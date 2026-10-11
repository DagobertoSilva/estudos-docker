# Criando sua própria imagem (Dockerfile)
### Empacote sua aplicação em uma imagem que roda igual em qualquer máquina.

# Passo 1 · Criar a pasta do projeto


###  No Terminal
``` 
mkdir minha-imagem
cd minha-imagem
code .       
```

### code .   abre o VS Code (ou use outro editor)

# Passo 2 · Criar a página da aplicação

### ARQUIVO: minha-imagem/index.html
``` 
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Minha aplicação</title>
</head>
<body>
  <h1>Olá, Docker!</h1>
  <p>Esta página está rodando em uma imagem criada por mim.</p>
</body>
</html>
```


# Passo 3 · Criar o Dockerfile (sem extensão)

### ARQUIVO: minha-imagem/Dockerfile
``` 
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
```

| Trecho | Significado |
|---|---|
|FROM | Imagem base sobre a qual a sua será construída|
| COPY | Copia arquivos do seu computador para dentro da imagem para o diretório que o Nginx utiliza para servir os arquivos. |
| WORKDIR | Define a pasta de trabalho (usado em apps Node, Python…) |
|RUN | Executa um comando durante a construção (ex.: instalar dependências)|
|EXPOSE | Documenta a porta em que a aplicação escuta|
|CMD | Comando executado quando o container inicia|

### Atenção O nome deve ser exatamente Dockerfile, com D maiúsculo e sem “.txt” no final. No Windows, ative “Mostrar extensões de arquivo” para conferir.

# Passo 4 · Construir a imagem

### No terminal
```
docker build -t minha-web:1.0 .
```

### Saída Esperada
```
[+] Building 0.2s (7/7) FINISHED
 => [1/2] FROM docker.io/library/nginx:latest@sha256:05b8cb...
 => [2/2] COPY index.html /usr/share/nginx/html/index.html
 => => naming to docker.io/library/minha-web:1.0
```

### O que aconteceu? 
### -t minha-web:1.0 dá nome e versão (tag) à imagem. O ponto final é o contexto de build: a pasta atual, onde o Docker procura o Dockerfile e os arquivos do COPY. Esquecer o ponto é oerro mais comum aqui

# Passo 5 · Conferir e executar

### No terminal
```
docker images
docker run -d -p 8080:80 --name minha-web minha-web:1.0
```

### Saída Esperada
```
IMAGE           ID             DISK USAGE   CONTENT SIZE
minha-web:1.0   2f490491c362   268MB        65MB
nginx:latest    05b8cb60c354   271MB        67.9MB
```

### Abra http://localhost:8080 — agora aparece “Olá, Docker!”.

# Passo 6 · Versionar: criar a versão 2.0

### Altere o "h1" do index.html para Olá, Docker! — versão 2 e reconstrua:

### No terminal
```
docker build -t minha-web:2.0 .
```
```
docker rm -f minha-web
```
```
docker run -d -p 8080:80 --name minha-web minha-web:2.0
```
### Abra http://localhost:8080 — agora aparece “Olá, Docker! — versão 2 !”.
### O que aconteceu?
A imagem 1.0 continua intacta — imagens são imutáveis. Para voltar atrás basta rodar a 1.0 de
novo. É assim que se faz rollback em produção. Repare também que o build foi rapidíssimo: a
camada FROM veio do cache.

### No terminal
```
$ docker rm -f minha-web     
```

### $ docker rm -f minha-web   libera a porta 8080 para a próxima parte