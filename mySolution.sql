-- Exercise 1
-- I do change the types according to updated suggestions from AI 
CREATE TABLE customers (
	id SERIAL PRIMARY KEY,
	first_name TEXT	NOT NULL,
	last_name TEXT NOT NULL,
	delivery_address TEXT NOT NULL,
	delivery_city TEXT NOT NULL,
	delivery_zip TEXT NOT NULL,
	billing_address TEXT NOT NULL,
	billing_city TEXT NOT NULL,
	billing_zip TEXT NOT NULL,
	email TEXT NOT NULL,
	phone TEXT 
);


CREATE TABLE movies (
	id SERIAL PRIMARY KEY,
	title TEXT NOT NULL,
	director TEXT NOT NULL,
	release_year INTEGER NOT NULL,
	price NUMERIC(10, 2) NOT NULL
);


CREATE TABLE orders (
	id SERIAL PRIMARY KEY,
	order_date DATE NOT NULL,
	customer_id INTEGER NOT NULL,

	CONSTRAINT fk_customer
		FOREIGN KEY (customer_id)
		REFERENCES customers(id)
		ON DELETE CASCADE
);


CREATE TABLE orderrows (
	id SERIAL PRIMARY KEY,
	order_id INTEGER NOT NULL,
	movie_id INTEGER NOT NULL,
	price NUMERIC(10, 2) NOT NULL,

	CONSTRAINT fk_order
		FOREIGN KEY (order_id)
		REFERENCES orders(id)
		ON DELETE CASCADE,

	CONSTRAINT fk_movie
		FOREIGN KEY (movie_id)
		REFERENCES movies(id)
		ON DELETE CASCADE
);


-- Exercise 2
INSERT INTO customers (first_name, last_name, billing_address, billing_zip, billing_city, delivery_address, delivery_zip, delivery_city, email, phone)
VALUES 
('Jonas', 'Gray', '23 Green Corner Street', '56743', 'Birmingham', '23 Green Corner Street', '56743', 'Birmingham', 'jonas.gray@hotmail.com', '0708123456'),
('Jane', 'Harolds', '10 West Street', '43213', 'London', '10 West Street', '43213', 'London', 'jane_h77@gmail.com', '0701245512'),
('Peter', 'Birro', '12 Fox Street', '45681', 'New York', '89 Moose Plaza', '45321', 'Seattle', 'peter_the_great@hotmail.com', '0739484322');


INSERT INTO movies (title, director, release_year, price)
VALUES
('Interstellar', 'Christoper Nolan', 2014, 179),
('Hobbit: Battle of the five armies', 'Peter Jackson', 2014, 179),
('The Wolf of Wall Street', 'Martin Scorcese', 2013, 119),
('Pulp Fiction', 'Quentin Tarantino', 1994, 49);


-- Exercise 3
-- On 2025-01-01, Jonas Gray purchases Interstellar and Pulp Fiction
INSERT INTO orders (order_date, customer_id)
VALUES ('2025-01-01', (SELECT id FROM customers WHERE first_name = 'Jonas' AND last_name = 'Gray'));

INSERT INTO orderrows (order_id, movie_id, price)
VALUES 
(
	(SELECT max(id) FROM orders),
	(SELECT id FROM movies WHERE title = 'Interstellar'),
	(SELECT price FROM movies WHERE title = 'Interstellar')
),
(
	(SELECT max(id) FROM orders),
	(SELECT id FROM movies WHERE title = 'Pulp Fiction'),
	(SELECT price FROM movies WHERE title = 'Pulp Fiction')
);

-- On 2025-12-15, Peter Birro purchases 2 copies of The Wolf of Wall Street.
INSERT INTO orders (order_date, customer_id)
VALUES ('2025-12-15', (SELECT id FROM customers WHERE first_name = 'Peter' AND last_name = 'Birro'));

INSERT INTO orderrows (order_id, movie_id, price)
VALUES 
(
	(SELECT max(id) FROM orders),
	(SELECT id FROM movies WHERE title = 'The Wolf of Wall Street'),
	(SELECT price FROM movies WHERE title = 'The Wolf of Wall Street')
),
(
	(SELECT max(id) FROM orders),
	(SELECT id FROM movies WHERE title = 'The Wolf of Wall Street'),
	(SELECT price FROM movies WHERE title = 'The Wolf of Wall Street')
);

-- On 2026-03-20, Jonas Gray purchased The Wolf of Wall Street 
INSERT INTO orders (order_date, customer_id)
VALUES ('2026-03-20', (SELECT id FROM customers WHERE first_name = 'Jonas' AND last_name = 'Gray'));

INSERT INTO orderrows (order_id, movie_id, price)
VALUES 
(
	(SELECT max(id) FROM orders),
	(SELECT id FROM movies WHERE title = 'The Wolf of Wall Street'),
	(SELECT price FROM movies WHERE title = 'The Wolf of Wall Street')
);


-- Exercise 4
-- Write a query that changes the price of all movies made in 2014 to 169 kr.
UPDATE movies 
SET price = 169
WHERE release_year = 2014;


-- Exercise 5
-- Write queries for the following SELECT operations
-- Get first_name, Last_name, phone and email to all customers.



-- Get all movies, ordered by year from newest to oldest.
-- Get all movie titles, ordered by price, from cheapest to most expensive.
-- Get first_name, Last_name, delivery__address, delivery_zip, delivery_city for all customers who bought The Wolf of Wall Street.
--Get Id, Date, customer (first_name, last_name) and total cost of every individual order.
-- (Optional) Get customer (first_name, last_name), total number of movies ordered by this customer, number of orders by this customer and total cost of all orders by this customer.
-- (Optional) Get number of orders and total cost for all orders in the database.








