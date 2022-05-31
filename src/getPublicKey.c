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
#include "ui/menu.h"

static action_validate_cb g_validate_callback;
static char g_public_key[135]; // 1 + 4 + 130

static char g_derivation_path[30];
// Global Structure
cx_ecfp_public_key_t publicKey;

// Step with icon and text
UX_STEP_NOCB(ux_display_confirm_addr_step, bnnn_paging, {
                                                            .title = "Confirm Origin",
                                                            .text = "Public Key",
                                                        });

// Step with title/text for BIP44 path
UX_STEP_NOCB(ux_display_path_step,
             bnnn_paging,
             {
                 .title = "Derivation Path",
                 .text = g_derivation_path,
             });

// Step with title/text for public key
UX_STEP_NOCB(ux_display_public_key_step,
             bnnn_paging,
             {
                 .title = "Public Key",
                 .text = g_public_key,
             });

// Step with approve button
UX_STEP_CB(ux_display_approve_step,
           pb,
           (*g_validate_callback)(true),
           {
               &C_icon_validate_14,
               "Approve",
           });

// Step with reject button
UX_STEP_CB(ux_display_reject_step,
           pb,
           (*g_validate_callback)(false),
           {
               &C_icon_crossmark,
               "Reject",
           });

// FLOW to display public key and BIP44 path:
// #1 screen: "confirm public key" text
// #2 screen: display BIP44 Path
// #3 screen: display public key
// #4 screen: approve button
// #5 screen: reject button
UX_FLOW(ux_display_pubkey_flow,
        &ux_display_confirm_addr_step,
        &ux_display_path_step,
        &ux_display_public_key_step,
        &ux_display_approve_step,
        &ux_display_reject_step);

void ui_action_validate_pubkey(bool choice)
{

    if (choice)
    {
        G_io_apdu_buffer[0] = 2;
        // Ledger Origin Device
        G_io_apdu_buffer[1] = 4;

        memcpy(G_io_apdu_buffer + 2, publicKey.W, publicKey.W_len);
        io_exchange_with_code(SW_OK, publicKey.W_len + 2);
    }
    else
    {
        io_exchange_with_code(SW_USER_REJECTED, 0);
    }

    ui_menu_main();
}

void handleGetPublicKey(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags)
{
    *flags |= IO_ASYNCH_REPLY;

    memset(g_derivation_path, 0, sizeof(g_derivation_path));
    memset(g_public_key, 0, sizeof(g_public_key));

    getOriginPublicKey(&publicKey);
    // Append 0204 in front as per origin public key encoding
    snprintf(g_public_key, sizeof(g_public_key), "0204%.*H", publicKey.W_len, publicKey.W);

    // g_derivation_path = "m/650'/ffff'/0'" always
    strncpy(g_derivation_path, "m/650'/ffff'/0'", 30);

    g_validate_callback = &ui_action_validate_pubkey;
    ux_flow_init(0, ux_display_pubkey_flow, NULL);
}
