#!/bin/bash
total_physical_CPU_num=$(cat /proc/cpuinfo|grep "physical id"|sort|uniq|wc -l)
cpu_bit=$(getconf LONG_BIT)
core_num_per_physical=$(cat /proc/cpuinfo|grep "core id"|sort|uniq|wc -l)
total_core_num=$(($core_num_per_physical*$total_physical_CPU_num))
total_processor_num=$(cat /proc/cpuinfo|grep "processor"|wc -l)
CPU_name=$(cat /proc/cpuinfo|grep "model name"|uniq|sed 's/^.*://g')
TIME_INTERVAL=5
time=$(date "+%Y-%m-%d %H:%M:%S")
LAST_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
LAST_SYS_IDLE=$(echo $LAST_CPU_INFO | awk '{print $4}')
LAST_TOTAL_CPU_T=$(echo $LAST_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')
sleep ${TIME_INTERVAL}
NEXT_CPU_INFO=$(cat /proc/stat | grep -w cpu | awk '{print $2,$3,$4,$5,$6,$7,$8}')
NEXT_SYS_IDLE=$(echo $NEXT_CPU_INFO | awk '{print $4}')
NEXT_TOTAL_CPU_T=$(echo $NEXT_CPU_INFO | awk '{print $1+$2+$3+$4+$5+$6+$7}')

#系统空闲时间
SYSTEM_IDLE=`echo ${NEXT_SYS_IDLE} ${LAST_SYS_IDLE} | awk '{print $1-$2}'`
#CPU总时间
TOTAL_TIME=`echo ${NEXT_TOTAL_CPU_T} ${LAST_TOTAL_CPU_T} | awk '{print $1-$2}'`
CPU_USAGE=`echo ${SYSTEM_IDLE} ${TOTAL_TIME} | awk '{printf "%.2f", 100-$1/$2*100}'`
echo "===>****CPU****<==="
echo "当前时间-> $time"
echo "CPU-名字: $CPU_name"
echo "物理CPU: $total_physical_CPU_num"
echo "核数: $total_core_num"
echo "处理器数: $total_processor_num"
echo "CPU-BIT: $cpu_bit"
echo "CPU 使用率:${CPU_USAGE}%"
