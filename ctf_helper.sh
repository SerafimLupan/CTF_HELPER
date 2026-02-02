#!/bin/bash

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
    echo -e "                   | by Lupan \"Tirasp0l\" Serafim | more info: serafimlupan.com |"
    echo -e "--------------------------------------------------------------------------------------------------------\n"
}

# --- Main Menu ---
while true; do
    print_banner
    echo -e "${C6} 1)${NC} 🌐 Pentesting Web             ${C6} 8)${NC} 🖼️  Stego"
    echo -e "${C6} 2)${NC} 🔌 Network Services          ${C6} 9)${NC} 🧬 Binary Exploitation"
    echo -e "${C6} 3)${NC} 🛡️  Linux Hardening           ${C6}10)${NC} 🏁 Windows Hardening"
    echo -e "${C6} 4)${NC} 🔍 Reversing                 ${C6}11)${NC} 📱 Mobile Pentesting"
    echo -e "${C6} 5)${NC} 🔐 Crypto                    ${C6}12)${NC} 🤖 AI Security"
    echo -e "${C6} 6)${NC} ⛓️  Blockchain               ${C6}13)${NC} ⚙️  Generic Methodologies"
    echo -e "${C6} 7)${NC} 📂 File Analyzer             ${C6} 0)${NC} ❌ Exit"

    echo -ne "\n${C5}Select a category to explore: ${NC}"
    read opt

    case $opt in
        1) # logic for pentesting-web
           ;;
        3) # logic for linux-hardening
           ;;
        7) # file analyzer
           ;;
        0) echo -e "${C6}Exiting. Happy Hacking!${NC}"; exit 0 ;;
        *) echo -e "${C1}Category logic not yet implemented.${NC}"; sleep 1 ;;
    esac
done
