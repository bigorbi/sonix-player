#!/bin/sh

ulimit -s 1024
export MALLOC_ARENA_MAX=1

killall    sonix_player    &>/dev/null
killall -9 sonix_player    &>/dev/null

if [ -f "/usr/bin/batd" ]; then
killall    batd    &>/dev/null
killall -9 batd    &>/dev/null
#/usr/bin/batd -v -s -t5 -o /mnt/sd_0/batlog.txt &
fi

#/usr/bin/sonix_player &>/dev/null
# SD card remount in the case of cold boot issues
if [ ! -b /dev/mmcblk0 ] && [ ! -b /dev/mmcblk1 ]; then
    echo "md_ingenic,mmc.1" > /sys/bus/platform/drivers/md_ingenic,mmc/unbind 2>/dev/null
    sleep 0.5
    echo "md_ingenic,mmc.1" > /sys/bus/platform/drivers/md_ingenic,mmc/bind 2>/dev/null
    sleep 0.5
    mdev -s
fi
/usr/bin/sonix_player
sleep 1
reboot
