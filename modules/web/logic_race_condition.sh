#!/bin/bash
# HackTricks Ref: race-condition.md
# Module: Race Condition (Limit Overrun & Timing)

echo -e "${C6}[WEB ATTACK: LOGIC_RACE_CONDITION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/race-condition"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Race Condition Vector:${NC}"
echo "1) Limit Overrun (Gift Cards/Coupons)"
echo "2) Multi-Endpoint Race (Validation Bypass)"
echo "3) Single-Packet Attack (HTTP/2 Theory)"
echo "4) File Upload Race (Execution before deletion)"
echo "0) Exit"

read -p "Selection: " race_opt

case $race_opt in
    1)
        echo -e "\n${C2}[*] Limit Overrun Attack:${NC}"
        echo "Goal: Use a single-use coupon multiple times by sending requests simultaneously."
        echo "Method: Use Burp Intruder or Turbo Intruder with 50+ concurrent threads."
        echo "Example: POST /api/redeem-coupon HTTP/1.1 (Payload: {'code':'FREE10'})"
        ;;
    2)
        echo -e "\n${C2}[*] Multi-Endpoint Race:${NC}"
        echo "Exploit the gap between two different actions (e.g., Change Email & Verify)."
        echo "1. Trigger 'Change Email' to a victim's address."
        echo "2. Simultaneously trigger another action that uses the 'old' state."
        ;;
    3)
        echo -e "\n${C2}[*] Single-Packet Attack (HTTP/2):${NC}"
        echo "Advanced: Send multiple HTTP requests within a single TCP packet."
        echo "This eliminates network jitter, making requests arrive at the server at the exact same nanosecond."
        echo "Tool: Burp Suite - Turbo Intruder (engine=Engine.HTTP2)"
        ;;
    4)
        echo -e "\n${C2}[*] File Upload Race:${NC}"
        echo "If the server saves a file, checks it for viruses, and then deletes it if malicious:"
        echo "1. Upload 'shell.php'."
        echo "2. Simultaneously try to access 'shell.php' in a loop."
        echo "If you access it before the server deletes it, you get RCE."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
