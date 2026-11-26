### ==== Magi-Casper: /root/soal_12.sh (hardening tetap utuh, INPUT policy DROP) ====
cat << 'EOF' > /root/soal_12.sh
#!/bin/bash
# Perbaikan soal 12 - Casper
iptables -F
iptables -X
iptables -t nat -F
iptables -P INPUT DROP                      # tujuan hardening tetap: tolak semua yang tidak diizinkan
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT                   # Casper boleh keluar (ping, DNS, apt)
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP                    # soal 11: tidak ada yang boleh mem-ping Casper
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT       # balasan ping, DNS, apt yang keluar
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT                              # layanan TCP 5000
echo "nameserver 8.8.8.8" > /etc/resolv.conf
ip route replace default via 10.72.4.57 dev eth0
EOF
chmod +x /root/soal_12.sh
bash /root/soal_12.sh
grep -q soal_12.sh /etc/network/interfaces || echo "        up bash /root/soal_12.sh" >> /etc/network/interfaces
iptables -S

### ==== Magi-Casper: bukti (paste sekali untuk screenshot) ====
clear; date
iptables -S
ping -c 2 8.8.8.8
apt-get update 2>&1 | tail -3
cat /root/casper_5000.log | tail -3

### ==== Unit-00: nc ke Casper:5000 harus berhasil ====
echo "tes dari Unit-00" | nc.traditional -w 3 -q 1 10.72.4.58 5000; echo "exit=$?"

### ==== Balthasar: ping ke Casper tetap GAGAL (memang benar) ====
ping -c 2 -W 1 10.72.4.58

### ==== Misato, Gendou, Casper: diff penyebab (jalankan SEBELUM perbaikan) ====
bash /root/snap.sh /root/kondisi_rusak.txt
diff /root/kondisi_normal.txt /root/kondisi_rusak.txt   