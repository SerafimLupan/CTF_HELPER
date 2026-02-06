# CTF_HELPER 🚩 `v5.0.0`

**A modular, HackTricks-inspired automation suite for CTF players and Pentesters.**

`CTF_HELPER` is a Bash-based framework designed to streamline the reconnaissance and exploitation phases in Capture The Flag competitions. Built with a modular architecture, it maps directly to the world-renowned **HackTricks** methodology, providing a unified interface for the best security tools available on Kali Linux.



---

## ✨ Features
- **Advanced Crypto Toolkit:** Automates complex attacks like Padding Oracles, RSA factorization, and MD5/SHA Length Extensions.
- **Comprehensive Network Orchestrator:** Scans 15+ specialized service categories and features a terminal-based PCAP engine for deep-packet forensics and credential carving.
- **Deep Stego Forensics:** Forensics-first approach for extracting data from Images, Audio (FSK/DTMF), Documents, and "Invisible" Text.
- **Massive Web Suite:** 50+ specialized attack vectors covering Server-Side, Client-Side, and Modern Web logic.
- **HackTricks Integrated:** Every module follows step-by-step checklists from [HackTricks.xyz](https://book.hacktricks.xyz/).
- **Native & Advanced Tools:** Combines built-in Linux commands (`strings`, `xxd`, `find`) with industry-standard tools (`nmap`, `gobuster`, `steghide`, `slither`).
- **Matrix-style UI:** A clean, green-themed interface with a custom ASCII banner.
- **Automated Workflow:** From initial recon to privilege escalation.

---

## 📂 Project Structure
    
    CTF_HELPER/
    ├── ctf_helper.sh             # Main entry point & Menu system
    ├── requirements.sh           # Dependency installer
    ├── .gitignore                # GitHub clean-up
    ├── LICENSE                   # MIT License
    ├── README.md                 # Documentation
    └── modules/                  # Specialized attack modules
        ├── crypto/               # 🔑 CRYPTOGRAPHY SUITE (HackTricks aligned)
        │   ├── classical_ciphers.sh    # Encodings & Substitution
        │   ├── hash_cracking.sh        # John/Hashcat & HashPump
        │   ├── symmetric_attacks.sh    # Padding Oracle & Bit-flipping
        │   ├── public_key_rsa.sh       # RsaCtfTool & SageMath
        │   ├── malware_recon.sh        # Constants & Binary patterns
        │   └── misc_crypto.sh          # Esolangs & Shamir SSS
        ├── network/              # 🔌 NETWORK SUITE (Specialized Sub-modules)
        │   ├── common_services.sh      # Port 21, 22, 25, 53 (FTP, SSH, SMTP, DNS)
        │   ├── db_services.sh          # Port 3306, 5432, 6379 (SQL & NoSQL Databases)
        │   ├── win_services.sh         # Port 88, 135, 445 (Active Directory, SMB, RPC, LDAP)
        │   ├── infra_services.sh       # Port 69, 123, 161 (TFTP, NTP, SNMP, VPN)
        │   ├── modern_services.sh      # Port 2375, 5000, 6443 (Docker, K8s, Cloud APIs)
        │   └── pcap_analyzer.sh        # Network Forensics (Tshark, Carving, Stream Analysis)        
        ├── stego/                # 🔍 STEGANOGRAPHY SUITE (Forensics-First Approach)
        │   ├── workflow.sh             # The Triage Brain
        │   ├── images.sh               # Pixel & Chunk Analysis
        │   ├── audio.sh                # Spectrogram & Tones
        │   ├── documents.sh            # PDF & Office Analysis
        │   ├── text.sh                 # Unicode & Whitespace
        │   └── malware_stego.sh        # Delivery & Markers
        ├── web/                  # 🌐 WEB VULNERABILITIES (50+ Vectors)
        │   ├── auth_*.sh               # 2FA, JWT, OAuth, SAML, Login/Reset Bypass
        │   ├── client_*.sh             # XSS, CSRF, CORS, PostMessage, Clickjacking
        │   ├── injection_*.sh          # SQLi, NoSQL, Command, LDAP, XPath, Unicode
        │   ├── logic_*.sh              # IDOR, Race Condition, Rate Limit, Price Tampering
        │   ├── server_*.sh             # SSRF, XXE, SSTI, LFI/RFI, Deserialization, Smuggling
        │   ├── modern_*.sh             # WebSockets, gRPC, dApps, ReDoS, UUIDs
        │   └── methodology_*.sh        # Recon flow and PoC templates
        ├── ai_security.sh            # AI Security: Focuses on LLM vulnerabilities, Prompt Injection, and Model Safety.
        ├── binary_exploit.sh         # Binary Exploitation: Tools for buffer overflows, ROP chains, and memory protection bypass.
        ├── blockchain.sh             # Blockchain: Smart contract auditing and interaction with EVM-based networks.
        ├── crypto.sh                 # Cryptography: Hash identification, cracking, and common cipher decryption.
        ├── file_analyzer.sh          # File Analyzer: Deep inspection of file signatures, magic bytes, and metadata.
        ├── generic_methodologies.sh  # Generic Methodologies: OSINT, Cloud (AWS/Azure) basics, and general CTF strategy.
        ├── linux_hardening.sh        # Linux Hardening: Local enumeration for Privilege Escalation (SUID, Caps, Cron).
        ├── mobile_pentest.sh         # Mobile Pentest: Android APK and iOS IPA static and dynamic analysis.
        ├── network_services.sh       # Network Services: Protocol-specific enumeration (SMB, FTP, SNMP, etc.).
        ├── reversing.sh              # Reversing: Static and dynamic analysis of binaries (ELF/EXE).
        ├── stego.sh                  # Steganography: Finding hidden data in images, audio, and video files.
        ├── web_pentest.sh            # Web Pentest: Fuzzing, CMS identification, and web vulnerability scanning.
        └── windows_hardening.sh      # Windows Hardening: Local PrivEsc vectors and Active Directory enumeration.

---

## 🚀 Getting Started

### Prerequisites

Developed and tested on Kali Linux. Ensure you have the necessary permissions to run security tools.

#### Installation

1. Clone the repository:
   ```bahs 
    git clone https://github.com/SerafimLupan/CTF_HELPER.git
    cd CTF_HELPER
2. Make scripts executable:
   ```bash
    chmod +x ctf_helper.sh requirements.sh modules/*.sh
3. Install dependencies:
   ```bash
   sudo ./requirements.sh
4. Run the tool:
   ```bash
   ./ctf_helper.sh

---

## 🛠️ Modules Overview

| Module | Description | Key Tools |
| :--- | :--- | :--- |
| **🌐 Web Pentest** | Fuzzing, CMS detection, and Header analysis. | `gobuster`, `nikto`, `curl` |
| **🔌 Network** | Enumeration for SMB, FTP, SNMP, and SMTP. | `enum4linux`, `nmap`, `onesixtyone` |
| **🛡️ Linux Hardening** | SUID, Capabilities, and Cronjob discovery. | `find`, `getcap`, `crontab` |
| **🔍 Reversing** | Static analysis and binary tracing. | `readelf`, `ltrace`, `radare2` |
| **🔐 Crypto** | Hash identification and brute-forcing. | `john`, `hash-identifier` |
| **⛓️ Blockchain** | Smart contract analysis (EVM). | `slither`, `curl (JSON-RPC)` |
| **📂 File Analyzer** | Deep file inspection and magic bytes. | `binwalk`, `exiftool`, `xxd` |
| **🖼️ Stego** | LSB analysis and hidden data extraction. | `steghide`, `zsteg`, `stegsolve` |
| **🧬 Binary Exploit** | Memory protection bypass and ROP. | `checksec`, `ropper`, `pwntools` |
| **🏁 Windows Hardening** | Local PrivEsc and service enumeration. | `powershell`, `wmic`, `winPEAS` |
| **📱 Mobile Pentesting** | APK/IPA decompilation and analysis. | `apktool`, `dex2jar`, `adb` |
| **🤖 AI Security** | Prompt injection and LLM vulnerability checks. | `strings`, `jailbreak-templates` |
| **⚙️ Generic Methodologies** | OSINT, Cloud, and Container breakout. | `docker`, `cloud-checklists` |

---

## 🤝 Contributing

Contributions are welcome! If you have a new module or an improvement for an existing one based on the HackTricks methodology:

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`).
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the Branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## ⚖️ License & Disclaimer

This project is licensed under the **MIT License**.

**Disclaimer:** This tool is intended for **educational and ethical hacking purposes only**. The author is not responsible for any misuse or damage caused by this program. Always obtain permission before testing any target.

---

**Developed with 💚 by [Serafim Lupan](https://serafimlupan.com)**
