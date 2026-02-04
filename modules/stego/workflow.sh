#!/bin/bash
# CTF_HELPER - Stego Workflow (Quick Triage)
# Guiding Principle: Identify container -> Metadata -> Carve -> Branch

source ./ctf_helper.sh

echo -e "${C6}[MODULE: STEGO QUICK TRIAGE]${NC}"
read -p "Enter path to target file: " target

if [[ ! -f "$target" ]]; then
    echo -e "${C2}[!] Error: File not found.${NC}"
    exit 1
fi

# 1. Container Identification
echo -e "\n${C1}[STEP 1] Identifying Container & Magic Bytes${NC}"
file "$target"
# Compare extension with real file type
echo -e "${C3}[*] First 32 bytes (Hex):${NC}"
xxd -g 1 -l 32 "$target"


# 2. Metadata and Strings Analysis
echo -e "\n${C1}[STEP 2] Extracting Metadata & High-Signal Strings${NC}"
exiftool -a -u -g1 "$target"

echo -e "\n${C3}[*] Searching for suspicious strings (UTF-16 & ASCII)...${NC}"
# Search for standard ASCII and Little-Endian/Big-Endian Unicode
strings -n 7 "$target" | head -n 15
strings -e l -n 7 "$target" | head -n 15

# 3. Appended Data and Embedded Files
echo -e "\n${C1}[STEP 3] Checking for Appended Data / Embedded Archives${NC}"
binwalk "$target"

echo -e "\n${C2}[*] Manual Check for Trailing Bytes (Last 64 bytes):${NC}"
tail -c 64 "$target" | xxd

# 4. Automated Extraction (If requested)
echo -en "\n${C3}Attempt automated extraction with binwalk/foremost? (y/n): ${NC}"
read extract_opt
if [[ "$extract_opt" == "y" ]]; then
    mkdir -p ./stego_extracted
    echo -e "${C2}[*] Carving with binwalk...${NC}"
    binwalk -e "$target" -C ./stego_extracted
    echo -e "${C2}[*] Carving with foremost...${NC}"
    foremost -i "$target" -o ./stego_extracted/foremost
fi

# 5. Suggested Branching based on file type
echo -e "\n${C1}[STEP 4] Suggested Next Steps:${NC}"
mimetype=$(file -b --mime-type "$target")
case "$mimetype" in
    image/png|image/bmp)
        echo -e "${C4}>> Detected PNG/BMP: Run 'zsteg -a' or check bit-planes in Stegsolve.${NC}" ;;
    image/jpeg)
        echo -e "${C4}>> Detected JPEG: Try 'stegseek' or check DCT coefficients with OutGuess.${NC}" ;;
    audio/*)
        echo -e "${C4}>> Detected Audio: Open in Sonic Visualiser (Spectrogram) or run 'minimodem'.${NC}" ;;
    application/pdf|application/vnd.openxmlformats-officedocument*)
        echo -e "${C4}>> Detected Document: Unzip/PDFDetach to check internal streams.${NC}" ;;
    text/plain)
        echo -e "${C4}>> Detected Text: Check for Zero-Width characters or Whitespace patterns.${NC}" ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return to Stego Menu..."
