#!/bin/bash
# HackTricks Ref: hth-response-smuggling-splitting
# Module: HTTP Response Smuggling & Splitting

echo -e "${C6}[WEB ATTACK: SERVER_SMUGGLING_RESPONSE]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/http-response-smuggling"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Response Smuggling/Splitting Vector:${NC}"
echo "1) HTTP Response Splitting (CRLF Injection)"
echo "2) Response Smuggling (Desync via Reverse Proxy)"
echo "3) Cache Poisoning via Response Splitting"
echo "4) Identification: Header Injection in Responses"
echo "0) Exit"

read -p "Selection: " res_opt

case $res_opt in
    1)
        echo -e "\n${C2}[*] HTTP Response Splitting (CRLF):${NC}"
        echo "Inject \r\n (Carriage Return Line Feed) into headers (e.g., via a redirect)."
        echo "Payload Example (in a 'page' parameter):"
        echo "  ?page=index%0d%0aContent-Length: 0%0d%0a%0d%0aHTTP/1.1 200 OK%0d%0aContent-Type: text/html%0d%0a%0d%0a<html>EXPLOITED</html>"
        ;;
    2)
        echo -e "\n${C2}[*] Response Smuggling (Desync):${NC}"
        echo "Forcing the backend to respond with more data than the frontend expects."
        echo "If the backend sends back two responses for one request, the second"
        echo "response stays in the socket buffer for the next user."
        ;;
    3)
        echo -e "\n${C2}[*] Web Cache Poisoning:${NC}"
        echo "By splitting the response, you can make the proxy cache your"
        echo "second (injected) response as if it were the legitimate page."
        echo "Impact: Every user visiting the page will see your XSS/defacement."
        ;;
    4)
        echo -e "\n${C2}[*] Identification:${NC}"
        echo " - Test if you can set custom headers in the response via input."
        echo " - Use Burp Suite to check if %0d%0a results in new lines in the raw response."
        echo " - Look for headers like 'X-Forwarded-For' reflected in the response."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
