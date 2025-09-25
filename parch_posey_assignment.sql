SELECT *
FROM web_events;

SELECT *
FROM accounts;

SELECT *
FROM orders;

--Find all info on individuals contacted via the organic or adwords channels, and started account in anypoint in 2016, sorted from newest to oldest

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords')
AND   occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY occurred_at DESC;

--Find all the companies whose names do not start with 'C' and end with 's'.

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%'
AND name LIKE '%S';


--Fetch a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
SELECT *
FROM orders
WHERE standard_qty=0
AND (gloss_qty>1000 OR poster_qty>1000);


--Retrieve all the accounts whose primary point of contact has a name that starts with ‘T’ or ‘E’. The result should be ordered alphabetically. 

SELECT *
FROM accounts
WHERE primary_poc LIKE 'T%' 
OR primary_poc LIKE 'E%'
ORDER BY primary_poc ASC;

--Retrieve the total number of unique sales reps and unique accounts.

SELECT COUNT(DISTINCT sales_rep_id) AS unique_sales_rep,
       COUNT(DISTINCT id) AS unique_accounts
       FROM accounts;

--Fetch the website and primary point of contact for these accounts :  Walmart, Target, and Nordstrom.

SELECT name,website,primary_poc
FROM accounts
WHERE name IN ('Walmart','Target','Nordstrom');
