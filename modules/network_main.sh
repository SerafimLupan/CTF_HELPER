#!/bin/bash
# CTF_HELPER - Network Master Orchestrator

function run_network_main() {
    print_banner
    echo -e "${C6}[NETWORK SERVICES PENTESTING]${NC}"
    echo -e "1) 🛠️  Common Services (FTP, SSH, SMTP, Telnet, DNS)"
    echo -e "2) 🗄️  Databases (MySQL, Postgres, Redis, MongoDB, MSSQL)"
    echo -e "3) 🖥️  Windows/AD (SMB, RPC, LDAP, Kerberos, RDP)"
    echo -e "4) 🛰️  Infrastructure & VoIP (SNMP, NTP, TFTP, SIP)"
    echo -e "5) 📦  Modern Stack (Docker, Kubernetes, Redis, Memcache)"
    echo -e "6) 📦  PCAP/PCAPNG Analyzer (Forensics)"
    echo -e "0) ↩️  Back to Main Menu"

    echo -ne "\n${C5}Category Selection: ${NC}"
    read nopt

    case $nopt in
        1) source ./modules/network/common_services.sh; run_common_services ;;
        2) source ./modules/network/db_services.sh; run_db_services ;;
        3) source ./modules/network/win_services.sh; run_win_services ;;
        4) source ./modules/network/infra_services.sh; run_infra_services ;;
        5) source ./modules/network/modern_services.sh; run_modern_services ;;
        6) source ./modules/network/pcap_analyzer.sh; run_pcap_analyzer ;;
        0) return ;;
        *) echo -e "${C1}Invalid option.${NC}"; sleep 1 ;;
    esac
}
