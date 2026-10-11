# Ciclo de vida do container
### Criar → executar → parar → reiniciar → remover

# Passo 1 · Parar o container

###  No Terminal
``` 
docker stop meu-nginx
docker ps
```

### Saída Esperada (aproximada)
``` 
meu-nginx
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

### A lista ficou vazia porque docker ps mostra só os que estão rodando. 

### Para ver todos, inclusive os parados:
###  No Terminal
``` 
docker ps -a
```

### Saída Esperada (aproximada)
``` 
CONTAINER ID  IMAGE  ...  STATUS                     NAMES
07ddb02437cb  nginx  ...  Exited (0) 10 seconds ago  meu-nginx
```

### Recarregue http://localhost:8080 — a página não abre mais.

# Passo 2 · Iniciar novamente
###  No Terminal
``` 
docker start meu-nginx
docker ps
```

### Saída Esperada (aproximada)
``` 
meu-nginx
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
07ddb02437cb  nginx  ...  9 minutes ago  Up 2 seconds  0.0.0.0:8080->80/tcp  meu-nginx
```

### O que aconteceu?

```
Observe: CREATED continua “9 minutes ago”, mas STATUS é “Up 2 seconds”. É o mesmo
container sendo religado, não um novo. Com docker restart meu-nginx você faz stop + start
em um comando.
```

### Recarregue http://localhost:8080 — a página abre Novamente.

# Passo 3 · Ver os logs

###  No Terminal
``` 
docker logs meu-nginx
docker logs -f meu-nginx 
```

### docker logs -f meu-nginx acompanha em tempo real (Ctrl+C sai)


Com o **docker logs -f meu-nginx** ativo, recarregue a página no navegador algumas vezes: cada acesso gera uma
linha de log com IP, horário e o caminho requisitado.

# Passo 4 · Entrar no container

###  No Terminal
``` 
docker exec -it meu-nginx bash
```

### DENTRO DO CONTAINER
``` 
/ # ls /usr/share/nginx/html
/ # cat /etc/os-release
/ # exit
```

### O que aconteceu?

```
exec roda um comando em um container que já está em execução. -it = interativo + terminal.
Você está num “mini Linux” isolado. Imagens baseadas em Alpine não têm bash; use sh no
lugar.
```

# Passo 5 · Remover o container
###  No Terminal
``` 
docker rm -f meu-nginx
docker ps -a
```

### Saída Esperada (aproximada)
``` 
meu-nginx
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS   NAMES
```

### Dica:
```
docker rm só remove containers parados; -f força (para e remove). A imagem nginx continua
no disco — confira com docker images.

```

# Prática - CRIANDO MINHA IMAGEM

# Etapa 1— Entre na pasta correta
###  No Terminal
``` 
cd 04-dockerfile/nginx-personalizado
```

###  No Terminal, Para confirmar que você entrou na pasta correta:
``` 
Get-Location
```


### No Terminal, Agora liste os arquivos:
``` 
Get-ChildItem
```
### Você deverá encontrar um arquivo chamado Dockerfile e, possivelmente, um arquivo HTML, como index.html.
Se a pasta não existir, volte à raiz do repositório e confira os nomes das pastas com Get-ChildItem.

# Etapa 2 — Entenda o Dockerfile
``` 
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```

| Trecho | Significado |
|---|---|
| FROM nginx:alpine |utiliza uma imagem do Nginx baseada no Alpine Linux.|
| COPY index.html /usr/share/nginx/html/index.html | copia sua página HTML para o diretório que o Nginx utiliza para servir os arquivos. |
| -p 8080:80 | Mapeia a porta 8080 do seu computador para a porta 80 do container (formato HOST:CONTAINER) |
| EXPOSE 80 | documenta que a aplicação utiliza a porta 80 dentro do contêiner. Essa instrução, sozinha, não publica a porta no computador.

###  No Terminal, para confirer o conteúdo do DockerFile
``` 
Get-Content Dockerfile
```

# Etapa 3 — Crie sua página personalizada

### No arquivo index.html
``` 

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Web Docker</title>
</head>
<body>
    <h1>Minha primeira imagem Docker personalizada!</h1>
    <p>Esta página está sendo servida pelo Nginx.</p>
</body>
</html>

```

### Salve o arquivo como index.html dentro de nginx-personalizado.

# Etapa 4 — Construa sua imagem

###  No Terminal
``` 
docker build -t minha-web:1.0 .
```

| Trecho | Significado |
|---|---|
| docker build |	Constrói uma imagem. |
| -t | Define nome e etiqueta da imagem.|
| -minha-web|	Nome da imagem. |
| 1.0 | Etiqueta, ou versão, da imagem.|
| .	| Usa a pasta atual como contexto de construção.|

### Espere o processo terminar. Se aparecer uma mensagem como Successfully tagged minha-web:1.0 ou naming to docker.io/library/minha-web:1.0, a imagem foi construída.


###  No Terminal
``` 
docker images
```

### Etapa 5 — Crie e execute o contêiner
### Antes de executar, vamos evitar o problema de porta ocupada que você encontrou anteriormente.
Confira se a porta 8080 está sendo utilizada:
``` 
docker ps
```

### Se outro contêiner estiver usando a porta 8080, você pode utilizar a porta 8081 para este exercício.
Execute:

###  No Terminal
``` 
docker run -d `
  --name minha-web `
  -p 8081:80 `
  minha-web:1.0
```

| Trecho | Significado |
|---|---|
| docker run | Cria e inicia um container novo |
| -d |  detached: roda em segundo plano e devolve o terminal |
| --name minha-web| atribui o nome minha-web ao contêiner. |
| -p 8081:80| direciona a porta 8081 do computador para a porta 80 do contêiner.|
|minha-web:1.0:| indica a imagem que será utilizada.|


### Recarregue http://localhost:8080 — a página abre .

# Etapa 6 — Verifique se está funcionando
### No terminal, Confira os contêineres em execução:
``` 
docker ps 
```

###  No terminal, Veja os logs
``` 
docker logs minha-web
```

### Agora acesse no navegador:
### http://localhost:8081/

### Se você vir o título “Minha primeira imagem Docker personalizada!”, seu exercício funcionou.

# Etapa 7 — Aprenda a atualizar sua página

### Imagine que você alterou o index.html e deseja mostrar uma mensagem nova.
Alterar o HTML não atualiza automaticamente a imagem que já foi construída. Você precisa reconstruir a imagem e recriar o contêiner.
1. Edite e salve o index.html.
2. Pare e remova o contêiner antigo:

### 1. No terminal , Para remover o contêiner antigo:
```
docker rm -f minha-web
```

### 2. Construa novamente a imagem:
### No terminal
```
docker build -t minha-web:1.0 .
```

### 3. Crie o contêiner novamente:
```
docker run -d --name minha-web -p 8081:80 minha-web:1.0
```

### 5. Atualize o navegador.
### http://localhost:8081/
