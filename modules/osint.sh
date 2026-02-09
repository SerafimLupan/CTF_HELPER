#!/bin/bash
# CTF_HELPER - OSINT & Intelligence Module

run_osint() {
    # Folosim o buclă while în loc să re-apelăm funcția
    while true; do
        print_banner
        echo -e "${C6}[CATEGORY: OSINT & RECONNAISSANCE]${NC}"
        
        echo -e "\n${C4}Select OSINT Task:${NC}"
        echo "1) 👤 User Recon (Sherlock)"
        echo "2) 🌍 GEOINT (Exiftool)"
        echo "3) 🌐 Website Recon (DNS/Whois)"
        echo "4) 📧 Email & Breach Lookups"
        echo "5) 🖼️  Google Dorking Templates"
        echo "0) ↩️  Back"

        echo -ne "\n${C5}osint > ${NC}"
        read -r oopt

        case "$oopt" in
            1)
                read -p "🔍 Enter target username: " username
                if [ -z "$username" ]; then
                    echo -e "${C1}[!] No username entered.${NC}"
                else
                    echo -e "${C3}[*] Searching for accounts associated with: $username...${NC}"
                    sherlock "$username" --timeout 5 --print-found
                fi
                ;;
                
            2)
                read -e -p "📂 Path to image: " img_path # -e permite TAB-completion
                if [ -f "$img_path" ]; then
                    echo -e "${C2}[*] Extracting Info...${NC}"
                    exiftool "$img_path" | grep -iE "GPS|Location|Make|Model|Create Date"
                    echo -e "${C3}\n[TIP] Check GPS on Google Maps manually if found.${NC}"
                else
                    echo -e "${C1}[!] File not found.${NC}"
                fi
                ;;

            3)
                read -p "🌐 Enter domain (ex: target.com): " domain
                [ -z "$domain" ] && continue
                echo -e "${C2}[*] DNS Records:${NC}"
                dig +short "$domain" ANY
                echo -e "${C2}\n[*] Whois Info:${NC}"
                whois "$domain" | grep -iE "Registrant|Admin|Organization|Email"
                ;;

            4)
                read -p "📧 Enter email/domain: " email
                echo -e "${C3}[*] Check manually on:${NC}"
                echo "- https://haveibeenpwned.com"
                echo "- https://intelx.io"
                ;;

            5)
                echo -e "${C2}[*] Useful Dorks for CTF:${NC}"
                echo -e "${C4}site:target.com filetype:pdf \"confidential\"${NC}"
                echo -e "${C4}site:target.com intitle:\"index of /\"${NC}"
                echo -e "${C4}inurl:\"/phpinfo.php\"${NC}"
                ;;

            0) 
                return # Ieșire curată în meniul principal
                ;;
            *)
                echo -e "${C1}[!] Invalid option.${NC}"
                ;;
        esac

        echo -e "\n${C2}--------------------------------------------------${NC}"
        read -p "Press Enter to continue..."
    done
}
