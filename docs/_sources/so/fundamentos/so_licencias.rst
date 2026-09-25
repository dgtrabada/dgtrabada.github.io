**************************
Tipos software y licencias
**************************

**Un Programa** es una lista de instrucciones escritas en un lenguaje de programación utilizadas para controlar las tareas de una máquina.
   
.. code-block:: c

 /*
 primos.c is a free (GPLv3) program to list prime numbers using c
 Copyright (C) 2009 by Daniel González Trabada

 This program is free software: you can redistribute it and/or 
 modify  it under the terms of the GNU General Public License 
 as published by the Free Software Foundation, either version 3
 of the License, or  (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program. 
 If not, see <http://www.gnu.org/licenses/>.

 */

 #include <stdio.h>
 #include <stdbool.h>
 int main() {
   int c,d,n=100;
   bool es_primo=false;
   c=1;
   while (c < n) {
     c++;
     es_primo=true;
     for (d = 2; d < c; ++d) {
       if (c % d == 0) {
       es_primo = false;
       break;
       }
     }
     if (es_primo) {
     printf("%d ", c);
     }
   }
   printf("\n");
   return 0;
 }
   
   


**Compilar** significa traducir un código de programación a código ejecutable por la máquina

.. code-block:: bash
   
   gcc primos.c


**Ejecutar** es la acción de iniciar la carga de un programa o de un archivo ejecutable.

.. code-block:: bash
   
   ./a.out
   
Para dejar constancia de la autoría de un programa se puede inscribir en el `Registro Territorial de la Propiedad Intelectual <https://www.comunidad.madrid/gobierno/informacion-juridica-legislacion/registro-territorial-propiedad-intelectual>`_, aunque no es obligatorio: los derechos de autor existen desde el momento en que se crea la obra.


Tipos de software
=================

* **Software de sistema:** Su objetivo es desvincular adecuadamente al usuario y al programador de los detalles del sistema informático en particular que se use, aislándolo especialmente del procesamiento referido a las características internas de: memoria, discos, puertos y dispositivos de comunicaciones, impresoras, pantallas, teclados, etc. Incluye entre otros: Sistemas operativos, Controladores de dispositivos, Herramientas de diagnóstico, etc ...

* **Software de programación:** Es el conjunto de herramientas que permiten al programador desarrollar programas de informática, usando diferentes alternativas y lenguajes de programación, de una manera práctica. Incluyen en forma básica: Editores de texto, Compiladores,  Intérpretes, Depuradores, Entornos de desarrollo integrados (IDE): Agrupan las anteriores herramientas, usualmente en un entorno visual, de forma tal que el programador no necesite introducir múltiples comandos para compilar, interpretar, depurar, etc. Habitualmente cuentan con una avanzada interfaz gráfica de usuario (GUI).
 
* **Software de aplicación:** Es aquel que permite a los usuarios llevar a cabo una o varias tareas específicas, en cualquier campo de actividad susceptible de ser automatizado o asistido, con especial énfasis en los negocios. Incluye entre muchos otros: Aplicaciones para Control de sistemas y automatización industrial, Aplicaciones ofimáticas,  Software educativo, Software empresarial, Bases de datos, Videojuegos, Software médico, etc



Tipos de licencias software
===========================


La autorización que el titular de los derechos patrimoniales de una obra literaria, artística, musical, audiovisual o de software da a otras personas sobre lo que pueden y no pueden hacer con la obra, se realiza a través de una Licencia de Uso. La licencia es un documento que expresa la voluntad del autor sobre los límites y alcances del uso que pueden hacer las personas respecto a la:

* Copia.
* Reproducción.
* Modificación.
* Traducción.
* Adaptación.
* Beneficio económico.

En este sentido se pueden encontrar una variedad de tipos de licencias que pueden ir desde las más restrictivas, en la cual el autor se reserva todos los derechos (de ahí la expresión **“todos los derechos reservados”**), hasta las licencias más permisivas en las cuales el autor autoriza una amplia posibilidad de usos de la obra a las personas (**"algunos derechos reservados"**), el extremo de esta posibilidad es el dominio público.
Sin embargo, en todos estos tipos de licencias está el principio de respeto por el otro y por lo que ha surgido de su creación, es decir el respeto por los Derechos Morales, lo que implica que en ningún momento una persona puede adjudicarse la autoría de una obra que no ha creado, independiente de la licencia que tenga.
La forma de indicar los términos de la Licencia de Uso en una obra, es a través de una leyenda que sintetice lo que se puede y lo que no se puede hacer con la obra. En los libros, las licencias más restrictivas para los usuarios tienen una leyenda en una de las páginas, como la que está a continuación:

*Todos los Derechos Reservados © Nombre del Autor y/o Nombre de la Editorial. Prohibida la reproducción total o parcial de esta obra, por cualquier medio, sin la autorización del autor/editor.*

Mientras que las licencias más permisivas con los usuarios, presentan leyendas del siguiente tipo:

*Derechos de Copia © Nombre del Autor y/o Nombre de la Editorial. Se permite la copia en cualquier formato siempre y cuando no se alteren los contenidos y se haga reconocimiento de los autores/editorial.*

La licencia no pone en consideración el reconocimiento de la autoría de la obra, porque como lo establece el Derecho Moral en el Derecho de Autor, esto no es negociable. Siempre que se conozca la autoría de una obra se debe indicar.

Software gratuito no es lo mismo que software libre
===================================================

Que un programa se pueda descargar sin pagar no significa que sea libre. Según su forma de distribución encontramos:

* **Freeware**: se puede usar gratis, pero no se tiene acceso al código fuente ni se permite modificarlo; el autor conserva todos los derechos. Por ejemplo, Google Chrome o Adobe Acrobat Reader.
* **Shareware**: se puede probar gratis durante un tiempo o con funciones limitadas, y después hay que pagar para seguir usándolo. Por ejemplo, WinRAR.
* **Demo o versión de prueba (trial)**: versión limitada, en tiempo o en funciones, de un programa comercial, para evaluarlo antes de comprarlo.
* **Dominio público**: el programa no tiene derechos de autor patrimoniales, bien porque han caducado o porque el autor ha renunciado a ellos, y se puede usar, modificar y distribuir sin ninguna condición.

El freeware, el shareware y las demos son **software privativo**: gratis o no, el usuario no tiene las libertades del software libre.

Software privativo
==================

El software privativo es cualquier software que no es libre. Está prohibido su uso, redistribución o modificación, o requiere que se solicite permiso, o tiene tantas restricciones que de hecho no se puede hacer libremente

**EULA**, son las siglas de **“End-User License Agreement”** o traducido al español, *“Acuerdo de Licencia con el Usuario Final”* que son las condiciones o limitaciones que debes aceptar para poder utilizar ese programa, aplicación, juego, producto, etc.

Licencia Retail
---------------

Windows Retail es la licencia “de toda la vida” que podemos adquirir en la propia página de microsoft.com o en una tienda. Lo que la caracteriza es que **se puede trasladar de un equipo a otro**, aunque solo puede estar activada en un equipo a la vez: tendremos que desactivarla primero en un ordenador antes de activarla en el siguiente. También podremos hacer cambios en el hardware sin tener que comprar otra licencia. Desde Windows 10 la licencia se puede **vincular a una cuenta de Microsoft**, lo que facilita reactivarla al cambiar de equipo iniciando sesión.
En las licencias de tipo retail, normalmente podemos elegir entre una licencia completa, o una licencia de actualización, que permite actualizar un sistema anterior al nuevo, por un coste algo más reducido.

.. code-block:: shell

 slmgr /upk                      # desinstala la licencia
 slmgr /cpky                     # la elimina del registro
 slmgr /ipk [clave de producto]  # instalar la clave de activación
 slmgr /ato                      # activará la licencia

Licencia VOLUMEN (VLM)
----------------------

Las licencias  VOLUMEN, enfocadas a empresas, son las más completas. En este caso, el precio por licencia suele tener descuento y la ventaja está en que se puede utilizar en varios ordenadores en los que, por cierto, se pueden también hacer cambios de hardware. A los usuarios normales no les aporta ventaja de ningún tipo,  son como las RETAIL para empresas.
Los Cracks para activar la licencias de windows piratas utilizan estas licencias, Windows pregunta a un servidor KMS, significa Key Management Service, y es un servicio de publicación automática de licencias de Microsoft, capaz de servir licencias para sistemas operativos. El Crack emula el servidor y dice que la licencia que se ha introducido es válida, de esta forma Windows queda activado. Las activaciones por KMS caducan y el equipo tiene que renovarlas periódicamente (cada 180 días), por eso estos Cracks dejan instalado un programa que se ejecuta en segundo plano. Esta práctica además de ser ilegal crea un fallo en la seguridad del equipo: se está ejecutando con privilegios de administrador un programa de origen desconocido.

MSDN y licencias de educación
-----------------------------

Son unas licencias especiales de Microsoft que permiten su uso únicamente para actividades de desarrollo, pruebas y evaluación (MSDN, hoy *Visual Studio Subscriptions*) o para actividades educativas y de formación (*Azure Dev Tools for Teaching*, antes DreamSpark/Imagine). Cualquier uso de estas licencias en equipos que desarrollen actividades fuera de este ámbito, es ilegal.
 
Licencia OEM
---------------

Las siglas OEM hacen referencia a Original Equipment Manufacturer, que en castellano se podría traducir como fabricante de equipamiento original.

Esta licencia va ligada a la placa base, de modo que solo podremos usar la licencia en un único equipo, pero con la ventaja de un reducido coste. Podemos cambiar otros componentes hardware (RAM, tarjeta gráfica) sin que afecte a la licencia.
Los fabricantes de equipos (OEM) como HP, Dell, etc. compran muchas de estas licencias directamente a Microsoft para venderlas preinstaladas en sus ordenadores, por eso su coste es mucho menor que el de una retail (~250€).

En Internet se venden claves de Windows muy baratas (~20€), pero no las vende Microsoft sino tiendas de terceros que las revenden, y muchas son claves OEM sacadas de equipos desechados o claves de volumen de empresas, de origen dudoso. Pueden dejar de funcionar en cualquier momento si Microsoft las bloquea.

.. image:: imagenes/OEM.png


Software libre
==============

`What is Open Source explained in LEGO <https://www.youtube.com/watch?v=a8fHgx9mE5U>`_

El software libre es el que respeta la libertad de los usuarios. El concepto lo definió Richard Stallman, que en 1985 creó la **Free Software Foundation (FSF)**, con las cuatro libertades del software libre:

#. La libertad de **usar** el programa, con cualquier propósito (Uso).
#. La libertad de **estudiar** cómo funciona el programa y modificarlo, adaptándolo a las propias necesidades (Estudio).
#. La libertad de **distribuir** copias del programa, con lo cual se puede ayudar a otros usuarios (Distribución).
#. La libertad de **mejorar** el programa y hacer públicas esas mejoras a los demás, de modo que toda la comunidad se beneficie (Mejora).

Las libertades de estudiar y de mejorar el programa exigen tener acceso al **código fuente**.

Libre no significa gratis: en inglés *free* significa tanto "libre" como "gratis", y la FSF lo aclara con la frase *"free as in freedom, not as in free beer"*. Se puede cobrar por distribuir software libre, por ejemplo vendiendo una copia de una distribución de GNU/Linux o el servicio de instalarla y mantenerla.

En 1998 surge el movimiento **open source** (código abierto), con la **Open Source Initiative (OSI)**. En la práctica casi todas las licencias libres son también open source, la diferencia está en el enfoque: la FSF defiende el software libre como una cuestión ética de libertad de los usuarios, y la OSI como una forma más eficaz de desarrollar software.

Copyleft
--------

El **copyleft** es una forma de utilizar el copyright para que un programa libre siga siendo libre: quien distribuya el programa, o una versión modificada de él, tiene que hacerlo con la misma licencia. Según este criterio las licencias libres se dividen en tres grupos:

* **Copyleft fuerte**: todo programa que incluya el código tiene que distribuirse con la misma licencia. Por ejemplo, GPL y AGPL.
* **Copyleft débil**: solo los ficheros con el código original y sus modificaciones mantienen la licencia, pero pueden combinarse con código con otra licencia, incluso privativo. Por ejemplo, MPL y LGPL.
* **Permisivas (sin copyleft)**: permiten redistribuir el código, modificado o no, con cualquier licencia, incluso privativa, con la condición de mantener el aviso de autoría. Por ejemplo, BSD, MIT y Apache.

Licencias GPL
-------------

Una de las más utilizadas es la Licencia Pública General de GNU (GNU GPL), la licencia de copyleft fuerte por excelencia; con ella se distribuye, por ejemplo, el núcleo Linux. El autor conserva los derechos de autor (copyright), y permite la redistribución y modificación del software, pero únicamente bajo esa misma licencia: todas las versiones modificadas tienen que seguir siendo GPL.

Si se reutiliza en un mismo programa código “A” licenciado bajo GNU GPL y código “B” licenciado bajo otra licencia libre, el programa final “C”, independientemente de la cantidad de cada uno de los códigos “A” y “B”, debe distribuirse bajo la licencia GNU GPL. El código “B” no pierde su licencia ni su aviso de autoría, pero el conjunto se distribuye como GPL.

Esto solo es posible si la licencia de “B” es **compatible** con la GPL, es decir, si no impone condiciones que la GPL no admite. Las licencias permisivas como BSD o MIT son compatibles; otras licencias libres no lo son y su código no se puede mezclar en un mismo programa con código GPL. En el sitio web oficial de GNU hay una lista de licencias compatibles con la GNU GPL y otras que no.

La obligación de la GPL afecta a lo que se **mezcla en un mismo programa**, no a lo que simplemente se distribuye junto: una distribución de GNU/Linux incluye programas GPL junto a otros con licencias distintas, cada uno con la suya.

Además, las obligaciones de la GPL aparecen al **distribuir** el programa, no al usarlo: podemos modificar un programa GPL para nuestro propio uso sin tener que publicar nada. Si lo distribuimos, tenemos que ofrecer también su código fuente.

La **LGPL** (Lesser GPL) es una variante de copyleft débil pensada para bibliotecas: permite que programas con cualquier licencia, incluso privativos, usen la biblioteca, pero las modificaciones de la propia biblioteca tienen que seguir siendo LGPL.

Durante muchos años la GPL y sus derivadas fueron las licencias más empleadas en el software libre (en torno al 60%); actualmente las licencias permisivas como la MIT son las más utilizadas.

`Software libre para una sociedad libre <https://www.gnu.org/philosophy/fsfs/free_software.es.pdf>`_

Licencias AGPL
--------------

La Licencia Pública General de Affero (en inglés Affero General Public License, también Affero GPL o AGPL) es una licencia copyleft derivada de la Licencia Pública General de GNU diseñada específicamente para asegurar la cooperación con la comunidad en el caso de software que funcione en servidores de red.
La Affero GPL es íntegramente una GNU GPL con una cláusula nueva: si el software modificado se ejecuta para ofrecer servicios a través de una red de ordenadores (por ejemplo una aplicación web), hay que ofrecer su código fuente a los usuarios de ese servicio, aunque el programa en sí no se les distribuya.
La Free Software Foundation recomienda que el uso de la GNU AGPLv3 sea considerado para cualquier software que usualmente corra sobre una red.

Licencias estilo BSD
--------------------

Llamadas así porque se utilizan en gran cantidad de software distribuido junto a los sistemas operativos BSD. El autor, bajo tales licencias, mantiene la protección de copyright únicamente para la renuncia de garantía y para requerir la adecuada atribución de la autoría en trabajos derivados, pero permite la libre redistribución y modificación, incluso si dichos trabajos tienen propietario. Son licencias permisivas, compatibles con la GNU GPL, por lo que su código se puede incluir en programas GPL. Sus defensores argumentan que dan más libertad a quien recibe el software, que puede decidir incluso redistribuirlo como no libre; sus detractores, que por eso mismo no garantizan que el software siga siendo libre. Por ejemplo, macOS incluye mucho código de FreeBSD, y la consola PlayStation usa un sistema operativo basado en FreeBSD.

Muy parecidas son la licencia **MIT**, la licencia libre más utilizada hoy en día, y la licencia **Apache 2.0**, que además incluye una protección frente a patentes y es la que usan, por ejemplo, gran parte de Android y Kubernetes.

Licencias estilo MPL y derivadas (Mozilla Public License)
----------------------------------------------------------

Esta licencia es de Software Libre y tiene un gran valor porque fue el instrumento que empleó Netscape Communications Corp. para liberar su Netscape Communicator 4.0 y empezar ese proyecto tan importante para el mundo del Software Libre: Mozilla. Se utilizan en gran cantidad de productos de software libre de uso cotidiano en todo tipo de sistemas operativos. La MPL es una licencia de **copyleft débil**: los ficheros con código MPL, y sus modificaciones, tienen que seguir siendo MPL, pero pueden combinarse en un mismo programa con otros ficheros con cualquier licencia, incluso privativa. Así evita el efecto “viral” de la GPL (si usas código licenciado GPL, tu desarrollo final tiene que estar licenciado GPL), sin ser tan permisiva como las licencias tipo BSD. La NPL (luego la MPL) fue una de las primeras licencias libres nuevas desde la GPL y la BSD. Hoy la utilizan, por ejemplo, Firefox y LibreOffice.

Doble licencia
--------------

El titular de los derechos de autor (copyright) de un software bajo licencia copyleft puede también realizar una versión modificada bajo su copyright original, y venderla bajo cualquier licencia que desee, además de distribuir la versión original como software libre. Esta técnica ha sido usada como un modelo de negocio por una serie de empresas que realizan software libre (por ejemplo MySQL); esta práctica no restringe ninguno de los derechos otorgados a los usuarios de la versión copyleft.

En España, toda obra derivada está tan protegida como una original, siempre que la obra derivada parta de una autorización contractual con el autor. En el caso genérico de que el autor retire las licencias “copyleft”, no afectaría de ningún modo a los productos derivados anteriores a esa retirada, ya que no tiene efecto retroactivo. En términos legales, el autor no puede retirar el permiso de una licencia a quien ya la ha recibido; la GPLv3, por ejemplo, dice expresamente que es irrevocable. Si así sucediera, el conflicto entre las partes se resolvería en un pleito convencional.
 
Diferentes tipos de Licencias de Software Libre
-----------------------------------------------

En las siguientes tablas se comparan las licencias de software libre más utilizadas: qué garantiza cada icono y qué licencias lo cumplen.

.. image:: imagenes/CC1.png

.. image:: imagenes/CC2.png

Tipos de licencias (documentos)
===============================

Todo contenido (texto, ficheros, fotos, video,...) que está en Internet ha sido colocado por alguien, por lo tanto tiene dueño. Muchos de estos contenidos, objetos digitales, obras y creaciones están referenciados con su autoría e incluso la licencia de uso que tienen, suele pasar mucho en los vídeos, fotografías, imágenes, obras literarias, documentación, apuntes, manuales,....

También puedes encontrar que muchos contenidos e información de Internet no tengan ninguna referencia a su titularidad, pero el hecho de que no aparezca la autoría o que no se explicite el uso permisivo o restrictivo que poseen dichos contenidos, no significa que puedas copiarlos y utilizarlos libremente como te venga en gana.

Desde el momento de su creación toda obra tiene un reconocimiento legal de autoría. Es precisamente ese reconocimiento legal que se dan a todos los contenidos, lo que nos permite también a nosotros tener la tranquilidad de poder publicar nuestras propias creaciones originales (vídeos, fotos, textos, apuntes, etc.) sabiendo que pueden estar salvaguardados de un uso inadecuado.

Así pues, todo contenido tiene unos derechos de autor y depende del propio autor el determinar el uso y distribución que se pueda hacer de su obra. En este sentido podríamos esquematizar los tipos de licencias de contenidos en Internet del siguiente modo:

* **Copyright**: no es propiamente una licencia, sino el derecho de autor sobre la obra, en el que se basan todas las licencias. Cuando una obra solo indica © se entiende que tiene **todos los derechos reservados**, que es lo habitual en el mundo editorial y audiovisual.
* **Creative Commons**: normalmente indicado como las letras CC. Las obras CC también tienen copyright de reconocimiento de autoría, aunque se caracterizan por que permite copiarlas y distribuirlas. El modo de distribución de las obras se explicita en cada uno de los tipos de licencias Creative Commons. Están pensadas para contenidos (textos, imágenes, música, vídeo...), no para software: la propia Creative Commons recomienda usar licencias de software libre para los programas.

Las licencias Creative Commons se basan en cuatro condicionantes:

.. image:: imagenes/CC3.png

.. image:: imagenes/CC4.png

.. toctree::
   :hidden:

   cuestionario_licencias.rst

