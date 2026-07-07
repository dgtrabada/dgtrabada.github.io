#!/bin/bash

# analizar_web.sh - análisis del access.log de Apache

archivo=${1:-/var/log/apache2/access.log}

if [ ! -f "$archivo" ]; then
  echo -e "\033[31mNo existe el archivo $archivo\033[0m"
  echo "Uso: ./analizar_web.sh [access.log]"
  exit 1
fi

total=$(wc -l < "$archivo")
echo -e "\033[34m=== Análisis de $archivo ($total peticiones) ===\033[0m"

# En el formato común de Apache el campo 1 es la IP, el 7 la URL y el 9 el código
echo -e "\n--- Top 5 IPs ---"
cut -d' ' -f1 "$archivo" | sort | uniq -c | sort -rn | head -5

echo -e "\n--- Top 5 URLs ---"
cut -d' ' -f7 "$archivo" | sort | uniq -c | sort -rn | head -5

echo -e "\n--- Códigos de respuesta ---"
cut -d' ' -f9 "$archivo" | sort | uniq -c | sort -rn

echo -e "\n--- Páginas no encontradas (404) ---"
awk '$9 == 404 {print $7}' "$archivo" | sort | uniq -c | sort -rn | head -5

echo -e "\n--- Peticiones por hora ---"
# la fecha va como [10/Oct/2024:13:55:36 ...], nos quedamos con la hora
awk -F'[:[]' '{print $3":00"}' "$archivo" | sort | uniq -c
