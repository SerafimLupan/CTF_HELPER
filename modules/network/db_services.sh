#!/bin/bash
# CTF_HELPER - Database Services Module
# Targets: MySQL (3306), Postgres (5432), Redis (6379), MSSQL (1433), MongoDB (27017)

source ./ctf_helper.sh

echo -e "${C6}[MODULE: DATABASE SERVICES]${NC}"
echo -e "Target: ${C3}$TARGET_IP${NC}\n"

echo "1) MySQL (3306)    - Empty Pass, User Enum, & DB Dumping"
echo "2) PostgreSQL (5432)- Default Creds & RCE via COPY FROM PROGRAM"
echo "3) Redis (6379)    - Unauth Access, Info & SSH Key Injection"
echo "4) MSSQL (1433)    - Trusted Conn & xp_cmdshell RCE"
echo "5) MongoDB (27017) - Unauth Login & Database Listing"
echo "6) Cassandra (9042)- Default Superuser Check"
echo "0) Back to Network Menu"

echo -ne "\n${C5}db_services > ${NC}"
read dbopt

case $dbopt in
    1) # MySQL - pentesting-mysql.md
        echo -e "${C4}[*] Running MySQL Enumeration...${NC}"
        nmap -sV --script mysql-empty-password,mysql-info,mysql-users,mysql-databases -p 3306 "$TARGET_IP"
        echo -e "\n${C3}Manual Tip: mysql -h $TARGET_IP -u root${NC}"
        ;;
    2) # PostgreSQL - pentesting-postgresql.md
        echo -e "${C4}[*] Checking for Common Postgres Vulnerabilities...${NC}"
        nmap -p 5432 --script pgsql-brute "$TARGET_IP"
        echo -e "\n${C3}Manual Tip: psql -h $TARGET_IP -U postgres${NC}"
        ;;
    3) # Redis - 6379-pentesting-redis.md
        echo -e "${C4}[*] Checking for Unauthenticated Redis Access...${NC}"
        redis-cli -h "$TARGET_IP" --stat
        echo -e "${C4}[*] Attempting to fetch INFO...${NC}"
        redis-cli -h "$TARGET_IP" info | grep -E "redis_version|os|process_id"
        ;;
    4) # MSSQL - pentesting-mssql-microsoft-sql-server/
        echo -e "${C4}[*] Scanning MSSQL Instances...${NC}"
        nmap -p 1433 --script ms-sql-info,ms-sql-empty-password,ms-sql-ntlm-info "$TARGET_IP"
        ;;
    5) # MongoDB - 27017-27018-mongodb.md
        echo -e "${C4}[*] Checking for MongoDB Unauth Access...${NC}"
        mongosh --host "$TARGET_IP" --eval "db.adminCommand('listDatabases')" --quiet
        ;;
    6) # Cassandra - cassandra.md
        echo -e "${C4}[*] Testing Cassandra default login (cassandra:cassandra)...${NC}"
        cqlsh "$TARGET_IP" -u cassandra -p cassandra
        ;;
    0) return ;;
esac

echo -e "\n--------------------------------------------------"
read -p "Press Enter to continue..."
./modules/network/db_services.sh
