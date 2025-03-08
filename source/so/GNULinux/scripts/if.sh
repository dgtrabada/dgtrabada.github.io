cadena=$1
if [ -n "$cadena" ]; then
  echo "La cadena no está vacía"
else
  echo "La cadena está vacía"
fi

cadena=$1
if test -n "$cadena"
then
  echo "La cadena no está vacía"
else
  echo "La cadena está vacía"
fi
