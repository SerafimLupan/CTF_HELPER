#!/bin/bash
# CTF_HELPER - Miscellaneous & Quick Wins Module

run_misc() {
    print_banner
    echo -e "${C6}[CATEGORY: MISCELLANEOUS]${NC}"
    
    echo -e "\n${C4}Select Misc Task:${NC}"
    echo "1) 🧠 Esoteric Languages Decoder (Brainfuck, Morse, etc.)"
    echo "2) 🔓 Archive Cracker (Zip, Rar, Tar - Bruteforce)"
    echo "3) 🐍 PyJail / Escape Sandbox Triage"
    echo "4) 🕵️  Discord/Social OSINT Quick-Look"
    echo "5) 🔢 Base-All Decoder (Auto-detect Base16/32/58/64/85)"
    echo "0) ↩️  Back"

    echo -ne "\n${C5}misc > ${NC}"
    read mopt

    case $mopt in
        1) # Esolangs
            echo -e "${C2}[*] Brainfuck / Ook / Morse Triage${NC}"
            read -p "Enter string or file path: " esodata
            # Dacă e fișier, îl citim
            [[ -f "$esodata" ]] && esodata=$(cat "$esodata")
            
            echo -e "${C3}Try using CyberChef or these CLI tools:${NC}"
            echo "1. Brainfuck: 'beef $esodata'"
            echo "2. Morse: https://morsedecoder.com"
            ;;
            
        2) # Archive Cracking
            read -p "📂 Path to archive: " archive
            read -p "📖 Path to wordlist (default: rockyou.txt): " wlist
            wlist=${wlist:-/usr/share/wordlists/rockyou.txt}
            
            if [[ "$archive" == *.zip ]]; then
                fcrackzip -u -D -p "$wlist" "$archive"
            elif [[ "$archive" == *.rar ]]; then
                john --wordlist="$wlist" --format=rar "$archive"
            fi
            ;;

        3) # PyJail
            echo -e "${C2}[*] Common PyJail Payloads:${NC}"
            echo "__import__('os').system('cat flag.txt')"
            echo "().__class__.__mro__[1].__subclasses__()"
            echo "print(open('flag.txt').read())"
            ;;

        4) # OSINT
            read -p "🔍 Username/ID: " target
            echo -e "${C2}[*] Running Sherloock for $target...${NC}"
            sherlock "$target"
            ;;

        5) # Base-All
            read -p "🔢 Enter encoded string: " bdata
            echo -e "${C2}[*] Attempting multi-base decode...${NC}"
            echo "$bdata" | basenc --base64 -d 2>/dev/null && echo " (Base64)"
            echo "$bdata" | basenc --base32 -d 2>/dev/null && echo " (Base32)"
            echo "$bdata" | basenc --base16 -d 2>/dev/null && echo " (Base16/Hex)"
            ;;

        0) return ;;
    esac
    read -p "Press Enter to continue..."
    run_misc
}
