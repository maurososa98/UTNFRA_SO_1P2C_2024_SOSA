#!/bin/bash

# Crear grupos
sudo groupadd p1c2_2024_gAlumno
sudo groupadd p1c2_2024_gProfesores

# Guarda la contraseña de mi usuario
CLAVE=$(sudo grep mauro /etc/shadow | awk -F ':' '{print $2}')

# Crear ususarios alumnos
for i in {1..3}; do
  sudo useradd -m -s /bin/bash -G p1c2_2024_gAlumno -p "${CLAVE}" "p1c2_2024_A${i}"
done

# Crear ususarios profesores
sudo useradd -m -s /bin/bash -G p1c2_2024_gProfesores -p "${CLAVE}" p1c2_2024_P1

# Cambiar dueño y grupo
sudo chown -R p1c2_2024_A1:p1c2_2024_A1 /Examenes-UTN/alumno_1
sudo chown -R p1c2_2024_A2:p1c2_2024_A2 /Examenes-UTN/alumno_2
sudo chown -R p1c2_2024_A3:p1c2_2024_A3 /Examenes-UTN/alumno_3
sudo chown -R p1c2_2024_P1:p1c2_2024_gProfesores /Examenes-UTN/profesores

# Cambiar permisos
sudo chmod -R 750 /Examenes-UTN/alumno_1
sudo chmod -R 760 /Examenes-UTN/alumno_2
sudo chmod -R 700 /Examenes-UTN/alumno_3
sudo chmod -R 775 /Examenes-UTN/profesores

# Crear archivo “validar.txt” con la salida del comando whoami para alumnos
for i in {1..3}; do
  sudo -u p1c2_2024_A${i} bash -c "whoami > /Examenes-UTN/alumno_${i}/validar.txt"
done

# Crear archivo “validar.txt” con la salida del comando whoami para profesores
sudo -u p1c2_2024_P1 bash -c "whoami > /Examenes-UTN/profesores/validar.txt"

