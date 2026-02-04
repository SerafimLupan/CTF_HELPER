#!/bin/bash
# CTF_HELPER - Common Services Module (21, 22, 23, 25, 53, 79)
# Focus: Reliable enumeration and low-hanging fruit discovery

source ./ctf_helper.sh

echo -e "${C6}[MODULE: COMMON SERVICES]${NC}"
echo -e "Target: ${C3}$TARGET_IP${NC}\n"

echo "1) FTP (21)     - Anon Login, Bounce, & ProFTPD exploits"
echo "2) SSH (22)     - Algorithm Audit & User Enumeration"
echo "3) Telnet (23)  - Banner Grabbing & Credential Testing"
echo "4) SMTP (25)    - User Enumeration (VRFY/EXPN) & Smuggling"
echo "5) DNS (53)     - Zone Transfer (AXFR) & Subdomain Brute"
echo "6) Finger (79)  - User Information Leakage"
echo "0) Back to Network Menu"

echo -ne "\n${C5}common_services > ${NC}"
read copt

case $copt in
    1) # FTP - Based on pentesting-ftp/ README
        echo -e "${C2}[*] Testing FTP Anonymous & Scripts...${NC}"
        nmap -sV --script ftp-anon,ftp-bounce,ftp-syst -p 21 "$TARGET_IP"
        ;;
    2) # SSH - Based on pentesting-ssh.md
        echo -e "${C2}[*] Auditing SSH Security...${NC}"
        # ssh-audit este ideal, dar nmap script e fallback-ul rapid
        nmap -p 22 --script ssh-auth-methods,ssh2-enum-algos,ssh-hostkey "$TARGET_IP"
        ;;
    3) # Telnet
        echo -e "${C2}[*] Grabbing Telnet Banner...${NC}"
        curl -t pdu --head telnet://"$TARGET_IP"
        ;;
    4) # SMTP - Based on pentesting-smtp/ README
        echo -e "${C2}[*] Enumerating SMTP Users...${NC}"
        nmap -p 25,465,587 --script smtp-enum-users,smtp-commands,smtp-ntlm-info "$TARGET_IP"
        ;;
    5) # DNS - Based on pentesting-dns.md
        echo -e "${C2}[*] Attempting Zone Transfer (AXFR)...${NC}"
        read -p "Domain (ex: example.com): " dom
        dig axfr @"$TARGET_IP" "$dom"
        host -l "$dom" "$TARGET_IP"
        ;;
    6) # Finger - Based on pentesting-finger.md
        echo -e "${C2}[*] Querying Finger service for users...${NC}"
        finger @"$TARGET_IP"
        nmap -p 79 --script finger "$TARGET_IP"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/network/common_services.sh
