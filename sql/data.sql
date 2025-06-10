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