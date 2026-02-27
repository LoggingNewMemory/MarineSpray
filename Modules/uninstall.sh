#!/system/bin/sh
# Marine's Anti-Horny Spray - Uninstaller (Bare-Metal Clean Reset)

TARGET_HOSTS="/system/etc/hosts"

# 1. Unmount just in case the old systemless method is still active
umount /system/etc/hosts 2>/dev/null

# 2. Remount root and system as Read-Write
mount -o rw,remount / 2>/dev/null
mount -o rw,remount /system 2>/dev/null

# 3. Test if write access was successfully granted
if touch /system/etc/test_write 2>/dev/null; then
    rm -f /system/etc/test_write
    
    # 4. Force write a default clean Android hosts file
    echo "127.0.0.1       localhost" > "$TARGET_HOSTS"
    echo "::1             ip6-localhost" >> "$TARGET_HOSTS"
    
    # 5. Restore standard Android permissions and ownership
    chmod 644 "$TARGET_HOSTS"
    chown root:root "$TARGET_HOSTS"
    
    echo "[*] Success: /system/etc/hosts has been wiped and reset to default."
else
    echo "[!] CRITICAL ERROR: Could not mount /system as Read-Write."
    echo "[!] Cannot clean the hosts file."
fi

# 6. Lock the system back down to Read-Only
mount -o ro,remount / 2>/dev/null
mount -o ro,remount /system 2>/dev/null