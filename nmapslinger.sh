#!/bin/bash

# Loading Animation Function
loading_gunslinger() {
    printf "Loading Scanner "
    for i in {1..5}; do
        printf "."
        sleep 0.2
    done
    echo " READY!"
}

# Banner with ASCII Gun
banner() {
    clear
    echo "========================================="
    echo "    WILD GUNSLINGER - CTF Toolkit"
    echo "========================================="
    echo "       Primed for CTF challenges..."
    echo
    echo "          Gunslinger Scanner Ready:"
    echo "          /                                 />"
    echo "          \__+_____________________/\/\___/ /|"
    echo "          ()______________________      / /|/\ "
    echo "                      /0 0  ---- |----    /---\ "
    echo "                     |0 o 0 ----|| - \ --|      \ "
    echo "                      \0_0/____/ |    |  |\      \ "
    echo "                          \__/__/  |      \ "
    echo "          Bang! Bang!              |       \ "
    echo "                                   |         \ "
    echo "                                   |__________|\ "
    echo
}

# Function to display menu
show_menu() {
    echo "Target Scan Options:"
    echo "  [1] Full TCP Scan (-T4 -p-)"
    echo "  [2] Stealth TCP Scan (-sS)"
    echo "  [3] Service Version Scan (-sV)"
    echo "  [4] Aggressive Scan (-A)"
    echo "  [5] UDP Scan (-sU)"
    echo "  [6] OS Detection (-O)"
    echo "  [7] Vulnerability Scan (--script vuln)"
    echo "  [8] Quick Port Scan (-p 1-1000)"
    echo "  [9] Exhaustive Port Scan (-p 1-65535)"
    echo " [10] Custom Script Scan (--script)"
    echo "  --- CTF Bonus Scans ---"
    echo " [11] Host Discovery (-sn)"
    echo " [12] Web Enumeration (--script http-enum)"
    echo " [13] SMB Enumeration (--script smb-enum-*)"
    echo " [14] SSH Enumeration (--script ssh-enum-algos)"
    echo " [15] DNS Enumeration (--script dns-zone-transfer)"
    echo " [16] FTP Enumeration (--script ftp-anon)"
    echo " [17] SMTP Enumeration (--script smtp-enum-users)"
    echo " [18] SSL/TLS Check (--script ssl-cert)"
    echo " [19] Default Script Scan (--script default)"
    echo " [20] Port Timing Scan (-T5)"
    echo "  [0] Exit"
}

# Main Nmap Gunslinger Function
nmap_gunslinger() {
    show_menu
    echo -n "Select Scan Type: "
    read scan_type

    if [ "$scan_type" != "0" ]; then
        echo -n "Target IP: "
        read target
        if [ -z "$target" ]; then
            echo "Target required - scan aborted!"
            return
        fi
    fi

    case $scan_type in
        1)
            loading_gunslinger
            nmap -T4 -p- "$target" | tee "full_tcp_$target.txt"
            echo "Full TCP scan completed - logged to full_tcp_$target.txt"
            ;;
        2)
            loading_gunslinger
            nmap -sS "$target" | tee "stealth_tcp_$target.txt"
            echo "Stealth TCP scan completed - logged to stealth_tcp_$target.txt"
            ;;
        3)
            loading_gunslinger
            nmap -sV "$target" | tee "service_$target.txt"
            echo "Service version scan completed - logged to service_$target.txt"
            ;;
        4)
            loading_gunslinger
            nmap -A "$target" | tee "aggressive_$target.txt"
            echo "Aggressive scan completed - logged to aggressive_$target.txt"
            ;;
        5)
            loading_gunslinger
            nmap -sU "$target" | tee "udp_$target.txt"
            echo "UDP scan completed - logged to udp_$target.txt"
            ;;
        6)
            loading_gunslinger
            nmap -O "$target" | tee "os_$target.txt"
            echo "OS detection completed - logged to os_$target.txt"
            ;;
        7)
            loading_gunslinger
            nmap --script vuln "$target" | tee "vuln_$target.txt"
            echo "Vulnerability scan completed - logged to vuln_$target.txt"
            ;;
        8)
            loading_gunslinger
            nmap -p 1-1000 "$target" | tee "quick_$target.txt"
            echo "Quick port scan completed - logged to quick_$target.txt"
            ;;
        9)
            loading_gunslinger
            nmap -p 1-65535 "$target" | tee "exhaustive_$target.txt"
            echo "Exhaustive port scan completed - logged to exhaustive_$target.txt"
            ;;
        10)
            echo -n "Input custom script (e.g., http-enum): "
            read custom_script
            if [ -z "$custom_script" ]; then
                echo "Script required - scan aborted!"
                return
            fi
            loading_gunslinger
            nmap --script "$custom_script" "$target" | tee "custom_$target.txt"
            echo "Custom script scan completed - logged to custom_$target.txt"
            ;;
        11)
            loading_gunslinger
            nmap -sn "$target" | tee "discovery_$target.txt"
            echo "Host discovery completed - logged to discovery_$target.txt"
            ;;
        12)
            loading_gunslinger
            nmap --script http-enum "$target" | tee "web_$target.txt"
            echo "Web enumeration completed - logged to web_$target.txt"
            ;;
        13)
            loading_gunslinger
            nmap --script smb-enum-* "$target" | tee "smb_$target.txt"
            echo "SMB enumeration completed - logged to smb_$target.txt"
            ;;
        14)
            loading_gunslinger
            nmap --script ssh-enum-algos "$target" | tee "ssh_$target.txt"
            echo "SSH enumeration completed - logged to ssh_$target.txt"
            ;;
        15)
            loading_gunslinger
            nmap --script dns-zone-transfer "$target" | tee "dns_$target.txt"
            echo "DNS enumeration completed - logged to dns_$target.txt"
            ;;
        16)
            loading_gunslinger
            nmap --script ftp-anon "$target" | tee "ftp_$target.txt"
            echo "FTP enumeration completed - logged to ftp_$target.txt"
            ;;
        17)
            loading_gunslinger
            nmap --script smtp-enum-users "$target" | tee "smtp_$target.txt"
            echo "SMTP enumeration completed - logged to smtp_$target.txt"
            ;;
        18)
            loading_gunslinger
            nmap --script ssl-cert "$target" | tee "ssl_$target.txt"
            echo "SSL/TLS check completed - logged to ssl_$target.txt"
            ;;
        19)
            loading_gunslinger
            nmap --script default "$target" | tee "default_$target.txt"
            echo "Default script scan completed - logged to default_$target.txt"
            ;;
        20)
            loading_gunslinger
            nmap -T5 "$target" | tee "timing_$target.txt"
            echo "Port timing scan completed - logged to timing_$target.txt"
            ;;
        0)
            echo "Exiting toolkit..."
            exit 0
            ;;
        *)
            echo "Invalid scan type - try again!"
            ;;
    esac
}

# Main Loop
while true; do
    banner
    nmap_gunslinger
    echo
    echo "Press Enter to reload scanner..."
    read
done

