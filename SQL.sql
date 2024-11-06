-- Seleciona o banco de dados correto (substitua "aaaa" pelo nome do seu banco de dados)
USE clube_do_livro;

-- Criação da tabela Cliente
CREATE TABLE Cliente (
    ID INTEGER AUTO_INCREMENT,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(255),
    Tipo_cliente ENUM('PF', 'PJ'),
    CPF VARCHAR(14),
    RG VARCHAR(20),
    CNPJ VARCHAR(18),
    PRIMARY KEY(ID)
); 

-- Criação da tabela Editora
CREATE TABLE Editora (
    ID INTEGER AUTO_INCREMENT,
    Nome VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(255),
    PRIMARY KEY(ID)
);

-- Criação da tabela Livro
CREATE TABLE Livro (
    ID INTEGER AUTO_INCREMENT,
    Titulo VARCHAR(255),
    Categoria VARCHAR(100),
    ISBN VARCHAR(20),
    Ano_Publicacao INT,
    Valor DECIMAL,
    Editora_ID INTEGER,
    PRIMARY KEY(ID),
    FOREIGN KEY (Editora_ID) REFERENCES Editora(ID)
);

-- Criação da tabela Estoque
CREATE TABLE Estoque (
    ID INTEGER AUTO_INCREMENT,
    Livro_ID INTEGER,
    Quantidade INTEGER,
    Cod_Editora INTEGER,
    PRIMARY KEY(ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID),
    FOREIGN KEY (Cod_Editora) REFERENCES Editora(ID)
);

-- Criação da tabela Pedido
CREATE TABLE Pedido (
    ID INTEGER AUTO_INCREMENT,
    Cliente_ID INTEGER,
    Data_Pedido DATE,
    Valor DECIMAL,
    PRIMARY KEY(ID),
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

-- Criação da tabela Item_Pedido
CREATE TABLE Item_Pedido (
    Pedido_ID INTEGER,
    Livro_ID INTEGER,
    Quantidade INTEGER,
    PRIMARY KEY(Pedido_ID, Livro_ID),
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID)
);

-- Inserção de dados na tabela Cliente
INSERT INTO Cliente (Nome, Endereco, Telefone, Email, Tipo_cliente, CPF, RG, CNPJ) VALUES
('João Silva', 'Rua A, 123', '123456789', 'joao@example.com', 'PF', '123.456.789-00', 'MG1234567', NULL),
('Maria Oliveira', 'Rua B, 456', '987654321', 'maria@example.com', 'PF', '987.654.321-00', 'SP9876543', NULL),
('Pedro Costa', 'Rua C, 789', '112233445', 'pedro@example.com', 'PF', '112.233.445-00', 'RJ1122334', NULL),
('Ana Santos', 'Rua D, 101', '223344556', 'ana@example.com', 'PF', '223.344.556-00', 'BA2233445', NULL),
('Carlos Pereira', 'Rua E, 202', '334455667', 'carlos@example.com', 'PF', '334.455.667-00', 'MG3344556', NULL),
('Luciana Almeida', 'Rua F, 303', '445566778', 'luciana@example.com', 'PF', '445.566.778-00', 'SP4455667', NULL),
('Giovanni Rodrigues', 'Rua G, 404', '556677889', 'giovanni@example.com', 'PF', '556.677.889-00', 'RJ5566778', NULL),
('Fernanda Lima', 'Rua H, 505', '667788990', 'fernanda@example.com', 'PF', '667.788.990-00', 'BA6677889', NULL),
('Paulo Silva', 'Rua I, 606', '778899001', 'paulo@example.com', 'PF', '778.899.001-00', 'MG7788990', NULL),
('Ricardo Pereira', 'Rua J, 707', '889900112', 'ricardo@example.com', 'PF', '889.900.112-00', 'SP8899001', NULL);

-- Inserção de dados na tabela Editora
INSERT INTO Editora (Nome, Telefone, Email) VALUES
('Editora ABC', '123456789', 'contato@abc.com'),
('Editora XYZ', '987654321', 'contato@xyz.com'),
('Editora Lua', '223344556', 'contato@lua.com'),
('Editora Sol', '334455667', 'contato@sol.com'),
('Editora Estrela', '445566778', 'contato@estrela.com'),
('Editora Mundo', '556677889', 'contato@mundo.com'),
('Editora Fênix', '667788990', 'contato@fenix.com'),
('Editora Brisa', '778899001', 'contato@brisa.com'),
('Editora Mar', '889900112', 'contato@mar.com'),
('Editora Vento', '990011223', 'contato@vento.com');

-- Inserção de dados na tabela Livro
INSERT INTO Livro (Titulo, Categoria, ISBN, Ano_Publicacao, Valor, Editora_ID) VALUES
('O Hobbit', 'Fantasia', '1234567890', 1937, 59.90, 1),
('Harry Potter', 'Fantasia', '0987654321', 1997, 79.90, 2),
('Dom Casmurro', 'Literatura', '1122334455', 1900, 39.90, 3),
('O Primo Basílio', 'Literatura', '2233445566', 1878, 49.90, 4),
('1984', 'Ficção Científica', '3344556677', 1949, 29.90, 5),
('A Metamorfose', 'Literatura', '4455667788', 1915, 19.90, 6),
('Cem Anos de Solidão', 'Romance', '5566778899', 1967, 89.90, 7),
('O Senhor dos Anéis', 'Fantasia', '6677889900', 1954, 99.90, 8),
('Moby Dick', 'Aventura', '7788990011', 1851, 59.90, 9),
('A Moreninha', 'Romance', '8899001122', 1900, 19.90, 10);

-- Inserção de dados na tabela Estoque
INSERT INTO Estoque (Livro_ID, Quantidade, Cod_Editora) VALUES
(1, 50, 1),
(2, 30, 2),
(3, 20, 3),
(4, 10, 4),
(5, 40, 5),
(6, 60, 6),
(7, 25, 7),
(8, 15, 8),
(9, 35, 9),
(10, 45, 10);

-- Inserção de dados na tabela Pedido
INSERT INTO Pedido (Cliente_ID, Data_Pedido, Valor) VALUES
(1, '2024-10-01', 150.00),
(2, '2024-10-02', 200.00),
(3, '2024-10-03', 120.00),
(4, '2024-10-04', 180.00),
(5, '2024-10-05', 220.00),
(6, '2024-10-06', 140.00),
(7, '2024-10-07', 160.00),
(8, '2024-10-08', 190.00),
(9, '2024-10-09', 210.00),
(10, '2024-10-10', 230.00);

-- Inserção de dados na tabela Item_Pedido
INSERT INTO Item_Pedido (Pedido_ID, Livro_ID, Quantidade) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(3, 5, 2),
(3, 6, 1),
(4, 7, 1),
(4, 8, 1),
(5, 9, 2),
(5, 10, 1);
SELECT 
    Pedido.ID AS Pedido_ID, 
    Pedido.Data_Pedido, 
    Pedido.Valor, 
    Cliente.Nome AS Cliente_Nome
FROM 
    Pedido
JOIN 
    Cliente ON Pedido.Cliente_ID = Cliente.ID
WHERE 
    Cliente.Nome = 'João Silva';
    SELECT 
    Pedido.ID AS Pedido_ID, 
    SUM(Item_Pedido.Quantidade) AS Total_Livros_Vendidos
FROM 
    Item_Pedido
JOIN 
    Pedido ON Item_Pedido.Pedido_ID = Pedido.ID
GROUP BY 
    Pedido.ID;
    SELECT 
    Cliente.Nome AS Cliente_Nome, 
    Pedido.ID AS Pedido_ID, 
    Pedido.Data_Pedido
FROM 
    Cliente
JOIN 
    Pedido ON Cliente.ID = Pedido.Cliente_ID
JOIN 
    Item_Pedido ON Pedido.ID = Item_Pedido.Pedido_ID
JOIN 
    Livro ON Item_Pedido.Livro_ID = Livro.ID
WHERE 
    Livro.Editora_ID = 1;  -- Editora ABC
    
    SELECT 
    Cliente.Nome AS Cliente_Nome, 
    SUM(Pedido.Valor) AS Total_Gasto
FROM 
    Cliente
JOIN 
    Pedido ON Cliente.ID = Pedido.Cliente_ID
GROUP BY 
    Cliente.ID;
    
    SELECT 
    Livro.Titulo, 
    SUM(Item_Pedido.Quantidade) AS Total_Vendido
FROM 
    Livro
JOIN 
    Item_Pedido ON Livro.ID = Item_Pedido.Livro_ID
GROUP BY 
    Livro.ID
ORDER BY 
    Total_Vendido DESC
LIMIT 5;

SELECT 
    Editora.Nome AS Editora_Nome, 
    SUM(Estoque.Quantidade) AS Total_Em_Estoque
FROM 
    Editora
JOIN 
    Estoque ON Editora.ID = Estoque.Cod_Editora
GROUP BY 
    Editora.ID;
    
    SELECT 
    Pedido.ID AS Pedido_ID, 
    Livro.Titulo, 
    Item_Pedido.Quantidade
FROM 
    Pedido
JOIN 
    Item_Pedido ON Pedido.ID = Item_Pedido.Pedido_ID
JOIN 
    Livro ON Item_Pedido.Livro_ID = Livro.ID
WHERE 
    Pedido.ID = 1;