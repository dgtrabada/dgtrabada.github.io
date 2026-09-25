**********
Kubernetes
**********

También conocido como **K8s** es un sistema open-source para la automatización del despliegue, escalado y gestión de aplicaciones en contenedores.

Fue desarrollado originalmente por Google y ahora es mantenido por la Cloud Native Computing Foundation (CNCF).

Partes Principales
------------------

- **Nodo (Node)**:

  - **Nodos Maestro (Master Nodes)**: Administran el clúster y toman decisiones sobre la gestión del clúster.
  - **Nodos de Trabajo (Worker Nodes)**: Ejecutan las aplicaciones en contenedores.

- **Pod**:
  - La unidad de despliegue más pequeña en Kubernetes, que puede contener uno o varios contenedores.

- **Controlador (Controller)**: Mantienen el estado deseado del clúster. Tipos de controladores incluyen:
    
  - **Deployment**: Administra la creación y escalado de un conjunto de pods.
  - **ReplicaSet**: Asegura que un número específico de pods estén corriendo.
  - **StatefulSet**: Administra la persistencia y el orden de los pods.
  - **DaemonSet**: Asegura que todos (o algunos) nodos ejecuten una copia de un pod.

- **Servicio (Service)**: Define un conjunto lógico de pods y una política para acceder a ellos. Tipos de servicios incluyen:

  - **ClusterIP**: Expone el servicio en una IP interna del clúster.
  - **NodePort**: Expone el servicio en el mismo puerto en cada nodo del clúster.
  - **LoadBalancer**: Utiliza un balanceador de carga externo.

- **ConfigMap y Secret**:

  - **ConfigMap**: Separa la configuración estática del código de la aplicación.
  - **Secret**: Almacena y gestiona información sensible.

- **Volumen (Volume)**: Permiten el almacenamiento persistente de datos en los contenedores.

- **Ingress**: Gestiona el acceso externo a los servicios en un clúster, típicamente mediante HTTP.

- **Namespace**: Divide un clúster de Kubernetes en secciones virtuales para separar ambientes como desarrollo, testing y producción.

Funcionamiento Básico
---------------------

1. **Planificación**: El planificador asigna pods a los nodos de trabajo basándose en la disponibilidad de recursos.

2. **Orquestación y Gestión**: Kubernetes garantiza que la aplicación esté en el estado deseado y reprograma pods en caso de fallos.

3. **Escalado**: Kubernetes puede escalar automáticamente la cantidad de instancias de una aplicación.

4. **Mantenimiento y Actualización**: Kubernetes permite actualizaciones sin tiempo de inactividad mediante controladores como Deployment que gestionan actualizaciones de manera gradual.


Caso práctico: un clúster Kubernetes con k3s
--------------------------------------------

Montamos ahora un clúster de verdad con **k3s**, la distribución ligera de Kubernetes de Rancher: un único binario de unos 70 MB que trae dentro el servidor de la API, el planificador, containerd, flannel y un Ingress (Traefik) ya instalados. Es Kubernetes certificado —los comandos y los ficheros YAML son exactamente los mismos que con la instalación completa de **kubeadm**— pero cabe en una máquina virtual modesta y se instala con una orden.

Partimos de **cuatro máquinas virtuales limpias**, clones enlazados de **MV Ubuntu Server**, con **4 GB de memoria cada una** y la red de siempre. Con 2 GB el clúster arranca, pero se queda sin sitio en cuanto se le añade algo, así que dáselos ahora y te ahorras rehacerlo a mitad del tema:

* **compute-0-0** (será el **servidor** del clúster y dará salida a Internet a los demás)

  * Tarjeta red modo "Red Nat 10.0.2.10/24 utiliza el puerto 2222 del anfitrión al 22 y el puerto 30080 al 30080"
  * Tarjeta de red modo "Red interna" : 172.16.0.10/16

* **compute-0-1** (**agente**)

  * Tarjeta de red modo "Red interna" : 172.16.0.11/16 (tiene internet a través de compute-0-0)

* **compute-0-2** (**agente**)

  * Tarjeta de red modo "Red interna" : 172.16.0.12/16 (tiene internet a través de compute-0-0)

* **compute-0-3** (**agente**)

  * Tarjeta de red modo "Red interna" : 172.16.0.13/16 (tiene internet a través de compute-0-0)

El clúster
^^^^^^^^^^

La instalación «oficial» de Kubernetes, con **kubeadm**, exige además desactivar la swap, cargar el módulo ``br_netfilter``, activar el enrutado IP y configurar containerd a mano. Con k3s no hace falta nada de eso: el enrutado IP ya está puesto desde que compute-0-0 hace de router para la red interna, el módulo ``br_netfilter`` lo carga el propio instalador, y ni siquiera hay que quitar la swap, porque su kubelet no la rechaza.

En **compute-0-0** instalamos el servidor. El instalador descarga el binario, crea los enlaces a ``kubectl``, ``crictl`` y ``ctr``, y deja un servicio de systemd arrancado y habilitado:

.. code-block:: bash

  root@compute-0-0:~# curl -sfL https://get.k3s.io | sh -
  [INFO]  Finding release for channel stable
  [INFO]  Using v1.36.4+k3s1 as release
  [INFO]  Downloading binary https://github.com/k3s-io/k3s/releases/download/v1.36.4%2Bk3s1/k3s
  [INFO]  Verifying binary download
  [INFO]  Installing k3s to /usr/local/bin/k3s
  [INFO]  Creating /usr/local/bin/kubectl symlink to k3s
  [INFO]  Creating /usr/local/bin/crictl symlink to k3s
  [INFO]  Creating /usr/local/bin/ctr symlink to k3s
  [INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
  [INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
  [INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
  [INFO]  systemd: Enabling k3s unit
  [INFO]  systemd: Starting k3s

  root@compute-0-0:~# systemctl is-active k3s
  active
  root@compute-0-0:~# systemctl is-enabled k3s
  enabled

Al cabo de medio minuto ya hay un nodo. Y aquí aparece el primer problema, porque **compute-0-0 tiene dos tarjetas**:

.. code-block:: bash

  root@compute-0-0:~# kubectl get nodes -o wide
  NAME          STATUS   ROLES           AGE   VERSION        INTERNAL-IP   OS-IMAGE
  compute-0-0   Ready    control-plane   48s   v1.36.4+k3s1   10.0.2.10     Ubuntu 26.04.1 LTS

k3s ha elegido la **primera tarjeta**, la de la Red NAT, como dirección del nodo: 10.0.2.10. Esa no vale: es una dirección que puede cambiar y que los agentes de la red interna no alcanzan. El clúster tiene que vivir en la **red interna**, así que desinstalamos y repetimos diciéndole por dónde:

.. code-block:: bash

  root@compute-0-0:~# /usr/local/bin/k3s-uninstall.sh
  root@compute-0-0:~# curl -sfL https://get.k3s.io | \
    INSTALL_K3S_EXEC="--node-ip 172.16.0.10 --flannel-iface enp0s8" sh -

  root@compute-0-0:~# kubectl get nodes -o wide
  NAME          STATUS   ROLES           AGE   VERSION        INTERNAL-IP   OS-IMAGE
  compute-0-0   Ready    control-plane   26s   v1.36.4+k3s1   172.16.0.10   Ubuntu 26.04.1 LTS

``--node-ip`` es la dirección con la que el nodo se anuncia y ``--flannel-iface`` la tarjeta por la que viaja la red interna de los contenedores. Comprueba con ``ip a`` cuál es el nombre de tu tarjeta interna: aquí es **enp0s8**.

Antes de tocar los agentes, recupera el **masquerade** de compute-0-0:

.. code-block:: bash

  root@compute-0-0:~# systemctl restart nftables
  root@compute-0-0:~# nft list table ip nat | grep masquerade
    oifname "enp0s3" ip saddr 172.16.0.0/16 masquerade

Al instalar k3s, que programa sus propias reglas, se ha perdido la regla de ``/etc/nftables.conf`` que da salida a Internet a la red interna, y sin ella los agentes no pueden descargarse el instalador. Tenlo en cuenta cada vez que toques el cortafuegos del servidor.

Los agentes se unen con la dirección del servidor y un **token** que k3s ha generado al instalarse:

.. code-block:: bash

  root@compute-0-0:~# cat /var/lib/rancher/k3s/server/node-token
  K106e38f07428bc61c0645f6ba3fe0...::server:6e0f...

Ese token son cien caracteres que no apetece copiar a mano de una máquina a otra, así que lanzamos la instalación de los tres agentes **desde compute-0-0 por ssh**, como ya hacíamos en la tarea de Ansible:

.. code-block:: bash

  root@compute-0-0:~# for n in compute-0-1 compute-0-2 compute-0-3; do
      ssh -n $n "curl -fL https://get.k3s.io | \
        K3S_URL=https://172.16.0.10:6443 \
        K3S_TOKEN='$(cat /var/lib/rancher/k3s/server/node-token)' sh -"
    done
  [INFO]  systemd: Enabling k3s-agent unit
  [INFO]  systemd: Starting k3s-agent

El truco está en las **comillas**: el ``$(cat ...)`` va dentro de comillas dobles, así que lo resuelve compute-0-0 **antes** de mandar la orden, y al agente le llega el token ya escrito. Las comillas simples de dentro viajan tal cual y protegen el valor en la otra máquina.

Fíjate en que el servicio aquí se llama **k3s-agent**, no k3s. El registro contra el servidor se ve en su diario:

.. code-block:: bash

  root@compute-0-1:~# journalctl -u k3s-agent | grep -i "Successfully registered"

Desde el servidor ya tenemos el clúster entero:

.. code-block:: bash

  root@compute-0-0:~# kubectl get nodes
  NAME          STATUS   ROLES           AGE     VERSION
  compute-0-0   Ready    control-plane   2d19h   v1.36.4+k3s1
  compute-0-1   Ready    <none>          2d19h   v1.36.4+k3s1
  compute-0-2   Ready    <none>          2d19h   v1.36.4+k3s1
  compute-0-3   Ready    <none>          2d19h   v1.36.4+k3s1

Si ``kubectl get nodes`` contesta, están funcionando el servidor de la API, containerd y la red. Que ``is-enabled`` diga **enabled** es lo que garantiza que el clúster vuelva solo después de apagar las máquinas.

Y lo que k3s trae dentro, que debe estar ``Running`` o ``Completed``:

.. code-block:: bash

  root@compute-0-0:~# kubectl get pods -n kube-system
  NAME                                      READY   STATUS      RESTARTS   AGE
  coredns-...                               1/1     Running     0          2d19h
  local-path-provisioner-...                1/1     Running     0          2d19h
  metrics-server-...                        1/1     Running     0          2d19h
  helm-install-traefik-crd-...              0/1     Completed   0          2d19h
  helm-install-traefik-...                  0/1     Completed   1          2d19h
  svclb-traefik-...-<uno por nodo>          1/1     Running     0          2d19h
  traefik-...                               1/1     Running     0          2d19h

Estos son los servicios que en una instalación con kubeadm habría que ir montando a mano: **coredns** es el DNS interno del clúster, **traefik** el Ingress con el que publicaremos la aplicación por nombre, **local-path-provisioner** el almacenamiento local que usaremos al final del tema, **metrics-server** el que da los datos a ``kubectl top``, y **svclb-traefik** el repartidor que pone una copia en cada nodo. Los dos ``helm-install`` son tareas de un solo uso: instalaron Traefik al arrancar y por eso salen ``Completed`` y no ``Running``.

En cada **agente**, el servicio se llama ``k3s-agent``:

.. code-block:: bash

  root@compute-0-1:~# systemctl is-active k3s-agent
  active
  root@compute-0-1:~# systemctl is-enabled k3s-agent
  enabled
  root@compute-0-1:~# journalctl -u k3s-agent | grep -i "Starting k3s agent"

En los agentes **no** hay ``kubectl`` ni credenciales: si lo ejecutas ahí da un error de conexión y parece que el clúster está roto cuando no lo está.

Desplegar y exponer una aplicación
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Hasta ahora, para publicar una web instalábamos un servidor, copiábamos los ficheros y arrancábamos un servicio. En Kubernetes **se describe el resultado** en un fichero YAML y el clúster se encarga del resto. Creamos ``web-tunombre.yml`` con tres objetos:

* un **ConfigMap** con la página,
* un **Deployment** que pide 4 copias de nginx con esa página montada,
* y un **Service** de tipo NodePort que la publica en el puerto 30080 de los cuatro nodos.

.. code-block:: yaml

  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: web-tunombre-html
  data:
    index.html: |
      <!DOCTYPE html>
      <html>
      <head><title>web-tunombre</title></head>
      <body>
        <h1>Hola, soy tunombre</h1>
        <p>Servida por Kubernetes (k3s) en el IES</p>
      </body>
      </html>
  ---
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: web-tunombre
  spec:
    replicas: 4
    selector:
      matchLabels:
        app: web-tunombre
    template:
      metadata:
        labels:
          app: web-tunombre
      spec:
        containers:
          - name: nginx
            image: nginx:alpine
            ports:
              - containerPort: 80
            volumeMounts:
              - name: html
                mountPath: /usr/share/nginx/html
        volumes:
          - name: html
            configMap:
              name: web-tunombre-html
  ---
  apiVersion: v1
  kind: Service
  metadata:
    name: web-tunombre
  spec:
    type: NodePort
    selector:
      app: web-tunombre
    ports:
      - port: 80
        targetPort: 80
        nodePort: 30080

Las **etiquetas** son lo que une las tres piezas: el Deployment pone ``app: web-tunombre`` a cada copia y el Service reparte entre todo lo que lleve esa etiqueta. No hay ninguna lista de máquinas en ningún sitio.

.. code-block:: bash

  root@compute-0-0:~# kubectl apply -f web-tunombre.yml
  configmap/web-tunombre-html created
  deployment.apps/web-tunombre created
  service/web-tunombre created

  root@compute-0-0:~# kubectl get pods -o wide
  NAME                           READY   STATUS    RESTARTS   AGE   IP          NODE
  web-tunombre-c6bf74bfb-7d9dj   1/1     Running   0          25s   10.42.2.3   compute-0-2
  web-tunombre-c6bf74bfb-w45md   1/1     Running   0          25s   10.42.0.9   compute-0-0
  web-tunombre-c6bf74bfb-zdzcm   1/1     Running   0          25s   10.42.1.3   compute-0-1
  web-tunombre-c6bf74bfb-q8k4n   1/1     Running   0          25s   10.42.3.2   compute-0-3

  root@compute-0-0:~# kubectl get services
  NAME           TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
  web-tunombre   NodePort   10.43.65.96   <none>        80:30080/TCP   26s

El planificador ha repartido una copia en cada máquina sin que se lo pidamos. Cada **Pod** tiene su propia dirección de la red interna de contenedores (10.42.X.Y), que el clúster crea con flannel por encima de nuestra 172.16.0.0/16.

Con NodePort la aplicación responde en el puerto 30080 de **cualquiera** de los nodos, aunque ahí no haya ninguna copia:

.. code-block:: bash

  root@compute-0-2:~# curl -s http://172.16.0.11:30080
  <!DOCTYPE html>
  <html>
  <head><title>web-tunombre</title></head>
  <body>
    <h1>Hola, soy tunombre</h1>
    <p>Servida por Kubernetes (k3s) en el IES</p>
  </body>
  </html>

Para ver qué está pasando, tres comandos que usarás constantemente:

.. code-block:: bash

  kubectl get all -o wide                     # todo de un vistazo
  kubectl describe pod web-tunombre-c6bf74bfb-7d9dj   # por qué un Pod no arranca
  kubectl logs web-tunombre-c6bf74bfb-7d9dj          # la salida del contenedor

Publicar con un nombre: el Ingress
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Acceder por «la IP de un nodo y el puerto 30080» no es como se publica un servicio de verdad. Un **Ingress** publica la aplicación por **nombre** en el puerto 80, y k3s ya trae instalado el controlador que lo hace, **Traefik**:

.. code-block:: bash

  root@compute-0-0:~# kubectl get svc -n kube-system traefik
  NAME      TYPE           CLUSTER-IP     EXTERNAL-IP                           PORT(S)
  traefik   LoadBalancer   10.43.84.167   172.16.0.10,172.16.0.11,172.16.0.12   80:32524/TCP,443:30869/TCP

``ingress-tunombre.yml``:

.. code-block:: yaml

  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: web-tunombre
  spec:
    rules:
      - host: web-tunombre.local
        http:
          paths:
            - path: /
              pathType: Prefix
              backend:
                service:
                  name: web-tunombre
                  port:
                    number: 80

Como ``web-tunombre.local`` no existe en ningún DNS, lo añadimos al ``/etc/hosts`` **de los cuatro nodos**:

.. code-block:: bash

  root@compute-0-0:~# echo "172.16.0.10 web-tunombre.local" >> /etc/hosts

  root@compute-0-0:~# kubectl apply -f ingress-tunombre.yml
  ingress.networking.k8s.io/web-tunombre created

  root@compute-0-0:~# kubectl get ingress
  NAME           CLASS     HOSTS                ADDRESS                               PORTS   AGE
  web-tunombre   traefik   web-tunombre.local   172.16.0.10,172.16.0.11,172.16.0.12   80      13s

  root@compute-0-0:~# curl -s http://web-tunombre.local | head -4
  <!DOCTYPE html>
  <html>
  <head><title>web-tunombre</title></head>
  <body>

Ahora la aplicación se pide por su nombre y en el puerto 80, como cualquier web. Y en la misma dirección caben muchas aplicaciones: el Ingress mira la cabecera ``Host:`` y decide a cuál va cada petición.

Hasta aquí hemos entrado siempre desde dentro del clúster. Desde el **navegador del anfitrión** también se ve, sin entrar en ninguna máquina, gracias al reenvío de puertos de la Red NAT que pusimos al principio (el 30080 del anfitrión al 30080 de compute-0-0):

.. code-block:: bash

  http://<ip-del-anfitrión>:30080

Eso entra por el **NodePort**, no por el Ingress: es la misma aplicación, pero pedida por IP y puerto en lugar de por nombre. El nombre ``web-tunombre.local`` solo lo entienden los nodos, que son los que lo tienen en su ``/etc/hosts``.

Cambiar la página sin entrar en ninguna máquina
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ya tienes la web delante en el navegador, así que la siguiente pregunta es la de siempre: **¿dónde se toca esto para cambiarlo?** En un servidor de toda la vida entrarías por ssh y editarías el ``index.html``. Aquí no, y el propio sistema te lo impide. Los volúmenes de ConfigMap se montan en **sólo lectura**, y menos mal: estarías cambiando **una** copia de cuatro, y el cambio se perdería en cuanto ese Pod muriera. La página no vive en ningún contenedor, vive en el **ConfigMap**, y ahí es donde se toca:

El ConfigMap está dentro de ``web-tunombre.yml``, así que se edita **ahí**, en el fichero, y se vuelve a aplicar. Añádele a la página una línea con la **hora a la que haces el cambio**, que es la forma de saber qué versión estás viendo:

.. code-block:: html

  <h1>Hola, soy tunombre</h1>
  <p>Cambiado a <hora dia y mes></p>

Escribe la hora, el día y el mes de verdad, por ejemplo ``Cambiado a 13:00 3 sept``. Es lo que te va a decir si lo que estás viendo en el navegador es tu cambio o todavía el de antes.

.. code-block:: bash

  root@compute-0-0:~# kubectl apply -f web-tunombre.yml
  configmap/web-tunombre-html configured


Y ahora recarga el navegador. **No habrá cambiado todavía**, y eso no es un fallo. El kubelet de cada nodo va refrescando cada poco los ficheros que vienen de un ConfigMap, así que el cambio tarda **hasta un minuto** en aparecer. Comparando la hora que escribiste con la hora en la que sale, se mide exactamente lo que ha tardado. Si recargas a los dos segundos y ves lo de antes, es que has ido más rápido que el clúster.

Lo importante es lo que ha pasado mientras tanto: han cambiado **las cuatro copias a la vez**, sin reiniciar nada, sin entrar en ninguna máquina y sin que importe en qué nodo esté cada una. Has cambiado un objeto, no unos servidores.

Escalabilidad y autorreparación
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Todo lo que viene ahora se ve mucho mejor **en vivo**, así que abre una **segunda terminal** contra compute-0-0 y déjala con **k9s**, una consola que enseña el clúster y lo va refrescando solo:

.. code-block:: bash

  root@compute-0-0:~# curl -sL https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.deb -o /tmp/k9s.deb
  root@compute-0-0:~# apt install -y /tmp/k9s.deb

  root@compute-0-0:~# k9s
  ... Unable to connect to context ...

``kubectl`` encuentra solo las credenciales del clúster porque es el propio binario de k3s, pero **k9s no**: busca ``~/.kube/config``, que en k3s **no existe**, porque las credenciales están en ``/etc/rancher/k3s/k3s.yaml``. Se lo decimos con la variable ``KUBECONFIG``, y lo dejamos puesto en el ``~/.bashrc`` para no tener que repetirlo:

.. code-block:: bash

  root@compute-0-0:~# echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
  root@compute-0-0:~# bash
  root@compute-0-0:~# echo $KUBECONFIG
  /etc/rancher/k3s/k3s.yaml
  root@compute-0-0:~# k9s

Con eso, la máquina queda como cualquier otro cliente de Kubernetes, y la variable vale igual para ``helm`` o para cualquier otra herramienta que necesite las credenciales.

Dentro de k9s, con unas pocas teclas tienes bastante:

* ``0`` — muestra todos los *namespaces*.
* ``:pods`` y ``:nodes`` — cambian de vista.
* ``l`` — saca los registros del Pod señalado.
* ``d`` — su descripción.
* ``Ctrl-D`` — lo borra, muy a mano para la prueba de autorreparación de aquí abajo.
* ``:q`` — sale.

Con esa terminal a la vista, en la primera pedir más copias es cambiar un número:

.. code-block:: bash

  root@compute-0-0:~# kubectl scale deployment web-tunombre --replicas=8
  deployment.apps/web-tunombre scaled

  root@compute-0-0:~# kubectl get pods -o custom-columns=NODO:.spec.nodeName --no-headers | sort | uniq -c
        2 compute-0-0
        2 compute-0-1
        2 compute-0-2
        2 compute-0-3

Y si se pierde una copia, el clúster la repone **sin que nadie haga nada**:

.. code-block:: bash

  root@compute-0-0:~# kubectl delete pod web-tunombre-c6bf74bfb-5v2ld
  pod "web-tunombre-c6bf74bfb-5v2ld" deleted from default namespace

  root@compute-0-0:~# kubectl get pods --no-headers | wc -l
  8

El clúster compara sin parar **lo que hay** con **lo que pediste**, y arregla la diferencia.

Qué pasa cuando se cae una máquina
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Esto es lo que de verdad distingue a Kubernetes de todo lo anterior, y conviene verlo con reloj. Apaga **compute-0-2** entera desde VirtualBox, con las ocho copias repartidas 2/2/2/2, y ve mirando:

.. code-block:: bash

  root@compute-0-0:~# kubectl get nodes
  root@compute-0-0:~# kubectl get pods -o wide

Pausamos compute-0-2. En **menos de un minuto** el clúster se da cuenta de que ese nodo ha dejado de dar señales, pero **los Pods siguen exactamente donde estaban**:

.. code-block:: bash

  root@compute-0-0:~# kubectl get nodes
  NAME          STATUS     ROLES           AGE     VERSION
  compute-0-0   Ready      control-plane   4d22h   v1.36.4+k3s1
  compute-0-1   Ready      <none>          4d21h   v1.36.4+k3s1
  compute-0-2   NotReady   <none>          4d21h   v1.36.4+k3s1
  compute-0-3   Ready      <none>          4d21h   v1.36.4+k3s1

  root@compute-0-0:~# kubectl get pods -o custom-columns=NODO:.spec.nodeName --no-headers | sort | uniq -c
        2 compute-0-0
        2 compute-0-1
        2 compute-0-2
        2 compute-0-3

No es un error: el clúster ha dejado de recibir noticias de ese nodo, pero **no sabe si la máquina está apagada o es la red la que falla**, y arrancar copias nuevas de algo que quizá sigue vivo puede ser peor. Así que espera cinco minutos antes de tocar nada.

A los **seis minutos** toma la decisión, y a partir de aquí hay que mirar la salida entera, no un recuento:

.. code-block:: bash

  root@compute-0-0:~# kubectl get pods -o wide
  ... PENDIENTE: las diez lineas, con los Terminating en compute-0-2 ...

Aparecen **diez** Pods donde pediste ocho: ha recreado las dos copias perdidas en las máquinas que quedan —vuelven a estar las ocho pedidas— y ha marcado las viejas como ``Terminating``. Se quedarán así mientras el nodo no vuelva, porque nadie puede confirmar que se hayan parado.

.. note::

  Ese ``Terminating`` no sale en el recuento de antes, y no es un fallo del comando: **no es un estado que exista en el objeto**, lo calcula ``kubectl`` al ver que el Pod tiene puesta la fecha de borrado. Por dentro sigue diciendo ``Running``. Por eso, en esta prueba, la salida completa de ``kubectl get pods -o wide`` enseña más que cualquier recuento.

Al **volver a encender** compute-0-2, el nodo pasa a ``Ready`` en menos de un minuto, los ``Terminating`` desaparecen... y las copias **no vuelven**:

.. code-block:: bash

  root@compute-0-0:~# kubectl get nodes
  NAME          STATUS   ROLES           AGE     VERSION
  compute-0-0   Ready    control-plane   4d22h   v1.36.4+k3s1
  compute-0-1   Ready    <none>          4d21h   v1.36.4+k3s1
  compute-0-2   Ready    <none>          4d21h   v1.36.4+k3s1
  compute-0-3   Ready    <none>          4d21h   v1.36.4+k3s1

  root@compute-0-0:~# kubectl get pods -o custom-columns=NODO:.spec.nodeName --no-headers | sort | uniq -c
        2 compute-0-0
        3 compute-0-1
        3 compute-0-3

Siguen siendo ocho copias, pero repartidas **2 / 3 / 3**: las dos que se perdieron con el nodo renacieron en compute-0-1 y compute-0-3, y ahí se han quedado. Fíjate en que **compute-0-2 ni siquiera aparece** en la lista: está ``Ready``, dentro del clúster y listo para recibir trabajo, pero sin una sola copia.

Kubernetes garantiza que haya **ocho copias**, no que estén repartidas a partes iguales: mover algo que ya funciona no aporta nada y sí arriesga. Nada va a reequilibrarlo solo; el reparto se recupera según vayan muriendo y naciendo Pods.

Y eso se puede provocar. Mata una copia de uno de los nodos que tienen tres y mira dónde nace la siguiente:

.. code-block:: bash

  root@compute-0-0:~# kubectl delete pod <una copia de compute-0-1>

El planificador elige **por hueco**, así que la nueva se va a compute-0-2, que está a cero. Repitiendo con una de compute-0-3 vuelves a tener las ocho repartidas. Y si quieres hacerlo de una vez, ``kubectl rollout restart deployment web-tunombre`` recrea las ocho de pocas en pocas y las vuelve a colocar, que es lo que harías en un sistema de verdad porque no corta el servicio.

Actualizar sin cortar el servicio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Cambiar la versión de la aplicación es cambiar la imagen del Deployment, y Kubernetes va sustituyendo las copias **de pocas en pocas**. La pregunta es si durante ese cambio **se pierde alguna petición**, y para poder contestarla hay que medir **antes**, con la aplicación quieta: trescientas peticiones seguidas, contando por código de respuesta.

.. code-block:: bash

  root@compute-0-0:~# for i in $(seq 1 300); do
    curl -s -o /dev/null -w "%{http_code}\n" --max-time 5 http://web-tunombre.local
    sleep 0.2
  done | sort | uniq -c

Sin tocar nada contestan las trescientas, como tenía que ser. Ese es el punto de partida: ahora actualizamos la imagen y, **mientras se actualiza**, repetimos exactamente la misma medición desde otra terminal para comparar. ``rollout status`` cuenta el proceso:

.. code-block:: bash

  root@compute-0-0:~# kubectl set image deployment/web-tunombre nginx=nginx:1.29-alpine
  deployment.apps/web-tunombre image updated

  root@compute-0-0:~# kubectl rollout status deployment/web-tunombre
  Waiting for deployment "web-tunombre" rollout to finish: 7 out of 8 new replicas have been updated...
  Waiting for deployment "web-tunombre" rollout to finish: 2 old replicas are pending termination...
  Waiting for deployment "web-tunombre" rollout to finish: 7 of 8 updated replicas are available...
  deployment "web-tunombre" successfully rolled out

Y si la versión nueva no sirve, se vuelve atrás con un comando:

.. code-block:: bash

  root@compute-0-0:~# kubectl rollout history deployment web-tunombre
  REVISION  CHANGE-CAUSE
  1         <none>
  3         <none>
  4         <none>

  root@compute-0-0:~# kubectl rollout undo deployment/web-tunombre
  deployment.apps/web-tunombre rolled back

Y aquí está la diferencia. El mismo bucle de antes, lanzado en otra terminal mientras el cambio está en marcha, ya no da lo mismo: con el Deployment tal como lo hemos escrito, el resultado **no es perfecto**:

.. code-block:: bash

      1 000
    297 200
      2 502

Los ``502`` son peticiones que Traefik mandó a una copia que ya se estaba apagando, y los ``000`` conexiones cortadas a medias. Kubernetes no sabe cuándo un contenedor **está listo** ni cuándo **ha terminado de atender** lo que tenía entre manos, y hay que decírselo con tres cosas:

* una **readinessProbe**: hasta que la página no conteste, esa copia no recibe tráfico;
* ``maxUnavailable: 0``: no quites una copia vieja hasta tener una nueva lista;
* y un **preStop**, una pausa antes de apagar la copia vieja, para que le dé tiempo a salir de la lista de destinos.

Las tres van en el **Deployment de** ``web-tunombre.yml``, que ya tienes escrito: no es un objeto nuevo. **Lo resaltado es lo que hay que añadir o cambiar**; el resto está solo para situar el sitio y la sangría:

.. code-block:: yaml
  :emphasize-lines: 3-7,13-21

  # web-tunombre.yml, en el Deployment
  spec:
    replicas: 8
    strategy:
      rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 0
    template:
      spec:
        containers:
          - name: nginx
            image: nginx:alpine
            readinessProbe:
              httpGet:
                path: /
                port: 80
              periodSeconds: 2
            lifecycle:
              preStop:
                exec:
                  command: ["sleep", "5"]

Y aprovecha para poner las **ocho** réplicas en el fichero: el ``kubectl scale`` de antes cambió el clúster pero no el YAML, así que si lo aplicas tal como está te bajaría otra vez al número viejo. Después, ``kubectl apply -f web-tunombre.yml``, y repitiendo la misma prueba, ahora sí:

.. code-block:: bash

    300 200

Merece la pena verlo por pasos, porque explica para qué sirve cada ajuste:

.. list-table::
  :header-rows: 1

  * - Deployment
    - 300 peticiones durante el cambio
  * - como está arriba
    - 297 ``200``, 2 ``502``, 1 sin respuesta
  * - con readinessProbe y maxUnavailable: 0
    - 297 ``200``, 3 sin respuesta
  * - y además con preStop
    - **300** ``200``

Actualizar sin cortar el servicio no sale gratis por usar Kubernetes: sale de decirle al clúster cómo sabe él que una copia ya está lista para recibir peticiones, y cuánto tiene que esperar antes de apagar una que todavía está atendiendo.

Una imagen propia: Dockerfile, ConfigMap y Secret
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Hasta aquí hemos usado la imagen oficial de nginx con la página metida en un ConfigMap. Ahora construimos **nuestra propia imagen**, que lee de **variables de entorno** el título de la página y una clave de acceso.

Kubernetes no construye imágenes, así que instalamos Docker en compute-0-0 (convive con k3s sin tocarle las reglas de red):

.. code-block:: bash

  root@compute-0-0:~# apt install -y docker.io

La imagen oficial de nginx ejecuta al arrancar todo lo que encuentre en ``/docker-entrypoint.d/``. Ese es el sitio donde sustituir las variables dentro del HTML, con ``envsubst``:

Son **tres ficheros dentro del directorio** ``imagen/``, y cada uno tiene que quedar con exactamente lo que se ve aquí: ni una línea más.

``imagen/index.html.template``:

.. code-block:: html

  <!DOCTYPE html>
  <html>
  <head><title>${TITULO}</title></head>
  <body>
    <h1>${TITULO}</h1>
    <p>Imagen propia construida con Dockerfile</p>
  </body>
  </html>

``imagen/20-titulo.sh``:

.. code-block:: bash

  #!/bin/sh
  # la imagen nginx ejecuta al arrancar todo lo que encuentre en /docker-entrypoint.d/
  envsubst "\$TITULO" < /plantilla/index.html.template > /usr/share/nginx/html/index.html

``imagen/Dockerfile``:

.. code-block:: docker

  FROM nginx:alpine
  # envsubst viene en el paquete gettext
  RUN apk add --no-cache gettext
  ENV TITULO="sin titulo" CLAVE="sin clave"
  COPY index.html.template /plantilla/index.html.template
  COPY 20-titulo.sh /docker-entrypoint.d/20-titulo.sh
  RUN chmod +x /docker-entrypoint.d/20-titulo.sh

Antes de construir, comprueba que el script tiene **tres líneas** y el resto lo suyo, porque si se cuela ahí cualquier otra cosa nginx intentará ejecutarla al arrancar y el contenedor se morirá nada más nacer:

.. code-block:: bash

  root@compute-0-0:~# wc -l imagen/*
    7 imagen/Dockerfile
    8 imagen/index.html.template
    3 imagen/20-titulo.sh

  root@compute-0-0:~# docker build -t web-tunombre:1.0 imagen/
  sha256:28ce5e9688896cf74c49b57685c71bd8af308f5dfa0d9608a4b5f49fed40cbe2

La imagen está ahora en el Docker de compute-0-0, pero **k3s no usa Docker, usa containerd**, y además cada nodo tiene su propio almacén de imágenes. Si una copia cae en compute-0-1 y allí no está la imagen, el Pod se queda en ``ErrImagePull``. Hay que llevarla a los tres agentes:

.. code-block:: bash

  root@compute-0-0:~# docker save web-tunombre:1.0 -o web-tunombre-1.0.tar
  root@compute-0-0:~# ls -lh web-tunombre-1.0.tar
  31M web-tunombre-1.0.tar

  root@compute-0-0:~# k3s ctr images import web-tunombre-1.0.tar
  unpacking docker.io/library/web-tunombre:1.0 ...

  root@compute-0-0:~# for n in 1 2 3; do
    scp web-tunombre-1.0.tar 172.16.0.1$n:/root/
    ssh 172.16.0.1$n "k3s ctr images import /root/web-tunombre-1.0.tar"
  done

  root@compute-0-0:~# for n in 0 1 2 3; do
    echo -n "compute-0-$n: "; ssh 172.16.0.1$n "k3s ctr images ls | grep -c web-tunombre"
  done
  compute-0-0: 1
  compute-0-1: 1
  compute-0-2: 1
  compute-0-3: 1

En la vida real esto se resuelve con un **registro de imágenes** (Docker Hub o uno propio): se sube una vez y cada nodo se la descarga. Copiar el tar a mano solo se aguanta con cuatro máquinas.

El **título** no es un secreto y va en un **ConfigMap**; la **clave** sí, y va en un **Secret**. Los dos son objetos nuevos, así que van en un fichero nuevo, ``config-tunombre.yml``:

.. code-block:: yaml

  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: web-tunombre-config
  data:
    titulo: "Hola, soy tunombre"
  ---
  apiVersion: v1
  kind: Secret
  metadata:
    name: web-tunombre-secret
  type: Opaque
  stringData:
    clave: "MiClaveSecreta"

Tenerlos creados no hace nada por sí solo: hay que **inyectarlos como variables de entorno** en el contenedor, y eso se toca donde vive el contenedor, en el Deployment de ``web-tunombre.yml``. Otra vez, lo resaltado es lo que cambia:

.. code-block:: yaml
  :emphasize-lines: 5-6,9-19

  # web-tunombre.yml, dentro del Deployment
      spec:
        containers:
          - name: nginx
            image: web-tunombre:1.0
            imagePullPolicy: IfNotPresent
            ports:
              - containerPort: 80
            env:
              - name: TITULO
                valueFrom:
                  configMapKeyRef:
                    name: web-tunombre-config
                    key: titulo
              - name: CLAVE
                valueFrom:
                  secretKeyRef:
                    name: web-tunombre-secret
                    key: clave

La ``image`` deja de ser ``nginx:alpine`` y pasa a ser la nuestra. Y ``imagePullPolicy: IfNotPresent`` es importante: sin él, el clúster intentaría descargar de Docker Hub una imagen que solo existe en nuestros nodos.

Y hay algo que **se quita**: el ConfigMap ``web-tunombre-html`` con la página y el volumen que lo montaba en ``/usr/share/nginx/html``. Ya no hacen falta, porque ahora la página la genera la propia imagen al arrancar, y además **estorban**: un volumen de ConfigMap se monta en sólo lectura, así que el ``envsubst`` del arranque no podría escribir ahí el ``index.html``. Borra del Deployment las dos partes:

.. code-block:: yaml
  :emphasize-lines: 4-6,8-11

  # web-tunombre.yml: esto se BORRA del Deployment
      spec:
        containers:
          - name: nginx
            volumeMounts:
              - name: html
                mountPath: /usr/share/nginx/html
        volumes:
          - name: html
            configMap:
              name: web-tunombre-html

Si te dejas el volumen puesto, el Pod arranca pero la página sigue siendo la vieja, y no hay ningún error que te lo diga.

Y hay una diferencia con la página del ConfigMap de antes: aquellos ficheros se refrescaban solos porque iban montados como un volumen, pero **una variable de entorno se lee al arrancar el contenedor y ya no cambia mientras vive**. Si ahora cambias el título en el ConfigMap, la web seguirá igual hasta que los Pods se recreen.

Y se aplican los dos ficheros, el nuevo y el de siempre:

.. code-block:: bash

  root@compute-0-0:~# kubectl apply -f config-tunombre.yml
  configmap/web-tunombre-config created
  secret/web-tunombre-secret created

  root@compute-0-0:~# kubectl apply -f web-tunombre.yml
  deployment.apps/web-tunombre configured

Del segundo fichero solo cambia el Deployment; de lo demás que hay dentro, ``kubectl`` dirá ``unchanged``, porque no lo has tocado.

.. code-block:: bash

  root@compute-0-0:~# curl -s http://web-tunombre.local
  <!DOCTYPE html>
  <html>
  <head><title>Hola, soy tunombre</title></head>
  <body>
    <h1>Hola, soy tunombre</h1>
    <p>Imagen propia construida con Dockerfile</p>
  </body>
  </html>

La diferencia entre los dos se ve en ``describe``, que enseña de dónde sale cada variable pero **no** el valor del Secret:

.. code-block:: bash

  root@compute-0-0:~# kubectl describe pod web-tunombre-6d9474f456-9qxwz | grep -A3 Environment
    Environment:
      TITULO:  <set to the key 'titulo' of config map 'web-tunombre-config'>  Optional: false
      CLAVE:   <set to the key 'clave' in secret 'web-tunombre-secret'>       Optional: false

.. warning::

  Un Secret **no está cifrado**, solo codificado en base64, y dentro del contenedor la clave está a la vista. Sirve para que no aparezca en los listados ni en el fichero YAML del repositorio, no para guardar algo de verdad importante:

  .. code-block:: bash

    root@compute-0-0:~# kubectl get secret web-tunombre-secret -o jsonpath='{.data.clave}'
    TWlDbGF2ZVNlY3JldGE=
    root@compute-0-0:~# echo TWlDbGF2ZVNlY3JldGE= | base64 -d
    MiClaveSecreta

    root@compute-0-0:~# kubectl exec web-tunombre-6d9474f456-9qxwz -- printenv TITULO CLAVE
    Hola, soy tunombre
    MiClaveSecreta

Almacenamiento persistente
^^^^^^^^^^^^^^^^^^^^^^^^^^

Un Pod es desechable: cuando muere se lleva consigo todo lo que hubiera escrito. Para que los datos sobrevivan hay que sacarlos fuera, y lo que ya sabemos montar es un **NFS** (ver :doc:`09_GNULinux_NFS`). En compute-0-0:

.. code-block:: bash

  root@compute-0-0:~# apt install -y nfs-kernel-server
  root@compute-0-0:~# for n in 1 2 3; do ssh -n 172.16.0.1$n "apt install -y nfs-common"; done
  root@compute-0-0:~# mkdir -p /srv/tunombre && chmod 777 /srv/tunombre
  root@compute-0-0:~# echo "/srv/tunombre 172.16.0.0/16(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
  root@compute-0-0:~# exportfs -ra && exportfs -v
  /srv/tunombre 	172.16.0.0/16(sync,wdelay,hide,no_subtree_check,sec=sys,rw,secure,no_root_squash,no_all_squash)

En Kubernetes el almacenamiento se describe en dos piezas: un **PersistentVolume** (el disco que hay) y un **PersistentVolumeClaim** (lo que la aplicación pide). ``nfs-tunombre.yml``:

.. code-block:: yaml

  apiVersion: v1
  kind: PersistentVolume
  metadata:
    name: pv-tunombre
  spec:
    capacity:
      storage: 1Gi
    accessModes:
      - ReadWriteMany
    persistentVolumeReclaimPolicy: Retain
    storageClassName: nfs-tunombre
    nfs:
      server: 172.16.0.10
      path: /srv/tunombre
  ---
  apiVersion: v1
  kind: PersistentVolumeClaim
  metadata:
    name: pvc-tunombre
  spec:
    accessModes:
      - ReadWriteMany
    storageClassName: nfs-tunombre
    resources:
      requests:
        storage: 1Gi

``ReadWriteMany`` es lo que permite que **varias copias a la vez** escriban en el mismo sitio, y es justo lo que un NFS sabe hacer.

.. code-block:: bash

  root@compute-0-0:~# kubectl apply -f nfs-tunombre.yml
  persistentvolume/pv-tunombre created
  persistentvolumeclaim/pvc-tunombre created

  root@compute-0-0:~# kubectl get pv,pvc
  NAME                           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM
  persistentvolume/pv-tunombre   1Gi        RWX            Retain           Bound    default/pvc-tunombre

  NAME                                 STATUS   VOLUME        CAPACITY   ACCESS MODES
  persistentvolumeclaim/pvc-tunombre   Bound    pv-tunombre   1Gi        RWX

``Bound`` quiere decir que la petición ha encontrado su volumen, y ahora se monta en el Deployment de ``web-tunombre.yml``. Como ese fichero se ha ido construyendo a trozos en tres apartados distintos, aquí va entero, para que lo compares con el tuyo. **Lo resaltado es lo importante de este apartado**: el ``volumeMounts`` dentro del contenedor y el ``volumes`` al mismo nivel que ``containers``.

.. code-block:: yaml
  :emphasize-lines: 45-51

  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: web-tunombre
  spec:
    replicas: 8
    strategy:
      rollingUpdate:
        maxSurge: 25%
        maxUnavailable: 0
    selector:
      matchLabels:
        app: web-tunombre
    template:
      metadata:
        labels:
          app: web-tunombre
      spec:
        containers:
          - name: nginx
            image: web-tunombre:1.0
            imagePullPolicy: IfNotPresent
            ports:
              - containerPort: 80
            env:
              - name: TITULO
                valueFrom:
                  configMapKeyRef:
                    name: web-tunombre-config
                    key: titulo
              - name: CLAVE
                valueFrom:
                  secretKeyRef:
                    name: web-tunombre-secret
                    key: clave
            readinessProbe:
              httpGet:
                path: /
                port: 80
              periodSeconds: 2
            lifecycle:
              preStop:
                exec:
                  command: ["sleep", "5"]
            volumeMounts:
              - name: datos
                mountPath: /datos
        volumes:
          - name: datos
            persistentVolumeClaim:
              claimName: pvc-tunombre

Y ``kubectl apply -f web-tunombre.yml`` para que se lleve a los Pods. Kubernetes los recrea él solo al ver el Deployment cambiado, pero conviene comprobar que han nacido **todos** con el volumen antes de seguir:

.. code-block:: bash

  root@compute-0-0:~# kubectl apply -f web-tunombre.yml
  root@compute-0-0:~# kubectl rollout status deployment/web-tunombre

  root@compute-0-0:~# kubectl get pods -o custom-columns=POD:.metadata.name,NODO:.spec.nodeName,VOLUMENES:.spec.containers[0].volumeMounts[*].name

Los Pods buenos llevan ``datos`` en la última columna; los que salgan vacíos son de la versión anterior y tienen que desaparecer solos. Si se quedan, ``kubectl rollout restart deployment/web-tunombre`` los renueva todos de pocas en pocas, sin dejar el servicio sin copias.


Y la prueba de que el dato sobrevive al Pod: escribimos desde una copia, la borramos y leemos desde la que nace en su lugar, que además puede caer en otra máquina:

.. code-block:: bash

  root@compute-0-0:~# kubectl exec web-tunombre-7f7bdd879f-6dxcz -- \
      sh -c 'echo "escrito por $(hostname) el $(date)" > /datos/prueba.txt'

  root@compute-0-0:~# cat /srv/tunombre/prueba.txt
  escrito por web-tunombre-7f7bdd879f-6dxcz el Mon Sep 14 18:05:26 UTC 2026

  root@compute-0-0:~# kubectl delete pod web-tunombre-7f7bdd879f-6dxcz
  root@compute-0-0:~# kubectl exec web-tunombre-7f7bdd879f-fmvhq -- cat /datos/prueba.txt
  escrito por web-tunombre-7f7bdd879f-6dxcz el Mon Sep 14 18:05:26 UTC 2026

El fichero lo escribió un Pod que ya no existe y lo lee otro que ha nacido después. Los datos viven en el NFS, no en el contenedor.

.. note::

  k3s trae además una clase de almacenamiento por defecto, **local-path**, que no necesita NFS: crea el directorio en el disco del nodo donde arranca el Pod. Repite la prueba con ella (quita ``storageClassName`` del PVC) y verás que funciona **mientras el Pod renazca en la misma máquina**; si el planificador lo manda a otra, el fichero no está. Esa es la diferencia entre almacenamiento local y almacenamiento de red, y es la razón de montar el NFS.

Mantenimiento del clúster
^^^^^^^^^^^^^^^^^^^^^^^^^

**Añadir un nodo** al clúster que ya está funcionando es repetir en la máquina nueva el mismo comando de los agentes. Compáralo con lo que costaba añadir un nodo al clúster de Slurm de la tarea 04:

.. code-block:: bash

  root@compute-0-3:~# curl -sfL https://get.k3s.io | \
    K3S_URL=https://172.16.0.10:6443 K3S_TOKEN=<token> sh -

**Sacar un nodo** para mantenimiento, sin que se caiga nada: ``drain`` mueve sus Pods al resto y ``cordon`` impide que le manden más trabajo.

.. code-block:: bash

  root@compute-0-0:~# kubectl drain compute-0-2 --ignore-daemonsets --delete-emptydir-data
  root@compute-0-0:~# kubectl uncordon compute-0-2      # al volver

**Ver el clúster por dentro** cuando algo no va:

.. code-block:: bash

  journalctl -u k3s -f            # en el servidor
  journalctl -u k3s-agent -f      # en los agentes
  kubectl get events --sort-by=.lastTimestamp | tail -20
  kubectl get pods -A             # incluido lo que k3s trae en kube-system

**Empezar de cero**, que en clase hace falta más de una vez:

.. code-block:: bash

  root@compute-0-0:~# /usr/local/bin/k3s-uninstall.sh          # en el servidor
  root@compute-0-1:~# /usr/local/bin/k3s-agent-uninstall.sh    # en los agentes

Y para **apagar las máquinas**, nada especial: k3s arranca solo al encender, porque es un servicio de systemd habilitado. Al volver, los Pods se recrean y el clúster se reconstruye solo; dale un par de minutos antes de dar nada por roto.


Caso práctico: Helm, observabilidad y almacenamiento de objetos
---------------------------------------------------------------

Seguimos sobre **el mismo clúster** del caso anterior, sin borrar ni reinstalar nada: los nodos que ya tenemos, el NFS de compute-0-0 y la aplicación ``web-tunombre`` desplegada con su imagen propia. Lo que cambia es la forma de trabajar. Hasta ahora hemos escrito los YAML a mano y hemos mirado el clúster con ``kubectl`` y ``k9s``, que enseña lo que pasa **ahora mismo**. Un administrador de verdad hace otras dos cosas: **instala software empaquetado** en lugar de escribirlo, y **guarda el histórico** de lo que ha pasado para poder mirarlo después.

Vamos a montar tres piezas encima de lo que ya hay:

* **Helm**, el gestor de paquetes de Kubernetes: lo que ``apt`` es a Ubuntu.
* **Prometheus y Grafana**, para ver el clúster con gráficas y con histórico.
* **MinIO**, un almacén de objetos compatible con S3, y una copia de seguridad automática del NFS contra él.

.. note::

  Esto pesa bastante más que el caso anterior: aquí es donde hacen falta los **4 GB** de cada máquina. Aun así, los valores que usamos más abajo van recortados a propósito, porque los que traen los charts por defecto están pensados para servidores de verdad.

Helm, el gestor de paquetes de Kubernetes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Instalar una aplicación en Kubernetes escribiendo los YAML a mano funciona con tres objetos, como los nuestros. Con treinta, no. **Helm** empaqueta todos los objetos de una aplicación en un **chart**, con los valores configurables sacados a un fichero aparte, y lo instala de una vez. Tres palabras que hay que tener claras:

* **chart**: el paquete, con las plantillas de todos los objetos.
* **values**: los valores que rellenan las plantillas (el ``values.yaml``).
* **release**: una instalación concreta de un chart en el clúster, con su nombre y su historial.

Es la misma idea que un paquete ``.deb``, sus ficheros de configuración y el paquete ya instalado en la máquina.

.. code-block:: bash

  root@compute-0-0:~# curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  Downloading https://get.helm.sh/helm-v3.22.0-linux-amd64.tar.gz
  Verifying checksum... Done.
  Preparing to install helm into /usr/local/bin
  helm installed into /usr/local/bin/helm

  root@compute-0-0:~# helm version
  version.BuildInfo{Version:"v3.22.0", GitCommit:"144ca65f8501...", GoVersion:"go1.26.8"}

``helm version`` contesta sin tocar el clúster, así que **parece** que ya está todo. En cuanto le pides algo de verdad, no:

.. code-block:: bash

  root@compute-0-0:~# helm list
  Error: Kubernetes cluster unreachable: Get "http://localhost:8080/version": dial tcp 127.0.0.1:8080: connect: connection refused

Helm, igual que k9s, **no es el binario de k3s** y no sabe dónde están las credenciales: al no encontrar un kubeconfig prueba la dirección por defecto de Kubernetes, que en k3s no escucha nadie. Lo arregla la misma variable que pusimos para k9s, así que si la dejaste en el ``~/.bashrc`` no hay nada que hacer; si no, es una línea:

.. code-block:: bash

  root@compute-0-0:~# echo 'export KUBECONFIG=/etc/rancher/k3s/k3s.yaml' >> ~/.bashrc
  root@compute-0-0:~# source ~/.bashrc

  root@compute-0-0:~# helm list
  NAME	NAMESPACE	REVISION	UPDATED	STATUS	CHART	APP VERSION

La lista sale vacía, pero ya contesta. Aunque hay más de lo que parece, y se ve pidiendo **todos** los *namespaces*:

.. code-block:: bash

  root@compute-0-0:~# helm list -A
  NAME          NAMESPACE     REVISION  STATUS     CHART                        APP VERSION
  traefik       kube-system   1         deployed   traefik-40.1.4+up40.1.0      v3.7.1
  traefik-crd   kube-system   1         deployed   traefik-crd-40.1.4+up40.1.0  v3.7.1

**k3s ya estaba usando Helm sin decírnoslo**: aquellos dos Pods ``helm-install-traefik`` que salían como ``Completed`` en ``kube-system`` desde el primer día eran exactamente esto, la instalación del Ingress con un chart.

Nuestra aplicación como chart propio
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Antes de instalar paquetes de otros, empaquetamos el nuestro: así se ve qué hay dentro de un chart. ``helm create`` deja un esqueleto de ejemplo del que nos quedamos con la estructura:

.. code-block:: bash

  root@compute-0-0:~/09# helm create web-tunombre-chart
  Creating web-tunombre-chart

  root@compute-0-0:~/09# find web-tunombre-chart -maxdepth 2 | sort
  web-tunombre-chart
  web-tunombre-chart/.helmignore
  web-tunombre-chart/Chart.yaml
  web-tunombre-chart/charts
  web-tunombre-chart/templates
  web-tunombre-chart/templates/NOTES.txt
  web-tunombre-chart/templates/_helpers.tpl
  web-tunombre-chart/templates/deployment.yaml
  web-tunombre-chart/templates/hpa.yaml
  web-tunombre-chart/templates/httproute.yaml
  web-tunombre-chart/templates/ingress.yaml
  web-tunombre-chart/templates/service.yaml
  web-tunombre-chart/templates/serviceaccount.yaml
  web-tunombre-chart/values.yaml

Lo que nos interesa son tres sitios: ``Chart.yaml`` (el nombre y la versión del paquete), ``values.yaml`` (los valores) y ``templates/`` (los YAML, con huecos). Las plantillas de ejemplo que trae son mucho más complicadas de lo que necesitamos, así que las borramos y ponemos las nuestras, que son **exactamente los ficheros del caso anterior** con los valores sustituidos por huecos:

.. code-block:: bash

  root@compute-0-0:~/09# rm -rf web-tunombre-chart/templates/* web-tunombre-chart/charts

``Chart.yaml``:

.. code-block:: yaml

  apiVersion: v2
  name: web-tunombre
  description: La aplicacion web del caso practico anterior, empaquetada como chart
  type: application
  version: 0.1.0
  appVersion: "1.0"

``values.yaml``, que es el fichero que de verdad se toca después:

.. code-block:: yaml

  replicaCount: 4

  image:
    repository: web-tunombre
    tag: "1.0"
    pullPolicy: IfNotPresent

  titulo: "Hola, soy tunombre"
  clave: "MiClaveSecreta"

  service:
    nodePort: 30080

  ingress:
    host: web-tunombre.local

  nfs:
    claimName: pvc-tunombre

En ``templates/`` van cinco ficheros —``configmap.yaml``, ``secret.yaml``, ``deployment.yaml``, ``service.yaml`` e ``ingress.yaml``—, los mismos objetos del caso anterior. Los dos pequeños enseñan la idea entera:

.. code-block:: yaml

  # templates/configmap.yaml
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: {{ .Release.Name }}-config
  data:
    titulo: {{ .Values.titulo | quote }}

  # templates/secret.yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: {{ .Release.Name }}-secret
  type: Opaque
  stringData:
    clave: {{ .Values.clave | quote }}

Y el Deployment, que es el de siempre con los valores sacados fuera:

.. code-block:: yaml

  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: {{ .Release.Name }}
  spec:
    replicas: {{ .Values.replicaCount }}
    selector:
      matchLabels:
        app: {{ .Release.Name }}
    template:
      metadata:
        labels:
          app: {{ .Release.Name }}
      spec:
        containers:
          - name: nginx
            image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
            imagePullPolicy: {{ .Values.image.pullPolicy }}
            ports:
              - containerPort: 80
            env:
              - name: TITULO
                valueFrom:
                  configMapKeyRef:
                    name: {{ .Release.Name }}-config
                    key: titulo
              - name: CLAVE
                valueFrom:
                  secretKeyRef:
                    name: {{ .Release.Name }}-secret
                    key: clave
            volumeMounts:
              - name: datos
                mountPath: /datos
        volumes:
          - name: datos
            persistentVolumeClaim:
              claimName: {{ .Values.nfs.claimName }}

``{{ .Values.algo }}`` es un valor del ``values.yaml`` y ``{{ .Release.Name }}`` el nombre que le damos al instalar. El ``| quote`` pone las comillas por nosotros. Eso es lo que convierte un YAML escrito para un nombre concreto en algo **reutilizable**.

Dos comprobaciones antes de tocar el clúster. ``helm lint`` revisa el paquete y ``helm template`` enseña el YAML ya montado, que es como se depura un chart:

.. code-block:: bash

  root@compute-0-0:~/09# helm lint web-tunombre-chart
  ==> Linting web-tunombre-chart
  [INFO] Chart.yaml: icon is recommended

  1 chart(s) linted, 0 chart(s) failed

  root@compute-0-0:~/09# helm template prueba web-tunombre-chart | head -20
  ---
  # Source: web-tunombre/templates/secret.yaml
  apiVersion: v1
  kind: Secret
  metadata:
    name: prueba-secret
  type: Opaque
  stringData:
    clave: "MiClaveSecreta"
  ---
  # Source: web-tunombre/templates/configmap.yaml
  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: prueba-config
  data:
    titulo: "Hola, soy tunombre"

Fíjate en que al llamar a la *release* ``prueba``, **todos** los objetos han pasado a llamarse ``prueba-...``. Eso es lo que permite instalar el mismo chart dos veces en el mismo clúster sin que choquen.

Como la aplicación del caso anterior sigue desplegada, la quitamos primero para no chocar con el mismo NodePort y el mismo Ingress. El PersistentVolume y su PVC **no se tocan**: los queremos:

.. code-block:: bash

  root@compute-0-0:~/09# kubectl delete -f web-tunombre.yml -f ingress-tunombre.yml -f config-tunombre.yml
  configmap "web-tunombre-html" deleted from default namespace
  deployment.apps "web-tunombre" deleted from default namespace
  service "web-tunombre" deleted from default namespace
  ingress.networking.k8s.io "web-tunombre" deleted from default namespace
  configmap "web-tunombre-config" deleted from default namespace
  secret "web-tunombre-secret" deleted from default namespace

  root@compute-0-0:~/09# helm install web-tunombre ./web-tunombre-chart
  NAME: web-tunombre
  LAST DEPLOYED: Mon Sep 21 15:42:30 2026
  NAMESPACE: default
  STATUS: deployed
  REVISION: 1
  TEST SUITE: None

  root@compute-0-0:~/09# helm list
  NAME          NAMESPACE  REVISION  STATUS    CHART               APP VERSION
  web-tunombre  default    1         deployed  web-tunombre-0.1.0  1.0

  root@compute-0-0:~/09# kubectl get pods -l app=web-tunombre \
      -o custom-columns=ESTADO:.status.phase,NODO:.spec.nodeName --no-headers | sort | uniq -c
        1 Running compute-0-0
        1 Running compute-0-1
        1 Running compute-0-2
        1 Running compute-0-3

  root@compute-0-0:~/09# curl -s http://web-tunombre.local | head -6
  <!DOCTYPE html>
  <html>
  <head><title>Hola, soy tunombre</title></head>
  <body>
    <h1>Hola, soy tunombre</h1>
    <p>Imagen propia construida con Dockerfile</p>

Seis objetos, un comando, y la misma página de antes. Y ahora lo importante: **todo lo que hicimos a mano en el caso anterior, Helm lo hace sobre el paquete entero**, no objeto a objeto.

.. code-block:: bash

  root@compute-0-0:~/09# helm upgrade web-tunombre ./web-tunombre-chart --set replicaCount=8
  Release "web-tunombre" has been upgraded. Happy Helming!
  NAME: web-tunombre
  REVISION: 2
  STATUS: deployed

  root@compute-0-0:~/09# kubectl get pods --no-headers | wc -l
  8

  root@compute-0-0:~/09# helm rollback web-tunombre 1
  Rollback was a success! Happy Helming!

  root@compute-0-0:~/09# kubectl get pods --no-headers | wc -l
  4

  root@compute-0-0:~/09# helm history web-tunombre
  REVISION  UPDATED                   STATUS      CHART               DESCRIPTION
  1         Mon Sep 21 15:42:30 2026  superseded  web-tunombre-0.1.0  Install complete
  2         Mon Sep 21 15:42:53 2026  superseded  web-tunombre-0.1.0  Upgrade complete
  3         Mon Sep 21 15:43:12 2026  deployed    web-tunombre-0.1.0  Rollback to 1

.. list-table::
  :header-rows: 1

  * - A mano (caso anterior)
    - Con Helm
  * - ``kubectl apply -f`` de tres ficheros
    - ``helm install web-tunombre ./web-tunombre-chart``
  * - ``kubectl scale deployment --replicas=8``
    - ``helm upgrade --set replicaCount=8``
  * - ``kubectl rollout undo``
    - ``helm rollback web-tunombre 1``
  * - ``kubectl get all`` y deducir qué hay
    - ``helm list`` y ``helm history``
  * - editar el YAML
    - cambiar un valor del ``values.yaml``

La diferencia no es escribir menos: es que el ``rollback`` de Helm devuelve **la aplicación entera** —Deployment, ConfigMap, Secret, Service e Ingress— a como estaba, mientras que ``kubectl rollout undo`` solo deshace el Deployment. Fíjate además en que el rollback **es la revisión 3**, no vuelve a la 1: el historial nunca se reescribe, solo crece.

Un chart ajeno: MinIO
^^^^^^^^^^^^^^^^^^^^^^

**MinIO** es un almacén de **objetos** compatible con la API S3 de Amazon: en vez de ficheros y directorios como el NFS, guarda objetos dentro de *buckets*, y se habla con él por HTTP. Es lo que hay por dentro de muchas copias de seguridad y de casi cualquier aplicación que guarde imágenes o documentos, y es la pieza que más se parece a lo que luego encontraréis en la nube.

Lo instalamos **sin escribir un solo YAML**, que es de lo que se trata:

.. code-block:: bash

  root@compute-0-0:~/09# helm repo add minio https://charts.min.io/
  "minio" has been added to your repositories

  root@compute-0-0:~/09# helm repo update
  Update Complete. ⎈Happy Helming!⎈

  root@compute-0-0:~/09# helm search repo minio
  NAME         CHART VERSION  APP VERSION                  DESCRIPTION
  minio/minio  5.4.0          RELEASE.2024-12-18T13-15-44Z  High Performance Object Storage

Antes de instalar nada conviene mirar **qué se puede configurar**, que es el equivalente a leer el fichero de configuración de un paquete de Debian:

.. code-block:: bash

  root@compute-0-0:~/09# helm show values minio/minio | head -40

Ahí se ve, entre otras cosas, que el chart está pensado para un servidor de verdad:

.. code-block:: yaml

  mode: distributed   ## other supported values are "standalone"
  replicas: 16
  resources:
    requests:
      memory: 16Gi

.. warning::

  **16 Gi de memoria y 16 réplicas** por defecto. Si instalas el chart tal cual, el Pod se queda en ``Pending`` para siempre y ``kubectl describe`` dirá que ningún nodo tiene memoria suficiente. Es el error más habitual al usar un chart ajeno por primera vez: los valores por defecto son los del fabricante, no los tuyos.

Nuestros valores van en un fichero propio, ``minio-values.yaml``, en lugar de encadenar diez ``--set``:

.. code-block:: yaml

  mode: standalone
  replicas: 1

  rootUser: "tunombre"
  rootPassword: "MiClaveSecreta"

  persistence:
    enabled: true
    size: 5Gi

  resources:
    requests:
      memory: 512Mi

  consoleIngress:
    enabled: true
    hosts:
      - minio-tunombre.local

.. code-block:: bash

  root@compute-0-0:~/09# kubectl create namespace minio
  namespace/minio created

  root@compute-0-0:~/09# helm install minio minio/minio -n minio -f minio-values.yaml
  NAME: minio
  NAMESPACE: minio
  STATUS: deployed
  REVISION: 1

  root@compute-0-0:~/09# kubectl get all,pvc -n minio
  NAME                         READY   STATUS    RESTARTS   AGE
  pod/minio-5bb5cf69fd-b7cjc   1/1     Running   0          59s

  NAME                    TYPE        CLUSTER-IP      PORT(S)    AGE
  service/minio           ClusterIP   10.43.209.10    9000/TCP   59s
  service/minio-console   ClusterIP   10.43.141.196   9001/TCP   59s

  NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
  deployment.apps/minio   1/1     1            1           59s

  NAME                          STATUS   VOLUME                     CAPACITY   ACCESS MODES   STORAGECLASS
  persistentvolumeclaim/minio   Bound    pvc-c391c89e-9701-4a87...  5Gi        RWO            local-path

Fíjate en lo que ha aparecido sin haberlo escrito: un Deployment, **dos** Services (uno para la API en el 9000 y otro para la consola web en el 9001), un Ingress, un Secret con las credenciales y un **PersistentVolumeClaim**. El PVC lo ha resuelto ``local-path``, el almacenamiento por defecto de k3s del que hablamos al final del caso anterior, así que **los datos viven en el disco del nodo donde haya caído el Pod**.

El nombre nuevo hay que añadirlo al ``/etc/hosts`` de todos los nodos. Ojo con el bucle: compute-0-0 no puede entrar por ssh en sí mismo, así que el primero se hace en local:

.. code-block:: bash

  root@compute-0-0:~/09# echo "172.16.0.10 minio-tunombre.local grafana-tunombre.local" >> /etc/hosts
  root@compute-0-0:~/09# for n in 1 2 3; do
      ssh -n 172.16.0.1$n "echo '172.16.0.10 minio-tunombre.local grafana-tunombre.local' >> /etc/hosts"
    done

  root@compute-0-0:~/09# kubectl get ingress -A
  NAMESPACE   NAME            CLASS     HOSTS                  ADDRESS                                           PORTS
  default     web-tunombre    traefik   web-tunombre.local     172.16.0.10,172.16.0.11,172.16.0.12,172.16.0.13   80
  minio       minio-console   traefik   minio-tunombre.local   172.16.0.10,172.16.0.11,172.16.0.12,172.16.0.13   80

  root@compute-0-0:~/09# curl -s -o /dev/null -w "%{http_code}\n" http://minio-tunombre.local
  200

El mismo Traefik reparte ahora dos aplicaciones distintas por el puerto 80 según el nombre que se pida, que es justo lo que decíamos al montar el Ingress.

Desde la consola web (``http://minio-tunombre.local``, con el usuario y la clave del ``values.yaml``) se crea un *bucket* con el ratón, pero también se puede desde la línea de órdenes con ``mc``, el cliente de MinIO, que viene dentro de la propia imagen. Como el Pod tiene un nombre que cambia en cada despliegue, lo cómodo es entrar por el Deployment:

.. code-block:: bash

  root@compute-0-0:~/09# kubectl -n minio exec deploy/minio -- \
      mc alias set local http://localhost:9000 tunombre MiClaveSecreta
  Added `local` successfully.

  root@compute-0-0:~/09# kubectl -n minio exec deploy/minio -- mc mb local/backup-tunombre
  Bucket created successfully `local/backup-tunombre`.

  root@compute-0-0:~/09# kubectl -n minio exec deploy/minio -- mc ls local
  [2026-09-21 15:45:21 UTC]     0B backup-tunombre/

Observabilidad: Prometheus y Grafana
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``kubectl top`` y k9s enseñan lo que pasa **en este instante**. Cuando un nodo se cayó durante la noche, o cuando hay que explicar por qué a las once se quedó todo lento, hace falta **histórico**, y eso son dos programas: **Prometheus**, que va preguntando cada poco a todo el clúster y guarda los números, y **Grafana**, que los pinta.

Montarlos a mano son decenas de objetos. Aquí es donde Helm deja de ser una comodidad:

.. code-block:: bash

  root@compute-0-0:~/09# helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  root@compute-0-0:~/09# helm repo update

``monitor-values.yaml``:

.. code-block:: yaml

  # k3s ejecuta el plano de control dentro de un unico proceso: estos componentes
  # no existen como servicios sueltos y el chart los daria por caidos
  kubeControllerManager:
    enabled: false
  kubeScheduler:
    enabled: false
  kubeEtcd:
    enabled: false
  kubeProxy:
    enabled: false

  alertmanager:
    enabled: false

  prometheus:
    prometheusSpec:
      retention: 2d
      # para que recoja tambien los ServiceMonitor de otros charts, como el de MinIO
      serviceMonitorSelectorNilUsesHelmValues: false
      resources:
        requests:
          memory: 400Mi

  grafana:
    adminPassword: "MiClaveSecreta"
    ingress:
      enabled: true
      hosts:
        - grafana-tunombre.local

.. code-block:: bash

  root@compute-0-0:~/09# kubectl create namespace monitoring
  namespace/monitoring created

  root@compute-0-0:~/09# helm install monitor prometheus-community/kube-prometheus-stack \
      -n monitoring -f monitor-values.yaml
  NAME: monitor
  NAMESPACE: monitoring
  STATUS: deployed
  REVISION: 1

Tarda varios minutos, porque son bastantes imágenes. Al acabar:

.. code-block:: bash

  root@compute-0-0:~/09# kubectl get pods -n monitoring -o wide
  NAME                                                   READY   STATUS    NODE
  monitor-grafana-946bd9ff6-dv86j                        3/3     Running   compute-0-1
  monitor-kube-prometheus-st-operator-585c879bb6-tm58w   1/1     Running   compute-0-1
  monitor-kube-state-metrics-657db597d-s4cf8             1/1     Running   compute-0-2
  monitor-prometheus-node-exporter-626mt                 1/1     Running   compute-0-1
  monitor-prometheus-node-exporter-7kw2p                 1/1     Running   compute-0-3
  monitor-prometheus-node-exporter-bgp6d                 1/1     Running   compute-0-2
  monitor-prometheus-node-exporter-nn7cb                 1/1     Running   compute-0-0
  prometheus-monitor-kube-prometheus-st-prometheus-0     2/2     Running   compute-0-2

Un solo comando ha dejado funcionando cuatro cosas distintas:

* **Prometheus**, que guarda los números (y es un ``StatefulSet``: por eso acaba en ``-0``).
* **Grafana**, que los pinta.
* **node-exporter**, un ``DaemonSet``: **una copia en cada nodo**, igual que el ``svclb`` de Traefik, porque los datos de una máquina solo se pueden recoger desde dentro de esa máquina.
* **kube-state-metrics**, que traduce a números el estado de los objetos de Kubernetes: cuántos Pods hay, cuántos esperados, cuántos reiniciados.

Y un quinto que no es un servicio sino un **operador**: el ``prometheus-operator`` es quien ha creado a Prometheus a partir de un objeto de configuración. Los operadores son la forma en que Kubernetes se amplía a sí mismo.

.. warning::

  Los cuatro ``enabled: false`` del principio del ``values.yaml`` no son un capricho. El chart está pensado para una instalación con **kubeadm**, donde ``kube-scheduler``, ``kube-controller-manager``, ``etcd`` y ``kube-proxy`` son procesos separados con su propio puerto de métricas. **k3s los ejecuta todos dentro de un único binario**, así que esos puertos no existen y Prometheus los marcaría como ``DOWN`` para siempre, con el panel lleno de rojo sin que nada esté roto.

Quién está contestando y quién no se mira en la propia página de Prometheus (*Status → Target health*), o desde la línea de órdenes:

.. code-block:: bash

  root@compute-0-0:~/09# IP=$(kubectl get svc -n monitoring monitor-kube-prometheus-st-prometheus \
      -o jsonpath='{.spec.clusterIP}')
  root@compute-0-0:~/09# curl -s "http://$IP:9090/api/v1/targets?state=any" | \
      python3 -c 'import sys,json; d=json.load(sys.stdin)["data"]["activeTargets"]; [print(t["health"], t["labels"].get("job"), t["scrapeUrl"]) for t in d]'
  up apiserver https://172.16.0.10:6443/metrics
  up coredns http://10.42.0.55:9153/metrics
  up kubelet https://172.16.0.10:10250/metrics
  up kubelet https://172.16.0.10:10250/metrics/cadvisor
  up kubelet https://172.16.0.10:10250/metrics/probes
  up kubelet https://172.16.0.11:10250/metrics
  ...
  up kubelet https://172.16.0.13:10250/metrics/probes
  up kube-state-metrics http://10.42.2.58:8080/metrics
  up monitor-grafana http://10.42.1.53:3000/metrics
  up node-exporter http://172.16.0.10:9100/metrics
  up node-exporter http://172.16.0.11:9100/metrics
  up node-exporter http://172.16.0.12:9100/metrics
  up node-exporter http://172.16.0.13:9100/metrics

Son veinticuatro destinos y ninguno caído. Aquí se ve algo que no se aprecia en ningún otro sitio: Prometheus **va a buscar** los datos, uno por uno, a direcciones que ha descubierto solo. Nadie le ha dado una lista. Y fíjate en que hay un ``node-exporter`` por máquina y tres destinos de ``kubelet`` por máquina: si añades un nodo, aparecen los suyos sin tocar nada.

.. note::

  En máquinas justas de memoria puede aparecer el ``apiserver`` en ``down`` con un ``context deadline exceeded``: no es un fallo de configuración, es que el servidor de la API ha tardado más de lo que Prometheus espera. Suele recuperarse solo en la siguiente pasada.

Grafana se entra por su nombre, con el usuario ``admin`` y la clave del ``values.yaml``:

.. code-block:: bash

  root@compute-0-0:~/09# curl -s -o /dev/null -w "%{http_code}\n" http://grafana-tunombre.local
  302

El 302 es la redirección a la pantalla de entrada: desde el navegador del anfitrión hay que ir a ``http://grafana-tunombre.local``. Y no hay que dibujar ningún panel, porque el chart trae **veinticuatro** cuadros de mando ya hechos, cada uno en un ConfigMap:

.. code-block:: bash

  root@compute-0-0:~/09# kubectl get configmaps -n monitoring -l grafana_dashboard=1 --no-headers | wc -l
  24

Busca **Kubernetes / Compute Resources / Cluster** y **Node Exporter / Nodes**, y repite mirándolos los dos experimentos del caso anterior: escalar a ocho copias y apagar un nodo entero.

.. code-block:: bash

  root@compute-0-0:~/09# helm upgrade web-tunombre ./web-tunombre-chart --set replicaCount=8

  ... PENDIENTE: pantallazo de Grafana con el salto de Pods y de memoria ...

  ... PENDIENTE: pantallazo del nodo cayendo y volviendo ...

La diferencia con k9s es que esto **queda grabado**: dentro de una hora seguirá ahí el hueco, y esa es justo la información con la que se explica una caída que nadie vio.

Las métricas de MinIO
^^^^^^^^^^^^^^^^^^^^^^

Un sistema de monitorización sirve de poco si solo mira al propio Kubernetes. MinIO publica sus números él solo, sin ningún programa intermedio; solo hay que decirle a Prometheus que vaya a buscarlos, y eso se hace con un objeto **ServiceMonitor**, que es lo que el chart de MinIO sabe crear:

.. code-block:: yaml

  # se añade al minio-values.yaml
  metrics:
    serviceMonitor:
      enabled: true
      includeNode: true

.. warning::

  Hacen falta **las dos líneas**. La plantilla del chart empieza con ``{{- if and .Values.metrics.serviceMonitor.enabled .Values.metrics.serviceMonitor.includeNode }}``, así que con solo ``enabled: true`` no se crea nada, sin ningún error y sin ninguna pista. Cuando un chart ajeno «no hace caso» a un valor, la respuesta está en su plantilla: ``helm pull minio/minio --untar`` la descarga para poder leerla.

.. code-block:: bash

  root@compute-0-0:~/09# helm upgrade minio minio/minio -n minio -f minio-values.yaml
  REVISION: 4
  STATUS: deployed

  root@compute-0-0:~/09# kubectl get servicemonitors -A | grep minio
  minio   minio   5s

Un minuto después, Prometheus ya lo está recogiendo, y tiene datos:

.. code-block:: bash

  root@compute-0-0:~/09# curl -s "http://$IP:9090/api/v1/targets?state=any" | \
      python3 -c 'import sys,json; d=json.load(sys.stdin)["data"]["activeTargets"]; [print(t["health"], t["labels"].get("job"), t["scrapeUrl"]) for t in d if t["labels"].get("job")=="minio"]'
  up minio http://10.42.2.53:9000/minio/v2/metrics/node

  root@compute-0-0:~/09# curl -s --data-urlencode 'query=count({job="minio"})' "http://$IP:9090/api/v1/query"
  {"status":"success","data":{"resultType":"vector","result":[{"metric":{},"value":[...,"168"]}]}}

168 series distintas sobre MinIO, sin tocar la configuración de Prometheus. Así es como crece un sistema de monitorización de verdad: cada cosa nueva que se instala **se apunta sola**.

Copia de seguridad del NFS contra MinIO
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Cerramos el círculo. En la tarea de **cron y systemd** montamos copias de seguridad que se ejecutaban en una máquina: si esa máquina estaba apagada a su hora, esa noche no había copia. Aquí la copia la mantiene el clúster: un **CronJob** es un Job que se lanza según un horario, y lo arranca **cualquier nodo que esté vivo**.

Lo que copiamos es el NFS ``/srv/tunombre`` del caso anterior, que ya tenemos en el ``pvc-tunombre``, contra el bucket de MinIO. La herramienta es ``mc mirror``, y las credenciales **no van escritas en el YAML**: van en un Secret, como aprendimos con la clave de la página.

``backup-tunombre.yml``:

.. code-block:: yaml

  apiVersion: v1
  kind: Secret
  metadata:
    name: minio-credenciales
  type: Opaque
  stringData:
    usuario: "tunombre"
    clave: "MiClaveSecreta"
  ---
  apiVersion: batch/v1
  kind: CronJob
  metadata:
    name: backup-tunombre
  spec:
    schedule: "*/5 * * * *"
    jobTemplate:
      spec:
        template:
          spec:
            restartPolicy: OnFailure
            containers:
              - name: mc
                image: quay.io/minio/mc
                env:
                  - name: USUARIO
                    valueFrom:
                      secretKeyRef:
                        name: minio-credenciales
                        key: usuario
                  - name: CLAVE
                    valueFrom:
                      secretKeyRef:
                        name: minio-credenciales
                        key: clave
                command:
                  - sh
                  - -c
                  - |
                    echo "copia desde $HOSTNAME el $(date)" > /datos/ultima-copia.txt
                    mc alias set destino http://minio.minio.svc.cluster.local:9000 "$USUARIO" "$CLAVE"
                    mc mirror --overwrite /datos destino/backup-tunombre
                volumeMounts:
                  - name: datos
                    mountPath: /datos
            volumes:
              - name: datos
                persistentVolumeClaim:
                  claimName: pvc-tunombre

Tres detalles que dan más guerra de la que parece:

* La imagen es ``quay.io/minio/mc``, **no** ``minio/mc``. La de Docker Hub contesta ``pull access denied ... insufficient_scope`` y el Pod se queda en ``ImagePullBackOff``; ``quay.io`` es el registro que usa el propio chart de MinIO.
* Dentro de esa imagen **no existe el mandato ``hostname``** (es una imagen mínima, sin las herramientas de siempre), así que se usa la variable ``$HOSTNAME``, que Kubernetes ya deja puesta con el nombre del Pod.
* La dirección de MinIO es ``minio.minio.svc.cluster.local``, es decir *servicio.namespace*``.svc.cluster.local``, el nombre que le da **coredns**, el DNS interno que vimos en ``kube-system`` al montar el clúster. Dentro del clúster nadie usa direcciones IP.

El ``schedule`` es **el mismo formato de cinco campos de crontab** que ya conoces. Lo que cambia es quién lo ejecuta.

.. code-block:: bash

  root@compute-0-0:~/09# kubectl apply -f backup-tunombre.yml
  secret/minio-credenciales created
  cronjob.batch/backup-tunombre created

  root@compute-0-0:~/09# kubectl get cronjob
  NAME              SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
  backup-tunombre   */5 * * * *   False     0        <none>          1s

Esperar cinco minutos a ver si funciona es incómodo. Se puede lanzar una ejecución **a mano**, a partir del mismo CronJob, sin tocar el horario:

.. code-block:: bash

  root@compute-0-0:~/09# kubectl create job prueba-backup --from=cronjob/backup-tunombre
  job.batch/prueba-backup created

  root@compute-0-0:~/09# kubectl logs job/prueba-backup
  Added `destino` successfully.
  `/datos/ultima-copia.txt` -> `destino/backup-tunombre/ultima-copia.txt`
  ┌───────┬─────────────┬──────────┬────────────┐
  │ Total │ Transferred │ Duration │ Speed      │
  │ 119 B │ 119 B       │ 00m00s   │ 3.65 KiB/s │
  └───────┴─────────────┴──────────┴────────────┘

Dejándolo un rato, las ejecuciones aparecen solas cada cinco minutos, cada una con su Job y su Pod:

.. code-block:: bash

  root@compute-0-0:~/09# kubectl get jobs
  NAME                       STATUS     COMPLETIONS   DURATION   AGE
  backup-tunombre-29833430   Complete   1/1           43s        10m
  backup-tunombre-29833435   Complete   1/1           7s         5m40s
  backup-tunombre-29833440   Complete   1/1           6s         40s

  root@compute-0-0:~/09# cat /srv/tunombre/ultima-copia.txt
  copia desde backup-tunombre-29833440-5rg86 el Mon Sep 21 16:00:02 UTC 2026

  root@compute-0-0:~/09# kubectl -n minio exec deploy/minio -- mc ls local/backup-tunombre
  [2026-09-21 15:47:49 UTC]    74B STANDARD prueba.txt
  [2026-09-21 16:00:03 UTC]    75B STANDARD ultima-copia.txt

El fichero está en los dos sitios: en el NFS, que es un directorio de compute-0-0, y dentro del bucket, que es un objeto guardado en el disco de otro nodo. Fíjate también en que la primera ejecución tardó **43 segundos** y las siguientes **6**: la primera se tuvo que descargar la imagen.

Y la prueba que de verdad importa, la que en la tarea de cron no se podía hacer: **apaga el nodo donde se ejecutó la última copia** y espera a la siguiente. Sale igual, en otra máquina, sin que nadie toque nada.

.. code-block:: bash

  ... PENDIENTE: salida con el nodo apagado ...

Un nodo nuevo en un clúster que ya tiene cosas
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Merece la pena añadir un nodo **ahora**, con el clúster lleno, y ver qué se apaña solo y qué no. El nodo se une con el mismo comando de siempre:

.. code-block:: bash

  root@compute-0-3:~# curl -fL https://get.k3s.io | \
    K3S_URL=https://172.16.0.10:6443 K3S_TOKEN=<token> sh -
  [INFO]  systemd: Enabling k3s-agent unit
  [INFO]  systemd: Starting k3s-agent

  root@compute-0-0:~# kubectl get nodes
  NAME          STATUS   ROLES           AGE     VERSION
  compute-0-0   Ready    control-plane   6d22h   v1.36.4+k3s1
  compute-0-1   Ready    <none>          6d22h   v1.36.4+k3s1
  compute-0-2   Ready    <none>          6d22h   v1.36.4+k3s1
  compute-0-3   Ready    <none>          54s     v1.36.4+k3s1

**Lo que se arregla solo**, sin que nadie lo pida:

* el **DaemonSet** de node-exporter le pone su copia y Prometheus empieza a recogerlo;
* el **svclb** de Traefik hace lo mismo, y los tres Ingress pasan a anunciar cuatro direcciones;
* el **planificador** empieza a mandarle Pods.

**Lo que no**, y son justo las dos cosas que ya sabemos del caso anterior:

.. code-block:: bash

  root@compute-0-0:~# kubectl get pods -o wide | grep compute-0-3
  web-tunombre-54f95d7999-7xwhr   0/1   ContainerCreating   0   2m   compute-0-3

  root@compute-0-0:~# kubectl describe pod web-tunombre-54f95d7999-7xwhr | grep -A3 Events:
  Warning  FailedMount  16s (x7 over 47s)  kubelet
    MountVolume.SetUp failed for volume "pv-tunombre" : mount failed: exit status 32
    Mounting arguments: -t nfs 172.16.0.10:/srv/tunombre ...

* La **imagen propia** no está en su containerd, porque cada nodo tiene su propio almacén: hay que llevársela con ``scp`` y ``k3s ctr images import``, como hicimos con los demás.
* El **cliente de NFS** tampoco está: sin ``nfs-common`` el Pod se queda en ``ContainerCreating`` con ese ``exit status 32``, que es el mismo aviso de la sección de almacenamiento persistente.

.. code-block:: bash

  root@compute-0-0:~# scp web-tunombre-1.0.tar 172.16.0.13:/root/
  root@compute-0-0:~# ssh 172.16.0.13 "k3s ctr images import /root/web-tunombre-1.0.tar"
  root@compute-0-0:~# ssh 172.16.0.13 "apt install -y nfs-common"

  root@compute-0-0:~# kubectl get pods -l app=web-tunombre \
      -o custom-columns=ESTADO:.status.phase,NODO:.spec.nodeName --no-headers | sort | uniq -c
        1 Running compute-0-0
        1 Running compute-0-1
        1 Running compute-0-2
        1 Running compute-0-3

Esa es la diferencia entre lo que **Kubernetes** mantiene —los Pods, los servicios, la monitorización— y lo que sigue siendo **administración de sistemas** de toda la vida: los paquetes y las imágenes de cada máquina. Un nodo recién añadido está en el clúster desde el primer minuto, pero no sirve para todo hasta que alguien lo prepara. En un sistema de verdad eso se resuelve con un registro de imágenes y con el Ansible de la tarea 08.


Deshacer lo instalado
^^^^^^^^^^^^^^^^^^^^^^

Todo lo que ha entrado por Helm sale por Helm, que es otra de las razones de usarlo: no hay que acordarse de qué objetos creó cada cosa.

.. code-block:: bash

  root@compute-0-0:~/09# helm list -A
  NAME          NAMESPACE     REVISION  STATUS    CHART                         APP VERSION
  minio         minio         4         deployed  minio-5.4.0                   RELEASE.2024-12-18T13-15-44Z
  monitor       monitoring    1         deployed  kube-prometheus-stack-91.4.1  v0.94.0
  traefik       kube-system   1         deployed  traefik-40.1.4+up40.1.0       v3.7.1
  traefik-crd   kube-system   1         deployed  traefik-crd-40.1.4+up40.1.0   v3.7.1
  web-tunombre  default       3         deployed  web-tunombre-0.1.0            1.0

  root@compute-0-0:~/09# helm uninstall monitor -n monitoring
  root@compute-0-0:~/09# helm uninstall minio -n minio
  root@compute-0-0:~/09# helm uninstall web-tunombre

Los dos ``traefik`` de la lista **no se tocan**: son de k3s, y si los quitas te quedas sin Ingress.

.. note::

  ``helm uninstall`` **no borra los PersistentVolumeClaim**: los datos de MinIO y de Prometheus siguen ocupando disco a propósito, para que una reinstalación los recupere. Si quieres el espacio de vuelta hay que borrarlos a mano con ``kubectl delete pvc``, y los *namespaces* con ``kubectl delete namespace``.
