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
#include "ux.h"
#include "bip44.h"

// exception codes
#define SW_OK 0x9000
#define SW_DEVELOPER_ERR 0x6B00
#define SW_INVALID_PARAM 0x6B01
#define SW_IMPROPER_INIT 0x6B02
#define SW_WRONG_WALLET 0X6B03
#define SW_USER_REJECTED 0x6985

typedef void (*action_validate_cb)(bool);

#define MAX_ENCODE_WALLET_LEN 200

typedef struct
{
    uint8_t encodedWallet[MAX_ENCODE_WALLET_LEN];
    uint8_t walletLen;
} onchain_wallet_struct_t;

typedef struct
{
    uint8_t arch_address[34];
    uint8_t arch_addr_len;
} addr_struct_t;

typedef struct
{
    uint8_t ecdhPointX[32];
    uint8_t txHash[64];
    uint8_t txHashLen;
    uint8_t amount[8];
    uint8_t receiveAddr[70];
    uint8_t receiveAddrLen;
    uint8_t senderAddr[70];
    uint8_t senderAddrLen;
    uint32_t address_index;
    uint8_t service_index;
    uint32_t seek_bytes;
} tx_struct_t;

void io_exchange_with_code(uint16_t code, uint16_t tx);

void getOriginPublicKey(cx_ecfp_public_key_t *publicKey);

void deriveArchEthicKeyPair(cx_curve_t curve, uint32_t coin_type, uint32_t account, uint32_t address_index,
                            uint8_t *masterSeed, uint8_t masterSeedLen,
                            cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey);

void performECDH(uint8_t *ephPublicKey, uint8_t ephPublicKeySize, uint8_t *ecdhPointX);

void performECDSA(uint8_t *txHash, uint8_t txHashLen, uint32_t address_index_offset,
                  uint8_t *encoded_wallet, uint8_t *wallet_len, uint8_t service_index, uint32_t seek_bytes,
                  uint8_t *asn_sign, uint8_t *sign_len);

void decryptWallet(uint8_t *ecdhPointX, uint8_t ecdhPointLen,
                   uint8_t *dataBuffer, uint8_t dataLen,
                   uint8_t *encodedWallet, uint8_t *walletLen);

void generateKeyFromWallet(uint32_t address_index_offset, uint8_t *encoded_wallet, uint8_t *wallet_len, uint8_t service_index, uint32_t seek_bytes,
                           uint8_t *curve_type, cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey);

void generateArchEthicAddress(uint8_t hash_type, uint8_t service_index,
                              uint8_t *encoded_wallet, uint8_t *wallet_len, uint32_t sequence_no,
                              uint8_t *address, uint8_t *address_len, uint32_t seek_bytes, uint32_t address_index_offset);

void getDerivationPath(uint8_t service_index, uint8_t *encoded_wallet, uint8_t wallet_len, uint8_t sequence_no, char *string_derivation_path, uint8_t *derivation_path_len, uint32_t *seek_bytes);

void getTransactionHash(uint8_t *senderAddr, uint8_t senderAddrLen,
                        uint8_t *receiveAddr, uint8_t receiveAddrLen,
                        uint8_t *amount, uint8_t *txHash, uint8_t *txHashLen);
