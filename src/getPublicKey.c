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

static getPublicKeyContext_t *ctx = &global.getPublicKeyContext;

static const bagl_element_t ui_getPublicKey_approve[] = {
    UI_BACKGROUND(),
    UI_ICON_LEFT(0x00, BAGL_GLYPH_ICON_CROSS),
    UI_ICON_RIGHT(0x00, BAGL_GLYPH_ICON_CHECK),
    UI_TEXT(0x00, 0, 12, 128, global.getPublicKeyContext.typeStr),
    UI_TEXT(0x00, 0, 26, 128, global.getPublicKeyContext.keyStr),
};

static unsigned int ui_getPublicKey_approve_button(unsigned int button_mask, unsigned int button_mask_counter)
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

void handleGetPublicKey(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
    memmove(ctx->typeStr, "Generate Public", 16);
    memmove(ctx->keyStr, "Key ?", 5);
    UX_DISPLAY(ui_getPublicKey_approve, NULL);
    *flags |= IO_ASYNCH_REPLY;
}
