import ecdsa
from hashlib import sha256

from ecdsa.curves import SECP256k1
from ecdsa.keys import VerifyingKey
from ecdsa.util import sigdecode_der

from utils import verify_signature, pubkey_pair, str_to_hex_int, sign_pair


def test_sign_txn_hash_origin(cmd, hid):
    hash_len = "20"
    txn_hash = "7829BE6ADB23E83AF08BE2F27977EE8FDA4E2FE6D40A514DAF1BE13A020F7CB2"

    curve_type, origin_type, pubkey_tag, public_key, sign_tag, sign_len, asn_der_sign = cmd.sign_txn_hash_origin(
        hid, hash_len, txn_hash, hid)

    pubkeyPair = pubkey_pair(public_key)
    sign = sign_pair(asn_der_sign)

    assert(verify_signature(pubkeyPair, str_to_hex_int(txn_hash), sign) == True)
    assert(curve_type == "02")