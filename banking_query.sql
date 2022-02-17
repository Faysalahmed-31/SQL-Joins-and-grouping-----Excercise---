/*For each product, show the product name "Product" and the product type name "Type".*/
use Banking;
SELECT * FROM PRODUCT p ;
SELECT NAME AS 'Product', PRODUCT_TYPE_CD FROM PRODUCT p ;

-- 2. For each branch, list the branch name and city, plus the last name and title of each employee who works in that branch.
SELECT * FROM BRANCH b ;
SELECT * FROM EMPLOYEE e ;

SELECT b.name, b.city, e.lastName, e.title 
FROM BRANCH AS b JOIN EMPLOYEE AS  e ON employee.employee_id = branch.branch_id ;

-- 3. Show a list of each unique employee title.
SELECT * FROM EMPLOYEE e ;
SELECT DISTINCT title FROM EMPLOYEE e ;
-- 
-- 4. Show the last name and title of each employee, along with the last name and title of that employee's boss.
SELECT * FROM EMPLOYEE e ;
SELECT employee.last_name, employee.title, s.last_name, s.title FROM EMPLOYEE AS e
 left JOIN EMPLOYEE AS e2 ON  employee.emp_id = employee.superior_emp_id ;
-- 
-- 5. For each account, show the name of the account's product, the available balance, and the customer's last name.
SELECT p.name, a.avail_balance, i.last_name
FROM account AS a
LEFT JOIN product AS p ON a.product_cd = p.product_cd
JOIN individual as i ON a.cust_id = i.cust_id;

-- 6. List all account transaction details for individual customers whose last name starts with 'T'.
*/

SELECT at.*
FROM individual AS i
JOIN account AS a ON i.cust_id = a.cust_id
JOIN acc_transaction AS at ON a.account_id = at.account_id
WHERE SUBSTR(i.last_name, 1, 1) = 'T';