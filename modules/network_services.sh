#!/bin/bash
# CTF_HELPER - Network Master Orchestrator

source ./ctf_helper.sh

function run_network_main() {
    print_banner
    echo -e "${C6}[NETWORK SERVICES PENTESTING]${NC}"
    echo -e "1) 🛠️  Common Services (FTP, SSH, SMTP, Telnet, DNS)"
    echo -e "2) 🗄️  Databases (MySQL, Postgres, Redis, MongoDB, MSSQL)"
    echo -e "3) 🖥️  Windows/AD (SMB, RPC, LDAP, Kerberos, RDP)"
    echo -e "4) 🛰️  Infrastructure & VoIP (SNMP, NTP, TFTP, SIP)"
    echo -e "5) 📦  Modern Stack (Docker, Kubernetes, Redis, Memcache)"
    echo -e "0) ↩️  Back to Main Menu"

    echo -ne "\n${C5}Category Selection: ${NC}"
    read nopt

    case $nopt in
        1) ./modules/network/common_services.sh ;;
        2) ./modules/network/db_services.sh ;;
        3) ./modules/network/win_services.sh ;;
        4) ./modules/network/infra_services.sh ;;
        5) ./modules/network/modern_services.sh ;;
        0) return ;;
    esac
}
run_network_main
