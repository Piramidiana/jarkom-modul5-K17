#!/bin/bash
# Dipanggil saat boot lewat /etc/network/interfaces: jalankan semua soal_N.sh berurutan
{
  echo "=== startup $(date)"
  for s in $(ls /root/soal_[0-9]*.sh 2>/dev/null | sort -V); do
    echo "--- $s"; bash $s
  done
  echo "=== selesai $(date)"
} >> /root/startup.log 2>&1
