#!/bin/bash
# Soal 8: Pen-Pen, listener TCP 80 (jawaban: Welcome to {hostname}). Paket hanya dipasang kalau belum ada.
export DEBIAN_FRONTEND=noninteractive
if ! command -v nc.traditional >/dev/null 2>&1 || ! command -v iptables >/dev/null 2>&1; then
  apt-get update -qq
  apt-get install -y -qq iptables netcat-traditional
fi
update-alternatives --set nc /bin/nc.traditional >/dev/null 2>&1
pkill -f "nc.traditional -l -p 80 -q 1" 2>/dev/null
setsid nohup bash -c 'while true; do echo "Welcome to $(hostname)" | nc.traditional -l -p 80 -q 1 >/dev/null; done' >/dev/null 2>&1 &
