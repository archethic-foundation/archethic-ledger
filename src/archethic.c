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
#include "archethic.h"
#include "common/format.h"
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

    // Double Hashing sha512 Here using ecdhPointX
    cx_hash_sha512(ecdhPointX, ecdhPointLen, aes_key_iv_tag, sizeof(aes_key_iv_tag));

    cx_hash_sha512(aes_key_iv_tag, sizeof(aes_key_iv_tag), aes_key_iv_tag, sizeof(aes_key_iv_tag));

    uint8_t auth_key[32] = {0};
    uint8_t auth_tag[32] = {0};
    // Auth Key is sha256 hash of last 16 bytes of aes_key_iv_tag
    cx_hash_sha256(aes_key_iv_tag + 48, 16, auth_key, sizeof(auth_key));

    // Auth Tag is hmac_sha256 of dataBuffer
    cx_hmac_sha256(auth_key, sizeof(auth_key), dataBuffer + 16, 32, auth_tag, sizeof(auth_tag));

    uint8_t verify_tag = memcmp(auth_tag, dataBuffer, 16);
    // If verify tag is non zero then it's a bad decode.

    uint8_t wallet_key[32] = {0};
    uint8_t wallet_iv[32] = {0};
    if (verify_tag == 0)
    {
        cx_aes_key_t aesKey;
        cx_aes_init_key(aes_key_iv_tag, 32, &aesKey);
        cx_aes_iv(&aesKey, CX_DECRYPT | CX_CHAIN_CBC | CX_PAD_NONE, aes_key_iv_tag + 32, 16, dataBuffer + 16, 32, wallet_key, sizeof(wallet_key));

        cx_hash_sha256(wallet_key, sizeof(wallet_key), wallet_iv, sizeof(wallet_iv));
        cx_hash_sha256(wallet_iv, sizeof(wallet_iv), wallet_iv, sizeof(wallet_iv));

        cx_aes_key_t walletAESkey;
        cx_aes_init_key(wallet_key, 32, &walletAESkey);

        // Encrypt == Decrypt in CTR mode, hence using CX_ENCRYPT for decrypt
        *walletLen = cx_aes_iv(&walletAESkey, CX_ENCRYPT | CX_CHAIN_CTR | CX_LAST | CX_PAD_NONE, wallet_iv, 16, dataBuffer + 16 + 32, dataLen - 16 - 32, encodedWallet, *walletLen);
    }
    else
    { // BAD DECODE
        *walletLen = 5;
        encodedWallet[0] = 0xBA;
        encodedWallet[1] = 0xDD;
        encodedWallet[2] = 0xEC;
        encodedWallet[3] = 0x0D;
        encodedWallet[4] = 0xE0;
    }
}

void getDerivationPath(uint8_t service_index, uint8_t *encoded_wallet, uint8_t wallet_len, uint8_t sequence_no, char *string_bip_44, uint8_t *bip44_len, uint32_t *seek_bytes)
{
    // Assuming minimum length for encoded onchain wallet be atleast 39 bytes
    // Minimum bytes a service can have is 6 bytes
    if (wallet_len < 6 * service_index + 39)
        return;

    // Read the encoded wallet in sequential manner here.
    // Since paths and seed length can be varying
    int seek_bytes_l = 0;

    // First 4 bytes are version of onchain wallet;

    seek_bytes_l += 4;

    // Read the seed length
    uint8_t seed_length = encoded_wallet[seek_bytes_l];

    seek_bytes_l += 1;

    seek_bytes_l += seed_length;

    // Now encoded wallet is pointing to total no. of services
    uint8_t total_services = encoded_wallet[seek_bytes_l];
 
    seek_bytes_l += 1;

    // Requesting Service Index cannot be outside of total services in onchain wallet
    if (total_services < service_index)
        return;

    int coin_type = 0;
    int account = 0;
    int address_index = 0;

    for (int c = 0; c <= service_index; c++)
    {
        // For each service seek and get the derivation path, if not the required service index seek to the next one;
        if (c == service_index)
        {
            // Get the values and break
            int name_len = encoded_wallet[seek_bytes_l];
            // encoded_wallet += name_len + 1;
            seek_bytes_l += name_len + 1;
            // int path_len = encoded_wallet [0];
            coin_type = (encoded_wallet[seek_bytes_l + 1] << 8) | encoded_wallet[seek_bytes_l + 2];
            account = (encoded_wallet[seek_bytes_l + 3] << 8) | encoded_wallet[seek_bytes_l + 4];
            address_index = (encoded_wallet[seek_bytes_l + 5] << 8) | encoded_wallet[seek_bytes_l + 6];
            break;
        }
        else
        {
            // Seek the encoded wallet to next service
            int name_len = encoded_wallet[seek_bytes_l];
            // encoded_wallet += name_len + 1;
            seek_bytes_l += name_len + 1;
            int path_len = encoded_wallet[seek_bytes_l];
            // Extra two bytes are for curve type and hash type
            // encoded_wallet += path_len + 1 + 1 + 1;
            seek_bytes_l += path_len + 1 + 1 + 1;
        }
    }

    // int coin_type = (encoded_wallet[5 * sequence_no + 34] << 8) | encoded_wallet[5 * sequence_no + 35];
    // int account = (encoded_wallet[5 * sequence_no + 36] << 8) | encoded_wallet[5 * sequence_no + 37];

    *seek_bytes = seek_bytes_l;

    strncpy(string_bip_44, "m/", 3);
    snprintf(string_bip_44 + 2, 6, "%d", coin_type);

    strncpy(string_bip_44 + strlen(string_bip_44), "'/", 3);
    snprintf(string_bip_44 + strlen(string_bip_44), 6, "%d", account);
    strncpy(string_bip_44 + strlen(string_bip_44), "'/", 3);
    snprintf(string_bip_44 + strlen(string_bip_44), 6, "%d", address_index);

    // format_u64(string_bip_44 + strlen(string_bip_44), 11, address_index);
    strncpy(string_bip_44 + strlen(string_bip_44), "'", 2);
   
    *bip44_len = strlen(string_bip_44);
}

void generateKeyFromWallet(uint32_t address_index_offset, uint8_t *encoded_wallet, uint8_t *wallet_len, uint8_t service_index, uint32_t seek_bytes, uint8_t *curve_type, cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey)
{
    if (*wallet_len < 6 * service_index + 39)
        return;

    // Assuming Derivation Path to be 6 Bytes, 2 Bytes each coin_type | account | address_index

    uint32_t coin_type = (encoded_wallet[seek_bytes + 1] << 8) | encoded_wallet[seek_bytes + 2];
    uint32_t account = (encoded_wallet[seek_bytes + 3] << 8) | encoded_wallet[seek_bytes + 4];
    uint32_t address_index = (encoded_wallet[seek_bytes + 5] << 8) | encoded_wallet[seek_bytes + 6];

    address_index += address_index_offset;

    // uint32_t coin_type = (encoded_wallet[5 * sequence_no + 34] << 8) | encoded_wallet[5 * sequence_no + 35];
    // uint32_t account = (encoded_wallet[5 * sequence_no + 36] << 8) | encoded_wallet[5 * sequence_no + 37];

    cx_curve_t curve;
    *curve_type = encoded_wallet[seek_bytes + 7];
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
    // First 4 bytes are version
    uint8_t seed_len = encoded_wallet[4];
  
    deriveArchEthicKeyPair(curve, coin_type, account, address_index, encoded_wallet + 5, seed_len, privateKey, publicKey);
}

void generateArchEthicAddress(uint8_t hash_type, uint8_t service_index, uint8_t *encoded_wallet, uint8_t *wallet_len, uint32_t sequence_no, uint8_t *address, uint8_t *address_len, uint32_t seek_bytes, uint32_t address_index_offset)
{

    cx_ecfp_public_key_t publicKey;
    publicKey.W_len = 0;
    uint8_t curve_type = 255;

    generateKeyFromWallet(address_index_offset, encoded_wallet, wallet_len, service_index, seek_bytes, &curve_type, NULL, &publicKey);

    address[0] = curve_type;
    address[1] = 0; // onchain wallet origin
    memcpy(address + 2, publicKey.W, publicKey.W_len);

    switch (hash_type)
    {
    case 0:
        cx_hash_sha256(address, 1 + 1 + publicKey.W_len, address + 2, 32);
        *address_len = 1 + 1 + 32;
        break;
    default:
        break;
    }
}

void deriveArchEthicKeyPair(cx_curve_t curve, uint32_t coin_type, uint32_t account, uint32_t address_index, uint8_t *masterSeed, uint8_t masterSeedLen, cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey)
{
    uint8_t rawPrivateKey[32];
    cx_ecfp_private_key_t walletPrivateKey;

    // uint32_t bip44Path[] = {44 | 0x80000000, coin_type | 0x80000000, account | 0x80000000, 0x80000000, address_index | 0x80000000};

    // New Scheme for derivation path is
    // m/650'/0'/0' where m/coin_type(650' fixed for now)/account/address_index
    uint32_t derivationPath[] = {coin_type | 0x80000000,
                                 account | 0x80000000,
                                 address_index | 0x80000000};

    // If hashedPath is required, do it here
    // Hashed Path is not required hence send raw paths.

    int mode = -1;
    if (curve == CX_CURVE_Ed25519)
        mode = HDW_ED25519_SLIP10;
    else
        mode = HDW_NORMAL;

    if (account == 0xffff)
        // Derive the raw private key for the given path
        os_perso_derive_node_with_seed_key(mode, curve, derivationPath, 3, rawPrivateKey, NULL, NULL, 0);
    else
        archethic_derive_node_with_seed_key(mode, curve, masterSeed, masterSeedLen, derivationPath, 3, rawPrivateKey, NULL, NULL, 0);

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

void performECDSA(uint8_t *txHash, uint8_t txHashLen, uint32_t address_index_offset, uint8_t *encoded_wallet, uint8_t *wallet_len, uint8_t service_index, uint32_t seek_bytes, uint8_t *asn_sign, uint8_t *sign_len)
{
    uint8_t curve_type = 255;
    cx_ecfp_private_key_t privateKey;
    cx_ecfp_public_key_t publicKey;
    publicKey.W_len = 0;
    unsigned int info = 0;

    generateKeyFromWallet(address_index_offset, encoded_wallet, wallet_len, service_index, seek_bytes, &curve_type, &privateKey, &publicKey);

    asn_sign[0] = curve_type;
    asn_sign[1] = 0; // Onchain Wallet Key
    memcpy(asn_sign + 2, publicKey.W, publicKey.W_len);

    *sign_len = cx_ecdsa_sign(&privateKey, CX_RND_TRNG, CX_SHA256, txHash, txHashLen, asn_sign + publicKey.W_len + 2, MAX_ENCODE_WALLET_LEN - publicKey.W_len - 2, &info);
    *sign_len += publicKey.W_len + 2;


}

void getTransactionHash(uint8_t *senderAddr, uint8_t senderAddrLen,
                        uint8_t *receiveAddr, uint8_t receiveAddrLen,
                        uint8_t *amount, uint8_t *txHash, uint8_t *txHashLen)
{
    uint8_t tx[200];
    uint8_t version[] = {0x00, 0x00, 0x00, 0x01};
    uint8_t tx_type = 0xFD;

    uint8_t code_size[4] = {0};
    uint8_t content_size[4] = {0};
    uint8_t ownership_length = 0;

    uint8_t total_uco_transfers = 0x01;
    uint8_t total_nft_transfers = 0;
    uint8_t recipients = 0;
    int index = 0;

    memcpy(tx, version, 4);
    index += 4;

    /*
     * Till V1 Specs on TestNet are implemented,
     * the Curve Type will not be used in the Address.
     * After V1 Specs are implemented, remove
     * +1 from senderAddr and -1 from senderAddrLen
     */
    memcpy(tx + index, senderAddr, senderAddrLen);
    index += senderAddrLen;

    memcpy(tx + index, &tx_type, 1);
    index += 1;

    memcpy(tx + index, code_size, 4);
    index += 4;

    memcpy(tx + index, content_size, 4);
    index += 4;

    memcpy(tx + index, &ownership_length, 1);
    index += 1;

    memcpy(tx + index, &total_uco_transfers, 1);
    index += 1;

    /*
     * Till V1 Specs on TestNet are implemented,
     * the Curve Type will not be used in the Address.
     * After V1 Specs are implemented, remove
     * +1 from receiveAddr and -1 from receiveAddrLen
     */
    memcpy(tx + index, receiveAddr, receiveAddrLen);
    index += receiveAddrLen;

    memcpy(tx + index, amount, 8);
    index += 8;

    memcpy(tx + index, &total_nft_transfers, 1);
    index += 1;

    memcpy(tx + index, &recipients, 1);
    index += 1;

    *txHashLen = 32;
    cx_hash_sha256(tx, index, txHash, *txHashLen);

    // PRINTF("\n Encoded Txn: ---------- \n");
    // for (int k = 0; k < index; k++)
    //     PRINTF("%02X", tx[k]);
    // PRINTF("\n\n");

    /*
            for (int k = 0; k < *txHashLen; k++)
                PRINTF("%02X", txHash[k]);
            PRINTF("\n\n");
        */
}