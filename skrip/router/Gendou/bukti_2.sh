#!/bin/bash
# Soal 2: bukti IP interface dan ping dua ujung tiap link (Gendou)
hostname
ip -br -4 a
sysctl net.ipv4.ip_forward
for x in Hikari:10.72.4.113:10.72.4.114 Yui:10.72.4.117:10.72.4.118 Fuyutsuki:10.72.4.145:10.72.4.146 Misato:10.72.4.149:10.72.4.150 Shigeru:10.72.4.157:10.72.4.158 Asuka:10.72.4.165:10.72.4.166 Kaji:10.72.4.169:10.72.4.170; do
  IFS=: read n a b <<< "$x"
  for ip in $a $b; do
    if ping -c 1 -W 1 $ip >/dev/null 2>&1; then echo "OK     $n $ip"; else echo "GAGAL  $n $ip"; fi
  done
done
