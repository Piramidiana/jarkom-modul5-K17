#!/bin/bash
# Soal 8: Tokyo3-Core, listener TCP 80 dan 8080 (jawaban: syifa imutz). Paket hanya dipasang kalau belum ada.
export DEBIAN_FRONTEND=noninteractive
if ! command -v nc.traditional >/dev/null 2>&1 || ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables netcat-traditional
fi
update-alternatives --set nc /bin/nc.traditional >/dev/null 2>&1
for p in 80 8080; do
  pkill -f "nc.traditional -l -p $p -q 1" 2>/dev/null
  setsid nohup bash -c "while true; do echo 'syifa imutz' | nc.traditional -l -p $p -q 1 >/dev/null; done" >/dev/null 2>&1 &
done
