# Conceitos fundamentais do Docker

## 1. Imagem

Uma imagem é um **modelo imutável** utilizado para criar containers. Ela reúne a aplicação e os componentes necessários para executá-la. Ela é a receita do bolo, semelhante a uma clase do java.

Exemplo: `nginx:latest`.

## 2. Container

É uma instância criada a partir de uma imagem. Pode ser executada, parada, reiniciada e removida ( Tem ciclo de vida).

Exemplo:

```bash
docker run -d --name meu-nginx -p 8080:80 nginx
```

## 3. Volume

É um mecanismo de **armazenamento persistente** gerenciado pelo Docker. Pode manter dados mesmo depois que um container é removido.

## 4. Rede

Permite que containers se comuniquem. Em uma rede Docker criada pelo usuário, os serviços podem ser encontrados pelo nome.

## 5. Diferença entre imagem e container

A imagem funciona como um modelo; o container é uma instância criada a partir desse modelo.