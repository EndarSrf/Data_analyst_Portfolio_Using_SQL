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
2️⃣ Top 10 Produk Terlaris  
3️⃣ Pendapatan per Bulan  
4️⃣ Top 10 Negara dengan Pendapatan Tertinggi  

📊 Insight yang Ditemukan  
Beberapa hasil dari analisis:  
Produk dengan penjualan tertinggi adalah produk dekorasi dan perlengkapan rumah.  
Negara dengan pendapatan tertinggi adalah United Kingdom, karena mayoritas transaksi berasal dari sana.  
Pendapatan meningkat menjelang akhir tahun (bulan November–Desember).  
Sebagian besar pelanggan melakukan pembelian dalam jumlah kecil namun sering.  

Langkah Rekomendasi:
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
