#include "archethic.h"
#include "ux.h"
#include <os.h>
#include <os_io_seproxyhal.h>
#include "cx.h"
#include "display.h"

static action_validate_cb g_validate_callback;
static char g_address[65];
static char g_bip32_path[60];
cx_ecfp_public_key_t publicKey;


// Step with icon and text
UX_STEP_NOCB(ux_display_confirm_addr_step, pn, {NULL, "Confirm Address"});
// Step with title/text for BIP32 path
UX_STEP_NOCB(ux_display_path_step,
             bnnn_paging,
             {
                 .title = "bip32 Path",
                 .text = g_bip32_path,
             });
// Step with title/text for address
UX_STEP_NOCB(ux_display_address_step,
             bnnn_paging,
             {
                 .title = "Address",
                 .text = g_address,
             });
// Step with approve button
UX_STEP_CB(ux_display_approve_step,
           pb,
           (*g_validate_callback)(true),
           {
               NULL,
               "Approve",
           });
// Step with reject button
UX_STEP_CB(ux_display_reject_step,
           pb,
           (*g_validate_callback)(false),
           {
               NULL,
               "Reject",
           });

// FLOW to display address and BIP32 path:
// #1 screen: eye icon + "Confirm Address"
// #2 screen: display BIP32 Path
// #3 screen: display address
// #4 screen: approve button
// #5 screen: reject button
UX_FLOW(ux_display_pubkey_flow,
        &ux_display_confirm_addr_step,
        &ux_display_path_step,
        &ux_display_address_step,
        &ux_display_approve_step,
        &ux_display_reject_step);


void ui_action_validate_pubkey(bool choice) {

    if (choice) {
        
        G_io_apdu_buffer[0] = 2;

        // Ledger Origin Device
        G_io_apdu_buffer[1] = 4;
        for (int v = 0; v < (int)publicKey.W_len; v++)
            G_io_apdu_buffer[v + 2] = publicKey.W[v];

        io_exchange_with_code(SW_OK, publicKey.W_len + 2);
    } else {
        io_exchange_with_code(SW_USER_REJECTED, 0);
        
    }

    ui_menu_main();
}

int ui_display_address() {
    
    memset(g_bip32_path, 0, sizeof(g_bip32_path));
    memset(g_address, 0, sizeof(g_address));

    getOriginPublicKey(&publicKey);
    
    snprintf(g_address, sizeof(g_address), "0x%.*H", publicKey.W_len, publicKey.W);
    
    // g_bip32_path = "m/44'/650'/ffff'/0'/0'" always

    strncpy(g_bip32_path, "m/44'/650'/ffff'/0'/0'", 60);

    g_validate_callback = &ui_action_validate_pubkey;

    ux_flow_init(0, ux_display_pubkey_flow, NULL);

    return 0;
}
