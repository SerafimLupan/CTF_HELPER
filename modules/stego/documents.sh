#!/bin/bash
# CTF_HELPER - Document Steganography Module
# Focus: PDF Stream Extraction and Office (OOXML) Analysis

source ./ctf_helper.sh

echo -e "${C6}[MODULE: DOCUMENT STEGANOGRAPHY]${NC}"
echo -e "Analyzing PDF objects, Office ZIP structures, and OLE legacy formats\n"

echo "1) PDF Triage (Metadata & Attachments)"
echo "2) PDF Stream Decompress (qpdf/peepdf)"
echo "3) Office OOXML Analysis (.docx, .xlsx, .pptx)"
echo "4) OLE/Legacy Document Check (oleid/olevba)"
echo "0) Back to Stego Menu"

echo -en "\n${C3}doc_helper > ${NC}"
read doc_opt

case $doc_opt in
    1)
        # HackTricks: "Extract embedded attachments"
        read -p "Target PDF: " target
        pdfinfo "$target"
        echo -e "${C2}[*] Checking for embedded files...${NC}"
        pdfdetach -list "$target"
        echo -en "${C3}Extract all attachments? (y/n): ${NC}"
        read det_opt
        if [ "$det_opt" == "y" ]; then pdfdetach -saveall "$target"; fi
        ;;
    2)
        # HackTricks: "Decompress/flatten object streams"
        read -p "Target PDF: " target
        echo -e "${C2}[*] Flattening PDF with qpdf...${NC}"
        qpdf --qdf --object-streams=disable "$target" out.pdf
        echo -e "${C3}[+] Created 'out.pdf'. You can now use 'grep' or 'strings' on it.${NC}"
        ;;
    3)
        # HackTricks: "Treat OOXML as a ZIP + XML relationship graph"
        read -p "Target Office File: " target
        echo -e "${C2}[*] Analyzing OOXML Structure...${NC}"
        7z l "$target"
        echo -e "\n${C1}[High-Signal Locations to Check]${NC}"
        echo " - word/media/ (Images/Audio)"
        echo " - word/_rels/ (Relationship maps/External links)"
        echo " - customXml/ (Hidden data blobs)"
        echo -en "${C3}Extract and grep for 'flag'? (y/n): ${NC}"
        read gre_opt
        if [ "$gre_opt" == "y" ]; then
            mkdir -p ./doc_extracted && 7z x "$target" -o./doc_extracted > /dev/null
            grep -rni "flag" ./doc_extracted
        fi
        ;;
    4)
        # HackTricks: "Payloads often hide in legacy formats"
        read -p "Target Doc: " target
        echo -e "${C2}[*] Running OLETools for Macro/Hidden Stream detection...${NC}"
        oleid "$target"
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/stego/documents.sh
