from ledgercomm import Transport  # Nano S/X using HID interface

transport = Transport(interface="hid", debug=True)
apdu_payload = "79CCB90235842588695A0B99256EB316A9E6807C8277564115FCA1A67FDA08FD041BBC73208CB4F613B324A069E07094A2C21AE83C9F263AEEF30397959BA2A3E4A09CA34FC2273C90A9F0CCABF46C8816916FEEADE5C3438C35A40EDF5507384234904064F1314FDA6ED87BD6E0ECBA0B3340E9674B019584717565E15894DF236560EFC3EB6B08B708F7AE3B358F5E21447A2BCAFCA45687314C1670E4069FFA400A484F79A6844723A61C05C514E88230E5003A27F56F"
sw, response = transport.exchange(cla=0xe0, ins=0x02, p1=0, p2=0, cdata=bytes.fromhex(apdu_payload))
print(response.hex())
transport.close()

# transport.send(cla=0xe0, ins=0x01, p1=0, p2=0, cdata=b"")# Waiting for a response (blocking IO)
# sw, response = transport.recv()# exchange method for structured APDUs
