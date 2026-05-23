CREATE TABLE Books(
book_ID SERIAL PRIMARY KEY,
title VARCHAR(100),
author VARCHAR(100),
genre VARCHAR(100),
Published_Year INT,
Price NUMERIC(10,2),
stock INT 
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
name VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(15),
city VARCHAR(100),
country VARCHAR(100)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
order_ID SERIAL PRIMARY KEY,
customer_ID INT REFERENCES Customers(Customer_ID),
book_ID	INT REFERENCES Books(book_ID),
order_Date DATE,
quantity INT,
total_Amount NUMERIC(10,2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

--import csv


--BASIC QUERIES:

--1)retrieve all books in the "Fiction" genre
SELECT * FROM Books
WHERE genre='Fiction';

--2)Find the books published after year 1950
SELECT * FROM Books
WHERE Published_Year>1950;

--3)List all the customers from canada
SELECT * FROM Customers
WHERE country='Canada';

--4)Show orders placed in November 2023
SELECT * FROM Orders
WHERE order_Date BETWEEN '2023-11-01' AND '2023-11-30';

--5)Retrieve the total stock of books available
SELECT SUM(stock)
FROM Books;

--6)Find the details of most expensive book
SELECT * FROM Books ORDER BY Price DESC
LIMIT 1;

--7)Show all customers who ordered more than 1 quantity of book
SELECT * FROM Orders
WHERE quantity>1;

--8)RETRIEVE all orders where total amount exceeds $20
SELECT *FROM Orders
WHERE total_amount>20;

--9)List all genres available in the books table
SELECT DISTINCT genre
FROM Books;

--10)Find the book with lowest stock
SELECT * FROM Books
ORDER BY stock
LIMIT 1;

--11)Calculate the total revenue generated from all orders (sum of total amount) 
SELECT SUM(total_amount) AS revenue
FROM Orders;

--Advanced queries
--1)Retrieve the total number of books sold for each genre
 SELECT b.genre , SUM(o.quantity) AS total_books_sold
 FROM Orders o
 JOIN Books b
 ON b.book_id=o.book_id
 GROUP BY b.genre;

--2)Find the average price of books in the "Fantcy" genre
SELECT AVG(price) AS average_price
FROM Books
WHERE genre='Fantasy';

--3)List customers who have placed at least 2 orders :EK customer ka order count 
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM Orders o
JOIN Customers c ON c.customer_id=o.customer_id
GROUP BY o.customer_id,c.name
HAVING COUNT(o.Order_id)>=2;
--HAVING aggregate function ke liye use hota hai 
--agar aggre nh hai to simple where ka use krna


--4)Find the most frequently ordered book:
SELECT o.book_id,b.title,COUNT(o.Order_id) AS ORDER_COUNT
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY o.book_id,b.title
ORDER BY ORDER_COUNT DESC
LIMIT 1;

--5)show the top 3 most expensive books of "Fantasy" genre
SELECT * FROM Books
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;

--6)Retrieve the total quantity of books sold by each author
SELECT b.author, SUM(o.quantity) AS total_quantity_of_books_sold
FROM Books b
JOIN Orders o ON  b.book_id=o.book_id
GROUP BY b.author;

--7)List the cities where customers who spent over $30 are located:
SELECT c.city,o.customer_id,o.total_amount
FROM Customers c
JOIN Orders o ON o.customer_id=c.customer_id
WHERE o.total_amount>30;

--8)Find the customere who spent the most on orders:
SELECT c.name,c.customer_id, SUM(o.total_amount) AS TOTAL_SPENT
FROM Orders o
JOIN Customers c ON o.customer_id=c.customer_id
GROUP BY c.name,c.customer_id
ORDER BY TOTAL_SPENT DESC
LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders (Stock-Quantinty)
SELECT b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS Order_quantity,
b.stock-COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM Books b
LEFT JOIN Orders o
ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;




--part 2
--1)retrieve all books in the "Fiction" genre
SELECT * FROM Books
WHERE genre='Fiction';

--2)Find the books published after year 1950
SELECT * FROM Books
WHERE published_year>1950;

--3)List all the customers from canada
SELECT * FROM Customers
WHERE country='Canada';

--4)Show orders placed in November 2023
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5)Retrieve the total stock of books available
SELECT SUM(stock) AS total_stock
FROM Books;

--6)Find the details of most expensive book
SELECT * FROM Books
ORDER BY price DESC
LIMIT 1;

--7)Show all customers who ordered more than 1 quantity of book
SELECT * FROM Orders
WHERE quantity>1;


--8)RETRIEVE all orders where total amount exceeds $20
SELECT * FROM Orders
WHERE total_amount>20;

--9)List all genres available in the books table
SELECT DISTINCT genre FROM Books;

--10)Find the book with lowest stock
SELECT * FROM Books 
ORDER BY stock
LIMIT 1

--11)Calculate the total revenue generated from all orders 
SELECT SUM(total_amount) AS revenue
FROM Orders;

--Advanced queries
--1)Retrieve the total number of books sold for each genre
SELECT b.genre,SUM(o.quantity) AS total_books_sold
FROM Orders o
JOIN Books b ON b.book_id=o.book_id
GROUP BY b.genre;

--2)Find the average price of books in the "Fantcy" genre
SELECT AVG(price) AS average_price
FROM Books
WHERE genre='Fantasy';

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Books;

--3)List customers who have placed at least 2 orders
SELECT c.name, COUNT(o.order_id) AS total_order
FROM Orders o
JOIN Customers c ON c.customer_id=o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id)>=2;

--4)Find the most frequently ordered book:
SELECT b.title,COUNT(o.order_id) AS total_order
FROM Orders o
JOIN Books b ON b.book_id=o.book_id
GROUP BY b.title
ORDER BY total_order DESC LIMIT 1;

--5)show the top 3 most expensive books of "Fantasy" genre
SELECT * FROM Books
WHERE genre='Fiction'
ORDER BY price DESC 
LIMIT 3;

--6)Retrieve the total quantity of books sold by each author
SELECT b.author,SUM(o.quantity) AS total_quantity
FROM Orders o
JOIN Books b ON b.book_id=o.book_id
GROUP BY b.author;

--7)List the cities where customers who spent over $30 are located:
SELECT c.city,o.total_amount AS spent
FROM Orders o
JOIN Customers c ON c.customer_id=o.customer_id
WHERE o.total_amount>30;

--8)Find the customer who spent the most on orders:
SELECT c.name,SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customers c ON c.customer_id=o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC 
LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders (Stock-Quantity)
SELECT b.book_id,b.title,b.stock,COALESCE(SUM(o.quantity),0) AS order_quantity,
b.stock-COALESCE(SUM(o.quantity),0) AS remaining_quantity
FROM Books b  
LEFT JOIN Orders o ON b.book_id=o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;