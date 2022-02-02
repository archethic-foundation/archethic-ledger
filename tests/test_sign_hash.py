import ecdsa
from hashlib import sha256

from ecdsa.curves import SECP256k1
from ecdsa.keys import VerifyingKey
from ecdsa.util import sigdecode_der

from utils import verify_signature, pubkey_pair, str_to_hex_int, sign_pair


def test_sign_txn_hash(cmd, hid):

    # Testing with a predefined onchain wallet
    encrypted_key_plus_wallet = "0401EC530D1BBDF3B1B3E18C6E2330E5CFD1BFD88EB6D84102184CB39EC271793578B469ACBD8EB4F684C41B5DA87712A203AAA910B7964218794E3D3F343835843C44AFFE281D750E6CA526C6FC265167FE37DB9E47828BF80964DAC837E1072CA9954FF1852FF71865B9043BC117BC001C47D76A326A2A2F7CF6B16AB49E9E57F9D5E6D8E1D00D7F1B7E2F986C711DCA060005B2C8F485"

    # Address Index to perform signature
    address_index = "00000000"

    # Receiver Address as per specification
    receiver = "020019CA33A6CA9E69B5C29E6E8497CC5AC9675952F847347709AD39C92C1B1B5313"

    # 151 UC0 in hex, 1 UCO = 10^8
    amount = "000000038407B700"

    final_txn_hash, curve_type, origin_type, pubkey_tag, public_key, sign_tag, sign_len, asn_der_sign = cmd.sign_txn_hash(
        hid, encrypted_key_plus_wallet, address_index, receiver, amount, hid)

    pubkeyPair = pubkey_pair(public_key)
    sign = sign_pair(asn_der_sign)
    finalHash = str_to_hex_int(final_txn_hash)

    assert(verify_signature(pubkeyPair, finalHash, sign) == True)
    assert(curve_type == "02")
