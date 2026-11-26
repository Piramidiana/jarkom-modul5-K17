### ==== Misato: /root/soal_10.sh (NAT tidak boleh ada di sini, alamat asli dipertahankan) ====
cat << 'EOF' > /root/soal_10.sh
#!/bin/bash
# Perbaikan soal 10 - Misato
sysctl -w net.ipv4.ip_forward=1 >/dev/null
iptables -t nat -F                  # Misato tidak boleh menerjemahkan alamat apa pun
iptables -t nat -X
iptables -t mangle -F
iptables -P FORWARD ACCEPT
iptables -F FORWARD
ip route replace default via 10.72.4.149 dev eth0   # induk: Gendou
EOF
chmod +x /root/soal_10.sh
bash /root/soal_10.sh
iptables -S; iptables -t nat -S; ip route

### ==== Gendou: /root/soal_10.sh (satu-satunya tempat NAT + firewall soal 5 dibangun ulang) ====
cat << 'EOF' > /root/soal_10.sh
#!/bin/bash
# Perbaikan soal 10 - Gendou
sysctl -w net.ipv4.ip_forward=1 >/dev/null

# NAT: hanya prefix internal yang keluar lewat eth0 (NAT1) yang diterjemahkan
iptables -t nat -F
iptables -t nat -A POSTROUTING -s 10.72.0.0/16 -o eth0 -j MASQUERADE

# Firewall soal 5 (default deny)
iptables -F INPUT
iptables -F FORWARD
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -i eth0 -p udp --sport 67 --dport 68 -j ACCEPT
iptables -A INPUT ! -i eth0 -s 10.72.0.0/16 -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD ! -i eth0 -s 10.72.0.0/16 -o eth0 -j ACCEPT
iptables -A FORWARD ! -i eth0 -s 10.72.0.0/16 -d 10.72.0.0/16 -j ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
EOF
chmod +x /root/soal_10.sh
bash /root/soal_10.sh
iptables -S; iptables -t nat -S

### ==== Misato + Gendou: bandingkan dengan kondisi normal (snapshot dari snap.sh) ====
bash /root/snap.sh /root/kondisi_pulih.txt
diff /root/kondisi_normal.txt /root/kondisi_pulih.txt
# Harus hampir kosong. Selisih yang tersisa hanya boleh baris tanggal atau counter.

### ==== Unit-01 + Spy: bukti pulih ====
date
ping -c 3 8.8.8.8

### ==== Misato lalu Gendou, sambil Unit-01 ping 8.8.8.8: di router mana alamat diterjemahkan ====
tcpdump -ni eth0 icmp and host 8.8.8.8 -c 4
iptables -t nat -L POSTROUTING -n -v
# Misato: sumber paket masih 10.72.4.66 (tidak diterjemahkan, nat kosong)
# Gendou: sumber berubah jadi IP NAT1 di eth0, counter MASQUERADE naik -> penerjemahan hanya di Gendou