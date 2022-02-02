import enum
import logging
import struct
from typing import List, Tuple, Union, Iterator, cast

from archethic_client.transaction import Transaction
from archethic_client.utils import bip32_path_from_string

MAX_APDU_LEN: int = 255


def chunkify(data: bytes, chunk_len: int) -> Iterator[Tuple[bool, bytes]]:
    size: int = len(data)

    if size <= chunk_len:
        yield True, data
        return

    chunk: int = size // chunk_len
    remaining: int = size % chunk_len
    offset: int = 0

    for i in range(chunk):
        yield False, data[offset:offset + chunk_len]
        offset += chunk_len

    if remaining:
        yield True, data[offset:]


class InsType(enum.IntEnum):
    INS_GET_VERSION = 0x01
    INS_GET_PUBLIC_KEY = 0x02
    INS_GET_ARCH_ADDR = 0x04
    INS_SIGN_TX = 0x08


class ArchethicCommandBuilder:
    """APDU command builder for the Arhcethic application.

    Parameters
    ----------
    debug: bool
        Whether you want to see logging or not.

    Attributes
    ----------
    debug: bool
        Whether you want to see logging or not.

    """
    CLA: int = 0xE0

    def __init__(self, debug: bool = False):
        """Init constructor."""
        self.debug = debug

    def serialize(self,
                  cla: int,
                  ins: Union[int, enum.IntEnum],
                  p1: int = 0,
                  p2: int = 0,
                  cdata: bytes = b"") -> bytes:
        """Serialize the whole APDU command (header + data).

        Parameters
        ----------
        cla : int
            Instruction class: CLA (1 byte)
        ins : Union[int, IntEnum]
            Instruction code: INS (1 byte)
        p1 : int
            Instruction parameter 1: P1 (1 byte).
        p2 : int
            Instruction parameter 2: P2 (1 byte).
        cdata : bytes
            Bytes of command data.

        Returns
        -------
        bytes
            Bytes of a complete APDU command.

        """
        ins = cast(int, ins.value) if isinstance(ins, enum.IntEnum) else cast(int, ins)

        header: bytes = struct.pack("BBBBB",
                                    cla,
                                    ins,
                                    p1,
                                    p2,
                                    len(cdata))  # add Lc to APDU header

        if self.debug:
            logging.info("header: %s", header.hex())
            logging.info("cdata:  %s", cdata.hex())

        return header + cdata

    def get_app_and_version(self) -> bytes:
        """Command builder for GET_APP_AND_VERSION (builtin in BOLOS SDK).

        Returns
        -------
        bytes
            APDU command for GET_APP_AND_VERSION.

        """
        return self.serialize(cla=0xB0,  # specific CLA for BOLOS
                              ins=0x01,
                              p1=0x00,
                              p2=0x00,
                              cdata=b"")

    def get_version(self) -> bytes:
        """Command builder for GET_VERSION.

        Returns
        -------
        bytes
            APDU command for GET_VERSION.

        """
        return self.serialize(cla=self.CLA,
                              ins=InsType.INS_GET_VERSION,
                              p1=0x00,
                              p2=0x00,
                              cdata=b"")


    def get_public_key(self, display: bool = False) -> bytes:
        """Command builder for GET_PUBLIC_KEY.

        Parameters
        ----------
        display : bool
            Whether you want to display the address on the device.

        Returns
        -------
        bytes
            APDU command for GET_PUBLIC_KEY.
        """

        return self.serialize(cla=self.CLA,
                              ins=InsType.INS_GET_PUBLIC_KEY,
                              p1=0x01 if display else 0x00,
                              p2=0x00,
                              cdata=b"")

    def get_arch_address(self,  enc_oc_wallet, addr_index, display: bool = False):
        """Command builder for GET_ARCH_ADDR.

        Parameters
        ----------
        display : bool
            Whether you want to display the address on the device.
        enc_oc_wallet: String<hex>
            The Encyrpted onchain wallet with key or in short encrypted key plus wallet
        addr_index: string
            The address index to which address need to be derived

        Returns
        -------
        bytes
            APDU command for GET_ARCH_ADDR.
        """
        
        # As per specification https://hackmd.io/0fKm_XjJQuu46ph6zP5doQ#Get-ArchEthic-Account-Address
        cdata: bytes = bytes.fromhex(addr_index + enc_oc_wallet)

        return self.serialize(cla=self.CLA,
                                ins=InsType.INS_GET_ARCH_ADDR,
                                p1=0x01 if display else 0x00,
                                p2=0x00,
                                cdata=cdata)

    def sign_txn_hash_build(self, enc_oc_wallet, addr_index, receiver_addr, amount, display: bool = False):
        """Command builder for SIGN_TX.

        Parameters
        ----------
        enc_oc_wallet: String<hex>
            The Encyrpted onchain wallet with key or in short encrypted key plus wallet
        addr_index: string
            The address index to which address need to be derived
        receiver_addr: string
            The receiver address which will receive the amount
        amount: string
            The amount which will be transferred to receiver (in hex).
        display : bool  
            Whether you want to display the address on the device.

        Returns
        -------
        bytes
            APDU command for SIGN_TX.
        """

        cdata: bytes = bytes.fromhex(addr_index + receiver_addr + amount + enc_oc_wallet)

        return self.serialize(cla=self.CLA,
                                ins=InsType.INS_SIGN_TX,
                                p1=0x01 if display else 0x00,
                                p2=0x00,
                                cdata=cdata)
        
