#!/bin/bash

palabra=("PYTHON" "LINUX" "BASH" "GITHUB" "DOCKER")
indice=$((RANDOM % ${#palabra[@]}))
secreta="${palabra[$indice]}"

longitud=${#secreta}
oculta=$(echo "$secreta" | sed 's/./_/g')
intentos=0
fallos=0
max_fallos=6
letras_intentadas=()

dibujar() {
  clear
  case $fallos in
    0)
      echo "  @ @ @"
      echo " @ (o) @"
      echo "    |"
      echo "   \\|/"
      echo "========="
      ;;
    1)
      echo "  @ @ @"
      echo "   (o) @"
      echo "    |"
      echo "   \\|/"
      echo "========="
      ;;
    2)
      echo "  @ @ @"
      echo "   (o)"
      echo "    |"
      echo "   \\|/"
      echo "========="
      ;;
    3)
      echo "  @ @"
      echo "   (o)"
      echo "    |"
      echo "   \\|/"
      echo "========="
      ;;
    4)
      echo "  @"
      echo "   (o)"
      echo "    |"
      echo "   \\|/"
      echo "========="
      ;;
    5)
      echo ""
      echo "   (o)"
      echo "    |"
      echo "   \\|/"
      echo "========="
      ;;
    6)
      echo ""
      echo "   (o)"
      echo "     \\"
      echo "   \\|/"
      echo "========="
      ;;
  esac
}

echo "¡Bienvenido al juego de la flor!"
echo "Adivina la palabra antes de que la flor pierda todos sus pétalos"
dibujar

while [[ "$oculta" != "$secreta" && $fallos -lt $max_fallos ]]; do
  echo "Palabra: $oculta"
  echo "Letras intentadas: ${letras_intentadas[@]}"
  read -p "Introduce una letra: " letra
  letra=$(echo "$letra" | tr '[:lower:]' '[:upper:]')

  if [[ " ${letras_intentadas[@]} " =~ " $letra " ]]; then
    echo "Ya intentaste esa letra. Prueba otra."
    continue
  fi

  letras_intentadas+=("$letra")

  if [[ "$secreta" =~ "$letra" ]]; then
    # Reemplazar guiones bajos por la letra adivinada
    for ((i = 0; i < $longitud; i++)); do
      if [[ "${secreta:$i:1}" == "$letra" ]]; then
        oculta=$(echo "$oculta" | sed "s/./$letra/$((i + 1))")
      fi
    done
    echo "¡Bien hecho! La letra '$letra' está en la palabra."
  else
    ((fallos++))
    echo "La letra '$letra' no está en la palabra. La flor pierde un pétalo..."
  fi
  dibujar
done

if [[ "$oculta" == "$secreta" ]]; then
  echo "¡Felicidades! Adivinaste la palabra: $secreta"
else
  echo "¡Oh no! La flor se ha marchitado."
  echo "La palabra era: $secreta"
fi
