#!/bin/bash
total_mem=$(grep MemTotal /proc/meminfo | sed 's/^[^0-9]*//g'|sed 's/kB//g')
total_mem_g=$(($total_mem/1048576))
memory_Hz=$(dmidecode|grep -A16 "Memory Device" | grep 'Speed'|uniq |grep 'Hz'|sed 's/^.*: //g'|uniq)
memory_max=$(dmidecode | grep  "Maximum Capacity"|sed 's/^.*: //g')
memory_list=$(dmidecode|grep  -A5 "Memory Device"|grep Size)
memory_num=$(dmidecode|grep -A5 "Memory Device"|grep Size -c)
memory_num_used=$(dmidecode|grep -A5 "Memory Device"|grep MB -c)
total=$(free -m | sed -n '2p' | awk '{print $2}')
used=$(free -m | sed -n '2p' | awk '{print $3}')
free=$(free -m | sed -n '2p' | awk '{print $4}')
shared=$(free -m | sed -n '2p' | awk '{print $5}')
buff=$(free -m | sed -n '2p' | awk '{print $6}')
cached=$(free -m | sed -n '2p' | awk '{print $7}')
rate=`echo "scale=2;$used/$total" | bc | awk -F. '{print $2}'`
echo "*****内存******"
echo "总内存: $total_mem KB"
echo "总内存: $total_mem_g G"
echo -e "${used}M/${total}M\n使用率:${rate}%"
echo "内存频率: $memory_Hz"
echo "内存大小: $memory_max"
echo "内存数: $memory_num"
echo "装载内存: $memory_num_used"
echo "内存列表:"
echo "$memory_list"
if    [ $rate -ge 80 ]
then    echo "内存排行"
    ps aux | grep -v USER | sort -rn -k4 | head
fi
