# 🏗️ Comandos DDL (Data Definition Language)

> **DDL** são comandos usados para definir e modificar a estrutura do banco de dados

## 📋 Índice

-   [CREATE DATABASE](#create-database)
-   [CREATE TABLE](#create-table)
-   [ALTER TABLE](#alter-table)
-   [DROP](#drop)
-   [Exercícios Práticos](#exercícios-práticos)

## CREATE DATABASE

**Função**: Cria um novo banco de dados

### Sintaxe Básica

```sql
CREATE DATABASE nome_do_banco;
```

### Exemplo Prático

```sql
-- Criando o banco de dados da atividade
CREATE DATABASE FATEC_MogiMirim;

-- Selecionando o banco para uso
USE FATEC_MogiMirim;
```

### 💡 Dicas Importantes

-   O nome do banco não pode conter espaços
-   Use nomes descritivos e significativos
-   Sempre use `USE` depois de criar o banco

---

## CREATE TABLE

**Função**: Cria uma nova tabela no banco de dados

### Sintaxe Básica

```sql
CREATE TABLE nome_tabela (
    campo1 tipo_de_dado [constraints],
    campo2 tipo_de_dado [constraints],
    ...
    [CONSTRAINT nome_constraint tipo_constraint]
);
```

### Tipos de Dados Mais Usados

| Tipo         | Descrição                       | Exemplo             |
| ------------ | ------------------------------- | ------------------- |
| `INT`        | Número inteiro                  | `idade INT`         |
| `VARCHAR(n)` | Texto variável até n caracteres | `nome VARCHAR(100)` |
| `FLOAT`      | Número decimal                  | `nota FLOAT`        |
| `DATE`       | Data                            | `nascimento DATE`   |
| `DATETIME`   | Data e hora                     | `cadastro DATETIME` |

### Constraints (Restrições)

| Constraint      | Função            | Exemplo                                            |
| --------------- | ----------------- | -------------------------------------------------- |
| `PRIMARY KEY`   | Chave primária    | `id INT PRIMARY KEY`                               |
| `FOREIGN KEY`   | Chave estrangeira | `FOREIGN KEY (id_cliente) REFERENCES clientes(id)` |
| `NOT NULL`      | Campo obrigatório | `nome VARCHAR(100) NOT NULL`                       |
| `IDENTITY(1,1)` | Auto incremento   | `id INT IDENTITY(1,1)`                             |
| `UNIQUE`        | Valor único       | `email VARCHAR(100) UNIQUE`                        |

### Exemplo da Atividade

```sql
-- Criando a tabela ALUNOS
CREATE TABLE ALUNOS (
    RA INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    NOME VARCHAR(100) NOT NULL,
    CIDADE VARCHAR(40)
);

-- Criando a tabela HISTORICO com chaves estrangeiras
CREATE TABLE HISTORICO (
    codigohistorico INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ra INT,
    codigodisciplina INT,
    codigoprofessor INT,
    semestre INT,
    faltas INT,
    nota FLOAT,
    FOREIGN KEY (ra) REFERENCES ALUNOS(RA),
    FOREIGN KEY (codigodisciplina) REFERENCES DISCIPLINA(codigodisciplina),
    FOREIGN KEY (codigoprofessor) REFERENCES PROFESSOR(codigoprofessor)
);
```

---

## ALTER TABLE

**Função**: Modifica a estrutura de uma tabela existente

### Adicionando Colunas

```sql
-- Sintaxe
ALTER TABLE nome_tabela ADD nome_coluna tipo_dado [constraints];

-- Exemplo da atividade (Questão 4)
ALTER TABLE HISTORICO ADD ano INT;
```

### Modificando Colunas

```sql
-- Alterando tipo de dado
ALTER TABLE nome_tabela ALTER COLUMN nome_coluna novo_tipo;

-- Exemplo
ALTER TABLE ALUNOS ALTER COLUMN NOME VARCHAR(200);
```

### Removendo Colunas

```sql
-- Sintaxe
ALTER TABLE nome_tabela DROP COLUMN nome_coluna;

-- Exemplo
ALTER TABLE HISTORICO DROP COLUMN campo_temporario;
```

### Adicionando Constraints

```sql
-- Adicionando chave primária
ALTER TABLE nome_tabela ADD CONSTRAINT PK_nome PRIMARY KEY (campo);

-- Adicionando chave estrangeira
ALTER TABLE tabela1 ADD CONSTRAINT FK_nome
FOREIGN KEY (campo) REFERENCES tabela2(campo);
```

---

## DROP

**Função**: Remove objetos do banco de dados

### Removendo Tabela

```sql
-- Remove a tabela completamente
DROP TABLE nome_tabela;

-- Exemplo
DROP TABLE HISTORICO; -- ⚠️ Remove todos os dados!
```

### Removendo Banco de Dados

```sql
-- Remove o banco completamente
DROP DATABASE nome_banco;

-- Exemplo
DROP DATABASE FATEC_MogiMirim; -- ⚠️ Remove tudo!
```

### ⚠️ Atenção com DROP

-   **IRREVERSÍVEL**: Uma vez executado, não há como desfazer
-   **Remove TODOS os dados**: Tabelas, registros, relacionamentos
-   **Use com extrema cautela**: Sempre faça backup antes

---

## 📝 Exercícios Práticos

### Exercício 1: Criação Básica

```sql
-- Crie um banco de dados chamado "Loja"
-- Crie uma tabela "Produtos" com:
-- - id (chave primária, auto incremento)
-- - nome (texto até 100 caracteres, obrigatório)
-- - preco (decimal)
-- - categoria (texto até 50 caracteres)

-- SOLUÇÃO:
CREATE DATABASE Loja;
USE Loja;

CREATE TABLE Produtos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco FLOAT,
    categoria VARCHAR(50)
);
```

### Exercício 2: Alteração de Estrutura

```sql
-- Na tabela Produtos criada acima:
-- 1. Adicione um campo "estoque" do tipo INT
-- 2. Modifique o campo "nome" para aceitar 150 caracteres
-- 3. Adicione um campo "data_cadastro" do tipo DATE

-- SOLUÇÃO:
ALTER TABLE Produtos ADD estoque INT;
ALTER TABLE Produtos ALTER COLUMN nome VARCHAR(150);
ALTER TABLE Produtos ADD data_cadastro DATE;
```

### Exercício 3: Relacionamentos

```sql
-- Crie uma tabela "Clientes" e relacione com "Pedidos"
-- Clientes: id, nome, email
-- Pedidos: id, id_cliente (FK), data_pedido, total

-- SOLUÇÃO:
CREATE TABLE Clientes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Pedidos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    total FLOAT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id)
);
```

---

## 🎯 Dicas para a Prova

### ✅ Checklist DDL

-   [ ] Memorizar sintaxe básica do CREATE TABLE
-   [ ] Entender IDENTITY(1,1) para auto incremento
-   [ ] Saber definir PRIMARY KEY e FOREIGN KEY
-   [ ] Conhecer principais tipos de dados (INT, VARCHAR, FLOAT)
-   [ ] Praticar ALTER TABLE ADD para adicionar colunas

### 📝 Modelo Mental para CREATE TABLE

```sql
CREATE TABLE NOME_TABELA (
    -- 1. Chave primária (sempre primeiro)
    id INT IDENTITY(1,1) PRIMARY KEY,

    -- 2. Campos obrigatórios
    nome VARCHAR(100) NOT NULL,

    -- 3. Campos opcionais
    campo_opcional VARCHAR(50),

    -- 4. Chaves estrangeiras (no final)
    id_relacionado INT,
    FOREIGN KEY (id_relacionado) REFERENCES OUTRA_TABELA(id)
);
```

### ⚠️ Erros Comuns

-   **Esquecer NOT NULL** em campos obrigatórios
-   **Não definir tamanho** do VARCHAR
-   **Esquecer IDENTITY** em chaves primárias
-   **Ordem errada** nas FOREIGN KEY (criar tabela pai primeiro)
-   **Nomes inconsistentes** (maiúscula/minúscula)

---

**💡 Lembre-se**: DDL define a **estrutura** do banco. É a base de tudo!
