-- numero
integer
real
serial
numeric


-- texto
varchar(n) -- tamanho variável
char(n) -- tamanho fixo
text

-- lógico
boolean

-- data e hora
date -- data
time -- hora
timestamp -- data e hora

DROP TABLE IF EXISTS aluno;

CREATE TABLE aluno (
	id SERIAL,
	nome VARCHAR(255),
	cpf CHAR(11),
	observacao TEXT,
	idade INTEGER,
	dinheiro NUMERIC(10,2),
	altura REAL,
	ativo BOOLEAN,
	data_nascimento DATE,
	hora_aula TIME,
	matricula_em timestamp
);

DROP TABLE aluno;

SELECT * FROM aluno;

INSERT INTO aluno (nome, cpf, observacao, idade, dinheiro, altura, ativo, data_nascimento, hora_aula, matricula_em) VALUES 
('Lucas Coelho', '02922233379', 'gaúcho, natural de Rio Grande/RS', 27, 375.40, 1.69, true, '1994-09-12', '15:03:37', '2022-05-20 12:32:45'),
('Matheus Dias', '02922233379', 'gaúcho, natural de Rio Grande/RS', 36, 1375.40, 1.68, false, '1985-06-02', '15:03:37', '2021-05-20 13:32:45'),
('Rodrigo Avila', '02922233379', 'gaúcho, natural de Pelotas/RS', 41, 2375.40, 1.67, true, '1980-12-23', '15:03:37', '2020-05-20 14:32:45'),
('Luiz Sotero', '02922233379', 'gaúcho, natural de Pedro Osório/RS', 72, 15375.40, 1.65, false, '1949-11-05', '15:03:37', '2020-05-20 14:32:45');

INSERT INTO aluno (nome) VALUES
('Diogo'),
('Diego');

-- seleções
SELECT * FROM aluno WHERE id = 1;

UPDATE aluno 
	SET nome = 'Luiz Sotero',
		observacao = 'gaúcho, natural de Pedro Osório/RS',
		idade = 71,
		dinheiro = 4567.81,
		altura = 1.65
	WHERE id = 1;
	
SELECT * FROM aluno WHERE nome = 'Luiz Sotero';

DELETE FROM aluno WHERE nome = 'Luiz Sotero'; 

SELECT * FROM aluno;
SELECT nome FROM aluno;
SELECT nome, idade, altura, observacao FROM aluno;

SELECT nome AS "nome completo", 
	   idade, 
	   altura AS "altura (em metros)", 
	   observacao AS naturalidade
	FROM aluno;
	
-- seleções com filtros
SELECT * FROM aluno WHERE nome = 'Lucas Coelho';

SELECT * FROM aluno WHERE nome <> 'Lucas Coelho';
SELECT * FROM aluno WHERE nome != 'Lucas Coelho';

-- LIKE : parecido
-- _ : indica qualquer caracter
-- % : indica qualquer coisa até aquele ponto
SELECT * FROM aluno WHERE nome LIKE '_ucas Coelho';
SELECT * FROM aluno WHERE nome LIKE 'Di_go';
SELECT * FROM aluno WHERE nome NOT LIKE 'Di_go';

SELECT * FROM aluno WHERE nome LIKE 'L%';
SELECT * FROM aluno WHERE nome LIKE '%go';
SELECT * FROM aluno WHERE nome LIKE '%s %';
SELECT * FROM aluno WHERE observacao LIKE '%Pelotas%';
SELECT * FROM aluno WHERE observacao LIKE '% R%G%';

SELECT * FROM aluno WHERE cpf IS NULL;
SELECT * FROM aluno WHERE cpf IS NOT NULL;

-- esses filtros funcionam para todos os outros campos!
SELECT nome, observacao FROM aluno WHERE idade = 27;
SELECT nome AS "nome completo", observacao AS informacao FROM aluno WHERE idade >= 30;
SELECT * FROM aluno WHERE idade < 50;
SELECT nome, observacao FROM aluno WHERE idade BETWEEN 18 AND 36; -- BETWEEN É INCLUSIVO

-- filtros com operadores lógicos
SELECT * FROM aluno WHERE nome LIKE 'L%' AND ativo = true;
SELECT * FROM aluno WHERE nome LIKE 'L%' OR ativo = true;
SELECT * FROM aluno WHERE nome LIKE 'L%' OR ativo = true AND altura > 1.6;

-- chave primária
DROP TABLE IF EXISTS curso;
CREATE TABLE curso (
	id INTEGER PRIMARY KEY, -- é o  mesmo que: id INTEGER NOT NULL UNIQUE;
	nome VARCHAR(255) NOT NULL
);

INSERT INTO curso (id, nome) VALUES 
(1, 'Python'),
(2, 'JavaScript');

SELECT * FROM curso;

DROP TABLE IF EXISTS aluno;
CREATE TABLE aluno (
	id SERIAL PRIMARY KEY,
	NOME VARCHAR(100)
);

INSERT INTO aluno (nome) VALUES 
('Lucas'),
('Matheus');

SELECT * FROM aluno;
SELECT * FROM curso;

DROP TABLE IF EXISTS aluno_curso;
CREATE TABLE aluno_curso (
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id),
	FOREIGN KEY (aluno_id) REFERENCES aluno (id),
	FOREIGN KEY (curso_id) REFERENCES curso (id)
);

INSERT INTO aluno_curso (aluno_id, curso_id) VALUES
(1, 1),
(2, 1);

-- INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (3,1);
-- gera erro por conta da referência da chave estrangeira

SELECT * FROM aluno_curso;

-- consultas com relacionamentos
-- JOIN
SELECT * FROM aluno 
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso 		 ON curso.id = aluno_curso.curso_id; 
	
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES (2, 2);
INSERT INTO aluno_curso (aluno_id, curso_id) VALUES
(3, 1),
(1, 3);

SELECT aluno.nome AS "nome do aluno",
	   curso.nome AS "nome do curso"
	FROM aluno 
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso 		 ON curso.id = aluno_curso.curso_id; 
	
INSERT INTO aluno (nome) VALUES ('Rodrigo');
INSERT INTO curso (id, nome) VALUES (3, 'MongoDB');

-- LEFT JOIN
SELECT aluno.nome AS "nome do aluno",
	   curso.nome AS "nome do curso"
	FROM aluno 
	LEFT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	LEFT JOIN curso 		 ON curso.id = aluno_curso.curso_id; 
	
-- RIGHT JOIN
SELECT aluno.nome AS "nome do aluno",
	   curso.nome AS "nome do curso"
	FROM aluno 
	RIGHT JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	RIGHT JOIN curso 		 ON curso.id = aluno_curso.curso_id; 
	
-- FULL JOIN
SELECT aluno.nome AS "nome do aluno",
	   curso.nome AS "nome do curso"
	FROM aluno 
	FULL JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	FULL JOIN curso 		 ON curso.id = aluno_curso.curso_id; 
	
-- CROSS JOIN
SELECT aluno.nome AS "nome do aluno",
	   curso.nome AS "nome do curso"
	FROM aluno 
	CROSS JOIN curso; 
	
INSERT INTO aluno (nome) VALUES ('Luiza');

-- cascade: a ação de deleção ou atualização é refletida nas demais tabelas
SELECT * FROM aluno;
SELECT * FROM aluno_curso;
SELECT * FROM curso;

-- DELETE FROM aluno WHERE id = 1;
-- não é possível, pois o id do aluno é refenciado em outra tabela como chave estrangeira e está com configuração padrão RESTRICT

-- configuração cascade e configuração restrict (ON DELETE RESTRICT)
DROP TABLE IF EXISTS aluno_curso;
CREATE TABLE aluno_curso (
	aluno_id INTEGER,
	curso_id INTEGER,
	PRIMARY KEY (aluno_id, curso_id),
	FOREIGN KEY (aluno_id) REFERENCES aluno (id) 
		ON DELETE CASCADE 	-- deleção em cascada, o oposto e padrão é RESTRICT
		ON UPDATE CASCADE, 	-- atualização em cascada
	FOREIGN KEY (curso_id) REFERENCES curso (id)
);

-- agora com castade será possível fazer a remoção em cascada
DELETE FROM aluno WHERE id = 1;

-- atualização em cascade (ON UPDATE CASCADE)
UPDATE aluno SET id = 10 WHERE id = 4; -- funciona, pois esse id de aluno não é refenciado em outra tabela
UPDATE aluno SET id = 345 WHERE id = 2; -- NÃO funciona, pois esse id de aluno é refenciado em outra tabela

SELECT * FROM aluno_curso;

SELECT aluno.id AS matricula,
	   aluno.nome AS "Nome do aluno",
	   curso.nome AS curso
	FROM aluno 
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso on aluno_curso.curso_id = curso.id;
	
-- ordenar consultas
DROP TABLE IF EXISTS funcionario;
CREATE TABLE funcionario (
	id SERIAL PRIMARY KEY NOT NULL,
	matricula VARCHAR(10) NOT NULL,
	nome VARCHAR(255),
	sobrenome VARCHAR(255)
);

INSERT INTO funcionario (matricula, nome, sobrenome) VALUES
('M001', 'Diogo', 'Mascarenhas'),
('M002', 'Vinícius', 'Dias'),
('M003', 'Nico', 'Steppat'),
('M004', 'João', 'Roberto'),
('M005', 'Diogo', 'Mascarenhas'),
('M006', 'Alberto', 'Martins');

SELECT * FROM funcionario;

SELECT * FROM funcionario ORDER BY nome;

SELECT * FROM funcionario ORDER BY nome DESC;

SELECT * FROM funcionario ORDER BY nome, matricula;

SELECT * FROM funcionario ORDER BY nome, matricula;
SELECT * FROM funcionario ORDER BY 3, 2; --  ordena da mesma forma que a coluna acima (coluna 3 e coluna 2)

SELECT * FROM funcionario ORDER BY 4 DESC, 2 ASC -- ordem decrescente de sobrenome e crescente de nome

SELECT * FROM funcionario ORDER BY funcionario.nome; -- funcionario.nome evita referência ambígua de nome, mas nesse caso não é nescessário

SELECT aluno.id AS matricula,
	   aluno.nome AS "Nome do aluno",
	   curso.nome AS curso
	FROM aluno 
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso on aluno_curso.curso_id = curso.id
	ORDER BY curso.nome ASC; -- curso.nome evita referência ambígua de nome, pois há nome de curso e de aluno
	
SELECT aluno.id AS matricula,
	   aluno.nome AS "Nome do aluno",
	   curso.nome AS curso
	FROM aluno 
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso on aluno_curso.curso_id = curso.id
	ORDER BY curso.nome, aluno.nome DESC; 
	
-- limites de consulta
SELECT matricula, nome from funcionario  LIMIT 2;  

SELECT * FROM funcionario ORDER BY nome LIMIT 3;

-- offset
SELECT * FROM funcionario OFFSET 3; -- inicia a partir do terceiro item
SELECT * FROM funcionario ORDER BY matricula LIMIT 3 OFFSET 4; -- inicia a partir do segundo item

-- agregações
-- COUNT : retorna a quantidade de registros
-- SUM : retorna a soma dos valores de registros
-- MAX : retorna o maior valor dos registros
-- MIN : retorna o menor valor dos registros
-- AVG : reotorna a média dos valores do registros

INSERT INTO funcionario (matricula, nome, sobrenome) VALUES 
('M007', 'Lucas', 'Coelho'),
('M008', 'Matheus', 'Coelho'),
('M009', 'Rodrigo', 'Coelho');
SELECT * FROM funcionario;

SELECT COUNT(id) FROM funcionario;
SELECT COUNT(*) FROM funcionario;

SELECT SUM(id) FROM funcionario;
SELECT MIN(id) FROM funcionario;
SELECT MAX(id) FROM funcionario;
SELECT AVG(id) FROM funcionario;

SELECT COUNT(id),
	   SUM(id),
	   MIN(id),
	   MAX(id),
	   ROUND(AVG(id), 2) -- arredonda para 2 casas decimais
	FROM funcionario;

-- agrupamentos
SELECT DISTINCT nome FROM funcionario ORDER BY nome; -- distinct não repirá os dados iguais

SELECT DISTINCT nome, sobrenome FROM funcionario 
	GROUP BY nome, sobrenome
	ORDER BY nome;
	
SELECT DISTINCT nome, sobrenome, COUNT(id) 
	FROM funcionario 
	GROUP BY nome, sobrenome
	ORDER BY nome;
	
SELECT DISTINCT nome, sobrenome, COUNT(id) 
	FROM funcionario 
	GROUP BY 1, 2
	ORDER BY nome;
	
SELECT * FROM aluno;
SELECT * FROM aluno_curso;

SELECT curso.nome AS curso,
	   COUNT(aluno.id)
	FROM aluno 
	JOIN aluno_curso ON aluno_curso.aluno_id = aluno.id
	JOIN curso ON aluno_curso.curso_id = curso.id
	GROUP BY curso.nome;

SELECT * FROM aluno;
SELECT * FROM aluno_curso;
SELECT * FROM curso;

INSERT INTO curso (id, nome) VALUES 
(4, 'Docker'),
(5, 'AWS');

SELECT * 
	FROM curso
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id;

SELECT curso.nome,
	   COUNT(aluno.id)
	FROM curso
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id
	WHERE curso.nome LIKE '%S%'
	GROUP BY curso.nome;
	
-- listagem de cursos sem alunos	
SELECT curso.nome,
	   COUNT(aluno.id)
	FROM curso
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id
	GROUP BY curso.nome
	HAVING COUNT(aluno.id) = 0;

-- listagem de cursos com alunos
SELECT curso.nome,
	   COUNT(aluno.id)
	FROM curso
	LEFT JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	LEFT JOIN aluno ON aluno.id = aluno_curso.aluno_id
	GROUP BY curso.nome
	HAVING COUNT(aluno.id) > 0;

-- listagem de funcionários com nomes repetidos junto ao número de repetições
SELECT nome, COUNT(id) 
	FROM funcionario
	GROUP BY nome
	HAVING COUNT(id) > 1;
		
