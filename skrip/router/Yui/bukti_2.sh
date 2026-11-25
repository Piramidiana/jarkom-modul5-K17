#!/bin/bash
# Soal 2: bukti IP interface dan ping ke router tetangga (Yui)
hostname
ip -br -4 a
for ip in 10.72.4.117 10.72.4.110 10.72.4.134 10.72.4.138; do
  echo "ping $ip"
  ping -c 2 -W 1 $ip | grep "packets transmitted"
done
