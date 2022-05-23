-- SELECT first 5 customers ORDER by name ASC  but skip the first 10

SELECT * FROM customer ORDER BY first_name LIMIT 5 OFFSET 10

-- SELECT first 5 customers ORDER by name DESC

SELECT * FROM customer ORDER BY first_name DESC LIMIT 5

-- SELECT payments  that amount between 4-6 order desc by payment_date


SELECT * FROM payment WHERE amount BETWEEN '4' AND '6' ORDER BY payment_date DESC

-- SELECT movies that are in inventory. (hint: use sub-query)

SELECT * FROM film WHERE film_id IN (SELECT film_id FROM inventory)


-- SELECT payments that happened between 2007-02-15 and 2007-02-20


SELECT * FROM payment WHERE payment_date BETWEEN '2007-02-15' AND '2007-02-20'

-- SELECT payments that amount value is between 3 and 5

SELECT * FROM payment WHERE amount BETWEEN '3' AND '5'

-- SELECT customers whose name starts with “J”


SELECT * FROM customer WHERE first_name ILIKE ('J%')

-- SELECT all columns from the film table.

SELECT * FROM film

-- SELECT district,phone,postal_code from “address” table.

SELECT district, phone, postal_code FROM address

-- SELECT address, district,postal_code and concat them and get as “full_address”.


SELECT address || ' ' || district || ' ' || postal_code AS full_address FROM address

-- SELECT all films with tiltle Airport Pollock

SELECT * FROM film WHERE title in ('Airport Pollock')

-- Insert 5 customers into the database.

INSERT INTO customer(store_id, first_name, last_name, email, address_id, activebool) 
VALUES (1, 'shola', 'deupe', 'shole.adeg@gmail.com', 300, true ) returning *

SELECT * FROM customer

-- Edit the second customer’s name

UPDATE customer SET first_name = 'Ahmed' WHERE customer_id = 1 returning *

-- Delete the last customer

DELETE FROM customer WHERE first_name = 'Ahmed'


--  get customer amount that us greater than average
SELECT customer_id, sum(amount), ROUND(( select avg(amount) FROM payment), 2)  from payment GROUP BY customer_id HAVING SUM(amount) > (SELECT AVG(amount) FROM payment)




-- Get total payment that is above the average of all payments, join staff who made rental and customer. Data should be as in the image.
select  c.first_name, c.last_name, s.first_name, s.last_name, SUM(p.amount) from customer c
JOIN payment p
ON p.customer_id = c.customer_id
JOIN staff s
ON s.staff_id = p.staff_id
GROUP BY c.customer_id, s.staff_id, p.payment_id
HAVING SUM(p.amount) > (SELECT AVG(AMOUNT) FROM payment)
ORDER BY SUM(p.amount) DESC
 