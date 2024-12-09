-- MÓDULO 22 - SQL SERVER - PROCEDURES - EXERCÍCIOS


-- Obs. As Procedures dos exercícios 1 a 3 serão executadas nas tabelas originais do banco de dados ContosoRetailDW. 
USE ContosoRetailDW

/* EXERCICIO 01
Crie uma Procedure que resume o total de produtos por nome da categoria. Essa Procedure deve solicitar ao usuário qual marca deve ser considerada na análise. */

CREATE OR ALTER PROCEDURE P_TotalProdutosCategoria (@marca VARCHAR(MAX))
AS
BEGIN
	SELECT
		DimProductCategory.ProductCategoryName,
		COUNT(*) AS 'Total de Produtos'
	FROM DimProduct
	INNER JOIN DimProductSubcategory
		ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey
	WHERE BrandName = @marca
	GROUP BY ProductCategoryName
	
END

EXECUTE P_TotalProdutosCategoria 'Contoso'
EXECUTE P_TotalProdutosCategoria 'Litware'


SELECT * FROM DimProduct
SELECT * FROM DimProductSubCategory
SELECT * FROM DimProductCategory

------------------------------

/* EXERCICIO 02
Crie uma Procedure que lista os top N clientes de acordo com a data de primeira compra. O valor de N deve ser um parâmetro de entrada da sua Procedure. */

SELECT * FROM DimCustomer


CREATE OR ALTER PROCEDURE P_ListaTopClientes(@topn INT)
AS
BEGIN
	SELECT TOP(@topn) *
	FROM DimCustomer
	WHERE CustomerType = 'Person'
	ORDER BY DateFirstPurchase

END

EXECUTE P_ListaTopClientes 10

------------------------------

/* EXERCICIO 03
Crie uma Procedure que recebe 2 argumentos: MÊS (de 1 a 12) e ANO (1996 a 2003). Sua Procedure deve listar todos os funcionários que foram contratados no mês/ano informado. */

SELECT * FROM DimEmployee

CREATE OR ALTER PROCEDURE P_FuncionariosContratados(@mes INT, @ano INT)
AS
BEGIN
	SELECT * FROM DimEmployee
	WHERE DATEPART(MM, Hiredate) = @mes AND DATEPART(YYYY, HireDate)  = @ano
	ORDER BY HireDate
END

EXECUTE P_FuncionariosContratados 1, 2000


-- Obs. Para os exercícios 4, 5 e 6, utilize os códigos abaixo.

DROP DATABASE AlugaFacil 

CREATE DATABASE AlugaFacil 
USE AlugaFacil 

CREATE TABLE Carro( 
	id_carro INT, 
	placa VARCHAR(100) NOT NULL, 
	modelo VARCHAR(100) NOT NULL, 
	tipo VARCHAR(100) NOT NULL, 
	valor FLOAT NOT NULL, 
	CONSTRAINT carro_id_carro_pk PRIMARY KEY(id_carro) 
) 

INSERT INTO Carro(id_carro, placa, modelo, tipo, valor) VALUES 
	(1, 'CRU-1111', 'Chevrolet Cruze', 'Sedan', 140000), 
	(2, 'ARG-2222', 'Fiat Argo', 'Hatch', 80000), 
	(3, 'COR-3333', 'Toyota Corolla', 'Sedan', 170000), 
	(4, 'TIG-4444', 'Caoa Chery Tiggo', 'SUV', 190000) 

SELECT * FROM Carro

------------------------------

/* EXERCICIO 04
Crie uma Procedure que insere uma nova linha na tabela Carro. Essa nova linha deve conter os seguintes dados: 
- id = 5 
- placa = GOL-5555 
- modelo = Volkswagen Gol 
- tipo = Hatch 
- valor = 80000			*/

CREATE OR ALTER PROCEDURE P_InserirCarro
AS
BEGIN
	BEGIN TRANSACTION
	INSERT INTO Carro(id_carro, placa, modelo, tipo, valor) VALUES 
		(5, 'GOL-5555', 'Volkswagen Gol', 'Hatch', 80000)
	COMMIT
END

EXECUTE P_InserirCarro

SELECT * FROM Carro

------------------------------

/* EXERCICIO 05
Crie uma Procedure que altera o valor de venda de um carro. A Procedure deve receber como parâmetros o id_carro e o novo valor. */

CREATE OR ALTER PROCEDURE P_AlteraValorCarro(@id INT, @nvalor FLOAT)
AS
BEGIN
	BEGIN TRANSACTION
		UPDATE Carro
		SET valor = @nvalor
		WHERE id_Carro = @id
	COMMIT
END

EXECUTE P_AlteraValorCarro 5, 85000

SELECT * FROM Carro

------------------------------

/* EXERCICIO 06
Crie uma Precedure que exclui um carro a partir do id informado. */

CREATE OR ALTER PROCEDURE P_ExcluiCarro(@id INT)
AS
BEGIN
	BEGIN TRANSACTION
		DELETE FROM Carro
		WHERE id_carro = @id
	COMMIT
END

EXECUTE P_ExcluiCarro 5

SELECT * FROM Carro