#!/system/bin/sh
# Magisk Action Script - Updates the Spray

MODDIR=${0%/*}
CUSTOM_SPRAY="$MODDIR/custom_spray.txt"
FINAL_SPRAY="$MODDIR/spray.txt"
TMP_HOSTS="$MODDIR/temp_hosts.txt"
STEVEN_BLACK_URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn-only/hosts"

echo "[*] Loading Marine's Anti-Horny Spray Updater..."
echo "[*] Checking internet connection..."

# Check DNS resolution
if ! ping -c 1 -W 2 raw.githubusercontent.com >/dev/null 2>&1; then
    echo "[!] Error: No internet or DNS is broken."
    echo "[!] Repentance requires Wi-Fi AND working DNS. Try again later."
    exit 1
fi

echo "[*] Downloading the latest StevenBlack adult blocklist..."

attempt=1
max_attempts=3
success=0

while [ $attempt -le $max_attempts ]; do
    echo "[*] Attempt $attempt of $max_attempts..."
    busybox wget -q -O "$TMP_HOSTS" "$STEVEN_BLACK_URL"
    
    if [ -s "$TMP_HOSTS" ]; then
        success=1
        break
    fi
    
    attempt=$((attempt + 1))
    sleep 2
done

if [ $success -eq 1 ]; then
    echo "[*] Download successful!"
    
    # Start fresh with the downloaded list
    mv "$TMP_HOSTS" "$FINAL_SPRAY"
    
    # Append your custom manual domains if the file exists
    if [ -f "$CUSTOM_SPRAY" ]; then
        echo "[*] Merging your custom domains..."
        echo -e "\n# --- Marine's Custom Spray Blocklist ---" >> "$FINAL_SPRAY"
        cat "$CUSTOM_SPRAY" >> "$FINAL_SPRAY"
    fi
    
    # Apply the new hosts file immediately without needing a reboot
    echo "[*] Applying new blocklist dynamically..."
    chmod 644 "$FINAL_SPRAY"
    umount /system/etc/hosts 2>/dev/null
    mount --bind "$FINAL_SPRAY" /system/etc/hosts
    
    echo "[*] Success! You are protected."
else
    echo "[!] Error: Download failed after 3 attempts. Keeping previous list."
    rm -f "$TMP_HOSTS"
fi

echo "[*] Done! Stay pure."
sleep 3