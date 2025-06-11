# ⚡ Cola da Prova - Banco de Dados

> **Consulta rápida para a prova de 14/06/2025**

## 🏗️ DDL - Criação de Estruturas

### Criar Banco e Tabela

```sql
CREATE DATABASE nome_banco;
USE nome_banco;

CREATE TABLE TABELA (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    campo_fk INT,
    FOREIGN KEY (campo_fk) REFERENCES OUTRA_TABELA(id)
);
```

### Alterar Tabela

```sql
ALTER TABLE TABELA ADD nova_coluna INT;
ALTER TABLE TABELA ALTER COLUMN coluna VARCHAR(200);
ALTER TABLE TABELA DROP COLUMN coluna;
```

## 📊 DML - Manipulação de Dados

### Inserir Dados

```sql
-- Um registro
INSERT INTO TABELA (campo1, campo2) VALUES (valor1, valor2);

-- Múltiplos registros
INSERT INTO TABELA (campo1, campo2) VALUES
(valor1a, valor2a),
(valor1b, valor2b);
```

### Atualizar e Deletar

```sql
UPDATE TABELA SET campo = valor WHERE condição;
DELETE FROM TABELA WHERE condição;
```

## 🔍 SELECT - Consultas

### Estrutura Básica

```sql
SELECT [DISTINCT] campos
FROM tabela1 [AS alias1]
[JOIN tabela2 [AS alias2] ON condição]
[WHERE filtros]
[GROUP BY campos]
[HAVING filtros_de_grupo]
[ORDER BY campos];
```

### JOINs da Atividade

```sql
-- 2 tabelas
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra

-- 3 tabelas (+ Disciplina)
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina

-- 4 tabelas (+ Professor)
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor
```

## 🎯 Operadores e Funções

### Operadores de Comparação

```sql
=, <>, !=, <, >, <=, >=
LIKE 'padrão%'
IN (lista)
BETWEEN valor1 AND valor2
IS NULL, IS NOT NULL
```

### Funções de Agregação

```sql
COUNT(*)           -- Conta registros
COUNT(DISTINCT campo)  -- Conta únicos
SUM(campo)         -- Soma
AVG(campo)         -- Média
MAX(campo)         -- Máximo
MIN(campo)         -- Mínimo
```

### Lógicos

```sql
AND, OR, NOT
```

## 📋 Esquema da Atividade

### Tabelas e Relacionamentos

```
ALUNOS (RA, NOME, CIDADE)
PROFESSOR (codigoprofessor, nome, cidade)
DISCIPLINA (codigodisciplina, disciplina, cargahoraria)
HISTORICO (codigohistorico, ra, codigodisciplina, codigoprofessor, semestre, faltas, nota, ano)
```

### Dados Específicos

-   **Disciplinas**: Banco de Dados (80h), Sistemas Operacionais (80h), Rede de Computadores (60h), Estrutura de Dados (40h)
-   **Professores**: Sandro Roberto Armelin (Itapira), Marcos (Mogi Guaçu), Ana Julia (Mogi Mirim)
-   **Alunos**: Alex, Beatriz, Carlos, Daniela, Eduardo, Fernanda, Guilherme, Heloisa, Igor, Pedro Paulo Cunha
-   **Anos**: 2019 e 2020

## 🎯 Padrões das Questões

### Questão Tipo: "Alunos com nota < X"

```sql
SELECT A.NOME, A.RA
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Nome da Disciplina'
AND H.nota < X
AND H.semestre = Y;
```

### Questão Tipo: "Professores que ministraram X"

```sql
SELECT DISTINCT P.nome
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Nome da Disciplina'
AND H.ano = YYYY;
```

### Questão Tipo: "Quantidade por professor"

```sql
SELECT P.nome, COUNT(DISTINCT H.codigodisciplina) AS Quantidade
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
WHERE H.ano = YYYY
GROUP BY P.nome;
```

### Questão Tipo: "Histórico de aluno específico"

```sql
SELECT A.RA, A.NOME, D.disciplina, H.faltas, H.nota, H.ano, H.semestre
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE A.NOME = 'Nome do Aluno'
ORDER BY H.ano, H.semestre;
```

## ⚠️ Checklist Final

### Antes de Entregar

-   [ ] **WHERE sempre presente** em UPDATE e DELETE
-   [ ] **ON correto** nos JOINs (PK = FK)
-   [ ] **DISTINCT** quando há duplicatas possíveis
-   [ ] **Aliases consistentes** (A, H, D, P)
-   [ ] **Aspas simples** em textos
-   [ ] **AND/OR** corretos em condições múltiplas
-   [ ] **GROUP BY** com funções de agregação

### Erros Fatais

-   ❌ `UPDATE tabela SET campo = valor` (sem WHERE)
-   ❌ `FROM A JOIN B` (sem ON)
-   ❌ `WHERE A.campo = B.campo` (confundir JOIN com WHERE)
-   ❌ `"texto"` (aspas duplas em string)
-   ❌ `GROUP BY` sem função de agregação

### Dicas de Ouro

-   ✅ **Leia 2x** antes de começar
-   ✅ **Identifique as tabelas** necessárias
-   ✅ **Escreva os JOINs** primeiro
-   ✅ **Adicione os filtros** depois
-   ✅ **Use nomes específicos** da atividade
-   ✅ **Teste mentalmente** o resultado

---

**🍀 BOA SORTE NA PROVA!**
