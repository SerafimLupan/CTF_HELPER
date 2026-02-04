#!/bin/bash
# CTF_HELPER - Text Steganography Module
# Focus: Zero-Width characters, Homoglyphs, and Whitespace Encodings

source ./ctf_helper.sh

echo -e "${C6}[MODULE: TEXT STEGANOGRAPHY]${NC}"
echo -e "Identifying invisible data within plaintext and source code\n"

echo "1) Check for Zero-Width Characters (ZWSP/ZWJ)"
echo "2) Unicode Homoglyph Detection (Cyrillic/Latin mixing)"
echo "3) Whitespace Analysis (SNOW / StegSnow)"
echo "4) CSS Unicode-Range Scraper"
echo "5) Python Codepoint Inspector (Deep Analysis)"
echo "0) Back to Stego Menu"

echo -en "\n${C3}text_helper > ${NC}"
read text_opt

case $text_opt in
    1)
        # HackTricks: "Look for characters that render invisibly"
        read -p "Enter text or file path: " input
        echo -e "${C2}[*] Highlighting Zero-Width Characters...${NC}"
        # Use grep to find ZWSP (U+200B), ZWJ (U+200D), etc.
        cat "$input" 2>/dev/null | grep -uaP "[\u200B-\u200D\uFEFF\u200E\u200F]" --color=always
        echo -e "${C3}[Tip] If highlighted dots appear between letters, it is a ZW-channel.${NC}"
        ;;
    2)
        # HackTricks: "Homoglyphs: different Unicode codepoints that look the same"
        read -p "Target file: " target
        echo -e "${C2}[*] Scanning for non-ASCII characters in text...${NC}"
        perl -ne 'print "Line $.: $_" if /[^\x00-\x7F]/' "$target"
        ;;
    3)
        # HackTricks: "Whitespace encodings: spaces vs tabs"
        read -p "Target file: " target
        read -p "Password (leave blank if unknown): " pass
        echo -e "${C2}[*] Attempting StegSnow extraction...${NC}"
        stegsnow -C -p "$pass" "$target"
        ;;
    4)
        # HackTricks: "Extract bytes from unicode-range in CSS"
        read -p "Target CSS file: " target
        echo -e "${C2}[*] Scraping U+ codepoints...${NC}"
        grep -o "U+[0-9A-Fa-f]\+" "$target" | tr -d 'U+\n' | xxd -r -p
        echo ""
        ;;
    5)
        # HackTricks: "Inspect codepoints and normalize carefully"
        read -p "Target file: " target
        echo -e "${C2}[*] Running Python Codepoint Inspector...${NC}"
        python3 -c "
import sys
try:
    with open(sys.argv[1], 'r', encoding='utf-8') as f:
        data = f.read()
        for i, ch in enumerate(data):
            if ord(ch) > 127 or ch.isspace():
                print(f'Pos {i}: {hex(ord(ch))} ({repr(ch)})')
except Exception as e: print(e)" "$target"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/stego/text.sh
