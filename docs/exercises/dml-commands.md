# 📊 Comandos DML (Data Manipulation Language)

> **DML** são comandos usados para manipular os dados dentro das tabelas

## 📋 Índice

-   [INSERT](#insert)
-   [UPDATE](#update)
-   [DELETE](#delete)
-   [SELECT Básico](#select-básico)
-   [Exercícios Práticos](#exercícios-práticos)

## INSERT

**Função**: Insere novos registros na tabela

### Sintaxe Básica

```sql
-- Inserindo um registro
INSERT INTO nome_tabela (campo1, campo2, campo3)
VALUES (valor1, valor2, valor3);

-- Inserindo múltiplos registros
INSERT INTO nome_tabela (campo1, campo2, campo3)
VALUES
    (valor1a, valor2a, valor3a),
    (valor1b, valor2b, valor3b),
    (valor1c, valor2c, valor3c);
```

### Exemplos da Atividade

#### Inserindo Professores

```sql
-- Um professor por vez
INSERT INTO PROFESSOR (nome, cidade)
VALUES ('Sandro Roberto Armelin', 'Itapira');

-- Múltiplos professores de uma vez (mais eficiente)
INSERT INTO PROFESSOR (nome, cidade) VALUES
('Sandro Roberto Armelin', 'Itapira'),
('Marcos', 'Mogi Guaçu'),
('Ana Julia', 'Mogi Mirim');
```

#### Inserindo Alunos

```sql
INSERT INTO ALUNOS (NOME, CIDADE) VALUES
('Alex', 'Mogi Mirim'),
('Beatriz', 'Mogi Guaçu'),
('Carlos', 'Itapira'),
('Daniela', 'Mogi Mirim'),
('Eduardo', 'Jacutinga'),
('Fernanda', 'Espírito Santo do Pinhal'),
('Guilherme', 'Mogi Guaçu'),
('Heloisa', 'Conchal'),
('Igor', 'Mogi Mirim'),
('Pedro Paulo Cunha', 'Itapira');
```

#### Inserindo Históricos (com relacionamentos)

```sql
-- Relacionando aluno (RA), disciplina e professor
INSERT INTO HISTORICO (ra, codigodisciplina, codigoprofessor, semestre, faltas, nota) VALUES
(1, 1, 1, 1, 4, 8.5),   -- Alex, BD, Sandro
(10, 1, 1, 2, 8, 4.5),  -- Pedro Paulo, BD, Sandro (nota < 5)
(2, 2, 2, 1, 2, 7.0);   -- Beatriz, SO, Marcos
```

### 💡 Dicas para INSERT

-   **Não inclua** campos IDENTITY (são gerados automaticamente)
-   **Mantenha a ordem** dos campos e valores
-   **Use aspas simples** para texto: `'texto'`
-   **Não use aspas** para números: `123` ou `7.5`
-   **Para inserir todos os campos**, pode omitir a lista de campos

---

## UPDATE

**Função**: Modifica registros existentes na tabela

### Sintaxe Básica

```sql
UPDATE nome_tabela
SET campo1 = novo_valor1, campo2 = novo_valor2
WHERE condição;
```

### ⚠️ ATENÇÃO: Sempre use WHERE!

```sql
-- ❌ PERIGOSO - Atualiza TODOS os registros
UPDATE HISTORICO SET ano = 2020;

-- ✅ CORRETO - Atualiza apenas registros específicos
UPDATE HISTORICO SET ano = 2020 WHERE codigohistorico BETWEEN 1 AND 5;
```

### Exemplo da Atividade (Questão 5)

```sql
-- Definindo o ano para registros específicos
UPDATE HISTORICO SET ano = 2020 WHERE codigohistorico IN (1, 2, 5, 8, 11, 14, 15);
UPDATE HISTORICO SET ano = 2019 WHERE codigohistorico IN (3, 4, 6, 7, 9, 10, 12, 13);
```

### Outros Exemplos de UPDATE

```sql
-- Atualizando um campo
UPDATE ALUNOS SET CIDADE = 'São Paulo' WHERE RA = 1;

-- Atualizando múltiplos campos
UPDATE HISTORICO
SET nota = 7.0, faltas = 2
WHERE codigohistorico = 1;

-- Atualizando com base em condições
UPDATE HISTORICO
SET nota = nota + 1.0
WHERE nota < 5.0 AND semestre = 1;
```

### Operadores para WHERE

| Operador     | Descrição           | Exemplo                          |
| ------------ | ------------------- | -------------------------------- |
| `=`          | Igual               | `WHERE idade = 25`               |
| `<>` ou `!=` | Diferente           | `WHERE cidade <> 'São Paulo'`    |
| `>`          | Maior que           | `WHERE nota > 7.0`               |
| `<`          | Menor que           | `WHERE faltas < 5`               |
| `>=`         | Maior ou igual      | `WHERE nota >= 6.0`              |
| `<=`         | Menor ou igual      | `WHERE faltas <= 10`             |
| `LIKE`       | Padrão de texto     | `WHERE nome LIKE 'João%'`        |
| `IN`         | Dentro de uma lista | `WHERE id IN (1, 2, 3)`          |
| `BETWEEN`    | Entre valores       | `WHERE nota BETWEEN 5.0 AND 8.0` |

---

## DELETE

**Função**: Remove registros da tabela

### Sintaxe Básica

```sql
DELETE FROM nome_tabela WHERE condição;
```

### ⚠️ ATENÇÃO: Sempre use WHERE!

```sql
-- ❌ EXTREMAMENTE PERIGOSO - Apaga TODOS os registros
DELETE FROM HISTORICO;

-- ✅ CORRETO - Apaga apenas registros específicos
DELETE FROM HISTORICO WHERE codigohistorico = 1;
```

### Exemplos Práticos

```sql
-- Removendo um registro específico
DELETE FROM HISTORICO WHERE codigohistorico = 1;

-- Removendo múltiplos registros
DELETE FROM HISTORICO WHERE nota < 5.0;

-- Removendo com múltiplas condições
DELETE FROM HISTORICO WHERE semestre = 1 AND faltas > 15;

-- Removendo registros de uma lista
DELETE FROM HISTORICO WHERE codigohistorico IN (1, 2, 3);
```

### 🔄 Integridade Referencial

```sql
-- ❌ ERRO - Não pode deletar professor que tem históricos
DELETE FROM PROFESSOR WHERE codigoprofessor = 1;

-- ✅ CORRETO - Primeiro delete os históricos, depois o professor
DELETE FROM HISTORICO WHERE codigoprofessor = 1;
DELETE FROM PROFESSOR WHERE codigoprofessor = 1;
```

---

## SELECT Básico

**Função**: Consulta dados da tabela

### Sintaxe Básica

```sql
SELECT campos FROM tabela WHERE condições;
```

### Exemplos Básicos

```sql
-- Selecionar todos os campos
SELECT * FROM ALUNOS;

-- Selecionar campos específicos
SELECT NOME, CIDADE FROM ALUNOS;

-- Com filtro
SELECT NOME FROM ALUNOS WHERE CIDADE = 'Mogi Mirim';

-- Com ordenação
SELECT NOME, CIDADE FROM ALUNOS ORDER BY NOME;

-- Contando registros
SELECT COUNT(*) FROM ALUNOS;

-- Valores únicos
SELECT DISTINCT CIDADE FROM ALUNOS;
```

---

## 📝 Exercícios Práticos

### Exercício 1: INSERT Básico

```sql
-- Crie e insira dados em uma tabela "Funcionarios"
-- Campos: id (PK, identity), nome, cargo, salario, departamento

-- SOLUÇÃO:
CREATE TABLE Funcionarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario FLOAT,
    departamento VARCHAR(50)
);

INSERT INTO Funcionarios (nome, cargo, salario, departamento) VALUES
('João Silva', 'Analista', 5000.00, 'TI'),
('Maria Santos', 'Gerente', 8000.00, 'Vendas'),
('Pedro Oliveira', 'Desenvolvedor', 6000.00, 'TI');
```

### Exercício 2: UPDATE com Condições

```sql
-- Aumente em 10% o salário de todos os funcionários do departamento de TI
-- Mude o cargo de 'Analista' para 'Analista Sênior' para quem ganha mais de 5000

-- SOLUÇÃO:
UPDATE Funcionarios
SET salario = salario * 1.10
WHERE departamento = 'TI';

UPDATE Funcionarios
SET cargo = 'Analista Sênior'
WHERE cargo = 'Analista' AND salario > 5000;
```

### Exercício 3: DELETE com Cuidado

```sql
-- Remove funcionários com salário menor que 3000
-- Remove todos os registros do departamento 'Temporário'

-- SOLUÇÃO:
DELETE FROM Funcionarios WHERE salario < 3000;
DELETE FROM Funcionarios WHERE departamento = 'Temporário';
```

---

## 🎯 Dicas para a Prova

### ✅ Checklist DML

-   [ ] Memorizar sintaxe básica do INSERT
-   [ ] Saber inserir múltiplos registros de uma vez
-   [ ] Sempre usar WHERE no UPDATE e DELETE
-   [ ] Conhecer operadores de comparação
-   [ ] Entender ordem de execução em relacionamentos

### 📝 Padrões de Escrita

```sql
-- INSERT com múltiplos registros
INSERT INTO TABELA (campo1, campo2) VALUES
(valor1a, valor2a),
(valor1b, valor2b),
(valor1c, valor2c);

-- UPDATE sempre com WHERE
UPDATE TABELA
SET campo = novo_valor
WHERE condição_específica;

-- DELETE sempre com WHERE
DELETE FROM TABELA
WHERE condição_específica;
```

### ⚠️ Erros Comuns

-   **Esquecer WHERE** no UPDATE/DELETE (modifica/apaga tudo!)
-   **Ordem errada** nas listas VALUES
-   **Aspas duplas** em texto (usar aspas simples)
-   **Incluir campos IDENTITY** no INSERT
-   **Não respeitar** integridade referencial

### 🔄 Ordem de Execução

```sql
-- 1. Primeiro insira tabelas "pai" (sem FK)
INSERT INTO PROFESSOR...
INSERT INTO DISCIPLINA...
INSERT INTO ALUNOS...

-- 2. Depois insira tabelas "filha" (com FK)
INSERT INTO HISTORICO...

-- Para DELETE, ordem inversa:
-- 1. Primeiro delete "filhas"
DELETE FROM HISTORICO...

-- 2. Depois delete "pai"
DELETE FROM PROFESSOR...
```

---

**💡 Lembre-se**: DML manipula os **dados** das tabelas. Sempre tenha cuidado com UPDATE e DELETE!
