#!/bin/bash
# Soal 7: Magi-Casper, listener TCP 5000. Paket hanya dipasang kalau belum ada.
export DEBIAN_FRONTEND=noninteractive
if ! command -v nc.traditional >/dev/null 2>&1 || ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables netcat-traditional
fi
update-alternatives --set nc /bin/nc.traditional >/dev/null 2>&1
pkill -f "nc.traditional -l -p 5000" 2>/dev/null
setsid nohup bash -c 'while true; do nc.traditional -l -p 5000 >> /root/casper_5000.log; done' >/dev/null 2>&1 &
