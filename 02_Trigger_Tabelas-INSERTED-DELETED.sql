-- M�DULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 04 - Tabelas INSERTED e DELETED
- Vamos alterar a trigger anterior para deix�-la mais clara. 

Quando executarmos um comando a mensagem que aparecer� ser� personalizada para aquele comando. 

INSERT INTO: Os dados foram inseridos na tabela!
UPDATE: Os dados foram atualizados na tabela!
DELETE: Os dados foram exclu�dos da tabela!

Antes, vamos entender a exist�ncia das tabelas INSERTED e DELETED.

No SQL Server, existem duas tabelas pr�-configuradas, chamadas INSERTED e DELETED que, todas as vezes que efetuamos um comando DML (INSERT, UPDATE ou DELETE) elas recebem os dados que foram inseridos, atualizados ou exclu�dos, a depender do comando que foi utilizado.

Exemplos: 
*/

SELECT * FROM dCliente

-- INSERT
-- Ao inv�s de mostrar na tela a mensagem gen�rica que os dados foram inseridos, mostrar os pr�prios dados que foram inseridos na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT
AS
BEGIN
	SELECT * FROM INSERTED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que no bloco de comandos, no lugar do comando PRINT, inserimos o SELECT * FROM INSERTED. Com essa altera��o na nossa trigger, se efetuarmos o INSERT abaixo, repare que o resultado mostrado ser�o os pr�prios dados que foram inseridos na tabela dCliente, ao inv�s da mensagem que t�nhamos.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Isso aconteceu porque, toda vez que inserimos um dado em alguma tabela, esse registro tamb�m fica temporariamente armazenado na tabela INSERTED. Como inclu�mos um SELECT a essa tabela (INSERTED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registo que a tabela INSERTED acabou de temporariamente armazenar.


-- DELETE
-- Ao inv�s de mostrar na tela a mensagem gen�rica que os dados foram alterados, mostrar os pr�prios dados que foram deletados na tabela;
CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER DELETE
AS
BEGIN
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos um SELECT * FROM DELETED. Com essa altera��o na nossa trigger, se efetuarmos o DELETE abaixo, repare que o resultado ser�o os pr�prios dados que foram exclu�dos na tabela dCliente.

DELETE FROM dCliente
WHERE id_cliente = 12

-- Isso aconteceu porque, toda vez que exclu�mos algum dado de uma tabela, esse registro tamb�m fica temporariamente armazenado na tabela DELETED. Como inclu�mos um SELECT a essa tabela (DELETED) no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado o registro que a tabela DELETED acabou de temporariamente armazenar.


-- UPDATE
-- Ja parou para pensar que, quando atualizamos uma tabela, temos dois registros? O novo que foi inserido na tabela, e o antigo que foi exclu�do da tabela para dar lugar ao novo. Com isso em mente, vamos imaginar que queremos, por fim, alterar a trigger tgClienteAlterado para, a partir de agora, apresentar na tela os dados que foram inseridos na tabela dCliente e os que foram exclu�dos da tabela dCliente toda vez que executamos um UPDATE.

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER UPDATE
AS
BEGIN
	SELECT * FROM INSERTED
	SELECT * FROM DELETED
		-- PRINT 'Os dados da tabela dCliente foram alterados!'
END

-- Repare que agora, no bloco de comandos, inserimos duas consultas: um SELECT * FROM INSERTED (para retornar o novo registo) e um SELECT * FROM DELETED (para retornar o registro que foi exclu�do). Vamos inserir novamente o registro que exclu�mos no �ltimo exemplo para podermos, posteriormente, atualiz�-los.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

-- Agora, note que, com a altera��o na nossa trigger, se efetuarmos o UPDATE abaixo, o resultado ser� o registro que foi inclu�do na tabela dCliente e tamb�m o que foi exclu�do da tabela dCliente.

UPDATE dCliente
SET cpf = '130.451.892-10'
WHERE id_cliente = 13

/* Isso aconteceu porque, toda vez que atualizamos algum dado de uma tabela, o novo registro tamb�m fica temporariamente armazenado na tabela INSERTED, enquanto que o antigo registo (que foi exclu�do) fica temporariamente armazenado na tabela DELETED. Como inclu�mos um SELECT tanto � tabela INSERTED quanto � tabela DELETED no bloco de comandos da trigger tgClienteAlterado, quando disparada, ela mostrou como resultado os registros que as tabelas INSERTED e DELETED acabaram de temporariamente armazenar.

Portando, em resumo, podemos concluir que:

- Se a trigger for de INSERT, a INSERTED ter� registros e a DELETED ficar� vazia;
- Se a trigger for de DELETE, a INSERTED ficar� vazia e a DELETED ter� registros;
- Se a trigger for de UPDATE, a INSERTED e a DELETED ter�o registros;
*/