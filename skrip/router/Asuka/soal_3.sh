#!/bin/bash
# Soal 3: routing statis (Asuka). Aman dijalankan ulang (ip route replace).
ip route replace default via 10.72.4.165
ip route replace 10.72.3.128/26 via 10.72.4.122    # lewat Kensuke
ip route replace 10.72.4.48/29 via 10.72.4.142    # lewat Ritsuko
