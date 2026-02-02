#!/bin/bash
# Module: Reversing (HackTricks Methodology)

function run_reversing() {
    print_banner
    echo -e "${C6}[REVERSING MODULE]${NC}"
    echo -e "Based on: https://book.hacktricks.xyz/reversing/reversing-tools"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🔍  Static Analysis (Strings, File, NM)"
    echo -e "2) 🧱  Header & Sections (readelf -a)"
    echo -e "3) 🔗  Shared Libraries (ldd)"
    echo -e "4) 🕵️   Trace Execution (ltrace / strace)"
    echo -e "5) 🛠️   Decompile/Disassemble (radare2 basic)"
    echo -e "6) 📦  Unpack Binaries (UPX check)"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Reversing Selection: ${NC}"
    read ropt

    case $ropt in
        1)
            read -p "File path: " f
            if [ -f "$f" ]; then
                echo -e "\n[*] File info:" && file "$f"
                echo -e "\n[*] Interesting Strings (long):"
                strings -n 8 "$f" | grep -iE "pass|key|flag|secret|admin|user" | head -n 15
                echo -e "\n[*] Symbols (nm):" && nm "$f" 2>/dev/null | head -n 10
            fi
            ;;
        2)
            read -p "File path: " f
            [ -f "$f" ] && readelf -a "$f" | less
            ;;
        3)
            read -p "File path: " f
            [ -f "$f" ] && ldd "$f"
            ;;
        4)
            read -p "File path: " f
            if [ -f "$f" ]; then
                chmod +x "$f"
                echo -e "1) Library Calls (ltrace)\n2) System Calls (strace)"
                read -p "> " trc
                [ "$trc" == "1" ] && ltrace ./"$f"
                [ "$trc" == "2" ] && strace ./"$f"
            fi
            ;;
        5)
            read -p "File path: " f
            if [ -f "$f" ]; then
                echo -e "[*] Opening $f in radare2 (Analyze & Main)..."
                r2 -A -c "pdf @ main; q" "$f"
            fi
            ;;
        6)
            read -p "File path: " f
            [ -f "$f" ] && strings "$f" | grep -i "UPX" && echo -e "${C6}[!] UPX Packing detected! Use 'upx -d file'${NC}" || echo "No UPX signature found."
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
