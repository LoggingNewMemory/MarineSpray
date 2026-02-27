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
}

marine_main

# 1 Corinthians 6:18 - 19 (NIV)
# (18) Flee from sexual immorality. All other sins a man commits are outside
# his body, but he who sins sexually sins against his own body
# (19) Do you not know that your body is a temple of the Holy Spirit, who is
# in you, whom you have received from God? You are not your own