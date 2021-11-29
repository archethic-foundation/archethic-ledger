# Archethic Onchain Wallet Generator and Encoder, using V1 specifications from https://hackmd.io/@219_ne6IRI6utatg6Fc8ZA/B1g0TU0uK

origin_public_key = "04523f9d4068555b8c30bd03507f8c4e454a399b39885555dba91477b3640047cbfb8201d11567faa7956b41bb4b7f207a0fd1641d77f32f53ed9f38b7ecff12fb"
{_ok, ledger} = Base.decode16(origin_public_key, case: :lower)

{_ok, version} = Base.decode16("01")
master_seed = :crypto.strong_rand_bytes(32)
{_ok, total_services} = Base.decode16("01")

{_ok, coin_type} = Base.decode16("028A")
{_ok, account} = Base.decode16("0000")
bip44 =  coin_type <> account 
{_ok, wallet_curve} = Base.decode16("00")

{_ok, ecdh_curve} = Base.decode16("00")
curve = :secp256k1


IO.puts("\n----------------------------------------------------")


IO.puts("\nMaster Seed for Onchain Wallet (32 bytes)")
IO.puts(Base.encode16(master_seed))

IO.puts("\nBIP44 Path (4 bytes): [Coin type = 650, account = 0]")
IO.puts(Base.encode16(bip44))

IO.puts("\nWallet Curve (0:secp256k1, 1:nistp256, 2:ed25519): ")
IO.puts(Base.encode16(wallet_curve))

encoded_wallet = version <> master_seed <> total_services <> bip44 <> wallet_curve

IO.puts("\nEncoded Wallet (version, master seed, number of services, bip44, wallet curve):")
IO.puts(Base.encode16(encoded_wallet))


IO.puts("\n----------------------------------------------------")


IO.puts("\nECDH Curve (0:secp256k1, 1:nistp256, 2:ed25519): ")
IO.puts(Base.encode16(ecdh_curve))

IO.puts("\nEphemeral Public Key")
{ephemeral_pubkey, ephemeral_privkey} = :crypto.generate_key(:ecdh, curve)
IO.puts(Base.encode16(ephemeral_pubkey))

IO.puts("\nOrigin Device Public Key")
IO.puts(Base.encode16(ledger))

ecdh=:crypto.compute_key(:ecdh, ledger, ephemeral_privkey, curve)
IO.puts("\nECDH Point x: ECDH(Origin Device Public Key, Ephemeral Private Key)")
IO.puts(Base.encode16(ecdh))

hmac_key = :crypto.hash(:sha512, ecdh)
IO.puts("\nHmac Key: SHA512(ECDH Point x)")
IO.puts(Base.encode16(hmac_key))

<<aes_key::binary-size(32), iv::binary-size(16), _future::binary>>= :crypto.hmac(:sha512, hmac_key, ledger)
IO.puts("\nAES Key: Hmac512(Hmac Key, Origin Device Public Key)[0:32]")
IO.puts(Base.encode16(aes_key))

IO.puts("\nIV: Hmac512(Hmac Key, Origin Device Public Key)[32:48]")
IO.puts(Base.encode16(iv))

IO.puts("\n----------------------------------------------------")

encrypted_wallet = :crypto.crypto_one_time(:aes_256_ctr, aes_key, iv, encoded_wallet, true)
IO.puts("\nEncryption of Encoded Wallet (AES256 CTR):")
IO.puts(Base.encode16(encrypted_wallet))

final_wallet = ecdh_curve <> ephemeral_pubkey <> encrypted_wallet
IO.puts("\nFinal Encoding of Encrypted Wallet (ecdh curve, ephemeral public key, encrypted wallet):")
IO.puts(Base.encode16(final_wallet))
