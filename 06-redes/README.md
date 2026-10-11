# Redes: containers conversando

### Em sistemas distribuídos, serviços precisam se encontrar pelo nome.

# Experimento A — rede padrão

# Passo 1 · Criar servidor e cliente
### No terminal
```
docker run -d --name servidor nginx
```
```
docker run -it --name cliente alpine
```

### O segundo comando cria o container e já te coloca dentro dele. Tente acessar o servidor:

### DENTRO DO CLIENTE
/ # wget -qO- http://servidor
```
wget -qO- http://servidor
```

### SAÍDA ESPERADA (aproximada)
```
wget: bad address 'servidor'
```

### O que aconteceu?
Os dois estão na rede bridge padrão do Docker, que não tem DNS entre containers. O cliente
não sabe quem é “servidor”.

# Passo 2 · Sair e limpar
### DENTRO DO CLIENTE
/ # exit
```
exit
```

### No Terminal 
```
docker rm -f servidor cliente
```

#### Atenção Sem esse rm, o próximo passo falha com “Conflict. The container name "/servidor" is already inuse”.

# Experimento B — rede criada por você

# Passo 3 · Criar a rede e os containers nela

### No Terminal 
```
docker network create app-net
```
```
docker run -d --name servidor --network app-net nginx
```
```
docker run -it --name cliente --network app-net alpine
```

# DENTRO DO CLIENTE

```
wget -qO- http://servidor
```
```
ping -c 3 servidor
```
```
exit
```

### SAÍDA ESPERADA (aproximada)
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```

## O que aconteceu?
Em redes criadas pelo usuário, o Docker oferece um DNS interno: o nome do container vira um
endereço. É assim que um backend acha o banco com postgres:5432 ou db:5432, sem precisar
saber IPs (que mudam a cada recriação).

# Passo 4 · Inspecionar a rede
### No Terminal
```
docker network ls
```
```
docker network inspect app-net
```

### Na seção Containers aparecem os dois, cada um com seu IP interno.

# Dica
Repare que o servidor não usou -p. Containers na mesma rede conversam pela porta interna; o-p só é necessário para acessar do seu computador.

# TERMINAL
```
docker rm -f servidor cliente
```