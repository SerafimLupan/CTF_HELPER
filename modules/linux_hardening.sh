#!/bin/bash
# Module: Linux Hardening & PrivEsc (HackTricks Methodology)

function run_linux_hardening() {
    print_banner
    echo -e "${C6}[LINUX HARDENING & PRIVESC MODULE]${NC}"
    echo -e "Based on: https://book.hacktricks.xyz/linux-hardening/privilege-escalation"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🔑  SUID Binaries (Căutare vectori GTFOBins)"
    echo -e "2) 🛠️   Capabilities (Căutare getcap)"
    echo -e "3) 📝  Writable Files/Dirs (Check for misconfigurations)"
    echo -e "4) 🕵️   Cron Jobs (Sarcini programate & scripturi)"
    echo -e "5) 💾  Sudo Rights (sudo -l)"
    echo -e "6) 📂  Sensitive Files (Shadow, Backup, SSH keys)"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Hardening Selection: ${NC}"
    read lopt

    case $lopt in
        1)
            echo -e "\n[*] Searching for SUID binaries..."
            find / -perm -u=s -type f 2>/dev/null | grep -v "Permission denied"
            echo -e "\n${C4}Tip:${NC} Cross-reference found binaries with https://gtfobins.github.io/"
            ;;
        2)
            echo -e "\n[*] Searching for Capabilities..."
            getcap -r / 2>/dev/null
            ;;
        3)
            echo -e "\n[*] Searching for world-writable files/directories..."
            find / -writable -type d 2>/dev/null | grep -v "proc"
            echo -e "\n[*] Writable files (excluding sys/proc):"
            find / -writable -type f 2>/dev/null | grep -vE "proc|sys"
            ;;
        4)
            echo -e "\n[*] Checking Cron Jobs..."
            ls -la /etc/cron* 2>/dev/null
            cat /etc/crontab 2>/dev/null
            echo -e "\n[*] User Crontabs:"
            for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -l 2>/dev/null; done
            ;;
        5)
            echo -e "\n[*] Checking current sudo privileges..."
            sudo -l
            ;;
        6)
            echo -e "\n[*] Checking for sensitive files..."
            echo -ne "SSH Keys: "
            find / -name "id_rsa" -o -name "authorized_keys" 2>/dev/null
            echo -ne "Backups: "
            find / -name "*.bak" -o -name "*.old" 2>/dev/null
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
