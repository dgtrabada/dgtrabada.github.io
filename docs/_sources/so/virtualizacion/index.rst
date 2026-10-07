*****************
La virtualización
*****************

La virtualización es una tecnología que permite la creación de entornos virtuales o máquinas virtuales (VM) que funcionan de manera independiente en un mismo sistema físico. Consiste en la abstracción de los recursos físicos, como la CPU, la memoria, el almacenamiento y los dispositivos de entrada/salida, para asignarlos y compartirlos entre varias máquinas virtuales.

El objetivo principal de la virtualización es maximizar la utilización de los recursos físicos y mejorar la eficiencia de los sistemas informáticos. Al utilizar la virtualización, es posible ejecutar múltiples sistemas operativos y aplicaciones en un único servidor o computadora, lo que reduce la necesidad de hardware físico adicional.

Algunos conceptos clave relacionados con la virtualización son:

* **Hipervisor**: También conocido como monitor de máquina virtual (VMM), es el software o firmware responsable de crear y gestionar las máquinas virtuales. Se encarga de asignar y administrar los recursos físicos entre las VM.

  Existen dos tipos principales de hipervisores:

  * **Hipervisor de tipo 1 o "nativo"** (Bare Metal Hypervisor): Este tipo de hipervisor se ejecuta directamente sobre el hardware físico sin depender de un sistema operativo anfitrión. Actúa como una capa de virtualización entre el hardware y las máquinas virtuales. Algunos ejemplos de hipervisores de tipo 1 son:
  
    * VMware ESXi
    * Microsoft Hyper-V
    * Citrix XenServer
    * KVM (Kernel-based Virtual Machine)
    * Oracle VM Server

  * **Hipervisor de tipo 2 o "hosted"** (Hosted Hypervisor): Este tipo de hipervisor se ejecuta como una aplicación dentro de un sistema operativo anfitrión. Utiliza los recursos y servicios del sistema operativo subyacente para proporcionar la virtualización. Algunos ejemplos de hipervisores de tipo 2 son:
  
    * VMware Workstation
    * Oracle VirtualBox
    * Microsoft Virtual PC
    * Parallels Desktop

* **Máquina virtual (VM)**: Es un entorno virtual que emula una computadora completa con su propio sistema operativo, aplicaciones y configuraciones. Cada VM se ejecuta de forma aislada y puede ser tratada como una entidad independiente.

* **Host**: Es el sistema físico o servidor que ejecuta el hipervisor y aloja las máquinas virtuales.

* **Guest**: Es la máquina virtual que se ejecuta dentro de un host. Puede ser un sistema operativo completo o una instancia de una aplicación específica.

* **Portabilidad**: Las máquinas virtuales son independientes del hardware subyacente, lo que facilita su migración entre diferentes servidores físicos sin necesidad de modificar el sistema operativo o las aplicaciones.

*  **Escalabilidad**: La virtualización permite escalar verticalmente (aumentar los recursos asignados a una VM) o escalar horizontalmente (agregar más VM) según las necesidades de carga de trabajo.

La virtualización se utiliza en diversos entornos, como servidores, redes, almacenamiento y escritorios, proporcionando flexibilidad, eficiencia y mayor aprovechamiento de los recursos informáticos.

Que sus componentes sean virtuales no quiere decir necesariamente que no existan. Por ejemplo, una máquina virtual puede tener unos recursos reservados de 2 GB de RAM y 20 GB de disco duro, que salen del PC donde está instalada la máquina virtual.

Hay varias aplicaciones muy conocidas capaces de hacer esto; las más famosas son VMware, VirtualBox, QEMU, etc.

.. toctree::
   :maxdepth: 1

   virtualbox.rst
   docker.rst
