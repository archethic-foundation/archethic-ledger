#include "archethic.h"
#include <os.h>

void io_exchange_with_code(uint16_t code, uint16_t tx)
{
    G_io_apdu_buffer[tx++] = code >> 8;
    G_io_apdu_buffer[tx++] = code & 0xFF;
    io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
}

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

void decryptWallet(uint8_t *ecdhPointX, uint8_t ecdhPointLen, uint8_t *dataBuffer, uint8_t dataLen, uint8_t *encodedWallet, uint8_t *walletLen)
{
    uint8_t aes_key_iv_tag[64] = {0};
    cx_hash_sha512(ecdhPointX, ecdhPointLen, aes_key_iv_tag, sizeof(aes_key_iv_tag));
    cx_hash_sha512(aes_key_iv_tag, sizeof(aes_key_iv_tag), aes_key_iv_tag, sizeof(aes_key_iv_tag));

    uint8_t auth_key[32] = {0};
    uint8_t auth_tag[32] = {0};
    cx_hash_sha256(aes_key_iv_tag + 48, 16, auth_key, sizeof(auth_key));
    cx_hmac_sha256(auth_key, sizeof(auth_key), dataBuffer + 65 + 16, 32, auth_tag, sizeof(auth_tag));
    uint8_t verify_tag = memcmp(auth_tag, dataBuffer + 65, 16);

    uint8_t wallet_key[32] = {0};
    uint8_t wallet_iv[32] = {0};
    if (verify_tag == 0)
    {
        cx_aes_key_t aesKey;
        cx_aes_init_key(aes_key_iv_tag, 32, &aesKey);
        cx_aes_iv(&aesKey, CX_DECRYPT | CX_CHAIN_CBC | CX_PAD_NONE, aes_key_iv_tag + 32, 16, dataBuffer + 65 + 16, 32, wallet_key, sizeof(wallet_key));

        cx_hash_sha256(wallet_key, sizeof(wallet_key), wallet_iv, sizeof(wallet_iv));
        cx_hash_sha256(wallet_iv, sizeof(wallet_iv), wallet_iv, sizeof(wallet_iv));

        cx_aes_key_t walletAESkey;
        cx_aes_init_key(wallet_key, 32, &walletAESkey);
        *walletLen = cx_aes_iv(&walletAESkey, CX_ENCRYPT | CX_CHAIN_CTR | CX_LAST | CX_PAD_NONE, wallet_iv, 16, dataBuffer + 65 + 16 + 32, dataLen - 65 - 16 - 32, encodedWallet, *walletLen);
    }
}

void getBIP44Path(uint8_t address_index, uint8_t *encoded_wallet, uint8_t wallet_len, uint8_t sequence_no, char *string_bip_44, uint8_t *bip44_len)
{
    if (wallet_len < 5 * sequence_no + 37)
        return;
    // strncpy(string_bip_44, "m/44'/650'/ffff'/0'/0'", 60);
    int coin_type = (encoded_wallet[5 * sequence_no + 34] << 8) | encoded_wallet[5 * sequence_no + 35];
    int account = (encoded_wallet[5 * sequence_no + 36] << 8) | encoded_wallet[5 * sequence_no + 37];

    strncpy(string_bip_44, "m/44'/", 7);
    snprintf(string_bip_44 + 6, 6, "%d", coin_type);

    strncpy(string_bip_44 + strlen(string_bip_44), "'/", 3);
    snprintf(string_bip_44 + strlen(string_bip_44), 6, "%d", account);

    strncpy(string_bip_44 + strlen(string_bip_44), "'/0'/", 6);
    snprintf(string_bip_44 + strlen(string_bip_44), 6, "%d", address_index);
    strncpy(string_bip_44 + strlen(string_bip_44), "'", 2);

    *bip44_len = strlen(string_bip_44);
}

void generateKeyFromWallet(uint32_t address_index, uint8_t *encoded_wallet, uint8_t *wallet_len, uint32_t sequence_no, uint8_t *curve_type, cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey)
{
    if (*wallet_len < 5 * sequence_no + 37)
        return;
    uint32_t coin_type = (encoded_wallet[5 * sequence_no + 34] << 8) | encoded_wallet[5 * sequence_no + 35];
    uint32_t account = (encoded_wallet[5 * sequence_no + 36] << 8) | encoded_wallet[5 * sequence_no + 37];

    cx_curve_t curve;
    *curve_type = encoded_wallet[5 * sequence_no + 38];
    switch (*curve_type)
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
    deriveArchEthicKeyPair(curve, coin_type, account, address_index, encoded_wallet + 1, 32, privateKey, publicKey);
}

void generateArchEthicAddress(uint8_t hash_type, uint32_t address_index, uint8_t *encoded_wallet, uint8_t *wallet_len, uint32_t sequence_no)
{

    cx_ecfp_public_key_t publicKey;
    uint8_t curve_type = 255;
    generateKeyFromWallet(address_index, encoded_wallet, wallet_len, sequence_no, &curve_type, NULL, &publicKey);

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

void performECDSA(uint8_t *txHash, uint8_t txHashLen, uint8_t address_index, uint8_t *encoded_wallet, uint8_t *wallet_len, uint8_t sequence_no)
{
    uint8_t curve_type = 255;
    cx_ecfp_private_key_t privateKey;
    cx_ecfp_public_key_t publicKey;
    unsigned int info = 0;
    generateKeyFromWallet(address_index, encoded_wallet, wallet_len, sequence_no, &curve_type, &privateKey, &publicKey);
    *wallet_len = cx_ecdsa_sign(&privateKey, CX_RND_TRNG, CX_SHA256, txHash, txHashLen, encoded_wallet, *wallet_len, &info);

    encoded_wallet[*wallet_len] = curve_type;
    encoded_wallet[(*wallet_len) + 1] = 0; // Onchain Wallet Key
    memcpy(encoded_wallet + (*wallet_len) + 2, publicKey.W, publicKey.W_len);
    *wallet_len += publicKey.W_len + 2;
}