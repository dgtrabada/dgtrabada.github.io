#!/bin/bash

archivo="calificaciones.csv"
num_alumnos=0
todos_aprobados=0
un_suspenso=0
dos_suspensos=0
tres_o_mas_suspensos=0

while IFS=',' read -r nombre nota_1 nota_2 nota_3 nota_4 nota_5
do
    if [[ $nombre == "nombre" ]]; then continue; fi # saltamos la cabecera

    num_alumnos=$((num_alumnos+1))
    sum_aprobados=0
    for nota in $nota_1 $nota_2 $nota_3 $nota_4 $nota_5
    do
      if [ $nota -ge 5 ]; then sum_aprobados=$((sum_aprobados+1)); fi
    done

    if [ $sum_aprobados -eq 5 ];  then  todos_aprobados=$((todos_aprobados+1)) ;    fi
    if [ $sum_aprobados -eq 4 ];  then  un_suspenso=$((un_suspenso+1)) ;    fi
    if [ $sum_aprobados -eq 3 ];  then  dos_suspensos=$((dos_suspensos+1)) ;    fi
    if [ $sum_aprobados -lt 3 ];  then  tres_o_mas_suspensos=$((tres_o_mas_suspensos+1)) ;    fi
    echo -e "$nombre: $nota_1, $nota_2, $nota_3, $nota_4, $nota_5 : \033[32m$sum_aprobados \033[0mmod. aprobados "

done < $archivo

porcentaje_aprobados=$(echo "scale=2; ($todos_aprobados / $num_alumnos) * 100" | bc)
porcentaje_suspensos=$(echo "scale=2; (($num_alumnos-$todos_aprobados) / $num_alumnos) * 100" | bc)

echo -e "\033[34m-------------- Resultados ---------------- \033[0m"
echo -e "Número total de alumnos matriculados:\033[32m $num_alumnos \033[0m"
echo -e "Número de alumnos que han aprobado todos los módulos:\033[32m $todos_aprobados\033[0m"
echo -e "Número de alumnos que han suspendido solo un módulo:\033[32m $un_suspenso\033[0m"
echo -e "Número de alumnos que han suspendido dos módulos:\033[32m $dos_suspensos\033[0m"
echo -e "Número de alumnos que han suspendido tres módulos o más:\033[32m $tres_o_mas_suspensos\033[0m"
echo -e "Porcentaje de alumnos aprobados:\033[35m  $porcentaje_aprobados %\033[0m"
echo -e "Porcentaje de alumnos suspensos:\033[35m  $porcentaje_suspensos %\033[0m"
