# Criar uma rede
docker network create app-net

# Criar o servidor
docker run -d \
  --name servidor \
  --network app-net \
  nginx:alpine

# Abrir um cliente temporário na mesma rede
docker run --rm -it \
  --name cliente \
  --network app-net \
  alpine sh