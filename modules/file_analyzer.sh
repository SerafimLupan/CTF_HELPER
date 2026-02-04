#!/bin/bash
# CTF_HELPER - File Analyzer & Forensic Triage
# Based on: https://book.hacktricks.xyz/generic-methodologies-and-resources/basic-forensic-methodology

source ./ctf_helper.sh

function run_file_analyzer() {
    print_banner
    echo -e "${C6}[FILE ANALYZER MODULE]${NC}"
    echo -e "Native Forensic & Identification Tools"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🛠️  Full Identification (File Type + Mime)"
    echo -e "2) 📑  Deep String Extraction (ASCII + UTF-16LE)"
    echo -e "3) 🔍  Hex Header Analysis (xxd)"
    echo -e "4) 📦  Signature & Overlay Search (binwalk)"
    echo -e "5) 📅  Metadata Triage (exiftool)"
    echo -e "6) 🔐  Entropy Check (Encryption Detection)"
    echo -e "7) 🚀  Quick 'All-in-One' Triage"
    echo -e "0) ↩️  Return to Main Menu"

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
                echo -e "\n${C4}[*] ASCII Strings (High Signal):${NC}"
                strings -n 6 "$f" | grep -iE "flag|ctf|pass|key|admin|user|conf|{.*}" | head -n 20
                echo -e "\n${C4}[*] Wide Character Strings (UTF-16LE):${NC}"
                strings -e l -n 6 "$f" | head -n 15
            fi
            ;;
        3)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "\n${C4}[*] Header (First 64 bytes):${NC}"
                head -c 64 "$f" | xxd -g 1
                echo -e "\n${C4}[*] Footer (Last 64 bytes - check for overlays):${NC}"
                tail -c 64 "$f" | xxd -g 1
            fi
            ;;
        4)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "${C4}[*] Searching for embedded signatures...${NC}"
                binwalk "$f"
                echo -ne "\n${C5}[?] Extract found files automatically? (y/n): ${NC}"
                read ext_opt
                [ "$ext_opt" == "y" ] && binwalk -e "$f" --run-as=root
            fi
            ;;
        5)
            read -p "Path to file: " f
            [ -f "$f" ] && exiftool "$f"
            ;;
        6)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                python3 -c "import collections, math, sys; f=open('$f','rb').read(); e=0; \
                [ (p:=f.count(i)/len(f), (p and (e:=e-p*math.log2(p)))) for i in range(256)]; \
                print(f'\n${C2}Shannon Entropy: {e:.4f}${NC}'); \
                print('Interpretation: ' + ('HIGH (Encrypted/Compressed)' if e > 7.5 else 'LOW/MED (Text/Executable/Image)'))"
            fi
            ;;
        7)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "\n${C2}--- QUICK TRIAGE REPORT: $(basename $f) ---${NC}"
                echo -en "${C4}Type: ${NC}" ; file -b "$f"
                echo -en "${C4}Mime: ${NC}" ; file -b --mime-type "$f"
                echo -en "${C4}Entropy: ${NC}" ; python3 -c "import collections, math, sys; f=open('$f','rb').read(); e=0; [ (p:=f.count(i)/len(f), (p and (e:=e-p*math.log2(p)))) for i in range(256)]; print(round(e,4))"
                echo -e "${C4}Magic Bytes:${NC}" ; head -c 16 "$f" | xxd -g 1
                echo -e "${C4}Strings (top 5):${NC}" ; strings -n 6 "$f" | head -n 5
            fi
            ;;
        0) return ;;
        *) echo -e "${C2}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    echo -e "\n--------------------------------------------------"
    read -p "Press Enter to return..."
    run_file_analyzer
}
