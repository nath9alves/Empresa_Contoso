
--Quest�o 1

--a. Fa�a um resumo da quantidade vendida (SalesQuantity) de acordo
--com o canal de vendas (channelkey).

SELECT channelKey, SUM(SalesQuantity) FROM FactSales GROUP BY ChannelKey

--b. Fa�a um agrupamento mostrando a quantidade total vendida
--(SalesQuantity) e quantidade total devolvida (Return Quantity) de
--acordo com o ID das lojas (StoreKey).

SELECT StoreKey, SUM(Salesquantity), SUM(ReturnQuantity) FROM FactSales GROUP BY StoreKey

--c. Fa�a um resumo do valor total vendido (SalesAmount) para cada
--canal de venda, mas apenas para o ano de 2007.

SELECT ChannelKey, SUM(SalesQuantity) FROM FactSales WHERE DateKey BETWEEN '01/01/2007' AND '31/12/2007'
GROUP BY ChannelKey

--Quest�o 2

--Voc� precisa fazer uma an�lise de vendas por produtos O objetivo final �
--descobrir o valor total vendido SalesAmount por produto ProductKey 

--a. A tabela final dever� estar ordenada de acordo com a quantidade vendida e,
--al�m disso mostrar apenas os produtos que tiveram um resultado final de vendas 
--maior do que $5.000.000.

SELECT ProductKey, SUM(SalesAmount) FROM FactSales GROUP BY ProductKey
HAVING SUM(SalesAmount) >= 5000000 ORDER BY SUM(SalesAmount) DESC

--b.Fa�a uma adapta��o no exerc�cio anterior e mostre os Top 10 produtoscom
--mais vendas . Desconsidere o filtro de $5.000.000 aplicado. 

SELECT TOP(10) ProductKey, SUM(SalesAmount) FROM FactSales GROUP BY ProductKey ORDER BY SUM (SalesAmount) DESC

--Quest�o 3

--a. Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual
--� o ID ( do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).

SELECT TOP(1) CustomerKey, 
SUM(SalesQuantity) 
FROM FactOnlineSales 
GROUP BY CustomerKey
ORDER BY SUM(SalesQuantity) DESC


--b.Feito isso, fa�a um agrupamento de total vendido ( por ID do produto e descubra quais foram 
--os top 3 produtos mais comprados pelo cliente da letra a).

SELECT TOP(3) ProductKey, AS 'Produto', 
SUM(SalesQuantity) AS 'Total vendido'
FROM FactOnlineSales
WHERE CustomerKey = 19037
GROUP BY ProductKey
ORDER BY SUM(SalesQuantity) DESC

-- Quest�o 4

--a. Fa�a um agrupamento e descubra a quantidade total de produtos por marca.

SELECT BrandName, COUNT(*) FROM DimProduct GROUP BY BrandName

--b. Determine a m�dia do pre�o unit�rio (UnitPrice) para cada ClassName.

SELECT ClassName, AVG(unitPrice) FROM DimProduct GROUP BY ClassName

--c. Fa�a um agrupamento de cores e descubra o peso total que cada cor
--de produto possui.

SELECT ColorName, SUM(Weight) FROM DimProduct GROUP BY ColorName

-- Quest�o 5

--Voc� dever� descobrir o peso total para cada tipo de produto (StockTypeName).
--A tabela final deve considerar apenas a marca e ter os seus valores classificados em ordem decrescente

SELECT StockTypeName, SUM(Weight)
FROM DimProduct WHERE BrandName = 'Contoso'
GROUP BY StockTypeName

-- Quest�o 6

--Voc� seria capaz de confirmar se todas as marcas dos produtos possuem
--� disposi��o todas as 16 op��es de cores?

SELECT BrandName, COUNT(DISTINCT ColorName) FROM DimProduct GROUP BY BrandName

-- Quest�o 7 

--Fa�a um agrupamento para saber o total de clientes de acordo com o Sexo e tamb�m 
--a m�dia salarial de acordo com o Sexo. Corrija qualquer resultado �inesperado� com 
--os seus conhecimentos em SQL.

SELECT Gender AS 'Sexo', COUNT(Gender) AS 'Total'
FROM DimCustomer WHERE Gender IS NOT NULL
GROUP BY Gender ORDER BY COUNT(Gender) DESC

-- Quest�o 8

--Fa�a um agrupamento para descobrir a quantidade total de clientes e a m�dia salarial 
--de acordo com o seu n�vel escolar. Utilize a coluna Education da tabela DimCustomer 
--para fazer esse agrupamento.

SELECT Education AS 'N�vel Escolar', 
COUNT(Education) AS 'Qtd Total Escolaridade',
AVG(YearlyIncome) AS 'M�dia Salarial'
FROM DimCustomer WHERE Education IS NOT NULL
GROUP BY Education

-- Quest�o 9 

--Fa�a uma tabela resumo mostrando a quantidade total de funcion�rios de acordo 
--com o Departamento (DepartmentName). Importante: Voc� dever� considerar apenas 
--os funcion�rios ativos.

SELECT DepartmentName, COUNT(*)
FROM DimEmployee WHERE "Status" = 'Current'
GROUP BY DepartmentName

-- Quest�o 10

--Fa�a uma tabela resumo mostrando o total de VacationHours para cada cargo (Title). 
--Voc� deve considerar apenas as mulheres, dos departamentos de Production, Marketing,
--Engineering e Finance, para os funcion�rios contratados entre os anos de 1999 e 2000.

SELECT Title, SUM(VacationHours) FROM DimEmployee
WHERE Gender = 'F' AND DepartmentName IN ('Production', 'Marketing', 'Finance', 'Engineering')
AND HireDate BETWEEN '1999/01/01' AND '2000/12/31'
GROUP BY Title







