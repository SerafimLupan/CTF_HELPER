#!/bin/bash
# CTF_HELPER - Steganography Module v2.0
# Based on HackTricks Stego Methodology


echo -e "${C6}
 ██████╗████████╗███████╗ ██████╗  ██████╗ 
██╔════╝╚══██╔══╝██╔════╝██╔════╝ ██╔═══██╗
╚█████╗    ██║   █████╗  ██║  ███╗ ██║   ██║
 ╚═══██╗   ██║   ██╔══╝  ██║   ██║ ██║   ██║
██████╔╝   ██║   ███████╗╚██████╔╝ ╚██████╔╝
╚═════╝    ╚═╝   ╚══════╝ ╚═════╝   ╚═════╝ 
${NC}"

echo -e "${C4}[REFERENCE] https://book.hacktricks.xyz/stego/stego${NC}"
echo -e "------------------------------------------------------------------"

echo -e "${C1}Select Steganography Category:${NC}"
echo "1) 📋 General Triage (Workflow, Strings, Binwalk, Carving)"
echo "2) 🖼️  Image Stego (LSB, Metadata, Chunks, GIF/APNG)"
echo "3) 🎵 Audio Stego (Spectrogram, LSB, DTMF, FSK)"
echo "4) 📄 Document Stego (PDF, Office/OOXML ZIP extraction)"
echo "5) 🔡 Text Stego (Unicode, Zero-Width, Whitespace)"
echo "6) 🦠 Malware/Delivery Stego (Marker-delimited payloads)"
echo "0) 🔙 Return to Main Menu"

echo -en "\n${C3}stego_helper > ${NC}"
read stego_opt

case $stego_opt in
    1) ./modules/stego/workflow.sh ;;
    2) ./modules/stego/images.sh ;;
    3) ./modules/stego/audio.sh ;;
    4) ./modules/stego/documents.sh ;;
    5) ./modules/stego/text.sh ;;
    6) ./modules/stego/malware_stego.sh ;;
    0) return ;;
    *) echo -e "${C2}[!] Invalid option.${NC}" ; sleep 1 ; ./modules/stego.sh ;;
esac

# Return to menu
./modules/stego.sh
