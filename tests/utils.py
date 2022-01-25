#!/usr/bin/env python3

import collections
import hashlib
import random
import time
import logging
import uuid

EllipticCurve = collections.namedtuple('EllipticCurve', 'name p a b g n h')

# curve = EllipticCurve(
#     'NIST_P256',
#     # Field characteristic.
#     p=0xffffffff00000001000000000000000000000000ffffffffffffffffffffffff,
#     # Curve coefficients.
#     a=0xffffffff00000001000000000000000000000000fffffffffffffffffffffffc,
#     b=0x5ac635d8aa3a93e7b3ebbd55769886bc651d06b0cc53b0f63bce3c3e27d2604b,
#     # Base point.
#     g=(0x6b17d1f2e12c4247f8bce6e563a440f277037d812deb33a0f4a13945d898c296, 0x4fe342e2fe1a7f9b8ee7eb4a7c0f9e162bce33576b315ececbb6406837bf51f5),
#     # Subgroup order.
#     n=0xffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551,
#     # Subgroup cofactor.
#     h=0x1
# )

curve = EllipticCurve(
    'SECP256K1',
    # Field characteristic.
    p=0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f,
    # Curve coefficients.
    a=0x0000000000000000000000000000000000000000000000000000000000000000,
    b=0x0000000000000000000000000000000000000000000000000000000000000007,
    # Base point.
    g=(0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798, 0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8),
    # Subgroup order.
    n=0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141,
    # Subgroup cofactor.
    h=0x1
)

logging.basicConfig(filename=str(curve.name) + ".log", level=logging.DEBUG)


# Modular arithmetic ##########################################################


def inverse_mod(k, p):
    """Returns the inverse of k modulo p.
    This function returns the only integer x such that (x * k) % p == 1.
    k must be non-zero and p must be a prime.
    """
    if k == 0:
        raise ZeroDivisionError('division by zero')

    if k < 0:
        # k ** -1 = p - (-k) ** -1  (mod p)
        return p - inverse_mod(-k, p)

    # Extended Euclidean algorithm.
    s, old_s = 0, 1
    t, old_t = 1, 0
    r, old_r = p, k

    while r != 0:
        quotient = old_r // r
        old_r, r = r, old_r - quotient * r
        old_s, s = s, old_s - quotient * s
        old_t, t = t, old_t - quotient * t

    gcd, x, y = old_r, old_s, old_t

    assert gcd == 1
    assert (k * x) % p == 1

    return x % p


# Functions that work on curve points #########################################

def is_on_curve(point):
    """Returns True if the given point lies on the elliptic curve."""
    if point is None:
        # None represents the point at infinity.
        return True

    x, y = point

    return (y * y - x * x * x - curve.a * x - curve.b) % curve.p == 0


def point_neg(point):
    """Returns -point."""
    assert is_on_curve(point)

    if point is None:
        # -0 = 0
        return None

    x, y = point
    result = (x, -y % curve.p)

    assert is_on_curve(result)

    return result


def point_add(point1, point2):
    """Returns the result of point1 + point2 according to the group law."""
    assert is_on_curve(point1)
    assert is_on_curve(point2)

    if point1 is None:
        # 0 + point2 = point2
        return point2
    if point2 is None:
        # point1 + 0 = point1
        return point1

    x1, y1 = point1
    x2, y2 = point2

    if x1 == x2 and y1 != y2:
        # point1 + (-point1) = 0
        return None

    if x1 == x2:
        # This is the case point1 == point2.
        m = (3 * x1 * x1 + curve.a) * inverse_mod(2 * y1, curve.p)
    else:
        # This is the case point1 != point2.
        m = (y1 - y2) * inverse_mod(x1 - x2, curve.p)

    x3 = m * m - x1 - x2
    y3 = y1 + m * (x3 - x1)
    result = (x3 % curve.p,
              -y3 % curve.p)

    assert is_on_curve(result)

    return result


def scalar_mult(k, point):
    """Returns k * point computed using the double and point_add algorithm."""
    assert is_on_curve(point)

    if k % curve.n == 0 or point is None:
        return None

    if k < 0:
        # k * point = -k * (-point)
        return scalar_mult(-k, point_neg(point))

    result = None
    addend = point

    while k:
        if k & 1:
            # Add.
            result = point_add(result, addend)

        # Double.
        addend = point_add(addend, addend)

        k >>= 1

    assert is_on_curve(result)

    return result


# Keypair generation and ECDSA ################################################

def make_keypair():
    """Generates a random private-public key pair."""
    # private_key = random.randrange(1, curve.n)
    private_key = privKey
    public_key = scalar_mult(private_key, curve.g)

    return private_key, public_key


def hash_message(message):
    """Returns the truncated SHA256 hash of the message."""
    message_hash = hashlib.sha256(message).digest()
    e = int.from_bytes(message_hash, 'big')
    print("Hash: ", hex(e))
    # FIPS 180 says that when a hash needs to be truncated, the rightmost bits
    # should be discarded.
    if e.bit_length() > curve.n.bit_length():
        z = e >> (e.bit_length() - curve.n.bit_length())

    # FIPS 186-4 says nothing is needed to be done if hash bit length is smaller
    # than the curve bit length
    else:
        z = e
    assert z.bit_length() <= curve.n.bit_length()
    return z

def sign_message(private_key, message):
    z = hash_message(message)

    r = 0
    s = 0
    strt = time.time()
    while not r or not s:
        k = random.randrange(1, curve.n)
        x, y = scalar_mult(k, curve.g)

        r = x % curve.n
        s = ((z + r * private_key) * inverse_mod(k, curve.n)) % curve.n
    stp = time.time() - strt
    logging.info("SIGN :" + str(stp))
    return (r, s)


def verify_signature(public_key, hash_message, signature):
    z = hash_message
    r, s = signature
    strt = time.time()
    w = inverse_mod(s, curve.n)
    u1 = (z * w) % curve.n
    u2 = (r * w) % curve.n

    x, y = point_add(scalar_mult(u1, curve.g),
                     scalar_mult(u2, public_key))

    if (r % curve.n) == (x % curve.n):
        stp = time.time() - strt
        logging.info("VERIFY :" + str(stp))
        return True
    else:
        return False

def str_to_hex_int(hex_str) -> hex:
    hex_int = int(hex_str, base=16)
    return hex_int

def pubkey_pair(publicKey):
    publicKey = publicKey[6:]
    x = publicKey[:int(len(publicKey)/2)]
    y = publicKey[int(len(publicKey)/2):]
    return (str_to_hex_int(x), str_to_hex_int(y))

def sign_pair(signature):
    #30 || L || 02 || Lr || r || 02 || Ls || s
    lr_o = 2 + 2 + 2
    r_o = lr_o + 2
    lr = str_to_hex_int(signature[lr_o:r_o])
    
    ls_o = r_o + lr*2 + 2
    s_o = ls_o + 2
    ls = str_to_hex_int(signature[ls_o:s_o])
    
    r = signature[r_o: r_o + lr*2]
    s = signature[s_o: s_o + ls*2]

    return (str_to_hex_int(r), str_to_hex_int(s))