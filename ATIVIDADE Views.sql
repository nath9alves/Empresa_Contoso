--**Objetivo**: Encontrar uma situa��o problema dentro do seu projeto e resolver utilizando **Views**, **declara��o de vari�veis** e **fun��es condicionais** no SQL. Ao final, voc� dever� subir as queries no reposit�rio do projeto.

--### Instru��es:

--1. **Identifique uma situa��o problema**: Analise o cen�rio do seu projeto e encontre uma necessidade espec�fica que pode ser resolvida com o uso de **Views** e **vari�veis**.
--    - **Exemplos de situa��o problema**:
--        - Necessidade de gerar relat�rios frequentes ou resumos de dados.
--        - Requerimento de realizar c�lculos complexos que dependem de condi��es espec�ficas (ex.: calcular descontos, aplicar regras de neg�cio).


-- Cria uma View para mostrar o total de vendas por franquia

	CREATE VIEW VendasPorFranquia AS
SELECT 
    Franquia.Nome_Franquia AS NomeFranquia, 
    Produto.Nome_Produto AS NomeProduto, 
    SUM(Item_Pedido.Quantidade) AS TotalVendido, 
    SUM(Item_Pedido.Quantidade * Produto.Preco) AS TotalReceita
FROM 
    Item_Pedido
INNER JOIN 
    Pedido ON Item_Pedido.id_pedido = Pedido.id_pedido
INNER JOIN 
    Franquia ON Pedido.id_franquia = franquia.id_franquia eto
INNER JOIN 
    Produto ON Item_Pedido.id_produto = Produto.id_produto 
GROUP BY 
    Franquia.Nome_Franquia, Produto.Nome_Produto;


--2. **Crie uma View**: Crie uma **View** para organizar os dados que precisam ser consultados frequentemente, otimizando o acesso � informa��o.
--    - Exemplo: Criar uma View que agrupe as vendas por cliente, produtos mais vendidos, etc.


CREATE VIEW ProdutosMaisVendidos AS
SELECT 
    Produto.Nome_Produto AS NomeProduto, 
    SUM(Item_Pedido.quantidade) AS TotalVendido, 
    SUM(Item_Pedido.quantidade * produto.preco) AS TotalReceita
FROM 
    Item_Pedido
INNER JOIN 
    Produto ON Item_Pedido.id_produto = Produto.id_produto -- Verifique se o nome da coluna � 'produto_id'
INNER JOIN 
    Pedido ON Item_Pedido.id_pedido = Pedido.id_pedido -- Verifique se o nome da coluna � 'pedido_id'
GROUP BY 
    Produto.Nome_Produto
	
	select * from ProdutosMaisVendidos
	ORDER BY TotalVendido DESC



--3. **Utilize vari�veis e fun��es condicionais**:


--    - Declare **vari�veis** no SQL para armazenar valores tempor�rios (ex.: valores de entrada como data, ID de cliente, etc.).


DECLARE @ValorTotalPedido DECIMAL(10, 2);
DECLARE @Desconto DECIMAL(10, 2);


--    - Use **fun��es condicionais** como `CASE` para aplicar diferentes regras de neg�cio dentro das consultas.
--    - Exemplo: Declarar uma vari�vel que armazena o valor total de um pedido e usar um `CASE` para aplicar um desconto condicionalmente, dependendo do valor.


SELECT 
    Pedido.id_pedido, 
    Pedido.data_pedido, 
    SUM(Item_Pedido.quantidade * Produto.preco) AS ValorTotal,
    
    -- Aplica��o de desconto usando CASE
    CASE 
        WHEN SUM(Item_Pedido.quantidade * Produto.preco) > 1000 THEN SUM(Item_Pedido.quantidade * Produto.preco) * 0.15 -- 15% de desconto
        WHEN SUM(Item_Pedido.quantidade * Produto.preco) BETWEEN 500 AND 1000 THEN SUM(Item_Pedido.quantidade * Produto.preco) * 0.10 -- 10% de desconto
        ELSE 0 -- Sem desconto
    END AS Desconto,
    
    -- Valor final com desconto aplicado
    SUM(Item_Pedido.quantidade * Produto.preco) - 
    CASE 
        WHEN SUM(Item_Pedido.quantidade * Produto.preco) > 1000 THEN SUM(Item_Pedido.quantidade * Produto.preco) * 0.15
        WHEN SUM(Item_Pedido.quantidade * Produto.preco) BETWEEN 500 AND 1000 THEN SUM(Item_Pedido.quantidade * Produto.preco) * 0.10
        ELSE 0 
    END AS ValorFinal
FROM 
    Pedido
INNER JOIN 
    Item_Pedido ON Pedido.id_pedido = Item_Pedido.id_pedido
INNER JOIN 
    Produto ON Item_Pedido.id_produto = Produto.id_produto
GROUP BY 
    Pedido.id_pedido, Pedido.data_pedido
ORDER BY 
    Pedido.data_pedido DESC;
