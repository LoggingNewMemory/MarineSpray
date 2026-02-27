#!/system/bin/sh
# Magisk Action Script - Updates the Spray

MODULE_DIR="/data/adb/modules/MarineSpray"
FINAL_SPRAY="$MODULE_DIR/spray.txt"
STEVEN_BLACK_URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn-only/hosts"

echo "[*] Loading Marine's Anti-Horny Spray Updater..."

# Check DNS resolution
if ! ping -c 1 -W 2 raw.githubusercontent.com >/dev/null 2>&1; then
    echo "[!] Error: No internet or DNS is broken."
    echo "[!] Repentance requires Wi-Fi AND working DNS. Try again later."
    sleep 2
    exit 1
fi

echo "[*] Downloading the latest StevenBlack adult blocklist..."

attempt=1
success=0

while [ $attempt -le 3 ]; do
    echo "[*] Attempt $attempt of 3..."
    
    # Download directly into the active spray.txt
    busybox wget -q -O "$FINAL_SPRAY" "$STEVEN_BLACK_URL"
    
    if [ -s "$FINAL_SPRAY" ]; then
        success=1
        break
    fi
    
    attempt=$((attempt + 1))
    sleep 2
done

if [ $success -eq 1 ]; then
    echo "[*] Download successful!"
    echo "[*] Success! The active blocklist has been updated."
else
    echo "[!] Error: Download failed after 3 attempts."
fi

echo "[*] Done! Stay pure."
sleep 3