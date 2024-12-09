-- M�DULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 05 - Identificando na Trigger o Evento DML Relacionado
Sabendo agora, como funcionam as tabelas INSERTED e DELETED, podemos finalmente personalizar as mensagens apresentadas na tela, de acordo com o comando DML utilizado, quando a tabela dCliente for alterada e a nossa trigger tgClienteAlterado disparada.

Relembrando, quando dispararmos o comando... ser� apresentado na tela a mensagem...
INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram exclu�dos da tabela!
*/

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

	IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
			PRINT 'Dados Foram Atualizados na Tabela'
	ELSE IF EXISTS (SELECT * FROM INSERTED)
            PRINT 'Dados Foram Inseridos na Tabela'
    ELSE IF EXISTS (SELECT * FROM DELETED)
            PRINT 'Dados Foram Excluidos na Tabela'

END

/* vamos entender o funcionamento;
- 1. Iniciamos a nossa trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que far� a trigger ser disparada toda vez que for alterada. No caso, ser� a dCliente;
- 3. Determinamos se a trigger ser� do tipo AFTER ou INSTEAD OF (no caso, ser� do tipo AFTER, pois queremos que ela dispare depois que uma altera��o for efetuada) e quais ser�o os comandos que a disparar�o quando forem executados. No caso, ser� depois dos tr�s comando DML: INSERT, UPDATE e DELETE	  
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, fazemos um IF EXISTS, para verificar se, ap�s executado um dos comando DML (INSERT, UPDATE ou DELETE), h� dados tanto na tabela INSERTED quando na DELETED; e se houver, significa que o comando DML utilizado foi um UPDATE, j� que, conforme vimos, o UPDATE � o �nico comando que insere dados em ambas tabelas tempor�rias. Sendo um UPDATE, aparecer� na tela a mensagem 'Os dados foram atualizados na tabela!';
- 6. Se no IF acima for verificado que ou a INSERTED ou a DELETED est� vazia, significa que o comando DML utilizado n�o foi um UPDATE, ent�o, prosseguimos para a pr�xima linha do c�digo e verificamos no primeiro ELSE IF EXISTS, se h� dados na tabela INSERTED; se houver, significa que o comando DML utilizado foi um INSERTED, portando, imprimimos na tela a mensagem 'Os dados foram inseridos na tabela!'; 
- 7. Caso contr�rio, ou seja, se a tabela INSERTED estiver vazia, fazemos a �ltima verifica��o para saber se h� dados na tabela DELETED, se houver, significa que o comando DML utilizado foi um DELETE, portanto, imprimimos na tela que 'Os dados foram exclu�dos da tabela!'.
- 8. Finalizamos o bloco de comandos com o comando END.	

Vamos testar agora um comando DML por vez.	*/

-- INSERT
INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Eleonora Batista', 'F', '13/02/2003', '453.543.189-00')

SELECT * FROM dCliente

-- DELETE
DELETE FROM dCliente
WHERE id_cliente = 14

-- UPDATE
UPDATE dCliente
SET cpf = '678.333.111-11'
WHERE id_cliente = 1