USE Loja;
GO

INSERT INTO [Pessoa] (idPessoa, nome, logradouro, cidade, estado, telefone, email)
VALUES 
    (1, 'Ana Oliveira', 'Rua das Flores 123', 'São Paulo', 'SP', '11987654321', 'ana@email.com'),
    (2, 'Carlos Silva', 'Avenida Central 456', 'Rio de Janeiro', 'RJ', '21987654321', 'carlos@email.com'),
    (3, 'Mariana Santos', 'Travessa Exemplo 789', 'Belo Horizonte', 'MG', '31987654321', 'mariana@email.com'),
    (4, 'José Pereira', 'Rua Principal 321', 'Porto Alegre', 'RS', '51987654321', 'jose@email.com');

INSERT INTO [Usuario] (idUsuario, login, senha)
VALUES 
    (1, 'funcionario1', 'senha123'),
    (2, 'funcionario2', 'senha456'),
    (3, 'gerente1', 'senha789');

INSERT INTO [PessoaFisica] (idPessoaFisica, cpf)
VALUES 
    (1, '11122233344'),  
    (2, '55566677788');

INSERT INTO [PessoaJuridica] (idPessoaJuridica, cnpj)
VALUES 
    (1, '12345678901234'),  
    (2, '98765432109876');

INSERT INTO [Produto] (idProduto, nome, quantidade, precoVenda)
VALUES 
    (1, 'Maçã', 200, 2.50),
    (2, 'Abacaxi', 150, 3.00),
    (3, 'Pera', 120, 2.75),
    (4, 'Uva', 180, 4.50);

INSERT INTO [Movimento] (idMovimento, idProduto, idPessoa, idUsuario, tipo, quantidade, precoUnitario)
VALUES 
    (1, 1, 1, 1, 'E', 20, 2.50),
    (2, 2, 2, 2, 'E', 15, 3.00),
    (3, 3, 3, 3, 'S', 10, 2.75),
    (4, 4, 4, 1, 'E', 25, 4.50),
    (5, 1, 2, 2, 'S', 5, 3.00);

SELECT Pessoa.idPessoa, Pessoa.nome, Pessoa.logradouro, Pessoa.cidade, Pessoa.estado, Pessoa.telefone, Pessoa.email, PF.cpf 
FROM Pessoa
JOIN PessoaFisica PF ON Pessoa.idPessoa = PF.idPessoaFisica;

SELECT Pessoa.idPessoa, Pessoa.nome, Pessoa.logradouro, Pessoa.cidade, Pessoa.estado, Pessoa.telefone, Pessoa.email, PJ.cnpj
FROM Pessoa
JOIN PessoaJuridica PJ ON Pessoa.idPessoa = PJ.idPessoaJuridica;

SELECT 
    P.nome AS Fornecedor,
    Prod.nome AS Produto,
    Mov.quantidade,
    Mov.precoUnitario AS PrecoUnitario,
    Mov.quantidade * Mov.precoUnitario AS ValorTotal
FROM Movimento Mov
JOIN Produto Prod ON Mov.idProduto = Prod.idProduto
JOIN Pessoa P ON Mov.idPessoa = P.idPessoa
WHERE Mov.tipo = 'E';

SELECT 
    P.nome AS Comprador,
    Prod.nome AS Produto,
    Mov.quantidade,
    Mov.precoUnitario AS PrecoUnitario,
    Mov.quantidade * Mov.precoUnitario AS ValorTotal
FROM Movimento Mov
JOIN Produto Prod ON Mov.idProduto = Prod.idProduto
JOIN Pessoa P ON Mov.idPessoa = P.idPessoa
WHERE Mov.tipo = 'S';

SELECT Mov.idProduto, SUM(Mov.quantidade * Mov.precoUnitario) AS TotalEntradas
FROM Movimento Mov
WHERE Mov.tipo = 'E'
GROUP BY Mov.idProduto;

SELECT Mov.idProduto, SUM(Mov.quantidade * Mov.precoUnitario) AS TotalSaidas
FROM Movimento Mov
WHERE Mov.tipo = 'S'
GROUP BY Mov.idProduto;

SELECT DISTINCT U.*
FROM Usuario U
LEFT JOIN Movimento M ON U.idUsuario = M.idUsuario AND M.tipo = 'E'
WHERE M.idUsuario IS NULL;

SELECT M.idUsuario, SUM(M.quantidade * M.precoUnitario) AS TotalEntradas
FROM Movimento M
WHERE M.tipo = 'E'
GROUP BY M.idUsuario;

SELECT M.idUsuario, SUM(M.quantidade * M.precoUnitario) AS TotalSaidas
FROM Movimento M
WHERE M.tipo = 'S'
GROUP BY M.idUsuario;

SELECT 
    Prod.nome AS Produto,
    Mov.idProduto, 
    SUM(Mov.quantidade * Mov.precoUnitario) / SUM(Mov.quantidade) AS MediaPonderada
FROM Movimento Mov
JOIN Produto Prod ON Mov.idProduto = Prod.idProduto
WHERE Mov.tipo = 'S'
GROUP BY Mov.idProduto, Prod.nome;
