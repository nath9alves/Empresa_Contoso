-- Quest�o 1

--Para fins fiscais, a contabilidade da empresa precisa de uma tabela
--contendo todas as vendas referentes � loja �Contoso Orlando Store�. Isso
--porque essa loja encontra-se em uma regi�o onde a tributa��o foi
--modificada recente.

--Portanto, crie uma consulta ao Banco de Dados para obter uma tabela
--FactSales contendo todas as vendas desta loja.


SELECT * FROM FactSales WHERE StoreKey = (SELECT StoreKey FROM DimStore WHERE StoreName = 'Contoso Orlando Store')


-- Quest�o 2


--a)A sua consulta resultante deve conter as colunas ProductKey,
--ProductName e UnitPrice da tabela DimProduct.

--b)Nessa query voc� tamb�m deve retornar uma coluna extra, que
--informe o unitPrice do produto 1893.

SELECT ProductKey,
ProductName,
UnitPrice,
(SELECT
UnitPrice
FROM DimProduct
WHERE ProductKey = 1893)
FROM DimProduct
WHERE UnitPrice > (SELECT UnitPrice FROM DimProduct WHERE ProductKey = 1893)


--Quest�o 3

--A empresa Contoso criou um programa de bonifica��o chamado �Todos
--por 1�. Este programa consistia no seguinte: 1 funcion�rio seria escolhido
--ao final do ano como o funcion�rio destaque, s� que a bonifica��o seria
--recebida por todos da �rea daquele funcion�rio em particular. O objetivo
--desse programa seria o de incentivar a colabora��o coletiva entre os
--funcion�rios de uma mesma �rea. Desta forma, o funcion�rio destaque
--beneficiaria n�o s� a si, mas tamb�m a todos os colegas de sua �rea.

--Ao final do ano, o funcion�rio escolhido como destaque foi o Miguel
--Severino. Isso significa que todos os funcion�rios da �rea do Miguel
--seriam beneficiados com o programa.

--O seu objetivo � realizar uma consulta � tabela DimEmployee e retornar
--todos os funcion�rios da �rea �vencedora� para que o setor Financeiro
--possa realizar os pagamentos das bonifica��es.

SELECT * FROM DimEmployee
WHERE DepartmentName = (
    SELECT DepartmentName
    FROM DimEmployee
    WHERE LastName = 'Severino')


	--Quest�o 4

-- Fa�a uma query que retorne os clientes que recebem um sal�rio anual
-- acima da m�dia. A sua query deve retornar as colunas CustomerKey,
-- FirstName, LastName, EmailAddress e YearlyIncome.

-- Obs: considere apenas os clientes que s�o 'Pessoas F�sicas'.

SELECT CustomerKey, FirstName, LastName, EmailAddress, YearlyIncome
FROM DimCustomer
WHERE YearlyIncome > (
    SELECT AVG(YearlyIncome)
    FROM DimCustomer
    WHERE CustomerType = 'Person'
)
AND CustomerType = 'Person';


-- Quest�o 5

--A a��o de desconto da Asian Holiday Promotion foi uma das mais bem
--sucedidas da empresa. Agora, a Contoso quer entender um pouco
--melhor sobre o perfil dos clientes que compraram produtos com essa
--promo��o.
--Seu trabalho � criar uma query que retorne a lista de clientes que
--compraram nessa promo��o.


-- 1� Passo - Descobrir qual � o ID da promo��o Asian Holiday Promotion


SELECT PromotionKey FROM DimPromotion WHERE PromotionName = 'Asian Holiday Promotion' --> IDs: 5, 14 e 23


-- 2� Passo - Descobrir os IDs das clientes que compraram com essa promo��o


SELECT
	CustomerKey
FROM FactOnlineSales
WHERE PromotionKey IN (
	SELECT PromotionKey FROM DimPromotion 
	WHERE PromotionName = 'Asian Holiday Promotion'
)


-- 3� Passo - Descobrir as informa��es desses clientes


SELECT
	*
FROM 
	DimCustomer
WHERE 
	CustomerKey IN (
		SELECT
			CustomerKey
		FROM 
			FactOnlineSales
		WHERE 
			PromotionKey IN (
			SELECT 
				PromotionKey 
			FROM 
				DimPromotion 
			WHERE 
				PromotionName = 'Asian Holiday Promotion'
		)
)


-- Exerc�cio 6

-- A empresa implementou um programa de fideliza��o para clientes empresariais. Todos os clientes que compraram 
--ou que comprarem mais de 3000 unidades de um mesmo produto receber�o descontos em compras futuras. Voc� dever� descobrir 
--as informa��es de CustomerKey e CompanyName destes clientes. 


-- 1� Passo: Descobrir o ID dos clientes que compram mais de 3000 unidades


SELECT
	CustomerKey,
	ProductKey,
	COUNT(*)
FROM
	FactOnlineSales
GROUP BY CustomerKey, ProductKey
HAVING COUNT(*) >= 3000


 --2� Passo: Descobrir o CompanyName desses clientes


SELECT
	CustomerKey,
	CompanyName
FROM DimCustomer
WHERE CustomerKey IN (
		SELECT 
			CustomerKey 
		FROM FactOnlineSales
		GROUP BY CustomerKey, ProductKey
		HAVING COUNT(*) >= 3000
)


-- Exerc�cio 7

/* Voc� dever� criar uma consulta para o setor de vendas que mostre as seguintes colunas da tabela DimProduct: 
ProductKey, 
ProductName, 
BrandName, 
UnitPrice 
M�dia de UnitPrice. */

SELECT
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	( SELECT AVG(UnitPrice) FROM DimProduct) AS 'M�dia de UnitPrice'
FROM
	DimProduct


-- Exerc�cio 8

-- Fa�a uma consulta para descobrir os seguintes indicadores dos seus produtos: 

--Maior quantidade de produtos por marca 
--Menor quantidade de produtos por marca 
--M�dia de produtos por marca */

SELECT 
	MAX(Quantidade) AS 'M�ximo',
	MIN(Quantidade) AS 'M�nima',
	AVG(Quantidade) AS 'M�dia'
FROM ( SELECT BrandName, COUNT(*) AS 'Quantidade' FROM DimProduct GROUP BY BrandName ) AS T


-- Exerc�cio 9

-- Crie uma CTE que seja o agrupamento da tabela DimProduct, armazenando o total de produtos por marca. Em seguida, fa�a um SELECT nesta CTE, descobrindo qual � a quantidade m�xima de produtos para uma marca. Chame esta CTE de CTE_QtdProdutosPorMarca. */

WITH CTE_QtdProdutosPorMarca AS (
	SELECT
		BrandName,
		COUNT(*) AS 'Quantidade'
	FROM DimProduct
	GROUP BY BrandName
)

--SELECT * FROM CTE_QtdProdutosPorMarca
--SELECT MAX(Quantidade) FROM CTE_QtdProdutosPorMarca
--SELECT MIN(Quantidade) FROM CTE_QtdProdutosPorMarca

SELECT AVG(Quantidade) FROM CTE_QtdProdutosPorMarca


-- Exerc�cio 10

--Crie duas CTEs:

--(1) a primeira deve conter as colunas ProductKey, ProductName, ProductSubcategoryKey, BrandName e UnitPrice, da tabela DimProduct, mas apenas os produtos da marca Adventure Works. Chame essa CTE de CTE_ProdutosAdventureWorks. 
--(2) a segunda deve conter as colunas ProductSubcategoryKey, ProductSubcategoryName, da tabela DimProductSubcategory mas apenas para as subcategorias �Televisions� e �Monitors�. Chame essa CTE de CTE_CategoriaTelevisionsEMonitors. 

--Fa�a um Join entre essas duas CTEs, e o resultado deve ser uma query contendo todas as colunas das duas tabelas. Observe nesse exemplo a diferen�a entre o LEFT JOIN e o INNER JOIN.

WITH CTE_ProdutosAdventureWorks AS (
	SELECT
		ProductKey,
		ProductName,
		ProductSubcategoryKey,
		BrandName,
		UnitPrice
	FROM DimProduct
	WHERE BrandName = 'Adventure Works'
),
CTE_CategoriaTelevisionsEMonitors AS (
	SELECT
		ProductSubcategoryKey,
		ProductSubcategoryName
	FROM DimProductSubcategory
	WHERE ProductSubcategoryName IN ('Televisions', 'Monitors')
)

SELECT 
	CTE_ProdutosAdventureWorks.*,
	CTE_CategoriaTelevisionsEMonitors.ProductSubcategoryName
FROM CTE_ProdutosAdventureWorks
INNER JOIN CTE_CategoriaTelevisionsEMonitors
	ON CTE_ProdutosAdventureWorks.ProductSubcategoryKey = CTE_CategoriaTelevisionsEMonitors.ProductSubcategoryKey