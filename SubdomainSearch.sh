#!/bin/bash

CLR=$'\033[1;35m'
GREEN='\033[1;32m'
NC=$'\033[0m'
banner="         	 ____  ____  ____  
                / ___||  _ \/ ___| 
                \___ \| | | \___ \ 
                 ___) | |_| |___) |
                |____/|____/|____/ 
               Simple Domain Search"


echo "${CLR}$banner${NC}"

echo "
${CLR}A basic script for searching subdomains with ping.${NC}
"

read -p "Enter the domain: " domain

wordlist="/usr/share/wordlists/dirb/small.txt"

echo "[1] Use default wordlist (/dirb/small.txt)"
echo "[2] Use your own wordlist"
read -p "Enter your choice: " choice

if [[ "$choice" = "2" ]]; then
    read -p "Enter your wordlist: " wordlist
fi

if [ ! -f "$wordlist" ]; then
    echo "$wordlist not found"
else
    echo "${CLR}Starting subdomain search for $domain${NC}"
    while IFS= read -r line || [[ -n "$line" ]]; do
        success=$(ping -c 1 -W 1 "$line.$domain" 2>/dev/null | grep 'PING' )
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}$success${NC}"
        fi
    done < "$wordlist"
fi
