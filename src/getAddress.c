#include <os.h>
#include "archethic.h"
#include "ui/menu.h"

static action_validate_cb g_validate_addr_callback;

static char g_bip44_path[40];
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
                 .title = "bip44 Path",
                 .text = g_bip44_path,
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

    *flags |= IO_ASYNCH_REPLY;

    // convert address index (big endian)
    uint32_t address_index = 0;
    for (int c = 0; c < 4; c++)
        address_index |= (uint32_t)dataBuffer[c] << 8 * (3 - c);

    dataBuffer += 4;
    dataLength -= 4;

    uint8_t ecdhPointX[32] = {0};
    performECDH(dataBuffer, 65, ecdhPointX);
    dataBuffer += 65;
    dataLength -= 65;

    // decrypt wallet
    g_wallet.walletLen = sizeof(g_wallet.encodedWallet);
    decryptWallet(ecdhPointX, sizeof(ecdhPointX), dataBuffer, dataLength, g_wallet.encodedWallet, &g_wallet.walletLen);

    uint8_t bip44pathlen;
    memset(g_bip44_path, 0, sizeof(g_bip44_path));
    getBIP44Path(address_index, g_wallet.encodedWallet, g_wallet.walletLen, 0, g_bip44_path, &bip44pathlen);

    generateArchEthicAddress(0, address_index, g_wallet.encodedWallet, &g_wallet.walletLen, 0, g_addr.arch_address, &g_addr.arch_addr_len);
    memset(g_address, 0, sizeof(g_address));
    snprintf(g_address, sizeof(g_address), "0x%.*H", sizeof(g_addr.arch_address), g_addr.arch_address);

    g_validate_addr_callback = &ui_validate_address_arch;
    ux_flow_init(0, ux_display_arch_addr_flow, NULL);
}
