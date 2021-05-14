Главные объекты k8s
1. Pod        - объект в котором работают один или больше контейнеров.
2. Deployment - сет одинаковых Pods, нужен для AutoScaling и для обновления
Container Image, держит минимальное количество работающих Pods.
3. Service    - предоставлет доступ к Deployment через
                  = ClusterIP
                  = NodePort
                  = LoadBalancer
                  = ExternalName
4. Nodes      - сервера, где все это работает
5. Cluster    - логическое объедиение Nodes.

#Установка kubectl

`curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl`

`chmod +x ./kubectl`

`sudo mv ./kubectl /usr/local/bin/kubectl`


#Установка minikube

`curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube`

`sudo mkdir -p /usr/local/bin/`

`sudo install minikube /usr/local/bin/`

#Запуск minikube

`minikube start`

#Проверка состояния кластера

`minikube status`

#Остановка кластера

`minikube stop`

#Сравнение Ingress Controllers
`https://docs.google.com/spreadsheets/d/191WWNpjJ2za6-nbG4ZoUMXMpUK8KlCIosvQB0f-oq3k/edit#gid=907731238`
