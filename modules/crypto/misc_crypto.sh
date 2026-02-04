#!/bin/bash
# CTF_HELPER - Miscellaneous Crypto & Esoteric Encodings
# Focus: Esolangs, Shamir Secret Sharing, and Salted OpenSSL Blobs

source ./ctf_helper.sh

echo -e "${C6}[MODULE: MISC CRYPTO]${NC}"
echo -e "Handling rare primitives, Esolangs, and Secret Sharing\n"

echo "1) Esoteric Language Identifier (Brainfuck, Ook, Piet)"
echo "2) Shamir Secret Sharing (SSS) Reconstructor"
echo "3) OpenSSL Salted File Brute-force"
echo "4) Fernet Token Decoder (Python Cryptography)"
echo "5) Identification Checklist (HackTricks Misc)"
echo "0) Back to Crypto Menu"

echo -en "\n${C3}misc_helper > ${NC}"
read misc_opt

case $misc_opt in
    1)
        # HackTricks: "Identify the esolang (Google a distinctive token)"
        echo -e "${C2}[*] Common Esolang Tokens:${NC}"
        echo " - Brainfuck: [ ] < > + - . ,"
        echo " - Ook!: Ook. Ook? Ook!"
        echo " - JSFuck: [ ] ( ) ! +"
        echo -e "${C3}[Tip] Use an online interpreter: https://copy.sh/brainfuck/${NC}"
        ;;
    2)
        # HackTricks: "Shamir Secret Sharing (SSS) - multiple shares & threshold t"
        echo -e "${C2}[*] Shamir Secret Sharing Reconstructor:${NC}"
        echo " - If you have enough shares (k >= threshold), you can recover the secret."
        echo " - Tool Recommended: http://christian.gen.co/secrets/"
        echo -e "${C3}[Logic] Uses Lagrange Interpolation over Finite Fields.${NC}"
        
        ;;
    3)
        # HackTricks: "OpenSSL salted formats (header begins with Salted__)"
        read -p "Encrypted file: " enc_file
        read -p "Wordlist: " w_list
        echo -e "${C2}[*] Attempting OpenSSL Brute-force...${NC}"
        # Using a simple loop or specialized BF tool if installed
        if [ -f "/usr/share/wordlists/rockyou.txt" ]; then
            /opt/easy_BFopensslCTF/bf_openssl.sh "$enc_file" "${w_list:-/usr/share/wordlists/rockyou.txt}"
        else
            echo "Please install easy_BFopensslCTF or provide a wordlist."
        fi
        ;;
    4)
        # HackTricks: "Fernet hint: two Base64 strings (token + key)"
        echo -e "${C2}[*] Fernet Token logic (Python cryptography):${NC}"
        echo " - Requires: 32-byte URL-safe base64-encoded key."
        echo " - Command: python3 -c \"from cryptography.fernet import Fernet; f=Fernet(input('Key: ')); print(f.decrypt(input('Token: ')).decode())\""
        ;;
    5)
        # HackTricks: "Grab-bag pages that show up a lot"
        echo -e "${C2}[*] Misc Triage Checklist:${NC}"
        echo " - Is it a 'Custom' cipher? (Look for simple XOR/Addition in a loop)."
        echo " - Is it a Polybius Square or Bifid cipher? (Check for grid patterns)."
        echo " - Check for Morse or DNA encoding (ATCG base sequences)."
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/crypto/misc_crypto.sh
