-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS ClubeDoLivro;
USE ClubeDoLivro;

-- Remover as tabelas existentes, caso já existam (com CASCADE para remover as dependências)
DROP TABLE IF EXISTS pedido_livro CASCADE;
DROP TABLE IF EXISTS Pedido CASCADE;
DROP TABLE IF EXISTS Item_Pedido CASCADE;
DROP TABLE IF EXISTS Estoque CASCADE;
DROP TABLE IF EXISTS Livro CASCADE;
DROP TABLE IF EXISTS Editora CASCADE;
DROP TABLE IF EXISTS Cliente CASCADE;


-- Criação da tabela Cliente
CREATE TABLE Cliente (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Endereco VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(255),
    Tipo_cliente ENUM('PF', 'PJ'),
    CPF VARCHAR(14),
    RG VARCHAR(20),
    CNPJ VARCHAR(18)
);

-- Inserção de dados na tabela Cliente
INSERT INTO Cliente (Nome, Endereco, Telefone, Email, Tipo_cliente, CPF, RG, CNPJ) VALUES
('João Silva', 'Rua A, 123', '999999999', 'joao@email.com', 'PF', '123.456.789-00', 'MG1234567', NULL),
('Maria Oliveira', 'Rua B, 456', '988888888', 'maria@email.com', 'PF', '234.567.890-11', 'MG2345678', NULL),
('Empresa X', 'Av. C, 789', '977777777', 'empresa@x.com', 'PJ', NULL, NULL, '12.345.678/0001-99'),
('Carlos Lima', 'Rua D, 101', '966666666', 'carlos@email.com', 'PF', '345.678.901-22', 'MG3456789', NULL),
('Ana Souza', 'Rua E, 102', '955555555', 'ana@email.com', 'PF', '456.789.012-33', 'MG4567890', NULL),
('Livros ABC', 'Av. F, 202', '944444444', 'livros@abc.com', 'PJ', NULL, NULL, '23.456.789/0001-00'),
('Ricardo Costa', 'Rua G, 303', '933333333', 'ricardo@email.com', 'PF', '567.890.123-44', 'MG5678901', NULL),
('Juliana Mendes', 'Rua H, 404', '922222222', 'juliana@email.com', 'PF', '678.901.234-55', 'MG6789012', NULL),
('Editoras X', 'Rua I, 505', '911111111', 'editoras@x.com', 'PJ', NULL, NULL, '34.567.890/0001-11'),
('Paula Costa', 'Rua J, 606', '900000000', 'paula@email.com', 'PF', '789.012.345-66', 'MG7890123', NULL);

-- Criação da tabela Editora
CREATE TABLE Editora (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(255)
);

-- Inserção de dados na tabela Editora
INSERT INTO Editora (Nome, Telefone, Email) VALUES
('Editora A', '999999999', 'editoraA@email.com'),
('Editora B', '888888888', 'editoraB@email.com'),
('Editora C', '777777777', 'editoraC@email.com');

-- Criação da tabela Livro
CREATE TABLE Livro (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(255),
    Categoria VARCHAR(100),
    ISBN VARCHAR(20),
    Ano_Publicacao YEAR,
    Valor DECIMAL(10, 2),
    Editora_ID INT,
    FOREIGN KEY (Editora_ID) REFERENCES Editora(ID)
);

-- Inserção de dados na tabela Livro
INSERT INTO Livro (Titulo, Categoria, ISBN, Ano_Publicacao, Valor, Editora_ID) VALUES
('Livro 1', 'Ficção', '978-3-16-148410-0', 2020, 50.00, 1),
('Livro 2', 'Ficção', '978-1-40-289462-6', 2021, 45.00, 2),
('Livro 3', 'Não-ficção', '978-0-13-419044-0', 2019, 60.00, 3),
('Livro 4', 'Ficção', '978-0-14-017739-8', 2018, 40.00, 1),
('Livro 5', 'Aventura', '978-1-4028-9463-3', 2022, 70.00, 2),
('Livro 6', 'Romance', '978-0-452-28423-9', 2021, 55.00, 3),
('Livro 7', 'Suspense', '978-0-7432-7356-0', 2020, 65.00, 1),
('Livro 8', 'Ficção', '978-1-4000-3477-8', 2019, 50.00, 2),
('Livro 9', 'Drama', '978-0-385-47487-0', 2023, 80.00, 3),
('Livro 10', 'Aventura', '978-0-312-37969-1', 2021, 45.00, 1);

-- Criação da tabela Estoque
CREATE TABLE Estoque (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Livro_ID INT,
    Quantidade INT,
    Cod_Editora INT,
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID),
    FOREIGN KEY (Cod_Editora) REFERENCES Editora(ID)
);

-- Inserção de dados na tabela Estoque
INSERT INTO Estoque (Livro_ID, Quantidade, Cod_Editora) VALUES
(1, 10, 1),
(2, 5, 2),
(3, 3, 3),
(4, 7, 1),
(5, 6, 2),
(6, 8, 3),
(7, 9, 1),
(8, 4, 2),
(9, 11, 3),
(10, 5, 1);

-- Criação da tabela Pedido
CREATE TABLE Pedido (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Cliente_ID INT,
    Data_Pedido DATE,
    Valor DECIMAL(10, 2),
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);

-- Inserção de dados na tabela Pedido
INSERT INTO Pedido (Cliente_ID, Data_Pedido, Valor) VALUES
(1, '2024-11-01', 200.00),
(2, '2024-11-02', 150.00),
(3, '2024-11-03', 300.00),
(4, '2024-11-04', 250.00),
(5, '2024-11-05', 400.00),
(6, '2024-11-06', 350.00),
(7, '2024-11-07', 220.00),
(8, '2024-11-08', 180.00),
(9, '2024-11-09', 280.00),
(10, '2024-11-10', 220.00);

-- Criação da tabela Item_Pedido (entidade associativa entre Pedido e Livro)
CREATE TABLE Item_Pedido (
    Pedido_ID INT,
    Livro_ID INT,
    Quantidade INT,
    PRIMARY KEY (Pedido_ID, Livro_ID),
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID)
);

-- Inserção de dados na tabela Item_Pedido
INSERT INTO Item_Pedido (Pedido_ID, Livro_ID, Quantidade) VALUES
(1, 1, 2),
(1, 2, 3),
(2, 3, 1),
(2, 4, 2),
(3, 5, 4),
(3, 6, 1),
(4, 7, 2),
(4, 8, 1),
(5, 9, 3),
(5, 10, 2);

-- Consultas úteis

-- Consulta 1: Exibir todos os livros com seu título, categoria e editora
SELECT Livro.Titulo, Livro.Categoria, Editora.Nome
FROM Livro
JOIN Editora ON Livro.Editora_ID = Editora.ID;

-- Consulta 2: Exibir todos os pedidos de um cliente específico, incluindo o valor total
SELECT Pedido.ID, Pedido.Data_Pedido, Pedido.Valor
FROM Pedido
WHERE Pedido.Cliente_ID = 1;

-- Consulta 3: Exibir todos os livros comprados em um pedido específico
SELECT Livro.Titulo, Item_Pedido.Quantidade, Livro.Valor
FROM Item_Pedido
JOIN Livro ON Item_Pedido.Livro_ID = Livro.ID
WHERE Item_Pedido.Pedido_ID = 1;

-- Consulta 4: Exibir a quantidade de livros disponíveis em estoque
SELECT Livro.Titulo, Estoque.Quantidade
FROM Estoque
JOIN Livro ON Estoque.Livro_ID = Livro.ID;
