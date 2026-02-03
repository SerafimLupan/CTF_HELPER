#!/bin/bash
# HackTricks Ref: iframe-traps.md
# Module: Iframe Traps and Sandboxing Escapes

echo -e "${C6}[WEB ATTACK: IFRAME_TRAPS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/iframe-traps"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Iframe Trap Vector:${NC}"
echo "1) Transparent Overlay Trap (Clickjacking base)"
echo "2) Password Manager Trap (Autofill Stealing)"
echo "3) Sandbox Escape Analysis (Attribute check)"
echo "4) Frame Busting / Reverse Tabnabbing Theory"
echo "0) Exit"

read -p "Selection: " if_opt

case $if_opt in
    1)
        echo -e "\n${C2}[*] Overlay Trap Logic:${NC}"
        echo "Goal: Make the user believe they are on a safe site while interacting with a hidden iframe."
        echo "CSS Payload:"
        echo "  iframe { opacity: 0.0; position: absolute; z-index: 1000; width: 100%; height: 100%; }"
        echo "Use this to intercept clicks meant for a legitimate-looking background."
        ;;
    2)
        echo -e "\n${C2}[*] Password Manager Trap:${NC}"
        echo "If a site is frameable, an attacker can embed it and use hidden forms."
        echo "Many password managers will 'autofill' credentials if the domain matches,"
        echo "even if the iframe is 1x1 pixels or invisible."
        echo -e "${C4}Vector:${NC} Use JavaScript to detect when the hidden fields are filled and send them to your server."
        ;;
    3)
        echo -e "\n${C2}[*] Sandbox Attribute Analysis:${NC}"
        echo "Check for missing restrictions in the 'sandbox' attribute:"
        echo " - allow-same-origin: Allows access to cookies/DOM of the parent."
        echo " - allow-scripts: Allows execution of JS."
        echo " - allow-top-navigation: Allows the iframe to redirect the main page."
        echo " - allow-forms: Allows the iframe to submit data."
        ;;
    4)
        echo -e "\n${C2}[*] Reverse Tabnabbing:${NC}"
        echo "If a site uses <a target='_blank'> without rel='noopener', the new page"
        echo "can control the original tab using 'window.opener.location'."
        echo "Payload (in the new tab):"
        echo "  window.opener.location = 'https://phishing-site.com';"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
