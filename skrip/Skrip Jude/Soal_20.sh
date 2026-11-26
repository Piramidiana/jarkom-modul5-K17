#!/bin/bash
# Rekap Konfigurasi Praktikum - Soal 20 (Babak Final: Uji Kebakaran Geofront)
# Simulasi Pemusnahan & Pemulihan Idempoten Rule Firewall/NAT serta Rute Statis
# Target Pengujian (3 Node): Router Shigeru, Router Fuyutsuki, dan Host Tokyo3-Core




# 1. NODE 1: ROUTER SHIGERU

### ==== [Shigeru] A. Simpan rule + buat skrip rute (JALANKAN SEKALI) ====
# Penjaga: jangan simpan kalau rule kosong (soal 18 dan 19 belum terpasang)
if [ "$(iptables -S | wc -l)" -le 8 ]; then
  echo "STOP: rule masih kosong, pasang soal 18 dan 19 dulu"
else
  iptables-save > /root/shigeru.rules

  cat << 'EOF' > /root/shigeru.sh
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1 >/dev/null
ip route replace default via 10.72.4.157 dev eth0
ip route replace 10.72.4.88/29 via 10.72.4.162 dev eth2
EOF
  chmod +x /root/shigeru.sh
  echo "BASELINE (Shigeru) filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) route=$(ip route | wc -l)"
fi

### ==== [Shigeru] B. Simulasi kebakaran (hapus semua rule filter/nat dan rute tambahan) ====
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

ip route del default
ip route del 10.72.4.88/29

# Cek kondisi kosong sebelum pemulihan
echo "SETELAH HAPUS (Shigeru) filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) route=$(ip route | wc -l)"
iptables -S
iptables -t nat -S
ip route

### ==== [Shigeru] C. Pemulihan pertama & kedua (angka harus sama dengan BASELINE) ====
iptables-restore < /root/shigeru.rules
bash /root/shigeru.sh
echo "--- Pemulihan 1 (Shigeru) ---"
echo "Jumlah baris filter: $(iptables -S | wc -l)"
echo "Jumlah baris nat   : $(iptables -t nat -S | wc -l)"
echo "Jumlah rute        : $(ip route | wc -l)"
ip route

iptables-restore < /root/shigeru.rules
bash /root/shigeru.sh
echo "--- Pemulihan 2 (Shigeru) ---"
echo "Jumlah baris filter: $(iptables -S | wc -l)"
echo "Jumlah baris nat   : $(iptables -t nat -S | wc -l)"
echo "Jumlah rute        : $(ip route | wc -l)"
ip route
iptables -S

### ==== [Shigeru] D. Verifikasi fungsi jaringan kembali normal ====
# [Di Magi-Casper] ping -c 2 10.72.4.82        -> Berhasil (0% packet loss)
# [Di Lilith]      ping -c 2 -W 1 10.72.4.82   -> Gagal (Packet filtered)
# [Di Zeruel]      ping -c 2 8.8.8.8           -> Berhasil (0% packet loss)
# [Di Armisael]    ping -c 2 -W 1 8.8.8.8      -> Gagal (isolasi soal 19 tetap utuh)
# [Di Shigeru]     iptables -L ZONA -n -v      -> counter naik dari 0 setelah tes di atas


# 2. NODE 2: ROUTER FUYUTSUKI

### ==== [Fuyutsuki] A. Simpan rule (termasuk nat DNAT) + buat skrip rute (JALANKAN SEKALI) ====
# Penjaga: DNAT soal 17 harus ada (tabel nat > 4 baris) dan hanya satu baris DNAT
if [ "$(iptables -t nat -S | wc -l)" -le 4 ]; then
  echo "STOP: DNAT tidak ada, pasang soal 17 dulu"
else
  iptables-save > /root/fuyutsuki.rules

  # Skrip rute dipisah dari fuyutsuki.sh (itu skrip DNAT soal 17)
  cat << 'EOF' > /root/fuyutsuki_rute.sh
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1 >/dev/null
ip route replace default via 10.72.4.145 dev eth0
ip route replace 10.72.3.192/27 via 10.72.4.126 dev eth2
ip route replace 10.72.4.72/29 via 10.72.4.154 dev eth3
EOF
  chmod +x /root/fuyutsuki_rute.sh
  echo "BASELINE (Fuyutsuki) filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) route=$(ip route | wc -l)"
fi

### ==== [Fuyutsuki] B. Simulasi kebakaran (hapus semua rule filter/nat dan rute tambahan) ====
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

ip route del default
ip route del 10.72.3.192/27
ip route del 10.72.4.72/29

# Cek kondisi kosong sebelum pemulihan
echo "SETELAH HAPUS (Fuyutsuki) filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) route=$(ip route | wc -l)"
iptables -S
iptables -t nat -S
ip route

### ==== [Fuyutsuki] C. Pemulihan pertama & kedua (angka harus sama dengan BASELINE) ====
iptables-restore < /root/fuyutsuki.rules
bash /root/fuyutsuki_rute.sh
echo "--- Pemulihan 1 (Fuyutsuki) ---"
echo "Jumlah baris filter: $(iptables -S | wc -l)"
echo "Jumlah baris nat   : $(iptables -t nat -S | wc -l)"
echo "Jumlah rute        : $(ip route | wc -l)"
ip route

iptables-restore < /root/fuyutsuki.rules
bash /root/fuyutsuki_rute.sh
echo "--- Pemulihan 2 (Fuyutsuki) ---"
echo "Jumlah baris filter: $(iptables -S | wc -l)"
echo "Jumlah baris nat   : $(iptables -t nat -S | wc -l)"
echo "Jumlah rute        : $(ip route | wc -l)"
ip route
iptables -t nat -S

### ==== [Fuyutsuki] D. Verifikasi fungsi jaringan & DNAT kembali normal ====
# [Di Pen-Pen]     nc -l -p 9000
# [Di Magi-Casper] echo "Tes setelah kebakaran Fuyutsuki" | nc -w 2 10.72.4.82 9000
#                  -> Pesan muncul di Pen-Pen (bukan Zeruel)
# [Di Magi-Casper] ping -c 2 10.72.4.74   -> Berhasil (rute ke Switch-Dogma pulih)
# [Di Magi-Casper] ping -c 2 8.8.8.8      -> Berhasil (rute default pulih)
# [Di Fuyutsuki]   iptables -t nat -L PREROUTING -n -v -> counter DNAT naik dari 0



# 3. NODE 3: HOST TOKYO3-CORE

### ==== [Tokyo3-Core] A. Simpan rule + buat skrip rute default (JALANKAN SEKALI) ====
# Penjaga: aturan soal 15 dan 16 harus terpasang (filter lebih dari 3 baris)
if [ "$(iptables -S | wc -l)" -le 3 ]; then
  echo "STOP: rule masih kosong, pasang soal 15 dan 16 dulu"
else
  iptables-save > /root/tokyo3-core.rules

  cat << 'EOF' > /root/tokyo3-core.sh
#!/bin/bash
ip route replace default via 10.72.4.105 dev eth0
EOF
  chmod +x /root/tokyo3-core.sh
  echo "BASELINE (Tokyo3-Core) filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) route=$(ip route | wc -l)"
fi

### ==== [Tokyo3-Core] B. Simulasi kebakaran (hapus semua rule dan rute default) ====
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

ip route del default

# Cek kondisi kosong sebelum pemulihan
echo "SETELAH HAPUS (Tokyo3-Core) filter=$(iptables -S | wc -l) nat=$(iptables -t nat -S | wc -l) route=$(ip route | wc -l)"
iptables -S
ip route

### ==== [Tokyo3-Core] C. Pemulihan pertama & kedua (angka harus sama dengan BASELINE) ====
iptables-restore < /root/tokyo3-core.rules
bash /root/tokyo3-core.sh
echo "--- Pemulihan 1 (Tokyo3-Core) ---"
echo "Jumlah baris filter: $(iptables -S | wc -l)"
echo "Jumlah baris nat   : $(iptables -t nat -S | wc -l)"
echo "Jumlah rute        : $(ip route | wc -l)"
ip route

iptables-restore < /root/tokyo3-core.rules
bash /root/tokyo3-core.sh
echo "--- Pemulihan 2 (Tokyo3-Core) ---"
echo "Jumlah baris filter: $(iptables -S | wc -l)"
echo "Jumlah baris nat   : $(iptables -t nat -S | wc -l)"
echo "Jumlah rute        : $(ip route | wc -l)"
ip route
iptables -S

### ==== [Tokyo3-Core] D. Verifikasi fungsi jaringan & firewall kembali normal ====
ping -c 2 8.8.8.8
# [Di Lilith]     ping -i 0.1 -c 50 10.72.4.106 -> sebagian hilang (pembatas soal 15 hidup lagi)
# [Di Dummy-Plug] nc -w 2 -vz 10.72.4.106 22    -> Langsung ditolak (Connection refused)
# [Di Dummy-Plug] nc -w 2 -vz 10.72.4.106 80    -> Berhasil
# [Di Tokyo3-Core] iptables -L PINGLIMIT -n -v; iptables -L SCAN -n -v -> counter naik dari 0

