#!/bin/bash
# CTF_HELPER - Cryptography Module v2.0
# Based on HackTricks Cryptography Methodology

source ./ctf_helper.sh # Pentru culori și banner, dacă sunt exportate

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
        # Identificare rapidă conform HackTricks Triage Checklist
        read -p "Enter secret/blob: " secret
        echo -e "${C2}[*] Identifying...${NC}"
        hashid -m -j "$secret"
        echo -e "${C3}[Tip] Check if it's High Entropy (Encrypted) or Structured (Encoded).${NC}"
        ;;
    2) ./modules/crypto/classical_ciphers.sh ;;
    3) ./modules/crypto/symmetric_attacks.sh ;;
    4) ./modules/crypto/public_key_rsa.sh ;;
    5) ./modules/crypto/hash_cracking.sh ;;
    6) ./modules/crypto/malware_recon.sh ;;
    7) ./modules/crypto/misc_crypto.sh ;;
    0) return ;;
    *) echo -e "${C2}[!] Invalid option.${NC}" ; sleep 1 ; ./modules/crypto.sh ;;
esac

# Revenire automată la meniul crypto după execuție
./modules/crypto.sh
