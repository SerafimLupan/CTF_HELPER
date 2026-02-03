#!/bin/bash
# HackTricks Ref: idor.md
# Module: IDOR (Insecure Direct Object Reference)

echo -e "${C6}[WEB ATTACK: LOGIC_IDOR]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/idor"
echo -e "--------------------------------------------------"

echo -e "${C4}Select IDOR Testing Vector:${NC}"
echo "1) Parameter ID Manipulation (Classic)"
echo "2) UUID/Hash Prediction & Brute Force"
echo "3) Parameter Pollution (HPP) for Bypass"
echo "4) HTTP Method Switching (GET to POST/PUT)"
echo "5) API Version Downgrade (v2 to v1)"
echo "0) Exit"

read -p "Selection: " idor_opt

case $idor_opt in
    1)
        echo -e "\n${C2}[*] Basic ID Manipulation:${NC}"
        echo "Check URLs and API endpoints for incremental IDs:"
        echo " - /api/user/123 -> /api/user/124"
        echo " - /download/file_10.pdf -> /download/file_9.pdf"
        echo " - /view_invoice?id=2024-001"
        ;;
    2)
        echo -e "\n${C2}[*] Non-Incremental Identifiers:${NC}"
        echo "If IDs are hashes, check if they are predictable (MD5 of email, etc.):"
        echo " - echo -n 'user@mail.com' | md5sum"
        echo "If using UUIDs, look for endpoints that leak them (e.g., public profiles)."
        ;;
    3)
        echo -e "\n${C2}[*] HPP Bypass:${NC}"
        echo "Try to confuse the back-end by providing two IDs:"
        echo " - ?id=YOUR_ID&id=VICTIM_ID"
        echo "Some servers check the first ID for permission, but use the second for the query."
        ;;
    4)
        echo -e "\n${C2}[*] Method & Body Switching:${NC}"
        echo "If GET is protected, try PUT or PATCH with the ID in the body:"
        echo " - PUT /api/profile { \"id\": \"124\", \"email\": \"hacker@evil.com\" }"
        ;;
    5)
        echo -e "\n${C2}[*] API Versioning:${NC}"
        echo "Newer APIs (v2) often have better IDOR protection."
        echo "Try changing the path: /api/v2/user/123 -> /api/v1/user/123"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
