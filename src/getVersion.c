#include <stdint.h>
#include <stdbool.h>
#include <os.h>
#include <os_io_seproxyhal.h>

// exception codes
#define SW_DEVELOPER_ERR 0x6B00
#define SW_INVALID_PARAM 0x6B01
#define SW_IMPROPER_INIT 0x6B02
#define SW_USER_REJECTED 0x6985
#define SW_OK 0x9000

// handleGetVersion is the entry point for the getVersion command. It
// unconditionally sends the app version.
void handleGetVersion(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
	G_io_apdu_buffer[0] = APPVERSION[0] - '0';
	G_io_apdu_buffer[1] = APPVERSION[2] - '0';
	G_io_apdu_buffer[2] = APPVERSION[4] - '0';

	// Testing Debug
	uint8_t buffer[4] = {0xDE, 0xAD, 0xBE, 0xEF};

	// PRINTF(string, array length, array);
	// .*H for uppercase, .*h for lowercase
	PRINTF("What a lovely buffer:\n %.*H \n\n", 4, buffer);
	PRINTF("I prefer it lower-cased:\n %.*h \n", 4, buffer);

	io_exchange_with_code(SW_OK, 3);
}