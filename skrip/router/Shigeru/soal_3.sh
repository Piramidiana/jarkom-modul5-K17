#!/bin/bash
# Soal 3: routing statis (Shigeru). Aman dijalankan ulang (ip route replace).
ip route replace default via 10.72.4.157
ip route replace 10.72.4.88/29 via 10.72.4.162    # lewat Makoto
