-- SELECT 

-- select everything from the customer TABLE
SELECT * 
FROM customer;

-- use sql as a calculator
SELECT 1+1, 10*5, pi();

--add a static value
SELECT 2025 as this_year, 'August' as this_month, customer_id
FROM customer;

-- add an order by and limit 
SELECT * 
FROM customer
ORDER BY customer_first_name
LIMIT 10;

SELECT customer_id, customer_first_name
FROM customer


-- WHERE

SELECT * FROM customer
WHERE customer_id = 1
OR customer_id = 2;         -- 1 or 2
--AND customer_id = 2 -- returns nothing

--IN
SELECT * FROM customer
WHERE customer_id IN (3,4,5) -- only customers 3,4,5
OR customer_postal_code IN ('M4H','M1L'); --  customers in these postal codes

--LIKE
-- all the peppers
SELECT * FROM product
WHERE product_name LIKE '%pepper%';

--customer with a last name starting with a
SELECT * FROM customer
WHERE customer_last_name LIKE 'a%';

--NULLS and Blanks
SELECT * FROM product
WHERE product_size IS NULL
OR product_size = ''; -- two single quotes, "blanks", different from nulls

-- between another option
SELECT * FROM customer
WHERE customer_id BETWEEN 1 AND 20




--CASE

-- add some logic to determine which vendors come on which days
SELECT * ,
CASE WHEN vendor_type = 'Fresh Focused' THEN 'Wednesday'
	WHEN vendor_type = 'Prepared Foods' THEN 'Thursday'
	ELSE 'Saturday'
END as day_of_specialty
-- pie day, otherwise nothing
,CASE WHEN vendor_name = "Annie's Pies" --- double quotes will work just this once!
	THEN 'annie is the best'
	END as annie_is_the_king
,CASE WHEN vendor_name LIKE '%pie%'
THEN 'Wednesday'
ELSE 'Friday'	-- with the else, we get values for FALSE statements
END as pie_day
-- nonsense, but not a string, instead a different COLUMN
,CASE WHEN vendor_type = 'Fresh Focused' THEN vendor_owner_first_name
	WHEN vendor_type = 'Prepared Foods' THEN vendor_owner_last_name
  
  
  -- DISTINCT

--without distinct 4221 rows of various cust_ids
SELECT customer_id FROM customer_purchases;

-- with distinct 26 rows of various cust_ids
SELECT DISTINCT customer_id FROM customer_purchases;

--150 days the market was open
SELECT market_day
FROM market_date_info;

-- market is only open wed and sat
SELECT DISTINCT market_day
FROM market_date_info;

/* which vendor has sold products to a customer */ -- 3 rows
SELECT DISTINCT vendor_id
FROM customer_purchases;

/* which vendor has sold products to a customer ... and which product was it? */ -- 8 rows
SELECT DISTINCT vendor_id, product_id
FROM customer_purchases;

/* which vendor has sold products to a customer 
... and which product was it? 
... AND to whom was it sold*/ -- 200 rows
SELECT DISTINCT vendor_id, customer_id, product_id
FROM customer_purchases
ORDER BY customer_id ASC, product_id DESC


-- INNER JOIN
-- INNER JOIN without an alias

--get product names alongside customer_purchases ... only products that a customer has purchased
SELECT 
product_name, -- come from product table
vendor_id, -- coming from the customer_purchases table ... below
market_date,
customer_id,
customer_purchases.product_id


FROM product
INNER JOIN customer_purchases
	ON customer_purchases.product_id = product.product_id;
	
-- which vendor has sold products to a customer AND which product was it AND to whom was it sold
SELECT DISTINCT vendor_id, 
c.customer_id,
customer_first_name, 
customer_last_name,  -- go and get this name
product_id
FROM customer_purchases as cp
INNER JOIN customer as c
	ON c.customer_id = cp.customer_id







  
END as first_or_last
FROM vendor