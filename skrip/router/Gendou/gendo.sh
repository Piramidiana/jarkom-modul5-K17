#!/bin/bash
# gendo.sh - konfigurasi Gendou untuk soal 2, 3, 4, dan 5. Aman dijalankan ulang.
# Dipanggil otomatis saat boot oleh /root/startup.sh.

# ===== Soal 2: IP interface (eth0 dari DHCP lewat /etc/network/interfaces) dan IP forwarding
sysctl -w net.ipv4.ip_forward=1
ip addr flush dev eth1; ip addr add 10.72.4.105/30 dev eth1; ip link set eth1 up
ip addr flush dev eth2; ip addr add 10.72.4.113/30 dev eth2; ip link set eth2 up
ip addr flush dev eth3; ip addr add 10.72.4.117/30 dev eth3; ip link set eth3 up
ip addr flush dev eth4; ip addr add 10.72.4.145/30 dev eth4; ip link set eth4 up
ip addr flush dev eth5; ip addr add 10.72.4.149/30 dev eth5; ip link set eth5 up
ip addr flush dev eth6; ip addr add 10.72.4.157/30 dev eth6; ip link set eth6 up
ip addr flush dev eth7; ip addr add 10.72.4.165/30 dev eth7; ip link set eth7 up
ip addr flush dev eth8; ip addr add 10.72.4.169/30 dev eth8; ip link set eth8 up

# ===== Soal 3: routing statis (default route datang dari DHCP NAT1)
ip route replace 10.72.2.0/24 via 10.72.4.114    # lewat Hikari
ip route replace 10.72.3.224/27 via 10.72.4.114    # lewat Hikari
ip route replace 10.72.4.128/30 via 10.72.4.114    # lewat Hikari
ip route replace 10.72.0.0/23 via 10.72.4.118    # lewat Yui
ip route replace 10.72.3.0/25 via 10.72.4.118    # lewat Yui
ip route replace 10.72.4.0/27 via 10.72.4.118    # lewat Yui
ip route replace 10.72.4.32/28 via 10.72.4.118    # lewat Yui
ip route replace 10.72.4.108/30 via 10.72.4.118    # lewat Yui
ip route replace 10.72.4.132/30 via 10.72.4.118    # lewat Yui
ip route replace 10.72.4.136/30 via 10.72.4.118    # lewat Yui
ip route replace 10.72.3.192/27 via 10.72.4.146    # lewat Fuyutsuki
ip route replace 10.72.4.56/29 via 10.72.4.146    # lewat Fuyutsuki
ip route replace 10.72.4.72/29 via 10.72.4.146    # lewat Fuyutsuki
ip route replace 10.72.4.124/30 via 10.72.4.146    # lewat Fuyutsuki
ip route replace 10.72.4.152/30 via 10.72.4.146    # lewat Fuyutsuki
ip route replace 10.72.4.64/29 via 10.72.4.150    # lewat Misato
ip route replace 10.72.4.80/28 via 10.72.4.158    # lewat Shigeru
ip route replace 10.72.4.160/30 via 10.72.4.158    # lewat Shigeru
ip route replace 10.72.3.128/26 via 10.72.4.166    # lewat Asuka
ip route replace 10.72.4.48/29 via 10.72.4.166    # lewat Asuka
ip route replace 10.72.4.96/30 via 10.72.4.166    # lewat Asuka
ip route replace 10.72.4.120/30 via 10.72.4.166    # lewat Asuka
ip route replace 10.72.4.140/30 via 10.72.4.166    # lewat Asuka
ip route replace 10.72.4.100/30 via 10.72.4.170    # lewat Kaji

# ===== Soal 4: NAT, hanya prefix internal yang keluar lewat interface NAT1 (eth0)
iptables -t nat -C POSTROUTING -s 10.72.0.0/16 -o eth0 -j MASQUERADE 2>/dev/null || iptables -t nat -A POSTROUTING -s 10.72.0.0/16 -o eth0 -j MASQUERADE

# ===== Soal 5: firewall, policy INPUT dan FORWARD DROP
iptables -F INPUT
iptables -F FORWARD
# INPUT: loopback, balasan koneksi, DHCP dari NAT1, jaringan internal ke Gendo
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i eth0 -p udp --sport 67 --dport 68 -j ACCEPT
iptables -A INPUT ! -i eth0 -s 10.72.0.0/16 -j ACCEPT
# FORWARD: balasan koneksi, internal ke internet, antar-LAN
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD ! -i eth0 -s 10.72.0.0/16 -o eth0 -j ACCEPT
iptables -A FORWARD ! -i eth0 -s 10.72.0.0/16 -d 10.72.0.0/16 -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
