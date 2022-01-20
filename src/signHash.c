#include <os.h>
#include "archethic.h"

static action_validate_cb g_validate_hash_callback;

static char g_hash[67];
static char g_bip44_path[40];
static tx_struct_t g_tx;
static onchain_wallet_struct_t g_Wallet;

// Step with icon and text
UX_STEP_NOCB(ux_confirm_sign_hash, bnnn_paging, {
                                                    .title = "Confirm Hash",
                                                    .text = "to Sign",
                                                });

// Step with title/text for BIP44 path
UX_STEP_NOCB(ux_display_hash_addr_bip44,
             bnnn_paging,
             {
                 .title = "bip44 Path",
                 .text = g_bip44_path,
             });

// Step with title/text for public key
UX_STEP_NOCB(ux_display_sign_hash,
             bnnn_paging,
             {
                 .title = "Txn Hash",
                 .text = g_hash,
             });

// Step with approve button
UX_STEP_CB(ux_display_approve_sign_hash,
           pb,
           (*g_validate_hash_callback)(true),
           {
               &C_icon_validate_14,
               "Approve to Sign",
           });

// Step with reject button
UX_STEP_CB(ux_display_reject_sign_hash,
           pb,
           (*g_validate_hash_callback)(false),
           {
               &C_icon_crossmark,
               "Reject",
           });

// FLOW to display confirm Sign Hash
// #1 screen: "confirm Sign Hash key" text
// #2 screen: display HASH
// #3 screen: approve button
// #4 screen: reject button
UX_FLOW(ux_display_sign_hash_main,
        &ux_confirm_sign_hash,
        &ux_display_hash_addr_bip44,
        &ux_display_sign_hash,
        &ux_display_approve_sign_hash,
        &ux_display_reject_sign_hash);

void ui_validate_sign_hash(bool choice)
{
    if (choice)
    {
        // Perform ECDSA Sign Hash After Approved By User
        performECDSA(g_tx.txHash, g_tx.txHashLen, g_tx.address_index,
                     g_Wallet.encodedWallet, &g_Wallet.walletLen, 0,
                     g_Wallet.encodedWallet, &g_Wallet.walletLen);

        for (int i = 0; i < g_Wallet.walletLen; i++)
            G_io_apdu_buffer[i] = g_Wallet.encodedWallet[i];
        io_exchange_with_code(SW_OK, g_Wallet.walletLen);
    }
    else
    {
        io_exchange_with_code(SW_USER_REJECTED, 0);
    }

    ui_menu_main();
}

void handleSignHash(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags)
{
    *flags |= IO_ASYNCH_REPLY;

    // convert address index (big endian)
    uint32_t address_index = 0;
    for (int c = 0; c < 4; c++)
        address_index |= (uint32_t)dataBuffer[c] << 8 * (3 - c);
    g_tx.address_index = address_index;
    dataBuffer += 4;
    dataLength -= 4;

    memcpy(g_tx.amount, dataBuffer, 8);
    dataBuffer += 8;
    dataLength -= 8;

    uint8_t addrLen = 0;
    switch (dataBuffer[1] % 2)
    {
    case 0: // SHA256 or SHA3_256
        addrLen = 34;
        break;
    case 1: // SHA512 OR SHA3_512
        addrLen = 66;
    default:
        break;
    }

    memcpy(g_tx.receiveAddr, dataBuffer, addrLen);
    g_tx.receiveAddrLen = addrLen;
    dataBuffer += addrLen;
    dataLength -= addrLen;

    performECDH(dataBuffer, 65, g_tx.ecdhPointX);
    dataBuffer += 65;
    dataLength -= 65;

    g_Wallet.walletLen = sizeof(g_Wallet.encodedWallet);
    decryptWallet(g_tx.ecdhPointX, sizeof(g_tx.ecdhPointX), dataBuffer, dataLength, g_Wallet.encodedWallet, &g_Wallet.walletLen);

    generateArchEthicAddress(0, address_index + 1, g_Wallet.encodedWallet, &g_Wallet.walletLen, 0, g_tx.senderAddr, &g_tx.senderAddrLen);

    uint8_t bip44pathlen;
    memset(g_bip44_path, 0, sizeof(g_bip44_path));
    getBIP44Path(address_index, g_Wallet.encodedWallet, g_Wallet.walletLen, 0, g_bip44_path, &bip44pathlen);

    getTransactionHash(g_tx.senderAddr, g_tx.senderAddrLen, g_tx.receiveAddr, g_tx.receiveAddrLen, g_tx.amount, g_tx.txHash, &g_tx.txHashLen);

    memset(g_hash, 0, sizeof(g_hash));
    snprintf(g_hash, sizeof(g_hash), "0x%.*H", sizeof(g_tx.txHash), g_tx.txHash);

    g_validate_hash_callback = &ui_validate_sign_hash;
    g_Wallet.walletLen = sizeof(g_Wallet.encodedWallet);
    ux_flow_init(0, ux_display_sign_hash_main, NULL);
}
