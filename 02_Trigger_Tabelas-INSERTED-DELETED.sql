-- MÓDULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 04 - Tabelas INSERTED e DELETED
- Vamos alterar a trigger anterior para deixá-la mais clara. 

Quando executarmos um comando a mensagem que aparecerá será personalizada para aquele comando. 

INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram excluídos da tabela!

Antes, vamos entender a existência das tabelas INSERTED e DELETED.

No SQL Server, existem duas tabelas pré-configuradas, chamadas INSERTED e DELETED que, todas as vezes que efetuamos um comando DML (INSERT, UPDATE ou DELETE) elas recebem os dados que foram inseridos, atualizados ou excluídos, a depender do comando que foi utilizado.

Exemplos: 
*/

SELECT * FROM dCliente

-- INSERT
-- Ao invés de mostrar na tela a mensagem genérica que os dados foram inseridos, mostrar os próprios dados que foram inseridos na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT
AS
BEGIN
	SELECT * FROM INSERTED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que no bloco de comandos, no lugar do comando PRINT, inserimos o SELECT * FROM INSERTED. Com essa alteração na nossa trigger, se efetuarmos o INSERT abaixo, repare que o resultado mostrado serão os próprios dados que foram inseridos na tabela dCliente, ao invés da mensagem que tínhamos.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Isso aconteceu porque, toda vez que inserimos um dado em alguma tabela, esse registro também fica temporariamente armazenado na tabela INSERTED. Como incluímos um SELECT a essa tabela (INSERTED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registo que a tabela INSERTED acabou de temporariamente armazenar.


-- DELETE
-- Ao invés de mostrar na tela a mensagem genérica que os dados foram alterados, mostrar os próprios dados que foram deletados na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER DELETE
AS
BEGIN
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos um SELECT * FROM DELETED. Com essa alteração na nossa trigger, se efetuarmos o DELETE abaixo, repare que o resultado serão os próprios dados que foram excluídos na tabela dCliente.

DELETE FROM dCliente
WHERE id_cliente = 12

-- Isso aconteceu porque, toda vez que excluímos algum dado de uma tabela, esse registro também fica temporariamente armazenado na tabela DELETED. Como incluímos um SELECT a essa tabela (DELETED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registro que a tabela DELETED acabou de temporariamente armazenar.


-- UPDATE
-- Ja parou para pensar que, quando atualizamos uma tabela, temos dois registros? O novo que foi inserido na tabela, e o antigo que foi excluído da tabela para dar lugar ao novo. Com isso em mente, vamos imaginar que queremos, por fim, alterar a trigger tgClienteAlterado para, a partir de agora, apresentar na tela os dados que foram inseridos na tabela dCliente e os que foram excluídos da tabela dCliente toda vez que executamos um UPDATE.

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER UPDATE
AS
BEGIN
	SELECT * FROM INSERTED
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos duas consultas: um SELECT * FROM INSERTED (para retornar o novo registo) e um SELECT * FROM DELETED (para retornar o registro que foi excluído). Vamos inserir novamente o registro que excluímos no último exemplo para podermos, posteriormente, atualizá-los.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Agora, note que, com a alteração na nossa trigger, se efetuarmos o UPDATE abaixo, o resultado será o registro que foi incluído na tabela dCliente e também o que foi excluído da tabela dCliente.

UPDATE dCliente
SET cpf = '130.451.892-10'
WHERE id_cliente = 13

/* Isso aconteceu porque, toda vez que atualizamos algum dado de uma tabela, o novo registro também fica temporariamente armazenado na tabela INSERTED, enquanto que o antigo registo (que foi excluído) fica temporariamente armazenado na tabela DELETED. Como incluímos um SELECT tanto à tabela INSERTED quanto à tabela DELETED no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado os registros que as tabelas INSERTED e DELETED acabaram de temporariamente armazenar.

Portando, em resumo, podemos concluir que:

- Se a trigger for de INSERT, a INSERTED terá registros e a DELETED ficará vazia;
- Se a trigger for de DELETE, a INSERTED ficará vazia e a DELETED terá registros;
- Se a trigger for de UPDATE, a INSERTED e a DELETED terão registros;
*/