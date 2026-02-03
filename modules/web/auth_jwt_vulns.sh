#!/bin/bash
# HackTricks Ref: hacking-jwt-json-web-tokens.md
# Module: JWT (JSON Web Token) Vulnerabilities

echo -e "${C6}[WEB ATTACK: JWT_VULNERABILITIES]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/hacking-jwt-json-web-tokens"
echo -e "--------------------------------------------------"

echo -ne "${C5}Paste your JWT token for analysis: ${NC}"
read jwt_token

# Extragere Header și Payload (fără biblioteci externe)
header_json=$(echo "$jwt_token" | cut -d'.' -f1 | base64 -d 2>/dev/null)
payload_json=$(echo "$jwt_token" | cut -d'.' -f2 | base64 -d 2>/dev/null)

echo -e "\n${C4}[*] Decoded Header:${NC} $header_json"
echo -e "${C4}[*] Decoded Payload:${NC} $payload_json"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Attack Vector:${NC}"
echo "1) None Algorithm Attack (Header Manipulation)"
echo "2) Weak Secret Brute-force (Instructions)"
echo "3) RS256 to HS256 Key Confusion Theory"
echo "4) Kid Parameter Injection (SQLi/LFI/CMD)"
echo "5) JKU/JWK Header Injection"
echo "0) Exit"

read -p "Selection: " jwt_opt

case $jwt_opt in
    1)
        echo -e "\n${C2}[!] None Algorithm Attack:${NC}"
        echo "1. Change 'alg' in header to 'none', 'NONE', or 'nOnE'."
        echo "2. Re-encode header to Base64 (remove padding =)."
        echo "3. Remove the signature part (keep the last dot: header.payload.)."
        echo "Example Payload: eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.payload_here."
        ;;
    2)
        echo -e "\n${C2}[*] Weak Secret Brute-force:${NC}"
        echo "If the algorithm is HS256, the signature is a hash using a secret."
        echo "Use 'jwt_tool' or 'hashcat':"
        echo "Command: hashcat -m 16500 jwt.txt /usr/share/wordlists/rockyou.txt"
        ;;
    3)
        echo -e "\n${C2}[*] RS256 to HS256 (Key Confusion):${NC}"
        echo "1. Obtain the server's public key (usually from /jwks.json or similar)."
        echo "2. Change the algorithm in the header from RS256 to HS256."
        echo "3. Sign the token using the public key as the HS256 secret."
        echo "Server logic: Verifies HS256 signature using what it thinks is its private key (but is actually the public key)."
        ;;
    4)
        echo -e "\n${C2}[*] 'kid' Header Injection:${NC}"
        echo "The 'kid' (Key ID) can be vulnerable to:"
        echo " - Directory Traversal: \"kid\": \"../../../../dev/null\" (secret becomes null)."
        echo " - SQL Injection: \"kid\": \"' UNION SELECT 'key'--\"."
        echo " - Command Injection: \"kid\": \"key|id\"."
        ;;
    5)
        echo -e "\n${C2}[*] JKU/JWK Injections:${NC}"
        echo " - JKU: Point 'jku' header to your own URL containing a rogue JWKS file."
        echo " - JWK: Embed your own public key directly into the header."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
