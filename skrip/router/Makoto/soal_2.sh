#!/bin/bash
# Soal 2: IP tiap interface dan IP forwarding (Makoto). Aman dijalankan ulang.
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0; ip addr add 10.72.4.162/30 dev eth0; ip link set eth0 up
ip addr flush dev eth1; ip addr add 10.72.4.89/29 dev eth1; ip link set eth1 up
