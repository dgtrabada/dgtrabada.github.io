#!/bin/bash

# Prueba todas las opciones de ip.sh

function run() {
  echo ""
  echo -e "\033[33m### $* \033[0m"
  "$@"
}

run ./ip.sh -help
run ./ip.sh -file conexiones.dat 30
run ./ip.sh -read conexiones.dat
run ./ip.sh -find conexiones.dat 192.168.2.13
run ./ip.sh -find conexiones.dat
run ./ip.sh -find noexiste.dat 192.168.2.13
run ./ip.sh -read noexiste.dat
run ./ip.sh
