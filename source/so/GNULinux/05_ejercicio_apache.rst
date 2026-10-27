*****************
Ejercicio Apache
*****************

Haz un **nuevo clon enlazado** de **MV Ubuntu Server 26.04** e instala un servidor Apache con el sitio **tunombre**, como en el :ref:`Caso práctico: Apache`.

* Sube el **pantallazo**\ :sup:`1`, con el estado del servicio (``systemctl status apache2``):

  .. image:: imagenes/apache_ej_status.png

* Sube el **pantallazo**\ :sup:`2`, con la configuración del sitio (``cat /etc/apache2/sites-available/tunombre.conf``):

  .. image:: imagenes/apache_ej_conf.png

* Sube el **pantallazo**\ :sup:`3`, con la página vista desde el navegador de tu ordenador:

  .. image:: imagenes/apache_ej_web.png

Cuando termines y lo haya corregido el profesor, borra el clon enlazado, pero deja la original **MV Ubuntu Server 26.04**.
