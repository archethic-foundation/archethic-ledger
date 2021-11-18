#include "ux.h"

// Each command has some state associated with it that sticks around for the
// life of the command. A separate context_t struct should be defined for each
// command.

typedef struct
{
    uint32_t keyIndex;
    bool genAddr;
    uint8_t displayIndex;
    // NUL-terminated strings for display
    uint8_t typeStr[40]; // variable-length
    uint8_t keyStr[40];  // variable-length
    uint8_t fullStr[77]; // variable length
    // partialStr contains 12 characters of a longer string. This allows text
    // to be scrolled.
    uint8_t partialStr[13];
} getPublicKeyContext_t;

typedef struct
{
    uint32_t keyIndex;
    uint8_t hash[32];
    uint8_t hexHash[64];
    uint8_t displayIndex;
    // NUL-terminated strings for display
    uint8_t indexStr[40]; // variable-length
    uint8_t partialHashStr[13];
} signHashContext_t;

typedef struct
{
    uint32_t keyIndex;
    bool sign;
    uint8_t elemLen;
    uint8_t displayIndex;
    uint8_t elemPart; // screen index of elements
    // txn_state_t txn;
    //  NUL-terminated strings for display
    uint8_t labelStr[40]; // variable length
    uint8_t fullStr[128]; // variable length
    uint8_t partialStr[13];
    bool initialized; // protects against certain attacks
} calcTxnHashContext_t;

// To save memory, we store all the context types in a single global union,
// taking advantage of the fact that only one command is executed at a time.
typedef union
{
    getPublicKeyContext_t getPublicKeyContext;
    signHashContext_t signHashContext;
    calcTxnHashContext_t calcTxnHashContext;
} commandContext;
extern commandContext global;

// ux is a magic global variable implicitly referenced by the UX_ macros. Apps
// should never need to reference it directly.
extern ux_state_t ux;

#define UI_BACKGROUND()                                                                                         \
    {                                                                                                           \
        {BAGL_RECTANGLE, 0, 0, 0, 128, 32, 0, 0, BAGL_FILL, 0, 0xFFFFFF, 0, 0}, NULL, 0, 0, 0, NULL, NULL, NULL \
    }
#define UI_ICON_LEFT(userid, glyph)                                                                       \
    {                                                                                                     \
        {BAGL_ICON, userid, 3, 12, 7, 7, 0, 0, 0, 0xFFFFFF, 0, 0, glyph}, NULL, 0, 0, 0, NULL, NULL, NULL \
    }
#define UI_ICON_RIGHT(userid, glyph)                                                                        \
    {                                                                                                       \
        {BAGL_ICON, userid, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0, 0, glyph}, NULL, 0, 0, 0, NULL, NULL, NULL \
    }
#define UI_TEXT(userid, x, y, w, text)                                                                                                                                        \
    {                                                                                                                                                                         \
        {BAGL_LABELINE, userid, x, y, w, 12, 0, 0, 0, 0xFFFFFF, 0, BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0}, (char *)text, 0, 0, 0, NULL, NULL, NULL \
    }

// exception codes
#define SW_DEVELOPER_ERR 0x6B00
#define SW_INVALID_PARAM 0x6B01
#define SW_IMPROPER_INIT 0x6B02
#define SW_USER_REJECTED 0x6985
#define SW_OK 0x9000

void deriveArchEthicKeyPair(uint32_t keyIndex, cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey);
void bin2hex(uint8_t *dst, uint8_t *data, uint64_t inlen);
int bin2dec(uint8_t *dst, uint64_t n);