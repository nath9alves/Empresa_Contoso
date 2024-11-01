--### Exercícios

--1. **Exibir números de 1 a 20:** Crie um loop `WHILE` para exibir os números de 1 a 20 no console.

DECLARE @Contador INT = 1 -- > Declarando a ordem "Contador" como dado INTEIRO, no valor de 1
WHILE @Contador <= 20 -- > Onde sua CONDIÇÃO será DECLARADA até o valor 20
BEGIN -- > iniciando por:
PRINT 'Contador: ' + CAST(@Contador AS VARCHAR) -- > MENSAGEM EM TELA "Contador: 1 até 20", onde @Contador terá seu tipo alterado para VARCHAR
SET @Contador = @Contador + 1 -- > SETAR o "Contador" para obter 1 a mais no resultado final, onde erá finalizado de acordo com o comando WHILE
END -- > FIM


--2. **Diminuir preços:** Usando um loop, diminua o preço de cada produto em 5% e exiba o novo valor para cada produto.

--SELECT * FROM Produtos

--DECLARE @Preco DECIMAL (10,2) = 50.00
--DECLARE @Limite DECIMAL (10,2) = 1.00
--WHILE @Preco > @Limite 
--BEGIN
--SET @Preco = @Preco * 0.95
--PRINT 'Resultado -5% ' + CAST(@Preco AS VARCHAR (10))
--END

DECLARE @Id INT = 1
DECLARE @Preco DECIMAL (10,2)
WHILE @Id <= (SELECT MAX(ProdutoID) FROM Produtos)
BEGIN
SET @Preco = (SELECT Preco FROM Produtos WHERE ProdutoID = @Id)
UPDATE Produtos
SET Preco = @Preco * 0.95
WHERE ProdutoID = @Id
SET @Id = @Id + 1
END


--3. **Inserir dados automaticamente:** Crie um loop para inserir 10 novos produtos na tabela `Produtos`. Cada produto 
--deve ter um nome como “Produto X” e uma quantidade inicial de 20.

DECLARE @Contador INT = 1
DECLARE @NomeProduto VARCHAR (50)
WHILE @Contador <= 10
BEGIN
SET @NomeProduto = 'Produto ' + CAST(@Contador AS VARCHAR)
INSERT INTO Produtos (Nome, Quantidade, Preco)
VALUES (@NomeProduto, 20, 10.00)
SET @Contador = @Contador + 1
END


--4. **Contar produtos com quantidade acima de 50:** Use um loop para verificar quantos produtos têm uma quantidade maior 
--que 50, exibindo uma mensagem para cada produto que atende ao critério.


DECLARE @id INT = 1
DECLARE @quantidade INT
DECLARE @contador INT = 0
WHILE @id <= (SELECT MAX(ProdutoID) FROM Produtos)
BEGIN
SET @quantidade = (SELECT Quantidade FROM Produtos WHERE ProdutoID = @id)
IF @quantidade > 50
BEGIN
SET @contador = @contador + 1
PRINT 'ProdutoID ' + CAST(@id AS VARCHAR) + 'tem quantidade maior que 50: ' + CAST(@quantidade AS VARCHAR)
END
SET @id = @id + 1
END
PRINT 'Total de produtos com quantidade acima de 50: ' + CAST(@contador AS VARCHAR)


--5. **Cálculo acumulativo de valor em estoque:** Calcule o valor total em estoque de todos os produtos, multiplicando a 
--`Quantidade` pelo `Preco` e somando para cada produto usando um loop. Exiba o valor total após o loop.

DECLARE @id INT = 1; -- Declara a variável @id e define seu valor inicial como 1, usada para iterar sobre os produtos
DECLARE @quantidade INT; -- Declara a variável @quantidade para armazenar a quantidade de cada produto
DECLARE @preco DECIMAL(10, 2); -- Declara a variável @preco para armazenar o preço de cada produto
DECLARE @valorTotal DECIMAL(18, 2) = 0; -- Declara a variável @valorTotal e define seu valor inicial como 0, usada para acumular o valor total em estoque

WHILE @id <= (SELECT MAX(ProdutoID) FROM Produtos) -- O loop WHILE continua até que @id ultrapasse o maior ProdutoID
BEGIN
    SET @quantidade = (SELECT Quantidade FROM Produtos WHERE ProdutoID = @id); -- Armazena a quantidade do produto com ProdutoID = @id
    SET @preco = (SELECT Preco FROM Produtos WHERE ProdutoID = @id); -- Armazena o preço do produto com ProdutoID = @id

    SET @valorTotal = @valorTotal + (@quantidade * @preco); -- Calcula o valor do estoque para o produto atual e adiciona ao valor total acumulado

    -- Exibe o valor acumulado em estoque até o momento para cada produto
    PRINT 'Valor acumulado após ProdutoID ' + CAST(@id AS VARCHAR) + ': ' + CAST(@valorTotal AS VARCHAR);

    SET @id = @id + 1; -- Incrementa @id para o próximo produto
END;