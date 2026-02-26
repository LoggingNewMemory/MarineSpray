#!/system/bin/sh
# Marine's Anti-Horny Spray Module - Enforcer

MODULE_DIR="/data/adb/modules/MarineSpray/Marine"
FINAL_SPRAY="$MODULE_DIR/spray.txt"

marine_main() {
    # 1. Systemless Hosts Override
    # Bind mount the pre-existing spray.txt over the system hosts file
    if [ -f "$FINAL_SPRAY" ]; then
        chmod 644 "$FINAL_SPRAY"
        mount --bind "$FINAL_SPRAY" /system/etc/hosts
    fi

    # 2. Enforce Safe DNS (OpenDNS FamilyShield)
    # Block Private DNS (Port 853) so Android doesn't bypass our trap
    iptables -I OUTPUT -p tcp --dport 853 -j REJECT
    ip6tables -I OUTPUT -p tcp --dport 853 -j REJECT

    # Redirect all Standard DNS (Port 53) traffic to OpenDNS
    for dns in 208.67.222.123 208.67.220.123; do
        iptables -t nat -I OUTPUT -p udp --dport 53 -j DNAT --to-destination "$dns"
        iptables -t nat -I OUTPUT -p tcp --dport 53 -j DNAT --to-destination "$dns"
    done
}

marine_main

# 1 Corinthians 6:18 - 19 (NIV)
# (18) Flee from sexual immorality. All other sins a man commits are outside
# his body, but he who sins sexually sins against his own body
# (19) Do you not know that your body is a temple of the Holy Spirit, who is
# in you, whom you have received from God? You are not your own