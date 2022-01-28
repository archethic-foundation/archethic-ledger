# ArchEthic Ledger Device Application (Nano S)

This is a BOLOS application which can be to interact with ArchEthic TestNet using Ledger Nano S Device.

## Prerequisite

Be sure to have your environment correctly set up (see [Getting Started](https://developers.ledger.com/docs/nano-app/introduction/)) and [ledgerblue](https://pypi.org/project/ledgerblue/) and installed.

If you want to benefit from [vscode](https://code.visualstudio.com/) integration, it's recommended to move the toolchain in `/opt` and set `BOLOS_ENV` environment variable as follows

```
BOLOS_ENV=/opt/bolos-devenv
```

and do the same with `BOLOS_SDK` environment variable

```
BOLOS_SDK=/opt/nanos-secure-sdk
```

## Compilation

```
make DEBUG=1  # compile optionally with PRINTF
make load     # load the app on the Nano using ledgerblue
```

## Documentation

## Tests & Continuous Integration

The flow processed in [GitHub Actions](https://github.com/features/actions) is the following:

- Compilation of the application for Ledger Nano S in [ledger-app-builder](https://github.com/LedgerHQ/ledger-app-builder)
- End-to-end tests with [Speculos](https://github.com/LedgerHQ/speculos) emulator (see [tests/](tests/))


It outputs 2 artifacts:

- `archethic-app-debug` within output files of the compilation process in debug mode
- `speculos-log` within APDU command/response when executing end-to-end tests

## Tests with Ledger device (Nano S)
After loading the app.elf on the ledger device, You can test it with predefined on-chain wallet in [ALCA](https://github.com/archethic-foundation/ledger-cli-app).

Soon, the [GUI Wallet](https://github.com/archethic-foundation/archethic_wallet) will be supported.

## Dev Environment Setup
You can follow the docker route as recommended by Ledger or execute the following for a native dev environment.

```
sudo apt install make
sudo apt install python3-venv
sudo apt install gcc-multilib g++-multilib
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash

cd /opt
sudo mkdir dev-env
sudo mkdir dev-env/backup
sudo mkdir dev-env/SDK
sudo mkdir dev-env/CC
sudo mkdir dev-env/CC/others
sudo mkdir dev-env/CC/others/clang-arm-fropi

cd dev-env/backup
sudo wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
sudo tar xf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
sudo cp -r gcc-arm-none-eabi-10.3-2021.10 ../CC/others/.
sudo rm -r gcc-arm-none-eabi-10.3-2021.10


sudo wget https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz
sudo tar xf clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz
sudo cp -r clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04 ../CC/others/clang-arm-fropi
sudo rm -r clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04

cd ../SDK
sudo git clone https://github.com/LedgerHQ/nanos-secure-sdk

sudo nano /etc/environment

//append the following lines to the file
BOLOS_ENV=/opt/dev-env/CC/others
BOLOS_SDK=/opt/dev-env/SDK/nanos-secure-sdk
// Press Ctrl+O and then Ctrl+X

cd /opt
python3 -m venv dev-env/ledger
source dev-env/ledger/bin/activate
sudo reboot

//After reboot open terminal and go to your home directory
mkdir ledger
cd ledger
git clone https://github.com/LedgerHQ/speculos
cd speculos
sudo apt install \
    cmake gcc-arm-linux-gnueabihf libc6-dev-armhf-cross gdb-multiarch \
    python3-pyqt5 python3-construct python3-flask-restful python3-jsonschema \
    python3-mnemonic python3-pil python3-pyelftools python3-requests \
    qemu-user-static

cmake -Bbuild -H.
make -C build/

cd ..
git clone https://github.com/archethic-foundation/archethic-ledger
cd archethic-ledger
make
../speculos/speculos.py bin/app.elf
```
