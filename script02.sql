-- dados automáticos na criação do banco de dados
CREATE DATABASE alura
	WITH 
	OWNER = postgres
	ENCODING = 'UTF8'
	LC_COLLATE = 'en_US.utf8'
	LC_CTYPE = 'en_US.utf8'
	TABLESPACE = pg_default
	CONNECTION LIMIT -1; 	-- -1 significa que não há limites de conexões ao banco de dados

CREATE TABLE IF NOT EXISTS academico.aluno ( 			-- cria a tabela no schema academico ao invés de public
	id SERIAL PRIMARY KEY NOT NULL,
	primeiro_nome VARCHAR(255) NOT NULL DEFAULT 'John',
	ultimo_nome VARCHAR(255) NOT NULL DEFAULT 'Doe',
	data_nascimento DATE NOT NULL DEFAULT NOW()::DATE
);

CREATE TABLE IF NOT EXISTS academico.categoria (
	id SERIAL PRIMARY KEY NOT NULL,
	nome VARCHAR(255) NOT NULL UNIQUE CHECK (nome <> '')
);

CREATE TABLE IF NOT EXISTS academico.curso (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	categoria_id INTEGER NOT NULL REFERENCES academico.categoria(id) -- importante! 
);

CREATE TABLE IF NOT EXISTS academico.aluno_curso (
	aluno_id INTEGER NOT NULL REFERENCES academico.aluno(id),
	curso_id INTEGER NOT NULL REFERENCES academico.curso(id),
	PRIMARY KEY (aluno_id, curso_id)
);

-- SCHEMA: organizar (e separar em grupos) de forma lógicas nossas tabelas
CREATE SCHEMA academico;
DROP TABLE academico.aluno, academico.categoria, academico.curso, academico.aluno_curso;