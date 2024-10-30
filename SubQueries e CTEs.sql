-- Questão 1

--Para fins fiscais, a contabilidade da empresa precisa de uma tabela
--contendo todas as vendas referentes à loja ‘Contoso Orlando Store’. Isso
--porque essa loja encontra-se em uma região onde a tributação foi
--modificada recente.

--Portanto, crie uma consulta ao Banco de Dados para obter uma tabela
--FactSales contendo todas as vendas desta loja.


SELECT * FROM FactSales WHERE StoreKey = (SELECT StoreKey FROM DimStore WHERE StoreName = 'Contoso Orlando Store')


-- Questão 2


--a)A sua consulta resultante deve conter as colunas ProductKey,
--ProductName e UnitPrice da tabela DimProduct.

--b)Nessa query você também deve retornar uma coluna extra, que
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


--Questão 3

--A empresa Contoso criou um programa de bonificação chamado “Todos
--por 1”. Este programa consistia no seguinte: 1 funcionário seria escolhido
--ao final do ano como o funcionário destaque, só que a bonificação seria
--recebida por todos da área daquele funcionário em particular. O objetivo
--desse programa seria o de incentivar a colaboração coletiva entre os
--funcionários de uma mesma área. Desta forma, o funcionário destaque
--beneficiaria não só a si, mas também a todos os colegas de sua área.

--Ao final do ano, o funcionário escolhido como destaque foi o Miguel
--Severino. Isso significa que todos os funcionários da área do Miguel
--seriam beneficiados com o programa.

--O seu objetivo é realizar uma consulta à tabela DimEmployee e retornar
--todos os funcionários da área “vencedora” para que o setor Financeiro
--possa realizar os pagamentos das bonificações.

SELECT * FROM DimEmployee
WHERE DepartmentName = (
    SELECT DepartmentName
    FROM DimEmployee
    WHERE LastName = 'Severino')


	--Questão 4

-- Faça uma query que retorne os clientes que recebem um salário anual
-- acima da média. A sua query deve retornar as colunas CustomerKey,
-- FirstName, LastName, EmailAddress e YearlyIncome.

-- Obs: considere apenas os clientes que são 'Pessoas Físicas'.

SELECT CustomerKey, FirstName, LastName, EmailAddress, YearlyIncome
FROM DimCustomer
WHERE YearlyIncome > (
    SELECT AVG(YearlyIncome)
    FROM DimCustomer
    WHERE CustomerType = 'Person'
)
AND CustomerType = 'Person';


-- Questão 5

--A ação de desconto da Asian Holiday Promotion foi uma das mais bem
--sucedidas da empresa. Agora, a Contoso quer entender um pouco
--melhor sobre o perfil dos clientes que compraram produtos com essa
--promoção.
--Seu trabalho é criar uma query que retorne a lista de clientes que
--compraram nessa promoção.


-- 1º Passo - Descobrir qual é o ID da promoção Asian Holiday Promotion


SELECT PromotionKey FROM DimPromotion WHERE PromotionName = 'Asian Holiday Promotion' --> IDs: 5, 14 e 23


-- 2º Passo - Descobrir os IDs das clientes que compraram com essa promoção


SELECT
	CustomerKey
FROM FactOnlineSales
WHERE PromotionKey IN (
	SELECT PromotionKey FROM DimPromotion 
	WHERE PromotionName = 'Asian Holiday Promotion'
)


-- 3º Passo - Descobrir as informações desses clientes


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


-- Exercício 6

-- A empresa implementou um programa de fidelização para clientes empresariais. Todos os clientes que compraram 
--ou que comprarem mais de 3000 unidades de um mesmo produto receberão descontos em compras futuras. Você deverá descobrir 
--as informações de CustomerKey e CompanyName destes clientes. 


-- 1º Passo: Descobrir o ID dos clientes que compram mais de 3000 unidades


SELECT
	CustomerKey,
	ProductKey,
	COUNT(*)
FROM
	FactOnlineSales
GROUP BY CustomerKey, ProductKey
HAVING COUNT(*) >= 3000


 --2º Passo: Descobrir o CompanyName desses clientes


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


-- Exercício 7

/* Você deverá criar uma consulta para o setor de vendas que mostre as seguintes colunas da tabela DimProduct: 
ProductKey, 
ProductName, 
BrandName, 
UnitPrice 
Média de UnitPrice. */

SELECT
	ProductKey,
	ProductName,
	BrandName,
	UnitPrice,
	( SELECT AVG(UnitPrice) FROM DimProduct) AS 'Média de UnitPrice'
FROM
	DimProduct


-- Exercício 8

-- Faça uma consulta para descobrir os seguintes indicadores dos seus produtos: 

--Maior quantidade de produtos por marca 
--Menor quantidade de produtos por marca 
--Média de produtos por marca */

SELECT 
	MAX(Quantidade) AS 'Máximo',
	MIN(Quantidade) AS 'Mínima',
	AVG(Quantidade) AS 'Média'
FROM ( SELECT BrandName, COUNT(*) AS 'Quantidade' FROM DimProduct GROUP BY BrandName ) AS T


-- Exercício 9

-- Crie uma CTE que seja o agrupamento da tabela DimProduct, armazenando o total de produtos por marca. Em seguida, faça um SELECT nesta CTE, descobrindo qual é a quantidade máxima de produtos para uma marca. Chame esta CTE de CTE_QtdProdutosPorMarca. */

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


-- Exercício 10

--Crie duas CTEs:

--(1) a primeira deve conter as colunas ProductKey, ProductName, ProductSubcategoryKey, BrandName e UnitPrice, da tabela DimProduct, mas apenas os produtos da marca Adventure Works. Chame essa CTE de CTE_ProdutosAdventureWorks. 
--(2) a segunda deve conter as colunas ProductSubcategoryKey, ProductSubcategoryName, da tabela DimProductSubcategory mas apenas para as subcategorias ‘Televisions’ e ‘Monitors’. Chame essa CTE de CTE_CategoriaTelevisionsEMonitors. 

--Faça um Join entre essas duas CTEs, e o resultado deve ser uma query contendo todas as colunas das duas tabelas. Observe nesse exemplo a diferença entre o LEFT JOIN e o INNER JOIN.

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