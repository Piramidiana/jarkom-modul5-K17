#!/bin/bash
# Soal 3: routing statis (Yui). Aman dijalankan ulang (ip route replace).
ip route replace default via 10.72.4.117
ip route replace 10.72.0.0/23 via 10.72.4.110    # lewat Rei
ip route replace 10.72.4.0/27 via 10.72.4.134    # lewat Shinji
ip route replace 10.72.4.32/28 via 10.72.4.138    # lewat Mari
