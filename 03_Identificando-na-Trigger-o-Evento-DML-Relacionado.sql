-- MÓDULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 05 - Identificando na Trigger o Evento DML Relacionado
Sabendo agora, como funcionam as tabelas INSERTED e DELETED, podemos finalmente personalizar as mensagens apresentadas na tela, de acordo com o comando DML utilizado, quando a tabela dCliente for alterada e a nossa trigger tgClienteAlterado disparada.

Relembrando, quando dispararmos o comando... será apresentado na tela a mensagem...
INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram excluídos da tabela!
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
- 2. Informamos o nome da tabela que fará a trigger ser disparada toda vez que for alterada. No caso, será a dCliente;
- 3. Determinamos se a trigger será do tipo AFTER ou INSTEAD OF (no caso, será do tipo AFTER, pois queremos que ela dispare depois que uma alteração for efetuada) e quais serão os comandos que a dispararão quando forem executados. No caso, será depois dos três comando DML: INSERT, UPDATE e DELETE	  
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Dentro do bloco de comandos, fazemos um IF EXISTS, para verificar se, após executado um dos comando DML (INSERT, UPDATE ou DELETE), há dados tanto na tabela INSERTED quando na DELETED; e se houver, significa que o comando DML utilizado foi um UPDATE, já que, conforme vimos, o UPDATE é o único comando que insere dados em ambas tabelas temporárias. Sendo um UPDATE, aparecerá na tela a mensagem 'Os dados foram atualizados na tabela!';
- 6. Se no IF acima for verificado que ou a INSERTED ou a DELETED está vazia, significa que o comando DML utilizado não foi um UPDATE, então, prosseguimos para a próxima linha do código e verificamos no primeiro ELSE IF EXISTS, se há dados na tabela INSERTED; se houver, significa que o comando DML utilizado foi um INSERTED, portando, imprimimos na tela a mensagem 'Os dados foram inseridos na tabela!'; 
- 7. Caso contrário, ou seja, se a tabela INSERTED estiver vazia, fazemos a última verificação para saber se há dados na tabela DELETED, se houver, significa que o comando DML utilizado foi um DELETE, portanto, imprimimos na tela que 'Os dados foram excluídos da tabela!'.
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