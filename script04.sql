SELECT academico.curso.id,
	   academico.curso.nome AS curso,
	   academico.categoria.nome AS categoria
	FROM academico.curso
	JOIN academico.categoria ON academico.categoria.id = academico.curso.categoria_id
WHERE categoria_id = 2;
 
SELECT academico.curso.id,
 	   academico.curso.nome
	FROM academico.curso
WHERE categoria_id = 2;
 
CREATE TEMPORARY TABLE cursos_programacao (
	id_curso INTEGER PRIMARY KEY NOT NULL,
	nome_curso VARCHAR(255) NOT NULL
 );
 
-- INSERT INTO + SELECT 
-- os campos do SELECT pode ter nomes diferentes, mas não precisa estar em ordem 
INSERT INTO cursos_programacao
SELECT academico.curso.id,
 	   academico.curso.nome
	FROM academico.curso
WHERE categoria_id = 2;

SELECT * FROM cursos_programacao;
