--EX 1

--SELECT ProductName
--FROM DimProduct

--R: 2517 linhas de registro (ok)

--SELECT CustomerKey
--FROM DimCustomer

--R: Contém 18869 linhas
-------------------------------------------------------

--EX 2

--SELECT 

--CustomerKey AS ID Cliente, 
--FirstName AS Primeiro_Nome,
--EmailAddress AS Email,
--BirthDate AS Data_Nascimento

--FROM DimCustomer

--R: Colunas Nomeadas
-------------------------------------------------------

--EX 3

--SELECT TOP(100) CustomerKey
--FROM DimCustomer

--SELECT TOP(100) PERCENT CustomerKey
--FROM DimCustomer

--SELECT TOP(100)
--FirstName AS "Nome",
--EmailAddress AS Email,
--BirthDate AS Data_Nascimento


--R: Filtrado os 100 primeiros clientes
--------------------------------------------------------

--EX 4

--SELECT DISTINCT Manufasturer AS "Produtor" < ----
--FROM DimProduct

-- SELECT Manufacturer FROM DimProduct --> Fabricante

--SELECT VendorName
--FROM DimMachine

--R: A resposta está na tabela DimMachine
-------------------------------------------------------

--EX 5

--SELECT Vendorname AS Fornecedor
--FROM DimMachine

--SELECT DISTINCT ProductKey FROM FactSales < ----

--SELECT DISTINCT "Status" 
--FROM DimProduct

--R: Existe sim produtos vendidos















