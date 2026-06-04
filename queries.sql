
SELECT * FROM products;


SELECT category_name FROM categories;


SELECT * FROM products ORDER BY price DESC LIMIT 1;


SELECT * FROM products ORDER BY price ASC LIMIT 1;


SELECT * FROM products WHERE price > 50000;


SELECT * FROM sales ORDER BY sale_date DESC LIMIT 10;


SELECT * FROM sales WHERE quantity > 3;


SELECT * FROM sales WHERE total_amount > 100000;


SELECT * FROM products WHERE product_name LIKE '%Книга%';


SELECT * FROM sales WHERE sale_date = '2023-05-15';


SELECT COUNT(*) AS category_count FROM categories;


SELECT COUNT(*) AS product_count FROM products;


SELECT AVG(price) AS avg_price FROM products;


SELECT SUM(total_amount) AS total_revenue FROM sales;


SELECT MAX(total_amount) AS max_check FROM sales;


SELECT MIN(total_amount) AS min_check FROM sales;


SELECT SUM(quantity) AS total_sold FROM sales;


SELECT product_id, SUM(quantity) AS total_quantity 
FROM sales 
GROUP BY product_id 
ORDER BY total_quantity DESC;


SELECT product_id, SUM(total_amount) AS revenue 
FROM sales 
GROUP BY product_id 
ORDER BY revenue DESC;


SELECT product_id, SUM(total_amount) AS revenue 
FROM sales 
GROUP BY product_id 
HAVING SUM(total_amount) > 1000000;


SELECT sale_date, COUNT(*) AS sales_count 
FROM sales 
GROUP BY sale_date 
ORDER BY sales_count DESC;


SELECT sale_date, SUM(total_amount) AS daily_revenue 
FROM sales 
GROUP BY sale_date 
ORDER BY daily_revenue DESC 
LIMIT 1;


SELECT p.product_name, c.category_name 
FROM products p
JOIN categories c ON p.category_id = c.category_id;


SELECT s.sale_date, p.product_name, s.quantity, s.total_amount 
FROM sales s
JOIN products p ON s.product_id = p.product_id
ORDER BY s.sale_date DESC;


SELECT c.category_name, SUM(s.total_amount) AS revenue 
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;


SELECT c.category_name, AVG(s.total_amount) AS avg_check 
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_check DESC 
LIMIT 1;


SELECT s.sale_date, p.product_name, c.category_name, s.quantity, s.total_amount
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
ORDER BY s.sale_date DESC;


SELECT p.product_name 
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.product_id IS NULL;


SELECT * FROM products 
WHERE price > (SELECT AVG(price) FROM products);


SELECT p.product_name, c.category_name, SUM(s.total_amount) AS revenue 
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY p.product_id, p.product_name, c.category_name
ORDER BY revenue DESC 
LIMIT 3;