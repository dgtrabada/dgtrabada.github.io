#!/bin/bash

# auditoria.sh - chequeo de seguridad básico del sistema
# Ejecutar como root para poder leer /etc/shadow

problemas=0

ok()    { echo -e "\033[32m[ OK ]\033[0m $1"; }
fallo() { echo -e "\033[31m[FALLO]\033[0m $1"; problemas=$((problemas+1)); }

echo "=== Auditoría de seguridad de $(hostname) ==="

# 1. Usuarios con UID 0 (solo debería estar root)
echo "--- Usuarios con UID 0 ---"
uid0=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)
if [ "$uid0" == "root" ]; then
  ok "Solo root tiene UID 0"
else
  fallo "Hay más usuarios con UID 0: $uid0"
fi

# 2. Cuentas sin contraseña
echo "--- Cuentas sin contraseña ---"
sin_pass=$(awk -F: '($2 == "") {print $1}' /etc/shadow 2>/dev/null)
if [ -z "$sin_pass" ]; then
  ok "No hay cuentas sin contraseña"
else
  fallo "Cuentas sin contraseña: $sin_pass"
fi

# 3. Permisos de /etc/shadow (debe ser 640 o más restrictivo)
echo "--- Permisos de /etc/shadow ---"
perm=$(stat -c '%a' /etc/shadow 2>/dev/null)
if [ "$perm" == "640" ] || [ "$perm" == "600" ]; then
  ok "/etc/shadow tiene permisos $perm"
else
  fallo "/etc/shadow tiene permisos $perm (debería ser 640)"
fi

# 4. Quién puede usar sudo
echo "--- Miembros del grupo sudo ---"
sudoers=$(getent group sudo | cut -d: -f4)
echo "Pueden usar sudo: ${sudoers:-nadie}"

# 5. Puertos a la escucha
echo "--- Puertos a la escucha ---"
ss -tlnp 2>/dev/null | tail -n +2 | tr -s ' ' | cut -d' ' -f4 | sort -u

echo "=== $problemas problemas encontrados ==="
exit $problemas
