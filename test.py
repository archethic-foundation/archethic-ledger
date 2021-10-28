from ledgercomm import Transport# Nano S/X using HID interface
transport = Transport(interface="hid", debug=True)

#transport.send(cla=0xe0, ins=0x01, p1=0, p2=0, cdata=b"")# Waiting for a response (blocking IO)
#sw, response = transport.recv()# exchange method for structured APDUs

sw, response = transport.exchange(cla=0xe0, ins=0x01, p1=0, p2=0, cdata=b"")
print(response)
transport.close()