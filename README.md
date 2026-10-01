# Prova Primeiro Bimestre Devops

**Aluno:** Leonardo Rafael Contini Costa 
**RA:** 6325054  
**Disciplina:** DevOps — Análise e Desenvolvimento de Sistemas 2026.2

API de Reservas construída com Node.js/Express e PostgreSQL, containerizada com Docker e com infraestrutura provisionada na AWS via Terraform modularizado.

---
**Evidências e relatório com todos os meus prompts da IA estão na pasta evidências**

---

## Rodar local com Docker Compose

O ambiente local sobe a API + PostgreSQL em containers. O banco é criado automaticamente pelo `init.sql`.

**Copie o `.env.example` e preencha as variáveis:**
```bash
cp .env.example .env
```

O `.env` para rodar local deve ter `DB_HOST=postgres` (nome do serviço no compose):
```env
PORT=3000
DB_HOST=postgres
DB_PORT=5432
DB_NAME=reservas
DB_USER=postgres
DB_PASSWORD=postgres
```

**Suba os containers:**
```bash
docker compose up -d --build
```

**Teste a API:**
```bash
curl http://localhost:3000/health
curl http://localhost:3000/api/reservas
```

Comando para uma crianção de dados na API
```bash
curl -X POST http://localhost:3000/api/reservas \
  -H "Content-Type: application/json" \
  -d '{
    "nome_cliente": "Fernanda Lima",
    "data_reserva": "2026-10-31T21:00:00",
    "numero_pessoas": 3,
    "observacoes": "Reserva para área externa / terraço"
  }'

```

**Para derrubar:**
```bash
docker compose down
```

---

## Rodar na AWS com Terraform + RDS

Na nuvem, o banco é o RDS PostgreSQL (não o postgres do compose). O `docker-compose.yml.example` contém apenas o serviço da API, sem postgres local.

Assim, para subir a API na nuvem rode:
```bash
rm docker-compose.yml

cp docker-compose.yml.example docker-compose.yml

```
Faça isso para API gravar os dados na RDS, caso contraio o docker vai subir uma imagem postgres dentro da EC2 e irá guardar os dados dentro de seu compose local (será necessário a criação de um novo repositório ou um fork e atualizar os dados em scripts/user_data.sh)

**Suba o bootstrap (S3 + DynamoDB para remote state):**

Dentro da pasta bootstrap rode:

```bash
terraform init
terraform apply -auto-approve
```

**Configure o `infra/terraform.tfvars` com suas credenciais:**
```hcl
project_name = "reservas"
db_username  = "reservas_admin"
db_password  = "sua_senha_aqui"
key_name     = "nome-da-sua-chave-aws"
```

**Suba a infraestrutura:**

Dentro da pasta infra rode:

```bash
terraform init
terraform apply -auto-approve
```

Ao final do `apply`, os outputs mostram o IP da EC2 e o endpoint do RDS.

**A EC2 sobe automaticamente com a API rodando.** O `user_data.sh` clona o repositório, cria o `.env` com o endpoint do RDS e sobe o container usando o `docker-compose.yml.example` como referência — apenas o serviço `api`, sem postgres local.

**Para entrar terminal de sua maquina na AWS use**
```bash
ssh -i ~/.ssh/sua-chave.pem ubuntu@<EC2_PUBLIC_IP>
```

**Use esse script para criar as tabelas na aws, ele só precisa ser usado uma vez**
```bash
psql -U seu_usuario -d seu_banco -c "CREATE TABLE IF NOT EXISTS reservas (id SERIAL PRIMARY KEY, nome_cliente VARCHAR(100) NOT NULL, data_reserva TIMESTAMP NOT NULL, numero_pessoas INT, observacoes TEXT, status VARCHAR(20) DEFAULT 'confirmada', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);"

```
Isso só precisa ser feito na aws, quando rodamos o docker local o postgres já roda o arquivo init.sql, assim já criando as tabelas automaticamente 


**Teste a API na nuvem:**
```bash
curl http://<EC2_PUBLIC_IP>:3000/health
curl http://<EC2_PUBLIC_IP>:3000/api/reservas
```

---

**API rodando local**

![](evidencias/Imagem%20colada%20(3).png)

![](evidencias/Imagem%20colada%20(5).png)

![](evidencias/Imagem%20colada%20(6).png)

![](evidencias/Imagem%20colada%20(7).png)

**Plan do bootstrap**

![](evidencias/Imagem%20colada%20(8).png)

**Plan e apply da infra**

![](evidencias/Imagem%20colada%20(9).png)

**Apply completo e API rodando na aws**

![](evidencias/Imagem%20colada%20(24).png)

![](evidencias/Imagem%20colada%20(25).png)

![](evidencias/Imagem%20colada%20(26).png)

**Docker ps do server aws**

![](evidencias/Imagem%20colada%20(27).png)

**Configs do OS da maquina**

![](evidencias/Imagem%20colada%20(27).png)




