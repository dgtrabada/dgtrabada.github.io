**********************************
Cuestionario gestión del arranque
**********************************

.. cuestionario::

   1. Responde:
      - 1. ¿Puede protegerse un gestor de arranque con contraseña?
        (x) Sí
        ( ) No
      - 2. Si solo tenemos un sistema operativo instalado, ¿nos aparece el menú del gestor de arranque de Windows?
        ( ) Sí
        (x) No
      - 3. En un arranque dual, si queremos que GRUB controle el arranque, ¿qué sistema conviene instalar en último lugar?
        ( ) Windows
        (x) Linux
      - 4. ¿En qué punto de montaje se instala el gestor de arranque en Linux?
        (x) /boot
        ( ) /home
        ( ) /etc
      - 5. ¿Qué programa nos permite editar fácilmente el BCD de Windows?
        (x) EasyBCD
        ( ) Grub2Win
        ( ) rEFInd

   2. Comandos:
      - 1. ¿Qué comando regenera la configuración de GRUB después de instalar otro sistema operativo?
        = sudo update-grub | update-grub | sudo update-grub2 | update-grub2
      - 2. Desde la consola de recuperación de Windows, ¿qué comando repara el MBR?
        = bootrec /fixmbr
      - 3. ¿Y qué comando busca los Windows instalados y regenera el BCD?
        = bootrec /rebuildbcd
      - 4. ¿En qué fichero se configura GRUB (entrada por defecto, tiempo de espera...)?
        = /etc/default/grub
      - 5. ¿Qué comando de Windows muestra y edita las entradas del arranque?
        = bcdedit

   3. Problemas del arranque dual:
      - 1. Instalamos una distribución de Linux junto a Windows, pero el equipo no la deja arrancar por no estar firmada digitalmente. ¿Qué medida de seguridad es la responsable?
        (x) Secure Boot
        ( ) El inicio rápido de Windows
        ( ) La contraseña de GRUB
      - 2. Desde Linux no podemos montar las particiones de Windows aunque el equipo estaba apagado. ¿Qué debemos desactivar?
        ( ) Secure Boot
        (x) El inicio rápido de Windows
        ( ) El gestor de arranque
      - 3. Reinstalamos Windows y desaparece el menú de GRUB. ¿Cómo lo recuperamos?
        ( ) No se puede recuperar, hay que reinstalar Linux
        (x) Arrancando con un live USB de Linux y usando grub-install o Boot-Repair
        ( ) Con el comando bootrec /fixmbr
