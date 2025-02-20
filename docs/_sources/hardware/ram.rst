***********
Memoria RAM
***********

La RAM (Random Acces Memory = Memoria de acceso aleatorio) es una memoria de trabajo, cuando ejecutamos un programa, se pasa una copia a la memoria RAM, después las instrucciones que componen el programa pasan a la CPU; sin embargo, los contenidos se eliminan al apagarse o reiniciarse el ordenador, a diferencia de los dispositivos de almacenamiento masivo como los discos duros, que mantienen la información de manera segura, incluso cuando el ordenador se encuentra apagado.

.. image:: imagenes/RAM/ram1.png
  :width: 150

La RAM es extremadamente rápida a comparación de los dispositivos de almacenamiento masivo como los discos duros.

.. image:: imagenes/RAM/gerarquia_mem.png
  :width: 350

En la actualidad, encontramos en el mercado procesadores de gama media y alta que  trabajan con memoria DDR5,  es decir cuando vas a comprar un modulo de memoria DDR5, es muy probable que estés comprando un modulo DDR5 UDIMM SDRAM, vamos a entender que significa esto:


* **DRAM** :(Dynamic Random Access Memory): Es el tipo más común de RAM y se utiliza en la mayoría de las computadoras. La DRAM se actualiza constantemente, lo que significa que debe ser alimentada con electricidad para mantener los datos almacenados.
* **SRAM** : (Static Random Access Memory): La SRAM es más rápida que la DRAM, pero también es más costosa y consume más energía. Se utiliza en aplicaciones que requieren un acceso rápido a la memoria, como los cachés de CPU.

* **SDRAM** (Synchronous Dynamic Random Access Memory) La SDRAM sincroniza su reloj con el bus del sistema para permitir un acceso más rápido a la memoria. Se utiliza en computadoras de escritorio y servidores.

  .. image:: imagenes/RAM/sdram.jpeg
    :width: 400
  
  .. image:: imagenes/RAM/sdram2.jpeg
    :width: 400

* **DDR-SDRAM** (Doble data rate SDRAM) SDRAM de doble velocidad, la SDRAM "normal" trabajaba solo con las fases de subida de la señal de reloj, sin embargo la DDR-SDRAM utiliza los flancos de subida y de bajada.

  .. image:: imagenes/RAM/ddr.png
    :width: 200
    
  * DDR2 ~533-800 Mhz, 1.8V y T ~ 4-6 GB/s
  * DDR3 ~1066-1866 Mhz, 1.5V ~ 10-14 GB/s
  * DDR4 ~2133-3200 Mhz, 1.2V ~ 17-25 GB/s
  * DDR5 ~4800-8400 MHz, 1.1V ~ 38-68 GB/s
  
  **Ejemplo de cálculo** DDR4  2933MHz,  (1466.67 X 2) X 8 (cantidad de bytes de ancho) X 4 (cantidad de canales) = ancho de banda de 93 866.88 MB/s, o 94 GB/s.

* **UDIMM** Unbuffered Dual In-line Memory Module,  Módulo de Memoria Dual en Línea sin Búfer, esto significa que no tiene un circuito adicional que actúe como amortiguador entre el controlador de memoria de la placa base y los chips de memoria, UDIMM es el tipo de memoria RAM más común y accesible, els el que se usa en **portatiles y equipos de escritorio**.

* **RDIMM y LRDIMM** son tipos de módulos de memoria diseñados principalmente para **servidores y estaciones de trabajo de alto rendimiento**. A diferencia de los UDIMM, estos módulos ofrecen características específicas que los hacen ideales para entornos con grandes cargas de trabajo y altas demandas de memoria. 

  * **RDIMM** (Registered Dual In-line Memory Module) Incorpora un registro entre los chips de memoria y el controlador de memoria de la placa base. Este registro actúa como un búfer, reduciendo la carga eléctrica en el controlador y mejorando la estabilidad del sistema. Elegimos este modelo si necesitas un alto rendimiento y una gran capacidad de memoria
  
  * **LRDIMM** Utiliza un circuito de búfer más simple que el RDIMM, lo que reduce la carga en el controlador de memoria y permite utilizar una mayor cantidad de módulos.  Si necesitas una densidad de memoria extremadamente alta y una mayor eficiencia energética


* **Por su forma física** los módulos de RAM los podemos clasificar en:

  * **SIMM** (Single Memory Module)

    .. image:: imagenes/RAM/simm.png

  * **DIMM** (Dual Inline Memory Module)

    .. image:: imagenes/RAM/dimm.png

  * **SO-DIMM** usado en portátiles, es un formato reducido del DIMM

    .. image:: imagenes/RAM/so-dimm.png
  

* **Otras características**

  * **Velocidad**  La velocidad de la RAM se mide en megahercios (MHz) o gigahercios (GHz), por ejemplo: DDR4 suele operar entre 2133 MHz y 3200 MHz, mientras que DDR5 puede superar los 4800 MHz.

  * **Ancho de banda** Es la cantidad de datos que la RAM puede transferir por segundo, y está directamente relacionado con la velocidad y la cantidad de canales de la memoria. Cuanto mayor sea el ancho de banda, más datos pueden transferirse entre la RAM y el procesador, por ejemplo: DDR4 puede tener un ancho de banda de 17 GB/s o más, mientras que DDR5 puede superar los 38 GB/s.

  * **Dual chanel**  Incrementa el rendimiento de estas al permitir el acceso simultáneo a dos módulos distintos de memoria, tienen que ser dos módulos exactamente iguales, además la placa base tiene que soportarlo. Las placas base de consumo general soportan configuraciones de doble canal, pero en las versiones para equipos profesionales podemos encontrar soporte de cuádruple, séxtuple y hasta óctuple canal. El doble canal marca una gran diferencia en equipos con GPUs integradas, ya que estas recurren a la memoria RAM y utilizan una parte de ella como memoria VRAM (la VRAM es a la GPU lo que la RAM a la CPU)
  
  * **LPDDR** (abreviatura de Low-Power Double Data Rate), también conocida como Low-Power DDR SDRAM o LPDDR SDRAM, es un tipo de memoria de acceso aleatorio dinámico síncrona de doble velocidad de datos que consume menos energía y está destinada a dispositivos móviles. También se conoce como Mobile DDR y se abrevia como mDDR.
  
  * **XMP** , o Extreme Memory Profile es una característica de la memoria RAM de ordenador que permite a los usuarios configurar y ajustar la velocidad y otras opciones avanzadas de la memoria de forma sencilla
  
  * **SPD**, Serial Presence Detect, es una característica de la memoria RAM de ordenador que permite a la placa base detectar y leer información sobre la memoria instalada en el sistema. La información incluida en el SPD típicamente incluye la marca y modelo de la memoria, su capacidad, su frecuencia y otros ajustes técnicos.
    
    .. image:: imagenes/RAM/spd.png
      :width: 150    
    
  * **EEPROM**, o Electrically Erasable Programmable Read-Only Memory, es un tipo de memoria no volátil que se utiliza en ordenadores y otros dispositivos electrónicos para almacenar datos que pueden ser borrados y reescritos electrónicamente. La memoria EEPROM se utiliza a menudo para almacenar información que necesita ser modificada con regularidad, como la configuración del sistema o la información de usuario, y es más rápida y fácil de actualizar que otros tipos de memoria no volátil, como la memoria ROM o la memoria flash. La memoria EEPROM se diferencia de la memoria RAM en que los datos almacenados en EEPROM no se pierden cuando se apaga el dispositivo, mientras que los datos almacenados en RAM sí se pierden.
  
  * **Tiempo de Latencia** Se refiere al tiempo que tarda la RAM en responder a una solicitud de la CPU para leer o escribir datos. La latencia se mide en ciclos de reloj (CAS latency, o CL).

Instalación
===========

.. image:: imagenes/RAM/instalcion0.jpeg
  :width: 300

.. image:: imagenes/RAM/instalacion.png
  :width: 400

.. image:: imagenes/RAM/instalcion2.jpeg
  :width: 400




