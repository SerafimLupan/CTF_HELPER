#!/bin/bash
# HackTricks Ref: unicode-injection
# Module: Unicode Normalization & Transformation Attacks

echo -e "${C6}[WEB ATTACK: UNICODE_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/unicode-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Unicode Attack Vector:${NC}"
echo "1) Unicode Case Mapping Collision (Auth Bypass)"
echo "2) Normalization Bypass (NFC/NFD/NFKC/NFKD)"
echo "3) Overlong UTF-8 Encoding (WAF Bypass)"
echo "4) Visual Homoglyph Attack (IDN Homograph)"
echo "0) Exit"

read -p "Selection: " uni_opt

case $uni_opt in
    1)
        echo -e "\n${C2}[*] Case Mapping Collision:${NC}"
        echo "Example: The Turkish 'ı' (U+0131) when uppercased becomes 'I' (U+0049)."
        echo "If you register as 'admın', and the app converts to uppercase to check"
        echo "uniqueness, it might collide with 'ADMIN'."
        echo -e "${C4}Payloads:${NC} admın, ᴀᴅᴍɪɴ, ⓐⓓⓜⓘⓝ"
        ;;
    2)
        echo -e "\n${C2}[*] Normalization Bypass:${NC}"
        echo "Server A might normalize BEFORE security checks, Server B AFTER."
        echo "Example: '＜img src=x onerror=alert(1)＞' (using Full-width characters)"
        echo "After normalization, these become standard '<' and '>'."
        echo -e "${C4}Tool:${NC} Use 'Unicode Character Table' to find similar characters."
        ;;
    3)
        echo -e "\n${C2}[*] Overlong UTF-8 Encoding:${NC}"
        echo "Some parsers accept non-shortest form UTF-8."
        echo "Standard '.': %2e"
        echo "Overlong '.': %c0%ae or %e0%80%ae"
        echo "Use this to bypass simple string-matching WAFs for Path Traversal."
        ;;
    4)
        echo -e "\n${C2}[*] Visual Homoglyphs:${NC}"
        echo "Used mainly in Phishing or Account Takeover:"
        echo " - 'google.com' vs 'ɡoogle.com' (uses U+0261 - Latin Small Letter Script G)"
        echo "If the app displays names but doesn't sanitize Unicode, you can impersonate others."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
