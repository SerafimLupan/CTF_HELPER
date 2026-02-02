#!/bin/bash
# Module: Network Services Pentesting (HackTricks Methodology)
# Targets specific ports and protocols common in CTFs

function run_network_services() {
    print_banner
    echo -e "${C6}[NETWORK SERVICES MODULE]${NC}"
    echo -e "Protocol-Specific Enumeration (HackTricks Style)"
    echo -e "------------------------------------------------"
    echo -e "1) 📂  SMB (445) - enum4linux / smbclient"
    echo -e "2) 📁  FTP (21) - Anonymous login & recursion"
    echo -e "3) 🛰️   SNMP (161/162) - snmp-check / onesixtyone"
    echo -e "4) 📧  SMTP (25) - User Enumeration"
    echo -e "5) 🌐  DNS (53) - Zone Transfer (AXFR)"
    echo -e "6) 🛠️   Nmap Script Scan (Vulners/Safe)"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Network Selection: ${NC}"
    read nopt

    case $nopt in
        1)
            read -p "Target IP: " ip
            echo -e "[*] Running enum4linux..."
            enum4linux -a "$ip"
            echo -e "\n[*] Checking shares (NULL Session)..."
            smbclient -L "//$ip/" -N
            ;;
        2)
            read -p "Target IP: " ip
            echo -e "[*] Attempting Anonymous FTP login..."
            ftp -n "$ip" <<END_SCRIPT
quote USER anonymous
quote PASS anonymous
ls -R
quit
END_SCRIPT
            ;;
        3)
            read -p "Target IP: " ip
            echo -e "[*] Brute-forcing Communities..."
            onesixtyone "$ip"
            echo -e "[*] Running SNMP Enumeration..."
            snmp-check "$ip"
            ;;
        4)
            read -p "Target IP: " ip
            read -p "Wordlist Path [/usr/share/wordlists/metasploit/unix_users.txt]: " wlist
            wlist=${wlist:-/usr/share/wordlists/metasploit/unix_users.txt}
            smtp-user-enum -M VRFY -U "$wlist" -t "$ip"
            ;;
        5)
            read -p "Domain: " dom
            read -p "Nameserver (IP): " ns
            echo -e "[*] Attempting Zone Transfer..."
            dig axfr "@$ns" "$dom"
            ;;
        6)
            read -p "Target IP: " ip
            echo -e "[*] Running Nmap Vuln scan..."
            nmap -sV --script=vulners,safe "$ip"
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid choice.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
