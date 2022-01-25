def test_get_arch_addr(cmd, hid):

    # Testing with a predefined onchain wallet
    encrypted_key_plus_wallet = "0401EC530D1BBDF3B1B3E18C6E2330E5CFD1BFD88EB6D84102184CB39EC271793578B469ACBD8EB4F684C41B5DA87712A203AAA910B7964218794E3D3F343835843C44AFFE281D750E6CA526C6FC265167FE37DB9E47828BF80964DAC837E1072CA9954FF1852FF71865B9043BC117BC001C47D76A326A2A2F7CF6B16AB49E9E57F9D5E6D8E1D00D7F1B7E2F986C711DCA060005B2C8F485"
    # Need First Address Index
    address_index = "00000000"

    curve_type, hash_type, hash_enc_pub_key = cmd.get_arch_addr(hid, encrypted_key_plus_wallet, address_index)

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