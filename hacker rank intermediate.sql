-- Creating the 'country' table
CREATE TABLE country (
    id INT PRIMARY KEY,
    country_name VARCHAR(255) NOT NULL
);

-- Creating the 'city' table
CREATE TABLE city (
    id INT PRIMARY KEY,
    city_name VARCHAR(255) NOT NULL,
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(id)
);

-- Creating the 'customer' table
CREATE TABLE customer (
    id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    city_id INT,
    customer_address VARCHAR(255),
    contact_person VARCHAR(255),
    FOREIGN KEY (city_id) REFERENCES city(id)
);

-- Creating the 'invoice' table
CREATE TABLE invoice (
    id INT PRIMARY KEY,
    invoice_number VARCHAR(50) NOT NULL,
    customer_id INT,
    user_account_id INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

INSERT INTO country (id, country_name) VALUES
(1, 'United States'),
(2, 'Canada'),
(3, 'United Kingdom'),
(4, 'Australia'),
(5, 'Germany'),
(6, 'France'),
(7, 'Japan'),
(8, 'South Korea'),
(9, 'Brazil'),
(10, 'India'),
(11, 'Russia'),
(12, 'China'),
(13, 'South Africa'),
(14, 'Mexico'),
(15, 'Italy');


INSERT INTO city (id, city_name, postal_code, country_id) VALUES
(1, 'New York', '10001', 1),
(2, 'Toronto', 'M5H 2N2', 2),
(3, 'London', 'SW1A 1AA', 3),
(4, 'Sydney', '2000', 4),
(5, 'Berlin', '10115', 5),
(6, 'Paris', '75000', 6),
(7, 'Tokyo', '100-0001', 7),
(8, 'Seoul', '03000', 8),
(9, 'Rio de Janeiro', '20000-000', 9),
(10, 'Mumbai', '400001', 10),
(11, 'Moscow', '101000', 11),
(12, 'Beijing', '100000', 12),
(13, 'Cape Town', '8001', 13),
(14, 'Mexico City', '01000', 14),
(15, 'Rome', '00100', 15);

INSERT INTO customer (id, customer_name, city_id, customer_address, contact_person) VALUES
(1, 'Acme Corp', 1, '123 Broadway, New York', 'John Doe'),
(2, 'Northern Inc', 2, '456 Maple St, Toronto', 'Jane Smith'),
(3, 'British Goods', 3, '789 Piccadilly, London', 'Sam Johnson'),
(4, 'Aussie Products', 4, '101 Opera House, Sydney', 'Alice Brown'),
(5, 'German Tech', 5, '202 Alexanderplatz, Berlin', 'Max Müller'),
(6, 'French Cuisine', 6, '303 Rivoli, Paris', 'Marie Dubois'),
(7, 'Tokyo Electronics', 7, '404 Ginza, Tokyo', 'Hiro Tanaka'),
(8, 'Seoul Fashion', 8, '505 Myeongdong, Seoul', 'Ji-Young Kim'),
(9, 'Rio Entertainment', 9, '606 Copacabana, Rio de Janeiro', 'Carlos Silva'),
(10, 'Mumbai Textiles', 10, '707 Colaba, Mumbai', 'Anil Kapoor'),
(11, 'Moscow Imports', 11, '808 Red Square, Moscow', 'Ivan Petrov'),
(12, 'Beijing Exports', 12, '909 Forbidden City, Beijing', 'Li Wei'),
(13, 'Cape Town Shipping', 13, '1010 Table Mountain, Cape Town', 'Sarah Jacobs'),
(14, 'Mexican Art', 14, '1111 Zocalo, Mexico City', 'Luis Hernandez'),
(15, 'Italian Fashion', 15, '1212 Colosseum, Rome', 'Giulia Rossi');

INSERT INTO invoice (id, invoice_number, customer_id, user_account_id, total_price) VALUES
(1, 'INV1001', 1, 101, 500.00),
(2, 'INV1002', 2, 102, 300.00),
(3, 'INV1003', 3, 103, 450.00),
(4, 'INV1004', 4, 104, 520.00),
(5, 'INV1005', 5, 105, 610.00),
(6, 'INV1006', 6, 106, 350.00),
(7, 'INV1007', 7, 107, 430.00),
(8, 'INV1008', 8, 108, 560.00),
(9, 'INV1009', 9, 109, 490.00),
(10, 'INV1010', 10, 110, 660.00),
(11, 'INV1011', 11, 111, 720.00),
(12, 'INV1012', 12, 112, 380.00),
(13, 'INV1013', 13, 113, 470.00),
(14, 'INV1014', 14, 114, 530.00),
(15, 'INV1015', 15, 115, 600.00);

-- for each country, display country name, total number of invoices, and their average amount (6 decimal points). return only those countries with average invoice amount bigger than average of all invoices
SELECT 
    c.country_name,
    COUNT(i.id) AS total_invoices,
    ROUND(AVG(i.total_price), 6) AS average_invoice_amount
FROM 
    country c
JOIN 
    city ci ON c.id = ci.country_id
JOIN 
    customer cu ON ci.id = cu.city_id
JOIN 
    invoice i ON cu.id = i.customer_id
GROUP BY 
    c.country_name
HAVING 
    AVG(i.total_price) > (SELECT AVG(total_price) FROM invoice)
