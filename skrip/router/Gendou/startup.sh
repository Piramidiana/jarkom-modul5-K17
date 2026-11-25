#!/bin/bash
# Dipanggil saat boot lewat /etc/network/interfaces: jalankan gendo.sh (soal 2 sampai 5)
{
  echo "=== startup $(date)"
  if [ -f /root/gendo.sh ]; then echo "--- /root/gendo.sh"; bash /root/gendo.sh; fi
  for s in $(ls /root/soal_[0-9]*.sh 2>/dev/null | sort -V); do
    echo "--- $s"; bash $s
  done
  echo "=== selesai $(date)"
} >> /root/startup.log 2>&1
