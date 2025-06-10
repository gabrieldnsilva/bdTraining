# 📊 Diagrama de Relacionamento - Modelo ER

## Estrutura Visual do Banco de Dados

```
                                FATEC_MogiMirim
                                      |
          ┌──────────────────────────────────────────────────────────┐
          │                                                          │
          │                    BANCO DE DADOS                        │
          │                                                          │
          └──────────────────────────────────────────────────────────┘
                                      |
      ┌───────────────┬───────────────┼───────────────┬───────────────┐
      │               │               │               │               │
      ▼               ▼               ▼               ▼               ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│   ALUNOS    │ │  PROFESSOR  │ │ DISCIPLINA  │ │  HISTORICO  │ │    DADOS    │
│             │ │             │ │             │ │             │ │             │
│ RA (PK)     │ │codigoprofes │ │codigodicip  │ │codigohisto  │ │ 10 Alunos   │
│ NOME        │ │sor (PK)     │ │lina (PK)    │ │rico (PK)    │ │ 3 Professores│
│ CIDADE      │ │ nome        │ │ disciplina  │ │ ra (FK)     │ │ 4 Disciplinas│
│             │ │ cidade      │ │ cargahoraria│ │ codigodicip │ │ 15 Históricos│
│             │ │             │ │             │ │lina (FK)    │ │             │
│             │ │             │ │             │ │ codigoprofes│ │             │
│             │ │             │ │             │ │sor (FK)     │ │             │
│             │ │             │ │             │ │ semestre    │ │             │
│             │ │             │ │             │ │ faltas      │ │             │
│             │ │             │ │             │ │ nota        │ │             │
│             │ │             │ │             │ │ ano         │ │             │
└─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘
      │               │               │               │
      │               │               │               │
      │         ┌─────┴─────┐   ┌─────┴─────┐   ┌─────┴─────┐
      │         │           │   │           │   │           │
      │         ▼           ▼   ▼           ▼   ▼           ▼
      │   ┌─────────────────────────────────────────────────────┐
      │   │                 HISTORICO                           │
      │   │            (Tabela de Relacionamento)               │
      │   │                                                     │
      └───┤ Um aluno pode ter vários históricos         (1:N)  │
          │ Uma disciplina pode ter vários históricos   (1:N)  │
          │ Um professor pode ter vários históricos     (1:N)  │
          │ Um histórico pertence a um aluno            (N:1)  │
          │ Um histórico pertence a uma disciplina      (N:1)  │
          │ Um histórico pertence a um professor        (N:1)  │
          └─────────────────────────────────────────────────────┘
```

## Relacionamentos Detalhados

### 🔗 Tipo de Relacionamento: N:N:N

A tabela HISTORICO resolve um relacionamento ternário (três entidades):

-   **ALUNOS** ↔ **DISCIPLINAS** ↔ **PROFESSORES**

### 📋 Cardinalidades

| Relacionamento         | Cardinalidade | Descrição                                         |
| ---------------------- | ------------- | ------------------------------------------------- |
| ALUNOS → HISTORICO     | 1:N           | Um aluno pode ter vários históricos               |
| DISCIPLINA → HISTORICO | 1:N           | Uma disciplina pode aparecer em vários históricos |
| PROFESSOR → HISTORICO  | 1:N           | Um professor pode ter vários históricos           |
| HISTORICO → ALUNOS     | N:1           | Cada histórico pertence a um aluno                |
| HISTORICO → DISCIPLINA | N:1           | Cada histórico pertence a uma disciplina          |
| HISTORICO → PROFESSOR  | N:1           | Cada histórico pertence a um professor            |

## Integridade Referencial

### 🔑 Chaves Primárias (PK)

```sql
ALUNOS.RA                    -- Auto incremento, inicia em 1
PROFESSOR.codigoprofessor    -- Auto incremento, inicia em 1
DISCIPLINA.codigodisciplina  -- Auto incremento, inicia em 1
HISTORICO.codigohistorico    -- Auto incremento, inicia em 1
```

### 🔗 Chaves Estrangeiras (FK)

```sql
HISTORICO.ra → ALUNOS.RA
HISTORICO.codigodisciplina → DISCIPLINA.codigodisciplina
HISTORICO.codigoprofessor → PROFESSOR.codigoprofessor
```

### ⚠️ Regras de Integridade

1. **Não é possível** inserir um histórico sem um aluno válido
2. **Não é possível** inserir um histórico sem uma disciplina válida
3. **Não é possível** inserir um histórico sem um professor válido
4. **Não é possível** deletar um aluno que possui históricos
5. **Não é possível** deletar uma disciplina que possui históricos
6. **Não é possível** deletar um professor que possui históricos

## Exemplo de Dados Relacionados

### 📊 Caso Prático: Alex cursa Banco de Dados com Sandro

```
ALUNO: Alex (RA=1, Cidade='Mogi Mirim')
   ↓
HISTÓRICO: (código=1, ra=1, disciplina=1, professor=1, nota=8.5, semestre=1, ano=2020)
   ↓                    ↓                    ↓
DISCIPLINA:          PROFESSOR:          RELACIONAMENTO:
Banco de Dados       Sandro Roberto      Alex teve nota 8.5 em BD
(código=1,           Armelin             com o professor Sandro
80h de carga)        (código=1,          no 1º semestre de 2020
                     Itapira)
```

## Consultas Típicas por Relacionamento

### 🔍 Consultas com 2 Tabelas

```sql
-- Alunos e seus históricos
SELECT A.NOME, H.nota
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra;

-- Professores e suas disciplinas ministradas
SELECT P.nome, D.disciplina
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina;
```

### 🔍 Consultas com 3 Tabelas

```sql
-- Alunos, suas notas e disciplinas
SELECT A.NOME, D.disciplina, H.nota
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina;
```

### 🔍 Consultas com 4 Tabelas (Completa)

```sql
-- Visão completa: Aluno, Disciplina, Professor, Nota
SELECT A.NOME, D.disciplina, P.nome, H.nota, H.semestre, H.ano
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor;
```

## Cenários de Negócio

### 📈 Relatórios Possíveis

1. **Histórico de um aluno** (todas as disciplinas cursadas)
2. **Disciplinas de um professor** (o que cada professor leciona)
3. **Alunos de uma disciplina** (quem cursou cada matéria)
4. **Performance por semestre** (notas em períodos específicos)
5. **Professores por cidade** (distribuição geográfica)
6. **Disciplinas por carga horária** (classificação por duração)

### 🎯 Queries de Análise

```sql
-- Média de notas por disciplina
SELECT D.disciplina, AVG(H.nota) as Media
FROM DISCIPLINA D
JOIN HISTORICO H ON D.codigodisciplina = H.codigodisciplina
GROUP BY D.disciplina;

-- Professores mais rigorosos (menor média de notas)
SELECT P.nome, AVG(H.nota) as Media
FROM PROFESSOR P
JOIN HISTORICO H ON P.codigoprofessor = H.codigoprofessor
GROUP BY P.nome
ORDER BY Media ASC;

-- Alunos com mais faltas
SELECT A.NOME, SUM(H.faltas) as Total_Faltas
FROM ALUNOS A
JOIN HISTORICO H ON A.RA = H.ra
GROUP BY A.NOME
ORDER BY Total_Faltas DESC;
```

---

**💡 Dica para a Prova:** Memorize os relacionamentos! HISTORICO é sempre o centro das consultas complexas, conectando as outras três tabelas.
