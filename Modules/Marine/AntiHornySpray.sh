HOSTS_FILE="/system/etc/hosts"
SPRAY="/data/adb/modules/MarineSpray/Marine/spray.txt"

marine_main() {
    # Append blocked domains to hosts file
    if [ -f "$SPRAY" ]; then
        if ! grep -qFf "$SPRAY" "$HOSTS_FILE"; then
            cat "$SPRAY" >> "$HOSTS_FILE"
        fi
    fi

    # Block domains via iptables (even through VPN)
    if [ -f "$SPRAY" ]; then
        while read -r domain; do
            for ip in $(nslookup "$domain" | grep "Address:" | cut -d " " -f 2); do
                iptables -A OUTPUT -d "$ip" -j REJECT
                iptables -A FORWARD -d "$ip" -j REJECT
                
                if [[ "$ip" =~ ":" ]]; then
                    ip6tables -A OUTPUT -d "$ip" -j REJECT
                    ip6tables -A FORWARD -d "$ip" -j REJECT
                fi
            done
        done < "$SPRAY"
    fi

    # Remove VPN blocking, allow VPN usage
    iptables -F OUTPUT
    ip6tables -F OUTPUT
    
    # Force safe DNS (OpenDNS FamilyShield) to block porn
    for dns in 208.67.222.123 208.67.220.123; do
        iptables -t nat -A OUTPUT -p udp --dport 53 -j DNAT --to-destination "$dns"
        iptables -t nat -A OUTPUT -p tcp --dport 53 -j DNAT --to-destination "$dns"
    done
    
    # Log blocked porn site access for debugging
    iptables -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "Porn Blocked: " --log-level 4
}

marine_main


# You managed to read this? 
# Stop bussing everyday like Marine!
# REPENT!!!!

# 1 Corinthians 6:18 - 19 (NIV)
# (18) Flee from sexual immorality. All other sins a man commits are outside
# his body, but he who sins sexually sins againts his own body
# (19) Do you not know that your body is a temple of the Holy Spirit, who is
# in you, whom you have received from God? You are not your own

