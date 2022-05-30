import ecdsa
from hashlib import sha256

from ecdsa.curves import SECP256k1
from ecdsa.keys import VerifyingKey
from ecdsa.util import sigdecode_der

from utils import verify_signature, pubkey_pair, str_to_hex_int, sign_pair


def test_sign_txn_hash(cmd, hid):

    # Testing with a predefined onchain wallet
    encoded_encrypted_key = "04CB3DC7888D6045AE7BB6A2F80FB8919E0D01CFF3407643F22582BA5F7EDCC403D569ED5F9C30CCEE2CE3136BEE0D12C58564EA8D8A244B5E6DFEC04536B0182A97B7E544F03670554D737EF76A948DB0CC5A9928A0F8C11D2DE8923C9E5E3267DBC51B4DDDA7CD496F2F331E0736B4B9"
    encoded_encrypted_wallet = "FC6659EFC3B68999B968136940C25FF0FB7241AE7B03C3D0CDCB76D03FE5CC35A2E4F201569DFCB6C26544D99DEB21FA12C7B7BABF38075293"

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
