#!/bin/bash
# CTF_HELPER - Cryptography Module v2.0
# Guiding Principle: HackTricks Crypto Methodology

# Load colors and banner functions from main script
source ./ctf_helper.sh 

echo -e "${C6}
██████╗██████╗ ██╗   ██╗██████╗ ████████╗ ██████╗ 
██╔════╝██╔══██╗╚██╗ ██╔╝██╔══██╗╚══██╔══╝██╔═══██╗
██║     ██████╔╝ ╚████╔╝ ██████╔╝   ██║   ██║   ██║
██║     ██╔══██╗  ╚██╔╝  ██╔═══╝    ██║   ██║   ██║
╚██████╗██║  ██║   ██║   ██║        ██║   ╚██████╔╝
 ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝        ╚═╝    ╚═════╝ 
${NC}"

echo -e "${C4}[REFERENCE] https://book.hacktricks.xyz/crypto/crypto-attacks${NC}"
echo -e "------------------------------------------------------------------"

echo -e "${C1}Select Cryptography Category:${NC}"
echo "1) 🔍 Triage & Identification (HashID, CipherID, CyberChef Magic)"
echo "2) 🏛️  Classical Ciphers & Encodings (ROT, Vigenere, Base-Layers)"
echo "3) 🔑 Symmetric Crypto (AES Modes, Padding Oracle, Bit-Flipping, XOR)"
echo "4) 📜 Public-Key Crypto (RSA, ECC, Lattices/SageMath)"
echo "5) ⚡ Hashes & MACs (Cracking, Length Extension, HMAC)"
echo "6) 🛠️  Crypto in Malware (S-Box Search, RC4 Loops, API Recognition)"
echo "7) 📦 Misc (Esoteric Langs, Shamir, OpenSSL Salted)"
echo "0) 🔙 Return to Main Menu"

echo -en "\n${C3}crypto_helper > ${NC}"
read crypto_opt

case $crypto_opt in
    1)
        # Fast identification based on HackTricks Triage Checklist
        # Helps distinguish between Encoding, Encryption, Hash, or Signature
        read -p "Enter secret/blob: " secret
        echo -e "${C2}[*] Identifying...${NC}"
        hashid -m -j "$secret"
        echo -e "${C3}[Tip] Check entropy: High (Encryption/Compressed) vs Low (Encoded/Plain).${NC}"
        ;;
    2)
        # Handles legacy ciphers and multi-layer encodings
        ./modules/crypto/classical_ciphers.sh 
        ;;
    3)
        # Block cipher modes (ECB/CBC/GCM) and Stream cipher (RC4/XOR) attacks
        ./modules/crypto/symmetric_attacks.sh 
        ;;
    4)
        # Factorization, Coppersmith, LLL, and Discrete Logarithm problems
        ./modules/crypto/public_key_rsa.sh 
        ;;
    5)
        # Brute-force and Merkle-Damgard specific vulnerabilities
        ./modules/crypto/hash_cracking.sh 
        ;;
    6)
        # Heuristics for finding crypto constants and loops in binaries
        ./modules/crypto/malware_recon.sh 
        ;;
    7)
        # Rare cases: Bacon, Morse, Esolangs, and Secret Sharing
        ./modules/crypto/misc_crypto.sh 
        ;;
    0) 
        # Exit module
        return 
        ;;
    *) 
        echo -e "${C2}[!] Invalid option.${NC}" 
        sleep 1 
        ./modules/crypto.sh 
        ;;
esac

# Recursive call to keep the user in the Crypto Menu after an action
./modules/crypto.sh
