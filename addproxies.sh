#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# ProxyChains config file location
PROXYCHAINS_CONF="/etc/proxychains4.conf"

# Function to print colored text
print_color() {
    echo -e "${1}${2}${NC}"
}

# Function to get user input with a prompt
get_input() {
    read -p "$(print_color ${BLUE} "$1")" $2
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    print_color ${RED} "Please run this script as root or with sudo."
    exit 1
fi

# Welcome message
clear
print_color ${GREEN} "Welcome to the ProxyChains Configuration Helper!"
echo "This script will guide you through adding proxies to your ProxyChains configuration."
echo

# Backup the original config file
cp ${PROXYCHAINS_CONF} ${PROXYCHAINS_CONF}.backup
print_color ${GREEN} "Backup of original config file created: ${PROXYCHAINS_CONF}.backup"
echo

while true; do
    # Get proxy type
    echo "Available proxy types:"
    echo "1. HTTP"
    echo "2. SOCKS4"
    echo "3. SOCKS5"
    get_input "Enter the number for the proxy type (1-3): " proxy_type_num

    case $proxy_type_num in
        1) proxy_type="http" ;;
        2) proxy_type="socks4" ;;
        3) proxy_type="socks5" ;;
        *) print_color ${RED} "Invalid choice. Please try again."; continue ;;
    esac

    # Get proxy IP address
    get_input "Enter the proxy IP address: " proxy_ip

    # Get proxy port
    get_input "Enter the proxy port number: " proxy_port

    # Confirm the entered information
    echo
    print_color ${GREEN} "You entered the following proxy information:"
    echo "Type: $proxy_type"
    echo "IP: $proxy_ip"
    echo "Port: $proxy_port"
    echo

    get_input "Is this information correct? (y/n): " confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        # Add the proxy to the config file
        echo "$proxy_type $proxy_ip $proxy_port" >> ${PROXYCHAINS_CONF}
        print_color ${GREEN} "Proxy added successfully!"
    else
        print_color ${RED} "Proxy not added. Please try again."
    fi

    echo
    get_input "Do you want to add another proxy? (y/n): " add_another
    if [[ ! $add_another =~ ^[Yy]$ ]]; then
        break
    fi
    echo
done

print_color ${GREEN} "ProxyChains configuration updated successfully!"
print_color ${BLUE} "You can now use ProxyChains with your added proxies."
echo "To use ProxyChains, run your command with 'proxychains' in front, like this:"
echo "proxychains firefox"
echo
print_color ${GREEN} "Thank you for using the ProxyChains Configuration Helper!"
