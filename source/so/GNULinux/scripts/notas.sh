#!/bin/bash

archivo="calificaciones.txt"
todos_aprobados=0
un_suspenso=0
dos_suspensos=0
tres_o_mas_suspensos=0

num_alumnos=$(wc -l $archivo | cut -d' ' -f1)

for ((i=1; i<=num_alumnos; i++))
    do
    linea=$(sed -n "${i}p" "$archivo")
    aprobado_1=0 
    aprobado_2=0 
    aprobado_3=0 
    aprobado_4=0 
    aprobado_5=0 
    nota_1=$(echo $linea |cut -d':' -f2|cut -d',' -f1)
    if [ $nota_1 -ge 5 ]; then aprobado_1=1 ; fi

    nota_2=$(echo $linea |cut -d':' -f2|cut -d',' -f2) 
    if [ $nota_2 -ge 5 ]; then aprobado_2=1 ; fi
   
    nota_3=$(echo $linea |cut -d':' -f2|cut -d',' -f3) 
    if [ $nota_3 -ge 5 ]; then aprobado_3=1 ; fi

    nota_4=$(echo $linea |cut -d':' -f2|cut -d',' -f4) 
    if [ $nota_4 -ge 5 ]; then aprobado_4=1 ; fi

    nota_5=$(echo $linea |cut -d':' -f2|cut -d',' -f5)
    if [ $nota_5 -ge 5 ]; then aprobado_5=1 ; fi
    sum_aprobados=$((aprobado_1 + aprobado_2 + aprobado_3 + aprobado_4 + aprobado_5))

    if [ $sum_aprobados -eq 5 ];  then  todos_aprobados=$((todos_aprobados+1)) ;    fi   
    if [ $sum_aprobados -eq 4 ];  then  un_suspenso=$((un_suspenso+1)) ;    fi   
    if [ $sum_aprobados -eq 3 ];  then  dos_suspensos=$((dos_suspensos+1)) ;    fi   
    if [ $sum_aprobados -lt 3 ];  then  tres_o_mas_suspensos=$((tres_o_mas_suspensos+1)) ;    fi   
    echo -e "$linea : \033[32m$sum_aprobados \033[0mmod. aprobados "

done

porcentaje_aprobados=$(echo "scale=2; ($todos_aprobados / $num_alumnos) * 100" | bc)
porcentaje_suspensos=$(echo "scale=2; (($num_alumnos-$todos_aprobados) / $num_alumnos) * 100" | bc)

echo -e "\033[34m-------------- Resultados ---------------- \033[0m"
echo "Número total de alumnos matriculados: $total_alumnos"
echo "Número de alumnos que han aprobado todos los módulos: $todos_aprobados"
echo "Número de alumnos que han suspendido solo un módulo: $un_suspenso"
echo "Número de alumnos que han suspendido dos módulos: $dos_suspensos"
echo "Número de alumnos que han suspendido tres módulos o más: $tres_o_mas_suspensos"
echo "Porcentaje de alumnos aprobados: $porcentaje_aprobados%"
echo "Porcentaje de alumnos suspensos: $porcentaje_suspensos%"

