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
#include <os.h>
#include "archethic.h"
#include "common/format.h"
#include "ui/menu.h"


static action_validate_cb g_validate_origin_sig;
static char g_derivation_origin_path[30];
static char g_txHash_origin[200];

UX_STEP_NOCB(ux_flow_orig_sig_init, bnnn_paging, {
                                                     .title = "Confirm Signing",
                                                     .text = "Origin Signature",
                                                 });

UX_STEP_NOCB(ux_flow_orig_sig_derivation_path,
             bnnn_paging,
             {
                 .title = "Derivation Path",
                 .text = g_derivation_origin_path,
             });

UX_STEP_NOCB(ux_flow_orig_sig_txHash,
             bnnn_paging,
             {
                 .title = "Txn Hash",
                 .text = g_txHash_origin,
             });

UX_STEP_CB(ux_flow_approve_orig_sig,
           pb,
           (*g_validate_origin_sig)(true),
           {
               &C_icon_validate_14,
               "Approve",
           });

UX_STEP_CB(ux_flow_reject_orig_sig,
           pb,
           (*g_validate_origin_sig)(false),
           {
               &C_icon_crossmark,
               "Reject",
           });

UX_FLOW(ux_display_orig_sign_flow,
        &ux_flow_orig_sig_init,
        &ux_flow_orig_sig_derivation_path,
        &ux_flow_orig_sig_txHash,
        &ux_flow_approve_orig_sig,
        &ux_flow_reject_orig_sig);

void ui_action_validate_origin_signature(bool choice)
{
    if (choice)
    {

        cx_ecfp_private_key_t originPrivateKey;
        cx_ecfp_public_key_t originPublicKey;

        deriveArchEthicKeyPair(CX_CURVE_SECP256K1, 650, 0xffff, 0, NULL, 0, &originPrivateKey, &originPublicKey);

        uint8_t asn_sign[200];
        uint8_t asn_sign_len = 0;
        unsigned int info = 0;

        // Curve Type is SECP256K1
        asn_sign[0] = 0x02;
        // Origin is Ledger Device
        asn_sign[1] = 0x04;

        memcpy(asn_sign + 2, originPublicKey.W, originPublicKey.W_len);

        uint8_t txHash[200];
        
        // CDATA starts at byte 5, 1st Byte is txHashLen
        uint8_t txHashLen = G_io_apdu_buffer[5];
        
        // Next n bytes are txHash
        memcpy(txHash, G_io_apdu_buffer + 5 + 1, txHashLen);
        
        asn_sign_len = cx_ecdsa_sign(&originPrivateKey, CX_RND_TRNG, CX_SHA256, txHash, txHashLen, asn_sign + originPublicKey.W_len + 2, 200 - originPublicKey.W_len - 2, &info);
        asn_sign_len += originPublicKey.W_len + 2;

        memcpy(G_io_apdu_buffer, asn_sign, asn_sign_len);

        io_exchange_with_code(SW_OK, asn_sign_len);
    }
    else
    {
        io_exchange_with_code(SW_USER_REJECTED, 0);
    }

    ui_menu_main();
}

// data buffer is encoded as -> txnHashSize, txnHash
void handleSignHashOrigin(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags)
{

    *flags |= IO_ASYNCH_REPLY;

    memset(g_derivation_origin_path, 0, sizeof(g_derivation_origin_path));
    // g_derivation_path = "m/650'/ffff'/0'" always
    strncpy(g_derivation_origin_path, "m/650'/ffff'/0'", 30);

    snprintf(g_txHash_origin, sizeof(g_txHash_origin), "%.*H", dataBuffer[0], dataBuffer + 1);

    g_validate_origin_sig = &ui_action_validate_origin_signature;

    ux_flow_init(0, ux_display_orig_sign_flow, NULL);
}
