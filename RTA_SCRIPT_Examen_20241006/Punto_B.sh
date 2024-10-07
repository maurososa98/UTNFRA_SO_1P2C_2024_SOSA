#!/bin/bash

# Guarda el nombre del disco que tiene un tamaño de 10 G
DISCO=$(sudo fdisk -l | grep "10 G" | awk '{print $2}' | awk -F ':' '{ print $1}')

# Crear particiones
{

# 3 primarias
for i in {1..3}; do
 echo n      # Nueva partición
 echo p      # Tipo primaria
 echo        # Número de partición
 echo        # Primer sector por defecto
 echo +900M  # Último sector
done

# 1 extendida
echo n       # Nueva partición
echo e       # Tipo extendida
echo         # Primer sector por defecto
echo         # Utilizar todo el espacio restante

# 7 lógicas
for i in {1..7}; do
 echo n      # Nueva partición
 echo        # Primer sector por defecto
 echo +900M  # Último sector
done

echo w # Guardar y salir
} | sudo fdisk "${DISCO}"

# Formatear particiones (evitando extendida)
for i in {1..3} {5..11}; do
 sudo mkfs -t ext4 "${DISCO}${i}"
done

# Montar y persistir particiones para el primer alumno
for i in {1..3}; do
  sudo mount "${DISCO}${i}" "/Examenes-UTN/alumno_1/parcial_${i}"
  echo "${DISCO}${i} /Examenes-UTN/alumno_1/parcial_${i} ext4 defaults 0 0" | sudo tee -a /etc/fstab
done

# Montar y persistir particiones para el segundo alumno
for i in {5..7}; do
  sudo mount "${DISCO}${i}" "/Examenes-UTN/alumno_2/parcial_$((i-4))"
  echo "${DISCO}${i} /Examenes-UTN/alumno_2/parcial_$((i-4)) ext4 defaults 0 0" | sudo tee -a /etc/fstab
done

# Montar y persistir particiones para el tercer alumno
for i in {8..10}; do
  sudo mount "${DISCO}${i}" "/Examenes-UTN/alumno_3/parcial_$((i-7))"
  echo "${DISCO}${i} /Examenes-UTN/alumno_3/parcial_$((i-7)) ext4 defaults 0 0" | sudo tee -a /etc/fstab
done

# Montar y persistir particiones para profesores
sudo mount "${DISCO}11" "/Examenes-UTN/profesores"
echo "${DISCO}11 /Examenes-UTN/profesores ext4 defaults 0 0" | sudo tee -a /etc/fstab
