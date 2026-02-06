#!/bin/bash
# CTF_HELPER - Forensics & File Triage Module

run_forensics() {
    print_banner
    echo -e "${C6}[CATEGORY: FORENSICS & FILE ANALYSIS]${NC}"
    read -p "📂 Path to challenge file: " fpath

    if [[ ! -f "$fpath" ]]; then
        echo -e "${C1}[!] Error: File not found.${NC}"
        return
    fi

    echo -e "\n${C4}Select Forensics Task:${NC}"
    echo "1) 🔍 Quick Triage (file, exiftool, strings)"
    echo "2) 🛠️ Magic Bytes Repair (Fix corrupted headers)"
    echo "3) 📦 Binwalk & Carving (Extract hidden data)"
    echo "4) 🎞️ LSB Steganography (zsteg for PNG/BMP)"
    echo "5) 🧠 RAM Analysis (Volatility 3 Menu)"
    echo "0) ↩️ Back"

    echo -ne "\n${C5}forensics > ${NC}"
    read fopt

    case $fopt in
        1) # Quick Triage
            echo -e "${C2}[*] File Type:${NC}" ; file "$fpath"
            echo -e "${C2}[*] Metadata:${NC}" ; exiftool "$fpath"
            echo -e "${C2}[*] Interesting Strings:${NC}"
            strings "$fpath" | grep -iE "flag|CTF|UNB|ROCSC|{.*}" | head -n 20
            ;;
        2) # Magic Bytes Repair
            echo -e "${C3}[!] Top common headers:${NC}"
            echo "PNG: 89 50 4E 47 0D 0A 1A 0A | JPG: FF D8 FF E0"
            echo "PDF: 25 50 44 46 | ZIP: 50 4B 03 04"
            hexeditor "$fpath"
            ;;
        3) # Binwalk
            echo -e "${C2}[*] Searching for embedded files...${NC}"
            binwalk "$fpath"
            read -p "Attempt extraction? (y/n): " ext_opt
            [[ "$ext_opt" == "y" ]] && binwalk -e "$fpath"
            ;;
        4) # Stego
            if [[ "$fpath" == *.png ]] || [[ "$fpath" == *.bmp ]]; then
                zsteg -a "$fpath"
            else
                echo -e "${C1}[!] zsteg only works on PNG/BMP.${NC}"
            fi
            ;;
        5) # Volatility (if implemented)
            run_volatility_logic "$fpath"
            ;;
        0) return ;;
    esac
    read -p "Press Enter to continue..."
}
