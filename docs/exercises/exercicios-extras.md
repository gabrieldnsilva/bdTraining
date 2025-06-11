# 📚 Exercícios Extras para Prática

> **Exercícios adicionais para fortalecer o aprendizado antes da prova**

## 🎯 Nível Básico

### Exercício 1: Criação de Estrutura

Crie um banco de dados para uma **Biblioteca** com as seguintes especificações:

**Tabelas:**

-   `AUTORES` (id, nome, nacionalidade)
-   `LIVROS` (id, titulo, ano_publicacao, id_autor)
-   `USUARIOS` (id, nome, email, data_cadastro)
-   `EMPRESTIMOS` (id, id_livro, id_usuario, data_emprestimo, data_devolucao)

**Requisitos:**

-   Todas as chaves primárias devem ser auto incremento
-   Definir relacionamentos apropriados
-   Campo email deve ser único

<details>
<summary>💡 Solução</summary>

```sql
CREATE DATABASE Biblioteca;
USE Biblioteca;

CREATE TABLE AUTORES (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

CREATE TABLE LIVROS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    ano_publicacao INT,
    id_autor INT,
    FOREIGN KEY (id_autor) REFERENCES AUTORES(id)
);

CREATE TABLE USUARIOS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE
);

CREATE TABLE EMPRESTIMOS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_livro INT,
    id_usuario INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_livro) REFERENCES LIVROS(id),
    FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id)
);
```

</details>

### Exercício 2: Inserção de Dados

Com base no banco Biblioteca criado acima, insira:

-   3 autores brasileiros e 2 estrangeiros
-   5 livros (distribuídos entre os autores)
-   4 usuários
-   6 empréstimos (alguns já devolvidos, outros não)

<details>
<summary>💡 Solução</summary>

```sql
-- Inserindo autores
INSERT INTO AUTORES (nome, nacionalidade) VALUES
('Machado de Assis', 'Brasileira'),
('Clarice Lispector', 'Brasileira'),
('Paulo Coelho', 'Brasileira'),
('Gabriel García Márquez', 'Colombiana'),
('George Orwell', 'Inglesa');

-- Inserindo livros
INSERT INTO LIVROS (titulo, ano_publicacao, id_autor) VALUES
('Dom Casmurro', 1899, 1),
('A Hora da Estrela', 1977, 2),
('O Alquimista', 1988, 3),
('Cem Anos de Solidão', 1967, 4),
('1984', 1949, 5);

-- Inserindo usuários
INSERT INTO USUARIOS (nome, email, data_cadastro) VALUES
('João Silva', 'joao@email.com', '2025-01-15'),
('Maria Santos', 'maria@email.com', '2025-02-10'),
('Pedro Oliveira', 'pedro@email.com', '2025-03-05'),
('Ana Costa', 'ana@email.com', '2025-04-12');

-- Inserindo empréstimos
INSERT INTO EMPRESTIMOS (id_livro, id_usuario, data_emprestimo, data_devolucao) VALUES
(1, 1, '2025-05-01', '2025-05-15'),
(2, 2, '2025-05-10', NULL),
(3, 3, '2025-05-15', '2025-05-29'),
(4, 1, '2025-06-01', NULL),
(5, 4, '2025-06-05', NULL),
(1, 2, '2025-06-08', NULL);
```

</details>

## 🔗 Nível Intermediário

### Exercício 3: Consultas com JOIN

Com base no banco Biblioteca, escreva consultas para:

1. **Listar todos os livros com seus autores**
2. **Encontrar usuários que nunca fizeram empréstimos**
3. **Mostrar empréstimos em aberto (não devolvidos)**
4. **Livros mais emprestados**

<details>
<summary>💡 Soluções</summary>

```sql
-- 1. Livros com autores
SELECT L.titulo, A.nome AS autor, L.ano_publicacao
FROM LIVROS L
JOIN AUTORES A ON L.id_autor = A.id;

-- 2. Usuários sem empréstimos
SELECT U.nome, U.email
FROM USUARIOS U
LEFT JOIN EMPRESTIMOS E ON U.id = E.id_usuario
WHERE E.id_usuario IS NULL;

-- 3. Empréstimos em aberto
SELECT U.nome, L.titulo, E.data_emprestimo
FROM EMPRESTIMOS E
JOIN USUARIOS U ON E.id_usuario = U.id
JOIN LIVROS L ON E.id_livro = L.id
WHERE E.data_devolucao IS NULL;

-- 4. Livros mais emprestados
SELECT L.titulo, COUNT(*) AS total_emprestimos
FROM LIVROS L
JOIN EMPRESTIMOS E ON L.id = E.id_livro
GROUP BY L.titulo
ORDER BY total_emprestimos DESC;
```

</details>

### Exercício 4: Análise de Dados

Escreva consultas para:

1. **Autores brasileiros com mais de 1 livro**
2. **Usuários que pegaram livros em maio de 2025**
3. **Livros que nunca foram emprestados**
4. **Média de dias de empréstimo dos livros devolvidos**

<details>
<summary>💡 Soluções</summary>

```sql
-- 1. Autores brasileiros com mais de 1 livro
SELECT A.nome, COUNT(*) AS total_livros
FROM AUTORES A
JOIN LIVROS L ON A.id = L.id_autor
WHERE A.nacionalidade = 'Brasileira'
GROUP BY A.nome
HAVING COUNT(*) > 1;

-- 2. Usuários que pegaram livros em maio/2025
SELECT DISTINCT U.nome
FROM USUARIOS U
JOIN EMPRESTIMOS E ON U.id = E.id_usuario
WHERE E.data_emprestimo >= '2025-05-01'
AND E.data_emprestimo < '2025-06-01';

-- 3. Livros nunca emprestados
SELECT L.titulo, A.nome AS autor
FROM LIVROS L
JOIN AUTORES A ON L.id_autor = A.id
LEFT JOIN EMPRESTIMOS E ON L.id = E.id_livro
WHERE E.id_livro IS NULL;

-- 4. Média de dias de empréstimo
SELECT AVG(DATEDIFF(day, data_emprestimo, data_devolucao)) AS media_dias
FROM EMPRESTIMOS
WHERE data_devolucao IS NOT NULL;
```

</details>

## 🚀 Nível Avançado

### Exercício 5: Modificações Estruturais

Execute as seguintes alterações no banco Biblioteca:

1. **Adicionar campo `genero` na tabela LIVROS**
2. **Adicionar campo `telefone` na tabela USUARIOS**
3. **Criar tabela CATEGORIAS e relacionar com LIVROS**
4. **Atualizar alguns registros com os novos campos**

<details>
<summary>💡 Solução</summary>

```sql
-- 1. Adicionar campo gênero
ALTER TABLE LIVROS ADD genero VARCHAR(50);

-- 2. Adicionar telefone
ALTER TABLE USUARIOS ADD telefone VARCHAR(15);

-- 3. Criar tabela CATEGORIAS
CREATE TABLE CATEGORIAS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(200)
);

-- Adicionar FK na tabela LIVROS
ALTER TABLE LIVROS ADD id_categoria INT;
ALTER TABLE LIVROS ADD CONSTRAINT FK_livros_categoria
FOREIGN KEY (id_categoria) REFERENCES CATEGORIAS(id);

-- 4. Inserir categorias
INSERT INTO CATEGORIAS (nome, descricao) VALUES
('Ficção', 'Obras de ficção literária'),
('Romance', 'Obras românticas'),
('Realismo Mágico', 'Ficção com elementos fantásticos'),
('Distopia', 'Sociedades imaginárias indesejáveis');

-- Atualizar livros com gênero e categoria
UPDATE LIVROS SET genero = 'Romance', id_categoria = 2 WHERE id = 1;
UPDATE LIVROS SET genero = 'Ficção', id_categoria = 1 WHERE id = 2;
UPDATE LIVROS SET genero = 'Ficção', id_categoria = 1 WHERE id = 3;
UPDATE LIVROS SET genero = 'Realismo Mágico', id_categoria = 3 WHERE id = 4;
UPDATE LIVROS SET genero = 'Distopia', id_categoria = 4 WHERE id = 5;
```

</details>

## 🎯 Desafios para a Prova

### Desafio 1: Relatório Completo

Crie uma consulta que mostre:

-   Nome do usuário
-   Título do livro emprestado
-   Nome do autor
-   Data do empréstimo
-   Status (Devolvido/Em aberto)
-   Dias de posse (para devolvidos) ou dias em atraso (para em aberto, considerando 15 dias como prazo)

### Desafio 2: Análise Estatística

Crie consultas para:

-   Top 3 autores mais emprestados
-   Usuário mais assíduo (mais empréstimos)
-   Mês com mais empréstimos em 2025
-   Percentual de livros devolvidos no prazo

### Desafio 3: Manutenção de Dados

Crie um script que:

-   Remove empréstimos com mais de 1 ano
-   Atualiza email de usuários com domínio antigo
-   Adiciona um campo `ativo` para usuários e marca inativos os sem empréstimos há mais de 6 meses

---

## 🧠 Dicas de Resolução

### Para JOINs Complexos:

1. **Identifique o objetivo** da consulta
2. **Liste as tabelas** necessárias
3. **Desenhe o relacionamento** mentalmente
4. **Construa passo a passo** (uma JOIN por vez)

### Para Funções de Agregação:

1. **Identifique o que contar/somar/calcular**
2. **Determine o agrupamento** (GROUP BY)
3. **Adicione filtros** de grupo (HAVING) se necessário

### Para Modificações:

1. **Sempre faça backup** antes de ALTER/UPDATE/DELETE
2. **Teste com WHERE** pequeno primeiro
3. **Verifique integridade** referencial

---

**💡 Lembre-se:** A prática é essencial! Tente resolver sem olhar as soluções primeiro.
