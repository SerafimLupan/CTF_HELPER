#!/bin/bash
# CTF_HELPER - Image Steganography Module
# Focus: LSB, Metadata, PNG Chunks, and JPEG DCT Attacks

source ./ctf_helper.sh

echo -e "${C6}[MODULE: IMAGE STEGANOGRAPHY]${NC}"
echo -e "Targeting Pixel-level and Container-level anomalies\n"

echo "1) Automated LSB Analysis (zsteg - PNG/BMP only)"
echo "2) Metadata & Chunk Inspection (exiftool/pngcheck)"
echo "3) JPEG DCT Brute-force (stegseek/stegcracker)"
echo "4) Visual Filter Tips (StegSolve/Aperi'Solve)"
echo "5) Animated Image Analysis (GIF/APNG Frame extraction)"
echo "0) Back to Stego Menu"

echo -en "\n${C3}image_helper > ${NC}"
read img_opt

case $img_opt in
    1)
        # HackTricks: "zsteg enumerates many LSB/bit-plane patterns"
        read -p "Target PNG/BMP: " target
        echo -e "${C2}[*] Running zsteg --all...${NC}"
        zsteg -a "$target"
        ;;
    2)
        # HackTricks: "PNG is a chunked format... check for extra bytes"
        read -p "Target Image: " target
        echo -e "${C2}[*] Detailed Metadata & Chunk Analysis:${NC}"
        exiftool -a -u -g1 "$target"
        if [[ "$target" == *.png ]]; then
            echo -e "${C3}[*] Validating PNG Structure...${NC}"
            pngcheck -vtp "$target"
        fi
        ;;
    3)
        # HackTricks: "stegseek is faster than older scripts"
        read -p "Target JPEG: " target
        read -p "Wordlist (default: rockyou): " wlist
        echo -e "${C2}[*] Attempting Steghide brute-force...${NC}"
        stegseek "$target" "${wlist:-/usr/share/wordlists/rockyou.txt}"
        ;;
    4)
        # HackTricks: "Visual filters can reveal content"
        echo -e "${C1}[*] Visual Inspection Strategy:${NC}"
        echo " - Open StegSolve -> 'Check planes' (R:0, G:0, B:0)."
        echo " - Use Aperi'Solve for a quick web-based gallery of all transforms."
        echo " - Web: https://aperisolve.com/"
        ;;
    5)
        # HackTricks: "Assumption: message is in a single frame or spread across"
        read -p "Target Animated File: " target
        mkdir -p ./frames
        echo -e "${C2}[*] Extracting frames with ffmpeg...${NC}"
        ffmpeg -i "$target" ./frames/frame_%04d.png
        echo -e "${C3}[Tip] Compare frame_0001.png and frame_0002.png for differences.${NC}"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/stego/images.sh
