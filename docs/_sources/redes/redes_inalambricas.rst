Tipos de redes 802.11
=====================

Las redes 802.11 son un conjunto de estándares para redes inalámbricas (Wi-Fi) desarrollados por el Institute of Electrical and Electronics Engineers (IEEE). Estos estándares definen las características técnicas de las redes Wi-Fi, como la frecuencia de operación, el ancho de banda, la velocidad de transmisión y el alcance.

Versiones más utilizadas hoy en día

1. **IEEE 802.11n (Wi-Fi 4)**, Frecuencia: 2.4 GHz y 5 GHz (dual-band). Velocidad máxima: Hasta **600 Mbps**. Fue un gran salto en velocidad y alcance respecto a sus predecesores (802.11a/b/g).Es compatible con dispositivos más antiguos que operan en 2.4 GHz. Los canales 1, 6 y 11 son los únicos que no se superponen. Sigue siendo ampliamente utilizado en hogares y pequeñas empresas debido a su relación costo-beneficio.

2. **IEEE 802.11ac (Wi-Fi 5)**. Frecuencia: 5 GHz (y 2.4 GHz en algunos casos). Velocidad máxima: Hasta **6.9 Gbps** (en condiciones ideales). Ofrece velocidades mucho más altas que 802.11n, ideal para streaming de video 4K, juegos en línea y aplicaciones de alta demanda. Introduce MU-MIMO (Multi-User MIMO), que permite atender a múltiples dispositivos simultáneamente. Es el estándar dominante en routers y dispositivos modernos desde su lanzamiento en 2013.

3. **IEEE 802.11ax (Wi-Fi 6)**. Frecuencia: 2.4 GHz y 5 GHz (dual-band). Velocidad máxima: Hasta **9.6 Gbps**. Diseñado para mejorar el rendimiento en entornos con muchos dispositivos conectados (como hogares inteligentes o áreas públicas). Introduce OFDMA (Orthogonal Frequency-Division Multiple Access), que permite una mayor eficiencia en la transmisión de datos. Compatible con versiones anteriores (802.11a/b/g/n/ac). Se está adoptando rápidamente en routers y dispositivos nuevos (desde 2019).

4. **IEEE 802.11be (Wi-Fi 7)**. Frecuencia: 2.4 GHz, 5 GHz y 6 GHz (tri-band). Velocidad máxima: Hasta **46 Gbps**. Ofrece velocidades extremadamente altas y mejoras significativas en la eficiencia espectral. Ideal para aplicaciones futuras como realidad aumentada, inteligencia artificial y IoT de alta densidad.



El canal de una red 802.11
==========================

* **Banda de 2.4 GHz**: 

  * Canales disponibles: 14 canales (dependiendo de la región).
  * Ancho de canal: 20 MHz (estándar) o 40 MHz (en algunos casos). 
  * Mayor alcance pero menor velocidad en comparación con las bandas de 5 GHz y 6 GHz.

* **Banda de 5 GHz**

  * Canales disponibles: Más de 20 canales (varía según la región).
  * Ancho de canal: 20 MHz, 40 MHz, 80 MHz o 160 MHz.
  * Menor alcance pero mayor velocidad y menos interferencias.

* **Banda de 6 GHz (Wi-Fi 6E)**

  * Canales disponibles: Más de 50 canales (dependiendo de la región).
  * Ancho de canal: 20 MHz, 40 MHz, 80 MHz, 160 MHz o 320 MHz.
  * Menor congestión y mayor ancho de banda.

El SSID de una red 802.11
=========================

El SSID es una cadena de texto de hasta 32 caracteres que identifica una red Wi-Fi. Es visible para cualquier dispositivo que busque redes inalámbricas cercanas. Puede incluir letras, números y algunos caracteres especiales (como guiones o guiones bajos).

Seguridad en 802.11
===================

Para encriptar o codificar la información que de la red podemos usar distintos tipos de cifrado:

* **WEP** Privacidad equivalente a cableado, se encarga de encriptar la información o los datos utilizando claves preconfiguradas para cifrar y descifrar los datos. Puede utilizar claves de 64 bits, 128 bits o 256 bits. Al ser un método bastante débil, ya que es fácilmente descifrable, no es muy recomendable utilizarlo.

* **WPA-PSK** que utiliza un algoritmo complejo de encriptación, utilizando el protocolo TKIP que es el que cambia la clave dinámicamente. Por lo que WPA-PSK es vulnerable en la primera conexión al punto de acceso que es donde utiliza la clave preestablecida, después va cambiando las claves de forma dinámica. Se ha mejorado con el **WAP2** y **WPA3**

Otras medidas de seguridad es filtrar las direcciones MAC, ocultar SSID.

También podemos instalar un servicio de autentificación, que debe verificar los permisos y claves de los usuarios