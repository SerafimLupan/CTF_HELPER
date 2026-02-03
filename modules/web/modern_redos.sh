#!/bin/bash
# HackTricks Ref: regular-expression-denial-of-service-redos
# Module: ReDoS (Regular Expression Denial of Service)

echo -e "${C6}[WEB ATTACK: MODERN_REDOS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/regular-expression-denial-of-service-redos"
echo -e "--------------------------------------------------"

echo -e "${C4}Select ReDoS Attack Vector:${NC}"
echo "1) Common Vulnerable Patterns (Cheat Sheet)"
echo "2) Detection Payloads (Pumped Strings)"
echo "3) Identification of Catastrophic Backtracking"
echo "4) Tools for Regex Analysis"
echo "0) Exit"

read -p "Selection: " redos_opt

case $redos_opt in
    1)
        echo -e "\n${C2}[*] Vulnerable Regex Patterns:${NC}"
        echo "Look for nested quantifiers or overlapping groups:"
        echo " - (a+)+ "
        echo " - ([a-zA-Z]+)* "
        echo " - (a|b|a)* "
        echo " - (.*a){10} "
        echo -e "${C4}Usage:${NC} Find these in client-side JS or via error messages."
        ;;
    2)
        echo -e "\n${C2}[*] Detection Payloads:${NC}"
        echo "The goal is to provide a string that almost matches but fails at the end."
        echo " - Pattern: (a+)+$ "
        echo " - Payload: aaaaaaaaaaaaaaaaaaaaaaaaaaaaab"
        echo "Increase the number of 'a's and monitor the server response time."
        ;;
    3)
        echo -e "\n${C2}[*] Catastrophic Backtracking Explained:${NC}"
        echo "When the engine has too many paths to evaluate a non-match,"
        echo "the CPU usage spikes to 100% for a single request."
        echo "Formula: T = c * 2^n (where n is the length of the input)."
        ;;
    4)
        echo -e "\n${C2}[*] Recommended Analysis Tools:${NC}"
        echo " - Regex101.com (Check the 'debugger' for step count)"
        echo " - Devina.io (ReDoS visualizer)"
        echo " - Vulnerable Regular Expression Checker (rxxr)"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
