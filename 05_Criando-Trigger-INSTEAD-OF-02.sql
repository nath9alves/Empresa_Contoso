-- M�DULO 23 - SQL SERVER - TRIGGERS DML


-- AULA 07 - Criando uma Trigger para Controle de Permiss�o de Cadastro - INSTEAD OF (Parte 2)

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
	ELSE
	BEGIN

	INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)
	SELECT i.nome_cliente, i.genero, i.data_de_nascimento, i.cpf FROM INSERTED i

	END
END

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Lucio Dantas', 'M', '13/02/2003', '111.222.333-00')

-- Obs.�: Agora sim, os dados dos clientes foram inseridos na tabela.
-- Obs.�: Na mensagem aparecer� a mensagem 'Dados Foram Inseridos na Tabela' pois nos exemplos anteriores, foi criar uma Trigger que verificava se era um INSERTED, DELETED ou UPDATE e inserido este PRINT como resultado.

SELECT * FROM dCliente