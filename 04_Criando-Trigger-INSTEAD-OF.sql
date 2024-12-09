-- MÓDULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 06 - Criando uma Trigger para Controle de Permissão de Cadastro - INSTEAD OF (Parte 1)
Vamos ver agora a criação de uma Trigger DML do tipo INSTEAD OF. Este tipo de trigger efetua alguma ação no lugar do comando DML especificado, toda vez que uma determinada condição for atendida.

No nosso exemplo, vamos imaginar que queremos permitir à inserção de dados na tabela dCliente apenas de segunda à sexta. Se for sábado ou domingo, nossa trigger deve gerar um erro, apresentá-lo na tela e não permitir a inserção dos novos dados. Porém, se for dia útil, a trigger deve permitir a inserção dos novos dados na tabela dCliente normalmente.

Vamos ao passo a passo:
- 1. Iniciamos a noss trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que fará a trigger ser disparada quando for alterada. No caso, será a dCliente;
- 3. Determinamos se a trigger será do tipo AFTER ou INSTEAD OF (no caso, será do tipo INSTEAD OF, pois queremos que ela informe um erro no lugar do INSERT, não permitindo que ele seja efetuado, caso o usuário tente inserir novos dados na tabela dCliente no final de semana;
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, executamos um IF para verificar se o dia de hoje (GETDATE()) é sábado ou domingo;
- 6. Se for, utilizamos a instrução RAISERROR para exibir um erro na tela com a seguinte mensagem: 'O cadastro de clientes só pode ser feito de segunda à sexta feira, e efetuamos um ROLLBACK para que o INSERT efetuado seja desfeito;
- 7. Se não for final de semana, efetuamos o INSERT desejado na tabela dCliente. Observe que os dados a serem inseridos na tabela dCliente serão extraídos da tabela INSERTED, que armazenou temporariamente o registo incluído pelo usuário;
- 8. Finalizamos o bloco de comando com o comando END.

- Crie uma Trigger que seja disparada sempre INSTEAD OF de um INSERT, UPDATE e DELETE que for executado na tabela dCliente. O que deve acontecer: se o dia de cadastro for sábado ou domingo, não pode deixar alterar pois está fora do horário comercial. */

-- Se for sábado ou domingo retorne o erro.
CREATE OR ALTER TRIGGER tgControleRegistros
ON dCliente
INSTEAD OF INSERT
AS
BEGIN

	IF FORMAT(GETDATE(), 'dddd') IN ('sábado', 'domingo') -- Pode usar OR ou IN
	BEGIN

		RAISERROR('O cadastro de clientes só pode ser feito de segunda à sexta', 1, 1) -- Emitir um erro forçado
		ROLLBACK
	END
END

-- Testemos agora a nossa trigger tgControleRegistros, tentando efetuar o seguinte INSERT na tabela dCliente; Se for final de semana (sábado ou domingo), repare que a trigger disparada retornará o erro configurado, conforme esperado; Porém, se caso hoje não seja sábado ou domingo, será executado o INSERT e os dados serão normalmente inseridos na tabela.

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

		RAISERROR('O cadastro de clientes só pode ser feito de segunda à sexta', 1, 1) -- Emitir um erro forçado
		ROLLBACK
	END
END

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Pedro Albuquerque', 'M', '13/02/2003', '111.543.189-00')

SELECT * FROM dCliente
-- Obs.: Não ocorreu um erro pois 'hoje' é sábado porém, não foi inserido nenhuma linha pois em nosso código não foi informado o que tem que ocorrer se o dia for diferente de domingo.