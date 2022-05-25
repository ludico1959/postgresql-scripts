CREATE TEMPORARY TABLE tmp (
	coluna1 VARCHAR(255) NOT NULL CHECK (coluna1 <> ''),
	coluna2 VARCHAR(255) NOT NULL,
	UNIQUE (coluna1, coluna2)
);

INSERT INTO tmp VALUES
('a', 'b'),
('a', 'c');

SELECT * FROM tmp;

ALTER TABLE tmp RENAME TO temporario;

ALTER TABLE temporario RENAME coluna1 TO primeira_coluna;
ALTER TABLE temporario RENAME coluna2 TO segunda_coluna;

SELECT * FROM temporario;