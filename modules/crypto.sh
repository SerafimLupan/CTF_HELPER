#!/bin/bash
# Module: Cryptography (HackTricks Methodology)

function run_crypto() {
    print_banner
    echo -e "${C6}[CRYPTOGRAPHY MODULE]${NC}"
    echo -e "Based on: https://book.hacktricks.xyz/crypto/cryptography-introduction"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🧠  Identify Hash Type (hash-identifier)"
    echo -e "2) 🔨  Brute-force Hash (John the Ripper)"
    echo -e "3) 🔓  Decrypt Base64 / Hex / Rot13 (Quick)"
    echo -e "4) 🤐  Zip/Archive Password Cracking (fcrackzip)"
    echo -e "5) 🔑  SSH Key Permissions & Passphrase Crack"
    echo -e "6) 📜  Certificate Analysis (OpenSSL)"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Crypto Selection: ${NC}"
    read copt

    case $copt in
        1)
            read -p "Enter Hash: " hash_val
            echo "$hash_val" > /tmp/hash.txt
            hash-identifier <<<$hash_val
            ;;
        2)
            read -p "Path to Hash file: " hfile
            read -p "Format (ex: md5, sha1, nt): " hfmt
            john --format=$hfmt --wordlist=/usr/share/wordlists/rockyou.txt "$hfile"
            ;;
        3)
            read -p "Enter String: " s
            echo -e "\n[*] Base64: $(echo $s | base64 -d 2>/dev/null || echo 'N/A')"
            echo -e "[*] Hex:    $(echo $s | xxd -r -p 2>/dev/null || echo 'N/A')"
            echo -e "[*] Rot13:  $(echo $s | tr 'A-Za-z' 'N-ZA-Mn-za-m')"
            ;;
        4)
            read -p "Path to Zip: " zfile
            fcrackzip -u -d -p /usr/share/wordlists/rockyou.txt "$zfile"
            ;;
        5)
            read -p "Path to SSH Key: " kfile
            chmod 600 "$kfile"
            echo -e "[*] Permissions fixed (600). Attempting to extract hash for John..."
            ssh2john "$kfile" > /tmp/ssh.hash 2>/dev/null
            john --wordlist=/usr/share/wordlists/rockyou.txt /tmp/ssh.hash
            ;;
        6)
            read -p "Path to Certificate (.crt/.pem): " cert
            openssl x509 -in "$cert" -text -noout
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
