-- M�DULO 23 - SQL SERVER - TRIGGERS DML


/* AULA 08 - Habilitando, Desabilitando e Excluindo uma Trigger
Al�m de, podermos excluir uma TRIGGER DML, tamb�m temos a op��o de apenas desabilit�-la. Desta forma, ela continua salva no banco de dados por�m, deixa de ser disparada. Se porventura precisarmos, podemos habilit�-la novamente. */

----------------------------------------------------------------------------------------------------------

-- Para desabilitar uma trigger DML, utilizamos o comando DISABLE:

DISABLE TRIGGER nome_da_trigger ON nome_da_tabela

----------------------------------------------------------------------------------------------------------

-- Para habilitar uma trigger DML novamente, utilizamos o comando ENABLE:

ENABLE TRIGGER nome_da_trigger ON nome_da_tabea

----------------------------------------------------------------------------------------------------------

-- Para desabilitar todas as trigger DML de uma tabela utilizamos a seguinte sintaxxe:

DISABLE TRIGGER ALL ON nome_da_tabela

----------------------------------------------------------------------------------------------------------

-- Para habilitar novamente todas as trigger DML de uma tabela utilizamos a seguinte sintaxe:

ENABLE TRIGGER ALL ON nome_da_tabela

----------------------------------------------------------------------------------------------------------

-- Por fim, para excluir uma trigger DML, utilizamos a sintaxe:

DROP TRIGGER nome_da_trigger

----------------------------------------------------------------------------------------------------------

-- Desabilitando e Habilitando a Trigger DML tgControleRegistros

DISABLE TRIGGER tgControleRegistros ON dCliente -- Desabilitando uma Trigger espec�fica

ENABLE TRIGGER tgControleRegistros ON dCliente -- Habilitando uma Trigger espec�fica

----------------------------------------------------------------------------------------------------------

-- Desabilitando e Habilitando TODAS as Triggers DML da tabela dCliente

DISABLE TRIGGER ALL ON dCliente -- Desabilitando TODAS as Triggers

ENABLE TRIGGER ALL ON dCliente -- Habilitando TODAS as Triggers

----------------------------------------------------------------------------------------------------------

-- Excluindo a Trigger DML tgControleRegistros

DROP TRIGGER tgControleRegistros;