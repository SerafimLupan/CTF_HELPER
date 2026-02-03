#!/bin/bash
# HackTricks Ref: captcha-bypass.md
# Module: CAPTCHA Bypass Techniques

echo -e "${C6}[WEB ATTACK: CAPTCHA_BYPASS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/captcha-bypass"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Bypass Technique:${NC}"
echo "1) Check for Static CAPTCHA Value"
echo "2) CAPTCHA Reuse (Replay Attack)"
echo "3) Remove CAPTCHA Parameter"
echo "4) OCR / Automated Solving (Python/Tesseract)"
echo "5) Bypass via Header (User-Agent/X-Forwarded-For)"
echo "0) Exit"

read -p "Selection: " cap_opt

case $cap_opt in
    1)
        echo -e "\n${C2}[*] Static Value Test:${NC}"
        echo "Check if the server accepts a constant value like '0', '1' or 'CAPTCHA'."
        echo "Sometimes developers leave test values in production."
        ;;
    2)
        echo -e "\n${C2}[*] CAPTCHA Reuse:${NC}"
        echo "1. Solve the CAPTCHA once."
        echo "2. Keep the same Session Cookie and CAPTCHA solution."
        echo "3. Repeat the main request (Login/Post) multiple times."
        echo "If it works, the server doesn't invalidate the solution after use."
        ;;
    3)
        echo -e "\n${C2}[*] Parameter Removal:${NC}"
        echo "Try to send the request without the 'captcha' or 'g-recaptcha-response' parameter."
        echo "Example: curl -X POST -d \"user=admin&pass=123\" https://target.com/login"
        echo "If the server only checks if 'captcha == input', removing it might trigger a bypass."
        ;;
    4)
        echo -e "\n${C2}[*] Automated OCR Theory:${NC}"
        echo "If the CAPTCHA is a simple image, use Tesseract:"
        echo "Command: tesseract captcha.png stdout -l eng"
        echo "For complex ones, look for 'Audio Challenge' - often easier to solve via speech-to-text."
        ;;
    5)
        echo -e "\n${C2}[*] Logic Bypass via Headers:${NC}"
        echo "Try changing User-Agent to a known Crawler (Googlebot):"
        echo "Header: User-Agent: Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
        echo "Some sites disable CAPTCHA for search engine indexers."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
