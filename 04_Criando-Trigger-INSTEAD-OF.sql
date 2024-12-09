-- M�DULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 06 - Criando uma Trigger para Controle de Permiss�o de Cadastro - INSTEAD OF (Parte 1)
Vamos ver agora a cria��o de uma Trigger DML do tipo INSTEAD OF. Este tipo de trigger efetua alguma a��o no lugar do comando DML especificado, toda vez que uma determinada condi��o for atendida.

No nosso exemplo, vamos imaginar que queremos permitir � inser��o de dados na tabela dCliente apenas de segunda � sexta. Se for s�bado ou domingo, nossa trigger deve gerar um erro, apresent�-lo na tela e n�o permitir a inser��o dos novos dados. Por�m, se for dia �til, a trigger deve permitir a inser��o dos novos dados na tabela dCliente normalmente.

Vamos ao passo a passo:
- 1. Iniciamos a noss trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que far� a trigger ser disparada quando for alterada. No caso, ser� a dCliente;
- 3. Determinamos se a trigger ser� do tipo AFTER ou INSTEAD OF (no caso, ser� do tipo INSTEAD OF, pois queremos que ela informe um erro no lugar do INSERT, n�o permitindo que ele seja efetuado, caso o usu�rio tente inserir novos dados na tabela dCliente no final de semana;
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, executamos um IF para verificar se o dia de hoje (GETDATE()) � s�bado ou domingo;
- 6. Se for, utilizamos a instru��o RAISERROR para exibir um erro na tela com a seguinte mensagem: 'O cadastro de clientes s� pode ser feito de segunda � sexta feira, e efetuamos um ROLLBACK para que o INSERT efetuado seja desfeito;
- 7. Se n�o for final de semana, efetuamos o INSERT desejado na tabela dCliente. Observe que os dados a serem inseridos na tabela dCliente ser�o extra�dos da tabela INSERTED, que armazenou temporariamente o registo inclu�do pelo usu�rio;
- 8. Finalizamos o bloco de comando com o comando END.

- Crie uma Trigger que seja disparada sempre INSTEAD OF de um INSERT, UPDATE e DELETE que for executado na tabela dCliente. O que deve acontecer: se o dia de cadastro for s�bado ou domingo, n�o pode deixar alterar pois est� fora do hor�rio comercial. */

-- Se for s�bado ou domingo retorne o erro.
CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('s�bado', 'domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes s� pode ser feito de segunda � sexta', 1, 1) -- Emitir um erro for�ado
		ROLLBACK
	END
END

-- Testemos agora a nossa trigger tgControleRegistros, tentando efetuar o seguinte INSERT na tabela dCliente; Se for final de semana (s�bado ou domingo), repare que a trigger disparada retornar� o erro configurado, conforme esperado; Por�m, se caso hoje n�o seja s�bado ou domingo, ser� executado o INSERT e os dados ser�o normalmente inseridos na tabela.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Pedro Albuquerque', 'M', '13/02/2003', '111.543.189-00')


-- Se for domingo, retorne o erro
CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes s� pode ser feito de segunda � sexta', 1, 1) -- Emitir um erro for�ado
		ROLLBACK
	END
END

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Pedro Albuquerque', 'M', '13/02/2003', '111.543.189-00')

SELECT * FROM dCliente
-- Obs.: N�o ocorreu um erro pois 'hoje' � s�bado por�m, n�o foi inserido nenhuma linha pois em nosso c�digo n�o foi informado o que tem que ocorrer se o dia for diferente de domingo.