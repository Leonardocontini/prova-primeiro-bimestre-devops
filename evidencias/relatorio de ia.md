# Nome: Leonardo Rafael Contini Costa    RA:6325054

# Relatório de Uso de Inteligência Artificial

> **Projeto:** API REST de Reservas + Docker + Infraestrutura AWS/Terraform
> **Finalidade:** registrar, de forma organizada, o uso de diferentes ferramentas de IA durante o desenvolvimento do projeto.

## Legenda

- **Prompt:** solicitação enviada pelo autor à ferramenta de IA.
- **Comentário do autor:** observação, decisão ou justificativa registrada pelo autor durante o desenvolvimento.
- **Resposta da IA:** conteúdo produzido pela ferramenta em resposta ao prompt.

## Índice

1. [GPT](#1-gpt)
2. [GPT](#2-gpt)
3. [GPT](#3-gpt)
4. [GPT](#4-gpt)
5. [GPT](#5-gpt)
6. [KIRO](#6-kiro)
7. [GPT](#7-gpt)
8. [KIRO](#8-kiro)
9. [KIRO](#9-kiro)
10. [KIRO](#10-kiro)
11. [KIRO](#11-kiro)
12. [KIRO](#12-kiro)
13. [KIRO](#13-kiro)
14. [KIRO](#14-kiro)
15. [GPT](#15-gpt)
16. [GPT](#16-gpt)
17. [GPT](#17-gpt)
18. [GPT](#18-gpt)
19. [GPT](#19-gpt)
20. [GPT](#20-gpt)
21. [GEMINI](#21-gemini)
22. [GPT](#22-gpt)
23. [GPT](#23-gpt)
24. [GPT](#24-gpt)
25. [GPT](#25-gpt)
26. [GPT](#26-gpt)
27. [GPT](#27-gpt)
28. [GPT](#28-gpt)
29. [GPT](#29-gpt)
30. [GPT](#30-gpt)
31. [KIRO](#31-kiro)

## 1. GPT

> **Prompt do autor**
>
> Apenas escute por enquanto
> Você ira me ajudar a criar uma API crud chamada reservas com Node.js que rodara em um container docker local e mais tarde será executada em nuvem aws com terraform


Entendido. Vou apenas acompanhar por enquanto e aguardar suas próximas instruções.


## 2. GPT

> **Prompt do autor**
>
> Vamos criar uma API rest em Node.js com express para gerenciar esse recurso reservas, esses dados serão gravados no PostgreSQL e deverão persistir guardados no banco de dados, para isso serão executadas as seguintes rotas: POST /reservas - Cria uma nova reserva (com validação de campos obrigatórios), GET /reservas - Lista todas as reservas, GET /reservas/:id - Busca reserva por ID (retorna 404 se não existir), PUT /reservas/:id - Atualiza uma reserva existente, DELETE /reservas/:id - Remove uma reserva, GET /health - Health check simples (retorna status 200).


Perfeito. Vamos montar a API Reservas com esta estrutura:

Node.js + Express
PostgreSQL para persistência
Docker para executar localmente
API REST com as 6 rotas que você definiu
Validação dos campos obrigatórios
Tratamento de 404 para reserva inexistente
Posteriormente, estrutura preparada para AWS + Terraform
Rotas
Método	Rota	Função
POST	/reservas	Criar reserva
GET	/reservas	Listar reservas
GET	/reservas/:id	Buscar por ID
PUT	/reservas/:id	Atualizar reserva
DELETE	/reservas/:id	Excluir reserva
GET	/health	Health check

Também vamos separar a aplicação em camadas, em vez de colocar tudo em um único server.js, para que ela fique mais fácil de manter e posteriormente levar para a AWS.

Podemos começar pela 
estrutura do projeto e criação dos arquivos, e depois 
implementar cada parte passo a passo.


## 3. GPT

> **Prompt do autor**
>
> ok, a partir de agora vamos focar somente na API e no docker, terraform e aws será somente mais tarde, e também vc só ira me responder com mensagens longas quando eu mandar em todos os prompts, caso eu não mandar vc ira me confirmar com respostas curtas e diretas


Combinado. Vou manter as respostas curtas e diretas, e só detalharei quando você pedir.

> **Comentário do autor**
>
> Optei por usar uma versão do node:20-alpine como imagem do Node.js por ser extremamente leve e segura, já que já tive uma ótima experiência com ela em nossa prova em abril mas em sua versão 14. Já que vamos trabalhar com a API em nuvem precisamos deixar o menor e mais otimizado consumo possível, já que pagamos pelo o quanto utilizamos de recursos da nuvem



## 4. GPT

> **Prompt do autor**
>
> agora vamos criar o Docker Compose e o Dockerfile, usando as imagens node:20-alpine e postgres:16-alpine


Sim. Vamos começar com esses dois arquivos, deixando a estrutura preparada para a API Node.js e o PostgreSQL.

Docker Compose.yml

services:
  API:
    build:
      context: .
      Dockerfile: Dockerfile
    container_name: reservas-API
    ports:
      - "3000:3000"
    environment:
      PORT: 3000
      DB_HOST: postgres
      DB_PORT: 5432
      DB_NAME: reservas
      DB_USER: postgres
      DB_PASSWORD: postgres
    depends_on:
      postgres:
        condition: service_healthy
    networks:
      - reservas-network

  postgres:
    image: postgres:16-alpine
    container_name: reservas-postgres
    environment:
      POSTGRES_DB: reservas
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/PostgreSQL/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d reservas"]
      interval: 5s
      timeout: 5s
      retries: 5
    networks:
      - reservas-network

volumes:
  postgres_data:

networks:
  reservas-network:
    driver: bridge

Dockerfile

FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]


## 5. GPT

> **Prompt do autor**
>
> agora faça para mim um comando shell touch para criar a estrutura dentro da src (já estou dentro da pasta) da minha API


mkdir -p src/{controllers,routes,services,repositories,config} && touch src/app.js src/server.js src/controllers/reservasController.js src/routes/reservasRoutes.js src/services/reservasService.js src/repositories/reservasRepository.js src/config/database.js


## 6. KIRO

> **Prompt do autor**
>
> acesse o src e crie um db.js dentro de config para conectar a API com meu banco de dados postgres, usando em consideração que estamos rodando em docker com uma imagem postgres:16-alpine


Vou primeiro ler os arquivos existentes para entender o padrão do projeto antes de criar o db.js.


5 tool calls
Read Files

database.js

Docker Compose.yml

package.json
Read Files

app.js

reservasRepository.js
List Directory
Command
cat "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/package.json"
Command
ls -la "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/config/"
cat "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/app.js"
cat "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/repositories/reservasRepository.js"
total 8
drwxrwxr-x 2 leonardocontini leonardocontini 4096 set 26 18:29 .
drwxrwxr-x 7 leonardocontini leonardocontini 4096 set 26 18:29 ..
-rw-rw-r-- 1 leonardocontini leonardocontini    0 set 26 18:29 database.js
Os arquivos estão vazios. Com base no Docker Compose.yml, já tenho todas as variáveis de ambiente definidas. Vou criar o db.js usando pg (node-postgres), que é o driver padrão para PostgreSQL em Node.js.


1 tool call
Write File

db.js

Details
Arquivo criado. Aqui está o que ele faz:

Usa Pool do pacote pg para gerenciar um pool de conexões, o que é mais eficiente do que abrir uma conexão nova a cada query.
Lê todas as credenciais das variáveis de ambiente definidas no Docker Compose.yml (DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD), com fallbacks para desenvolvimento local.
O DB_HOST aponta para postgres, que é exatamente o nome do serviço definido no compose — dentro da rede Docker isso resolve corretamente para o container do banco.
Loga no console quando a conexão é estabelecida e encerra o processo em caso de erro crítico no pool.
Para usar nos repositories, basta importar:

js

const pool = require('../config/db');

// exemplo de query
const result = await pool.query('SELECT * FROM reservas');
Só certifique-se de que o pg está listado nas dependências do package.json. Se ainda não estiver, adicione com:
npm install pg


## 7. GPT

> **Prompt do autor**
>
> agora vamos criar o reservasController.js (dentro da lógica crud) e o reservasRoutes.js com as nossas rotas já preparadas para rodar em nosso banco de dados


Sim. Vamos deixar o Controller responsável pelo CRUD e as Routes responsáveis apenas pelo mapeamento das rotas.

Como ainda vamos criar o reservasService.js e o reservasRepository.js, o controller ficará preparado para utilizá-los.

src/controllers/reservasController.js
const reservasService = require('../services/reservasService');

const criarReserva = async (req, res) => {
  try {
    const reserva = await reservasService.criarReserva(req.body);

    return res.status(201).json(reserva);
  } catch (error) {
    return res.status(400).json({
      erro: error.message
    });
  }
};

const listarReservas = async (req, res) => {
  try {
    const reservas = await reservasService.listarReservas();

    return res.status(200).json(reservas);
  } catch (error) {
    return res.status(500).json({
      erro: error.message
    });
  }
};

const buscarReservaPorId = async (req, res) => {
  try {
    const reserva = await reservasService.buscarReservaPorId(req.params.id);

    if (!reserva) {
      return res.status(404).json({
        erro: 'Reserva não encontrada'
      });
    }

    return res.status(200).json(reserva);
  } catch (error) {
    return res.status(500).json({
      erro: error.message
    });
  }
};

const atualizarReserva = async (req, res) => {
  try {
    const reserva = await reservasService.atualizarReserva(
      req.params.id,
      req.body
    );

    if (!reserva) {
      return res.status(404).json({
        erro: 'Reserva não encontrada'
      });
    }

    return res.status(200).json(reserva);
  } catch (error) {
    return res.status(400).json({
      erro: error.message
    });
  }
};

const excluirReserva = async (req, res) => {
  try {
    const reserva = await reservasService.excluirReserva(req.params.id);

    if (!reserva) {
      return res.status(404).json({
        erro: 'Reserva não encontrada'
      });
    }

    return res.status(204).send();
  } catch (error) {
    return res.status(500).json({
      erro: error.message
    });
  }
};

module.exports = {
  criarReserva,
  listarReservas,
  buscarReservaPorId,
  atualizarReserva,
  excluirReserva
};
src/routes/reservasRoutes.js
const express = require('express');

const reservasController = require('../controllers/reservasController');

const router = express.Router();

router.post('/reservas', reservasController.criarReserva);

router.get('/reservas', reservasController.listarReservas);

router.get('/reservas/:id', reservasController.buscarReservaPorId);

router.put('/reservas/:id', reservasController.atualizarReserva);

router.delete('/reservas/:id', reservasController.excluirReserva);

module.exports = router;

Com isso, nossas rotas já ficam definidas:

POST    /reservas
GET     /reservas
GET     /reservas/:id
PUT     /reservas/:id
DELETE  /reservas/:id

O próximo arquivo necessário para realmente conectar isso ao PostgreSQL será o reservasRepository.js, que vai executar os comandos SQL no banco.


## 8. KIRO

> **Prompt do autor**
>
> crie a conexão para o reservasRepository.js para conectar a API com PostgreSQL, fazendo que execute comandos sql em meu banco de dados


Vou ler todos os arquivos abertos para entender a estrutura completa antes de escrever o repository.


1 tool call
Read Files

reservasController.js

reservasRoutes.js

reservasService.js

db.js
O controller já revela todas as operações necessárias: criar, listar, buscarPorId, atualizar e excluir. Vou implementar o repository com SQL direto para cada uma.


1 tool call
Write File

reservasRepository.js


Pronto. Aqui está o que foi implementado:

Operações SQL:

Função	SQL
criarReserva	INSERT ... RETURNING *
listarReservas	SELECT * ORDER BY data_reserva
buscarReservaPorId	SELECT * WHERE id = $1
atualizarReserva	UPDATE ... WHERE id = $5 RETURNING *
excluirReserva	DELETE WHERE id = $1 RETURNING *
Pontos importantes:

Todos os valores são passados como parâmetros posicionais ($1, $2...) — isso previne SQL injection.
RETURNING * em todas as operações de escrita retorna a linha afetada, permitindo que o controller responda com os dados atualizados.
Quando nenhuma linha é encontrada (buscarPorId, atualizar, excluir), retorna null — o controller já trata esse caso respondendo com 404.
A tabela esperada no banco é:

sql

CREATE TABLE reservas (
  id SERIAL PRIMARY KEY,
  nome_cliente VARCHAR(255) NOT NULL,
  data_reserva TIMESTAMP NOT NULL,
  numero_pessoas INTEGER NOT NULL,
  observacoes TEXT
);
Se ainda não tiver essa tabela criada no Postgres, precisa rodar esse CREATE TABLE no banco antes de usar a API.


## 9. KIRO

> **Prompt do autor**
>
> faça agora o app.js lembrando que estou usando express e a rota padrão pode ser a 3000


Vou ler o server.js para ver se já tem algo lá antes de criar o app.js.


1 tool call
Command
cat "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/server.js"
Arquivo vazio. O projeto já separa app.js de server.js, que é um padrão comum — app.js configura o Express e server.js sobe o servidor. Vou criar os dois.


2 tool calls
Write File

app.js


Write File

server.js


Feito. A divisão ficou assim:

app.js — configura o Express:

express.json() para parsear o body das requisições
Rota /health para verificar se a API está de pé (útil no Docker)
Rotas de reservas montadas em /API, então os endpoints ficam como /API/reservas
server.js — sobe o servidor:

Lê a porta da variável de ambiente PORT (já definida como 3000 no Docker Compose.yml), com fallback para 3000
Endpoints disponíveis após subir:


GET    /health
POST   /API/reservas
GET    /API/reservas
GET    /API/reservas/:id
PUT    /API/reservas/:id
DELETE /API/reservas/:id


## 10. KIRO

> **Prompt do autor**
>
> agora análise minha estrutura como um todo e análise se ela já esta pronta para rodar em meu docker


Vou ler todos os arquivos da estrutura de uma vez para fazer uma análise completa.


2 tool calls
Read Files

Dockerfile

.dockerignore

Docker Compose.yml
Command
cat "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/package.json"
echo "---"
cat "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/services/reservasService.js"
---
Dois problemas críticos encontrados: package.json está vazio e reservasService.js está vazio. Vou verificar o restante dos arquivos também.


1 tool call
Command
for f in \
  "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/app.js" \
  "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/server.js" \
  "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/config/db.js" \
  "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/repositories/reservasRepository.js" \
  "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/services/reservasService.js" \
  "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/controllers/reservasController.js" \
  "/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/routes/reservasRoutes.js"; do
  echo "=== $f ==="
  wc -c "$f" 2>/dev/null || echo "ARQUIVO NAO ENCONTRADO"
done
=== /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/app.js ===
285 /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/app.js
=== /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/server.js ===
152 /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/server.js
=== /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/config/db.js ===
524 /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/config/db.js
=== /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/repositories/reservasRepository.js ===
1464 /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/repositories/reservasRepository.js
=== /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/services/reservasService.js ===
0 /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/services/reservasService.js
=== /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/controllers/reservasController.js ===
1856 /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/controllers/reservasController.js
=== /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/routes/reservasRoutes.js ===
494 /home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/routes/reservasRoutes.js
Dois arquivos críticos estão vazios. Vou resolver os dois e também verificar o Docker Compose.yml — o context aponta para . mas o Dockerfile está dentro de app/, o que é um problema.


1 tool call
Corrigir estrutura do projeto para rodar no Docker
0/4
Criar reservasService.js (arquivo vazio, camada entre controller e repository)
NEXT
Criar package.json com dependências express e pg
Corrigir Docker Compose.yml: context e Dockerfile path incorretos
Corrigir .dockerignore
Vou resolver os 4 problemas em paralelo onde possível.


2 tool calls
Write File

reservasService.js



Details
Corrigir estrutura do projeto para rodar no Docker
1/4
Criar reservasService.js (arquivo vazio, camada entre controller e repository)
Criar package.json com dependências express e pg
NEXT
Corrigir Docker Compose.yml: context e Dockerfile path incorretos
Corrigir .dockerignore
/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/services/reservasService.js
Agora os três restantes — package.json, Docker Compose.yml e .dockerignore:


2 tool calls
Write File

package.json



Details
Corrigir estrutura do projeto para rodar no Docker
2/4
Criar reservasService.js (arquivo vazio, camada entre controller e repository)
Criar package.json com dependências express e pg
Corrigir Docker Compose.yml: context e Dockerfile path incorretos
NEXT
Corrigir .dockerignore
/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/package.json
/home/leonardocontini/Área de trabalho/Prova Alexandre/prova-primeiro-bimestre-devops/app/src/services/reservasService.js
O problema no Docker Compose.yml é que o context: . aponta para a raiz do projeto, mas o Dockerfile está dentro de app/. O Docker vai procurar os arquivos na raiz e não vai encontrar o package.json nem o src/. Precisa corrigir para context: ./app e Dockerfile: Dockerfile.


1 tool call
Replace in File

Docker Compose.yml



Details
Agora o .dockerignore dentro de app/:


2 tool calls
Write File

.dockerignore



Details
Task List
Tudo resolvido. Resumo do que foi corrigido/criado:

Docker Compose.yml — context: . → context: ./app Sem isso o Docker buildava a partir da raiz e não achava o package.json nem o src/.


package.json
 — criado com express e pg, script start apontando para 
server.js
 (que é o que o CMD ["npm", "start"] do Dockerfile chama).


reservasService.js
 — criado com validação e delegação ao repository. Sem ele o controller quebrava na importação.

app/.dockerignore — node_modules ignorado para o Docker não copiar as dependências locais para dentro da imagem (o RUN npm install cuida disso).


## 11. KIRO

> **Prompt do autor**
>
> agora me uns comandos sql para testar meu banco de dados


Com base na estrutura da API (tabela reservas com os campos usados no repository), aqui estão os comandos:

1. Criar a tabela (rodar uma vez antes de tudo)

sql

CREATE TABLE IF NOT EXISTS reservas (
  id SERIAL PRIMARY KEY,
  nome_cliente VARCHAR(255) NOT NULL,
  data_reserva TIMESTAMP NOT NULL,
  numero_pessoas INTEGER NOT NULL,
  observacoes TEXT
);
2. Inserir registros

sql

INSERT INTO reservas (nome_cliente, data_reserva, numero_pessoas, observacoes)
VALUES ('João Silva', '2026-10-01 19:00:00', 4, 'Mesa próxima à janela');

INSERT INTO reservas (nome_cliente, data_reserva, numero_pessoas, observacoes)
VALUES ('Maria Souza', '2026-10-02 20:30:00', 2, NULL);

INSERT INTO reservas (nome_cliente, data_reserva, numero_pessoas, observacoes)
VALUES ('Carlos Lima', '2026-10-03 18:00:00', 6, 'Aniversário');
3. Listar todas as reservas

sql

SELECT * FROM reservas ORDER BY data_reserva ASC;
4. Buscar por ID

sql

SELECT * FROM reservas WHERE id = 1;
5. Atualizar uma reserva

sql

UPDATE reservas
SET nome_cliente = 'João Atualizado', numero_pessoas = 5
WHERE id = 1;
6. Deletar uma reserva

sql

DELETE FROM reservas WHERE id = 1;
7. Verificar se a tabela está vazia ou contar registros

sql

SELECT COUNT(*) FROM reservas;
Para executar esses comandos com os containers rodando, use:

bash

docker exec -it reservas-postgres psql -U postgres -d reservas
Isso abre o terminal do PostgreSQL direto no container. Depois é só colar os comandos acima. Para sair do psql, digite \que.


## 12. KIRO

> **Prompt do autor**
>
> agora quero testar direto pela API


Aqui estão os comandos curl para testar cada endpoint da API:

Health check

bash

curl http://localhost:3000/health
Criar reserva (POST)

bash

curl -X POST http://localhost:3000/API/reservas \
  -H "Content-Type: application/json" \
  -d '{
    "nome_cliente": "João Silva",
    "data_reserva": "2026-10-01T19:00:00",
    "numero_pessoas": 4,
    "observacoes": "Mesa próxima à janela"
  }'
Listar todas (GET)

bash

curl http://localhost:3000/API/reservas
Buscar por ID (GET)

bash

curl http://localhost:3000/API/reservas/1
Atualizar (PUT)

bash

curl -X PUT http://localhost:3000/API/reservas/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nome_cliente": "João Atualizado",
    "data_reserva": "2026-10-01T19:00:00",
    "numero_pessoas": 5,
    "observacoes": "Mesa no centro"
  }'
Deletar (DELETE)

bash

curl -X DELETE http://localhost:3000/API/reservas/1
Se preferir uma interface gráfica ao invés do terminal, pode usar o Postman ou o Insomnia com a mesma base http://localhost:3000/API/reservas. Só garantir que os containers estão rodando antes:

bash

docker compose up --build

> **Comentário do autor**
>
> decidi criar um arquivo de automação na criação da tabela reservas, assim quando o container for executado o script sql já cria a tabela reservas que já estara pronta para receber dados



## 13. KIRO

> **Prompt do autor**
>
> crie um arquivo init.sql que contenha um script que já crie a tabela reservas, depois o referencie no Docker Compose.yml


Agora referencio no Docker Compose.yml mapeando o arquivo para o diretório /docker-entrypoint-initdb.d/ — o Postgres executa automaticamente qualquer .sql que estiver lá na primeira inicialização do container:


1 tool call
Replace in File

Docker Compose.yml


Feito. A estrutura de arquivos ficou assim:


prova-primeiro-bimestre-devops/
├── init.sql                  ← script de criação da tabela
├── Docker Compose.yml        ← referencia o init.sql
└── app/
    └── ...
Importante: o /docker-entrypoint-initdb.d/ só é executado quando o volume do Postgres está vazio (primeira vez). Se o container já existia antes, precisa recriar do zero:

bash

docker compose down -v
docker compose up --build -d
O -v remove o volume postgres_data, forçando o Postgres a rodar o init.sql na próxima subida.


## 14. KIRO

> **Prompt do autor**
>
> adicione o multi-stage build e usuário não-root no Dockerfile


Feito. O que mudou:

Multi-stage build:

builder — instala as dependências com --omit=dev (exclui pacotes de desenvolvimento)
production — imagem final limpa, recebe só o node_modules já instalado e o código fonte. A imagem final não carrega o npm nem nenhum artefato desnecessário do build
Usuário não-root:

Cria o grupo appgroup e o usuário appuser
Transfere a propriedade dos arquivos com chown antes de trocar de usuário
USER appuser garante que o processo roda sem privilégios de root
Bonus: trocou npm start por node src/server.js direto — evita um processo intermediário do npm desnecessário em produção.


## 15. GPT

> **Prompt do autor**
>
> ok, agora vamos começar a criar a estrutura do terraform aws, espere as minhas specs


Certo. Vou aguardar suas especificações do Terraform/AWS.


## 16. GPT

> **Prompt do autor**
>
> lembre-se agora de antigos trabalhos meu que fiz para o terraform aws, vamos trabalhar mais ou menos naquele estilo


Sim, lembro do padrão dos seus trabalhos anteriores e vamos seguir aproximadamente aquele estilo.

Vou considerar como referência:

* Estrutura Terraform separada por arquivos (`providers.tf`, `variables.tf`, `vpc.tf`, `subnets.tf`, `security_groups.tf`, `ec2.tf`, `rds.tf`, `outputs.tf`, etc.).
* VPC no padrão que você já utilizou, quando fizer sentido.
* Recursos organizados e nomeados com `project_name`.
* Tags como `Name`, `Project`, `Environment` e `ManagedBy = "Terraform"`.
* EC2 usando o **AWS Academy Learner Lab / LabRole**, com `LabInstanceProfile`.
* PostgreSQL/RDS privado e regras de segurança restritas.
* Desenvolvimento/testes localmente antes do deploy na AWS.
* Separação clara entre API, banco, rede e infraestrutura.

Vou aguardar suas especificações antes de começar a montar o Terraform.


## 17. GPT

> **Prompt do autor**
>
> esses serão os novos requisitos que iremos trabalhar, apenas análise eles por enquanto
> 
> VPC com subnets públicas e privadas em 2 AZs (módulo vpc)
> Security Groups com menor privilégio (módulo security-group): EC2 (22, 3000) e RDS (5432 apenas do SG do EC2)
> EC2 t2.micro na subnet pública com a API (módulo ec2) — use o instance profile LabInstanceProfile se precisar de acesso a serviços
> RDS PostgreSQL db.t3.micro provisionado e funcional nas subnets privadas (módulo rds) — este é o banco de dados da API na nuvem, onde as rotas de CRUD gravam os dados. Deve ter publicly_accessible = false, storage_encrypted = true, db_subnet_group_name com as subnets privadas e ser acessível apenas a partir do Security Group da EC2 (porta 5432)
> Remote State: backend S3 (com versionamento e encriptação) + DynamoDB para locking
> Composição entre módulos (output de um alimenta input de outro)
> Tags em todos os recursos e outputs úteis (IP da EC2, endpoint do RDS, URL da API)


Analisado. Os requisitos formam uma arquitetura bem definida:

```text
                    INTERNET
                       │
                       ▼
                ┌─────────────┐
                │     VPC     │
                │             │
                │  2 AZs      │
                └──────┬──────┘
                       │
          ┌────────────┴────────────┐
          │                         │
          ▼                         ▼
   ┌──────────────┐         ┌──────────────┐
   │ Subnets      │         │ Subnets      │
   │ Públicas     │         │ Privadas     │
   │ AZ-1 / AZ-2  │         │ AZ-1 / AZ-2  │
   └──────┬───────┘         └──────┬───────┘
          │                        │
          ▼                        ▼
   ┌──────────────┐         ┌──────────────┐
   │ EC2 t2.micro │────────►│ RDS          │
   │ API Node.js  │  5432   │ PostgreSQL   │
   │ porta 3000   │         │ db.t3.micro  │
   └──────────────┘         └──────────────┘
```

### Módulos

Teremos principalmente:

```text
terraform/
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── ec2/
│   └── rds/
│
├── environments/
│   └── ...
│
├── backend.tf
├── providers.tf
├── variables.tf
├── outputs.tf
└── main.tf
```

A composição será aproximadamente:

```text
VPC
 ├── public_subnet_ids ──► EC2
 └── private_subnet_ids ─► RDS

Security Group EC2
 └── id ────────────────► Security Group RDS
                           └── permite 5432 somente do SG EC2
```

### Pontos importantes que identifiquei

* **EC2:** `t2.micro`, subnet pública, API Node.js/Express.
* **RDS:** PostgreSQL `db.t3.micro`, privado, sem acesso público.
* **RDS:** criptografia habilitada e armazenamento persistente.
* **Segurança:** RDS não aceitará `0.0.0.0/0` na porta `5432`; somente o SG da EC2.
* **EC2:** portas `22` e `3000`, conforme requisito.
* **Remote State:** S3 + versionamento + criptografia + DynamoDB locking.
* **Outputs:** IP da EC2, endpoint do RDS e URL da API.
* **Tags:** todos os recursos deverão receber tags.
* **Módulos:** os outputs de um módulo serão utilizados como inputs de outros.
* **Lab:** manteremos o padrão do **LabInstanceProfile** para a EC2 quando necessário.

Um detalhe que vou manter em mente: **a API na EC2 precisará conseguir acessar o RDS pela rede privada**, então a configuração de rede, rotas e Security Groups precisa estar coerente com isso.

Por enquanto não vou criar nenhum arquivo até você passar as próximas especificações.


## 18. GPT

> **Prompt do autor**
>
> o nome do bucket que a nossa infraestrutura criara e gerenciará será prova-devops6325054, lembre-se disso


Certo. O bucket S3 será **`prova-devops6325054`**.


## 19. GPT

> **Prompt do autor**
>
> ok, vamos começar a codificar e criar a estrutura do modules, com as specs que já te mandei


Vamos começar pela estrutura dos módulos, seguindo as especificações que você passou.

```bash
mkdir -p modules/{vpc,security-group,ec2,rds}

touch modules/vpc/{main.tf,variables.tf,outputs.tf}
touch modules/security-group/{main.tf,variables.tf,outputs.tf}
touch modules/ec2/{main.tf,variables.tf,outputs.tf}
touch modules/rds/{main.tf,variables.tf,outputs.tf}
```

A estrutura ficará:

```text
terraform/
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── security-group/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── ec2/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── rds/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

Depois vamos criar a infraestrutura principal fora de `modules/`, onde faremos a **composição dos módulos**:

```text
VPC
 ↓
Security Groups
 ↓
EC2 ──────► RDS
```

E o Remote State ficará separado da infraestrutura dos módulos, usando o bucket:

```text
prova-devops6325054
```

Não vou preencher os arquivos ainda; podemos construir **módulo por módulo**, começando pelo `vpc`.


## 20. GPT

> **Prompt do autor**
>
> ok, vamos começar, faça cada código me deixando por dentro do o que vc esta fazendo, não se esqueça que vamos subir em learn lab, então a estrutura tem que ser em labrole


Perfeito. Vamos fazer **módulo por módulo**, explicando o que cada arquivo faz e mantendo o padrão do **AWS Academy Learner Lab / LabRole**.

Vamos começar pelo **módulo VPC**, porque os outros módulos dependerão dos IDs das subnets e da VPC.

### 1. `modules/vpc/variables.tf`

Aqui definimos os valores que o módulo recebe:

```hcl
variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidade utilizadas"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDRs das subnets públicas"
  type        = map(string)
}

variable "private_subnets" {
  description = "CIDRs das subnets privadas"
  type        = map(string)
}
```

A ideia é não deixar os valores presos dentro do módulo. Por exemplo:

```text
VPC
├── CIDR
├── AZ-1
├── AZ-2
├── Subnet pública AZ-1
├── Subnet pública AZ-2
├── Subnet privada AZ-1
└── Subnet privada AZ-2
```

---

### 2. `modules/vpc/main.tf`

Agora criamos efetivamente a VPC e as subnets.

```hcl
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name        = "var.projectname-public-{each.key}"
    Project     = var.project_name
    Environment = "lab"
    Type        = "public"
    ManagedBy   = "Terraform"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name        = "var.projectname-private-{each.key}"
    Project     = var.project_name
    Environment = "lab"
    Type        = "private"
    ManagedBy   = "Terraform"
  }
}
```

Aqui temos um ponto importante do requisito:

```hcl
for_each = var.public_subnets
```

e:

```hcl
for_each = var.private_subnets
```

Isso permite criar as subnets dinamicamente.

Por exemplo:

```hcl
public_subnets = {
  "us-east-1a" = "10.0.1.0/24"
  "us-east-1b" = "10.0.3.0/24"
}
```

O Terraform criará automaticamente duas subnets públicas.

---

### 3. `modules/vpc/outputs.tf`

Os outros módulos precisarão saber onde a VPC e as subnets estão.

```hcl
output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas"
  value       = {
    for az, subnet in aws_subnet.public : az => subnet.id
  }
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = {
    for az, subnet in aws_subnet.private : az => subnet.id
  }
}
```

Assim poderemos fazer posteriormente algo como:

```text
módulo VPC
   │
   ├── vpc_id
   │
   ├── public_subnet_ids ──► módulo EC2
   │
   └── private_subnet_ids ─► módulo RDS
```

### Um detalhe importante

Ainda **não colocamos `LabRole` nesse módulo**.

O `LabInstanceProfile`/`LabRole` é relacionado à **EC2**, não à VPC. Quando chegarmos ao `modules/ec2/main.tf`, vamos configurar a instância para usar:

```hcl
iam_instance_profile = "LabInstanceProfile"
```

Isso mantém a estrutura correta para o **Learner Lab**.

Também ainda faltam **Internet Gateway, Route Tables e associações**, que são necessários para que a subnet pública realmente tenha acesso à internet. Vamos adicionar isso ao módulo VPC antes de considerá-lo completo.


## 21. GEMINI

> **Prompt do autor**
>
> Provisione, com Terraform modularizado, no AWS Academy Learner Lab:
> 
> VPC com subnets públicas e privadas em 2 AZs (módulo vpc)
> Security Groups com menor privilégio (módulo security-group): EC2 (22, 3000) e RDS (5432 apenas do SG do EC2)
> EC2 t2.micro na subnet pública com a API (módulo ec2) — use o instance profile LabInstanceProfile se precisar de acesso a serviços
> RDS PostgreSQL db.t3.micro provisionado e funcional nas subnets privadas (módulo rds) — este é o banco de dados da API na nuvem, onde as rotas de CRUD gravam os dados. Deve ter publicly_accessible = false, storage_encrypted = true, db_subnet_group_name com as subnets privadas e ser acessível apenas a partir do Security Group da EC2 (porta 5432)
> Remote State: backend S3 (com versionamento e encriptação) + DynamoDB para locking
> Composição entre módulos (output de um alimenta input de outro)
> Tags em todos os recursos e outputs úteis (IP da EC2, endpoint do RDS, URL da API)
> 
> melhore esse prompt com base nessas specs: agora vamos montar a infraestrutura, quero que ela se conecte as outras instancias com outputs dos módulos para os inputs dos outros




Prompt Otimizado para Copiloto / LLM:
"Preciso criar o ficheiro infraestrutura/main.tf para compor os meus módulos Terraform (vpc, security-group, ec2 e rds) no AWS Academy Learner Lab (região us-east-1).

Por favor, faça o encadeamento dos dados conectando as saídas (outputs) de uns módulos às entradas (inputs) dos outros:

O módulo vpc deve fornecer a vpc_id para o security-group, a public_subnet_id para a ec2 e o db_subnet_group_name para o rds.

O módulo security-group deve fornecer o ec2_sg_id para a ec2 e o rds_sg_id para o rds (garantindo que o RDS aceite tráfego da EC2 na porta 5432).

O módulo ec2 deve utilizar o perfil LabInstanceProfile nativo do Learner Lab.

O módulo rds deve receber o nome do banco, utilizador e senha definidos nas variáveis principais.

Forneça o código limpo e pronto para o infraestrutura/main.tf."

Por que este prompt é melhor?
Especifica o encadeamento das portas e IDs: Deixa claro exatamente qual output vai para qual input (ex: ec2_sg_id alimentando o filtro do RDS).

Reforça as regras do Learner Lab: Relembra o uso do LabInstanceProfile para evitar que a IA crie novos papéis IAM que causariam erro de permissão no teu laboratório.

Reduz ambiguidades: Garante que todas as quatro partes da infraestrutura fiquem perfeitamente amarradas no primeiro teste.


## 22. GPT

> **Prompt do autor**
>
> Preciso criar o ficheiro `infraestrutura/main.tf` para compor os meus módulos Terraform (`vpc`, `security-group`, `ec2` e `rds`) no **AWS Academy Learner Lab** (região `us-east-1`).
> 
> Por favor, faça o encadeamento dos dados conectando as saídas (`outputs`) de uns módulos às entradas (`inputs`) dos outros:
> 
> 1. O **módulo `vpc`** deve fornecer a `vpc_id` para o `security-group`, a `public_subnet_id` para a `ec2` e o `db_subnet_group_name` para o `rds`.
> 2. O **módulo `security-group`** deve fornecer o `ec2_sg_id` para a `ec2` e o `rds_sg_id` para o `rds` (garantindo que o RDS aceite tráfego da EC2 na porta 5432).
> 3. O **módulo `ec2`** deve utilizar o perfil `LabInstanceProfile` nativo do Learner Lab.
> 4. O **módulo `rds`** deve receber o nome do banco, utilizador e senha definidos nas variáveis principais.
> 
> Forneça o código limpo e pronto para o `infraestrutura/main.tf`.


Claro. Considerando os outputs/inputs que você definiu, o `infraestrutura/main.tf` pode ficar assim:

```hcl
module "vpc" {
  source = "../modules/vpc"

  project_name      = var.project_name
  vpc_cidr          = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
}

module "security_group" {
  source = "../modules/security-group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "ec2" {
  source = "../modules/ec2"

  project_name        = var.project_name
  subnet_id           = module.vpc.public_subnet_id
  security_group_id   = module.security_group.ec2_sg_id
  instance_profile    = "LabInstanceProfile"
}

module "rds" {
  source = "../modules/rds"

  project_name          = var.project_name
  db_subnet_group_name  = module.vpc.db_subnet_group_name
  security_group_id     = module.security_group.rds_sg_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
```

### Encadeamento

O fluxo ficará:

```text
VPC
 ├── vpc_id ────────────────► Security Group
 │
 ├── public_subnet_id ──────► EC2
 │
 └── db_subnet_group_name ──► RDS

Security Group
 ├── ec2_sg_id ──────────────► EC2
 │
 └── rds_sg_id ──────────────► RDS
                                  │
                                  └── porta 5432 somente da EC2

EC2
 └── LabInstanceProfile
```

**Observação importante:** esse `main.tf` pressupõe que os módulos tenham exatamente esses nomes de variáveis e outputs. No módulo VPC que fizemos anteriormente, usamos `public_subnet_ids` e `private_subnet_ids` (plural), então precisaremos alinhar isso para `public_subnet_id` e criar `db_subnet_group_name` no VPC, caso essa seja a interface que você quer manter.


## 23. GPT

> **Prompt do autor**
>
> agora vamos criar o resto da infraestrutura


Vamos continuar. Para não misturar tudo, vamos completar a infraestrutura na seguinte ordem:

1. **VPC** — Internet Gateway, Route Tables e DB Subnet Group.
2. **Security Groups** — EC2 e RDS.
3. **EC2** — `t2.micro` + `LabInstanceProfile`.
4. **RDS** — PostgreSQL `db.t3.micro`.
5. **Infra principal** — variáveis e outputs.
6. **Remote State** — S3 `prova-devops6325054` + DynamoDB.

Começamos agora pelo **módulo VPC**, que é a base dos demais.

### `modules/vpc/main.tf`

Substitua o conteúdo pelo seguinte:

```hcl
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}

# =========================
# SUBNETS PÚBLICAS
# =========================

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name        = "var.projectname-public-{each.key}"
    Project     = var.project_name
    Environment = "lab"
    Type        = "public"
    ManagedBy   = "Terraform"
  }
}

# =========================
# SUBNETS PRIVADAS
# =========================

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name        = "var.projectname-private-{each.key}"
    Project     = var.project_name
    Environment = "lab"
    Type        = "private"
    ManagedBy   = "Terraform"
  }
}

# =========================
# INTERNET GATEWAY
# =========================

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-igw"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}

# =========================
# ROUTE TABLE PÚBLICA
# =========================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Project     = var.project_name
    Environment = "lab"
    Type        = "public"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# =========================
# ROUTE TABLE PRIVADA
# =========================

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name        = "${var.project_name}-private-rt"
    Project     = var.project_name
    Environment = "lab"
    Type        = "private"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# =========================
# DB SUBNET GROUP
# =========================

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [for subnet in aws_subnet.private : subnet.id]

  tags = {
    Name        = "${var.project_name}-db-subnet-group"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}
```

### `modules/vpc/outputs.tf`

Agora precisamos expor os dados que os outros módulos vão consumir:

```hcl
output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID da subnet pública utilizada pela EC2"
  value       = values(aws_subnet.public)[0].id
}

output "public_subnet_ids" {
  description = "IDs de todas as subnets públicas"
  value       = {
    for az, subnet in aws_subnet.public : az => subnet.id
  }
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas"
  value       = {
    for az, subnet in aws_subnet.private : az => subnet.id
  }
}

output "db_subnet_group_name" {
  description = "Nome do DB Subnet Group utilizado pelo RDS"
  value       = aws_db_subnet_group.this.name
}
```

Agora o encadeamento que você pediu funciona:

```text
                 ┌──────────────┐
                 │     VPC      │
                 └──────┬───────┘
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             ▼             ▼
      vpc_id      public_subnet   private_subnets
          │             │             │
          ▼             ▼             ▼
         SG            EC2           RDS
                                      ▲
                                      │
                              db_subnet_group
```

E temos duas AZs com:

```text
AZ-1                         AZ-2

Public subnet                Public subnet
     │                            │
     └────── Internet Gateway ────┘

Private subnet               Private subnet
     │                            │
     └────────── RDS ─────────────┘
```

**Importante:** a subnet privada não possui rota direta para a Internet Gateway. Isso atende ao requisito de manter o RDS privado.


Assim o PostgreSQL não ficará aberto para a internet.


## 24. GPT

> **Prompt do autor**
>
> crie agora o rds relembrando que vamos rodar o banco de dados da API que criamos no inicio, leve isso em consideração pra criar os módulos deixando o mais leve possível para não consumir muitos recursos


Sim. Como esse RDS será **exclusivamente o PostgreSQL da nossa API de reservas**, vamos manter a configuração enxuta, usando exatamente o `db.t3.micro` exigido e evitando recursos desnecessários.

### `modules/rds/variables.tf`

```hcl
variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Nome do DB Subnet Group das subnets privadas"
  type        = string
}

variable "security_group_id" {
  description = "Security Group que poderá acessar o RDS"
  type        = string
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "db_username" {
  description = "Usuário administrador do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
}
```

### `modules/rds/main.tf`

```hcl
resource "aws_db_instance" "this" {
  identifier = "${var.project_name}-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 5432

  db_subnet_group_name = var.db_subnet_group_name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  publicly_accessible = false

  backup_retention_period = 0

  multi_az = false

  skip_final_snapshot = true

  deletion_protection = false

  tags = {
    Name        = "${var.project_name}-postgres"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}
```

### `modules/rds/outputs.tf`

```hcl
output "rds_endpoint" {
  description = "Endpoint do PostgreSQL"
  value       = aws_db_instance.this.address
}

output "rds_port" {
  description = "Porta do PostgreSQL"
  value       = aws_db_instance.this.port
}

output "rds_database_name" {
  description = "Nome do banco de dados"
  value       = aws_db_instance.this.db_name
}
```

### Por que essa configuração é leve?

Estamos evitando recursos que não são necessários para o nosso laboratório:

```text
RDS PostgreSQL
│
├── db.t3.micro
├── 20 GB gp3
├── 1 AZ
├── Multi-AZ: desativado
├── Backup automático: desativado
├── Criptografia: ativada
├── Acesso público: desativado
└── Porta: 5432
```

O banco será acessível assim:

```text
Internet
   │
   X
   │
   └── RDS ❌

EC2
 │
 │ TCP 5432
 ▼
RDS PostgreSQL
 │
 └── banco: reservas
```

Isso também combina diretamente com a API que criamos anteriormente: o PostgreSQL será o banco persistente onde o `reservasRepository` posteriormente executará os `INSERT`, `SELECT`, `UPDATE` e `DELETE`.

**Importante:** `skip_final_snapshot = true`, `backup_retention_period = 0` e `deletion_protection = false` são escolhas apropriadas para um ambiente de laboratório, mas não seriam configurações que eu recomendaria para um banco de produção.

O próximo módulo será a **EC2**, onde vamos colocar a API Node.js/Express dentro do Docker e utilizar o `LabInstanceProfile`.


## 25. GPT

> **Prompt do autor**
>
> ok, vamos configurar o ec2 agora, quero uma maquina rodando amazon linux, em lab role com a região de server em us-east-1, a chave ssh será a technova-key.pem que já existe registrada em minha conta aws


Perfeito. Vamos configurar a EC2 para o **AWS Academy Learner Lab**, região `us-east-1`, usando Amazon Linux, `t2.micro`, `LabInstanceProfile` e a chave já existente `technova-key`.

### `modules/ec2/variables.tf`

```hcl
variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet pública"
  type        = string
}

variable "security_group_id" {
  description = "ID do Security Group da EC2"
  type        = string
}

variable "instance_profile" {
  description = "Instance Profile utilizado pela EC2"
  type        = string
}

variable "key_name" {
  description = "Nome da chave SSH registrada na AWS"
  type        = string
}
```

### `modules/ec2/main.tf`

```hcl
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  key_name = var.key_name

  iam_instance_profile = var.instance_profile

  associate_public_ip_address = true

  tags = {
    Name        = "${var.project_name}-api"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}
```

### `modules/ec2/outputs.tf`

```hcl
output "instance_id" {
  description = "ID da EC2"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "IP público da EC2"
  value       = aws_instance.this.public_ip
}

output "public_dns" {
  description = "DNS público da EC2"
  value       = aws_instance.this.public_dns
}
```

### Atualização do `infraestrutura/main.tf`

Como adicionamos `key_name` ao módulo, a composição ficará:

```hcl
module "ec2" {
  source = "../modules/ec2"

  project_name      = var.project_name
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.ec2_sg_id

  instance_profile = "LabInstanceProfile"
  key_name         = "technova-key"
}
```

### Resultado

A EC2 será:

```text
AWS Learner Lab
└── us-east-1
    └── Amazon Linux 2023
        ├── t2.micro
        ├── Subnet pública
        ├── IP público
        ├── SSH → technova-key
        ├── IAM → LabInstanceProfile
        └── SG
            ├── 22
            └── 3000
```

A chave `technova-key.pem` **não precisa estar no Terraform**. O Terraform precisa apenas do nome do **Key Pair registrado na AWS**, que é `technova-key`. O arquivo `.pem` continua no seu computador e será usado posteriormente para o SSH.


## 26. GPT

> **Prompt do autor**
>
> vamos agora recapitular o que já fizemos e ver o que falta


Até agora temos a base da infraestrutura definida. O que já fizemos e o que falta:

### Já feito

```text
Terraform
└── modules/
    ├── vpc/
    │   ├── main.tf          ✅
    │   ├── variables.tf     ✅
    │   └── outputs.tf       ✅
    │
    ├── security-group/
    │   ├── main.tf          ✅
    │   ├── variables.tf     ✅
    │   └── outputs.tf       ✅
    │
    ├── ec2/
    │   ├── main.tf          ✅
    │   ├── variables.tf     ✅
    │   └── outputs.tf       ✅
    │
    └── rds/
        ├── main.tf          ✅
        ├── variables.tf     ✅
        └── outputs.tf       ✅
```

### VPC

Configuramos:

* VPC
* DNS support/hostnames
* 2 subnets públicas
* 2 subnets privadas
* `for_each` para criação dinâmica
* Internet Gateway
* Route Table pública
* Route Table privada
* associações das subnets
* DB Subnet Group para o RDS
* tags

Arquitetura:

```text
VPC 10.0.0.0/16
│
├── AZ 1
│   ├── Public subnet
│   └── Private subnet
│
└── AZ 2
    ├── Public subnet
    └── Private subnet
```

### Security Groups

Configuramos:

**EC2:**

```text
22    → SSH
3000  → API
```

**RDS:**

```text
5432 → somente Security Group da EC2
```

Portanto:

```text
Internet ──► EC2 :3000
Internet ──► EC2 :22

EC2 ────────► RDS :5432
Internet ──X─► RDS :5432
```

### EC2

Configuramos:

* Amazon Linux 2023
* `t2.micro`
* subnet pública
* IP público
* `technova-key`
* `LabInstanceProfile`
* Security Group da EC2
* região planejada: `us-east-1`

### RDS

Configuramos:

* PostgreSQL 16
* `db.t3.micro`
* 20 GB `gp3`
* `storage_encrypted = true`
* `publicly_accessible = false`
* subnet group privado
* Security Group do RDS
* porta `5432`
* `multi_az = false`
* backup automático desativado para manter o laboratório leve

E ele será o banco da nossa API **Reservas**.

---

## O que ainda falta

Temos alguns pontos importantes antes de executar `terraform plan`.

### 1. Infra principal

Ainda precisamos criar:

```text
infra/
├── main.tf          ← composição dos módulos
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── providers.tf
└── backend.tf
```

Já montamos anteriormente um `main.tf` de composição, mas precisamos completar e conferir todos os nomes com os módulos atuais.

### 2. Provider AWS

Precisamos configurar:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

### 3. Variáveis principais

Precisamos definir coisas como:

```text
project_name
vpc_cidr
availability_zones
public_subnets
private_subnets
db_name
db_username
db_password
```

### 4. Outputs

Precisamos expor:

```text
EC2 public IP
EC2 public DNS
RDS endpoint
RDS port
URL da API
```

Por exemplo:

```text
http://IP_DA_EC2:3000
```

### 5. Remote State

Ainda falta:

```text
S3
└── prova-devops6325054
    ├── versionamento
    └── criptografia

DynamoDB
└── tabela para Terraform State Lock
```

E depois configurar o `backend.tf`.

### 6. API na EC2

A infraestrutura ainda não está fazendo o deploy da nossa aplicação Node.js.

Depois precisaremos preparar a EC2 para:

```text
EC2
 └── Docker
      ├── Node.js / Express API
      └── conexão com RDS PostgreSQL
```

### 7. Conexão da API com o RDS

A aplicação precisará receber:

```text
DB_HOST
DB_PORT
DB_NAME
DB_USER
DB_PASSWORD
```

e apontar para o endpoint privado do RDS.

---

### Resumo geral

```text
                    AWS us-east-1
                         │
                    ┌────▼────┐
                    │   VPC   │
                    └────┬────┘
                         │
          ┌──────────────┴──────────────┐
          │                             │
     Subnets públicas             Subnets privadas
          │                             │
          ▼                             ▼
       EC2 API  ────── :5432 ──────► RDS PostgreSQL
          │
       :3000
          │
       Internet

Terraform
   │
   ├── VPC module              ✅
   ├── Security Group module   ✅
   ├── EC2 module              ✅
   ├── RDS module              ✅
   ├── Composition             🟡
   ├── Provider                 ⬜
   ├── Variables                ⬜
   ├── Outputs                  ⬜
   ├── S3 Remote State          ⬜
   └── DynamoDB Locking         ⬜
```

**A próxima etapa lógica é fechar o `infraestrutura/` — `providers.tf`, `variables.tf`, `terraform.tfvars`, `outputs.tf` e revisar o `main.tf` — antes de criarmos o Remote State.**


## 27. GPT

> **Prompt do autor**
>
> entao vamos finalizar a infraestrutura agora



Vamos. O próximo passo é fechar o **`infraestrutura/`**, deixando a composição dos módulos pronta para depois fazer `terraform init`, `validate` e `plan`.

### 1. `infraestrutura/providers.tf`

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### 2. `infraestrutura/variables.tf`

```hcl
variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "reservas"
}

variable "vpc_cidr" {
  description = "CIDR da VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones utilizadas"
  type        = list(string)

  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "public_subnets" {
  description = "Subnets públicas por Availability Zone"
  type        = map(string)

  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.3.0/24"
  }
}

variable "private_subnets" {
  description = "Subnets privadas por Availability Zone"
  type        = map(string)

  default = {
    "us-east-1a" = "10.0.2.0/24"
    "us-east-1b" = "10.0.4.0/24"
  }
}

variable "db_name" {
  description = "Nome do banco PostgreSQL"
  type        = string
  default     = "reservas"
}

variable "db_username" {
  description = "Usuário do PostgreSQL"
  type        = string
}

variable "db_password" {
  description = "Senha do PostgreSQL"
  type        = string
  sensitive   = true
}
```

### 3. `infraestrutura/main.tf`

Aqui acontece a composição dos módulos:

```hcl
module "vpc" {
  source = "../modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
}

module "security_group" {
  source = "../modules/security-group"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}

module "ec2" {
  source = "../modules/ec2"

  project_name      = var.project_name
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.security_group.ec2_sg_id

  instance_profile = "LabInstanceProfile"
  key_name         = "technova-key"
}

module "rds" {
  source = "../modules/rds"

  project_name         = var.project_name
  db_subnet_group_name = module.vpc.db_subnet_group_name
  security_group_id    = module.security_group.rds_sg_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
```

Esse arquivo é justamente o que demonstra a **composição entre módulos** exigida no projeto.

### 4. `infraestrutura/outputs.tf`

```hcl
output "ec2_public_ip" {
  description = "IP público da EC2"
  value       = module.ec2.public_ip
}

output "ec2_public_dns" {
  description = "DNS público da EC2"
  value       = module.ec2.public_dns
}

output "rds_endpoint" {
  description = "Endpoint do PostgreSQL"
  value       = module.rds.rds_endpoint
}

output "rds_port" {
  description = "Porta do PostgreSQL"
  value       = module.rds.rds_port
}

output "api_url" {
  description = "URL da API de reservas"
  value       = "http://${module.ec2.public_ip}:3000"
}
```

### 5. `infraestrutura/terraform.tfvars`

Para não colocar a senha diretamente no código versionado, podemos deixar assim:

```hcl
project_name = "reservas"

db_username = "reservas_admin"

db_password = "ALTERE_ESTA_SENHA"
```

**Não coloque esse arquivo no Git** se ele contiver a senha real. Depois podemos colocar `terraform.tfvars` no `.gitignore` e usar uma variável de ambiente ou outro mecanismo para fornecer a senha.

A estrutura agora fica:

```text
terraform/
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── ec2/
│   └── rds/
│
└── infra/
    ├── main.tf
    ├── providers.tf
    ├── variables.tf
    ├── outputs.tf
    └── terraform.tfvars
```


## 28. GPT

> **Prompt do autor**
>
> agora vamos criar o backend com os parametros que eu já te mandei


Sim. Agora vamos configurar o **Remote State** usando o bucket que você definiu:

```text
S3: prova-devops6325054
Região: us-east-1
Locking: DynamoDB
```

### `infraestrutura/backend.tf`

```hcl
terraform {
  backend "s3" {
    bucket         = "prova-devops6325054"
    key            = "reservas/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "reservas-terraform-lock"
  }
}
```

O que cada configuração faz:

```text
bucket
└── prova-devops6325054
      └── onde o state será armazenado

key
└── reservas/terraform.tfstate
      └── caminho do state dentro do bucket

region
└── us-east-1

encrypt
└── protege o state armazenado no S3

dynamodb_table
└── reservas-terraform-lock
      └── impede alterações simultâneas no state
```

### Importante

O `backend.tf` **não cria o bucket nem a tabela DynamoDB**. O backend precisa existir antes do Terraform conseguir utilizá-lo.

Portanto, teremos:

```text
AWS
│
├── S3
│   └── prova-devops6325054
│       └── reservas/terraform.tfstate
│
└── DynamoDB
    └── reservas-terraform-lock
```

Como você quer que a infraestrutura **crie e gerencie o bucket**, existe uma questão importante: **não podemos usar esse mesmo bucket como backend antes de ele existir**.

O próximo passo será criar uma pequena infraestrutura de bootstrap para:

1. Criar `prova-devops6325054`.
2. Habilitar versionamento.
3. Habilitar criptografia.
4. Criar `reservas-terraform-lock`.
5. Depois inicializar o backend S3.

Isso evita o problema clássico de **"chicken and egg" do Terraform backend**.


## 29. GPT

> **Prompt do autor**
>
> vamos adicionar o user_data.sh no nosso projeto agora, não se esqueça de colocar o sudo em comandos de instalação e outros que necessitar


Sim. Vamos adicionar o `user_data.sh` agora, já seguindo o padrão que você usou anteriormente: **Amazon Linux 2023 e `sudo` nos comandos que exigem privilégio**.

### 1. Criar a pasta e o arquivo

Na raiz do projeto:

```bash
mkdir -p scripts
touch scripts/user_data.sh
chmod +x scripts/user_data.sh
```

### 2. `scripts/user_data.sh`

Coloque este conteúdo:

```bash
#!/bin/bash

set -e

# Atualiza os pacotes do sistema
sudo dnf update -y

# Instala Docker
sudo dnf install -y docker

# Inicia o serviço Docker
sudo systemctl start docker
sudo systemctl enable docker

# Adiciona o usuário ec2-user ao grupo Docker
sudo usermod -aG docker ec2-user

# Instala Docker Compose
sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
  -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Verifica as instalações
sudo docker --version
sudo docker-compose --version

# Cria diretório da aplicação
sudo mkdir -p /opt/reservas
sudo chown -R ec2-user:ec2-user /opt/reservas

echo "Configuração inicial da EC2 concluída."
```

### 3. Conectar ao Terraform

No arquivo:

```text
terraform/modules/ec2/main.tf
```

adicione:

```hcl
user_data = file("${path.root}/../scripts/user_data.sh")
```

ficando:

```hcl
resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = var.key_name
  iam_instance_profile        = var.instance_profile
  associate_public_ip_address = true

  user_data = file("${path.root}/../scripts/user_data.sh")

  tags = {
    Name        = "${var.project_name}-api"
    Project     = var.project_name
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}
```

### 4. Importante

O caminho:

```hcl
"${path.root}/../scripts/user_data.sh"
```

funciona porque nosso `main.tf` principal está em:

```text
terraform/infra/
```

e o script está em:

```text
scripts/
└── user_data.sh
```

Ou seja:

```text
reservas/
├── scripts/
│   └── user_data.sh
│
└── terraform/
    └── infra/
        └── main.tf
```

Depois podemos fazer:

```bash
cd terraform/infra
terraform fmt -recursive
terraform validate
```

**Ainda não precisamos executar `terraform apply`.** Primeiro vamos terminar o `bootstrap` do S3/DynamoDB e conferir o `plan` completo.


## 30. GPT

> **Prompt do autor**
>
> ok vamos la


Beleza. Vamos seguir **passo a passo**, sem aplicar nada na AWS ainda.

O próximo passo é criar o **bootstrap**, que vai preparar o Remote State:

```text
S3
└── prova-devops6325054
    ├── versionamento
    └── criptografia

DynamoDB
└── reservas-terraform-lock
```

Depois disso configuramos o `backend.tf` e partimos para o `terraform init`.

### 1. Criar a estrutura

Na raiz do projeto:

```bash
mkdir -p terraform/bootstrap
touch terraform/bootstrap/main.tf
touch terraform/bootstrap/providers.tf
touch terraform/bootstrap/variables.tf
```

### 2. `terraform/bootstrap/providers.tf`

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### 3. `terraform/bootstrap/variables.tf`

```hcl
variable "bucket_name" {
  description = "Nome do bucket S3 utilizado pelo Terraform Remote State"
  type        = string
  default     = "prova-devops6325054"
}

variable "dynamodb_table_name" {
  description = "Nome da tabela DynamoDB utilizada para locking"
  type        = string
  default     = "reservas-terraform-lock"
}
```

### 4. `terraform/bootstrap/main.tf`

```hcl
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Project     = "reservas"
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_lock" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.dynamodb_table_name
    Project     = "reservas"
    Environment = "lab"
    ManagedBy   = "Terraform"
  }
}
```

### 5. Agora validar o Bootstrap

Entre na pasta:

```bash
cd terraform/bootstrap
```

Inicialize:

```bash
terraform init
```

Depois:

```bash
terraform fmt
terraform validate
```

E finalmente:

```bash
terraform plan
```

**Pare no `terraform plan` por enquanto.** Não execute `terraform apply` ainda.

Se tudo estiver correto, o próximo passo será aplicar **somente o bootstrap**, criar o S3/DynamoDB e então configurar o `backend.tf` do projeto principal.

> **Comentário do autor**
>
> tive alguns problemas na execução e acabei perdendo alguns prompts, estao pedi pro kiro relatar oque nos fizemos ate a infraestrutura ficar pronta



## 31. KIRO

> **Prompt do autor**
>
> me de um relatório do o que fizemos nas últimas 2 horas


Aqui vai o resumo completo do que fizemos:

Relatório da Sessão
1. Análise inicial do projeto vs. enunciado da prova
Lemos todos os arquivos do projeto e comparamos com os requisitos. Identificamos o que estava correto (Docker, Compose, API, Terraform) e o que faltava (README incompleto, menos de 6 commits, sem feature branch, sem evidencias/, sem relatório.md).

2. Configuração das credenciais AWS
Criamos o arquivo ~/.aws/credentials com as credenciais temporárias do AWS Academy Learner Lab (access key, secret key e session token).

3. Correção do user_data.sh
O script original tinha vários problemas:

set -e que matava o script em qualquer erro
Clonava o repo no diretório errado (/ em vez de /opt/reservas)
Subia o compose sem o .env (a API crasharia sem as variáveis de banco)
Usava dnf (Amazon Linux) — depois migrado para apt (Ubuntu)
Reescrevemos o script para:

Instalar Docker via repositório oficial da Docker
Clonar o repo corretamente em /opt/reservas
Criar o .env com os valores do banco injetados pelo Terraform via templatefile
Subir apenas o serviço API (sem postgres local, pois o banco é o RDS)
4. Descoberta e correção da estrutura de módulos
Os módulos Terraform estavam em /modules/ na raiz do projeto, mas o 
main.tf
 apontava para ../modules/ e depois ./modules/ (dentro de infraestrutura/). Copiamos os módulos para infraestrutura/modules/ para alinhar com o que o main.tf referenciava.

5. Correção do módulo EC2
Adicionamos as variáveis db_host, db_name, db_user, db_password no variables.tf do módulo
Trocamos file() por templatefile() no main.tf do módulo para injetar os valores do banco no user_data.sh
6. Correção do 
main.tf
Corrigimos os source de ../modules/ para ./modules/
Movemos o módulo rds para antes do módulo ec2 na ordem de declaração
Adicionamos depends_on = [module.rds] no módulo ec2 para garantir que o RDS existe antes de a EC2 tentar se conectar
Passamos o module.rds.rds_endpoint como db_host para o módulo ec2
7. Adição da variável key_name
A chave SSH estava hardcoded como "technova-key" no main.tf. Transformamos em variável, adicionamos em variables.tf e incluímos no terraform.tfvars.

8. Correção do terraform.tfvars
Consultamos a AWS para listar os key pairs disponíveis (technova-key e vockey). Preenchemos o arquivo com os valores reais:

key_name = "*******"
db_password = "******"
9. Migração de Amazon Linux para Ubuntu
Por solicitação, trocamos a AMI de Amazon Linux 2023 para Ubuntu 22.04 LTS (Canonical). Atualizamos:


main.tf
: novo data "aws_ami" buscando Ubuntu Jammy 22.04

user_data.sh
: trocado dnf por apt-get, instalação do Docker pelo repositório oficial, usuário ubuntu no lugar de ec2-user
10. Correção do SSH
O .pem estava na raiz do projeto mas o SSH procurava em ~/.ssh/. Copiamos a chave para o local correto com permissão 400:


~/.ssh/technova-key.pem
Confirmamos também que o .gitignore já protegia *.pem para não subir ao GitHub.

Estado atual
O projeto está pronto para rodar na AWS. O fluxo é:

cd terraform/bootstrap && terraform init && terraform apply — cria S3 + DynamoDB
cd infraestrutura && terraform init && terraform apply — sobe VPC, SGs, RDS e EC2
A EC2 sobe automaticamente com a API rodando via user_data.sh
SSH: ssh -i ~/.ssh/technova-key.pem ubuntu@<IP>

---

## Observação final

Este documento foi organizado a partir do histórico fornecido, preservando a sequência das interações e diferenciando os prompts do autor, os comentários pessoais e as respostas das ferramentas de IA. A revisão textual teve como objetivo corrigir ortografia, acentuação, concordância e padronização, sem alterar a finalidade técnica registrada no histórico.