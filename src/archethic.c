#include "archethic.h"

// uint8_t masterSeed[] = {0x9A, 0x34, 0xA2, 0x33, 0xC4, 0x8B, 0x77, 0xD4, 0x88, 0x56, 0xED, 0x17, 0x17, 0x92, 0xD0, 0xB1, 0x67, 0xF5, 0x0D, 0x9A, 0x81, 0x48, 0x76, 0x9E, 0x00, 0x0D, 0x1F, 0x3C, 0x75, 0xF7, 0x4C, 0x15};
// uint8_t masterSeed[] = {0x6f, 0xa7, 0x74, 0x71, 0x8b, 0x0f, 0x08, 0x61, 0x01, 0xe7, 0xa0, 0xbf, 0x43, 0xf8, 0x19, 0x44, 0xf2, 0xee, 0xa0, 0x39, 0x2b, 0xc3, 0x45, 0x2a, 0xc3, 0x14, 0xcc, 0x44, 0x4f, 0x19, 0x97, 0x89, 0x89, 0xc6, 0x2b, 0xe4, 0x11, 0x0f, 0x8f, 0xd3, 0xe5, 0x43, 0x87, 0x5e, 0x9f, 0x3f, 0xe2, 0xe2, 0x24, 0x0f, 0x55, 0x4c, 0xf1, 0x6c, 0xfe, 0xbf, 0x67, 0x3b, 0x11, 0x2a, 0xc4, 0x4e, 0xc0, 0x16};

void getOriginPublicKey(cx_ecfp_public_key_t *publicKey)
{
    // setting default curve to CX_CURVE_SECP256K1
    return deriveArchEthicKeyPair(CX_CURVE_SECP256K1, 650, 0xffff, 0, NULL, 0, NULL, publicKey);
}

void performECDH(uint8_t *ephPublicKey, uint8_t ephPublicKeySize, uint8_t *ecdhPointX)
{

    cx_ecfp_private_key_t originPrivateKey;
    deriveArchEthicKeyPair(CX_CURVE_SECP256K1, 650, 0xffff, 0, NULL, 0, &originPrivateKey, NULL);
    cx_ecdh(&originPrivateKey, CX_ECDH_X, ephPublicKey, ephPublicKeySize, ecdhPointX, 32);
}

void generateArchEthicAddress(uint8_t hash_type, uint32_t address_index, uint8_t *encoded_wallet, uint8_t *wallet_len, uint32_t sequence_no)
{
    uint32_t coin_type = (encoded_wallet[5 * sequence_no + 34] << 8) | encoded_wallet[5 * sequence_no + 35];
    uint32_t account = (encoded_wallet[5 * sequence_no + 36] << 8) | encoded_wallet[5 * sequence_no + 37];

    cx_curve_t curve;
    uint8_t curve_type = encoded_wallet[5 * sequence_no + 38];
    switch (curve_type)
    {
    case 0:
        curve = CX_CURVE_Ed25519;
        break;
    case 1:
        curve = CX_CURVE_NISTP256;
        break;
    case 2:
        curve = CX_CURVE_SECP256K1;
        break;
    default:
        curve = CX_CURVE_SECP256K1;
        break;
    }

    cx_ecfp_public_key_t publicKey;
    deriveArchEthicKeyPair(curve, coin_type, account, address_index, encoded_wallet + 1, 32, NULL, &publicKey);

    PRINTF("Public Key\n %.*h \n", publicKey.W_len, publicKey.W);
    encoded_wallet[0] = curve_type;
    encoded_wallet[1] = 0; // onchain wallet origin
    memcpy(encoded_wallet + 2, publicKey.W, publicKey.W_len);

    switch (hash_type)
    {
    case 0:
        cx_hash_sha256(encoded_wallet, 1 + 1 + publicKey.W_len, encoded_wallet + 2, 32);
        *wallet_len = 1 + 1 + 32;
        break;
    default:
        break;
    }
}

void deriveArchEthicKeyPair(cx_curve_t curve, uint32_t coin_type, uint32_t account, uint32_t address_index, uint8_t *masterSeed, uint8_t masterSeedLen, cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey)
{
    uint8_t rawPrivateKey[32];
    cx_ecfp_private_key_t walletPrivateKey;

    uint32_t bip44Path[] = {44 | 0x80000000, coin_type | 0x80000000, account | 0x80000000, 0x80000000, address_index | 0x80000000};

    int mode = -1;
    if (curve == CX_CURVE_Ed25519)
        mode = HDW_ED25519_SLIP10;
    else
        mode = HDW_NORMAL;

    if (account == 0xffff)
        // Derive the raw private key for the given path
        os_perso_derive_node_with_seed_key(mode, curve, bip44Path, 5, rawPrivateKey, NULL, NULL, 0);
    else
        archethic_derive_node_with_seed_key(mode, curve, masterSeed, masterSeedLen, bip44Path, 5, rawPrivateKey, NULL, NULL, 0);

    //  Initiate the private key structure with the raw private key
    cx_ecfp_init_private_key(curve, rawPrivateKey, 32, &walletPrivateKey);

    if (publicKey)
    {
        // Derive the corresponding public key
        cx_ecfp_init_public_key(curve, NULL, 0, publicKey);
        cx_ecfp_generate_pair(curve, publicKey, &walletPrivateKey, 1);
    }
    if (privateKey)
    {
        *privateKey = walletPrivateKey;
    }
    explicit_bzero(rawPrivateKey, sizeof(rawPrivateKey));
    explicit_bzero(&walletPrivateKey, sizeof(walletPrivateKey));
}
