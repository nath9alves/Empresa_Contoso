

--SELECT TOP(100) * FROM FactSales ORDER BY SalesAmount DESC -- > Ex 1 = OK

----------------------------------------------------------------------------------------------------------------------------

--SELECT TOP(10) ProductName, UnitPrice, Weight, AvailableForSaleDate FROM DimProduct --> Ex 2 =  
--ORDER BY UnitPrice DESC, Weight DESC, AvailableForSaleDate ASC 

                             
--SELECT TOP(10) * FROM DimProduct ORDER BY UnitPrice DESC, "Weight" DESC
--SELECT TOP(10) * FROM DimProduct                                                   --> Ambas Consultas OK
--ORDER BY UnitPrice DESC, Weight DESC, AvailableForSaleDate ASC


-----------------------------------------------------------------------------------------------------------------------------

--SELECT ProductName AS Produto, Weight AS Peso FROM DimProduct WHERE Weight > 100 ORDER BY Weight DESC --> Ex 3 = Obs: > significa maior que

-----------------------------------------------------------------------------------------------------------------------------

--SELECT StoreName AS Loja, OpenDate AS Abertura, EmployeeCount AS Funcionários, Status AS Ativa 
--FROM DimStore WHERE StoreType = 'Store' AND Status = 'On' --> Ex 4 = OK Obs: É Possível filtrar apenas com 'nome' (aspas)

-----------------------------------------------------------------------------------------------------------------------------

--SELECT * FROM DimProduct
--WHERE BrandName = 'Litware' AND AvailableForSaleDate = '15/03/2009' --> Ex 5 = OBS: A data pode ser informada no formato BR

------------------------------------------------------------------------------------------------------------------------------

--SELECT * FROM DimStore WHERE "Status" LIKE '%Off%' --> Ex 6 = AMBOS OK
--SELECT * FROM DimStorE WHERE CloseDate IS NOT NULL

------------------------------------------------------------------------------------------------------------------------------
--SELECT EmployeeCount, StoreName       --> Ex 7
--FROM DimStore
--WHERE EmployeeCount BETWEEN 1 AND 20
--ORDER BY EmployeeCount

--SELECT EmployeeCount, StoreName 
--FROM DimStore
--WHERE EmployeeCount BETWEEN 21 AND 50
--ORDER BY EmployeeCount

--SELECT EmployeeCount, StoreName 
--FROM DimStore
--WHERE EmployeeCount >=51     --> OBS: >= significa maior ou igual a
--ORDER BY EmployeeCount

-------------------------------------------------------------------------------------------------------------------------------

--SELECT ProductKey, ProductName, UnitPrice FROM DimProduct WHERE ProductName LIKE '%LCD%' ORDER BY UnitPrice DESC --> Ex 8 = OK

--Ou a opção de ProductDescription

--SELECT * FROM DimProduct
--WHERE ProductDescription LIKE '%LCD%'

---------------------------------------------------------------------------------------------------------------------------------

--SELECT * FROM DimProduct
--WHERE ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink') AND BrandName IN ('Contoso', 'Litware', 'Fabrikam') -- Ex 9 = Ok

---------------------------------------------------------------------------------------------------------------------------------

--SELECT * FROM DimProduct
--WHERE BrandName = 'Contoso' AND ColorName = 'Silver' AND UnitPrice BETWEEN 10 AND 30 ORDER BY UnitPrice DESC -- Ex 10 = OK



