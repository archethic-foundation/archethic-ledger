# *******************************************************************************
#   Archethic Ledger Bolos App
#   (c) 2022 Varun Deshpande, Uniris
#
#  Licensed under the GNU Affero General Public License, Version 3 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      https://www.gnu.org/licenses/agpl-3.0.en.html
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# *******************************************************************************

# Archethic Onchain Wallet Generator and Encoder, using V1 specifications from https://hackmd.io/@219_ne6IRI6utatg6Fc8ZA/B1g0TU0uK

# origin_public_key = "04523f9d4068555b8c30bd03507f8c4e454a399b39885555dba91477b3640047cbfb8201d11567faa7956b41bb4b7f207a0fd1641d77f32f53ed9f38b7ecff12fb"
# Ledger Origin Public Key with seed: 6fa774718b0f086101e7a0bf43f81944f2eea0392bc3452ac314cc444f19978989c62be4110f8fd3e543875e9f3fe2e2240f554cf16cfebf673b112ac44ec016
origin_public_key =
  "0456adc116763f07b1cdc6ec8e2453fcb5f67ddd96123c0b4955d7bf82eab20ff190f871f3c514d2e81391c7ff314f0f18d38899ec43a7085abe2bd90b0d147f30"

{_ok, ledger} = Base.decode16(origin_public_key, case: :lower)

# Version is 4 Bytes
{_ok, version} = Base.decode16("00000001")

master_seed = :crypto.strong_rand_bytes(32)

# {_ok, master_seed_length} =
#   master_seed |> :erlang.byte_size() |> Integer.to_string() |> Base.encode16(case: :upper)

{_ok, master_seed_length} = Base.decode16("20")

{_ok, total_services} = Base.decode16("01")

{_ok, service_name_length} = Base.decode16("03")

# Convert String to Hex?
service_name = "uco"
# {_ok, service_name} = Base.encode16("uco", case: :upper )

# {_ok, derivation_path_length} = Base.decode16("06")

# {_ok, coin_type} = Base.decode16("028A")
# {_ok, account} = Base.decode16("0000")
# {_ok, address_index} = Base.decode16("0000")
# derivation_path = coin_type <> account <> address_index

{_ok, derivation_path_length} = Base.decode16("0C")

derivation_path = "m/650'/0'/0'"

# size_str = derivation_path |> String.length |> Integer.to_string(16)

{_ok, wallet_curve} = Base.decode16("02")
{_ok, hash_type} = Base.decode16("00")

{_ok, ecdh_curve} = Base.decode16("02")
curve = :secp256k1

IO.puts("\n----------------------------------------------------")

IO.puts("\n Master Seed Length: ")
IO.puts(Base.encode16(master_seed_length))

IO.puts("\nMaster Seed for Onchain Wallet (32 bytes)")
IO.puts(Base.encode16(master_seed))

IO.puts("\n No. of services: ")
IO.puts(Base.encode16(total_services))

IO.puts("\n Service Name Length: ")
IO.puts(Base.encode16(service_name_length))

IO.puts("\n Service Name: ")
IO.puts(Base.encode16(service_name))

IO.puts("\n Derivation Path Length: ")
IO.puts(Base.encode16(derivation_path_length))

IO.puts(
  "\n Derivation Path (" <>
    Base.encode16(derivation_path_length) <>
    ":hex Bytes): [Coin type = 650, account = 0, index = 0]"
)

IO.puts(Base.encode16(derivation_path))

IO.puts("\nWallet Curve (0:ed25519, 1:nistp256, 2:secp256k1): ")
IO.puts(Base.encode16(wallet_curve))

IO.puts("\n Hash Type: 0: SHA256 (sha2)
1: SHA512 (sha2)
2: SHA3_256 (keccak)
3: SHA3_512 (keccak)
4: BLAKE2B")
IO.puts(Base.encode16(hash_type))

# Encoded Wallet Scheme
# Version	,Seed size	,Seed	,Nb services	,Service name size	,Service name	,Derivation path length	,Derivation path	,Curve type	,Hash type	...
# 4 bytes	1 byte	N bytes	1 byte	1 byte	N bytes	1 byte	N bytes	1 byte	1 byte	...

encoded_wallet =
  version <>
    master_seed_length <>
    master_seed <>
    total_services <>
    service_name_length <>
    service_name <> derivation_path_length <> derivation_path <> wallet_curve <> hash_type

IO.puts(
  "\nEncoded Wallet (version,master seed len, master seed, number of services, service name len, service name, derivation path len, derivcation path, wallet curve, hash type):"
)

IO.puts(Base.encode16(encoded_wallet))

IO.puts("\n----------------------------------------------------")

wallet_encryption_key = :crypto.strong_rand_bytes(32)
IO.puts("\nWallet Key (AES256 CTR) for encrypting Onchain Wallet (32 bytes)")
IO.puts(Base.encode16(wallet_encryption_key))

<<wallet_encryption_iv::binary-size(16), _reserved::binary-size(16)>> =
  :crypto.hash(:sha256, :crypto.hash(:sha256, wallet_encryption_key))

IO.puts("\nIV encrypting Onchain Wallet (SHA256(SHA256(Wallet Key)))[0:16]")
IO.puts(Base.encode16(wallet_encryption_iv))

encrypted_wallet =
  :crypto.crypto_one_time(
    :aes_256_ctr,
    wallet_encryption_key,
    wallet_encryption_iv,
    encoded_wallet,
    true
  )

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

ecdh = :crypto.compute_key(:ecdh, ledger, ephemeral_privkey, curve)
IO.puts("\nECDH Point x: ECDH(Origin Device Public Key, Ephemeral Private Key)")
IO.puts(Base.encode16(ecdh))

IO.puts("\n----------------------------------------------------")

<<aes_key::binary-size(32), iv::binary-size(16), auth_seed::binary-size(16)>> =
  :crypto.hash(:sha512, :crypto.hash(:sha512, ecdh))

IO.puts("\nAES256 CBC Key: SHA512(SHA512(ECDH Point x))[0:32]")
IO.puts(Base.encode16(aes_key))

IO.puts("\nIV: SHA512(SHA512(ECDH Point x))[32:48]")
IO.puts(Base.encode16(iv))

encrypted_wallet_key =
  :crypto.crypto_one_time(:aes_256_cbc, aes_key, iv, wallet_encryption_key, true)

IO.puts("\nEncryption of Wallet Key (AES256 CBC):")
IO.puts(Base.encode16(encrypted_wallet_key))

IO.puts("\n----------------------------------------------------")

IO.puts("\nAuthentication Seed: SHA512(SHA512(ECDH Point x))[48:64]")
IO.puts(Base.encode16(auth_seed))

auth_key = :crypto.hash(:sha256, auth_seed)
IO.puts("\nAuthentication Key: SHA256(Authentication Seed)")
IO.puts(Base.encode16(auth_key))

<<auth_tag::binary-size(16), _reserved::binary-size(16)>> =
  :crypto.mac(:hmac, :sha256, auth_key, encrypted_wallet_key)

IO.puts("\nAuthentication Tag: HMAC256(Authentication Key, Encrypted Wallet Key)[0:16]")
IO.puts(Base.encode16(auth_tag))

IO.puts("\n----------------------------------------------------")

encoded_wallet_key = ephemeral_pubkey <> auth_tag <> encrypted_wallet_key

IO.puts(
  "\nEncoding of Encrypted Wallet Key(ephemeral public key, authentication tag, encrypted wallet key):"
)

IO.puts(Base.encode16(encoded_wallet_key))

IO.puts("\n----------------------------------------------------")

IO.puts("\n Encoding a Simple Transaction")

# Transaction encoding
# tx_version | senderAddr | tx_type | code_size | content_size
# | ownership_length | total_uco_transfers | recieverAddr | amount | total_nft_transfers | recipients

{_ok, tx_version} = Base.decode16("00000001")
{_ok, tx_type} = Base.decode16("FD")
{_ok, code_size} = Base.decode16("00000000")
{_ok, content_size} = Base.decode16("00000000")
{_ok, ownership_length} = Base.decode16("00")
{_ok, total_uco_transfers} = Base.decode16("01")
{_ok, total_nft_transfers} = Base.decode16("00")
{_ok, recipients} = Base.decode16("00")

# 151 UC0 in hex, 1 UCO = 10^8
{_ok, amount} = Base.decode16("000000038407B700")

{_ok, receiver_addr} = Base.decode16("020019CA33A6CA9E69B5C29E6E8497CC5AC9675952F847347709AD39C92C1B1B5313")
{_ok, sender_addr} = Base.decode16("02008C9C7EE489E47E3867CD8CDADDA4867C6A874880E25CF68346D05B5C985CA1ED")

encoded_txn = tx_version <> sender_addr <> tx_type <> code_size <> content_size <> ownership_length <> total_uco_transfers <> receiver_addr <> amount <> total_nft_transfers <> recipients

IO.puts("Encoded Transaction:")
IO.puts(Base.encode16(encoded_txn))

#  Should be Equal to this
# "0000000102008C9C7EE489E47E3867CD8CDADDA4867C6A874880E25CF68346D05B5C985CA1EDFD00000000000000000001020019CA33A6CA9E69B5C29E6E8497CC5AC9675952F847347709AD39C92C1B1B5313000000038407B7000000"

txn_hash = :crypto.hash(:sha256, encoded_txn)

IO.puts("Transaction Hash: ---")
IO.puts(Base.encode16(txn_hash))

# From Script
# 7829BE6ADB23E83AF08BE2F27977EE8FDA4E2FE6D40A514DAF1BE13A020F7CB2
# From Device
# 7829BE6ADB23E83AF08BE2F27977EE8FDA4E2FE6D40A514DAF1BE13A020F7CB2


"""
{_ok, address_header} = Base.decode16("E0040000")
payload = encoded_wallet_key <> encrypted_wallet
{_ok, lc} = Base.decode16(Integer.to_string(byte_size(payload), 16))
address_apdu = address_header <> lc <> payload
IO.puts("\nAddress APDU:")
IO.puts(Base.encode16(address_apdu))

{_ok, sign_header} = Base.decode16("E0080000")
tx_hash = :crypto.hash(:sha256, "ARCHETHIC")
IO.puts("\nTx Hash:")
IO.puts(Base.encode16(tx_hash))

payload = tx_hash <> payload
{_ok, lc} = Base.decode16(Integer.to_string(byte_size(payload), 16))
sign_apdu = sign_header <> lc <> payload
IO.puts("\nSign APDU:")
IO.puts(Base.encode16(sign_apdu))

# elixir verify
# public_key = Base.decode16!("", case: :lower)
# sign = Base.decode16!("", case: :lower)
# :crypto.verify(:ecdsa, :sha256, "archethic", sign, [public_key, :secp256k1])
"""
