#!/bin/bash

palabra=("PYTHON" "LINUX" "BASH" "GITHUB" "DOCKER")
indice=$((RANDOM % ${#palabra[@]}))
secreta="${palabra[$indice]}"
echo $secreta

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
      echo "  +---+"
      echo "   |  |"
      echo "      |"
      echo "      |"
      echo "      |"
      echo "      |"
      echo "========="
      ;;
    1)
      echo "  +---+"
      echo "   |  |"
      echo "   O  |"
      echo "      |"
      echo "      |"
      echo "      |"
      echo "========="
      ;;
    2)
      echo "  +---+"
      echo "   |  |"
      echo "   O  |"
      echo "   |  |"
      echo "      |"
      echo "      |"
      echo "========="
      ;;
    3)
      echo "  +---+"
      echo "   |  |"
      echo "   O  |"
      echo "  /|  |"
      echo "      |"
      echo "      |"
      echo "========="
      ;;
    4)
      echo "  +---+"
      echo "   |  |"
      echo "   O  |"
      echo "  /|\\ |"
      echo "      |"
      echo "      |"
      echo "========="
      ;;
    5)
      echo "  +---+"
      echo "   |  |"
      echo "   O  |"
      echo "  /|\\ |"
      echo "  /   |"
      echo "      |"
      echo "========="
      ;;
    6)
      echo "  +---+"
      echo "   |  |"
      echo "   O  |"
      echo "  /|\\ |"
      echo "  / \\ |"
      echo "      |"
      echo "========="
      ;;
  esac
}

echo "¡Bienvenido al juego del ahorcado!"
dibujar

while [[ "$oculta" != "$secreta" && $fallos -lt $max_fallos ]]; do
  echo "Palabra: $oculta"
  echo "Letras intentadas: ${letras_intentadas[@]}"
  read -p "Introduce una letra: " letra
  letra=$(echo "$letra" | tr '[:lower:]' '[:upper:]') # Convertir a mayúscula

  # Comprobar si la letra ya fue intentada
  if [[ " ${letras_intentadas[@]} " =~ " $letra " ]]; then
    echo "Ya intentaste esa letra. Prueba otra."
    continue
  fi

  # Añadir letra a las intentadas
  letras_intentadas+=("$letra")

  # Comprobar si la letra está en la palabra
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
    echo "La letra '$letra' no está en la palabra."
  fi

  # Dibujar el ahorcado
  dibujar
done

# Fin del juego
if [[ "$oculta" == "$secreta" ]]; then
  echo "¡Felicidades! Adivinaste la palabra: $secreta"
else
  echo "¡Oh no! Has sido ahorcado."
  echo "La palabra era: $secreta"
fi

