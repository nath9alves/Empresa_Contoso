
-- Passo 1: Criação do Banco de Dados
CREATE DATABASE FunctionsDB;
GO
USE FunctionsDB;

-- Passo 2: Criação das Tabelas
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nome NVARCHAR(100),
    Cidade NVARCHAR(50),
    DataNascimento DATE
);

CREATE TABLE Vendas (
    VendaID INT PRIMARY KEY,
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    DataVenda DATE,
    ValorTotal DECIMAL(10, 2)
);

-- Passo 3: Inserção de Dados
INSERT INTO Clientes VALUES
    (1, 'Alice', 'São Paulo', '1985-04-10'),
    (2, 'Bruno', 'Rio de Janeiro', '1990-07-22'),
    (3, 'Carlos', 'Belo Horizonte', '1980-01-15');

INSERT INTO Vendas VALUES
    (1, 1, '2024-01-10', 3500.00),
    (2, 2, '2024-01-15', 1500.00),
    (3, 3, '2024-01-20', 3000.00),
    (4, 1, '2024-02-01', 2000.00),
    (5, 2, '2024-02-10', 4000.00);

	
-- Criação da função para calcular idade
CREATE FUNCTION dbo.CalcularIdade (@DataNascimento DATE)
RETURNS INT
AS
BEGIN
    DECLARE @Idade INT;
    SET @Idade = DATEDIFF(YEAR, @DataNascimento, GETDATE());

    -- Ajuste da idade caso o aniversário não tenha ocorrido este ano
    IF (DATEADD(YEAR, @Idade, @DataNascimento) > GETDATE())
        SET @Idade = @Idade - 1;

    RETURN @Idade;
END;



SELECT Nome, dbo.CalcularIdade(DataNascimento) AS Idade FROM Clientes;



-- Criação da função para obter iniciais
CREATE FUNCTION dbo.ObterIniciais (@Nome NVARCHAR(100))
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @Iniciais NVARCHAR(1) = '';

    -- Loop para obter a primeira letra de cada palavra no nome
    DECLARE @i INT = 1;
    WHILE @i <= LEN(@Nome)
    BEGIN
        IF SUBSTRING(@Nome, @i, 1) LIKE '[A-Z]'
            SET @Iniciais = @Iniciais + SUBSTRING(@Nome, @i, 1);
        SET @i = @i + 1;
    END

    RETURN @Iniciais;
END;


SELECT Nome, dbo.ObterIniciais(Nome) AS Iniciais FROM Clientes;



-- Criação da função para calcular desconto
CREATE FUNCTION dbo.CalcularDesconto (@Valor DECIMAL(10, 2), @DescontoPercentual DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @Valor - (@Valor * @DescontoPercentual / 100);
END;



SELECT VendaID, ValorTotal, dbo.CalcularDesconto(ValorTotal, 10) AS ValorComDesconto FROM Vendas;



-- Criação da função para concatenar cidade e nome do cliente
CREATE FUNCTION dbo.CidadeCliente (@Cidade NVARCHAR(50), @Nome NVARCHAR(100))
RETURNS NVARCHAR(150)
AS
BEGIN
    RETURN @Cidade + ' - ' + @Nome;
END;



SELECT Nome, Cidade, dbo.CidadeCliente(Cidade, Nome) AS ClienteCidade FROM Clientes;



--### Exercício 1

--Use a função `CalcularIdade` para listar o nome de cada cliente e a idade atual.


SELECT * FROM Clientes
SELECT * FROM Vendas

SELECT Nome, dbo.CalcularIdade(DataNascimento) AS Idade
FROM Clientes;


--### Exercício 2

--Exiba o nome e as iniciais de cada cliente usando a função `ObterIniciais`.


SELECT Nome, dbo.ObterIniciais(Nome) AS Iniciais FROM Clientes


--### Exercício 3

--Liste as vendas e o valor total de cada uma com um desconto de 15% usando a função `CalcularDesconto`.


SELECT VendaID, ValorTotal, dbo.CalcularDesconto(ValorTotal, 10) AS Valor_Desconto FROM Vendas


--### Exercício 4

--Mostre o nome do cliente e a cidade concatenados usando a função `CidadeCliente`.


SELECT Nome, Cidade, dbo.CidadeCliente(Cidade, Nome) AS ClienteCidade FROM Clientes


--### Exercício 5

--Modifique a função `CalcularDesconto` para que ela retorne o valor zero se o desconto for maior que 50%.

select * from Clientes
select * from Vendas

ALTER FUNCTION CalcularDesconto (@Valor DECIMAL (10,2), @PorcentagemDesconto DECIMAL (5,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
DECLARE @ValorDesconto DECIMAL(10,2)
IF @PorcentagemDesconto > 50
BEGIN
SET @ValorDesconto = 0;
END
ELSE
BEGIN
SET @ValorDesconto = @Valor * (@PorcentagemDesconto / 100)
END
RETURN @ValorDesconto
END

SELECT * from clientes
select * from Vendas
 
SELECT VendaID, ValorTotal, dbo.CalcularDesconto(ValorTotal, 100) AS Valor_Desconto FROM Vendas

--**Exercício 6**

--Crie uma função chamada `CalcularDiferencaDias` que receba duas datas e retorne o número de dias entre elas. Use essa função para calcular quantos dias se passaram entre a data de nascimento do cliente e a data de venda.


CREATE FUNCTION dbo.CalcularDiferencaDias (@DataInicial DATE, @DataFinal DATE)
RETURNS INT
AS
BEGIN
RETURN DATEDIFF(DAY, @DataInicial, @DataFinal)
END

SELECT * FROM Clientes

SELECT Clientes.ClienteID,
Clientes.Nome,
Clientes.DataNascimento,
Vendas.DataVenda,
dbo.CalcularDiferencaDias (Clientes.DataNascimento, Vendas.DataVenda) AS Dias_Diferenca
FROM
Clientes
INNER JOIN
Vendas ON Clientes.ClienteID = Vendas.ClienteID


--**Exercício 7**

--Crie uma função chamada `ObterUltimoNome` que receba o nome completo de um cliente e retorne apenas o último nome. Em seguida, use essa função para mostrar o último nome de cada cliente na tabela `Clientes`.

USE ContosoRetailDW

CREATE FUNCTION ObterUltimoNome (@LastName NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @LastName
	END

SELECT 
    CustomerKey,
	FirstName,
	LastName,
    dbo.ObterUltimoNome(LastName) AS UltimoNome
FROM 
    DimCustomer

	select * from DimCustomer

--**Exercício 8**

--Crie uma função chamada `AplicarTaxa` que receba um valor e uma taxa percentual e retorne o valor com a taxa aplicada. Use essa função para calcular o valor total com uma taxa de 10% em cada venda.


USE FunctionsDB

CREATE FUNCTION AplicarTaxa (@Valor DECIMAL (10,2), @TaxaPercentual DECIMAL(5,2))
RETURNS DECIMAL(10,2)
AS 
BEGIN
DECLARE @ValorComTaxa DECIMAL(10,2)
SET @ValorComTaxa = @Valor + (@Valor * (@TaxaPercentual / 100))
RETURN @ValorComTaxa
END

SELECT
VendaID,
ValorTotal,
dbo.AplicarTaxa(ValorTotal, 10) AS ValorTotalComTaxa
FROM Vendas


--**Exercício 9**

--Crie uma função chamada `CalcularAnosDesdeData` que receba uma data e retorne quantos anos se passaram desde essa data até hoje. Use essa função para calcular há quantos anos cada cliente nasceu.

CREATE FUNCTION CalcularAnosDesdeData (@DataNascimento DATE)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(YEAR, @DataNascimento, GETDATE());
END;


SELECT 
    ClienteID,
    Nome,
    DataNascimento,
    dbo.CalcularAnosDesdeData(DataNascimento) AS AnosDesdeNascimento
FROM 
    Clientes


--**Exercício 10**

--Crie uma função chamada `PrimeiraLetraMaiuscula` que receba uma string e retorne a string com apenas a primeira letra em maiúscula e o restante em minúsculo. Use essa função para formatar o nome dos clientes na tabela `Clientes`.


CREATE FUNCTION PrimeiraLetraMaiuscula (@Nome NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN UPPER(LEFT(@Nome, 1)) + LOWER(SUBSTRING(@Nome, 2, LEN(@Nome) - 1));
END


SELECT 
    ClienteID,
    Nome,
    dbo.PrimeiraLetraMaiuscula(Nome) AS NomeFormatado
FROM 
    Clientes