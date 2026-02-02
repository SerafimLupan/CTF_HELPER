#!/bin/bash
# Module: Steganography (HackTricks Methodology)
# Based on: https://book.hacktricks.xyz/crypto/stegano-introduction

function run_stego() {
    print_banner
    echo -e "${C6}[STEGANOGRAPHY MODULE]${NC}"
    echo -e "Image & Media Analysis Tools"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🖼️   Image Layers Analysis (LSB/Color Planes)"
    echo -e "2) 🤐  Steghide Extract (Check for hidden data with/without pass)"
    echo -e "3) 🕵️   Check for Hidden EOF Data (Strings at end of file)"
    echo -e "4) 📊  Bit Plane Complexity (stegoveritas/zsteg check)"
    echo -e "5) 🔊  Audio Steganography (Spectrogram reminder)"
    echo -e "6) 🛠️   Fix Corrupt File Headers (PNG/JPG Magic Bytes)"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Stego Selection: ${NC}"
    read sopt

    case $sopt in
        1)
            read -p "Path to image: " img
            if [ -f "$img" ]; then
                echo -e "[*] Opening StegSolve (Manual Analysis)..."
                # StegSolve is a JAR file, assuming it's in a standard path or aliased
                java -jar /opt/stegsolve.jar "$img" 2>/dev/null || echo -e "${C1}[!] StegSolve not found in /opt/. Please check path.${NC}"
            fi
            ;;
        2)
            read -p "Path to file: " f
            read -p "Enter passphrase (leave empty for none): " pass
            if [ -f "$f" ]; then
                steghide extract -sf "$f" -p "$pass"
            fi
            ;;
        3)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "[*] Checking for data after File Termination..."
                # Extracting trailing data after PNG/JPG EOF
                binwalk "$f"
                echo -e "\n[*] Strings at EOF (last 50 lines):"
                tail -n 50 "$f" | strings
            fi
            ;;
        4)
            read -p "Path to file: " f
            if [ -f "$f" ]; then
                echo -e "[*] Running zsteg (LSB detection for PNG/BMP)..."
                zsteg -a "$f" 2>/dev/null || echo "zsteg not found. Install with: gem install zsteg"
            fi
            ;;
        5)
            echo -e "\n${C4}--- Audio Stego Tip ---${NC}"
            echo -e "1. Open file in Audacity."
            echo -e "2. Switch to 'Spectrogram' view."
            echo -e "3. Look for text or patterns in high/low frequencies."
            ;;
        6)
            read -p "Path to file: " f
            echo -e "[*] Current Header (xxd):"
            head -c 8 "$f" | xxd
            echo -e "\n${C4}Expected Headers:${NC}"
            echo -e "PNG: 89 50 4E 47 0D 0A 1A 0A"
            echo -e "JPG: FF D8 FF E0"
            echo -e "GIF: 47 49 46 38 39 61"
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
