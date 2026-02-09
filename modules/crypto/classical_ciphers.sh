#!/bin/bash
# CTF_HELPER - Classical Ciphers & Encodings
# Focus: Layered transforms, Substitution, and Esoteric Encodings

echo -e "${C6}[MODULE: CLASSICAL CIPHERS]${NC}"
echo -e "Handling layered transforms (Encoding -> Substitution -> Compression)\n"

echo "1) Multi-Base Decoder (Base64/32/58/85)"
echo "2) Caesar / ROT Brute-force (0-25)"
echo "3) Vigenere Solver (Known Key or Auto-break)"
echo "4) Monoalphabetic Substitution (quipqiup style)"
echo "5) Esoteric (Bacon, Morse, Atbash)"
echo "6) CyberChef Magic Mode (External API)"
echo "0) Back to Crypto Menu"

echo -en "\n${C3}classical_helper > ${NC}"
read -r class_opt

case $class_opt in
    1)
        # HackTricks: "Peel layers safely"
        read -p "Enter string to decode: " data
        echo -e "${C2}[*] Testing standard bases...${NC}"
        # Try python-codext for smart decoding, fallback to base64
        if command -v codext &> /dev/null; then
            codext "$data"
        else
            echo -n "Base64: " && echo "$data" | base64 -d 2>/dev/null || echo "Failed"
            echo -n "Base32: " && echo "$data" | base32 -d 2>/dev/null || echo "Failed"
        fi
        ;;
    2)
        # HackTricks: "Try many rotations"
        read -p "Enter ciphertext: " data
        echo -e "${C2}[*] Brute-forcing all 25 rotations...${NC}"
        for i in {1..25}; do
            echo -n "ROT$i: "
            # Shift characters using 'tr'
            upper=$(echo {A..Z} | tr -d ' ')
            lower=$(echo {a..z} | tr -d ' ')
            echo "$data" | tr "${upper:i:26}${upper:0:i}" "${upper}" | tr "${lower:i:26}${lower:0:i}" "${lower}"
        done
        ;;
    3)
        # HackTricks: "Identify Vigenere and find key length"
        read -p "Enter ciphertext: " data
        read -p "Enter key (press enter to auto-solve): " vkey
        if [ -z "$vkey" ]; then
            echo -e "${C3}[!] Recommended: Use dcode.fr/vigenere-cipher for auto-breaking.${NC}"
        else
            # Simple python wrapper for Vigenere decryption
            python3 -c "
import sys
c, k = sys.argv[1], sys.argv[2]
p = ''
k_idx = 0
for char in c:
    if char.isalpha():
        offset = 65 if char.isupper() else 97
        p += chr((ord(char) - offset - (ord(k[k_idx % len(k)].upper()) - 65)) % 26 + offset)
        k_idx += 1
    else:
        p += char
print(f'Plaintext: {p}')" "$data" "$vkey"
        fi
        ;;
    4)
        # HackTricks: "Frequency analysis & mapping tables"
        echo -e "${C3}[*] Tool Recommended: https://quipqiup.com/${NC}"
        echo "Paste your ciphertext there for automatic frequency analysis."
        ;;
    5)
        # HackTricks: "Bacon looks like groups of 5 bits/letters"
        echo "1) Bacon Decoder"
        echo "2) Morse Decoder"
        read -p "Choice: " eso_opt
        if [ "$eso_opt" == "1" ]; then
             echo -e "${C3}[Tip] Look for patterns like AABBB ABABA (Binary substitution).${NC}"
        fi
        ;;
    6)
        # CyberChef Integration
        echo -e "${C1}[*] CyberChef Magic Mode Link:${NC}"
        echo "https://gchq.github.io/CyberChef/#recipe=Magic(3,false,false,'')"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/crypto/classical_ciphers.sh
