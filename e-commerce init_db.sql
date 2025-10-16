CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    country VARCHAR(100)
);

CREATE TABLE products (
    stock_code VARCHAR(20) PRIMARY KEY,
    description VARCHAR(255)
);

CREATE TABLE invoices (
    invoice_no VARCHAR(20) PRIMARY KEY,
    invoice_date DATETIME,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE invoice_items (
    invoice_no VARCHAR(20),
    stock_code VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10, 2),
    total_price DECIMAL(12, 2),
    PRIMARY KEY (invoice_no, stock_code),
    FOREIGN KEY (invoice_no) REFERENCES invoices(invoice_no),
    FOREIGN KEY (stock_code) REFERENCES products(stock_code)
);

DROP TABLE IF EXISTS raw_ecom;

CREATE TABLE raw_ecom (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100)
) ENGINE=InnoDB;
