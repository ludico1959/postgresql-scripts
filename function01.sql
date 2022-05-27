-- crirar função
CREATE FUNCTION primeira_funcao() RETURNS INTEGER AS '
	SELECT (5 - 3) * 2
' LANGUAGE SQL;

-- executar função
SELECT primeira_funcao();

SELECT * FROM primeira_funcao();

SELECT primeira_funcao() AS resultado;

-- outra função
CREATE FUNCTION soma_dois_numeros(numero_1 INTEGER, numero_2 INTEGER) RETURNS INTEGER AS '
	SELECT numero_1 + numero_2;
' LANGUAGE SQL;

SELECT soma_dois_numeros(3, 17);
SELECT soma_dois_numeros(4, 43);
SELECT soma_dois_numeros(19, -6);
SELECT soma_dois_numeros(-90, -6);

-- referenciando as posições dos parâmetros na função com $
CREATE FUNCTION multiplica_dois_numeros(INTEGER, INTEGER) RETURNS INTEGER AS '
	SELECT $1 * $2; 
' LANGUAGE SQL;

SELECT multiplica_dois_numeros(3, 7);

-- deletar função
DROP FUNCTION multiplica_dois_numeros;

-- outra forma mais simples
SELECT 2 + 5; -- usa-se funções para o caso de executar muitas linhas de comando

-- funções com tabelas
CREATE TABLE tabela (nome VARCHAR(255) NOT NULL);

-- cria ou substiui a função
-- o REPLACE não permite que os tipos dos parâmetros e do retorno seja diferentes da função que ele irá substituir
-- nesse caso, deve-se dar um DROP FUNCTION e, em seguida, um novo CREATE FUNCTION
CREATE OR REPLACE FUNCTION cria_tabela(nome VARCHAR) RETURNS VARCHAR AS '
	INSERT INTO tabela (nome) VALUES (cria_tabela.nome);
	
	SELECT nome;
' LANGUAGE SQL;

SELECT cria_tabela('John Doe');

DROP FUNCTION cria_tabela;
CREATE OR REPLACE FUNCTION cria_tabela(nome VARCHAR) RETURNS VOID AS '
	INSERT INTO tabela (nome) VALUES (cria_tabela.nome);
' LANGUAGE SQL;

SELECT cria_tabela('John Doe'); -- retona null, pois o retorno é void
SELECT * FROM tabela;

-- é uma boa prática delimitar a função com $$ ao invés de ''
DROP FUNCTION cria_tabela;
CREATE OR REPLACE FUNCTION cria_tabela(nome VARCHAR) RETURNS VOID AS $$
	INSERT INTO tabela (nome) VALUES (cria_tabela.nome);
$$ LANGUAGE SQL;

/* PROCEDURE
Existe um outro conceito, muito similar às funções, chamado de PROCEDUREs.
Uma Procedure no PostgreSQL é exatamente igual a uma função tendo como diferença o fato de que não retorna nenhum valor.
Como não há retorno em Procedures, não podemos chamá-lo como parte de um comando SQL (como temos feito com funções, chamando-as como parte do SELECT). 
No lugar disso, utilizamos CALL nome_do_procedure para executar uma Procedure.

Tudo que for ensinado nesse treinamento sobre lógicas de execução se aplica a procedure, se atentando à diferença de que não há retorno.
*/
