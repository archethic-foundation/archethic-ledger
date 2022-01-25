from pathlib import Path
import pytest

from ledgercomm import Transport
from archethic_client.archethic_cmd import ArchethicCommand

def pytest_addoption(parser):
    parser.addoption("--hid",
                     action="store_true")

@pytest.fixture(scope="session")
def hid(pytestconfig):
    return pytestconfig.getoption("hid")

@pytest.fixture(scope="session")
def cmd(hid):
    transport = (Transport(interface="hid", debug=True)
                 if hid else Transport(interface="tcp",
                                       server="127.0.0.1",
                                       port=9999,
                                       debug=True))
    command = ArchethicCommand(
        transport=transport,
        debug=True
    )

    yield command
    command.transport.close()
