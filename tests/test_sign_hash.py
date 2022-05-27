import ecdsa
from hashlib import sha256

from ecdsa.curves import SECP256k1
from ecdsa.keys import VerifyingKey
from ecdsa.util import sigdecode_der

from utils import verify_signature, pubkey_pair, str_to_hex_int, sign_pair


def test_sign_txn_hash(cmd, hid):

    # Testing with a predefined onchain wallet
    encoded_encrypted_key = "041513BB64C3F276D6062E6BF961B243C14D038A0736B69C445834CAFD36277015BE7CCB6D145D5D56FCEF323FBFA702836EA56CFF8BF35E086CD395F266D60E988BFA38917BF72DDBBB0A72E4EE839024790EB79193B4324D2D87A5115CAE6E79193E8E4AE4B5DC9681FC89E02944BE75"
    encoded_encrypted_wallet = "098491FEBC7C6473E7A01177B83F9C7167C8110A827474574106E47781FDB65ED087A965F1B6CDF47C5F043FD02A1CC1B12E5D"

    encrypted_key_plus_wallet = encoded_encrypted_key + encoded_encrypted_wallet

    # service index for which derivation path will be used to sign
    service_index = "00"

    # Receiver Address as per specification
    receiver = "020019CA33A6CA9E69B5C29E6E8497CC5AC9675952F847347709AD39C92C1B1B5313"

    # 151 UC0 in hex, 1 UCO = 10^8
    amount = "000000038407B700"

    final_txn_hash, curve_type, origin_type, pubkey_tag, public_key, sign_tag, sign_len, asn_der_sign = cmd.sign_txn_hash(
        hid, encrypted_key_plus_wallet, service_index, receiver, amount, hid)

    pubkeyPair = pubkey_pair(public_key)
    sign = sign_pair(asn_der_sign)
    finalHash = str_to_hex_int(final_txn_hash)

    assert(verify_signature(pubkeyPair, finalHash, sign) == True)
    assert(curve_type == "02")
