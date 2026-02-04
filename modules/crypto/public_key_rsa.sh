#!/bin/bash
# CTF_HELPER - Public Key Crypto (RSA Focus)
# Focus: RSA Factorization, Discrete Logs, and SageMath Integration

source ./ctf_helper.sh

echo -e "${C6}[MODULE: PUBLIC-KEY CRYPTO]${NC}"
echo -e "Attacking RSA, ECC, and Discrete Logarithm Problems\n"

echo "1) RSA Automated Attack (RsaCtfTool)"
echo "2) Factoring N (Factordb / Small Primes)"
echo "3) Weak Public Exponent (Low e - Root Attack)"
echo "4) Common Modulus / Hastad's Broadcast Attack"
echo "5) SageMath Environment (Lattices & Coppersmith)"
echo "0) Back to Crypto Menu"

echo -en "\n${C3}pubkey_helper > ${NC}"
read rsa_opt

case $rsa_opt in
    1)
        # HackTricks: "Classify primitive and apply attack template"
        echo -e "${C2}[*] Launching RsaCtfTool...${NC}"
        read -p "Path to public key (.pub) or N/e values: " rsa_input
        /opt/RsaCtfTool/RsaCtfTool.py --publickey "$rsa_input" --attack all
        ;;
    2)
        # HackTricks: "Can we factor N?"
        read -p "Enter Modulus (N) in hex or dec: " n_val
        echo -e "${C2}[*] Checking Factordb.com for known primes...${NC}"
        curl -s "http://factordb.com/api?query=$n_val" | jq
        ;;
    3)
        # HackTricks: "Low e attacks"
        echo -e "${C2}[*] Low Exponent (e=3) Detected:${NC}"
        echo " - Logic: If m^e < N, then m is just the e-th root of ciphertext."
        echo " - Command: python3 -c \"import gmpy2; print(gmpy2.iroot(int(input('C: ')), $e))\""
        ;;
    4)
        # HackTricks: "Common Modulus Attack"
        echo -e "${C2}[*] Common Modulus Attack Requirements:${NC}"
        echo " - Same N, different e (e1, e2) used to encrypt same message m."
        echo " - Tool: Use RsaCtfTool with --attack common_modulus"
        ;;
    5)
        # HackTricks: "Escalate to advanced methods (Lattices/LLL)"
        echo -e "${C1}[*] Advanced SageMath Interaction:${NC}"
        echo " - Useful for: Coppersmith (partial p/m known), LLL/BKZ."
        echo " - Run 'sage' to enter the interactive shell."
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/crypto/public_key_rsa.sh
