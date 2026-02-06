#!/bin/bash
# CTF_HELPER - Forensics & File Triage Module

# --- SUB-FUNCTION: VOLATILITY ENGINE ---
run_volatility_logic() {
    local mem_file=$1
    
    # Check if volatility is installed
    if ! command -v vol &> /dev/null && ! command -v volatility &> /dev/null; then
        echo -e "${C1}[!] Volatility 3 not found. Please install it first.${NC}"
        return
    fi

    # Determine command alias (some systems use 'vol', others 'volatility')
    local vol_cmd="vol"
    command -v volatility &> /dev/null && vol_cmd="volatility"

    print_banner
    echo -e "${C6}[VOLATILITY 3 ENGINE]${NC}"
    echo -e "Target: ${C2}$(basename "$mem_file")${NC}\n"

    echo "1) 📋 Windows: PsList & PsScan (Process Triage)"
    echo "2) ⌨️  Windows: CmdLine & Console (Command History)"
    echo "3) 🔑 Windows: Hashdump (Extract SAM/SYSTEM hashes)"
    echo "4) 📂 Windows: Filescan (Find interesting files)"
    echo "5) 🌐 Windows: NetStat (Network Connections)"
    echo "6) 🐧 Linux: PsList & Lsof (Experimental)"
    echo "0) ↩️  Back to Forensics Menu"

    echo -ne "\n${C5}volatility > ${NC}"
    read vopt

    case $vopt in
        1) $vol_cmd -f "$mem_file" windows.pslist.PsList ;;
        2) 
            echo -e "${C2}[*] Extracting command history...${NC}"
            $vol_cmd -f "$mem_file" windows.cmdline.CmdLine
            ;;
        3) 
            echo -e "${C2}[*] Dumping hashes (SAM)...${NC}"
            $vol_cmd -f "$mem_file" windows.hashdump.Hashdump
            ;;
        4) 
            read -p "Filter by name (e.g., 'flag', 'zip'): " ffilter
            $vol_cmd -f "$mem_file" windows.filescan.FileScan | grep -i "$ffilter"
            ;;
        5) $vol_cmd -f "$mem_file" windows.netstat.NetStat ;;
        6) 
            echo -e "${C3}[!] Linux analysis requires specific symbols/profiles.${NC}"
            $vol_cmd -f "$mem_file" linux.pslist.PsList
            ;;
        0) return ;;
    esac
    
    echo -e "\n${C3}--------------------------------------------------${NC}"
    read -p "Press Enter to continue..."
    run_volatility_logic "$mem_file"
}

# --- MAIN FUNCTION: FORENSICS ---
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
