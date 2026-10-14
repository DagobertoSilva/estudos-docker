# Volumes: persistência de dados - 
### Por padrão, tudo que é gravado dentro de um container some quando ele é removido.

# Experimento A — sem volume
# Passo 1 · Subir um container e alterar a página


### No terminal
```
docker run -d --name nginx-sem-volume -p 8080:80 nginx
````
```
docker exec nginx-sem-volume sh -c "echo '<h1>Hello World.</h1>' > /usr/share/nginx/html/index.html"
```

### Acesse http://localhost:8080: aparece Hello World.

# Passo 2 · Remover e recriar


### No terminal
```
docker rm -f nginx-sem-volume
 ```
```
docker run -d --name nginx-sem-volume -p 8080:80 nginx
```
### Acesse de novo http://localhost:8080 : voltou o “Welcome to nginx!”. A alteração foi perdida.

# O que aconteceu? Cada container tem uma camada gravável própria, por cima da imagem. Ao remover o container, essa camada é apagada junto. Isso é ótimo para reprodutibilidade, péssimo para um banco de dados.

# Experimento B — com volume

# Passo 3 · Criar um volume


### No terminal
```
docker rm -f nginx-sem-volume
```
```
docker volume create meus-dados
```
```
docker volume ls
```

### Saída Esperada
```
DRIVER    VOLUME NAME
local     meus-dados
```

# Passo 4 · Subir o container usando o volume e alterar a página

### No terminal
```
docker run -d --name nginx-com-volume -p 8080:80 -v meus-dados:/usr/share/nginx/html nginx
```
```
docker exec nginx-com-volume sh -c "echo '<h1>Hello World</h1>' > /usr/share/nginx/html/index.html"
```


# Passo 5 · Remover e recriar — o teste decisivo

### No terminal
```
docker rm -f nginx-com-volume
```
```
docker run -d --name nginx-com-volume -p 8080:80 -v meus-dados:/usr/share/nginx/html nginx
```

### Acesse http://localhost:8080: Hello World continua lá. Os dados sobreviveram ao container.

### O que aconteceu?-v meus-dados:/usr/share/nginx/html liga o volume (gerenciado pelo Docker, fora do container) à pasta interna. O container foi destruído; o volume, não. Detalhe: na primeira vez, como o volume estava vazio, o Docker copiou para ele o conteúdo original da pasta da imagem.


# Passo 6 · Inspecionar o volume
### No terminal
```
docker volume inspect meus-dados
```
### Mostra onde os dados ficam no host (campo Mountpoint).


# Bônus — bind mount (pasta do seu computador)
### Em desenvolvimento é comum montar uma pasta sua diretamente. 

# Dentro de uma pasta minha-imagem:

### No terminal
```
docker rm -f nginx-com-volume
```
```
docker run -d --name dev -p 8080:80 -v "${PWD}:/usr/share/nginx/html" nginx
```
### Edite o index.html no VS Code, salve e recarregue o navegador: a mudança aparece na hora, sem rebuild.

Acesse de novo http://localhost:8080

### No PowerShell do Windows, use `${PWD}` no lugar de `$(pwd)`. No CMD, use `%cd%`.

### No terminal
```
docker rm -f dev
``` 
