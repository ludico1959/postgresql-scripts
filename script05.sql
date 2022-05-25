CREATE SCHEMA teste;

CREATE TABLE teste.cursos_programacao (
	id_curso INTEGER PRIMARY KEY NOT NULL,
	nome_curso VARCHAR(255) NOT NULL
);

INSERT INTO teste.cursos_programacao
SELECT academico.curso.id,
	   academico.curso.nome
	FROM academico.curso
WHERE categoria_id = 2;
	
SELECT * FROM teste.cursos_programacao;


-- UPDATE FROM
SELECT * FROM academico.curso ORDER BY id;

UPDATE academico.curso SET nome = 'PHP Básico' WHERE id = 4;
UPDATE academico.curso SET nome = 'Java Básico' WHERE id = 5;
UPDATE academico.curso SET nome = 'C++ Básico' WHERE id = 6;

UPDATE teste.cursos_programacao SET nome_curso = nome
	FROM academico.curso 
	WHERE teste.cursos_programacao.id_curso = academico.curso.id
	AND academico.curso.id < 10;

-- sempre fazer um SELECT antes de fazer um DELETE ou UPDATE
BEGIN; -- inicia a transação
	SELECT * FROM teste.cursos_programacao; -- transação
	DELETE FROM teste.cursos_programacao;	-- transação
COMMIT;	-- confirma a transação
ROLLBACK; -- desfaz a transação