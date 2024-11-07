CREATE DATABASE Joins
GO
USE Joins

--------------------------------------------------------> Banco criado

CREATE TABLE produtos(
id_produto INT,
nome_produto VARCHAR(30),
id_subcategoria INT)

CREATE TABLE subcategoria(
id_subcategoria INT,
nome_subcategoria VARCHAR(30))

--------------------------------------------------------> Tabelas criadas

INSERT INTO produtos(id_produto, nome_produto, id_subcategoria)
VALUES
1, 'Fone Bluetooth JBL', 5),
2, 'PS4', 6),
3, 'Notebook Samsumg I3', 2),
4, 'Iphone 11', 1),
5, 'Moto G9', 1)


INSERT INTO subcategoria (id_subcategoria, nome_subcategoria)
VALUES
(1, 'Celular'),
(2, 'Notebook'),
(3, 'Câmera Digital'),
(4, 'Televisão'),
(5, 'Fone de Ouvido')

--------------------------------------------------------> Informações inseridas em ambas tabelas

SELECT id_produto, nome_produto, produtos.id_subcategoria, nome_subcategoria
FROM produtos
LEFT JOIN subcategoria
ON produtos.id_subcategoria = subcategoria.id_subcategoria ----> Consulta com LEFT JOIN


SELECT id_produto, nome_produto, produtos.id_subcategoria, nome_subcategoria
FROM produtos
RIGHT JOIN subcategoria
ON produtos.id_subcategoria = subcategoria.id_subcategoria ----> Consulta com RIGHT JOIN


SELECT id_produto, nome_produto, produtos.id_subcategoria, nome_subcategoria
FROM produtos
INNER JOIN subcategoria
ON produtos.id_subcategoria = subcategoria.id_subcategoria ----> Consulta com INNER JOIN


SELECT id_produto, nome_produto, produtos.id_subcategoria, nome_subcategoria
FROM produtos
FULL JOIN subcategoria
ON produtos.id_subcategoria = subcategoria.id_subcategoria ----> Consulta com FULL JOIN


SELECT id_produto, nome_produto, produtos.id_subcategoria, nome_subcategoria
FROM produtos
LEFT JOIN subcategoria
ON produtos.id_subcategoria = subcategoria.id_subcategoria 
WHERE subcategoria.id_subcategoria IS NULL ----> Consulta com LEFT ANTI JOIN


SELECT id_produto, 
nome_produto, 
produtos.id_subcategoria, 
nome_subcategoria
FROM produtos
RIGHT JOIN subcategoria
ON produtos.id_subcategoria = subcategoria.id_subcategoria 
WHERE Produtos.id_subcategoria IS NULL ----> Consulta com RIGHT ANTI JOIN


SELECT id_produto, nome_produto, produtos.id_subcategoria, nome_subcategoria
FROM produtos
FULL JOIN subcategoria
ON produtos.id_subcategoria = subcategoria.id_subcategoria
WHERE produtos.id_subcategoria IS NULL OR subcategoria.id_subcategoria IS NULL ----> Consulta com FULL ANTI JOIN


SELECT id_produto, nome_produto, produtos.id_subcategoria, nome_subcategoria
FROM subcategoria
RIGHT JOIN produtos
ON subcategoria.id_subcategoria = produtos.id_subcategoria ----> Consulta com RIGHT JOIN


SELECT nome_produto, nome_subcategoria
FROM produtos CROSS JOIN subcategoria ----> Consulta com CROSS JOIN (Repetiu a categoria errada em alguns produtos)

















