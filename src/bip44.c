/*******************************************************************************
 *   Archethic Ledger Bolos App
 *   (c) 2022 Varun Deshpande, Uniris
 *
 *  Licensed under the GNU Affero General Public License, Version 3 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      https://www.gnu.org/licenses/agpl-3.0.en.html
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 ********************************************************************************/
#include <bip44.h>

#define MAX_SEED_SIZE 64

static uint8_t const BIP32_SECP_SEED[] = {
    'B', 'i', 't', 'c', 'o', 'i', 'n', ' ', 's', 'e', 'e', 'd'};

static uint8_t const BIP32_NIST_SEED[] = {
    'N', 'i', 's', 't', '2', '5', '6', 'p', '1', ' ', 's', 'e', 'e', 'd'};

static uint8_t const BIP32_ED_SEED[] = {
    'e', 'd', '2', '5', '5', '1', '9', ' ', 's', 'e', 'e', 'd'};

static uint8_t const SLIP21_SEED[] = {
    'S', 'y', 'm', 'm', 'e', 't', 'r', 'i', 'c', ' ', 'k', 'e', 'y', ' ', 's', 'e', 'e', 'd'};

void be2le(uint8_t *v, size_t len)
{
  uint8_t t;
  int i, j;

  j = len - 1;
  len /= 2;

  for (i = 0; len > 0; i++, j--, len--)
  {
    t = v[i];
    v[i] = v[j];
    v[j] = t;
    i++;
    j--;
  }
}

void le2be(uint8_t *v, size_t len)
{
  return be2le(v, len);
}

static bool is_hardened_child(uint32_t child)
{
  return (child & 0x80000000) != 0;
}

static size_t get_seed_key(cx_curve_t curve, const uint8_t **sk)
{
  size_t sk_length;

  switch (curve)
  {
  case CX_CURVE_256K1:
    *sk = BIP32_SECP_SEED;
    sk_length = sizeof(BIP32_SECP_SEED);
    break;
  case CX_CURVE_256R1:
    *sk = BIP32_NIST_SEED;
    sk_length = sizeof(BIP32_NIST_SEED);
    break;
  case CX_CURVE_Ed25519:
    *sk = BIP32_ED_SEED;
    sk_length = sizeof(BIP32_ED_SEED);
    break;
  default:
    // unsupported curve
    sk_length = -1;
    *sk = NULL;
    break;
  }

  return sk_length;
}

static size_t get_seed_key_slip21(const uint8_t **sk)
{
  size_t sk_length;

  *sk = SLIP21_SEED;
  sk_length = sizeof(SLIP21_SEED);

  return sk_length;
}

void expand_seed_slip10(const uint8_t *sk, size_t sk_length, uint8_t *seed, unsigned int seed_length, extended_private_key *key)
{
  uint8_t hash[CX_SHA512_SIZE];

  cx_hmac_sha512(sk, sk_length, seed, seed_length, hash, CX_SHA512_SIZE);

  memcpy(key->private_key, hash, 32);
  memcpy(key->chain_code, hash + 32, 32);
}

void expand_seed_ed25519_bip32(const uint8_t *sk, size_t sk_length, uint8_t *seed, unsigned int seed_length, extended_private_key *key)
{
  uint8_t buf[1 + MAX_SEED_SIZE];

  buf[0] = 0x01;
  memcpy(buf + 1, seed, seed_length);
  cx_hmac_sha256(sk, sk_length, buf, 1 + seed_length,
                 key->chain_code, CX_SHA256_SIZE);

  cx_hmac_sha512(sk, sk_length, seed, seed_length,
                 key->private_key, CX_SHA512_SIZE);

  while (key->private_key[31] & 0x20)
  {
    cx_hmac_sha512(sk, sk_length,
                   key->private_key, CX_SHA512_SIZE,
                   key->private_key, CX_SHA512_SIZE);
  }

  key->private_key[0] &= 0xF8;
  key->private_key[31] = (key->private_key[31] & 0x7F) | 0x40;
}

static void expand_seed(cx_curve_t curve, const uint8_t *sk, size_t sk_length, uint8_t *seed, unsigned int seed_length, extended_private_key *key)
{
  uint8_t hash[CX_SHA512_SIZE];
  uint8_t domain_n[64] = {0};
  size_t vt = 0;

  cx_ecdomain_parameters_length(curve, &vt);
  cx_ecdomain_parameter(curve, CX_CURVE_PARAM_Order, domain_n, vt);

  cx_hmac_sha512(sk, sk_length, seed, seed_length, hash, CX_SHA512_SIZE);

  memcpy(key->private_key, hash, 32);
  memcpy(key->chain_code, hash + 32, 32);

  /* ensure that the master key is valid */
  while (cx_math_is_zero(key->private_key, 32) ||
         cx_math_cmp(key->private_key, domain_n, 32) >= 0)
  {
    memcpy(hash, key->private_key, 32);
    memcpy(hash + 32, key->chain_code, 32);
    cx_hmac_sha512(sk, sk_length,
                   hash, CX_SHA512_SIZE,
                   hash, CX_SHA512_SIZE);
    memcpy(key->private_key, hash, 32);
    memcpy(key->chain_code, hash + 32, 32);
  }
}

static int hdw_bip32_ed25519(extended_private_key *key, const uint32_t *path, size_t length, uint8_t *private_key, uint8_t *chain)
{
  cx_ecfp_256_public_key_t pub;
  uint8_t *kP, *kLP, *kRP;
  unsigned int i, j, len;
  uint8_t tmp[1 + 64 + 4], x;
  uint8_t *ZR, *Z, *ZL;

  Z = tmp + 1;
  ZL = tmp + 1;
  ZR = tmp + 1 + 32;

  kP = key->private_key;
  kLP = key->private_key;
  kRP = &key->private_key[32];

  uint8_t gx[64] = {0};
  uint8_t gy[64] = {0};
  size_t et = 0;

  cx_ecdomain_parameters_length(CX_CURVE_Ed25519, &et);
  cx_ecdomain_parameter(CX_CURVE_Ed25519, CX_CURVE_PARAM_Gx, gx, et);
  cx_ecdomain_parameter(CX_CURVE_Ed25519, CX_CURVE_PARAM_Gy, gy, et);

  pub.W_len = 65;
  pub.W[0] = 0x04;

  for (i = 0; i < length; i++)
  {
    // compute the public key A = kL.G
    memcpy(pub.W + 1, gx, 32);
    memcpy(pub.W + 1 + 32, gy, 32);

    le2be(kLP, 32);
    cx_ecfp_scalar_mult(CX_CURVE_Ed25519, pub.W, pub.W_len, kLP, 32);
    be2le(kLP, 32);

    cx_edwards_compress_point(CX_CURVE_Ed25519, pub.W, pub.W_len);

    // Step 1: compute kL/Kr child
    //   if less than 0x80000000 => setup 02|A|i in tmp
    if (!is_hardened_child(path[i]))
    {
      tmp[0] = 0x02;
      memcpy(tmp + 1, &pub.W[1], 32);
      len = 1 + 32;
    }
    else
    {
      //  else if greater-eq than 0x80000000 --> setup 00|k|i in tmp
      tmp[0] = 0x00;
      memcpy(tmp + 1, kP, 64);
      len = 1 + 32 * 2;
    }

    tmp[len + 0] = (path[i] >> 0) & 0xff;
    tmp[len + 1] = (path[i] >> 8) & 0xff;
    tmp[len + 2] = (path[i] >> 16) & 0xff;
    tmp[len + 3] = (path[i] >> 24) & 0xff;
    len += 4;

    // compute Z = Hmac(...)
    cx_hmac_sha512(key->chain_code, 32, tmp, len, Z, CX_SHA512_SIZE);
    // kL = 8*Zl + kLP (use multm, but never overflow order, so ok)
    le2be(ZL, 32);
    le2be(kLP, 32);
    memset(ZL, 0, 4);
    cx_math_add(ZL, ZL, ZL, 32);
    cx_math_add(ZL, ZL, ZL, 32);
    cx_math_add(ZL, ZL, ZL, 32);
    cx_math_add(ZL, ZL, kLP, 32);
    be2le(ZL, 32);
    be2le(kLP, 32);
    // kR = Zr + kRP
    le2be(ZR, 32);
    le2be(kRP, 32);
    cx_math_add(ZR, ZR, kRP, 32);
    be2le(ZR, 32);
    be2le(kRP, 32);
    // store new kL,kP, but keep old on to compute new c
    for (j = 0; j < 64; j++)
    {
      x = kP[j];
      kP[j] = Z[j];
      Z[j] = x;
    }

    // Step2: compute chain code
    //  if less than 0x80000000 => set up 03|A|i in tmp
    if (!is_hardened_child(path[i]))
    {
      tmp[0] = 0x03;
      memcpy(tmp + 1, &pub.W[1], 32);
      len = 1 + 32;
    }
    // else if greater-eq than 0x80000000 -->  01|k|i in tmp
    else
    {
      tmp[0] = 0x01;
      // kP already set
      len = 1 + 32 * 2;
    }
    tmp[len + 0] = (path[i] >> 0) & 0xff;
    tmp[len + 1] = (path[i] >> 8) & 0xff;
    tmp[len + 2] = (path[i] >> 16) & 0xff;
    tmp[len + 3] = (path[i] >> 24) & 0xff;
    len += 4;
    cx_hmac_sha512(key->chain_code, 32, tmp, len, tmp, CX_SHA512_SIZE);
    // store new c
    memcpy(key->chain_code, tmp + 32, 32);
  }

  if (private_key != NULL)
  {
    memcpy(private_key, kP, 64);
  }

  if (chain != NULL)
  {
    memcpy(chain, key->chain_code, 32);
  }

  return 0;
}

static int hdw_slip10(extended_private_key *key, const uint32_t *path, size_t length, uint8_t *private_key, uint8_t *chain)
{
  uint8_t tmp[1 + 64 + 4];
  unsigned int i;

  for (i = 0; i < length; i++)
  {
    if (is_hardened_child(path[i]))
    {
      tmp[0] = 0;
      memcpy(tmp + 1, key->private_key, 32);
    }
    else
    {
      PRINTF("hdw_slip10: invalid path (%u:0x%x)", i, path[i]);
      return -1;
    }

    tmp[33] = (path[i] >> 24) & 0xff;
    tmp[34] = (path[i] >> 16) & 0xff;
    tmp[35] = (path[i] >> 8) & 0xff;
    tmp[36] = path[i] & 0xff;

    cx_hmac_sha512(key->chain_code, 32, tmp, 37, tmp, CX_SHA512_SIZE);

    memcpy(key->private_key, tmp, 32);
    memcpy(key->chain_code, tmp + 32, 32);
  }

  if (private_key != NULL)
  {
    memcpy(private_key, key->private_key, 32);
  }

  if (chain != NULL)
  {
    memcpy(chain, key->chain_code, 32);
  }

  return 0;
}

static int hdw_bip32(extended_private_key *key, cx_curve_t curve, const uint32_t *path, size_t length, uint8_t *private_key, uint8_t *chain)
{
  cx_ecfp_256_public_key_t pub;
  cx_ecfp_private_key_t priv;
  uint8_t tmp[1 + 64 + 4];
  unsigned int i;

  if (curve != CX_CURVE_256K1 && curve != CX_CURVE_SECP256R1)
  {
    PRINTF("hdw_bip32: invalid curve (0x%x)", curve);
    return -1;
  }

  uint8_t domain_n[64] = {0};
  size_t vt = 0;

  cx_ecdomain_parameters_length(curve, &vt);
  cx_ecdomain_parameter(curve, CX_CURVE_PARAM_Order, domain_n, vt);

  for (i = 0; i < length; i++)
  {
    if (is_hardened_child(path[i]))
    {
      tmp[0] = 0;
      memcpy(tmp + 1, key->private_key, 32);
    }
    else
    {
      cx_ecfp_init_private_key(curve, key->private_key, 32, &priv);
      cx_ecfp_generate_pair(curve, &pub, &priv, 1);
      pub.W[0] = (pub.W[64] & 1) ? 0x03 : 0x02;
      memcpy(tmp, pub.W, 33);
    }

    while (true)
    {
      tmp[33] = (path[i] >> 24) & 0xff;
      tmp[34] = (path[i] >> 16) & 0xff;
      tmp[35] = (path[i] >> 8) & 0xff;
      tmp[36] = path[i] & 0xff;

      cx_hmac_sha512(key->chain_code, 32, tmp, 37, tmp, CX_SHA512_SIZE);

      if (cx_math_cmp(tmp, domain_n, 32) < 0)
      {
        cx_math_addm(tmp, tmp, key->private_key, domain_n, 32);
        if (cx_math_is_zero(tmp, 32) == 0)
          break;
      }

      tmp[0] = 1;
      memcpy(tmp + 1, tmp + 32, 32);
    }

    memcpy(key->private_key, tmp, 32);
    memcpy(key->chain_code, tmp + 32, 32);
  }

  if (private_key != NULL)
  {
    memcpy(private_key, key->private_key, 32);
  }

  if (chain != NULL)
  {
    memcpy(chain, key->chain_code, 32);
  }

  return 0;
}

static int hdw_slip21(const uint8_t *sk, size_t sk_length, const uint8_t *seed, size_t seed_size, const uint8_t *path, size_t path_len, uint8_t *private_key)
{
  uint8_t node[CX_SHA512_SIZE];

  if (path == NULL || path_len == 0 || path[0] != 0)
  {
    PRINTF("hdw_slip21: invalid path");
    return -1;
  }

  /* derive master node */
  cx_hmac_sha512(sk, sk_length, seed, seed_size, node, CX_SHA512_SIZE);

  /* derive child node */
  cx_hmac_sha512(node, 32, path, path_len, node, CX_SHA512_SIZE);

  if (private_key != NULL)
  {
    memcpy(private_key, node + 32, 32);
  }

  return 0;
}

unsigned long archethic_derive_node_with_seed_key(unsigned int mode, cx_curve_t curve, uint8_t *masterSeed, size_t masterSeedLen, const unsigned int *path, unsigned int pathLength, unsigned char *privateKey, unsigned char *chain, unsigned char *seed_key, unsigned int seed_key_length)
{
  size_t seed_size, sk_length;
  extended_private_key key;
  const uint8_t *sk;
  int ret;

  if (seed_key == NULL || seed_key_length == 0)
  {
    if (mode != HDW_SLIP21)
    {
      sk_length = get_seed_key(curve, &sk);
    }
    else
    {
      sk_length = get_seed_key_slip21(&sk);
    }
    if (sk_length < 0)
    {
      THROW(EXCEPTION);
    }
  }
  else
  {
    sk = seed_key;
    sk_length = seed_key_length;
  }
  seed_size = masterSeedLen;
  if (seed_size < 0)
  {
    THROW(EXCEPTION);
  }

  if (mode == HDW_SLIP21)
  {
    ret = hdw_slip21(sk, sk_length, masterSeed, seed_size, (const uint8_t *)path, pathLength, privateKey);
  }
  else if (mode == HDW_ED25519_SLIP10)
  {
    /* https://github.com/satoshilabs/slips/tree/master/slip-0010 */
    /* https://github.com/satoshilabs/slips/blob/master/slip-0010.md */
    if (curve == CX_CURVE_Ed25519)
    {
      expand_seed_slip10(sk, sk_length, masterSeed, seed_size, &key);
      ret = hdw_slip10(&key, path, pathLength, privateKey, chain);
    }
    else
    {
      expand_seed(curve, sk, sk_length, masterSeed, seed_size, &key);
      ret = hdw_bip32(&key, curve, path, pathLength, privateKey, chain);
    }
  }
  else
  {
    if (curve == CX_CURVE_Ed25519)
    {
      expand_seed_ed25519_bip32(sk, sk_length, masterSeed, seed_size, &key);
      ret = hdw_bip32_ed25519(&key, path, pathLength, privateKey, chain);
    }
    else
    {
      expand_seed(curve, sk, sk_length, masterSeed, seed_size, &key);
      ret = hdw_bip32(&key, curve, path, pathLength, privateKey, chain);
    }
  }

  if (ret < 0)
  {
    THROW(EXCEPTION);
  }

  return 0;
}

unsigned long archethic_derive_node_bip32(cx_curve_t curve, uint8_t *masterSeed, size_t masterSeedLen, const uint32_t *path, size_t length, uint8_t *private_key, uint8_t *chain)
{
  return archethic_derive_node_with_seed_key(HDW_NORMAL, curve, masterSeed, masterSeedLen, path, length, private_key, chain, NULL, 0);
}