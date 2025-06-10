-- ========================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS
-- Atividade: Banco de Dados - FATEC
-- Data: 10/06/2025
-- ========================================

-- Primeiro, criamos o banco de dados
CREATE DATABASE FATEC_MogiMirim;

-- Em seguida, selecionamos o banco que acabamos de criar para usá-lo
USE FATEC_MogiMirim;

-- ========================================
-- CRIAÇÃO DAS TABELAS
-- ========================================

-- Tabela de Alunos
-- Armazena informações básicas dos estudantes
CREATE TABLE ALUNOS (
    RA INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Chave primária com autonumeração
    NOME VARCHAR(100) NOT NULL,                 -- Nome completo do aluno
    CIDADE VARCHAR(40)                          -- Cidade de residência
);

-- Tabela de Professores  
-- Armazena informações dos docentes
CREATE TABLE PROFESSOR (
    codigoprofessor INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Chave primária com autonumeração
    nome VARCHAR(100) NOT NULL,                             -- Nome completo do professor
    cidade VARCHAR(40)                                      -- Cidade de residência
);

-- Tabela de Disciplinas
-- Armazena informações sobre as matérias do curso
CREATE TABLE DISCIPLINA (
    codigodisciplina INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Chave primária com autonumeração
    disciplina VARCHAR(100) NOT NULL,                        -- Nome da disciplina
    cargahoraria FLOAT                                       -- Carga horária em horas
);

-- Tabela de Histórico
-- Tabela de relacionamento que armazena o histórico acadêmico
-- Relaciona alunos, disciplinas e professores com notas e frequência
CREATE TABLE HISTORICO (
    codigohistorico INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Chave primária com autonumeração
    semestre INT,                                           -- Semestre cursado (1 ou 2)
    faltas INT,                                             -- Número de faltas
    nota FLOAT,                                             -- Nota obtida (0.0 a 10.0)
    
    -- Chaves Estrangeiras (estabelecem os relacionamentos)
    ra INT,                                                 -- FK para ALUNOS
    codigodisciplina INT,                                   -- FK para DISCIPLINA  
    codigoprofessor INT,                                    -- FK para PROFESSOR
    
    -- Definição das chaves estrangeiras com integridade referencial
    FOREIGN KEY (ra) REFERENCES ALUNOS(RA),
    FOREIGN KEY (codigodisciplina) REFERENCES DISCIPLINA(codigodisciplina),
    FOREIGN KEY (codigoprofessor) REFERENCES PROFESSOR(codigoprofessor)
);

-- ========================================
-- OBSERVAÇÕES IMPORTANTES
-- ========================================

/*
1. IDENTITY(1,1) significa:
   - Primeiro valor: 1 (início da sequência)
   - Segundo valor: 1 (incremento)
   - O campo será preenchido automaticamente pelo SGBD

2. PRIMARY KEY:
   - Garante que cada registro tenha um identificador único
   - Não permite valores NULL ou duplicados
   - Cria automaticamente um índice para melhor performance

3. FOREIGN KEY:
   - Estabelece relacionamento entre tabelas
   - Garante integridade referencial
   - Impede que sejam inseridos valores que não existem na tabela referenciada

4. Relacionamentos:
   - Um aluno pode ter vários históricos (1:N)
   - Uma disciplina pode ter vários históricos (1:N)  
   - Um professor pode ter vários históricos (1:N)
   - Um histórico pertence a um aluno, uma disciplina e um professor (N:1)
*/
