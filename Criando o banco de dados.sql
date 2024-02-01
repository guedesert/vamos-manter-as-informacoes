USE master;
GO

CREATE LOGIN loja WITH PASSWORD = 'loja', CHECK_POLICY = OFF;
GO

CREATE USER loja FOR LOGIN loja;
GO

CREATE DATABASE Loja;
GO

USE Loja;
GO

CREATE TABLE [Pessoa] (
	idPessoa int NOT NULL UNIQUE,
	nome varchar(50) NOT NULL,
	logradouro varchar(50) NOT NULL,
	cidade varchar(50) NOT NULL,
	estado char(2) NOT NULL,
	telefone varchar(11) NOT NULL,
	email varchar(50) NOT NULL,
  CONSTRAINT [PK_PESSOA] PRIMARY KEY CLUSTERED
  (
  [idPessoa] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Usuario] (
	idUsuario int NOT NULL UNIQUE,
	login varchar(25) NOT NULL UNIQUE,
	senha varchar(16) NOT NULL,
  CONSTRAINT [PK_USUARIO] PRIMARY KEY CLUSTERED
  (
  [idUsuario] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PessoaFisica] (
	idPessoaFisica int NOT NULL UNIQUE,
	cpf varchar(11) NOT NULL UNIQUE,
  CONSTRAINT [PK_PESSOAFISICA] PRIMARY KEY CLUSTERED
  (
  [idPessoaFisica] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PessoaJuridica] (
	idPessoaJuridica int NOT NULL UNIQUE,
	cnpj varchar(14) NOT NULL UNIQUE,
  CONSTRAINT [PK_PESSOAJURIDICA] PRIMARY KEY CLUSTERED
  (
  [idPessoaJuridica] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Produto] (
	idProduto int NOT NULL UNIQUE,
	nome varchar(100) NOT NULL,
	quantidade int NOT NULL,
	precoVenda decimal (10, 2) NOT NULL,
  CONSTRAINT [PK_PRODUTO] PRIMARY KEY CLUSTERED
  (
  [idProduto] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Movimento] (
	idMovimento int NOT NULL UNIQUE,
	idProduto int NOT NULL,
	idPessoa int NOT NULL,
	idUsuario int NOT NULL,
	tipo char(1) NOT NULL,
	quantidade int NOT NULL,
	precoUnitario decimal(10, 2) NOT NULL,
  CONSTRAINT [PK_MOVIMENTO] PRIMARY KEY CLUSTERED
  (
  [idMovimento] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO


ALTER TABLE [PessoaFisica] WITH CHECK ADD CONSTRAINT [PessoaFisica_fk0] FOREIGN KEY ([idPessoaFisica]) REFERENCES [Pessoa]([idPessoa])
ON UPDATE CASCADE
GO
ALTER TABLE [PessoaFisica] CHECK CONSTRAINT [PessoaFisica_fk0]
GO

ALTER TABLE [PessoaJuridica] WITH CHECK ADD CONSTRAINT [PessoaJuridica_fk0] FOREIGN KEY ([idPessoaJuridica]) REFERENCES [Pessoa]([idPessoa])
ON UPDATE CASCADE
GO
ALTER TABLE [PessoaJuridica] CHECK CONSTRAINT [PessoaJuridica_fk0]
GO


ALTER TABLE [Movimento] WITH CHECK ADD CONSTRAINT [Movimento_fk0] FOREIGN KEY ([idProduto]) REFERENCES [Produto]([idProduto])
ON UPDATE CASCADE
GO
ALTER TABLE [Movimento] CHECK CONSTRAINT [Movimento_fk0]
GO
ALTER TABLE [Movimento] WITH CHECK ADD CONSTRAINT [Movimento_fk1] FOREIGN KEY ([idPessoa]) REFERENCES [Pessoa]([idPessoa])
ON UPDATE CASCADE
GO
ALTER TABLE [Movimento] CHECK CONSTRAINT [Movimento_fk1]
GO
ALTER TABLE [Movimento] WITH CHECK ADD CONSTRAINT [Movimento_fk2] FOREIGN KEY ([idUsuario]) REFERENCES [Usuario]([idUsuario])
ON UPDATE CASCADE
GO
ALTER TABLE [Movimento] CHECK CONSTRAINT [Movimento_fk2]
GO
