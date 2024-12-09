-- MÓDULO 23 - SQL SERVER - TRIGGERS DML


-- AULA 07 - Criando uma Trigger para Controle de Permissão de Cadastro - INSTEAD OF (Parte 2)

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
	ELSE
	BEGIN

	INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)
	SELECT i.nome_cliente, i.genero, i.data_de_nascimento, i.cpf FROM INSERTED i

	END
END

INSERT INTO dCliente(nome_cliente, genero, data_de_nascimento, cpf)	VALUES
	('Lucio Dantas', 'M', '13/02/2003', '111.222.333-00')

-- Obs.¹: Agora sim, os dados dos clientes foram inseridos na tabela.
-- Obs.²: Na mensagem aparecerá a mensagem 'Dados Foram Inseridos na Tabela' pois nos exemplos anteriores, foi criar uma Trigger que verificava se era um INSERTED, DELETED ou UPDATE e inserido este PRINT como resultado.

SELECT * FROM dCliente