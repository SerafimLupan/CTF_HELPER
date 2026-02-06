#!/bin/bash
C1='\033[1;32m'
C2='\033[1;31m'
C3='\033[1;34m'
NC='\033[0m'

echo -e "${C3}[*] Starting Fixed Installation...${NC}"

# 1. Pachete Apt cu nume corecte
echo -e "${C1}[+] Installing system dependencies...${NC}"
apt-get update -y
apt-get install -y \
    nmap gobuster ffuf sqlmap nikto commix \
    steghide binwalk exiftool john hashid \
    curl wget git python3-pip jq \
    libimage-exiftool-perl dnsutils tshark \
    pngcheck sox minimodem qpdf \
    libgmp3-dev libmpc-dev ruby-full \
    radare2 upx-ucl ltrace strace checksec ropper gdb

# 2. Fix Volatility 3
echo -e "${C1}[+] Setting up Volatility 3...${NC}"
if [ ! -d "/opt/volatility3" ]; then
    git clone https://github.com/volatilityfoundation/volatility3.git /opt/volatility3
    # Fix: Install dependencies directly to avoid missing requirements.txt
    pip3 install pefile iana-etc --break-system-packages
    ln -sf /opt/volatility3/vol.py /usr/local/bin/vol
fi

# 3. Fix Stegseek (Manual Release Check)
echo -e "${C1}[+] Installing Stegseek...${NC}"
if ! command -v stegseek &> /dev/null; then
    # Download direct de pe serverul de release-uri v0.6 (link verificat)
    wget https://github.com/RickdeJager/stegseek/releases/download/v0.6/stegseek_0.6-1_amd64.deb -O /tmp/stegseek.deb
    apt install /tmp/stegseek.deb -y
    rm /tmp/stegseek.deb
fi

# 4. Fix PIP Conflicts (Arjun, Pycryptodome)
echo -e "${C1}[+] Installing Python tools with bypass...${NC}"
# Folosim --ignore-installed pentru a trece de erorile de "uninstall"
pip3 install --upgrade --break-system-packages --ignore-installed \
    arjun cryptography pillow pycryptodome pwntools z3-solver bitarray

# 5. Fix RsaCtfTool
echo -e "${C1}[+] Setting up RsaCtfTool...${NC}"
if [ ! -d "/opt/RsaCtfTool" ]; then
    git clone https://github.com/RsaCtfTool/RsaCtfTool.git /opt/RsaCtfTool
    pip3 install -r /opt/RsaCtfTool/requirements.txt --break-system-packages
fi

echo -e "${C1}[SUCCESS] Tools installed. Check for any remaining red lines above.${NC}"
