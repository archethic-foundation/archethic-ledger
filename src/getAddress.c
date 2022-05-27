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

static action_validate_cb g_validate_addr_callback;

static char g_derivation_path[30];
static char g_address[70];

static addr_struct_t g_addr;
static onchain_wallet_struct_t g_wallet;

// Step with icon and text
UX_STEP_NOCB(ux_display_confirm_address, bnnn_paging, {
                                                          .title = "Confirm Archethic",
                                                          .text = "Address",
                                                      });

// Step with title/text for BIP44 path
UX_STEP_NOCB(ux_display_addr_bip44,
             bnnn_paging,
             {
                 .title = "Derivation Path",
                 .text = g_derivation_path,
             });

// Step with title/text for public key
UX_STEP_NOCB(ux_display_arch_addr,
             bnnn_paging,
             {
                 .title = "Address",
                 .text = g_address,
             });

// Step with approve button
UX_STEP_CB(ux_display_approve_addr_arch,
           pb,
           (*g_validate_addr_callback)(true),
           {
               &C_icon_validate_14,
               "Approve to Share",
           });

// Step with reject button
UX_STEP_CB(ux_display_reject_addr_arch,
           pb,
           (*g_validate_addr_callback)(false),
           {
               &C_icon_crossmark,
               "Reject",
           });

// FLOW to display arch address key and BIP44 path:
// #1 screen: "confirm public key" text
// #2 screen: display BIP44 Path
// #3 screen: display arch address key
// #4 screen: approve button
// #5 screen: reject button
UX_FLOW(ux_display_arch_addr_flow,
        &ux_display_confirm_address,
        &ux_display_addr_bip44,
        &ux_display_arch_addr,
        &ux_display_approve_addr_arch,
        &ux_display_reject_addr_arch);

void ui_validate_address_arch(bool choice)
{

    if (choice)
    {

        memcpy(G_io_apdu_buffer, g_addr.arch_address, g_addr.arch_addr_len);
        io_exchange_with_code(SW_OK, g_addr.arch_addr_len);
    }
    else
    {
        io_exchange_with_code(SW_USER_REJECTED, 0);
    }

    ui_menu_main();
}

void handleGetAddress(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags)
{
    // convert address index (big endian)
    // uint32_t address_index = 0;
    // for (int c = 0; c < 4; c++)
    //     address_index |= (uint32_t)dataBuffer[c] << 8 * (3 - c);

    // dataBuffer += 4;
    // dataLength -= 4;

    uint8_t service_index = 0;
    service_index = dataBuffer[0];

    dataBuffer += 1;
    dataLength -= 1;

    uint8_t ecdhPointX[32] = {0};
    performECDH(dataBuffer, 65, ecdhPointX);
    dataBuffer += 65;
    dataLength -= 65;

    // decrypt wallet
    g_wallet.walletLen = sizeof(g_wallet.encodedWallet);

    decryptWallet(ecdhPointX, sizeof(ecdhPointX), dataBuffer, dataLength, g_wallet.encodedWallet, &g_wallet.walletLen);

    if (g_wallet.walletLen == 5)
    { // return "BADDECODE" if authentication for wallet decryption failed
        memcpy(G_io_apdu_buffer, g_wallet.encodedWallet, g_wallet.walletLen);
        io_exchange_with_code(SW_WRONG_WALLET, g_wallet.walletLen);
        return;
    }
    else
        *flags |= IO_ASYNCH_REPLY;

    // If this is reached then we will have our encoded wallet
   
    uint8_t bip44pathlen;
    memset(g_derivation_path, 0, sizeof(g_derivation_path));
    uint32_t seek_bytes = 0;
    getDerivationPath(service_index, g_wallet.encodedWallet, g_wallet.walletLen, 0, g_derivation_path, &bip44pathlen, &seek_bytes);

    generateArchEthicAddress(0, service_index, g_wallet.encodedWallet, &g_wallet.walletLen, 0, g_addr.arch_address, &g_addr.arch_addr_len, seek_bytes, 0);
    memset(g_address, 0, sizeof(g_address));
    snprintf(g_address, sizeof(g_address), "%.*H", sizeof(g_addr.arch_address), g_addr.arch_address);

    g_validate_addr_callback = &ui_validate_address_arch;
    ux_flow_init(0, ux_display_arch_addr_flow, NULL);
}
