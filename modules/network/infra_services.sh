#!/bin/bash
# CTF_HELPER - Infrastructure Services Module
# Targets: SNMP (161), NFS (2049), TFTP (69), NTP (123), IPsec/VPN (500)

source ./ctf_helper.sh

echo -e "${C6}[MODULE: INFRASTRUCTURE SERVICES]${NC}"
echo -e "Target: ${C3}$TARGET_IP${NC}\n"

echo "1) SNMP (161/UDP) - Community Brute & Info Dump"
echo "2) NFS (2049)     - Showmount & Root Squash Check"
echo "3) TFTP (69/UDP)  - File Bruteforce (configs/keys)"
echo "4) NTP (123/UDP)  - Query Mode 6 (monlist) Leak"
echo "5) IPsec (500/UDP)- IKE VPN Aggressive Mode Scan"
echo "0) Back to Network Menu"

echo -ne "\n${C5}infra_services > ${NC}"
read iopt

case $iopt in
    1) # SNMP - Based on pentesting-snmp/
        echo -e "${C4}[*] Brute-forcing SNMP communities...${NC}"
        onesixtyone -c /usr/share/wordlists/metasploit/snmp_default_pass.txt "$TARGET_IP"
        echo -ne "\n${C5}Enter community found (default: public): ${NC}"
        read community
        [ -z "$community" ] && community="public"
        snmp-check -t "$TARGET_IP" -c "$community"
        ;;
    2) # NFS - nfs-service-pentesting.md
        echo -e "${C4}[*] Listing NFS Exports...${NC}"
        showmount -e "$TARGET_IP"
        nmap -p 2049 --script nfs-ls,nfs-showmount,nfs-statfs "$TARGET_IP"
        echo -e "\n${C3}Manual Tip: mount -t nfs $TARGET_IP:/path /mnt/nfs -o nolock${NC}"
        ;;
    3) # TFTP - 69-udp-tftp.md
        echo -e "${C4}[*] Scanning for TFTP common files...${NC}"
        # TFTP e UDP și nu listeză fișierele, trebuie să ghicim
        nmap -n -sU -p 69 --script tftp-enum "$TARGET_IP"
        ;;
    4) # NTP - pentesting-ntp.md
        echo -e "${C4}[*] Checking for NTP monlist vulnerability...${NC}"
        ntpq -c readvar "$TARGET_IP"
        nmap -sU -p 123 --script ntp-monlist "$TARGET_IP"
        ;;
    5) # IPsec - ipsec-ike-vpn-pentesting.md
        echo -e "${C4}[*] Scanning for VPN Endpoints (IKE)...${NC}"
        ike-scan -A "$TARGET_IP"
        nmap -sU -p 500 --script ike-version "$TARGET_IP"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/network/infra_services.sh
