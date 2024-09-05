
--> Ex 1: O gerente comercial pediu a você uma análise da Quantidade Vendida e
--Uma nova ação no setor de Marketing precisará avaliar a média salarial
--Quantidade Devolvida para o canal de venda mais importante da empresa:
--Store.
--Utilize uma função SQL para fazer essas consultas no seu banco de
--dados. Obs: Faça essa análise considerando a tabela FactSales.

--SELECT SUM (SalesQuantity) AS 'Qtd Vendida',
--SUM (Returnquantity) AS 'Qtd Devolvida'
--FROM FactSales WHERE channelkey = '1'
---------------------------------------------------------------------------------------------------------------------

--> Ex 2: Uma nova ação no setor de Marketing precisará avaliar a média salarial
--de todos os clientes da empresa, mas apenas de ocupação Professional.
--Utilize um comando SQL para atingir esse resultado.

--SELECT AVG (YearlyIncome) AS 'Média Salarial' FROM DimCustomer WHERE Occupation = 'Professional'

---------------------------------------------------------------------------------------------------------------------

--> Ex 3: Você precisará fazer uma análise da quantidade de funcionários das lojas
--registradas na empresa. O seu gerente te pediu os seguintes números e
--informações:

--a.Quantos funcionários tem a loja com mais funcionários?

--SELECT MAX (EmployeeCount) AS 'Qtd Funcionários' FROM DimStore 

--b.Qual é o nome dessa loja?

--SELECT TOP (1) StoreName AS 'Nome da Loja', EmployeeCount AS 'Qtd Funcionários' FROM DimStore ORDER BY EmployeeCount DESC -- 1º Opção Exibirá na 1 linha de registro
--SELECT StoreName FROM DimStore WHERE EmployeeCount = '325' -- 2º Opção exibirá uma linha de registro com a resposta

--c.Quantos funcionários tem a loja com menos funcionários?

--SELECT MIN (EmployeeCount) AS 'Menor Qtd Funcionários' FROM DimStore

--d.Qual é o nome dessa loja?

--SELECT TOP (1) StoreName AS 'Nome da Loja', EmployeeCount AS 'Menor Qtd Funcionários' FROM DimStore WHERE EmployeeCount IS NOT NULL ORDER BY EmployeeCount --1º Opção está na 1 linha de registro
--SELECT StoreName FROM DimStore WHERE EmployeeCount = '7' --2º Opção exibirá uma linha de registro com a resposta

---------------------------------------------------------------------------------------------------------------------

-- Ex 4: A área de RH está com uma nova ação para a empresa, e para isso precisa saber a quantidade total de funcionários do sexo Masculino e do sexo Feminino.

--a.Descubra essas duas informações utilizando o SQL.

--SELECT COUNT (Gender) AS 'Qtd Feminino' FROM DimEmployee WHERE Gender = 'F' --> Ambos exibem a quantidade total de linhas de registro que estejam preenchidas com seus respectivos gêneros
--SELECT COUNT (Gender) AS 'Qtd Masculino' FROM DimEmployee WHERE Gender = 'M'

--b.O funcionário e a funcionária mais antigos receberão uma homenagem. Descubra as seguintes informações de cada um deles: Nome, E-mail, Data de Contratação.

--SELECT MIN (HireDate) AS 'Data Contratação' FROM DimEmployee WHERE Gender = 'M' 
--SELECT MIN (HireDate) AS 'Data Contratação' FROM DimEmployee WHERE Gender = 'F' 

--SELECT FirstName AS 'Primeiro Nome', LastName AS 'Segundo Nome', EmailAddress AS 'E-mail', Gender AS 'Gênero', HireDate AS 'Data Contratação', EndDate AS 'Ativo desde' FROM DimEmployee ORDER BY HireDate ASC


---------------------------------------------------------------------------------------------------------------------


--Ex 5: Agora você precisa fazer uma análise dos produtos. Será necessário descobrir as seguintes informações:

--a.Quantidade distinta de cores de produtos.

--SELECT COUNT (DISTINCT ColorName) AS 'Cores' FROM DimProduct

--SELECT DISTINCT TOP (17) ColorName FROM DimProduct --> Comprova os nomes das cores

--b.Quantidade distinta de marcas

--SELECT COUNT (DISTINCT BrandName) AS 'Marcas' FROM DimProduct
--SELECT DISTINCT TOP (11) BrandName FROM DimProduct --> Comprova os nomes das marcas

--c.Quantidade distinta de classes de produto

--SELECT COUNT (DISTINCT ClassName) AS 'Classe' FROM DimProduct
--SELECT DISTINCT TOP (3) ClassName FROM DimProduct --> Comprova os nomes das classes

--Para simplificar, você pode fazer isso em uma mesma consulta

--SELECT COUNT (DISTINCT BrandName) AS 'Marcas' ,
--COUNT (DISTINCT ClassName) AS 'Classe',
--COUNT (DISTINCT ColorName) AS 'Cor'
--FROM DimProduct



