# 🔍 Consultas Avançadas - SELECT com JOINs

> **Consultas avançadas** envolvem múltiplas tabelas, funções de agregação e subconsultas

## 📋 Índice

-   [JOINs](#joins)
-   [Funções de Agregação](#funções-de-agregação)
-   [GROUP BY e HAVING](#group-by-e-having)
-   [Subconsultas](#subconsultas)
-   [Exercícios da Atividade](#exercícios-da-atividade)

## JOINs

### O que são JOINs?

JOINs são usados para combinar dados de duas ou mais tabelas com base em relacionamentos entre elas.

### Tipos de JOIN

#### INNER JOIN (ou apenas JOIN)

**Retorna apenas registros que têm correspondência em ambas as tabelas**

```sql
-- Sintaxe
SELECT campos
FROM tabela1
JOIN tabela2 ON tabela1.chave = tabela2.chave_estrangeira;

-- Exemplo: Alunos e seus históricos
SELECT A.NOME, H.nota
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra;
```

#### LEFT JOIN

**Retorna todos os registros da tabela esquerda, mesmo sem correspondência**

```sql
-- Exemplo: Todos os alunos, com ou sem histórico
SELECT A.NOME, H.nota
FROM ALUNOS A
LEFT JOIN HISTORICO H ON A.RA = H.ra;
```

#### RIGHT JOIN

**Retorna todos os registros da tabela direita, mesmo sem correspondência**

```sql
-- Exemplo: Todos os históricos e alunos (se existirem)
SELECT A.NOME, H.nota
FROM ALUNOS A
RIGHT JOIN HISTORICO H ON A.RA = H.ra;
```

### JOINs Múltiplos (3+ tabelas)

```sql
-- Estrutura para 3 tabelas
SELECT campos
FROM tabela1 A
JOIN tabela2 B ON A.chave = B.chave_estrangeira
JOIN tabela3 C ON B.chave = C.chave_estrangeira
WHERE condições;

-- Exemplo da atividade: Aluno, Histórico, Disciplina
SELECT A.NOME, D.disciplina, H.nota
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina;
```

### 💡 Dicas para JOINs

-   **Use aliases** para deixar o código mais limpo: `ALUNOS AS A`
-   **Sempre defina a condição** do ON corretamente
-   **Ordem das tabelas** no FROM/JOIN não afeta o resultado
-   **Use DISTINCT** se necessário para eliminar duplicatas

---

## Funções de Agregação

### Principais Funções

| Função                  | Descrição                | Exemplo                                     |
| ----------------------- | ------------------------ | ------------------------------------------- |
| `COUNT(*)`              | Conta todos os registros | `SELECT COUNT(*) FROM ALUNOS`               |
| `COUNT(DISTINCT campo)` | Conta valores únicos     | `SELECT COUNT(DISTINCT cidade) FROM ALUNOS` |
| `SUM(campo)`            | Soma valores numéricos   | `SELECT SUM(nota) FROM HISTORICO`           |
| `AVG(campo)`            | Calcula média            | `SELECT AVG(nota) FROM HISTORICO`           |
| `MAX(campo)`            | Valor máximo             | `SELECT MAX(nota) FROM HISTORICO`           |
| `MIN(campo)`            | Valor mínimo             | `SELECT MIN(nota) FROM HISTORICO`           |

### Exemplos Práticos

```sql
-- Quantos alunos temos?
SELECT COUNT(*) AS 'Total de Alunos' FROM ALUNOS;

-- Média das notas gerais
SELECT AVG(nota) AS 'Média Geral' FROM HISTORICO;

-- Maior e menor nota
SELECT MAX(nota) AS 'Maior Nota', MIN(nota) AS 'Menor Nota' FROM HISTORICO;

-- Quantas cidades diferentes temos?
SELECT COUNT(DISTINCT cidade) AS 'Cidades Diferentes' FROM ALUNOS;
```

---

## GROUP BY e HAVING

### GROUP BY

**Agrupa registros com valores iguais em colunas específicas**

```sql
-- Sintaxe básica
SELECT campo_agrupamento, função_agregação
FROM tabela
GROUP BY campo_agrupamento;

-- Exemplo: Quantidade de alunos por cidade
SELECT CIDADE, COUNT(*) AS 'Quantidade'
FROM ALUNOS
GROUP BY CIDADE;
```

### HAVING

**Filtra grupos criados pelo GROUP BY** (WHERE filtra registros, HAVING filtra grupos)

```sql
-- Sintaxe
SELECT campo_agrupamento, função_agregação
FROM tabela
GROUP BY campo_agrupamento
HAVING condição_sobre_grupo;

-- Exemplo: Cidades com mais de 2 alunos
SELECT CIDADE, COUNT(*) AS 'Quantidade'
FROM ALUNOS
GROUP BY CIDADE
HAVING COUNT(*) > 2;
```

### Exemplo da Atividade (Questão 7)

```sql
-- Quantidade de disciplinas que cada professor ministrou em 2020
SELECT
    P.nome AS 'Professor',
    COUNT(DISTINCT D.codigodisciplina) AS 'Quantidade de Disciplinas'
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE H.ano = 2020
GROUP BY P.nome;
```

---

## Subconsultas

### O que são?

**Consultas dentro de outras consultas**, usadas para filtros complexos ou cálculos baseados em outras tabelas.

### Tipos de Subconsultas

#### Subconsulta no WHERE

```sql
-- Encontrar alunos que têm histórico
SELECT NOME FROM ALUNOS
WHERE RA IN (SELECT DISTINCT ra FROM HISTORICO);

-- Professores que lecionaram em 2020
SELECT nome FROM PROFESSOR
WHERE codigoprofessor IN (
    SELECT DISTINCT codigoprofessor
    FROM HISTORICO
    WHERE ano = 2020
);
```

#### Subconsulta com EXISTS

```sql
-- Alunos que têm pelo menos um histórico
SELECT A.NOME
FROM ALUNOS A
WHERE EXISTS (
    SELECT 1 FROM HISTORICO H
    WHERE H.ra = A.RA
);
```

---

## 📝 Exercícios da Atividade

### Questão 3: Filtro com JOIN

```sql
-- Alunos com nota < 5 em BD no 2º semestre
SELECT A.NOME, A.RA
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Banco de Dados'
AND H.semestre = 2
AND H.nota < 5;
```

**Conceitos aplicados:**

-   JOIN triplo (3 tabelas)
-   Filtros múltiplos no WHERE
-   Comparação numérica e textual

### Questão 6: JOIN com filtro de ano

```sql
-- Professores de BD que ministraram em 2020
SELECT DISTINCT P.nome
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE D.disciplina = 'Banco de Dados'
AND H.ano = 2020;
```

**Conceitos aplicados:**

-   DISTINCT para eliminar duplicatas
-   JOIN triplo
-   Filtros com AND

### Questão 8: Múltiplas condições

```sql
-- Alunos com nota < 5 no 1º semestre de 2020
SELECT A.NOME, A.CIDADE, H.codigodisciplina, D.disciplina
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
WHERE H.nota < 5
AND H.semestre = 1
AND H.ano = 2020;
```

**Conceitos aplicados:**

-   Múltiplos campos no SELECT
-   Três condições no WHERE
-   JOIN entre três tabelas

### Questão 9: JOIN quádruplo

```sql
-- Alunos em Estrutura de Dados com prof. Marcos em 2019
SELECT A.NOME, A.RA
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor
WHERE D.disciplina = 'Estrutura de Dados'
AND P.nome = 'Marcos'
AND H.ano = 2019;
```

**Conceitos aplicados:**

-   JOIN quádruplo (4 tabelas)
-   Filtros em diferentes tabelas
-   Coordenação de múltiplas condições

---

## 🎯 Dicas para a Prova

### ✅ Estratégia para Consultas Complexas

1. **Identifique as tabelas necessárias**

    - Que dados preciso mostrar?
    - De quais tabelas eles vêm?

2. **Determine os relacionamentos**

    - Como as tabelas se conectam?
    - Quais são as chaves primárias e estrangeiras?

3. **Escreva os JOINs**

    - Comece com a tabela principal
    - Adicione uma JOIN por vez
    - Verifique as condições ON

4. **Adicione os filtros WHERE**

    - Uma condição por vez
    - Use AND para múltiplas condições

5. **Teste mentalmente**
    - A consulta faz sentido?
    - Está retornando o que foi pedido?

### 📝 Template Mental

```sql
SELECT DISTINCT  -- Use se necessário eliminar duplicatas
    A.campo1,    -- Campos da tabela principal
    B.campo2,    -- Campos de tabelas relacionadas
    C.campo3
FROM
    TABELA_PRINCIPAL AS A
JOIN
    TABELA_RELACIONADA1 AS B ON A.chave = B.chave_estrangeira
JOIN
    TABELA_RELACIONADA2 AS C ON B.chave = C.chave_estrangeira
WHERE
    A.condicao1 = 'valor'     -- Filtros específicos
    AND B.condicao2 > 0       -- Múltiplas condições
    AND C.condicao3 LIKE '%texto%'
ORDER BY
    A.campo1;                 -- Ordenação se necessário
```

### ⚠️ Erros Comuns em JOINs

-   **Esquecer a condição ON** (produto cartesiano)
-   **Usar WHERE em vez de ON** para relacionamento
-   **Não usar DISTINCT** quando há duplicatas
-   **Misturar aliases** (usar A.campo mas declarar AS B)
-   **Relacionamento errado** (chave primária com campo comum)

### 🧠 Memorização de Padrões

**Para relacionar 3 tabelas (Aluno-Histórico-Disciplina):**

```sql
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
```

**Para relacionar 4 tabelas (+ Professor):**

```sql
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor
```

---

**💡 Lembre-se**: Consultas complexas são construídas passo a passo. Comece simples e vá adicionando complexidade!
