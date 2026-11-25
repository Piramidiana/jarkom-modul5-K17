# Tabel VLSM - 10.72.0.0/16 (17 LAN + 16 link)

Terpakai = jumlah host + 1 alamat gateway router. Sisa = alamat usable - terpakai.

| No | Subnet | Isi | Network/Prefix | Gateway | Broadcast | Terpakai | Sisa |
|---:|---|---|---|---|---|---:|---:|
| 1 | LAN Switch-Quarters (Rei) | Quarters=500 | 10.72.0.0/23 | 10.72.0.1 | 10.72.1.255 | 501 | 9 |
| 2 | LAN Switch-Comm (Hikari) | Comm-Net=200 | 10.72.2.0/24 | 10.72.2.1 | 10.72.2.255 | 201 | 53 |
| 3 | LAN Switch-Hangar (Yui) | Hangar-Crew=100 | 10.72.3.0/25 | 10.72.3.1 | 10.72.3.127 | 101 | 25 |
| 4 | LAN Switch-Bunker (Kensuke) | Sachiel=55 | 10.72.3.128/26 | 10.72.3.129 | 10.72.3.191 | 56 | 6 |
| 5 | LAN Switch-Medic (Maya) | Pen-Pen=1 + Medic-Bay=25 | 10.72.3.192/27 | 10.72.3.193 | 10.72.3.223 | 27 | 3 |
| 6 | LAN Switch-Relay (Kaworu) | Relay-Node=25 | 10.72.3.224/27 | 10.72.3.225 | 10.72.3.255 | 26 | 4 |
| 7 | LAN Switch-Garden (Shinji) | Garden-Staff=14 | 10.72.4.0/27 | 10.72.4.1 | 10.72.4.31 | 15 | 15 |
| 8 | LAN Switch-Dock (Mari) | Dock-Crew=12 | 10.72.4.32/28 | 10.72.4.33 | 10.72.4.47 | 13 | 1 |
| 9 | LAN Switch-Lab (Ritsuko) | Entry-Plug=3 + Dummy-Plug=2 | 10.72.4.48/29 | 10.72.4.49 | 10.72.4.55 | 6 | 0 |
| 10 | LAN Switch-Terminal (Fuyutsuki) | Magi-Casper=1 + Magi-Balthasar=1 + Magi-Melchior=1 | 10.72.4.56/29 | 10.72.4.57 | 10.72.4.63 | 4 | 2 |
| 11 | LAN Switch-Cage (Misato) | Unit-01=1 + Unit-02=1 + Unit-00=1 | 10.72.4.64/29 | 10.72.4.65 | 10.72.4.71 | 4 | 2 |
| 12 | LAN Switch-Dogma (Toji) | Lilith=1 + Adam=1 | 10.72.4.72/29 | 10.72.4.73 | 10.72.4.79 | 3 | 3 |
| 13 | LAN Switch-Monolith (Shigeru) | Zeruel=1 + Armisael=1 | 10.72.4.80/29 | 10.72.4.81 | 10.72.4.87 | 3 | 3 |
| 14 | LAN Switch-Radar (Makoto) | Radar-Array=4 | 10.72.4.88/29 | 10.72.4.89 | 10.72.4.95 | 5 | 1 |
| 15 | LAN Switch-Archive (Asuka) | Archive-Vault=1 | 10.72.4.96/30 | 10.72.4.97 | 10.72.4.99 | 2 | 0 |
| 16 | LAN Switch-Intel (Kaji) | Spy=1 | 10.72.4.100/30 | 10.72.4.101 | 10.72.4.103 | 2 | 0 |
| 17 | LAN Switch-Cmd (Gendou) | Tokyo3-Core=1 | 10.72.4.104/30 | 10.72.4.105 | 10.72.4.107 | 2 | 0 |
| 18 | Link Rei-Yui | 2 router | 10.72.4.108/30 | 10.72.4.109 | 10.72.4.111 | 2 | 0 |
| 19 | Link Hikari-Gendou | 2 router | 10.72.4.112/30 | 10.72.4.113 | 10.72.4.115 | 2 | 0 |
| 20 | Link Yui-Gendou | 2 router | 10.72.4.116/30 | 10.72.4.117 | 10.72.4.119 | 2 | 0 |
| 21 | Link Kensuke-Asuka | 2 router | 10.72.4.120/30 | 10.72.4.121 | 10.72.4.123 | 2 | 0 |
| 22 | Link Maya-Fuyutsuki | 2 router | 10.72.4.124/30 | 10.72.4.125 | 10.72.4.127 | 2 | 0 |
| 23 | Link Kaworu-Hikari | 2 router | 10.72.4.128/30 | 10.72.4.129 | 10.72.4.131 | 2 | 0 |
| 24 | Link Shinji-Yui | 2 router | 10.72.4.132/30 | 10.72.4.133 | 10.72.4.135 | 2 | 0 |
| 25 | Link Mari-Yui | 2 router | 10.72.4.136/30 | 10.72.4.137 | 10.72.4.139 | 2 | 0 |
| 26 | Link Ritsuko-Asuka | 2 router | 10.72.4.140/30 | 10.72.4.141 | 10.72.4.143 | 2 | 0 |
| 27 | Link Fuyutsuki-Gendou | 2 router | 10.72.4.144/30 | 10.72.4.145 | 10.72.4.147 | 2 | 0 |
| 28 | Link Misato-Gendou | 2 router | 10.72.4.148/30 | 10.72.4.149 | 10.72.4.151 | 2 | 0 |
| 29 | Link Toji-Fuyutsuki | 2 router | 10.72.4.152/30 | 10.72.4.153 | 10.72.4.155 | 2 | 0 |
| 30 | Link Shigeru-Gendou | 2 router | 10.72.4.156/30 | 10.72.4.157 | 10.72.4.159 | 2 | 0 |
| 31 | Link Makoto-Shigeru | 2 router | 10.72.4.160/30 | 10.72.4.161 | 10.72.4.163 | 2 | 0 |
| 32 | Link Asuka-Gendou | 2 router | 10.72.4.164/30 | 10.72.4.165 | 10.72.4.167 | 2 | 0 |
| 33 | Link Kaji-Gendou | 2 router | 10.72.4.168/30 | 10.72.4.169 | 10.72.4.171 | 2 | 0 |

Alamat terakhir terpakai: 10.72.4.171
