#!/bin/bash

# Generar un número aleatorio entre 1 y 20
numero_secreto=$((RANDOM % 20 + 1))
echo $numero_secreto
intentos=0

echo "¡Adivina el número entre 1 y 20!"

acertado=0
while [[ $acertado == 0 ]]
do
  intentos=$((intentos+1))
  read -p "Introduce tu número: " respuesta
  
  # Comparar el número ingresado con el número secreto
  if [[ $respuesta -lt $numero_secreto ]]; then
    echo "El número es más grande."
  elif [[ $respuesta -gt $numero_secreto ]]; then
    echo "El número es más pequeño."
  else
    echo "¡Correcto! El número era $numero_secreto."
    echo "Lo has adivinado en $intentos intento(s)."
    acertado=1
  fi
done
