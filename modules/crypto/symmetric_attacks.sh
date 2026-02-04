#!/bin/bash
# CTF_HELPER - Symmetric Crypto Attacks
# Focus: Block Cipher Modes (ECB, CBC, GCM) & Stream Ciphers (CTR, RC4)

source ./ctf_helper.sh

echo -e "${C6}[MODULE: SYMMETRIC CRYPTO]${NC}"
echo -e "Targeting Mode Misuse (Oracle, Malleability, Nonce Reuse)\n"

echo "1) ECB Pattern Detection (Block Leak)"
echo "2) CBC Padding Oracle Attack (PadBuster)"
echo "3) CBC Bit-Flipping PoC (Malleability)"
echo "4) CTR/Stream Nonce Reuse (C1 ^ C2 = P1 ^ P2)"
echo "5) GCM Nonce Reuse (Forbidden Attack)"
echo "0) Back to Crypto Menu"

echo -en "\n${C3}symmetric_helper > ${NC}"
read sym_opt

case $sym_opt in
    1)
        # HackTricks: "equal plaintext blocks -> equal ciphertext blocks"
        echo -e "${C2}[*] ECB Detection Checklist:${NC}"
        echo " - Send 64 'A's as input."
        echo " - Check for identical 16-byte hex blocks in output."
        echo " - Logic: No IV used, each block is independent."
        ;;
    2)
        # HackTricks: "server reveals valid/invalid padding"
        echo -e "${C2}[*] CBC Padding Oracle (PadBuster)${NC}"
        read -p "Target URL/API: " target
        read -p "Encrypted Sample (B64/Hex): " sample
        read -p "Block Size (16 for AES): " bsize
        echo -e "${C3}[!] Running PadBuster...${NC}"
        padbuster "$target" "$sample" "${bsize:-16}" -encoding 0
        ;;
    3)
        # HackTricks: "flipping bits in C[i-1] flips bits in P[i]"
        echo -e "${C2}[*] CBC Bit-Flipping Concept:${NC}"
        echo " Formula: New_Cipher[i-1] = Original_Cipher[i-1] ^ Original_Plain[i] ^ Desired_Plain[i]"
        
        ;;
    4)
        # HackTricks: "keystream reuse (same key+nonce)"
        echo -e "${C2}[*] Keystream Reuse Attack:${NC}"
        read -p "Ciphertext 1 (Hex): " c1
        read -p "Ciphertext 2 (Hex): " c2
        echo -e "${C3}[*] Calculating C1 XOR C2 (Difference of Plaintexts):${NC}"
        python3 -c "
import sys
h1 = bytes.fromhex(sys.argv[1])
h2 = bytes.fromhex(sys.argv[2])
diff = bytes([b1 ^ b2 for b1, b2 in zip(h1, h2)])
print(f'XOR Result: {diff.hex()}')
print(f'ASCII (if printable): {diff}')" "$c1" "$c2"
        ;;
    5)
        # HackTricks: "Loss of integrity guarantees in GCM"
        echo -e "${C2}[!] GCM Nonce Reuse Detected${NC}"
        echo " Vulnerability: Authenticity can be bypassed."
        echo " Recommended tool: https://github.com/nonce-disrespect/nonce-disrespect"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/crypto/symmetric_attacks.sh
