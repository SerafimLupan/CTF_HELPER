#!/bin/bash
# CTF_HELPER - Advanced Reverse Engineering Engine (Powered by Radare2 & Scripts)

function run_reversing() {
    print_banner
    echo -e "${C6}[REVERSING MODULE - ELITE EDITION]${NC}"
    read -p "📂 Path to binary (ELF/EXE): " f

    if [[ ! -f "$f" ]]; then
        echo -e "${C1}[!] Error: Binary not found.${NC}"
        return
    fi

    echo -e "\n${C4}Select Intelligence Task:${NC}"
    echo "1) 🔍  Automated Triage (Deep strings, metadata, entrypoints)"
    echo "2) 🧩  Logic Reconstruction (Decompile Main via Radare2)"
    echo "3) 🛡️   Protection Check (Stack Canaries, NX, PIE, ASLR)"
    echo "4) 🏃  Execution Trace (Follow library & syscalls with args)"
    echo "5) 📦  Entropy & Packer Scan (Detect UPX, VMProtect, custom packers)"
    echo "6) 💀  Vulnerability Scanner (Find dangerous calls: gets, strcpy, system)"
    echo "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}reversing > ${NC}"
    read ropt

    case $ropt in
        1) # Triage Automatizat
            echo -e "${C2}[*] Binary Fingerprint:${NC}" ; file "$f"
            echo -e "${C2}[*] Searching for Flags/URLs/IPs in data sections...${NC}"
            strings -n 6 "$f" | grep -iE "flag|{.*}|http|www|127\.|0\.|/bin/sh"
            echo -e "${C2}[*] Entry Point & Architecture:${NC}"
            readelf -h "$f" | grep -iE "Entry|Class|Machine"
            ;;
        2) # Decompilare Rapidă
            echo -e "${C2}[*] Disassembling 'main' and looking for branching logic...${NC}"
            # Analiză automată, afișare main, și ieșire
            r2 -A -qc "pdf @ main" "$f" 2>/dev/null || r2 -A -qc "pdf @ entry0" "$f"
            ;;
        3) # Protecții
            echo -e "${C2}[*] Checking binary security headers:${NC}"
            checksec --file="$f" || readelf -l "$f" | grep -i "STACK"
            ;;
        4) # Tracing Inteligent
            chmod +x "$f"
            echo -e "1) Library Trace (ltrace) - Best for strcmp/malloc\n2) Syscall Trace (strace) - Best for file/net access"
            read -p "> " trc
            if [ "$trc" == "1" ]; then
                echo -e "${C3}[TIP] Look for strcmp/strncmp to find passwords!${NC}"
                ltrace -i -C -s 128 ./"$f"
            else
                strace -e trace=open,read,write,connect ./"$f"
            fi
            ;;
        5) # Entropy & Packers
            echo -e "${C2}[*] Analyzing sections entropy (High entropy = Packed/Encrypted):${NC}"
            r2 -A -qc "iS" "$f" | awk '{print $1, $12}' # Afișează numele secțiunilor și entropia
            strings "$f" | grep -iE "UPX|Pack|VMProtect|Themida"
            ;;
        6) # Hunter Mode
            echo -e "${C1}[!] SCANNING FOR EXPLOITABLE FUNCTIONS...${NC}"
            nm -D "$f" 2>/dev/null | grep -iE "gets|strcpy|sprintf|system|exec|ptrace" && echo -e "${C1}[ALERT] Found potential Buffer Overflow or Command Injection point!${NC}"
            echo -e "${C2}[*] Constant strings check:${NC}"
            r2 -A -qc "iz" "$f" | grep -iE "flag|secret|pass"
            ;;
        0) return ;;
    esac
    read -p "Press Enter to return..."
    run_reversing
}
