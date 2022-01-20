def test_get_public_key(cmd):
    curve_type, device_origin, path_form, x, y = cmd.get_public_key(
        display=False
    )  # type: hex, hex, hex, hex, hex

    ### Returned string is in form of `hex` string

    assert curve_type == "02" # Since curve type defined is SECP256K1
    assert device_origin == "04" # Since test is for ledger device
    assert path_form == "04" # Since need an uncompressed form of the publickey
    assert len(x) == 64 # Length Check for the x on curve
    assert len(y) == 64 # Lengty Check for the y on curve

    ## Full Reponse Check 
    assert len(curve_type + device_origin + path_form + x + y)/2 == 67 # 1 byte + 1 byte + 1 byte + 32 bytes + 32 bytes

