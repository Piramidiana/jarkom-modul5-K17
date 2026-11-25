#!/bin/bash
# Soal 2: IP tiap interface dan IP forwarding (Yui). Aman dijalankan ulang.
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth0; ip addr add 10.72.4.118/30 dev eth0; ip link set eth0 up
ip addr flush dev eth1; ip addr add 10.72.3.1/25 dev eth1; ip link set eth1 up
ip addr flush dev eth2; ip addr add 10.72.4.109/30 dev eth2; ip link set eth2 up
ip addr flush dev eth3; ip addr add 10.72.4.133/30 dev eth3; ip link set eth3 up
ip addr flush dev eth4; ip addr add 10.72.4.137/30 dev eth4; ip link set eth4 up
