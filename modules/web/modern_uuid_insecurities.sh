#!/bin/bash
# HackTricks Ref: uuid-guid-look-alike-insecurities
# Module: UUID/GUID Insecurities & Prediction

echo -e "${C6}[WEB ATTACK: MODERN_UUID_INSECURITIES]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/uuid-guid-look-alike-insecurities"
echo -e "--------------------------------------------------"

echo -e "${C4}Select UUID Attack Vector:${NC}"
echo "1) UUID Version Identification"
echo "2) V1 Prediction (Time & MAC Based)"
echo "3) V4 Collision & Randomness Analysis"
echo "4) UUID-to-Timestamp Conversion"
echo "0) Exit"

read -p "Selection: " uuid_opt

case $uuid_opt in
    1)
        echo -e "\n${C2}[*] Identifying UUID Version:${NC}"
        echo "Check the first character of the 3rd group: xxxxxxxx-xxxx-Mxxx-xxxx-xxxxxxxxxxxx"
        echo " - M=1: Version 1 (Time + MAC)"
        echo " - M=4: Version 4 (Random)"
        echo " - M=5: Version 5 (SHA-1 Hash)"
        ;;
    2)
        echo -e "\n${C2}[*] UUID V1 Prediction:${NC}"
        echo "V1 UUIDs are sequential in time and contain the sender's MAC address."
        echo "If you have one UUID from a user, you can brute-force the 'time' bits"
        echo "to find UUIDs generated shortly before or after."
        echo -e "${C4}Tool:${NC} Use 'uuid-picker' or custom scripts to increment clock sequence."
        ;;
    3)
        echo -e "\n${C2}[*] V4 Randomness Issues:${NC}"
        echo "V4 should be random, but weak PRNGs (Pseudo-Random Number Generators)"
        echo "can make them predictable. Check if the server uses a static seed"
        echo "or a low-entropy source for generation."
        ;;
    4)
        echo -e "\n${C2}[*] UUID-to-Timestamp (Recon):${NC}"
        echo "For V1 UUIDs, you can extract the exact nanosecond of creation."
        echo "This is useful for correlating actions or finding account creation times."
        echo -e "${C4}Online Tool:${NC} https://www.uuidtools.com/decode"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
