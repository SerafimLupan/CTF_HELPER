#!/bin/bash
# CTF_HELPER - OSINT & Intelligence Module

run_osint() {
    print_banner
    echo -e "${C6}[CATEGORY: OSINT & RECONNAISSANCE]${NC}"
    
    echo -e "\n${C4}Select OSINT Task:${NC}"
    echo "1) 👤 User Recon (Sherlock - Social Media search)"
    echo "2) 🌍 GEOINT (Image Metadata & Location Triage)"
    echo "3) 🌐 Website Recon (Whois, DNS, Subdomains)"
    echo "4) 📧 Email & Breach Lookups (Leaked data tools)"
    echo "5) 🖼️  Google Dorking Templates (Quick Copy-Paste)"
    echo "0) ↩️  Back"

    echo -ne "\n${C5}osint > ${NC}"
    read oopt

    case $oopt in
        1) # Sherlock
            read -p "🔍 Enter target username: " target
            echo -e "${C2}[*] Searching across 300+ platforms...${NC}"
            sherlock "$target" --timeout 5
            ;;
            
        2) # GEOINT
            read -p "📂 Path to image: " img_path
            echo -e "${C2}[*] Extracting Coordinates & Camera Info...${NC}"
            exiftool "$img_path" | grep -iE "GPS|Location|Make|Model|Create Date"
            echo -e "${C3}\n[TIP] Copy GPS coordinates to: https://www.google.com/maps${NC}"
            ;;

        3) # Domain Recon
            read -p "🌐 Enter domain (ex: target.com): " domain
            echo -e "${C2}[*] DNS Records:${NC}"
            dig +short "$domain" ANY
            echo -e "${C2}[*] Whois Info:${NC}"
            whois "$domain" | grep -iE "Registrant|Admin|Organization|Email"
            ;;

        4) # Breach search
            read -p "📧 Enter email/domain: " email
            echo -e "${C3}[*] Check manually on:${NC}"
            echo "- https://haveibeenpwned.com"
            echo "- https://intelx.io"
            ;;

        5) # Google Dorks
            echo -e "${C2}[*] Useful Dorks for CTF:${NC}"
            echo -e "${C4}site:target.com filetype:pdf \"confidential\"${NC}"
            echo -e "${C4}site:target.com intitle:\"index of /\"${NC}"
            echo -e "${C4}inurl:\"/phpinfo.php\"${NC}"
            ;;

        0) return ;;
    esac
    read -p "Press Enter to continue..."
    run_osint
}
