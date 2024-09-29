CREATE TABLE order_status (
    status_id SERIAL PRIMARY KEY, 
    status_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE categories (
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(100),
	description TEXT,
	active BOOLEAN NOT NULL
	);

CREATE TABLE payment_methods (
    method_id SERIAL PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL UNIQUE, 
    active BOOLEAN DEFAULT TRUE  
);

CREATE TABLE addresses (
    address_id SERIAL PRIMARY KEY,
    street_address VARCHAR(255) NOT NULL,  
    neighborhood VARCHAR(100),               
    city VARCHAR(100) NOT NULL,              
    postal_code VARCHAR(20),                  
    country VARCHAR(100) NOT NULL        
);

CREATE TABLE suppliers (
	id_supplier SERIAL PRIMARY KEY,
	company_name VARCHAR(100),
	contact_name VARCHAR(100),
	contact_number VARCHAR(20),
	email VARCHAR(100),
	country VARCHAR(50),
	city VARCHAR(50),
	address_id INT,
	active BOOLEAN DEFAULT TRUE,
	FOREIGN KEY (address_id) REFERENCES addresses (address_id)
);

CREATE TABLE products (
	id_product SERIAL PRIMARY KEY,
	product_name VARCHAR (100),
	category_id SMALLINT,
	id_supplier SMALLINT,
	units_stock INT,
	unit_price DECIMAL (10,2),
	active BOOLEAN NOT NULL DEFAULT TRUE,
	FOREIGN KEY (category_id)
		REFERENCES categories(category_id) ON DELETE CASCADE,
	FOREIGN KEY (id_supplier) 
		REFERENCES suppliers(id_supplier) ON DELETE CASCADE
);


CREATE TABLE orders (
	id_order SERIAL PRIMARY KEY,
    id_supplier INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    address_id INT NOT NULL,
	payment_method INT,
    status_id INT,
	FOREIGN KEY ( payment_method) REFERENCES payment_methods ( method_id),
    FOREIGN KEY (id_supplier) REFERENCES suppliers(id_supplier),
	FOREIGN KEY (address_id) REFERENCES addresses (address_id),
	FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

CREATE TABLE detail_order (
    id_detail SERIAL PRIMARY KEY,
    id_order INT NOT NULL,
    id_product INT NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(3, 2) DEFAULT 0.00,
    FOREIGN KEY (id_order) REFERENCES orders (id_order),
    FOREIGN KEY (id_product) REFERENCES products(id_product)
);

CREATE TABLE customers (
    id_customer SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
	first_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address_id int,
	FOREIGN KEY (address_id) REFERENCES addresses (address_id)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    manager_id INT,
	active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    id_customer INT NOT NULL,
    employee_id INT NOT NULL,
    sale_date DATE NOT NULL DEFAULT CURRENT_DATE,
    payment_method INT,
	FOREIGN KEY ( payment_method) REFERENCES payment_methods ( method_id),
    FOREIGN KEY (id_customer) REFERENCES customers(id_customer),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE sale_details (
    detail_id SERIAL PRIMARY KEY,
    sale_id INT NOT NULL,
    id_product INT NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(3, 2) DEFAULT 0.00,
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (id_product) REFERENCES products(id_product)
);

CREATE TABLE deliveries (
    delivery_id SERIAL PRIMARY KEY,
    id_order INT NOT NULL,
    delivery_address_id INT NOT NULL,
    delivery_date DATE NOT NULL DEFAULT CURRENT_DATE,
    delivery_status VARCHAR(50) NOT NULL,
    employee_id INT,
    FOREIGN KEY (id_order) REFERENCES orders(id_order),
    FOREIGN KEY (delivery_address_id) REFERENCES addresses(address_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


CREATE TABLE users (
	id_user INT PRIMARY KEY,
	full_name VARCHAR(50),
	email VARCHAR(50),
	password VARCHAR(50)
)

	

