#!/bin/bash
# Soal 2: bukti IP interface dan ping ke router tetangga (Ritsuko)
hostname
ip -br -4 a
for ip in 10.72.4.141; do
  echo "ping $ip"
  ping -c 2 -W 1 $ip | grep "packets transmitted"
done
