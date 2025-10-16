SQL Project: E-Commerce Sales Analysis
📘 Deskripsi Proyek
Proyek ini bertujuan untuk menganalisis data penjualan dari sebuah toko online menggunakan MySQL.
Data yang digunakan berasal dari dataset E-Commerce (transaksi tahun 2010–2011), yang berisi informasi tentang pelanggan, produk, dan pesanan.

Tujuan utama proyek ini adalah:
Membangun database relasional untuk data e-commerce.
Melakukan analisis data penjualan menggunakan query SQL.
Menemukan insight bisnis seperti produk terlaris, negara dengan pendapatan terbesar, dan tren penjualan per bulan.

🗂️ Struktur Database
Database bernama ecommerce terdiri dari empat tabel utama:
Tabel	Deskripsi
customers	Menyimpan data pelanggan (ID dan negara).
products	Menyimpan data produk (kode dan deskripsi).
invoices	Menyimpan data transaksi/faktur.
invoice_items	Menyimpan detail item per transaksi (produk, jumlah, harga, total).
🔗 Relasi Antar Tabel
customers (1) ───< invoices (N)
products  (1) ───< invoice_items (N)
invoices  (1) ───< invoice_items (N)

Artinya:
Satu pelanggan bisa memiliki banyak invoice.
Satu produk bisa muncul di banyak invoice item.
Satu invoice bisa berisi banyak item produk.

⚙️ Langkah-Langkah Proyek
Membuat Database dan Tabel
Membuat tabel customers, products, invoices, dan invoice_items di MySQL.
Import Data Mentah (CSV)
Dataset raw_ecom.csv diimpor ke tabel sementara raw_ecom.
Data Cleaning dan Transformasi
Menghapus duplikasi.
Memisahkan data ke tabel sesuai entitas (produk, pelanggan, transaksi, dan item).

Analisis Data Menggunakan Query SQL
Membuat query untuk menghitung metrik penting dan mendapatkan insight bisnis.
🧮 Analisis SQL
1️⃣ Total Pendapatan Keseluruhan
SELECT ROUND(SUM(total_price), 2) AS total_revenue
FROM invoice_items;

2️⃣ Top 10 Produk Terlaris
SELECT p.description, SUM(ii.quantity) AS total_quantity
FROM invoice_items ii
JOIN products p ON ii.stock_code = p.stock_code
GROUP BY p.description
ORDER BY total_quantity DESC
LIMIT 10;

3️⃣ Pendapatan per Bulan
SELECT DATE_FORMAT(i.invoice_date, '%Y-%m') AS month,
       ROUND(SUM(ii.total_price), 2) AS monthly_revenue
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
GROUP BY month
ORDER BY month;

4️⃣ Top 10 Negara dengan Pendapatan Tertinggi
SELECT c.country, ROUND(SUM(ii.total_price), 2) AS total_revenue
FROM invoice_items ii
JOIN invoices i ON ii.invoice_no = i.invoice_no
JOIN customers c ON i.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC
LIMIT 10;

📊 Insight yang Ditemukan
Beberapa hasil dari analisis:
Produk dengan penjualan tertinggi adalah produk dekorasi dan perlengkapan rumah.
Negara dengan pendapatan tertinggi adalah United Kingdom, karena mayoritas transaksi berasal dari sana.
Pendapatan meningkat menjelang akhir tahun (bulan November–Desember).
Sebagian besar pelanggan melakukan pembelian dalam jumlah kecil namun sering.

🧠 Kesimpulan
Proyek ini membantu memahami:
Cara merancang database relasional dari data mentah.
Cara melakukan analisis bisnis menggunakan SQL Query.
Pentingnya data cleaning sebelum melakukan analisis.

Langkah berikutnya:
Data hasil query ini bisa digunakan untuk membuat dashboard interaktif di Power BI sebagai kelanjutan proyek portofolio.
📂 Struktur Folder (di GitHub)
📁 sql-ecommerce-project
├── 📄 README.md
├── 📄 ecommerce_schema.sql
├── 📄 analysis_queries.sql
└── 📄 raw_ecom.csv

💡 Tools yang Digunakan:
MySQL (Database utama)
DBeaver (SQL Editor)
