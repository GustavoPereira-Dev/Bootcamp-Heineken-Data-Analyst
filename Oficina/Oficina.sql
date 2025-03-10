-- Criação das Tabelas

-- Tabela ClienteO
CREATE TABLE ClienteO (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(13)
);

-- Tabela Veiculo
CREATE TABLE Veiculo (
    codigoVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    ClienteO_IdCliente INT NOT NULL,
    marca VARCHAR(45) NOT NULL,
    modelo VARCHAR(45) NOT NULL,
    cor VARCHAR(45),
    chassi VARCHAR(45) UNIQUE NOT NULL,
    tipo VARCHAR(45),
    FOREIGN KEY (ClienteO_IdCliente) REFERENCES ClienteO(IdCliente)
);

-- Tabela Equipe Mecanico
CREATE TABLE EquipeMecanico (
    codigoEquipe INT AUTO_INCREMENT PRIMARY KEY,
    quantMecanicos INT NOT NULL,
    disponibilidade VARCHAR(45) NOT NULL
);

-- Tabela Mecanico
CREATE TABLE Mecanico (
    codigoMecanico INT AUTO_INCREMENT PRIMARY KEY,
    EquipeMecanico_codigoEquipe INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    endereco VARCHAR(45),
    especialidade VARCHAR(45),
    FOREIGN KEY (EquipeMecanico_codigoEquipe) REFERENCES EquipeMecanico(codigoEquipe)
);

-- Tabela Ordem Servico
CREATE TABLE OrdemServico (
    nOS INT AUTO_INCREMENT PRIMARY KEY,
    EquipeMecanico_codigoEquipe INT NOT NULL,
    Veiculo_codigoVeiculo INT NOT NULL,
    ClienteO_IdCliente INT NOT NULL,
    dataEmissao DATE NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    dataConclusao DATE,
    FOREIGN KEY (EquipeMecanico_codigoEquipe) REFERENCES EquipeMecanico(codigoEquipe),
    FOREIGN KEY (Veiculo_codigoVeiculo) REFERENCES Veiculo(codigoVeiculo),
    FOREIGN KEY (ClienteO_IdCliente) REFERENCES ClienteO(IdCliente)
);

-- Tabela ServicoO
CREATE TABLE ServicoO (
    codigoServico INT AUTO_INCREMENT PRIMARY KEY,
    EquipeMecanico_codigoEquipe INT NOT NULL,
    tipoServico VARCHAR(45) NOT NULL,
    maoDeObra DECIMAL(10, 2),
    precoPecas DECIMAL(10, 2),
    FOREIGN KEY (EquipeMecanico_codigoEquipe) REFERENCES EquipeMecanico(codigoEquipe)
);

-- Tabela Ordem Servico ServicoO
CREATE TABLE OrdemServico_ServicoO (
    id INT AUTO_INCREMENT PRIMARY KEY,
    OrdemServico_nOS INT NOT NULL,
    ServicoO_codigoServico INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    FOREIGN KEY (OrdemServico_nOS) REFERENCES OrdemServico(nOS),
    FOREIGN KEY (ServicoO_codigoServico) REFERENCES ServicoO(codigoServico)
);

-- Inserção de Dados

-- Inserções na Tabela ClienteO
INSERT INTO ClienteO (nome, cpf, telefone) VALUES 
('João Silva', '12345678900', '11987654321'),
('Maria Oliveira', '98765432100', '11912345678'),
('Carlos Souza', '45678912399', '11945678912'),
('Ana Pereira', '78912345688', '11976543210');

-- Inserções na Tabela Veiculo
INSERT INTO Veiculo (ClienteO_IdCliente, marca, modelo, cor, chassi, tipo) VALUES 
(1, 'Toyota', 'Corolla', 'Branco', 'ABC123456DEF78901', 'Sedan'),
(2, 'Ford', 'Fiesta', 'Preto', 'XYZ123456LMN78902', 'Hatch'),
(3, 'Honda', 'Civic', 'Cinza', 'QWE123456RTY78903', 'Sedan'),
(4, 'Chevrolet', 'Onix', 'Vermelho', 'ASD123456FGH78904', 'Hatch');

-- Inserções na Tabela Equipe Mecanico
INSERT INTO EquipeMecanico (quantMecanicos, disponibilidade) VALUES 
(5, 'Disponível'),
(3, 'Disponível'),
(4, 'Indisponível'),
(2, 'Disponível');

-- Inserções na Tabela Mecanico
INSERT INTO Mecanico (EquipeMecanico_codigoEquipe, nome, endereco, especialidade) VALUES 
(1, 'Pedro Henrique', 'Rua A, 123', 'Suspensão'),
(1, 'Lucas Almeida', 'Rua B, 456', 'Freios'),
(2, 'Ricardo Santos', 'Rua C, 789', 'Motor'),
(3, 'Thiago Costa', 'Rua D, 101', 'Transmissão');

-- Inserções na Tabela Ordem Servico
INSERT INTO OrdemServico (EquipeMecanico_codigoEquipe, Veiculo_codigoVeiculo, ClienteO_IdCliente, dataEmissao, valor, status, dataConclusao) VALUES 
(1, 1, 1, '2025-03-01', 1500, 'Concluído', '2025-03-05'),
(2, 2, 2, '2025-03-10', 800, 'Em andamento', NULL),
(3, 3, 3, '2025-03-15', 300, 'Aguardando peças', NULL),
(1, 4, 4, '2025-03-20', 2000, 'Concluído', '2025-03-25');

-- Inserções na Tabela ServicoO
INSERT INTO ServicoO (EquipeMecanico_codigoEquipe, tipoServico, maoDeObra, precoPecas) VALUES 
(1, 'Troca de óleo', 150, 100.00),
(2, 'Substituição de pastilhas de freio', 200, 300.00),
(3, 'Reparo no motor', 500, 800.00),
(1, 'Alinhamento e balanceamento', 100, 0.00);

-- Inserções na Tabela Ordem Servico ServicoO
INSERT INTO OrdemServico_ServicoO (OrdemServico_nOS, ServicoO_codigoServico, quantidade) VALUES
(1, 1, 2),
(1, 4, 1),
(2, 2, 1),
(3, 3, 1),
(4, 1, 1);


-- Retornar o nome do cliente, a quantidade de ordens de serviço e o valor médio dessas ordens
SELECT ClienteO.nome AS NomeCliente, 
       COUNT(OrdemServico.nOS) AS TotalOrdens, 
       AVG(OrdemServico.valor) AS ValorMedio
FROM ClienteO
JOIN OrdemServico ON ClienteO.IdCliente = OrdemServico.ClienteO_IdCliente
GROUP BY ClienteO.nome;


-- Modelo do veículo, descrição do serviço e nome da equipe responsável por serviços concluídos
SELECT Veiculo.modelo AS ModeloVeiculo, 
       ServicoO.tipoServico AS DescricaoServico, 
       EquipeMecanico.codigoEquipe AS EquipeResponsavel
FROM Veiculo
JOIN OrdemServico ON Veiculo.codigoVeiculo = OrdemServico.Veiculo_codigoVeiculo
JOIN OrdemServico_ServicoO ON OrdemServico.nOS = OrdemServico_ServicoO.OrdemServico_nOS
JOIN ServicoO ON OrdemServico_ServicoO.ServicoO_codigoServico = ServicoO.codigoServico
JOIN EquipeMecanico ON ServicoO.EquipeMecanico_codigoEquipe = EquipeMecanico.codigoEquipe
WHERE OrdemServico.status = 'Concluído';


-- Veículos que têm mais de um serviço registrado em suas ordens
SELECT Veiculo.modelo AS Modelo, 
       COUNT(OrdemServico_ServicoO.ServicoO_codigoServico) AS TotalServicos
FROM Veiculo
JOIN OrdemServico ON Veiculo.codigoVeiculo = OrdemServico.Veiculo_codigoVeiculo
JOIN OrdemServico_ServicoO ON OrdemServico.nOS = OrdemServico_ServicoO.OrdemServico_nOS
GROUP BY Veiculo.modelo
HAVING COUNT(OrdemServico_ServicoO.ServicoO_codigoServico) > 1;


-- Qual equipe foi atribuída ao maior número de ordens de serviço
SELECT EquipeMecanico.codigoEquipe, 
       COUNT(OrdemServico.nOS) AS TotalOrdens
FROM EquipeMecanico
JOIN OrdemServico ON EquipeMecanico.codigoEquipe = OrdemServico.EquipeMecanico_codigoEquipe
GROUP BY EquipeMecanico.codigoEquipe
ORDER BY TotalOrdens DESC
LIMIT 1;


-- Listar os serviços mais caros realizados entre 1º de março e 31 de março de 2025
SELECT ServicoO.tipoServico AS Descricao, 
       (ServicoO.maoDeObra + ServicoO.precoPecas) AS CustoTotal, 
       OrdemServico.dataEmissao
FROM ServicoO
JOIN OrdemServico_ServicoO ON ServicoO.codigoServico = OrdemServico_ServicoO.ServicoO_codigoServico
JOIN OrdemServico ON OrdemServico.nOS = OrdemServico_ServicoO.OrdemServico_nOS
WHERE OrdemServico.dataEmissao BETWEEN '2025-03-01' AND '2025-03-31'
ORDER BY CustoTotal DESC;


-- Clientes que possuem veículos com ordens que ainda estão em andamento
SELECT DISTINCT ClienteO.nome AS NomeCliente, 
                Veiculo.modelo AS ModeloVeiculo, 
                OrdemServico.status AS StatusOrdem
FROM ClienteO
JOIN Veiculo ON ClienteO.IdCliente = Veiculo.ClienteO_IdCliente
JOIN OrdemServico ON Veiculo.codigoVeiculo = OrdemServico.Veiculo_codigoVeiculo
WHERE OrdemServico.status = 'Em andamento';


-- Faturamento total de serviços realizados por cada equipe
SELECT EquipeMecanico.codigoEquipe AS Equipe, 
       SUM((ServicoO.maoDeObra + ServicoO.precoPecas) * OrdemServico_ServicoO.quantidade) AS FaturamentoTotal
FROM EquipeMecanico
JOIN ServicoO ON EquipeMecanico.codigoEquipe = ServicoO.EquipeMecanico_codigoEquipe
JOIN OrdemServico_ServicoO ON ServicoO.codigoServico = OrdemServico_ServicoO.ServicoO_codigoServico
GROUP BY EquipeMecanico.codigoEquipe
ORDER BY FaturamentoTotal DESC;


-- Informações completas das ordens de serviço e serviços relacionados para um cliente específico
SELECT ClienteO.nome AS NomeCliente, 
       Veiculo.modelo AS ModeloVeiculo, 
       OrdemServico.dataEmissao, 
       ServicoO.tipoServico AS ServicoRealizado, 
       (ServicoO.maoDeObra + ServicoO.precoPecas) * OrdemServico_ServicoO.quantidade AS CustoTotal
FROM ClienteO
JOIN Veiculo ON ClienteO.IdCliente = Veiculo.ClienteO_IdCliente
JOIN OrdemServico ON Veiculo.codigoVeiculo = OrdemServico.Veiculo_codigoVeiculo
JOIN OrdemServico_ServicoO ON OrdemServico.nOS = OrdemServico_ServicoO.OrdemServico_nOS
JOIN ServicoO ON OrdemServico_ServicoO.ServicoO_codigoServico = ServicoO.codigoServico
WHERE ClienteO.nome = 'João Silva';

-- Listar ordens com seus serviços detalhados
SELECT OrdemServico.nOS AS NumeroOrdem, 
       ServicoO.tipoServico AS TipoServico,
       OrdemServico_ServicoO.quantidade AS Quantidade,
       (ServicoO.maoDeObra + ServicoO.precoPecas) * OrdemServico_ServicoO.quantidade AS CustoTotal
FROM OrdemServico
JOIN OrdemServico_ServicoO ON OrdemServico.nOS = OrdemServico_ServicoO.OrdemServico_nOS
JOIN ServicoO ON OrdemServico_ServicoO.ServicoO_codigoServico = ServicoO.codigoServico;

-- Custo total de serviços por ordem
SELECT OrdemServico.nOS AS NumeroOrdem,
       SUM((ServicoO.maoDeObra + ServicoO.precoPecas) * OrdemServico_ServicoO.quantidade) AS CustoTotalOrdem
FROM OrdemServico
JOIN OrdemServico_ServicoO ON OrdemServico.nOS = OrdemServico_ServicoO.OrdemServico_nOS
JOIN ServicoO ON OrdemServico_ServicoO.ServicoO_codigoServico = ServicoO.codigoServico
GROUP BY OrdemServico.nOS;

-- Serviços mais solicitados em ordens
SELECT ServicoO.tipoServico AS TipoServico,
       COUNT(OrdemServico_ServicoO.id) AS TotalSolicitacoes
FROM ServicoO
JOIN OrdemServico_ServicoO ON ServicoO.codigoServico = OrdemServico_ServicoO.ServicoO_codigoServico
GROUP BY ServicoO.tipoServico
ORDER BY TotalSolicitacoes DESC;


