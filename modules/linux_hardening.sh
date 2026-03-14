#!/bin/bash
# Module: Linux Hardening & PrivEsc (HackTricks Methodology)

function run_linux_hardening() {
    print_banner
    echo -e "${C6}[LINUX HARDENING & PRIVESC MODULE]${NC}"
    echo -e "Based on: https://book.hacktricks.xyz/linux-hardening/privilege-escalation"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) OS info"
    echo -e "2) Path"
    echo -e "3) Env info"
    echo -e "4) Kernel exploits"
    echo -e "5) CVE-2016-5195 (DirtyCow)"
    echo -e "6) Sudo version"
    echo -e "7) More system enumeration"
    echo -e "0) Return to Main Menu"

    echo -ne "\n${C5}Hardening Selection: ${NC}"
    read lopt

    case $lopt in
        1)
            echo -e "\n[*] OS info..."
            (cat /proc/version || uname -a ) 2>/dev/null
            lsb_release -a 2>/dev/null # old, not by default on many systems
            cat /etc/os-release 2>/dev/null # universal on modern systems
            ;;
        2)
            echo -e "\n[*] Path..."
            echo $PATH
            ;;
        3)
            echo -e "\n[*]  Env info..."
            (env || set) 2>/dev/null
            ;;
        4)
            echo -e "\n[*] Check the kernel version and if there is some exploit that can be used to escalate privileges..."
            cat /proc/version
            uname -a
            searchsploit "Linux Kernel"
            ;;
        5)
            echo -e "\n[*] Linux Privilege Escalation - Linux Kernel <= 3.19.0-73.8..."
            # make dirtycow stable
            echo 0 > /proc/sys/vm/dirty_writeback_centisecs
            g++ -Wall -pedantic -O2 -std=c++11 -pthread -o dcow 40847.cpp -lutil https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs https://github.com/evait-security/ClickNRoot/blob/master/1/exploit.c
            ;;
        6)
            echo -e "\n[*] Based on the vulnerable sudo versions that appear in..."
            searchsploit sudo
            echo -e "\n[*] You can check if the sudo version is vulnerable using this grep...."
            sudo -V | grep "Sudo ver" | grep "1\.[01234567]\.[0-9]\+\|1\.8\.1[0-9]\*\|1\.8\.2[01234567]"
            ;;
        7) 
            echo -r "\n[*] More system enumeration..."
            date 2>/dev/null #Date
            (df -h || lsblk) #System stats
            lscpu #CPU info
            lpstat -a 2>/dev/null #Printers info
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
