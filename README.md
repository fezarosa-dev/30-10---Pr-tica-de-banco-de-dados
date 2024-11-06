### GRUPO: FELIPE Z. ROSA - BEATRIZ PINHEIRO LAMI



# ReadMe: Sistema de Gerenciamento de Clube do Livro

Este repositório contém o código de criação de um banco de dados para um **Clube do Livro**. O sistema gerencia informações sobre clientes, editoras, livros, estoque e pedidos. A seguir, é apresentado o passo a passo para configurar e usar o banco de dados.

---

## 1. Estrutura do Banco de Dados

### 1.1. Banco de Dados
- O código começa selecionando o banco de dados `clube_do_livro` para executar as consultas. Certifique-se de criar o banco de dados antes de rodar o código:
```sql
CREATE DATABASE clube_do_livro;
```

### 1.2. Tabelas Criadas
As tabelas que compõem o banco de dados são:

- **Cliente**: Armazena dados dos clientes, incluindo CPF, RG, CNPJ, entre outros.
- **Editora**: Contém informações das editoras, como nome, telefone e email.
- **Livro**: Detalha os livros, como título, categoria, ISBN, ano de publicação, preço e a editora associada.
- **Estoque**: Controla a quantidade disponível de cada livro em estoque.
- **Pedido**: Registra os pedidos feitos pelos clientes, com a data do pedido e o valor total.
- **Item_Pedido**: Relaciona os itens de cada pedido, informando quais livros foram comprados e suas quantidades.

---

## 2. Passo a Passo para Configuração e Execução

### 2.1. Selecionando o Banco de Dados
Após a criação do banco de dados, execute o comando para selecioná-lo:
```sql
USE clube_do_livro;
```

### 2.2. Criação das Tabelas

Execute os seguintes comandos SQL para criar as tabelas no banco de dados:

#### Cliente:
```sql
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
```

#### Editora:
```sql
CREATE TABLE Editora (
    ID INTEGER AUTO_INCREMENT,
    Nome VARCHAR(255),
    Telefone VARCHAR(20),
    Email VARCHAR(255),
    PRIMARY KEY(ID)
);
```

#### Livro:
```sql
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
```

#### Estoque:
```sql
CREATE TABLE Estoque (
    ID INTEGER AUTO_INCREMENT,
    Livro_ID INTEGER,
    Quantidade INTEGER,
    Cod_Editora INTEGER,
    PRIMARY KEY(ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID),
    FOREIGN KEY (Cod_Editora) REFERENCES Editora(ID)
);
```

#### Pedido:
```sql
CREATE TABLE Pedido (
    ID INTEGER AUTO_INCREMENT,
    Cliente_ID INTEGER,
    Data_Pedido DATE,
    Valor DECIMAL,
    PRIMARY KEY(ID),
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);
```

#### Item_Pedido:
```sql
CREATE TABLE Item_Pedido (
    Pedido_ID INTEGER,
    Livro_ID INTEGER,
    Quantidade INTEGER,
    PRIMARY KEY(Pedido_ID, Livro_ID),
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID)
);
```

---

## 3. Inserção de Dados

Após a criação das tabelas, insira os dados de exemplo para popular as tabelas:

### 3.1. Inserção de Dados na Tabela Cliente
```sql
INSERT INTO Cliente (Nome, Endereco, Telefone, Email, Tipo_cliente, CPF, RG, CNPJ) VALUES
('João Silva', 'Rua A, 123', '123456789', 'joao@example.com', 'PF', '123.456.789-00', 'MG1234567', NULL),
('Maria Oliveira', 'Rua B, 456', '987654321', 'maria@example.com', 'PF', '987.654.321-00', 'SP9876543', NULL),
-- (Outros dados omitidos por brevidade)
```

### 3.2. Inserção de Dados na Tabela Editora
```sql
INSERT INTO Editora (Nome, Telefone, Email) VALUES
('Editora ABC', '123456789', 'contato@abc.com'),
('Editora XYZ', '987654321', 'contato@xyz.com'),
-- (Outros dados omitidos por brevidade)
```

### 3.3. Inserção de Dados na Tabela Livro
```sql
INSERT INTO Livro (Titulo, Categoria, ISBN, Ano_Publicacao, Valor, Editora_ID) VALUES
('O Hobbit', 'Fantasia', '1234567890', 1937, 59.90, 1),
('Harry Potter', 'Fantasia', '0987654321', 1997, 79.90, 2),
-- (Outros dados omitidos por brevidade)
```

### 3.4. Inserção de Dados na Tabela Estoque
```sql
INSERT INTO Estoque (Livro_ID, Quantidade, Cod_Editora) VALUES
(1, 50, 1),
(2, 30, 2),
-- (Outros dados omitidos por brevidade)
```

### 3.5. Inserção de Dados na Tabela Pedido
```sql
INSERT INTO Pedido (Cliente_ID, Data_Pedido, Valor) VALUES
(1, '2024-10-01', 150.00),
(2, '2024-10-02', 200.00),
-- (Outros dados omitidos por brevidade)
```

### 3.6. Inserção de Dados na Tabela Item_Pedido
```sql
INSERT INTO Item_Pedido (Pedido_ID, Livro_ID, Quantidade) VALUES
(1, 1, 2),
(1, 2, 1),
-- (Outros dados omitidos por brevidade)
```

---

*** CONSULTAS

### 1. **Listar todos os livros com suas respectivas editoras e estoque disponível**
```sql
SELECT 
    Livro.Titulo, 
    Livro.Categoria, 
    Livro.ISBN, 
    Livro.Ano_Publicacao, 
    Livro.Valor, 
    Editora.Nome AS Editora, 
    Estoque.Quantidade AS Estoque_Disponivel
FROM 
    Livro
JOIN 
    Editora ON Livro.Editora_ID = Editora.ID
JOIN 
    Estoque ON Livro.ID = Estoque.Livro_ID;
```
**Explicação**:  
Esta consulta retorna informações sobre todos os livros, incluindo título, categoria, ISBN, ano de publicação, preço, nome da editora e a quantidade disponível em estoque. Ela usa `JOIN` para combinar as tabelas `Livro`, `Editora` e `Estoque`.

**Dados esperados**:
- Título, categoria, ISBN, ano de publicação, valor, nome da editora e quantidade disponível no estoque de cada livro.

---

### 2. **Listar pedidos feitos por um cliente específico**
```sql
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
```
**Explicação**:  
Esta consulta retorna os pedidos feitos por um cliente específico (no caso, 'João Silva'). Ela retorna o ID do pedido, a data do pedido, o valor total do pedido e o nome do cliente. O `JOIN` entre as tabelas `Pedido` e `Cliente` é feito usando o `Cliente_ID`.

**Dados esperados**:
- ID do pedido, data do pedido, valor do pedido e nome do cliente para todos os pedidos feitos por "João Silva".

---

### 3. **Total de livros vendidos por pedido**
```sql
SELECT 
    Pedido.ID AS Pedido_ID, 
    SUM(Item_Pedido.Quantidade) AS Total_Livros_Vendidos
FROM 
    Item_Pedido
JOIN 
    Pedido ON Item_Pedido.Pedido_ID = Pedido.ID
GROUP BY 
    Pedido.ID;
```
**Explicação**:  
Esta consulta retorna o número total de livros vendidos por pedido. Ela utiliza o `SUM` para somar as quantidades de livros em cada pedido e agrupa os resultados por `Pedido_ID`.

**Dados esperados**:
- ID do pedido e o total de livros vendidos para cada pedido.

---

### 4. **Clientes que compraram livros de uma editora específica**
```sql
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
```
**Explicação**:  
Esta consulta retorna os clientes que compraram livros da "Editora ABC" (Editora com ID 1). Ela faz `JOIN` entre as tabelas `Cliente`, `Pedido`, `Item_Pedido` e `Livro` para relacionar as compras com os clientes e livros da editora especificada.

**Dados esperados**:
- Nome do cliente, ID do pedido e data do pedido para todos os pedidos feitos com livros da editora "Editora ABC".

---

### 5. **Valor total gasto por cada cliente**
```sql
SELECT 
    Cliente.Nome AS Cliente_Nome, 
    SUM(Pedido.Valor) AS Total_Gasto
FROM 
    Cliente
JOIN 
    Pedido ON Cliente.ID = Pedido.Cliente_ID
GROUP BY 
    Cliente.ID;
```
**Explicação**:  
Esta consulta calcula o valor total gasto por cada cliente. Ela usa o `SUM` para somar os valores dos pedidos de cada cliente e agrupa os resultados por `Cliente_ID`.

**Dados esperados**:
- Nome do cliente e o total gasto por cada um.

---

### 6. **Livros mais vendidos (com base no número de unidades vendidas)**
```sql
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
```
**Explicação**:  
Esta consulta retorna os 5 livros mais vendidos, com base no total de unidades vendidas. Ela soma as quantidades de livros vendidas e ordena o resultado pela quantidade total de forma decrescente (`DESC`).

**Dados esperados**:
- Título do livro e o número total de unidades vendidas dos 5 livros mais vendidos.

---

### 7. **Quantidade de livros em estoque por editora**
```sql
SELECT 
    Editora.Nome AS Editora_Nome, 
    SUM(Estoque.Quantidade) AS Total_Em_Estoque
FROM 
    Editora
JOIN 
    Estoque ON Editora.ID = Estoque.Cod_Editora
GROUP BY 
    Editora.ID;
```
**Explicação**:  
Esta consulta retorna a quantidade total de livros em estoque para cada editora. Ela utiliza a função `SUM` para somar as quantidades de livros em estoque, agrupadas por editora.

**Dados esperados**:
- Nome da editora e a quantidade total de livros em estoque.

---

### 8. **Detalhes do pedido (livros e quantidades)**
```sql
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
```
**Explicação**:  
Esta consulta retorna os detalhes do pedido com ID 1, incluindo os títulos dos livros e as quantidades de cada livro no pedido. Ela faz `JOIN` entre as tabelas `Pedido`, `Item_Pedido` e `Livro`.

**Dados esperados**:
- ID do pedido, título dos livros e quantidade de cada livro no pedido.
