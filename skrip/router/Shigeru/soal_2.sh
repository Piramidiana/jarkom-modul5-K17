#!/bin/bash
# Soal 2: IP tiap interface dan IP forwarding (Shigeru). Aman dijalankan ulang.
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0; ip addr add 10.72.4.158/30 dev eth0; ip link set eth0 up
ip addr flush dev eth1; ip addr add 10.72.4.81/29 dev eth1; ip link set eth1 up
ip addr flush dev eth2; ip addr add 10.72.4.161/30 dev eth2; ip link set eth2 up
