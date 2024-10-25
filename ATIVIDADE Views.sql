--**Objetivo**: Encontrar uma situação problema dentro do seu projeto e resolver utilizando **Views**, **declaração de variáveis** e **funções condicionais** no SQL. Ao final, você deverá subir as queries no repositório do projeto.

--### Instruções:

--1. **Identifique uma situação problema**: Analise o cenário do seu projeto e encontre uma necessidade específica que pode ser resolvida com o uso de **Views** e **variáveis**.
--    - **Exemplos de situação problema**:
--        - Necessidade de gerar relatórios frequentes ou resumos de dados.
--        - Requerimento de realizar cálculos complexos que dependem de condições específicas (ex.: calcular descontos, aplicar regras de negócio).


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


--2. **Crie uma View**: Crie uma **View** para organizar os dados que precisam ser consultados frequentemente, otimizando o acesso à informação.
--    - Exemplo: Criar uma View que agrupe as vendas por cliente, produtos mais vendidos, etc.


CREATE VIEW ProdutosMaisVendidos AS
SELECT 
    Produto.Nome_Produto AS NomeProduto, 
    SUM(Item_Pedido.quantidade) AS TotalVendido, 
    SUM(Item_Pedido.quantidade * produto.preco) AS TotalReceita
FROM 
    Item_Pedido
INNER JOIN 
    Produto ON Item_Pedido.id_produto = Produto.id_produto -- Verifique se o nome da coluna é 'produto_id'
INNER JOIN 
    Pedido ON Item_Pedido.id_pedido = Pedido.id_pedido -- Verifique se o nome da coluna é 'pedido_id'
GROUP BY 
    Produto.Nome_Produto
	
	select * from ProdutosMaisVendidos
	ORDER BY TotalVendido DESC



--3. **Utilize variáveis e funções condicionais**:


--    - Declare **variáveis** no SQL para armazenar valores temporários (ex.: valores de entrada como data, ID de cliente, etc.).


DECLARE @ValorTotalPedido DECIMAL(10, 2);
DECLARE @Desconto DECIMAL(10, 2);


--    - Use **funções condicionais** como `CASE` para aplicar diferentes regras de negócio dentro das consultas.
--    - Exemplo: Declarar uma variável que armazena o valor total de um pedido e usar um `CASE` para aplicar um desconto condicionalmente, dependendo do valor.


SELECT 
    Pedido.id_pedido, 
    Pedido.data_pedido, 
    SUM(Item_Pedido.quantidade * Produto.preco) AS ValorTotal,
    
    -- Aplicação de desconto usando CASE
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
