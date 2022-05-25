-- sequencias
CREATE SEQUENCE sequencia;

SELECT CURRVAL('sequencia');
SELECT NEXTVAL('sequencia');

DROP TABLE auto;
CREATE TEMPORARY TABLE auto (
	id INTEGER PRIMARY KEY DEFAULT NEXTVAL('sequencia'),
	nome VARCHAR(30) NOT NULL
);

INSERT INTO auto (nome) VALUES ('Lucas Coelho');
INSERT INTO auto (id, nome) VALUES (2, 'Matheus Coelho');
INSERT INTO auto (nome) VALUES ('Rodrigo Coelho');

SELECT * FROM auto;

-- ENUM: tipo enumerado
CREATE TYPE CLASSIFICACAO AS ENUM ('LIVRE', '12_ANOS', '14_ANOS', '16_ANOS', 'ADULTO');

CREATE TEMPORARY TABLE filme (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(255) NOT NULL,
	classificacao CLASSIFICACAO
);

INSERT INTO filme (nome, classificacao) VALUES
('Herby', '12_ANOS'),
('Deadpool', 'ADULTO'),
('Bambi', 'LIVRE'),
('Pânico 5', '16_ANOS');

SELECT * FROM filme;