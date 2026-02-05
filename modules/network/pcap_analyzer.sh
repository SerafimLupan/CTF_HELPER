#!/bin/bash
# CTF_HELPER - Advanced PCAP Forensics Engine (English Version)
# Focus: Deep Packet Inspection, Credential Harvesting, and Data Carving

source ./ctf_helper.sh

run_pcap_analyzer() {
    print_banner
    echo -e "${C6}[ADVANCED NETWORK FORENSICS]${NC}"
    read -p "📂 Path to PCAP/PCAPNG file: " pcap

    if [[ ! -f "$pcap" ]]; then
        echo -e "${C1}[!] Error: File not found.${NC}"
        return
    fi

    echo -e "\n${C4}--- Advanced Analysis Menu ---${NC}"
    echo "1) 📊  Total Triage (Protocol Hierarchy, IPs, Ports)"
    echo "2) 🔑  Credential Harvester (HTTP, FTP, Telnet, SMTP, POP3)"
    echo "3) 📄  Object Carver (Extract HTTP, SMB, TFTP, IMF files)"
    echo "4) 🌐  Web & DNS Intel (Hostnames, User-Agents, DNS Queries)"
    echo "5) 🧵  TCP/UDP Stream Follower (Reconstruct content)"
    echo "6) 🕵️  Threat Hunting (Beaconing, Long DNS, Large Payloads)"
    echo "7) 🛠️   Expert Filters (Apply custom Wireshark-style filters)"
    echo "8) 📝  String Search (Brute-force grep & strings)"
    echo "0) ↩️   Back to Main Menu"

    echo -ne "\n${C5}pcap_analyzer > ${NC}"
    read pcap_opt

    case $pcap_opt in
        1) # Total Triage
            echo -e "${C2}[*] Generating Statistics Report...${NC}"
            echo -e "\n${C3}--- Protocol Hierarchy ---${NC}"
            tshark -r "$pcap" -z io,phs -q
            echo -e "\n${C3}--- Top 20 IP Conversations ---${NC}"
            tshark -r "$pcap" -z conv,ip -q | head -n 25
            echo -e "\n${C3}--- Destination Ports (Service Discovery) ---${NC}"
            tshark -r "$pcap" -T fields -e tcp.dstport -e udp.dstport | sort | uniq -c | sort -nr | head -n 20
            ;;

        2) # Credentials
            echo -e "${C2}[*] Harvesting authentication data...${NC}"
            tshark -r "$pcap" -Y "http.request.method == POST || ftp.request.command == USER || ftp.request.command == PASS || imap.request || pop.request || smtp.auth" -T fields -e frame.number -e ip.src -e ip.dst -e text | grep -iE "user|pass|login|auth|pwd|credential"
            echo -e "\n${C3}[*] Checking HTTP Basic Auth (Base64 Decode):${NC}"
            tshark -r "$pcap" -Y "http.authbasic" -T fields -e http.authbasic | while read line; do echo -n "Decoded: "; echo "$line" | base64 -d; echo ""; done
            ;;

        3) # Object Carver
            echo -e "${C2}[*] Extracting files from traffic...${NC}"
            mkdir -p ./extracted_pcap_data
            tshark -r "$pcap" --export-objects http,./extracted_pcap_data -q
            tshark -r "$pcap" --export-objects smb,./extracted_pcap_data -q
            tshark -r "$pcap" --export-objects tftp,./extracted_pcap_data -q
            echo -e "${C5}[+] Objects saved in ./extracted_pcap_data${NC}"
            ;;

        4) # Web & DNS
            echo -e "${C2}[*] Analyzing DNS & HTTP Metadata...${NC}"
            echo -e "\n${C3}--- DNS Queries ---${NC}"
            tshark -r "$pcap" -T fields -e dns.qry.name -Y "dns.flags.response == 0" | sort | uniq -c | sort -nr
            echo -e "\n${C3}--- HTTP Hosts & User-Agents ---${NC}"
            tshark -r "$pcap" -Y "http.request" -T fields -e http.host -e http.user_agent | sort | uniq -c
            ;;

        5) # Stream Follower
            echo -ne "${C5}Protocol (tcp/udp): ${NC}" ; read proto
            echo -ne "${C5}Stream Index: ${NC}" ; read s_index
            tshark -r "$pcap" -z "follow,$proto,ascii,$s_index" -q | less
            ;;

        6) # Threat Hunting
            echo -e "${C2}[*] Hunting for Beaconing & Tunnels...${NC}"
            echo -e "\n${C3}--- Potential DNS Tunnels (Long Queries) ---${NC}"
            tshark -r "$pcap" -T fields -e dns.qry.name | awk 'length($0) > 50' | sort -u
            echo -e "\n${C3}--- Large Data Transfers (High Frame Length) ---${NC}"
            tshark -r "$pcap" -Y "frame.len > 1200" -q -z io,stat,1
            ;;

        7) # Expert Filters
            read -p "Enter Wireshark filter (e.g., ip.addr == 10.10.10.1): " u_filter
            tshark -r "$pcap" -Y "$u_filter" -T fields -e frame.number -e ip.src -e ip.dst -e _ws.col.Info | head -n 50
            ;;

        8) # String Search
            read -p "Search for keyword (e.g., flag{, CTF, password): " search_str
            grep -aE "$search_str" "$pcap" | strings -n 6
            ;;

        0) return ;;
    esac

    echo -e "\n${C3}--------------------------------------------------${NC}"
    read -p "Press Enter to continue..."
    run_pcap_analyzer
}
