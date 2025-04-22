/* Lawyer Elijah Lab 7 */

/* 1 */
DROP DATABASE IF EXISTS Painters;
CREATE DATABASE Painters;
USE Painters;

/* 2 */
DROP USER lawyere@localhost;

DROP USER thatguyjoe@localhost;

DROP USER thatotherguyjay@localhost;

/* 3 */
DROP VIEW vwPainters;

DROP VIEW vwPay;

/* 4 */
DROP INDEX ix_customer_name
ON customer;

DROP INDEX ix_fks_job
ON job;

DROP INDEX ix_fks_empjob
ON empjob;

/* 5 */
DROP TABLE IF EXISTS empjob;

DROP TABLE IF EXISTS employee;

DROP TABLE IF EXISTS job;

DROP TABLE IF EXISTS customer;

/* 6 */
CREATE TABLE Customer (
custphone CHAR(12) PRIMARY KEY UNIQUE,
ctype ENUM ('C', 'R'),
cfname VARCHAR(35) NOT NULL,
clname VARCHAR (15) NOT NULL,
caddr VARCHAR (40),
ccity VARCHAR (20),
cstate CHAR (2) DEFAULT 'SC',
CONSTRAINT chk_custphone CHECK (custphone like '%%% %%%-%%%%') 
);

CREATE TABLE Job (
jobnum INT PRIMARY KEY,
custphone CHAR(12),
jobstartdate DATE,
description TEXT,
amobilled DECIMAL (7, 2),
FOREIGN KEY (custphone) REFERENCES Customer(custphone),
CONSTRAINT chk_jobnum CHECK (jobnum <= 65000),
CONSTRAINT chk_description CHECK (description <= 2000)
);

CREATE TABLE employee (
essn CHAR(9) PRIMARY KEY,
efname VARCHAR(35) NOT NULL,
elname VARCHAR(15) NOT NULL,
ephone CHAR(12) UNIQUE,
hrrate DECIMAL(5, 2) DEFAULT 15.75,
CONSTRAINT chk_ephone CHECK (ephone like '%%% %%%-%%%%'),
CONSTRAINT chk_hrrate CHECK (hrrate <= 100.00)
);

CREATE TABLE empjob (
essn CHAR(9),
jobnum INT,
hrsperjob DECIMAL(5, 2),
FOREIGN KEY (essn) REFERENCES employee(essn),
FOREIGN KEY (jobnum) REFERENCES job(jobnum),
CONSTRAINT chk_jobnum CHECK (jobnum <= 65000),
CONSTRAINT chk_hrsperjob CHECK (hrsperjob <= 500.00)
);

/* 7 */
CREATE INDEX ix_customer_name ON customer(clname, cfname); 

/* 8 */
CREATE INDEX ix_fks_job ON job(custphone);
CREATE INDEX ix_fks_empjob ON empjob(essn, jobnum);

/* 9 */
CREATE USER lawyere@localhost
IDENTIFIED BY 'password';

GRANT ALL
ON painters.*
TO lawyere@localhost;

CREATE USER thatguyjoe@localhost
IDENTIFIED BY 'Drowssap';

GRANT SELECT
ON painters.*
TO thatguyjoe@localhost;

CREATE USER thatotherguyjay@localhost
IDENTIFIED BY 'Apwsosdr';

GRANT ALL
ON painters.customer
TO thatotherguyjay@localhost;

GRANT ALL
ON painters.job
TO thatotherguyjay@localhost;

GRANT SELECT
ON painters.employee
TO thatotherguyjay@localhost;

GRANT SELECT
ON painters.empjob
TO thatotherguyjay@localhost;

/* 10 */
INSERT INTO customer (custphone, ctype, cfname, clname, caddr, ccity, cstate)
VALUES ('602 654-9877', 'C', 'Joe', 'Dabest', '123 STREET', 'PHEONIX', 'AZ');

INSERT INTO customer (custphone, ctype, cfname, clname, caddr, ccity, cstate)
VALUES ('602 321-6549', 'C', 'Jamie', 'Linton', '124 STREET', 'PHEONIX', 'AZ');

INSERT INTO customer (custphone, ctype, cfname, clname, caddr, ccity, cstate)
VALUES ('602 991-5848', 'R', 'Lisa', 'Smith', '125 STREET', 'PHEONIX', 'AZ');

INSERT INTO job (jobnum, custphone, jobstartdate, description, amobilled)
VALUES (123456789, '602 654-9877', '2006-01-01', "did you see the customers last name?", 1234.56);

INSERT INTO job (jobnum, custphone, jobstartdate, description, amobilled)
VALUES (123456790, '602 321-6549', '2006-04-01', "what did we sell him???", 10000.01);

INSERT INTO job (jobnum, custphone, jobstartdate, description, amobilled)
VALUES (123456791, '602 991-5848', '2007-12-09', "she a good customer", 1600.86);

INSERT INTO employee (essn, efname, elname, ephone, hrrate)
VALUES (451254789, 'Jon', 'Snow', '999 123-4574', 99.9);

INSERT INTO employee (essn, efname, elname, ephone, hrrate)
VALUES (753214896, 'Jon', 'Marston', '457 456-7894', 12.5);

INSERT INTO employee (essn, efname, elname, ephone, hrrate)
VALUES (326598741, 'Jon', 'Favreau', '812 987-6543', 50.0);

INSERT INTO empjob (essn, jobnum, hrsperjob)
VALUES (451254789, 123456789, 320.21);

INSERT INTO empjob (essn, jobnum, hrsperjob)
VALUES (753214896, 123456790, 441.41);

INSERT INTO empjob (essn, jobnum, hrsperjob)
VALUES (326598741, 123456791, 2.20);

/* 11 */
UPDATE customer
SET clname = 'Dabest'
WHERE custphone = '602 991-5848';

UPDATE job
SET description = 'you hear he got married?'
WHERE jobnum = 123456789;

UPDATE employee
SET hrrate = 99.8
WHERE essn = 451254789;

UPDATE empjob
SET hrsperjob = 1
WHERE essn = 326598741;

/* 12 */
DELETE FROM customer
WHERE custphone = '602 654-9877';

DELETE FROM job
WHERE jobnum = '123456789';

DELETE FROM employee
WHERE essn = 451254789;

DELETE FROM empjob
WHERE essn = 451254789;

/* 13 */
CREATE VIEW vwPainters AS
SELECT CONCAT(cfname,' ',clname) AS 'Customer Name', jobnum, jobstartdate, CONCAT(efname,' ',elname) AS 'Employee Name'
FROM customer INNER JOIN job
USING (custphone)
INNER JOIN empjob
USING (jobnum)
INNER JOIN employee
USING (essn);

/* 14 */
SELECT * FROM vwPainters;

/* 15 */
CREATE VIEW vwPay AS
SELECT CONCAT (efname,' ',elname) AS 'Employee Name', SUM(amobilled) AS 'Total Pay'
FROM employee INNER JOIN empjob
USING (essn)
INNER JOIN job
USING (jobnum);

/* 16 */
SELECT * FROM vwPay;






