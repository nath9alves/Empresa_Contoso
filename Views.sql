
USE ContosoRetailDW

CREATE VIEW vw_ProductSales
AS
SELECT ProductKey,SUM(SalesQuantity) AS TotalSold
FROM FactSales
GROUP BY ProductKey
GO

SELECT * FROM FactSales


--1 Quest�o

--A partir da tabela DimProduct, crie uma View contendo as
--informa��es de ProductName, ColorName, UnitPrice e UnitCost, da
--tabela DimProduct. Chame essa View de vwProdutos.


SELECT * FROM DimProduct

CREATE VIEW vwProdutos
AS 
SELECT ProductName, ColorName, UnitPrice, UnitCost
FROM DimProduct


--A partir da tabela DimEmployee, crie uma View mostrando FirstName,
--BirthDate, DepartmentName. Chame essa View de vwFuncionarios.


SELECT * FROM DimEmployee

CREATE VIEW vwFuncionarios
AS
SELECT FirstName, BirthDate, DepartmentName
FROM DimEmployee


--A partir da tabela DimStore, crie uma View mostrando StoreKey,
--StoreName e OpenDate. Chame essa View de vwLojas.


SELECT * FROM DimStore

CREATE VIEW vwLojas
AS
SELECT StoreKey, StoreName, OpenDate
FROM DimStore


-- Quest�o 02

--Crie uma View contendo as informa��es de Nome Completo (FirstName
--+ LastName), G�nero (por extenso), E-mail e Renda Anual (formatada
--com R$).

--Utilize a tabela DimCustomer. Chame essa View de vwClientes.


CREATE VIEW vwClientes 
AS
SELECT
FirstName + ' ' + LastName AS NomeCompleto,
CASE 
WHEN Gender = 'M' THEN 'Masculino'
WHEN Gender = 'F' THEN 'Feminino'
ELSE 'Outro'
END AS Genero,
EmailAddress AS Email,
'R$ ' + FORMAT(YearlyIncome, 'N2', 'pt-BR') AS RendaAnual
FROM DimCustomer


--Quest�o 3

--a. A partir da tabela DimStore, crie uma View que considera apenas as
--lojas ativas. Fa�a um SELECT de todas as colunas. Chame essa View
--de vwLojasAtivas.

CREATE VIEW vwLojasAtivas 
AS
SELECT * FROM DimStore
WHERE
Status = 'On'

--b. A partir da tabela DimEmployee, crie uma View de uma tabela que
--considera apenas os funcion�rios da �rea de Marketing. Fa�a um
--SELECT das colunas: FirstName, EmailAddress e DepartmentName.
--Chame essa de vwFuncionariosMkt

CREATE VIEW vwFuncionariosMkt AS
SELECT FirstName, EmailAddress, DepartmentName
FROM Dimemployee
WHERE DepartmentName = 'Marketing'

--c. Crie uma View de uma tabela que considera apenas os produtos das
--marcas Contoso e Litware. Al�m disso, a sua View deve considerar
--apenas os produtos de cor Silver. Fa�a um SELECT de todas as
--colunas da tabela DimProduct. Chame essa View de vwContosoLitwareSilver

CREATE VIEW vwContosoLitwareSilver
AS
SELECT 
ProductName, 
Manufacturer, 
ColorName
FROM DimProduct
WHERE ColorName = 'Silver' 
AND Manufacturer IN ('Contoso, Ltd', 'Litware, Inc.')


--Quest�o 4

--Crie uma View que seja o resultado de um agrupamento da tabela
--FactSales. Este agrupamento deve considerar o SalesQuantity
--(Quantidade Total Vendida) por Nome do Produto. Chame esta View de
--vwTotalVendidoProdutos.
--OBS: Para isso, voc� ter� que utilizar um JOIN para relacionar as tabelas
--FactSales e DimProduct.

CREATE VIEW vwTotalVendidoProdutos 
AS
SELECT 
ProductName AS 'Nome do produto',
SUM(SalesQuantity) AS 'Qtd. Vendida'
FROM
Factsales
INNER JOIN DimProduct
ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName


--Quest�o 5

-- Fa�a as seguintes altera��es nas tabelas da quest�o 1.

--a.Na View criada na letra a da quest�o 1, adicione a coluna de
--BrandName.

ALTER VIEW vwProdutos 
AS
SELECT
ProductName AS 'Nome do produto',
BrandName AS 'Marca',
ColorName AS 'Cor',
UnitPrice AS 'Pre�o Unit�rio',
UnitCost AS 'Custo unit�rio'
FROM DimProduct


--b.Na View criada na letra b da quest�o 1, fa�a um filtro e
--considere apenas os funcion�rios do sexo feminino.

ALTER VIEW vwProdutos
AS
SELECT
FirstName AS 'Nome',
BirthDate AS 'Nascimento',
DepartmentName AS 'Departamento'
FROM
DimEmployee
WHERE Gender = 'F'


--c.Na View criada na letra c da quest�o 1, fa�a uma altera��o e
--filtre apenas as lojas ativas.


ALTER VIEW vwProdutos
AS
SELECT
StoreKey AS 'ID Loja',
StoreName AS 'Nome da Loja',
OpenDate AS 'Data de Abertura'
FROM
DimStore
WHERE Status = 'On'


-- Quest�o 6

-- Crie uma View que seja o resultado de um agrupamento da tabela
--DimProduct. O resultado esperado da consulta dever� ser o total de
--produtos por marca. Chame essa View de vw_6a.


CREATE VIEW vw_6a
AS
SELECT 
BrandName AS 'Marca',
COUNT(*) AS 'Total'
FROM 
DimProduct
GROUP BY BrandName


--Altere a View criada no exerc�cio anterior, adicionando o peso total
--por marca. Aten��o: sua View final dever� ter ent�o 3 colunas: Nome
--da Marca, Total de Produtos e Peso Total.


ALTER VIEW vW_6a
AS
SELECT
BrandName AS 'Marca',
COUNT(*) AS 'Total',
SUM(Weight) AS 'Peso'
FROM 
DimProduct
GROUP BY BrandName

--Exclua a View vw_6a.

DROP VIEW vW_6a









