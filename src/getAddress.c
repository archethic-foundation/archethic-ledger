#include <os.h>
#include "archethic.h"

void handleGetAddress(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{

    uint8_t ecdhPointX[32] = {0};
    performECDH(dataBuffer, 65, ecdhPointX);

    uint8_t encodedWallet[100] = {0};
    uint8_t walletLen = sizeof(encodedWallet);

    decryptWallet(ecdhPointX, sizeof(ecdhPointX), dataBuffer, dataLength, encodedWallet, &walletLen);
    generateArchEthicAddress(p1, p2, encodedWallet, &walletLen, 0);

    for (int i = 0; i < walletLen; i++)
    {
        G_io_apdu_buffer[i] = encodedWallet[i];
    }
    io_exchange_with_code(SW_OK, walletLen);
    //*flags |= IO_ASYNCH_REPLY;
}
