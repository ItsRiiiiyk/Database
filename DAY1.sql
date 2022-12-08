-- Perintah Untuk Membuat Database
CREATE DATABASE Oriyk;

-- Perintah Untuhk Membuat Tabel
CREATE TABLE oriyk.customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    frist_name VARCHAR (16) NOT NULL,
    last_name VARCHAR (16) NOT NULL,
    email VARCHAR (32) UNIQUE NOT NULL,
    brith_date DATE,
    balance FLOAT DEFAULT 0.0
);

-- Memasukkan data kedalam tabel (sesuai urutan kolom)
INSERT INTO oriyk.customers VALUES (
	NULL,
    "ItsRiiiyk",
    "Star",
    "itsriiyk@gmail.com",
    "2000-09-06",
    100.000
);

-- menampilkan data pada tabel
SELECT * FROM oriyk.customers;

-- Memperbaharui data pada tabel
UPDATE oriyk.customers SET
		email = "itsriyk@yahoo.com",
        brith_date = "2001-09-06",
        balance = 99.99
WHERE id = 1;

-- menghapus data
DELETE FROM oriyk.customers WHERE id = 2;

-- Menambah kolom pada tabel
ALTER TABLE oriyk.customers ADD username TEXT NOT NULL;

-- Perintah untuk menampilkan informasi table
DESCRIBE oriyk.customers;

-- Mengubah nama kolom
ALTER TABLE oriyk.customers
CHANGE brith_date tanggal_lahir DATE;

-- menghapus kolom pada table
ALTER TABLE oriyk.customers
DROP COLUMN username;

-- mengubah tipe constraint
ALTER TABlE oriyk.customers
CHANGE tanggal_lahir tanggal_lahir TEXT NOT NULL;

-- Menampilkan data pada tabel (seluruh kolom)
SELECT * FROM belajar.orderdetails;

-- Menampilkan data kolom tertentu
SELECT
	productCode,
    quantityOrdered,
    priceEach
FROM belajar.orderdetails;

-- Menarik data dengan jumlah tertentu
SELECT
	productCode,
    quantityOrdered,
    priceEach
FROM belajar.orderdetails
LIMIT 20;

-- Membuat alias pada kolom
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
LIMIT 20;

-- Sorting Pada Kolom  (menurun)
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
ORDER BY quantityOrdered DESC;

-- Sorting Pada Kolom  (menaik)
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
ORDER BY quantityOrdered ASC;

-- Filtering pada kolom angka
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
WHERE quantityOrdered > 50;

-- Filtering pada kolom karakter
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
WHERE productCode = "S10_1678";

-- Filtering pada kolom karakter
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan"
FROM belajar.orderdetails
WHERE productCode LIKE "S10_%";

-- Melakukan operasi antar kolom
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan",
    (quantityOrdered * priceEach) AS total
FROM belajar.orderdetails;


-- Melakukan filtering pada kolom  operasi
SELECT
	productCode AS "kode produk",
    quantityOrdered AS jumlah,
    priceEach AS "harga satuan",
    (quantityOrdered * priceEach) AS total
FROM belajar.orderdetails
HAVING total > 2000;

-- Melakukan Agregasi
SELECT
	SUM(quantityOrdered) AS "total jumlah",
    AVG(quantityOrdered) AS "rata-rata jumlah",
    MIN(quantityOrdered) AS "Pembelian terkecil",
    MAX(quantityOrdered) AS "Pembelian terbanyak",
    SUM(quantityOrdered * priceEach) AS "total revenue"
FROM belajar.orderdetails;

-- Melakukan gouping
SELECT
	productCode AS "kode produk",
    (quantityOrdered * priceEach) AS total
FROM belajar.orderdetails
GROUP BY productCode
ORDER BY productCode DESC;

-- Chalenge
-- Tampilkan top 10 product code dengan total terbesar
-- hingga terkecil
SELECT
	productCode AS "kode produk",
    SUM(quantityOrdered * priceEach) AS total
FROM belajar.orderdetails
GROUP BY productCode
ORDER BY total DESC
LIMIT 10;

-- Menggunakan fungsi
SELECT
	paymentDate,
    YEAR(paymentDate),
    MONTH(paymentDate),
    DATE_FORMAT(paymentDate, "%d/%m/%Y")
    amount
FROM belajar.payments;

-- Menghitung total transaksi berdasarkan tahun
SELECT
	YEAR(paymentDate) AS tahun,
    SUM(amount) AS total
FROM belajar.payments
GROUP BY tahun;
 

-- Melakukan Join pada tabel
SELECT
	A.productCode AS "kode produk",
    B.productName AS "nama produk",
    SUM(A.quantityOrdered * A.priceEach) AS total
FROM belajar.orderdetails A
INNER JOIN belajar.products B
ON A.productCode = B.productCode
GROUP BY A.productCode
ORDER BY total DESC
LIMIT 10;

SELECT * FROM belajar.payment;
SELECT * FROM belajar.customers;
-- Chalenge
-- Tampilkan top 10 customerName berdasarkan SUM(amount)
-- Gabungkan antara tabel payments dan customers
-- ORDER BY SUM(amount) terbersar ke terkecil

SELECT
	A.customerName AS "Nama",
    B.customerNumber AS "no",
     SUM(B.amount) AS "TOTAL"
FROM belajar.customers A
INNER JOIN belajar.payments B
ON A.customerNumber = B.customerNumber
GROUP BY A.customerNumber
ORDER BY SUM(B.amount) DESC
LIMIT 10;

	
    
   



	




