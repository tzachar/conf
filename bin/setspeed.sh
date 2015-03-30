#!/bin/bash

if [ $# -ne 1 ]; then
	echo -n "Current freq: "
	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
	echo -n "Available freqs: "
	cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
	exit 1
fi

echo -n "Before: "
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

echo "Setting Govenor to userspace"
sudo sh -c 'echo -n "userspace" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
echo "Setting max freq"
sudo sh -c "echo -n $1 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq"
sudo sh -c "echo -n $1 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq"
echo "Setting min freq"
sudo sh -c "echo -n $1 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq"
sudo sh -c "echo -n $1 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq"
echo "Setting freq"
sudo sh -c "echo -n $1 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"
sudo sh -c "echo -n $1 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed"

echo -n "After freq: "
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

