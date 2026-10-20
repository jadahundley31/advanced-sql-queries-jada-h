DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;

CREATE TABLE online_store.customers (
 id INT PRIMARY KEY AUTO_INCREMENT,
 first_name VARCHAR(50),
 last_name VARCHAR(50)
);

CREATE TABLE online_store.orders (
 id INT PRIMARY KEY,
 customer_id INT NULL,
 order_date DATE,
 total_amount DECIMAL(10, 2),
 FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

INSERT INTO orders (id, customer_id, order_date, total_amount) VALUES
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

Use online_store;
SELECT * FROM customers;
SELECT * FROM orders;

/*Use JOIN statements to combine data from multiple tables*/
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

SELECT DISTINCT customers.first_name 
FROM customers 
INNER JOIN orders ON orders.customer_id = customers.id;

SELECT orders.id, customers.first_name, customers.last_name
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

/*Write GROUP BY queries with aggregate functions like SUM and COUNT*/
SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;

SELECT COUNT(*) AS order_date
FROM orders
WHERE order_date = '2023-04-01';

/*Apply WHERE and HAVING clauses to filter data*/
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount > 200
GROUP BY customer_id;
-- WHERE filters individual orders before they are grouped

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) >= 200;
-- HAVING looks at the combined spending

/*Practice using SubQueries to create dynamic filters*/
-- Scalar Subqueries
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount < (SELECT AVG(total_amount) FROM orders);

-- Column Subqueries
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Doe');

-- Table Subqueries
SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;
