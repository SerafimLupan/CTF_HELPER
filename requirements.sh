#!/bin/bash
# --- CTF_HELPER Complete Requirements ---
# Target: Full HackTricks Methodology support

echo -e "\e[38;5;46m[+] Initializing full toolset installation...\e[0m"

# Update repositories
sudo apt-get update -y

# 1. Network Services & Recon (network-services-pentesting)
NET=("nmap" "whois" "netcat-traditional" "snmp" "enum4linux" "smbclient" "ftp" "onesixtyone" "snmp-check")

# 2. Web Pentesting (pentesting-web)
WEB=("curl" "wget" "gobuster" "nikto" "sqlmap" "dirb" "ffuf" "wfuzz")

# 3. Binary Exploitation & Reversing (binary-exploitation / reversing)
BIN=("gdb" "gcc" "strace" "ltrace" "radare2" "checksec" "ropper" "ghidra" "nasm")

# 4. Steganography & File Analysis (stego / files)
STEGO=("steghide" "exiftool" "binwalk" "outguess" "foremost" "pngcheck" "stegsolve")

# 5. Linux & Windows Hardening (linux-hardening / windows-hardening)
HARDENING=("getcap" "binutils" "util-linux" "powershell-empire" "bloodhound" "impacket-scripts")

# 6. Crypto (crypto)
CRYPTO=("python3-pip" "openssl" "fcrackzip" "john" "hashcat")

# 7. Mobile & Hardware (mobile-pentesting / hardware-physical-access)
MOBILE=("adb" "fastboot" "apktool")

# 8. Blockchain & AI (blockchain / AI)
# Mostly handled via Python libraries
AI_CLOUD=("awscli" "azure-cli")

# Combine all lists
ALL_TOOLS=("${NET[@]}" "${WEB[@]}" "${BIN[@]}" "${STEGO[@]}" "${HARDENING[@]}" "${CRYPTO[@]}" "${MOBILE[@]}" "${AI_CLOUD[@]}")

for tool in "${ALL_TOOLS[@]}"; do
    if ! command -v $tool &> /dev/null; then
        echo -e "[!] Installing: $tool"
        sudo apt-get install -y $tool
    else
        echo -e "[V] Already installed: $tool"
    fi
done

# Python Specialized Libraries (HackTricks frequently uses these)
echo -e "\e[38;5;46m[+] Installing Python libraries (requests, pwntools, etc.)...\e[0m"
pip3 install requests pwntools pycryptodome scapy --break-system-packages 2>/dev/null

echo -e "\e[38;5;82m[+] All categories from HackTricks are now supported by your local tools!\e[0m"
