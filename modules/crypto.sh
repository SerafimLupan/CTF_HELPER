#!/bin/bash
# CTF_HELPER - Cryptography Module v2.0

run_crypto() {
    while true; do
        print_banner 
        echo -e "${C4}[REFERENCE] https://book.hacktricks.xyz/crypto/crypto-attacks${NC}"
        echo -e "------------------------------------------------------------------"

        echo -e "${C1}Select Cryptography Category:${NC}"
        echo "1) 🔍 Triage & Identification"
        echo "2) 🏛️  Classical Ciphers & Encodings"
        echo "3) 🔑 Symmetric Crypto (AES, XOR)"
        echo "4) 📜 Public-Key Crypto (RSA, ECC)"
        echo "5) ⚡ Hashes & MACs"
        echo "6) 🛠️  Crypto in Malware"
        echo "7) 📦 Misc (Esolangs, Shamir)"
        echo "0) 🔙 Return to Main Menu"

        echo -en "\n${C3}crypto_helper > ${NC}"
        read -r opt

        case "$opt" in
            1)
                read -p "Enter secret/blob: " secret
                echo -e "${C2}[*] Identifying...${NC}"
                if command -v hashid &> /dev/null; then
                    hashid -m -j "$secret"
                else
                    echo "Error: hashid not found. Install with: sudo apt install hashid"
                fi
                echo -e "${C3}[Tip] Check entropy: High (Encrypted) vs Low (Encoded).${NC}"
                ;;
            2)
                
                [ -f "./modules/crypto/classical_ciphers.sh" ] && bash ./modules/crypto/classical_ciphers.sh
                ;;
            3)
                [ -f "./modules/crypto/symmetric_attacks.sh" ] && bash ./modules/crypto/symmetric_attacks.sh
                ;;
            4)
                [ -f "./modules/crypto/public_key_rsa.sh" ] && bash ./modules/crypto/public_key_rsa.sh
                ;;
            5)
                [ -f "./modules/crypto/hash_cracking.sh" ] && bash ./modules/crypto/hash_cracking.sh
                ;;
            6) 
                [ -f "./modules/crypto/misc_crypto.sh" ] && bash ./modules/crypto/misc_crypto.sh
                ;;
            7)
                [ -f "./modules/crypto/classical_ciphers.sh" ] && bash ./modules/crypto/classical_ciphers.sh
                ;;
            0) 
                return 
                ;;
            *) 
                echo -e "${C1}[!] Invalid option.${NC}"
                sleep 1
                ;;
        esac

        echo -e "\n${C2}--------------------------------------------------${NC}"
        read -p "Press Enter to continue..."
    done
}	
	


	
