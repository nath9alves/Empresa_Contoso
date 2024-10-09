--Declare 4 variáveis inteiras. Atribua os seguintes valores a elas:

--valor1 = 10
--valor2 = 5
--valor3 = 34
--valor4 = 7


--a)Crie uma nova variável para armazenar o resultado da soma entre
--valor1 e valor2. Chame essa variável de soma.

DECLARE @Resultado VARCHAR(4)
SET @Resultado = '15'
SELECT @Resultado AS Soma

--b)Crie uma nova variável para armazenar o resultado da subtração entre valor3 e valor 4. Chame essa variável de subtracao.

DECLARE @Resultado VARCHAR(4)
SET @Resultado = '27'
SELECT @Resultado AS 'Subtração'

--c)Crie uma nova variável para armazenar o resultado da multiplicação entre o valor 1 e o valor4. Chame essa variável de multiplicacao.

DECLARE @Resultado VARCHAR(4)
SET @Resultado = '7'
SELECT @Resultado AS 'Multiplicação'

--d)Crie uma nova variável para armazenar o resultado da divisão do valor3 pelo valor4. Chame essa variável de divisao. Obs: O resultado deverá estar em decimal, e não em inteiro.
--Arredonde o resultado da letra d) para 2 casas decimais.

DECLARE @Resultado FLOAT
SET @Resultado = '4.85'
SELECT @Resultado AS 'DIVISÃO'

-------- > Resposta Alternativa Para Todas as questões acima <--------

DECLARE @Valor1 FLOAT
DECLARE @Valor2 FLOAT
DECLARE @Valor3 FLOAT
DECLARE @Valor4 FLOAT
DECLARE @ValorDiv FLOAT
DECLARE @ValorSoma FLOAT
DECLARE @ValorSub FLOAT
DECLARE @ValorMult FLOAT

SET @Valor1 = 10.3
SET @Valor2 = 5
SET @Valor3 = 34
SET @Valor4 = 7

SET @ValorDiv = @Valor3 / @Valor4
SET @ValorSoma = @Valor1 + @Valor2
SET @ValorSub = @Valor3 - @Valor4
SET @ValorMult = @Valor1 * @Valor4

SELECT @ValorDiv AS DIVISÃO
SELECT @ValorSoma AS SOMA
SELECT @ValorSub AS SUBTRAÇÃO
SELECT @ValorMult AS MULTIPLICAÇÃO


------------------------------------------------------------------------------------------------------------------------------------------//


-- Questão 2

--Para cada declaração das variáveis abaixo, atenção em relação ao tipo de dado que deverá ser especificado.


--a.Declare uma variável chamada ‘produto’ e atribua o valor de ‘Celular’.

DECLARE @Produto VARCHAR
SET @Produto = '1'
SELECT FORMAT (1, 'Celular') AS 'Produto'

--b.Declare uma variável chamada ‘quantidade’ e atribua o valor de 12.

DECLARE @Quantidade VARCHAR
SET @Quantidade = '2'
SELECT FORMAT (2, '12') AS 'Quantidade'


--c.Declare uma variável chamada ‘preco’ e atribua o valor 9.99.

DECLARE @Preco DECIMAL (5,2)
SET @Preco = 9.99
SELECT @Preco AS Preco


--d.Declare uma variável chamada ‘faturamento’ e atribua o resultado da multiplicação entre ‘quantidade’ e ‘preco’.

DECLARE @Faturamento DECIMAL (5,2)
SET @Faturamento = 119.88
SELECT @Faturamento AS Faturamento

--e.Visualize o resultado dessas 4 variáveis em uma única consulta, por meio do SELECT.

DECLARE @Produto VARCHAR
DECLARE @Quantidade DECIMAL
DECLARE @Preco DECIMAL (5,2)
DECLARE @Faturamento DECIMAL (5,2)

SET @Produto = 1
SET @Quantidade = 12
SET @Preco = 9.99
SET @Faturamento = 119.88

SELECT @Produto AS Produto,
@Quantidade AS Quantidade,
@Preco AS Preço,
@Faturamento AS Faturamento


-------- > Resposta Alternativa Para Todas as questões acima <--------


DECLARE @Produto VARCHAR (30) = 'Celular'
DECLARE @Quantidade int = 12
DECLARE @Preco FLOAT = 9.99
DECLARE @Faturamento FLOAT = @Quantidade * @Preco 


SELECT @Produto AS Produto,
@Quantidade AS Quantidade,
@Preco AS Preço,
@Faturamento AS Faturamento


------------------------------------------------------------------------------------------------------------------------------------------//


--Questão 3


--Você é responsável por gerenciar um banco de dados onde são recebidos dados externos de usuários. Em resumo, esses dados são:

--- Nome do usuário
--- Data de nascimento
--- Quantidade de pets que aquele usuário possui

--Você precisará criar um código em SQL capaz de juntar as informações fornecidas por este usuário. Para simular estes dados, crie 3 variáveis,
--chamadas: nome, data_nascimento e num_pets. Você deverá armazenar os valores ‘André’, ‘10/02/1998’ e 2, respectivamente.

--Dica: você precisará utilizar as funções CAST e FORMAT para chegar no
--resultado.


DECLARE @Nome_usuario VARCHAR (50)
DECLARE @Data_Nascimento DATE
DECLARE @Qtd_Pets INT

SET @Nome_usuario = 'André'
SET @Data_Nascimento = '1998/02/10'
SET @Qtd_Pets = 2

SELECT @Nome_usuario AS Nome,
FORMAT (@Data_Nascimento, 'dd/MM/yyyy') AS Data_Nascimento,
CAST (@Qtd_Pets AS VARCHAR(10)) AS Quantidade_Pets


-------- > Resposta Alternativa Para a Questão Acima <--------


DECLARE @nome VARCHAR (30),
@nascimento DATETIME,
@pets INT

SET @nome = 'André'
SET @nascimento = '10/02/1998'
SET @pets = 2

SELECT 'Meu nome é ' + @nome + ', nasci em ' + FORMAT (@nascimento, 'dd/MM/yyyy') + ' e tenho ' + FORMAT (@pets, '0') + ' pets.'


------------------------------------------------------------------------------------------------------------------------------------------//


--Questão 4

--Você acabou de ser promovido e o seu papel será realizar um controle de qualidade sobre as lojas da empresa.

--A primeira informação que é passada a você é que o ano de 2008 foi bem complicado para a empresa, pois foi quando duas das principais lojas
--fecharam. O seu primeiro desafio é descobrir o nome dessas lojas que fecharam no ano de 2008, para que você possa entender o motivo e mapear 
--planos de ação para evitar que outras lojas importantes tomem o mesmo caminho.

--O seu resultado deverá estar estruturado em uma frase, com a seguinte estrutura:

--‘As lojas fechadas no ano de 2008 foram: ’ + nome_das_lojas
--Obs: utilize o comando PRINT (e não o SELECT!) para mostrar o resultado.


DECLARE @nome_loja VARCHAR(100)
SET @nome_loja = ''

SELECT @nome_loja = @nome_loja + Storename + ', '
FROM DimStore
WHERE FORMAT (closedate, 'yyy') = 2008

PRINT 'As lojas fechadas no ano de 2008 foram: ' + @nome_loja


------------------------------------------------------------------------------------------------------------------------------------------//


--Questão 05


--Você precisa criar uma consulta para mostrar a lista de produtos da tabela DimProduct para uma subcategoria específica: ‘Lamps’.

--Utilize o conceito de variáveis para chegar neste resultado.


SELECT * FROM DimProductSubcategory

DECLARE @id_subcategoria INT
DECLARE @subcategoria VARCHAR(100)

SET @subcategoria = 'Rádio'
SET @id_subcategoria = (SELECT ProductSubcategoryKey FROM DimProductSubcategory WHERE ProductSubcategoryName = @subcategoria)

SELECT * FROM DimProduct

WHERE ProductSubcategoryKey = @id_subcategoria