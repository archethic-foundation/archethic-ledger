// elixir verify
// public_key = Base.decode16!("", case: :lower)
// sign = Base.decode16!("", case: :lower)
// :crypto.verify(:ecdsa, :sha256, "archethic", sign, [public_key, :secp256k1])

#include <stdint.h>
#include <stdbool.h>
#include <os.h>
#include <os_io_seproxyhal.h>
#include <cx.h>
#include "archethic.h"
/*
static getAddressContext_t *ctx = &global.getAddressContext;

static const bagl_element_t ui_getAddress_approve[] = {
    UI_BACKGROUND(),
    UI_ICON_LEFT(0x00, BAGL_GLYPH_ICON_CROSS),
    UI_ICON_RIGHT(0x00, BAGL_GLYPH_ICON_CHECK),
    UI_TEXT(0x00, 0, 12, 128, global.getAddressContext.typeStr),
    UI_TEXT(0x00, 0, 26, 128, global.getAddressContext.keyStr),
};

static unsigned int ui_getAddress_approve_button(unsigned int button_mask, unsigned int button_mask_counter)
{
    uint16_t tx = 0;
    cx_ecfp_public_key_t publicKey;
    switch (button_mask)
    {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT: // REJECT
        io_exchange_with_code(SW_USER_REJECTED, 0);
        ui_menu_main();
        break;

    case BUTTON_EVT_RELEASED | BUTTON_RIGHT: // APPROVE
        getOriginPublicKey(&publicKey);
        G_io_apdu_buffer[0] = 2;

        // Ledger Origin Device
        G_io_apdu_buffer[1] = 4;
        for (int v = 0; v < (int)publicKey.W_len; v++)
            G_io_apdu_buffer[v + 2] = publicKey.W[v];

        io_exchange_with_code(SW_OK, publicKey.W_len + 2);
        ui_menu_main();
        break;
    }
    return 0;
}
*/
void handleGetAddress(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
    // ctx->hashType = p1;
    // ctx->addressIndex = p2;
    uint8_t ecdhPointX[32] = {0};
    uint8_t aes_key_iv_tag[64] = {0};
    performECDH(dataBuffer, 65, ecdhPointX);

    cx_hash_sha512(ecdhPointX, sizeof(ecdhPointX), aes_key_iv_tag, sizeof(aes_key_iv_tag));
    cx_hash_sha512(aes_key_iv_tag, sizeof(aes_key_iv_tag), aes_key_iv_tag, sizeof(aes_key_iv_tag));

    uint8_t auth_key[32] = {0};
    uint8_t auth_tag[32] = {0};
    cx_hash_sha256(aes_key_iv_tag + 48, 16, auth_key, sizeof(auth_key));
    cx_hmac_sha256(auth_key, sizeof(auth_key), dataBuffer + 65 + 16, 32, auth_tag, sizeof(auth_tag));
    uint8_t verify_tag = memcmp(auth_tag, dataBuffer + 65, 16);

    uint8_t wallet_key[32] = {0};
    uint8_t wallet_iv[32] = {0};
    uint8_t encodedWallet[100] = {0};
    uint8_t wallet_len = 0;
    if (verify_tag == 0)
    {
        cx_aes_key_t aesKey;
        cx_aes_init_key(aes_key_iv_tag, 32, &aesKey);
        cx_aes_iv(&aesKey, CX_DECRYPT | CX_CHAIN_CBC | CX_PAD_NONE, aes_key_iv_tag + 32, 16, dataBuffer + 65 + 16, 32, wallet_key, sizeof(wallet_key));

        cx_hash_sha256(wallet_key, sizeof(wallet_key), wallet_iv, sizeof(wallet_iv));
        cx_hash_sha256(wallet_iv, sizeof(wallet_iv), wallet_iv, sizeof(wallet_iv));

        cx_aes_key_t walletAESkey;
        cx_aes_init_key(wallet_key, 32, &walletAESkey);
        wallet_len = cx_aes_iv(&walletAESkey, CX_ENCRYPT | CX_CHAIN_CTR | CX_LAST | CX_PAD_NONE, wallet_iv, 16, dataBuffer + 65 + 16 + 32, dataLength - 65 - 16 - 32, encodedWallet, sizeof(encodedWallet));
    }

    generateArchEthicAddress(p1, p2, encodedWallet, &wallet_len, 0);

    for (int i = 0; i < wallet_len; i++)
    {
        G_io_apdu_buffer[i] = encodedWallet[i];
    }
    io_exchange_with_code(SW_OK, wallet_len);
    /*
        memmove(ctx->typeStr, "Generate Onchain", 17);
        memmove(ctx->keyStr, "Wallet Address?", 16);
        UX_DISPLAY(ui_getAddress_approve, NULL);
        *flags |= IO_ASYNCH_REPLY;
    */
}
