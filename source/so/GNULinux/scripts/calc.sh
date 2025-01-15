#!/bin/bash

# Función para mostrar ayuda
mostrar_ayuda() {
    echo"
	Uso: ./calc.sh [número] [operación] [número] ...

	Este script realiza operaciones aritméticas (suma y resta) con los números que se le proporcionen.

	Operaciones disponibles:
	  -sum     Suma los números.
	  -rest    Resta los números.
	  --help   Muestra este mensaje de ayuda.

	Ejemplos:
	  ./calc.sh 2 -sum 4        Muestra la suma de 2 y 4 (6).
	  ./calc.sh 2 -sum 4 -sum 7 Muestra la suma de 2, 4 y 7 (13).
	  ./calc.sh 2 -rest 7       Muestra la resta de 2 menos 7 (-5).
	"
}

# Verificación de la opción --help
if [[ $1 == "--help" ]]; then
    mostrar_ayuda
    exit 0
fi

# Verificación de la cantidad de argumentos
if [[ $# -lt 3 ]]; then
    echo "Error: Número insuficiente de argumentos."
    mostrar_ayuda
    exit 1
fi

# Inicializar el resultado con el primer número
resultado=$1
shift # Eliminar el primer número

# Procesar las operaciones
while [[ $# -gt 0 ]]; do
    operador=$1
    numero=$2
    shift 2

    case $operador in
        -sum)
            resultado=$((resultado + numero))
            ;;
        -rest)
            resultado=$((resultado - numero))
            ;;
        *)
            echo "Error: Operación desconocida '$operador'."
            mostrar_ayuda
            exit 1
            ;;
    esac
done

# Mostrar el resultado final
echo "Resultado: $resultado"
