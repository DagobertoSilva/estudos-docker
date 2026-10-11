# Desafio final: aplicação multi-serviço

### Juntando tudo: imagem própria + banco de dados + painel de administração.

# Você vai montar um ambiente com três serviços que se comunicam por uma rede interna:
-  web: sua imagem construída a partir do Dockerfile (porta 8080);
- db: PostgreSQL com volume para persistir os dados (sem porta exposta);
- adminer: painel web para administrar o banco (porta 8081).

# Passo 1 · Preparar a pasta

### No Terminal 
```
mkdir ~/desafio-compose && cd ~/desafio-compose
```

# Copie para essa pasta o index.html e o Dockerfile da Parte 4.

# Passo 2 · Criar o docker-compose.yml

### ARQUIVO: desafio-compose/docker-compose.yml

```
services:
  web:
    build: .
    image: minha-web:3.0
    ports:
      - "8080:80"
    networks:
      - backend
    depends_on:
      - db
  db:
    image: postgres:16
    environment:
      POSTGRES_USER: aluno
      POSTGRES_PASSWORD: senha123
      POSTGRES_DB: escola
    volumes:
      - pgdata:/var/lib/postgresql/data
    networks:
      - backend
  adminer:
    image: adminer
    ports:
      - "8081:8080"
    networks:
      - backend
    depends_on:
      - db
volumes:
  pgdata:
networks:
  backend:
```

|Novidade |O que faz|
|---|---|
| build: . |Constrói a imagem a partir do Dockerfile da pasta (em vez de baixar)|
|environment: | Variáveis de ambiente — aqui configuram usuário, senha e banco do Postgres|
| depends_on: | Define a ordem de inicialização (db sobe antes de web e adminer)|
| db sem ports: |O banco só é acessível de dentro da rede backend — mais seguro|

# Passo 3 · Subir tudo
### No Terminal

```
docker compose up -d --build
```
```
docker compose ps
```

# Passo 4 · Testar
- http://localhost:8080 → sua página.
- http://localhost:8081 → Adminer. Faça login com: Sistema PostgreSQL, Servidor db,
Usuário aluno, Senha senha123, Base de dados escola.

# O que aconteceu?
No campo “Servidor” você digitou db — o nome do serviço. O Adminer achou o Postgres pelo
DNS interno da rede, exatamente como o cliente achou o servidor na Parte 7.

# Passo 5 · Criar dados e provar a persistência

### No Adminer, clique em Comando SQL e execute:
### ARQUIVO: SQL no Adminer
```
CREATE TABLE alunos (id SERIAL PRIMARY KEY, nome TEXT);
INSERT INTO alunos (nome) VALUES ('Ana'), ('Bruno'), ('Carla');
```

### Ou pelo terminal, direto no banco:
### No Terminal
```
docker compose exec db psql -U aluno -d escola -c "SELECT * FROM alunos;"
```

# Agora derrube e suba de novo:
### No Terminal
```
docker compose down
```
```
docker compose up -d
```
```
docker compose exec db psql -U aluno -d escola -c "SELECT * FROM alunos;"
```

# SAÍDA ESPERADA (aproximada)
```
 id | nome
----+------
  1 | Ana
  2 | Bruno
  3 | Carla
```

# O que aconteceu?
Os containers foram destruídos e recriados, mas a tabela continua: ela mora no volume pgdata.
Se rodar docker compose down -v, os dados somem de verdade.

# Atenção
Se o comando psql falhar logo após o up, espere alguns segundos: depends_on garante a ordem
de início, não que o banco já esteja pronto. Em projetos reais usa-se healthcheck para isso.

# Desafios extras
- Adicione um serviço redis (imagem redis) e teste a conexão com docker compose exec
redis redis-cli ping (resposta: PONG).
- Troque a senha do Postgres para uma variável lida de um arquivo .env
(POSTGRES_PASSWORD: ${DB_PASS}).
- Escale o serviço web: remova o mapeamento fixo de porta e rode docker compose up -d--scale web=3. Observe os três containers em docker compose ps.