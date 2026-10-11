# Conceito:
### Imagens são os modelos a partir dos quais containers nascem.



# Passo 1 · Procurar uma imagem

###  No Terminal
``` 
$ docker search nginx
```


### Lista imagens do Docker Hub. Prefira as marcadas como [OK] na coluna OFFICIAL.

### Saída Esperada (aproximada)
``` 
NAME                                     DESCRIPTION                                     STARS     OFFICIAL
nginx                                    Official build of Nginx.                        21407     [OK]
nginx/nginx-ingress                      NGINX and  NGINX Plus Ingress Controllers fo…   123       
nginx/nginx-prometheus-exporter          NGINX Prometheus Exporter for NGINX and NGIN…   52        
nginx/nginx-ingress-operator             NGINX Ingress Operator for NGINX and NGINX P…   4         
nginx/nginxaas-loadbalancer-kubernetes                                                   1         
bitnamicharts/nginx                      Bitnami Helm chart for NGINX Open Source        4         
ubuntu/nginx                             Nginx, a high-performance reverse proxy & we…   143       
kasmweb/nginx                            An Nginx image based off nginx:alpine and in…   9         
rancher/nginx                                                                            4         
linuxserver/nginx                        An Nginx container, brought to you by LinuxS…   236       
dtagdevsec/nginx                         T-Pot Nginx                                     0         
paketobuildpacks/nginx                                                                   0         
activestate/nginx                        ActiveState's customizable, low-to-no vulner…   0         
cleanstart/nginx                         Secure by Design, Built for Speed, Hardened …   0         
vmware/nginx                                                                             3         
gluufederation/nginx                      A customized NGINX image containing a consu…   1         
antrea/nginx                             Nginx server used for Antrea e2e testing        0         
intel/nginx                                                                              0         
docksal/nginx                            Nginx service image for Docksal                 1         
geokrety/nginx                           Our customized nginx image                      0         
ilios/nginx                              Nginx customized to run Ilios along with the…   0         
circleci/nginx                           This image is for internal use                  2         
dockette/nginx                           Nginx SSL / HSTS / HTTP2                        3         
wayofdev/nginx                           Nginx Docker image for PHP development. SSL-…   0         
corpusops/nginx                          https://github.com/corpusops/docker-images/     1  
```

# Passo 2 · Baixar a imagem do Nginx

###  No Terminal
``` 
$ docker pull nginx
```

### Saída Esperada (aproximada)
``` 
Using default tag: latest
latest: Pulling from library/nginx
a3d95972273c: Pull complete
50355e0ebcbc: Pull complete
...
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest
```

### O que aconteceu?
``` 
Cada linha “Pull complete” é uma camada da imagem (SO base, dependências, aplicação).
Como nenhuma tag foi informada, o Docker usou latest. O nome completo é
docker.io/library/nginx:latest = registry / repositório / nome : tag.
```

# Passo 3 · Baixar mais duas imagens que usaremos depois
###  No Terminal
``` 
$ docker pull alpine
$ docker pull nginx:alpine
```

# Passo 4 · Listar as imagens locais

###  No Terminal
``` 
$ docker images
```

### Saída Esperada (aproximada)
``` 
IMAGE          ID             DISK USAGE   CONTENT SIZE
nginx:latest   05b8cb60c354   271MB        67.9MB
nginx:alpine   ...            ~80MB        ~22MB
alpine:latest  ...            ~13MB        ~4MB
```

# Passo 5 · Remover uma imagem


###  No Terminal
``` 
$ docker rmi nginx:alpine
$ docker images
```

### Atenção
``` 
Não é possível remover uma imagem que está sendo usada por algum container (mesmo
parado). Remova o container primeiro, ou use docker rmi -f.
```