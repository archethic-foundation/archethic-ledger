/*******************************************************************************
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
 ********************************************************************************/
#include <cx.h>

#define HDW_NORMAL 0
#define HDW_ED25519_SLIP10 1
#define HDW_SLIP21 2

typedef struct
{
    uint8_t private_key[64];
    uint8_t chain_code[32];
} extended_private_key;

unsigned long archethic_derive_node_with_seed_key(unsigned int mode, cx_curve_t curve, uint8_t *masterSeed, size_t masterSeedLen, const unsigned int *path, unsigned int pathLength, unsigned char *privateKey, unsigned char *chain, unsigned char *seed_key, unsigned int seed_key_length);