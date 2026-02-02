#!/bin/bash
# Module: Generic Methodologies & Cloud (HackTricks Methodology)
# Focus: OSINT, Cloud Basics, and CTF Strategy

function run_generic_methodologies() {
    print_banner
    echo -e "${C6}[GENERIC METHODOLOGIES & CLOUD]${NC}"
    echo -e "The Attack Mindset & Infrastructure Basics"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🎯  CTF Strategy: Where to Start?"
    echo -e "2) ☁️   Cloud Enumeration (AWS/Azure/GCP)"
    echo -e "3) 🔍  OSINT Quick Links & Tools"
    echo -e "4) 🐳  Docker & Container Breakout Basics"
    echo -e "5) 📋  Post-Exploitation Checklist"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Methodology Selection: ${NC}"
    read gopt

    case $gopt in
        1)
            echo -e "\n${C4}--- CTF Attack Flow ---${NC}"
            echo -e "1. Enumeration: Ports, Services, Web Dirs."
            echo -e "2. Vulnerability Research: Searchsploit, CVEs, HackTricks."
            echo -e "3. Exploitation: Gain initial foothold."
            echo -e "4. Post-Exploitation: Check for local enumeration (SUID, Caps)."
            echo -e "5. Privilege Escalation: Become root/system."
            ;;
        2)
            echo -e "\n[*] Cloud Common Enumeration:"
            echo -e " - AWS: Check for /.aws/credentials or instance metadata (169.254.169.254)"
            echo -e " - Azure: Check for Managed Identities and Storage Account Keys."
            echo -e " - Tool Suggestion: ${C6}cloudlist, pacu, scoutsuite${NC}"
            ;;
        3)
            echo -e "\n[*] OSINT Fundamentals:"
            echo -e " - Whois & Dig (DNS)"
            echo -e " - Shodan / Censys (Internet-wide scan)"
            echo -e " - WayBackMachine (Hidden paths in history)"
            echo -e " - Tool Suggestion: ${C6}theHarvester, spiderfoot${NC}"
            ;;
        4)
            echo -e "\n[*] Docker Breakout Check:"
            echo -e " - Check for .dockerenv file in /"
            echo -e " - Check for privileged mode: 'fdisk -l' (if works, you can mount host drive)"
            echo -e " - Check for exposed docker.sock"
            ;;
        5)
            echo -e "\n${C4}--- Post-Exploitation Steps ---${NC}"
            echo -e " - Who am I? (id, whoami, groups)"
            echo -e " - What's running? (ps -ef, netstat -tunlp)"
            echo -e " - What can I run? (sudo -l)"
            echo -e " - Any interesting files? (ls -laR /home, /opt)"
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
