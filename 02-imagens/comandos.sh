# Procurar imagens
docker search nginx

# Baixar imagens
docker pull nginx
docker pull alpine
docker pull nginx:alpine

# Listar imagens locais
docker images

# Consultar detalhes de uma imagem
docker image inspect nginx

# Remover uma imagem, caso não esteja em uso
docker rmi nginx:alpine