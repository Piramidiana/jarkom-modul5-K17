#!/bin/bash
# Soal 2: bukti IP interface dan ping ke router tetangga (Asuka)
hostname
ip -br -4 a
for ip in 10.72.4.165 10.72.4.122 10.72.4.142; do
  echo "ping $ip"
  ping -c 2 -W 1 $ip | grep "packets transmitted"
done
