#!/bin/bash
# Soal 3: routing statis (Fuyutsuki). Aman dijalankan ulang (ip route replace).
ip route replace default via 10.72.4.145
ip route replace 10.72.3.192/27 via 10.72.4.126    # lewat Maya
ip route replace 10.72.4.72/29 via 10.72.4.154    # lewat Toji
