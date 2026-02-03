#!/bin/bash
# HackTricks Ref: dapps-DecentralizedApplications
# Module: Modern DApps & Web3 Security

echo -e "${C6}[WEB ATTACK: MODERN_DAPPS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/dapps-decentralized-applications"
echo -e "--------------------------------------------------"

echo -e "${C4}Select DApp Attack Vector:${NC}"
echo "1) Wallet Interaction & Provider Injection"
echo "2) Signature Replay & Phishing (permit/permit2)"
echo "3) Logic: Frontend vs On-Chain Discrepancies"
echo "4) API/RPC Exploitation (Infura/Alchemy keys)"
echo "5) Common Smart Contract Vulnerabilities (Audit Checklist)"
echo "0) Exit"

read -p "Selection: " dapp_opt

case $dapp_opt in
    1)
        echo -e "\n${C2}[*] Wallet & Provider Attacks:${NC}"
        echo " - Check if 'window.ethereum' is handled securely."
        echo " - Test for XSS that can steal 'localStorage' keys or hijack 'request' calls."
        echo " - Verify if the DApp validates the ChainID to prevent Cross-Chain attacks."
        ;;
    2)
        echo -e "\n${C2}[*] Signature Phishing:${NC}"
        echo " - Look for 'eth_sign' (Insecure, can sign anything)."
        echo " - Inspect 'EIP-712' structured data for hidden malicious 'permit' calls."
        echo " - Attack: Trick user into signing an 'Approve' or 'IncreaseAllowance' tx."
        ;;
    3)
        echo -e "\n${C2}[*] Frontend vs On-Chain Logic:${NC}"
        echo " - Does the UI show a price but the Contract executes another?"
        echo " - Check for 'Slippage' manipulation in swap interfaces."
        echo " - Verify if sensitive data is hidden in the UI but visible on-chain via Etherscan."
        ;;
    4)
        echo -e "\n${C2}[*] API/RPC Security:${NC}"
        echo " - Find hardcoded Infura/Alchemy API keys in JS bundles."
        echo " - Test for unauthenticated RPC methods (eth_accounts, eth_sendTransaction)."
        echo " - Check for 'CORS' misconfigurations on private RPC nodes."
        ;;
    5)
        echo -e "\n${C2}[*] Smart Contract Quick Audit:${NC}"
        echo " - Reentrancy: Check 'call' before state updates."
        echo " - Integer Overflow: (Check Solidity < 0.8.0)."
        echo " - Access Control: Look for missing 'onlyOwner' modifiers."
        echo " - Logic: Flash Loan attacks & Price Oracle manipulation."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
