CREATE TABLE sales (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP,
    customer_name VARCHAR(100),
    region VARCHAR(50),
    category VARCHAR(50),
    product VARCHAR(100),
    quantity INTEGER,
    unit_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    payment_method VARCHAR(30),
    status VARCHAR(30)
);

INSERT INTO sales
(order_date, customer_name, region, category,
 product, quantity, unit_price, discount,
 payment_method, status)
VALUES
('2025-01-05', 'John', 'Central', 'Technology', 'Laptop', 2, 1200, 0.10, 'Card', 'Completed'),
('2025-01-08', 'Sarah', 'West', 'Furniture', 'Chair', 4, 150, 0.05, 'Cash', 'Completed'),
('2025-01-12', 'David', 'East', 'Technology', 'Mouse', 3, 25, 0.00, 'Card', 'Completed'),
('2025-02-02', 'Emma', 'Central', 'Office Supplies', 'Paper', 10, 8, 0.00, 'Cash', 'Completed'),
('2025-02-15', 'John', 'West', 'Technology', 'Monitor', 2, 350, 0.15, 'Card', 'Cancelled'),
('2025-03-01', 'Alex', 'East', 'Furniture', 'Desk', 1, 500, 0.10, 'Card', 'Completed'),
('2025-03-10', 'Sarah', 'Central', 'Technology', 'Keyboard', 2, 75, 0.05, 'Cash', 'Completed'),
('2025-04-05', 'Michael', 'West', 'Office Supplies', 'Notebook', 20, 5, 0.00, 'Card', 'Completed'),
('2025-04-15', 'Emma', 'East', 'Furniture', 'Table', 2, 300, 0.20, 'Card', 'Pending'),
('2025-05-20', 'David', 'Central', 'Technology', 'Laptop', 1, 1200, 0.10, 'Cash', 'Completed');

-- Retrieve all the columns
SELECT * 
FROM sales;

-- Retrieve only customer_name, product and unit_price
SELECT customer_name,product,unit_price
FROM sales;

-- Products with a unit price greater than 100
SELECT product 
FROM sales 
WHERE unit_price > 100;

-- Product sorted by unit_price
SELECT product,unit_price
FROM sales
ORDER BY unit_price DESC;

-- Order has been cancelled
SELECT * 
FROM sales
WHERE status = 'Cancelled';

-- Product containing the letter o
SELECT * 
FROM sales
WHERE lower(product) LIKE '%o%'

-- Discount greater than 10 Percent
-- Product containing the letter o
SELECT * 
FROM sales
WHERE discount > 0.10;


-- Sales from central
SELECT * 
FROM 
sales
WHERE lower(region) = 'central';

-- Orders where the unit_price is between 100 and 500
SELECT * 
FROM 
sales 
WHERE unit_price > 100 and unit_price < 500;

-- customer name containing the letter a
SELECT * 
FROM 
sales 
WHERE lower(customer_name)  ~'a';


-- Orders either pending or cancelled
SELECT * 
FROM sales
WHERE status = 'Cancelled' or status = 'Pending';

-- Top five most expensive products
SELECT * 
FROM sales
ORDER BY unit_price DESC
LIMIT 5;	