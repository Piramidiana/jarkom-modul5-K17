#!/bin/bash
# Soal 3: routing statis (Hikari). Aman dijalankan ulang (ip route replace).
ip route replace default via 10.72.4.113
ip route replace 10.72.3.224/27 via 10.72.4.130    # lewat Kaworu
