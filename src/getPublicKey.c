#include <stdint.h>
#include <stdbool.h>
#include <os.h>
#include <os_io_seproxyhal.h>
#include <cx.h>

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
	// cx_ecfp_private_key_t privateKey;
	// cx_ecfp_public_key_t publicKey;
	cx_aes_key_t aesKey;

	// Derive Seed1
	os_perso_derive_node_bip32(CX_CURVE_256K1, bip32Path, 5, keySeed, NULL);
	PRINTF("Seed1:\n %.*h \n", 32, keySeed);

	cx_aes_init_key(keySeed, 32, &aesKey);
	unsigned char plaintext[] = "ARCHETHIC";
	unsigned char cipher[50] = {0};
	unsigned char recoveredtext[50] = {0};

	PRINTF("Plain:\n %.*h \n", sizeof(plaintext), plaintext);
	int cipher_size = cx_aes(&aesKey, CX_LAST | CX_ENCRYPT | CX_CHAIN_CBC | CX_PAD_ISO9797M2, plaintext, sizeof(plaintext), cipher, sizeof(cipher));
	PRINTF("Cipher:\n %.*h \n", cipher_size, cipher);

	int plain_size = cx_aes(&aesKey, CX_DECRYPT | CX_CHAIN_CBC | CX_PAD_ISO9797M2, cipher, cipher_size, recoveredtext, sizeof(recoveredtext));
	PRINTF("Recovered:\n %.*h \n", plain_size, recoveredtext);

	io_exchange_with_code(SW_OK, 0);
	/*
		// Initiate the private key with the seed1
		cx_ecfp_init_private_key(CX_CURVE_256K1, keySeed, 32, &privateKey);

		// Generate the corresponding public key1
		cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
		PRINTF("Pub Key1:\n %.*h \n", publicKey.W_len, publicKey.W);

		uint32_t bip32Path2[] = {44 | 0x80000000, 93 | 0x80000000, 2 | 0x80000000, 0x80000000, 0x80000000};
		uint8_t keySeed2[32];
		cx_ecfp_private_key_t privateKey2;
		cx_ecfp_public_key_t publicKey2;

		// Derive Seed2
		os_perso_derive_node_bip32(CX_CURVE_256K1, bip32Path2, 5, keySeed2, NULL);
		PRINTF("Seed2:\n %.*h \n", 32, keySeed2);

		// Initiate the private key2 with the seed2
		cx_ecfp_init_private_key(CX_CURVE_256K1, keySeed2, 32, &privateKey2);

		// Generate the corresponding public key2
		cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey2, &privateKey2, 1);
		PRINTF("Pub Key2:\n %.*h \n", publicKey2.W_len, publicKey2.W);

		unsigned char ecdh1[65] = {0};
		unsigned char ecdh2[65] = {0};

		int ecdh1_size = cx_ecdh(&privateKey, CX_ECDH_POINT, publicKey2.W, publicKey2.W_len, ecdh1, 65);
		for (int v = 0; v < ecdh1_size; v++)
		{
			G_io_apdu_buffer[v] = ecdh1[v];
		}

		int ecdh2_size = cx_ecdh(&privateKey2, CX_ECDH_POINT, publicKey.W, publicKey.W_len, ecdh2, 65);

		for (int v = 0; v < ecdh2_size; v++)
		{
			G_io_apdu_buffer[ecdh1_size + v] = ecdh2[v];
		}

		*/
}
