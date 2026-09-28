#!/bin/bash

# Atualiza os pacotes do sistema
apt-get update -y
apt-get upgrade -y

# Instala dependências
apt-get install -y git curl ca-certificates gnupg

# Instala Docker via repositório oficial
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Inicia e habilita o Docker
systemctl start docker
systemctl enable docker

# Adiciona ubuntu ao grupo docker
usermod -aG docker ubuntu

# Cria diretório da aplicação
mkdir -p /opt/reservas
cd /opt/reservas

# Clona o repositório
git clone https://github.com/leonardocontini/prova-primeiro-bimestre-devops.git .

# Cria o .env com as variáveis do banco (valores injetados pelo Terraform)
cat > /opt/reservas/.env << ENVEOF
PORT=3000
DB_HOST=${db_host}
DB_PORT=5432
DB_NAME=${db_name}
DB_USER=${db_user}
DB_PASSWORD=${db_password}
ENVEOF

# Ajusta permissões
chown -R ubuntu:ubuntu /opt/reservas

# Sobe apenas o serviço da API (banco é o RDS, não o compose local)
docker compose up -d --build api

echo "Configuração inicial da EC2 concluída."
