
--> Ex 1: O gerente comercial pediu a voc� uma an�lise da Quantidade Vendida e
--Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial
--Quantidade Devolvida para o canal de venda mais importante da empresa:
--Store.
--Utilize uma fun��o SQL para fazer essas consultas no seu banco de
--dados. Obs: Fa�a essa an�lise considerando a tabela FactSales.

--SELECT SUM (SalesQuantity) AS 'Qtd Vendida',
--SUM (Returnquantity) AS 'Qtd Devolvida'
--FROM FactSales WHERE channelkey = '1'
---------------------------------------------------------------------------------------------------------------------

--> Ex 2: Uma nova a��o no setor de Marketing precisar� avaliar a m�dia salarial
--de todos os clientes da empresa, mas apenas de ocupa��o Professional.
--Utilize um comando SQL para atingir esse resultado.

--SELECT AVG (YearlyIncome) AS 'M�dia Salarial' FROM DimCustomer WHERE Occupation = 'Professional'

---------------------------------------------------------------------------------------------------------------------

--> Ex 3: Voc� precisar� fazer uma an�lise da quantidade de funcion�rios das lojas
--registradas na empresa. O seu gerente te pediu os seguintes n�meros e
--informa��es:

--a.Quantos funcion�rios tem a loja com mais funcion�rios?

--SELECT MAX (EmployeeCount) AS 'Qtd Funcion�rios' FROM DimStore 

--b.Qual � o nome dessa loja?

--SELECT TOP (1) StoreName AS 'Nome da Loja', EmployeeCount AS 'Qtd Funcion�rios' FROM DimStore ORDER BY EmployeeCount DESC -- 1� Op��o Exibir� na 1 linha de registro
--SELECT StoreName FROM DimStore WHERE EmployeeCount = '325' -- 2� Op��o exibir� uma linha de registro com a resposta

--c.Quantos funcion�rios tem a loja com menos funcion�rios?

--SELECT MIN (EmployeeCount) AS 'Menor Qtd Funcion�rios' FROM DimStore

--d.Qual � o nome dessa loja?

--SELECT TOP (1) StoreName AS 'Nome da Loja', EmployeeCount AS 'Menor Qtd Funcion�rios' FROM DimStore WHERE EmployeeCount IS NOT NULL ORDER BY EmployeeCount --1� Op��o est� na 1 linha de registro
--SELECT StoreName FROM DimStore WHERE EmployeeCount = '7' --2� Op��o exibir� uma linha de registro com a resposta

---------------------------------------------------------------------------------------------------------------------

-- Ex 4: A �rea de RH est� com uma nova a��o para a empresa, e para isso precisa saber a quantidade total de funcion�rios do sexo Masculino e do sexo Feminino.

--a.Descubra essas duas informa��es utilizando o SQL.

--SELECT COUNT (Gender) AS 'Qtd Feminino' FROM DimEmployee WHERE Gender = 'F' --> Ambos exibem a quantidade total de linhas de registro que estejam preenchidas com seus respectivos g�neros
--SELECT COUNT (Gender) AS 'Qtd Masculino' FROM DimEmployee WHERE Gender = 'M'

--b.O funcion�rio e a funcion�ria mais antigos receber�o uma homenagem. Descubra as seguintes informa��es de cada um deles: Nome, E-mail, Data de Contrata��o.

--SELECT MIN (HireDate) AS 'Data Contrata��o' FROM DimEmployee WHERE Gender = 'M' 
--SELECT MIN (HireDate) AS 'Data Contrata��o' FROM DimEmployee WHERE Gender = 'F' 

--SELECT FirstName AS 'Primeiro Nome', LastName AS 'Segundo Nome', EmailAddress AS 'E-mail', Gender AS 'G�nero', HireDate AS 'Data Contrata��o', EndDate AS 'Ativo desde' FROM DimEmployee ORDER BY HireDate ASC


---------------------------------------------------------------------------------------------------------------------


--Ex 5: Agora voc� precisa fazer uma an�lise dos produtos. Ser� necess�rio descobrir as seguintes informa��es:

--a.Quantidade distinta de cores de produtos.

--SELECT COUNT (DISTINCT ColorName) AS 'Cores' FROM DimProduct

--SELECT DISTINCT TOP (17) ColorName FROM DimProduct --> Comprova os nomes das cores

--b.Quantidade distinta de marcas

--SELECT COUNT (DISTINCT BrandName) AS 'Marcas' FROM DimProduct
--SELECT DISTINCT TOP (11) BrandName FROM DimProduct --> Comprova os nomes das marcas

--c.Quantidade distinta de classes de produto

--SELECT COUNT (DISTINCT ClassName) AS 'Classe' FROM DimProduct
--SELECT DISTINCT TOP (3) ClassName FROM DimProduct --> Comprova os nomes das classes

--Para simplificar, voc� pode fazer isso em uma mesma consulta

--SELECT COUNT (DISTINCT BrandName) AS 'Marcas' ,
--COUNT (DISTINCT ClassName) AS 'Classe',
--COUNT (DISTINCT ColorName) AS 'Cor'
--FROM DimProduct



