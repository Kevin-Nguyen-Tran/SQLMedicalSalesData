--DDL (Data Definition Language):

CREATE TABLE order_info(
	id SERIAL PRIMARY KEY,
	order_num INT,
  	product_line VARCHAR(100),
  	status VARCHAR(100)
);

CREATE TABLE sales_info(
	id SERIAL PRIMARY KEY,
	oi_id INT REFERENCES order_info(id),
 	quantity SMALLINT,
  	price_each numeric,
  	total_sales numeric
);

CREATE TABLE date_info(
	id SERIAL PRIMARY KEY,
	oi_id INT REFERENCES order_info(id),
 	order_date DATETIME,
  	qtr_id SMALLINT,
 	month_id SMALLINT,
  	year_id SMALLINT
);

CREATE TABLE address_info(
	id SERIAL PRIMARY KEY,
	oi_id INT REFERENCES order_info(id),
 	address_line_1 VARCHAR(255),
  	city VARCHAR(255),
  	state VARCHAR(255),
  	zipcode INT
);

CREATE TABLE contact_info(
	id SERIAL PRIMARY KEY,
	oi_id INT REFERENCES order_info(id),
 	contact_last VARCHAR(100),
 	contact_first VARCHAR(100)
);

