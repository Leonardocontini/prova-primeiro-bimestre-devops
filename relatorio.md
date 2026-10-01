## Questão 1 — A Jornada Completa (Aulas 01 a 07)

Durante o bimestre, fui construindo a API de Reservas por etapas, começando pelo desenvolvimento da aplicação e chegando à infraestrutura na AWS.

Primeiro desenvolvi a API em **Node.js com Express**, criando as rotas de CRUD de reservas e a rota `/health`. Depois utilizei **PostgreSQL** para persistência dos dados e **Docker/ Docker Compose** para padronizar a execução da aplicação e do banco localmente.

Em seguida, coloquei o projeto no **Git/GitHub**, o que permitiu versionar as alterações e manter o código organizado. Depois comecei a transformar a infraestrutura em código utilizando **Terraform**.

A infraestrutura foi dividida em módulos, principalmente:

* `vpc` — criação da rede, subnets públicas e privadas;
* `security-group` — regras de acesso da EC2 e do RDS;
* `ec2` — criação da máquina que executa a API;
* `rds` — criação do PostgreSQL gerenciado.

Também configurei **remote state no S3**, utilizando DynamoDB para controle de lock do estado.

A ordem foi importante porque primeiro precisava ter a aplicação funcionando, depois precisava conseguir executá-la de forma padronizada com Docker e, por fim, criar a infraestrutura necessária para executar essa aplicação na nuvem.

As aulas foram aplicadas de forma progressiva: desenvolvimento e versionamento nas primeiras etapas, Docker para empacotamento e execução, Terraform para infraestrutura como código, módulos para organização e reutilização e, por fim, AWS/remote state para disponibilizar a aplicação em um ambiente de nuvem.

---

## Questão 2 — O Processo com IA como Copiloto

Utilizei o **ChatGPT e o Kiro como ferramenta de IA**, principalmente como copiloto durante o desenvolvimento. Eu apresentava os requisitos da atividade e trechos do código e utilizava a IA para gerar uma primeira versão, explicar erros e sugerir correções.

Alguns dos prompts foram relacionados à criação da API Node.js, configuração do Docker Compose, criação dos módulos Terraform, configuração do RDS e EC2 e integração entre a API e o banco de dados.

A IA ajudou bastante na criação de estruturas iniciais e principalmente na explicação de erros. Por exemplo, durante a configuração da EC2, ela ajudou a identificar problemas relacionados ao Docker Buildx, às permissões do usuário `ubuntu` e à configuração das variáveis de ambiente para conexão com o RDS.

Por outro lado, nem todo código gerado poderia ser utilizado diretamente. Foi necessário corrigir nomes de variáveis, caminhos dos arquivos, configurações do Docker Compose e detalhes específicos do AWS Academy. Um exemplo foi a diferença entre `db_user` e `db_username`, que causou erro no `templatefile` do Terraform.

Comparando com fazer tudo manualmente, a IA economizou bastante tempo principalmente na criação da estrutura inicial e na investigação de erros. Porém, também exigiu revisão, porque uma resposta aparentemente correta pode não estar adequada ao ambiente real da atividade.

Não utilizei a IA como substituta da validação. Eu testava as alterações com comandos como `terraform validate`, `terraform plan`, `terraform apply`, `docker ps` e testes da API.

---

## Questão 3 — Infraestrutura, Segurança e o Learner Lab

A arquitetura final foi organizada aproximadamente desta forma:

```text
                    INTERNET
                       |
                       |
                +--------------+
                |     EC2      |
                |   Ubuntu     |
                |    Docker    |
                |     API      |
                +--------------+
                       |
                       | PostgreSQL :5432
                       |
                +--------------+
                |     RDS      |
                |  PostgreSQL  |
                | Private Subnet
                +--------------+

             VPC 10.0.0.0/16
```

A **EC2 ficou em uma subnet pública** porque precisava receber acesso externo para disponibilizar a API e permitir acesso administrativo por SSH.

O **RDS ficou em subnets privadas** porque o banco não precisava ser acessado diretamente pela Internet. O acesso ao PostgreSQL foi restringido pelo Security Group para permitir a porta `5432` somente a partir do Security Group da EC2.

A infraestrutura foi dividida em módulos Terraform para facilitar a organização:

```text
infra/
├── modules/
│   ├── vpc/
│   ├── security-group/
│   ├── ec2/
│   └── rds/
```

No AWS Academy Learner Lab não era possível simplesmente criar qualquer recurso de IAM como em uma conta AWS comum. Por isso utilizei o **LabInstanceProfile/LabRole disponibilizado pelo ambiente**, em vez de criar uma estrutura própria de IAM.

Também foi necessário trabalhar com as limitações do Learner Lab, como as **credenciais temporárias**, a região disponibilizada para o laboratório (`us-east-1`) e as restrições para criação e gerenciamento de determinados recursos.

O remote state foi configurado utilizando o bucket S3 fornecido para a atividade e uma tabela DynamoDB para controle de lock.

---

## Questão 4 — Validação e Responsabilidade

Antes de executar `terraform apply`, utilizei um processo de validação para não aceitar automaticamente o código produzido pela IA.

Primeiro verificava a estrutura e os arquivos Terraform e executava:

```bash
terraform fmt -recursive
terraform validate
```

Depois analisava o resultado do:

```bash
terraform plan
```

para verificar quais recursos seriam criados, alterados ou destruídos.

Também conferia pontos de segurança, principalmente:

* RDS sem acesso público;
* RDS em subnet privada;
* porta `5432` liberada somente para a EC2;
* portas da EC2 necessárias para a aplicação;
* armazenamento criptografado no RDS;
* uso de variáveis para credenciais;
* configuração correta do remote state;
* uso dos módulos corretos;
* dependências entre EC2 e RDS.

Depois da criação, também validei a infraestrutura diretamente na EC2. Por exemplo, verifiquei os containers com:

```bash
docker ps
```

e testei a API:

```bash
curl http://<ip-da-ec2>:3000/health
```

Também conferi se a aplicação estava recebendo as variáveis corretas do RDS.

Se eu simplesmente aceitasse o código da IA sem revisar, poderia acabar criando recursos incorretamente, deixando portas abertas desnecessariamente, utilizando credenciais de forma insegura ou criando uma infraestrutura que não funcionasse no ambiente do Learner Lab.

A evolução **Git → Docker → Terraform → Modules** foi importante porque cada etapa aumentou meu entendimento sobre o projeto. Com isso, a IA passou a ser uma ferramenta de apoio e não uma fonte que eu simplesmente copio e executo. Eu consigo analisar o código, entender o que ele está fazendo, testar e identificar quando uma sugestão da IA não está adequada ao meu ambiente.
