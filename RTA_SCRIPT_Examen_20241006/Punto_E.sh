#!/bin/bash

{
 grep MemTotal /proc/meminfo

 echo "Chassis Information"
 sudo dmidecode -t chassis | grep Manufacturer
} > $HOME/repogit/UTNFRA_SO_1P2C_2024_SOSA/RTA_ARCHIVOS_Examen_20241007/Filtro_Basico.txt

