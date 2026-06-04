
SELECT * FROM product;

SELECT name FROM categories;

SELECT * FROM product
ORDER BY price DESC
LIMIT 1;

SELECT * FROM product
ORDER BY price ASC
LIMIT 1;

SELECT * FROM product
WHERE price > 50000;


SELECT * FROM sales
ORDER BY sale_date
LIMIT 10;

SELECT * FROM sales
WHERE quantity > 3;

SELECT * FROM sales
WHERE total_amount > 100000;

SELECT * FROM product
WHERE name ILIKE '%Книга%';

SELECT * FROM sales
WHERE DATE(sale_date) = '2023-05-15';

SELECT COUNT(*) AS total_categories
FROM categories;

SELECT COUNT(*) AS total_products
FROM product;

SELECT AVG(price) AS average_price
FROM product;

SELECT SUM(total_amount) AS total_revenue
FROM sales;

SELECT MAX(total_amount) AS max_receipt
FROM sales;

SELECT MIN(total_amount) AS min_receipt
FROM sales;

SELECT SUM(quantity) AS total_quantity_sold
FROM sales;

SELECT product_id,
       SUM(quantity) AS total_sold
FROM sales
GROUP BY product_id;

SELECT product_id,
       SUM(total_amount) AS revenue
FROM sales
GROUP BY product_id;

SELECT product_id
FROM sales
GROUP BY product_id
HAVING SUM(total_amount) > 1000000;

SELECT DATE(sale_date) AS sale_day,
       COUNT(*) AS sales_count
FROM sales
GROUP BY DATE(sale_date)
ORDER BY sale_day;

SELECT DATE(sale_date) AS sale_day,
       SUM(total_amount) AS revenue
FROM sales
GROUP BY DATE(sale_date)
ORDER BY revenue DESC
LIMIT 1;

SELECT p.name AS product_name,
       c.name AS category_name
FROM product p
JOIN categories c
ON p.category_id = c.category_id;

SELECT s.sale_id,
       p.name AS product_name,
       s.sale_date,
       s.quantity,
       s.total_amount
FROM sales s
JOIN product p
ON s.product_id = p.product_id;

SELECT c.name AS category_name,
       SUM(s.total_amount) AS revenue
FROM categories c
JOIN product p
ON c.category_id = p.category_id
JOIN sales s
ON p.product_id = s.product_id
GROUP BY c.name
ORDER BY revenue DESC;

SELECT c.name AS category_name,
       AVG(s.total_amount) AS average_receipt
FROM categories c
JOIN product p
ON c.category_id = p.category_id
JOIN sales s
ON p.product_id = s.product_id
GROUP BY c.name
ORDER BY average_receipt DESC
LIMIT 1;

SELECT s.sale_date,
       p.name AS product_name,
       c.name AS category_name,
       s.total_amount
FROM sales s
JOIN product p
ON s.product_id = p.product_id
JOIN categories c
ON p.category_id = c.category_id;

SELECT p.name
FROM product p
LEFT JOIN sales s
ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;

SELECT *
FROM product
WHERE price > (
    SELECT AVG(price)
    FROM product
);

SELECT p.name AS product_name,
       c.name AS category_name,
       SUM(s.total_amount) AS revenue
FROM sales s
JOIN product p
ON s.product_id = p.product_id
JOIN categories c
ON p.category_id = c.category_id
GROUP BY p.name, c.name
ORDER BY revenue DESC
LIMIT 3;