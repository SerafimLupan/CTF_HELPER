#!/bin/bash
# CTF_HELPER Dependency Installer
# Target OS: Kali Linux / Debian-based
# Updated: Integrated Crypto & Stego Suite

C1='\033[1;32m' # Green
C2='\033[1;31m' # Red
C3='\033[1;34m' # Blue
NC='\033[0m'    # No Color

echo -e "${C3}[*] Starting CTF_HELPER dependency installation...${NC}"

# Check for root
if [[ $EUID -ne 0 ]]; then
   echo -e "${C2}[!] This script must be run as root (sudo ./requirements.sh)${NC}"
   exit 1
fi

# 1. Update System
echo -e "${C1}[+] Updating package lists...${NC}"
apt-get update -y

# 2. Install Core Apt Tools (Web, Crypto, Stego)
echo -e "${C1}[+] Installing core security tools via apt...${NC}"
apt-get install -y \
    nmap gobuster ffuf sqlmap nikto commix \
    steghide binwalk exiftool john hashid \
    curl wget git python3-pip jq \
    libimage-exiftool-perl \
    pngcheck sox minimodem qpdf hashpump \
    libgmp3-dev libmpc-dev ruby-full # Needed for RSA & zsteg

# 3. Cryptography Specialized Tools
echo -e "${C1}[+] Setting up Advanced Crypto tools...${NC}"
# RsaCtfTool
if [ ! -d "/opt/RsaCtfTool" ]; then
    git clone https://github.com/RsaCtfTool/RsaCtfTool.git /opt/RsaCtfTool
    pip3 install -r /opt/RsaCtfTool/requirements.txt --break-system-packages
fi

# 4. Steganography Specialized Tools
echo -e "${C1}[+] Setting up Advanced Stego tools...${NC}"
# zsteg (Ruby gem is the most reliable way)
gem install zsteg
# stegseek (Fastest JPEG brute-force)
if ! command -v stegseek &> /dev/null; then
    wget https://github.com/RickdeJager/stegseek/releases/download/v0.6/stegseek_0.6-1_amd64.deb
    apt install ./stegseek_0.6-1_amd64.deb -y
    rm stegseek_0.6-1_amd64.deb
fi

# 5. Web-Specific Advanced Tools (Python-based)
echo -e "${C1}[+] Installing specialized web tools...${NC}"
pip3 install arjun cryptography pillow pycryptodome --break-system-packages
# XSStrike & Tplmap
[ ! -d "/opt/XSStrike" ] && git clone https://github.com/s0md3v/XSStrike /opt/XSStrike
[ ! -d "/opt/tplmap" ] && git clone https://github.com/epinna/tplmap /opt/tplmap

# 6. Networking & PrivEsc Utilities
echo -e "${C1}[+] Downloading Privilege Escalation scripts...${NC}"
mkdir -p /opt/privesc
wget -q https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh -O /opt/privesc/linpeas.sh
chmod +x /opt/privesc/linpeas.sh

# 7. Clean up
echo -e "${C1}[+] Finalizing installation...${NC}"
apt-get autoremove -y

echo -e "--------------------------------------------------"
echo -e "${C1}[SUCCESS] CTF_HELPER Suite is fully equipped!${NC}"
