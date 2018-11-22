#!/bin/bash

# Colors
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
SKYBLUE='\033[0;36m'
PLAIN='\033[0m'



corescache=$( awk -F: '/cache size/ {cache=$2} END {print cache}' /proc/cpuinfo | sed 's/^[ \t]*//;s/[ \t]*$//' )
tram=$( free -m | awk '/Mem/ {print $2}' )
uram=$( free -m | awk '/Mem/ {print $3}' )
bram=$( free -m | awk '/Mem/ {print $6}' )
memfree=$( free -mh | grep Mem: | awk '{print $7}' )
swap=$( free -m | awk '/Swap/ {print $2}' )
uswap=$( free -m | awk '/Swap/ {print $3}' )
up=$( awk '{a=$1/86400;b=($1%86400)/3600;c=($1%3600)/60} {printf("%d days %d hour %d min\n",a,b,c)}' /proc/uptime )
load=$( w | head -1 | awk -F'load average:' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//' )
opsy=$( awk -F'[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release )
arch=$( uname -m )
lbit=$( getconf LONG_BIT )
kern=$( uname -r )
disk_total_size=$( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|overlay|shm|udev|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $2}' )
disk_used_size=$( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|overlay|shm|udev|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $3}' )
disk_used_free=$( LANG=C df -hPl | grep -wvE '\-|none|tmpfs|overlay|shm|udev|devtmpfs|by-uuid|chroot|Filesystem' | awk '{print $4}' )
connections=$( netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print S[a]}' )
user=$( who | awk '{print $1}' )


echo  "OS              : ${SKYBLUE}$opsy ($lbit Bit) ${YELLOW}$virtual${PLAIN}"
echo  "Kernel          : ${SKYBLUE}$kern${PLAIN}"
echo  "Total Space     : ${YELLOW}$disk_total_size  ${SKYBLUE}(${RED}$disk_used_free ${SKYBLUE}Free $disk_used_size Used)${PLAIN}"
echo  "Total RAM       : ${YELLOW}$tram MB ${SKYBLUE}(${RED} $memfree ${SKYBLUE}Free $uram MB Used $bram MB Buff)${PLAIN}"
echo  "Total SWAP      : ${SKYBLUE}$swap MB ($uswap MB Used)${PLAIN}"
echo  "Connections     : $connections"
echo  "Logged in User  : \n${SKYBLUE}$user"
