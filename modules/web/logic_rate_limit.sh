#!/bin/bash
# HackTricks Ref: bypass-rate-limit.md
# Module: Rate Limit Bypass Techniques

echo -e "${C6}[WEB ATTACK: LOGIC_RATE_LIMIT]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/rate-limit-bypass"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Rate Limit Bypass Vector:${NC}"
echo "1) Header Manipulation (IP Spoofing)"
echo "2) Endpoint Variation (Slashes & Case)"
echo "3) Parameter Padding (Adding dummy data)"
echo "4) Protocol Switching (HTTP/1.1 vs HTTP/2)"
echo "5) Null Byte & Character Injection"
echo "0) Exit"

read -p "Selection: " rate_opt

case $rate_opt in
    1)
        echo -e "\n${C2}[*] IP Spoofing via Headers:${NC}"
        echo "Rotate these headers with random IPs in each request:"
        echo " - X-Forwarded-For: 127.0.0.1"
        echo " - X-Originating-IP: 127.0.0.1"
        echo " - X-Remote-IP: 127.0.0.1"
        echo " - X-Client-IP: 127.0.0.1"
        ;;
    2)
        echo -e "\n${C2}[*] Endpoint Variation:${NC}"
        echo "If /login is rate-limited, try these variations:"
        echo " - /login/ (Trailing slash)"
        echo " - /./login"
        echo " - /LOGIN (If case-insensitive)"
        echo " - /api/v1/login -> /api/v2/login"
        ;;
    3)
        echo -e "\n${C2}[*] Parameter Padding:${NC}"
        echo "Add junk parameters to make each request unique to the WAF:"
        echo " - /login?id=1"
        echo " - /login?id=2"
        echo " - /login?bypass_cache=$(date +%s)"
        ;;
    4)
        echo -e "\n${C2}[*] Protocol & Method Switching:${NC}"
        echo " - Switch from HTTP/1.1 to HTTP/2 (often has different limiters)."
        echo " - Change the method: If POST is limited, try PUT or PATCH."
        ;;
    5)
        echo -e "\n${C2}[*] Character Injection:${NC}"
        echo "Try adding non-printing characters to the path:"
        echo " - /login%00"
        echo " - /login%09 (Tab)"
        echo " - /login%20 (Space)"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
