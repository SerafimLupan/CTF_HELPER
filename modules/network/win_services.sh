#!/bin/bash
# CTF_HELPER - Windows & Active Directory Services
# Targets: MSRPC (135), SMB (445), LDAP (389), Kerberos (88), RDP (3389), WinRM (5985)

source ./ctf_helper.sh

echo -e "${C6}[MODULE: WINDOWS & AD SERVICES]${NC}"
echo -e "Target: ${C3}$TARGET_IP${NC}\n"

echo "1) SMB (139/445)   - Shares, Null Sessions & Vulnerabilities"
echo "2) MSRPC (135/593) - User/Pipe Enumeration (rpcclient)"
echo "3) LDAP (389/636)  - Domain Recon & Null Bind Search"
echo "4) Kerberos (88)   - User Enumeration & Pre-Auth (AS-REP)"
echo "5) RDP (3389)      - Security Check & NLA Detection"
echo "6) WinRM (5985/86) - PowerShell Remoting Check"
echo "0) Back to Network Menu"

echo -ne "\n${C5}win_services > ${NC}"
read wopt

case $wopt in
    1) # SMB - Based on pentesting-smb/
        echo -e "${C4}[*] Enumerating SMB (Null Session & Shares)...${NC}"
        smbclient -L //"$TARGET_IP"/ -N
        enum4linux -a "$TARGET_IP"
        nmap -p 445 --script smb-enum-shares,smb-vuln-ms17-010,smb-os-discovery "$TARGET_IP"
        ;;
    2) # MSRPC - 135-pentesting-msrpc.md
        echo -e "${C4}[*] Querying RPC Endpoints...${NC}"
        rpcclient -U "" -N "$TARGET_IP" -c "enumdomusers; querydominfo; netshareenumall"
        nmap -p 135 --script msrpc-enum "$TARGET_IP"
        ;;
    3) # LDAP - pentesting-ldap.md
        echo -e "${C4}[*] Attempting LDAP Null Bind & RootDSE...${NC}"
        ldapsearch -x -H ldap://"$TARGET_IP" -s base namingcontexts
        nmap -n -sV --script "ldap* and not brute" -p 389 "$TARGET_IP"
        ;;
    4) # Kerberos - pentesting-kerberos-88/
        echo -e "${C4}[*] Enumerating Users via Kerbrute (Port 88)...${NC}"
        read -p "Domain (ex: corp.local): " domain
        kerbrute userenum --dc "$TARGET_IP" -d "$domain" /usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt
        ;;
    5) # RDP - pentesting-rdp.md
        echo -e "${C4}[*] Checking RDP Encryption & NLA...${NC}"
        nmap -p 3389 --script rdp-enum-encryption,rdp-ntlm-info "$TARGET_IP"
        ;;
    6) # WinRM - 5985-5986-pentesting-winrm.md
        echo -e "${C4}[*] Validating WinRM Service...${NC}"
        nmap -p 5985,5986 --script http-ntlm-info "$TARGET_IP"
        echo -e "${C3}Manual Tip: evil-winrm -i $TARGET_IP -u user -p pass${NC}"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/network/win_services.sh
