-- 1. Write a query to display each customer’s name (as “Customer Name”) alongside 
-- the name of the employee who is responsible for that customer’s orders. 
-- The employee name should be in a single “Sales Rep” column formatted as “lastName, firstName”. The output 
-- should be sorted alphabetically by customer name.
use classicmodels;

SELECT customerName as 'Customer Name', CONCAT('firstName', 'lastName') as 'Sales Rep'
FROM customers as c 
JOIN employees as e on c.customerNumber = e.employeeNumber 
order by c.customerName ;

-- 2. Determine which products are most popular with our customers. 
-- For each product, list the total quantity ordered along with the 
-- total sale generated (total quantity ordered * priceEach) for that product. 
-- The column headers should be “Product Name”, “Total # Ordered” and “Total Sale”. List the products by Total Sale descending.

SELECT productName AS "Product Name", 
quantityOrdered AS "Total # Ordered", 
SUM(quantityOrdered * priceEach) AS "Total Sale"
FROM products AS p JOIN orderdetails AS o ON p.productCode = o.productCode
ORDER BY 'Total Sale' DESC ;

-- 3. Write a query which lists order status and the # of orders with that status.
--  Column headers should be “Order Status” and “# Orders”. Sort alphabetically by status.
 SELECT * FROM orders o2 ;

 SELECT status  as 'Order Status', COUNT(orderNumber) as '# Orders' FROM orders as  o
 group by status 
 order by status ASC

 
--  4. Write a query to list, for each product line, the total # of products sold from that product line. 
--  The first column should be “Product Line” and the second 
--  should be “# Sold”. Order by the second column descending.
  
 SELECT pl.productLine AS "Product Line", COUNT(quantityOrdered) AS "# Sold"
 FROM productlines as pl
 JOIN products as p ON pl.productLine = p.productLine
 JOIN orderdetails as od ON p.productCode = od.productCode
 GROUP BY pl.productLine;
 
 
--  5. For each employee who represents customers, output the total # of orders that employee’s customers 
--  have placed alongside the total sale amount of those orders. The employee name should be output as a single column named
--  “Sales Rep” formatted as “lastName, firstName”. The second column should be titled “# Orders” and the third should be “Total Sales”. 
--  Sort the output by Total Sales descending. Only (and all) employees with the job title ‘Sales Rep’ 
--  should be included in the output, and if the employee made no sales 
--  the Total Sales should display as “0.00”.
 


   SELECT CONCAT(e.lastName, ", ", e.firstName) AS "Sales Rep",
		SUM(od.quantityOrdered) AS "# Orders", 
        IF(SUM(od.quantityOrdered) IS NULL, 0.00, SUM(od.quantityOrdered * od.priceEach)) AS "Total Sales"
 FROM employees AS e
 LEFT JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
 LEFT JOIN orders AS o ON c.customerNumber = o.customerNumber
 LEFT JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
 WHERE e.jobTitle = "Sales Rep"
 GROUP BY e.employeeNumber
 ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC;


-- 6. Your product team is requesting data to help them create a bar-chart of monthly sales since the company’s inception. 
-- Write a query to output the month (January, February, etc.), 4-digit year, and total sales for that month. 
-- The first column should be labeled ‘Month’, the second ‘Year’, and the third should be ‘Payments Received’.
-- Values in the third column should be formatted as numbers with two decimals 
-- – for example: 694,292.68.


SELECT DATE_FORMAT(p.paymentDate, "%M") AS "Month", 
		DATE_FORMAT(p.paymentDate, "%Y") AS "Year", 
        FORMAT(SUM(amount), 2) AS "Payments Received"
 FROM payments as p
 GROUP BY YEAR(p.paymentDate), MONTH(p.paymentDate);










 
  
  