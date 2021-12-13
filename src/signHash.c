#include <os.h>
#include "archethic.h"

void handleSignHash(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
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
		G_io_apdu_buffer[i] = buffer[i];
	}
	io_exchange_with_code(SW_OK, bufferLen);
	//*flags |= IO_ASYNCH_REPLY;
}
