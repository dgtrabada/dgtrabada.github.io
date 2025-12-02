#!/bin/bash

# Verificar que el archivo existe
if [ ! -f "calificaciones.txt" ]; then
    echo "Error: El archivo calificaciones.txt no existe en el directorio actual."
    exit 1
fi

# Verificar que el archivo no está vacío
if [ ! -s "calificaciones.txt" ]; then
    echo "Error: El archivo calificaciones.txt está vacío."
    exit 1
fi

# Procesar con awk
awk -F'[:,]' '
BEGIN {
    print "============================================="
    print "   ESTADÍSTICAS DE CALIFICACIONES"
    print "=============================================\n"
    
    # Inicializar contadores
    total = 0
    aprob_todos = 0
    un_suspenso = 0
    dos_suspensos = 0
    tres_o_mas = 0
    aprob_general = 0
    susp_general = 0
}
{
    total++
    suspensos = 0
    
    # Contar suspensos (notas < 5)
    for(i=2; i<=NF; i++) {
        # Convertir a número (el +0 elimina espacios automáticamente)
        nota = $i + 0
        if (nota < 5) suspensos++
    }
    
    # Contar por categorías
    if (suspensos == 0) aprob_todos++
    if (suspensos == 1) un_suspenso++
    if (suspensos == 2) dos_suspensos++
    if (suspensos >= 3) tres_o_mas++
    
    # Contar aprobados generales (<= 2 suspensos)
    if (suspensos <= 2) {
        aprob_general++
    } else {
        susp_general++
    }
}
END {
    print "1. Número de alumnos matriculados: " total
    print "2. Alumnos que han aprobado todos los módulos: " aprob_todos
    print "3. Alumnos que han suspendido sólo un módulo: " un_suspenso
    print "4. Alumnos que han suspendido dos módulos: " dos_suspensos
    print "5. Alumnos que han suspendido tres módulos o más: " tres_o_mas
    printf "\n6. Porcentaje de alumnos:\n"
    printf "   Aprobados (<= 2 suspensos): %.2f%%\n", (aprob_general/total)*100
    printf "   Suspensos (> 2 suspensos): %.2f%%\n", (susp_general/total)*100
    print "\n============================================="
}' calificaciones.txt
