#!/bin/bash
# HackTricks Ref: oauth-to-account-takeover.md
# Module: OAuth 2.0 / OpenID Connect (OIDC) Attacks

echo -e "${C6}[WEB ATTACK: OAUTH_TAKEOVER]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/oauth-to-account-takeover"
echo -e "--------------------------------------------------"

echo -e "${C4}Select OAuth Attack Vector:${NC}"
echo "1) Redirect URI Manipulation (Token/Code Stealing)"
echo "2) State Parameter CSRF (Account Linking)"
echo "3) Authorization Code Reuse / Brute-force"
echo "4) Scope Injection & Privilege Escalation"
echo "5) OIDC ID Token Validation Flaws"
echo "0) Exit"

read -p "Selection: " oauth_opt

case $oauth_opt in
    1)
        echo -e "\n${C2}[*] Redirect URI Manipulation:${NC}"
        echo "Check if you can redirect the 'code' or 'access_token' to your server."
        echo "Try to bypass whitelist:"
        echo " - https://target.com.attacker.com"
        echo " - https://target.com/callback?redirect=https://attacker.com"
        echo " - https://target.com%2f%2fattacker.com"
        echo " - Using folder traversal: https://target.com/callback/../logout?redirect=https://attacker.com"
        ;;
    2)
        echo -e "\n${C2}[*] State Parameter CSRF:${NC}"
        echo "If the 'state' parameter is missing or static:"
        echo "1. Start OAuth login as attacker, intercept the '/callback?code=...' request."
        echo "2. Don't use the code; send the link to a logged-in victim."
        echo "3. Victim clicks, and their account is linked to YOUR (attacker) identity."
        ;;
    3)
        echo -e "\n${C2}[*] Code Reuse / Brute-force:${NC}"
        echo " - Test if an Authorization Code can be used more than once."
        echo " - If the code is short (4-6 digits) and has no rate limit, try brute-force."
        ;;
    4)
        echo -e "\n${C2}[*] Scope Injection:${NC}"
        echo "Try adding sensitive scopes to the initial request:"
        echo "Change: scope=user:email"
        echo "To:     scope=user:email+notes+admin+profile"
        ;;
    5)
        echo -e "\n${C2}[*] ID Token Flaws (OIDC):${NC}"
        echo " - Check if the ID Token (JWT) is validated (see auth_jwt_vulns.sh)."
        echo " - Check if the 'nonce' parameter is validated to prevent replay attacks."
        echo " - Try to change 'sub' (subject) in the JWT to another user's ID."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
