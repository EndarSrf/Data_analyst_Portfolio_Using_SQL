SELECT COUNT(*) FROM raw_ecom;
SELECT * FROM raw_ecom
-- where InvoiceNo like 'C%'
LIMIT 5;


SELECT COUNT(*) FROM customers;
SELECT COUNT(*) from invoices;

INSERT IGNORE INTO customers (customer_id, country)
SELECT DISTINCT CustomerID, Country
FROM raw_ecom
WHERE CustomerID IS NOT NULL;


INSERT INTO products (stock_code, description)
SELECT StockCode, MIN(TRIM(Description))
FROM raw_ecom
WHERE StockCode IS NOT NULL
GROUP BY StockCode;

SELECT COUNT(*), COUNT(DISTINCT stock_code) FROM products;


INSERT INTO invoices (invoice_no, invoice_date, customer_id)
SELECT
    InvoiceNo,
    MIN(
        COALESCE(
            STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'),
            STR_TO_DATE(InvoiceDate, '%d/%m/%Y %H:%i'),
            STR_TO_DATE(InvoiceDate, '%Y-%m-%d %H:%i:%s')
        )
    ) AS invoice_date,
    MIN(CustomerID) AS customer_id
FROM raw_ecom
WHERE InvoiceNo IS NOT NULL
GROUP BY InvoiceNo;

-- cek:
SELECT COUNT(*) AS total_invoices FROM invoices;
SELECT invoice_date FROM invoices ORDER BY invoice_date LIMIT 5;
SELECT invoice_no FROM invoices GROUP BY invoice_no HAVING COUNT(*) > 1;


INSERT INTO invoice_items (invoice_no, stock_code, quantity, unit_price, total_price)
SELECT
    InvoiceNo,
    StockCode,
    SUM(Quantity) AS quantity,              -- jika produk muncul lebih dari 1 kali per invoice
    MAX(UnitPrice) AS unit_price,           -- biasanya sama, ambil 1 nilai
    SUM(Quantity * UnitPrice) AS total_price
FROM raw_ecom
WHERE InvoiceNo IS NOT NULL
  AND StockCode IS NOT NULL
  AND Quantity > 0
  AND UnitPrice > 0
GROUP BY InvoiceNo, StockCode;

-- cek hasil
SELECT COUNT(*) AS total_items FROM invoice_items;

-- contoh 5 baris pertama
SELECT * FROM invoice_items LIMIT 5;

-- Cek konsistensi Foreign Key
-- cek total nilai per invoice, bandingkan dengan invoices
SELECT invoice_no, SUM(total_price) AS total_value
FROM invoice_items
GROUP BY invoice_no
ORDER BY total_value DESC
LIMIT 10;

-- cek invoice_no yang tidak ada di tabel invoices
SELECT DISTINCT i.invoice_no
FROM invoice_items i
LEFT JOIN invoices inv ON i.invoice_no = inv.invoice_no
WHERE inv.invoice_no IS NULL;

-- cek stock_code yang tidak ada di tabel products
SELECT DISTINCT i.stock_code
FROM invoice_items i
LEFT JOIN products p ON i.stock_code = p.stock_code
WHERE p.stock_code IS NULL;
