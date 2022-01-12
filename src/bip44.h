#include <cx.h>

#define HDW_NORMAL 0
#define HDW_ED25519_SLIP10 1
#define HDW_SLIP21 2

typedef struct
{
    uint8_t private_key[64];
    uint8_t chain_code[32];
} extended_private_key;

unsigned long archethic_derive_node_with_seed_key(unsigned int mode, cx_curve_t curve, uint8_t *masterSeed, size_t masterSeedLen, const unsigned int *path, unsigned int pathLength, unsigned char *privateKey, unsigned char *chain, unsigned char *seed_key, unsigned int seed_key_length);