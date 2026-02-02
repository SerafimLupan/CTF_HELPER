#!/bin/bash
# Module: File Analyzer (Native & Forensic Tools)
# Based on: https://book.hacktricks.xyz/generic-methodologies-and-resources/basic-forensic-methodology

function run_file_analyzer() {
    print_banner
    echo -e "${C6}[FILE ANALYZER MODULE]${NC}"
    echo -e "Native Forensic & Identification Tools"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🛠️   Deep File Identification (file + magic bytes)"
    echo -e "2) 📑  Extract All Strings (UTF-16, Little Endian check)"
    echo -e "3) 🔍  Hex View & Header Analysis (xxd)"
    echo -e "4) 📦  Embedded File Discovery (binwalk)"
    echo -e "5) 📅  Metadata Extraction (exiftool)"
    echo -e "6) 🔐  Entropy Calculation (Check for Encryption/Compression)"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Analyzer Selection: ${NC}"
    read fopt

    case $fopt in
        1)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "\n${C4}[*] Standard Identification:${NC}"
                file "$f"
                echo -e "\n${C4}[*] Mime-Type:${NC}"
                file --mime-type "$f"
            fi
            ;;
        2)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "\n${C4}[*] Extracting Interesting Strings (Flag/Pass/User):${NC}"
                strings -n 6 "$f" | grep -iE "flag|ctf|pass|key|admin|user|conf" | head -n 20
                echo -e "\n${C4}[*] Wide Character Strings (UTF-16):${NC}"
                strings -e l "$f" | head -n 10
            fi
            ;;
        3)
            read -p "Path to file: " f
            [ -f "$f" ] && xxd "$f" | head -n 20 | less
            ;;
        4)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "[*] Searching for embedded signatures..."
                binwalk "$f"
                echo -ne "\n${C5}[?] Extract found files automatically? (y/n): ${NC}"
                read ext_opt
                [ "$ext_opt" == "y" ] && binwalk -e "$f"
            fi
            ;;
        5)
            read -p "Path to file: " f
            [ -f "$f" ] && exiftool "$f"
            ;;
        6)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                # Quick entropy check using ent if installed, or a python one-liner
                python3 -c "import collections, math, sys; f=open('$f','rb').read(); e=0; \
                [ (p:=f.count(i)/len(f), (p and (e:=e-p*math.log2(p)))) for i in range(256)]; \
                print(f'Entropy: {e:.4f} (High entropy > 7.5 suggests encryption/compression)')"
            fi
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
