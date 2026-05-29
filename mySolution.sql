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




