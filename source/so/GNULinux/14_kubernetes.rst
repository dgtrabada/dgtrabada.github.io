**********
Kubernetes
**********

**Kubernetes**, también conocido como **K8s**, es un sistema de código abierto para automatizar el despliegue, el escalado y la gestión de aplicaciones en contenedores. Lo desarrolló Google a partir de su experiencia con su sistema interno Borg, lo liberó en 2014 y hoy lo mantiene la Cloud Native Computing Foundation (CNCF).

Con Docker arrancamos contenedores en **una** máquina. En cuanto hay varias máquinas aparecen preguntas que Docker solo no contesta: en cuál arranca cada contenedor, qué pasa si esa máquina se apaga, cómo se reparten las peticiones entre diez copias de la misma aplicación o cómo se cambia de versión sin cortar el servicio. A eso se le llama **orquestar** contenedores, y es lo que hace Kubernetes.

La idea central es el **estado deseado**: no le decimos a Kubernetes *qué hacer* («arranca un contenedor aquí»), sino *cómo queremos que estén las cosas* («quiero tres copias de esta aplicación»). Kubernetes compara continuamente lo que hay con lo que se ha pedido y corrige la diferencia: si una copia muere, crea otra; si sobra una, la quita.

Arquitectura de un clúster
--------------------------

Un **clúster** de Kubernetes es un conjunto de máquinas, llamadas **nodos**, que trabajan como una sola. Hay dos papeles:

* El **plano de control** (*control plane*, antes «nodo maestro») toma las decisiones. Lo forman:

  * **kube-apiserver**: la API del clúster. Todo pasa por ella: ``kubectl``, los nodos y los demás componentes solo hablan con el servidor de la API (puerto 6443).
  * **etcd**: la base de datos clave-valor donde se guarda el estado del clúster, es decir, todos los objetos que hemos creado. Si se pierde etcd, se pierde el clúster.
  * **kube-scheduler**: el planificador. Decide en qué nodo arranca cada Pod nuevo, según los recursos libres y las restricciones que se le pongan.
  * **kube-controller-manager**: los controladores, los bucles que comparan el estado deseado con el real y lo corrigen (crear el Pod que falta, marcar como caído el nodo que no responde...).

* Los **nodos de trabajo** (*workers*) ejecutan las aplicaciones. En cada uno hay:

  * **kubelet**: el agente del nodo. Recibe del servidor de la API los Pods que le tocan, los arranca y avisa de cómo están.
  * El **motor de contenedores**: quien de verdad arranca los contenedores. Hoy es **containerd** (el mismo que usa Docker por debajo).
  * **kube-proxy**: mantiene las reglas de red que hacen funcionar los Services.

Además, un **plugin de red** (CNI), como flannel o Calico, da a cada Pod su propia IP y hace que los Pods de distintos nodos se vean entre sí.

.. code-block:: text

                    kubectl
                       |
           +-----------v------------+
           |    Plano de control    |
           |  apiserver    etcd     |
           |  scheduler  controller |
           +-----------+------------+
                       |
        +--------------+--------------+
        |              |              |
   +----v----+    +----v----+    +----v----+
   |  nodo 1 |    |  nodo 2 |    |  nodo 3 |
   | kubelet |    | kubelet |    | kubelet |
   |  Pods   |    |  Pods   |    |  Pods   |
   +---------+    +---------+    +---------+

En el caso práctico el plano de control está en una sola máquina (compute-0-0) y los demás nodos son agentes. En producción el plano de control se reparte entre tres o cinco máquinas para que el clúster siga funcionando si una se cae.

Los objetos y sus ficheros YAML
-------------------------------

Todo lo que hay en un clúster es un **objeto** guardado en etcd: un Pod, un Deployment, un Service... Cada objeto se describe en un fichero **YAML** con cuatro partes que se repiten siempre:

.. code-block:: yaml

  apiVersion: apps/v1        # versión de la API a la que pertenece el tipo de objeto
  kind: Deployment           # tipo de objeto
  metadata:                  # su nombre, su namespace y sus etiquetas
    name: web
    labels:
      app: web
  spec:                      # el estado deseado: cómo queremos que sea
    replicas: 3

Se envía al clúster con ``kubectl apply -f fichero.yml``. Es una orden **declarativa**: si el objeto no existe lo crea, y si existe cambia solo lo que sea distinto. Por eso el mismo comando sirve para crear y para modificar, y por eso los YAML se guardan y se versionan como si fueran código.

Las **etiquetas** (*labels*) son parejas clave-valor que se ponen a los objetos (``app: web``), y los **selectores** son la forma de buscarlos por ellas. Es así como se relacionan los objetos entre sí: un Service no guarda una lista de Pods, sino un selector, y reparte las peticiones entre los Pods que en cada momento lleven esa etiqueta.

Los **namespaces** dividen el clúster en espacios con nombre para separar aplicaciones, equipos o entornos. Si no se indica otro, se trabaja en ``default``; los componentes del propio clúster están en ``kube-system``. Para verlo todo se usa ``-A`` (``kubectl get pods -A``) y para trabajar en uno concreto ``-n <namespace>``.

Pods
----

El **Pod** es la unidad más pequeña que se despliega en Kubernetes: uno o varios contenedores que comparten IP, puertos y volúmenes y que arrancan siempre juntos en el mismo nodo. Lo normal es un contenedor por Pod; se ponen varios solo cuando son inseparables (por ejemplo, la aplicación y un contenedor auxiliar que le recoge los registros).

Un Pod es **desechable**. Tiene una IP propia, pero cuando muere no se repara ni se mueve: se crea otro, con otro nombre y otra IP. Por eso casi nunca se crean Pods sueltos, sino a través de un controlador que los vigila, y por eso nunca se accede a un Pod por su IP, sino a través de un Service.

Dentro del Pod se declara qué imagen ejecutar, qué puertos abre, qué variables de entorno recibe y cuánta CPU y memoria pide (``requests``) o puede usar como máximo (``limits``). También las **sondas** con las que el kubelet comprueba el contenedor:

* **livenessProbe**: ¿sigue vivo? Si falla, el contenedor se reinicia.
* **readinessProbe**: ¿está listo para atender? Mientras falle, el Pod no recibe peticiones, pero no se reinicia.

Deployments
-----------

Un **Deployment** es el controlador con el que se despliega una aplicación sin estado. Se le dice qué Pod queremos (la plantilla, ``template``) y cuántas copias (``replicas``), y él se encarga de que existan:

.. code-block:: yaml

  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: web
  spec:
    replicas: 3
    selector:
      matchLabels:
        app: web            # los Pods que son suyos
    template:               # la plantilla de los Pods
      metadata:
        labels:
          app: web
      spec:
        containers:
          - name: nginx
            image: nginx:alpine
            ports:
              - containerPort: 80

Por debajo crea un **ReplicaSet**, que es quien mantiene el número de copias. De ahí salen tres cosas que veremos funcionando:

* **Autorreparación**: si un Pod muere o su nodo se cae, falta una copia y se crea otra en un nodo que funcione.
* **Escalado**: cambiar ``replicas`` (o ``kubectl scale deployment web --replicas=8``) añade o quita copias. Con un *HorizontalPodAutoscaler* el número cambia solo según la carga.
* **Actualización gradual** (*rolling update*): al cambiar la plantilla, por ejemplo la imagen, se crea un ReplicaSet nuevo y se van sustituyendo los Pods viejos por nuevos de pocos en pocos, sin dejar el servicio sin copias. ``maxSurge`` y ``maxUnavailable`` marcan el ritmo, ``kubectl rollout status`` enseña cómo va y ``kubectl rollout undo`` vuelve a la versión anterior.

Para otros tipos de carga hay otros controladores:

* **StatefulSet**: aplicaciones con estado, como las bases de datos. Los Pods tienen nombre fijo (``db-0``, ``db-1``...) y cada uno su propio almacenamiento.
* **DaemonSet**: una copia del Pod en cada nodo, para agentes de monitorización o de red.
* **Job** y **CronJob**: tareas que empiezan y terminan, una vez o de forma periódica.

Services
--------

Los Pods nacen y mueren, y sus IP cambian. Un **Service** da una dirección estable a un conjunto de Pods, elegidos con un selector, y reparte las peticiones entre los que estén listos:

.. code-block:: yaml

  apiVersion: v1
  kind: Service
  metadata:
    name: web
  spec:
    type: NodePort
    selector:
      app: web              # reparte entre los Pods con esta etiqueta
    ports:
      - port: 80            # puerto del Service
        targetPort: 80      # puerto del contenedor
        nodePort: 30080     # puerto que se abre en todos los nodos

Hay tres tipos principales:

==============  ===========================================================  ================================
Tipo            Qué hace                                                     Desde dónde se llega
==============  ===========================================================  ================================
ClusterIP       Da al Service una IP interna del clúster. Es el tipo por     Solo desde dentro del clúster
                defecto.
NodePort        Además, abre el mismo puerto (30000-32767) en todos los      Desde fuera, con la IP de
                nodos.                                                       cualquier nodo y ese puerto
LoadBalancer    Además, pide una IP pública a un balanceador externo         Desde fuera, con una IP pública
                (el del proveedor de nube).
==============  ===========================================================  ================================

Dentro del clúster hay un **DNS interno** (CoreDNS) que resuelve cada Service por su nombre: desde cualquier Pod, ``http://web`` llega al Service ``web`` del mismo namespace, y ``web.otro-namespace.svc.cluster.local`` al de otro.

Ingress
-------

Un Service de tipo NodePort o LoadBalancer publica **una** aplicación por un puerto. Un **Ingress** publica **muchas** por el mismo puerto 80 o 443, repartiéndolas por **nombre de host** o por **ruta** (``tienda.ejemplo.com``, ``ejemplo.com/blog``), y puede encargarse también del HTTPS. Trabaja en la capa HTTP: es el equivalente a los *virtual hosts* de Apache.

El Ingress es solo la regla. Quien la aplica es un **controlador de Ingress**, un proxy inverso que corre dentro del clúster (Traefik, NGINX, HAProxy...) y que hay que tener instalado; k3s trae Traefik. Su sucesor es la **Gateway API**, que reparte esas mismas funciones en varios objetos.

Configuración: ConfigMap y Secret
---------------------------------

La configuración no debe ir dentro de la imagen: la misma imagen tiene que servir para desarrollo y para producción. Kubernetes la guarda en dos tipos de objeto:

* **ConfigMap**: configuración que no es secreta, como parejas clave-valor o ficheros enteros.
* **Secret**: contraseñas, tokens y certificados. Se usa igual que un ConfigMap, pero el valor se guarda codificado en **base64**. Base64 **no es cifrado**: cualquiera con permiso para leer el Secret puede descodificarlo. Lo que protege un Secret son los permisos sobre el objeto y, si se activa, el cifrado de etcd.

Los dos llegan al contenedor de dos maneras: como **variables de entorno** o como **ficheros** montados en un directorio. Un cambio en el ConfigMap o en el Secret no reinicia los Pods: las variables de entorno se leen al arrancar, así que hay que recrearlos (``kubectl rollout restart``).

Almacenamiento
--------------

El sistema de archivos de un contenedor desaparece con él. Para guardar datos se monta un **volumen**, y si los datos tienen que sobrevivir al Pod, un volumen **persistente**, que se describe con tres objetos:

* **PersistentVolume (PV)**: un trozo de almacenamiento real (una exportación NFS, un disco de la nube...). Lo da de alta el administrador.
* **PersistentVolumeClaim (PVC)**: la petición de una aplicación («necesito 1 GiB en el que puedan escribir varios Pods»). Kubernetes la **enlaza** (*Bound*) con un PV que la cumpla, y el Pod monta el PVC sin saber qué hay detrás.
* **StorageClass**: un tipo de almacenamiento capaz de crear los PV él solo cuando llega un PVC (aprovisionamiento dinámico), sin que el administrador los prepare uno a uno.

Los **modos de acceso** dicen cuántos nodos pueden montar el volumen a la vez: ``ReadWriteOnce`` (uno solo) o ``ReadWriteMany`` (varios, como permite un NFS).

Helm
----

Una aplicación real son muchos objetos: Deployments, Services, ConfigMaps, Secrets, PVC... **Helm** es el gestor de paquetes de Kubernetes: lo que ``apt`` es a Ubuntu. Empaqueta todos los YAML de una aplicación en un **chart**, con plantillas en las que los valores que cambian (número de copias, imagen, contraseñas) se sacan a un fichero ``values.yaml``. Cada instalación de un chart es una **release**, que se puede actualizar y devolver a una versión anterior, y los charts se publican en **repositorios**, de donde se instalan aplicaciones ya hechas con una orden.

Formas de instalar Kubernetes
-----------------------------

Kubernetes es un conjunto de componentes, y hay muchas maneras de juntarlos:

* **kubeadm**: la herramienta oficial para montar un clúster en nuestras máquinas. Es la instalación «completa»: hay que preparar cada nodo a mano.
* **k3s**: una distribución ligera y certificada, en un solo binario, que trae ya el motor de contenedores, la red y un Ingress. Es la que usamos en el caso práctico.
* **minikube** y **kind**: un clúster dentro de una sola máquina, para aprender y para desarrollar.
* **Kubernetes gestionado**: el proveedor de nube lleva el plano de control y nosotros solo ponemos los nodos (GKE de Google, EKS de Amazon, AKS de Microsoft).

En todos los casos los YAML y los comandos de ``kubectl`` son los mismos.

kubectl
-------

``kubectl`` es el cliente de línea de comandos: habla con el servidor de la API usando la dirección y las credenciales del fichero *kubeconfig* (``~/.kube/config``, o el que indique la variable ``KUBECONFIG``). Casi todo se hace con unas pocas órdenes:

============================================  ==================================================================
Comando                                       Para qué sirve
============================================  ==================================================================
``kubectl get nodes``                         Lista los nodos del clúster y su estado
``kubectl get pods -o wide``                  Lista los Pods, con su IP y el nodo en el que están
``kubectl get all``                           Lista Pods, Deployments, Services... del namespace
``kubectl apply -f fichero.yml``              Crea o actualiza los objetos descritos en el fichero
``kubectl delete -f fichero.yml``             Borra los objetos descritos en el fichero
``kubectl describe pod <pod>``                Detalle de un objeto y sus últimos eventos: lo primero que hay
                                              que mirar cuando un Pod no arranca
``kubectl logs <pod>``                        Salida del contenedor (``-f`` para seguirla)
``kubectl exec -it <pod> -- sh``              Abre una terminal dentro del contenedor
``kubectl scale deployment <d> --replicas``   Cambia el número de copias
``kubectl rollout status deployment <d>``     Sigue una actualización (``undo`` la deshace, ``restart``
                                              recrea los Pods)
``kubectl get events``                        Lo que ha ido pasando en el clúster
============================================  ==================================================================

Los estados más habituales de un Pod son ``Pending`` (aún no tiene nodo o no ha arrancado), ``ContainerCreating`` (descargando la imagen o montando volúmenes), ``Running``, ``Completed`` y los de error: ``ImagePullBackOff`` (no puede descargar la imagen) y ``CrashLoopBackOff`` (el contenedor arranca y se muere una y otra vez).

Casos prácticos de Kubernetes
-----------------------------

Todo lo anterior se ve funcionando en dos casos prácticos, que van seguidos sobre el mismo clúster:

* :doc:`14_kubernetes_k3s`: montamos el clúster y desplegamos una aplicación con Deployment, Service, Ingress, ConfigMap, Secret y almacenamiento en NFS.
* :doc:`14_kubernetes_helm`: empaquetamos la aplicación con Helm e instalamos MinIO, Prometheus y Grafana.

.. toctree::
   :hidden:

   14_kubernetes_k3s.rst
   14_kubernetes_helm.rst
