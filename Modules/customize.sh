LATESTARTSERVICE=true

ui_print "------------------------------------"
ui_print "            MARINE SPRAY            " 
ui_print "------------------------------------"
ui_print "         By: Kanagawa Yamada        "
ui_print "------------------------------------"
ui_print "      READ THE TELEGRAM MESSAGE     "
ui_print "------------------------------------"
ui_print " "
sleep 1.5

ui_print "------------------------------------"
ui_print "            DEVICE INFO             "
ui_print "------------------------------------"
ui_print "DEVICE : $(getprop ro.build.product) "
ui_print "MODEL : $(getprop ro.product.model) "
ui_print "MANUFACTURE : $(getprop ro.product.system.manufacturer) "
ui_print "PROC : $(getprop ro.product.board) "
ui_print "CPU : $(getprop ro.hardware) "
ui_print "ANDROID VER : $(getprop ro.build.version.release) "
ui_print "KERNEL : $(uname -r) "
ui_print "RAM : $(free | grep Mem |  awk '{print $2}') "
ui_print " "
sleep 1.5

ui_print "------------------------------------"
ui_print "            MODULE INFO             "
ui_print "------------------------------------"
ui_print "Name : Marine Spray"
ui_print "Version : 3.0"
ui_print "Support Root : Magisk / KernelSU / APatch"
ui_print " "
sleep 1.5

ui_print "      INSTALLING MARINE SPRAY       "
ui_print " "
sleep 1.5

unzip -o "$ZIPFILE" 'Marine/*' -d $MODPATH >&2
set_perm_recursive $MODPATH/Marine 0 0 0774 0774

sleep 1.5

ui_print "------------------------------------"
ui_print "      DOWNLOADING BLOCKLIST         "
ui_print "------------------------------------"

STEVEN_BLACK_URL="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/porn-only/hosts"
DYNAMIC_HOSTS="$MODPATH/dynamic_hosts.txt"

attempt=1
max_attempts=3
success=0

while [ $attempt -le $max_attempts ]; do
    ui_print "- Fetching StevenBlack hosts (Attempt $attempt of $max_attempts)..."
    busybox wget -q -O "$DYNAMIC_HOSTS" "$STEVEN_BLACK_URL"
    
    if [ -s "$DYNAMIC_HOSTS" ]; then
        success=1
        break
    fi
    
    attempt=$((attempt + 1))
    sleep 2
done

if [ $success -eq 1 ]; then
    ui_print "- Download successful!"
else
    ui_print "- Download failed! Service will try again on boot."
fi

sleep 1.5
ui_print " "

ui_print "   A Piece of Bible Verse For You     "
ui_print " Why? Kanagawa Yamada is a Christian  "
ui_print " "
ui_print "          ROMANS 6:12 (NIV)           "
ui_print "Therefore do not let sin reign in your"
ui_print "   mortal body so that you obey its   "
ui_print "            EVIL DESIRES              "