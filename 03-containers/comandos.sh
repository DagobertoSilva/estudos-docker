# Criar e iniciar um container
docker run -d -p 8080:80 --name meu-nginx nginx

# Listar os containers em execução
docker ps

# Listar todos, inclusive os parados
docker ps -a

# Consultar os logs
docker logs meu-nginx

# Acompanhar os logs
docker logs -f meu-nginx

# Entrar no container
docker exec -it meu-nginx sh

# Parar e iniciar novamente
docker stop meu-nginx
docker start meu-nginx

# Remover o container
docker rm -f meu-nginx