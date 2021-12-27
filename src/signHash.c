#include <os.h>
#include "archethic.h"

static action_validate_cb g_validate_hash_callback;

static char g_hash[279];

hash_struct_t g_hash_ctx;


// Step with icon and text
UX_STEP_NOCB(ux_confirm_sign_hash, bnnn_paging, {
                                                            .title = "Confirm Sign",
                                                            .text = "Hash",
                                                        });


// Step with title/text for public key
UX_STEP_NOCB(ux_display_sign_hash,
             bnnn_paging,
             {
                 .title = "Hash",
                 .text = g_hash,
             });

// Step with approve button
UX_STEP_CB(ux_display_approve_sign_hash,
           pb,
           (*g_validate_hash_callback)(true),
           {
               &C_icon_validate_14,
               "Approve",
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
        &ux_display_sign_hash,
		&ux_display_approve_sign_hash,
		&ux_display_reject_sign_hash
    );


void ui_validate_sign_hash(bool choice)
{
	
    if (choice)
    {	
		for (int i = 0; i < g_hash_ctx.hash_len ; i++)
			{
				G_io_apdu_buffer[i] = g_hash_ctx.hash_buffer[i];
			}
		io_exchange_with_code(SW_OK, g_hash_ctx.hash_len);
    }
    else
    {
        io_exchange_with_code(SW_USER_REJECTED, 0);
    }

    ui_menu_main();
}

void handleSignHash(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{

	*flags |= IO_ASYNCH_REPLY;

	uint8_t txHash[64] = {0};
	uint8_t txHashLen = 64;
	switch (p1)
	{
	case 0: // SHA256
		memcpy(txHash, dataBuffer, 32);
		txHashLen = 32;
		dataBuffer += 32;
		break;
	default:
		break;
	}

	uint8_t ecdhPointX[32] = {0};
	performECDH(dataBuffer, 65, ecdhPointX);

	uint8_t buffer[150] = {0};
	uint8_t bufferLen = sizeof(buffer);

	decryptWallet(ecdhPointX, sizeof(ecdhPointX), dataBuffer, dataLength, buffer, &bufferLen);

	bufferLen = sizeof(buffer);
	performECDSA(txHash, txHashLen, p2, buffer, &bufferLen, 0);

	for (int i = 0; i < bufferLen; i++)
	{
		g_hash_ctx.hash_buffer[i] = buffer[i];
	}

	g_hash_ctx.hash_len = bufferLen;

 	memset(g_hash, 0, sizeof(g_hash));
	snprintf(g_hash, sizeof(g_hash), "0x%.*H", sizeof(buffer), buffer);

    g_validate_hash_callback = &ui_validate_sign_hash;
	ux_flow_init(0, ux_display_sign_hash_main, NULL);

}
