# Docker Compose
Tudo que você fez com vários comandos, descrito em um único arquivo.

# Por que Compose?
Uma aplicação real tem frontend, backend, banco, cache… Subir tudo à mão exige criar
redes, volumes, lembrar flags e respeitar a ordem de inicialização. O Compose descreve esse
ambiente em YAML: **reprodutível**, **versionável** no Git e com **configuração centralizada**.

# Passo 1 · Criar o docker-compose.yml
### Dentro da pasta **minha-imagem**:
### ARQUIVO: minha-imagem/docker-compose.yml
```
services:
  web:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - dados:/usr/share/nginx/html
    networks:
      - sd-net
volumes:
  dados:
networks:
  sd-net:
```

# Atenção
YAML é sensível à indentação: use espaços (nunca TAB), sempre 2 por nível. A linha version:
"3.9", vista em exemplos antigos, é obsoleta no Compose v2 e pode ser omitida.

# Compare com o que você fez manualmente:

| No Compose | Equivale a |
|---|---|
| image: nginx |latest a imagem no final do docker run|
| ports: "8080:80" |-p 8080:80 |
| volumes: dados:/usr/... | docker volume create + -v |
| networks: sd-net | docker network create + --network|


# Passo 2 · Subir a aplicação
### TERMINAL
```
docker compose up -d
```

### SAÍDA ESPERADA (aproximada)
```
[+] up 3/3
 ✔ Network minha-imagem_sd-net   Created
 ✔ Volume minha-imagem_dados     Created
 ✔ Container minha-imagem-web-1 Started
```

# O que aconteceu?
O Compose prefixou tudo com o nome da pasta (minha-imagem) para não misturar projetos.
Um comando criou rede, volume e container.

# Passo 3 · Verificar
### No Terminal 
```
docker compose ps
```
```
docker compose logs web
```
# Passo 4 · Copiar sua página para o container

### TERMINAL
```
docker cp .\index.html "$(docker compose ps -q web):/usr/share/nginx/html/index.html
```

### docker compose ps -q web devolve o ID do container do serviço “web”, usado como destinodo docker cp. 
## Abra http://localhost:8080.

# Passo 5 · Ver os recursos criados

### No Terminal
```
docker volume ls
```
```
docker network ls
```

### SAÍDA ESPERADA (aproximada)
```
local     meus-dados
local     minha-imagem_dados
...
8c39aa250f32   minha-imagem_sd-net   bridge   local
```

# Passo 6 · Derrubar a aplicação

### No Terminal
```
docker compose down
```

### SAÍDA ESPERADA (aproximada)
```
[+] down 2/2
 ✔ Container minha-imagem-web-1 Removed
 ✔ Network minha-imagem_sd-net   Removed
 ```

 # O que aconteceu?
down remove containers e redes, mas preserva os volumes — seus dados ficam salvos. Rode
docker compose up -d de novo e a página personalizada ainda estará lá. Para apagar também
os volumes: docker compose down -v.

|Comando |Efeito|
|---|---|
| docker compose up | Sobe tudo em primeiro plano (logs na tela, Ctrl+C para)|
|docker compose up -d | Sobe tudo em segundo plano |
| docker compose up -d --build | Reconstrói imagens com build: antes de subir|
| docker compose ps| Lista os serviços do projeto|
| docker compose logs -f web | Acompanha os logs de um serviço|
| docker compose exec web sh | Abre um terminal dentro do serviço|
| docker compose restart | Reinicia os serviços|
| docker compose stop |Para sem remover (dados mantidos)|
| docker compose down |Para e remove containers e redes|
| docker compose down -v |Remove também os volumes (apaga dados!)|
