****************************************
Tipos y técnicas de transmisión de datos
****************************************

**Según la sincronización** del emisor y al receptor, podemos clasificar la transmisión de datos en los siguientes tipos

* **Transmisión síncrona.** Utilizamos una señal periódica que indica los instantes en los que está accesible cada dígito. Normalmente el emisor envía al receptor la señal de sincronización junto con la señal de datos. Es decir el emisor y el receptor están sincronizados

  .. image:: imagenes/TTT1.png
    :width: 400
  
* **Transmisión asíncrona**. Una transmisión es asíncrona cuando el proceso de sincronización entre el emisor y el receptor se realiza en cada palabra de código transmitida. Por ejemplo, con 1 bit de start, 8 bits de carácter y 3 bits de stop, el rendimiento es 8/12 ~ 67%

Además podemos clasificarla como **digital y analógica**

* **Transmisión analógica.** La función es continua en el tiempo y puede tomar cualquier valor continuo dentro del rango que permite el medio de transmisión.

* **Transmisión digital.** La función es discreta en el tiempo y solo puede tomar unos pocos valores dentro de un rango.

Si tomamos la **direccionalidad de la transmisión**, podemos clasificar la transmisión de datos en los siguientes tipos

* **Simplex.** La transmisión tiene lugar en un solo sentido (TV, radio)

  .. image:: imagenes/TTT2.png
    :width: 300

* **Semidúplex (half-dúplex).**   La transmisión puede tener lugar en ambos sentidos, es decir que puede ser bidireccional, pero no puede ser simultánea (radioaficionados)

  .. image:: imagenes/TTT3.png
    :width: 300
    
* **Dúplex (full - dúplex).** Transmisión bidireccional y además simultánea, es decir, puede tener lugar en ambos sentidos y al mismo tiempo (teléfono)

  .. image:: imagenes/TTT4.png
    :width: 300
    
Según el **modo de transmisión** tendríamos:

* **Serie.** Los datos se transmiten bit a bit por un solo canal de transmisión
* **Paralelo.** Consiste en la transmisión simultánea de N bits

