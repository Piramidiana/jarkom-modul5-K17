#!/bin/bash
# Uji konektivitas dari Gendou ke 25 node non-router.
# Setelah soal 11, Magi-Casper memang GAGAL (tidak boleh di-ping) - itu hasil yang benar.
for x in Quarters:10.72.0.2 Comm-Net:10.72.2.2 Hangar-Crew:10.72.3.2 Sachiel:10.72.3.130 Medic-Bay:10.72.3.194 Pen-Pen:10.72.3.195 Relay-Node:10.72.3.226 Garden-Staff:10.72.4.2 Dock-Crew:10.72.4.34 Entry-Plug:10.72.4.50 Dummy-Plug:10.72.4.51 Magi-Casper:10.72.4.58 Magi-Balthasar:10.72.4.59 Magi-Melchior:10.72.4.60 Unit-01:10.72.4.66 Unit-02:10.72.4.67 Unit-00:10.72.4.68 Lilith:10.72.4.74 Adam:10.72.4.75 Zeruel:10.72.4.82 Armisael:10.72.4.83 Radar-Array:10.72.4.90 Archive-Vault:10.72.4.98 Spy:10.72.4.102 Tokyo3-Core:10.72.4.106; do
  n=${x%%:*}; ip=${x##*:}
  if ping -c 1 -W 1 $ip >/dev/null 2>&1; then echo "OK     $n $ip"; else echo "GAGAL  $n $ip"; fi
done
