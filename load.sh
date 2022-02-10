#!/bin/bash

python3 -m ledgerblue.loadApp --appFlags 0x000 --path "44'/650'" --tlv --targetId 0x31100004 --targetVersion="2.0.0" --delete --fileName bin/app.hex --appName "ARCHEthic" --appVersion "1.0.1" --dataSize $((0x`cat debug/app.map |grep _envram_data | tr -s ' ' | cut -f2 -d' '|cut -f2 -d'x'` - 0x`cat debug/app.map |grep _nvram_data | tr -s ' ' | cut -f2 -d' '|cut -f2 -d'x'`)) --icon 0101010000fffefe00000000000000f00d181b6816301410181008300c6006c0008003000000000000 --rootPrivateKey 2900003ae4a2109be14c8b3a8b70387eb76bf1b45f92d6ff12178f91a08534cf
