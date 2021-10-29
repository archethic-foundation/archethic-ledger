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

void handleGetPublicKey(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
	/*
		cx_err_t retcode;
		uint8_t buffer[32] = {0};
		retcode = cx_get_random_bytes(buffer, 32);
	*/
	uint32_t bip32Path[] = {44 | 0x80000000, 93 | 0x80000000, 1 | 0x80000000, 0x80000000, 0x80000000};
	uint8_t keySeed[32];
	cx_ecfp_private_key_t privateKey;
	cx_ecfp_public_key_t publicKey;

	// Derive Seed
	os_perso_derive_node_bip32(CX_CURVE_256K1, bip32Path, 5, keySeed, NULL);
	PRINTF("Seed:\n %.*h \n", 32, keySeed);

	// Initiate the private key with the seed
	cx_ecfp_init_private_key(CX_CURVE_256K1, keySeed, 32, &privateKey);

	// Generate the corresponding public key
	cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
	PRINTF("Pub Key:\n %.*h \n", publicKey.W_len, publicKey.W);

	for (int v = 0; v < publicKey.W_len; v++)
	{
		G_io_apdu_buffer[v] = publicKey.W[v];
	}
	io_exchange_with_code(SW_OK, publicKey.W_len);
}