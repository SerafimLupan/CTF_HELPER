#!/bin/bash
# Module: Linux Hardening (HackTricks Methodology)

function run_linux_hardening() {
    echo -e "\e[38;5;82m[LINUX HARDENING MODULE]\e[0m"
    echo -e "1) Find SUID Binaries"
    echo -e "2) Check Writable Directories"
    echo -e "3) Check Capabilities"
    echo -e "4) Return to Main Menu"
    
    read -p "Selection: " lopt
    case $lopt in
        1) find / -perm -u=s -type f 2>/dev/null ;;
        2) find / -writable -type d 2>/dev/null ;;
        3) getcap -r / 2>/dev/null ;;
        *) return ;;
    esac
    read -p "Press Enter..."
}
