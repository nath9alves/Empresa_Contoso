-- M�DULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 03 - Criando uma Trigger DML - AFTER

- Criando uma TRIGGER DML simples
Essa trigger ser� disparada ap�s (AFTER) um evento INSERT, UPDATE ou DELETE ser executado na tabela dCliente e imprimir� na tela uma mensagem informando que os dados dessa tabela foram alterados.

Veja o passo a passo:

- 1. Iniciamos a nossa trigger com o comando CREATE OR ALTER TRIGGER e damos um nome a ela;
- 2. Informamos o nome da tabela que far� a trigger ser disparada toda vez que for alterada. No caso, ser� a dCliente.
- 3. Determinamos se a trigger ser� do tipo AFTER ou INSTEAD OF e quais comandos que disparar�o quando forem executados.
- 4. Iniciamos o bloco de comandos com o comando BEGIN;
- 5. Inclu�mos todos os comandos que dever�o ser executados quando a trigger for disparada. Aqui, apenas um PRINT na tela com a mensagem 'Os dados da tabela dCliente foram alterados!';
- 6. Finalizamos o bloco de comandos com o comando END.

*/

USE Exercicios

CREATE OR ALTER TRIGGER tgClienteAlterado
ON dCliente
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

	PRINT 'Os dados da tabela dCliente foram alterados!'

END


SELECT * FROM dCliente

--  Com a nossa trigger tgClienteAlterado criada, repare que toda vez que efetuarmos um INSERT, UPDATE ou um DELETE na tabela dCliente, aparecer� na tela a mensagem configurada no PRINT.

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Zacarias Neto', 'M', '13/02/1999', '139.543.189-00')

UPDATE dCliente
SET cpf = '130.451.892-10'
WHERE id_cliente = 11

DELETE FROM dCliente
WHERE id_cliente = 11