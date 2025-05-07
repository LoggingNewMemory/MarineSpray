while [ -z "$(getprop sys.boot_completed)" ]; do
	sleep 30
    /data/adb/modules/MarineSpray/Marine/AntiHornySpray.sh
done

