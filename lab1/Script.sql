SELECT * FROM ord WHERE snum != 3005;

SELECT city, name, pnum, weight FROM prod WHERE weight > 500;

SELECT DISTINCT pnum FROM ord WHERE snum <= 1001;

SELECT * FROM sal WHERE comm <= 0.13 AND city != 'Екатеринбург';

SELECT * FROM cust WHERE cnum IN (2005, 2006, 2007);

SELECT * FROM cust WHERE cnum = 2005 OR cnum = 2006 OR cnum = 2007;

SELECT * FROM cust WHERE cnum BETWEEN 2005 AND 2007;

