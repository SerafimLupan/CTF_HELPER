#!/bin/bash
# CTF_HELPER Dependency Installer
# Target OS: Kali Linux / Debian-based

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

# 2. Install Core Apt Tools (The heavy hitters)
echo -e "${C1}[+] Installing core security tools via apt...${NC}"
apt-get install -y \
    nmap \
    gobuster \
    ffuf \
    sqlmap \
    nikto \
    commix \
    steghide \
    binwalk \
    exiftool \
    exploitdb \
    john \
    hashid \
    curl \
    wget \
    git \
    python3-pip \
    jq \
    libimage-exiftool-perl

# 3. Web-Specific Advanced Tools (Python-based)
echo -e "${C1}[+] Installing specialized web tools (Python)...${NC}"
# Arjun (Parameter discovery)
pip3 install arjun --break-system-packages
# XSStrike (Advanced XSS)
git clone https://github.com/s0md3v/XSStrike /opt/XSStrike
pip3 install -r /opt/XSStrike/requirements.txt --break-system-packages
# Tplmap (SSTI exploitation)
git clone https://github.com/epinna/tplmap /opt/tplmap
pip3 install -r /opt/tplmap/requirements.txt --break-system-packages

# 4. Networking & PrivEsc Utilities
echo -e "${C1}[+] Downloading Privilege Escalation scripts...${NC}"
mkdir -p /opt/privesc
wget https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh -O /opt/privesc/linpeas.sh
wget https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASany.exe -O /opt/privesc/winpeas.exe
chmod +x /opt/privesc/linpeas.sh

# 5. Clean up
echo -e "${C1}[+] Finalizing installation...${NC}"
apt-get autoremove -y

echo -e "--------------------------------------------------"
echo -e "${C1}[SUCCESS] CTF_HELPER is ready to engage!${NC}"
echo -e "Usage: sudo ./ctf_helper.sh"
