#!/bin/bash
# Module: Web Pentesting Methodology (The Game Plan)
# Reference: OWASP WSTG & HackTricks

echo -e "${C6}[METHODOLOGY: WEB_RECON_AND_AUDIT]${NC}"
echo -e "--------------------------------------------------"

echo -e "${C4}Select Phase of Engagement:${NC}"
echo "1) Information Gathering (Recon)"
echo "2) Configuration & Domain Discovery"
echo "3) Authentication & Session Testing"
echo "4) Data Validation (The Injection Hunt)"
echo "5) Business Logic & Client-Side"
echo "0) Exit"

read -p "Selection: " meth_opt

case $meth_opt in
    1)
        echo -e "\n${C2}[*] Phase 1: Information Gathering${NC}"
        echo " - Fingerprint Web Server & Framework (Wappalyzer/WhatWeb)"
        echo " - Identify entry points (Forms, APIs, URL parameters)"
        echo " - Check robots.txt, sitemap.xml, and /.well-known/"
        echo " - Look for comments in HTML/JS (S3 buckets, dev API keys)"
        ;;
    2)
        echo -e "\n${C2}[*] Phase 2: Configuration Discovery${NC}"
        echo " - Test for subdomain takeover"
        echo " - Check for backup files (.bak, .old, .swp, .zip)"
        echo " - Verify TLS/SSL configurations"
        echo " - Test for HTTP Method Overriding (X-HTTP-Method-Override)"
        ;;
    3)
        echo -e "\n${C2}[*] Phase 3: Auth & Sessions${NC}"
        echo " - Test for Username Enumeration"
        echo " - Check for Weak Password Policies / Brute Force"
        echo " - Inspect Cookies (Secure, HttpOnly, SameSite flags)"
        echo " - Test Session Fixation & CSRF Protections"
        ;;
    4)
        echo -e "\n${C2}[*] Phase 4: Data Validation${NC}"
        echo " - Test SQLi, NoSQLi, and LDAP Injection"
        echo " - Check for XXE (XML External Entity)"
        echo " - Test Command Injection & SSTI"
        echo " - Look for Path Traversal (../../etc/passwd)"
        ;;
    5)
        echo -e "\n${C2}[*] Phase 5: Logic & Client-Side${NC}"
        echo " - Test IDOR (Insecure Direct Object Reference)"
        echo " - Check for Mass Assignment & Race Conditions"
        echo " - Hunt for XSS (Reflected, Stored, DOM)"
        echo " - Test CORS misconfigurations & Open Redirects"
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
