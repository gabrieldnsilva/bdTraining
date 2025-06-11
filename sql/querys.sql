-- ========================================
-- 				SCHEMA SQL 
-- ========================================

CREATE DATABASE FATEC_MogiMirim;

CREATE TABLE ALUNOS (
	RA SERIAL PRIMARY KEY,
	NOME VARCHAR(100) NOT NULL, 
	CIDADE VARCHAR(40) 
);

CREATE TABLE PROFESSOR (
	codigoprofessor SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	cidade VARCHAR(40)
);

CREATE TABLE DISCIPLINA (
	codigodisciplina SERIAL PRIMARY KEY,
	disciplina VARCHAR(100) NOT NULL,
	cargahoraria FLOAT
);

CREATE TABLE HISTORICO(
	codigohistorico SERIAL PRIMARY KEY,
	semestre INT,
	faltas INT,
	nota FLOAT,

	-- Chaves Estrangeiras
	ra INT, -- FK para ALUNOS
	codigodisciplina INT, -- FK para DISCIPLINA
	codigoprofessor INT, -- FK para PROFESSOR

	-- Definição das chaves estrangeiras com integridade referencial
	FOREIGN KEY (ra) REFERENCES ALUNOS(RA),
	FOREIGN KEY (codigodisciplina) REFERENCES DISCIPLINA(codigodisciplina),
	FOREIGN KEY (codigoprofessor) REFERENCES PROFESSOR(codigoprofessor)
);

-- ========================================
-- 		SCRIPT DE INSERÇÃO DE DADOS
-- ========================================

-- INSERÇÃO DE PROFESSORES (3 registros)

INSERT INTO PROFESSOR (nome, cidade) VALUES
('Sandro Roberto Armelin', 'Itapira'),
('Marcos', 'Mogi Guaçu'),
('Ana Célia', 'Mogi Mirim');

-- Verificação dos professores inseridos
SELECT * FROM PROFESSOR;

-- INSERÇÃO DE DISCIPLINAS (4 registros)

INSERT INTO DISCIPLINA (disciplina, cargahoraria) VALUES
('Banco de Dados', 80),
('Sistemas Operacionais', 80),
('Redes de Computadores', 80),
('Estruturas de Dados', 80);

-- Verificação das disciplinas inseridas
SELECT * FROM DISCIPLINA;

-- INSERSÃO DE ALUNOS (10 registros)

INSERT INTO ALUNOS (NOME, CIDADE) VALUES
('Gabriel Danilo', 'Mogi Mirim'),
('Kaique Carvalho', 'Mogi Mirim'),
('Marcelo Belotto', 'Jaguariúna'),
('Carlos', 'Itapira'),
('Rogério Rodrigues', 'Mogi Guaçu'),
('Fernanda', 'Espírito Santo do Pinhal'),
('Heloisa', 'Conchal'),
('Gabriel Molinari', 'Mogi Guaçu'),
('Vinicius Silva', 'Mogi Mirim'),
('Micael Jarniac', 'Mogi Guaçu');

-- Verificação dos alunos inseridos
SELECT * FROM ALUNOS;

INSERT INTO HISTORICO (ra, codigodisciplina, codigoprofessor, semestre, faltas, nota) VALUES
-- Gabriel Danilo (RA=1) - Múltiplas disciplinas
(1, 1, 1, 1, 4, 8.5),   -- Gabriel Danilo, Banco de Dados, Sandro, 1º sem, 4 faltas, nota 8.5
(1, 4, 2, 3, 6, 9.5),   -- Gabriel Danilo, Estrutura de Dados, Marcos, 3º sem, 6 faltas, nota 9.5
(1, 2, 3, 2, 2, 8.0),   -- Gabriel Danilo, Sistemas Operacionais, Ana, 2º sem, 2 faltas, nota 8.0

-- Kaique Carvalho (RA=2) - Múltiplas disciplinas  
(2, 2, 2, 1, 2, 7.0),   -- Kaique Carvalho, Sistemas Operacionais, Marcos, 1º sem, 2 faltas, nota 7.0
(2, 1, 1, 1, 0, 10.0),  -- Kaique Carvalho, Banco de Dados, Sandro, 1º sem, 0 faltas, nota 10.0

-- Marcelo Belotto (RA=3) - Múltiplas disciplinas
(3, 4, 3, 3, 6, 6.0),   -- Marcelo Belotto, Estrutura de Dados, Ana, 3º sem, 6 faltas, nota 6.0
(3, 3, 2, 1, 4, 4.5),   -- Marcelo Belotto, Redes, Marcos, 1º sem, 4 faltas, nota 4.5 (REPROVADO)

-- Carlos (RA=4)
(4, 3, 2, 2, 0, 9.5),   -- Carlos, Redes, Marcos, 2º sem, 0 faltas, nota 9.5

-- Rogério Rodrigues (RA=5) 
(5, 1, 1, 1, 10, 4.0),  -- Rogério Rodrigues, Banco de Dados, Sandro, 1º sem, 10 faltas, nota 4.0 (REPROVADO)

-- Fernanda (RA=6)
(6, 4, 3, 1, 4, 9.0),   -- Fernanda, Estrutura de Dados, Ana, 1º sem, 4 faltas, nota 9.0

-- Heloisa (RA=7)
(7, 2, 2, 3, 8, 5.5),   -- Heloisa, Sistemas Operacionais, Marcos, 3º sem, 8 faltas, nota 5.5

-- Gabriel Molinari (RA=8)
(8, 1, 1, 1, 2, 8.0),   -- Gabriel Molinari, Banco de Dados, Sandro, 1º sem, 2 faltas, nota 8.0

-- Vinicius Silva (RA=9)
(9, 4, 2, 1, 14, 7.5),  -- Vinicius Silva, Estrutura de Dados, Marcos, 1º sem, 14 faltas, nota 7.5

-- Micael Jarniac (RA=10) - Casos específicos para exercícios
(10, 1, 1, 2, 8, 4.5),  -- Micael Jarniac, Banco de Dados, Sandro, 2º sem, 8 faltas, nota 4.5 (REPROVADO - Questão 3)
(10, 3, 2, 4, 12, 3.0); -- Micael Jarniac, Redes, Marcos, 4º sem, 12 faltas, nota 3.0 (REPROVADO - Questão 13)

-- Verificação dos históricos inseridos
SELECT * FROM HISTORICO;

-- ========================================
-- 		VERIFICAÇÃO DOS RELACIONAMENTOS
-- ========================================

-- Consulta para verificar se os relacionamentos estão corretos:
SELECT
	H.codigohistorico,
	A.NOME AS Aluno,
	D.disciplina AS Disciplina,
	P.nome AS Professor,
	H.semestre,
	H.faltas,
	H.nota
FROM HISTORICO H
JOIN ALUNOS A ON H.ra = A.ra
JOIN DISCIPLINA D ON H.codigodisciplina = D.codigodisciplina
JOIN PROFESSOR P ON H.codigoprofessor = P.codigoprofessor
ORDER BY A.NOME, D.disciplina;

-- ========================================
-- ESTATÍSTICAS DOS DADOS INSERIDOS
-- ========================================

-- Contagem de registros por tabela
SELECT 'ALUNOS' as Tabela, COUNT(*) as Total FROM ALUNOS
UNION ALL
SELECT 'PROFESSOR' as Tabela, COUNT(*) as Total FROM PROFESSOR
UNION ALL  
SELECT 'DISCIPLINA' as Tabela, COUNT(*) as Total FROM DISCIPLINA
UNION ALL
SELECT 'HISTORICO' as Tabela, COUNT(*) as Total FROM HISTORICO;

-- 3. Encontre o nome e RA dos alunos com nota na disciplina de  
-- Banco de Dados no 2º semestre menor que 5.

SELECT
	A.NOME,
	A.RA
FROM
	ALUNOS AS A
INNER JOIN
	HISTORICO AS H ON A.RA = H.ra
INNER JOIN
	DISCIPLINA AS D ON H.codigodisciplina = D.codigodisciplina
WHERE
	D.disciplina = 'Banco de Dados'
	AND H.semestre = 2
	AND H.nota < 5;

-- ================================================================
-- QUESTÃO 4: Adicionar campo ano na tabela histórico
-- ================================================================

ALTER TABLE HISTORICO ADD ano INT;

-- ================================================================
-- QUESTÃO 5: Definir ano para registros existentes
-- ================================================================

-- Definindo registros de 2020
UPDATE HISTORICO
SET ano = 2020
WHERE codigohistorico IN (1, 2, 5, 8, 11, 14, 15);

-- Definindo registros de 2019
UPDATE HISTORICO
SET ano = 2019
WHERE codigohistorico IN (3, 4, 6, 7, 9, 10, 12, 13);

-- ================================================================
-- QUESTÃO 6: Professores de BD que ministraram em 2020
-- ================================================================

SELECT DISTINCT
	P.nome
FROM
	PROFESSOR AS P
INNER JOIN
	HISTORICO AS H ON P.codigoprofessor = H.codigoprofessor
INNER JOIN
	DISCIPLINA AS D ON H.codigodisciplina = D.codigodisciplina
WHERE
	D.disciplina = 'Banco de Dados'
	AND H.ano = 2020;

	-- ================================================================
-- QUESTÃO 7: Quantidade de disciplinas por professor em 2020
-- ================================================================

SELECT
    P.nome AS "Professor",
    COUNT(DISTINCT D.codigodisciplina) AS "Quantidade de Disciplinas"
FROM
    PROFESSOR AS P
INNER JOIN
    HISTORICO AS H ON P.codigoprofessor = H.codigoprofessor
INNER JOIN
    DISCIPLINA AS D ON H.codigodisciplina = D.codigodisciplina
WHERE
    H.ano = 2020
GROUP BY
    P.nome;

-- ================================================================
-- QUESTÃO 8: Alunos com nota < 5 no 1º semestre de 2020
-- ================================================================

SELECT
	A.NOME AS "Nome do Aluno",
	A.CIDADE AS "Cidade do Aluno",
	D.codigodisciplina AS "Codigo da Disciplina",
	D.disciplina AS "Nome da Disciplina"
FROM
	ALUNOS AS A
INNER JOIN 
	HISTORICO AS H ON A.RA = H.ra
INNER JOIN
	DISCIPLINA AS D ON H.codigodisciplina = D.codigodisciplina
WHERE
	H.nota < 5
	AND H.semestre = 2
	AND H.ano = 2020;

-- ================================================================
-- QUESTÃO 9: Alunos em Estrutura de Dados com prof. Marcos em 2019
-- ================================================================

SELECT
    A.NOME,
    A.RA
FROM
    ALUNOS AS A
INNER JOIN
    HISTORICO AS H ON A.RA = H.ra
INNER JOIN
    DISCIPLINA AS D ON H.codigodisciplina = D.codigodisciplina
INNER JOIN
    PROFESSOR AS P ON H.codigoprofessor = P.codigoprofessor
WHERE
    D.disciplina = 'Estruturas de Dados'
    AND P.nome = 'Marcos'
    AND H.ano = 2019;

-- ================================================================
-- QUESTÃO 10: Histórico escolar do aluno Gabriel (contém dados)
-- ================================================================

SELECT
	A.ra,
	A.nome,
	D.disciplina,
	H.faltas,
	H.nota,
	H.ano,
	H.semestre
FROM 
	ALUNOS AS A
INNER JOIN
	HISTORICO AS H ON A.RA = H.ra
INNER JOIN
	DISCIPLINA AS D ON H.codigodisciplina = D.codigodisciplina
WHERE
	A.NOME LIKE 'Gabriel%'
ORDER BY
	H.ano, H.semestre, D.disciplina;

-- ================================================================
-- QUESTÃO 11: Professores que residem em Mogi Mirim
-- ================================================================

SELECT
	nome
FROM
	PROFESSOR
WHERE
	cidade = 'Mogi Mirim';

-- ================================================================
-- QUESTÃO 12: Alunos e disciplinas com carga < 60h e professores
-- ================================================================

SELECT
	A.NOME AS "Nome do Aluno",
	D.disciplina AS "Nome da Disciplina",
	P.nome AS "Nome do Professor"
FROM
	ALUNOS AS A
JOIN
	HISTORICO AS H ON A.RA = H.ra
JOIN
	DISCIPLINA AS D ON H.codigodisciplina = D.codigodisciplina
JOIN
	PROFESSOR AS P ON H.codigoprofessor = P.codigoprofessor
WHERE
	D.cargahoraria < 60;

-- ================================================================
-- QUESTÃO 13: Professores que reprovaram Pedro Paulo Cunha
-- ================================================================

SELECT DISTINCT
	P.nome
FROM
	PROFESSOR AS P
JOIN
	HISTORICO AS H ON P.codigoprofessor = H.codigoprofessor
JOIN
	ALUNOS AS A ON H.ra = A.RA
WHERE
	A.NOME = 'Pedro Paulo Cunha'
	AND H.nota < 5;

-- ================================================================
-- QUESTÃO 14: Alunos que tiveram aulas com prof. Sandro
-- ================================================================

SELECT DISTINCT
	A.RA,
	A.NOME
FROM
	ALUNOS AS A
JOIN 
	HISTORICO AS H ON A.RA = H.ra
JOIN
	PROFESSOR AS P ON H.codigoprofessor = P.codigoprofessor
WHERE
	P.nome LIKE 'Sandro%';
