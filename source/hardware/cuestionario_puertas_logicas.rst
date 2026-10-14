*******************************
Cuestionario puertas lógicas
*******************************

En las preguntas, a̅ es la negación de a (NOT a), * es AND, + es OR y ⊗ es XOR.

.. cuestionario::

   1. ¿Qué puerta es?
      - 1. Puerta:
        imagen: imagenes/puertas/quiz_and.png 120
        (x) AND
        ( ) OR
        ( ) NAND
      - 2. Puerta:
        imagen: imagenes/puertas/quiz_nor.png 120
        ( ) OR
        (x) NOR
        ( ) XOR
      - 3. Puerta:
        imagen: imagenes/puertas/quiz_xor.png 120
        ( ) OR
        ( ) NOR
        (x) XOR
      - 4. Puerta:
        imagen: imagenes/puertas/quiz_nand.png 120
        ( ) AND
        (x) NAND
        ( ) NOT
      - 5. Puerta:
        imagen: imagenes/puertas/quiz_or.png 120
        (x) OR
        ( ) XOR
        ( ) AND
      - 6. Puerta:
        imagen: imagenes/puertas/quiz_not.png 120
        ( ) NAND
        ( ) NOR
        (x) NOT
      - 7. ¿Qué indica el círculo pequeño a la salida de algunas puertas (NAND, NOR, NOT)?
        (x) Que la salida está negada
        ( ) Que la puerta tiene tres entradas
        ( ) Que la salida vale siempre 1

   2. Completa la tabla de verdad:
      tabla:
         | a | b | a*b (AND) | a+b (OR) | NAND | NOR | a⊗b (XOR) |
         | 0 | 0 | [0] | [0] | [1] | [1] | [0] |
         | 0 | 1 | [0] | [1] | [1] | [0] | [1] |
         | 1 | 0 | [0] | [1] | [1] | [0] | [1] |
         | 1 | 1 | [1] | [1] | [0] | [0] | [0] |

   3. Si a = 1, b = 0 y c = 1, ¿cuánto vale cada expresión?
      - 1. a*b
        Vale: [0]
      - 2. a+b
        Vale: [1]
      - 3. a̅
        Vale: [0]
      - 4. NOT (a*c)
        Vale: [0]
      - 5. (a+b)*c
        Vale: [1]
      - 6. a*b+c
        Vale: [1]
      - 7. a⊗b
        Vale: [1]
      - 8. a⊗b⊗c
        Vale: [0]

   4. Indica si la salida de cada circuito vale 0 o 1. Las entradas en blanco están apagadas (0) y las naranjas encendidas (1):
      - 1. Circuito 1:
        imagen: imagenes/puertas/moodle_circuito_1.png 190
        Salida: [1]
      - 2. Circuito 2:
        imagen: imagenes/puertas/moodle_circuito_2.png 190
        Salida: [0]
      - 3. Circuito 3:
        imagen: imagenes/puertas/moodle_circuito_3.png 190
        Salida: [1]
      - 4. Circuito 4:
        imagen: imagenes/puertas/moodle_circuito_4.png 190
        Salida: [0]
      - 5. Circuito 5:
        imagen: imagenes/puertas/moodle_circuito_5.png 260
        Salida: [0]
      - 6. Circuito 6:
        imagen: imagenes/puertas/moodle_circuito_6.png 260
        Salida: [1]
      - 7. Circuito 7:
        imagen: imagenes/puertas/moodle_circuito_7.png 260
        Salida: [0]
      - 8. Circuito 8:
        imagen: imagenes/puertas/moodle_circuito_8.png 260
        Salida: [1]
      - 9. Circuito 9:
        imagen: imagenes/puertas/moodle_circuito_9.png 260
        Salida: [1]
      - 10. Circuito 10:
        imagen: imagenes/puertas/moodle_circuito_10.png 260
        Salida: [0]
      - 11. Circuito 11:
        imagen: imagenes/puertas/moodle_circuito_11.png 260
        Salida: [1]

   5. Álgebra de Boole:
      - 1. Según el teorema de Morgan, la negación de (a+b) es igual a:
        (x) a̅*b̅
        ( ) a̅+b̅
        ( ) a*b
      - 2. Según el teorema de Morgan, la negación de (a*b) es igual a:
        ( ) a̅*b̅
        (x) a̅+b̅
        ( ) a+b
      - 3. Una función vale 1 solo en las filas a=0, b=1 y a=1, b=0. Con la primera forma canónica (suma de productos), ¿cuál es su fórmula?
        (x) f = a̅b + ab̅
        ( ) f = ab + a̅b̅
        ( ) f = a̅b̅ + ab
      - 4. ¿A qué puerta equivale la función de la pregunta anterior?
        ( ) OR
        (x) XOR
        ( ) NOR
      - 5. Una función vale 1 en las filas 00, 01 y 10, y 0 en la fila 11. ¿A qué puerta equivale?
        ( ) AND
        ( ) NOR
        (x) NAND
      - 6. ¿Se puede construir cualquier circuito lógico usando solo puertas NAND?
        (x) Sí
        ( ) No
      - 7. Obtén la primera forma canónica (mintérminos) de la siguiente tabla de verdad:
        tabla:
           | A | B | F |
           | 0 | 0 | 0 |
           | 0 | 1 | 1 |
           | 1 | 0 | 0 |
           | 1 | 1 | 0 |
        ( ) F = A+B
        ( ) F = A̅+B
        ( ) F = A*B
        (x) F = A̅*B

   6. Se quiere diseñar el control de una puerta automática. La puerta se abre (S = 1) solo si hay una persona delante del sensor (P = 1) y, además, tiene una tarjeta válida (T = 1) o el guardia autoriza la entrada (G = 1). En cualquier otro caso la puerta sigue cerrada (S = 0).
      - 1. Completa la tabla de verdad:
        tabla:
           | P | T | G | S |
           | 0 | 0 | 0 | [0] |
           | 0 | 0 | 1 | [0] |
           | 0 | 1 | 0 | [0] |
           | 0 | 1 | 1 | [0] |
           | 1 | 0 | 0 | [0] |
           | 1 | 0 | 1 | [1] |
           | 1 | 1 | 0 | [1] |
           | 1 | 1 | 1 | [1] |
      - 2. ¿Cuál es la función S?
        (x) S = P*(T+G)
        ( ) S = P*T*G
        ( ) S = P+T+G
      - 3. El circuito tiene dos puertas: T y G entran en una puerta y su salida entra, junto con P, en una puerta AND. ¿Qué puerta es la primera?
        [OR]

   7. Sumadores:
      - 1. En el sumador de dos bits a y b, ¿qué puerta da la suma S?
        ( ) AND
        ( ) OR
        (x) XOR
      - 2. En el sumador de dos bits, ¿qué puerta da el acarreo (cuando a y b valen 1)?
        (x) AND
        ( ) OR
        ( ) XOR
      - 3. En el sumador de dos bits, si a = 1 y b = 1:
        S = [0] C_{+} = [1]
      - 4. En el sumador con acarreo, si c = 1, a = 1 y b = 0:
        S = [0] C_{+} = [1]
      - 5. En el sumador con acarreo, si c = 1, a = 1 y b = 1:
        S = [1] C_{+} = [1]
      - 6. En el sumador con acarreo, si c = 0, a = 0 y b = 1:
        S = [1] C_{+} = [0]
      - 7. ¿Cuál es la fórmula de la suma S en el sumador con acarreo?
        (x) S = a⊗b⊗c
        ( ) S = a*b*c
        ( ) S = a+b+c
      - 8. Para sumar números de 8 bits, ¿cuántos sumadores con acarreo hay que encadenar?
        [8|ocho]

   8. Fíjate en el circuito del sumador con acarreo. Si a1 = 0, b1 = 0 y c1 = 0, entonces s1 = 0 y c1+ = 0. Completa la tabla:
      imagen: imagenes/puertas/moodle_sumador.png 320
      tabla:
         | c1 | b1 | a1 | s1 | c1+ |
         | 0 | 0 | 0 | [0] | [0] |
         | 0 | 0 | 1 | [1] | [0] |
         | 0 | 1 | 0 | [1] | [0] |
         | 0 | 1 | 1 | [0] | [1] |
         | 1 | 0 | 0 | [1] | [0] |
         | 1 | 0 | 1 | [0] | [1] |
         | 1 | 1 | 0 | [0] | [1] |
         | 1 | 1 | 1 | [1] | [1] |

   9. Circuitos combinacionales:
      - 1. En un circuito combinacional, las salidas dependen:
        (x) Solo de los valores de las entradas en ese momento
        ( ) De las entradas y de los estados anteriores
      - 2. ¿Cuántas salidas tiene un decodificador de 3 entradas?
        [8|ocho]
      - 3. ¿Cuántas salidas tiene un codificador de 16 entradas?
        [4|cuatro]
      - 4. ¿Cuántas entradas de selección necesita un multiplexor de 8 entradas de información?
        [3|tres]
      - 5. ¿Qué circuito activa la salida que corresponde al código binario presente en la entrada?
        (x) Decodificador
        ( ) Codificador
        ( ) Multiplexor
      - 6. ¿Qué circuito elige cuál de sus entradas de información pasa a la salida?
        ( ) Decodificador
        ( ) Codificador
        (x) Multiplexor

   10. Circuitos secuenciales:
      - 1. En un circuito secuencial, las salidas dependen:
        ( ) Solo de los valores de las entradas en ese momento
        (x) De las entradas y de los estados anteriores
      - 2. ¿Cómo se llaman los circuitos capaces de retener un bit de información?
        (x) Biestables
        ( ) Decodificadores
        ( ) Multiplexores
      - 3. En un biestable RS, si R = 0 y S = 1, ¿cuánto vale Q?
        [1]
      - 4. En un biestable RS, si R = 1 y S = 0, ¿cuánto vale Q?
        [0]
      - 5. En un biestable RS, si R = 0 y S = 0:
        (x) Q mantiene el valor que tenía
        ( ) Q pasa a valer 0
        ( ) Q pasa a valer 1
      - 6. ¿Qué problema tiene el biestable RS cuando R = 1 y S = 1?
        (x) La salida no está definida
        ( ) La salida vale siempre 0
        ( ) La salida vale siempre 1
      - 7. ¿Qué hace el biestable JK cuando sus dos entradas valen 1?
        (x) Cambia de estado (Q pasa a valer lo contrario)
        ( ) Mantiene el estado
        ( ) Su salida no está definida
      - 8. Un biestable T con T = 1 y Q = 0 recibe 3 pulsos de reloj. ¿Cuánto vale Q después?
        [1]
      - 9. ¿Qué biestables se usan para construir un registro?
        ( ) RS
        ( ) T
        (x) D
      - 10. ¿Qué circuito presenta en binario el número de impulsos que han llegado a su entrada?
        ( ) Registro
        (x) Contador
        ( ) Decodificador
