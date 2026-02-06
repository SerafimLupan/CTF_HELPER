#!/bin/bash
# CTF_HELPER - Pwn & Binary Exploitation Module

run_pwn() {
    print_banner
    echo -e "${C6}[CATEGORY: PWN - BINARY EXPLOITATION]${NC}"
    read -p "📂 Path to binary (ELF): " bin_path

    if [[ ! -f "$bin_path" ]]; then
        echo -e "${C1}[!] Error: File not found.${NC}"
        return
    fi

    echo -e "\n${C4}Select Pwn Task:${NC}"
    echo "1) 🛡️  Checksec (Mitigation Analysis)"
    echo "2) 🔍 Find Vulnerable Functions (Static Analysis)"
    echo "3) 📏 Calculate Overflow Offset (Pattern Create/Offset)"
    echo "4) 🔗 ROPgadget Search (Find JMP ESP, POP/RET)"
    echo "5) 🐍 Generate Pwntools Template (Python script)"
    echo "0) ↩️  Back"

    echo -ne "\n${C5}pcap_analyzer > ${NC}"
    read popt

    case $popt in
        1) # Checksec
            echo -e "${C2}[*] Mitigation Check:${NC}"
            checksec --file="$bin_path"
            ;;
            
        2) # Static Analysis
            echo -e "${C2}[*] Searching for dangerous imports...${NC}"
            nm -D "$bin_path" | grep -E "gets|system|strcpy|printf|scanf"
            echo -e "${C2}[*] Searching for /bin/sh or flag strings...${NC}"
            strings -t x "$bin_path" | grep -iE "/bin/sh|flag|cat"
            ;;

        3) # Overflow calculation
            read -p "Enter length of pattern: " p_len
            echo -e "${C2}[*] GDB Pattern (Copy this to GDB):${NC}"
            echo "cyclic $p_len"
            echo "cyclic -l <fault_address>"
            ;;

        4) # ROP
            echo -e "${C2}[*] Searching for useful gadgets...${NC}"
            ROPgadget --binary "$bin_path" | grep -E "pop|ret|jmp" | head -n 20
            ;;

        5) # Pwntools Template
            echo -e "${C2}[*] Creating exploit_template.py...${NC}"
            cat <<EOF > exploit_template.py
from pwn import *

# Configuration
exe = context.binary = ELF('$bin_path')
host = args.HOST or 'remote_ip'
port = int(args.PORT or 1337)

def start_local(argv=[], *a, **kw):
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    else:
        return process([exe.path] + argv, *a, **kw)

def start_remote(argv=[], *a, **kw):
    return remote(host, port)

io = start_local() if args.LOCAL else start_remote()

# --- EXPLOIT GOES HERE ---
# payload = flat({ 40: exe.sym['win'] })
# io.sendline(payload)

io.interactive()
EOF
            echo -e "${C5}[+] Template created! Use: python3 exploit_template.py LOCAL${NC}"
            ;;

        0) return ;;
    esac
    read -p "Press Enter to continue..."
    run_pwn
}
