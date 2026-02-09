#!/bin/bash
# CTF_HELPER - Hash Cracking & Logic Attacks
# Focus: Brute-force automation and Length Extension Attacks

echo -e "${C6}[MODULE: HASHES & CRACKING]${NC}"
echo -e "Automating identification, brute-force, and extension attacks\n"

echo "1) Identify Hash Type (hashid/hashcat mode)"
echo "2) Crack with John the Ripper (CPU)"
echo "3) Crack with Hashcat (GPU/High Performance)"
echo "4) Hash Length Extension Attack (HashPump)"
echo "5) Online Lookup (CrackStation/MD5Decrypt)"
echo "0) Back to Crypto Menu"

echo -en "\n${C3}hash_helper > ${NC}"
read hash_opt

case -r $hash_opt in
    1)
        # HackTricks: "Identify the hash first"
        read -p "Enter hash string: " h_str
        echo -e "${C2}[*] Analyzing hash structure...${NC}"
        hashid -m -j "$h_str"
        echo -e "${C3}[Tip] Check if it's salted (salt\$hash) or a slow KDF like bcrypt.${NC}"
        ;;
    2)
        # HackTricks: "Try many formats with John"
        read -p "File containing hashes: " h_file
        read -p "Wordlist path: " w_list
        john --wordlist="${w_list:-/usr/share/wordlists/rockyou.txt}" "$h_file"
        ;;
    3)
        # HackTricks: "Determine mode mode: hashcat --example-hashes"
        read -p "Hashcat Mode (-m): " h_mode
        read -p "Hash file: " h_file
        read -p "Wordlist path: " w_list
        hashcat -m "$h_mode" -a 0 "$h_file" "${w_list:-/usr/share/wordlists/rockyou.txt}"
        ;;
    4)
        # HackTricks: "Exploit sig = HASH(secret || message)"
        echo -e "${C2}[*] Starting Length Extension Attack...${NC}"
        read -p "Original Signature: " sig
        read -p "Original Data: " data
        read -p "Estimated Secret Length: " slen
        read -p "Data to Append: " append
        hashpump -s "$sig" -d "$data" -k "$slen" -a "$append"
        
        ;;
    5)
        # HackTricks: "Google the hash or use online DBs"
        echo -e "${C1}[*] Popular Online Resources:${NC}"
        echo " - https://crackstation.net/ (General)"
        echo " - https://md5decrypt.net/ (MD5/SHA/Bcrypt)"
        echo " - https://hashes.org/ (Database search)"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/crypto/hash_cracking.sh
