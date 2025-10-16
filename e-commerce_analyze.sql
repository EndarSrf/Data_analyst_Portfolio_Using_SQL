-- A. Analisis Base Sales
-- Total Revenue:
SELECT 
    ROUND(SUM(total_price), 2) AS total_revenue
FROM invoice_items;

-- Jumlah Transaksi dan Jumlah Customer
SELECT 
    COUNT(DISTINCT invoice_no) AS total_invoices,
    COUNT(DISTINCT customer_id) AS total_customers
FROM invoices;

-- total sold product:
SELECT 
    SUM(quantity) AS total_units_sold
FROM invoice_items;

-- B. Analysis Product
-- Top 10 Product by qty
SELECT 
   p.description,
    SUM(ii.quantity) AS total_quantity
FROM invoice_items ii
JOIN products p ON ii.stock_code = p.stock_code
GROUP BY p.description
ORDER BY total_quantity DESC
LIMIT 10;

SELECT 
    COALESCE(NULLIF(TRIM(p.description), ''), 'Unknown Product') AS description,
    SUM(ii.quantity) AS total_quantity
FROM invoice_items ii
JOIN products p ON ii.stock_code = p.stock_code
GROUP BY p.description
ORDER BY total_quantity DESC;


-- Top 10 highest revenue product
SELECT 
    p.description,
    ROUND(SUM(ii.total_price), 2) AS total_revenue
FROM invoice_items ii
JOIN products p ON ii.stock_code = p.stock_code
GROUP BY p.description
ORDER BY total_revenue DESC
LIMIT 10;

-- customers & country analysis
SELECT 
    c.country,
    ROUND(SUM(ii.total_price), 2) AS total_revenue
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
JOIN customers c ON i.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC
LIMIT 10;

-- top 10 best customers
SELECT 
    c.customer_id,
    c.country,
    ROUND(SUM(ii.total_price), 2) AS total_spent
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
JOIN customers c ON i.customer_id = c.customer_id
GROUP BY c.customer_id, c.country
ORDER BY total_spent DESC
LIMIT 10;

-- time analysis
-- monthly revenue
SELECT 
    DATE_FORMAT(i.invoice_date, '%Y-%m') AS month,
    ROUND(SUM(ii.total_price), 2) AS monthly_revenue
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
GROUP BY month
ORDER BY month;

-- daily revenue
SELECT 
    DATE(i.invoice_date) AS date,
    ROUND(SUM(ii.total_price), 2) AS daily_revenue
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
GROUP BY date
ORDER BY date;

-- aov
SELECT 
    c.customer_id,
    ROUND(SUM(ii.total_price) / COUNT(DISTINCT i.invoice_no), 2) AS avg_order_value
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
JOIN customers c ON i.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY avg_order_value DESC
LIMIT 10;

-- other insight
-- highest facture 
SELECT 
    i.invoice_no,
    ROUND(SUM(ii.total_price), 2) AS invoice_value,
    i.invoice_date,
    c.country
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
JOIN customers c ON i.customer_id = c.customer_id
GROUP BY i.invoice_no, i.invoice_date, c.country
ORDER BY invoice_value DESC
LIMIT 10;
