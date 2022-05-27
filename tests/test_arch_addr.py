def test_get_arch_addr(cmd, hid):

    # Testing with a predefined onchain wallet
    
    encoded_encrypted_key = "041513BB64C3F276D6062E6BF961B243C14D038A0736B69C445834CAFD36277015BE7CCB6D145D5D56FCEF323FBFA702836EA56CFF8BF35E086CD395F266D60E988BFA38917BF72DDBBB0A72E4EE839024790EB79193B4324D2D87A5115CAE6E79193E8E4AE4B5DC9681FC89E02944BE75"
    encoded_encrypted_wallet = "098491FEBC7C6473E7A01177B83F9C7167C8110A827474574106E47781FDB65ED087A965F1B6CDF47C5F043FD02A1CC1B12E5D"

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