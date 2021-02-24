#!/bin/bash
total_disk=$(fdisk -l | grep '^Disk'| sed 's/,.*//g')
ina=`awk '/pgpgin/{print $2}' /proc/vmstat`
sleep 240s
inb=`awk '/pgpgin/{print $2}' /proc/vmstat`
ioin=$(((inb-ina)/240))
outa=`awk '/pgpgout/{print $2}' /proc/vmstat`
sleep 240s
outb=`awk '/pgpgout/{print $2}' /proc/vmstat`
ioout=$(((outb-outa)/240))
DEV=`df -hP | grep '^/dev/*' | cut -d' ' -f1 | sort`
for I in $DEV
do 
dev=`df -Ph | grep $I | awk '{print $1}'`
size=`df -Ph | grep $I | awk '{print $2}'`
used=`df -Ph | grep $I | awk '{print $3}'`
free=`df -Ph | grep $I | awk '{print $4}'`
rate=`df -Ph | grep $I | awk '{print $5}'`
mount=`df -Ph | grep $I | awk '{print $6}'`
echo "****硬盘****"
echo "总硬盘: $total_disk"
echo -e "$I:\t$used/$size"
echo "使用率；$rate"
echo "读取: $ioin"
echo "写入: $ioout"
done
