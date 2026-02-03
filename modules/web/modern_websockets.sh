#!/bin/bash
# HackTricks Ref: pentesting-web-websockets
# Module: WebSocket Security (CSWSH & Data Injection)

echo -e "${C6}[WEB ATTACK: MODERN_WEBSOCKETS]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/pentesting-web-websockets"
echo -e "--------------------------------------------------"

echo -e "${C4}Select WebSocket Attack Vector:${NC}"
echo "1) CSWSH (Cross-Site WebSocket Hijacking)"
echo "2) Message Injection (SQLi/XSS/Command Injection)"
echo "3) Authentication & Session Fixation"
echo "4) DoS: Connection & Message Flooding"
echo "5) Tools & Recon (Burp/Python-ws)"
echo "0) Exit"

read -p "Selection: " ws_opt

case $ws_opt in
    1)
        echo -e "\n${C2}[*] CSWSH (Cross-Site WebSocket Hijacking):${NC}"
        echo "Similar to CSRF, but for WebSockets. The server fails to check the 'Origin' header."
        echo "1. Victim visits attacker.com."
        echo "2. attacker.com opens a WebSocket connection to target.com."
        echo "3. The browser sends target.com's cookies automatically."
        echo "4. The attacker now has a full-duplex tunnel to the victim's account."
        ;;
    2)
        echo -e "\n${C2}[*] Message Injection:${NC}"
        echo "The application might trust WebSocket messages more than HTTP requests."
        echo "Test for injection in JSON/Binary payloads:"
        echo " - XSS: {\"message\": \"<script>alert(1)</script>\"}"
        echo " - SQLi: {\"id\": \"1' OR 1=1--\"}"
        echo " - IDOR: {\"action\": \"get_user\", \"user_id\": \"124\"}"
        ;;
    3)
        echo -e "\n${C2}[*] Auth & Session Weaknesses:${NC}"
        echo " - Check if authentication is only done during the HTTP handshake."
        echo " - If the session cookie expires, does the WebSocket close? (Often, it doesn't)."
        echo " - Check for 'sec-websocket-key' predictability (rare, but possible)."
        ;;
    4)
        echo -e "\n${C2}[*] WebSocket Denial of Service:${NC}"
        echo " - Connection Exhaustion: Open thousands of sockets without closing them."
        echo " - Message Flood: Send massive frames to overwhelm the server's parser."
        echo " - Oversized Frames: Send a frame header claiming 1TB of data."
        ;;
    5)
        echo -e "\n${C2}[*] Tools of the Trade:${NC}"
        echo " - Burp Suite: 'WebSockets history' tab + Repeater support."
        echo " - Wscat: 'wscat -c ws://target.com/socket'"
        echo " - Wireshark: Filter by 'websocket'."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
