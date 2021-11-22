#include <cx.h>

#define HDW_NORMAL 0
#define HDW_ED25519_SLIP10 1
#define HDW_SLIP21 2

typedef struct
{
    uint8_t private_key[64];
    uint8_t chain_code[32];
} extended_private_key;

unsigned long archethic_derive_node_bip32(cx_curve_t curve, const uint8_t *masterSeed, size_t masterSeedLen, const uint32_t *path, size_t length, uint8_t *private_key, uint8_t *chain);
unsigned long archethic_derive_node_with_seed_key(unsigned int mode, cx_curve_t curve, const uint8_t *masterSeed, size_t masterSeedLen, const unsigned int *path, unsigned int pathLength, unsigned char *privateKey, unsigned char *chain, unsigned char *seed_key, unsigned int seed_key_length);
void expand_seed_bip32(const cx_curve_domain_t *domain, uint8_t *seed, unsigned int seed_length, extended_private_key *key);