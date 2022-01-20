// echo 'e001000000' | python3 -m ledgerblue.runScript --apdu
// echo 'e001000000' | LEDGER_PROXY_ADDRESS=127.0.0.1 LEDGER_PROXY_PORT=9999 python3 -m ledgerblue.runScript --apdu
#include "os.h"
#include <os_io_seproxyhal.h>
#include "glyphs.h"
#include "archethic.h"
#include "ui/menu.h"

#include <stdint.h>
#include <stdbool.h>

ux_state_t G_ux;
bolos_ux_params_t G_ux_params;

#define INS_GET_VERSION 0x01
#define INS_GET_PUBLIC_KEY 0x02
#define INS_GET_ADDRESS 0x04
#define INS_SIGN_HASH 0x08

typedef void handler_fn_t(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags);

handler_fn_t handleGetVersion;
handler_fn_t handleGetPublicKey;
handler_fn_t handleGetAddress;
handler_fn_t handleSignHash;

static handler_fn_t *lookupHandler(uint8_t ins)
{
	switch (ins)
	{
	case INS_GET_VERSION:
		return handleGetVersion;
	case INS_GET_PUBLIC_KEY:
		return handleGetPublicKey;
	case INS_GET_ADDRESS:
		return handleGetAddress;
	case INS_SIGN_HASH:
		return handleSignHash;
	default:
		return NULL;
	}
}

#define CLA 0xE0
#define OFFSET_CLA 0x00
#define OFFSET_INS 0x01
#define OFFSET_P1 0x02
#define OFFSET_P2 0x03
#define OFFSET_LC 0x04
#define OFFSET_CDATA 0x05

static void archethic_main(void)
{
	// global.calcTxnHashContext.initialized = false;
	volatile unsigned int rx = 0;
	volatile unsigned int tx = 0;
	volatile unsigned int flags = 0;

	// Exchange APDUs until EXCEPTION_IO_RESET is thrown.
	for (;;)
	{
		volatile unsigned short sw = 0;
		BEGIN_TRY
		{
			TRY
			{
				rx = tx;
				tx = 0; // ensure no race in CATCH_OTHER if io_exchange throws an error
				rx = io_exchange(CHANNEL_APDU | flags, rx);
				flags = 0;

				// No APDU received; trigger a reset.
				if (rx == 0)
				{
					THROW(EXCEPTION_IO_RESET);
				}
				// Malformed APDU.
				if (G_io_apdu_buffer[OFFSET_CLA] != CLA)
				{
					THROW(0x6E00);
				}
				// Lookup and call the requested command handler.
				handler_fn_t *handlerFn = lookupHandler(G_io_apdu_buffer[OFFSET_INS]);
				if (!handlerFn)
				{
					THROW(0x6D00);
				}
				handlerFn(G_io_apdu_buffer[OFFSET_P1], G_io_apdu_buffer[OFFSET_P2],
						  G_io_apdu_buffer + OFFSET_CDATA, G_io_apdu_buffer[OFFSET_LC], &flags);
			}
			CATCH(EXCEPTION_IO_RESET)
			{
				THROW(EXCEPTION_IO_RESET);
			}
			CATCH_OTHER(e)
			{

				switch (e & 0xF000)
				{
				case 0x6000:
				case 0x9000:
					sw = e;
					break;
				default:
					sw = 0x6800 | (e & 0x7FF);
					break;
				}
				G_io_apdu_buffer[tx++] = sw >> 8;
				G_io_apdu_buffer[tx++] = sw & 0xFF;
			}
			FINALLY
			{
			}
		}
		END_TRY;
	}
}

// Ledger Default Code
void io_seproxyhal_display(const bagl_element_t *element)
{
	io_seproxyhal_display_default((bagl_element_t *)element);
}

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

unsigned char io_event(unsigned char channel)
{
	// can't have more than one tag in the reply, not supported yet.
	switch (G_io_seproxyhal_spi_buffer[0])
	{
	case SEPROXYHAL_TAG_FINGER_EVENT:
		UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
		break;

	case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
		UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
		break;

	case SEPROXYHAL_TAG_STATUS_EVENT:
		if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID &&
			!(U4BE(G_io_seproxyhal_spi_buffer, 3) &
			  SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED))
		{
			THROW(EXCEPTION_IO_RESET);
		}
		UX_DEFAULT_EVENT();
		break;

	case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
		UX_DISPLAYED_EVENT({});
		break;

	case SEPROXYHAL_TAG_TICKER_EVENT:
		UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {});
		break;

	default:
		UX_DEFAULT_EVENT();
		break;
	}

	// close the event if not done previously (by a display or whatever)
	if (!io_seproxyhal_spi_is_status_sent())
	{
		io_seproxyhal_general_status();
	}

	// command has been processed, DO NOT reset the current APDU transport
	return 1;
}

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len)
{
	switch (channel & ~(IO_FLAGS))
	{
	case CHANNEL_KEYBOARD:
		break;
	// multiplexed io exchange over a SPI channel and TLV encapsulated protocol
	case CHANNEL_SPI:
		if (tx_len)
		{
			io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
			if (channel & IO_RESET_AFTER_REPLIED)
			{
				reset();
			}
			return 0; // nothing received from the master so far (it's a tx transaction)
		}
		else
		{
			return io_seproxyhal_spi_recv(G_io_apdu_buffer, sizeof(G_io_apdu_buffer), 0);
		}
	default:
		THROW(INVALID_PARAMETER);
	}
	return 0;
}

static void app_exit(void)
{
	BEGIN_TRY_L(exit)
	{
		TRY_L(exit)
		{
			os_sched_exit(-1);
		}
		FINALLY_L(exit)
		{
		}
	}
	END_TRY_L(exit);
}

__attribute__((section(".boot"))) int main(void)
{
	// exit critical section
	__asm volatile("cpsie i");

	for (;;)
	{
		UX_INIT();
		os_boot();
		BEGIN_TRY
		{
			TRY
			{
				io_seproxyhal_init();
				USB_power(0);
				USB_power(1);

				ui_menu_main();
				archethic_main();
			}
			CATCH(EXCEPTION_IO_RESET)
			{
				// reset IO and UX before continuing
				continue;
			}
			CATCH_ALL
			{
				break;
			}
			FINALLY
			{
			}
		}
		END_TRY;
	}
	app_exit();
	return 0;
}
