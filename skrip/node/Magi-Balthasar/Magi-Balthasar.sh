#!/bin/bash
# Soal 7: Magi-Balthasar, listener TCP 5000 dan 5001. Paket hanya dipasang kalau belum ada.
export DEBIAN_FRONTEND=noninteractive
if ! command -v nc.traditional >/dev/null 2>&1 || ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables netcat-traditional
fi
update-alternatives --set nc /bin/nc.traditional >/dev/null 2>&1
for p in 5000 5001; do
  pkill -f "nc.traditional -l -p $p" 2>/dev/null
  setsid nohup bash -c "while true; do nc.traditional -l -p $p >> /root/balthasar_$p.log; done" >/dev/null 2>&1 &
done
