***************************************************************
Caso práctico: Helm, observabilidad y almacenamiento de objetos
***************************************************************

Seguimos sobre **el mismo clúster** del :doc:`caso anterior <14_kubernetes_k3s>`, sin borrar ni reinstalar nada: los nodos que ya tenemos, el NFS de compute-0-0 y la aplicación ``web-tunombre`` desplegada con su imagen propia. Lo que cambia es la forma de trabajar. Hasta ahora hemos escrito los YAML a mano y hemos mirado el clúster con ``kubectl`` y ``k9s``, que enseña lo que pasa **ahora mismo**. Un administrador de verdad hace otras dos cosas: **instala software empaquetado** en lugar de escribirlo, y **guarda el histórico** de lo que ha pasado para poder mirarlo después.

Vamos a montar tres piezas encima de lo que ya hay:

* **Helm**, el gestor de paquetes de Kubernetes: lo que ``apt`` es a Ubuntu.
* **Prometheus y Grafana**, para ver el clúster con gráficas y con histórico.
* **MinIO**, un almacén de objetos compatible con S3, y una copia de seguridad automática del NFS contra él.

Helm, el gestor de paquetes de Kubernetes
=========================================

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
====================================

Antes de instalar paquetes de otros, empaquetamos el nuestro: así se ve qué hay dentro de un chart. ``helm create`` deja un esqueleto de ejemplo del que nos quedamos con la estructura:

.. code-block:: bash

  root@compute-0-0:~/09# helm create web-tunombre-chart
  Creating web-tunombre-chart

  root@compute-0-0:~/09# tree web-tunombre-chart/
  web-tunombre-chart/
  ├── charts
  ├── Chart.yaml
  ├── templates
  │   ├── deployment.yaml
  │   ├── _helpers.tpl
  │   ├── hpa.yaml
  │   ├── httproute.yaml
  │   ├── ingress.yaml
  │   ├── NOTES.txt
  │   ├── serviceaccount.yaml
  │   ├── service.yaml
  │   └── tests
  │       └── test-connection.yaml
  └── values.yaml

Lo que nos interesa son tres sitios: ``Chart.yaml`` (el nombre y la versión del paquete), ``values.yaml`` (los valores) y ``templates/`` (los YAML, con huecos). Las plantillas de ejemplo que trae son mucho más complicadas de lo que necesitamos, así que las borramos y ponemos las nuestras, que son **exactamente los ficheros del caso anterior** con los valores sustituidos por huecos:

.. code-block:: bash

  root@compute-0-0:~/09# rm -rf web-tunombre-chart/templates/* web-tunombre-chart/charts

``web-tunombre-chart/Chart.yaml``:

.. code-block:: yaml

  apiVersion: v2
  name: web-tunombre
  description: La aplicacion web del caso practico anterior, empaquetada como chart
  type: application
  version: 0.1.0
  appVersion: "1.0"

``web-tunombre-chart/values.yaml``:

.. code-block:: yaml

  replicaCount: 4

  image:
    repository: web-tunombre
    tag: "1.0"
    pullPolicy: IfNotPresent

  titulo: "Hola, soy tunombre"
  usuario: "tunombre"
  clave: "MiClaveSecreta"

  service:
    nodePort: 30080

  ingress:
    host: web-tunombre.local

  nfs:
    claimName: pvc-tunombre

En ``templates/`` van cinco ficheros —``configmap.yaml``, ``secret.yaml``, ``deployment.yaml``, ``service.yaml`` e ``ingress.yaml``—, los mismos objetos del caso anterior. Los dos pequeños enseñan la idea entera:

``web-tunombre-chart/templates/configmap.yaml``:

.. code-block:: yaml

  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: {{ .Release.Name }}-config
  data:
    titulo: {{ .Values.titulo | quote }}
    usuario: {{ .Values.usuario | quote }}

``web-tunombre-chart/templates/secret.yaml``:

.. code-block:: yaml

  apiVersion: v1
  kind: Secret
  metadata:
    name: {{ .Release.Name }}-secret
  type: Opaque
  stringData:
    clave: {{ .Values.clave | quote }}

Y el Deployment, que es el de siempre con los valores sacados fuera:

``web-tunombre-chart/templates/deployment.yaml``:

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
              - name: USUARIO
                valueFrom:
                  configMapKeyRef:
                    name: {{ .Release.Name }}-config
                    key: usuario
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

El Service y el Ingress, igual:

``web-tunombre-chart/templates/service.yaml``:

.. code-block:: yaml

  apiVersion: v1
  kind: Service
  metadata:
    name: {{ .Release.Name }}
  spec:
    type: NodePort
    selector:
      app: {{ .Release.Name }}
    ports:
      - port: 80
        targetPort: 80
        nodePort: {{ .Values.service.nodePort }}

``web-tunombre-chart/templates/ingress.yaml``:

.. code-block:: yaml

  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: {{ .Release.Name }}
  spec:
    rules:
      - host: {{ .Values.ingress.host }}
        http:
          paths:
            - path: /
              pathType: Prefix
              backend:
                service:
                  name: {{ .Release.Name }}
                  port:
                    number: 80

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
    usuario: "tunombre"

Fíjate en que al llamar a la *release* ``prueba``, **todos** los objetos han pasado a llamarse ``prueba-...``. Eso es lo que permite instalar el mismo chart dos veces en el mismo clúster sin que choquen.

Como la aplicación del caso anterior sigue desplegada, la quitamos primero para no chocar con el mismo NodePort y el mismo Ingress. El PersistentVolume y su PVC **no se tocan**: los queremos:

.. code-block:: bash

  root@compute-0-0:~/09# kubectl delete -f web-tunombre.yml -f ingress-tunombre.yml -f config-tunombre.yml
  deployment.apps "web-tunombre" deleted from default namespace
  service "web-tunombre" deleted from default namespace
  ingress.networking.k8s.io "web-tunombre" deleted from default namespace
  configmap "web-tunombre-config" deleted from default namespace
  secret "web-tunombre-secret" deleted from default namespace
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
======================

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
  root@compute-0-0:~/09# for n in 1 2 3 4; do
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
====================================

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
======================

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
=======================================

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
==============================================

Merece la pena añadir un nodo **ahora**, con el clúster lleno, y ver qué se apaña solo y qué no. Creamos una sexta máquina, **compute-0-5**, clon enlazado de **MV Ubuntu Server** con 4 GB de memoria y la tarjeta en "Red interna" : 172.16.0.15/16. Para poder llamarla por su nombre desde compute-0-0, como a las demás, la añadimos a su ``/etc/hosts`` (si no la tienes ya), y la unimos con el mismo comando de siempre, lanzado desde compute-0-0:

.. code-block:: bash

  root@compute-0-0:~# echo "172.16.0.15 compute-0-5" >> /etc/hosts

  root@compute-0-0:~# ssh -n compute-0-5 "curl -fL https://get.k3s.io | \
      K3S_URL=https://172.16.0.10:6443 \
      K3S_TOKEN='$(cat /var/lib/rancher/k3s/server/node-token)' sh -"
  [INFO]  systemd: Enabling k3s-agent unit
  [INFO]  systemd: Starting k3s-agent

  root@compute-0-0:~# kubectl get nodes
  NAME          STATUS   ROLES           AGE     VERSION
  compute-0-0   Ready    control-plane   6d22h   v1.36.4+k3s1
  compute-0-1   Ready    <none>          6d22h   v1.36.4+k3s1
  compute-0-2   Ready    <none>          6d22h   v1.36.4+k3s1
  compute-0-3   Ready    <none>          6d22h   v1.36.4+k3s1
  compute-0-4   Ready    <none>          6d21h   v1.36.4+k3s1
  compute-0-5   Ready    <none>          54s     v1.36.4+k3s1

**Lo que se arregla solo**, sin que nadie lo pida:

* el **DaemonSet** de node-exporter le pone su copia y Prometheus empieza a recogerlo;
* el **svclb** de Traefik hace lo mismo, y los tres Ingress pasan a anunciar seis direcciones.

Se ve pidiendo los Pods de ese nodo:

.. code-block:: bash

  root@compute-0-0:~# kubectl get pods -A -o wide --field-selector spec.nodeName=compute-0-5

**Lo que no** se arregla solo es nuestra aplicación: en compute-0-5 no hay **ningún** Pod de ``web-tunombre``. El planificador solo decide dónde va un Pod **cuando se crea**, y los que ya estaban funcionando en los otros cinco nodos se quedan donde están. Kubernetes no los mueve para repartir la carga.

Para que la aplicación use el nodo nuevo hay que **recrear los Pods**, pero antes hay que preparar el nodo, porque le faltan justo las dos cosas que ya sabemos del caso anterior:

* La **imagen propia** no está en su containerd, porque cada nodo tiene su propio almacén: hay que llevársela con ``scp`` e importarla con ``k3s ctr images import``, como hicimos con los demás.
* El **cliente de NFS** tampoco está: sin ``nfs-common`` el Pod se quedaría en ``ContainerCreating`` con el ``exit status 32`` de la sección de almacenamiento persistente.

.. code-block:: bash

  root@compute-0-0:~# scp web-tunombre-1.0.tar compute-0-5:/root/
  root@compute-0-0:~# ssh compute-0-5 "k3s ctr images import /root/web-tunombre-1.0.tar"
  root@compute-0-0:~# ssh compute-0-5 "k3s ctr images ls | grep web-tunombre"
  root@compute-0-0:~# ssh compute-0-5 "apt install -y nfs-common"

Ahora sí, recreamos los Pods. ``rollout restart`` crea Pods nuevos uno a uno y va borrando los viejos, sin cortar el servicio, y como son nuevos el planificador ya cuenta con compute-0-5:

.. code-block:: bash

  root@compute-0-0:~# kubectl rollout restart deployment/web-tunombre
  deployment.apps/web-tunombre restarted

  root@compute-0-0:~# kubectl rollout status deployment/web-tunombre
  deployment "web-tunombre" successfully rolled out

  root@compute-0-0:~# kubectl get pods -o wide

Por defecto el planificador **tiende** a repartir las réplicas entre los nodos, pero no lo garantiza: a compute-0-5 le puede tocar una, dos o, alguna vez, ninguna. Si hay que asegurar el reparto, el Deployment admite ``topologySpreadConstraints``, que impiden que un nodo tenga más réplicas que otro.

Esa es la diferencia entre lo que **Kubernetes** mantiene —los Pods, los servicios, la monitorización— y lo que sigue siendo **administración de sistemas** de toda la vida: los paquetes y las imágenes de cada máquina. Un nodo recién añadido está en el clúster desde el primer minuto, pero no sirve para todo hasta que alguien lo prepara. En un sistema de verdad eso se resuelve con un registro de imágenes y con el Ansible de la tarea 08.


Deshacer lo instalado
======================

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
