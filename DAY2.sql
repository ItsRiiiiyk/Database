-- Melakukan Subquery
SELECT
	productCode,
    AVG(quantityOrdered) AS avg_qty
FROM belajar.orderdetails
GROUP BY productCode
HAVING avg_qty > (SELECT AVG(quantityOrdered) FROM belajar.orderdetails);

-- Membuat tabel total product orders
CREATE TABLE belajar.product_total (
	productCode VARCHAR(32),
    productName VARCHAR(50),
    total FLOAT
);


SELECT
	A.productCode,
    B.productName,
    SUM(A.quantityOrdered * A.priceEach) AS total
FROM belajar.orderdetails A
JOIN belajar.products B
ON A.productCode = B.productCode
GROUP BY A.productCode
ORDER BY total DESC;


-- Memasukkan data ke tabel menggunakan subquery
INSERT INTO belajar.product_total
	SELECT
	A.productCode,
    B.productName,
    SUM(A.quantityOrdered * A.priceEach) AS total
FROM belajar.orderdetails A
JOIN belajar.products B
ON A.productCode = B.productCode
GROUP BY A.productCode
ORDER BY total DESC;

-- Menampilkan data pada table
SELECT * FROM belajar.product_total;

-- Membuat view table
CREATE VIEW belajar.summary_product_total AS
	SELECT
	A.productCode,
    B.productName,
    SUM(A.quantityOrdered * A.priceEach) AS total
FROM belajar.orderdetails A
JOIN belajar.products B
ON A.productCode = B.productCode
GROUP BY A.productCode
ORDER BY total DESC;

-- Menampilkan data pada view tabel
SELECT * FROM belajar.summary_product_total;

-- Melakukan subquery pada perintah FROM
SELECT
	A.productCode,
    B.productName,
    SUM(A.quantityOrdered * A.priceEach) AS total
FROM (SELECT * FROM (SELECT * FROM belajar.orderdetails) Aa) A
JOIN (SELECT * FROM belajar.products)B
ON A.productCode = B.productCode
GROUP BY A.productCode
ORDER BY total DESC;

-- tampilkan customerName yang melakukan transaksi di atas rata-rata
SELECT
		A.customerNumber,
        B.customerName,
        AVG(A.amount) AS avg_amount
FROM belajar.payments A
JOIN belajar.customers B
ON A.customerNumber = B.customerNumber
GROUP BY customerNumber
HAVING avg_amount > (SELECT AVG(amount) FROM belajar.payments)
ORDER BY avg_amount DESC;

CREATE VIEW belajar.summary_avg_amount AS
SELECT
		A.customerNumber,
        B.customerName,
        AVG(A.amount) AS avg_amount
FROM belajar.payments A
JOIN belajar.customers B
ON A.customerNumber = B.customerNumber
GROUP BY customerNumber
HAVING avg_amount > (SELECT AVG(amount) FROM belajar.payments)
ORDER BY avg_amount DESC;

SELECT * FROM belajar.summary_avg_amount;

DROP VIEW belajar.summary_avg_amount;

-- Menambahkan kolomm customer level
ALTER TABLE belajar.customers
ADD customer_level VARCHAR(32);

SELECT
	customerName,
    phone,
    customer_level
FROM belajar.customers;

SELECT AVG(amount) FROM belajar.payments;

-- Melakukan subquery menggunakan update
SET SQL_SAFE_UPDATES = 0;
UPDATE belajar.customers SET
	customer_level = "High Level Customer"
WHERE customerNumber IN (
	SELECT
		customerNumber
	FROM belajar.payments
	GROUP BY customerNumber
	HAVING AVG(amount) > 32431.64
);

UPDATE belajar.customers SET
	customer_level = "Low Level Customer"
WHERE customerNumber IN (
	SELECT
		customerNumber
	FROM belajar.payments
	GROUP BY customerNumber
	HAVING AVG(amount) < 32431.64
);

UPDATE belajar.customers SET
	customer_level = "Mid Level Customer"
WHERE customer_level IS NULL;
 
 
 -- Membuat table bakcup
 CREATE TABLE belajar.customer_backup (
	customerNumber INT,
    customerName TEXT,
    phone TEXT,
    addressLine1 TEXT,
    creditLimit FLOAT
 );
 
 -- Memasukkan data ke table backup
 INSERT INTO belajar.customer_backup
	 SELECT
		customerNumber,
		customerName,
		phone,
		addressLine1,
		creditLimit 
	FROM belajar.customers;
    
	
    -- Melakukan delete menggunakan subquery
    DELETE FROM belajar.customer_backup
    WHERE customerNumber IN (
		SELECT
			customerNumber
		FROM belajar.payments
        GROUP BY customerNumber
        HAVING AVG(amount) > (
			SELECT AVG(amount) FROM belajar.payments
        )
    );

SELECT * FROM belajar.customer_backup;

  

-- Challaenge
ALTER TABLE belajar.products
ADD product_level TEXT;

SELECT AVG(quantityOrdered) FROM belajar.orderdetails;

SET SQL_SAFE_UPDATES =0;
UPDATE belajar.products SET
	product_level = "High Level Products"
WHERE productCode IN (
	SELECT
		productCode
	FROM belajar.orderdetails
    GROUP BY productCode
    HAVING AVG(quantityOrdered) > 35.2190

);

UPDATE belajar.products SET
	product_level = "Low Level Products"
WHERE productCode IN (
	SELECT
		productCode
	FROM belajar.orderdetails
    GROUP BY productCode
    HAVING AVG(quantityOrdered) < 35.2190

);


SELECT
	productCode,
    product_level
FROM belajar.products;
















SELECT
	A.productCode,
    B.productName,
    SUM(quantityOrdered * priceEach) AS total
FROM belajar.orderdetails A
JOIN belajar.products B
ON A.productCode = B.productCode
GROUP BY productCode
ORDER BY total DESC;
    

