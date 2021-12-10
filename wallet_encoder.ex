# Archethic Onchain Wallet Generator and Encoder, using V1 specifications from https://hackmd.io/@219_ne6IRI6utatg6Fc8ZA/B1g0TU0uK

origin_public_key = "04523f9d4068555b8c30bd03507f8c4e454a399b39885555dba91477b3640047cbfb8201d11567faa7956b41bb4b7f207a0fd1641d77f32f53ed9f38b7ecff12fb"

{_ok, ledger} = Base.decode16(origin_public_key, case: :lower)

{_ok, version} = Base.decode16("01")
master_seed = :crypto.strong_rand_bytes(32)
{_ok, total_services} = Base.decode16("01")

{_ok, coin_type} = Base.decode16("028A")
{_ok, account} = Base.decode16("0000")
bip44 =  coin_type <> account
{_ok, wallet_curve} = Base.decode16("02")

{_ok, ecdh_curve} = Base.decode16("02")
curve = :secp256k1


IO.puts("\n----------------------------------------------------")


IO.puts("\nMaster Seed for Onchain Wallet (32 bytes)")
IO.puts(Base.encode16(master_seed))

IO.puts("\nBIP44 Path (4 bytes): [Coin type = 650, account = 0]")
IO.puts(Base.encode16(bip44))

IO.puts("\nWallet Curve (0:ed25519, 1:nistp256, 2:secp256k1): ")
IO.puts(Base.encode16(wallet_curve))

encoded_wallet = version <> master_seed <> total_services <> bip44 <> wallet_curve

IO.puts("\nEncoded Wallet (version, master seed, number of services, bip44, wallet curve):")
IO.puts(Base.encode16(encoded_wallet))


IO.puts("\n----------------------------------------------------")


wallet_encryption_key = :crypto.strong_rand_bytes(32)
IO.puts("\nWallet Key (AES256 CTR) for encrypting Onchain Wallet (32 bytes)")
IO.puts(Base.encode16(wallet_encryption_key))

<<wallet_encryption_iv::binary-size(16), _reserved::binary-size(16)>>= :crypto.hash(:sha256, :crypto.hash(:sha256, wallet_encryption_key))
IO.puts("\nIV encrypting Onchain Wallet (SHA256(SHA256(Wallet Key)))[0:16]")
IO.puts(Base.encode16(wallet_encryption_iv))

encrypted_wallet = :crypto.crypto_one_time(:aes_256_ctr, wallet_encryption_key, wallet_encryption_iv, encoded_wallet, true)
IO.puts("\nEncryption of Encoded Wallet (AES256 CTR):")
IO.puts(Base.encode16(encrypted_wallet))

IO.puts("\n----------------------------------------------------")

IO.puts("\nECDH Curve (0:ed25519, 1:nistp256, 2:secp256k1): ")
IO.puts(Base.encode16(ecdh_curve))

IO.puts("\nEphemeral Public Key")
{ephemeral_pubkey, ephemeral_privkey} = :crypto.generate_key(:ecdh, curve)
IO.puts(Base.encode16(ephemeral_pubkey))

IO.puts("\nOrigin Device Public Key")
IO.puts(Base.encode16(ledger))

ecdh=:crypto.compute_key(:ecdh, ledger, ephemeral_privkey, curve)
IO.puts("\nECDH Point x: ECDH(Origin Device Public Key, Ephemeral Private Key)")
IO.puts(Base.encode16(ecdh))

IO.puts("\n----------------------------------------------------")

<<aes_key::binary-size(32), iv::binary-size(16), auth_seed::binary-size(16)>> = :crypto.hash(:sha512, :crypto.hash(:sha512, ecdh))

IO.puts("\nAES256 CBC Key: SHA512(SHA512(ECDH Point x))[0:32]")
IO.puts(Base.encode16(aes_key))

IO.puts("\nIV: SHA512(SHA512(ECDH Point x))[32:48]")
IO.puts(Base.encode16(iv))

encrypted_wallet_key = :crypto.crypto_one_time(:aes_256_cbc, aes_key, iv, wallet_encryption_key, true)
IO.puts("\nEncryption of Wallet Key (AES256 CBC):")
IO.puts(Base.encode16(encrypted_wallet_key))

IO.puts("\n----------------------------------------------------")

IO.puts("\nAuthentication Seed: SHA512(SHA512(ECDH Point x))[48:64]")
IO.puts(Base.encode16(auth_seed))

auth_key = :crypto.hash(:sha256, auth_seed)
IO.puts("\nAuthentication Key: SHA256(Authentication Seed)")
IO.puts(Base.encode16(auth_key))

<<auth_tag::binary-size(16), _reserved::binary-size(16)>> = :crypto.hmac(:sha256, auth_key, encrypted_wallet_key)
IO.puts("\nAuthentication Tag: HMAC256(Authentication Key, Encrypted Wallet Key)[0:16]")
IO.puts(Base.encode16(auth_tag))

IO.puts("\n----------------------------------------------------")

encoded_wallet_key = ephemeral_pubkey <> auth_tag <> encrypted_wallet_key
IO.puts("\nEncoding of Encrypted Wallet Key(ephemeral public key, authentication tag, encrypted wallet key):")
IO.puts(Base.encode16(encoded_wallet_key))

IO.puts("\n----------------------------------------------------")

{_ok, address_header} = Base.decode16("E0040000")
payload = encoded_wallet_key <> encrypted_wallet
{_ok, lc} = Base.decode16(Integer.to_string(byte_size(payload), 16))
address_apdu = address_header <> lc <> payload
IO.puts("\nAddress APDU:")
IO.puts(Base.encode16(address_apdu))

{_ok, sign_header} = Base.decode16("E0080000")
tx_hash = :crypto.hash(:sha256, "ARCHETHIC")
payload = tx_hash <> payload
{_ok, lc} = Base.decode16(Integer.to_string(byte_size(payload), 16))
sign_apdu = sign_header <> lc <> payload
IO.puts("\nSign APDU:")
IO.puts(Base.encode16(sign_apdu))

# elixir verify
# public_key = Base.decode16!("", case: :lower)
# sign = Base.decode16!("", case: :lower)
# :crypto.verify(:ecdsa, :sha256, "archethic", sign, [public_key, :secp256k1])
