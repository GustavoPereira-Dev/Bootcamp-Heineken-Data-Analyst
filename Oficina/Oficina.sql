-- Criação das tabelas

CREATE TABLE Cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF VARCHAR(14) UNIQUE NOT NULL,
    Telefone VARCHAR(15)
);

CREATE TABLE Veiculo (
    VeiculoID INT AUTO_INCREMENT PRIMARY KEY,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Cor VARCHAR(30),
    Chassi VARCHAR(17) UNIQUE NOT NULL,
    Tipo VARCHAR(30),
    ClienteID INT NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID)
);

CREATE TABLE EquipeMecanico (
    EquipeID INT AUTO_INCREMENT PRIMARY KEY,
    QuantidadeMecanicos INT NOT NULL,
    Disponibilidade BOOLEAN NOT NULL
);

CREATE TABLE Mecanico (
    MecanicoID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(200),
    Especialidade VARCHAR(50),
    EquipeID INT NOT NULL,
    FOREIGN KEY (EquipeID) REFERENCES EquipeMecanico(EquipeID)
);

CREATE TABLE OrdemServico (
    OrdemID INT AUTO_INCREMENT PRIMARY KEY,
    DataEmissao DATE NOT NULL,
    Valor DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    DataConclusao DATE,
    ClienteID INT NOT NULL,
    VeiculoID INT NOT NULL,
    EquipeID INT NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Cliente(ClienteID),
    FOREIGN KEY (VeiculoID) REFERENCES Veiculo(VeiculoID),
    FOREIGN KEY (EquipeID) REFERENCES EquipeMecanico(EquipeID)
);

CREATE TABLE Servico (
    ServicoID INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(200) NOT NULL,
    MaoDeObra DECIMAL(10, 2),
    PrecoPecas DECIMAL(10, 2),
    OrdemID INT NOT NULL,
    EquipeID INT NOT NULL,
    FOREIGN KEY (OrdemID) REFERENCES OrdemServico(OrdemID),
    FOREIGN KEY (EquipeID) REFERENCES EquipeMecanico(EquipeID)
);

-- Inserção de dados

INSERT INTO Cliente (Nome, CPF, Telefone) VALUES 
('João Silva', '123.456.789-00', '(11) 98765-4321'),
('Maria Oliveira', '987.654.321-00', '(11) 91234-5678'),
('Carlos Souza', '456.789.123-99', '(11) 94567-8912'),
('Ana Pereira', '789.123.456-88', '(11) 97654-3210');

INSERT INTO Veiculo (Marca, Modelo, Cor, Chassi, Tipo, ClienteID) VALUES 
('Toyota', 'Corolla', 'Branco', 'ABC123456DEF78901', 'Sedan', 1),
('Ford', 'Fiesta', 'Preto', 'XYZ123456LMN78902', 'Hatch', 2),
('Honda', 'Civic', 'Cinza', 'QWE123456RTY78903', 'Sedan', 3),
('Chevrolet', 'Onix', 'Vermelho', 'ASD123456FGH78904', 'Hatch', 4);

INSERT INTO EquipeMecanico (QuantidadeMecanicos, Disponibilidade) VALUES 
(5, TRUE),
(3, TRUE),
(4, FALSE),
(2, TRUE);

INSERT INTO Mecanico (Nome, Endereco, Especialidade, EquipeID) VALUES 
('Pedro Henrique', 'Rua A, 123', 'Suspensão', 1),
('Lucas Almeida', 'Rua B, 456', 'Freios', 1),
('Ricardo Santos', 'Rua C, 789', 'Motor', 2),
('Thiago Costa', 'Rua D, 101', 'Transmissão', 3);

INSERT INTO OrdemServico (DataEmissao, Valor, Status, DataConclusao, ClienteID, VeiculoID, EquipeID) VALUES 
('2025-03-01', 1500.00, 'Concluído', '2025-03-05', 1, 1, 1),
('2025-03-10', 800.00, 'Em andamento', NULL, 2, 2, 2),
('2025-03-15', 300.00, 'Aguardando peças', NULL, 3, 3, 3),
('2025-03-20', 2000.00, 'Concluído', '2025-03-25', 4, 4, 1);

INSERT INTO Servico (Descricao, MaoDeObra, PrecoPecas, OrdemID, EquipeID) VALUES 
('Troca de óleo', 150.00, 100.00, 1, 1),
('Substituição de pastilhas de freio', 200.00, 300.00, 2, 2),
('Reparo no motor', 500.00, 800.00, 3, 3),
('Alinhamento e balanceamento', 100.00, 0.00, 4, 1);

-- Consultas (Queries)

SELECT Cliente.Nome AS ClienteNome, Veiculo.Modelo AS VeiculoModelo, OrdemServico.Status AS StatusOrdem
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID;

SELECT OrdemID, DataEmissao, Valor, Status
FROM OrdemServico
WHERE DataEmissao > '2025-03-01' AND Valor > 1000.00;

SELECT Descricao, MaoDeObra, PrecoPecas, 
       (MaoDeObra + PrecoPecas) AS CustoTotal
FROM Servico;

SELECT Nome, Especialidade, EquipeID
FROM Mecanico
ORDER BY Nome ASC, Especialidade ASC;

SELECT EquipeID, QuantidadeMecanicos, Disponibilidade
FROM EquipeMecanico
GROUP BY EquipeID, QuantidadeMecanicos, Disponibilidade
HAVING QuantidadeMecanicos > 3 AND Disponibilidade = TRUE;

SELECT Cliente.Nome AS ClienteNome, Veiculo.Modelo AS VeiculoModelo, Servico.Descricao AS ServicoDescricao, 
       (Servico.MaoDeObra + Servico.PrecoPecas) AS CustoTotal
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID
JOIN Servico ON OrdemServico.OrdemID = Servico.OrdemID;

SELECT Cliente.Nome AS NomeCliente, 
       COUNT(OrdemServico.OrdemID) AS TotalOrdens, 
       AVG(OrdemServico.Valor) AS ValorMedio
FROM Cliente
JOIN OrdemServico ON Cliente.ClienteID = OrdemServico.ClienteID
GROUP BY Cliente.Nome;

SELECT Veiculo.Modelo AS ModeloVeiculo, Servico.Descricao AS DescricaoServico, EquipeMecanico.EquipeID AS EquipeResponsavel
FROM Veiculo
JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID
JOIN Servico ON OrdemServico.OrdemID = Servico.OrdemID
JOIN EquipeMecanico ON Servico.EquipeID = EquipeMecanico.EquipeID
WHERE OrdemServico.Status = 'Concluído';


SELECT Veiculo.Modelo, COUNT(Servico.ServicoID) AS TotalServicos
FROM Veiculo
JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID
JOIN Servico ON OrdemServico.OrdemID = Servico.OrdemID
GROUP BY Veiculo.Modelo
HAVING COUNT(Servico.ServicoID) > 1;

SELECT EquipeMecanico.EquipeID, COUNT(OrdemServico.OrdemID) AS TotalOrdens
FROM EquipeMecanico
JOIN OrdemServico ON EquipeMecanico.EquipeID = OrdemServico.EquipeID
GROUP BY EquipeMecanico.EquipeID
ORDER BY TotalOrdens DESC
LIMIT 1;

SELECT Servico.Descricao, 
       (Servico.MaoDeObra + Servico.PrecoPecas) AS CustoTotal, 
       OrdemServico.DataEmissao
FROM Servico
JOIN OrdemServico ON Servico.OrdemID = OrdemServico.OrdemID
WHERE OrdemServico.DataEmissao BETWEEN '2025-03-01' AND '2025-03-31'
ORDER BY CustoTotal DESC;

SELECT DISTINCT Cliente.Nome AS NomeCliente, Veiculo.Modelo AS ModeloVeiculo, OrdemServico.Status
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID
WHERE OrdemServico.Status = 'Em andamento';

SELECT EquipeMecanico.EquipeID AS Equipe, SUM(Servico.MaoDeObra + Servico.PrecoPecas) AS FaturamentoTotal
FROM EquipeMecanico
JOIN Servico ON EquipeMecanico.EquipeID = Servico.EquipeID
GROUP BY EquipeMecanico.EquipeID
ORDER BY FaturamentoTotal DESC;

SELECT Cliente.Nome AS NomeCliente, 
       Veiculo.Modelo AS ModeloVeiculo, 
       OrdemServico.DataEmissao, 
       Servico.Descricao AS ServicoRealizado, 
       (Servico.MaoDeObra + Servico.PrecoPecas) AS CustoTotal
FROM Cliente
JOIN Veiculo ON Cliente.ClienteID = Veiculo.ClienteID
JOIN OrdemServico ON Veiculo.VeiculoID = OrdemServico.VeiculoID
JOIN Servico ON OrdemServico.OrdemID = Servico.OrdemID
WHERE Cliente.Nome = 'João Silva';

