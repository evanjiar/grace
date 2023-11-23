#!/bin/bash

while [ 1 ]
do
  cpu_total=`top -b -n 1 | grep Cpu | awk '{print (100-$8)}' | cut -f 1 -d "%"`
  cpu_user=`top -b -n 1 | grep Cpu | awk '{print $2}' | cut -f 1 -d "%"`
  cpu_system=`top -b -n 1 | grep Cpu | awk '{print $4}' | cut -f 1 -d "%"`
  cpu_idle=`top -b -n 1 | grep Cpu | awk '{print $8}' | cut -f 1 -d "%"`
  cpu_iowait=`top -b -n 1 | grep Cpu | awk '{print $10}' | cut -f 1 -d "%"`
  current_time=`date '+%Y-%m-%d %H:%M:%S'`
  echo "[$current_time] $cpu_total $cpu_user $cpu_system $cpu_idle $cpu_iowait" >> cpu.log
  sleep 1
done
