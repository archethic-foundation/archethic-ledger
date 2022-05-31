def test_get_arch_addr(cmd, hid):

    # Testing with a predefined onchain wallet
    
    encoded_encrypted_key = "04CB3DC7888D6045AE7BB6A2F80FB8919E0D01CFF3407643F22582BA5F7EDCC403D569ED5F9C30CCEE2CE3136BEE0D12C58564EA8D8A244B5E6DFEC04536B0182A97B7E544F03670554D737EF76A948DB0CC5A9928A0F8C11D2DE8923C9E5E3267DBC51B4DDDA7CD496F2F331E0736B4B9"
    encoded_encrypted_wallet = "FC6659EFC3B68999B968136940C25FF0FB7241AE7B03C3D0CDCB76D03FE5CC35A2E4F201569DFCB6C26544D99DEB21FA12C7B7BABF38075293"

    encrypted_key_plus_wallet = encoded_encrypted_key + encoded_encrypted_wallet

    # Need the service index for whose derivation path needs to be used
    service_index = "00"

    # APDU Command is =>  service_index (1byte) | encrypted_key | encrypted_wallet

    curve_type, hash_type, hash_enc_pub_key = cmd.get_arch_addr(hid, encrypted_key_plus_wallet, service_index)

    # curve_type => 0: ED25519, 1: NISTP256, 2: SECP256K1
    # hash_type => 0 -> SHA256 (sha2) 1 -> SHA512 (sha2) 2 -> SHA3_256 (keccak) 3 -> SHA3_512 (keccak) 4 -> BLAKE2B
    # hash_enc_pub_key => According to hash type hashed encoded public key

    def check_hash_len(curve_type, hashed_data):
        if(curve_type == "00" or curve_type == "02"):
            assert(len(hashed_data) == 64)
        elif(curve_type == "01" or curve_type == "03"):
            assert(len(hashed_data) == 128)

        assert(curve_type == "02")
        assert(hash_type == "00")
    check_hash_len(curve_type, hash_enc_pub_key)