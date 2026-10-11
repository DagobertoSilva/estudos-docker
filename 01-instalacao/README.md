# Passo 1. Instalação
 Acesse https://docs.docker.com/get-started/get-docker/

# escolha seu sistema:
- Windows: Docker Desktop (exige WSL 2 habilitado — o instalador orienta).
- macOS: Docker Desktop (escolha a versão Apple Silicon ou Intel).
- Linux: Docker Desktop ou apenas o Docker Engine (pacote da sua distribuição)

``` 
Atenção
No Windows e no macOS, o Docker Desktop precisa estar aberto (ícone da baleia ativo)
para os comandos funcionarem. Se aparecer “Cannot connect to the Docker daemon”, abra o
app.

```

# Passo 2 · Verificar a versão

###  No Terminal
``` 
$ docker --version
$ docker compose version
```

### Saída Esperada (aproximada)
``` 
Docker version 29.7.2, build a7dcaa6
Docker Compose version v2.x.x
```

# Passo 3 · Rodar o teste oficial
###  No Terminal
``` 
$ docker run hello-world
```

## caso apresente um erro  

``` 
failed to connect to the docker API at npipe:////./pipe/dockerDesktopLinuxEngine; check if the path is correct and if the daemon is running: open //./pipe/dockerDesktopLinuxEngine: The system cannot find the file specified.
```

## abra o app do Docker qquando ele iniciar rode o comando anterior novamente

### Saída Esperada (aproximada)
``` 
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
...
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

### o que aconteceu?
``` 
O Docker não achou a imagem hello-world no seu computador, baixou do Docker Hub, criou
um container, executou o programa (que só imprime a mensagem) e o container terminou. Você

```

### Atenção
``` 
Linux: se aparecer “permission denied … docker.sock”, adicione seu usuário ao grupo docker
com sudo usermod -aG docker $USER, faça logout e login de novo.


```