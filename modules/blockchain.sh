#!/bin/bash
# Module: Blockchain & Smart Contracts (HackTricks Methodology)

function run_blockchain() {
    print_banner
    echo -e "${C6}[BLOCKCHAIN MODULE]${NC}"
    echo -e "Based on: https://book.hacktricks.xyz/blockchain/blockchain-basics"
    echo -e "----------------------------------------------------------------------------"
    echo -e "1) 🔍  Identify Smart Contract Code (Solidity/Vyper)"
    echo -e "2) 🐍  Static Analysis with Slither"
    echo -e "3) 🌐  Web3 Provider Interaction (Get Balance/Code)"
    echo -e "4) 🔨  Common Vulnerability Checklist (HackTricks)"
    echo -e "5) 🗝️   Private Key / Mnemonic Check"
    echo -e "0) ↩️   Return to Main Menu"

    echo -ne "\n${C5}Blockchain Selection: ${NC}"
    read bopt

    case $bopt in
        1)
            read -p "Path to .sol file: " solfile
            if [ -f "$solfile" ]; then
                echo -e "\n[*] Checking compiler version and imports:"
                grep -E "pragma|import" "$solfile"
            fi
            ;;
        2)
            read -p "Path to project folder/file: " ppath
            if command -v slither &> /dev/null; then
                slither "$ppath"
            else
                echo -e "${C1}[!] Slither not installed. Run requirements.sh first.${NC}"
            fi
            ;;
        3)
            read -p "RPC URL (ex: http://127.0.0.1:8545): " rpc
            read -p "Contract/Wallet Address: " addr
            echo -e "[*] Fetching balance via curl (JSON-RPC)..."
            curl -X POST -H "Content-Type: application/json" --data "{\"jsonrpc\":\"2.0\",\"method\":\"eth_getBalance\",\"params\":[\"$addr\", \"latest\"],\"id\":1}" "$rpc"
            ;;
        4)
            echo -e "\n${C4}--- HackTricks Blockchain Checklist ---${NC}"
            echo -e " - Reentrancy: Check for state changes AFTER external calls."
            echo -e " - Access Control: Are functions like 'withdraw' protected by 'onlyOwner'?"
            echo -e " - Integer Overflow: Use SafeMath or Solidity >0.8.0."
            echo -e " - Front-Running: Transaction ordering dependence."
            ;;
        5)
            read -p "Enter text to check for private key patterns: " txt
            echo "$txt" | grep -iE "[0-9a-f]{64}" && echo -e "${C6}[!] Potential Private Key found!${NC}" || echo "No obvious keys found."
            ;;
        0) return ;;
        *) echo -e "${C1}Invalid selection.${NC}" ; sleep 1 ;;
    esac
    read -p "Press Enter to return..."
}
