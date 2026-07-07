#!/bin/bash

# Prueba todas las opciones de inventario.sh

function run() {
  echo ""
  echo -e "\033[33m### $* \033[0m"
  "$@"
}

run ./inventario.sh -help
run ./inventario.sh -crear lista.csv 10
run ./inventario.sh -read lista.csv
run ./inventario.sh -add lista.csv servidor01 192.168.1.250 64 activo
run ./inventario.sh -find lista.csv servidor01
run ./inventario.sh -resumen lista.csv
run ./inventario.sh -del lista.csv servidor01
run ./inventario.sh -find lista.csv servidor01
run ./inventario.sh -del lista.csv servidor01
run ./inventario.sh -find lista.csv
run ./inventario.sh -read noexiste.csv
run ./inventario.sh
