CREATE DATABASE ASSIGNMENT;
USE ASSIGNMENT;

-- 1) Company Table
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(45) NOT NULL,
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(45),
    Zip VARCHAR(10)
);
INSERT INTO Company (CompanyID, CompanyName, Street, City, State, Zip)
 VALUES
  (1, 'TechWorld Solutions', '123 Main St', 'New York', 'NY', '10001'),
  (2, 'MarketCo Partners', '456 High St', 'Chicago', 'IL', '60601'),
  (3, 'GreenLeaf Corp', '789 Elm St', 'San Francisco', 'CA', '94101'),
  (4, 'BlueOcean Ltd', '101 Ocean Ave', 'Miami', 'FL', '33101'),
  (5, 'Starline Industries', '202 Star Rd', 'Dallas', 'TX', '75201');
select*from company;

-- 2) Contact Table
CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(45),
    Zip VARCHAR(10),
    ismain boolean,
    Email VARCHAR(45),
    Phone VARCHAR(12)
);
INSERT INTO Contact (ContactID, CompanyID, FirstName, LastName, Street, City, State, Zip, ismain, Email, Phone) VALUES
(1, 1, 'Amit', 'Sharma', '123 Main St', 'New York', 'NY', '10001', TRUE, 'amit.sharma@techworld.com', '2125551234'),
(2, 1, 'Sara', 'Khan', '123 Main St', 'New York', 'NY', '10001', FALSE, 'sara.khan@techworld.com', '2125555678'),
(3, 2, 'John', 'Miller', '456 High St', 'Chicago', 'IL', '60601', TRUE, 'john.miller@marketco.com', '3125558888'),
(4, 3, 'Priya', 'Nair', '789 Elm St', 'San Francisco', 'CA', '94101', TRUE, 'priya.nair@greenleaf.com', '4155552222'),
(5, 4, 'Carlos', 'Diaz', '101 Ocean Ave', 'Miami', 'FL', '33101', TRUE, 'carlos.diaz@blueocean.com', '3055554444');
select*from contact;
-- 3) Employee Table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Salary DECIMAL(10,2),
    HireDate date,
    jobTitle varchar(25),    
    Email VARCHAR(45),
    Phone VARCHAR(12)
);
INSERT INTO Employee (EmployeeID, FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone) VALUES
(1, 'Lesley', 'Bland', 60000.00, '2018-03-12', 'Sales Manager', 'lesley.bland@marketco.com', '2155559000'),
(2, 'David', 'Smith', 55000.00, '2019-07-01', 'Account Executive', 'david.smith@marketco.com', '2155559111'),
(3, 'Ritu', 'Verma', 70000.00, '2017-05-20', 'HR Manager', 'ritu.verma@marketco.com', '2155559222'),
(4, 'Michael', 'Brown', 75000.00, '2020-01-15', 'IT Specialist', 'michael.brown@marketco.com', '2155559333'),
(5, 'Anjali', 'Gupta', 50000.00, '2021-09-10', 'Sales Rep', 'anjali.gupta@marketco.com', '2155559444');
select*from employee;

-- 4) ContactEmployee Table
CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,
    Description VARCHAR(100)
);
INSERT INTO ContactEmployee (ContactEmployeeID, ContactID, EmployeeID, ContactDate, Description) VALUES
(1, 1, 1, '2025-01-15', 'Initial sales meeting with Amit Sharma'),
(2, 2, 2, '2025-02-01', 'Follow-up call with Sara Khan regarding contract details'),
(3, 3, 1, '2025-02-10', 'John Miller requested a pricing proposal'),
(4, 4, 3, '2025-03-05', 'HR coordination with Priya Nair'),
(5, 5, 5, '2025-04-12', 'Carlos Diaz requested a demo session');
select*from contactEmployee;

# /* 1). Statement to create the Contact table */
 CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(45),
    Zip VARCHAR(10),
    ismain boolean,
    Email VARCHAR(45),
    Phone VARCHAR(12)
);
SELECT*FROM CONTACT;
# /* 2). Statement to create the Employee table */
  CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45) NOT NULL,
    LastName VARCHAR(45) NOT NULL,
    Salary DECIMAL(10,2),
    HireDate date,
    jobTitle varchar(25),    
    Email VARCHAR(45),
    Phone VARCHAR(12)
);
SELECT*FROM EMPLOYEE;
/* 3) Statement to create the ContactEmployee table
HINT: Use DATE as the datatype for ContactDate. It allows you to store the
date in this format: YYYY-MM-DD (i.e., ‘2014-03-12’ for March 12, 2014). */
CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    ContactID INT,
    EmployeeID INT,
    ContactDate DATE,              -- Stores date in YYYY-MM-DD format
    Description VARCHAR(100)
);
SELECT*FROM CONTACTEMPLOYEE;
/* 4) In the Employee table, the statement that changes Lesley Bland’s phone number
to 215-555-8800 */

SET SQL_SAFE_UPDATES = 0;

UPDATE Employee
SET Phone = '215-555-8800'
WHERE FirstName = 'Lesley' AND LastName = 'Bland';

/* 5) In the Company table, the statement that changes the name of “Urban
Outfitters, Inc.” to “Urban Outfitters” . */
UPDATE Company
SET CompanyName = 'Urban Outfitters'
WHERE CompanyName = 'Urban Outfitters, Inc.';

/* 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact
event with Jack Lee (one statement).
HINT: Use the primary key of the ContactEmployee table to specify the correct record to remove. */
DELETE FROM ContactEmployee
WHERE ContactEmployeeID = (
    SELECT ce.ContactEmployeeID
    FROM ContactEmployee ce
    JOIN Contact c ON ce.ContactID = c.ContactID
    JOIN Employee e ON ce.EmployeeID = e.EmployeeID
    WHERE c.FirstName = 'Dianne' AND c.LastName = 'Connor'
      AND e.FirstName = 'Jack' AND e.LastName = 'Lee'
);
/* 7) Write the SQL SELECT query that displays the names of the employees that
have contacted Toll Brothers (one statement). Run the SQL SELECT query in
MySQL Workbench. Copy the results below as well. */
SELECT DISTINCT e.FirstName, e.LastName
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Customer cu ON c.CustomerID = cu.CustomerID
WHERE cu.CustomerName = 'Toll Brothers';
/*8) What is the significance of “%” and “_” operators in the LIKE statement? */
/*In SQL, the LIKE operator is used for pattern matching in WHERE clauses.
The special characters % and _ are wildcards:
1. % (percent sign)
Represents zero, one, or many characters.
Example:
SELECT * 
FROM Employee
WHERE LastName LIKE 'Sm%';
✔️ Matches:
Smith
Smythe
Smalls
2. _ (underscore)
Represents exactly one character.
Example:
SELECT * 
FROM Employee
WHERE LastName LIKE 'Sm_th';
✔️ Matches:
Smith
Smyth
❌ Does not match:
Smth (missing a character)
Smithe (extra character)*/

/*9) Explain normalization in the context of databases.  */
/*→ Normalization in the context of databases is the process of organizing data in a relational 
database to eliminate redundancy, ensure data integrity, and optimize storage efficiency. It 
involves structuring tables and their relationships to adhere to specific rules, called normal 
forms, which reduce anomalies during data operations like insertion, deletion, and updates. 
Key Objectives of Normalization 
1. Eliminate Data Redundancy 
2. Ensure Data Integrity 
3. Simplify Data Management 
4. Optimize Storage */

/*10) What does a join in MySQL mean? */
/*→ In MySQL, a JOIN is a SQL operation that combines rows from two or more tables based on 
a related column between them, allowing you to retrieve data from multiple tables as if they 
were a single table. The JOIN operation is fundamental in relational databases to query related 
data stored across normalized tables.
🔹 Types of Joins in MySQL
1. INNER JOIN
2. LEFT JOIN
3. RIGHT JOIN 
4. CROSS JOIN
5. SELF JOIN  */

/*11) 19.What do you understand about DDL, DCL, and DML in MySQL?*/
/*→ In MySQL, DDL, DCL, and DML are categories of SQL (Structured Query Language) commands 
used to interact with a database. Each serves a distinct purpose in managing and manipulating 
database structure, access, and data. 
1. DDL (Data Definition Language) 
 Purpose: DDL commands are used to define, modify, or delete the structure of database 
objects like tables, schemas, or indexes. 
2. DML (Data Manipulation Language) 
 Purpose: DML commands are used to manipulate the data within database tables (e.g., 
inserting, updating, or deleting records). 
3. DCL (Data Control Language) 
 Purpose: DCL commands are used to define access controls and permissions for database 
users or roles. 
 DDL: Create a table for employees (CREATE TABLE employees).  
 DML: Add employee data (INSERT INTO employees) or retrieve it (SELECT * 
FROM employees).  
 DCL: Grant a user permission to view the table (GRANT SELECT ON employees 
TO 'user1'). */

/*12) What is the role of the MySQL JOIN clause in a query, and what are some 
common types of joins? 
→ The JOIN clause in MySQL is used to combine rows from two or more tables based on a 
related column, enabling you to retrieve data from multiple tables in a single query. It is 
essential in relational databases where data is normalized across multiple tables, and you need 
to link them to produce meaningful results. 
Role of the JOIN Clause 
 Combine Data: JOIN links tables based on a specified condition, typically involving 
primary and foreign keys, to fetch related data. 
 Enable Relational Queries: It allows you to query data spread across normalized 
tables, such as combining customer and order information. 
 Flexible Data Retrieval: By specifying the type of JOIN, you control which rows are 
included in the result set, even when matches are not found in one of the tables. 
Common Types of JOINs in MySQL 
1. INNER JOIN (or simply JOIN):  
o Description: Returns only the rows where there is a match in both tables 
based on the ON condition. 
o Use: When you want data that exists in both tables. 
2. LEFT JOIN (or LEFT OUTER JOIN):  
 Description: Returns all rows from the left table (first table) and the matched rows 
from the right table. If no match is found, NULL values are returned for columns 
from the right table. 
 Use: When you want all records from the left table, even if there are no 
corresponding matches in the right table. 
3. RIGHT JOIN (or RIGHT OUTER JOIN):  
 Description: Returns all rows from the right table and the matched rows from the 
left table. If no match is found, NULL values are returned for columns from the left 
table. 
 Use: When you want all records from the right table, even if there are no matches 
in the left table. 
4. FULL JOIN (or FULL OUTER JOIN):  
 Description: Returns all rows from both tables, with NULL values in places where 
there is no match in one of the tables. 
 Note: MySQL does not natively support FULL OUTER JOIN, but it can be achieved 
using a combination of LEFT JOIN and RIGHT JOIN with UNION. 
 Use: When you want all records from both tables, regardless of matches.*/