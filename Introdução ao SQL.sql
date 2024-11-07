--EX 1
--Você é responsável por controlar os dados de clientes e de produtos da sua empresa. O que você precisará fazer é confirmar se:

--a. Existem 2.517 produtos cadastrados na base e, se não tiver, você
--deverá reportar ao seu gestor para saber se existe alguma defasagem
--no controle dos produtos. A quantidade de produtos
--Até o mês passado, a empresa tinha um total de 19.500 clientes na
--base de controle. Verifique se esse número aumentou ou
--reduziu.

SELECT ProductName
FROM DimProduct

--R: 2517 linhas de registro (ok)

SELECT CustomerKey
FROM DimCustomer

--R: Contém 18869 linhas

-------------------------------------------------------

--EX 2

--Você trabalha no setor de marketing da empresa Contoso e acaba de ter
--uma ideia de oferecer descontos especiais para os clientes no dia de
--seus aniversários. Para isso, você vai precisar listar todos os clientes e as
--suas respectivas datas de nascimento, além de um contato.

--a.Selecione as colunas: CustomerKey, FirstName, EmailAddress,
--BirthDate da tabela dimCustomer.

--b.Renomeie as colunas dessa tabela usando o alias (comando AS).

SELECT 

CustomerKey AS ID Cliente, 
FirstName AS Primeiro_Nome,
EmailAddress AS Email,
BirthDate AS Data_Nascimento
FROM DimCustomer

--R: Colunas Nomeadas

-------------------------------------------------------

--EX 3

--A Contoso está comemorando aniversário de inauguração de 10 anos e pretende
--fazer uma ação de premiação para os clientes. A empresa quer presentear os
--primeiros clientes desde a inauguração.
--Você foi alocado para levar adiante essa ação. Para isso, você terá que fazer
--o seguinte:
  
--a.A Contoso decidiu presentear os primeiros 100 clientes da história com um bvale
--compras de R$ 10.000. Utilize um comando em SQL para retornar uma tabela
--com os primeiros 100 primeiros clientes da tabela dimCustomer (selecione todas as
--colunas).

SELECT TOP(100) CustomerKey
FROM DimCustomer

SELECT TOP(100) PERCENT CustomerKey
FROM DimCustomer

SELECT TOP(100)
FirstName AS "Nome",
EmailAddress AS Email,
BirthDate AS Data_Nascimento


--R: Filtrado os 100 primeiros clientes

--------------------------------------------------------

--EX 4

--A empresa Contoso precisa fazer contato com os fornecedores de
--produtos para repor o estoque. Você é da área de compras e precisa
--descobrir quem são esses fornecedores.
--Utilize um comando em SQL para retornar apenas os nomes dos
--fornecedores na tabela dimProduct e renomeie essa nova coluna da
--tabela.

SELECT DISTINCT Manufasturer AS "Produtor" < ----
FROM DimProduct

 SELECT Manufacturer FROM DimProduct --> Fabricante

SELECT VendorName
FROM DimMachine

--R: A resposta está na tabela DimMachine

-------------------------------------------------------

--EX 5

--O seu trabalho de investigação não para. Você precisa descobrir se
--existe algum produto registrado na base de produtos que ainda não
--tenha sido vendido. Tente chegar nessa informação.
--Obs: caso tenha algum produto que ainda não tenha sido vendido, você
--não precisa descobrir qual é, é suficiente saber se teve ou não algum
--produto que ainda não foi vendido. Existe 1 produto que está
--registrado na tabela DimProduct e que não foi vendido.

SELECT Vendorname AS Fornecedor
FROM DimMachine

SELECT DISTINCT ProductKey FROM FactSales < ----

SELECT DISTINCT "Status" 
FROM DimProduct

--R: Existe sim produtos vendidos















