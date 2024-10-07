#!/bin/bash

{
 echo "Mi IP Publica es: $(curl -s ifconfig.me)"
 echo "Mi usuario es: $(whoami)"
 echo "El Hash de mi Usuario es: $(sudo grep mauro /etc/shadow | awk -F ':' '{print $2}')"
 echo "La URL de mi repositorio es: "
} > $HOME/repogit/UTNFRA_SO_1P2C_2024_SOSA/RTA_ARCHIVOS_Examen_20241007/Filtro_Avanzado.txt
