#!/bin/bash
# HackTricks Ref: cors-bypass.md
# Module: CORS (Cross-Origin Resource Sharing) Misconfigurations

echo -e "${C6}[WEB ATTACK: CORS_MISCONFIG]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/cors-bypass"
echo -e "--------------------------------------------------"

echo -e "${C4}Select CORS Vulnerability Pattern:${NC}"
echo "1) Reflection of Origin Header (The '*' fallback)"
echo "2) Null Origin Exploitation"
echo "3) Regex/Prefix Bypass (Subdomain Takeover combo)"
echo "4) Advanced: XSS to CORS Bypass"
echo "5) Automatic Scanner (using 'corscanner')"
echo "0) Exit"

read -p "Selection: " cors_opt

case $cors_opt in
    1)
        echo -e "\n${C2}[*] Origin Reflection Test:${NC}"
        echo "Check if the server reflects the 'Origin' header in 'Access-Control-Allow-Origin'."
        echo "Command: curl -H \"Origin: https://evil.com\" -I https://target.com/api/me"
        echo -e "\n${C1}Vulnerable if response contains:${NC}"
        echo "Access-Control-Allow-Origin: https://evil.com"
        echo "Access-Control-Allow-Credentials: true"
        ;;
    2)
        echo -e "\n${C2}[*] Null Origin Attack:${NC}"
        echo "Some servers allow the 'null' origin (used by local files or sandboxed iframes)."
        echo "Command: curl -H \"Origin: null\" -I https://target.com/api/data"
        echo -e "\n${C4}PoC Concept:${NC}"
        echo "Use an iframe with 'sandbox' attribute to trigger a null origin request from attacker.com."
        ;;
    3)
        echo -e "\n${C2}[*] Regex/Trust Bypass:${NC}"
        echo "Servers often check if the origin STARTS with 'target.com'. Try:"
        echo " - Origin: https://target.com.evil.com"
        echo " - Origin: https://target.com-evil.com"
        echo " - Origin: https://evil-target.com"
        ;;
    4)
        echo -e "\n${C2}[*] XSS to CORS:${NC}"
        echo "If you have XSS on a trusted subdomain (ex: forum.target.com),"
        echo "and the main API (api.target.com) trusts subdomains via CORS,"
        echo "you can use the XSS to pull data from the API even if it's protected."
        ;;
    5)
        read -p "Enter Target URL: " target
        echo -e "${C4}[*] Running CORS Scanner...${NC}"
        # Presupunem că ai corscanner sau un script similar instalat
        python3 -m corscanner -u "$target"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
