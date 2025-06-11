-- Criação do banco de dados
CREATE DATABASE vendas_empresa;
USE vendas_empresa;

-- Tabela de Clientes
CREATE TABLE clientes (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    data_cadastro DATE DEFAULT CURRENT_DATE,
    cidade VARCHAR(50),
    estado CHAR(2),
    tipo_cliente ENUM('Pessoa Física', 'Pessoa Jurídica') DEFAULT 'Pessoa Física'
);

-- Tabela de Vendedores
CREATE TABLE vendedores (
    vendedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    data_admissao DATE,
    salario_base DECIMAL(10,2)
);

-- Tabela de Categorias de Produtos
CREATE TABLE categorias (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT
);

-- Tabela de Produtos
CREATE TABLE produtos (
    produto_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0,
    categoria_id INT,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

-- Tabela de Vendas
CREATE TABLE vendas (
    venda_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    vendedor_id INT,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pendente', 'Processando', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    total DECIMAL(12,2),
    forma_pagamento ENUM('Dinheiro', 'Cartão Crédito', 'Cartão Débito', 'Boleto', 'PIX'),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(vendedor_id)
);

-- Tabela de Itens de Venda
CREATE TABLE itens_venda (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    venda_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    desconto DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (venda_id) REFERENCES vendas(venda_id),
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

-- Inserção de dados de exemplo

-- Clientes
INSERT INTO clientes (nome, email, telefone, cidade, estado, tipo_cliente) VALUES
('João Silva', 'joao@email.com', '(11) 9999-8888', 'São Paulo', 'SP', 'Pessoa Física'),
('Maria Oliveira', 'maria@email.com', '(21) 7777-6666', 'Rio de Janeiro', 'RJ', 'Pessoa Física'),
('Empresa ABC Ltda', 'contato@abc.com', '(31) 5555-4444', 'Belo Horizonte', 'MG', 'Pessoa Jurídica'),
('Carlos Souza', 'carlos@email.com', '(41) 3333-2222', 'Curitiba', 'PR', 'Pessoa Física'),
('Ana Costa', 'ana@email.com', '(51) 1111-0000', 'Porto Alegre', 'RS', 'Pessoa Física');

-- Vendedores
INSERT INTO vendedores (nome, email, telefone, data_admissao, salario_base) VALUES
('Pedro Alves', 'pedro@empresa.com', '(11) 2222-3333', '2020-05-15', 2500.00),
('Fernanda Lima', 'fernanda@empresa.com', '(11) 4444-5555', '2021-02-10', 2800.00),
('Ricardo Santos', 'ricardo@empresa.com', '(11) 6666-7777', '2019-11-20', 3200.00);

-- Categorias
INSERT INTO categorias (nome, descricao) VALUES
('Eletrônicos', 'Produtos eletrônicos em geral'),
('Informática', 'Computadores, notebooks e acessórios'),
('Móveis', 'Móveis para escritório e residência'),
('Material Escritório', 'Materiais básicos para escritório');

-- Produtos
INSERT INTO produtos (nome, descricao, preco, estoque, categoria_id) VALUES
('Notebook Dell i7', 'Notebook Dell Inspiron com processador i7', 4500.00, 10, 2),
('Mouse sem fio', 'Mouse óptico sem fio', 120.00, 50, 2),
('Teclado mecânico', 'Teclado mecânico RGB', 350.00, 30, 2),
('Monitor 24"', 'Monitor LED 24 polegadas Full HD', 899.00, 15, 1),
('Cadeira Executiva', 'Cadeira giratória com ajuste de altura', 1200.00, 8, 3),
('Mesa para escritório', 'Mesa retangular 1,40m', 750.00, 12, 3),
('Pack canetas', 'Conjunto com 10 canetas esferográficas', 25.00, 100, 4),
('Grampeador', 'Grampeador de mesa', 18.50, 40, 4);

-- Vendas
INSERT INTO vendas (cliente_id, vendedor_id, data_venda, status, total, forma_pagamento) VALUES
(1, 1, '2023-01-15 10:30:00', 'Entregue', 4500.00, 'Cartão Crédito'),
(2, 2, '2023-01-16 14:15:00', 'Enviado', 1049.00, 'PIX'),
(3, 1, '2023-01-17 09:45:00', 'Processando', 1950.00, 'Boleto'),
(4, 3, '2023-01-18 16:20:00', 'Pendente', 350.00, 'Cartão Débito'),
(1, 2, '2023-01-19 11:10:00', 'Entregue', 43.50, 'Dinheiro');

-- Itens de Venda
INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario, desconto) VALUES
(1, 1, 1, 4500.00, 0.00),
(2, 4, 1, 899.00, 0.00),
(2, 2, 1, 120.00, 30.00),
(3, 5, 1, 1200.00, 0.00),
(3, 6, 1, 750.00, 0.00),
(4, 3, 1, 350.00, 0.00),
(5, 7, 1, 25.00, 0.00),
(5, 8, 1, 18.50, 0.00);
