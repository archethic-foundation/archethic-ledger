
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
	}
	END_TRY_L(exit);
}

__attribute__((section(".boot"))) int main(void)
{
c0d00000:	b5b0      	push	{r4, r5, r7, lr}
c0d00002:	b08c      	sub	sp, #48	; 0x30
	// exit critical section
	__asm volatile("cpsie i");
c0d00004:	b662      	cpsie	i
c0d00006:	4c1a      	ldr	r4, [pc, #104]	; (c0d00070 <main+0x70>)
c0d00008:	2021      	movs	r0, #33	; 0x21
c0d0000a:	00c1      	lsls	r1, r0, #3

	for (;;)
	{
		UX_INIT();
c0d0000c:	4620      	mov	r0, r4
c0d0000e:	f003 f81b 	bl	c0d03048 <__aeabi_memclr>
		os_boot();
c0d00012:	f000 fd12 	bl	c0d00a3a <os_boot>
c0d00016:	466d      	mov	r5, sp
		BEGIN_TRY
		{
			TRY
c0d00018:	4628      	mov	r0, r5
c0d0001a:	f003 f851 	bl	c0d030c0 <setjmp>
c0d0001e:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00020:	b280      	uxth	r0, r0
c0d00022:	2805      	cmp	r0, #5
c0d00024:	d106      	bne.n	c0d00034 <main+0x34>
c0d00026:	4668      	mov	r0, sp
c0d00028:	2100      	movs	r1, #0
				USB_power(1);
				
				ui_menu_main();
				archethic_main();
			}
			CATCH(EXCEPTION_IO_RESET)
c0d0002a:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d0002c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d0002e:	f001 fc75 	bl	c0d0191c <try_context_set>
c0d00032:	e7e9      	b.n	c0d00008 <main+0x8>
			TRY
c0d00034:	2800      	cmp	r0, #0
c0d00036:	d00a      	beq.n	c0d0004e <main+0x4e>
c0d00038:	4668      	mov	r0, sp
c0d0003a:	2400      	movs	r4, #0
			{
				// reset IO and UX before continuing
				continue;
			}
			CATCH_ALL
c0d0003c:	8584      	strh	r4, [r0, #44]	; 0x2c
c0d0003e:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d00040:	f001 fc6c 	bl	c0d0191c <try_context_set>
			{
			}
		}
		END_TRY;
	}
	app_exit();
c0d00044:	f000 fcb2 	bl	c0d009ac <app_exit>
	return 0;
c0d00048:	4620      	mov	r0, r4
c0d0004a:	b00c      	add	sp, #48	; 0x30
c0d0004c:	bdb0      	pop	{r4, r5, r7, pc}
c0d0004e:	4668      	mov	r0, sp
			TRY
c0d00050:	f001 fc64 	bl	c0d0191c <try_context_set>
c0d00054:	900a      	str	r0, [sp, #40]	; 0x28
				io_seproxyhal_init();
c0d00056:	f000 fe09 	bl	c0d00c6c <io_seproxyhal_init>
c0d0005a:	2000      	movs	r0, #0
				USB_power(0);
c0d0005c:	f002 fb22 	bl	c0d026a4 <USB_power>
c0d00060:	2001      	movs	r0, #1
				USB_power(1);
c0d00062:	f002 fb1f 	bl	c0d026a4 <USB_power>
				ui_menu_main();
c0d00066:	f000 fcd1 	bl	c0d00a0c <ui_menu_main>
				archethic_main();
c0d0006a:	f000 fc05 	bl	c0d00878 <archethic_main>
c0d0006e:	46c0      	nop			; (mov r8, r8)
c0d00070:	20000200 	.word	0x20000200

c0d00074 <deriveArchEthicKeyPair>:

// uint8_t masterSeed[] = {0x9A, 0x34, 0xA2, 0x33, 0xC4, 0x8B, 0x77, 0xD4, 0x88, 0x56, 0xED, 0x17, 0x17, 0x92, 0xD0, 0xB1, 0x67, 0xF5, 0x0D, 0x9A, 0x81, 0x48, 0x76, 0x9E, 0x00, 0x0D, 0x1F, 0x3C, 0x75, 0xF7, 0x4C, 0x15};
// uint8_t masterSeed[] = {0x6f, 0xa7, 0x74, 0x71, 0x8b, 0x0f, 0x08, 0x61, 0x01, 0xe7, 0xa0, 0xbf, 0x43, 0xf8, 0x19, 0x44, 0xf2, 0xee, 0xa0, 0x39, 0x2b, 0xc3, 0x45, 0x2a, 0xc3, 0x14, 0xcc, 0x44, 0x4f, 0x19, 0x97, 0x89, 0x89, 0xc6, 0x2b, 0xe4, 0x11, 0x0f, 0x8f, 0xd3, 0xe5, 0x43, 0x87, 0x5e, 0x9f, 0x3f, 0xe2, 0xe2, 0x24, 0x0f, 0x55, 0x4c, 0xf1, 0x6c, 0xfe, 0xbf, 0x67, 0x3b, 0x11, 0x2a, 0xc4, 0x4e, 0xc0, 0x16};

void deriveArchEthicKeyPair(uint32_t keyIndex, cx_ecfp_private_key_t *privateKey, cx_ecfp_public_key_t *publicKey)
{
c0d00074:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00076:	b099      	sub	sp, #100	; 0x64
c0d00078:	4615      	mov	r5, r2
c0d0007a:	460c      	mov	r4, r1
c0d0007c:	2101      	movs	r1, #1
c0d0007e:	07c9      	lsls	r1, r1, #31
    uint8_t keySeed[32];
    cx_ecfp_private_key_t walletPrivateKey;

    // bip32 path for 44'/650'/n'/0'/0'
    uint32_t bip32Path[] = {44 | 0x80000000, 650 | 0x80000000, keyIndex | 0x80000000, 0x80000000, 0x80000000};
c0d00080:	9106      	str	r1, [sp, #24]
c0d00082:	9105      	str	r1, [sp, #20]
c0d00084:	4308      	orrs	r0, r1
c0d00086:	9004      	str	r0, [sp, #16]
c0d00088:	481e      	ldr	r0, [pc, #120]	; (c0d00104 <deriveArchEthicKeyPair+0x90>)
c0d0008a:	9003      	str	r0, [sp, #12]
c0d0008c:	312c      	adds	r1, #44	; 0x2c
c0d0008e:	9102      	str	r1, [sp, #8]
c0d00090:	2000      	movs	r0, #0

    // Derive the seed for given path
    os_perso_derive_node_bip32(CX_CURVE_256K1, bip32Path, 5, keySeed, NULL);
c0d00092:	9000      	str	r0, [sp, #0]
c0d00094:	2621      	movs	r6, #33	; 0x21
c0d00096:	a902      	add	r1, sp, #8
c0d00098:	2205      	movs	r2, #5
c0d0009a:	af11      	add	r7, sp, #68	; 0x44
c0d0009c:	4630      	mov	r0, r6
c0d0009e:	463b      	mov	r3, r7
c0d000a0:	f001 fbac 	bl	c0d017fc <os_perso_derive_node_bip32>
c0d000a4:	2220      	movs	r2, #32
c0d000a6:	ab07      	add	r3, sp, #28
                                  size_t                 key_len,
                                  cx_ecfp_private_key_t *pvkey);

static inline int cx_ecfp_init_private_key ( cx_curve_t curve, const unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * pvkey )
{
  CX_THROW(cx_ecfp_init_private_key_no_throw(curve, rawkey, key_len, pvkey));
c0d000a8:	4630      	mov	r0, r6
c0d000aa:	4639      	mov	r1, r7
c0d000ac:	f000 f832 	bl	c0d00114 <cx_ecfp_init_private_key_no_throw>
c0d000b0:	2800      	cmp	r0, #0
c0d000b2:	d124      	bne.n	c0d000fe <deriveArchEthicKeyPair+0x8a>
    // archethic_derive_node_bip32(CX_CURVE_256K1, masterSeed, sizeof(masterSeed), bip32Path, 5, keySeed, NULL);

    // Initiate the private key with the seed
    cx_ecfp_init_private_key(CX_CURVE_256K1, keySeed, 32, &walletPrivateKey);

    if (publicKey)
c0d000b4:	2d00      	cmp	r5, #0
c0d000b6:	d00f      	beq.n	c0d000d8 <deriveArchEthicKeyPair+0x64>
c0d000b8:	2021      	movs	r0, #33	; 0x21
c0d000ba:	2100      	movs	r1, #0
  CX_THROW(cx_ecfp_init_public_key_no_throw(curve, rawkey, key_len, key));
c0d000bc:	460a      	mov	r2, r1
c0d000be:	462b      	mov	r3, r5
c0d000c0:	f000 f82e 	bl	c0d00120 <cx_ecfp_init_public_key_no_throw>
c0d000c4:	2800      	cmp	r0, #0
c0d000c6:	d11a      	bne.n	c0d000fe <deriveArchEthicKeyPair+0x8a>
c0d000c8:	2021      	movs	r0, #33	; 0x21
c0d000ca:	aa07      	add	r2, sp, #28
c0d000cc:	2301      	movs	r3, #1
                               cx_ecfp_private_key_t *privkey,
                               bool                   keepprivate);

static inline int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate )
{
  CX_THROW(cx_ecfp_generate_pair_no_throw(curve, pubkey, privkey, keepprivate));
c0d000ce:	4629      	mov	r1, r5
c0d000d0:	f000 f81a 	bl	c0d00108 <cx_ecfp_generate_pair_no_throw>
c0d000d4:	2800      	cmp	r0, #0
c0d000d6:	d112      	bne.n	c0d000fe <deriveArchEthicKeyPair+0x8a>
    {
        // Derive the corresponding public key
        cx_ecfp_init_public_key(CX_CURVE_256K1, NULL, 0, publicKey);
        cx_ecfp_generate_pair(CX_CURVE_256K1, publicKey, &walletPrivateKey, 1);
    }
    if (privateKey)
c0d000d8:	2c00      	cmp	r4, #0
c0d000da:	d006      	beq.n	c0d000ea <deriveArchEthicKeyPair+0x76>
c0d000dc:	a807      	add	r0, sp, #28
    {
        *privateKey = walletPrivateKey;
c0d000de:	c80e      	ldmia	r0!, {r1, r2, r3}
c0d000e0:	c40e      	stmia	r4!, {r1, r2, r3}
c0d000e2:	c80e      	ldmia	r0!, {r1, r2, r3}
c0d000e4:	c40e      	stmia	r4!, {r1, r2, r3}
c0d000e6:	c82e      	ldmia	r0!, {r1, r2, r3, r5}
c0d000e8:	c42e      	stmia	r4!, {r1, r2, r3, r5}
c0d000ea:	a811      	add	r0, sp, #68	; 0x44
c0d000ec:	2120      	movs	r1, #32
    }
    explicit_bzero(keySeed, sizeof(keySeed));
c0d000ee:	f002 ffbf 	bl	c0d03070 <explicit_bzero>
c0d000f2:	a807      	add	r0, sp, #28
c0d000f4:	2128      	movs	r1, #40	; 0x28
    explicit_bzero(&walletPrivateKey, sizeof(walletPrivateKey));
c0d000f6:	f002 ffbb 	bl	c0d03070 <explicit_bzero>
}
c0d000fa:	b019      	add	sp, #100	; 0x64
c0d000fc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d000fe:	f000 fca1 	bl	c0d00a44 <os_longjmp>
c0d00102:	46c0      	nop			; (mov r8, r8)
c0d00104:	8000028a 	.word	0x8000028a

c0d00108 <cx_ecfp_generate_pair_no_throw>:
CX_TRAMPOLINE _NR_cx_ecdsa_verify_no_throw                 cx_ecdsa_verify_no_throw
CX_TRAMPOLINE _NR_cx_ecfp_add_point_no_throw               cx_ecfp_add_point_no_throw
CX_TRAMPOLINE _NR_cx_ecfp_decode_sig_der                   cx_ecfp_decode_sig_der
CX_TRAMPOLINE _NR_cx_ecfp_encode_sig_der                   cx_ecfp_encode_sig_der
CX_TRAMPOLINE _NR_cx_ecfp_generate_pair2_no_throw          cx_ecfp_generate_pair2_no_throw
CX_TRAMPOLINE _NR_cx_ecfp_generate_pair_no_throw           cx_ecfp_generate_pair_no_throw
c0d00108:	b403      	push	{r0, r1}
c0d0010a:	4801      	ldr	r0, [pc, #4]	; (c0d00110 <cx_ecfp_generate_pair_no_throw+0x8>)
c0d0010c:	e017      	b.n	c0d0013e <cx_trampoline_helper>
c0d0010e:	0000      	.short	0x0000
c0d00110:	0000001b 	.word	0x0000001b

c0d00114 <cx_ecfp_init_private_key_no_throw>:
CX_TRAMPOLINE _NR_cx_ecfp_init_private_key_no_throw        cx_ecfp_init_private_key_no_throw
c0d00114:	b403      	push	{r0, r1}
c0d00116:	4801      	ldr	r0, [pc, #4]	; (c0d0011c <cx_ecfp_init_private_key_no_throw+0x8>)
c0d00118:	e011      	b.n	c0d0013e <cx_trampoline_helper>
c0d0011a:	0000      	.short	0x0000
c0d0011c:	0000001c 	.word	0x0000001c

c0d00120 <cx_ecfp_init_public_key_no_throw>:
CX_TRAMPOLINE _NR_cx_ecfp_init_public_key_no_throw         cx_ecfp_init_public_key_no_throw
c0d00120:	b403      	push	{r0, r1}
c0d00122:	4801      	ldr	r0, [pc, #4]	; (c0d00128 <cx_ecfp_init_public_key_no_throw+0x8>)
c0d00124:	e00b      	b.n	c0d0013e <cx_trampoline_helper>
c0d00126:	0000      	.short	0x0000
c0d00128:	0000001d 	.word	0x0000001d

c0d0012c <cx_rng_no_throw>:
CX_TRAMPOLINE _NR_cx_pbkdf2_hmac                           cx_pbkdf2_hmac
CX_TRAMPOLINE _NR_cx_pbkdf2_no_throw                       cx_pbkdf2_no_throw
CX_TRAMPOLINE _NR_cx_ripemd160_final                       cx_ripemd160_final
CX_TRAMPOLINE _NR_cx_ripemd160_init_no_throw               cx_ripemd160_init_no_throw
CX_TRAMPOLINE _NR_cx_ripemd160_update                      cx_ripemd160_update
CX_TRAMPOLINE _NR_cx_rng_no_throw                          cx_rng_no_throw
c0d0012c:	b403      	push	{r0, r1}
c0d0012e:	4801      	ldr	r0, [pc, #4]	; (c0d00134 <cx_rng_no_throw+0x8>)
c0d00130:	e005      	b.n	c0d0013e <cx_trampoline_helper>
c0d00132:	0000      	.short	0x0000
c0d00134:	00000058 	.word	0x00000058

c0d00138 <cx_swap_uint64>:
CX_TRAMPOLINE _NR_cx_shake128_init_no_throw                cx_shake128_init_no_throw
CX_TRAMPOLINE _NR_cx_shake256_init_no_throw                cx_shake256_init_no_throw
CX_TRAMPOLINE _NR_cx_swap_buffer32                         cx_swap_buffer32
CX_TRAMPOLINE _NR_cx_swap_buffer64                         cx_swap_buffer64
CX_TRAMPOLINE _NR_cx_swap_uint32                           cx_swap_uint32
CX_TRAMPOLINE _NR_cx_swap_uint64                           cx_swap_uint64
c0d00138:	b403      	push	{r0, r1}
c0d0013a:	4802      	ldr	r0, [pc, #8]	; (c0d00144 <cx_trampoline_helper+0x6>)
c0d0013c:	e7ff      	b.n	c0d0013e <cx_trampoline_helper>

c0d0013e <cx_trampoline_helper>:

.thumb_func
cx_trampoline_helper:
  ldr  r1, =_cx_trampoline
c0d0013e:	4902      	ldr	r1, [pc, #8]	; (c0d00148 <cx_trampoline_helper+0xa>)
  bx   r1
c0d00140:	4708      	bx	r1
c0d00142:	0000      	.short	0x0000
CX_TRAMPOLINE _NR_cx_swap_uint64                           cx_swap_uint64
c0d00144:	0000006f 	.word	0x0000006f
  ldr  r1, =_cx_trampoline
c0d00148:	00120001 	.word	0x00120001

c0d0014c <handleGetPublicKey>:
    }
    return 0;
}

void handleGetPublicKey(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
c0d0014c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0014e:	b085      	sub	sp, #20
    memmove(ctx->typeStr, "Generate Public", 16);
c0d00150:	4d3a      	ldr	r5, [pc, #232]	; (c0d0023c <handleGetPublicKey+0xf0>)
c0d00152:	1da8      	adds	r0, r5, #6
c0d00154:	493c      	ldr	r1, [pc, #240]	; (c0d00248 <handleGetPublicKey+0xfc>)
c0d00156:	4479      	add	r1, pc
c0d00158:	2210      	movs	r2, #16
c0d0015a:	9202      	str	r2, [sp, #8]
c0d0015c:	f002 ff79 	bl	c0d03052 <__aeabi_memcpy>
    memmove(ctx->keyStr, "Key ?", 5);
c0d00160:	352e      	adds	r5, #46	; 0x2e
c0d00162:	493a      	ldr	r1, [pc, #232]	; (c0d0024c <handleGetPublicKey+0x100>)
c0d00164:	4479      	add	r1, pc
c0d00166:	2605      	movs	r6, #5
c0d00168:	4628      	mov	r0, r5
c0d0016a:	4632      	mov	r2, r6
c0d0016c:	f002 ff71 	bl	c0d03052 <__aeabi_memcpy>
c0d00170:	20d4      	movs	r0, #212	; 0xd4
    UX_DISPLAY(ui_getPublicKey_approve, NULL);
c0d00172:	4f33      	ldr	r7, [pc, #204]	; (c0d00240 <handleGetPublicKey+0xf4>)
c0d00174:	4936      	ldr	r1, [pc, #216]	; (c0d00250 <handleGetPublicKey+0x104>)
c0d00176:	4479      	add	r1, pc
c0d00178:	5039      	str	r1, [r7, r0]
c0d0017a:	20c8      	movs	r0, #200	; 0xc8
c0d0017c:	9003      	str	r0, [sp, #12]
c0d0017e:	543e      	strb	r6, [r7, r0]
c0d00180:	24c4      	movs	r4, #196	; 0xc4
c0d00182:	4834      	ldr	r0, [pc, #208]	; (c0d00254 <handleGetPublicKey+0x108>)
c0d00184:	4478      	add	r0, pc
c0d00186:	5138      	str	r0, [r7, r4]
c0d00188:	20d0      	movs	r0, #208	; 0xd0
c0d0018a:	9001      	str	r0, [sp, #4]
c0d0018c:	2500      	movs	r5, #0
c0d0018e:	503d      	str	r5, [r7, r0]
c0d00190:	482c      	ldr	r0, [pc, #176]	; (c0d00244 <handleGetPublicKey+0xf8>)
c0d00192:	6045      	str	r5, [r0, #4]
c0d00194:	2103      	movs	r1, #3
c0d00196:	7001      	strb	r1, [r0, #0]
c0d00198:	f001 fb5a 	bl	c0d01850 <os_ux>
c0d0019c:	2604      	movs	r6, #4
c0d0019e:	4630      	mov	r0, r6
c0d001a0:	f001 fbca 	bl	c0d01938 <os_sched_last_status>
c0d001a4:	4927      	ldr	r1, [pc, #156]	; (c0d00244 <handleGetPublicKey+0xf8>)
c0d001a6:	6048      	str	r0, [r1, #4]
c0d001a8:	f000 fd78 	bl	c0d00c9c <io_seproxyhal_init_ux>
c0d001ac:	f000 fd78 	bl	c0d00ca0 <io_seproxyhal_init_button>
c0d001b0:	20c2      	movs	r0, #194	; 0xc2
c0d001b2:	9004      	str	r0, [sp, #16]
c0d001b4:	523d      	strh	r5, [r7, r0]
c0d001b6:	4630      	mov	r0, r6
c0d001b8:	f001 fbbe 	bl	c0d01938 <os_sched_last_status>
c0d001bc:	4921      	ldr	r1, [pc, #132]	; (c0d00244 <handleGetPublicKey+0xf8>)
c0d001be:	6048      	str	r0, [r1, #4]
c0d001c0:	4626      	mov	r6, r4
c0d001c2:	5939      	ldr	r1, [r7, r4]
c0d001c4:	9c01      	ldr	r4, [sp, #4]
c0d001c6:	9d0a      	ldr	r5, [sp, #40]	; 0x28
c0d001c8:	2900      	cmp	r1, #0
c0d001ca:	d031      	beq.n	c0d00230 <handleGetPublicKey+0xe4>
c0d001cc:	2800      	cmp	r0, #0
c0d001ce:	d02f      	beq.n	c0d00230 <handleGetPublicKey+0xe4>
c0d001d0:	2897      	cmp	r0, #151	; 0x97
c0d001d2:	d02d      	beq.n	c0d00230 <handleGetPublicKey+0xe4>
c0d001d4:	9804      	ldr	r0, [sp, #16]
c0d001d6:	5a38      	ldrh	r0, [r7, r0]
c0d001d8:	9903      	ldr	r1, [sp, #12]
c0d001da:	5c79      	ldrb	r1, [r7, r1]
c0d001dc:	b280      	uxth	r0, r0
c0d001de:	4288      	cmp	r0, r1
c0d001e0:	d226      	bcs.n	c0d00230 <handleGetPublicKey+0xe4>
c0d001e2:	f001 fb75 	bl	c0d018d0 <io_seph_is_status_sent>
c0d001e6:	2800      	cmp	r0, #0
c0d001e8:	d122      	bne.n	c0d00230 <handleGetPublicKey+0xe4>
c0d001ea:	f001 faf9 	bl	c0d017e0 <os_perso_isonboarded>
c0d001ee:	28aa      	cmp	r0, #170	; 0xaa
c0d001f0:	d103      	bne.n	c0d001fa <handleGetPublicKey+0xae>
c0d001f2:	f001 fb1f 	bl	c0d01834 <os_global_pin_is_validated>
c0d001f6:	28aa      	cmp	r0, #170	; 0xaa
c0d001f8:	d11a      	bne.n	c0d00230 <handleGetPublicKey+0xe4>
c0d001fa:	59b9      	ldr	r1, [r7, r6]
c0d001fc:	9804      	ldr	r0, [sp, #16]
c0d001fe:	5a3a      	ldrh	r2, [r7, r0]
c0d00200:	0150      	lsls	r0, r2, #5
c0d00202:	1808      	adds	r0, r1, r0
c0d00204:	593b      	ldr	r3, [r7, r4]
c0d00206:	2b00      	cmp	r3, #0
c0d00208:	d005      	beq.n	c0d00216 <handleGetPublicKey+0xca>
c0d0020a:	4798      	blx	r3
c0d0020c:	2800      	cmp	r0, #0
c0d0020e:	d008      	beq.n	c0d00222 <handleGetPublicKey+0xd6>
c0d00210:	9904      	ldr	r1, [sp, #16]
c0d00212:	5a7a      	ldrh	r2, [r7, r1]
c0d00214:	59b9      	ldr	r1, [r7, r6]
c0d00216:	2801      	cmp	r0, #1
c0d00218:	d101      	bne.n	c0d0021e <handleGetPublicKey+0xd2>
c0d0021a:	0150      	lsls	r0, r2, #5
c0d0021c:	1808      	adds	r0, r1, r0
c0d0021e:	f000 f86f 	bl	c0d00300 <io_seproxyhal_display>
c0d00222:	9904      	ldr	r1, [sp, #16]
c0d00224:	5a78      	ldrh	r0, [r7, r1]
c0d00226:	1c40      	adds	r0, r0, #1
c0d00228:	5278      	strh	r0, [r7, r1]
c0d0022a:	59b9      	ldr	r1, [r7, r6]
c0d0022c:	2900      	cmp	r1, #0
c0d0022e:	d1d3      	bne.n	c0d001d8 <handleGetPublicKey+0x8c>
    *flags |= IO_ASYNCH_REPLY;
c0d00230:	6828      	ldr	r0, [r5, #0]
c0d00232:	9902      	ldr	r1, [sp, #8]
c0d00234:	4308      	orrs	r0, r1
c0d00236:	6028      	str	r0, [r5, #0]
}
c0d00238:	b005      	add	sp, #20
c0d0023a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0023c:	20000308 	.word	0x20000308
c0d00240:	20000200 	.word	0x20000200
c0d00244:	200003c8 	.word	0x200003c8
c0d00248:	00002fb6 	.word	0x00002fb6
c0d0024c:	00002fb8 	.word	0x00002fb8
c0d00250:	000000df 	.word	0x000000df
c0d00254:	00002fa0 	.word	0x00002fa0

c0d00258 <ui_getPublicKey_approve_button>:
{
c0d00258:	b510      	push	{r4, lr}
c0d0025a:	b094      	sub	sp, #80	; 0x50
c0d0025c:	4910      	ldr	r1, [pc, #64]	; (c0d002a0 <ui_getPublicKey_approve_button+0x48>)
    switch (button_mask)
c0d0025e:	4288      	cmp	r0, r1
c0d00260:	d005      	beq.n	c0d0026e <ui_getPublicKey_approve_button+0x16>
c0d00262:	4910      	ldr	r1, [pc, #64]	; (c0d002a4 <ui_getPublicKey_approve_button+0x4c>)
c0d00264:	4288      	cmp	r0, r1
c0d00266:	d117      	bne.n	c0d00298 <ui_getPublicKey_approve_button+0x40>
c0d00268:	4810      	ldr	r0, [pc, #64]	; (c0d002ac <ui_getPublicKey_approve_button+0x54>)
c0d0026a:	2100      	movs	r1, #0
c0d0026c:	e010      	b.n	c0d00290 <ui_getPublicKey_approve_button+0x38>
c0d0026e:	2000      	movs	r0, #0
c0d00270:	aa01      	add	r2, sp, #4
        deriveArchEthicKeyPair(0, NULL, &publicKey);
c0d00272:	4601      	mov	r1, r0
c0d00274:	f7ff fefe 	bl	c0d00074 <deriveArchEthicKeyPair>
c0d00278:	9c02      	ldr	r4, [sp, #8]
        for (int v = 0; v < publicKey.W_len; v++)
c0d0027a:	2c00      	cmp	r4, #0
c0d0027c:	d005      	beq.n	c0d0028a <ui_getPublicKey_approve_button+0x32>
c0d0027e:	a901      	add	r1, sp, #4
c0d00280:	3108      	adds	r1, #8
            G_io_apdu_buffer[v] = publicKey.W[v];
c0d00282:	4809      	ldr	r0, [pc, #36]	; (c0d002a8 <ui_getPublicKey_approve_button+0x50>)
c0d00284:	4622      	mov	r2, r4
c0d00286:	f002 fee4 	bl	c0d03052 <__aeabi_memcpy>
c0d0028a:	2009      	movs	r0, #9
c0d0028c:	0300      	lsls	r0, r0, #12
        io_exchange_with_code(SW_OK, publicKey.W_len);
c0d0028e:	4621      	mov	r1, r4
c0d00290:	f000 fae2 	bl	c0d00858 <io_exchange_with_code>
c0d00294:	f000 fbd0 	bl	c0d00a38 <ui_idle>
c0d00298:	2000      	movs	r0, #0
    return 0;
c0d0029a:	b014      	add	sp, #80	; 0x50
c0d0029c:	bd10      	pop	{r4, pc}
c0d0029e:	46c0      	nop			; (mov r8, r8)
c0d002a0:	80000002 	.word	0x80000002
c0d002a4:	80000001 	.word	0x80000001
c0d002a8:	20000450 	.word	0x20000450
c0d002ac:	00006985 	.word	0x00006985

c0d002b0 <handleGetVersion>:
#define SW_OK 0x9000

// handleGetVersion is the entry point for the getVersion command. It
// unconditionally sends the app version.
void handleGetVersion(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
c0d002b0:	b5b0      	push	{r4, r5, r7, lr}
c0d002b2:	b082      	sub	sp, #8
	G_io_apdu_buffer[0] = APPVERSION[0] - '0';
c0d002b4:	480e      	ldr	r0, [pc, #56]	; (c0d002f0 <handleGetVersion+0x40>)
c0d002b6:	2101      	movs	r1, #1
	G_io_apdu_buffer[1] = APPVERSION[2] - '0';
	G_io_apdu_buffer[2] = APPVERSION[4] - '0';
c0d002b8:	7081      	strb	r1, [r0, #2]
c0d002ba:	2200      	movs	r2, #0
	G_io_apdu_buffer[1] = APPVERSION[2] - '0';
c0d002bc:	7042      	strb	r2, [r0, #1]
	G_io_apdu_buffer[0] = APPVERSION[0] - '0';
c0d002be:	7001      	strb	r1, [r0, #0]
c0d002c0:	480c      	ldr	r0, [pc, #48]	; (c0d002f4 <handleGetVersion+0x44>)

	// Testing Debug
	uint8_t buffer[4] = {0xDE, 0xAD, 0xBE, 0xEF};
c0d002c2:	9001      	str	r0, [sp, #4]

	// PRINTF(string, array length, array);
	// .*H for uppercase, .*h for lowercase
	PRINTF("What a lovely buffer:\n %.*H \n\n", 4, buffer);
c0d002c4:	480c      	ldr	r0, [pc, #48]	; (c0d002f8 <handleGetVersion+0x48>)
c0d002c6:	4478      	add	r0, pc
c0d002c8:	2404      	movs	r4, #4
c0d002ca:	ad01      	add	r5, sp, #4
c0d002cc:	4621      	mov	r1, r4
c0d002ce:	462a      	mov	r2, r5
c0d002d0:	f001 f89c 	bl	c0d0140c <mcu_usb_printf>
	PRINTF("I prefer it lower-cased:\n %.*h \n", 4, buffer);
c0d002d4:	4809      	ldr	r0, [pc, #36]	; (c0d002fc <handleGetVersion+0x4c>)
c0d002d6:	4478      	add	r0, pc
c0d002d8:	4621      	mov	r1, r4
c0d002da:	462a      	mov	r2, r5
c0d002dc:	f001 f896 	bl	c0d0140c <mcu_usb_printf>
c0d002e0:	2009      	movs	r0, #9
c0d002e2:	0300      	lsls	r0, r0, #12
c0d002e4:	2103      	movs	r1, #3

	io_exchange_with_code(SW_OK, 3);
c0d002e6:	f000 fab7 	bl	c0d00858 <io_exchange_with_code>
c0d002ea:	b002      	add	sp, #8
c0d002ec:	bdb0      	pop	{r4, r5, r7, pc}
c0d002ee:	46c0      	nop			; (mov r8, r8)
c0d002f0:	20000450 	.word	0x20000450
c0d002f4:	efbeadde 	.word	0xefbeadde
c0d002f8:	00002efe 	.word	0x00002efe
c0d002fc:	00002f0d 	.word	0x00002f0d

c0d00300 <io_seproxyhal_display>:
#include "common/buffer.h"
#include "common/write.h"

uint32_t G_output_len = 0;

void io_seproxyhal_display(const bagl_element_t *element) {
c0d00300:	b580      	push	{r7, lr}
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d00302:	f000 fd21 	bl	c0d00d48 <io_seproxyhal_display_default>
}
c0d00306:	bd80      	pop	{r7, pc}

c0d00308 <io_event>:

uint8_t io_event(uint8_t channel __attribute__((unused))) {
c0d00308:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0030a:	b081      	sub	sp, #4
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d0030c:	4df5      	ldr	r5, [pc, #980]	; (c0d006e4 <io_event+0x3dc>)
c0d0030e:	7828      	ldrb	r0, [r5, #0]
c0d00310:	280d      	cmp	r0, #13
c0d00312:	dc05      	bgt.n	c0d00320 <io_event+0x18>
c0d00314:	2805      	cmp	r0, #5
c0d00316:	d100      	bne.n	c0d0031a <io_event+0x12>
c0d00318:	e0ae      	b.n	c0d00478 <io_event+0x170>
c0d0031a:	280d      	cmp	r0, #13
c0d0031c:	d00d      	beq.n	c0d0033a <io_event+0x32>
c0d0031e:	e057      	b.n	c0d003d0 <io_event+0xc8>
c0d00320:	280e      	cmp	r0, #14
c0d00322:	d100      	bne.n	c0d00326 <io_event+0x1e>
c0d00324:	e102      	b.n	c0d0052c <io_event+0x224>
c0d00326:	2815      	cmp	r0, #21
c0d00328:	d152      	bne.n	c0d003d0 <io_event+0xc8>
        case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
            break;
        case SEPROXYHAL_TAG_STATUS_EVENT:
            if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID &&  //
c0d0032a:	48ef      	ldr	r0, [pc, #956]	; (c0d006e8 <io_event+0x3e0>)
c0d0032c:	7980      	ldrb	r0, [r0, #6]
c0d0032e:	2801      	cmp	r0, #1
c0d00330:	d103      	bne.n	c0d0033a <io_event+0x32>
static inline uint16_t U2BE(const uint8_t *buf, size_t off) {
  return (buf[off] << 8) | buf[off + 1];
}
static inline uint32_t U4BE(const uint8_t *buf, size_t off) {
  return (((uint32_t)buf[off]) << 24) | (buf[off + 1] << 16) |
         (buf[off + 2] << 8) | buf[off + 3];
c0d00332:	79a8      	ldrb	r0, [r5, #6]
c0d00334:	0700      	lsls	r0, r0, #28
c0d00336:	d400      	bmi.n	c0d0033a <io_event+0x32>
c0d00338:	e265      	b.n	c0d00806 <io_event+0x4fe>
                  SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
                THROW(EXCEPTION_IO_RESET);
            }
            /* fallthrough */
        case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
            UX_DISPLAYED_EVENT({});
c0d0033a:	4cec      	ldr	r4, [pc, #944]	; (c0d006ec <io_event+0x3e4>)
c0d0033c:	2700      	movs	r7, #0
c0d0033e:	6067      	str	r7, [r4, #4]
c0d00340:	2001      	movs	r0, #1
c0d00342:	7020      	strb	r0, [r4, #0]
c0d00344:	4620      	mov	r0, r4
c0d00346:	f001 fa83 	bl	c0d01850 <os_ux>
c0d0034a:	2004      	movs	r0, #4
c0d0034c:	f001 faf4 	bl	c0d01938 <os_sched_last_status>
c0d00350:	6060      	str	r0, [r4, #4]
c0d00352:	2800      	cmp	r0, #0
c0d00354:	d100      	bne.n	c0d00358 <io_event+0x50>
c0d00356:	e24d      	b.n	c0d007f4 <io_event+0x4ec>
c0d00358:	2869      	cmp	r0, #105	; 0x69
c0d0035a:	d100      	bne.n	c0d0035e <io_event+0x56>
c0d0035c:	e1ca      	b.n	c0d006f4 <io_event+0x3ec>
c0d0035e:	2897      	cmp	r0, #151	; 0x97
c0d00360:	d100      	bne.n	c0d00364 <io_event+0x5c>
c0d00362:	e247      	b.n	c0d007f4 <io_event+0x4ec>
c0d00364:	25c4      	movs	r5, #196	; 0xc4
c0d00366:	4ce2      	ldr	r4, [pc, #904]	; (c0d006f0 <io_event+0x3e8>)
c0d00368:	5960      	ldr	r0, [r4, r5]
c0d0036a:	2800      	cmp	r0, #0
c0d0036c:	d100      	bne.n	c0d00370 <io_event+0x68>
c0d0036e:	e239      	b.n	c0d007e4 <io_event+0x4dc>
c0d00370:	26c2      	movs	r6, #194	; 0xc2
c0d00372:	5ba0      	ldrh	r0, [r4, r6]
c0d00374:	21c8      	movs	r1, #200	; 0xc8
c0d00376:	5c61      	ldrb	r1, [r4, r1]
c0d00378:	b280      	uxth	r0, r0
c0d0037a:	4288      	cmp	r0, r1
c0d0037c:	d300      	bcc.n	c0d00380 <io_event+0x78>
c0d0037e:	e231      	b.n	c0d007e4 <io_event+0x4dc>
c0d00380:	f001 faa6 	bl	c0d018d0 <io_seph_is_status_sent>
c0d00384:	2800      	cmp	r0, #0
c0d00386:	d000      	beq.n	c0d0038a <io_event+0x82>
c0d00388:	e22c      	b.n	c0d007e4 <io_event+0x4dc>
c0d0038a:	f001 fa29 	bl	c0d017e0 <os_perso_isonboarded>
c0d0038e:	28aa      	cmp	r0, #170	; 0xaa
c0d00390:	d104      	bne.n	c0d0039c <io_event+0x94>
c0d00392:	f001 fa4f 	bl	c0d01834 <os_global_pin_is_validated>
c0d00396:	28aa      	cmp	r0, #170	; 0xaa
c0d00398:	d000      	beq.n	c0d0039c <io_event+0x94>
c0d0039a:	e223      	b.n	c0d007e4 <io_event+0x4dc>
c0d0039c:	5961      	ldr	r1, [r4, r5]
c0d0039e:	5ba2      	ldrh	r2, [r4, r6]
c0d003a0:	0150      	lsls	r0, r2, #5
c0d003a2:	1808      	adds	r0, r1, r0
c0d003a4:	23d0      	movs	r3, #208	; 0xd0
c0d003a6:	58e3      	ldr	r3, [r4, r3]
c0d003a8:	2b00      	cmp	r3, #0
c0d003aa:	d004      	beq.n	c0d003b6 <io_event+0xae>
c0d003ac:	4798      	blx	r3
c0d003ae:	2800      	cmp	r0, #0
c0d003b0:	d007      	beq.n	c0d003c2 <io_event+0xba>
c0d003b2:	5ba2      	ldrh	r2, [r4, r6]
c0d003b4:	5961      	ldr	r1, [r4, r5]
c0d003b6:	2801      	cmp	r0, #1
c0d003b8:	d101      	bne.n	c0d003be <io_event+0xb6>
c0d003ba:	0150      	lsls	r0, r2, #5
c0d003bc:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d003be:	f000 fcc3 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_DISPLAYED_EVENT({});
c0d003c2:	5ba0      	ldrh	r0, [r4, r6]
c0d003c4:	1c40      	adds	r0, r0, #1
c0d003c6:	53a0      	strh	r0, [r4, r6]
c0d003c8:	5961      	ldr	r1, [r4, r5]
c0d003ca:	2900      	cmp	r1, #0
c0d003cc:	d1d2      	bne.n	c0d00374 <io_event+0x6c>
c0d003ce:	e209      	b.n	c0d007e4 <io_event+0x4dc>
            break;
        case SEPROXYHAL_TAG_TICKER_EVENT:
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {});
            break;
        default:
            UX_DEFAULT_EVENT();
c0d003d0:	4cc6      	ldr	r4, [pc, #792]	; (c0d006ec <io_event+0x3e4>)
c0d003d2:	2700      	movs	r7, #0
c0d003d4:	6067      	str	r7, [r4, #4]
c0d003d6:	2001      	movs	r0, #1
c0d003d8:	7020      	strb	r0, [r4, #0]
c0d003da:	4620      	mov	r0, r4
c0d003dc:	f001 fa38 	bl	c0d01850 <os_ux>
c0d003e0:	2004      	movs	r0, #4
c0d003e2:	f001 faa9 	bl	c0d01938 <os_sched_last_status>
c0d003e6:	6060      	str	r0, [r4, #4]
c0d003e8:	2869      	cmp	r0, #105	; 0x69
c0d003ea:	d000      	beq.n	c0d003ee <io_event+0xe6>
c0d003ec:	e0f2      	b.n	c0d005d4 <io_event+0x2cc>
c0d003ee:	f000 fc55 	bl	c0d00c9c <io_seproxyhal_init_ux>
c0d003f2:	f000 fc55 	bl	c0d00ca0 <io_seproxyhal_init_button>
c0d003f6:	25c2      	movs	r5, #194	; 0xc2
c0d003f8:	4ebd      	ldr	r6, [pc, #756]	; (c0d006f0 <io_event+0x3e8>)
c0d003fa:	5377      	strh	r7, [r6, r5]
c0d003fc:	2004      	movs	r0, #4
c0d003fe:	f001 fa9b 	bl	c0d01938 <os_sched_last_status>
c0d00402:	6060      	str	r0, [r4, #4]
c0d00404:	24c4      	movs	r4, #196	; 0xc4
c0d00406:	5931      	ldr	r1, [r6, r4]
c0d00408:	2900      	cmp	r1, #0
c0d0040a:	d100      	bne.n	c0d0040e <io_event+0x106>
c0d0040c:	e1f2      	b.n	c0d007f4 <io_event+0x4ec>
c0d0040e:	2800      	cmp	r0, #0
c0d00410:	d100      	bne.n	c0d00414 <io_event+0x10c>
c0d00412:	e1ef      	b.n	c0d007f4 <io_event+0x4ec>
c0d00414:	2897      	cmp	r0, #151	; 0x97
c0d00416:	d100      	bne.n	c0d0041a <io_event+0x112>
c0d00418:	e1ec      	b.n	c0d007f4 <io_event+0x4ec>
c0d0041a:	5b70      	ldrh	r0, [r6, r5]
c0d0041c:	21c8      	movs	r1, #200	; 0xc8
c0d0041e:	5c71      	ldrb	r1, [r6, r1]
c0d00420:	b280      	uxth	r0, r0
c0d00422:	4288      	cmp	r0, r1
c0d00424:	d300      	bcc.n	c0d00428 <io_event+0x120>
c0d00426:	e1e5      	b.n	c0d007f4 <io_event+0x4ec>
c0d00428:	f001 fa52 	bl	c0d018d0 <io_seph_is_status_sent>
c0d0042c:	2800      	cmp	r0, #0
c0d0042e:	d000      	beq.n	c0d00432 <io_event+0x12a>
c0d00430:	e1e0      	b.n	c0d007f4 <io_event+0x4ec>
c0d00432:	f001 f9d5 	bl	c0d017e0 <os_perso_isonboarded>
c0d00436:	28aa      	cmp	r0, #170	; 0xaa
c0d00438:	d104      	bne.n	c0d00444 <io_event+0x13c>
c0d0043a:	f001 f9fb 	bl	c0d01834 <os_global_pin_is_validated>
c0d0043e:	28aa      	cmp	r0, #170	; 0xaa
c0d00440:	d000      	beq.n	c0d00444 <io_event+0x13c>
c0d00442:	e1d7      	b.n	c0d007f4 <io_event+0x4ec>
c0d00444:	5931      	ldr	r1, [r6, r4]
c0d00446:	5b72      	ldrh	r2, [r6, r5]
c0d00448:	0150      	lsls	r0, r2, #5
c0d0044a:	1808      	adds	r0, r1, r0
c0d0044c:	23d0      	movs	r3, #208	; 0xd0
c0d0044e:	58f3      	ldr	r3, [r6, r3]
c0d00450:	2b00      	cmp	r3, #0
c0d00452:	d004      	beq.n	c0d0045e <io_event+0x156>
c0d00454:	4798      	blx	r3
c0d00456:	2800      	cmp	r0, #0
c0d00458:	d007      	beq.n	c0d0046a <io_event+0x162>
c0d0045a:	5b72      	ldrh	r2, [r6, r5]
c0d0045c:	5931      	ldr	r1, [r6, r4]
c0d0045e:	2801      	cmp	r0, #1
c0d00460:	d101      	bne.n	c0d00466 <io_event+0x15e>
c0d00462:	0150      	lsls	r0, r2, #5
c0d00464:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d00466:	f000 fc6f 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_DEFAULT_EVENT();
c0d0046a:	5b70      	ldrh	r0, [r6, r5]
c0d0046c:	1c40      	adds	r0, r0, #1
c0d0046e:	5370      	strh	r0, [r6, r5]
c0d00470:	5931      	ldr	r1, [r6, r4]
c0d00472:	2900      	cmp	r1, #0
c0d00474:	d1d2      	bne.n	c0d0041c <io_event+0x114>
c0d00476:	e1bd      	b.n	c0d007f4 <io_event+0x4ec>
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00478:	4ce4      	ldr	r4, [pc, #912]	; (c0d0080c <io_event+0x504>)
c0d0047a:	2700      	movs	r7, #0
c0d0047c:	6067      	str	r7, [r4, #4]
c0d0047e:	2001      	movs	r0, #1
c0d00480:	7020      	strb	r0, [r4, #0]
c0d00482:	4620      	mov	r0, r4
c0d00484:	f001 f9e4 	bl	c0d01850 <os_ux>
c0d00488:	2004      	movs	r0, #4
c0d0048a:	f001 fa55 	bl	c0d01938 <os_sched_last_status>
c0d0048e:	6060      	str	r0, [r4, #4]
c0d00490:	2800      	cmp	r0, #0
c0d00492:	d100      	bne.n	c0d00496 <io_event+0x18e>
c0d00494:	e1ae      	b.n	c0d007f4 <io_event+0x4ec>
c0d00496:	2897      	cmp	r0, #151	; 0x97
c0d00498:	d100      	bne.n	c0d0049c <io_event+0x194>
c0d0049a:	e1ab      	b.n	c0d007f4 <io_event+0x4ec>
c0d0049c:	2869      	cmp	r0, #105	; 0x69
c0d0049e:	d000      	beq.n	c0d004a2 <io_event+0x19a>
c0d004a0:	e167      	b.n	c0d00772 <io_event+0x46a>
c0d004a2:	f000 fbfb 	bl	c0d00c9c <io_seproxyhal_init_ux>
c0d004a6:	f000 fbfb 	bl	c0d00ca0 <io_seproxyhal_init_button>
c0d004aa:	25c2      	movs	r5, #194	; 0xc2
c0d004ac:	4ed8      	ldr	r6, [pc, #864]	; (c0d00810 <io_event+0x508>)
c0d004ae:	5377      	strh	r7, [r6, r5]
c0d004b0:	2004      	movs	r0, #4
c0d004b2:	f001 fa41 	bl	c0d01938 <os_sched_last_status>
c0d004b6:	6060      	str	r0, [r4, #4]
c0d004b8:	24c4      	movs	r4, #196	; 0xc4
c0d004ba:	5931      	ldr	r1, [r6, r4]
c0d004bc:	2900      	cmp	r1, #0
c0d004be:	d100      	bne.n	c0d004c2 <io_event+0x1ba>
c0d004c0:	e198      	b.n	c0d007f4 <io_event+0x4ec>
c0d004c2:	2800      	cmp	r0, #0
c0d004c4:	d100      	bne.n	c0d004c8 <io_event+0x1c0>
c0d004c6:	e195      	b.n	c0d007f4 <io_event+0x4ec>
c0d004c8:	2897      	cmp	r0, #151	; 0x97
c0d004ca:	d100      	bne.n	c0d004ce <io_event+0x1c6>
c0d004cc:	e192      	b.n	c0d007f4 <io_event+0x4ec>
c0d004ce:	5b70      	ldrh	r0, [r6, r5]
c0d004d0:	21c8      	movs	r1, #200	; 0xc8
c0d004d2:	5c71      	ldrb	r1, [r6, r1]
c0d004d4:	b280      	uxth	r0, r0
c0d004d6:	4288      	cmp	r0, r1
c0d004d8:	d300      	bcc.n	c0d004dc <io_event+0x1d4>
c0d004da:	e18b      	b.n	c0d007f4 <io_event+0x4ec>
c0d004dc:	f001 f9f8 	bl	c0d018d0 <io_seph_is_status_sent>
c0d004e0:	2800      	cmp	r0, #0
c0d004e2:	d000      	beq.n	c0d004e6 <io_event+0x1de>
c0d004e4:	e186      	b.n	c0d007f4 <io_event+0x4ec>
c0d004e6:	f001 f97b 	bl	c0d017e0 <os_perso_isonboarded>
c0d004ea:	28aa      	cmp	r0, #170	; 0xaa
c0d004ec:	d104      	bne.n	c0d004f8 <io_event+0x1f0>
c0d004ee:	f001 f9a1 	bl	c0d01834 <os_global_pin_is_validated>
c0d004f2:	28aa      	cmp	r0, #170	; 0xaa
c0d004f4:	d000      	beq.n	c0d004f8 <io_event+0x1f0>
c0d004f6:	e17d      	b.n	c0d007f4 <io_event+0x4ec>
c0d004f8:	5931      	ldr	r1, [r6, r4]
c0d004fa:	5b72      	ldrh	r2, [r6, r5]
c0d004fc:	0150      	lsls	r0, r2, #5
c0d004fe:	1808      	adds	r0, r1, r0
c0d00500:	23d0      	movs	r3, #208	; 0xd0
c0d00502:	58f3      	ldr	r3, [r6, r3]
c0d00504:	2b00      	cmp	r3, #0
c0d00506:	d004      	beq.n	c0d00512 <io_event+0x20a>
c0d00508:	4798      	blx	r3
c0d0050a:	2800      	cmp	r0, #0
c0d0050c:	d007      	beq.n	c0d0051e <io_event+0x216>
c0d0050e:	5b72      	ldrh	r2, [r6, r5]
c0d00510:	5931      	ldr	r1, [r6, r4]
c0d00512:	2801      	cmp	r0, #1
c0d00514:	d101      	bne.n	c0d0051a <io_event+0x212>
c0d00516:	0150      	lsls	r0, r2, #5
c0d00518:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d0051a:	f000 fc15 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0051e:	5b70      	ldrh	r0, [r6, r5]
c0d00520:	1c40      	adds	r0, r0, #1
c0d00522:	5370      	strh	r0, [r6, r5]
c0d00524:	5931      	ldr	r1, [r6, r4]
c0d00526:	2900      	cmp	r1, #0
c0d00528:	d1d2      	bne.n	c0d004d0 <io_event+0x1c8>
c0d0052a:	e163      	b.n	c0d007f4 <io_event+0x4ec>
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {});
c0d0052c:	4db7      	ldr	r5, [pc, #732]	; (c0d0080c <io_event+0x504>)
c0d0052e:	2600      	movs	r6, #0
c0d00530:	606e      	str	r6, [r5, #4]
c0d00532:	2001      	movs	r0, #1
c0d00534:	7028      	strb	r0, [r5, #0]
c0d00536:	4628      	mov	r0, r5
c0d00538:	f001 f98a 	bl	c0d01850 <os_ux>
c0d0053c:	2004      	movs	r0, #4
c0d0053e:	f001 f9fb 	bl	c0d01938 <os_sched_last_status>
c0d00542:	6068      	str	r0, [r5, #4]
c0d00544:	2869      	cmp	r0, #105	; 0x69
c0d00546:	d17b      	bne.n	c0d00640 <io_event+0x338>
c0d00548:	f000 fba8 	bl	c0d00c9c <io_seproxyhal_init_ux>
c0d0054c:	f000 fba8 	bl	c0d00ca0 <io_seproxyhal_init_button>
c0d00550:	24c2      	movs	r4, #194	; 0xc2
c0d00552:	4eaf      	ldr	r6, [pc, #700]	; (c0d00810 <io_event+0x508>)
c0d00554:	2000      	movs	r0, #0
c0d00556:	5330      	strh	r0, [r6, r4]
c0d00558:	2004      	movs	r0, #4
c0d0055a:	f001 f9ed 	bl	c0d01938 <os_sched_last_status>
c0d0055e:	6068      	str	r0, [r5, #4]
c0d00560:	25c4      	movs	r5, #196	; 0xc4
c0d00562:	5971      	ldr	r1, [r6, r5]
c0d00564:	2900      	cmp	r1, #0
c0d00566:	d100      	bne.n	c0d0056a <io_event+0x262>
c0d00568:	e144      	b.n	c0d007f4 <io_event+0x4ec>
c0d0056a:	2800      	cmp	r0, #0
c0d0056c:	d100      	bne.n	c0d00570 <io_event+0x268>
c0d0056e:	e141      	b.n	c0d007f4 <io_event+0x4ec>
c0d00570:	2897      	cmp	r0, #151	; 0x97
c0d00572:	d100      	bne.n	c0d00576 <io_event+0x26e>
c0d00574:	e13e      	b.n	c0d007f4 <io_event+0x4ec>
c0d00576:	5b30      	ldrh	r0, [r6, r4]
c0d00578:	21c8      	movs	r1, #200	; 0xc8
c0d0057a:	5c71      	ldrb	r1, [r6, r1]
c0d0057c:	b280      	uxth	r0, r0
c0d0057e:	4288      	cmp	r0, r1
c0d00580:	d300      	bcc.n	c0d00584 <io_event+0x27c>
c0d00582:	e137      	b.n	c0d007f4 <io_event+0x4ec>
c0d00584:	f001 f9a4 	bl	c0d018d0 <io_seph_is_status_sent>
c0d00588:	2800      	cmp	r0, #0
c0d0058a:	d000      	beq.n	c0d0058e <io_event+0x286>
c0d0058c:	e132      	b.n	c0d007f4 <io_event+0x4ec>
c0d0058e:	f001 f927 	bl	c0d017e0 <os_perso_isonboarded>
c0d00592:	28aa      	cmp	r0, #170	; 0xaa
c0d00594:	d104      	bne.n	c0d005a0 <io_event+0x298>
c0d00596:	f001 f94d 	bl	c0d01834 <os_global_pin_is_validated>
c0d0059a:	28aa      	cmp	r0, #170	; 0xaa
c0d0059c:	d000      	beq.n	c0d005a0 <io_event+0x298>
c0d0059e:	e129      	b.n	c0d007f4 <io_event+0x4ec>
c0d005a0:	5971      	ldr	r1, [r6, r5]
c0d005a2:	5b32      	ldrh	r2, [r6, r4]
c0d005a4:	0150      	lsls	r0, r2, #5
c0d005a6:	1808      	adds	r0, r1, r0
c0d005a8:	23d0      	movs	r3, #208	; 0xd0
c0d005aa:	58f3      	ldr	r3, [r6, r3]
c0d005ac:	2b00      	cmp	r3, #0
c0d005ae:	d004      	beq.n	c0d005ba <io_event+0x2b2>
c0d005b0:	4798      	blx	r3
c0d005b2:	2800      	cmp	r0, #0
c0d005b4:	d007      	beq.n	c0d005c6 <io_event+0x2be>
c0d005b6:	5b32      	ldrh	r2, [r6, r4]
c0d005b8:	5971      	ldr	r1, [r6, r5]
c0d005ba:	2801      	cmp	r0, #1
c0d005bc:	d101      	bne.n	c0d005c2 <io_event+0x2ba>
c0d005be:	0150      	lsls	r0, r2, #5
c0d005c0:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d005c2:	f000 fbc1 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {});
c0d005c6:	5b30      	ldrh	r0, [r6, r4]
c0d005c8:	1c40      	adds	r0, r0, #1
c0d005ca:	5330      	strh	r0, [r6, r4]
c0d005cc:	5971      	ldr	r1, [r6, r5]
c0d005ce:	2900      	cmp	r1, #0
c0d005d0:	d1d2      	bne.n	c0d00578 <io_event+0x270>
c0d005d2:	e10f      	b.n	c0d007f4 <io_event+0x4ec>
c0d005d4:	25c4      	movs	r5, #196	; 0xc4
            UX_DEFAULT_EVENT();
c0d005d6:	4c8e      	ldr	r4, [pc, #568]	; (c0d00810 <io_event+0x508>)
c0d005d8:	5960      	ldr	r0, [r4, r5]
c0d005da:	2800      	cmp	r0, #0
c0d005dc:	d100      	bne.n	c0d005e0 <io_event+0x2d8>
c0d005de:	e101      	b.n	c0d007e4 <io_event+0x4dc>
c0d005e0:	26c2      	movs	r6, #194	; 0xc2
c0d005e2:	5ba0      	ldrh	r0, [r4, r6]
c0d005e4:	21c8      	movs	r1, #200	; 0xc8
c0d005e6:	5c61      	ldrb	r1, [r4, r1]
c0d005e8:	b280      	uxth	r0, r0
c0d005ea:	4288      	cmp	r0, r1
c0d005ec:	d300      	bcc.n	c0d005f0 <io_event+0x2e8>
c0d005ee:	e0f9      	b.n	c0d007e4 <io_event+0x4dc>
c0d005f0:	f001 f96e 	bl	c0d018d0 <io_seph_is_status_sent>
c0d005f4:	2800      	cmp	r0, #0
c0d005f6:	d000      	beq.n	c0d005fa <io_event+0x2f2>
c0d005f8:	e0f4      	b.n	c0d007e4 <io_event+0x4dc>
c0d005fa:	f001 f8f1 	bl	c0d017e0 <os_perso_isonboarded>
c0d005fe:	28aa      	cmp	r0, #170	; 0xaa
c0d00600:	d104      	bne.n	c0d0060c <io_event+0x304>
c0d00602:	f001 f917 	bl	c0d01834 <os_global_pin_is_validated>
c0d00606:	28aa      	cmp	r0, #170	; 0xaa
c0d00608:	d000      	beq.n	c0d0060c <io_event+0x304>
c0d0060a:	e0eb      	b.n	c0d007e4 <io_event+0x4dc>
c0d0060c:	5961      	ldr	r1, [r4, r5]
c0d0060e:	5ba2      	ldrh	r2, [r4, r6]
c0d00610:	0150      	lsls	r0, r2, #5
c0d00612:	1808      	adds	r0, r1, r0
c0d00614:	23d0      	movs	r3, #208	; 0xd0
c0d00616:	58e3      	ldr	r3, [r4, r3]
c0d00618:	2b00      	cmp	r3, #0
c0d0061a:	d004      	beq.n	c0d00626 <io_event+0x31e>
c0d0061c:	4798      	blx	r3
c0d0061e:	2800      	cmp	r0, #0
c0d00620:	d007      	beq.n	c0d00632 <io_event+0x32a>
c0d00622:	5ba2      	ldrh	r2, [r4, r6]
c0d00624:	5961      	ldr	r1, [r4, r5]
c0d00626:	2801      	cmp	r0, #1
c0d00628:	d101      	bne.n	c0d0062e <io_event+0x326>
c0d0062a:	0150      	lsls	r0, r2, #5
c0d0062c:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d0062e:	f000 fb8b 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_DEFAULT_EVENT();
c0d00632:	5ba0      	ldrh	r0, [r4, r6]
c0d00634:	1c40      	adds	r0, r0, #1
c0d00636:	53a0      	strh	r0, [r4, r6]
c0d00638:	5961      	ldr	r1, [r4, r5]
c0d0063a:	2900      	cmp	r1, #0
c0d0063c:	d1d2      	bne.n	c0d005e4 <io_event+0x2dc>
c0d0063e:	e0d1      	b.n	c0d007e4 <io_event+0x4dc>
c0d00640:	4604      	mov	r4, r0
c0d00642:	20dc      	movs	r0, #220	; 0xdc
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {});
c0d00644:	4d72      	ldr	r5, [pc, #456]	; (c0d00810 <io_event+0x508>)
c0d00646:	5829      	ldr	r1, [r5, r0]
c0d00648:	2900      	cmp	r1, #0
c0d0064a:	d00f      	beq.n	c0d0066c <io_event+0x364>
c0d0064c:	460a      	mov	r2, r1
c0d0064e:	3a64      	subs	r2, #100	; 0x64
c0d00650:	d200      	bcs.n	c0d00654 <io_event+0x34c>
c0d00652:	4632      	mov	r2, r6
c0d00654:	502a      	str	r2, [r5, r0]
c0d00656:	2964      	cmp	r1, #100	; 0x64
c0d00658:	d808      	bhi.n	c0d0066c <io_event+0x364>
c0d0065a:	21d8      	movs	r1, #216	; 0xd8
c0d0065c:	5869      	ldr	r1, [r5, r1]
c0d0065e:	2900      	cmp	r1, #0
c0d00660:	d004      	beq.n	c0d0066c <io_event+0x364>
c0d00662:	22e0      	movs	r2, #224	; 0xe0
c0d00664:	58aa      	ldr	r2, [r5, r2]
c0d00666:	502a      	str	r2, [r5, r0]
c0d00668:	2000      	movs	r0, #0
c0d0066a:	4788      	blx	r1
c0d0066c:	2c00      	cmp	r4, #0
c0d0066e:	d100      	bne.n	c0d00672 <io_event+0x36a>
c0d00670:	e0c0      	b.n	c0d007f4 <io_event+0x4ec>
c0d00672:	2c97      	cmp	r4, #151	; 0x97
c0d00674:	d100      	bne.n	c0d00678 <io_event+0x370>
c0d00676:	e0bd      	b.n	c0d007f4 <io_event+0x4ec>
c0d00678:	24c4      	movs	r4, #196	; 0xc4
c0d0067a:	5928      	ldr	r0, [r5, r4]
c0d0067c:	2800      	cmp	r0, #0
c0d0067e:	d02b      	beq.n	c0d006d8 <io_event+0x3d0>
c0d00680:	26c2      	movs	r6, #194	; 0xc2
c0d00682:	5ba8      	ldrh	r0, [r5, r6]
c0d00684:	21c8      	movs	r1, #200	; 0xc8
c0d00686:	5c69      	ldrb	r1, [r5, r1]
c0d00688:	b280      	uxth	r0, r0
c0d0068a:	4288      	cmp	r0, r1
c0d0068c:	d224      	bcs.n	c0d006d8 <io_event+0x3d0>
c0d0068e:	f001 f91f 	bl	c0d018d0 <io_seph_is_status_sent>
c0d00692:	2800      	cmp	r0, #0
c0d00694:	d120      	bne.n	c0d006d8 <io_event+0x3d0>
c0d00696:	f001 f8a3 	bl	c0d017e0 <os_perso_isonboarded>
c0d0069a:	28aa      	cmp	r0, #170	; 0xaa
c0d0069c:	d103      	bne.n	c0d006a6 <io_event+0x39e>
c0d0069e:	f001 f8c9 	bl	c0d01834 <os_global_pin_is_validated>
c0d006a2:	28aa      	cmp	r0, #170	; 0xaa
c0d006a4:	d118      	bne.n	c0d006d8 <io_event+0x3d0>
c0d006a6:	5929      	ldr	r1, [r5, r4]
c0d006a8:	5baa      	ldrh	r2, [r5, r6]
c0d006aa:	0150      	lsls	r0, r2, #5
c0d006ac:	1808      	adds	r0, r1, r0
c0d006ae:	23d0      	movs	r3, #208	; 0xd0
c0d006b0:	58eb      	ldr	r3, [r5, r3]
c0d006b2:	2b00      	cmp	r3, #0
c0d006b4:	d004      	beq.n	c0d006c0 <io_event+0x3b8>
c0d006b6:	4798      	blx	r3
c0d006b8:	2800      	cmp	r0, #0
c0d006ba:	d007      	beq.n	c0d006cc <io_event+0x3c4>
c0d006bc:	5baa      	ldrh	r2, [r5, r6]
c0d006be:	5929      	ldr	r1, [r5, r4]
c0d006c0:	2801      	cmp	r0, #1
c0d006c2:	d101      	bne.n	c0d006c8 <io_event+0x3c0>
c0d006c4:	0150      	lsls	r0, r2, #5
c0d006c6:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d006c8:	f000 fb3e 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_TICKER_EVENT(G_io_seproxyhal_spi_buffer, {});
c0d006cc:	5ba8      	ldrh	r0, [r5, r6]
c0d006ce:	1c40      	adds	r0, r0, #1
c0d006d0:	53a8      	strh	r0, [r5, r6]
c0d006d2:	5929      	ldr	r1, [r5, r4]
c0d006d4:	2900      	cmp	r1, #0
c0d006d6:	d1d5      	bne.n	c0d00684 <io_event+0x37c>
c0d006d8:	20c8      	movs	r0, #200	; 0xc8
c0d006da:	5c28      	ldrb	r0, [r5, r0]
c0d006dc:	21c2      	movs	r1, #194	; 0xc2
c0d006de:	5a69      	ldrh	r1, [r5, r1]
c0d006e0:	e084      	b.n	c0d007ec <io_event+0x4e4>
c0d006e2:	46c0      	nop			; (mov r8, r8)
c0d006e4:	200003d0 	.word	0x200003d0
c0d006e8:	20000554 	.word	0x20000554
c0d006ec:	200003c8 	.word	0x200003c8
c0d006f0:	20000200 	.word	0x20000200
            UX_DISPLAYED_EVENT({});
c0d006f4:	f000 fad2 	bl	c0d00c9c <io_seproxyhal_init_ux>
c0d006f8:	f000 fad2 	bl	c0d00ca0 <io_seproxyhal_init_button>
c0d006fc:	25c2      	movs	r5, #194	; 0xc2
c0d006fe:	4e44      	ldr	r6, [pc, #272]	; (c0d00810 <io_event+0x508>)
c0d00700:	5377      	strh	r7, [r6, r5]
c0d00702:	2004      	movs	r0, #4
c0d00704:	f001 f918 	bl	c0d01938 <os_sched_last_status>
c0d00708:	6060      	str	r0, [r4, #4]
c0d0070a:	24c4      	movs	r4, #196	; 0xc4
c0d0070c:	5931      	ldr	r1, [r6, r4]
c0d0070e:	2900      	cmp	r1, #0
c0d00710:	d070      	beq.n	c0d007f4 <io_event+0x4ec>
c0d00712:	2800      	cmp	r0, #0
c0d00714:	d06e      	beq.n	c0d007f4 <io_event+0x4ec>
c0d00716:	2897      	cmp	r0, #151	; 0x97
c0d00718:	d06c      	beq.n	c0d007f4 <io_event+0x4ec>
c0d0071a:	5b70      	ldrh	r0, [r6, r5]
c0d0071c:	21c8      	movs	r1, #200	; 0xc8
c0d0071e:	5c71      	ldrb	r1, [r6, r1]
c0d00720:	b280      	uxth	r0, r0
c0d00722:	4288      	cmp	r0, r1
c0d00724:	d266      	bcs.n	c0d007f4 <io_event+0x4ec>
c0d00726:	f001 f8d3 	bl	c0d018d0 <io_seph_is_status_sent>
c0d0072a:	2800      	cmp	r0, #0
c0d0072c:	d162      	bne.n	c0d007f4 <io_event+0x4ec>
c0d0072e:	f001 f857 	bl	c0d017e0 <os_perso_isonboarded>
c0d00732:	28aa      	cmp	r0, #170	; 0xaa
c0d00734:	d103      	bne.n	c0d0073e <io_event+0x436>
c0d00736:	f001 f87d 	bl	c0d01834 <os_global_pin_is_validated>
c0d0073a:	28aa      	cmp	r0, #170	; 0xaa
c0d0073c:	d15a      	bne.n	c0d007f4 <io_event+0x4ec>
c0d0073e:	5931      	ldr	r1, [r6, r4]
c0d00740:	5b72      	ldrh	r2, [r6, r5]
c0d00742:	0150      	lsls	r0, r2, #5
c0d00744:	1808      	adds	r0, r1, r0
c0d00746:	23d0      	movs	r3, #208	; 0xd0
c0d00748:	58f3      	ldr	r3, [r6, r3]
c0d0074a:	2b00      	cmp	r3, #0
c0d0074c:	d004      	beq.n	c0d00758 <io_event+0x450>
c0d0074e:	4798      	blx	r3
c0d00750:	2800      	cmp	r0, #0
c0d00752:	d007      	beq.n	c0d00764 <io_event+0x45c>
c0d00754:	5b72      	ldrh	r2, [r6, r5]
c0d00756:	5931      	ldr	r1, [r6, r4]
c0d00758:	2801      	cmp	r0, #1
c0d0075a:	d101      	bne.n	c0d00760 <io_event+0x458>
c0d0075c:	0150      	lsls	r0, r2, #5
c0d0075e:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d00760:	f000 faf2 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_DISPLAYED_EVENT({});
c0d00764:	5b70      	ldrh	r0, [r6, r5]
c0d00766:	1c40      	adds	r0, r0, #1
c0d00768:	5370      	strh	r0, [r6, r5]
c0d0076a:	5931      	ldr	r1, [r6, r4]
c0d0076c:	2900      	cmp	r1, #0
c0d0076e:	d1d5      	bne.n	c0d0071c <io_event+0x414>
c0d00770:	e040      	b.n	c0d007f4 <io_event+0x4ec>
c0d00772:	20d4      	movs	r0, #212	; 0xd4
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00774:	4c26      	ldr	r4, [pc, #152]	; (c0d00810 <io_event+0x508>)
c0d00776:	5820      	ldr	r0, [r4, r0]
c0d00778:	2800      	cmp	r0, #0
c0d0077a:	d003      	beq.n	c0d00784 <io_event+0x47c>
c0d0077c:	78e9      	ldrb	r1, [r5, #3]
c0d0077e:	0849      	lsrs	r1, r1, #1
c0d00780:	f000 fb26 	bl	c0d00dd0 <io_seproxyhal_button_push>
c0d00784:	25c4      	movs	r5, #196	; 0xc4
c0d00786:	5960      	ldr	r0, [r4, r5]
c0d00788:	2800      	cmp	r0, #0
c0d0078a:	d02b      	beq.n	c0d007e4 <io_event+0x4dc>
c0d0078c:	26c2      	movs	r6, #194	; 0xc2
c0d0078e:	5ba0      	ldrh	r0, [r4, r6]
c0d00790:	21c8      	movs	r1, #200	; 0xc8
c0d00792:	5c61      	ldrb	r1, [r4, r1]
c0d00794:	b280      	uxth	r0, r0
c0d00796:	4288      	cmp	r0, r1
c0d00798:	d224      	bcs.n	c0d007e4 <io_event+0x4dc>
c0d0079a:	f001 f899 	bl	c0d018d0 <io_seph_is_status_sent>
c0d0079e:	2800      	cmp	r0, #0
c0d007a0:	d120      	bne.n	c0d007e4 <io_event+0x4dc>
c0d007a2:	f001 f81d 	bl	c0d017e0 <os_perso_isonboarded>
c0d007a6:	28aa      	cmp	r0, #170	; 0xaa
c0d007a8:	d103      	bne.n	c0d007b2 <io_event+0x4aa>
c0d007aa:	f001 f843 	bl	c0d01834 <os_global_pin_is_validated>
c0d007ae:	28aa      	cmp	r0, #170	; 0xaa
c0d007b0:	d118      	bne.n	c0d007e4 <io_event+0x4dc>
c0d007b2:	5961      	ldr	r1, [r4, r5]
c0d007b4:	5ba2      	ldrh	r2, [r4, r6]
c0d007b6:	0150      	lsls	r0, r2, #5
c0d007b8:	1808      	adds	r0, r1, r0
c0d007ba:	23d0      	movs	r3, #208	; 0xd0
c0d007bc:	58e3      	ldr	r3, [r4, r3]
c0d007be:	2b00      	cmp	r3, #0
c0d007c0:	d004      	beq.n	c0d007cc <io_event+0x4c4>
c0d007c2:	4798      	blx	r3
c0d007c4:	2800      	cmp	r0, #0
c0d007c6:	d007      	beq.n	c0d007d8 <io_event+0x4d0>
c0d007c8:	5ba2      	ldrh	r2, [r4, r6]
c0d007ca:	5961      	ldr	r1, [r4, r5]
c0d007cc:	2801      	cmp	r0, #1
c0d007ce:	d101      	bne.n	c0d007d4 <io_event+0x4cc>
c0d007d0:	0150      	lsls	r0, r2, #5
c0d007d2:	1808      	adds	r0, r1, r0
    io_seproxyhal_display_default((bagl_element_t *) element);
c0d007d4:	f000 fab8 	bl	c0d00d48 <io_seproxyhal_display_default>
            UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d007d8:	5ba0      	ldrh	r0, [r4, r6]
c0d007da:	1c40      	adds	r0, r0, #1
c0d007dc:	53a0      	strh	r0, [r4, r6]
c0d007de:	5961      	ldr	r1, [r4, r5]
c0d007e0:	2900      	cmp	r1, #0
c0d007e2:	d1d5      	bne.n	c0d00790 <io_event+0x488>
c0d007e4:	20c8      	movs	r0, #200	; 0xc8
c0d007e6:	5c20      	ldrb	r0, [r4, r0]
c0d007e8:	21c2      	movs	r1, #194	; 0xc2
c0d007ea:	5a61      	ldrh	r1, [r4, r1]
c0d007ec:	4281      	cmp	r1, r0
c0d007ee:	d301      	bcc.n	c0d007f4 <io_event+0x4ec>
c0d007f0:	f001 f86e 	bl	c0d018d0 <io_seph_is_status_sent>
            break;
    }

    if (!io_seproxyhal_spi_is_status_sent()) {
c0d007f4:	f001 f86c 	bl	c0d018d0 <io_seph_is_status_sent>
c0d007f8:	2800      	cmp	r0, #0
c0d007fa:	d101      	bne.n	c0d00800 <io_event+0x4f8>
        io_seproxyhal_general_status();
c0d007fc:	f000 f930 	bl	c0d00a60 <io_seproxyhal_general_status>
c0d00800:	2001      	movs	r0, #1
    }

    return 1;
c0d00802:	b001      	add	sp, #4
c0d00804:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00806:	2005      	movs	r0, #5
                THROW(EXCEPTION_IO_RESET);
c0d00808:	f000 f91c 	bl	c0d00a44 <os_longjmp>
c0d0080c:	200003c8 	.word	0x200003c8
c0d00810:	20000200 	.word	0x20000200

c0d00814 <io_exchange_al>:
}

uint16_t io_exchange_al(uint8_t channel, uint16_t tx_len) {
c0d00814:	b5b0      	push	{r4, r5, r7, lr}
c0d00816:	4605      	mov	r5, r0
c0d00818:	2007      	movs	r0, #7
    switch (channel & ~(IO_FLAGS)) {
c0d0081a:	4028      	ands	r0, r5
c0d0081c:	2400      	movs	r4, #0
c0d0081e:	2801      	cmp	r0, #1
c0d00820:	d012      	beq.n	c0d00848 <io_exchange_al+0x34>
c0d00822:	2802      	cmp	r0, #2
c0d00824:	d112      	bne.n	c0d0084c <io_exchange_al+0x38>
        case CHANNEL_KEYBOARD:
            break;
        case CHANNEL_SPI:
            if (tx_len) {
c0d00826:	2900      	cmp	r1, #0
c0d00828:	d007      	beq.n	c0d0083a <io_exchange_al+0x26>
                io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d0082a:	480a      	ldr	r0, [pc, #40]	; (c0d00854 <io_exchange_al+0x40>)
c0d0082c:	f001 f844 	bl	c0d018b8 <io_seph_send>

                if (channel & IO_RESET_AFTER_REPLIED) {
c0d00830:	0628      	lsls	r0, r5, #24
c0d00832:	d509      	bpl.n	c0d00848 <io_exchange_al+0x34>
                    halt();
c0d00834:	f000 ffc8 	bl	c0d017c8 <halt>
c0d00838:	e006      	b.n	c0d00848 <io_exchange_al+0x34>
c0d0083a:	2041      	movs	r0, #65	; 0x41
c0d0083c:	0081      	lsls	r1, r0, #2
                }

                return 0;
            } else {
                return io_seproxyhal_spi_recv(G_io_apdu_buffer, sizeof(G_io_apdu_buffer), 0);
c0d0083e:	4805      	ldr	r0, [pc, #20]	; (c0d00854 <io_exchange_al+0x40>)
c0d00840:	2200      	movs	r2, #0
c0d00842:	f001 f851 	bl	c0d018e8 <io_seph_recv>
c0d00846:	4604      	mov	r4, r0
        default:
            THROW(INVALID_PARAMETER);
    }

    return 0;
}
c0d00848:	4620      	mov	r0, r4
c0d0084a:	bdb0      	pop	{r4, r5, r7, pc}
c0d0084c:	2002      	movs	r0, #2
            THROW(INVALID_PARAMETER);
c0d0084e:	f000 f8f9 	bl	c0d00a44 <os_longjmp>
c0d00852:	46c0      	nop			; (mov r8, r8)
c0d00854:	20000450 	.word	0x20000450

c0d00858 <io_exchange_with_code>:
{
c0d00858:	b580      	push	{r7, lr}
	G_io_apdu_buffer[tx++] = code >> 8;
c0d0085a:	0a02      	lsrs	r2, r0, #8
c0d0085c:	4b05      	ldr	r3, [pc, #20]	; (c0d00874 <io_exchange_with_code+0x1c>)
c0d0085e:	545a      	strb	r2, [r3, r1]
c0d00860:	1c4a      	adds	r2, r1, #1
	G_io_apdu_buffer[tx++] = code & 0xFF;
c0d00862:	b292      	uxth	r2, r2
c0d00864:	5498      	strb	r0, [r3, r2]
c0d00866:	1c88      	adds	r0, r1, #2
	io_exchange(CHANNEL_APDU | IO_RETURN_AFTER_TX, tx);
c0d00868:	b281      	uxth	r1, r0
c0d0086a:	2020      	movs	r0, #32
c0d0086c:	f000 fb06 	bl	c0d00e7c <io_exchange>
}
c0d00870:	bd80      	pop	{r7, pc}
c0d00872:	46c0      	nop			; (mov r8, r8)
c0d00874:	20000450 	.word	0x20000450

c0d00878 <archethic_main>:
{
c0d00878:	b096      	sub	sp, #88	; 0x58
c0d0087a:	20bd      	movs	r0, #189	; 0xbd
	global.calcTxnHashContext.initialized = false;
c0d0087c:	4945      	ldr	r1, [pc, #276]	; (c0d00994 <archethic_main+0x11c>)
c0d0087e:	2600      	movs	r6, #0
c0d00880:	540e      	strb	r6, [r1, r0]
	volatile unsigned int rx = 0;
c0d00882:	9615      	str	r6, [sp, #84]	; 0x54
	volatile unsigned int tx = 0;
c0d00884:	9614      	str	r6, [sp, #80]	; 0x50
	volatile unsigned int flags = 0;
c0d00886:	9613      	str	r6, [sp, #76]	; 0x4c
c0d00888:	4f43      	ldr	r7, [pc, #268]	; (c0d00998 <archethic_main+0x120>)
c0d0088a:	4845      	ldr	r0, [pc, #276]	; (c0d009a0 <archethic_main+0x128>)
c0d0088c:	4478      	add	r0, pc
c0d0088e:	9005      	str	r0, [sp, #20]
c0d00890:	4844      	ldr	r0, [pc, #272]	; (c0d009a4 <archethic_main+0x12c>)
c0d00892:	4478      	add	r0, pc
c0d00894:	9004      	str	r0, [sp, #16]
c0d00896:	4844      	ldr	r0, [pc, #272]	; (c0d009a8 <archethic_main+0x130>)
c0d00898:	4478      	add	r0, pc
c0d0089a:	9003      	str	r0, [sp, #12]
c0d0089c:	a812      	add	r0, sp, #72	; 0x48
		volatile unsigned short sw = 0;
c0d0089e:	8006      	strh	r6, [r0, #0]
c0d008a0:	ad06      	add	r5, sp, #24
			TRY
c0d008a2:	4628      	mov	r0, r5
c0d008a4:	f002 fc0c 	bl	c0d030c0 <setjmp>
c0d008a8:	4604      	mov	r4, r0
c0d008aa:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d008ac:	b280      	uxth	r0, r0
c0d008ae:	2800      	cmp	r0, #0
c0d008b0:	d014      	beq.n	c0d008dc <archethic_main+0x64>
c0d008b2:	2805      	cmp	r0, #5
c0d008b4:	d05d      	beq.n	c0d00972 <archethic_main+0xfa>
c0d008b6:	a806      	add	r0, sp, #24
			CATCH_OTHER(e)
c0d008b8:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d008ba:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d008bc:	f001 f82e 	bl	c0d0191c <try_context_set>
c0d008c0:	200f      	movs	r0, #15
c0d008c2:	0300      	lsls	r0, r0, #12
				switch (e & 0xF000)
c0d008c4:	4020      	ands	r0, r4
c0d008c6:	2109      	movs	r1, #9
c0d008c8:	0309      	lsls	r1, r1, #12
c0d008ca:	4288      	cmp	r0, r1
c0d008cc:	d003      	beq.n	c0d008d6 <archethic_main+0x5e>
c0d008ce:	2103      	movs	r1, #3
c0d008d0:	0349      	lsls	r1, r1, #13
c0d008d2:	4288      	cmp	r0, r1
c0d008d4:	d121      	bne.n	c0d0091a <archethic_main+0xa2>
c0d008d6:	a812      	add	r0, sp, #72	; 0x48
					sw = e;
c0d008d8:	8004      	strh	r4, [r0, #0]
c0d008da:	e025      	b.n	c0d00928 <archethic_main+0xb0>
c0d008dc:	a806      	add	r0, sp, #24
			TRY
c0d008de:	f001 f81d 	bl	c0d0191c <try_context_set>
				rx = tx;
c0d008e2:	9914      	ldr	r1, [sp, #80]	; 0x50
c0d008e4:	9115      	str	r1, [sp, #84]	; 0x54
				tx = 0; // ensure no race in CATCH_OTHER if io_exchange throws an error
c0d008e6:	9614      	str	r6, [sp, #80]	; 0x50
			TRY
c0d008e8:	9010      	str	r0, [sp, #64]	; 0x40
				rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d008ea:	9813      	ldr	r0, [sp, #76]	; 0x4c
c0d008ec:	9915      	ldr	r1, [sp, #84]	; 0x54
c0d008ee:	b2c0      	uxtb	r0, r0
c0d008f0:	b289      	uxth	r1, r1
c0d008f2:	f000 fac3 	bl	c0d00e7c <io_exchange>
c0d008f6:	9015      	str	r0, [sp, #84]	; 0x54
				flags = 0;
c0d008f8:	9613      	str	r6, [sp, #76]	; 0x4c
				if (rx == 0)
c0d008fa:	9815      	ldr	r0, [sp, #84]	; 0x54
c0d008fc:	2800      	cmp	r0, #0
c0d008fe:	d03d      	beq.n	c0d0097c <archethic_main+0x104>
				if (G_io_apdu_buffer[OFFSET_CLA] != CLA)
c0d00900:	7838      	ldrb	r0, [r7, #0]
c0d00902:	28e0      	cmp	r0, #224	; 0xe0
c0d00904:	d13d      	bne.n	c0d00982 <archethic_main+0x10a>
				handler_fn_t *handlerFn = lookupHandler(G_io_apdu_buffer[OFFSET_INS]);
c0d00906:	7878      	ldrb	r0, [r7, #1]
	switch (ins)
c0d00908:	2801      	cmp	r0, #1
c0d0090a:	9905      	ldr	r1, [sp, #20]
c0d0090c:	d019      	beq.n	c0d00942 <archethic_main+0xca>
c0d0090e:	2804      	cmp	r0, #4
c0d00910:	d016      	beq.n	c0d00940 <archethic_main+0xc8>
c0d00912:	2802      	cmp	r0, #2
c0d00914:	d139      	bne.n	c0d0098a <archethic_main+0x112>
c0d00916:	9903      	ldr	r1, [sp, #12]
c0d00918:	e013      	b.n	c0d00942 <archethic_main+0xca>
					sw = 0x6800 | (e & 0x7FF);
c0d0091a:	4820      	ldr	r0, [pc, #128]	; (c0d0099c <archethic_main+0x124>)
c0d0091c:	4004      	ands	r4, r0
c0d0091e:	200d      	movs	r0, #13
c0d00920:	02c0      	lsls	r0, r0, #11
c0d00922:	1820      	adds	r0, r4, r0
c0d00924:	a912      	add	r1, sp, #72	; 0x48
c0d00926:	8008      	strh	r0, [r1, #0]
				G_io_apdu_buffer[tx++] = sw >> 8;
c0d00928:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d0092a:	0a00      	lsrs	r0, r0, #8
c0d0092c:	9914      	ldr	r1, [sp, #80]	; 0x50
c0d0092e:	5478      	strb	r0, [r7, r1]
c0d00930:	1c48      	adds	r0, r1, #1
c0d00932:	9014      	str	r0, [sp, #80]	; 0x50
				G_io_apdu_buffer[tx++] = sw & 0xFF;
c0d00934:	9812      	ldr	r0, [sp, #72]	; 0x48
c0d00936:	9914      	ldr	r1, [sp, #80]	; 0x50
c0d00938:	5478      	strb	r0, [r7, r1]
c0d0093a:	1c48      	adds	r0, r1, #1
c0d0093c:	9014      	str	r0, [sp, #80]	; 0x50
c0d0093e:	e00a      	b.n	c0d00956 <archethic_main+0xde>
c0d00940:	9904      	ldr	r1, [sp, #16]
c0d00942:	460c      	mov	r4, r1
						  G_io_apdu_buffer + OFFSET_CDATA, G_io_apdu_buffer[OFFSET_LC], &flags, &tx);
c0d00944:	793b      	ldrb	r3, [r7, #4]
				handlerFn(G_io_apdu_buffer[OFFSET_P1], G_io_apdu_buffer[OFFSET_P2],
c0d00946:	78f9      	ldrb	r1, [r7, #3]
c0d00948:	78b8      	ldrb	r0, [r7, #2]
c0d0094a:	aa14      	add	r2, sp, #80	; 0x50
c0d0094c:	9201      	str	r2, [sp, #4]
c0d0094e:	aa13      	add	r2, sp, #76	; 0x4c
c0d00950:	9200      	str	r2, [sp, #0]
c0d00952:	1d7a      	adds	r2, r7, #5
c0d00954:	47a0      	blx	r4
			FINALLY
c0d00956:	f000 ffd5 	bl	c0d01904 <try_context_get>
c0d0095a:	a906      	add	r1, sp, #24
c0d0095c:	4288      	cmp	r0, r1
c0d0095e:	d102      	bne.n	c0d00966 <archethic_main+0xee>
c0d00960:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d00962:	f000 ffdb 	bl	c0d0191c <try_context_set>
c0d00966:	a806      	add	r0, sp, #24
		END_TRY;
c0d00968:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d0096a:	2800      	cmp	r0, #0
c0d0096c:	d096      	beq.n	c0d0089c <archethic_main+0x24>
c0d0096e:	f000 f869 	bl	c0d00a44 <os_longjmp>
c0d00972:	a806      	add	r0, sp, #24
			CATCH(EXCEPTION_IO_RESET)
c0d00974:	8586      	strh	r6, [r0, #44]	; 0x2c
c0d00976:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d00978:	f000 ffd0 	bl	c0d0191c <try_context_set>
c0d0097c:	2005      	movs	r0, #5
c0d0097e:	f000 f861 	bl	c0d00a44 <os_longjmp>
c0d00982:	2037      	movs	r0, #55	; 0x37
c0d00984:	0240      	lsls	r0, r0, #9
					THROW(0x6E00);
c0d00986:	f000 f85d 	bl	c0d00a44 <os_longjmp>
c0d0098a:	206d      	movs	r0, #109	; 0x6d
c0d0098c:	0200      	lsls	r0, r0, #8
					THROW(0x6D00);
c0d0098e:	f000 f859 	bl	c0d00a44 <os_longjmp>
c0d00992:	46c0      	nop			; (mov r8, r8)
c0d00994:	20000308 	.word	0x20000308
c0d00998:	20000450 	.word	0x20000450
c0d0099c:	000007ff 	.word	0x000007ff
c0d009a0:	fffffa21 	.word	0xfffffa21
c0d009a4:	00000edf 	.word	0x00000edf
c0d009a8:	fffff8b1 	.word	0xfffff8b1

c0d009ac <app_exit>:
{
c0d009ac:	b510      	push	{r4, lr}
c0d009ae:	b08c      	sub	sp, #48	; 0x30
c0d009b0:	466c      	mov	r4, sp
		TRY_L(exit)
c0d009b2:	4620      	mov	r0, r4
c0d009b4:	f002 fb84 	bl	c0d030c0 <setjmp>
c0d009b8:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d009ba:	0400      	lsls	r0, r0, #16
c0d009bc:	d106      	bne.n	c0d009cc <app_exit+0x20>
c0d009be:	4668      	mov	r0, sp
c0d009c0:	f000 ffac 	bl	c0d0191c <try_context_set>
c0d009c4:	900a      	str	r0, [sp, #40]	; 0x28
c0d009c6:	20ff      	movs	r0, #255	; 0xff
			os_sched_exit(-1);
c0d009c8:	f000 ff68 	bl	c0d0189c <os_sched_exit>
		FINALLY_L(exit)
c0d009cc:	f000 ff9a 	bl	c0d01904 <try_context_get>
c0d009d0:	4669      	mov	r1, sp
c0d009d2:	4288      	cmp	r0, r1
c0d009d4:	d102      	bne.n	c0d009dc <app_exit+0x30>
c0d009d6:	980a      	ldr	r0, [sp, #40]	; 0x28
c0d009d8:	f000 ffa0 	bl	c0d0191c <try_context_set>
c0d009dc:	4668      	mov	r0, sp
	END_TRY_L(exit);
c0d009de:	8d80      	ldrh	r0, [r0, #44]	; 0x2c
c0d009e0:	2800      	cmp	r0, #0
c0d009e2:	d101      	bne.n	c0d009e8 <app_exit+0x3c>
}
c0d009e4:	b00c      	add	sp, #48	; 0x30
c0d009e6:	bd10      	pop	{r4, pc}
	END_TRY_L(exit);
c0d009e8:	f000 f82c 	bl	c0d00a44 <os_longjmp>

c0d009ec <ux_menu_about_step_validateinit>:
#include "../globals.h"
#include "menu.h"

UX_STEP_NOCB(ux_menu_ready_step, pnn, {NULL, "Archethic", "is Ready"});
UX_STEP_NOCB(ux_menu_version_step, bn, {"Version", APPVERSION});
UX_STEP_CB(ux_menu_about_step, pb, ui_menu_about(), {&C_icon_up, "About"});
c0d009ec:	b580      	push	{r7, lr}
// #1 screen: app info
// #2 screen: back button to main menu
UX_FLOW(ux_menu_about_flow, &ux_menu_info_step, &ux_menu_back_step, FLOW_LOOP);

void ui_menu_about() {
    ux_flow_init(0, ux_menu_about_flow, NULL);
c0d009ee:	4903      	ldr	r1, [pc, #12]	; (c0d009fc <ux_menu_about_step_validateinit+0x10>)
c0d009f0:	4479      	add	r1, pc
c0d009f2:	2000      	movs	r0, #0
c0d009f4:	4602      	mov	r2, r0
c0d009f6:	f002 f81b 	bl	c0d02a30 <ux_flow_init>
UX_STEP_CB(ux_menu_about_step, pb, ui_menu_about(), {&C_icon_up, "About"});
c0d009fa:	bd80      	pop	{r7, pc}
c0d009fc:	00002a28 	.word	0x00002a28

c0d00a00 <ux_menu_exit_step_validateinit>:
UX_STEP_VALID(ux_menu_exit_step, pb, os_sched_exit(-1), {&C_icon_dashboard, "Quit"});
c0d00a00:	b580      	push	{r7, lr}
c0d00a02:	20ff      	movs	r0, #255	; 0xff
c0d00a04:	f000 ff4a 	bl	c0d0189c <os_sched_exit>
c0d00a08:	bd80      	pop	{r7, pc}
	...

c0d00a0c <ui_menu_main>:
void ui_menu_main() {
c0d00a0c:	b580      	push	{r7, lr}
    if (G_ux.stack_count == 0) {
c0d00a0e:	4806      	ldr	r0, [pc, #24]	; (c0d00a28 <ui_menu_main+0x1c>)
c0d00a10:	7800      	ldrb	r0, [r0, #0]
c0d00a12:	2800      	cmp	r0, #0
c0d00a14:	d101      	bne.n	c0d00a1a <ui_menu_main+0xe>
        ux_stack_push();
c0d00a16:	f002 f9cd 	bl	c0d02db4 <ux_stack_push>
    ux_flow_init(0, ux_menu_main_flow, NULL);
c0d00a1a:	4904      	ldr	r1, [pc, #16]	; (c0d00a2c <ui_menu_main+0x20>)
c0d00a1c:	4479      	add	r1, pc
c0d00a1e:	2000      	movs	r0, #0
c0d00a20:	4602      	mov	r2, r0
c0d00a22:	f002 f805 	bl	c0d02a30 <ux_flow_init>
}
c0d00a26:	bd80      	pop	{r7, pc}
c0d00a28:	20000200 	.word	0x20000200
c0d00a2c:	0000299c 	.word	0x0000299c

c0d00a30 <ux_menu_back_step_validateinit>:
UX_STEP_CB(ux_menu_back_step, pb, ui_menu_main(), {&C_icon_back, "Back"});
c0d00a30:	b580      	push	{r7, lr}
c0d00a32:	f7ff ffeb 	bl	c0d00a0c <ui_menu_main>
c0d00a36:	bd80      	pop	{r7, pc}

c0d00a38 <ui_idle>:
{
    
    #ifdef HAVE_UX_LEGACY
        UX_MENU_DISPLAY(0, ui_menu_main, NULL);
    #endif
c0d00a38:	4770      	bx	lr

c0d00a3a <os_boot>:

// apdu buffer must hold a complete apdu to avoid troubles
unsigned char G_io_apdu_buffer[IO_APDU_BUFFER_SIZE];

#ifndef BOLOS_OS_UPGRADER_APP
void os_boot(void) {
c0d00a3a:	b580      	push	{r7, lr}
c0d00a3c:	2000      	movs	r0, #0
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0d00a3e:	f000 ff6d 	bl	c0d0191c <try_context_set>
#endif // HAVE_BOLOS
}
c0d00a42:	bd80      	pop	{r7, pc}

c0d00a44 <os_longjmp>:
  }
  return xoracc;
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0d00a44:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
c0d00a46:	4672      	mov	r2, lr
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
c0d00a48:	4804      	ldr	r0, [pc, #16]	; (c0d00a5c <os_longjmp+0x18>)
c0d00a4a:	4478      	add	r0, pc
c0d00a4c:	4621      	mov	r1, r4
c0d00a4e:	f000 fcdd 	bl	c0d0140c <mcu_usb_printf>
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0d00a52:	f000 ff57 	bl	c0d01904 <try_context_get>
c0d00a56:	4621      	mov	r1, r4
c0d00a58:	f002 fb3e 	bl	c0d030d8 <longjmp>
c0d00a5c:	000029de 	.word	0x000029de

c0d00a60 <io_seproxyhal_general_status>:
  0,
  2,
  SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8,
  SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND,
};
void io_seproxyhal_general_status(void) {
c0d00a60:	b580      	push	{r7, lr}
  // send the general status
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d00a62:	4803      	ldr	r0, [pc, #12]	; (c0d00a70 <io_seproxyhal_general_status+0x10>)
c0d00a64:	4478      	add	r0, pc
c0d00a66:	2105      	movs	r1, #5
c0d00a68:	f000 ff26 	bl	c0d018b8 <io_seph_send>
}
c0d00a6c:	bd80      	pop	{r7, pc}
c0d00a6e:	46c0      	nop			; (mov r8, r8)
c0d00a70:	000029de 	.word	0x000029de

c0d00a74 <io_seproxyhal_handle_usb_event>:
}

#ifdef HAVE_IO_USB
#ifdef HAVE_L4_USBLIB

void io_seproxyhal_handle_usb_event(void) {
c0d00a74:	b510      	push	{r4, lr}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00a76:	4816      	ldr	r0, [pc, #88]	; (c0d00ad0 <io_seproxyhal_handle_usb_event+0x5c>)
c0d00a78:	78c0      	ldrb	r0, [r0, #3]
c0d00a7a:	2803      	cmp	r0, #3
c0d00a7c:	dc07      	bgt.n	c0d00a8e <io_seproxyhal_handle_usb_event+0x1a>
c0d00a7e:	2801      	cmp	r0, #1
c0d00a80:	d00d      	beq.n	c0d00a9e <io_seproxyhal_handle_usb_event+0x2a>
c0d00a82:	2802      	cmp	r0, #2
c0d00a84:	d11f      	bne.n	c0d00ac6 <io_seproxyhal_handle_usb_event+0x52>
      }
      memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
      memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00a86:	4813      	ldr	r0, [pc, #76]	; (c0d00ad4 <io_seproxyhal_handle_usb_event+0x60>)
c0d00a88:	f001 fa0c 	bl	c0d01ea4 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00a8c:	bd10      	pop	{r4, pc}
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00a8e:	2804      	cmp	r0, #4
c0d00a90:	d016      	beq.n	c0d00ac0 <io_seproxyhal_handle_usb_event+0x4c>
c0d00a92:	2808      	cmp	r0, #8
c0d00a94:	d117      	bne.n	c0d00ac6 <io_seproxyhal_handle_usb_event+0x52>
      USBD_LL_Resume(&USBD_Device);
c0d00a96:	480f      	ldr	r0, [pc, #60]	; (c0d00ad4 <io_seproxyhal_handle_usb_event+0x60>)
c0d00a98:	f001 fa02 	bl	c0d01ea0 <USBD_LL_Resume>
}
c0d00a9c:	bd10      	pop	{r4, pc}
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);
c0d00a9e:	4c0d      	ldr	r4, [pc, #52]	; (c0d00ad4 <io_seproxyhal_handle_usb_event+0x60>)
c0d00aa0:	2101      	movs	r1, #1
c0d00aa2:	4620      	mov	r0, r4
c0d00aa4:	f001 f9f7 	bl	c0d01e96 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00aa8:	4620      	mov	r0, r4
c0d00aaa:	f001 f9d5 	bl	c0d01e58 <USBD_LL_Reset>
      if (G_io_app.apdu_media != IO_APDU_MEDIA_NONE) {
c0d00aae:	480a      	ldr	r0, [pc, #40]	; (c0d00ad8 <io_seproxyhal_handle_usb_event+0x64>)
c0d00ab0:	7981      	ldrb	r1, [r0, #6]
c0d00ab2:	2900      	cmp	r1, #0
c0d00ab4:	d108      	bne.n	c0d00ac8 <io_seproxyhal_handle_usb_event+0x54>
      memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d00ab6:	300c      	adds	r0, #12
c0d00ab8:	2112      	movs	r1, #18
c0d00aba:	f002 fac5 	bl	c0d03048 <__aeabi_memclr>
}
c0d00abe:	bd10      	pop	{r4, pc}
      USBD_LL_Suspend(&USBD_Device);
c0d00ac0:	4804      	ldr	r0, [pc, #16]	; (c0d00ad4 <io_seproxyhal_handle_usb_event+0x60>)
c0d00ac2:	f001 f9eb 	bl	c0d01e9c <USBD_LL_Suspend>
}
c0d00ac6:	bd10      	pop	{r4, pc}
c0d00ac8:	2005      	movs	r0, #5
        THROW(EXCEPTION_IO_RESET);
c0d00aca:	f7ff ffbb 	bl	c0d00a44 <os_longjmp>
c0d00ace:	46c0      	nop			; (mov r8, r8)
c0d00ad0:	200003d0 	.word	0x200003d0
c0d00ad4:	200005d8 	.word	0x200005d8
c0d00ad8:	20000554 	.word	0x20000554

c0d00adc <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
c0d00adc:	217f      	movs	r1, #127	; 0x7f
  if ((epnum & 0x7F) < IO_USB_MAX_ENDPOINTS) {
c0d00ade:	4001      	ands	r1, r0
c0d00ae0:	2905      	cmp	r1, #5
c0d00ae2:	d803      	bhi.n	c0d00aec <io_seproxyhal_get_ep_rx_size+0x10>
    return G_io_app.usb_ep_xfer_len[epnum&0x7F];
c0d00ae4:	4802      	ldr	r0, [pc, #8]	; (c0d00af0 <io_seproxyhal_get_ep_rx_size+0x14>)
c0d00ae6:	1840      	adds	r0, r0, r1
c0d00ae8:	7b00      	ldrb	r0, [r0, #12]
  }
  return 0;
}
c0d00aea:	4770      	bx	lr
c0d00aec:	2000      	movs	r0, #0
c0d00aee:	4770      	bx	lr
c0d00af0:	20000554 	.word	0x20000554

c0d00af4 <io_seproxyhal_handle_usb_ep_xfer_event>:

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00af4:	b580      	push	{r7, lr}
  uint8_t epnum;

  epnum = G_io_seproxyhal_spi_buffer[3] & 0x7F;
c0d00af6:	4815      	ldr	r0, [pc, #84]	; (c0d00b4c <io_seproxyhal_handle_usb_ep_xfer_event+0x58>)
c0d00af8:	78c2      	ldrb	r2, [r0, #3]
c0d00afa:	217f      	movs	r1, #127	; 0x7f
c0d00afc:	4011      	ands	r1, r2

  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00afe:	7902      	ldrb	r2, [r0, #4]
c0d00b00:	2a04      	cmp	r2, #4
c0d00b02:	d014      	beq.n	c0d00b2e <io_seproxyhal_handle_usb_ep_xfer_event+0x3a>
c0d00b04:	2a02      	cmp	r2, #2
c0d00b06:	d006      	beq.n	c0d00b16 <io_seproxyhal_handle_usb_ep_xfer_event+0x22>
c0d00b08:	2a01      	cmp	r2, #1
c0d00b0a:	d11d      	bne.n	c0d00b48 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
    /* This event is received when a new SETUP token had been received on a control endpoint */
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00b0c:	1d81      	adds	r1, r0, #6
c0d00b0e:	4811      	ldr	r0, [pc, #68]	; (c0d00b54 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d00b10:	f001 f8b2 	bl	c0d01c78 <USBD_LL_SetupStage>
        // prepare reception
        USBD_LL_DataOutStage(&USBD_Device, epnum, &G_io_seproxyhal_spi_buffer[6]);
      }
      break;
  }
}
c0d00b14:	bd80      	pop	{r7, pc}
      if (epnum < IO_USB_MAX_ENDPOINTS) {
c0d00b16:	2905      	cmp	r1, #5
c0d00b18:	d816      	bhi.n	c0d00b48 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        G_io_app.usb_ep_timeouts[epnum].timeout = 0;
c0d00b1a:	004a      	lsls	r2, r1, #1
c0d00b1c:	4b0c      	ldr	r3, [pc, #48]	; (c0d00b50 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d00b1e:	189a      	adds	r2, r3, r2
c0d00b20:	2300      	movs	r3, #0
c0d00b22:	8253      	strh	r3, [r2, #18]
        USBD_LL_DataInStage(&USBD_Device, epnum, &G_io_seproxyhal_spi_buffer[6]);
c0d00b24:	1d82      	adds	r2, r0, #6
c0d00b26:	480b      	ldr	r0, [pc, #44]	; (c0d00b54 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d00b28:	f001 f92a 	bl	c0d01d80 <USBD_LL_DataInStage>
}
c0d00b2c:	bd80      	pop	{r7, pc}
      if (epnum < IO_USB_MAX_ENDPOINTS) {
c0d00b2e:	2905      	cmp	r1, #5
c0d00b30:	d80a      	bhi.n	c0d00b48 <io_seproxyhal_handle_usb_ep_xfer_event+0x54>
        G_io_app.usb_ep_xfer_len[epnum] = MIN(G_io_seproxyhal_spi_buffer[5], IO_SEPROXYHAL_BUFFER_SIZE_B - 6);
c0d00b32:	4a07      	ldr	r2, [pc, #28]	; (c0d00b50 <io_seproxyhal_handle_usb_ep_xfer_event+0x5c>)
c0d00b34:	1852      	adds	r2, r2, r1
c0d00b36:	7943      	ldrb	r3, [r0, #5]
c0d00b38:	2b7a      	cmp	r3, #122	; 0x7a
c0d00b3a:	d300      	bcc.n	c0d00b3e <io_seproxyhal_handle_usb_ep_xfer_event+0x4a>
c0d00b3c:	237a      	movs	r3, #122	; 0x7a
c0d00b3e:	7313      	strb	r3, [r2, #12]
        USBD_LL_DataOutStage(&USBD_Device, epnum, &G_io_seproxyhal_spi_buffer[6]);
c0d00b40:	1d82      	adds	r2, r0, #6
c0d00b42:	4804      	ldr	r0, [pc, #16]	; (c0d00b54 <io_seproxyhal_handle_usb_ep_xfer_event+0x60>)
c0d00b44:	f001 f8c6 	bl	c0d01cd4 <USBD_LL_DataOutStage>
}
c0d00b48:	bd80      	pop	{r7, pc}
c0d00b4a:	46c0      	nop			; (mov r8, r8)
c0d00b4c:	200003d0 	.word	0x200003d0
c0d00b50:	20000554 	.word	0x20000554
c0d00b54:	200005d8 	.word	0x200005d8

c0d00b58 <io_usb_send_ep>:
#endif // HAVE_L4_USBLIB

// TODO, refactor this using the USB DataIn event like for the U2F tunnel
// TODO add a blocking parameter, for HID KBD sending, or use a USB busy flag per channel to know if 
// the transfer has been processed or not. and move on to the next transfer on the same endpoint
void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00b58:	b570      	push	{r4, r5, r6, lr}
  if (timeout) {
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00b5a:	2aff      	cmp	r2, #255	; 0xff
c0d00b5c:	d81d      	bhi.n	c0d00b9a <io_usb_send_ep+0x42>
c0d00b5e:	4615      	mov	r5, r2
c0d00b60:	460e      	mov	r6, r1
c0d00b62:	4604      	mov	r4, r0
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00b64:	480d      	ldr	r0, [pc, #52]	; (c0d00b9c <io_usb_send_ep+0x44>)
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
  G_io_seproxyhal_spi_buffer[2] = (3+length);
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00b66:	7142      	strb	r2, [r0, #5]
c0d00b68:	2120      	movs	r1, #32
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00b6a:	7101      	strb	r1, [r0, #4]
c0d00b6c:	2150      	movs	r1, #80	; 0x50
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00b6e:	7001      	strb	r1, [r0, #0]
c0d00b70:	2180      	movs	r1, #128	; 0x80
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00b72:	4321      	orrs	r1, r4
c0d00b74:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00b76:	1cd1      	adds	r1, r2, #3
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00b78:	7081      	strb	r1, [r0, #2]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00b7a:	0a09      	lsrs	r1, r1, #8
c0d00b7c:	7041      	strb	r1, [r0, #1]
c0d00b7e:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00b80:	f000 fe9a 	bl	c0d018b8 <io_seph_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00b84:	4630      	mov	r0, r6
c0d00b86:	4629      	mov	r1, r5
c0d00b88:	f000 fe96 	bl	c0d018b8 <io_seph_send>
  // setup timeout of the endpoint
  G_io_app.usb_ep_timeouts[ep&0x7F].timeout = IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d00b8c:	0660      	lsls	r0, r4, #25
c0d00b8e:	0e00      	lsrs	r0, r0, #24
c0d00b90:	4903      	ldr	r1, [pc, #12]	; (c0d00ba0 <io_usb_send_ep+0x48>)
c0d00b92:	1808      	adds	r0, r1, r0
c0d00b94:	217d      	movs	r1, #125	; 0x7d
c0d00b96:	0109      	lsls	r1, r1, #4
c0d00b98:	8241      	strh	r1, [r0, #18]
}
c0d00b9a:	bd70      	pop	{r4, r5, r6, pc}
c0d00b9c:	200003d0 	.word	0x200003d0
c0d00ba0:	20000554 	.word	0x20000554

c0d00ba4 <io_usb_send_apdu_data>:

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d00ba4:	b580      	push	{r7, lr}
c0d00ba6:	460a      	mov	r2, r1
c0d00ba8:	4601      	mov	r1, r0
c0d00baa:	2082      	movs	r0, #130	; 0x82
c0d00bac:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d00bae:	f7ff ffd3 	bl	c0d00b58 <io_usb_send_ep>
}
c0d00bb2:	bd80      	pop	{r7, pc}

c0d00bb4 <io_usb_send_apdu_data_ep0x83>:

#ifdef HAVE_WEBUSB
void io_usb_send_apdu_data_ep0x83(unsigned char* buffer, unsigned short length) {
c0d00bb4:	b580      	push	{r7, lr}
c0d00bb6:	460a      	mov	r2, r1
c0d00bb8:	4601      	mov	r1, r0
c0d00bba:	2083      	movs	r0, #131	; 0x83
c0d00bbc:	2314      	movs	r3, #20
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x83, buffer, length, 20);
c0d00bbe:	f7ff ffcb 	bl	c0d00b58 <io_usb_send_ep>
}
c0d00bc2:	bd80      	pop	{r7, pc}

c0d00bc4 <io_seproxyhal_handle_event>:
    // copy apdu to apdu buffer
    memcpy(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
  }
}

unsigned int io_seproxyhal_handle_event(void) {
c0d00bc4:	b510      	push	{r4, lr}
  return (buf[off] << 8) | buf[off + 1];
c0d00bc6:	4826      	ldr	r0, [pc, #152]	; (c0d00c60 <io_seproxyhal_handle_event+0x9c>)
c0d00bc8:	7881      	ldrb	r1, [r0, #2]
c0d00bca:	7842      	ldrb	r2, [r0, #1]
c0d00bcc:	0212      	lsls	r2, r2, #8
c0d00bce:	1852      	adds	r2, r2, r1
#ifdef HAVE_BLE
  // continue sending the ble db saved if any
  io_seproxyhal_ble_pairing_db_to_mcu(NULL, 0, BOLOS_FALSE);
#endif // HAVE_BLE

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00bd0:	7801      	ldrb	r1, [r0, #0]
c0d00bd2:	290f      	cmp	r1, #15
c0d00bd4:	dc08      	bgt.n	c0d00be8 <io_seproxyhal_handle_event+0x24>
c0d00bd6:	290e      	cmp	r1, #14
c0d00bd8:	d01c      	beq.n	c0d00c14 <io_seproxyhal_handle_event+0x50>
c0d00bda:	290f      	cmp	r1, #15
c0d00bdc:	d12c      	bne.n	c0d00c38 <io_seproxyhal_handle_event+0x74>
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 1) {
c0d00bde:	2a01      	cmp	r2, #1
c0d00be0:	d131      	bne.n	c0d00c46 <io_seproxyhal_handle_event+0x82>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d00be2:	f7ff ff47 	bl	c0d00a74 <io_seproxyhal_handle_usb_event>
c0d00be6:	e032      	b.n	c0d00c4e <io_seproxyhal_handle_event+0x8a>
  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00be8:	2910      	cmp	r1, #16
c0d00bea:	d02a      	beq.n	c0d00c42 <io_seproxyhal_handle_event+0x7e>
c0d00bec:	2916      	cmp	r1, #22
c0d00bee:	d123      	bne.n	c0d00c38 <io_seproxyhal_handle_event+0x74>
  if (G_io_app.apdu_state == APDU_IDLE) {
c0d00bf0:	491c      	ldr	r1, [pc, #112]	; (c0d00c64 <io_seproxyhal_handle_event+0xa0>)
c0d00bf2:	780b      	ldrb	r3, [r1, #0]
c0d00bf4:	2401      	movs	r4, #1
c0d00bf6:	2b00      	cmp	r3, #0
c0d00bf8:	d12a      	bne.n	c0d00c50 <io_seproxyhal_handle_event+0x8c>
c0d00bfa:	230a      	movs	r3, #10
    G_io_app.apdu_state = APDU_RAW; // for next call to io_exchange
c0d00bfc:	700b      	strb	r3, [r1, #0]
c0d00bfe:	2306      	movs	r3, #6
    G_io_app.apdu_media = IO_APDU_MEDIA_RAW; // for application code
c0d00c00:	718b      	strb	r3, [r1, #6]
    G_io_app.apdu_length = MIN(size, max);
c0d00c02:	2a7d      	cmp	r2, #125	; 0x7d
c0d00c04:	d300      	bcc.n	c0d00c08 <io_seproxyhal_handle_event+0x44>
c0d00c06:	227d      	movs	r2, #125	; 0x7d
c0d00c08:	804a      	strh	r2, [r1, #2]
    memcpy(G_io_apdu_buffer, G_io_seproxyhal_spi_buffer+3, G_io_app.apdu_length);
c0d00c0a:	1cc1      	adds	r1, r0, #3
c0d00c0c:	4816      	ldr	r0, [pc, #88]	; (c0d00c68 <io_seproxyhal_handle_event+0xa4>)
c0d00c0e:	f002 fa20 	bl	c0d03052 <__aeabi_memcpy>
c0d00c12:	e01d      	b.n	c0d00c50 <io_seproxyhal_handle_event+0x8c>
      return 1;

      // ask the user if not processed here
    case SEPROXYHAL_TAG_TICKER_EVENT:
      // process ticker events to timeout the IO transfers, and forward to the user io_event function too
      G_io_app.ms += 100; // value is by default, don't change the ticker configuration
c0d00c14:	4813      	ldr	r0, [pc, #76]	; (c0d00c64 <io_seproxyhal_handle_event+0xa0>)
c0d00c16:	6881      	ldr	r1, [r0, #8]
c0d00c18:	3164      	adds	r1, #100	; 0x64
c0d00c1a:	6081      	str	r1, [r0, #8]
c0d00c1c:	211c      	movs	r1, #28
#ifdef HAVE_IO_USB
      {
        unsigned int i = IO_USB_MAX_ENDPOINTS;
        while(i--) {
          if (G_io_app.usb_ep_timeouts[i].timeout) {
c0d00c1e:	5a42      	ldrh	r2, [r0, r1]
c0d00c20:	2a00      	cmp	r2, #0
c0d00c22:	d006      	beq.n	c0d00c32 <io_seproxyhal_handle_event+0x6e>
            G_io_app.usb_ep_timeouts[i].timeout-=MIN(G_io_app.usb_ep_timeouts[i].timeout, 100);
c0d00c24:	4613      	mov	r3, r2
c0d00c26:	3b64      	subs	r3, #100	; 0x64
c0d00c28:	d200      	bcs.n	c0d00c2c <io_seproxyhal_handle_event+0x68>
c0d00c2a:	2300      	movs	r3, #0
c0d00c2c:	5243      	strh	r3, [r0, r1]
            if (!G_io_app.usb_ep_timeouts[i].timeout) {
c0d00c2e:	2a64      	cmp	r2, #100	; 0x64
c0d00c30:	d910      	bls.n	c0d00c54 <io_seproxyhal_handle_event+0x90>
        while(i--) {
c0d00c32:	1e89      	subs	r1, r1, #2
c0d00c34:	2910      	cmp	r1, #16
c0d00c36:	d1f2      	bne.n	c0d00c1e <io_seproxyhal_handle_event+0x5a>
c0d00c38:	2002      	movs	r0, #2
      }
#endif // HAVE_BLE_APDU
      __attribute__((fallthrough));     
      // no break is intentional
    default:
      return io_event(CHANNEL_SPI);
c0d00c3a:	f7ff fb65 	bl	c0d00308 <io_event>
c0d00c3e:	4604      	mov	r4, r0
c0d00c40:	e006      	b.n	c0d00c50 <io_seproxyhal_handle_event+0x8c>
      if (rx_len < 3) {
c0d00c42:	2a03      	cmp	r2, #3
c0d00c44:	d201      	bcs.n	c0d00c4a <io_seproxyhal_handle_event+0x86>
c0d00c46:	2400      	movs	r4, #0
c0d00c48:	e002      	b.n	c0d00c50 <io_seproxyhal_handle_event+0x8c>
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d00c4a:	f7ff ff53 	bl	c0d00af4 <io_seproxyhal_handle_usb_ep_xfer_event>
c0d00c4e:	2401      	movs	r4, #1
  }
  // defaultly return as not processed
  return 0;
}
c0d00c50:	4620      	mov	r0, r4
c0d00c52:	bd10      	pop	{r4, pc}
c0d00c54:	2100      	movs	r1, #0
              G_io_app.apdu_state = APDU_IDLE;
c0d00c56:	7001      	strb	r1, [r0, #0]
c0d00c58:	2005      	movs	r0, #5
              THROW(EXCEPTION_IO_RESET);
c0d00c5a:	f7ff fef3 	bl	c0d00a44 <os_longjmp>
c0d00c5e:	46c0      	nop			; (mov r8, r8)
c0d00c60:	200003d0 	.word	0x200003d0
c0d00c64:	20000554 	.word	0x20000554
c0d00c68:	20000450 	.word	0x20000450

c0d00c6c <io_seproxyhal_init>:
  1,
  SEPROXYHAL_TAG_MCU_TYPE_PROTECT,
};
#endif // (!defined(HAVE_BOLOS) && defined(HAVE_MCU_PROTECT))

void io_seproxyhal_init(void) {
c0d00c6c:	b580      	push	{r7, lr}
// get API level
SYSCALL unsigned int get_api_level(void);

#ifndef HAVE_BOLOS
static inline void check_api_level(unsigned int apiLevel) {
  if (apiLevel < get_api_level()) {
c0d00c6e:	f000 fd9d 	bl	c0d017ac <get_api_level>
c0d00c72:	280d      	cmp	r0, #13
c0d00c74:	d302      	bcc.n	c0d00c7c <io_seproxyhal_init+0x10>
c0d00c76:	20ff      	movs	r0, #255	; 0xff
    os_sched_exit(-1);
c0d00c78:	f000 fe10 	bl	c0d0189c <os_sched_exit>
  memset(&G_io_app, 0, sizeof(G_io_app));
#ifdef TARGET_NANOX
  G_io_app.plane_mode = plane;
#endif // TARGET_NANOX

  G_io_app.apdu_state = APDU_IDLE;
c0d00c7c:	4805      	ldr	r0, [pc, #20]	; (c0d00c94 <io_seproxyhal_init+0x28>)
c0d00c7e:	2120      	movs	r1, #32
c0d00c80:	f002 f9e2 	bl	c0d03048 <__aeabi_memclr>
  #ifdef DEBUG_APDU
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU

  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d00c84:	f000 fb12 	bl	c0d012ac <io_usb_hid_init>
// #endif // TARGET_NANOX
}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_ux_os.button_mask = 0;
c0d00c88:	4803      	ldr	r0, [pc, #12]	; (c0d00c98 <io_seproxyhal_init+0x2c>)
c0d00c8a:	2100      	movs	r1, #0
c0d00c8c:	6001      	str	r1, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d00c8e:	6041      	str	r1, [r0, #4]
}
c0d00c90:	bd80      	pop	{r7, pc}
c0d00c92:	46c0      	nop			; (mov r8, r8)
c0d00c94:	20000554 	.word	0x20000554
c0d00c98:	20000574 	.word	0x20000574

c0d00c9c <io_seproxyhal_init_ux>:
}
c0d00c9c:	4770      	bx	lr
	...

c0d00ca0 <io_seproxyhal_init_button>:
  G_ux_os.button_mask = 0;
c0d00ca0:	4802      	ldr	r0, [pc, #8]	; (c0d00cac <io_seproxyhal_init_button+0xc>)
c0d00ca2:	2100      	movs	r1, #0
c0d00ca4:	6001      	str	r1, [r0, #0]
  G_ux_os.button_same_mask_counter = 0;
c0d00ca6:	6041      	str	r1, [r0, #4]
}
c0d00ca8:	4770      	bx	lr
c0d00caa:	46c0      	nop			; (mov r8, r8)
c0d00cac:	20000574 	.word	0x20000574

c0d00cb0 <io_seproxyhal_display_icon>:
    }
  }
}

#else // TARGET_NANOX
void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_det) {
c0d00cb0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00cb2:	b089      	sub	sp, #36	; 0x24
c0d00cb4:	4605      	mov	r5, r0
  bagl_component_t icon_component_mod;
  const bagl_icon_details_t* icon_details = (bagl_icon_details_t*)PIC(icon_det);
c0d00cb6:	4608      	mov	r0, r1
c0d00cb8:	f000 fd46 	bl	c0d01748 <pic>
  if (icon_details && icon_details->bitmap) {
c0d00cbc:	2800      	cmp	r0, #0
c0d00cbe:	d03f      	beq.n	c0d00d40 <io_seproxyhal_display_icon+0x90>
c0d00cc0:	4604      	mov	r4, r0
c0d00cc2:	6900      	ldr	r0, [r0, #16]
c0d00cc4:	2800      	cmp	r0, #0
c0d00cc6:	d03b      	beq.n	c0d00d40 <io_seproxyhal_display_icon+0x90>
    // ensure not being out of bounds in the icon component agianst the declared icon real size
    memcpy(&icon_component_mod, (void *)PIC(icon_component), sizeof(bagl_component_t));
c0d00cc8:	4628      	mov	r0, r5
c0d00cca:	f000 fd3d 	bl	c0d01748 <pic>
c0d00cce:	4601      	mov	r1, r0
c0d00cd0:	ad02      	add	r5, sp, #8
c0d00cd2:	221c      	movs	r2, #28
c0d00cd4:	4628      	mov	r0, r5
c0d00cd6:	9201      	str	r2, [sp, #4]
c0d00cd8:	f002 f9bb 	bl	c0d03052 <__aeabi_memcpy>
    icon_component_mod.width = icon_details->width;
c0d00cdc:	6822      	ldr	r2, [r4, #0]
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
    unsigned short length = sizeof(bagl_component_t)
                            +1 /* bpp */
                            +h /* color index */
                            +w; /* image bitmap size */
    G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00cde:	4819      	ldr	r0, [pc, #100]	; (c0d00d44 <io_seproxyhal_display_icon+0x94>)
c0d00ce0:	2165      	movs	r1, #101	; 0x65
c0d00ce2:	7001      	strb	r1, [r0, #0]
    icon_component_mod.width = icon_details->width;
c0d00ce4:	80ea      	strh	r2, [r5, #6]
    icon_component_mod.height = icon_details->height;
c0d00ce6:	6861      	ldr	r1, [r4, #4]
c0d00ce8:	8129      	strh	r1, [r5, #8]
    icon_component_mod.width = icon_details->width;
c0d00cea:	b292      	uxth	r2, r2
    icon_component_mod.height = icon_details->height;
c0d00cec:	b289      	uxth	r1, r1
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d00cee:	4351      	muls	r1, r2
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d00cf0:	68a3      	ldr	r3, [r4, #8]
    unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d00cf2:	4359      	muls	r1, r3
c0d00cf4:	074a      	lsls	r2, r1, #29
c0d00cf6:	08ce      	lsrs	r6, r1, #3
c0d00cf8:	2a00      	cmp	r2, #0
c0d00cfa:	d000      	beq.n	c0d00cfe <io_seproxyhal_display_icon+0x4e>
c0d00cfc:	1c76      	adds	r6, r6, #1
c0d00cfe:	2704      	movs	r7, #4
    unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d00d00:	409f      	lsls	r7, r3
                            +h /* color index */
c0d00d02:	19b9      	adds	r1, r7, r6
                            +w; /* image bitmap size */
c0d00d04:	311d      	adds	r1, #29
    G_io_seproxyhal_spi_buffer[1] = length>>8;
    G_io_seproxyhal_spi_buffer[2] = length;
c0d00d06:	7081      	strb	r1, [r0, #2]
    G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d00d08:	0a09      	lsrs	r1, r1, #8
c0d00d0a:	7041      	strb	r1, [r0, #1]
c0d00d0c:	2103      	movs	r1, #3
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00d0e:	f000 fdd3 	bl	c0d018b8 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d00d12:	4628      	mov	r0, r5
c0d00d14:	9901      	ldr	r1, [sp, #4]
c0d00d16:	f000 fdcf 	bl	c0d018b8 <io_seph_send>
    G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d00d1a:	68a1      	ldr	r1, [r4, #8]
c0d00d1c:	4809      	ldr	r0, [pc, #36]	; (c0d00d44 <io_seproxyhal_display_icon+0x94>)
c0d00d1e:	7001      	strb	r1, [r0, #0]
c0d00d20:	2101      	movs	r1, #1
    io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d00d22:	f000 fdc9 	bl	c0d018b8 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d00d26:	68e0      	ldr	r0, [r4, #12]
c0d00d28:	f000 fd0e 	bl	c0d01748 <pic>
c0d00d2c:	b2b9      	uxth	r1, r7
c0d00d2e:	f000 fdc3 	bl	c0d018b8 <io_seph_send>
    io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d00d32:	b2b5      	uxth	r5, r6
c0d00d34:	6920      	ldr	r0, [r4, #16]
c0d00d36:	f000 fd07 	bl	c0d01748 <pic>
c0d00d3a:	4629      	mov	r1, r5
c0d00d3c:	f000 fdbc 	bl	c0d018b8 <io_seph_send>
  #endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
  }
}
c0d00d40:	b009      	add	sp, #36	; 0x24
c0d00d42:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00d44:	200003d0 	.word	0x200003d0

c0d00d48 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(const bagl_element_t * el) {
c0d00d48:	b570      	push	{r4, r5, r6, lr}

  const bagl_element_t* element = (const bagl_element_t*) PIC(el);
c0d00d4a:	f000 fcfd 	bl	c0d01748 <pic>
c0d00d4e:	4604      	mov	r4, r0

  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d00d50:	7806      	ldrb	r6, [r0, #0]

  // avoid sending another status :), fixes a lot of bugs in the end
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00d52:	f000 fdbd 	bl	c0d018d0 <io_seph_is_status_sent>
c0d00d56:	2800      	cmp	r0, #0
c0d00d58:	d131      	bne.n	c0d00dbe <io_seproxyhal_display_default+0x76>
c0d00d5a:	207f      	movs	r0, #127	; 0x7f
c0d00d5c:	4006      	ands	r6, r0
c0d00d5e:	d02e      	beq.n	c0d00dbe <io_seproxyhal_display_default+0x76>
    return;
  }

  if (type != BAGL_NONE) {
    if (element->text != NULL) {
c0d00d60:	69e0      	ldr	r0, [r4, #28]
c0d00d62:	2800      	cmp	r0, #0
c0d00d64:	d01d      	beq.n	c0d00da2 <io_seproxyhal_display_default+0x5a>
      unsigned int text_adr = (unsigned int)PIC((unsigned int)element->text);
c0d00d66:	f000 fcef 	bl	c0d01748 <pic>
c0d00d6a:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d00d6c:	2e05      	cmp	r6, #5
c0d00d6e:	d102      	bne.n	c0d00d76 <io_seproxyhal_display_default+0x2e>
c0d00d70:	7ea0      	ldrb	r0, [r4, #26]
c0d00d72:	2800      	cmp	r0, #0
c0d00d74:	d024      	beq.n	c0d00dc0 <io_seproxyhal_display_default+0x78>
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d00d76:	4628      	mov	r0, r5
c0d00d78:	f002 f9bc 	bl	c0d030f4 <strlen>
c0d00d7c:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00d7e:	4813      	ldr	r0, [pc, #76]	; (c0d00dcc <io_seproxyhal_display_default+0x84>)
c0d00d80:	2165      	movs	r1, #101	; 0x65
c0d00d82:	7001      	strb	r1, [r0, #0]
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d00d84:	4631      	mov	r1, r6
c0d00d86:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[1] = length>>8;
        G_io_seproxyhal_spi_buffer[2] = length;
c0d00d88:	7081      	strb	r1, [r0, #2]
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d00d8a:	0a09      	lsrs	r1, r1, #8
c0d00d8c:	7041      	strb	r1, [r0, #1]
c0d00d8e:	2103      	movs	r1, #3
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00d90:	f000 fd92 	bl	c0d018b8 <io_seph_send>
c0d00d94:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d00d96:	4620      	mov	r0, r4
c0d00d98:	f000 fd8e 	bl	c0d018b8 <io_seph_send>
        io_seproxyhal_spi_send((unsigned char*)text_adr, length-sizeof(bagl_component_t));
c0d00d9c:	b2b1      	uxth	r1, r6
c0d00d9e:	4628      	mov	r0, r5
c0d00da0:	e00b      	b.n	c0d00dba <io_seproxyhal_display_default+0x72>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00da2:	480a      	ldr	r0, [pc, #40]	; (c0d00dcc <io_seproxyhal_display_default+0x84>)
c0d00da4:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[1] = length>>8;
      G_io_seproxyhal_spi_buffer[2] = length;
c0d00da6:	7085      	strb	r5, [r0, #2]
c0d00da8:	2100      	movs	r1, #0
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d00daa:	7041      	strb	r1, [r0, #1]
c0d00dac:	2165      	movs	r1, #101	; 0x65
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00dae:	7001      	strb	r1, [r0, #0]
c0d00db0:	2103      	movs	r1, #3
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00db2:	f000 fd81 	bl	c0d018b8 <io_seph_send>
      io_seproxyhal_spi_send((unsigned char*)&element->component, sizeof(bagl_component_t));
c0d00db6:	4620      	mov	r0, r4
c0d00db8:	4629      	mov	r1, r5
c0d00dba:	f000 fd7d 	bl	c0d018b8 <io_seph_send>
    }
  }
}
c0d00dbe:	bd70      	pop	{r4, r5, r6, pc}
        io_seproxyhal_display_icon((bagl_component_t*)&element->component, (bagl_icon_details_t*)text_adr);
c0d00dc0:	4620      	mov	r0, r4
c0d00dc2:	4629      	mov	r1, r5
c0d00dc4:	f7ff ff74 	bl	c0d00cb0 <io_seproxyhal_display_icon>
}
c0d00dc8:	bd70      	pop	{r4, r5, r6, pc}
c0d00dca:	46c0      	nop			; (mov r8, r8)
c0d00dcc:	200003d0 	.word	0x200003d0

c0d00dd0 <io_seproxyhal_button_push>:
  
  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d00dd0:	b570      	push	{r4, r5, r6, lr}
  if (button_callback) {
c0d00dd2:	2800      	cmp	r0, #0
c0d00dd4:	d025      	beq.n	c0d00e22 <io_seproxyhal_button_push+0x52>
c0d00dd6:	460b      	mov	r3, r1
c0d00dd8:	4602      	mov	r2, r0
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_ux_os.button_mask) {
c0d00dda:	4c12      	ldr	r4, [pc, #72]	; (c0d00e24 <io_seproxyhal_button_push+0x54>)
c0d00ddc:	cc03      	ldmia	r4!, {r0, r1}
c0d00dde:	3c08      	subs	r4, #8
c0d00de0:	4298      	cmp	r0, r3
c0d00de2:	d101      	bne.n	c0d00de8 <io_seproxyhal_button_push+0x18>
      // each 100ms ~
      G_ux_os.button_same_mask_counter++;
c0d00de4:	1c49      	adds	r1, r1, #1
c0d00de6:	6061      	str	r1, [r4, #4]
    }

    // when new_button_mask is 0 and 

    // append the button mask
    button_mask = G_ux_os.button_mask | new_button_mask;
c0d00de8:	4318      	orrs	r0, r3

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_ux_os.button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
c0d00dea:	2b00      	cmp	r3, #0
c0d00dec:	d002      	beq.n	c0d00df4 <io_seproxyhal_button_push+0x24>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_ux_os.button_mask = button_mask;
c0d00dee:	6020      	str	r0, [r4, #0]
c0d00df0:	4605      	mov	r5, r0
c0d00df2:	e005      	b.n	c0d00e00 <io_seproxyhal_button_push+0x30>
c0d00df4:	2500      	movs	r5, #0
      G_ux_os.button_mask = 0;
c0d00df6:	6025      	str	r5, [r4, #0]
      G_ux_os.button_same_mask_counter=0;
c0d00df8:	6065      	str	r5, [r4, #4]
c0d00dfa:	4e0b      	ldr	r6, [pc, #44]	; (c0d00e28 <io_seproxyhal_button_push+0x58>)
      button_mask |= BUTTON_EVT_RELEASED;
c0d00dfc:	1c76      	adds	r6, r6, #1
c0d00dfe:	4330      	orrs	r0, r6
    }

    // reset counter when button mask changes
    if (new_button_mask != G_ux_os.button_mask) {
c0d00e00:	429d      	cmp	r5, r3
c0d00e02:	d001      	beq.n	c0d00e08 <io_seproxyhal_button_push+0x38>
c0d00e04:	2300      	movs	r3, #0
      G_ux_os.button_same_mask_counter=0;
c0d00e06:	6063      	str	r3, [r4, #4]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d00e08:	2908      	cmp	r1, #8
c0d00e0a:	d309      	bcc.n	c0d00e20 <io_seproxyhal_button_push+0x50>
c0d00e0c:	4c07      	ldr	r4, [pc, #28]	; (c0d00e2c <io_seproxyhal_button_push+0x5c>)
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d00e0e:	434c      	muls	r4, r1
c0d00e10:	2301      	movs	r3, #1
c0d00e12:	4d07      	ldr	r5, [pc, #28]	; (c0d00e30 <io_seproxyhal_button_push+0x60>)
c0d00e14:	42ac      	cmp	r4, r5
c0d00e16:	d201      	bcs.n	c0d00e1c <io_seproxyhal_button_push+0x4c>
c0d00e18:	079c      	lsls	r4, r3, #30
c0d00e1a:	4320      	orrs	r0, r4
c0d00e1c:	07db      	lsls	r3, r3, #31
      }
      */

      // discard the release event after a fastskip has been detected, to avoid strange at release behavior
      // and also to enable user to cancel an operation by starting triggering the fast skip
      button_mask &= ~BUTTON_EVT_RELEASED;
c0d00e1e:	4398      	bics	r0, r3
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d00e20:	4790      	blx	r2

  }
}
c0d00e22:	bd70      	pop	{r4, r5, r6, pc}
c0d00e24:	20000574 	.word	0x20000574
c0d00e28:	7fffffff 	.word	0x7fffffff
c0d00e2c:	aaaaaaab 	.word	0xaaaaaaab
c0d00e30:	55555556 	.word	0x55555556

c0d00e34 <os_io_seproxyhal_get_app_name_and_version>:
#ifdef HAVE_IO_U2F
u2f_service_t G_io_u2f;
#endif // HAVE_IO_U2F

unsigned int os_io_seproxyhal_get_app_name_and_version(void) __attribute__((weak));
unsigned int os_io_seproxyhal_get_app_name_and_version(void) {
c0d00e34:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e36:	b081      	sub	sp, #4
  unsigned int tx_len, len;
  // build the get app name and version reply
  tx_len = 0;
  G_io_apdu_buffer[tx_len++] = 1; // format ID
c0d00e38:	4e0f      	ldr	r6, [pc, #60]	; (c0d00e78 <os_io_seproxyhal_get_app_name_and_version+0x44>)
c0d00e3a:	2401      	movs	r4, #1
c0d00e3c:	7034      	strb	r4, [r6, #0]

#ifndef HAVE_BOLOS
  // append app name
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPNAME, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len-1);
c0d00e3e:	1cb1      	adds	r1, r6, #2
c0d00e40:	27ff      	movs	r7, #255	; 0xff
c0d00e42:	3702      	adds	r7, #2
c0d00e44:	1c7a      	adds	r2, r7, #1
c0d00e46:	4620      	mov	r0, r4
c0d00e48:	f000 fd1c 	bl	c0d01884 <os_registry_get_current_app_tag>
c0d00e4c:	4605      	mov	r5, r0
  G_io_apdu_buffer[tx_len++] = len;
c0d00e4e:	7070      	strb	r0, [r6, #1]
  tx_len += len;
  // append app version
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len-1);
c0d00e50:	1a3a      	subs	r2, r7, r0
  tx_len += len;
c0d00e52:	1987      	adds	r7, r0, r6
  len = os_registry_get_current_app_tag(BOLOS_TAG_APPVERSION, G_io_apdu_buffer+tx_len+1, sizeof(G_io_apdu_buffer)-tx_len-1);
c0d00e54:	1cf9      	adds	r1, r7, #3
c0d00e56:	2002      	movs	r0, #2
c0d00e58:	f000 fd14 	bl	c0d01884 <os_registry_get_current_app_tag>
  G_io_apdu_buffer[tx_len++] = len;
c0d00e5c:	70b8      	strb	r0, [r7, #2]
c0d00e5e:	182d      	adds	r5, r5, r0
  tx_len += len;
c0d00e60:	19ae      	adds	r6, r5, r6
#endif // HAVE_BOLOS

#if !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)
  // to be fixed within io tasks
  // return OS flags to notify of platform's global state (pin lock etc)
  G_io_apdu_buffer[tx_len++] = 1; // flags length
c0d00e62:	70f4      	strb	r4, [r6, #3]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d00e64:	f000 fd02 	bl	c0d0186c <os_flags>
c0d00e68:	2100      	movs	r1, #0
#endif // !defined(HAVE_IO_TASK) || !defined(HAVE_BOLOS)

  // status words
  G_io_apdu_buffer[tx_len++] = 0x90;
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d00e6a:	71b1      	strb	r1, [r6, #6]
c0d00e6c:	2190      	movs	r1, #144	; 0x90
  G_io_apdu_buffer[tx_len++] = 0x90;
c0d00e6e:	7171      	strb	r1, [r6, #5]
  G_io_apdu_buffer[tx_len++] = os_flags();
c0d00e70:	7130      	strb	r0, [r6, #4]
  G_io_apdu_buffer[tx_len++] = 0x00;
c0d00e72:	1de8      	adds	r0, r5, #7
  return tx_len;
c0d00e74:	b001      	add	sp, #4
c0d00e76:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e78:	20000450 	.word	0x20000450

c0d00e7c <io_exchange>:
  return processed;
}

#endif // HAVE_BOLOS_NO_DEFAULT_APDU

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d00e7c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e7e:	b085      	sub	sp, #20
    }
  }
#endif // DEBUG_APDU

reply_apdu:
  switch(channel&~(IO_FLAGS)) {
c0d00e80:	0742      	lsls	r2, r0, #29
c0d00e82:	d007      	beq.n	c0d00e94 <io_exchange+0x18>
c0d00e84:	4606      	mov	r6, r0
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d00e86:	b2f0      	uxtb	r0, r6
c0d00e88:	b289      	uxth	r1, r1
c0d00e8a:	f7ff fcc3 	bl	c0d00814 <io_exchange_al>
  }
}
c0d00e8e:	b280      	uxth	r0, r0
c0d00e90:	b005      	add	sp, #20
c0d00e92:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00e94:	2701      	movs	r7, #1
c0d00e96:	4d90      	ldr	r5, [pc, #576]	; (c0d010d8 <io_exchange+0x25c>)
c0d00e98:	4c8e      	ldr	r4, [pc, #568]	; (c0d010d4 <io_exchange+0x258>)
c0d00e9a:	4606      	mov	r6, r0
c0d00e9c:	2210      	movs	r2, #16
c0d00e9e:	4002      	ands	r2, r0
    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d00ea0:	040b      	lsls	r3, r1, #16
c0d00ea2:	9604      	str	r6, [sp, #16]
c0d00ea4:	d07a      	beq.n	c0d00f9c <io_exchange+0x120>
c0d00ea6:	2a00      	cmp	r2, #0
c0d00ea8:	d178      	bne.n	c0d00f9c <io_exchange+0x120>
c0d00eaa:	9101      	str	r1, [sp, #4]
c0d00eac:	9202      	str	r2, [sp, #8]
c0d00eae:	9003      	str	r0, [sp, #12]
      while (io_seproxyhal_spi_is_status_sent()) {
c0d00eb0:	f000 fd0e 	bl	c0d018d0 <io_seph_is_status_sent>
c0d00eb4:	2800      	cmp	r0, #0
c0d00eb6:	d008      	beq.n	c0d00eca <io_exchange+0x4e>
c0d00eb8:	2180      	movs	r1, #128	; 0x80
c0d00eba:	2200      	movs	r2, #0
        io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00ebc:	4620      	mov	r0, r4
c0d00ebe:	f000 fd13 	bl	c0d018e8 <io_seph_recv>
c0d00ec2:	2001      	movs	r0, #1
        os_io_seph_recv_and_process(1);
c0d00ec4:	f000 f916 	bl	c0d010f4 <os_io_seph_recv_and_process>
c0d00ec8:	e7f2      	b.n	c0d00eb0 <io_exchange+0x34>
      timeout_ms = G_io_app.ms + IO_RAPDU_TRANSMIT_TIMEOUT_MS;
c0d00eca:	68a8      	ldr	r0, [r5, #8]
        switch(G_io_app.apdu_state) {
c0d00ecc:	9000      	str	r0, [sp, #0]
c0d00ece:	7828      	ldrb	r0, [r5, #0]
c0d00ed0:	2809      	cmp	r0, #9
c0d00ed2:	dd07      	ble.n	c0d00ee4 <io_exchange+0x68>
c0d00ed4:	280a      	cmp	r0, #10
c0d00ed6:	9901      	ldr	r1, [sp, #4]
c0d00ed8:	d00d      	beq.n	c0d00ef6 <io_exchange+0x7a>
c0d00eda:	280b      	cmp	r0, #11
c0d00edc:	d122      	bne.n	c0d00f24 <io_exchange+0xa8>
c0d00ede:	4882      	ldr	r0, [pc, #520]	; (c0d010e8 <io_exchange+0x26c>)
c0d00ee0:	4478      	add	r0, pc
c0d00ee2:	e004      	b.n	c0d00eee <io_exchange+0x72>
c0d00ee4:	2807      	cmp	r0, #7
c0d00ee6:	9901      	ldr	r1, [sp, #4]
c0d00ee8:	d119      	bne.n	c0d00f1e <io_exchange+0xa2>
c0d00eea:	487d      	ldr	r0, [pc, #500]	; (c0d010e0 <io_exchange+0x264>)
c0d00eec:	4478      	add	r0, pc
c0d00eee:	b289      	uxth	r1, r1
c0d00ef0:	f000 fa48 	bl	c0d01384 <io_usb_hid_send>
c0d00ef4:	e01d      	b.n	c0d00f32 <io_exchange+0xb6>
c0d00ef6:	20ff      	movs	r0, #255	; 0xff
c0d00ef8:	3006      	adds	r0, #6
            if (tx_len > sizeof(G_io_apdu_buffer)) {
c0d00efa:	b28e      	uxth	r6, r1
c0d00efc:	4286      	cmp	r6, r0
c0d00efe:	d300      	bcc.n	c0d00f02 <io_exchange+0x86>
c0d00f00:	e0e4      	b.n	c0d010cc <io_exchange+0x250>
            G_io_seproxyhal_spi_buffer[2]  = (tx_len);
c0d00f02:	70a1      	strb	r1, [r4, #2]
c0d00f04:	2053      	movs	r0, #83	; 0x53
            G_io_seproxyhal_spi_buffer[0]  = SEPROXYHAL_TAG_RAPDU;
c0d00f06:	7020      	strb	r0, [r4, #0]
            G_io_seproxyhal_spi_buffer[1]  = (tx_len)>>8;
c0d00f08:	0a08      	lsrs	r0, r1, #8
c0d00f0a:	7060      	strb	r0, [r4, #1]
c0d00f0c:	2103      	movs	r1, #3
            io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00f0e:	4620      	mov	r0, r4
c0d00f10:	f000 fcd2 	bl	c0d018b8 <io_seph_send>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d00f14:	4871      	ldr	r0, [pc, #452]	; (c0d010dc <io_exchange+0x260>)
c0d00f16:	4631      	mov	r1, r6
c0d00f18:	f000 fcce 	bl	c0d018b8 <io_seph_send>
c0d00f1c:	e027      	b.n	c0d00f6e <io_exchange+0xf2>
        switch(G_io_app.apdu_state) {
c0d00f1e:	2800      	cmp	r0, #0
c0d00f20:	d100      	bne.n	c0d00f24 <io_exchange+0xa8>
c0d00f22:	e0d0      	b.n	c0d010c6 <io_exchange+0x24a>
            if (io_exchange_al(channel, tx_len) == 0) {
c0d00f24:	b2f0      	uxtb	r0, r6
c0d00f26:	b289      	uxth	r1, r1
c0d00f28:	f7ff fc74 	bl	c0d00814 <io_exchange_al>
c0d00f2c:	2800      	cmp	r0, #0
c0d00f2e:	d000      	beq.n	c0d00f32 <io_exchange+0xb6>
c0d00f30:	e0c9      	b.n	c0d010c6 <io_exchange+0x24a>
        while (G_io_app.apdu_state != APDU_IDLE) {
c0d00f32:	7828      	ldrb	r0, [r5, #0]
c0d00f34:	2800      	cmp	r0, #0
c0d00f36:	d01a      	beq.n	c0d00f6e <io_exchange+0xf2>
c0d00f38:	207d      	movs	r0, #125	; 0x7d
c0d00f3a:	0100      	lsls	r0, r0, #4
c0d00f3c:	9900      	ldr	r1, [sp, #0]
c0d00f3e:	180e      	adds	r6, r1, r0
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d00f40:	486a      	ldr	r0, [pc, #424]	; (c0d010ec <io_exchange+0x270>)
c0d00f42:	4478      	add	r0, pc
c0d00f44:	2105      	movs	r1, #5
c0d00f46:	f000 fcb7 	bl	c0d018b8 <io_seph_send>
c0d00f4a:	2180      	movs	r1, #128	; 0x80
c0d00f4c:	2200      	movs	r2, #0
            io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00f4e:	4620      	mov	r0, r4
c0d00f50:	f000 fcca 	bl	c0d018e8 <io_seph_recv>
            if (G_io_app.ms >= timeout_ms) {
c0d00f54:	68a8      	ldr	r0, [r5, #8]
c0d00f56:	42b0      	cmp	r0, r6
c0d00f58:	d300      	bcc.n	c0d00f5c <io_exchange+0xe0>
c0d00f5a:	e0b1      	b.n	c0d010c0 <io_exchange+0x244>
            io_seproxyhal_handle_event();
c0d00f5c:	f7ff fe32 	bl	c0d00bc4 <io_seproxyhal_handle_event>
          } while (io_seproxyhal_spi_is_status_sent());
c0d00f60:	f000 fcb6 	bl	c0d018d0 <io_seph_is_status_sent>
c0d00f64:	2800      	cmp	r0, #0
c0d00f66:	d1f0      	bne.n	c0d00f4a <io_exchange+0xce>
        while (G_io_app.apdu_state != APDU_IDLE) {
c0d00f68:	7828      	ldrb	r0, [r5, #0]
c0d00f6a:	2800      	cmp	r0, #0
c0d00f6c:	d1e8      	bne.n	c0d00f40 <io_exchange+0xc4>
c0d00f6e:	2000      	movs	r0, #0
        G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d00f70:	71a8      	strb	r0, [r5, #6]
        G_io_app.apdu_state = APDU_IDLE;
c0d00f72:	7028      	strb	r0, [r5, #0]
        G_io_app.apdu_length = 0;
c0d00f74:	8068      	strh	r0, [r5, #2]
        if (channel & IO_RETURN_AFTER_TX) {
c0d00f76:	9904      	ldr	r1, [sp, #16]
c0d00f78:	0689      	lsls	r1, r1, #26
c0d00f7a:	d488      	bmi.n	c0d00e8e <io_exchange+0x12>
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d00f7c:	4859      	ldr	r0, [pc, #356]	; (c0d010e4 <io_exchange+0x268>)
c0d00f7e:	4478      	add	r0, pc
c0d00f80:	2105      	movs	r1, #5
c0d00f82:	f000 fc99 	bl	c0d018b8 <io_seph_send>
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d00f86:	9804      	ldr	r0, [sp, #16]
c0d00f88:	b240      	sxtb	r0, r0
c0d00f8a:	2800      	cmp	r0, #0
c0d00f8c:	9803      	ldr	r0, [sp, #12]
c0d00f8e:	9a02      	ldr	r2, [sp, #8]
c0d00f90:	d504      	bpl.n	c0d00f9c <io_exchange+0x120>
c0d00f92:	2005      	movs	r0, #5
        os_sched_exit((bolos_task_status_t)EXCEPTION_IO_RESET);
c0d00f94:	f000 fc82 	bl	c0d0189c <os_sched_exit>
c0d00f98:	9a02      	ldr	r2, [sp, #8]
c0d00f9a:	9803      	ldr	r0, [sp, #12]
    if (!(channel&IO_ASYNCH_REPLY)) {
c0d00f9c:	2a00      	cmp	r2, #0
c0d00f9e:	d105      	bne.n	c0d00fac <io_exchange+0x130>
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d00fa0:	0640      	lsls	r0, r0, #25
c0d00fa2:	d500      	bpl.n	c0d00fa6 <io_exchange+0x12a>
c0d00fa4:	e089      	b.n	c0d010ba <io_exchange+0x23e>
c0d00fa6:	2000      	movs	r0, #0
      G_io_app.apdu_media = IO_APDU_MEDIA_NONE;
c0d00fa8:	71a8      	strb	r0, [r5, #6]
c0d00faa:	7028      	strb	r0, [r5, #0]
c0d00fac:	2000      	movs	r0, #0
c0d00fae:	8068      	strh	r0, [r5, #2]
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d00fb0:	484f      	ldr	r0, [pc, #316]	; (c0d010f0 <io_exchange+0x274>)
c0d00fb2:	4478      	add	r0, pc
c0d00fb4:	2105      	movs	r1, #5
c0d00fb6:	f000 fc7f 	bl	c0d018b8 <io_seph_send>
c0d00fba:	2180      	movs	r1, #128	; 0x80
c0d00fbc:	2600      	movs	r6, #0
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00fbe:	4620      	mov	r0, r4
c0d00fc0:	4632      	mov	r2, r6
c0d00fc2:	f000 fc91 	bl	c0d018e8 <io_seph_recv>
      if (rx_len < 3 || rx_len != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])+3U) {
c0d00fc6:	2803      	cmp	r0, #3
c0d00fc8:	d331      	bcc.n	c0d0102e <io_exchange+0x1b2>
c0d00fca:	78a1      	ldrb	r1, [r4, #2]
c0d00fcc:	7862      	ldrb	r2, [r4, #1]
c0d00fce:	0212      	lsls	r2, r2, #8
c0d00fd0:	1851      	adds	r1, r2, r1
c0d00fd2:	1cc9      	adds	r1, r1, #3
c0d00fd4:	4281      	cmp	r1, r0
c0d00fd6:	d12a      	bne.n	c0d0102e <io_exchange+0x1b2>
      io_seproxyhal_handle_event();
c0d00fd8:	f7ff fdf4 	bl	c0d00bc4 <io_seproxyhal_handle_event>
c0d00fdc:	8868      	ldrh	r0, [r5, #2]
c0d00fde:	4241      	negs	r1, r0
c0d00fe0:	4141      	adcs	r1, r0
      if (G_io_app.apdu_state != APDU_IDLE && G_io_app.apdu_length > 0) {
c0d00fe2:	782a      	ldrb	r2, [r5, #0]
c0d00fe4:	2a00      	cmp	r2, #0
c0d00fe6:	463a      	mov	r2, r7
c0d00fe8:	d000      	beq.n	c0d00fec <io_exchange+0x170>
c0d00fea:	460a      	mov	r2, r1
c0d00fec:	2a00      	cmp	r2, #0
c0d00fee:	d1df      	bne.n	c0d00fb0 <io_exchange+0x134>
c0d00ff0:	4b3a      	ldr	r3, [pc, #232]	; (c0d010dc <io_exchange+0x260>)
  if (DEFAULT_APDU_CLA == G_io_apdu_buffer[APDU_OFF_CLA]) {
c0d00ff2:	7819      	ldrb	r1, [r3, #0]
c0d00ff4:	29b0      	cmp	r1, #176	; 0xb0
c0d00ff6:	d000      	beq.n	c0d00ffa <io_exchange+0x17e>
c0d00ff8:	e749      	b.n	c0d00e8e <io_exchange+0x12>
    switch (G_io_apdu_buffer[APDU_OFF_INS]) {
c0d00ffa:	7859      	ldrb	r1, [r3, #1]
c0d00ffc:	29a7      	cmp	r1, #167	; 0xa7
c0d00ffe:	d018      	beq.n	c0d01032 <io_exchange+0x1b6>
c0d01000:	2902      	cmp	r1, #2
c0d01002:	d02c      	beq.n	c0d0105e <io_exchange+0x1e2>
c0d01004:	2901      	cmp	r1, #1
c0d01006:	d000      	beq.n	c0d0100a <io_exchange+0x18e>
c0d01008:	e741      	b.n	c0d00e8e <io_exchange+0x12>
c0d0100a:	78d9      	ldrb	r1, [r3, #3]
c0d0100c:	1e4a      	subs	r2, r1, #1
c0d0100e:	4191      	sbcs	r1, r2
        if (!G_io_apdu_buffer[APDU_OFF_P1] && !G_io_apdu_buffer[APDU_OFF_P2]) {
c0d01010:	789a      	ldrb	r2, [r3, #2]
c0d01012:	2a00      	cmp	r2, #0
c0d01014:	463a      	mov	r2, r7
c0d01016:	d100      	bne.n	c0d0101a <io_exchange+0x19e>
c0d01018:	460a      	mov	r2, r1
c0d0101a:	2a00      	cmp	r2, #0
c0d0101c:	d000      	beq.n	c0d01020 <io_exchange+0x1a4>
c0d0101e:	e736      	b.n	c0d00e8e <io_exchange+0x12>
c0d01020:	2007      	movs	r0, #7
c0d01022:	9e04      	ldr	r6, [sp, #16]
          *channel &= ~IO_FLAGS;
c0d01024:	4006      	ands	r6, r0
          *tx_len = os_io_seproxyhal_get_app_name_and_version();
c0d01026:	f7ff ff05 	bl	c0d00e34 <os_io_seproxyhal_get_app_name_and_version>
c0d0102a:	4601      	mov	r1, r0
c0d0102c:	e040      	b.n	c0d010b0 <io_exchange+0x234>
c0d0102e:	2000      	movs	r0, #0
c0d01030:	e7bb      	b.n	c0d00faa <io_exchange+0x12e>
c0d01032:	78d9      	ldrb	r1, [r3, #3]
c0d01034:	1e4a      	subs	r2, r1, #1
c0d01036:	4191      	sbcs	r1, r2
        if (!G_io_apdu_buffer[APDU_OFF_P1] && !G_io_apdu_buffer[APDU_OFF_P2]) {
c0d01038:	789a      	ldrb	r2, [r3, #2]
c0d0103a:	2a00      	cmp	r2, #0
c0d0103c:	463a      	mov	r2, r7
c0d0103e:	d100      	bne.n	c0d01042 <io_exchange+0x1c6>
c0d01040:	460a      	mov	r2, r1
c0d01042:	2a00      	cmp	r2, #0
c0d01044:	d000      	beq.n	c0d01048 <io_exchange+0x1cc>
c0d01046:	e722      	b.n	c0d00e8e <io_exchange+0x12>
c0d01048:	2000      	movs	r0, #0
c0d0104a:	4924      	ldr	r1, [pc, #144]	; (c0d010dc <io_exchange+0x260>)
          G_io_apdu_buffer[(*tx_len)++] = 0x00;
c0d0104c:	7048      	strb	r0, [r1, #1]
c0d0104e:	2090      	movs	r0, #144	; 0x90
          G_io_apdu_buffer[(*tx_len)++] = 0x90;
c0d01050:	7008      	strb	r0, [r1, #0]
c0d01052:	207f      	movs	r0, #127	; 0x7f
c0d01054:	43c0      	mvns	r0, r0
c0d01056:	9e04      	ldr	r6, [sp, #16]
          *channel |= IO_RESET_AFTER_REPLIED;
c0d01058:	4306      	orrs	r6, r0
c0d0105a:	2102      	movs	r1, #2
c0d0105c:	e028      	b.n	c0d010b0 <io_exchange+0x234>
c0d0105e:	78d9      	ldrb	r1, [r3, #3]
c0d01060:	1e4a      	subs	r2, r1, #1
c0d01062:	4191      	sbcs	r1, r2
        if (!G_io_apdu_buffer[APDU_OFF_P1] && !G_io_apdu_buffer[APDU_OFF_P2]) {
c0d01064:	789a      	ldrb	r2, [r3, #2]
c0d01066:	2a00      	cmp	r2, #0
c0d01068:	463a      	mov	r2, r7
c0d0106a:	d100      	bne.n	c0d0106e <io_exchange+0x1f2>
c0d0106c:	460a      	mov	r2, r1
c0d0106e:	2a00      	cmp	r2, #0
c0d01070:	d000      	beq.n	c0d01074 <io_exchange+0x1f8>
c0d01072:	e70c      	b.n	c0d00e8e <io_exchange+0x12>
          if (os_global_pin_is_validated() == BOLOS_UX_OK) {
c0d01074:	f000 fbde 	bl	c0d01834 <os_global_pin_is_validated>
c0d01078:	28aa      	cmp	r0, #170	; 0xaa
c0d0107a:	d10e      	bne.n	c0d0109a <io_exchange+0x21e>
c0d0107c:	2001      	movs	r0, #1
c0d0107e:	4917      	ldr	r1, [pc, #92]	; (c0d010dc <io_exchange+0x260>)
            G_io_apdu_buffer[(*tx_len)++] = 0x01;
c0d01080:	7008      	strb	r0, [r1, #0]
            i = os_perso_seed_cookie(G_io_apdu_buffer+1+1, MIN(64,sizeof(G_io_apdu_buffer)-1-1-2));
c0d01082:	1c88      	adds	r0, r1, #2
c0d01084:	2140      	movs	r1, #64	; 0x40
c0d01086:	f000 fbc9 	bl	c0d0181c <os_perso_seed_cookie>
c0d0108a:	4b14      	ldr	r3, [pc, #80]	; (c0d010dc <io_exchange+0x260>)
            G_io_apdu_buffer[(*tx_len)++] = i;
c0d0108c:	7058      	strb	r0, [r3, #1]
            *tx_len += i;
c0d0108e:	1c81      	adds	r1, r0, #2
            G_io_apdu_buffer[(*tx_len)++] = 0x90;
c0d01090:	b289      	uxth	r1, r1
c0d01092:	2290      	movs	r2, #144	; 0x90
c0d01094:	545a      	strb	r2, [r3, r1]
c0d01096:	1cc0      	adds	r0, r0, #3
c0d01098:	e004      	b.n	c0d010a4 <io_exchange+0x228>
c0d0109a:	2069      	movs	r0, #105	; 0x69
c0d0109c:	4b0f      	ldr	r3, [pc, #60]	; (c0d010dc <io_exchange+0x260>)
            G_io_apdu_buffer[(*tx_len)++] = 0x69;
c0d0109e:	7018      	strb	r0, [r3, #0]
c0d010a0:	2685      	movs	r6, #133	; 0x85
c0d010a2:	2001      	movs	r0, #1
c0d010a4:	b281      	uxth	r1, r0
c0d010a6:	545e      	strb	r6, [r3, r1]
c0d010a8:	2107      	movs	r1, #7
c0d010aa:	9e04      	ldr	r6, [sp, #16]
          *channel &= ~IO_FLAGS;
c0d010ac:	400e      	ands	r6, r1
c0d010ae:	1c41      	adds	r1, r0, #1
  switch(channel&~(IO_FLAGS)) {
c0d010b0:	b2f0      	uxtb	r0, r6
c0d010b2:	0772      	lsls	r2, r6, #29
c0d010b4:	d100      	bne.n	c0d010b8 <io_exchange+0x23c>
c0d010b6:	e6f1      	b.n	c0d00e9c <io_exchange+0x20>
c0d010b8:	e6e5      	b.n	c0d00e86 <io_exchange+0xa>
        return G_io_app.apdu_length-5;
c0d010ba:	8868      	ldrh	r0, [r5, #2]
c0d010bc:	1f40      	subs	r0, r0, #5
c0d010be:	e6e6      	b.n	c0d00e8e <io_exchange+0x12>
c0d010c0:	2005      	movs	r0, #5
              THROW(EXCEPTION_IO_RESET);
c0d010c2:	f7ff fcbf 	bl	c0d00a44 <os_longjmp>
c0d010c6:	2004      	movs	r0, #4
            THROW(INVALID_STATE);
c0d010c8:	f7ff fcbc 	bl	c0d00a44 <os_longjmp>
c0d010cc:	2002      	movs	r0, #2
              THROW(INVALID_PARAMETER);
c0d010ce:	f7ff fcb9 	bl	c0d00a44 <os_longjmp>
c0d010d2:	46c0      	nop			; (mov r8, r8)
c0d010d4:	200003d0 	.word	0x200003d0
c0d010d8:	20000554 	.word	0x20000554
c0d010dc:	20000450 	.word	0x20000450
c0d010e0:	fffffcb5 	.word	0xfffffcb5
c0d010e4:	000024c4 	.word	0x000024c4
c0d010e8:	fffffcd1 	.word	0xfffffcd1
c0d010ec:	00002500 	.word	0x00002500
c0d010f0:	00002490 	.word	0x00002490

c0d010f4 <os_io_seph_recv_and_process>:

unsigned int os_io_seph_recv_and_process(unsigned int dont_process_ux_events) {
c0d010f4:	b570      	push	{r4, r5, r6, lr}
c0d010f6:	4604      	mov	r4, r0
  io_seproxyhal_spi_send(seph_io_general_status, sizeof(seph_io_general_status));
c0d010f8:	4810      	ldr	r0, [pc, #64]	; (c0d0113c <os_io_seph_recv_and_process+0x48>)
c0d010fa:	4478      	add	r0, pc
c0d010fc:	2105      	movs	r1, #5
c0d010fe:	f000 fbdb 	bl	c0d018b8 <io_seph_send>
  // send general status before receiving next event
  io_seproxyhal_general_status();

  io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01102:	4e0c      	ldr	r6, [pc, #48]	; (c0d01134 <os_io_seph_recv_and_process+0x40>)
c0d01104:	2180      	movs	r1, #128	; 0x80
c0d01106:	2500      	movs	r5, #0
c0d01108:	4630      	mov	r0, r6
c0d0110a:	462a      	mov	r2, r5
c0d0110c:	f000 fbec 	bl	c0d018e8 <io_seph_recv>

  switch (G_io_seproxyhal_spi_buffer[0]) {
c0d01110:	7830      	ldrb	r0, [r6, #0]
c0d01112:	2815      	cmp	r0, #21
c0d01114:	d806      	bhi.n	c0d01124 <os_io_seph_recv_and_process+0x30>
c0d01116:	2101      	movs	r1, #1
c0d01118:	4081      	lsls	r1, r0
c0d0111a:	4807      	ldr	r0, [pc, #28]	; (c0d01138 <os_io_seph_recv_and_process+0x44>)
c0d0111c:	4201      	tst	r1, r0
c0d0111e:	d001      	beq.n	c0d01124 <os_io_seph_recv_and_process+0x30>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT:
    case SEPROXYHAL_TAG_TICKER_EVENT:
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
    case SEPROXYHAL_TAG_STATUS_EVENT:
      // perform UX event on these ones, don't process as an IO event
      if (dont_process_ux_events) {
c0d01120:	2c00      	cmp	r4, #0
c0d01122:	d104      	bne.n	c0d0112e <os_io_seph_recv_and_process+0x3a>
      }
      __attribute__((fallthrough));

    default:
      // if malformed, then a stall is likely to occur
      if (io_seproxyhal_handle_event()) {
c0d01124:	f7ff fd4e 	bl	c0d00bc4 <io_seproxyhal_handle_event>
c0d01128:	4605      	mov	r5, r0
c0d0112a:	1e40      	subs	r0, r0, #1
c0d0112c:	4185      	sbcs	r5, r0
        return 1;
      }
  }
  return 0;
}
c0d0112e:	4628      	mov	r0, r5
c0d01130:	bd70      	pop	{r4, r5, r6, pc}
c0d01132:	46c0      	nop			; (mov r8, r8)
c0d01134:	200003d0 	.word	0x200003d0
c0d01138:	00207020 	.word	0x00207020
c0d0113c:	00002348 	.word	0x00002348

c0d01140 <mcu_usb_printc>:

  return ret;
} 

// so unoptimized
void mcu_usb_printc(unsigned char c) {
c0d01140:	b5b0      	push	{r4, r5, r7, lr}
c0d01142:	b082      	sub	sp, #8
c0d01144:	ac01      	add	r4, sp, #4
#else // TARGET_NANOX
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
#endif // TARGET_NANOX
  buf[1] = 0;
  buf[2] = 1;
  buf[3] = c;
c0d01146:	70e0      	strb	r0, [r4, #3]
c0d01148:	2001      	movs	r0, #1
  buf[2] = 1;
c0d0114a:	70a0      	strb	r0, [r4, #2]
c0d0114c:	2500      	movs	r5, #0
  buf[1] = 0;
c0d0114e:	7065      	strb	r5, [r4, #1]
c0d01150:	2066      	movs	r0, #102	; 0x66
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
c0d01152:	7020      	strb	r0, [r4, #0]
c0d01154:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buf, 4);
c0d01156:	4620      	mov	r0, r4
c0d01158:	f000 fbae 	bl	c0d018b8 <io_seph_send>
c0d0115c:	2103      	movs	r1, #3
#ifndef TARGET_NANOX
#ifndef IO_SEPROXYHAL_DEBUG
  // wait printf ack (no race kthx)
  io_seproxyhal_spi_recv(buf, 3, 0);
c0d0115e:	4620      	mov	r0, r4
c0d01160:	462a      	mov	r2, r5
c0d01162:	f000 fbc1 	bl	c0d018e8 <io_seph_recv>
  buf[0] = 0; // consume tag to avoid misinterpretation (due to IO_CACHE)
#endif // IO_SEPROXYHAL_DEBUG
#endif // TARGET_NANOX
}
c0d01166:	b002      	add	sp, #8
c0d01168:	bdb0      	pop	{r4, r5, r7, pc}
	...

c0d0116c <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_channel;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d0116c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0116e:	b081      	sub	sp, #4
c0d01170:	9200      	str	r2, [sp, #0]
c0d01172:	4604      	mov	r4, r0
  // avoid over/under flows
  if (buffer != G_io_usb_ep_buffer) {
c0d01174:	4f46      	ldr	r7, [pc, #280]	; (c0d01290 <io_usb_hid_receive+0x124>)
c0d01176:	42b9      	cmp	r1, r7
c0d01178:	d00f      	beq.n	c0d0119a <io_usb_hid_receive+0x2e>
c0d0117a:	460e      	mov	r6, r1
    memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d0117c:	4f44      	ldr	r7, [pc, #272]	; (c0d01290 <io_usb_hid_receive+0x124>)
c0d0117e:	2540      	movs	r5, #64	; 0x40
c0d01180:	4638      	mov	r0, r7
c0d01182:	4629      	mov	r1, r5
c0d01184:	f001 ff60 	bl	c0d03048 <__aeabi_memclr>
c0d01188:	9a00      	ldr	r2, [sp, #0]
    memmove(G_io_usb_ep_buffer, buffer, MIN(l, sizeof(G_io_usb_ep_buffer)));
c0d0118a:	2a40      	cmp	r2, #64	; 0x40
c0d0118c:	d300      	bcc.n	c0d01190 <io_usb_hid_receive+0x24>
c0d0118e:	462a      	mov	r2, r5
c0d01190:	4638      	mov	r0, r7
c0d01192:	4631      	mov	r1, r6
c0d01194:	f001 ff61 	bl	c0d0305a <__aeabi_memmove>
c0d01198:	4f3d      	ldr	r7, [pc, #244]	; (c0d01290 <io_usb_hid_receive+0x124>)
  }

  // process the chunk content
  switch(G_io_usb_ep_buffer[2]) {
c0d0119a:	78b8      	ldrb	r0, [r7, #2]
c0d0119c:	2801      	cmp	r0, #1
c0d0119e:	dc08      	bgt.n	c0d011b2 <io_usb_hid_receive+0x46>
c0d011a0:	2800      	cmp	r0, #0
c0d011a2:	d02b      	beq.n	c0d011fc <io_usb_hid_receive+0x90>
c0d011a4:	2801      	cmp	r0, #1
c0d011a6:	d16b      	bne.n	c0d01280 <io_usb_hid_receive+0x114>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng_no_throw(G_io_usb_ep_buffer+3, 4);
c0d011a8:	1cf8      	adds	r0, r7, #3
c0d011aa:	2104      	movs	r1, #4
c0d011ac:	f7fe ffbe 	bl	c0d0012c <cx_rng_no_throw>
c0d011b0:	e029      	b.n	c0d01206 <io_usb_hid_receive+0x9a>
  switch(G_io_usb_ep_buffer[2]) {
c0d011b2:	2802      	cmp	r0, #2
c0d011b4:	d027      	beq.n	c0d01206 <io_usb_hid_receive+0x9a>
c0d011b6:	2805      	cmp	r0, #5
c0d011b8:	d162      	bne.n	c0d01280 <io_usb_hid_receive+0x114>
c0d011ba:	7938      	ldrb	r0, [r7, #4]
c0d011bc:	78f9      	ldrb	r1, [r7, #3]
c0d011be:	0209      	lsls	r1, r1, #8
c0d011c0:	1809      	adds	r1, r1, r0
    if ((unsigned int)U2BE(G_io_usb_ep_buffer, 3) != (unsigned int)G_io_usb_hid_sequence_number) {
c0d011c2:	4e34      	ldr	r6, [pc, #208]	; (c0d01294 <io_usb_hid_receive+0x128>)
c0d011c4:	6832      	ldr	r2, [r6, #0]
c0d011c6:	2000      	movs	r0, #0
c0d011c8:	428a      	cmp	r2, r1
c0d011ca:	d120      	bne.n	c0d0120e <io_usb_hid_receive+0xa2>
    if (G_io_usb_hid_sequence_number == 0) {
c0d011cc:	6831      	ldr	r1, [r6, #0]
c0d011ce:	2900      	cmp	r1, #0
c0d011d0:	d026      	beq.n	c0d01220 <io_usb_hid_receive+0xb4>
c0d011d2:	9800      	ldr	r0, [sp, #0]
c0d011d4:	1f40      	subs	r0, r0, #5
      if (l > G_io_usb_hid_remaining_length) {
c0d011d6:	b282      	uxth	r2, r0
c0d011d8:	492f      	ldr	r1, [pc, #188]	; (c0d01298 <io_usb_hid_receive+0x12c>)
c0d011da:	680b      	ldr	r3, [r1, #0]
c0d011dc:	4293      	cmp	r3, r2
c0d011de:	d200      	bcs.n	c0d011e2 <io_usb_hid_receive+0x76>
        l = G_io_usb_hid_remaining_length;
c0d011e0:	6808      	ldr	r0, [r1, #0]
      if (l > sizeof(G_io_usb_ep_buffer) - 5) {
c0d011e2:	b281      	uxth	r1, r0
c0d011e4:	293b      	cmp	r1, #59	; 0x3b
c0d011e6:	d300      	bcc.n	c0d011ea <io_usb_hid_receive+0x7e>
c0d011e8:	203b      	movs	r0, #59	; 0x3b
      memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+5, l);
c0d011ea:	b284      	uxth	r4, r0
c0d011ec:	4d2b      	ldr	r5, [pc, #172]	; (c0d0129c <io_usb_hid_receive+0x130>)
c0d011ee:	6828      	ldr	r0, [r5, #0]
c0d011f0:	1d79      	adds	r1, r7, #5
c0d011f2:	4622      	mov	r2, r4
c0d011f4:	f001 ff31 	bl	c0d0305a <__aeabi_memmove>
    G_io_usb_hid_current_buffer += l;
c0d011f8:	682d      	ldr	r5, [r5, #0]
c0d011fa:	e037      	b.n	c0d0126c <io_usb_hid_receive+0x100>
c0d011fc:	2000      	movs	r0, #0
    memset(G_io_usb_ep_buffer+3, 0, 4); // PROTOCOL VERSION is 0
c0d011fe:	71b8      	strb	r0, [r7, #6]
c0d01200:	7178      	strb	r0, [r7, #5]
c0d01202:	7138      	strb	r0, [r7, #4]
c0d01204:	70f8      	strb	r0, [r7, #3]
c0d01206:	4822      	ldr	r0, [pc, #136]	; (c0d01290 <io_usb_hid_receive+0x124>)
c0d01208:	2140      	movs	r1, #64	; 0x40
c0d0120a:	47a0      	blx	r4
c0d0120c:	2000      	movs	r0, #0
c0d0120e:	4921      	ldr	r1, [pc, #132]	; (c0d01294 <io_usb_hid_receive+0x128>)
c0d01210:	2200      	movs	r2, #0
c0d01212:	600a      	str	r2, [r1, #0]
c0d01214:	4921      	ldr	r1, [pc, #132]	; (c0d0129c <io_usb_hid_receive+0x130>)
c0d01216:	600a      	str	r2, [r1, #0]
c0d01218:	491f      	ldr	r1, [pc, #124]	; (c0d01298 <io_usb_hid_receive+0x12c>)
c0d0121a:	600a      	str	r2, [r1, #0]
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d0121c:	b001      	add	sp, #4
c0d0121e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01220:	79b9      	ldrb	r1, [r7, #6]
c0d01222:	797a      	ldrb	r2, [r7, #5]
c0d01224:	0212      	lsls	r2, r2, #8
c0d01226:	1852      	adds	r2, r2, r1
      G_io_usb_hid_total_length = U2BE(G_io_usb_ep_buffer, 5); //(G_io_usb_ep_buffer[5]<<8)+(G_io_usb_ep_buffer[6]&0xFF);
c0d01228:	491d      	ldr	r1, [pc, #116]	; (c0d012a0 <io_usb_hid_receive+0x134>)
c0d0122a:	600a      	str	r2, [r1, #0]
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d0122c:	680a      	ldr	r2, [r1, #0]
c0d0122e:	2341      	movs	r3, #65	; 0x41
c0d01230:	009b      	lsls	r3, r3, #2
c0d01232:	429a      	cmp	r2, r3
c0d01234:	d8eb      	bhi.n	c0d0120e <io_usb_hid_receive+0xa2>
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d01236:	6808      	ldr	r0, [r1, #0]
c0d01238:	4917      	ldr	r1, [pc, #92]	; (c0d01298 <io_usb_hid_receive+0x12c>)
c0d0123a:	6008      	str	r0, [r1, #0]
c0d0123c:	7878      	ldrb	r0, [r7, #1]
c0d0123e:	783a      	ldrb	r2, [r7, #0]
c0d01240:	0212      	lsls	r2, r2, #8
c0d01242:	1810      	adds	r0, r2, r0
      G_io_usb_hid_channel = U2BE(G_io_usb_ep_buffer, 0);
c0d01244:	4a17      	ldr	r2, [pc, #92]	; (c0d012a4 <io_usb_hid_receive+0x138>)
c0d01246:	6010      	str	r0, [r2, #0]
      if (l > G_io_usb_hid_remaining_length) {
c0d01248:	680a      	ldr	r2, [r1, #0]
      l -= 2;
c0d0124a:	9800      	ldr	r0, [sp, #0]
c0d0124c:	1fc0      	subs	r0, r0, #7
      if (l > G_io_usb_hid_remaining_length) {
c0d0124e:	b283      	uxth	r3, r0
c0d01250:	429a      	cmp	r2, r3
c0d01252:	d200      	bcs.n	c0d01256 <io_usb_hid_receive+0xea>
        l = G_io_usb_hid_remaining_length;
c0d01254:	6808      	ldr	r0, [r1, #0]
      if (l > sizeof(G_io_usb_ep_buffer) - 7) {
c0d01256:	b281      	uxth	r1, r0
c0d01258:	2939      	cmp	r1, #57	; 0x39
c0d0125a:	d300      	bcc.n	c0d0125e <io_usb_hid_receive+0xf2>
c0d0125c:	2039      	movs	r0, #57	; 0x39
      memmove((void*)G_io_usb_hid_current_buffer, G_io_usb_ep_buffer+7, l);
c0d0125e:	b284      	uxth	r4, r0
c0d01260:	1df9      	adds	r1, r7, #7
c0d01262:	4d11      	ldr	r5, [pc, #68]	; (c0d012a8 <io_usb_hid_receive+0x13c>)
c0d01264:	4628      	mov	r0, r5
c0d01266:	4622      	mov	r2, r4
c0d01268:	f001 fef3 	bl	c0d03052 <__aeabi_memcpy>
    G_io_usb_hid_remaining_length -= l;
c0d0126c:	480a      	ldr	r0, [pc, #40]	; (c0d01298 <io_usb_hid_receive+0x12c>)
c0d0126e:	6801      	ldr	r1, [r0, #0]
c0d01270:	1b09      	subs	r1, r1, r4
c0d01272:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_current_buffer += l;
c0d01274:	1928      	adds	r0, r5, r4
c0d01276:	4909      	ldr	r1, [pc, #36]	; (c0d0129c <io_usb_hid_receive+0x130>)
c0d01278:	6008      	str	r0, [r1, #0]
    G_io_usb_hid_sequence_number++;
c0d0127a:	6830      	ldr	r0, [r6, #0]
c0d0127c:	1c40      	adds	r0, r0, #1
c0d0127e:	6030      	str	r0, [r6, #0]
  if (G_io_usb_hid_remaining_length) {
c0d01280:	4805      	ldr	r0, [pc, #20]	; (c0d01298 <io_usb_hid_receive+0x12c>)
c0d01282:	6800      	ldr	r0, [r0, #0]
c0d01284:	2800      	cmp	r0, #0
c0d01286:	d001      	beq.n	c0d0128c <io_usb_hid_receive+0x120>
c0d01288:	2001      	movs	r0, #1
c0d0128a:	e7c7      	b.n	c0d0121c <io_usb_hid_receive+0xb0>
c0d0128c:	2002      	movs	r0, #2
c0d0128e:	e7be      	b.n	c0d0120e <io_usb_hid_receive+0xa2>
c0d01290:	2000057c 	.word	0x2000057c
c0d01294:	200005bc 	.word	0x200005bc
c0d01298:	200005c4 	.word	0x200005c4
c0d0129c:	200005c8 	.word	0x200005c8
c0d012a0:	200005c0 	.word	0x200005c0
c0d012a4:	200005cc 	.word	0x200005cc
c0d012a8:	20000450 	.word	0x20000450

c0d012ac <io_usb_hid_init>:

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d012ac:	4803      	ldr	r0, [pc, #12]	; (c0d012bc <io_usb_hid_init+0x10>)
c0d012ae:	2100      	movs	r1, #0
c0d012b0:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
  G_io_usb_hid_current_buffer = NULL;
c0d012b2:	4803      	ldr	r0, [pc, #12]	; (c0d012c0 <io_usb_hid_init+0x14>)
c0d012b4:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
c0d012b6:	4803      	ldr	r0, [pc, #12]	; (c0d012c4 <io_usb_hid_init+0x18>)
c0d012b8:	6001      	str	r1, [r0, #0]
}
c0d012ba:	4770      	bx	lr
c0d012bc:	200005bc 	.word	0x200005bc
c0d012c0:	200005c8 	.word	0x200005c8
c0d012c4:	200005c4 	.word	0x200005c4

c0d012c8 <io_usb_hid_sent>:

/**
 * sent the next io_usb_hid transport chunk (rx on the host, tx on the device)
 */
void io_usb_hid_sent(io_send_t sndfct) {
c0d012c8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012ca:	b081      	sub	sp, #4
c0d012cc:	4a27      	ldr	r2, [pc, #156]	; (c0d0136c <io_usb_hid_sent+0xa4>)
c0d012ce:	6815      	ldr	r5, [r2, #0]
  unsigned int l;

  // only prepare next chunk if some data to be sent remain
  if (G_io_usb_hid_remaining_length && G_io_usb_hid_current_buffer) {
c0d012d0:	4b27      	ldr	r3, [pc, #156]	; (c0d01370 <io_usb_hid_sent+0xa8>)
c0d012d2:	6819      	ldr	r1, [r3, #0]
c0d012d4:	2900      	cmp	r1, #0
c0d012d6:	d021      	beq.n	c0d0131c <io_usb_hid_sent+0x54>
c0d012d8:	2d00      	cmp	r5, #0
c0d012da:	d01f      	beq.n	c0d0131c <io_usb_hid_sent+0x54>
c0d012dc:	9000      	str	r0, [sp, #0]
    // fill the chunk
    memset(G_io_usb_ep_buffer, 0, sizeof(G_io_usb_ep_buffer));
c0d012de:	4c27      	ldr	r4, [pc, #156]	; (c0d0137c <io_usb_hid_sent+0xb4>)
c0d012e0:	1d67      	adds	r7, r4, #5
c0d012e2:	263b      	movs	r6, #59	; 0x3b
c0d012e4:	4638      	mov	r0, r7
c0d012e6:	4631      	mov	r1, r6
c0d012e8:	f001 feae 	bl	c0d03048 <__aeabi_memclr>
c0d012ec:	4a20      	ldr	r2, [pc, #128]	; (c0d01370 <io_usb_hid_sent+0xa8>)
c0d012ee:	2005      	movs	r0, #5

    // keep the channel identifier
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
    G_io_usb_ep_buffer[2] = 0x05;
c0d012f0:	70a0      	strb	r0, [r4, #2]
    G_io_usb_ep_buffer[0] = (G_io_usb_hid_channel>>8)&0xFF;
c0d012f2:	4823      	ldr	r0, [pc, #140]	; (c0d01380 <io_usb_hid_sent+0xb8>)
c0d012f4:	6801      	ldr	r1, [r0, #0]
c0d012f6:	0a09      	lsrs	r1, r1, #8
c0d012f8:	7021      	strb	r1, [r4, #0]
    G_io_usb_ep_buffer[1] = G_io_usb_hid_channel&0xFF;
c0d012fa:	6800      	ldr	r0, [r0, #0]
c0d012fc:	7060      	strb	r0, [r4, #1]
    G_io_usb_ep_buffer[3] = G_io_usb_hid_sequence_number>>8;
c0d012fe:	491d      	ldr	r1, [pc, #116]	; (c0d01374 <io_usb_hid_sent+0xac>)
c0d01300:	6808      	ldr	r0, [r1, #0]
c0d01302:	0a00      	lsrs	r0, r0, #8
c0d01304:	70e0      	strb	r0, [r4, #3]
    G_io_usb_ep_buffer[4] = G_io_usb_hid_sequence_number;
c0d01306:	6808      	ldr	r0, [r1, #0]
c0d01308:	7120      	strb	r0, [r4, #4]

    if (G_io_usb_hid_sequence_number == 0) {
c0d0130a:	6809      	ldr	r1, [r1, #0]
c0d0130c:	6810      	ldr	r0, [r2, #0]
c0d0130e:	2900      	cmp	r1, #0
c0d01310:	d00c      	beq.n	c0d0132c <io_usb_hid_sent+0x64>
      memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
      G_io_usb_hid_current_buffer += l;
      G_io_usb_hid_remaining_length -= l;
    }
    else {
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : G_io_usb_hid_remaining_length);
c0d01312:	283b      	cmp	r0, #59	; 0x3b
c0d01314:	d800      	bhi.n	c0d01318 <io_usb_hid_sent+0x50>
c0d01316:	6816      	ldr	r6, [r2, #0]
      memmove(G_io_usb_ep_buffer+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d01318:	4638      	mov	r0, r7
c0d0131a:	e012      	b.n	c0d01342 <io_usb_hid_sent+0x7a>
  G_io_usb_hid_sequence_number = 0; 
c0d0131c:	4815      	ldr	r0, [pc, #84]	; (c0d01374 <io_usb_hid_sent+0xac>)
c0d0131e:	2100      	movs	r1, #0
c0d01320:	6001      	str	r1, [r0, #0]
  G_io_usb_hid_current_buffer = NULL;
c0d01322:	6011      	str	r1, [r2, #0]
  // cleanup when everything has been sent (ack for the last sent usb in packet)
  else {
    io_usb_hid_init();

    // we sent the whole response
    G_io_app.apdu_state = APDU_IDLE;
c0d01324:	4814      	ldr	r0, [pc, #80]	; (c0d01378 <io_usb_hid_sent+0xb0>)
c0d01326:	7001      	strb	r1, [r0, #0]
  G_io_usb_hid_remaining_length = 0;
c0d01328:	6019      	str	r1, [r3, #0]
c0d0132a:	e01d      	b.n	c0d01368 <io_usb_hid_sent+0xa0>
      l = ((G_io_usb_hid_remaining_length>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : G_io_usb_hid_remaining_length);
c0d0132c:	2839      	cmp	r0, #57	; 0x39
c0d0132e:	d901      	bls.n	c0d01334 <io_usb_hid_sent+0x6c>
c0d01330:	2639      	movs	r6, #57	; 0x39
c0d01332:	e000      	b.n	c0d01336 <io_usb_hid_sent+0x6e>
c0d01334:	6816      	ldr	r6, [r2, #0]
      G_io_usb_ep_buffer[5] = G_io_usb_hid_remaining_length>>8;
c0d01336:	6810      	ldr	r0, [r2, #0]
c0d01338:	0a00      	lsrs	r0, r0, #8
c0d0133a:	7160      	strb	r0, [r4, #5]
      G_io_usb_ep_buffer[6] = G_io_usb_hid_remaining_length;
c0d0133c:	6810      	ldr	r0, [r2, #0]
c0d0133e:	71a0      	strb	r0, [r4, #6]
      memmove(G_io_usb_ep_buffer+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d01340:	1de0      	adds	r0, r4, #7
c0d01342:	4629      	mov	r1, r5
c0d01344:	4632      	mov	r2, r6
c0d01346:	f001 fe88 	bl	c0d0305a <__aeabi_memmove>
c0d0134a:	4b09      	ldr	r3, [pc, #36]	; (c0d01370 <io_usb_hid_sent+0xa8>)
c0d0134c:	9a00      	ldr	r2, [sp, #0]
c0d0134e:	4907      	ldr	r1, [pc, #28]	; (c0d0136c <io_usb_hid_sent+0xa4>)
c0d01350:	6818      	ldr	r0, [r3, #0]
c0d01352:	1b80      	subs	r0, r0, r6
c0d01354:	6018      	str	r0, [r3, #0]
c0d01356:	19a8      	adds	r0, r5, r6
c0d01358:	6008      	str	r0, [r1, #0]
c0d0135a:	4906      	ldr	r1, [pc, #24]	; (c0d01374 <io_usb_hid_sent+0xac>)
    G_io_usb_hid_sequence_number++;
c0d0135c:	6808      	ldr	r0, [r1, #0]
c0d0135e:	1c40      	adds	r0, r0, #1
c0d01360:	6008      	str	r0, [r1, #0]
    sndfct(G_io_usb_ep_buffer, sizeof(G_io_usb_ep_buffer));
c0d01362:	4806      	ldr	r0, [pc, #24]	; (c0d0137c <io_usb_hid_sent+0xb4>)
c0d01364:	2140      	movs	r1, #64	; 0x40
c0d01366:	4790      	blx	r2
  }
}
c0d01368:	b001      	add	sp, #4
c0d0136a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0136c:	200005c8 	.word	0x200005c8
c0d01370:	200005c4 	.word	0x200005c4
c0d01374:	200005bc 	.word	0x200005bc
c0d01378:	20000554 	.word	0x20000554
c0d0137c:	2000057c 	.word	0x2000057c
c0d01380:	200005cc 	.word	0x200005cc

c0d01384 <io_usb_hid_send>:

void io_usb_hid_send(io_send_t sndfct, unsigned short sndlength) {
c0d01384:	b580      	push	{r7, lr}
  // perform send
  if (sndlength) {
c0d01386:	2900      	cmp	r1, #0
c0d01388:	d00b      	beq.n	c0d013a2 <io_usb_hid_send+0x1e>
    G_io_usb_hid_sequence_number = 0; 
c0d0138a:	4a06      	ldr	r2, [pc, #24]	; (c0d013a4 <io_usb_hid_send+0x20>)
c0d0138c:	2300      	movs	r3, #0
c0d0138e:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
    G_io_usb_hid_remaining_length = sndlength;
c0d01390:	4a05      	ldr	r2, [pc, #20]	; (c0d013a8 <io_usb_hid_send+0x24>)
c0d01392:	6011      	str	r1, [r2, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d01394:	4a05      	ldr	r2, [pc, #20]	; (c0d013ac <io_usb_hid_send+0x28>)
c0d01396:	4b06      	ldr	r3, [pc, #24]	; (c0d013b0 <io_usb_hid_send+0x2c>)
c0d01398:	6013      	str	r3, [r2, #0]
    G_io_usb_hid_total_length = sndlength;
c0d0139a:	4a06      	ldr	r2, [pc, #24]	; (c0d013b4 <io_usb_hid_send+0x30>)
c0d0139c:	6011      	str	r1, [r2, #0]
    io_usb_hid_sent(sndfct);
c0d0139e:	f7ff ff93 	bl	c0d012c8 <io_usb_hid_sent>
  }
}
c0d013a2:	bd80      	pop	{r7, pc}
c0d013a4:	200005bc 	.word	0x200005bc
c0d013a8:	200005c4 	.word	0x200005c4
c0d013ac:	200005c8 	.word	0x200005c8
c0d013b0:	20000450 	.word	0x20000450
c0d013b4:	200005c0 	.word	0x200005c0

c0d013b8 <mcu_usb_prints>:
    mcu_usb_printc(*str++);
  }
}

#else
void mcu_usb_prints(const char* str, unsigned int charcount) {
c0d013b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d013ba:	b081      	sub	sp, #4
c0d013bc:	460d      	mov	r5, r1
c0d013be:	4604      	mov	r4, r0
c0d013c0:	20dc      	movs	r0, #220	; 0xdc
  if(USBD_Device.dev_state != USBD_STATE_CONFIGURED){
c0d013c2:	4911      	ldr	r1, [pc, #68]	; (c0d01408 <mcu_usb_prints+0x50>)
c0d013c4:	5c08      	ldrb	r0, [r1, r0]
c0d013c6:	2803      	cmp	r0, #3
c0d013c8:	d11c      	bne.n	c0d01404 <mcu_usb_prints+0x4c>
    return;
  }
  unsigned char buf[4];
  if(io_seproxyhal_spi_is_status_sent()){
c0d013ca:	f000 fa81 	bl	c0d018d0 <io_seph_is_status_sent>
c0d013ce:	2800      	cmp	r0, #0
c0d013d0:	d004      	beq.n	c0d013dc <mcu_usb_prints+0x24>
c0d013d2:	4668      	mov	r0, sp
c0d013d4:	2103      	movs	r1, #3
c0d013d6:	2200      	movs	r2, #0
      io_seproxyhal_spi_recv(buf, 3, 0);
c0d013d8:	f000 fa86 	bl	c0d018e8 <io_seph_recv>
c0d013dc:	466e      	mov	r6, sp
  }
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
  buf[1] = charcount >> 8;
  buf[2] = charcount;
c0d013de:	70b5      	strb	r5, [r6, #2]
c0d013e0:	2066      	movs	r0, #102	; 0x66
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
c0d013e2:	7030      	strb	r0, [r6, #0]
  buf[1] = charcount >> 8;
c0d013e4:	0a28      	lsrs	r0, r5, #8
c0d013e6:	7070      	strb	r0, [r6, #1]
c0d013e8:	2703      	movs	r7, #3
  io_seproxyhal_spi_send(buf, 3);
c0d013ea:	4630      	mov	r0, r6
c0d013ec:	4639      	mov	r1, r7
c0d013ee:	f000 fa63 	bl	c0d018b8 <io_seph_send>
  io_seproxyhal_spi_send((unsigned char*)str, charcount);
c0d013f2:	b2a9      	uxth	r1, r5
c0d013f4:	4620      	mov	r0, r4
c0d013f6:	f000 fa5f 	bl	c0d018b8 <io_seph_send>
c0d013fa:	2200      	movs	r2, #0
#ifndef IO_SEPROXYHAL_DEBUG
  // wait printf ack (no race kthx)
  io_seproxyhal_spi_recv(buf, 3, 0);
c0d013fc:	4630      	mov	r0, r6
c0d013fe:	4639      	mov	r1, r7
c0d01400:	f000 fa72 	bl	c0d018e8 <io_seph_recv>
  buf[0] = 0; // consume tag to avoid misinterpretation (due to IO_CACHE)
#endif // IO_SEPROXYHAL_DEBUG
}
c0d01404:	b001      	add	sp, #4
c0d01406:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01408:	200005d8 	.word	0x200005d8

c0d0140c <mcu_usb_printf>:
 * - screen_printc
 */

void screen_printf(const char* format, ...) __attribute__ ((weak, alias ("mcu_usb_printf")));

void mcu_usb_printf(const char* format, ...) {
c0d0140c:	b083      	sub	sp, #12
c0d0140e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01410:	b08e      	sub	sp, #56	; 0x38
c0d01412:	ac13      	add	r4, sp, #76	; 0x4c
c0d01414:	c40e      	stmia	r4!, {r1, r2, r3}
    char cStrlenSet;

    //
    // Check the arguments.
    //
    if(format == 0) {
c0d01416:	2800      	cmp	r0, #0
c0d01418:	d100      	bne.n	c0d0141c <mcu_usb_printf+0x10>
c0d0141a:	e180      	b.n	c0d0171e <mcu_usb_printf+0x312>
c0d0141c:	4604      	mov	r4, r0
c0d0141e:	a813      	add	r0, sp, #76	; 0x4c
    }

    //
    // Start the varargs processing.
    //
    va_start(vaArgP, format);
c0d01420:	9008      	str	r0, [sp, #32]

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0d01422:	7820      	ldrb	r0, [r4, #0]
c0d01424:	2800      	cmp	r0, #0
c0d01426:	d100      	bne.n	c0d0142a <mcu_usb_printf+0x1e>
c0d01428:	e179      	b.n	c0d0171e <mcu_usb_printf+0x312>
c0d0142a:	2101      	movs	r1, #1
c0d0142c:	9104      	str	r1, [sp, #16]
c0d0142e:	2500      	movs	r5, #0
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0d01430:	2800      	cmp	r0, #0
c0d01432:	d005      	beq.n	c0d01440 <mcu_usb_printf+0x34>
c0d01434:	2825      	cmp	r0, #37	; 0x25
c0d01436:	d003      	beq.n	c0d01440 <mcu_usb_printf+0x34>
c0d01438:	1960      	adds	r0, r4, r5
c0d0143a:	7840      	ldrb	r0, [r0, #1]
            ulIdx++)
c0d0143c:	1c6d      	adds	r5, r5, #1
c0d0143e:	e7f7      	b.n	c0d01430 <mcu_usb_printf+0x24>
        }

        //
        // Write this portion of the string.
        //
        mcu_usb_prints(format, ulIdx);
c0d01440:	4620      	mov	r0, r4
c0d01442:	4629      	mov	r1, r5
c0d01444:	f7ff ffb8 	bl	c0d013b8 <mcu_usb_prints>
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0d01448:	5d60      	ldrb	r0, [r4, r5]
c0d0144a:	2825      	cmp	r0, #37	; 0x25
c0d0144c:	d143      	bne.n	c0d014d6 <mcu_usb_printf+0xca>
            ulCount = 0;
            cFill = ' ';
            ulStrlen = 0;
            cStrlenSet = 0;
            ulCap = 0;
            ulBase = 10;
c0d0144e:	1960      	adds	r0, r4, r5
c0d01450:	1c44      	adds	r4, r0, #1
c0d01452:	2300      	movs	r3, #0
c0d01454:	2720      	movs	r7, #32
c0d01456:	461e      	mov	r6, r3
c0d01458:	4618      	mov	r0, r3
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0d0145a:	7821      	ldrb	r1, [r4, #0]
c0d0145c:	1c64      	adds	r4, r4, #1
c0d0145e:	2200      	movs	r2, #0
c0d01460:	292d      	cmp	r1, #45	; 0x2d
c0d01462:	dc0c      	bgt.n	c0d0147e <mcu_usb_printf+0x72>
c0d01464:	4610      	mov	r0, r2
c0d01466:	d0f8      	beq.n	c0d0145a <mcu_usb_printf+0x4e>
c0d01468:	2925      	cmp	r1, #37	; 0x25
c0d0146a:	d06d      	beq.n	c0d01548 <mcu_usb_printf+0x13c>
c0d0146c:	292a      	cmp	r1, #42	; 0x2a
c0d0146e:	d000      	beq.n	c0d01472 <mcu_usb_printf+0x66>
c0d01470:	e103      	b.n	c0d0167a <mcu_usb_printf+0x26e>
                  goto error;
                }
                
                case '*':
                {
                  if (*format == 's' ) {                    
c0d01472:	7820      	ldrb	r0, [r4, #0]
c0d01474:	2873      	cmp	r0, #115	; 0x73
c0d01476:	d000      	beq.n	c0d0147a <mcu_usb_printf+0x6e>
c0d01478:	e0ff      	b.n	c0d0167a <mcu_usb_printf+0x26e>
c0d0147a:	2002      	movs	r0, #2
c0d0147c:	e026      	b.n	c0d014cc <mcu_usb_printf+0xc0>
            switch(*format++)
c0d0147e:	2947      	cmp	r1, #71	; 0x47
c0d01480:	dc2b      	bgt.n	c0d014da <mcu_usb_printf+0xce>
c0d01482:	460a      	mov	r2, r1
c0d01484:	3a30      	subs	r2, #48	; 0x30
c0d01486:	2a0a      	cmp	r2, #10
c0d01488:	d20f      	bcs.n	c0d014aa <mcu_usb_printf+0x9e>
c0d0148a:	9707      	str	r7, [sp, #28]
c0d0148c:	2230      	movs	r2, #48	; 0x30
c0d0148e:	461f      	mov	r7, r3
                    if((format[-1] == '0') && (ulCount == 0))
c0d01490:	460b      	mov	r3, r1
c0d01492:	4053      	eors	r3, r2
c0d01494:	9706      	str	r7, [sp, #24]
c0d01496:	433b      	orrs	r3, r7
c0d01498:	d000      	beq.n	c0d0149c <mcu_usb_printf+0x90>
c0d0149a:	9a07      	ldr	r2, [sp, #28]
c0d0149c:	230a      	movs	r3, #10
                    ulCount *= 10;
c0d0149e:	9f06      	ldr	r7, [sp, #24]
c0d014a0:	437b      	muls	r3, r7
                    ulCount += format[-1] - '0';
c0d014a2:	185b      	adds	r3, r3, r1
c0d014a4:	3b30      	subs	r3, #48	; 0x30
c0d014a6:	4617      	mov	r7, r2
c0d014a8:	e7d7      	b.n	c0d0145a <mcu_usb_printf+0x4e>
            switch(*format++)
c0d014aa:	292e      	cmp	r1, #46	; 0x2e
c0d014ac:	d000      	beq.n	c0d014b0 <mcu_usb_printf+0xa4>
c0d014ae:	e0e4      	b.n	c0d0167a <mcu_usb_printf+0x26e>
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0d014b0:	7820      	ldrb	r0, [r4, #0]
c0d014b2:	282a      	cmp	r0, #42	; 0x2a
c0d014b4:	d000      	beq.n	c0d014b8 <mcu_usb_printf+0xac>
c0d014b6:	e0e0      	b.n	c0d0167a <mcu_usb_printf+0x26e>
c0d014b8:	7860      	ldrb	r0, [r4, #1]
c0d014ba:	2848      	cmp	r0, #72	; 0x48
c0d014bc:	d004      	beq.n	c0d014c8 <mcu_usb_printf+0xbc>
c0d014be:	2873      	cmp	r0, #115	; 0x73
c0d014c0:	d002      	beq.n	c0d014c8 <mcu_usb_printf+0xbc>
c0d014c2:	2868      	cmp	r0, #104	; 0x68
c0d014c4:	d000      	beq.n	c0d014c8 <mcu_usb_printf+0xbc>
c0d014c6:	e0d8      	b.n	c0d0167a <mcu_usb_printf+0x26e>
c0d014c8:	1c64      	adds	r4, r4, #1
c0d014ca:	2001      	movs	r0, #1
c0d014cc:	9908      	ldr	r1, [sp, #32]
c0d014ce:	1d0a      	adds	r2, r1, #4
c0d014d0:	9208      	str	r2, [sp, #32]
c0d014d2:	680e      	ldr	r6, [r1, #0]
c0d014d4:	e7c1      	b.n	c0d0145a <mcu_usb_printf+0x4e>
c0d014d6:	1964      	adds	r4, r4, r5
c0d014d8:	e0df      	b.n	c0d0169a <mcu_usb_printf+0x28e>
            switch(*format++)
c0d014da:	2967      	cmp	r1, #103	; 0x67
c0d014dc:	9405      	str	r4, [sp, #20]
c0d014de:	dd08      	ble.n	c0d014f2 <mcu_usb_printf+0xe6>
c0d014e0:	2972      	cmp	r1, #114	; 0x72
c0d014e2:	dd10      	ble.n	c0d01506 <mcu_usb_printf+0xfa>
c0d014e4:	2973      	cmp	r1, #115	; 0x73
c0d014e6:	d032      	beq.n	c0d0154e <mcu_usb_printf+0x142>
c0d014e8:	2975      	cmp	r1, #117	; 0x75
c0d014ea:	d035      	beq.n	c0d01558 <mcu_usb_printf+0x14c>
c0d014ec:	2978      	cmp	r1, #120	; 0x78
c0d014ee:	d010      	beq.n	c0d01512 <mcu_usb_printf+0x106>
c0d014f0:	e0c3      	b.n	c0d0167a <mcu_usb_printf+0x26e>
c0d014f2:	2962      	cmp	r1, #98	; 0x62
c0d014f4:	dc16      	bgt.n	c0d01524 <mcu_usb_printf+0x118>
c0d014f6:	2948      	cmp	r1, #72	; 0x48
c0d014f8:	d100      	bne.n	c0d014fc <mcu_usb_printf+0xf0>
c0d014fa:	e0a6      	b.n	c0d0164a <mcu_usb_printf+0x23e>
c0d014fc:	2958      	cmp	r1, #88	; 0x58
c0d014fe:	d000      	beq.n	c0d01502 <mcu_usb_printf+0xf6>
c0d01500:	e0bb      	b.n	c0d0167a <mcu_usb_printf+0x26e>
c0d01502:	2001      	movs	r0, #1
c0d01504:	e006      	b.n	c0d01514 <mcu_usb_printf+0x108>
c0d01506:	2968      	cmp	r1, #104	; 0x68
c0d01508:	d100      	bne.n	c0d0150c <mcu_usb_printf+0x100>
c0d0150a:	e0a2      	b.n	c0d01652 <mcu_usb_printf+0x246>
c0d0150c:	2970      	cmp	r1, #112	; 0x70
c0d0150e:	d000      	beq.n	c0d01512 <mcu_usb_printf+0x106>
c0d01510:	e0b3      	b.n	c0d0167a <mcu_usb_printf+0x26e>
c0d01512:	2000      	movs	r0, #0
c0d01514:	9002      	str	r0, [sp, #8]
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01516:	9808      	ldr	r0, [sp, #32]
c0d01518:	1d01      	adds	r1, r0, #4
c0d0151a:	9108      	str	r1, [sp, #32]
c0d0151c:	6800      	ldr	r0, [r0, #0]
c0d0151e:	900d      	str	r0, [sp, #52]	; 0x34
c0d01520:	2110      	movs	r1, #16
c0d01522:	e021      	b.n	c0d01568 <mcu_usb_printf+0x15c>
            switch(*format++)
c0d01524:	2963      	cmp	r1, #99	; 0x63
c0d01526:	d100      	bne.n	c0d0152a <mcu_usb_printf+0x11e>
c0d01528:	e0ac      	b.n	c0d01684 <mcu_usb_printf+0x278>
c0d0152a:	2964      	cmp	r1, #100	; 0x64
c0d0152c:	d000      	beq.n	c0d01530 <mcu_usb_printf+0x124>
c0d0152e:	e0a4      	b.n	c0d0167a <mcu_usb_printf+0x26e>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01530:	9808      	ldr	r0, [sp, #32]
c0d01532:	1d01      	adds	r1, r0, #4
c0d01534:	9108      	str	r1, [sp, #32]
c0d01536:	6800      	ldr	r0, [r0, #0]
c0d01538:	900d      	str	r0, [sp, #52]	; 0x34
c0d0153a:	210a      	movs	r1, #10
                    if((long)ulValue < 0)
c0d0153c:	2800      	cmp	r0, #0
c0d0153e:	d500      	bpl.n	c0d01542 <mcu_usb_printf+0x136>
c0d01540:	e0d1      	b.n	c0d016e6 <mcu_usb_printf+0x2da>
c0d01542:	2200      	movs	r2, #0
c0d01544:	9202      	str	r2, [sp, #8]
c0d01546:	e00f      	b.n	c0d01568 <mcu_usb_printf+0x15c>
c0d01548:	9405      	str	r4, [sp, #20]
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    mcu_usb_prints(format - 1, 1);
c0d0154a:	1e60      	subs	r0, r4, #1
c0d0154c:	e0a0      	b.n	c0d01690 <mcu_usb_printf+0x284>
c0d0154e:	4619      	mov	r1, r3
c0d01550:	4c76      	ldr	r4, [pc, #472]	; (c0d0172c <mcu_usb_printf+0x320>)
c0d01552:	447c      	add	r4, pc
c0d01554:	2200      	movs	r2, #0
c0d01556:	e080      	b.n	c0d0165a <mcu_usb_printf+0x24e>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01558:	9808      	ldr	r0, [sp, #32]
c0d0155a:	1d01      	adds	r1, r0, #4
c0d0155c:	9108      	str	r1, [sp, #32]
c0d0155e:	6800      	ldr	r0, [r0, #0]
c0d01560:	900d      	str	r0, [sp, #52]	; 0x34
c0d01562:	2100      	movs	r1, #0
c0d01564:	9102      	str	r1, [sp, #8]
c0d01566:	210a      	movs	r1, #10
c0d01568:	9a04      	ldr	r2, [sp, #16]
c0d0156a:	9203      	str	r2, [sp, #12]
c0d0156c:	9707      	str	r7, [sp, #28]
c0d0156e:	4606      	mov	r6, r0
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01570:	4281      	cmp	r1, r0
c0d01572:	9106      	str	r1, [sp, #24]
c0d01574:	d902      	bls.n	c0d0157c <mcu_usb_printf+0x170>
c0d01576:	9c04      	ldr	r4, [sp, #16]
c0d01578:	4627      	mov	r7, r4
c0d0157a:	e014      	b.n	c0d015a6 <mcu_usb_printf+0x19a>
                    for(ulIdx = 1;
c0d0157c:	1e5a      	subs	r2, r3, #1
c0d0157e:	4608      	mov	r0, r1
c0d01580:	9c04      	ldr	r4, [sp, #16]
c0d01582:	4607      	mov	r7, r0
c0d01584:	4615      	mov	r5, r2
c0d01586:	2100      	movs	r1, #0
                        (((ulIdx * ulBase) <= ulValue) &&
c0d01588:	9806      	ldr	r0, [sp, #24]
c0d0158a:	463a      	mov	r2, r7
c0d0158c:	460b      	mov	r3, r1
c0d0158e:	f001 fd2d 	bl	c0d02fec <__aeabi_lmul>
c0d01592:	1e4a      	subs	r2, r1, #1
c0d01594:	4191      	sbcs	r1, r2
c0d01596:	42b0      	cmp	r0, r6
c0d01598:	d804      	bhi.n	c0d015a4 <mcu_usb_printf+0x198>
                    for(ulIdx = 1;
c0d0159a:	1e6a      	subs	r2, r5, #1
c0d0159c:	2900      	cmp	r1, #0
c0d0159e:	462b      	mov	r3, r5
c0d015a0:	d0ef      	beq.n	c0d01582 <mcu_usb_printf+0x176>
c0d015a2:	e000      	b.n	c0d015a6 <mcu_usb_printf+0x19a>
c0d015a4:	462b      	mov	r3, r5
c0d015a6:	9a03      	ldr	r2, [sp, #12]
                    if(ulNeg)
c0d015a8:	4610      	mov	r0, r2
c0d015aa:	4060      	eors	r0, r4
c0d015ac:	1a19      	subs	r1, r3, r0
                    if(ulNeg && (cFill == '0'))
c0d015ae:	2a00      	cmp	r2, #0
c0d015b0:	d001      	beq.n	c0d015b6 <mcu_usb_printf+0x1aa>
c0d015b2:	2500      	movs	r5, #0
c0d015b4:	e00d      	b.n	c0d015d2 <mcu_usb_printf+0x1c6>
c0d015b6:	9a07      	ldr	r2, [sp, #28]
c0d015b8:	b2d2      	uxtb	r2, r2
c0d015ba:	2500      	movs	r5, #0
c0d015bc:	2a30      	cmp	r2, #48	; 0x30
c0d015be:	9503      	str	r5, [sp, #12]
c0d015c0:	d108      	bne.n	c0d015d4 <mcu_usb_printf+0x1c8>
c0d015c2:	aa09      	add	r2, sp, #36	; 0x24
c0d015c4:	461d      	mov	r5, r3
c0d015c6:	232d      	movs	r3, #45	; 0x2d
                        pcBuf[ulPos++] = '-';
c0d015c8:	7013      	strb	r3, [r2, #0]
c0d015ca:	462b      	mov	r3, r5
c0d015cc:	2501      	movs	r5, #1
c0d015ce:	2230      	movs	r2, #48	; 0x30
c0d015d0:	9207      	str	r2, [sp, #28]
c0d015d2:	9403      	str	r4, [sp, #12]
                    if((ulCount > 1) && (ulCount < 16))
c0d015d4:	1e8a      	subs	r2, r1, #2
c0d015d6:	2a0d      	cmp	r2, #13
c0d015d8:	d80e      	bhi.n	c0d015f8 <mcu_usb_printf+0x1ec>
c0d015da:	1e49      	subs	r1, r1, #1
c0d015dc:	d00c      	beq.n	c0d015f8 <mcu_usb_printf+0x1ec>
c0d015de:	4240      	negs	r0, r0
c0d015e0:	9001      	str	r0, [sp, #4]
c0d015e2:	a809      	add	r0, sp, #36	; 0x24
                        for(ulCount--; ulCount; ulCount--)
c0d015e4:	1940      	adds	r0, r0, r5
                            pcBuf[ulPos++] = cFill;
c0d015e6:	9a07      	ldr	r2, [sp, #28]
c0d015e8:	b2d2      	uxtb	r2, r2
c0d015ea:	461c      	mov	r4, r3
c0d015ec:	f001 fd39 	bl	c0d03062 <__aeabi_memset>
                        for(ulCount--; ulCount; ulCount--)
c0d015f0:	1928      	adds	r0, r5, r4
c0d015f2:	9901      	ldr	r1, [sp, #4]
c0d015f4:	1840      	adds	r0, r0, r1
c0d015f6:	1e45      	subs	r5, r0, #1
c0d015f8:	9803      	ldr	r0, [sp, #12]
                    if(ulNeg)
c0d015fa:	2800      	cmp	r0, #0
c0d015fc:	d103      	bne.n	c0d01606 <mcu_usb_printf+0x1fa>
c0d015fe:	a809      	add	r0, sp, #36	; 0x24
c0d01600:	212d      	movs	r1, #45	; 0x2d
                        pcBuf[ulPos++] = '-';
c0d01602:	5541      	strb	r1, [r0, r5]
c0d01604:	1c6d      	adds	r5, r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0d01606:	2f00      	cmp	r7, #0
c0d01608:	d01c      	beq.n	c0d01644 <mcu_usb_printf+0x238>
c0d0160a:	9802      	ldr	r0, [sp, #8]
c0d0160c:	2800      	cmp	r0, #0
c0d0160e:	d002      	beq.n	c0d01616 <mcu_usb_printf+0x20a>
c0d01610:	484c      	ldr	r0, [pc, #304]	; (c0d01744 <mcu_usb_printf+0x338>)
c0d01612:	4478      	add	r0, pc
c0d01614:	e001      	b.n	c0d0161a <mcu_usb_printf+0x20e>
c0d01616:	484a      	ldr	r0, [pc, #296]	; (c0d01740 <mcu_usb_printf+0x334>)
c0d01618:	4478      	add	r0, pc
c0d0161a:	9607      	str	r6, [sp, #28]
c0d0161c:	9c06      	ldr	r4, [sp, #24]
c0d0161e:	4606      	mov	r6, r0
c0d01620:	9807      	ldr	r0, [sp, #28]
c0d01622:	4639      	mov	r1, r7
c0d01624:	f001 fc56 	bl	c0d02ed4 <__udivsi3>
c0d01628:	4621      	mov	r1, r4
c0d0162a:	f001 fcd9 	bl	c0d02fe0 <__aeabi_uidivmod>
c0d0162e:	5c70      	ldrb	r0, [r6, r1]
c0d01630:	a909      	add	r1, sp, #36	; 0x24
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0d01632:	5548      	strb	r0, [r1, r5]
                    for(; ulIdx; ulIdx /= ulBase)
c0d01634:	4638      	mov	r0, r7
c0d01636:	4621      	mov	r1, r4
c0d01638:	f001 fc4c 	bl	c0d02ed4 <__udivsi3>
c0d0163c:	1c6d      	adds	r5, r5, #1
c0d0163e:	42bc      	cmp	r4, r7
c0d01640:	4607      	mov	r7, r0
c0d01642:	d9ed      	bls.n	c0d01620 <mcu_usb_printf+0x214>
c0d01644:	a809      	add	r0, sp, #36	; 0x24
                    mcu_usb_prints(pcBuf, ulPos);
c0d01646:	4629      	mov	r1, r5
c0d01648:	e023      	b.n	c0d01692 <mcu_usb_printf+0x286>
c0d0164a:	4619      	mov	r1, r3
c0d0164c:	4c38      	ldr	r4, [pc, #224]	; (c0d01730 <mcu_usb_printf+0x324>)
c0d0164e:	447c      	add	r4, pc
c0d01650:	e002      	b.n	c0d01658 <mcu_usb_printf+0x24c>
c0d01652:	4619      	mov	r1, r3
c0d01654:	4c37      	ldr	r4, [pc, #220]	; (c0d01734 <mcu_usb_printf+0x328>)
c0d01656:	447c      	add	r4, pc
c0d01658:	9a04      	ldr	r2, [sp, #16]
c0d0165a:	9207      	str	r2, [sp, #28]
                    pcStr = va_arg(vaArgP, char *);
c0d0165c:	9a08      	ldr	r2, [sp, #32]
c0d0165e:	1d13      	adds	r3, r2, #4
c0d01660:	9308      	str	r3, [sp, #32]
                    switch(cStrlenSet) {
c0d01662:	b2c0      	uxtb	r0, r0
                    pcStr = va_arg(vaArgP, char *);
c0d01664:	6817      	ldr	r7, [r2, #0]
                    switch(cStrlenSet) {
c0d01666:	2800      	cmp	r0, #0
c0d01668:	d01a      	beq.n	c0d016a0 <mcu_usb_printf+0x294>
c0d0166a:	2801      	cmp	r0, #1
c0d0166c:	d021      	beq.n	c0d016b2 <mcu_usb_printf+0x2a6>
c0d0166e:	2802      	cmp	r0, #2
c0d01670:	d11e      	bne.n	c0d016b0 <mcu_usb_printf+0x2a4>
                        if (pcStr[0] == '\0') {
c0d01672:	7838      	ldrb	r0, [r7, #0]
c0d01674:	2800      	cmp	r0, #0
c0d01676:	9c05      	ldr	r4, [sp, #20]
c0d01678:	d03b      	beq.n	c0d016f2 <mcu_usb_printf+0x2e6>
c0d0167a:	9405      	str	r4, [sp, #20]
                default:
                {
                    //
                    // Indicate an error.
                    //
                    mcu_usb_prints("ERROR", 5);
c0d0167c:	482a      	ldr	r0, [pc, #168]	; (c0d01728 <mcu_usb_printf+0x31c>)
c0d0167e:	4478      	add	r0, pc
c0d01680:	2105      	movs	r1, #5
c0d01682:	e006      	b.n	c0d01692 <mcu_usb_printf+0x286>
                    ulValue = va_arg(vaArgP, unsigned long);
c0d01684:	9808      	ldr	r0, [sp, #32]
c0d01686:	1d01      	adds	r1, r0, #4
c0d01688:	9108      	str	r1, [sp, #32]
c0d0168a:	6800      	ldr	r0, [r0, #0]
c0d0168c:	900d      	str	r0, [sp, #52]	; 0x34
c0d0168e:	a80d      	add	r0, sp, #52	; 0x34
c0d01690:	2101      	movs	r1, #1
c0d01692:	f7ff fe91 	bl	c0d013b8 <mcu_usb_prints>
c0d01696:	9c05      	ldr	r4, [sp, #20]
    while(*format)
c0d01698:	7820      	ldrb	r0, [r4, #0]
c0d0169a:	2800      	cmp	r0, #0
c0d0169c:	d03f      	beq.n	c0d0171e <mcu_usb_printf+0x312>
c0d0169e:	e6c6      	b.n	c0d0142e <mcu_usb_printf+0x22>
c0d016a0:	2000      	movs	r0, #0
c0d016a2:	4625      	mov	r5, r4
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0d016a4:	5c3a      	ldrb	r2, [r7, r0]
c0d016a6:	1c40      	adds	r0, r0, #1
c0d016a8:	2a00      	cmp	r2, #0
c0d016aa:	d1fb      	bne.n	c0d016a4 <mcu_usb_printf+0x298>
                    switch(ulBase) {
c0d016ac:	1e46      	subs	r6, r0, #1
c0d016ae:	e001      	b.n	c0d016b4 <mcu_usb_printf+0x2a8>
c0d016b0:	462e      	mov	r6, r5
c0d016b2:	4625      	mov	r5, r4
c0d016b4:	9807      	ldr	r0, [sp, #28]
c0d016b6:	2800      	cmp	r0, #0
c0d016b8:	d00f      	beq.n	c0d016da <mcu_usb_printf+0x2ce>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d016ba:	2e00      	cmp	r6, #0
c0d016bc:	d0eb      	beq.n	c0d01696 <mcu_usb_printf+0x28a>
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0d016be:	783c      	ldrb	r4, [r7, #0]
c0d016c0:	0920      	lsrs	r0, r4, #4
c0d016c2:	5c28      	ldrb	r0, [r5, r0]
c0d016c4:	f7ff fd3c 	bl	c0d01140 <mcu_usb_printc>
c0d016c8:	200f      	movs	r0, #15
                          nibble2 = pcStr[ulCount]&0xF;
c0d016ca:	4020      	ands	r0, r4
c0d016cc:	5c28      	ldrb	r0, [r5, r0]
c0d016ce:	f7ff fd37 	bl	c0d01140 <mcu_usb_printc>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0d016d2:	1c7f      	adds	r7, r7, #1
c0d016d4:	1e76      	subs	r6, r6, #1
c0d016d6:	d1f2      	bne.n	c0d016be <mcu_usb_printf+0x2b2>
c0d016d8:	e7dd      	b.n	c0d01696 <mcu_usb_printf+0x28a>
c0d016da:	9106      	str	r1, [sp, #24]
                        mcu_usb_prints(pcStr, ulIdx);
c0d016dc:	4638      	mov	r0, r7
c0d016de:	4631      	mov	r1, r6
c0d016e0:	f7ff fe6a 	bl	c0d013b8 <mcu_usb_prints>
c0d016e4:	e00f      	b.n	c0d01706 <mcu_usb_printf+0x2fa>
                        ulValue = -(long)ulValue;
c0d016e6:	4240      	negs	r0, r0
c0d016e8:	900d      	str	r0, [sp, #52]	; 0x34
c0d016ea:	2200      	movs	r2, #0
c0d016ec:	9203      	str	r2, [sp, #12]
c0d016ee:	9202      	str	r2, [sp, #8]
c0d016f0:	e73c      	b.n	c0d0156c <mcu_usb_printf+0x160>
c0d016f2:	9106      	str	r1, [sp, #24]
                          do {
c0d016f4:	1c74      	adds	r4, r6, #1
                            mcu_usb_prints(" ", 1);
c0d016f6:	4810      	ldr	r0, [pc, #64]	; (c0d01738 <mcu_usb_printf+0x32c>)
c0d016f8:	4478      	add	r0, pc
c0d016fa:	2101      	movs	r1, #1
c0d016fc:	f7ff fe5c 	bl	c0d013b8 <mcu_usb_prints>
                          } while(ulStrlen-- > 0);
c0d01700:	1e64      	subs	r4, r4, #1
c0d01702:	d1f8      	bne.n	c0d016f6 <mcu_usb_printf+0x2ea>
c0d01704:	462e      	mov	r6, r5
c0d01706:	9806      	ldr	r0, [sp, #24]
                    if(ulCount > ulIdx)
c0d01708:	42b0      	cmp	r0, r6
c0d0170a:	d9c4      	bls.n	c0d01696 <mcu_usb_printf+0x28a>
                        while(ulCount--)
c0d0170c:	1a34      	subs	r4, r6, r0
                            mcu_usb_prints(" ", 1);
c0d0170e:	480b      	ldr	r0, [pc, #44]	; (c0d0173c <mcu_usb_printf+0x330>)
c0d01710:	4478      	add	r0, pc
c0d01712:	2101      	movs	r1, #1
c0d01714:	f7ff fe50 	bl	c0d013b8 <mcu_usb_prints>
                        while(ulCount--)
c0d01718:	1c64      	adds	r4, r4, #1
c0d0171a:	d3f8      	bcc.n	c0d0170e <mcu_usb_printf+0x302>
c0d0171c:	e7bb      	b.n	c0d01696 <mcu_usb_printf+0x28a>

    //
    // End the varargs processing.
    //
    va_end(vaArgP);
}
c0d0171e:	b00e      	add	sp, #56	; 0x38
c0d01720:	bcf0      	pop	{r4, r5, r6, r7}
c0d01722:	bc01      	pop	{r0}
c0d01724:	b003      	add	sp, #12
c0d01726:	4700      	bx	r0
c0d01728:	00001dcb 	.word	0x00001dcb
c0d0172c:	00001efd 	.word	0x00001efd
c0d01730:	00001e11 	.word	0x00001e11
c0d01734:	00001df9 	.word	0x00001df9
c0d01738:	00001d4f 	.word	0x00001d4f
c0d0173c:	00001d37 	.word	0x00001d37
c0d01740:	00001e37 	.word	0x00001e37
c0d01744:	00001e4d 	.word	0x00001e4d

c0d01748 <pic>:
// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern void _nvram;
extern void _envram;

void *pic(void *link_address) {
c0d01748:	b580      	push	{r7, lr}
  if (link_address >= &_nvram && link_address < &_envram) {
c0d0174a:	4904      	ldr	r1, [pc, #16]	; (c0d0175c <pic+0x14>)
c0d0174c:	4288      	cmp	r0, r1
c0d0174e:	d304      	bcc.n	c0d0175a <pic+0x12>
c0d01750:	4903      	ldr	r1, [pc, #12]	; (c0d01760 <pic+0x18>)
c0d01752:	4288      	cmp	r0, r1
c0d01754:	d201      	bcs.n	c0d0175a <pic+0x12>
    link_address = pic_internal(link_address);
c0d01756:	f000 f805 	bl	c0d01764 <pic_internal>
  }
  return link_address;
c0d0175a:	bd80      	pop	{r7, pc}
c0d0175c:	c0d00000 	.word	0xc0d00000
c0d01760:	c0d03980 	.word	0xc0d03980

c0d01764 <pic_internal>:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
__attribute__((naked)) void *pic_internal(void *link_address)
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");
c0d01764:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");
c0d01766:	4902      	ldr	r1, [pc, #8]	; (c0d01770 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");
c0d01768:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");
c0d0176a:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");
c0d0176c:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d0176e:	4770      	bx	lr
c0d01770:	c0d01765 	.word	0xc0d01765

c0d01774 <handleSignHash>:
#define SW_IMPROPER_INIT 0x6B02
#define SW_USER_REJECTED 0x6985
#define SW_OK 0x9000

void handleSignHash(uint8_t p1, uint8_t p2, uint8_t *dataBuffer, uint16_t dataLength, volatile unsigned int *flags, volatile unsigned int *tx)
{
c0d01774:	b510      	push	{r4, lr}
c0d01776:	4619      	mov	r1, r3
	for (int i = 0; i < dataLength; i++)
c0d01778:	2b00      	cmp	r3, #0
c0d0177a:	d007      	beq.n	c0d0178c <handleSignHash+0x18>
c0d0177c:	4806      	ldr	r0, [pc, #24]	; (c0d01798 <handleSignHash+0x24>)
c0d0177e:	460b      	mov	r3, r1
	{
		G_io_apdu_buffer[i] = dataBuffer[i];
c0d01780:	7814      	ldrb	r4, [r2, #0]
c0d01782:	7004      	strb	r4, [r0, #0]
	for (int i = 0; i < dataLength; i++)
c0d01784:	1c52      	adds	r2, r2, #1
c0d01786:	1c40      	adds	r0, r0, #1
c0d01788:	1e5b      	subs	r3, r3, #1
c0d0178a:	d1f9      	bne.n	c0d01780 <handleSignHash+0xc>
c0d0178c:	2009      	movs	r0, #9
c0d0178e:	0300      	lsls	r0, r0, #12
	}
	io_exchange_with_code(SW_OK, dataLength);
c0d01790:	f7ff f862 	bl	c0d00858 <io_exchange_with_code>
c0d01794:	bd10      	pop	{r4, pc}
c0d01796:	46c0      	nop			; (mov r8, r8)
c0d01798:	20000450 	.word	0x20000450

c0d0179c <SVC_Call>:
.thumb
.thumb_func
.global SVC_Call

SVC_Call:
    svc 1
c0d0179c:	df01      	svc	1
    cmp r1, #0
c0d0179e:	2900      	cmp	r1, #0
    bne exception
c0d017a0:	d100      	bne.n	c0d017a4 <exception>
    bx lr
c0d017a2:	4770      	bx	lr

c0d017a4 <exception>:
exception:
    // THROW(ex);
    mov r0, r1
c0d017a4:	4608      	mov	r0, r1
    bl os_longjmp
c0d017a6:	f7ff f94d 	bl	c0d00a44 <os_longjmp>
	...

c0d017ac <get_api_level>:
#include <string.h>

unsigned int SVC_Call(unsigned int syscall_id, void *parameters);
unsigned int SVC_cx_call(unsigned int syscall_id, unsigned int * parameters);

unsigned int get_api_level(void) {
c0d017ac:	b580      	push	{r7, lr}
c0d017ae:	b084      	sub	sp, #16
c0d017b0:	2000      	movs	r0, #0
  unsigned int parameters [2+1];
  parameters[0] = 0;
  parameters[1] = 0;
c0d017b2:	9002      	str	r0, [sp, #8]
  parameters[0] = 0;
c0d017b4:	9001      	str	r0, [sp, #4]
c0d017b6:	4803      	ldr	r0, [pc, #12]	; (c0d017c4 <get_api_level+0x18>)
c0d017b8:	a901      	add	r1, sp, #4
  return SVC_Call(SYSCALL_get_api_level_ID_IN, parameters);
c0d017ba:	f7ff ffef 	bl	c0d0179c <SVC_Call>
c0d017be:	b004      	add	sp, #16
c0d017c0:	bd80      	pop	{r7, pc}
c0d017c2:	46c0      	nop			; (mov r8, r8)
c0d017c4:	60000138 	.word	0x60000138

c0d017c8 <halt>:
}

void halt ( void ) {
c0d017c8:	b580      	push	{r7, lr}
c0d017ca:	b082      	sub	sp, #8
c0d017cc:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d017ce:	9001      	str	r0, [sp, #4]
c0d017d0:	4802      	ldr	r0, [pc, #8]	; (c0d017dc <halt+0x14>)
c0d017d2:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_halt_ID_IN, parameters);
c0d017d4:	f7ff ffe2 	bl	c0d0179c <SVC_Call>
  return;
}
c0d017d8:	b002      	add	sp, #8
c0d017da:	bd80      	pop	{r7, pc}
c0d017dc:	6000023c 	.word	0x6000023c

c0d017e0 <os_perso_isonboarded>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_perso_finalize_ID_IN, parameters);
  return;
}

bolos_bool_t os_perso_isonboarded ( void ) {
c0d017e0:	b580      	push	{r7, lr}
c0d017e2:	b082      	sub	sp, #8
c0d017e4:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d017e6:	9001      	str	r0, [sp, #4]
c0d017e8:	4803      	ldr	r0, [pc, #12]	; (c0d017f8 <os_perso_isonboarded+0x18>)
c0d017ea:	4669      	mov	r1, sp
  return (bolos_bool_t) SVC_Call(SYSCALL_os_perso_isonboarded_ID_IN, parameters);
c0d017ec:	f7ff ffd6 	bl	c0d0179c <SVC_Call>
c0d017f0:	b2c0      	uxtb	r0, r0
c0d017f2:	b002      	add	sp, #8
c0d017f4:	bd80      	pop	{r7, pc}
c0d017f6:	46c0      	nop			; (mov r8, r8)
c0d017f8:	60009f4f 	.word	0x60009f4f

c0d017fc <os_perso_derive_node_bip32>:
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, const unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) {
c0d017fc:	b510      	push	{r4, lr}
c0d017fe:	b088      	sub	sp, #32
c0d01800:	9c0a      	ldr	r4, [sp, #40]	; 0x28
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)curve;
  parameters[1] = (unsigned int)path;
  parameters[2] = (unsigned int)pathLength;
  parameters[3] = (unsigned int)privateKey;
  parameters[4] = (unsigned int)chain;
c0d01802:	9405      	str	r4, [sp, #20]
  parameters[3] = (unsigned int)privateKey;
c0d01804:	9304      	str	r3, [sp, #16]
  parameters[2] = (unsigned int)pathLength;
c0d01806:	9203      	str	r2, [sp, #12]
  parameters[1] = (unsigned int)path;
c0d01808:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)curve;
c0d0180a:	9001      	str	r0, [sp, #4]
c0d0180c:	4802      	ldr	r0, [pc, #8]	; (c0d01818 <os_perso_derive_node_bip32+0x1c>)
c0d0180e:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_perso_derive_node_bip32_ID_IN, parameters);
c0d01810:	f7ff ffc4 	bl	c0d0179c <SVC_Call>
  return;
}
c0d01814:	b008      	add	sp, #32
c0d01816:	bd10      	pop	{r4, pc}
c0d01818:	600053ba 	.word	0x600053ba

c0d0181c <os_perso_seed_cookie>:
  parameters[3] = (unsigned int)privateKey;
  SVC_Call(SYSCALL_os_perso_derive_eip2333_ID_IN, parameters);
  return;
}

unsigned int os_perso_seed_cookie ( unsigned char * seed_cookie, unsigned int seed_cookie_length ) {
c0d0181c:	b580      	push	{r7, lr}
c0d0181e:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)seed_cookie;
  parameters[1] = (unsigned int)seed_cookie_length;
c0d01820:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)seed_cookie;
c0d01822:	9000      	str	r0, [sp, #0]
c0d01824:	4802      	ldr	r0, [pc, #8]	; (c0d01830 <os_perso_seed_cookie+0x14>)
c0d01826:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_os_perso_seed_cookie_ID_IN, parameters);
c0d01828:	f7ff ffb8 	bl	c0d0179c <SVC_Call>
c0d0182c:	b004      	add	sp, #16
c0d0182e:	bd80      	pop	{r7, pc}
c0d01830:	6000a8fc 	.word	0x6000a8fc

c0d01834 <os_global_pin_is_validated>:
  parameters[1] = (unsigned int)length;
  SVC_Call(SYSCALL_os_perso_set_current_identity_pin_ID_IN, parameters);
  return;
}

bolos_bool_t os_global_pin_is_validated ( void ) {
c0d01834:	b580      	push	{r7, lr}
c0d01836:	b082      	sub	sp, #8
c0d01838:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d0183a:	9001      	str	r0, [sp, #4]
c0d0183c:	4803      	ldr	r0, [pc, #12]	; (c0d0184c <os_global_pin_is_validated+0x18>)
c0d0183e:	4669      	mov	r1, sp
  return (bolos_bool_t) SVC_Call(SYSCALL_os_global_pin_is_validated_ID_IN, parameters);
c0d01840:	f7ff ffac 	bl	c0d0179c <SVC_Call>
c0d01844:	b2c0      	uxtb	r0, r0
c0d01846:	b002      	add	sp, #8
c0d01848:	bd80      	pop	{r7, pc}
c0d0184a:	46c0      	nop			; (mov r8, r8)
c0d0184c:	6000a03c 	.word	0x6000a03c

c0d01850 <os_ux>:
  parameters[1] = (unsigned int)out_application_entry;
  SVC_Call(SYSCALL_os_registry_get_ID_IN, parameters);
  return;
}

unsigned int os_ux ( bolos_ux_params_t * params ) {
c0d01850:	b580      	push	{r7, lr}
c0d01852:	b084      	sub	sp, #16
c0d01854:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)params;
  parameters[1] = 0;
c0d01856:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)params;
c0d01858:	9001      	str	r0, [sp, #4]
c0d0185a:	4803      	ldr	r0, [pc, #12]	; (c0d01868 <os_ux+0x18>)
c0d0185c:	a901      	add	r1, sp, #4
  return (unsigned int) SVC_Call(SYSCALL_os_ux_ID_IN, parameters);
c0d0185e:	f7ff ff9d 	bl	c0d0179c <SVC_Call>
c0d01862:	b004      	add	sp, #16
c0d01864:	bd80      	pop	{r7, pc}
c0d01866:	46c0      	nop			; (mov r8, r8)
c0d01868:	60006458 	.word	0x60006458

c0d0186c <os_flags>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_lib_end_ID_IN, parameters);
  return;
}

unsigned int os_flags ( void ) {
c0d0186c:	b580      	push	{r7, lr}
c0d0186e:	b082      	sub	sp, #8
c0d01870:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d01872:	9001      	str	r0, [sp, #4]
c0d01874:	4802      	ldr	r0, [pc, #8]	; (c0d01880 <os_flags+0x14>)
c0d01876:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_os_flags_ID_IN, parameters);
c0d01878:	f7ff ff90 	bl	c0d0179c <SVC_Call>
c0d0187c:	b002      	add	sp, #8
c0d0187e:	bd80      	pop	{r7, pc}
c0d01880:	60006a6e 	.word	0x60006a6e

c0d01884 <os_registry_get_current_app_tag>:
  parameters[4] = (unsigned int)buffer;
  parameters[5] = (unsigned int)maxlength;
  return (unsigned int) SVC_Call(SYSCALL_os_registry_get_tag_ID_IN, parameters);
}

unsigned int os_registry_get_current_app_tag ( unsigned int tag, unsigned char * buffer, unsigned int maxlen ) {
c0d01884:	b580      	push	{r7, lr}
c0d01886:	b086      	sub	sp, #24
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)tag;
c0d01888:	ab01      	add	r3, sp, #4
c0d0188a:	c307      	stmia	r3!, {r0, r1, r2}
c0d0188c:	4802      	ldr	r0, [pc, #8]	; (c0d01898 <os_registry_get_current_app_tag+0x14>)
c0d0188e:	a901      	add	r1, sp, #4
  parameters[1] = (unsigned int)buffer;
  parameters[2] = (unsigned int)maxlen;
  return (unsigned int) SVC_Call(SYSCALL_os_registry_get_current_app_tag_ID_IN, parameters);
c0d01890:	f7ff ff84 	bl	c0d0179c <SVC_Call>
c0d01894:	b006      	add	sp, #24
c0d01896:	bd80      	pop	{r7, pc}
c0d01898:	600074d4 	.word	0x600074d4

c0d0189c <os_sched_exit>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_exec_ID_IN, parameters);
  return;
}

void os_sched_exit ( bolos_task_status_t exit_code ) {
c0d0189c:	b580      	push	{r7, lr}
c0d0189e:	b084      	sub	sp, #16
c0d018a0:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)exit_code;
  parameters[1] = 0;
c0d018a2:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)exit_code;
c0d018a4:	9001      	str	r0, [sp, #4]
c0d018a6:	4803      	ldr	r0, [pc, #12]	; (c0d018b4 <os_sched_exit+0x18>)
c0d018a8:	a901      	add	r1, sp, #4
  SVC_Call(SYSCALL_os_sched_exit_ID_IN, parameters);
c0d018aa:	f7ff ff77 	bl	c0d0179c <SVC_Call>
  return;
}
c0d018ae:	b004      	add	sp, #16
c0d018b0:	bd80      	pop	{r7, pc}
c0d018b2:	46c0      	nop			; (mov r8, r8)
c0d018b4:	60009abe 	.word	0x60009abe

c0d018b8 <io_seph_send>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_kill_ID_IN, parameters);
  return;
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) {
c0d018b8:	b580      	push	{r7, lr}
c0d018ba:	b084      	sub	sp, #16
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)buffer;
  parameters[1] = (unsigned int)length;
c0d018bc:	9101      	str	r1, [sp, #4]
  parameters[0] = (unsigned int)buffer;
c0d018be:	9000      	str	r0, [sp, #0]
c0d018c0:	4802      	ldr	r0, [pc, #8]	; (c0d018cc <io_seph_send+0x14>)
c0d018c2:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_io_seph_send_ID_IN, parameters);
c0d018c4:	f7ff ff6a 	bl	c0d0179c <SVC_Call>
  return;
}
c0d018c8:	b004      	add	sp, #16
c0d018ca:	bd80      	pop	{r7, pc}
c0d018cc:	60008381 	.word	0x60008381

c0d018d0 <io_seph_is_status_sent>:

unsigned int io_seph_is_status_sent ( void ) {
c0d018d0:	b580      	push	{r7, lr}
c0d018d2:	b082      	sub	sp, #8
c0d018d4:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d018d6:	9001      	str	r0, [sp, #4]
c0d018d8:	4802      	ldr	r0, [pc, #8]	; (c0d018e4 <io_seph_is_status_sent+0x14>)
c0d018da:	4669      	mov	r1, sp
  return (unsigned int) SVC_Call(SYSCALL_io_seph_is_status_sent_ID_IN, parameters);
c0d018dc:	f7ff ff5e 	bl	c0d0179c <SVC_Call>
c0d018e0:	b002      	add	sp, #8
c0d018e2:	bd80      	pop	{r7, pc}
c0d018e4:	600084bb 	.word	0x600084bb

c0d018e8 <io_seph_recv>:
}

unsigned short io_seph_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) {
c0d018e8:	b580      	push	{r7, lr}
c0d018ea:	b086      	sub	sp, #24
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)buffer;
c0d018ec:	ab01      	add	r3, sp, #4
c0d018ee:	c307      	stmia	r3!, {r0, r1, r2}
c0d018f0:	4803      	ldr	r0, [pc, #12]	; (c0d01900 <io_seph_recv+0x18>)
c0d018f2:	a901      	add	r1, sp, #4
  parameters[1] = (unsigned int)maxlength;
  parameters[2] = (unsigned int)flags;
  return (unsigned short) SVC_Call(SYSCALL_io_seph_recv_ID_IN, parameters);
c0d018f4:	f7ff ff52 	bl	c0d0179c <SVC_Call>
c0d018f8:	b280      	uxth	r0, r0
c0d018fa:	b006      	add	sp, #24
c0d018fc:	bd80      	pop	{r7, pc}
c0d018fe:	46c0      	nop			; (mov r8, r8)
c0d01900:	600085e4 	.word	0x600085e4

c0d01904 <try_context_get>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_nvm_erase_page_ID_IN, parameters);
  return;
}

try_context_t * try_context_get ( void ) {
c0d01904:	b580      	push	{r7, lr}
c0d01906:	b082      	sub	sp, #8
c0d01908:	2000      	movs	r0, #0
  unsigned int parameters [2];
  parameters[1] = 0;
c0d0190a:	9001      	str	r0, [sp, #4]
c0d0190c:	4802      	ldr	r0, [pc, #8]	; (c0d01918 <try_context_get+0x14>)
c0d0190e:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_get_ID_IN, parameters);
c0d01910:	f7ff ff44 	bl	c0d0179c <SVC_Call>
c0d01914:	b002      	add	sp, #8
c0d01916:	bd80      	pop	{r7, pc}
c0d01918:	600087b1 	.word	0x600087b1

c0d0191c <try_context_set>:
}

try_context_t * try_context_set ( try_context_t *context ) {
c0d0191c:	b580      	push	{r7, lr}
c0d0191e:	b084      	sub	sp, #16
c0d01920:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)context;
  parameters[1] = 0;
c0d01922:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)context;
c0d01924:	9001      	str	r0, [sp, #4]
c0d01926:	4803      	ldr	r0, [pc, #12]	; (c0d01934 <try_context_set+0x18>)
c0d01928:	a901      	add	r1, sp, #4
  return (try_context_t *) SVC_Call(SYSCALL_try_context_set_ID_IN, parameters);
c0d0192a:	f7ff ff37 	bl	c0d0179c <SVC_Call>
c0d0192e:	b004      	add	sp, #16
c0d01930:	bd80      	pop	{r7, pc}
c0d01932:	46c0      	nop			; (mov r8, r8)
c0d01934:	60010b06 	.word	0x60010b06

c0d01938 <os_sched_last_status>:
}

bolos_task_status_t os_sched_last_status ( unsigned int task_idx ) {
c0d01938:	b580      	push	{r7, lr}
c0d0193a:	b084      	sub	sp, #16
c0d0193c:	2100      	movs	r1, #0
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)task_idx;
  parameters[1] = 0;
c0d0193e:	9102      	str	r1, [sp, #8]
  parameters[0] = (unsigned int)task_idx;
c0d01940:	9001      	str	r0, [sp, #4]
c0d01942:	4803      	ldr	r0, [pc, #12]	; (c0d01950 <os_sched_last_status+0x18>)
c0d01944:	a901      	add	r1, sp, #4
  return (bolos_task_status_t) SVC_Call(SYSCALL_os_sched_last_status_ID_IN, parameters);
c0d01946:	f7ff ff29 	bl	c0d0179c <SVC_Call>
c0d0194a:	b2c0      	uxtb	r0, r0
c0d0194c:	b004      	add	sp, #16
c0d0194e:	bd80      	pop	{r7, pc}
c0d01950:	60009c8b 	.word	0x60009c8b

c0d01954 <USBD_LL_Init>:
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
  ep_out_stall = 0;
c0d01954:	4902      	ldr	r1, [pc, #8]	; (c0d01960 <USBD_LL_Init+0xc>)
c0d01956:	2000      	movs	r0, #0
c0d01958:	6008      	str	r0, [r1, #0]
  ep_in_stall = 0;
c0d0195a:	4902      	ldr	r1, [pc, #8]	; (c0d01964 <USBD_LL_Init+0x10>)
c0d0195c:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d0195e:	4770      	bx	lr
c0d01960:	200005d4 	.word	0x200005d4
c0d01964:	200005d0 	.word	0x200005d0

c0d01968 <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d01968:	b510      	push	{r4, lr}
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0196a:	4807      	ldr	r0, [pc, #28]	; (c0d01988 <USBD_LL_DeInit+0x20>)
c0d0196c:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[1] = 0;
  G_io_seproxyhal_spi_buffer[2] = 1;
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d0196e:	70c1      	strb	r1, [r0, #3]
c0d01970:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d01972:	7081      	strb	r1, [r0, #2]
c0d01974:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d01976:	7044      	strb	r4, [r0, #1]
c0d01978:	214f      	movs	r1, #79	; 0x4f
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d0197a:	7001      	strb	r1, [r0, #0]
c0d0197c:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d0197e:	f7ff ff9b 	bl	c0d018b8 <io_seph_send>

  return USBD_OK; 
c0d01982:	4620      	mov	r0, r4
c0d01984:	bd10      	pop	{r4, pc}
c0d01986:	46c0      	nop			; (mov r8, r8)
c0d01988:	200003d0 	.word	0x200003d0

c0d0198c <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d0198c:	b570      	push	{r4, r5, r6, lr}
c0d0198e:	b082      	sub	sp, #8
c0d01990:	466d      	mov	r5, sp
c0d01992:	2400      	movs	r4, #0
  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = 0;
c0d01994:	712c      	strb	r4, [r5, #4]
c0d01996:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d01998:	70e8      	strb	r0, [r5, #3]
c0d0199a:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d0199c:	70a8      	strb	r0, [r5, #2]
  buffer[1] = 0;
c0d0199e:	706c      	strb	r4, [r5, #1]
c0d019a0:	264f      	movs	r6, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d019a2:	702e      	strb	r6, [r5, #0]
c0d019a4:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d019a6:	4628      	mov	r0, r5
c0d019a8:	f7ff ff86 	bl	c0d018b8 <io_seph_send>
c0d019ac:	2001      	movs	r0, #1
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d019ae:	70e8      	strb	r0, [r5, #3]
  buffer[2] = 1;
c0d019b0:	70a8      	strb	r0, [r5, #2]
  buffer[1] = 0;
c0d019b2:	706c      	strb	r4, [r5, #1]
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d019b4:	702e      	strb	r6, [r5, #0]
c0d019b6:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d019b8:	4628      	mov	r0, r5
c0d019ba:	f7ff ff7d 	bl	c0d018b8 <io_seph_send>
  return USBD_OK; 
c0d019be:	4620      	mov	r0, r4
c0d019c0:	b002      	add	sp, #8
c0d019c2:	bd70      	pop	{r4, r5, r6, pc}

c0d019c4 <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d019c4:	b510      	push	{r4, lr}
c0d019c6:	b082      	sub	sp, #8
c0d019c8:	a801      	add	r0, sp, #4
c0d019ca:	2102      	movs	r1, #2
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 1;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d019cc:	70c1      	strb	r1, [r0, #3]
c0d019ce:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d019d0:	7081      	strb	r1, [r0, #2]
c0d019d2:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d019d4:	7044      	strb	r4, [r0, #1]
c0d019d6:	214f      	movs	r1, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d019d8:	7001      	strb	r1, [r0, #0]
c0d019da:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d019dc:	f7ff ff6c 	bl	c0d018b8 <io_seph_send>
  return USBD_OK; 
c0d019e0:	4620      	mov	r0, r4
c0d019e2:	b002      	add	sp, #8
c0d019e4:	bd10      	pop	{r4, pc}
	...

c0d019e8 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d019e8:	b570      	push	{r4, r5, r6, lr}
c0d019ea:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d019ec:	4814      	ldr	r0, [pc, #80]	; (c0d01a40 <USBD_LL_OpenEP+0x58>)
c0d019ee:	2400      	movs	r4, #0
c0d019f0:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d019f2:	4814      	ldr	r0, [pc, #80]	; (c0d01a44 <USBD_LL_OpenEP+0x5c>)
c0d019f4:	6004      	str	r4, [r0, #0]
c0d019f6:	466d      	mov	r5, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d019f8:	71ac      	strb	r4, [r5, #6]
  buffer[5] = ep_addr;
c0d019fa:	7169      	strb	r1, [r5, #5]
c0d019fc:	2001      	movs	r0, #1
  buffer[4] = 1;
c0d019fe:	7128      	strb	r0, [r5, #4]
c0d01a00:	2104      	movs	r1, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d01a02:	70e9      	strb	r1, [r5, #3]
c0d01a04:	2605      	movs	r6, #5
  buffer[2] = 5;
c0d01a06:	70ae      	strb	r6, [r5, #2]
  buffer[1] = 0;
c0d01a08:	706c      	strb	r4, [r5, #1]
c0d01a0a:	244f      	movs	r4, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01a0c:	702c      	strb	r4, [r5, #0]
  switch(ep_type) {
c0d01a0e:	2a01      	cmp	r2, #1
c0d01a10:	dc05      	bgt.n	c0d01a1e <USBD_LL_OpenEP+0x36>
c0d01a12:	2a00      	cmp	r2, #0
c0d01a14:	d00a      	beq.n	c0d01a2c <USBD_LL_OpenEP+0x44>
c0d01a16:	2a01      	cmp	r2, #1
c0d01a18:	d10a      	bne.n	c0d01a30 <USBD_LL_OpenEP+0x48>
c0d01a1a:	4608      	mov	r0, r1
c0d01a1c:	e006      	b.n	c0d01a2c <USBD_LL_OpenEP+0x44>
c0d01a1e:	2a02      	cmp	r2, #2
c0d01a20:	d003      	beq.n	c0d01a2a <USBD_LL_OpenEP+0x42>
c0d01a22:	2a03      	cmp	r2, #3
c0d01a24:	d104      	bne.n	c0d01a30 <USBD_LL_OpenEP+0x48>
c0d01a26:	2002      	movs	r0, #2
c0d01a28:	e000      	b.n	c0d01a2c <USBD_LL_OpenEP+0x44>
c0d01a2a:	2003      	movs	r0, #3
c0d01a2c:	4669      	mov	r1, sp
c0d01a2e:	7188      	strb	r0, [r1, #6]
c0d01a30:	4668      	mov	r0, sp
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d01a32:	71c3      	strb	r3, [r0, #7]
c0d01a34:	2108      	movs	r1, #8
  io_seproxyhal_spi_send(buffer, 8);
c0d01a36:	f7ff ff3f 	bl	c0d018b8 <io_seph_send>
c0d01a3a:	2000      	movs	r0, #0
  return USBD_OK; 
c0d01a3c:	b002      	add	sp, #8
c0d01a3e:	bd70      	pop	{r4, r5, r6, pc}
c0d01a40:	200005d0 	.word	0x200005d0
c0d01a44:	200005d4 	.word	0x200005d4

c0d01a48 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d01a48:	b5b0      	push	{r4, r5, r7, lr}
c0d01a4a:	b082      	sub	sp, #8
c0d01a4c:	460d      	mov	r5, r1
c0d01a4e:	4668      	mov	r0, sp
c0d01a50:	2400      	movs	r4, #0
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
  buffer[5] = 0;
c0d01a52:	7144      	strb	r4, [r0, #5]
c0d01a54:	2140      	movs	r1, #64	; 0x40
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d01a56:	7101      	strb	r1, [r0, #4]
  buffer[3] = ep_addr;
c0d01a58:	70c5      	strb	r5, [r0, #3]
c0d01a5a:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d01a5c:	7081      	strb	r1, [r0, #2]
  buffer[1] = 0;
c0d01a5e:	7044      	strb	r4, [r0, #1]
c0d01a60:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01a62:	7001      	strb	r1, [r0, #0]
c0d01a64:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d01a66:	f7ff ff27 	bl	c0d018b8 <io_seph_send>
c0d01a6a:	0628      	lsls	r0, r5, #24
c0d01a6c:	d501      	bpl.n	c0d01a72 <USBD_LL_StallEP+0x2a>
c0d01a6e:	4807      	ldr	r0, [pc, #28]	; (c0d01a8c <USBD_LL_StallEP+0x44>)
c0d01a70:	e000      	b.n	c0d01a74 <USBD_LL_StallEP+0x2c>
c0d01a72:	4805      	ldr	r0, [pc, #20]	; (c0d01a88 <USBD_LL_StallEP+0x40>)
c0d01a74:	6801      	ldr	r1, [r0, #0]
c0d01a76:	227f      	movs	r2, #127	; 0x7f
c0d01a78:	4015      	ands	r5, r2
c0d01a7a:	2201      	movs	r2, #1
c0d01a7c:	40aa      	lsls	r2, r5
c0d01a7e:	430a      	orrs	r2, r1
c0d01a80:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d01a82:	4620      	mov	r0, r4
c0d01a84:	b002      	add	sp, #8
c0d01a86:	bdb0      	pop	{r4, r5, r7, pc}
c0d01a88:	200005d4 	.word	0x200005d4
c0d01a8c:	200005d0 	.word	0x200005d0

c0d01a90 <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d01a90:	b5b0      	push	{r4, r5, r7, lr}
c0d01a92:	b082      	sub	sp, #8
c0d01a94:	460d      	mov	r5, r1
c0d01a96:	4668      	mov	r0, sp
c0d01a98:	2400      	movs	r4, #0
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = 0;
  buffer[2] = 3;
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
  buffer[5] = 0;
c0d01a9a:	7144      	strb	r4, [r0, #5]
c0d01a9c:	2180      	movs	r1, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d01a9e:	7101      	strb	r1, [r0, #4]
  buffer[3] = ep_addr;
c0d01aa0:	70c5      	strb	r5, [r0, #3]
c0d01aa2:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d01aa4:	7081      	strb	r1, [r0, #2]
  buffer[1] = 0;
c0d01aa6:	7044      	strb	r4, [r0, #1]
c0d01aa8:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01aaa:	7001      	strb	r1, [r0, #0]
c0d01aac:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d01aae:	f7ff ff03 	bl	c0d018b8 <io_seph_send>
c0d01ab2:	0628      	lsls	r0, r5, #24
c0d01ab4:	d501      	bpl.n	c0d01aba <USBD_LL_ClearStallEP+0x2a>
c0d01ab6:	4807      	ldr	r0, [pc, #28]	; (c0d01ad4 <USBD_LL_ClearStallEP+0x44>)
c0d01ab8:	e000      	b.n	c0d01abc <USBD_LL_ClearStallEP+0x2c>
c0d01aba:	4805      	ldr	r0, [pc, #20]	; (c0d01ad0 <USBD_LL_ClearStallEP+0x40>)
c0d01abc:	6801      	ldr	r1, [r0, #0]
c0d01abe:	227f      	movs	r2, #127	; 0x7f
c0d01ac0:	4015      	ands	r5, r2
c0d01ac2:	2201      	movs	r2, #1
c0d01ac4:	40aa      	lsls	r2, r5
c0d01ac6:	4391      	bics	r1, r2
c0d01ac8:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d01aca:	4620      	mov	r0, r4
c0d01acc:	b002      	add	sp, #8
c0d01ace:	bdb0      	pop	{r4, r5, r7, pc}
c0d01ad0:	200005d4 	.word	0x200005d4
c0d01ad4:	200005d0 	.word	0x200005d0

c0d01ad8 <USBD_LL_IsStallEP>:
c0d01ad8:	0608      	lsls	r0, r1, #24
c0d01ada:	d501      	bpl.n	c0d01ae0 <USBD_LL_IsStallEP+0x8>
c0d01adc:	4805      	ldr	r0, [pc, #20]	; (c0d01af4 <USBD_LL_IsStallEP+0x1c>)
c0d01ade:	e000      	b.n	c0d01ae2 <USBD_LL_IsStallEP+0xa>
c0d01ae0:	4803      	ldr	r0, [pc, #12]	; (c0d01af0 <USBD_LL_IsStallEP+0x18>)
c0d01ae2:	7802      	ldrb	r2, [r0, #0]
c0d01ae4:	207f      	movs	r0, #127	; 0x7f
c0d01ae6:	4001      	ands	r1, r0
c0d01ae8:	2001      	movs	r0, #1
c0d01aea:	4088      	lsls	r0, r1
c0d01aec:	4010      	ands	r0, r2
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d01aee:	4770      	bx	lr
c0d01af0:	200005d4 	.word	0x200005d4
c0d01af4:	200005d0 	.word	0x200005d0

c0d01af8 <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d01af8:	b510      	push	{r4, lr}
c0d01afa:	b082      	sub	sp, #8
c0d01afc:	4668      	mov	r0, sp
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
  buffer[1] = 0;
  buffer[2] = 2;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
  buffer[4] = dev_addr;
c0d01afe:	7101      	strb	r1, [r0, #4]
c0d01b00:	2103      	movs	r1, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d01b02:	70c1      	strb	r1, [r0, #3]
c0d01b04:	2102      	movs	r1, #2
  buffer[2] = 2;
c0d01b06:	7081      	strb	r1, [r0, #2]
c0d01b08:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d01b0a:	7044      	strb	r4, [r0, #1]
c0d01b0c:	214f      	movs	r1, #79	; 0x4f
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01b0e:	7001      	strb	r1, [r0, #0]
c0d01b10:	2105      	movs	r1, #5
  io_seproxyhal_spi_send(buffer, 5);
c0d01b12:	f7ff fed1 	bl	c0d018b8 <io_seph_send>
  return USBD_OK; 
c0d01b16:	4620      	mov	r0, r4
c0d01b18:	b002      	add	sp, #8
c0d01b1a:	bd10      	pop	{r4, pc}

c0d01b1c <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d01b1c:	b5b0      	push	{r4, r5, r7, lr}
c0d01b1e:	b082      	sub	sp, #8
c0d01b20:	461c      	mov	r4, r3
c0d01b22:	4615      	mov	r5, r2
c0d01b24:	4668      	mov	r0, sp
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3+size)>>8;
  buffer[2] = (3+size);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
  buffer[5] = size;
c0d01b26:	7143      	strb	r3, [r0, #5]
c0d01b28:	2220      	movs	r2, #32
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d01b2a:	7102      	strb	r2, [r0, #4]
  buffer[3] = ep_addr;
c0d01b2c:	70c1      	strb	r1, [r0, #3]
c0d01b2e:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01b30:	7001      	strb	r1, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d01b32:	1cd9      	adds	r1, r3, #3
  buffer[2] = (3+size);
c0d01b34:	7081      	strb	r1, [r0, #2]
  buffer[1] = (3+size)>>8;
c0d01b36:	0a09      	lsrs	r1, r1, #8
c0d01b38:	7041      	strb	r1, [r0, #1]
c0d01b3a:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d01b3c:	f7ff febc 	bl	c0d018b8 <io_seph_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d01b40:	4628      	mov	r0, r5
c0d01b42:	4621      	mov	r1, r4
c0d01b44:	f7ff feb8 	bl	c0d018b8 <io_seph_send>
c0d01b48:	2000      	movs	r0, #0
  return USBD_OK;   
c0d01b4a:	b002      	add	sp, #8
c0d01b4c:	bdb0      	pop	{r4, r5, r7, pc}

c0d01b4e <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d01b4e:	b510      	push	{r4, lr}
c0d01b50:	b082      	sub	sp, #8
c0d01b52:	4668      	mov	r0, sp
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
  buffer[1] = (3/*+size*/)>>8;
  buffer[2] = (3/*+size*/);
  buffer[3] = ep_addr;
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
  buffer[5] = size; // expected size, not transmitted here !
c0d01b54:	7142      	strb	r2, [r0, #5]
c0d01b56:	2230      	movs	r2, #48	; 0x30
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d01b58:	7102      	strb	r2, [r0, #4]
  buffer[3] = ep_addr;
c0d01b5a:	70c1      	strb	r1, [r0, #3]
c0d01b5c:	2103      	movs	r1, #3
  buffer[2] = (3/*+size*/);
c0d01b5e:	7081      	strb	r1, [r0, #2]
c0d01b60:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d01b62:	7044      	strb	r4, [r0, #1]
c0d01b64:	2150      	movs	r1, #80	; 0x50
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01b66:	7001      	strb	r1, [r0, #0]
c0d01b68:	2106      	movs	r1, #6
  io_seproxyhal_spi_send(buffer, 6);
c0d01b6a:	f7ff fea5 	bl	c0d018b8 <io_seph_send>
  return USBD_OK;   
c0d01b6e:	4620      	mov	r0, r4
c0d01b70:	b002      	add	sp, #8
c0d01b72:	bd10      	pop	{r4, pc}

c0d01b74 <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d01b74:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b76:	b081      	sub	sp, #4
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d01b78:	2800      	cmp	r0, #0
c0d01b7a:	d014      	beq.n	c0d01ba6 <USBD_Init+0x32>
c0d01b7c:	4615      	mov	r5, r2
c0d01b7e:	460e      	mov	r6, r1
c0d01b80:	4604      	mov	r4, r0
c0d01b82:	4607      	mov	r7, r0
c0d01b84:	37dc      	adds	r7, #220	; 0xdc
c0d01b86:	2045      	movs	r0, #69	; 0x45
c0d01b88:	0081      	lsls	r1, r0, #2
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d01b8a:	4620      	mov	r0, r4
c0d01b8c:	f001 fa5c 	bl	c0d03048 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d01b90:	2e00      	cmp	r6, #0
c0d01b92:	d000      	beq.n	c0d01b96 <USBD_Init+0x22>
  {
    pdev->pDesc = pdesc;
c0d01b94:	617e      	str	r6, [r7, #20]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
  pdev->id = id;
c0d01b96:	7025      	strb	r5, [r4, #0]
c0d01b98:	2001      	movs	r0, #1
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d01b9a:	7038      	strb	r0, [r7, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d01b9c:	4620      	mov	r0, r4
c0d01b9e:	f7ff fed9 	bl	c0d01954 <USBD_LL_Init>
c0d01ba2:	2000      	movs	r0, #0
c0d01ba4:	e000      	b.n	c0d01ba8 <USBD_Init+0x34>
c0d01ba6:	2002      	movs	r0, #2
  
  return USBD_OK; 
}
c0d01ba8:	b001      	add	sp, #4
c0d01baa:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01bac <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d01bac:	b5b0      	push	{r4, r5, r7, lr}
c0d01bae:	4604      	mov	r4, r0
c0d01bb0:	20dc      	movs	r0, #220	; 0xdc
c0d01bb2:	2101      	movs	r1, #1
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d01bb4:	5421      	strb	r1, [r4, r0]
c0d01bb6:	2017      	movs	r0, #23
c0d01bb8:	43c5      	mvns	r5, r0
  
  /* Free Class Resources */
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(pdev->interfacesClass[intf].pClass != NULL) {
c0d01bba:	1960      	adds	r0, r4, r5
c0d01bbc:	2143      	movs	r1, #67	; 0x43
c0d01bbe:	0089      	lsls	r1, r1, #2
c0d01bc0:	5840      	ldr	r0, [r0, r1]
c0d01bc2:	2800      	cmp	r0, #0
c0d01bc4:	d006      	beq.n	c0d01bd4 <USBD_DeInit+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config);  
c0d01bc6:	6840      	ldr	r0, [r0, #4]
c0d01bc8:	f7ff fdbe 	bl	c0d01748 <pic>
c0d01bcc:	4602      	mov	r2, r0
c0d01bce:	7921      	ldrb	r1, [r4, #4]
c0d01bd0:	4620      	mov	r0, r4
c0d01bd2:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01bd4:	3508      	adds	r5, #8
c0d01bd6:	d1f0      	bne.n	c0d01bba <USBD_DeInit+0xe>
    }
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d01bd8:	4620      	mov	r0, r4
c0d01bda:	f7ff fef3 	bl	c0d019c4 <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d01bde:	4620      	mov	r0, r4
c0d01be0:	f7ff fec2 	bl	c0d01968 <USBD_LL_DeInit>
c0d01be4:	2000      	movs	r0, #0
  
  return USBD_OK;
c0d01be6:	bdb0      	pop	{r4, r5, r7, pc}

c0d01be8 <USBD_RegisterClassForInterface>:
  * @retval USBD Status
  */
USBD_StatusTypeDef USBD_RegisterClassForInterface(uint8_t interfaceidx, USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d01be8:	2a00      	cmp	r2, #0
c0d01bea:	d008      	beq.n	c0d01bfe <USBD_RegisterClassForInterface+0x16>
c0d01bec:	4603      	mov	r3, r0
c0d01bee:	2000      	movs	r0, #0
  {
    if (interfaceidx < USBD_MAX_NUM_INTERFACES) {
c0d01bf0:	2b02      	cmp	r3, #2
c0d01bf2:	d803      	bhi.n	c0d01bfc <USBD_RegisterClassForInterface+0x14>
      /* link the class to the USB Device handle */
      pdev->interfacesClass[interfaceidx].pClass = pclass;
c0d01bf4:	00db      	lsls	r3, r3, #3
c0d01bf6:	18c9      	adds	r1, r1, r3
c0d01bf8:	23f4      	movs	r3, #244	; 0xf4
c0d01bfa:	50ca      	str	r2, [r1, r3]
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d01bfc:	4770      	bx	lr
c0d01bfe:	2002      	movs	r0, #2
c0d01c00:	4770      	bx	lr

c0d01c02 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d01c02:	b580      	push	{r7, lr}
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d01c04:	f7ff fec2 	bl	c0d0198c <USBD_LL_Start>
c0d01c08:	2000      	movs	r0, #0
  
  return USBD_OK;  
c0d01c0a:	bd80      	pop	{r7, pc}

c0d01c0c <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d01c0c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c0e:	b081      	sub	sp, #4
c0d01c10:	460c      	mov	r4, r1
c0d01c12:	4605      	mov	r5, r0
c0d01c14:	2600      	movs	r6, #0
c0d01c16:	27f4      	movs	r7, #244	; 0xf4
  /* Set configuration  and Start the Class*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d01c18:	4628      	mov	r0, r5
c0d01c1a:	4631      	mov	r1, r6
c0d01c1c:	f000 f95f 	bl	c0d01ede <usbd_is_valid_intf>
c0d01c20:	2800      	cmp	r0, #0
c0d01c22:	d007      	beq.n	c0d01c34 <USBD_SetClassConfig+0x28>
      ((Init_t)PIC(pdev->interfacesClass[intf].pClass->Init))(pdev, cfgidx);
c0d01c24:	59e8      	ldr	r0, [r5, r7]
c0d01c26:	6800      	ldr	r0, [r0, #0]
c0d01c28:	f7ff fd8e 	bl	c0d01748 <pic>
c0d01c2c:	4602      	mov	r2, r0
c0d01c2e:	4628      	mov	r0, r5
c0d01c30:	4621      	mov	r1, r4
c0d01c32:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01c34:	3708      	adds	r7, #8
c0d01c36:	1c76      	adds	r6, r6, #1
c0d01c38:	2e03      	cmp	r6, #3
c0d01c3a:	d1ed      	bne.n	c0d01c18 <USBD_SetClassConfig+0xc>
c0d01c3c:	2000      	movs	r0, #0
    }
  }

  return USBD_OK; 
c0d01c3e:	b001      	add	sp, #4
c0d01c40:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01c42 <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d01c42:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01c44:	b081      	sub	sp, #4
c0d01c46:	460c      	mov	r4, r1
c0d01c48:	4605      	mov	r5, r0
c0d01c4a:	2600      	movs	r6, #0
c0d01c4c:	27f4      	movs	r7, #244	; 0xf4
  /* Clear configuration  and De-initialize the Class process*/
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if(usbd_is_valid_intf(pdev, intf)) {
c0d01c4e:	4628      	mov	r0, r5
c0d01c50:	4631      	mov	r1, r6
c0d01c52:	f000 f944 	bl	c0d01ede <usbd_is_valid_intf>
c0d01c56:	2800      	cmp	r0, #0
c0d01c58:	d007      	beq.n	c0d01c6a <USBD_ClrClassConfig+0x28>
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, cfgidx);  
c0d01c5a:	59e8      	ldr	r0, [r5, r7]
c0d01c5c:	6840      	ldr	r0, [r0, #4]
c0d01c5e:	f7ff fd73 	bl	c0d01748 <pic>
c0d01c62:	4602      	mov	r2, r0
c0d01c64:	4628      	mov	r0, r5
c0d01c66:	4621      	mov	r1, r4
c0d01c68:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01c6a:	3708      	adds	r7, #8
c0d01c6c:	1c76      	adds	r6, r6, #1
c0d01c6e:	2e03      	cmp	r6, #3
c0d01c70:	d1ed      	bne.n	c0d01c4e <USBD_ClrClassConfig+0xc>
c0d01c72:	2000      	movs	r0, #0
    }
  }
  return USBD_OK;
c0d01c74:	b001      	add	sp, #4
c0d01c76:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01c78 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d01c78:	b570      	push	{r4, r5, r6, lr}
c0d01c7a:	4604      	mov	r4, r0
c0d01c7c:	4606      	mov	r6, r0
c0d01c7e:	36d4      	adds	r6, #212	; 0xd4
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d01c80:	4635      	mov	r5, r6
c0d01c82:	3514      	adds	r5, #20
c0d01c84:	4628      	mov	r0, r5
c0d01c86:	f000 fb61 	bl	c0d0234c <USBD_ParseSetupRequest>
c0d01c8a:	20d4      	movs	r0, #212	; 0xd4
c0d01c8c:	2101      	movs	r1, #1
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d01c8e:	5021      	str	r1, [r4, r0]
c0d01c90:	20ee      	movs	r0, #238	; 0xee
  pdev->ep0_data_len = pdev->request.wLength;
c0d01c92:	5a20      	ldrh	r0, [r4, r0]
c0d01c94:	6070      	str	r0, [r6, #4]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d01c96:	7d31      	ldrb	r1, [r6, #20]
c0d01c98:	201f      	movs	r0, #31
c0d01c9a:	4008      	ands	r0, r1
c0d01c9c:	2802      	cmp	r0, #2
c0d01c9e:	d008      	beq.n	c0d01cb2 <USBD_LL_SetupStage+0x3a>
c0d01ca0:	2801      	cmp	r0, #1
c0d01ca2:	d00b      	beq.n	c0d01cbc <USBD_LL_SetupStage+0x44>
c0d01ca4:	2800      	cmp	r0, #0
c0d01ca6:	d10e      	bne.n	c0d01cc6 <USBD_LL_SetupStage+0x4e>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d01ca8:	4620      	mov	r0, r4
c0d01caa:	4629      	mov	r1, r5
c0d01cac:	f000 f922 	bl	c0d01ef4 <USBD_StdDevReq>
c0d01cb0:	e00e      	b.n	c0d01cd0 <USBD_LL_SetupStage+0x58>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d01cb2:	4620      	mov	r0, r4
c0d01cb4:	4629      	mov	r1, r5
c0d01cb6:	f000 fac6 	bl	c0d02246 <USBD_StdEPReq>
c0d01cba:	e009      	b.n	c0d01cd0 <USBD_LL_SetupStage+0x58>
    USBD_StdItfReq(pdev, &pdev->request);
c0d01cbc:	4620      	mov	r0, r4
c0d01cbe:	4629      	mov	r1, r5
c0d01cc0:	f000 fa9d 	bl	c0d021fe <USBD_StdItfReq>
c0d01cc4:	e004      	b.n	c0d01cd0 <USBD_LL_SetupStage+0x58>
c0d01cc6:	2080      	movs	r0, #128	; 0x80
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d01cc8:	4001      	ands	r1, r0
c0d01cca:	4620      	mov	r0, r4
c0d01ccc:	f7ff febc 	bl	c0d01a48 <USBD_LL_StallEP>
c0d01cd0:	2000      	movs	r0, #0
    break;
  }  
  return USBD_OK;  
c0d01cd2:	bd70      	pop	{r4, r5, r6, pc}

c0d01cd4 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d01cd4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01cd6:	b083      	sub	sp, #12
c0d01cd8:	9202      	str	r2, [sp, #8]
c0d01cda:	4604      	mov	r4, r0
c0d01cdc:	4606      	mov	r6, r0
c0d01cde:	36dc      	adds	r6, #220	; 0xdc
c0d01ce0:	9101      	str	r1, [sp, #4]
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d01ce2:	2900      	cmp	r1, #0
c0d01ce4:	d01a      	beq.n	c0d01d1c <USBD_LL_DataOutStage+0x48>
c0d01ce6:	2700      	movs	r7, #0
c0d01ce8:	25f4      	movs	r5, #244	; 0xf4
  }
  else {

    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d01cea:	4620      	mov	r0, r4
c0d01cec:	4639      	mov	r1, r7
c0d01cee:	f000 f8f6 	bl	c0d01ede <usbd_is_valid_intf>
c0d01cf2:	2800      	cmp	r0, #0
c0d01cf4:	d00d      	beq.n	c0d01d12 <USBD_LL_DataOutStage+0x3e>
c0d01cf6:	5960      	ldr	r0, [r4, r5]
c0d01cf8:	6980      	ldr	r0, [r0, #24]
c0d01cfa:	2800      	cmp	r0, #0
c0d01cfc:	d009      	beq.n	c0d01d12 <USBD_LL_DataOutStage+0x3e>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01cfe:	7831      	ldrb	r1, [r6, #0]
      if( usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->DataOut != NULL)&&
c0d01d00:	2903      	cmp	r1, #3
c0d01d02:	d106      	bne.n	c0d01d12 <USBD_LL_DataOutStage+0x3e>
      {
        ((DataOut_t)PIC(pdev->interfacesClass[intf].pClass->DataOut))(pdev, epnum, pdata); 
c0d01d04:	f7ff fd20 	bl	c0d01748 <pic>
c0d01d08:	4603      	mov	r3, r0
c0d01d0a:	4620      	mov	r0, r4
c0d01d0c:	9901      	ldr	r1, [sp, #4]
c0d01d0e:	9a02      	ldr	r2, [sp, #8]
c0d01d10:	4798      	blx	r3
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01d12:	3508      	adds	r5, #8
c0d01d14:	1c7f      	adds	r7, r7, #1
c0d01d16:	2f03      	cmp	r7, #3
c0d01d18:	d1e7      	bne.n	c0d01cea <USBD_LL_DataOutStage+0x16>
c0d01d1a:	e02e      	b.n	c0d01d7a <USBD_LL_DataOutStage+0xa6>
c0d01d1c:	4620      	mov	r0, r4
c0d01d1e:	3080      	adds	r0, #128	; 0x80
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d01d20:	6d41      	ldr	r1, [r0, #84]	; 0x54
c0d01d22:	2903      	cmp	r1, #3
c0d01d24:	d129      	bne.n	c0d01d7a <USBD_LL_DataOutStage+0xa6>
      if(pep->rem_length > pep->maxpacket)
c0d01d26:	6800      	ldr	r0, [r0, #0]
c0d01d28:	6fe1      	ldr	r1, [r4, #124]	; 0x7c
c0d01d2a:	4281      	cmp	r1, r0
c0d01d2c:	d90a      	bls.n	c0d01d44 <USBD_LL_DataOutStage+0x70>
        pep->rem_length -=  pep->maxpacket;
c0d01d2e:	1a09      	subs	r1, r1, r0
c0d01d30:	67e1      	str	r1, [r4, #124]	; 0x7c
                            MIN(pep->rem_length ,pep->maxpacket));
c0d01d32:	4281      	cmp	r1, r0
c0d01d34:	d300      	bcc.n	c0d01d38 <USBD_LL_DataOutStage+0x64>
c0d01d36:	4601      	mov	r1, r0
        USBD_CtlContinueRx (pdev, 
c0d01d38:	b28a      	uxth	r2, r1
c0d01d3a:	4620      	mov	r0, r4
c0d01d3c:	9902      	ldr	r1, [sp, #8]
c0d01d3e:	f000 fd1f 	bl	c0d02780 <USBD_CtlContinueRx>
c0d01d42:	e01a      	b.n	c0d01d7a <USBD_LL_DataOutStage+0xa6>
c0d01d44:	2500      	movs	r5, #0
c0d01d46:	27f4      	movs	r7, #244	; 0xf4
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d01d48:	4620      	mov	r0, r4
c0d01d4a:	4629      	mov	r1, r5
c0d01d4c:	f000 f8c7 	bl	c0d01ede <usbd_is_valid_intf>
c0d01d50:	2800      	cmp	r0, #0
c0d01d52:	d00b      	beq.n	c0d01d6c <USBD_LL_DataOutStage+0x98>
c0d01d54:	59e0      	ldr	r0, [r4, r7]
c0d01d56:	6900      	ldr	r0, [r0, #16]
c0d01d58:	2800      	cmp	r0, #0
c0d01d5a:	d007      	beq.n	c0d01d6c <USBD_LL_DataOutStage+0x98>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01d5c:	7831      	ldrb	r1, [r6, #0]
          if(usbd_is_valid_intf(pdev, intf) &&  (pdev->interfacesClass[intf].pClass->EP0_RxReady != NULL)&&
c0d01d5e:	2903      	cmp	r1, #3
c0d01d60:	d104      	bne.n	c0d01d6c <USBD_LL_DataOutStage+0x98>
            ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_RxReady))(pdev); 
c0d01d62:	f7ff fcf1 	bl	c0d01748 <pic>
c0d01d66:	4601      	mov	r1, r0
c0d01d68:	4620      	mov	r0, r4
c0d01d6a:	4788      	blx	r1
        for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01d6c:	3708      	adds	r7, #8
c0d01d6e:	1c6d      	adds	r5, r5, #1
c0d01d70:	2d03      	cmp	r5, #3
c0d01d72:	d1e9      	bne.n	c0d01d48 <USBD_LL_DataOutStage+0x74>
        USBD_CtlSendStatus(pdev);
c0d01d74:	4620      	mov	r0, r4
c0d01d76:	f000 fd0a 	bl	c0d0278e <USBD_CtlSendStatus>
c0d01d7a:	2000      	movs	r0, #0
      }
    }
  }  
  return USBD_OK;
c0d01d7c:	b003      	add	sp, #12
c0d01d7e:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01d80 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d01d80:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d82:	b081      	sub	sp, #4
c0d01d84:	4604      	mov	r4, r0
c0d01d86:	4607      	mov	r7, r0
c0d01d88:	37d4      	adds	r7, #212	; 0xd4
c0d01d8a:	9100      	str	r1, [sp, #0]
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d01d8c:	2900      	cmp	r1, #0
c0d01d8e:	d01a      	beq.n	c0d01dc6 <USBD_LL_DataInStage+0x46>
c0d01d90:	463d      	mov	r5, r7
c0d01d92:	2600      	movs	r6, #0
c0d01d94:	27f4      	movs	r7, #244	; 0xf4
    }
  }
  else {
    uint8_t intf;
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d01d96:	4620      	mov	r0, r4
c0d01d98:	4631      	mov	r1, r6
c0d01d9a:	f000 f8a0 	bl	c0d01ede <usbd_is_valid_intf>
c0d01d9e:	2800      	cmp	r0, #0
c0d01da0:	d00c      	beq.n	c0d01dbc <USBD_LL_DataInStage+0x3c>
c0d01da2:	59e0      	ldr	r0, [r4, r7]
c0d01da4:	6940      	ldr	r0, [r0, #20]
c0d01da6:	2800      	cmp	r0, #0
c0d01da8:	d008      	beq.n	c0d01dbc <USBD_LL_DataInStage+0x3c>
         (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01daa:	7a29      	ldrb	r1, [r5, #8]
      if( usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->DataIn != NULL)&&
c0d01dac:	2903      	cmp	r1, #3
c0d01dae:	d105      	bne.n	c0d01dbc <USBD_LL_DataInStage+0x3c>
      {
        ((DataIn_t)PIC(pdev->interfacesClass[intf].pClass->DataIn))(pdev, epnum); 
c0d01db0:	f7ff fcca 	bl	c0d01748 <pic>
c0d01db4:	4602      	mov	r2, r0
c0d01db6:	4620      	mov	r0, r4
c0d01db8:	9900      	ldr	r1, [sp, #0]
c0d01dba:	4790      	blx	r2
    for (intf = 0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01dbc:	3708      	adds	r7, #8
c0d01dbe:	1c76      	adds	r6, r6, #1
c0d01dc0:	2e03      	cmp	r6, #3
c0d01dc2:	d1e8      	bne.n	c0d01d96 <USBD_LL_DataInStage+0x16>
c0d01dc4:	e045      	b.n	c0d01e52 <USBD_LL_DataInStage+0xd2>
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d01dc6:	6838      	ldr	r0, [r7, #0]
c0d01dc8:	2802      	cmp	r0, #2
c0d01dca:	d13c      	bne.n	c0d01e46 <USBD_LL_DataInStage+0xc6>
      if(pep->rem_length > pep->maxpacket)
c0d01dcc:	69e0      	ldr	r0, [r4, #28]
c0d01dce:	6a25      	ldr	r5, [r4, #32]
c0d01dd0:	42a8      	cmp	r0, r5
c0d01dd2:	d909      	bls.n	c0d01de8 <USBD_LL_DataInStage+0x68>
        pep->rem_length -=  pep->maxpacket;
c0d01dd4:	1b40      	subs	r0, r0, r5
c0d01dd6:	61e0      	str	r0, [r4, #28]
        pdev->pData = (uint8_t *)pdev->pData + pep->maxpacket;
c0d01dd8:	6bf9      	ldr	r1, [r7, #60]	; 0x3c
c0d01dda:	1949      	adds	r1, r1, r5
c0d01ddc:	63f9      	str	r1, [r7, #60]	; 0x3c
        USBD_CtlContinueSendData (pdev, 
c0d01dde:	b282      	uxth	r2, r0
c0d01de0:	4620      	mov	r0, r4
c0d01de2:	f000 fcbf 	bl	c0d02764 <USBD_CtlContinueSendData>
c0d01de6:	e02e      	b.n	c0d01e46 <USBD_LL_DataInStage+0xc6>
        if((pep->total_length % pep->maxpacket == 0) &&
c0d01de8:	69a6      	ldr	r6, [r4, #24]
c0d01dea:	4630      	mov	r0, r6
c0d01dec:	4629      	mov	r1, r5
c0d01dee:	f001 f8f7 	bl	c0d02fe0 <__aeabi_uidivmod>
c0d01df2:	42ae      	cmp	r6, r5
c0d01df4:	d30c      	bcc.n	c0d01e10 <USBD_LL_DataInStage+0x90>
c0d01df6:	2900      	cmp	r1, #0
c0d01df8:	d10a      	bne.n	c0d01e10 <USBD_LL_DataInStage+0x90>
             (pep->total_length < pdev->ep0_data_len ))
c0d01dfa:	6878      	ldr	r0, [r7, #4]
        if((pep->total_length % pep->maxpacket == 0) &&
c0d01dfc:	4286      	cmp	r6, r0
c0d01dfe:	d207      	bcs.n	c0d01e10 <USBD_LL_DataInStage+0x90>
c0d01e00:	2500      	movs	r5, #0
          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d01e02:	4620      	mov	r0, r4
c0d01e04:	4629      	mov	r1, r5
c0d01e06:	462a      	mov	r2, r5
c0d01e08:	f000 fcac 	bl	c0d02764 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d01e0c:	607d      	str	r5, [r7, #4]
c0d01e0e:	e01a      	b.n	c0d01e46 <USBD_LL_DataInStage+0xc6>
c0d01e10:	2500      	movs	r5, #0
c0d01e12:	26f4      	movs	r6, #244	; 0xf4
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d01e14:	4620      	mov	r0, r4
c0d01e16:	4629      	mov	r1, r5
c0d01e18:	f000 f861 	bl	c0d01ede <usbd_is_valid_intf>
c0d01e1c:	2800      	cmp	r0, #0
c0d01e1e:	d00b      	beq.n	c0d01e38 <USBD_LL_DataInStage+0xb8>
c0d01e20:	59a0      	ldr	r0, [r4, r6]
c0d01e22:	68c0      	ldr	r0, [r0, #12]
c0d01e24:	2800      	cmp	r0, #0
c0d01e26:	d007      	beq.n	c0d01e38 <USBD_LL_DataInStage+0xb8>
               (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01e28:	7a39      	ldrb	r1, [r7, #8]
            if(usbd_is_valid_intf(pdev, intf) && (pdev->interfacesClass[intf].pClass->EP0_TxSent != NULL)&&
c0d01e2a:	2903      	cmp	r1, #3
c0d01e2c:	d104      	bne.n	c0d01e38 <USBD_LL_DataInStage+0xb8>
              ((EP0_RxReady_t)PIC(pdev->interfacesClass[intf].pClass->EP0_TxSent))(pdev); 
c0d01e2e:	f7ff fc8b 	bl	c0d01748 <pic>
c0d01e32:	4601      	mov	r1, r0
c0d01e34:	4620      	mov	r0, r4
c0d01e36:	4788      	blx	r1
          for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01e38:	3608      	adds	r6, #8
c0d01e3a:	1c6d      	adds	r5, r5, #1
c0d01e3c:	2d03      	cmp	r5, #3
c0d01e3e:	d1e9      	bne.n	c0d01e14 <USBD_LL_DataInStage+0x94>
          USBD_CtlReceiveStatus(pdev);
c0d01e40:	4620      	mov	r0, r4
c0d01e42:	f000 fcb0 	bl	c0d027a6 <USBD_CtlReceiveStatus>
    if (pdev->dev_test_mode == 1)
c0d01e46:	7b38      	ldrb	r0, [r7, #12]
c0d01e48:	2801      	cmp	r0, #1
c0d01e4a:	d102      	bne.n	c0d01e52 <USBD_LL_DataInStage+0xd2>
c0d01e4c:	4639      	mov	r1, r7
c0d01e4e:	2000      	movs	r0, #0
      pdev->dev_test_mode = 0;
c0d01e50:	7338      	strb	r0, [r7, #12]
c0d01e52:	2000      	movs	r0, #0
      }
    }
  }
  return USBD_OK;
c0d01e54:	b001      	add	sp, #4
c0d01e56:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01e58 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d01e58:	b570      	push	{r4, r5, r6, lr}
c0d01e5a:	4604      	mov	r4, r0
c0d01e5c:	20dc      	movs	r0, #220	; 0xdc
c0d01e5e:	2101      	movs	r1, #1
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d01e60:	5421      	strb	r1, [r4, r0]
c0d01e62:	2080      	movs	r0, #128	; 0x80
c0d01e64:	2140      	movs	r1, #64	; 0x40
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d01e66:	5021      	str	r1, [r4, r0]
  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d01e68:	6221      	str	r1, [r4, #32]
c0d01e6a:	2500      	movs	r5, #0
c0d01e6c:	26f4      	movs	r6, #244	; 0xf4
 
  uint8_t intf;
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
    if( usbd_is_valid_intf(pdev, intf))
c0d01e6e:	4620      	mov	r0, r4
c0d01e70:	4629      	mov	r1, r5
c0d01e72:	f000 f834 	bl	c0d01ede <usbd_is_valid_intf>
c0d01e76:	2800      	cmp	r0, #0
c0d01e78:	d007      	beq.n	c0d01e8a <USBD_LL_Reset+0x32>
    {
      ((DeInit_t)PIC(pdev->interfacesClass[intf].pClass->DeInit))(pdev, pdev->dev_config); 
c0d01e7a:	59a0      	ldr	r0, [r4, r6]
c0d01e7c:	6840      	ldr	r0, [r0, #4]
c0d01e7e:	f7ff fc63 	bl	c0d01748 <pic>
c0d01e82:	4602      	mov	r2, r0
c0d01e84:	7921      	ldrb	r1, [r4, #4]
c0d01e86:	4620      	mov	r0, r4
c0d01e88:	4790      	blx	r2
  for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01e8a:	3608      	adds	r6, #8
c0d01e8c:	1c6d      	adds	r5, r5, #1
c0d01e8e:	2d03      	cmp	r5, #3
c0d01e90:	d1ed      	bne.n	c0d01e6e <USBD_LL_Reset+0x16>
c0d01e92:	2000      	movs	r0, #0
    }
  }
  
  return USBD_OK;
c0d01e94:	bd70      	pop	{r4, r5, r6, pc}

c0d01e96 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d01e96:	7401      	strb	r1, [r0, #16]
c0d01e98:	2000      	movs	r0, #0
  return USBD_OK;
c0d01e9a:	4770      	bx	lr

c0d01e9c <USBD_LL_Suspend>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Suspend(USBD_HandleTypeDef  *pdev)
{
c0d01e9c:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d01e9e:	4770      	bx	lr

c0d01ea0 <USBD_LL_Resume>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
c0d01ea0:	2000      	movs	r0, #0
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d01ea2:	4770      	bx	lr

c0d01ea4 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d01ea4:	b570      	push	{r4, r5, r6, lr}
c0d01ea6:	4604      	mov	r4, r0
c0d01ea8:	20dc      	movs	r0, #220	; 0xdc
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d01eaa:	5c20      	ldrb	r0, [r4, r0]
c0d01eac:	2803      	cmp	r0, #3
c0d01eae:	d114      	bne.n	c0d01eda <USBD_LL_SOF+0x36>
c0d01eb0:	2500      	movs	r5, #0
c0d01eb2:	26f4      	movs	r6, #244	; 0xf4
  {
    uint8_t intf;
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
      if( usbd_is_valid_intf(pdev, intf) && pdev->interfacesClass[intf].pClass->SOF != NULL)
c0d01eb4:	4620      	mov	r0, r4
c0d01eb6:	4629      	mov	r1, r5
c0d01eb8:	f000 f811 	bl	c0d01ede <usbd_is_valid_intf>
c0d01ebc:	2800      	cmp	r0, #0
c0d01ebe:	d008      	beq.n	c0d01ed2 <USBD_LL_SOF+0x2e>
c0d01ec0:	59a0      	ldr	r0, [r4, r6]
c0d01ec2:	69c0      	ldr	r0, [r0, #28]
c0d01ec4:	2800      	cmp	r0, #0
c0d01ec6:	d004      	beq.n	c0d01ed2 <USBD_LL_SOF+0x2e>
      {
        ((SOF_t)PIC(pdev->interfacesClass[intf].pClass->SOF))(pdev); 
c0d01ec8:	f7ff fc3e 	bl	c0d01748 <pic>
c0d01ecc:	4601      	mov	r1, r0
c0d01ece:	4620      	mov	r0, r4
c0d01ed0:	4788      	blx	r1
    for (intf =0; intf < USBD_MAX_NUM_INTERFACES; intf++) {
c0d01ed2:	3608      	adds	r6, #8
c0d01ed4:	1c6d      	adds	r5, r5, #1
c0d01ed6:	2d03      	cmp	r5, #3
c0d01ed8:	d1ec      	bne.n	c0d01eb4 <USBD_LL_SOF+0x10>
c0d01eda:	2000      	movs	r0, #0
      }
    }
  }
  return USBD_OK;
c0d01edc:	bd70      	pop	{r4, r5, r6, pc}

c0d01ede <usbd_is_valid_intf>:
/** @defgroup USBD_REQ_Private_Functions
  * @{
  */ 

unsigned int usbd_is_valid_intf(USBD_HandleTypeDef *pdev , unsigned int intf) {
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d01ede:	2902      	cmp	r1, #2
c0d01ee0:	d806      	bhi.n	c0d01ef0 <usbd_is_valid_intf+0x12>
c0d01ee2:	00c9      	lsls	r1, r1, #3
c0d01ee4:	1840      	adds	r0, r0, r1
c0d01ee6:	21f4      	movs	r1, #244	; 0xf4
c0d01ee8:	5840      	ldr	r0, [r0, r1]
c0d01eea:	1e41      	subs	r1, r0, #1
c0d01eec:	4188      	sbcs	r0, r1
c0d01eee:	4770      	bx	lr
c0d01ef0:	2000      	movs	r0, #0
c0d01ef2:	4770      	bx	lr

c0d01ef4 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d01ef4:	b580      	push	{r7, lr}
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d01ef6:	784a      	ldrb	r2, [r1, #1]
c0d01ef8:	2a04      	cmp	r2, #4
c0d01efa:	dd08      	ble.n	c0d01f0e <USBD_StdDevReq+0x1a>
c0d01efc:	2a07      	cmp	r2, #7
c0d01efe:	dc0f      	bgt.n	c0d01f20 <USBD_StdDevReq+0x2c>
c0d01f00:	2a05      	cmp	r2, #5
c0d01f02:	d014      	beq.n	c0d01f2e <USBD_StdDevReq+0x3a>
c0d01f04:	2a06      	cmp	r2, #6
c0d01f06:	d11b      	bne.n	c0d01f40 <USBD_StdDevReq+0x4c>
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d01f08:	f000 f821 	bl	c0d01f4e <USBD_GetDescriptor>
c0d01f0c:	e01d      	b.n	c0d01f4a <USBD_StdDevReq+0x56>
  switch (req->bRequest) 
c0d01f0e:	2a00      	cmp	r2, #0
c0d01f10:	d010      	beq.n	c0d01f34 <USBD_StdDevReq+0x40>
c0d01f12:	2a01      	cmp	r2, #1
c0d01f14:	d017      	beq.n	c0d01f46 <USBD_StdDevReq+0x52>
c0d01f16:	2a03      	cmp	r2, #3
c0d01f18:	d112      	bne.n	c0d01f40 <USBD_StdDevReq+0x4c>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d01f1a:	f000 f92a 	bl	c0d02172 <USBD_SetFeature>
c0d01f1e:	e014      	b.n	c0d01f4a <USBD_StdDevReq+0x56>
  switch (req->bRequest) 
c0d01f20:	2a08      	cmp	r2, #8
c0d01f22:	d00a      	beq.n	c0d01f3a <USBD_StdDevReq+0x46>
c0d01f24:	2a09      	cmp	r2, #9
c0d01f26:	d10b      	bne.n	c0d01f40 <USBD_StdDevReq+0x4c>
    USBD_SetConfig (pdev , req);
c0d01f28:	f000 f8b1 	bl	c0d0208e <USBD_SetConfig>
c0d01f2c:	e00d      	b.n	c0d01f4a <USBD_StdDevReq+0x56>
    USBD_SetAddress(pdev, req);
c0d01f2e:	f000 f88b 	bl	c0d02048 <USBD_SetAddress>
c0d01f32:	e00a      	b.n	c0d01f4a <USBD_StdDevReq+0x56>
    USBD_GetStatus (pdev , req);
c0d01f34:	f000 f8f9 	bl	c0d0212a <USBD_GetStatus>
c0d01f38:	e007      	b.n	c0d01f4a <USBD_StdDevReq+0x56>
    USBD_GetConfig (pdev , req);
c0d01f3a:	f000 f8df 	bl	c0d020fc <USBD_GetConfig>
c0d01f3e:	e004      	b.n	c0d01f4a <USBD_StdDevReq+0x56>
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
    break;
    
  default:  
    USBD_CtlError(pdev , req);
c0d01f40:	f000 fb6e 	bl	c0d02620 <USBD_CtlError>
c0d01f44:	e001      	b.n	c0d01f4a <USBD_StdDevReq+0x56>
    USBD_ClrFeature (pdev , req);
c0d01f46:	f000 f931 	bl	c0d021ac <USBD_ClrFeature>
c0d01f4a:	2000      	movs	r0, #0
    break;
  }
  
  return ret;
c0d01f4c:	bd80      	pop	{r7, pc}

c0d01f4e <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d01f4e:	b5b0      	push	{r4, r5, r7, lr}
c0d01f50:	b082      	sub	sp, #8
c0d01f52:	460d      	mov	r5, r1
c0d01f54:	4604      	mov	r4, r0
c0d01f56:	a801      	add	r0, sp, #4
c0d01f58:	2100      	movs	r1, #0
  uint16_t len = 0;
c0d01f5a:	8001      	strh	r1, [r0, #0]
c0d01f5c:	4620      	mov	r0, r4
c0d01f5e:	30f0      	adds	r0, #240	; 0xf0
  uint8_t *pbuf = NULL;
  
    
  switch (req->wValue >> 8)
c0d01f60:	886b      	ldrh	r3, [r5, #2]
c0d01f62:	0a1a      	lsrs	r2, r3, #8
c0d01f64:	2a05      	cmp	r2, #5
c0d01f66:	dc11      	bgt.n	c0d01f8c <USBD_GetDescriptor+0x3e>
c0d01f68:	2a01      	cmp	r2, #1
c0d01f6a:	d01a      	beq.n	c0d01fa2 <USBD_GetDescriptor+0x54>
c0d01f6c:	2a02      	cmp	r2, #2
c0d01f6e:	d021      	beq.n	c0d01fb4 <USBD_GetDescriptor+0x66>
c0d01f70:	2a03      	cmp	r2, #3
c0d01f72:	d132      	bne.n	c0d01fda <USBD_GetDescriptor+0x8c>
      }
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d01f74:	b2d9      	uxtb	r1, r3
c0d01f76:	2902      	cmp	r1, #2
c0d01f78:	dc34      	bgt.n	c0d01fe4 <USBD_GetDescriptor+0x96>
c0d01f7a:	2900      	cmp	r1, #0
c0d01f7c:	d058      	beq.n	c0d02030 <USBD_GetDescriptor+0xe2>
c0d01f7e:	2901      	cmp	r1, #1
c0d01f80:	d05c      	beq.n	c0d0203c <USBD_GetDescriptor+0xee>
c0d01f82:	2902      	cmp	r1, #2
c0d01f84:	d129      	bne.n	c0d01fda <USBD_GetDescriptor+0x8c>
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d01f86:	6800      	ldr	r0, [r0, #0]
c0d01f88:	68c0      	ldr	r0, [r0, #12]
c0d01f8a:	e00c      	b.n	c0d01fa6 <USBD_GetDescriptor+0x58>
  switch (req->wValue >> 8)
c0d01f8c:	2a06      	cmp	r2, #6
c0d01f8e:	d019      	beq.n	c0d01fc4 <USBD_GetDescriptor+0x76>
c0d01f90:	2a07      	cmp	r2, #7
c0d01f92:	d01f      	beq.n	c0d01fd4 <USBD_GetDescriptor+0x86>
c0d01f94:	2a0f      	cmp	r2, #15
c0d01f96:	d120      	bne.n	c0d01fda <USBD_GetDescriptor+0x8c>
    if(pdev->pDesc->GetBOSDescriptor != NULL) {
c0d01f98:	6800      	ldr	r0, [r0, #0]
c0d01f9a:	69c0      	ldr	r0, [r0, #28]
c0d01f9c:	2800      	cmp	r0, #0
c0d01f9e:	d102      	bne.n	c0d01fa6 <USBD_GetDescriptor+0x58>
c0d01fa0:	e01b      	b.n	c0d01fda <USBD_GetDescriptor+0x8c>
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d01fa2:	6800      	ldr	r0, [r0, #0]
c0d01fa4:	6800      	ldr	r0, [r0, #0]
c0d01fa6:	f7ff fbcf 	bl	c0d01748 <pic>
c0d01faa:	4602      	mov	r2, r0
c0d01fac:	7c20      	ldrb	r0, [r4, #16]
c0d01fae:	a901      	add	r1, sp, #4
c0d01fb0:	4790      	blx	r2
c0d01fb2:	e02b      	b.n	c0d0200c <USBD_GetDescriptor+0xbe>
    if(pdev->interfacesClass[0].pClass != NULL) {
c0d01fb4:	6840      	ldr	r0, [r0, #4]
c0d01fb6:	2800      	cmp	r0, #0
c0d01fb8:	d029      	beq.n	c0d0200e <USBD_GetDescriptor+0xc0>
      if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d01fba:	7c21      	ldrb	r1, [r4, #16]
c0d01fbc:	2900      	cmp	r1, #0
c0d01fbe:	d01f      	beq.n	c0d02000 <USBD_GetDescriptor+0xb2>
        pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetFSConfigDescriptor))(&len);
c0d01fc0:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d01fc2:	e01e      	b.n	c0d02002 <USBD_GetDescriptor+0xb4>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL )   
c0d01fc4:	7c21      	ldrb	r1, [r4, #16]
c0d01fc6:	2900      	cmp	r1, #0
c0d01fc8:	d107      	bne.n	c0d01fda <USBD_GetDescriptor+0x8c>
c0d01fca:	6840      	ldr	r0, [r0, #4]
c0d01fcc:	2800      	cmp	r0, #0
c0d01fce:	d004      	beq.n	c0d01fda <USBD_GetDescriptor+0x8c>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetDeviceQualifierDescriptor))(&len);
c0d01fd0:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d01fd2:	e016      	b.n	c0d02002 <USBD_GetDescriptor+0xb4>
    {
      goto default_error;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d01fd4:	7c21      	ldrb	r1, [r4, #16]
c0d01fd6:	2900      	cmp	r1, #0
c0d01fd8:	d00d      	beq.n	c0d01ff6 <USBD_GetDescriptor+0xa8>
      goto default_error;
    }

  default: 
  default_error:
     USBD_CtlError(pdev , req);
c0d01fda:	4620      	mov	r0, r4
c0d01fdc:	4629      	mov	r1, r5
c0d01fde:	f000 fb1f 	bl	c0d02620 <USBD_CtlError>
c0d01fe2:	e023      	b.n	c0d0202c <USBD_GetDescriptor+0xde>
    switch ((uint8_t)(req->wValue))
c0d01fe4:	2903      	cmp	r1, #3
c0d01fe6:	d026      	beq.n	c0d02036 <USBD_GetDescriptor+0xe8>
c0d01fe8:	2904      	cmp	r1, #4
c0d01fea:	d02a      	beq.n	c0d02042 <USBD_GetDescriptor+0xf4>
c0d01fec:	2905      	cmp	r1, #5
c0d01fee:	d1f4      	bne.n	c0d01fda <USBD_GetDescriptor+0x8c>
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d01ff0:	6800      	ldr	r0, [r0, #0]
c0d01ff2:	6980      	ldr	r0, [r0, #24]
c0d01ff4:	e7d7      	b.n	c0d01fa6 <USBD_GetDescriptor+0x58>
    if(pdev->dev_speed == USBD_SPEED_HIGH && pdev->interfacesClass[0].pClass != NULL)   
c0d01ff6:	6840      	ldr	r0, [r0, #4]
c0d01ff8:	2800      	cmp	r0, #0
c0d01ffa:	d0ee      	beq.n	c0d01fda <USBD_GetDescriptor+0x8c>
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d01ffc:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d01ffe:	e000      	b.n	c0d02002 <USBD_GetDescriptor+0xb4>
        pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->interfacesClass[0].pClass->GetHSConfigDescriptor))(&len);
c0d02000:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d02002:	f7ff fba1 	bl	c0d01748 <pic>
c0d02006:	4601      	mov	r1, r0
c0d02008:	a801      	add	r0, sp, #4
c0d0200a:	4788      	blx	r1
c0d0200c:	4601      	mov	r1, r0
c0d0200e:	a801      	add	r0, sp, #4
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d02010:	8802      	ldrh	r2, [r0, #0]
c0d02012:	2a00      	cmp	r2, #0
c0d02014:	d00a      	beq.n	c0d0202c <USBD_GetDescriptor+0xde>
c0d02016:	88e8      	ldrh	r0, [r5, #6]
c0d02018:	2800      	cmp	r0, #0
c0d0201a:	d007      	beq.n	c0d0202c <USBD_GetDescriptor+0xde>
  {
    
    len = MIN(len , req->wLength);
c0d0201c:	4282      	cmp	r2, r0
c0d0201e:	d300      	bcc.n	c0d02022 <USBD_GetDescriptor+0xd4>
c0d02020:	4602      	mov	r2, r0
c0d02022:	a801      	add	r0, sp, #4
c0d02024:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d02026:	4620      	mov	r0, r4
c0d02028:	f000 fb86 	bl	c0d02738 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d0202c:	b002      	add	sp, #8
c0d0202e:	bdb0      	pop	{r4, r5, r7, pc}
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d02030:	6800      	ldr	r0, [r0, #0]
c0d02032:	6840      	ldr	r0, [r0, #4]
c0d02034:	e7b7      	b.n	c0d01fa6 <USBD_GetDescriptor+0x58>
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d02036:	6800      	ldr	r0, [r0, #0]
c0d02038:	6900      	ldr	r0, [r0, #16]
c0d0203a:	e7b4      	b.n	c0d01fa6 <USBD_GetDescriptor+0x58>
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d0203c:	6800      	ldr	r0, [r0, #0]
c0d0203e:	6880      	ldr	r0, [r0, #8]
c0d02040:	e7b1      	b.n	c0d01fa6 <USBD_GetDescriptor+0x58>
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d02042:	6800      	ldr	r0, [r0, #0]
c0d02044:	6940      	ldr	r0, [r0, #20]
c0d02046:	e7ae      	b.n	c0d01fa6 <USBD_GetDescriptor+0x58>

c0d02048 <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02048:	b570      	push	{r4, r5, r6, lr}
c0d0204a:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d0204c:	8888      	ldrh	r0, [r1, #4]
c0d0204e:	2800      	cmp	r0, #0
c0d02050:	d107      	bne.n	c0d02062 <USBD_SetAddress+0x1a>
c0d02052:	88c8      	ldrh	r0, [r1, #6]
c0d02054:	2800      	cmp	r0, #0
c0d02056:	d104      	bne.n	c0d02062 <USBD_SetAddress+0x1a>
c0d02058:	4626      	mov	r6, r4
c0d0205a:	36dc      	adds	r6, #220	; 0xdc
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d0205c:	7830      	ldrb	r0, [r6, #0]
c0d0205e:	2803      	cmp	r0, #3
c0d02060:	d103      	bne.n	c0d0206a <USBD_SetAddress+0x22>
c0d02062:	4620      	mov	r0, r4
c0d02064:	f000 fadc 	bl	c0d02620 <USBD_CtlError>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d02068:	bd70      	pop	{r4, r5, r6, pc}
c0d0206a:	7888      	ldrb	r0, [r1, #2]
c0d0206c:	257f      	movs	r5, #127	; 0x7f
c0d0206e:	4005      	ands	r5, r0
      pdev->dev_address = dev_addr;
c0d02070:	70b5      	strb	r5, [r6, #2]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d02072:	4620      	mov	r0, r4
c0d02074:	4629      	mov	r1, r5
c0d02076:	f7ff fd3f 	bl	c0d01af8 <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d0207a:	4620      	mov	r0, r4
c0d0207c:	f000 fb87 	bl	c0d0278e <USBD_CtlSendStatus>
      if (dev_addr != 0) 
c0d02080:	2d00      	cmp	r5, #0
c0d02082:	d001      	beq.n	c0d02088 <USBD_SetAddress+0x40>
c0d02084:	2002      	movs	r0, #2
c0d02086:	e000      	b.n	c0d0208a <USBD_SetAddress+0x42>
c0d02088:	2001      	movs	r0, #1
c0d0208a:	7030      	strb	r0, [r6, #0]
}
c0d0208c:	bd70      	pop	{r4, r5, r6, pc}

c0d0208e <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0208e:	b570      	push	{r4, r5, r6, lr}
c0d02090:	460d      	mov	r5, r1
c0d02092:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d02094:	788e      	ldrb	r6, [r1, #2]
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d02096:	2e02      	cmp	r6, #2
c0d02098:	d21c      	bcs.n	c0d020d4 <USBD_SetConfig+0x46>
c0d0209a:	20dc      	movs	r0, #220	; 0xdc
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d0209c:	5c21      	ldrb	r1, [r4, r0]
c0d0209e:	4620      	mov	r0, r4
c0d020a0:	30dc      	adds	r0, #220	; 0xdc
c0d020a2:	2903      	cmp	r1, #3
c0d020a4:	d006      	beq.n	c0d020b4 <USBD_SetConfig+0x26>
c0d020a6:	2902      	cmp	r1, #2
c0d020a8:	d114      	bne.n	c0d020d4 <USBD_SetConfig+0x46>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d020aa:	2e00      	cmp	r6, #0
c0d020ac:	d022      	beq.n	c0d020f4 <USBD_SetConfig+0x66>
c0d020ae:	2103      	movs	r1, #3
      {                                                                               
        pdev->dev_config = cfgidx;
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d020b0:	7001      	strb	r1, [r0, #0]
c0d020b2:	e008      	b.n	c0d020c6 <USBD_SetConfig+0x38>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d020b4:	2e00      	cmp	r6, #0
c0d020b6:	d012      	beq.n	c0d020de <USBD_SetConfig+0x50>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d020b8:	6860      	ldr	r0, [r4, #4]
c0d020ba:	42b0      	cmp	r0, r6
c0d020bc:	d01a      	beq.n	c0d020f4 <USBD_SetConfig+0x66>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d020be:	b2c1      	uxtb	r1, r0
c0d020c0:	4620      	mov	r0, r4
c0d020c2:	f7ff fdbe 	bl	c0d01c42 <USBD_ClrClassConfig>
c0d020c6:	6066      	str	r6, [r4, #4]
c0d020c8:	4620      	mov	r0, r4
c0d020ca:	4631      	mov	r1, r6
c0d020cc:	f7ff fd9e 	bl	c0d01c0c <USBD_SetClassConfig>
c0d020d0:	2802      	cmp	r0, #2
c0d020d2:	d10f      	bne.n	c0d020f4 <USBD_SetConfig+0x66>
c0d020d4:	4620      	mov	r0, r4
c0d020d6:	4629      	mov	r1, r5
c0d020d8:	f000 faa2 	bl	c0d02620 <USBD_CtlError>
    default:          
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d020dc:	bd70      	pop	{r4, r5, r6, pc}
c0d020de:	2100      	movs	r1, #0
        pdev->dev_config = cfgidx;          
c0d020e0:	6061      	str	r1, [r4, #4]
c0d020e2:	2102      	movs	r1, #2
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d020e4:	7001      	strb	r1, [r0, #0]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d020e6:	4620      	mov	r0, r4
c0d020e8:	4631      	mov	r1, r6
c0d020ea:	f7ff fdaa 	bl	c0d01c42 <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d020ee:	4620      	mov	r0, r4
c0d020f0:	f000 fb4d 	bl	c0d0278e <USBD_CtlSendStatus>
c0d020f4:	4620      	mov	r0, r4
c0d020f6:	f000 fb4a 	bl	c0d0278e <USBD_CtlSendStatus>
}
c0d020fa:	bd70      	pop	{r4, r5, r6, pc}

c0d020fc <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d020fc:	b580      	push	{r7, lr}

  if (req->wLength != 1) 
c0d020fe:	88ca      	ldrh	r2, [r1, #6]
c0d02100:	2a01      	cmp	r2, #1
c0d02102:	d10a      	bne.n	c0d0211a <USBD_GetConfig+0x1e>
c0d02104:	22dc      	movs	r2, #220	; 0xdc
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d02106:	5c82      	ldrb	r2, [r0, r2]
c0d02108:	2a03      	cmp	r2, #3
c0d0210a:	d009      	beq.n	c0d02120 <USBD_GetConfig+0x24>
c0d0210c:	2a02      	cmp	r2, #2
c0d0210e:	d104      	bne.n	c0d0211a <USBD_GetConfig+0x1e>
c0d02110:	2100      	movs	r1, #0
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d02112:	6081      	str	r1, [r0, #8]
c0d02114:	4601      	mov	r1, r0
c0d02116:	3108      	adds	r1, #8
c0d02118:	e003      	b.n	c0d02122 <USBD_GetConfig+0x26>
c0d0211a:	f000 fa81 	bl	c0d02620 <USBD_CtlError>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d0211e:	bd80      	pop	{r7, pc}
                        (uint8_t *)&pdev->dev_config,
c0d02120:	1d01      	adds	r1, r0, #4
c0d02122:	2201      	movs	r2, #1
c0d02124:	f000 fb08 	bl	c0d02738 <USBD_CtlSendData>
}
c0d02128:	bd80      	pop	{r7, pc}

c0d0212a <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d0212a:	b5b0      	push	{r4, r5, r7, lr}
c0d0212c:	4604      	mov	r4, r0
c0d0212e:	20dc      	movs	r0, #220	; 0xdc
  
    
  switch (pdev->dev_state) 
c0d02130:	5c20      	ldrb	r0, [r4, r0]
c0d02132:	22fe      	movs	r2, #254	; 0xfe
c0d02134:	4002      	ands	r2, r0
c0d02136:	2a02      	cmp	r2, #2
c0d02138:	d10f      	bne.n	c0d0215a <USBD_GetStatus+0x30>
c0d0213a:	4620      	mov	r0, r4
c0d0213c:	30dc      	adds	r0, #220	; 0xdc
c0d0213e:	2101      	movs	r1, #1
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d02140:	60e1      	str	r1, [r4, #12]
c0d02142:	4625      	mov	r5, r4
c0d02144:	350c      	adds	r5, #12
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02146:	6880      	ldr	r0, [r0, #8]
c0d02148:	2800      	cmp	r0, #0
c0d0214a:	d00a      	beq.n	c0d02162 <USBD_GetStatus+0x38>
c0d0214c:	4620      	mov	r0, r4
c0d0214e:	f000 fb2a 	bl	c0d027a6 <USBD_CtlReceiveStatus>
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02152:	68e1      	ldr	r1, [r4, #12]
c0d02154:	2002      	movs	r0, #2
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d02156:	4308      	orrs	r0, r1
c0d02158:	e004      	b.n	c0d02164 <USBD_GetStatus+0x3a>
                      (uint8_t *)& pdev->dev_config_status,
                      2);
    break;
    
  default :
    USBD_CtlError(pdev , req);                        
c0d0215a:	4620      	mov	r0, r4
c0d0215c:	f000 fa60 	bl	c0d02620 <USBD_CtlError>
    break;
  }
}
c0d02160:	bdb0      	pop	{r4, r5, r7, pc}
c0d02162:	2003      	movs	r0, #3
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d02164:	60e0      	str	r0, [r4, #12]
c0d02166:	2202      	movs	r2, #2
    USBD_CtlSendData (pdev, 
c0d02168:	4620      	mov	r0, r4
c0d0216a:	4629      	mov	r1, r5
c0d0216c:	f000 fae4 	bl	c0d02738 <USBD_CtlSendData>
}
c0d02170:	bdb0      	pop	{r4, r5, r7, pc}

c0d02172 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02172:	b5b0      	push	{r4, r5, r7, lr}
c0d02174:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d02176:	8848      	ldrh	r0, [r1, #2]
c0d02178:	2801      	cmp	r0, #1
c0d0217a:	d116      	bne.n	c0d021aa <USBD_SetFeature+0x38>
c0d0217c:	460d      	mov	r5, r1
c0d0217e:	20e4      	movs	r0, #228	; 0xe4
c0d02180:	2101      	movs	r1, #1
  {
    pdev->dev_remote_wakeup = 1;  
c0d02182:	5021      	str	r1, [r4, r0]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02184:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02186:	2802      	cmp	r0, #2
c0d02188:	d80c      	bhi.n	c0d021a4 <USBD_SetFeature+0x32>
c0d0218a:	00c0      	lsls	r0, r0, #3
c0d0218c:	1820      	adds	r0, r4, r0
c0d0218e:	21f4      	movs	r1, #244	; 0xf4
c0d02190:	5840      	ldr	r0, [r0, r1]
    if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02192:	2800      	cmp	r0, #0
c0d02194:	d006      	beq.n	c0d021a4 <USBD_SetFeature+0x32>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d02196:	6880      	ldr	r0, [r0, #8]
c0d02198:	f7ff fad6 	bl	c0d01748 <pic>
c0d0219c:	4602      	mov	r2, r0
c0d0219e:	4620      	mov	r0, r4
c0d021a0:	4629      	mov	r1, r5
c0d021a2:	4790      	blx	r2
    }
    USBD_CtlSendStatus(pdev);
c0d021a4:	4620      	mov	r0, r4
c0d021a6:	f000 faf2 	bl	c0d0278e <USBD_CtlSendStatus>
  }

}
c0d021aa:	bdb0      	pop	{r4, r5, r7, pc}

c0d021ac <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d021ac:	b5b0      	push	{r4, r5, r7, lr}
c0d021ae:	460d      	mov	r5, r1
c0d021b0:	4604      	mov	r4, r0
c0d021b2:	20dc      	movs	r0, #220	; 0xdc
  switch (pdev->dev_state)
c0d021b4:	5c20      	ldrb	r0, [r4, r0]
c0d021b6:	21fe      	movs	r1, #254	; 0xfe
c0d021b8:	4001      	ands	r1, r0
c0d021ba:	2902      	cmp	r1, #2
c0d021bc:	d11a      	bne.n	c0d021f4 <USBD_ClrFeature+0x48>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d021be:	8868      	ldrh	r0, [r5, #2]
c0d021c0:	2801      	cmp	r0, #1
c0d021c2:	d11b      	bne.n	c0d021fc <USBD_ClrFeature+0x50>
c0d021c4:	4620      	mov	r0, r4
c0d021c6:	30dc      	adds	r0, #220	; 0xdc
c0d021c8:	2100      	movs	r1, #0
    {
      pdev->dev_remote_wakeup = 0; 
c0d021ca:	6081      	str	r1, [r0, #8]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d021cc:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d021ce:	2802      	cmp	r0, #2
c0d021d0:	d80c      	bhi.n	c0d021ec <USBD_ClrFeature+0x40>
c0d021d2:	00c0      	lsls	r0, r0, #3
c0d021d4:	1820      	adds	r0, r4, r0
c0d021d6:	21f4      	movs	r1, #244	; 0xf4
c0d021d8:	5840      	ldr	r0, [r0, r1]
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d021da:	2800      	cmp	r0, #0
c0d021dc:	d006      	beq.n	c0d021ec <USBD_ClrFeature+0x40>
        ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);   
c0d021de:	6880      	ldr	r0, [r0, #8]
c0d021e0:	f7ff fab2 	bl	c0d01748 <pic>
c0d021e4:	4602      	mov	r2, r0
c0d021e6:	4620      	mov	r0, r4
c0d021e8:	4629      	mov	r1, r5
c0d021ea:	4790      	blx	r2
      }
      USBD_CtlSendStatus(pdev);
c0d021ec:	4620      	mov	r0, r4
c0d021ee:	f000 face 	bl	c0d0278e <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d021f2:	bdb0      	pop	{r4, r5, r7, pc}
     USBD_CtlError(pdev , req);
c0d021f4:	4620      	mov	r0, r4
c0d021f6:	4629      	mov	r1, r5
c0d021f8:	f000 fa12 	bl	c0d02620 <USBD_CtlError>
}
c0d021fc:	bdb0      	pop	{r4, r5, r7, pc}

c0d021fe <USBD_StdItfReq>:
{
c0d021fe:	b5b0      	push	{r4, r5, r7, lr}
c0d02200:	460d      	mov	r5, r1
c0d02202:	4604      	mov	r4, r0
c0d02204:	20dc      	movs	r0, #220	; 0xdc
  switch (pdev->dev_state) 
c0d02206:	5c20      	ldrb	r0, [r4, r0]
c0d02208:	2803      	cmp	r0, #3
c0d0220a:	d116      	bne.n	c0d0223a <USBD_StdItfReq+0x3c>
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d0220c:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d0220e:	2802      	cmp	r0, #2
c0d02210:	d813      	bhi.n	c0d0223a <USBD_StdItfReq+0x3c>
c0d02212:	00c0      	lsls	r0, r0, #3
c0d02214:	1820      	adds	r0, r4, r0
c0d02216:	21f4      	movs	r1, #244	; 0xf4
c0d02218:	5840      	ldr	r0, [r0, r1]
    if (usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) 
c0d0221a:	2800      	cmp	r0, #0
c0d0221c:	d00d      	beq.n	c0d0223a <USBD_StdItfReq+0x3c>
      ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d0221e:	6880      	ldr	r0, [r0, #8]
c0d02220:	f7ff fa92 	bl	c0d01748 <pic>
c0d02224:	4602      	mov	r2, r0
c0d02226:	4620      	mov	r0, r4
c0d02228:	4629      	mov	r1, r5
c0d0222a:	4790      	blx	r2
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d0222c:	88e8      	ldrh	r0, [r5, #6]
c0d0222e:	2800      	cmp	r0, #0
c0d02230:	d107      	bne.n	c0d02242 <USBD_StdItfReq+0x44>
         USBD_CtlSendStatus(pdev);
c0d02232:	4620      	mov	r0, r4
c0d02234:	f000 faab 	bl	c0d0278e <USBD_CtlSendStatus>
c0d02238:	e003      	b.n	c0d02242 <USBD_StdItfReq+0x44>
c0d0223a:	4620      	mov	r0, r4
c0d0223c:	4629      	mov	r1, r5
c0d0223e:	f000 f9ef 	bl	c0d02620 <USBD_CtlError>
c0d02242:	2000      	movs	r0, #0
  return USBD_OK;
c0d02244:	bdb0      	pop	{r4, r5, r7, pc}

c0d02246 <USBD_StdEPReq>:
{
c0d02246:	b5b0      	push	{r4, r5, r7, lr}
c0d02248:	b082      	sub	sp, #8
c0d0224a:	460d      	mov	r5, r1
c0d0224c:	4604      	mov	r4, r0
  ep_addr  = LOBYTE(req->wIndex);
c0d0224e:	7909      	ldrb	r1, [r1, #4]
c0d02250:	207f      	movs	r0, #127	; 0x7f
  if ((ep_addr & 0x7F) > IO_USB_MAX_ENDPOINTS) {
c0d02252:	4008      	ands	r0, r1
c0d02254:	2807      	cmp	r0, #7
c0d02256:	d304      	bcc.n	c0d02262 <USBD_StdEPReq+0x1c>
c0d02258:	4620      	mov	r0, r4
c0d0225a:	4629      	mov	r1, r5
c0d0225c:	f000 f9e0 	bl	c0d02620 <USBD_CtlError>
c0d02260:	e071      	b.n	c0d02346 <USBD_StdEPReq+0x100>
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02262:	782a      	ldrb	r2, [r5, #0]
c0d02264:	2360      	movs	r3, #96	; 0x60
c0d02266:	4013      	ands	r3, r2
c0d02268:	2b20      	cmp	r3, #32
c0d0226a:	d10f      	bne.n	c0d0228c <USBD_StdEPReq+0x46>
c0d0226c:	2902      	cmp	r1, #2
c0d0226e:	d80d      	bhi.n	c0d0228c <USBD_StdEPReq+0x46>
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02270:	00ca      	lsls	r2, r1, #3
c0d02272:	18a2      	adds	r2, r4, r2
c0d02274:	23f4      	movs	r3, #244	; 0xf4
c0d02276:	58d2      	ldr	r2, [r2, r3]
  if ((req->bmRequest & 0x60) == 0x20 && usbd_is_valid_intf(pdev, LOBYTE(req->wIndex)))
c0d02278:	2a00      	cmp	r2, #0
c0d0227a:	d007      	beq.n	c0d0228c <USBD_StdEPReq+0x46>
    ((Setup_t)PIC(pdev->interfacesClass[LOBYTE(req->wIndex)].pClass->Setup)) (pdev, req);
c0d0227c:	6890      	ldr	r0, [r2, #8]
c0d0227e:	f7ff fa63 	bl	c0d01748 <pic>
c0d02282:	4602      	mov	r2, r0
c0d02284:	4620      	mov	r0, r4
c0d02286:	4629      	mov	r1, r5
c0d02288:	4790      	blx	r2
c0d0228a:	e05c      	b.n	c0d02346 <USBD_StdEPReq+0x100>
  switch (req->bRequest) 
c0d0228c:	786a      	ldrb	r2, [r5, #1]
c0d0228e:	2a00      	cmp	r2, #0
c0d02290:	d00a      	beq.n	c0d022a8 <USBD_StdEPReq+0x62>
c0d02292:	2a01      	cmp	r2, #1
c0d02294:	d011      	beq.n	c0d022ba <USBD_StdEPReq+0x74>
c0d02296:	2a03      	cmp	r2, #3
c0d02298:	d155      	bne.n	c0d02346 <USBD_StdEPReq+0x100>
c0d0229a:	20dc      	movs	r0, #220	; 0xdc
    switch (pdev->dev_state) 
c0d0229c:	5c20      	ldrb	r0, [r4, r0]
c0d0229e:	2803      	cmp	r0, #3
c0d022a0:	d01a      	beq.n	c0d022d8 <USBD_StdEPReq+0x92>
c0d022a2:	2802      	cmp	r0, #2
c0d022a4:	d00f      	beq.n	c0d022c6 <USBD_StdEPReq+0x80>
c0d022a6:	e7d7      	b.n	c0d02258 <USBD_StdEPReq+0x12>
c0d022a8:	22dc      	movs	r2, #220	; 0xdc
    switch (pdev->dev_state) 
c0d022aa:	5ca2      	ldrb	r2, [r4, r2]
c0d022ac:	2a03      	cmp	r2, #3
c0d022ae:	d02e      	beq.n	c0d0230e <USBD_StdEPReq+0xc8>
c0d022b0:	2a02      	cmp	r2, #2
c0d022b2:	d1d1      	bne.n	c0d02258 <USBD_StdEPReq+0x12>
      if ((ep_addr & 0x7F) != 0x00) 
c0d022b4:	2800      	cmp	r0, #0
c0d022b6:	d10b      	bne.n	c0d022d0 <USBD_StdEPReq+0x8a>
c0d022b8:	e045      	b.n	c0d02346 <USBD_StdEPReq+0x100>
c0d022ba:	22dc      	movs	r2, #220	; 0xdc
    switch (pdev->dev_state) 
c0d022bc:	5ca2      	ldrb	r2, [r4, r2]
c0d022be:	2a03      	cmp	r2, #3
c0d022c0:	d031      	beq.n	c0d02326 <USBD_StdEPReq+0xe0>
c0d022c2:	2a02      	cmp	r2, #2
c0d022c4:	d1c8      	bne.n	c0d02258 <USBD_StdEPReq+0x12>
c0d022c6:	2080      	movs	r0, #128	; 0x80
c0d022c8:	460a      	mov	r2, r1
c0d022ca:	4302      	orrs	r2, r0
c0d022cc:	2a80      	cmp	r2, #128	; 0x80
c0d022ce:	d03a      	beq.n	c0d02346 <USBD_StdEPReq+0x100>
c0d022d0:	4620      	mov	r0, r4
c0d022d2:	f7ff fbb9 	bl	c0d01a48 <USBD_LL_StallEP>
c0d022d6:	e036      	b.n	c0d02346 <USBD_StdEPReq+0x100>
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d022d8:	8868      	ldrh	r0, [r5, #2]
c0d022da:	2800      	cmp	r0, #0
c0d022dc:	d107      	bne.n	c0d022ee <USBD_StdEPReq+0xa8>
c0d022de:	2080      	movs	r0, #128	; 0x80
c0d022e0:	4308      	orrs	r0, r1
c0d022e2:	2880      	cmp	r0, #128	; 0x80
c0d022e4:	d003      	beq.n	c0d022ee <USBD_StdEPReq+0xa8>
          USBD_LL_StallEP(pdev , ep_addr);
c0d022e6:	4620      	mov	r0, r4
c0d022e8:	f7ff fbae 	bl	c0d01a48 <USBD_LL_StallEP>
      if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d022ec:	7929      	ldrb	r1, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d022ee:	2902      	cmp	r1, #2
c0d022f0:	d826      	bhi.n	c0d02340 <USBD_StdEPReq+0xfa>
c0d022f2:	00c8      	lsls	r0, r1, #3
c0d022f4:	1820      	adds	r0, r4, r0
c0d022f6:	21f4      	movs	r1, #244	; 0xf4
c0d022f8:	5840      	ldr	r0, [r0, r1]
c0d022fa:	2800      	cmp	r0, #0
c0d022fc:	d020      	beq.n	c0d02340 <USBD_StdEPReq+0xfa>
c0d022fe:	6880      	ldr	r0, [r0, #8]
c0d02300:	f7ff fa22 	bl	c0d01748 <pic>
c0d02304:	4602      	mov	r2, r0
c0d02306:	4620      	mov	r0, r4
c0d02308:	4629      	mov	r1, r5
c0d0230a:	4790      	blx	r2
c0d0230c:	e018      	b.n	c0d02340 <USBD_StdEPReq+0xfa>
        unsigned short status = USBD_LL_IsStallEP(pdev, ep_addr)? 1 : 0;        
c0d0230e:	4620      	mov	r0, r4
c0d02310:	f7ff fbe2 	bl	c0d01ad8 <USBD_LL_IsStallEP>
c0d02314:	1e41      	subs	r1, r0, #1
c0d02316:	4188      	sbcs	r0, r1
c0d02318:	a901      	add	r1, sp, #4
c0d0231a:	8008      	strh	r0, [r1, #0]
c0d0231c:	2202      	movs	r2, #2
        USBD_CtlSendData (pdev,
c0d0231e:	4620      	mov	r0, r4
c0d02320:	f000 fa0a 	bl	c0d02738 <USBD_CtlSendData>
c0d02324:	e00f      	b.n	c0d02346 <USBD_StdEPReq+0x100>
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02326:	886a      	ldrh	r2, [r5, #2]
c0d02328:	2a00      	cmp	r2, #0
c0d0232a:	d10c      	bne.n	c0d02346 <USBD_StdEPReq+0x100>
        if ((ep_addr & 0x7F) != 0x00) 
c0d0232c:	2800      	cmp	r0, #0
c0d0232e:	d007      	beq.n	c0d02340 <USBD_StdEPReq+0xfa>
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d02330:	4620      	mov	r0, r4
c0d02332:	f7ff fbad 	bl	c0d01a90 <USBD_LL_ClearStallEP>
          if(usbd_is_valid_intf(pdev, LOBYTE(req->wIndex))) {
c0d02336:	7928      	ldrb	r0, [r5, #4]
  return intf < USBD_MAX_NUM_INTERFACES && pdev->interfacesClass[intf].pClass != NULL;
c0d02338:	2802      	cmp	r0, #2
c0d0233a:	d801      	bhi.n	c0d02340 <USBD_StdEPReq+0xfa>
c0d0233c:	00c0      	lsls	r0, r0, #3
c0d0233e:	e7d9      	b.n	c0d022f4 <USBD_StdEPReq+0xae>
c0d02340:	4620      	mov	r0, r4
c0d02342:	f000 fa24 	bl	c0d0278e <USBD_CtlSendStatus>
c0d02346:	2000      	movs	r0, #0
}
c0d02348:	b002      	add	sp, #8
c0d0234a:	bdb0      	pop	{r4, r5, r7, pc}

c0d0234c <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d0234c:	780a      	ldrb	r2, [r1, #0]
c0d0234e:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d02350:	784a      	ldrb	r2, [r1, #1]
c0d02352:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d02354:	788a      	ldrb	r2, [r1, #2]
c0d02356:	78cb      	ldrb	r3, [r1, #3]
c0d02358:	021b      	lsls	r3, r3, #8
c0d0235a:	189a      	adds	r2, r3, r2
c0d0235c:	8042      	strh	r2, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d0235e:	790a      	ldrb	r2, [r1, #4]
c0d02360:	794b      	ldrb	r3, [r1, #5]
c0d02362:	021b      	lsls	r3, r3, #8
c0d02364:	189a      	adds	r2, r3, r2
c0d02366:	8082      	strh	r2, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02368:	798a      	ldrb	r2, [r1, #6]
c0d0236a:	79c9      	ldrb	r1, [r1, #7]
c0d0236c:	0209      	lsls	r1, r1, #8
c0d0236e:	1889      	adds	r1, r1, r2
c0d02370:	80c1      	strh	r1, [r0, #6]

}
c0d02372:	4770      	bx	lr

c0d02374 <USBD_CtlStall>:
* @param  pdev: device instance
* @param  req: usb request
* @retval None
*/
void USBD_CtlStall( USBD_HandleTypeDef *pdev)
{
c0d02374:	b510      	push	{r4, lr}
c0d02376:	4604      	mov	r4, r0
c0d02378:	2180      	movs	r1, #128	; 0x80
  USBD_LL_StallEP(pdev , 0x80);
c0d0237a:	f7ff fb65 	bl	c0d01a48 <USBD_LL_StallEP>
c0d0237e:	2100      	movs	r1, #0
  USBD_LL_StallEP(pdev , 0);
c0d02380:	4620      	mov	r0, r4
c0d02382:	f7ff fb61 	bl	c0d01a48 <USBD_LL_StallEP>
}
c0d02386:	bd10      	pop	{r4, pc}

c0d02388 <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02388:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0238a:	b083      	sub	sp, #12
c0d0238c:	460e      	mov	r6, r1
c0d0238e:	4605      	mov	r5, r0
c0d02390:	a802      	add	r0, sp, #8
c0d02392:	2400      	movs	r4, #0
  uint16_t len = 0;
c0d02394:	8004      	strh	r4, [r0, #0]
c0d02396:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02398:	7004      	strb	r4, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d0239a:	7809      	ldrb	r1, [r1, #0]
c0d0239c:	2060      	movs	r0, #96	; 0x60
c0d0239e:	4008      	ands	r0, r1
c0d023a0:	d010      	beq.n	c0d023c4 <USBD_HID_Setup+0x3c>
c0d023a2:	2820      	cmp	r0, #32
c0d023a4:	d137      	bne.n	c0d02416 <USBD_HID_Setup+0x8e>
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d023a6:	7870      	ldrb	r0, [r6, #1]
c0d023a8:	4601      	mov	r1, r0
c0d023aa:	390a      	subs	r1, #10
c0d023ac:	2902      	cmp	r1, #2
c0d023ae:	d332      	bcc.n	c0d02416 <USBD_HID_Setup+0x8e>
c0d023b0:	2802      	cmp	r0, #2
c0d023b2:	d01b      	beq.n	c0d023ec <USBD_HID_Setup+0x64>
c0d023b4:	2803      	cmp	r0, #3
c0d023b6:	d019      	beq.n	c0d023ec <USBD_HID_Setup+0x64>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d023b8:	4628      	mov	r0, r5
c0d023ba:	4631      	mov	r1, r6
c0d023bc:	f000 f930 	bl	c0d02620 <USBD_CtlError>
c0d023c0:	2402      	movs	r4, #2
c0d023c2:	e028      	b.n	c0d02416 <USBD_HID_Setup+0x8e>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d023c4:	7870      	ldrb	r0, [r6, #1]
c0d023c6:	280b      	cmp	r0, #11
c0d023c8:	d013      	beq.n	c0d023f2 <USBD_HID_Setup+0x6a>
c0d023ca:	280a      	cmp	r0, #10
c0d023cc:	d00e      	beq.n	c0d023ec <USBD_HID_Setup+0x64>
c0d023ce:	2806      	cmp	r0, #6
c0d023d0:	d121      	bne.n	c0d02416 <USBD_HID_Setup+0x8e>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d023d2:	78f0      	ldrb	r0, [r6, #3]
c0d023d4:	2400      	movs	r4, #0
c0d023d6:	2821      	cmp	r0, #33	; 0x21
c0d023d8:	d00f      	beq.n	c0d023fa <USBD_HID_Setup+0x72>
c0d023da:	2822      	cmp	r0, #34	; 0x22
c0d023dc:	4622      	mov	r2, r4
c0d023de:	4621      	mov	r1, r4
c0d023e0:	d116      	bne.n	c0d02410 <USBD_HID_Setup+0x88>
c0d023e2:	af02      	add	r7, sp, #8
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d023e4:	4638      	mov	r0, r7
c0d023e6:	f000 f849 	bl	c0d0247c <USBD_HID_GetReportDescriptor_impl>
c0d023ea:	e00a      	b.n	c0d02402 <USBD_HID_Setup+0x7a>
c0d023ec:	a901      	add	r1, sp, #4
c0d023ee:	2201      	movs	r2, #1
c0d023f0:	e00e      	b.n	c0d02410 <USBD_HID_Setup+0x88>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d023f2:	4628      	mov	r0, r5
c0d023f4:	f000 f9cb 	bl	c0d0278e <USBD_CtlSendStatus>
c0d023f8:	e00d      	b.n	c0d02416 <USBD_HID_Setup+0x8e>
c0d023fa:	af02      	add	r7, sp, #8
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d023fc:	4638      	mov	r0, r7
c0d023fe:	f000 f829 	bl	c0d02454 <USBD_HID_GetHidDescriptor_impl>
c0d02402:	4601      	mov	r1, r0
c0d02404:	883a      	ldrh	r2, [r7, #0]
c0d02406:	88f0      	ldrh	r0, [r6, #6]
c0d02408:	4282      	cmp	r2, r0
c0d0240a:	d300      	bcc.n	c0d0240e <USBD_HID_Setup+0x86>
c0d0240c:	4602      	mov	r2, r0
c0d0240e:	803a      	strh	r2, [r7, #0]
c0d02410:	4628      	mov	r0, r5
c0d02412:	f000 f991 	bl	c0d02738 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02416:	4620      	mov	r0, r4
c0d02418:	b003      	add	sp, #12
c0d0241a:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0241c <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d0241c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0241e:	b081      	sub	sp, #4
c0d02420:	4604      	mov	r4, r0
c0d02422:	2182      	movs	r1, #130	; 0x82
c0d02424:	2603      	movs	r6, #3
c0d02426:	2540      	movs	r5, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02428:	4632      	mov	r2, r6
c0d0242a:	462b      	mov	r3, r5
c0d0242c:	f7ff fadc 	bl	c0d019e8 <USBD_LL_OpenEP>
c0d02430:	2702      	movs	r7, #2
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d02432:	4620      	mov	r0, r4
c0d02434:	4639      	mov	r1, r7
c0d02436:	4632      	mov	r2, r6
c0d02438:	462b      	mov	r3, r5
c0d0243a:	f7ff fad5 	bl	c0d019e8 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d0243e:	4620      	mov	r0, r4
c0d02440:	4639      	mov	r1, r7
c0d02442:	462a      	mov	r2, r5
c0d02444:	f7ff fb83 	bl	c0d01b4e <USBD_LL_PrepareReceive>
c0d02448:	2000      	movs	r0, #0
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d0244a:	b001      	add	sp, #4
c0d0244c:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0244e <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d0244e:	2000      	movs	r0, #0
  
  // /* Close HID EP OUT */
  // USBD_LL_CloseEP(pdev,
  //                 HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02450:	4770      	bx	lr
	...

c0d02454 <USBD_HID_GetHidDescriptor_impl>:
{
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
c0d02454:	4601      	mov	r1, r0
c0d02456:	20ec      	movs	r0, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d02458:	4a06      	ldr	r2, [pc, #24]	; (c0d02474 <USBD_HID_GetHidDescriptor_impl+0x20>)
c0d0245a:	5c12      	ldrb	r2, [r2, r0]
c0d0245c:	2000      	movs	r0, #0
c0d0245e:	2a00      	cmp	r2, #0
c0d02460:	d001      	beq.n	c0d02466 <USBD_HID_GetHidDescriptor_impl+0x12>
c0d02462:	4603      	mov	r3, r0
c0d02464:	e000      	b.n	c0d02468 <USBD_HID_GetHidDescriptor_impl+0x14>
c0d02466:	2309      	movs	r3, #9
c0d02468:	800b      	strh	r3, [r1, #0]
c0d0246a:	2a00      	cmp	r2, #0
c0d0246c:	d101      	bne.n	c0d02472 <USBD_HID_GetHidDescriptor_impl+0x1e>
c0d0246e:	4802      	ldr	r0, [pc, #8]	; (c0d02478 <USBD_HID_GetHidDescriptor_impl+0x24>)
c0d02470:	4478      	add	r0, pc
      return (uint8_t*)USBD_HID_Desc_kbd; 
#endif // HAVE_USB_HIDKBD
  }
  *len = 0;
  return 0;
}
c0d02472:	4770      	bx	lr
c0d02474:	200005d8 	.word	0x200005d8
c0d02478:	00001000 	.word	0x00001000

c0d0247c <USBD_HID_GetReportDescriptor_impl>:

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
c0d0247c:	4601      	mov	r1, r0
c0d0247e:	20ec      	movs	r0, #236	; 0xec
  switch (USBD_Device.request.wIndex&0xFF) {
c0d02480:	4a06      	ldr	r2, [pc, #24]	; (c0d0249c <USBD_HID_GetReportDescriptor_impl+0x20>)
c0d02482:	5c12      	ldrb	r2, [r2, r0]
c0d02484:	2000      	movs	r0, #0
c0d02486:	2a00      	cmp	r2, #0
c0d02488:	d001      	beq.n	c0d0248e <USBD_HID_GetReportDescriptor_impl+0x12>
c0d0248a:	4603      	mov	r3, r0
c0d0248c:	e000      	b.n	c0d02490 <USBD_HID_GetReportDescriptor_impl+0x14>
c0d0248e:	2322      	movs	r3, #34	; 0x22
c0d02490:	800b      	strh	r3, [r1, #0]
c0d02492:	2a00      	cmp	r2, #0
c0d02494:	d101      	bne.n	c0d0249a <USBD_HID_GetReportDescriptor_impl+0x1e>
c0d02496:	4802      	ldr	r0, [pc, #8]	; (c0d024a0 <USBD_HID_GetReportDescriptor_impl+0x24>)
c0d02498:	4478      	add	r0, pc
    return (uint8_t*)HID_ReportDesc_kbd;
#endif // HAVE_USB_HIDKBD
  }
  *len = 0;
  return 0;
}
c0d0249a:	4770      	bx	lr
c0d0249c:	200005d8 	.word	0x200005d8
c0d024a0:	00000fe1 	.word	0x00000fe1

c0d024a4 <USBD_HID_DataIn_impl>:
}
#endif // HAVE_IO_U2F

uint8_t  USBD_HID_DataIn_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d024a4:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d024a6:	2902      	cmp	r1, #2
c0d024a8:	d103      	bne.n	c0d024b2 <USBD_HID_DataIn_impl+0xe>
    // HID gen endpoint
    case (HID_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data);
c0d024aa:	4803      	ldr	r0, [pc, #12]	; (c0d024b8 <USBD_HID_DataIn_impl+0x14>)
c0d024ac:	4478      	add	r0, pc
c0d024ae:	f7fe ff0b 	bl	c0d012c8 <io_usb_hid_sent>
c0d024b2:	2000      	movs	r0, #0
      break;
  }

  return USBD_OK;
c0d024b4:	bd80      	pop	{r7, pc}
c0d024b6:	46c0      	nop			; (mov r8, r8)
c0d024b8:	ffffe6f5 	.word	0xffffe6f5

c0d024bc <USBD_HID_DataOut_impl>:
}

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d024bc:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d024be:	2902      	cmp	r1, #2
c0d024c0:	d11a      	bne.n	c0d024f8 <USBD_HID_DataOut_impl+0x3c>
c0d024c2:	4614      	mov	r4, r2
c0d024c4:	2102      	movs	r1, #2
c0d024c6:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (HID_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d024c8:	f7ff fb41 	bl	c0d01b4e <USBD_LL_PrepareReceive>

#ifndef HAVE_USB_HIDKBD
    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d024cc:	4d0b      	ldr	r5, [pc, #44]	; (c0d024fc <USBD_HID_DataOut_impl+0x40>)
c0d024ce:	79a8      	ldrb	r0, [r5, #6]
c0d024d0:	2800      	cmp	r0, #0
c0d024d2:	d111      	bne.n	c0d024f8 <USBD_HID_DataOut_impl+0x3c>
c0d024d4:	2002      	movs	r0, #2
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d024d6:	f7fe fb01 	bl	c0d00adc <io_seproxyhal_get_ep_rx_size>
c0d024da:	4602      	mov	r2, r0
c0d024dc:	4809      	ldr	r0, [pc, #36]	; (c0d02504 <USBD_HID_DataOut_impl+0x48>)
c0d024de:	4478      	add	r0, pc
c0d024e0:	4621      	mov	r1, r4
c0d024e2:	f7fe fe43 	bl	c0d0116c <io_usb_hid_receive>
c0d024e6:	2802      	cmp	r0, #2
c0d024e8:	d106      	bne.n	c0d024f8 <USBD_HID_DataOut_impl+0x3c>
c0d024ea:	2007      	movs	r0, #7
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
          G_io_app.apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d024ec:	7028      	strb	r0, [r5, #0]
c0d024ee:	2001      	movs	r0, #1
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d024f0:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d024f2:	4803      	ldr	r0, [pc, #12]	; (c0d02500 <USBD_HID_DataOut_impl+0x44>)
c0d024f4:	6800      	ldr	r0, [r0, #0]
c0d024f6:	8068      	strh	r0, [r5, #2]
c0d024f8:	2000      	movs	r0, #0
    }
#endif // HAVE_USB_HIDKBD
    break;
  }

  return USBD_OK;
c0d024fa:	bdb0      	pop	{r4, r5, r7, pc}
c0d024fc:	20000554 	.word	0x20000554
c0d02500:	200005c0 	.word	0x200005c0
c0d02504:	ffffe6c3 	.word	0xffffe6c3

c0d02508 <USBD_WEBUSB_Init>:

#ifdef HAVE_WEBUSB

uint8_t  USBD_WEBUSB_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d02508:	b570      	push	{r4, r5, r6, lr}
c0d0250a:	4604      	mov	r4, r0
c0d0250c:	2183      	movs	r1, #131	; 0x83
c0d0250e:	2503      	movs	r5, #3
c0d02510:	2640      	movs	r6, #64	; 0x40
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d02512:	462a      	mov	r2, r5
c0d02514:	4633      	mov	r3, r6
c0d02516:	f7ff fa67 	bl	c0d019e8 <USBD_LL_OpenEP>
                 WEBUSB_EPIN_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d0251a:	4620      	mov	r0, r4
c0d0251c:	4629      	mov	r1, r5
c0d0251e:	462a      	mov	r2, r5
c0d02520:	4633      	mov	r3, r6
c0d02522:	f7ff fa61 	bl	c0d019e8 <USBD_LL_OpenEP>
                 WEBUSB_EPOUT_ADDR,
                 USBD_EP_TYPE_INTR,
                 WEBUSB_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d02526:	4620      	mov	r0, r4
c0d02528:	4629      	mov	r1, r5
c0d0252a:	4632      	mov	r2, r6
c0d0252c:	f7ff fb0f 	bl	c0d01b4e <USBD_LL_PrepareReceive>
c0d02530:	2000      	movs	r0, #0

  return USBD_OK;
c0d02532:	bd70      	pop	{r4, r5, r6, pc}

c0d02534 <USBD_WEBUSB_DeInit>:
}

uint8_t  USBD_WEBUSB_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx) {
c0d02534:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(cfgidx);
  return USBD_OK;
c0d02536:	4770      	bx	lr

c0d02538 <USBD_WEBUSB_Setup>:
}

uint8_t  USBD_WEBUSB_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d02538:	2000      	movs	r0, #0
  UNUSED(pdev);
  UNUSED(req);
  return USBD_OK;
c0d0253a:	4770      	bx	lr

c0d0253c <USBD_WEBUSB_DataIn>:
}

uint8_t  USBD_WEBUSB_DataIn (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum)
{
c0d0253c:	b580      	push	{r7, lr}
  UNUSED(pdev);
  switch (epnum) {
c0d0253e:	2903      	cmp	r1, #3
c0d02540:	d103      	bne.n	c0d0254a <USBD_WEBUSB_DataIn+0xe>
    // HID gen endpoint
    case (WEBUSB_EPIN_ADDR&0x7F):
      io_usb_hid_sent(io_usb_send_apdu_data_ep0x83);
c0d02542:	4803      	ldr	r0, [pc, #12]	; (c0d02550 <USBD_WEBUSB_DataIn+0x14>)
c0d02544:	4478      	add	r0, pc
c0d02546:	f7fe febf 	bl	c0d012c8 <io_usb_hid_sent>
c0d0254a:	2000      	movs	r0, #0
      break;
  }
  return USBD_OK;
c0d0254c:	bd80      	pop	{r7, pc}
c0d0254e:	46c0      	nop			; (mov r8, r8)
c0d02550:	ffffe66d 	.word	0xffffe66d

c0d02554 <USBD_WEBUSB_DataOut>:
}

uint8_t USBD_WEBUSB_DataOut (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02554:	b5b0      	push	{r4, r5, r7, lr}
  // only the data hid endpoint will receive data
  switch (epnum) {
c0d02556:	2903      	cmp	r1, #3
c0d02558:	d11a      	bne.n	c0d02590 <USBD_WEBUSB_DataOut+0x3c>
c0d0255a:	4614      	mov	r4, r2
c0d0255c:	2103      	movs	r1, #3
c0d0255e:	2240      	movs	r2, #64	; 0x40

  // HID gen endpoint
  case (WEBUSB_EPOUT_ADDR&0x7F):
    // prepare receiving the next chunk (masked time)
    USBD_LL_PrepareReceive(pdev, WEBUSB_EPOUT_ADDR, WEBUSB_EPOUT_SIZE);
c0d02560:	f7ff faf5 	bl	c0d01b4e <USBD_LL_PrepareReceive>

    // avoid troubles when an apdu has not been replied yet
    if (G_io_app.apdu_media == IO_APDU_MEDIA_NONE) {      
c0d02564:	4d0b      	ldr	r5, [pc, #44]	; (c0d02594 <USBD_WEBUSB_DataOut+0x40>)
c0d02566:	79a8      	ldrb	r0, [r5, #6]
c0d02568:	2800      	cmp	r0, #0
c0d0256a:	d111      	bne.n	c0d02590 <USBD_WEBUSB_DataOut+0x3c>
c0d0256c:	2003      	movs	r0, #3
      // add to the hid transport
      switch(io_usb_hid_receive(io_usb_send_apdu_data_ep0x83, buffer, io_seproxyhal_get_ep_rx_size(WEBUSB_EPOUT_ADDR))) {
c0d0256e:	f7fe fab5 	bl	c0d00adc <io_seproxyhal_get_ep_rx_size>
c0d02572:	4602      	mov	r2, r0
c0d02574:	4809      	ldr	r0, [pc, #36]	; (c0d0259c <USBD_WEBUSB_DataOut+0x48>)
c0d02576:	4478      	add	r0, pc
c0d02578:	4621      	mov	r1, r4
c0d0257a:	f7fe fdf7 	bl	c0d0116c <io_usb_hid_receive>
c0d0257e:	2802      	cmp	r0, #2
c0d02580:	d106      	bne.n	c0d02590 <USBD_WEBUSB_DataOut+0x3c>
c0d02582:	200b      	movs	r0, #11
        default:
          break;

        case IO_USB_APDU_RECEIVED:
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
          G_io_app.apdu_state = APDU_USB_WEBUSB; // for next call to io_exchange
c0d02584:	7028      	strb	r0, [r5, #0]
c0d02586:	2005      	movs	r0, #5
          G_io_app.apdu_media = IO_APDU_MEDIA_USB_WEBUSB; // for application code
c0d02588:	71a8      	strb	r0, [r5, #6]
          G_io_app.apdu_length = G_io_usb_hid_total_length;
c0d0258a:	4803      	ldr	r0, [pc, #12]	; (c0d02598 <USBD_WEBUSB_DataOut+0x44>)
c0d0258c:	6800      	ldr	r0, [r0, #0]
c0d0258e:	8068      	strh	r0, [r5, #2]
c0d02590:	2000      	movs	r0, #0
      }
    }
    break;
  }

  return USBD_OK;
c0d02592:	bdb0      	pop	{r4, r5, r7, pc}
c0d02594:	20000554 	.word	0x20000554
c0d02598:	200005c0 	.word	0x200005c0
c0d0259c:	ffffe63b 	.word	0xffffe63b

c0d025a0 <USBD_DeviceDescriptor>:
{
c0d025a0:	2012      	movs	r0, #18
  *length = sizeof(USBD_DeviceDesc);
c0d025a2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d025a4:	4801      	ldr	r0, [pc, #4]	; (c0d025ac <USBD_DeviceDescriptor+0xc>)
c0d025a6:	4478      	add	r0, pc
c0d025a8:	4770      	bx	lr
c0d025aa:	46c0      	nop			; (mov r8, r8)
c0d025ac:	00001116 	.word	0x00001116

c0d025b0 <USBD_LangIDStrDescriptor>:
{
c0d025b0:	2004      	movs	r0, #4
  *length = sizeof(USBD_LangIDDesc);  
c0d025b2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d025b4:	4801      	ldr	r0, [pc, #4]	; (c0d025bc <USBD_LangIDStrDescriptor+0xc>)
c0d025b6:	4478      	add	r0, pc
c0d025b8:	4770      	bx	lr
c0d025ba:	46c0      	nop			; (mov r8, r8)
c0d025bc:	00001118 	.word	0x00001118

c0d025c0 <USBD_ManufacturerStrDescriptor>:
{
c0d025c0:	200e      	movs	r0, #14
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d025c2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d025c4:	4801      	ldr	r0, [pc, #4]	; (c0d025cc <USBD_ManufacturerStrDescriptor+0xc>)
c0d025c6:	4478      	add	r0, pc
c0d025c8:	4770      	bx	lr
c0d025ca:	46c0      	nop			; (mov r8, r8)
c0d025cc:	0000110c 	.word	0x0000110c

c0d025d0 <USBD_ProductStrDescriptor>:
{
c0d025d0:	200e      	movs	r0, #14
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d025d2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d025d4:	4801      	ldr	r0, [pc, #4]	; (c0d025dc <USBD_ProductStrDescriptor+0xc>)
c0d025d6:	4478      	add	r0, pc
c0d025d8:	4770      	bx	lr
c0d025da:	46c0      	nop			; (mov r8, r8)
c0d025dc:	0000110a 	.word	0x0000110a

c0d025e0 <USBD_SerialStrDescriptor>:
{
c0d025e0:	200a      	movs	r0, #10
  *length = sizeof(USB_SERIAL_STRING);
c0d025e2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d025e4:	4801      	ldr	r0, [pc, #4]	; (c0d025ec <USBD_SerialStrDescriptor+0xc>)
c0d025e6:	4478      	add	r0, pc
c0d025e8:	4770      	bx	lr
c0d025ea:	46c0      	nop			; (mov r8, r8)
c0d025ec:	00001108 	.word	0x00001108

c0d025f0 <USBD_ConfigStrDescriptor>:
{
c0d025f0:	200e      	movs	r0, #14
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d025f2:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d025f4:	4801      	ldr	r0, [pc, #4]	; (c0d025fc <USBD_ConfigStrDescriptor+0xc>)
c0d025f6:	4478      	add	r0, pc
c0d025f8:	4770      	bx	lr
c0d025fa:	46c0      	nop			; (mov r8, r8)
c0d025fc:	000010ea 	.word	0x000010ea

c0d02600 <USBD_InterfaceStrDescriptor>:
{
c0d02600:	200e      	movs	r0, #14
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02602:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d02604:	4801      	ldr	r0, [pc, #4]	; (c0d0260c <USBD_InterfaceStrDescriptor+0xc>)
c0d02606:	4478      	add	r0, pc
c0d02608:	4770      	bx	lr
c0d0260a:	46c0      	nop			; (mov r8, r8)
c0d0260c:	000010da 	.word	0x000010da

c0d02610 <USBD_BOSDescriptor>:
};

#endif // HAVE_WEBUSB

static uint8_t *USBD_BOSDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
c0d02610:	2039      	movs	r0, #57	; 0x39
  UNUSED(speed);
#ifdef HAVE_WEBUSB
  *length = sizeof(C_usb_bos);
c0d02612:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)C_usb_bos;
c0d02614:	4801      	ldr	r0, [pc, #4]	; (c0d0261c <USBD_BOSDescriptor+0xc>)
c0d02616:	4478      	add	r0, pc
c0d02618:	4770      	bx	lr
c0d0261a:	46c0      	nop			; (mov r8, r8)
c0d0261c:	00000e85 	.word	0x00000e85

c0d02620 <USBD_CtlError>:
  '4', 0x00, '6', 0x00, '7', 0x00, '6', 0x00, '5', 0x00, '7', 0x00,
  '2', 0x00, '}', 0x00, 0x00, 0x00, 0x00, 0x00 // propertyData, double unicode nul terminated
};

// upon unsupported request, check for webusb request
void USBD_CtlError( USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef *req) {
c0d02620:	b580      	push	{r7, lr}
    USBD_CtlSendData (pdev, (unsigned char*)C_webusb_url_descriptor, MIN(req->wLength, sizeof(C_webusb_url_descriptor)));
  }
  else 
#endif // WEBUSB_URL_SIZE_B
    // SETUP (LE): 0x80 0x06 0x03 0x77 0x00 0x00 0xXX 0xXX
    if ((req->bmRequest & 0x80) 
c0d02622:	2200      	movs	r2, #0
c0d02624:	568a      	ldrsb	r2, [r1, r2]
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
c0d02626:	2a00      	cmp	r2, #0
c0d02628:	d402      	bmi.n	c0d02630 <USBD_CtlError+0x10>
      && req->bRequest == WINUSB_VENDOR_CODE
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
  }
  else {
    USBD_CtlStall(pdev);
c0d0262a:	f7ff fea3 	bl	c0d02374 <USBD_CtlStall>
  }
}
c0d0262e:	bd80      	pop	{r7, pc}
    && req->bRequest == USB_REQ_GET_DESCRIPTOR 
c0d02630:	784a      	ldrb	r2, [r1, #1]
    && (req->wValue>>8) == USB_DESC_TYPE_STRING 
c0d02632:	2a77      	cmp	r2, #119	; 0x77
c0d02634:	d00c      	beq.n	c0d02650 <USBD_CtlError+0x30>
c0d02636:	2a06      	cmp	r2, #6
c0d02638:	d1f7      	bne.n	c0d0262a <USBD_CtlError+0xa>
c0d0263a:	884a      	ldrh	r2, [r1, #2]
c0d0263c:	4b14      	ldr	r3, [pc, #80]	; (c0d02690 <USBD_CtlError+0x70>)
    && (req->wValue & 0xFF) == 0xEE) {
c0d0263e:	429a      	cmp	r2, r3
c0d02640:	d1f3      	bne.n	c0d0262a <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_string_descriptor, MIN(req->wLength, sizeof(C_winusb_string_descriptor)));
c0d02642:	88ca      	ldrh	r2, [r1, #6]
c0d02644:	2a12      	cmp	r2, #18
c0d02646:	d300      	bcc.n	c0d0264a <USBD_CtlError+0x2a>
c0d02648:	2212      	movs	r2, #18
c0d0264a:	4912      	ldr	r1, [pc, #72]	; (c0d02694 <USBD_CtlError+0x74>)
c0d0264c:	4479      	add	r1, pc
c0d0264e:	e01c      	b.n	c0d0268a <USBD_CtlError+0x6a>
    && req->wIndex == WINUSB_GET_COMPATIBLE_ID_FEATURE) {
c0d02650:	888a      	ldrh	r2, [r1, #4]
  else if ((req->bmRequest & 0x80) 
c0d02652:	2a04      	cmp	r2, #4
c0d02654:	d106      	bne.n	c0d02664 <USBD_CtlError+0x44>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_wcid, MIN(req->wLength, sizeof(C_winusb_wcid)));
c0d02656:	88ca      	ldrh	r2, [r1, #6]
c0d02658:	2a28      	cmp	r2, #40	; 0x28
c0d0265a:	d300      	bcc.n	c0d0265e <USBD_CtlError+0x3e>
c0d0265c:	2228      	movs	r2, #40	; 0x28
c0d0265e:	490e      	ldr	r1, [pc, #56]	; (c0d02698 <USBD_CtlError+0x78>)
c0d02660:	4479      	add	r1, pc
c0d02662:	e012      	b.n	c0d0268a <USBD_CtlError+0x6a>
    && req->wIndex == WINUSB_GET_EXTENDED_PROPERTIES_OS_FEATURE 
c0d02664:	888a      	ldrh	r2, [r1, #4]
  else if ((req->bmRequest & 0x80) 
c0d02666:	2a05      	cmp	r2, #5
c0d02668:	d106      	bne.n	c0d02678 <USBD_CtlError+0x58>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_guid, MIN(req->wLength, sizeof(C_winusb_guid)));
c0d0266a:	88ca      	ldrh	r2, [r1, #6]
c0d0266c:	2a92      	cmp	r2, #146	; 0x92
c0d0266e:	d300      	bcc.n	c0d02672 <USBD_CtlError+0x52>
c0d02670:	2292      	movs	r2, #146	; 0x92
c0d02672:	490a      	ldr	r1, [pc, #40]	; (c0d0269c <USBD_CtlError+0x7c>)
c0d02674:	4479      	add	r1, pc
c0d02676:	e008      	b.n	c0d0268a <USBD_CtlError+0x6a>
      && req->wIndex == MS_OS_20_DESCRIPTOR_INDEX) {
c0d02678:	888a      	ldrh	r2, [r1, #4]
  else if ((req->bmRequest & 0x80)
c0d0267a:	2a07      	cmp	r2, #7
c0d0267c:	d1d5      	bne.n	c0d0262a <USBD_CtlError+0xa>
    USBD_CtlSendData(pdev, (unsigned char*)C_winusb_request_descriptor, MIN(req->wLength, sizeof(C_winusb_request_descriptor)));
c0d0267e:	88ca      	ldrh	r2, [r1, #6]
c0d02680:	2ab2      	cmp	r2, #178	; 0xb2
c0d02682:	d300      	bcc.n	c0d02686 <USBD_CtlError+0x66>
c0d02684:	22b2      	movs	r2, #178	; 0xb2
c0d02686:	4906      	ldr	r1, [pc, #24]	; (c0d026a0 <USBD_CtlError+0x80>)
c0d02688:	4479      	add	r1, pc
c0d0268a:	f000 f855 	bl	c0d02738 <USBD_CtlSendData>
}
c0d0268e:	bd80      	pop	{r7, pc}
c0d02690:	000003ee 	.word	0x000003ee
c0d02694:	00000ea8 	.word	0x00000ea8
c0d02698:	00001098 	.word	0x00001098
c0d0269c:	00000e92 	.word	0x00000e92
c0d026a0:	00000f10 	.word	0x00000f10

c0d026a4 <USB_power>:
  // nothing to do ?
  return 0;
}
#endif // HAVE_USB_CLASS_CCID

void USB_power(unsigned char enabled) {
c0d026a4:	b5b0      	push	{r4, r5, r7, lr}
c0d026a6:	4604      	mov	r4, r0
c0d026a8:	2045      	movs	r0, #69	; 0x45
c0d026aa:	0085      	lsls	r5, r0, #2
  memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d026ac:	4815      	ldr	r0, [pc, #84]	; (c0d02704 <USB_power+0x60>)
c0d026ae:	4629      	mov	r1, r5
c0d026b0:	f000 fcca 	bl	c0d03048 <__aeabi_memclr>

  // init timeouts and other global fields
  memset(G_io_app.usb_ep_xfer_len, 0, sizeof(G_io_app.usb_ep_xfer_len));
  memset(G_io_app.usb_ep_timeouts, 0, sizeof(G_io_app.usb_ep_timeouts));
c0d026b4:	4814      	ldr	r0, [pc, #80]	; (c0d02708 <USB_power+0x64>)
c0d026b6:	300c      	adds	r0, #12
c0d026b8:	2112      	movs	r1, #18
c0d026ba:	f000 fcc5 	bl	c0d03048 <__aeabi_memclr>

  if (enabled) {
c0d026be:	2c00      	cmp	r4, #0
c0d026c0:	d01b      	beq.n	c0d026fa <USB_power+0x56>
    memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d026c2:	4c10      	ldr	r4, [pc, #64]	; (c0d02704 <USB_power+0x60>)
c0d026c4:	4620      	mov	r0, r4
c0d026c6:	4629      	mov	r1, r5
c0d026c8:	f000 fcbe 	bl	c0d03048 <__aeabi_memclr>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d026cc:	490f      	ldr	r1, [pc, #60]	; (c0d0270c <USB_power+0x68>)
c0d026ce:	4479      	add	r1, pc
c0d026d0:	2500      	movs	r5, #0
c0d026d2:	4620      	mov	r0, r4
c0d026d4:	462a      	mov	r2, r5
c0d026d6:	f7ff fa4d 	bl	c0d01b74 <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClassForInterface(HID_INTF,  &USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d026da:	4a0d      	ldr	r2, [pc, #52]	; (c0d02710 <USB_power+0x6c>)
c0d026dc:	447a      	add	r2, pc
c0d026de:	4628      	mov	r0, r5
c0d026e0:	4621      	mov	r1, r4
c0d026e2:	f7ff fa81 	bl	c0d01be8 <USBD_RegisterClassForInterface>
c0d026e6:	2001      	movs	r0, #1
#ifdef HAVE_USB_CLASS_CCID
    USBD_RegisterClassForInterface(CCID_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_CCID);
#endif // HAVE_USB_CLASS_CCID

#ifdef HAVE_WEBUSB
    USBD_RegisterClassForInterface(WEBUSB_INTF, &USBD_Device, (USBD_ClassTypeDef*)&USBD_WEBUSB);
c0d026e8:	4a0a      	ldr	r2, [pc, #40]	; (c0d02714 <USB_power+0x70>)
c0d026ea:	447a      	add	r2, pc
c0d026ec:	4621      	mov	r1, r4
c0d026ee:	f7ff fa7b 	bl	c0d01be8 <USBD_RegisterClassForInterface>
#endif // HAVE_WEBUSB

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d026f2:	4620      	mov	r0, r4
c0d026f4:	f7ff fa85 	bl	c0d01c02 <USBD_Start>
  }
  else {
    USBD_DeInit(&USBD_Device);
  }
}
c0d026f8:	bdb0      	pop	{r4, r5, r7, pc}
    USBD_DeInit(&USBD_Device);
c0d026fa:	4802      	ldr	r0, [pc, #8]	; (c0d02704 <USB_power+0x60>)
c0d026fc:	f7ff fa56 	bl	c0d01bac <USBD_DeInit>
}
c0d02700:	bdb0      	pop	{r4, r5, r7, pc}
c0d02702:	46c0      	nop			; (mov r8, r8)
c0d02704:	200005d8 	.word	0x200005d8
c0d02708:	20000554 	.word	0x20000554
c0d0270c:	00000e06 	.word	0x00000e06
c0d02710:	00000f70 	.word	0x00000f70
c0d02714:	00000f9a 	.word	0x00000f9a

c0d02718 <USBD_GetCfgDesc_impl>:
{
c0d02718:	2140      	movs	r1, #64	; 0x40
  *length = sizeof (USBD_CfgDesc);
c0d0271a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d0271c:	4801      	ldr	r0, [pc, #4]	; (c0d02724 <USBD_GetCfgDesc_impl+0xc>)
c0d0271e:	4478      	add	r0, pc
c0d02720:	4770      	bx	lr
c0d02722:	46c0      	nop			; (mov r8, r8)
c0d02724:	00001002 	.word	0x00001002

c0d02728 <USBD_GetDeviceQualifierDesc_impl>:
{
c0d02728:	210a      	movs	r1, #10
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d0272a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d0272c:	4801      	ldr	r0, [pc, #4]	; (c0d02734 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d0272e:	4478      	add	r0, pc
c0d02730:	4770      	bx	lr
c0d02732:	46c0      	nop			; (mov r8, r8)
c0d02734:	00001032 	.word	0x00001032

c0d02738 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02738:	b5b0      	push	{r4, r5, r7, lr}
c0d0273a:	460c      	mov	r4, r1
c0d0273c:	21d4      	movs	r1, #212	; 0xd4
c0d0273e:	2302      	movs	r3, #2
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d02740:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02742:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02744:	61c2      	str	r2, [r0, #28]
c0d02746:	4601      	mov	r1, r0
c0d02748:	31d4      	adds	r1, #212	; 0xd4
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d0274a:	63cc      	str	r4, [r1, #60]	; 0x3c
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d0274c:	6a01      	ldr	r1, [r0, #32]
c0d0274e:	4291      	cmp	r1, r2
c0d02750:	d800      	bhi.n	c0d02754 <USBD_CtlSendData+0x1c>
c0d02752:	460a      	mov	r2, r1
c0d02754:	b293      	uxth	r3, r2
c0d02756:	2500      	movs	r5, #0
c0d02758:	4629      	mov	r1, r5
c0d0275a:	4622      	mov	r2, r4
c0d0275c:	f7ff f9de 	bl	c0d01b1c <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02760:	4628      	mov	r0, r5
c0d02762:	bdb0      	pop	{r4, r5, r7, pc}

c0d02764 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02764:	b5b0      	push	{r4, r5, r7, lr}
c0d02766:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d02768:	6a01      	ldr	r1, [r0, #32]
c0d0276a:	4291      	cmp	r1, r2
c0d0276c:	d800      	bhi.n	c0d02770 <USBD_CtlContinueSendData+0xc>
c0d0276e:	460a      	mov	r2, r1
c0d02770:	b293      	uxth	r3, r2
c0d02772:	2500      	movs	r5, #0
c0d02774:	4629      	mov	r1, r5
c0d02776:	4622      	mov	r2, r4
c0d02778:	f7ff f9d0 	bl	c0d01b1c <USBD_LL_Transmit>
  return USBD_OK;
c0d0277c:	4628      	mov	r0, r5
c0d0277e:	bdb0      	pop	{r4, r5, r7, pc}

c0d02780 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02780:	b510      	push	{r4, lr}
c0d02782:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d02784:	4621      	mov	r1, r4
c0d02786:	f7ff f9e2 	bl	c0d01b4e <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d0278a:	4620      	mov	r0, r4
c0d0278c:	bd10      	pop	{r4, pc}

c0d0278e <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d0278e:	b510      	push	{r4, lr}
c0d02790:	21d4      	movs	r1, #212	; 0xd4
c0d02792:	2204      	movs	r2, #4

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d02794:	5042      	str	r2, [r0, r1]
c0d02796:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d02798:	4621      	mov	r1, r4
c0d0279a:	4622      	mov	r2, r4
c0d0279c:	4623      	mov	r3, r4
c0d0279e:	f7ff f9bd 	bl	c0d01b1c <USBD_LL_Transmit>
  
  return USBD_OK;
c0d027a2:	4620      	mov	r0, r4
c0d027a4:	bd10      	pop	{r4, pc}

c0d027a6 <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d027a6:	b510      	push	{r4, lr}
c0d027a8:	21d4      	movs	r1, #212	; 0xd4
c0d027aa:	2205      	movs	r2, #5
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d027ac:	5042      	str	r2, [r0, r1]
c0d027ae:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d027b0:	4621      	mov	r1, r4
c0d027b2:	4622      	mov	r2, r4
c0d027b4:	f7ff f9cb 	bl	c0d01b4e <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d027b8:	4620      	mov	r0, r4
c0d027ba:	bd10      	pop	{r4, pc}

c0d027bc <ux_flow_is_first>:
	}
	return 1;
}

// to hide the left tick or not
unsigned int ux_flow_is_first(void) {
c0d027bc:	b510      	push	{r4, lr}
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d027be:	4911      	ldr	r1, [pc, #68]	; (c0d02804 <ux_flow_is_first+0x48>)
c0d027c0:	780a      	ldrb	r2, [r1, #0]
c0d027c2:	2001      	movs	r0, #1
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d027c4:	2a01      	cmp	r2, #1
c0d027c6:	d81b      	bhi.n	c0d02800 <ux_flow_is_first+0x44>
c0d027c8:	1e52      	subs	r2, r2, #1
c0d027ca:	230c      	movs	r3, #12
c0d027cc:	4353      	muls	r3, r2
c0d027ce:	18cb      	adds	r3, r1, r3
c0d027d0:	8b9a      	ldrh	r2, [r3, #28]
	// no previous ?
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d027d2:	2a00      	cmp	r2, #0
c0d027d4:	d014      	beq.n	c0d02800 <ux_flow_is_first+0x44>
c0d027d6:	6959      	ldr	r1, [r3, #20]
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
c0d027d8:	2900      	cmp	r1, #0
c0d027da:	d011      	beq.n	c0d02800 <ux_flow_is_first+0x44>
c0d027dc:	8b1b      	ldrh	r3, [r3, #24]
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d027de:	2b00      	cmp	r3, #0
c0d027e0:	d105      	bne.n	c0d027ee <ux_flow_is_first+0x32>
c0d027e2:	0094      	lsls	r4, r2, #2
c0d027e4:	1864      	adds	r4, r4, r1
c0d027e6:	1f24      	subs	r4, r4, #4
c0d027e8:	6824      	ldr	r4, [r4, #0]
	if (!ux_flow_check_valid()
c0d027ea:	1ce4      	adds	r4, r4, #3
c0d027ec:	d108      	bne.n	c0d02800 <ux_flow_is_first+0x44>
		return 1;
	}

	// previous is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
		&& G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].length
c0d027ee:	4293      	cmp	r3, r2
c0d027f0:	d205      	bcs.n	c0d027fe <ux_flow_is_first+0x42>
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index-1] == FLOW_BARRIER) {
c0d027f2:	009a      	lsls	r2, r3, #2
c0d027f4:	1851      	adds	r1, r2, r1
c0d027f6:	1f09      	subs	r1, r1, #4
c0d027f8:	6809      	ldr	r1, [r1, #0]
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d027fa:	1c89      	adds	r1, r1, #2
c0d027fc:	d000      	beq.n	c0d02800 <ux_flow_is_first+0x44>
c0d027fe:	2000      	movs	r0, #0
		return 1;
	}

	// not the first, for sure
	return 0;
}
c0d02800:	bd10      	pop	{r4, pc}
c0d02802:	46c0      	nop			; (mov r8, r8)
c0d02804:	20000200 	.word	0x20000200

c0d02808 <ux_flow_is_last>:

unsigned int ux_flow_is_last(void){
c0d02808:	b510      	push	{r4, lr}
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d0280a:	490e      	ldr	r1, [pc, #56]	; (c0d02844 <ux_flow_is_last+0x3c>)
c0d0280c:	780a      	ldrb	r2, [r1, #0]
c0d0280e:	2001      	movs	r0, #1
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d02810:	2a01      	cmp	r2, #1
c0d02812:	d816      	bhi.n	c0d02842 <ux_flow_is_last+0x3a>
c0d02814:	1e52      	subs	r2, r2, #1
c0d02816:	230c      	movs	r3, #12
c0d02818:	4353      	muls	r3, r2
c0d0281a:	18cb      	adds	r3, r1, r3
c0d0281c:	8b9a      	ldrh	r2, [r3, #28]
	// last ?
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d0281e:	2a00      	cmp	r2, #0
c0d02820:	d00f      	beq.n	c0d02842 <ux_flow_is_last+0x3a>
c0d02822:	6959      	ldr	r1, [r3, #20]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0
c0d02824:	2900      	cmp	r1, #0
c0d02826:	d00c      	beq.n	c0d02842 <ux_flow_is_last+0x3a>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
c0d02828:	8b1b      	ldrh	r3, [r3, #24]
c0d0282a:	1e54      	subs	r4, r2, #1
	if (!ux_flow_check_valid()
c0d0282c:	429c      	cmp	r4, r3
c0d0282e:	dd08      	ble.n	c0d02842 <ux_flow_is_last+0x3a>
		return 1;
	}

	// followed by a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
		&& G_ux.flow_stack[G_ux.stack_count-1].index < G_ux.flow_stack[G_ux.stack_count-1].length - 2
c0d02830:	1e92      	subs	r2, r2, #2
		&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d02832:	429a      	cmp	r2, r3
c0d02834:	dd04      	ble.n	c0d02840 <ux_flow_is_last+0x38>
c0d02836:	009a      	lsls	r2, r3, #2
c0d02838:	1851      	adds	r1, r2, r1
c0d0283a:	6849      	ldr	r1, [r1, #4]
	if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d0283c:	1c89      	adds	r1, r1, #2
c0d0283e:	d000      	beq.n	c0d02842 <ux_flow_is_last+0x3a>
c0d02840:	2000      	movs	r0, #0
		return 1;
	}

	// is not last
	return 0;
}
c0d02842:	bd10      	pop	{r4, pc}
c0d02844:	20000200 	.word	0x20000200

c0d02848 <ux_flow_next_internal>:
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
	}
}

static void ux_flow_next_internal(unsigned int display_step) {
c0d02848:	b570      	push	{r4, r5, r6, lr}
c0d0284a:	4601      	mov	r1, r0
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d0284c:	4a15      	ldr	r2, [pc, #84]	; (c0d028a4 <ux_flow_next_internal+0x5c>)
c0d0284e:	7810      	ldrb	r0, [r2, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d02850:	2801      	cmp	r0, #1
c0d02852:	d826      	bhi.n	c0d028a2 <ux_flow_next_internal+0x5a>
c0d02854:	1e40      	subs	r0, r0, #1
c0d02856:	230c      	movs	r3, #12
c0d02858:	4343      	muls	r3, r0
c0d0285a:	18d2      	adds	r2, r2, r3
c0d0285c:	8b95      	ldrh	r5, [r2, #28]
	// last reached already (need validation, not next)
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d0285e:	2d00      	cmp	r5, #0
c0d02860:	d01f      	beq.n	c0d028a2 <ux_flow_next_internal+0x5a>
c0d02862:	6954      	ldr	r4, [r2, #20]
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
c0d02864:	2c00      	cmp	r4, #0
c0d02866:	d01c      	beq.n	c0d028a2 <ux_flow_next_internal+0x5a>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length -1) {
c0d02868:	2d02      	cmp	r5, #2
c0d0286a:	d31a      	bcc.n	c0d028a2 <ux_flow_next_internal+0x5a>
c0d0286c:	8b13      	ldrh	r3, [r2, #24]
c0d0286e:	1e6e      	subs	r6, r5, #1
	if (!ux_flow_check_valid()
c0d02870:	429e      	cmp	r6, r3
c0d02872:	dd16      	ble.n	c0d028a2 <ux_flow_next_internal+0x5a>
c0d02874:	4616      	mov	r6, r2
c0d02876:	3618      	adds	r6, #24
		return;
	}

	// followed by a flow barrier ? => need validation instead of next
	if (G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {
c0d02878:	1ead      	subs	r5, r5, #2
c0d0287a:	429d      	cmp	r5, r3
c0d0287c:	db0a      	blt.n	c0d02894 <ux_flow_next_internal+0x4c>
		if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d0287e:	009d      	lsls	r5, r3, #2
c0d02880:	192c      	adds	r4, r5, r4
c0d02882:	6864      	ldr	r4, [r4, #4]
c0d02884:	1ca5      	adds	r5, r4, #2
c0d02886:	d00c      	beq.n	c0d028a2 <ux_flow_next_internal+0x5a>
c0d02888:	1ce4      	adds	r4, r4, #3
c0d0288a:	d103      	bne.n	c0d02894 <ux_flow_next_internal+0x4c>
c0d0288c:	2100      	movs	r1, #0
		}

		// followed by a flow barrier ? => need validation instead of next
		if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_LOOP) {
			// display first step, fake direction as forward
			G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index = 0;
c0d0288e:	8031      	strh	r1, [r6, #0]
c0d02890:	8351      	strh	r1, [r2, #26]
c0d02892:	e004      	b.n	c0d0289e <ux_flow_next_internal+0x56>
		}
	}

	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
	G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d02894:	1c5c      	adds	r4, r3, #1
c0d02896:	8034      	strh	r4, [r6, #0]
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d02898:	8353      	strh	r3, [r2, #26]
	if (display_step) {
c0d0289a:	2900      	cmp	r1, #0
c0d0289c:	d001      	beq.n	c0d028a2 <ux_flow_next_internal+0x5a>
c0d0289e:	f000 f833 	bl	c0d02908 <ux_flow_engine_init_step>
		ux_flow_engine_init_step(G_ux.stack_count-1);
	}
}
c0d028a2:	bd70      	pop	{r4, r5, r6, pc}
c0d028a4:	20000200 	.word	0x20000200

c0d028a8 <ux_flow_prev>:

void ux_flow_next(void) {
	ux_flow_next_internal(1);
}

void ux_flow_prev(void) {
c0d028a8:	b5b0      	push	{r4, r5, r7, lr}
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d028aa:	4916      	ldr	r1, [pc, #88]	; (c0d02904 <ux_flow_prev+0x5c>)
c0d028ac:	7808      	ldrb	r0, [r1, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d028ae:	2801      	cmp	r0, #1
c0d028b0:	d826      	bhi.n	c0d02900 <ux_flow_prev+0x58>
c0d028b2:	1e40      	subs	r0, r0, #1
c0d028b4:	220c      	movs	r2, #12
c0d028b6:	4342      	muls	r2, r0
c0d028b8:	1889      	adds	r1, r1, r2
c0d028ba:	8b8a      	ldrh	r2, [r1, #28]
	// first reached already
	if (!ux_flow_check_valid()
		|| G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d028bc:	2a00      	cmp	r2, #0
c0d028be:	d01f      	beq.n	c0d02900 <ux_flow_prev+0x58>
c0d028c0:	694c      	ldr	r4, [r1, #20]
		|| G_ux.flow_stack[G_ux.stack_count-1].length <= 1
c0d028c2:	2c00      	cmp	r4, #0
c0d028c4:	d01c      	beq.n	c0d02900 <ux_flow_prev+0x58>
		|| (G_ux.flow_stack[G_ux.stack_count-1].index == 0 
c0d028c6:	2a02      	cmp	r2, #2
c0d028c8:	d31a      	bcc.n	c0d02900 <ux_flow_prev+0x58>
c0d028ca:	8b0d      	ldrh	r5, [r1, #24]
c0d028cc:	460b      	mov	r3, r1
c0d028ce:	3318      	adds	r3, #24
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d028d0:	2d00      	cmp	r5, #0
c0d028d2:	d009      	beq.n	c0d028e8 <ux_flow_prev+0x40>
		ux_flow_engine_init_step(G_ux.stack_count-1);
		return;
	}

	// previous item is a flow barrier ?
	if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index-1] == FLOW_BARRIER) {
c0d028d4:	00aa      	lsls	r2, r5, #2
c0d028d6:	1912      	adds	r2, r2, r4
c0d028d8:	1f12      	subs	r2, r2, #4
c0d028da:	6812      	ldr	r2, [r2, #0]
c0d028dc:	1c92      	adds	r2, r2, #2
c0d028de:	d00f      	beq.n	c0d02900 <ux_flow_prev+0x58>
		return;
	}

	// advance flow pointer and display it (skip META STEPS)
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
	G_ux.flow_stack[G_ux.stack_count-1].index--;
c0d028e0:	1e6a      	subs	r2, r5, #1
c0d028e2:	801a      	strh	r2, [r3, #0]
	G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d028e4:	834d      	strh	r5, [r1, #26]
c0d028e6:	e009      	b.n	c0d028fc <ux_flow_prev+0x54>
			  && G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].length-1] != FLOW_LOOP)) {
c0d028e8:	0095      	lsls	r5, r2, #2
c0d028ea:	192c      	adds	r4, r5, r4
c0d028ec:	1f24      	subs	r4, r4, #4
c0d028ee:	6824      	ldr	r4, [r4, #0]
	if (!ux_flow_check_valid()
c0d028f0:	1ce4      	adds	r4, r4, #3
c0d028f2:	d105      	bne.n	c0d02900 <ux_flow_prev+0x58>
		G_ux.flow_stack[G_ux.stack_count-1].index = G_ux.flow_stack[G_ux.stack_count-1].length-2;
c0d028f4:	1e94      	subs	r4, r2, #2
c0d028f6:	801c      	strh	r4, [r3, #0]
		G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index+1;
c0d028f8:	1e52      	subs	r2, r2, #1
c0d028fa:	834a      	strh	r2, [r1, #26]
c0d028fc:	f000 f804 	bl	c0d02908 <ux_flow_engine_init_step>

	ux_flow_engine_init_step(G_ux.stack_count-1);
}
c0d02900:	bdb0      	pop	{r4, r5, r7, pc}
c0d02902:	46c0      	nop			; (mov r8, r8)
c0d02904:	20000200 	.word	0x20000200

c0d02908 <ux_flow_engine_init_step>:
static void ux_flow_engine_init_step(unsigned int stack_slot) {
c0d02908:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0290a:	b081      	sub	sp, #4
c0d0290c:	4604      	mov	r4, r0
c0d0290e:	200c      	movs	r0, #12
	if (G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] == FLOW_END_STEP) {
c0d02910:	4360      	muls	r0, r4
c0d02912:	491a      	ldr	r1, [pc, #104]	; (c0d0297c <ux_flow_engine_init_step+0x74>)
c0d02914:	180e      	adds	r6, r1, r0
c0d02916:	6970      	ldr	r0, [r6, #20]
c0d02918:	8b31      	ldrh	r1, [r6, #24]
c0d0291a:	0089      	lsls	r1, r1, #2
c0d0291c:	5840      	ldr	r0, [r0, r1]
c0d0291e:	2103      	movs	r1, #3
c0d02920:	43c9      	mvns	r1, r1
c0d02922:	4288      	cmp	r0, r1
c0d02924:	d827      	bhi.n	c0d02976 <ux_flow_engine_init_step+0x6e>
c0d02926:	4637      	mov	r7, r6
c0d02928:	3718      	adds	r7, #24
c0d0292a:	3614      	adds	r6, #20
	if (STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init) {
c0d0292c:	f7fe ff0c 	bl	c0d01748 <pic>
c0d02930:	6831      	ldr	r1, [r6, #0]
c0d02932:	883a      	ldrh	r2, [r7, #0]
c0d02934:	0092      	lsls	r2, r2, #2
c0d02936:	5889      	ldr	r1, [r1, r2]
c0d02938:	6805      	ldr	r5, [r0, #0]
c0d0293a:	4608      	mov	r0, r1
c0d0293c:	f7fe ff04 	bl	c0d01748 <pic>
c0d02940:	2d00      	cmp	r5, #0
c0d02942:	d006      	beq.n	c0d02952 <ux_flow_engine_init_step+0x4a>
		INITPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->init)(stack_slot);
c0d02944:	6800      	ldr	r0, [r0, #0]
c0d02946:	f7fe feff 	bl	c0d01748 <pic>
c0d0294a:	4601      	mov	r1, r0
c0d0294c:	4620      	mov	r0, r4
c0d0294e:	4788      	blx	r1
c0d02950:	e011      	b.n	c0d02976 <ux_flow_engine_init_step+0x6e>
			           STEPSPIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->validate_flow), 
c0d02952:	6880      	ldr	r0, [r0, #8]
c0d02954:	f7fe fef8 	bl	c0d01748 <pic>
c0d02958:	4605      	mov	r5, r0
			           (const ux_flow_step_t*) PIC(STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index])->params));
c0d0295a:	6830      	ldr	r0, [r6, #0]
c0d0295c:	8839      	ldrh	r1, [r7, #0]
c0d0295e:	0089      	lsls	r1, r1, #2
c0d02960:	5840      	ldr	r0, [r0, r1]
c0d02962:	f7fe fef1 	bl	c0d01748 <pic>
c0d02966:	6840      	ldr	r0, [r0, #4]
c0d02968:	f7fe feee 	bl	c0d01748 <pic>
c0d0296c:	4602      	mov	r2, r0
		ux_flow_init(stack_slot,
c0d0296e:	4620      	mov	r0, r4
c0d02970:	4629      	mov	r1, r5
c0d02972:	f000 f85d 	bl	c0d02a30 <ux_flow_init>
}
c0d02976:	b001      	add	sp, #4
c0d02978:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0297a:	46c0      	nop			; (mov r8, r8)
c0d0297c:	20000200 	.word	0x20000200

c0d02980 <ux_flow_validate>:

void ux_flow_validate(void) {
c0d02980:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02982:	b081      	sub	sp, #4
	if (G_ux.stack_count > UX_STACK_SLOT_COUNT
c0d02984:	4d29      	ldr	r5, [pc, #164]	; (c0d02a2c <ux_flow_validate+0xac>)
c0d02986:	7828      	ldrb	r0, [r5, #0]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0) {
c0d02988:	2801      	cmp	r0, #1
c0d0298a:	d825      	bhi.n	c0d029d8 <ux_flow_validate+0x58>
c0d0298c:	1e40      	subs	r0, r0, #1
c0d0298e:	260c      	movs	r6, #12
c0d02990:	4370      	muls	r0, r6
c0d02992:	182a      	adds	r2, r5, r0
c0d02994:	8b90      	ldrh	r0, [r2, #28]
	// no flow ?
	if (!ux_flow_check_valid()
	  || G_ux.flow_stack[G_ux.stack_count-1].steps == NULL
c0d02996:	2800      	cmp	r0, #0
c0d02998:	d01e      	beq.n	c0d029d8 <ux_flow_validate+0x58>
c0d0299a:	6951      	ldr	r1, [r2, #20]
		|| G_ux.flow_stack[G_ux.stack_count-1].length == 0
c0d0299c:	2900      	cmp	r1, #0
c0d0299e:	d01b      	beq.n	c0d029d8 <ux_flow_validate+0x58>
		|| G_ux.flow_stack[G_ux.stack_count-1].index >= G_ux.flow_stack[G_ux.stack_count-1].length) {
c0d029a0:	8b12      	ldrh	r2, [r2, #24]
	if (!ux_flow_check_valid()
c0d029a2:	4282      	cmp	r2, r0
c0d029a4:	d218      	bcs.n	c0d029d8 <ux_flow_validate+0x58>
		return;
	}

	// no validation flow ?
	if (STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow != NULL) {
c0d029a6:	0090      	lsls	r0, r2, #2
c0d029a8:	5808      	ldr	r0, [r1, r0]
c0d029aa:	f7fe fecd 	bl	c0d01748 <pic>
c0d029ae:	6880      	ldr	r0, [r0, #8]
c0d029b0:	7829      	ldrb	r1, [r5, #0]
c0d029b2:	1e4c      	subs	r4, r1, #1
	}
	else {
		// if next is a barrier, then proceed to the item after the barrier
		// if NOT followed by a barrier, then validation is only performed through 
		// a validate_flow specified in the step, else ignored
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d029b4:	4366      	muls	r6, r4
	if (STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow != NULL) {
c0d029b6:	2800      	cmp	r0, #0
c0d029b8:	d010      	beq.n	c0d029dc <ux_flow_validate+0x5c>
		ux_flow_init(G_ux.stack_count-1, STEPSPIC(STEPPIC(G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index])->validate_flow), NULL);
c0d029ba:	19a8      	adds	r0, r5, r6
c0d029bc:	6941      	ldr	r1, [r0, #20]
c0d029be:	8b00      	ldrh	r0, [r0, #24]
c0d029c0:	0080      	lsls	r0, r0, #2
c0d029c2:	5808      	ldr	r0, [r1, r0]
c0d029c4:	f7fe fec0 	bl	c0d01748 <pic>
c0d029c8:	6880      	ldr	r0, [r0, #8]
c0d029ca:	f7fe febd 	bl	c0d01748 <pic>
c0d029ce:	4601      	mov	r1, r0
c0d029d0:	2200      	movs	r2, #0
c0d029d2:	4620      	mov	r0, r4
c0d029d4:	f000 f82c 	bl	c0d02a30 <ux_flow_init>
				// execute reached step
				ux_flow_engine_init_step(G_ux.stack_count-1);
			}
		}
	}
}
c0d029d8:	b001      	add	sp, #4
c0d029da:	bdf0      	pop	{r4, r5, r6, r7, pc}
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d029dc:	19a8      	adds	r0, r5, r6
c0d029de:	8b81      	ldrh	r1, [r0, #28]
			&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2) {
c0d029e0:	2900      	cmp	r1, #0
c0d029e2:	d0f9      	beq.n	c0d029d8 <ux_flow_validate+0x58>
c0d029e4:	8b05      	ldrh	r5, [r0, #24]
c0d029e6:	1e8a      	subs	r2, r1, #2
		if (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d029e8:	42aa      	cmp	r2, r5
c0d029ea:	dbf5      	blt.n	c0d029d8 <ux_flow_validate+0x58>
c0d029ec:	4601      	mov	r1, r0
c0d029ee:	3118      	adds	r1, #24
			if (G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d029f0:	6943      	ldr	r3, [r0, #20]
c0d029f2:	00ae      	lsls	r6, r5, #2
c0d029f4:	18f6      	adds	r6, r6, r3
c0d029f6:	6876      	ldr	r6, [r6, #4]
c0d029f8:	1cf7      	adds	r7, r6, #3
c0d029fa:	d010      	beq.n	c0d02a1e <ux_flow_validate+0x9e>
c0d029fc:	1cb6      	adds	r6, r6, #2
c0d029fe:	d1eb      	bne.n	c0d029d8 <ux_flow_validate+0x58>
c0d02a00:	462e      	mov	r6, r5
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d02a02:	00ad      	lsls	r5, r5, #2
c0d02a04:	18ed      	adds	r5, r5, r3
c0d02a06:	686d      	ldr	r5, [r5, #4]
				while (G_ux.flow_stack[G_ux.stack_count-1].length > 0 
c0d02a08:	1cad      	adds	r5, r5, #2
c0d02a0a:	d104      	bne.n	c0d02a16 <ux_flow_validate+0x96>
					G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d02a0c:	1c76      	adds	r6, r6, #1
c0d02a0e:	800e      	strh	r6, [r1, #0]
					&& G_ux.flow_stack[G_ux.stack_count-1].index <= G_ux.flow_stack[G_ux.stack_count-1].length - 2
c0d02a10:	b2b5      	uxth	r5, r6
					&& G_ux.flow_stack[G_ux.stack_count-1].steps[G_ux.flow_stack[G_ux.stack_count-1].index+1] == FLOW_BARRIER) {
c0d02a12:	42aa      	cmp	r2, r5
c0d02a14:	daf5      	bge.n	c0d02a02 <ux_flow_validate+0x82>
				G_ux.flow_stack[G_ux.stack_count-1].index++;
c0d02a16:	1c72      	adds	r2, r6, #1
c0d02a18:	800a      	strh	r2, [r1, #0]
				G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index;
c0d02a1a:	8346      	strh	r6, [r0, #26]
c0d02a1c:	e002      	b.n	c0d02a24 <ux_flow_validate+0xa4>
c0d02a1e:	2200      	movs	r2, #0
				G_ux.flow_stack[G_ux.stack_count-1].prev_index = G_ux.flow_stack[G_ux.stack_count-1].index = 0;
c0d02a20:	800a      	strh	r2, [r1, #0]
c0d02a22:	8342      	strh	r2, [r0, #26]
c0d02a24:	4620      	mov	r0, r4
c0d02a26:	f7ff ff6f 	bl	c0d02908 <ux_flow_engine_init_step>
c0d02a2a:	e7d5      	b.n	c0d029d8 <ux_flow_validate+0x58>
c0d02a2c:	20000200 	.word	0x20000200

c0d02a30 <ux_flow_init>:
 * Last step is marked with a FLOW_END_STEP value
 */
#define FLOW_END_STEP ((const ux_flow_step_t *)0xFFFFFFFFUL)
#define FLOW_BARRIER  ((const ux_flow_step_t *)0xFFFFFFFEUL)
#define FLOW_START    ((const ux_flow_step_t *)0xFFFFFFFDUL)
void ux_flow_init(unsigned int stack_slot, const ux_flow_step_t* const * steps, const ux_flow_step_t* const start_step) {
c0d02a30:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02a32:	b081      	sub	sp, #4
c0d02a34:	4615      	mov	r5, r2
c0d02a36:	230c      	movs	r3, #12
	G_ux.flow_stack[stack_slot].length = G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index = 0;
c0d02a38:	4343      	muls	r3, r0
c0d02a3a:	4a21      	ldr	r2, [pc, #132]	; (c0d02ac0 <ux_flow_init+0x90>)
c0d02a3c:	18d7      	adds	r7, r2, r3
c0d02a3e:	2300      	movs	r3, #0
	G_ux.flow_stack[stack_slot].steps = NULL;
c0d02a40:	83bb      	strh	r3, [r7, #28]
c0d02a42:	617b      	str	r3, [r7, #20]
c0d02a44:	61bb      	str	r3, [r7, #24]
	
	// reset paging to avoid troubles if first step is a paginated step
	memset(&G_ux.layout_paging, 0, sizeof(G_ux.layout_paging));
c0d02a46:	6053      	str	r3, [r2, #4]
c0d02a48:	6093      	str	r3, [r2, #8]
c0d02a4a:	60d3      	str	r3, [r2, #12]
c0d02a4c:	6113      	str	r3, [r2, #16]

	if (steps) {
c0d02a4e:	2900      	cmp	r1, #0
c0d02a50:	d034      	beq.n	c0d02abc <ux_flow_init+0x8c>
c0d02a52:	9000      	str	r0, [sp, #0]
c0d02a54:	463c      	mov	r4, r7
c0d02a56:	3414      	adds	r4, #20
c0d02a58:	463e      	mov	r6, r7
c0d02a5a:	361c      	adds	r6, #28
		G_ux.flow_stack[stack_slot].steps = STEPSPIC(steps);
c0d02a5c:	4608      	mov	r0, r1
c0d02a5e:	f7fe fe73 	bl	c0d01748 <pic>
c0d02a62:	6020      	str	r0, [r4, #0]
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
c0d02a64:	8831      	ldrh	r1, [r6, #0]
c0d02a66:	008a      	lsls	r2, r1, #2
c0d02a68:	5882      	ldr	r2, [r0, r2]
c0d02a6a:	1c52      	adds	r2, r2, #1
c0d02a6c:	d006      	beq.n	c0d02a7c <ux_flow_init+0x4c>
			G_ux.flow_stack[stack_slot].length++;
c0d02a6e:	1c49      	adds	r1, r1, #1
		while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].length] != FLOW_END_STEP) {
c0d02a70:	b28a      	uxth	r2, r1
c0d02a72:	0092      	lsls	r2, r2, #2
c0d02a74:	5882      	ldr	r2, [r0, r2]
c0d02a76:	1c52      	adds	r2, r2, #1
c0d02a78:	d1f9      	bne.n	c0d02a6e <ux_flow_init+0x3e>
c0d02a7a:	8031      	strh	r1, [r6, #0]
		}
		if (start_step != NULL) {
c0d02a7c:	2d00      	cmp	r5, #0
c0d02a7e:	d01a      	beq.n	c0d02ab6 <ux_flow_init+0x86>
c0d02a80:	463e      	mov	r6, r7
c0d02a82:	3618      	adds	r6, #24
			const ux_flow_step_t* const start_step2  = STEPPIC(start_step);
c0d02a84:	4628      	mov	r0, r5
c0d02a86:	f7fe fe5f 	bl	c0d01748 <pic>
c0d02a8a:	4605      	mov	r5, r0
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d02a8c:	6820      	ldr	r0, [r4, #0]
c0d02a8e:	8831      	ldrh	r1, [r6, #0]
c0d02a90:	0089      	lsls	r1, r1, #2
c0d02a92:	5840      	ldr	r0, [r0, r1]
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
c0d02a94:	1c41      	adds	r1, r0, #1
c0d02a96:	d00e      	beq.n	c0d02ab6 <ux_flow_init+0x86>
c0d02a98:	371a      	adds	r7, #26
c0d02a9a:	f7fe fe55 	bl	c0d01748 <pic>
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d02a9e:	42a8      	cmp	r0, r5
c0d02aa0:	d009      	beq.n	c0d02ab6 <ux_flow_init+0x86>
				G_ux.flow_stack[stack_slot].prev_index = G_ux.flow_stack[stack_slot].index;
c0d02aa2:	8830      	ldrh	r0, [r6, #0]
c0d02aa4:	8038      	strh	r0, [r7, #0]
				G_ux.flow_stack[stack_slot].index++;
c0d02aa6:	1c40      	adds	r0, r0, #1
c0d02aa8:	8030      	strh	r0, [r6, #0]
			while(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index] != FLOW_END_STEP
c0d02aaa:	6821      	ldr	r1, [r4, #0]
c0d02aac:	b280      	uxth	r0, r0
c0d02aae:	0080      	lsls	r0, r0, #2
c0d02ab0:	5808      	ldr	r0, [r1, r0]
				 && STEPPIC(G_ux.flow_stack[stack_slot].steps[G_ux.flow_stack[stack_slot].index]) != start_step2) {
c0d02ab2:	1c41      	adds	r1, r0, #1
c0d02ab4:	d1f1      	bne.n	c0d02a9a <ux_flow_init+0x6a>
			}
		}

		// init step
		ux_flow_engine_init_step(stack_slot);
c0d02ab6:	9800      	ldr	r0, [sp, #0]
c0d02ab8:	f7ff ff26 	bl	c0d02908 <ux_flow_engine_init_step>
	}
}
c0d02abc:	b001      	add	sp, #4
c0d02abe:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02ac0:	20000200 	.word	0x20000200

c0d02ac4 <ux_flow_button_callback>:
  if (stack_slot < UX_STACK_SLOT_COUNT) {
    memset(&G_ux.flow_stack[stack_slot], 0, sizeof(G_ux.flow_stack[stack_slot]));
  }
}

unsigned int ux_flow_button_callback(unsigned int button_mask, unsigned int button_mask_counter) {
c0d02ac4:	b580      	push	{r7, lr}
c0d02ac6:	490a      	ldr	r1, [pc, #40]	; (c0d02af0 <ux_flow_button_callback+0x2c>)
  UNUSED(button_mask_counter);
  switch(button_mask) {
c0d02ac8:	4288      	cmp	r0, r1
c0d02aca:	d008      	beq.n	c0d02ade <ux_flow_button_callback+0x1a>
c0d02acc:	4909      	ldr	r1, [pc, #36]	; (c0d02af4 <ux_flow_button_callback+0x30>)
c0d02ace:	4288      	cmp	r0, r1
c0d02ad0:	d008      	beq.n	c0d02ae4 <ux_flow_button_callback+0x20>
c0d02ad2:	4909      	ldr	r1, [pc, #36]	; (c0d02af8 <ux_flow_button_callback+0x34>)
c0d02ad4:	4288      	cmp	r0, r1
c0d02ad6:	d108      	bne.n	c0d02aea <ux_flow_button_callback+0x26>
    case BUTTON_EVT_RELEASED|BUTTON_LEFT:
      ux_flow_prev();
c0d02ad8:	f7ff fee6 	bl	c0d028a8 <ux_flow_prev>
c0d02adc:	e005      	b.n	c0d02aea <ux_flow_button_callback+0x26>
      break;
    case BUTTON_EVT_RELEASED|BUTTON_RIGHT:
      ux_flow_next();
      break;
    case BUTTON_EVT_RELEASED|BUTTON_LEFT|BUTTON_RIGHT:
      ux_flow_validate();
c0d02ade:	f7ff ff4f 	bl	c0d02980 <ux_flow_validate>
c0d02ae2:	e002      	b.n	c0d02aea <ux_flow_button_callback+0x26>
c0d02ae4:	2001      	movs	r0, #1
	ux_flow_next_internal(1);
c0d02ae6:	f7ff feaf 	bl	c0d02848 <ux_flow_next_internal>
c0d02aea:	2000      	movs	r0, #0
      break;
  }
  return 0;
c0d02aec:	bd80      	pop	{r7, pc}
c0d02aee:	46c0      	nop			; (mov r8, r8)
c0d02af0:	80000003 	.word	0x80000003
c0d02af4:	80000002 	.word	0x80000002
c0d02af8:	80000001 	.word	0x80000001

c0d02afc <ux_stack_get_step_params>:
}

void* ux_stack_get_step_params(unsigned int stack_slot) {
c0d02afc:	b510      	push	{r4, lr}
c0d02afe:	4601      	mov	r1, r0
c0d02b00:	2000      	movs	r0, #0
	if (stack_slot >= UX_STACK_SLOT_COUNT) {
c0d02b02:	2900      	cmp	r1, #0
c0d02b04:	d000      	beq.n	c0d02b08 <ux_stack_get_step_params+0xc>
	if (G_ux.flow_stack[stack_slot].index >= G_ux.flow_stack[stack_slot].length) {
		return NULL;
	}

	return (void*)PIC(STEPPIC(STEPSPIC(G_ux.flow_stack[stack_slot].steps)[G_ux.flow_stack[stack_slot].index])->params);
}
c0d02b06:	bd10      	pop	{r4, pc}
	if (G_ux.flow_stack[stack_slot].length == 0) {
c0d02b08:	4c09      	ldr	r4, [pc, #36]	; (c0d02b30 <ux_stack_get_step_params+0x34>)
c0d02b0a:	8ba1      	ldrh	r1, [r4, #28]
c0d02b0c:	2900      	cmp	r1, #0
c0d02b0e:	d0fa      	beq.n	c0d02b06 <ux_stack_get_step_params+0xa>
c0d02b10:	8b22      	ldrh	r2, [r4, #24]
c0d02b12:	428a      	cmp	r2, r1
c0d02b14:	d2f7      	bcs.n	c0d02b06 <ux_stack_get_step_params+0xa>
	return (void*)PIC(STEPPIC(STEPSPIC(G_ux.flow_stack[stack_slot].steps)[G_ux.flow_stack[stack_slot].index])->params);
c0d02b16:	6960      	ldr	r0, [r4, #20]
c0d02b18:	f7fe fe16 	bl	c0d01748 <pic>
c0d02b1c:	8b21      	ldrh	r1, [r4, #24]
c0d02b1e:	0089      	lsls	r1, r1, #2
c0d02b20:	5840      	ldr	r0, [r0, r1]
c0d02b22:	f7fe fe11 	bl	c0d01748 <pic>
c0d02b26:	6840      	ldr	r0, [r0, #4]
c0d02b28:	f7fe fe0e 	bl	c0d01748 <pic>
}
c0d02b2c:	bd10      	pop	{r4, pc}
c0d02b2e:	46c0      	nop			; (mov r8, r8)
c0d02b30:	20000200 	.word	0x20000200

c0d02b34 <ux_stack_get_current_step_params>:

void* ux_stack_get_current_step_params(void) {
c0d02b34:	b580      	push	{r7, lr}
	return ux_stack_get_step_params(G_ux.stack_count-1);
c0d02b36:	4803      	ldr	r0, [pc, #12]	; (c0d02b44 <ux_stack_get_current_step_params+0x10>)
c0d02b38:	7800      	ldrb	r0, [r0, #0]
c0d02b3a:	1e40      	subs	r0, r0, #1
c0d02b3c:	f7ff ffde 	bl	c0d02afc <ux_stack_get_step_params>
c0d02b40:	bd80      	pop	{r7, pc}
c0d02b42:	46c0      	nop			; (mov r8, r8)
c0d02b44:	20000200 	.word	0x20000200

c0d02b48 <ux_layout_bb_init_common>:
  }
  return &G_ux.tmp_element;
}
*/

void ux_layout_bb_init_common(unsigned int stack_slot) {
c0d02b48:	b510      	push	{r4, lr}
c0d02b4a:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d02b4c:	f000 f96c 	bl	c0d02e28 <ux_stack_init>
c0d02b50:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_bb_elements;
c0d02b52:	4360      	muls	r0, r4
c0d02b54:	4908      	ldr	r1, [pc, #32]	; (c0d02b78 <ux_layout_bb_init_common+0x30>)
c0d02b56:	1808      	adds	r0, r1, r0
c0d02b58:	21c8      	movs	r1, #200	; 0xc8
c0d02b5a:	2205      	movs	r2, #5
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_bb_elements);
c0d02b5c:	5442      	strb	r2, [r0, r1]
c0d02b5e:	21c4      	movs	r1, #196	; 0xc4
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_bb_elements;
c0d02b60:	4a06      	ldr	r2, [pc, #24]	; (c0d02b7c <ux_layout_bb_init_common+0x34>)
c0d02b62:	447a      	add	r2, pc
c0d02b64:	5042      	str	r2, [r0, r1]
c0d02b66:	21d4      	movs	r1, #212	; 0xd4
  G_ux.stack[stack_slot].element_arrays_count = 1;
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d02b68:	4a05      	ldr	r2, [pc, #20]	; (c0d02b80 <ux_layout_bb_init_common+0x38>)
c0d02b6a:	447a      	add	r2, pc
c0d02b6c:	5042      	str	r2, [r0, r1]
c0d02b6e:	21c1      	movs	r1, #193	; 0xc1
c0d02b70:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d02b72:	5442      	strb	r2, [r0, r1]
}
c0d02b74:	bd10      	pop	{r4, pc}
c0d02b76:	46c0      	nop			; (mov r8, r8)
c0d02b78:	20000200 	.word	0x20000200
c0d02b7c:	00000c0a 	.word	0x00000c0a
c0d02b80:	ffffff57 	.word	0xffffff57

c0d02b84 <ux_layout_bn_prepro>:
#endif
#endif
};
*/

const bagl_element_t* ux_layout_bn_prepro(const bagl_element_t* element) {
c0d02b84:	b580      	push	{r7, lr}
      G_ux.tmp_element.text = params->line2;
      break;
  }
  return &G_ux.tmp_element;
*/
  const bagl_element_t* e = ux_layout_strings_prepro(element);
c0d02b86:	f000 f8e9 	bl	c0d02d5c <ux_layout_strings_prepro>
  if (e && G_ux.tmp_element.component.userid == 0x11) {
c0d02b8a:	2800      	cmp	r0, #0
c0d02b8c:	d007      	beq.n	c0d02b9e <ux_layout_bn_prepro+0x1a>
c0d02b8e:	22a1      	movs	r2, #161	; 0xa1
c0d02b90:	4903      	ldr	r1, [pc, #12]	; (c0d02ba0 <ux_layout_bn_prepro+0x1c>)
c0d02b92:	5c8a      	ldrb	r2, [r1, r2]
c0d02b94:	2a11      	cmp	r2, #17
c0d02b96:	d102      	bne.n	c0d02b9e <ux_layout_bn_prepro+0x1a>
c0d02b98:	22b8      	movs	r2, #184	; 0xb8
c0d02b9a:	4b02      	ldr	r3, [pc, #8]	; (c0d02ba4 <ux_layout_bn_prepro+0x20>)
    G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER;
c0d02b9c:	528b      	strh	r3, [r1, r2]
  }
  return e;
c0d02b9e:	bd80      	pop	{r7, pc}
c0d02ba0:	20000200 	.word	0x20000200
c0d02ba4:	0000800a 	.word	0x0000800a

c0d02ba8 <ux_layout_bn_init>:
}

void ux_layout_bn_init(unsigned int stack_slot) { 
c0d02ba8:	b510      	push	{r4, lr}
c0d02baa:	4604      	mov	r4, r0
  ux_layout_bb_init_common(stack_slot);
c0d02bac:	f7ff ffcc 	bl	c0d02b48 <ux_layout_bb_init_common>
c0d02bb0:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_bn_prepro;
c0d02bb2:	4360      	muls	r0, r4
c0d02bb4:	4904      	ldr	r1, [pc, #16]	; (c0d02bc8 <ux_layout_bn_init+0x20>)
c0d02bb6:	1808      	adds	r0, r1, r0
c0d02bb8:	21d0      	movs	r1, #208	; 0xd0
c0d02bba:	4a04      	ldr	r2, [pc, #16]	; (c0d02bcc <ux_layout_bn_init+0x24>)
c0d02bbc:	447a      	add	r2, pc
c0d02bbe:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d02bc0:	4620      	mov	r0, r4
c0d02bc2:	f000 f90b 	bl	c0d02ddc <ux_stack_display>
}
c0d02bc6:	bd10      	pop	{r4, pc}
c0d02bc8:	20000200 	.word	0x20000200
c0d02bcc:	ffffffc5 	.word	0xffffffc5

c0d02bd0 <ux_layout_pb_prepro>:
  {{BAGL_ICON                           , 0x10,  56,  2,  16,  16, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x11,   0, 28, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px|BAGL_FONT_ALIGNMENT_CENTER, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_pb_prepro(const bagl_element_t* element) {
c0d02bd0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02bd2:	b081      	sub	sp, #4
c0d02bd4:	4606      	mov	r6, r0
  // don't display if null
  const ux_layout_pb_params_t* params = (const ux_layout_pb_params_t*)ux_stack_get_current_step_params();
c0d02bd6:	f7ff ffad 	bl	c0d02b34 <ux_stack_get_current_step_params>
c0d02bda:	4605      	mov	r5, r0

	// copy element before any mod
	memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d02bdc:	4f11      	ldr	r7, [pc, #68]	; (c0d02c24 <ux_layout_pb_prepro+0x54>)
c0d02bde:	463c      	mov	r4, r7
c0d02be0:	34a0      	adds	r4, #160	; 0xa0
c0d02be2:	2220      	movs	r2, #32
c0d02be4:	4620      	mov	r0, r4
c0d02be6:	4631      	mov	r1, r6
c0d02be8:	f000 fa37 	bl	c0d0305a <__aeabi_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d02bec:	7870      	ldrb	r0, [r6, #1]
c0d02bee:	280f      	cmp	r0, #15
c0d02bf0:	dc06      	bgt.n	c0d02c00 <ux_layout_pb_prepro+0x30>
c0d02bf2:	2801      	cmp	r0, #1
c0d02bf4:	d00d      	beq.n	c0d02c12 <ux_layout_pb_prepro+0x42>
c0d02bf6:	2802      	cmp	r0, #2
c0d02bf8:	d110      	bne.n	c0d02c1c <ux_layout_pb_prepro+0x4c>
  			return NULL;
  		}
  		break;

  	case 0x02:
  		if (ux_flow_is_last()) {
c0d02bfa:	f7ff fe05 	bl	c0d02808 <ux_flow_is_last>
c0d02bfe:	e00a      	b.n	c0d02c16 <ux_layout_pb_prepro+0x46>
  switch (element->component.userid) {
c0d02c00:	2810      	cmp	r0, #16
c0d02c02:	d002      	beq.n	c0d02c0a <ux_layout_pb_prepro+0x3a>
c0d02c04:	2811      	cmp	r0, #17
c0d02c06:	d109      	bne.n	c0d02c1c <ux_layout_pb_prepro+0x4c>
    case 0x10:
  		G_ux.tmp_element.text = (const char*)params->icon;
      break;

    case 0x11:
  		G_ux.tmp_element.text = params->line1;
c0d02c08:	1d2d      	adds	r5, r5, #4
c0d02c0a:	6828      	ldr	r0, [r5, #0]
c0d02c0c:	21bc      	movs	r1, #188	; 0xbc
c0d02c0e:	5078      	str	r0, [r7, r1]
c0d02c10:	e004      	b.n	c0d02c1c <ux_layout_pb_prepro+0x4c>
  		if (ux_flow_is_first()) {
c0d02c12:	f7ff fdd3 	bl	c0d027bc <ux_flow_is_first>
c0d02c16:	2800      	cmp	r0, #0
c0d02c18:	d000      	beq.n	c0d02c1c <ux_layout_pb_prepro+0x4c>
c0d02c1a:	2400      	movs	r4, #0
      break;
  }
  return &G_ux.tmp_element;
}
c0d02c1c:	4620      	mov	r0, r4
c0d02c1e:	b001      	add	sp, #4
c0d02c20:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02c22:	46c0      	nop			; (mov r8, r8)
c0d02c24:	20000200 	.word	0x20000200

c0d02c28 <ux_layout_pb_init>:

void ux_layout_pb_init(unsigned int stack_slot) {
c0d02c28:	b510      	push	{r4, lr}
c0d02c2a:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d02c2c:	f000 f8fc 	bl	c0d02e28 <ux_stack_init>
c0d02c30:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pb_elements;
c0d02c32:	4360      	muls	r0, r4
c0d02c34:	490b      	ldr	r1, [pc, #44]	; (c0d02c64 <ux_layout_pb_init+0x3c>)
c0d02c36:	1808      	adds	r0, r1, r0
c0d02c38:	21c8      	movs	r1, #200	; 0xc8
c0d02c3a:	2205      	movs	r2, #5
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pb_elements);
c0d02c3c:	5442      	strb	r2, [r0, r1]
c0d02c3e:	21c4      	movs	r1, #196	; 0xc4
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pb_elements;
c0d02c40:	4a09      	ldr	r2, [pc, #36]	; (c0d02c68 <ux_layout_pb_init+0x40>)
c0d02c42:	447a      	add	r2, pc
c0d02c44:	5042      	str	r2, [r0, r1]
c0d02c46:	21d4      	movs	r1, #212	; 0xd4
  G_ux.stack[stack_slot].element_arrays_count = 1;
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_pb_prepro;
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d02c48:	4a08      	ldr	r2, [pc, #32]	; (c0d02c6c <ux_layout_pb_init+0x44>)
c0d02c4a:	447a      	add	r2, pc
c0d02c4c:	5042      	str	r2, [r0, r1]
c0d02c4e:	21d0      	movs	r1, #208	; 0xd0
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_pb_prepro;
c0d02c50:	4a07      	ldr	r2, [pc, #28]	; (c0d02c70 <ux_layout_pb_init+0x48>)
c0d02c52:	447a      	add	r2, pc
c0d02c54:	5042      	str	r2, [r0, r1]
c0d02c56:	21c1      	movs	r1, #193	; 0xc1
c0d02c58:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d02c5a:	5442      	strb	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d02c5c:	4620      	mov	r0, r4
c0d02c5e:	f000 f8bd 	bl	c0d02ddc <ux_stack_display>
}
c0d02c62:	bd10      	pop	{r4, pc}
c0d02c64:	20000200 	.word	0x20000200
c0d02c68:	00000bca 	.word	0x00000bca
c0d02c6c:	fffffe77 	.word	0xfffffe77
c0d02c70:	ffffff7b 	.word	0xffffff7b

c0d02c74 <ux_layout_pbb_prepro>:
  {{BAGL_LABELINE                       , 0x10,  41,  12, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px, 0  }, NULL},
  {{BAGL_LABELINE                       , 0x11,  41,  26, 128,  32, 0, 0, 0        , 0xFFFFFF, 0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px, 0  }, NULL},
#endif // TARGET_NANOX
};

const bagl_element_t* ux_layout_pbb_prepro(const bagl_element_t* element) {
c0d02c74:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02c76:	b081      	sub	sp, #4
c0d02c78:	4606      	mov	r6, r0
  // don't display if null
  const ux_layout_icon_strings_params_t* params = (const ux_layout_icon_strings_params_t*)ux_stack_get_current_step_params();
c0d02c7a:	f7ff ff5b 	bl	c0d02b34 <ux_stack_get_current_step_params>
c0d02c7e:	4605      	mov	r5, r0

	// ocpy element before any mod
	memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d02c80:	4f14      	ldr	r7, [pc, #80]	; (c0d02cd4 <ux_layout_pbb_prepro+0x60>)
c0d02c82:	463c      	mov	r4, r7
c0d02c84:	34a0      	adds	r4, #160	; 0xa0
c0d02c86:	2220      	movs	r2, #32
c0d02c88:	4620      	mov	r0, r4
c0d02c8a:	4631      	mov	r1, r6
c0d02c8c:	f000 f9e5 	bl	c0d0305a <__aeabi_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d02c90:	7870      	ldrb	r0, [r6, #1]
c0d02c92:	280f      	cmp	r0, #15
c0d02c94:	dc06      	bgt.n	c0d02ca4 <ux_layout_pbb_prepro+0x30>
c0d02c96:	2801      	cmp	r0, #1
c0d02c98:	d011      	beq.n	c0d02cbe <ux_layout_pbb_prepro+0x4a>
c0d02c9a:	2802      	cmp	r0, #2
c0d02c9c:	d012      	beq.n	c0d02cc4 <ux_layout_pbb_prepro+0x50>
c0d02c9e:	280f      	cmp	r0, #15
c0d02ca0:	d009      	beq.n	c0d02cb6 <ux_layout_pbb_prepro+0x42>
c0d02ca2:	e014      	b.n	c0d02cce <ux_layout_pbb_prepro+0x5a>
c0d02ca4:	3810      	subs	r0, #16
c0d02ca6:	2802      	cmp	r0, #2
c0d02ca8:	d211      	bcs.n	c0d02cce <ux_layout_pbb_prepro+0x5a>
c0d02caa:	20a1      	movs	r0, #161	; 0xa1
  		G_ux.tmp_element.text = (const char*)params->icon;
      break;

    case 0x10:
    case 0x11:
      G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d02cac:	5c38      	ldrb	r0, [r7, r0]
c0d02cae:	0700      	lsls	r0, r0, #28
c0d02cb0:	0e80      	lsrs	r0, r0, #26
c0d02cb2:	1828      	adds	r0, r5, r0
c0d02cb4:	1d05      	adds	r5, r0, #4
c0d02cb6:	6828      	ldr	r0, [r5, #0]
c0d02cb8:	21bc      	movs	r1, #188	; 0xbc
c0d02cba:	5078      	str	r0, [r7, r1]
c0d02cbc:	e007      	b.n	c0d02cce <ux_layout_pbb_prepro+0x5a>
  		if (ux_flow_is_first()) {
c0d02cbe:	f7ff fd7d 	bl	c0d027bc <ux_flow_is_first>
c0d02cc2:	e001      	b.n	c0d02cc8 <ux_layout_pbb_prepro+0x54>
  		if (ux_flow_is_last()) {
c0d02cc4:	f7ff fda0 	bl	c0d02808 <ux_flow_is_last>
c0d02cc8:	2800      	cmp	r0, #0
c0d02cca:	d000      	beq.n	c0d02cce <ux_layout_pbb_prepro+0x5a>
c0d02ccc:	2400      	movs	r4, #0
      break;

  }
  return &G_ux.tmp_element;
}
c0d02cce:	4620      	mov	r0, r4
c0d02cd0:	b001      	add	sp, #4
c0d02cd2:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02cd4:	20000200 	.word	0x20000200

c0d02cd8 <ux_layout_pbb_init_common>:


void ux_layout_pbb_init_common(unsigned int stack_slot) {
c0d02cd8:	b510      	push	{r4, lr}
c0d02cda:	4604      	mov	r4, r0
  ux_stack_init(stack_slot);
c0d02cdc:	f000 f8a4 	bl	c0d02e28 <ux_stack_init>
c0d02ce0:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pbb_elements;
c0d02ce2:	4360      	muls	r0, r4
c0d02ce4:	4908      	ldr	r1, [pc, #32]	; (c0d02d08 <ux_layout_pbb_init_common+0x30>)
c0d02ce6:	1808      	adds	r0, r1, r0
c0d02ce8:	21c8      	movs	r1, #200	; 0xc8
c0d02cea:	2206      	movs	r2, #6
  G_ux.stack[stack_slot].element_arrays[0].element_array_count = ARRAYLEN(ux_layout_pbb_elements);
c0d02cec:	5442      	strb	r2, [r0, r1]
c0d02cee:	21c4      	movs	r1, #196	; 0xc4
  G_ux.stack[stack_slot].element_arrays[0].element_array = ux_layout_pbb_elements;
c0d02cf0:	4a06      	ldr	r2, [pc, #24]	; (c0d02d0c <ux_layout_pbb_init_common+0x34>)
c0d02cf2:	447a      	add	r2, pc
c0d02cf4:	5042      	str	r2, [r0, r1]
c0d02cf6:	21d4      	movs	r1, #212	; 0xd4
  G_ux.stack[stack_slot].element_arrays_count = 1;
  G_ux.stack[stack_slot].button_push_callback = ux_flow_button_callback;
c0d02cf8:	4a05      	ldr	r2, [pc, #20]	; (c0d02d10 <ux_layout_pbb_init_common+0x38>)
c0d02cfa:	447a      	add	r2, pc
c0d02cfc:	5042      	str	r2, [r0, r1]
c0d02cfe:	21c1      	movs	r1, #193	; 0xc1
c0d02d00:	2201      	movs	r2, #1
  G_ux.stack[stack_slot].element_arrays_count = 1;
c0d02d02:	5442      	strb	r2, [r0, r1]
}
c0d02d04:	bd10      	pop	{r4, pc}
c0d02d06:	46c0      	nop			; (mov r8, r8)
c0d02d08:	20000200 	.word	0x20000200
c0d02d0c:	00000bba 	.word	0x00000bba
c0d02d10:	fffffdc7 	.word	0xfffffdc7

c0d02d14 <ux_layout_pnn_prepro>:
#endif // TARGET_NANOX

};
*/

const bagl_element_t* ux_layout_pnn_prepro(const bagl_element_t* element) {
c0d02d14:	b580      	push	{r7, lr}
      G_ux.tmp_element.text = params->line2;
      break;
  }
  return &G_ux.tmp_element;
  */
  const bagl_element_t* e = ux_layout_pbb_prepro(element);
c0d02d16:	f7ff ffad 	bl	c0d02c74 <ux_layout_pbb_prepro>
  if (e && G_ux.tmp_element.component.userid >= 0x10) {
c0d02d1a:	2800      	cmp	r0, #0
c0d02d1c:	d007      	beq.n	c0d02d2e <ux_layout_pnn_prepro+0x1a>
c0d02d1e:	22a1      	movs	r2, #161	; 0xa1
c0d02d20:	4903      	ldr	r1, [pc, #12]	; (c0d02d30 <ux_layout_pnn_prepro+0x1c>)
c0d02d22:	5c8a      	ldrb	r2, [r1, r2]
c0d02d24:	2a10      	cmp	r2, #16
c0d02d26:	d302      	bcc.n	c0d02d2e <ux_layout_pnn_prepro+0x1a>
c0d02d28:	22b8      	movs	r2, #184	; 0xb8
c0d02d2a:	230a      	movs	r3, #10
    // The centering depends on the target.
#if defined(TARGET_NANOX)
    G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_REGULAR_11px|BAGL_FONT_ALIGNMENT_CENTER;
#else
    G_ux.tmp_element.component.font_id = BAGL_FONT_OPEN_SANS_REGULAR_11px;
c0d02d2c:	528b      	strh	r3, [r1, r2]
#endif // TARGET_NANOX
  }
  return e;
c0d02d2e:	bd80      	pop	{r7, pc}
c0d02d30:	20000200 	.word	0x20000200

c0d02d34 <ux_layout_pnn_init>:
}

void ux_layout_pnn_init(unsigned int stack_slot) { 
c0d02d34:	b510      	push	{r4, lr}
c0d02d36:	4604      	mov	r4, r0
  ux_layout_pbb_init_common(stack_slot);
c0d02d38:	f7ff ffce 	bl	c0d02cd8 <ux_layout_pbb_init_common>
c0d02d3c:	2024      	movs	r0, #36	; 0x24
  G_ux.stack[stack_slot].screen_before_element_display_callback = ux_layout_pnn_prepro;
c0d02d3e:	4360      	muls	r0, r4
c0d02d40:	4904      	ldr	r1, [pc, #16]	; (c0d02d54 <ux_layout_pnn_init+0x20>)
c0d02d42:	1808      	adds	r0, r1, r0
c0d02d44:	21d0      	movs	r1, #208	; 0xd0
c0d02d46:	4a04      	ldr	r2, [pc, #16]	; (c0d02d58 <ux_layout_pnn_init+0x24>)
c0d02d48:	447a      	add	r2, pc
c0d02d4a:	5042      	str	r2, [r0, r1]
  ux_stack_display(stack_slot);
c0d02d4c:	4620      	mov	r0, r4
c0d02d4e:	f000 f845 	bl	c0d02ddc <ux_stack_display>
}
c0d02d52:	bd10      	pop	{r4, pc}
c0d02d54:	20000200 	.word	0x20000200
c0d02d58:	ffffffc9 	.word	0xffffffc9

c0d02d5c <ux_layout_strings_prepro>:
    G_ux.stack[stack_slot].ticker_value = ms;
    G_ux.stack[stack_slot].ticker_interval = ms; // restart
  }
}

const bagl_element_t* ux_layout_strings_prepro(const bagl_element_t* element) {
c0d02d5c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02d5e:	b081      	sub	sp, #4
c0d02d60:	4606      	mov	r6, r0
  // don't display if null
  const ux_layout_strings_params_t* params = (const ux_layout_strings_params_t*)ux_stack_get_current_step_params();
c0d02d62:	f7ff fee7 	bl	c0d02b34 <ux_stack_get_current_step_params>
c0d02d66:	4605      	mov	r5, r0
  // ocpy element before any mod
  memmove(&G_ux.tmp_element, element, sizeof(bagl_element_t));
c0d02d68:	4f11      	ldr	r7, [pc, #68]	; (c0d02db0 <ux_layout_strings_prepro+0x54>)
c0d02d6a:	463c      	mov	r4, r7
c0d02d6c:	34a0      	adds	r4, #160	; 0xa0
c0d02d6e:	2220      	movs	r2, #32
c0d02d70:	4620      	mov	r0, r4
c0d02d72:	4631      	mov	r1, r6
c0d02d74:	f000 f971 	bl	c0d0305a <__aeabi_memmove>

  // for dashboard, setup the current application's name
  switch (element->component.userid) {
c0d02d78:	7870      	ldrb	r0, [r6, #1]
c0d02d7a:	2802      	cmp	r0, #2
c0d02d7c:	d004      	beq.n	c0d02d88 <ux_layout_strings_prepro+0x2c>
c0d02d7e:	2801      	cmp	r0, #1
c0d02d80:	d108      	bne.n	c0d02d94 <ux_layout_strings_prepro+0x38>
    case 0x01:
      if (ux_flow_is_first()) {
c0d02d82:	f7ff fd1b 	bl	c0d027bc <ux_flow_is_first>
c0d02d86:	e001      	b.n	c0d02d8c <ux_layout_strings_prepro+0x30>
        return NULL;
      }
      break;

    case 0x02:
      if (ux_flow_is_last()) {
c0d02d88:	f7ff fd3e 	bl	c0d02808 <ux_flow_is_last>
c0d02d8c:	2800      	cmp	r0, #0
c0d02d8e:	d00b      	beq.n	c0d02da8 <ux_layout_strings_prepro+0x4c>
c0d02d90:	2400      	movs	r4, #0
c0d02d92:	e009      	b.n	c0d02da8 <ux_layout_strings_prepro+0x4c>
c0d02d94:	20a1      	movs	r0, #161	; 0xa1
        return NULL;
      }
      break;

    default:
      if (G_ux.tmp_element.component.userid&0xF0) {
c0d02d96:	5c38      	ldrb	r0, [r7, r0]
c0d02d98:	0601      	lsls	r1, r0, #24
c0d02d9a:	0f09      	lsrs	r1, r1, #28
c0d02d9c:	d004      	beq.n	c0d02da8 <ux_layout_strings_prepro+0x4c>
        G_ux.tmp_element.text = params->lines[G_ux.tmp_element.component.userid&0xF];
c0d02d9e:	0700      	lsls	r0, r0, #28
c0d02da0:	0e80      	lsrs	r0, r0, #26
c0d02da2:	5828      	ldr	r0, [r5, r0]
c0d02da4:	21bc      	movs	r1, #188	; 0xbc
c0d02da6:	5078      	str	r0, [r7, r1]
      }
      break;
  }
  return &G_ux.tmp_element;
}
c0d02da8:	4620      	mov	r0, r4
c0d02daa:	b001      	add	sp, #4
c0d02dac:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02dae:	46c0      	nop			; (mov r8, r8)
c0d02db0:	20000200 	.word	0x20000200

c0d02db4 <ux_stack_push>:
    }
  }
  return 0;
}

unsigned int ux_stack_push(void) {
c0d02db4:	b510      	push	{r4, lr}
  // only push if an available slot exists
  if (G_ux.stack_count < ARRAYLEN(G_ux.stack)) {
c0d02db6:	4c08      	ldr	r4, [pc, #32]	; (c0d02dd8 <ux_stack_push+0x24>)
c0d02db8:	7820      	ldrb	r0, [r4, #0]
c0d02dba:	2800      	cmp	r0, #0
c0d02dbc:	d10a      	bne.n	c0d02dd4 <ux_stack_push+0x20>
    memset(&G_ux.stack[G_ux.stack_count], 0, sizeof(G_ux.stack[0]));
c0d02dbe:	4620      	mov	r0, r4
c0d02dc0:	30c0      	adds	r0, #192	; 0xc0
c0d02dc2:	2124      	movs	r1, #36	; 0x24
c0d02dc4:	f000 f940 	bl	c0d03048 <__aeabi_memclr>
c0d02dc8:	2000      	movs	r0, #0
#ifdef HAVE_UX_FLOW
    memset(&G_ux.flow_stack[G_ux.stack_count], 0, sizeof(G_ux.flow_stack[0]));
c0d02dca:	6160      	str	r0, [r4, #20]
c0d02dcc:	61a0      	str	r0, [r4, #24]
c0d02dce:	61e0      	str	r0, [r4, #28]
c0d02dd0:	2001      	movs	r0, #1
#endif // HAVE_UX_FLOW
    G_ux.stack_count++;
c0d02dd2:	7020      	strb	r0, [r4, #0]
  }
  // return the stack top index
  return G_ux.stack_count-1;
c0d02dd4:	1e40      	subs	r0, r0, #1
c0d02dd6:	bd10      	pop	{r4, pc}
c0d02dd8:	20000200 	.word	0x20000200

c0d02ddc <ux_stack_display>:
}
#endif // UX_STACK_SLOT_ARRAY_COUNT == 1
#endif // TARGET_NANOX

// common code for all screens
void ux_stack_display(unsigned int stack_slot) {
c0d02ddc:	b5b0      	push	{r4, r5, r7, lr}
c0d02dde:	4604      	mov	r4, r0
  // don't display any elements of a previous screen replacement
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
c0d02de0:	4810      	ldr	r0, [pc, #64]	; (c0d02e24 <ux_stack_display+0x48>)
c0d02de2:	7801      	ldrb	r1, [r0, #0]
c0d02de4:	2900      	cmp	r1, #0
c0d02de6:	d00e      	beq.n	c0d02e06 <ux_stack_display+0x2a>
c0d02de8:	1c62      	adds	r2, r4, #1
c0d02dea:	428a      	cmp	r2, r1
c0d02dec:	d10b      	bne.n	c0d02e06 <ux_stack_display+0x2a>
c0d02dee:	2124      	movs	r1, #36	; 0x24
    io_seproxyhal_init_ux();
    // at worse a redisplay of the current screen has been requested, ensure to redraw it correctly
    G_ux.stack[stack_slot].element_index = 0;
c0d02df0:	4361      	muls	r1, r4
c0d02df2:	1845      	adds	r5, r0, r1
    io_seproxyhal_init_ux();
c0d02df4:	f7fd ff52 	bl	c0d00c9c <io_seproxyhal_init_ux>
c0d02df8:	20c2      	movs	r0, #194	; 0xc2
c0d02dfa:	2100      	movs	r1, #0
    G_ux.stack[stack_slot].element_index = 0;
c0d02dfc:	5229      	strh	r1, [r5, r0]
#ifdef TARGET_NANOX
    ux_stack_display_elements(&G_ux.stack[stack_slot]); // on balenos, no need to wait for the display processed event
#else // TARGET_NANOX
    ux_stack_al_display_next_element(stack_slot);
c0d02dfe:	4620      	mov	r0, r4
c0d02e00:	f000 f822 	bl	c0d02e48 <ux_stack_al_display_next_element>
    if (G_ux.exit_code == BOLOS_UX_OK) {
      G_ux.exit_code = BOLOS_UX_REDRAW;
    }
  }
  // else don't draw (in stack insertion)
}
c0d02e04:	bdb0      	pop	{r4, r5, r7, pc}
  if(G_ux.stack_count > 0 && stack_slot+1 == G_ux.stack_count) {
c0d02e06:	424a      	negs	r2, r1
c0d02e08:	414a      	adcs	r2, r1
  else if (stack_slot == -1UL || G_ux.stack_count == 0) {
c0d02e0a:	1c61      	adds	r1, r4, #1
c0d02e0c:	424b      	negs	r3, r1
c0d02e0e:	414b      	adcs	r3, r1
c0d02e10:	4313      	orrs	r3, r2
c0d02e12:	2b01      	cmp	r3, #1
c0d02e14:	d104      	bne.n	c0d02e20 <ux_stack_display+0x44>
c0d02e16:	7841      	ldrb	r1, [r0, #1]
c0d02e18:	29aa      	cmp	r1, #170	; 0xaa
c0d02e1a:	d101      	bne.n	c0d02e20 <ux_stack_display+0x44>
c0d02e1c:	2169      	movs	r1, #105	; 0x69
      G_ux.exit_code = BOLOS_UX_REDRAW;
c0d02e1e:	7041      	strb	r1, [r0, #1]
}
c0d02e20:	bdb0      	pop	{r4, r5, r7, pc}
c0d02e22:	46c0      	nop			; (mov r8, r8)
c0d02e24:	20000200 	.word	0x20000200

c0d02e28 <ux_stack_init>:
void ux_stack_init(unsigned int stack_slot) {
c0d02e28:	b510      	push	{r4, lr}
c0d02e2a:	4604      	mov	r4, r0
  io_seproxyhal_init_ux(); // glitch upon ux_stack_display for a button being pressed in a previous screen
c0d02e2c:	f7fd ff36 	bl	c0d00c9c <io_seproxyhal_init_ux>
  if (stack_slot < UX_STACK_SLOT_COUNT) {
c0d02e30:	2c00      	cmp	r4, #0
c0d02e32:	d000      	beq.n	c0d02e36 <ux_stack_init+0xe>
}
c0d02e34:	bd10      	pop	{r4, pc}
    G_ux.stack[stack_slot].exit_code_after_elements_displayed = BOLOS_UX_CONTINUE;
c0d02e36:	4803      	ldr	r0, [pc, #12]	; (c0d02e44 <ux_stack_init+0x1c>)
c0d02e38:	30c0      	adds	r0, #192	; 0xc0
c0d02e3a:	2124      	movs	r1, #36	; 0x24
c0d02e3c:	f000 f904 	bl	c0d03048 <__aeabi_memclr>
}
c0d02e40:	bd10      	pop	{r4, pc}
c0d02e42:	46c0      	nop			; (mov r8, r8)
c0d02e44:	20000200 	.word	0x20000200

c0d02e48 <ux_stack_al_display_next_element>:
void ux_stack_al_display_next_element(unsigned int stack_slot) {
c0d02e48:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02e4a:	b081      	sub	sp, #4
c0d02e4c:	4604      	mov	r4, r0
c0d02e4e:	2004      	movs	r0, #4
  unsigned int status = os_sched_last_status(TASK_BOLOS_UX);
c0d02e50:	f7fe fd72 	bl	c0d01938 <os_sched_last_status>
  if (status != BOLOS_UX_IGNORE && status != BOLOS_UX_CONTINUE) {
c0d02e54:	2800      	cmp	r0, #0
c0d02e56:	d039      	beq.n	c0d02ecc <ux_stack_al_display_next_element+0x84>
c0d02e58:	2897      	cmp	r0, #151	; 0x97
c0d02e5a:	d037      	beq.n	c0d02ecc <ux_stack_al_display_next_element+0x84>
c0d02e5c:	2024      	movs	r0, #36	; 0x24
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d02e5e:	4360      	muls	r0, r4
c0d02e60:	491b      	ldr	r1, [pc, #108]	; (c0d02ed0 <ux_stack_al_display_next_element+0x88>)
c0d02e62:	180c      	adds	r4, r1, r0
c0d02e64:	20c4      	movs	r0, #196	; 0xc4
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d02e66:	5820      	ldr	r0, [r4, r0]
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d02e68:	2800      	cmp	r0, #0
c0d02e6a:	d02f      	beq.n	c0d02ecc <ux_stack_al_display_next_element+0x84>
c0d02e6c:	4625      	mov	r5, r4
c0d02e6e:	35d0      	adds	r5, #208	; 0xd0
c0d02e70:	4626      	mov	r6, r4
c0d02e72:	36c8      	adds	r6, #200	; 0xc8
c0d02e74:	4627      	mov	r7, r4
c0d02e76:	37c4      	adds	r7, #196	; 0xc4
c0d02e78:	34c2      	adds	r4, #194	; 0xc2
c0d02e7a:	8820      	ldrh	r0, [r4, #0]
c0d02e7c:	7831      	ldrb	r1, [r6, #0]
c0d02e7e:	b280      	uxth	r0, r0
      && ! io_seproxyhal_spi_is_status_sent()
c0d02e80:	4288      	cmp	r0, r1
c0d02e82:	d223      	bcs.n	c0d02ecc <ux_stack_al_display_next_element+0x84>
c0d02e84:	f7fe fd24 	bl	c0d018d0 <io_seph_is_status_sent>
      && (os_perso_isonboarded() != BOLOS_UX_OK || os_global_pin_is_validated() == BOLOS_UX_OK)) {
c0d02e88:	2800      	cmp	r0, #0
c0d02e8a:	d11f      	bne.n	c0d02ecc <ux_stack_al_display_next_element+0x84>
c0d02e8c:	f7fe fca8 	bl	c0d017e0 <os_perso_isonboarded>
c0d02e90:	28aa      	cmp	r0, #170	; 0xaa
c0d02e92:	d103      	bne.n	c0d02e9c <ux_stack_al_display_next_element+0x54>
c0d02e94:	f7fe fcce 	bl	c0d01834 <os_global_pin_is_validated>
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d02e98:	28aa      	cmp	r0, #170	; 0xaa
c0d02e9a:	d117      	bne.n	c0d02ecc <ux_stack_al_display_next_element+0x84>
      const bagl_element_t* element = &G_ux.stack[stack_slot].element_arrays[0].element_array[G_ux.stack[stack_slot].element_index];
c0d02e9c:	6838      	ldr	r0, [r7, #0]
c0d02e9e:	8821      	ldrh	r1, [r4, #0]
c0d02ea0:	0149      	lsls	r1, r1, #5
c0d02ea2:	1840      	adds	r0, r0, r1
      if (!G_ux.stack[stack_slot].screen_before_element_display_callback || (element = G_ux.stack[stack_slot].screen_before_element_display_callback(element)) ) {
c0d02ea4:	6829      	ldr	r1, [r5, #0]
c0d02ea6:	2900      	cmp	r1, #0
c0d02ea8:	d002      	beq.n	c0d02eb0 <ux_stack_al_display_next_element+0x68>
c0d02eaa:	4788      	blx	r1
c0d02eac:	2800      	cmp	r0, #0
c0d02eae:	d007      	beq.n	c0d02ec0 <ux_stack_al_display_next_element+0x78>
        if ((unsigned int)element == 1) { /*backward compat with coding to avoid smashing everything*/
c0d02eb0:	2801      	cmp	r0, #1
c0d02eb2:	d103      	bne.n	c0d02ebc <ux_stack_al_display_next_element+0x74>
          element = &G_ux.stack[stack_slot].element_arrays[0].element_array[G_ux.stack[stack_slot].element_index];
c0d02eb4:	6838      	ldr	r0, [r7, #0]
c0d02eb6:	8821      	ldrh	r1, [r4, #0]
c0d02eb8:	0149      	lsls	r1, r1, #5
c0d02eba:	1840      	adds	r0, r0, r1
        io_seproxyhal_display(element);
c0d02ebc:	f7fd fa20 	bl	c0d00300 <io_seproxyhal_display>
      G_ux.stack[stack_slot].element_index++;
c0d02ec0:	8820      	ldrh	r0, [r4, #0]
c0d02ec2:	1c40      	adds	r0, r0, #1
c0d02ec4:	8020      	strh	r0, [r4, #0]
    while (G_ux.stack[stack_slot].element_arrays[0].element_array
c0d02ec6:	6839      	ldr	r1, [r7, #0]
      && G_ux.stack[stack_slot].element_index < G_ux.stack[stack_slot].element_arrays[0].element_array_count
c0d02ec8:	2900      	cmp	r1, #0
c0d02eca:	d1d7      	bne.n	c0d02e7c <ux_stack_al_display_next_element+0x34>
}
c0d02ecc:	b001      	add	sp, #4
c0d02ece:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d02ed0:	20000200 	.word	0x20000200

c0d02ed4 <__udivsi3>:
c0d02ed4:	2200      	movs	r2, #0
c0d02ed6:	0843      	lsrs	r3, r0, #1
c0d02ed8:	428b      	cmp	r3, r1
c0d02eda:	d374      	bcc.n	c0d02fc6 <__udivsi3+0xf2>
c0d02edc:	0903      	lsrs	r3, r0, #4
c0d02ede:	428b      	cmp	r3, r1
c0d02ee0:	d35f      	bcc.n	c0d02fa2 <__udivsi3+0xce>
c0d02ee2:	0a03      	lsrs	r3, r0, #8
c0d02ee4:	428b      	cmp	r3, r1
c0d02ee6:	d344      	bcc.n	c0d02f72 <__udivsi3+0x9e>
c0d02ee8:	0b03      	lsrs	r3, r0, #12
c0d02eea:	428b      	cmp	r3, r1
c0d02eec:	d328      	bcc.n	c0d02f40 <__udivsi3+0x6c>
c0d02eee:	0c03      	lsrs	r3, r0, #16
c0d02ef0:	428b      	cmp	r3, r1
c0d02ef2:	d30d      	bcc.n	c0d02f10 <__udivsi3+0x3c>
c0d02ef4:	22ff      	movs	r2, #255	; 0xff
c0d02ef6:	0209      	lsls	r1, r1, #8
c0d02ef8:	ba12      	rev	r2, r2
c0d02efa:	0c03      	lsrs	r3, r0, #16
c0d02efc:	428b      	cmp	r3, r1
c0d02efe:	d302      	bcc.n	c0d02f06 <__udivsi3+0x32>
c0d02f00:	1212      	asrs	r2, r2, #8
c0d02f02:	0209      	lsls	r1, r1, #8
c0d02f04:	d065      	beq.n	c0d02fd2 <__udivsi3+0xfe>
c0d02f06:	0b03      	lsrs	r3, r0, #12
c0d02f08:	428b      	cmp	r3, r1
c0d02f0a:	d319      	bcc.n	c0d02f40 <__udivsi3+0x6c>
c0d02f0c:	e000      	b.n	c0d02f10 <__udivsi3+0x3c>
c0d02f0e:	0a09      	lsrs	r1, r1, #8
c0d02f10:	0bc3      	lsrs	r3, r0, #15
c0d02f12:	428b      	cmp	r3, r1
c0d02f14:	d301      	bcc.n	c0d02f1a <__udivsi3+0x46>
c0d02f16:	03cb      	lsls	r3, r1, #15
c0d02f18:	1ac0      	subs	r0, r0, r3
c0d02f1a:	4152      	adcs	r2, r2
c0d02f1c:	0b83      	lsrs	r3, r0, #14
c0d02f1e:	428b      	cmp	r3, r1
c0d02f20:	d301      	bcc.n	c0d02f26 <__udivsi3+0x52>
c0d02f22:	038b      	lsls	r3, r1, #14
c0d02f24:	1ac0      	subs	r0, r0, r3
c0d02f26:	4152      	adcs	r2, r2
c0d02f28:	0b43      	lsrs	r3, r0, #13
c0d02f2a:	428b      	cmp	r3, r1
c0d02f2c:	d301      	bcc.n	c0d02f32 <__udivsi3+0x5e>
c0d02f2e:	034b      	lsls	r3, r1, #13
c0d02f30:	1ac0      	subs	r0, r0, r3
c0d02f32:	4152      	adcs	r2, r2
c0d02f34:	0b03      	lsrs	r3, r0, #12
c0d02f36:	428b      	cmp	r3, r1
c0d02f38:	d301      	bcc.n	c0d02f3e <__udivsi3+0x6a>
c0d02f3a:	030b      	lsls	r3, r1, #12
c0d02f3c:	1ac0      	subs	r0, r0, r3
c0d02f3e:	4152      	adcs	r2, r2
c0d02f40:	0ac3      	lsrs	r3, r0, #11
c0d02f42:	428b      	cmp	r3, r1
c0d02f44:	d301      	bcc.n	c0d02f4a <__udivsi3+0x76>
c0d02f46:	02cb      	lsls	r3, r1, #11
c0d02f48:	1ac0      	subs	r0, r0, r3
c0d02f4a:	4152      	adcs	r2, r2
c0d02f4c:	0a83      	lsrs	r3, r0, #10
c0d02f4e:	428b      	cmp	r3, r1
c0d02f50:	d301      	bcc.n	c0d02f56 <__udivsi3+0x82>
c0d02f52:	028b      	lsls	r3, r1, #10
c0d02f54:	1ac0      	subs	r0, r0, r3
c0d02f56:	4152      	adcs	r2, r2
c0d02f58:	0a43      	lsrs	r3, r0, #9
c0d02f5a:	428b      	cmp	r3, r1
c0d02f5c:	d301      	bcc.n	c0d02f62 <__udivsi3+0x8e>
c0d02f5e:	024b      	lsls	r3, r1, #9
c0d02f60:	1ac0      	subs	r0, r0, r3
c0d02f62:	4152      	adcs	r2, r2
c0d02f64:	0a03      	lsrs	r3, r0, #8
c0d02f66:	428b      	cmp	r3, r1
c0d02f68:	d301      	bcc.n	c0d02f6e <__udivsi3+0x9a>
c0d02f6a:	020b      	lsls	r3, r1, #8
c0d02f6c:	1ac0      	subs	r0, r0, r3
c0d02f6e:	4152      	adcs	r2, r2
c0d02f70:	d2cd      	bcs.n	c0d02f0e <__udivsi3+0x3a>
c0d02f72:	09c3      	lsrs	r3, r0, #7
c0d02f74:	428b      	cmp	r3, r1
c0d02f76:	d301      	bcc.n	c0d02f7c <__udivsi3+0xa8>
c0d02f78:	01cb      	lsls	r3, r1, #7
c0d02f7a:	1ac0      	subs	r0, r0, r3
c0d02f7c:	4152      	adcs	r2, r2
c0d02f7e:	0983      	lsrs	r3, r0, #6
c0d02f80:	428b      	cmp	r3, r1
c0d02f82:	d301      	bcc.n	c0d02f88 <__udivsi3+0xb4>
c0d02f84:	018b      	lsls	r3, r1, #6
c0d02f86:	1ac0      	subs	r0, r0, r3
c0d02f88:	4152      	adcs	r2, r2
c0d02f8a:	0943      	lsrs	r3, r0, #5
c0d02f8c:	428b      	cmp	r3, r1
c0d02f8e:	d301      	bcc.n	c0d02f94 <__udivsi3+0xc0>
c0d02f90:	014b      	lsls	r3, r1, #5
c0d02f92:	1ac0      	subs	r0, r0, r3
c0d02f94:	4152      	adcs	r2, r2
c0d02f96:	0903      	lsrs	r3, r0, #4
c0d02f98:	428b      	cmp	r3, r1
c0d02f9a:	d301      	bcc.n	c0d02fa0 <__udivsi3+0xcc>
c0d02f9c:	010b      	lsls	r3, r1, #4
c0d02f9e:	1ac0      	subs	r0, r0, r3
c0d02fa0:	4152      	adcs	r2, r2
c0d02fa2:	08c3      	lsrs	r3, r0, #3
c0d02fa4:	428b      	cmp	r3, r1
c0d02fa6:	d301      	bcc.n	c0d02fac <__udivsi3+0xd8>
c0d02fa8:	00cb      	lsls	r3, r1, #3
c0d02faa:	1ac0      	subs	r0, r0, r3
c0d02fac:	4152      	adcs	r2, r2
c0d02fae:	0883      	lsrs	r3, r0, #2
c0d02fb0:	428b      	cmp	r3, r1
c0d02fb2:	d301      	bcc.n	c0d02fb8 <__udivsi3+0xe4>
c0d02fb4:	008b      	lsls	r3, r1, #2
c0d02fb6:	1ac0      	subs	r0, r0, r3
c0d02fb8:	4152      	adcs	r2, r2
c0d02fba:	0843      	lsrs	r3, r0, #1
c0d02fbc:	428b      	cmp	r3, r1
c0d02fbe:	d301      	bcc.n	c0d02fc4 <__udivsi3+0xf0>
c0d02fc0:	004b      	lsls	r3, r1, #1
c0d02fc2:	1ac0      	subs	r0, r0, r3
c0d02fc4:	4152      	adcs	r2, r2
c0d02fc6:	1a41      	subs	r1, r0, r1
c0d02fc8:	d200      	bcs.n	c0d02fcc <__udivsi3+0xf8>
c0d02fca:	4601      	mov	r1, r0
c0d02fcc:	4152      	adcs	r2, r2
c0d02fce:	4610      	mov	r0, r2
c0d02fd0:	4770      	bx	lr
c0d02fd2:	e7ff      	b.n	c0d02fd4 <__udivsi3+0x100>
c0d02fd4:	b501      	push	{r0, lr}
c0d02fd6:	2000      	movs	r0, #0
c0d02fd8:	f000 f806 	bl	c0d02fe8 <__aeabi_idiv0>
c0d02fdc:	bd02      	pop	{r1, pc}
c0d02fde:	46c0      	nop			; (mov r8, r8)

c0d02fe0 <__aeabi_uidivmod>:
c0d02fe0:	2900      	cmp	r1, #0
c0d02fe2:	d0f7      	beq.n	c0d02fd4 <__udivsi3+0x100>
c0d02fe4:	e776      	b.n	c0d02ed4 <__udivsi3>
c0d02fe6:	4770      	bx	lr

c0d02fe8 <__aeabi_idiv0>:
c0d02fe8:	4770      	bx	lr
c0d02fea:	46c0      	nop			; (mov r8, r8)

c0d02fec <__aeabi_lmul>:
c0d02fec:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02fee:	46ce      	mov	lr, r9
c0d02ff0:	4647      	mov	r7, r8
c0d02ff2:	b580      	push	{r7, lr}
c0d02ff4:	0007      	movs	r7, r0
c0d02ff6:	4699      	mov	r9, r3
c0d02ff8:	0c3b      	lsrs	r3, r7, #16
c0d02ffa:	469c      	mov	ip, r3
c0d02ffc:	0413      	lsls	r3, r2, #16
c0d02ffe:	0c1b      	lsrs	r3, r3, #16
c0d03000:	001d      	movs	r5, r3
c0d03002:	000e      	movs	r6, r1
c0d03004:	4661      	mov	r1, ip
c0d03006:	0400      	lsls	r0, r0, #16
c0d03008:	0c14      	lsrs	r4, r2, #16
c0d0300a:	0c00      	lsrs	r0, r0, #16
c0d0300c:	4345      	muls	r5, r0
c0d0300e:	434b      	muls	r3, r1
c0d03010:	4360      	muls	r0, r4
c0d03012:	4361      	muls	r1, r4
c0d03014:	18c0      	adds	r0, r0, r3
c0d03016:	0c2c      	lsrs	r4, r5, #16
c0d03018:	1820      	adds	r0, r4, r0
c0d0301a:	468c      	mov	ip, r1
c0d0301c:	4283      	cmp	r3, r0
c0d0301e:	d903      	bls.n	c0d03028 <__aeabi_lmul+0x3c>
c0d03020:	2380      	movs	r3, #128	; 0x80
c0d03022:	025b      	lsls	r3, r3, #9
c0d03024:	4698      	mov	r8, r3
c0d03026:	44c4      	add	ip, r8
c0d03028:	4649      	mov	r1, r9
c0d0302a:	4379      	muls	r1, r7
c0d0302c:	4372      	muls	r2, r6
c0d0302e:	0c03      	lsrs	r3, r0, #16
c0d03030:	4463      	add	r3, ip
c0d03032:	042d      	lsls	r5, r5, #16
c0d03034:	0c2d      	lsrs	r5, r5, #16
c0d03036:	18c9      	adds	r1, r1, r3
c0d03038:	0400      	lsls	r0, r0, #16
c0d0303a:	1940      	adds	r0, r0, r5
c0d0303c:	1889      	adds	r1, r1, r2
c0d0303e:	bcc0      	pop	{r6, r7}
c0d03040:	46b9      	mov	r9, r7
c0d03042:	46b0      	mov	r8, r6
c0d03044:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d03046:	46c0      	nop			; (mov r8, r8)

c0d03048 <__aeabi_memclr>:
c0d03048:	b510      	push	{r4, lr}
c0d0304a:	2200      	movs	r2, #0
c0d0304c:	f000 f809 	bl	c0d03062 <__aeabi_memset>
c0d03050:	bd10      	pop	{r4, pc}

c0d03052 <__aeabi_memcpy>:
c0d03052:	b510      	push	{r4, lr}
c0d03054:	f000 f810 	bl	c0d03078 <memcpy>
c0d03058:	bd10      	pop	{r4, pc}

c0d0305a <__aeabi_memmove>:
c0d0305a:	b510      	push	{r4, lr}
c0d0305c:	f000 f815 	bl	c0d0308a <memmove>
c0d03060:	bd10      	pop	{r4, pc}

c0d03062 <__aeabi_memset>:
c0d03062:	000b      	movs	r3, r1
c0d03064:	b510      	push	{r4, lr}
c0d03066:	0011      	movs	r1, r2
c0d03068:	001a      	movs	r2, r3
c0d0306a:	f000 f821 	bl	c0d030b0 <memset>
c0d0306e:	bd10      	pop	{r4, pc}

c0d03070 <explicit_bzero>:
c0d03070:	b510      	push	{r4, lr}
c0d03072:	f000 f846 	bl	c0d03102 <bzero>
c0d03076:	bd10      	pop	{r4, pc}

c0d03078 <memcpy>:
c0d03078:	2300      	movs	r3, #0
c0d0307a:	b510      	push	{r4, lr}
c0d0307c:	429a      	cmp	r2, r3
c0d0307e:	d100      	bne.n	c0d03082 <memcpy+0xa>
c0d03080:	bd10      	pop	{r4, pc}
c0d03082:	5ccc      	ldrb	r4, [r1, r3]
c0d03084:	54c4      	strb	r4, [r0, r3]
c0d03086:	3301      	adds	r3, #1
c0d03088:	e7f8      	b.n	c0d0307c <memcpy+0x4>

c0d0308a <memmove>:
c0d0308a:	b510      	push	{r4, lr}
c0d0308c:	4288      	cmp	r0, r1
c0d0308e:	d902      	bls.n	c0d03096 <memmove+0xc>
c0d03090:	188b      	adds	r3, r1, r2
c0d03092:	4298      	cmp	r0, r3
c0d03094:	d303      	bcc.n	c0d0309e <memmove+0x14>
c0d03096:	2300      	movs	r3, #0
c0d03098:	e007      	b.n	c0d030aa <memmove+0x20>
c0d0309a:	5c8b      	ldrb	r3, [r1, r2]
c0d0309c:	5483      	strb	r3, [r0, r2]
c0d0309e:	3a01      	subs	r2, #1
c0d030a0:	d2fb      	bcs.n	c0d0309a <memmove+0x10>
c0d030a2:	bd10      	pop	{r4, pc}
c0d030a4:	5ccc      	ldrb	r4, [r1, r3]
c0d030a6:	54c4      	strb	r4, [r0, r3]
c0d030a8:	3301      	adds	r3, #1
c0d030aa:	429a      	cmp	r2, r3
c0d030ac:	d1fa      	bne.n	c0d030a4 <memmove+0x1a>
c0d030ae:	e7f8      	b.n	c0d030a2 <memmove+0x18>

c0d030b0 <memset>:
c0d030b0:	0003      	movs	r3, r0
c0d030b2:	1882      	adds	r2, r0, r2
c0d030b4:	4293      	cmp	r3, r2
c0d030b6:	d100      	bne.n	c0d030ba <memset+0xa>
c0d030b8:	4770      	bx	lr
c0d030ba:	7019      	strb	r1, [r3, #0]
c0d030bc:	3301      	adds	r3, #1
c0d030be:	e7f9      	b.n	c0d030b4 <memset+0x4>

c0d030c0 <setjmp>:
c0d030c0:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d030c2:	4641      	mov	r1, r8
c0d030c4:	464a      	mov	r2, r9
c0d030c6:	4653      	mov	r3, sl
c0d030c8:	465c      	mov	r4, fp
c0d030ca:	466d      	mov	r5, sp
c0d030cc:	4676      	mov	r6, lr
c0d030ce:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d030d0:	3828      	subs	r0, #40	; 0x28
c0d030d2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d030d4:	2000      	movs	r0, #0
c0d030d6:	4770      	bx	lr

c0d030d8 <longjmp>:
c0d030d8:	3010      	adds	r0, #16
c0d030da:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d030dc:	4690      	mov	r8, r2
c0d030de:	4699      	mov	r9, r3
c0d030e0:	46a2      	mov	sl, r4
c0d030e2:	46ab      	mov	fp, r5
c0d030e4:	46b5      	mov	sp, r6
c0d030e6:	c808      	ldmia	r0!, {r3}
c0d030e8:	3828      	subs	r0, #40	; 0x28
c0d030ea:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d030ec:	0008      	movs	r0, r1
c0d030ee:	d100      	bne.n	c0d030f2 <longjmp+0x1a>
c0d030f0:	2001      	movs	r0, #1
c0d030f2:	4718      	bx	r3

c0d030f4 <strlen>:
c0d030f4:	2300      	movs	r3, #0
c0d030f6:	5cc2      	ldrb	r2, [r0, r3]
c0d030f8:	3301      	adds	r3, #1
c0d030fa:	2a00      	cmp	r2, #0
c0d030fc:	d1fb      	bne.n	c0d030f6 <strlen+0x2>
c0d030fe:	1e58      	subs	r0, r3, #1
c0d03100:	4770      	bx	lr

c0d03102 <bzero>:
c0d03102:	b510      	push	{r4, lr}
c0d03104:	000a      	movs	r2, r1
c0d03106:	2100      	movs	r1, #0
c0d03108:	f7ff ffd2 	bl	c0d030b0 <memset>
c0d0310c:	bd10      	pop	{r4, pc}
c0d0310e:	0000      	movs	r0, r0
c0d03110:	656e6547 	.word	0x656e6547
c0d03114:	65746172 	.word	0x65746172
c0d03118:	62755020 	.word	0x62755020
c0d0311c:	0063696c 	.word	0x0063696c
c0d03120:	2079654b 	.word	0x2079654b
c0d03124:	0000003f 	.word	0x0000003f

c0d03128 <ui_getPublicKey_approve>:
c0d03128:	00000003 00800000 00000020 00000001     ........ .......
c0d03138:	00000000 00ffffff 00000000 00000000     ................
c0d03148:	00030005 0007000c 00000007 00000000     ................
c0d03158:	00ffffff 00000000 00070000 00000000     ................
c0d03168:	00750005 0008000d 00000006 00000000     ..u.............
c0d03178:	00ffffff 00000000 00060000 00000000     ................
c0d03188:	00000007 0080000c 0000000c 00000000     ................
c0d03198:	00ffffff 00000000 0000800a 2000030e     ............... 
c0d031a8:	00000007 0080001a 0000000c 00000000     ................
c0d031b8:	00ffffff 00000000 0000800a 20000336     ............6.. 
c0d031c8:	74616857 6c206120 6c65766f 75622079     What a lovely bu
c0d031d8:	72656666 25200a3a 20482a2e 49000a0a     ffer:. %.*H ...I
c0d031e8:	65727020 20726566 6c207469 7265776f      prefer it lower
c0d031f8:	7361632d 0a3a6465 2a2e2520 000a2068     -cased:. %.*h ..

c0d03208 <C_icon_back_colors>:
c0d03208:	00000000 00ffffff                       ........

c0d03210 <C_icon_back_bitmap>:
c0d03210:	c1fe01e0 067f38fd c4ff81df bcfff37f     .....8..........
c0d03220:	f1e7e71f 7807f83f 00000000              ....?..x....

c0d0322c <C_icon_back>:
c0d0322c:	0000000e 0000000e 00000001 c0d03208     .............2..
c0d0323c:	c0d03210                                .2..

c0d03240 <C_icon_dashboard_colors>:
c0d03240:	00000000 00ffffff                       ........

c0d03248 <C_icon_dashboard_bitmap>:
c0d03248:	c1fe01e0 067038ff 9e7e79d8 b9e7e79f     .....8p..y~.....
c0d03258:	f1c0e601 7807f83f 00000000              ....?..x....

c0d03264 <C_icon_dashboard>:
c0d03264:	0000000e 0000000e 00000001 c0d03240     ............@2..
c0d03274:	c0d03248                                H2..

c0d03278 <C_icon_left_colors>:
c0d03278:	00000000 00ffffff                       ........

c0d03280 <C_icon_left_bitmap>:
c0d03280:	08421248                                H.B.

c0d03284 <C_icon_left>:
c0d03284:	00000004 00000007 00000001 c0d03278     ............x2..
c0d03294:	c0d03280                                .2..

c0d03298 <C_icon_right_colors>:
c0d03298:	00000000 00ffffff                       ........

c0d032a0 <C_icon_right_bitmap>:
c0d032a0:	01248421                                !.$.

c0d032a4 <C_icon_right>:
c0d032a4:	00000004 00000007 00000001 c0d03298     .............2..
c0d032b4:	c0d032a0                                .2..

c0d032b8 <C_icon_up_colors>:
c0d032b8:	00000000 00ffffff                       ........

c0d032c0 <C_icon_up_bitmap>:
c0d032c0:	08288a08                                ..(.

c0d032c4 <C_icon_up>:
c0d032c4:	00000007 00000004 00000001 c0d032b8     .............2..
c0d032d4:	c0d032c0 68637241 69687465 73690063     .2..Archethic.is
c0d032e4:	61655220 56007964 69737265 31006e6f      Ready.Version.1
c0d032f4:	312e302e 6f624100 51007475 00746975     .0.1.About.Quit.
c0d03304:	68637241 69687465 70412063 63280070     Archethic App.(c
c0d03314:	30322029 55203232 6972696e 61420073     ) 2022 Uniris.Ba
c0d03324:	00006b63                                ck..

c0d03328 <ux_menu_ready_step_val>:
c0d03328:	00000000 c0d032d8 c0d032e2              .....2...2..

c0d03334 <ux_menu_ready_step>:
c0d03334:	c0d02d35 c0d03328 00000000 00000000     5-..(3..........

c0d03344 <ux_menu_version_step_val>:
c0d03344:	c0d032eb c0d032f3                       .2...2..

c0d0334c <ux_menu_version_step>:
c0d0334c:	c0d02ba9 c0d03344 00000000 00000000     .+..D3..........

c0d0335c <ux_menu_about_step_validate_step>:
c0d0335c:	c0d009ed 00000000 00000000 00000000     ................

c0d0336c <ux_menu_about_step_validate>:
c0d0336c:	c0d0335c ffffffff                       \3......

c0d03374 <ux_menu_about_step_val>:
c0d03374:	c0d032c4 c0d032f9                       .2...2..

c0d0337c <ux_menu_about_step>:
c0d0337c:	c0d02c29 c0d03374 c0d0336c 00000000     ),..t3..l3......

c0d0338c <ux_menu_exit_step_validate_step>:
c0d0338c:	c0d00a01 00000000 00000000 00000000     ................

c0d0339c <ux_menu_exit_step_validate>:
c0d0339c:	c0d0338c ffffffff                       .3......

c0d033a4 <ux_menu_exit_step_val>:
c0d033a4:	c0d03264 c0d032ff                       d2...2..

c0d033ac <ux_menu_exit_step>:
c0d033ac:	c0d02c29 c0d033a4 c0d0339c 00000000     ),...3...3......

c0d033bc <ux_menu_main_flow>:
c0d033bc:	c0d03334 c0d0334c c0d0337c c0d033ac     43..L3..|3...3..
c0d033cc:	fffffffd ffffffff                       ........

c0d033d4 <ux_menu_info_step_val>:
c0d033d4:	c0d03304 c0d03312                       .3...3..

c0d033dc <ux_menu_info_step>:
c0d033dc:	c0d02ba9 c0d033d4 00000000 00000000     .+...3..........

c0d033ec <ux_menu_back_step_validate_step>:
c0d033ec:	c0d00a31 00000000 00000000 00000000     1...............

c0d033fc <ux_menu_back_step_validate>:
c0d033fc:	c0d033ec ffffffff                       .3......

c0d03404 <ux_menu_back_step_val>:
c0d03404:	c0d0322c c0d03322                       ,2.."3..

c0d0340c <ux_menu_back_step>:
c0d0340c:	c0d02c29 c0d03404 c0d033fc 00000000     ),...4...3......

c0d0341c <ux_menu_about_flow>:
c0d0341c:	c0d033dc c0d0340c fffffffd ffffffff     .3...4..........
c0d0342c:	65637865 6f697470 64255b6e 4c203a5d     exception[%d]: L
c0d0343c:	78303d52 58383025                        R=0x%08X..

c0d03446 <seph_io_general_status>:
c0d03446:	00020060 45002000 524f5252               `.... .ERROR.

c0d03453 <g_pcHex>:
c0d03453:	33323130 37363534 62613938 66656463     0123456789abcdef

c0d03463 <g_pcHex_cap>:
c0d03463:	33323130 37363534 42413938 46454443     0123456789ABCDEF
	...

c0d03474 <USBD_HID_Desc>:
c0d03474:	01112109 22220100                        .!...."".

c0d0347d <HID_ReportDesc>:
c0d0347d:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d0348d:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d0349d:	                                         ..

c0d0349f <C_usb_bos>:
c0d0349f:	00390f05 05101802 08b63800 a009a934     ..9......8..4...
c0d034af:	a0fd8b47 b6158876 1e010065 05101c00     G...v...e.......
c0d034bf:	dd60df00 c74589d8 65d29c4c 8a649e9d     ..`...E.L..e..d.
c0d034cf:	0300009f 7700b206                        .......w.

c0d034d8 <HID_Desc>:
c0d034d8:	c0d025a1 c0d025b1 c0d025c1 c0d025d1     .%...%...%...%..
c0d034e8:	c0d025e1 c0d025f1 c0d02601 c0d02611     .%...%...&...&..

c0d034f8 <C_winusb_string_descriptor>:
c0d034f8:	004d0312 00460053 00310054 00300030     ..M.S.F.T.1.0.0.
c0d03508:	                                         w.

c0d0350a <C_winusb_guid>:
c0d0350a:	00000092 00050100 00880001 00070000     ................
c0d0351a:	002a0000 00650044 00690076 00650063     ..*.D.e.v.i.c.e.
c0d0352a:	006e0049 00650074 00660072 00630061     I.n.t.e.r.f.a.c.
c0d0353a:	00470065 00490055 00730044 00500000     e.G.U.I.D.s...P.
c0d0354a:	007b0000 00330031 00360064 00340033     ..{.1.3.d.6.3.4.
c0d0355a:	00300030 0032002d 00390043 002d0037     0.0.-.2.C.9.7.-.
c0d0356a:	00300030 00340030 0030002d 00300030     0.0.0.4.-.0.0.0.
c0d0357a:	002d0030 00630034 00350036 00340036     0.-.4.c.6.5.6.4.
c0d0358a:	00370036 00350036 00320037 0000007d     6.7.6.5.7.2.}...
	...

c0d0359c <C_winusb_request_descriptor>:
c0d0359c:	0000000a 06030000 000800b2 00000001     ................
c0d035ac:	000800a8 00010002 001400a0 49570003     ..............WI
c0d035bc:	4253554e 00000000 00000000 00840000     NUSB............
c0d035cc:	00070004 0044002a 00760065 00630069     ....*.D.e.v.i.c.
c0d035dc:	00490065 0074006e 00720065 00610066     e.I.n.t.e.r.f.a.
c0d035ec:	00650063 00550047 00440049 00000073     c.e.G.U.I.D.s...
c0d035fc:	007b0050 00450043 00300038 00320039     P.{.C.E.8.0.9.2.
c0d0360c:	00340036 0034002d 00320042 002d0034     6.4.-.4.B.2.4.-.
c0d0361c:	00450034 00310038 0041002d 00420038     4.E.8.1.-.A.8.B.
c0d0362c:	002d0032 00370035 00440045 00310030     2.-.5.7.E.D.0.1.
c0d0363c:	00350044 00300038 00310045 0000007d     D.5.8.0.E.1.}...
c0d0364c:	00000000                                ....

c0d03650 <USBD_HID>:
c0d03650:	c0d0241d c0d0244f c0d02389 00000000     .$..O$...#......
c0d03660:	00000000 c0d024a5 c0d024bd 00000000     .....$...$......
	...
c0d03678:	c0d02719 c0d02719 c0d02719 c0d02729     .'...'...'..)'..

c0d03688 <USBD_WEBUSB>:
c0d03688:	c0d02509 c0d02535 c0d02539 00000000     .%..5%..9%......
c0d03698:	00000000 c0d0253d c0d02555 00000000     ....=%..U%......
	...
c0d036b0:	c0d02719 c0d02719 c0d02719 c0d02729     .'...'...'..)'..

c0d036c0 <USBD_DeviceDesc>:
c0d036c0:	02100112 40000000 10112c97 02010201     .......@.,......
c0d036d0:	                                         ..

c0d036d2 <USBD_LangIDDesc>:
c0d036d2:	04090304                                ....

c0d036d6 <USBD_MANUFACTURER_STRING>:
c0d036d6:	004c030e 00640065 00650067               ..L.e.d.g.e.r.

c0d036e4 <USBD_PRODUCT_FS_STRING>:
c0d036e4:	004e030e 006e0061 0020006f               ..N.a.n.o. .S.

c0d036f2 <USB_SERIAL_STRING>:
c0d036f2:	0030030a 00300030                        ..0.0.0.1.

c0d036fc <C_winusb_wcid>:
c0d036fc:	00000028 00040100 00000001 00000000     (...............
c0d0370c:	49570101 4253554e 00000000 00000000     ..WINUSB........
	...

c0d03724 <USBD_CfgDesc>:
c0d03724:	00400209 c0020102 00040932 00030200     ..@.....2.......
c0d03734:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d03744:	05070100 00400302 01040901 ffff0200     ......@.........
c0d03754:	050702ff 00400383 03050701 01004003     ......@......@..

c0d03764 <USBD_DeviceQualifierDesc>:
c0d03764:	0200060a 40000000 00000001              .......@....

c0d03770 <ux_layout_bb_elements>:
c0d03770:	00000003 00800000 00000020 00000001     ........ .......
c0d03780:	00000000 00ffffff 00000000 00000000     ................
c0d03790:	00020105 0004000c 00000007 00000000     ................
c0d037a0:	00ffffff 00000000 00000000 c0d03284     .............2..
c0d037b0:	007a0205 0004000c 00000007 00000000     ..z.............
c0d037c0:	00ffffff 00000000 00000000 c0d032a4     .............2..
c0d037d0:	00061007 0074000c 00000020 00000000     ......t. .......
c0d037e0:	00ffffff 00000000 00008008 00000000     ................
c0d037f0:	00061107 0074001a 00000020 00000000     ......t. .......
c0d03800:	00ffffff 00000000 00008008 00000000     ................

c0d03810 <ux_layout_pb_elements>:
c0d03810:	00000003 00800000 00000020 00000001     ........ .......
c0d03820:	00000000 00ffffff 00000000 00000000     ................
c0d03830:	00020105 0004000c 00000007 00000000     ................
c0d03840:	00ffffff 00000000 00000000 c0d03284     .............2..
c0d03850:	007a0205 0004000c 00000007 00000000     ..z.............
c0d03860:	00ffffff 00000000 00000000 c0d032a4     .............2..
c0d03870:	00381005 00100002 00000010 00000000     ..8.............
c0d03880:	00ffffff 00000000 0000800a 00000000     ................
c0d03890:	00001107 0080001c 00000020 00000000     ........ .......
c0d038a0:	00ffffff 00000000 00008008 00000000     ................

c0d038b0 <ux_layout_pbb_elements>:
c0d038b0:	00000003 00800000 00000020 00000001     ........ .......
c0d038c0:	00000000 00ffffff 00000000 00000000     ................
c0d038d0:	00020105 0004000c 00000007 00000000     ................
c0d038e0:	00ffffff 00000000 00000000 c0d03284     .............2..
c0d038f0:	007a0205 0004000c 00000007 00000000     ..z.............
c0d03900:	00ffffff 00000000 00000000 c0d032a4     .............2..
c0d03910:	00100f05 00100008 00000010 00000000     ................
c0d03920:	00ffffff 00000000 00000000 00000000     ................
c0d03930:	00291007 0080000c 00000020 00000000     ..)..... .......
c0d03940:	00ffffff 00000000 00000008 00000000     ................
c0d03950:	00291107 0080001a 00000020 00000000     ..)..... .......
c0d03960:	00ffffff 00000000 00000008 00000000     ................

c0d03970 <_etext>:
	...
