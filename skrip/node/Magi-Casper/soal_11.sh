#!/bin/bash
# Soal 11: Casper jadi hantu, tolak ping masuk. Ping keluar dan TCP 5000 tetap jalan.
iptables -C INPUT -p icmp --icmp-type echo-request -j DROP 2>/dev/null || iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
