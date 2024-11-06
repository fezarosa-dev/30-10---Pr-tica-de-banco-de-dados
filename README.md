### Passo 1: Criação do banco de dados

```sql
-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS ClubeDoLivro;
USE ClubeDoLivro;
```

### Passo 2: Criação das tabelas

#### Tabela `Cliente`

```sql
-- Excluir a tabela Cliente caso ela já exista
DROP TABLE IF EXISTS Cliente;

-- Criar a tabela Cliente
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
```

#### Tabela `Editora`

```sql
-- Excluir a tabela Editora caso ela já exista
DROP TABLE IF EXISTS Editora;

-- Criar a tabela Editora
CREATE TABLE Editora (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255),
    Email VARCHAR(255),
    Telefone VARCHAR(20)
);
```

#### Tabela `Livro`

```sql
-- Excluir a tabela Livro caso ela já exista
DROP TABLE IF EXISTS Livro;

-- Criar a tabela Livro
CREATE TABLE Livro (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(255),
    Categoria VARCHAR(100),
    ISBN VARCHAR(20) UNIQUE,
    Ano_publicacao YEAR,
    Valor DECIMAL(10, 2),
    Editora_ID INT,
    FOREIGN KEY (Editora_ID) REFERENCES Editora(ID)
);
```

#### Tabela `Estoque`

```sql
-- Excluir a tabela Estoque caso ela já exista
DROP TABLE IF EXISTS Estoque;

-- Criar a tabela Estoque
CREATE TABLE Estoque (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Quantidade INT,
    Livro_ID INT,
    Editora_ID INT,
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID),
    FOREIGN KEY (Editora_ID) REFERENCES Editora(ID)
);
```

#### Tabela `Pedido`

```sql
-- Excluir a tabela Pedido caso ela já exista
DROP TABLE IF EXISTS Pedido;

-- Criar a tabela Pedido
CREATE TABLE Pedido (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Data_pedido DATE,
    Valor DECIMAL(10, 2),
    Cliente_ID INT,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(ID)
);
```

#### Tabela `Pedido_Livro`

```sql
-- Excluir a tabela Pedido_Livro caso ela já exista
DROP TABLE IF EXISTS Pedido_Livro;

-- Criar a tabela Pedido_Livro (relacionando os livros com os pedidos)
CREATE TABLE Pedido_Livro (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Pedido_ID INT,
    Livro_ID INT,
    Quantidade INT,
    FOREIGN KEY (Pedido_ID) REFERENCES Pedido(ID),
    FOREIGN KEY (Livro_ID) REFERENCES Livro(ID)
);
```

### Passo 3: Inserção de dados

#### Inserir dados na tabela `Cliente`

```sql
INSERT INTO Cliente (Nome, Endereco, Telefone, Email, Tipo_cliente, CPF, RG, CNPJ) 
VALUES 
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
```

#### Inserir dados na tabela `Editora`

```sql
INSERT INTO Editora (Nome, Email, Telefone) 
VALUES 
  ('Editora ABC', 'editorabc@email.com', '123456789'),
  ('Editora XYZ', 'editorxyz@email.com', '987654321');
```

#### Inserir dados na tabela `Livro`

```sql
INSERT INTO Livro (Titulo, Categoria, ISBN, Ano_publicacao, Valor, Editora_ID) 
VALUES 
  ('Livro A', 'Ficção', '978-3-16-148410-0', 2020, 50.00, 1),
  ('Livro B', 'Terror', '978-3-16-148411-7', 2021, 60.00, 2);
```

#### Inserir dados na tabela `Estoque`

```sql
INSERT INTO Estoque (Quantidade, Livro_ID, Editora_ID) 
VALUES 
  (100, 1, 1),
  (150, 2, 2);
```

#### Inserir dados na tabela `Pedido`

```sql
INSERT INTO Pedido (Data_pedido, Valor, Cliente_ID) 
VALUES 
  ('2024-11-01', 150.00, 1),
  ('2024-11-02', 120.00, 2);
```

#### Inserir dados na tabela `Pedido_Livro`

```sql
INSERT INTO Pedido_Livro (Pedido_ID, Livro_ID, Quantidade) 
VALUES 
  (1, 1, 2),
  (2, 2, 3);
```

### Passo 4: Consultas

#### Consulta 1: Mostrar todos os livros de um determinado cliente

```sql
SELECT c.Nome AS Cliente, l.Titulo AS Livro, pl.Quantidade 
FROM Pedido_Livro pl
JOIN Pedido p ON pl.Pedido_ID = p.ID
JOIN Cliente c ON p.Cliente_ID = c.ID
JOIN Livro l ON pl.Livro_ID = l.ID
WHERE c.Nome = 'João Silva';
```

**Explicação**: Essa consulta retorna o nome do cliente, o título dos livros e a quantidade desses livros no pedido de um cliente específico, no caso "João Silva".

#### Consulta 2: Mostrar livros e suas editoras

```sql
SELECT l.Titulo AS Livro, e.Nome AS Editora
FROM Livro l
JOIN Editora e ON l.Editora_ID = e.ID;
```

**Explicação**: Retorna o título dos livros e o nome da editora associada a cada um.

#### Consulta 3: Verificar o estoque disponível de um livro

```sql
SELECT l.Titulo AS Livro, e.Quantidade
FROM Estoque e
JOIN Livro l ON e.Livro_ID = l.ID;
```

**Explicação**: Mostra o título do livro e a quantidade disponível no estoque.

---

### Backup do banco de dados

No MySQL Workbench, siga esses passos para realizar o backup:

1. No menu **Server**, selecione **Data Export**.
2. Escolha o banco de dados `ClubeDoLivro` e marque as tabelas que deseja exportar.
3. Escolha o formato de exportação (por exemplo, `.sql`).
4. Clique em **Start Export** para gerar o backup.
