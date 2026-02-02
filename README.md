# CTF_HELPER 🚩

**A modular, HackTricks-inspired automation suite for CTF players and Pentesters.**

`CTF_HELPER` is a Bash-based framework designed to streamline the reconnaissance and exploitation phases in Capture The Flag competitions. Built with a modular architecture, it maps directly to the world-renowned **HackTricks** methodology, providing a unified interface for the best security tools available on Kali Linux.



---

## ✨ Features

- **Modular Design:** 13 dedicated modules (Web, Network, Binary, Blockchain, etc.) for easy expansion.
- **HackTricks Integrated:** Every module follows step-by-step checklists from [HackTricks.xyz](https://book.hacktricks.xyz/).
- **Native & Advanced Tools:** Combines built-in Linux commands (`strings`, `xxd`, `find`) with industry-standard tools (`nmap`, `gobuster`, `steghide`, `slither`).
- **Matrix-style UI:** A clean, green-themed interface with a custom ASCII banner.
- **Automated Workflow:** From initial recon to privilege escalation.

---

## 📂 Project Structure

    ```text
    CTF_HELPER/
    ├── ctf_helper.sh             # Main entry point & Menu system
    ├── requirements.sh           # Dependency installer
    ├── .gitignore                # GitHub clean-up
    ├── LICENSE                   # MIT License
    ├── README.md                 # Documentation
    └── modules/                  # Specialized attack modules
        ├── ai_security.sh
        ├── binary_exploit.sh
        ├── blockchain.sh
        ├── crypto.sh
        ├── file_analyzer.sh
        ├── generic_methodologies.sh
        ├── linux_hardening.sh
        ├── mobile_pentest.sh
        ├── network_services.sh
        ├── reversing.sh
        ├── stego.sh
        ├── web_pentest.sh
        └── windows_hardening.sh                          `

---

## 🚀 Getting Started

### Prerequisites

Developed and tested on Kali Linux. Ensure you have the necessary permissions to run security tools.

#### Installation

1. Clone the repository:
   ```bahs 
    git clone [https://github.com/SerafimLupan/CTF_HELPER.git](https://github.com/SerafimLupan/CTF_HELPER.git)
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
