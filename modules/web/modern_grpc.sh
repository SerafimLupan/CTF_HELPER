#!/bin/bash
# HackTricks Ref: pentesting-grpc
# Module: gRPC Security & Protocol Buffer Exploitation

echo -e "${C6}[WEB ATTACK: MODERN_GRPC]${NC}"
echo -e "Reference: https://book.hacktricks.xyz/pentesting-web/pentesting-grpc"
echo -e "--------------------------------------------------"

echo -e "${C4}Select gRPC Attack Vector:${NC}"
echo "1) Reflection Discovery (Service Enumeration)"
echo "2) Authentication Bypass (Metadata manipulation)"
echo "3) Protobuf Injection & Logic Flaws"
echo "4) DoS: Resource Exhaustion (HTTP/2 Streams)"
echo "5) Tools & Recon Cheat Sheet"
echo "0) Exit"

read -p "Selection: " grpc_opt

case $grpc_opt in
    1)
        echo -e "\n${C2}[*] Service Discovery:${NC}"
        echo "If Server Reflection is enabled, you can list all services:"
        echo "Command: grpcurl -plaintext <target> list"
        echo "Command: grpcurl -plaintext <target> describe <service_name>"
        ;;
    2)
        echo -e "\n${C2}[*] Metadata & Auth Attacks:${NC}"
        echo "gRPC uses 'metadata' (HTTP/2 headers) for auth."
        echo " - Check for 'authorization' or 'x-api-key' headers."
        echo " - Try to inject: 'x-forwarded-for', 'x-host', 'x-real-ip'."
        echo " - Test for JWT vulnerabilities if tokens are passed in metadata."
        ;;
    3)
        echo -e "\n${C2}[*] Protobuf Injection:${NC}"
        echo "Even if binary, inputs are still processed. Test for:"
        echo " - SQLi/Command Injection inside string fields."
        echo " - Negative values in integer fields (Payment/Quantity bypass)."
        echo " - Overly large strings to test for buffer overflows in custom parsers."
        ;;
    4)
        echo -e "\n${C2}[*] gRPC DoS Vectors:${NC}"
        echo " - Unary Call Flood: Sending many small requests."
        echo " - Stream Multiplexing: Opening too many HTTP/2 streams."
        echo " - Large Payload Attack: Sending massive protobuf messages to exhaust RAM."
        ;;
    5)
        echo -e "\n${C2}[*] Recommended Tools:${NC}"
        echo " - grpcurl: The 'curl' for gRPC."
        echo " - ghz: gRPC benchmarking and DoS testing."
        echo " - Burp Suite: Use 'gRPC Web' or 'Protobuf' extensions."
        echo " - Postman: Now has native gRPC support."
        ;;
    *) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to return..."
