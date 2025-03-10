-- Criação das Tabelas

-- Tabela Terceiro Vendedor
CREATE TABLE TerceiroVendedor (
    idTerceiro INT PRIMARY KEY,
    razaoSocial VARCHAR(45),
    local VARCHAR(45)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    razaoSocial VARCHAR(45),
    CNPJ CHAR(14)
);

-- Tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY,
    local VARCHAR(45)
);

-- Tabela Produto
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    categoria VARCHAR(45),
    descricao VARCHAR(45),
    valor FLOAT
);

-- Tabela Terceiro Vendedor Produto
CREATE TABLE Terceiro_Vendedor_Produto (
    TerceiroidVendedorTerceiro INT,
    ProdutoidProduto INT,
    quantidade INT,
    PRIMARY KEY (TerceiroidVendedorTerceiro, ProdutoidProduto),
    FOREIGN KEY (TerceiroidVendedorTerceiro) REFERENCES TerceiroVendedor(idTerceiro),
    FOREIGN KEY (ProdutoidProduto) REFERENCES Produto(idProduto)
);

-- Tabela Comprador
CREATE TABLE Comprador (
    idComprador INT PRIMARY KEY,
    nome VARCHAR(45),
    identificacao VARCHAR(45),
    endereco VARCHAR(45)
);

-- Tabela Entregador
CREATE TABLE Entregador (
    idEntregador INT PRIMARY KEY,
    nome VARCHAR(45),
    contato VARCHAR(45)
);

-- Tabela Pedido
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    statusPedido VARCHAR(45),
    descricao VARCHAR(45),
    frete FLOAT,
    CompradoridComprador INT,
    EntregadoridEntregador INT,
    FOREIGN KEY (CompradoridComprador) REFERENCES Comprador(idComprador),
    FOREIGN KEY (EntregadoridEntregador) REFERENCES Entregador(idEntregador)
);

-- Tabela Produto Pedido
CREATE TABLE Produto_Pedido (
    ProdutoidProduto INT,
    PedidoidPedido INT,
    quantidade INT,
    valor FLOAT,
    PRIMARY KEY (ProdutoidProduto, PedidoidPedido),
    FOREIGN KEY (ProdutoidProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (PedidoidPedido) REFERENCES Pedido(idPedido)
);

-- Tabela Pagamento
CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY AUTO_INCREMENT,
    metodoPagamento VARCHAR(45),
    custoTotal FLOAT,
    CompradoridComprador INT,
    EntregadoridEntregador INT,
    TerceiroidVendedorTerceiro INT,
    FOREIGN KEY (CompradoridComprador) REFERENCES Comprador(idComprador),
    FOREIGN KEY (EntregadoridEntregador) REFERENCES Entregador(idEntregador),
    FOREIGN KEY (TerceiroidVendedorTerceiro) REFERENCES TerceiroVendedor(idTerceiro)
);

-- Tabela Estoque Produto
CREATE TABLE Estoque_Produto (
    EstoqueidEstoque INT,
    ProdutoidProduto INT,
    quantidade INT,
    PRIMARY KEY (EstoqueidEstoque, ProdutoidProduto),
    FOREIGN KEY (EstoqueidEstoque) REFERENCES Estoque(idEstoque),
    FOREIGN KEY (ProdutoidProduto) REFERENCES Produto(idProduto)
);

-- Tabela Fornecedor Produto
CREATE TABLE Fornecedor_Produto (
    FornecedoridFornecedor INT,
    ProdutoidProduto INT,
    PRIMARY KEY (FornecedoridFornecedor, ProdutoidProduto),
    FOREIGN KEY (FornecedoridFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (ProdutoidProduto) REFERENCES Produto(idProduto)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    CompradoridComprador INT,
    EntregadoridEntregador INT,
    status VARCHAR(10),
    codigoRastreio INT,
    PRIMARY KEY (CompradoridComprador, EntregadoridEntregador),
    FOREIGN KEY (CompradoridComprador) REFERENCES Comprador(idComprador),
    FOREIGN KEY (EntregadoridEntregador) REFERENCES Entregador(idEntregador)
);

-- Tabela CLT
CREATE TABLE CLT (
    CompradoridComprador INT PRIMARY KEY,
    beneficios VARCHAR(45),
    salario FLOAT,
    cargo VARCHAR(45),
    jornadaTrabalho VARCHAR(45),
    cpf CHAR(11),
    FOREIGN KEY (CompradoridComprador) REFERENCES Comprador(idComprador)
);

-- Tabela PJ
CREATE TABLE PJ (
    CompradoridComprador INT PRIMARY KEY,
    cnpj CHAR(14),
    servico VARCHAR(45),
    valorContrato FLOAT,
    valorHora FLOAT,
    FOREIGN KEY (CompradoridComprador) REFERENCES Comprador(idComprador)
);

-- Inserção de Dados

-- Inserções na Tabela Terceiro Vendedor
INSERT INTO TerceiroVendedor (idTerceiro, razaoSocial, local)
VALUES (2, 'Eletro Vendas LTDA', 'Campinas'),
       (3, 'Fashion Online', 'São Paulo'),
       (4, 'Livraria Virtual', 'Rio de Janeiro'),
       (5, 'Tech World', 'Belo Horizonte');

-- Inserções na Tabela Fornecedor
INSERT INTO Fornecedor (idFornecedor, razaoSocial, CNPJ)
VALUES (2, 'Fornecedor Tech', '45678912000145'),
       (3, 'Books Distribuidora', '78965432000199'),
       (4, 'Moda Distribuição', '32165487000133'),
       (5, 'Gadgets Fornecimentos', '15975348000122');

-- Inserções na Tabela Estoque
INSERT INTO Estoque (idEstoque, local)
VALUES (2, 'Centro de Distribuição RJ'),
       (3, 'Centro de Distribuição MG'),
       (4, 'Loja Física SP'),
       (5, 'Depósito Recife');

-- Inserções na Tabela Produto
INSERT INTO Produto (idProduto, categoria, descricao, valor)
VALUES (103, 'Roupas', 'Camiseta Básica', 49.90),
       (104, 'Eletrônicos', 'Carregador Portátil', 159.90),
       (105, 'Livros', 'Guia Avançado de SQL', 89.90),
       (106, 'Acessórios', 'Fone com Fio', 79.90),
       (107, 'Gadgets', 'Relógio Smart', 499.90);

-- Inserções na Tabela Terceiro Vendedor Produto
INSERT INTO Terceiro_Vendedor_Produto (TerceiroidVendedorTerceiro, ProdutoidProduto, quantidade)
VALUES 
    (2, 103, 15),
    (2, 104, 10),
    (3, 105, 8),
    (4, 106, 20),
    (5, 107, 5);

-- Inserções na Tabela Estoque Produto
INSERT INTO Estoque_Produto (EstoqueidEstoque, ProdutoidProduto, quantidade)
VALUES (2, 103, 20),
       (2, 104, 15),
       (3, 105, 10),
       (4, 106, 25),
       (5, 107, 8);

-- Inserções na Tabela Fornecedor Produto
INSERT INTO Fornecedor_Produto (FornecedoridFornecedor, ProdutoidProduto)
VALUES (2, 104),
       (3, 105),
       (4, 103),
       (5, 107);

-- Inserções na Tabela Comprador
INSERT INTO Comprador (idComprador, nome, identificacao, endereco)
VALUES (3, 'Pedro Fernandes', 'CPF:11122233344', 'Av. Central, 987, Campinas'),
       (4, 'Ana Pereira', 'CPF:55566677788', 'Rua Nova, 321, Recife'),
       (5, 'Lucas Moura', 'CPF:99988877766', 'Praça das Flores, 10, Belo Horizonte'),
       (6, 'Carla Oliveira', 'CPF:44433322211', 'Rua Rosa, 456, Natal');

-- Inserções na Tabela Entregador
INSERT INTO Entregador (idEntregador, nome, contato)
VALUES (2, 'Carlos Motoboy', '21999997777'),
       (3, 'Fernanda Express', '32988885555'),
       (4, 'Luiz Transportes', '31977776666'),
       (5, 'Amanda Logística', '41966664444');

-- Inserções na Tabela Pedido
INSERT INTO Pedido (idPedido, statusPedido, descricao, frete, CompradoridComprador, EntregadoridEntregador)
VALUES (2, 'Concluído', 'Pedido de livros', 10.00, 3, 2),
       (3, 'Pendente', 'Pedido de roupas', 15.00, 3, 3),
       (4, 'Cancelado', 'Pedido de eletrônicos', 25.00, 4, 4),
       (5, 'Em trânsito', 'Pedido de acessórios', 12.00, 5, 5);

-- Inserções na Tabela Produto Pedido
INSERT INTO Produto_Pedido (ProdutoidProduto, PedidoidPedido, quantidade, valor)
VALUES (105, 2, 1, 89.90),
       (103, 3, 2, 49.90),
       (104, 4, 1, 159.90),
       (106, 5, 1, 79.90);

-- Inserções na Tabela Pagamento
INSERT INTO Pagamento (metodoPagamento, custoTotal, CompradoridComprador, EntregadoridEntregador, TerceiroidVendedorTerceiro)
VALUES ('Boleto Bancário', 99.90, 3, 2, 3),
       ('Cartão de Débito', 109.80, 3, 3, 4),
       ('Pix', 159.90, 4, 4, 2),
       ('Cartão de Crédito', 499.90, 5, 5, 5);

-- Inserções na Tabela Entrega
INSERT INTO Entrega (CompradoridComprador, EntregadoridEntregador, status, codigoRastreio)
VALUES (3, 4, 'Entregue', 223344),
       (3, 3, 'Aguardando', 334455),
       (4, 4, 'Cancelada', 445566),
       (5, 5, 'Em rota', 556677);

-- Inserções na Tabela CLT
INSERT INTO CLT (CompradoridComprador, beneficios, salario, cargo, jornadaTrabalho, cpf)
VALUES (3, 'Vale Transporte, VA', 2500.00, 'Estagiário', '30h semanais', '11122233344'),
       (4, 'Plano Odontológico', 3500.00, 'Desenvolvedor', '40h semanais', '55566677788');

-- Inserções na Tabela PJ
INSERT INTO PJ (CompradoridComprador, cnpj, servico, valorContrato, valorHora)
VALUES (5, '12345678000987', 'Design Gráfico', 8000.00, 120.00),
       (6, '65432109000199', 'Marketing Digital', 12000.00, 200.00);
       
-- Consultas       

-- Exibir os nomes dos clientes e os produtos que comprados
SELECT c.nome AS Cliente, p.descricao AS Produto
FROM Pedido pe
JOIN Produto_Pedido pp ON pe.idPedido = pp.PedidoidPedido
JOIN Produto p ON pp.ProdutoidProduto = p.idProduto
JOIN Comprador c ON pe.CompradoridComprador = c.idComprador;

-- Verificar todos os pedidos pendentes
SELECT idPedido, descricao, frete
FROM Pedido
WHERE statusPedido = 'Pendente';

-- Calcular o valor total (frete + custo dos itens) de cada pedido
SELECT pe.idPedido, pe.descricao, 
       (SUM(pp.quantidade * pp.valor) + pe.frete) AS ValorTotal
FROM Pedido pe
JOIN Produto_Pedido pp ON pe.idPedido = pp.PedidoidPedido
GROUP BY pe.idPedido, pe.descricao, pe.frete;

-- Listar produtos mais caros em ordem decrescente
SELECT descricao, categoria, valor
FROM Produto
ORDER BY valor DESC;

-- Exibir clientes com mais de um pedido feito
SELECT c.nome AS Cliente, COUNT(pe.idPedido) AS TotalPedidos
FROM Comprador c
JOIN Pedido pe ON c.idComprador = pe.CompradoridComprador
GROUP BY c.nome
HAVING COUNT(pe.idPedido) > 1;

-- Junção de produtos, fornecedores e estoques (quantidade em cada local).
SELECT p.descricao AS Produto, f.razaoSocial AS Fornecedor, e.local AS Estoque, ep.quantidade AS Quantidade
FROM Produto p
JOIN Fornecedor_Produto fp ON p.idProduto = fp.ProdutoidProduto
JOIN Fornecedor f ON fp.FornecedoridFornecedor = f.idFornecedor
JOIN Estoque_Produto ep ON p.idProduto = ep.ProdutoidProduto
JOIN Estoque e ON ep.EstoqueidEstoque = e.idEstoque;

-- Quantos pedidos foram feitos por cada cliente?
SELECT c.nome AS Cliente, COUNT(pe.idPedido) AS TotalPedidos
FROM Comprador c
JOIN Pedido pe ON c.idComprador = pe.CompradoridComprador
GROUP BY c.nome;

-- Algum vendedor também é fornecedor?
SELECT tv.razaoSocial AS Vendedor
FROM TerceiroVendedor tv
JOIN Fornecedor f ON tv.razaoSocial = f.razaoSocial;

-- Relação de produtos, fornecedores e estoques:
SELECT p.descricao AS Produto, f.razaoSocial AS Fornecedor, e.local AS Estoque, ep.quantidade AS Quantidade
FROM Produto p
JOIN Fornecedor_Produto fp ON p.idProduto = fp.ProdutoidProduto
JOIN Fornecedor f ON fp.FornecedoridFornecedor = f.idFornecedor
JOIN Estoque_Produto ep ON p.idProduto = ep.ProdutoidProduto
JOIN Estoque e ON ep.EstoqueidEstoque = e.idEstoque;

-- Relação de nomes dos fornecedores e nomes dos produtos:
SELECT f.razaoSocial AS Fornecedor, p.descricao AS Produto
FROM Fornecedor f
JOIN Fornecedor_Produto fp ON f.idFornecedor = fp.FornecedoridFornecedor
JOIN Produto p ON fp.ProdutoidProduto = p.idProduto;

-- Lista de entregas com nome do cliente, status e código de rastreio.
SELECT c.nome AS Cliente, en.status AS StatusEntrega, en.codigoRastreio AS CodigoRastreio
FROM Entrega en
JOIN Comprador c ON en.CompradoridComprador = c.idComprador;

-- Produtos com preço maior que R$100.
SELECT descricao AS Produto, valor AS Preco
FROM Produto
WHERE valor > 100;

-- Número total de produtos em estoque (em todos os locais).
SELECT p.descricao AS Produto, SUM(ep.quantidade) AS TotalEmEstoque
FROM Produto p
JOIN Estoque_Produto ep ON p.idProduto = ep.ProdutoidProduto
GROUP BY p.descricao;

-- Listagem dos pedidos realizados em ordem decrescente de valor total (frete + itens).
SELECT pe.idPedido AS Pedido, c.nome AS Cliente, 
       (SUM(pp.quantidade * pp.valor) + pe.frete) AS ValorTotal
FROM Pedido pe
JOIN Produto_Pedido pp ON pe.idPedido = pp.PedidoidPedido
JOIN Comprador c ON pe.CompradoridComprador = c.idComprador
GROUP BY pe.idPedido, c.nome, pe.frete
ORDER BY ValorTotal DESC;

-- Fornecedores que fornecem mais de 3 produtos.
SELECT f.razaoSocial AS Fornecedor, COUNT(fp.ProdutoidProduto) AS TotalProdutos
FROM Fornecedor f
JOIN Fornecedor_Produto fp ON f.idFornecedor = fp.FornecedoridFornecedor
GROUP BY f.razaoSocial
HAVING COUNT(fp.ProdutoidProduto) > 3;

-- Lista completa de produtos, fornecedores, vendedores e estoques (quem fornece e vende cada produto e onde estão armazenados).
SELECT p.descricao AS Produto, f.razaoSocial AS Fornecedor, 
       tv.razaoSocial AS Vendedor, e.local AS LocalEstoque, ep.quantidade AS Estoque
FROM Produto p
LEFT JOIN Fornecedor_Produto fp ON p.idProduto = fp.ProdutoidProduto
LEFT JOIN Fornecedor f ON fp.FornecedoridFornecedor = f.idFornecedor
LEFT JOIN Terceiro_Vendedor_Produto tvp ON p.idProduto = tvp.ProdutoidProduto
LEFT JOIN TerceiroVendedor tv ON tvp.TerceiroidVendedorTerceiro = tv.idTerceiro
LEFT JOIN Estoque_Produto ep ON p.idProduto = ep.ProdutoidProduto
LEFT JOIN Estoque e ON ep.EstoqueidEstoque = e.idEstoque;

-- Pedido mais caro já realizado no sistema (considerando o valor total).
SELECT pe.idPedido AS PedidoMaisCaro, c.nome AS Cliente, 
       (SUM(pp.quantidade * pp.valor) + pe.frete) AS ValorTotal
FROM Pedido pe
JOIN Produto_Pedido pp ON pe.idPedido = pp.PedidoidPedido
JOIN Comprador c ON pe.CompradoridComprador = c.idComprador
GROUP BY pe.idPedido, c.nome, pe.frete
ORDER BY ValorTotal DESC
LIMIT 1;

-- Quais compradores adquiriram produtos do 'Fornecedor Tech'
SELECT DISTINCT c.nome AS Cliente, f.razaoSocial AS Fornecedor
FROM Comprador c
JOIN Pedido pe ON c.idComprador = pe.CompradoridComprador
JOIN Produto_Pedido pp ON pe.idPedido = pp.PedidoidPedido
JOIN Produto p ON pp.ProdutoidProduto = p.idProduto
JOIN Fornecedor_Produto fp ON p.idProduto = fp.ProdutoidProduto
JOIN Fornecedor f ON fp.FornecedoridFornecedor = f.idFornecedor
WHERE f.razaoSocial = 'Fornecedor Tech';

-- Produtos que possuem mais de 10 unidades disponíveis em qualquer estoque
SELECT p.descricao AS Produto, e.local AS Estoque, ep.quantidade AS QuantidadeDisponivel
FROM Estoque_Produto ep
JOIN Produto p ON ep.ProdutoidProduto = p.idProduto
JOIN Estoque e ON ep.EstoqueidEstoque = e.idEstoque
WHERE ep.quantidade > 10;