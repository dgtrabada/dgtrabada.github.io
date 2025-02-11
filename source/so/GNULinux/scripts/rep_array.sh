nlineas=$(wc -l nombres.dat | cut -d' ' -f1)
for((i=1;i<=$nlineas;i++))
do  
  A[$i]=$(head -$i nombres.dat | tail -1)
done

count=0
for((i=1;i<=$nlineas;i++))
do 
  encontrado=0
  for((j=1;j<=${#B[@]};j++))
  do
    if [ ${B[j]} == ${A[i]} ]
    then
      encontrado=1
    fi
  done
  if [[ $encontrado -eq 0 ]]
  then
    count=$((count+1))
    B[$count]=${A[i]}
  fi
done


for((i=1;i<=${#B[@]};i++))
do 
  C[$i]=0
  for((j=1;j<=${#A[@]};j++))
  do
    if [ ${B[i]} == ${A[j]} ]
    then
       C[$i]=$((${C[i]}+1))
    fi
  done
done


for((i=1;i<=${#B[@]};i++))
do  
  echo "${C[i]} ${B[i]}"
done | sort -rn
