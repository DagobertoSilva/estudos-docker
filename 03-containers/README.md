# Seu primeiro container
### Colocar um servidor web no ar com um único comando.

# Passo 1 · Executar o Nginx

###  No Terminal
``` 
docker run -d -p 8080:80 --name meu-nginx nginx
```

### Saída Esperada (aproximada)
``` 
07ddb02437cb47867097dac885c6cf7cd75c53c0467bf2daa4cc617a614fb7a1
```

## Entenda cada parte do comando:

| Trecho | Significado |
|---|---|
| docker run | Cria e inicia um container novo |
| -d |  detached: roda em segundo plano e devolve o terminal |
| -p 8080:80 | Mapeia a porta 8080 do seu computador para a porta 80 do container (formato HOST:CONTAINER) |
| --name meu-nginx| Dá um nome ao container (senão o Docker inventa um aleatório) |
| nginx | Imagem usada (sempre o último argumento antes de um eventual comando) |

###  No Terminal
``` 
docker ps
```

### Saída Esperada (aproximada)
``` 
CONTAINER ID  IMAGE  STATUS             PORTS                   NAMES
07ddb02437cb  nginx  Up About a minute  0.0.0.0:8080->80/tcp    meu-nginx
(algumas colunas omitidas: COMMAND e CREATED)
```

# Passo 3 · Acessar no navegador

### Abra http://localhost:8080. Deve aparecer a página “Welcome to nginx!”.

## Também é possível testar pelo terminal:

``` 
curl http://localhost:8080
```

### Saída Esperada no Navegador (aproximada)
``` 
Welcome to nginx!
If you see this page, nginx is successfully installed and working. Further configuration is required for the web server, reverse proxy, API gateway, load balancer, content cache, or other features.

For online documentation and support please refer to nginx.org.
To engage with the community please visit community.nginx.org.
For enterprise grade support, professional services, additional security features and capabilities please refer to f5.com/nginx.

Thank you for using nginx.
```

### O que aconteceu? 
``` 
O navegador falou com a porta 8080 do seu computador; o Docker repassou a requisição para a
porta 80 dentro do container, onde o Nginx estava escutando. O Nginx não está instalado no
seu sistema — ele vive só dentro do container.
```