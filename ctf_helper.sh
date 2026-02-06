#!/bin/bash

if [[ -n "$CTF_HELPER_LOADED" ]]; then
    return
fi
export CTF_HELPER_LOADED=1

# --- Color Codes (Matrix Green Palette) ---
C1="\e[38;5;22m"  # Darkest
C2="\e[38;5;28m"
C3="\e[38;5;34m"
C4="\e[38;5;40m"
C5="\e[38;5;46m"
C6="\e[38;5;82m"  # Lightest
NC="\e[0m"        # No Color

# --- Print Custom Banner ---
print_banner() {
    clear
    echo -e "${C1}  .g8\"\"\"bgd MMP\"\"MM\"\"YMM \`7MM\"\"\"YMM         \`7MMF'  \`7MMF'\`7MM\"\"\"YMM  \`7MMF'  ${C1}     MMMMMMMMMYMq.   ${NC}${C1}\`7MM\"\"\"YMM  \`7MM\"\"\"Mq. ${NC}"
    echo -e "${C2}.dP'     \`M P'   MM   \`7   MM    \`7           MM      MM    MM    \`7    MM       ${C2}  MMMMMMMMMMMMMbq.${NC}${C2}  MM    \`7    MM   \`MM.${NC}"
    echo -e "${C3}dM'       \`      MM        MM   d             MM      MM    MM   d      MM       ${C3}  MMMMMMMMMMMMMP' ${NC}${C3}  MM   d      MM   ,M9  ${NC}"
    echo -e "${C4}MM               MM        MM\"\"MM             MMmmmmmmMM    MMmmMM      MM        ${C4} MMMMMMMMMdP'    ${NC}${C4}  MMmmMM      MMmmdM9  ${NC}"
    echo -e "${C5}MM               MM        MM   Y             MM      MM    MM   Y  ,   MM      , ${C5} MM              ${NC}${C5}  MM   Y  ,   MM   YM.  ${NC}"
    echo -e "${C5}MM.              MM        MM                 MM      MM    MM     ,M   MM     ,M ${C5} MM              ${NC}${C5}  MM     ,M   MM    \`Mb.${NC}"
    echo -e "${C6}\`Mb.     ,'      MM        MM                 MM      MM    MM     ,M   MM     ,M ${C6} MM              ${NC}${C6}  MM     ,M   MM     \`Mb.${NC}"
    echo -e "${C6} \`\"bmmmd'      .JMML.    .JMML.   mmmmmmm   .JMML.  .JMML..JMMmmmmMMM .JMMmmmmMMM ${C6} MM              ${NC}${C6} .JMMmmmmMMM .JMML.  .JMM.${NC}"
    echo -e ""
    echo -e "        Modular Framework v1.0.0  | by Lupan \"Tirasp0l\" Serafim | more info: serafimlupan.com |"
    echo -e "--------------------------------------------------------------------------------------------------------\n"
}

# --- Import All Modules Dynamically ---
# This looks for any .sh file in /modules and loads it
if [ -d "./modules" ]; then
    for module in ./modules/*.sh; do
        # Verificăm dacă este un fișier regular și avem drept de citire
        if [ -f "$module" ] && [ -r "$module" ]; then
            source "$module"
        fi
    done
else
    echo -e "${C1}[!] Error: /modules directory not found.${NC}"
    exit 1
fi
# --- Main Menu ---
while true; do
    print_banner
    echo -e "${C6} 1)${NC} 🌐 Pentesting Web            ${C6} 10)${NC} 🎲 Miscellaneous"
    echo -e "${C6} 2)${NC} 🔌 Network Services          ${C6} 11)${NC} 🧬 Binary Exploitation"
    echo -e "${C6} 3)${NC} 🛡️ Linux Hardening           ${C6} 12)${NC} 🏁 Windows Hardening"
    echo -e "${C6} 4)${NC} 🔍 Reversing                 ${C6} 13)${NC} 📱 Mobile Pentesting"
    echo -e "${C6} 5)${NC} 🔐 Crypto                    ${C6} 14)${NC} 🤖 AI Security"
    echo -e "${C6} 6)${NC} ⛓️ Blockchain                ${C6} 15)${NC} ⚙️ Generic Methodologies"
    echo -e "${C6} 7)${NC} 📂 File Analyzer             ${C6} 16)${NC} 🕵️ Forensics"
    echo -e "${C6} 8)${NC} 🖼️ Stego                     ${C6} 17)${NC} 🧬 Pwn"
    echo -e "${C6} 9)${NC} 📡 OSINT                     ${C6}  0)${NC} ❌ Exit"

    echo -ne "\n${C5}Select a category to explore: ${NC}"
    read opt

    case $opt in
        1) run_web_pentest ;;
        2) run_network_main ;;
        3) run_linux_hardening ;;
        4) run_reversing ;;
        5) run_crypto ;;
        6) run_blockchain ;;
        7) run_file_analyzer ;;
        9) run_osint ;;
        8) run_stego ;;
        10) run_misc ;;
        11) run_binary_exploit ;;
        12) run_windows_hardening ;;
        13) run_mobile_pentest ;;
        14) run_ai_security ;;
        15) run_generic_methodologies ;;
        16) run_forensics ;;
        17) run_pwn ;;
        0) echo -e "${C6}Exiting. Happy Hacking! ;)${NC}"; exit 0 ;;
        *) echo -e "${C1}Category logic not yet implemented.${NC}"; sleep 1 ;;
    esac
done
