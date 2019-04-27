use sakila;
select * from actor;
select concat(upper(first_name, ' ', last_name)) from actor as Actor_Name;
select first_name from actor where first_name = "Joe";
select last_name from actor where last_name like "%GEN%";
select last_name, first_name from actor where last_name like "%LI%";
select country, country_id from country where country in ('Afghanistan', 'Bangladesh', 'China');
ALTER TABLE actor
ADD decription blob AFTER last_name;
ALTER TABLE actor

DROP description;

SELECT distinct last_name
  FROM actor;

select count (distinct last_name)
	from actor;

SELECT * FROM actor WHERE last_name = "williams" and first_name = "groucho";  

UPDATE actor SET first_name = 'harpo' WHERE actor_id = 172;

UPDATE actor SET first_name = 'groucho' WHERE actor_id = 172;
SHOW CREATE TABLE customer_list;
select * from staff_list; 

SELECT staff_list.name, address.address FROM staff_list INNER JOIN address ON staff_list.address = address.address;

SELECT first_name, last_name, SUM(amount) FROM staff_list INNER JOIN payment ON staff_list.staff_id = payment.staff_id
GROUP BY payment.staff_id
ORDER BY last_name ASC;

SELECT title, COUNT(actor_id)FROM film.film INNER JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY title;

SELECT title, (SELECT COUNT(*) FROM inventory
WHERE (film.film_id = inventory.film_id) AS 'Number of Copies'
FROM film WHERE title = "Hunchback Impossible";

SELECT cusomer.first_name, custome.last_name, sum(payment.amount) AS `Total Paid`
FROM customer JOIN payment p ON customer.customer_id= payment.customer_id
GROUP BY customer.last_name;

SELECT title FROM film WHERE title  LIKE 'K%' OR title LIKE 'Q%'AND title IN 
(SELECT title  FROM film  WHERE language_id = 1);

SELECT first_name, last_name FROM actor WHERE actor_id IN
(Select actor_id FROM film_actor WHERE film_id IN 
(SELECT film_id FROM film WHERE title = 'Alone Trip'));

SELECT cus.first_name, cus.last_name, cus.email FROM customer cus
JOIN address ON (cusomer.address_id = address.address_id)
JOIN city cty ON (city.city_id = address.city_id)
JOIN country ON (country.country_id = city.country_id)
WHERE country.country= 'Canada';

SELECT title, description FROM film WHERE film_id IN
(SELECT film_id FROM film_category WHERE category_id IN
(SELECT category_id FROM category WHERE name = "Family"));

SELECT f.title, COUNT(rental_id) AS 'Times Rented'FROM rental
JOIN inventory ON (rental.inventory_id = invenory.inventory_id)
JOIN film ON (inventory.film_id = film.film_id)
GROUP BY film.title
ORDER BY `Times Rented` DESC;

SELECT store.store_id, SUM(amount) AS 'Revenue'FROM payment
JOIN rental ON (payment.rental_id = rental.rental_id)
JOIN inventory ON (inventory.inventory_id = rental.inventory_id)
JOIN store ON (store.store_id = inventory.store_id)
GROUP BY store.store_id; 

SELECT store.store_id, city.city, country.country FROM store
JOIN address ON (store.address_id = address.address_id)
JOIN city ON (city.city_id = address.city_id)
JOIN country ON (country.country_id = city.country_id);

SELECT category.name AS 'Genre', SUM(payment.amount) AS 'Gross' FROM category
JOIN film_category ON (category.category_id=film_category.category_id)
JOIN inventory ON (film_ctegory.film_id=inventory.film_id)
JOIN rental ON (iventory.inventory_id=rental.inventory_id)
JOIN payment ON (rental.rental_id=payment.rental_id)
GROUP BY category.name ORDER BY Gross  LIMIT 5;