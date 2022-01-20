import struct
from typing import Tuple

from ledgercomm import Transport

from archethic_client.archethic_cmd_builder import ArchethicCommandBuilder, InsType
from archethic_client.button import Button
from archethic_client.exception import DeviceException
from archethic_client.transaction import Transaction


class ArchethicCommand:
    def __init__(self,
                 transport: Transport,
                 debug: bool = False) -> None:
        self.transport = transport
        self.builder = ArchethicCommandBuilder(debug=debug)
        self.debug = debug

    def get_app_and_version(self) -> Tuple[str, str]:
        sw, response = self.transport.exchange_raw(
            self.builder.get_app_and_version()
        )  # type: int, bytes

        if sw != 0x9000:
            raise DeviceException(error_code=sw, ins=0x01)

        # response = format_id (1) ||
        #            app_name_len (1) ||
        #            app_name (var) ||
        #            version_len (1) ||
        #            version (var) ||
        offset: int = 0

        format_id: int = response[offset]
        offset += 1
        app_name_len: int = response[offset]
        offset += 1
        app_name: str = response[offset:offset + app_name_len].decode("ascii")
        offset += app_name_len
        version_len: int = response[offset]
        offset += 1
        version: str = response[offset:offset + version_len].decode("ascii")
        offset += version_len

        return app_name, version

    def get_version(self) -> Tuple[int, int, int]:
        sw, response = self.transport.exchange_raw(
            self.builder.get_version()
        )  # type: int, bytes

        print(sw, response)

        if sw != 0x9000:
            raise DeviceException(error_code=sw, ins=InsType.INS_GET_VERSION)

        # response = MAJOR (1) || MINOR (1) || PATCH (1)
        assert len(response) == 3

        major, minor, patch = struct.unpack(
            "BBB",
            response
        )  # type: int, int, int

        return major, minor, patch

    def get_public_key(self, display: bool = False) -> Tuple[bytes, bytes]:
        sw, response = self.transport.exchange_raw(
            self.builder.get_public_key(display=display)
        )  # type: int, bytes

        if sw != 0x9000:
            raise DeviceException(error_code=sw, ins=InsType.INS_GET_PUBLIC_KEY)

        response = response.hex()

        # print (response)
        # print(len(response))

        offset: int = 0

        curve_type: hex = response[offset: offset + 2]
        offset += 2
        device_origin: hex = response[offset:offset + 2]
        offset += 2
        path_form: hex = response[offset:offset + 2]
        offset += 2
        x: hex = response[offset:offset + 64]
        offset += 64
        y: hex = response[offset:offset + 64]
        
        # curve_type => 0 -> SHA256 (sha2) 1 -> SHA512 (sha2) 2 -> SHA3_256 (keccak) 3 -> SHA3_512 (keccak) 4 -> BLAKE2B
        # device_origin => 0 -> Onchain Wallet , 1 -> Software wallet , 2 -> TPM(Node) , 3 -> Yubikey(Node, hardware Wallet) , 4 -> Ledger (Hardware Wallet)
        # path_form => 04 means uncompressed form
        # x => x on curve path uncompressed form
        # y => y on curve path uncompressed form

        assert len(response) == 134 # 1 bytes + 1 bytes + 1 byte + 32 bytes + 32 bytes

        return curve_type, device_origin, path_form, x, y

   