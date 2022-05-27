"""*******************************************************************************
*   Archethic Ledger Bolos App
*   (c) 2022 Varun Deshpande, Uniris
*
*  Licensed under the GNU Affero General Public License, Version 3 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      https://www.gnu.org/licenses/agpl-3.0.en.html
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
********************************************************************************"""
from ledgercomm import Transport  # Nano S/X using HID interface

#transport = Transport(interface="hid", debug=True)
transport = Transport(interface="tcp", server="127.0.0.1",
                      port=9999, debug=True)
# encrypted_key_plus_wallet = "0401EC530D1BBDF3B1B3E18C6E2330E5CFD1BFD88EB6D84102184CB39EC271793578B469ACBD8EB4F684C41B5DA87712A203AAA910B7964218794E3D3F343835843C44AFFE281D750E6CA526C6FC265167FE37DB9E47828BF80964DAC837E1072CA9954FF1852FF71865B9043BC117BC001C47D76A326A2A2F7CF6B16AB49E9E57F9D5E6D8E1D00D7F1B7E2F986C711DCA060005B2C8F485"

encoded_encrypted_key = "041513BB64C3F276D6062E6BF961B243C14D038A0736B69C445834CAFD36277015BE7CCB6D145D5D56FCEF323FBFA702836EA56CFF8BF35E086CD395F266D60E988BFA38917BF72DDBBB0A72E4EE839024790EB79193B4324D2D87A5115CAE6E79193E8E4AE4B5DC9681FC89E02944BE75"
encoded_encrypted_wallet = "098491FEBC7C6473E7A01177B83F9C7167C8110A827474574106E47781FDB65ED087A965F1B6CDF47C5F043FD02A1CC1B12E5D"

encrypted_key_plus_wallet = encoded_encrypted_key + encoded_encrypted_wallet
address_index = "00000000"
service_index = "00"
receiver = "020019CA33A6CA9E69B5C29E6E8497CC5AC9675952F847347709AD39C92C1B1B5313"
amount = "000000038407B700"

# Address APDU
# apdu_hex_payload = address_index + encrypted_key_plus_wallet
# apdu_hex_payload = service_index + encrypted_key_plus_wallet

# Sign APDU
# apdu_hex_payload = address_index + receiver + amount + encrypted_key_plus_wallet
apdu_hex_payload = service_index + receiver + amount + encrypted_key_plus_wallet

apdu_payload = bytes.fromhex(apdu_hex_payload)
sw, response = transport.exchange(
    cla=0xe0, ins=0x08, p1=0, p2=0, cdata=apdu_payload)

print(response.hex())
transport.close()

# transport.send(cla=0xe0, ins=0x01, p1=0, p2=0, cdata=b"")# Waiting for a response (blocking IO)
# sw, response = transport.recv()# exchange method for structured APDUs
