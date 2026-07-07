#!/bin/bash

# backup_incremental.sh - copias incrementales con hardlinks (estilo rsnapshot)
# Cada snapshot parece completo, pero los ficheros sin cambios son hardlinks
# al snapshot anterior, así que ocupan disco solo una vez.

origen=${1:-/home}
destino=${2:-/backups}
mantener=${3:-7}   # número de snapshots a conservar

if [ ! -d "$origen" ]; then
  echo -e "\033[31mEl directorio origen $origen no existe\033[0m"
  exit 1
fi

mkdir -p "$destino"
destino=$(realpath "$destino")   # rsync resuelve --link-dest respecto al destino, usamos ruta absoluta
nuevo="$destino/snapshot_$(date +%F_%H%M%S)"
ultimo=$(ls -1d $destino/snapshot_* 2>/dev/null | tail -1)

if [ -n "$ultimo" ]; then
  # --link-dest: los ficheros iguales al último snapshot se crean como hardlinks
  echo "Backup incremental respecto a $(basename $ultimo)"
  rsync -a --delete --link-dest="$ultimo" "$origen/" "$nuevo/"
else
  echo "Primer backup (completo)"
  rsync -a --delete "$origen/" "$nuevo/"
fi
echo -e "\033[32mCreado $nuevo\033[0m"

# Rotación: borramos los snapshots más viejos, dejando los $mantener últimos
sobran=$(ls -1d $destino/snapshot_* 2>/dev/null | head -n -$mantener)
for viejo in $sobran
do
  echo "Borrando snapshot antiguo $(basename $viejo)"
  rm -rf "$viejo"
done

echo "Espacio real ocupado por todos los snapshots:"
du -sh "$destino"
