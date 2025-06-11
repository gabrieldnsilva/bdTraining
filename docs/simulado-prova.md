# 📝 Simulado de Prova - Banco de Dados

> **Questões no estilo de prova para treinar antes do dia 14/06/2025**

## 📋 Instruções

-   **Tempo sugerido:** 2 horas
-   **Consulte apenas:** Cola da prova (cola-prova.md)
-   **Banco de dados:** Use o esquema da atividade (FATEC_MogiMirim)
-   **Dicas:** Leia toda a questão antes de começar a escrever

---

## 🎯 QUESTÕES DISSERTATIVAS

### Questão 1 (1,0 ponto)

**Conceitos Fundamentais**

a) Explique a diferença entre chave primária e chave estrangeira. (0,5 ponto)

b) O que significa IDENTITY(1,1) na criação de uma tabela? (0,5 ponto)

<details>
<summary>💡 Gabarito</summary>

**a)**

-   **Chave Primária (PK):** Identifica unicamente cada registro na tabela. Não pode ser NULL nem ter valores duplicados. Cada tabela pode ter apenas uma chave primária.
-   **Chave Estrangeira (FK):** Campo que estabelece relacionamento com outra tabela, referenciando a chave primária da tabela pai. Garante integridade referencial.

**b)**
IDENTITY(1,1) define um campo de auto incremento que:

-   Primeiro número (1): valor inicial da sequência
-   Segundo número (1): incremento a cada novo registro
-   O valor é gerado automaticamente pelo SGBD
</details>

### Questão 2 (1,5 pontos)

**DDL - Data Definition Language**

Considerando a necessidade de expandir o banco da FATEC, crie:

a) Uma tabela CURSOS com campos: codigo (PK, identity), nome, duracao_semestres, coordenador. (0,5 ponto)

b) Altere a tabela ALUNOS para incluir o campo id_curso (FK para CURSOS). (0,5 ponto)

c) Comando para remover a tabela CURSOS (sem executar). (0,5 ponto)

<details>
<summary>💡 Gabarito</summary>

```sql
-- a) Criar tabela CURSOS
CREATE TABLE CURSOS (
    codigo INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao_semestres INT,
    coordenador VARCHAR(100)
);

-- b) Alterar tabela ALUNOS
ALTER TABLE ALUNOS ADD id_curso INT;
ALTER TABLE ALUNOS ADD CONSTRAINT FK_alunos_curso
FOREIGN KEY (id_curso) REFERENCES CURSOS(codigo);

-- c) Remover tabela
DROP TABLE CURSOS;
```

</details>

---

## 🔍 QUESTÕES PRÁTICAS DE CONSULTA

### Questão 3 (2,0 pontos)

**Consultas Básicas com JOIN**

Com base no banco FATEC_MogiMirim, escreva consultas SQL para:

a) Listar o nome de todos os alunos que moram em "Mogi Mirim" e suas respectivas notas. (0,7 ponto)

b) Encontrar o nome dos professores que lecionaram "Sistemas Operacionais" em qualquer período. (0,7 ponto)

c) Mostrar disciplinas com carga horária superior a 70 horas e quantos alunos já as cursaram. (0,6 ponto)

<details>
<summary>💡 Gabarito</summary>

```sql
-- a) Alunos de Mogi Mirim e suas notas
SELECT A.NOME, H.nota
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
WHERE A.CIDADE = 'Mogi Mirim';

-- b) Professores que lecionaram SO
SELECT DISTINCT P.nome
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Sistemas Operacionais';

-- c) Disciplinas > 70h e quantidade de alunos
SELECT D.disciplina, D.cargahoraria, COUNT(DISTINCT H.ra) AS total_alunos
FROM DISCIPLINA D
JOIN HISTORICO H ON D.codigodisciplina = H.codigodisciplina
WHERE D.cargahoraria > 70
GROUP BY D.disciplina, D.cargahoraria;
```

</details>

### Questão 4 (2,5 pontos)

**Consultas Avançadas**

a) Liste os alunos que foram reprovados (nota < 5) em pelo menos uma disciplina, mostrando nome do aluno, disciplina e nota. (1,0 ponto)

b) Encontre o professor que teve a maior média de notas em suas disciplinas, considerando apenas o ano de 2020. (0,8 ponto)

c) Mostre as disciplinas que tiveram alunos reprovados no 1º semestre de 2020, ordenadas por quantidade de reprovados (decrescente). (0,7 ponto)

<details>
<summary>💡 Gabarito</summary>

```sql
-- a) Alunos reprovados
SELECT A.NOME, D.disciplina, H.nota
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE H.nota < 5;

-- b) Professor com maior média em 2020
SELECT TOP 1 P.nome, AVG(H.nota) AS media_notas
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
WHERE H.ano = 2020
GROUP BY P.nome
ORDER BY media_notas DESC;

-- c) Disciplinas com reprovados no 1º sem/2020
SELECT D.disciplina, COUNT(*) AS total_reprovados
FROM DISCIPLINA D
JOIN HISTORICO H ON D.codigodisciplina = H.codigodisciplina
WHERE H.nota < 5 AND H.semestre = 1 AND H.ano = 2020
GROUP BY D.disciplina
ORDER BY total_reprovados DESC;
```

</details>

### Questão 5 (2,0 pontos)

**DML - Manipulação de Dados**

a) Insira um novo professor: "Roberto Silva", cidade "Campinas". (0,5 ponto)

b) Atualize todas as notas menores que 4.0 para 4.0 (nota mínima da instituição). (0,5 ponto)

c) Delete todos os históricos de disciplinas com carga horária menor que 50 horas. (0,5 ponto)

d) Explique por que a operação do item (c) pode falhar e como resolver. (0,5 ponto)

<details>
<summary>💡 Gabarito</summary>

```sql
-- a) Inserir professor
INSERT INTO PROFESSOR (nome, cidade) VALUES ('Roberto Silva', 'Campinas');

-- b) Atualizar notas mínimas
UPDATE HISTORICO SET nota = 4.0 WHERE nota < 4.0;

-- c) Deletar históricos
DELETE FROM HISTORICO
WHERE codigodisciplina IN (
    SELECT codigodisciplina FROM DISCIPLINA WHERE cargahoraria < 50
);

-- d) A operação pode falhar se houver restrições de integridade referencial
-- ou se outros registros dependem desses históricos. Para resolver:
-- 1. Verificar dependências
-- 2. Deletar registros dependentes primeiro
-- 3. Ou usar CASCADE nas FKs
```

</details>

---

## 🧮 QUESTÕES DE ANÁLISE

### Questão 6 (1,0 ponto)

**Análise de Código**

Analise a consulta abaixo e identifique os erros:

```sql
SELECT A.NOME, D.disciplina, P.nome
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.codigodisciplina
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor
WHERE A.CIDADE = "Mogi Mirim"
AND H.nota > 5
GROUP BY A.NOME;
```

<details>
<summary>💡 Gabarito</summary>

**Erros identificados:**

1. **Linha 3:** `A.RA = H.codigodisciplina` deveria ser `A.RA = H.ra`
2. **Linha 5:** `"Mogi Mirim"` deveria usar aspas simples: `'Mogi Mirim'`
3. **Linha 7:** `GROUP BY A.NOME` está incompleto - deveria incluir todos os campos do SELECT que não são funções de agregação: `GROUP BY A.NOME, D.disciplina, P.nome`

**Consulta corrigida:**

```sql
SELECT A.NOME, D.disciplina, P.nome
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor
WHERE A.CIDADE = 'Mogi Mirim'
AND H.nota > 5;
```

</details>

---

## 🎯 QUESTÃO INTEGRADORA

### Questão 7 (2,0 pontos)

**Cenário Completo**

A FATEC precisa de um relatório para a coordenação com as seguintes informações:

_"Listar todos os alunos de Mogi Mirim que cursaram disciplinas com o professor Sandro, mostrando: nome do aluno, disciplina cursada, semestre, ano, nota obtida e status (Aprovado se nota >= 5, Reprovado se nota < 5). Ordenar por nome do aluno e depois por ano/semestre."_

Escreva a consulta SQL completa.

<details>
<summary>💡 Gabarito</summary>

```sql
SELECT
    A.NOME AS 'Nome do Aluno',
    D.disciplina AS 'Disciplina',
    H.semestre AS 'Semestre',
    H.ano AS 'Ano',
    H.nota AS 'Nota',
    CASE
        WHEN H.nota >= 5 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS 'Status'
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor
WHERE A.CIDADE = 'Mogi Mirim'
AND P.nome LIKE 'Sandro%'
ORDER BY A.NOME, H.ano, H.semestre;
```

</details>

---

## ⏱️ CRONÔMETRO DE ESTUDO

### Como usar este simulado:

1. **📖 Leia todas as questões** (5 min)
2. **🎯 Resolva em ordem** (100 min)
3. **✅ Confira com gabarito** (10 min)
4. **📝 Anote dúvidas** (5 min)

### Distribuição de tempo sugerida:

-   **Questões 1-2 (Teoria/DDL):** 25 min
-   **Questões 3-5 (Consultas/DML):** 65 min
-   **Questões 6-7 (Análise/Integração):** 30 min

### Critérios de avaliação:

-   **9,0-10,0:** Excelente - Pronto para a prova! 🏆
-   **7,0-8,9:** Bom - Revise pontos específicos 📚
-   **5,0-6,9:** Regular - Pratique mais exercícios ⚡
-   **< 5,0:** Precisa estudar mais - Revise conceitos básicos 📖

---

**🎯 BOA SORTE NO SIMULADO!**

_Lembre-se: Este simulado é para treino. O importante é identificar suas dificuldades e focar o estudo nelas._
