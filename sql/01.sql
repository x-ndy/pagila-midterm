/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

WITH titles AS (
    SELECT film_id
    FROM film
    WHERE film_id NOT IN (SELECT film_id
        FROM film
        WHERE title ILIKE '%F%'
    )
), 
actors AS (
    SELECT film_id
    FROM film
    WHERE film_id NOT IN (SELECT film.film_id
        FROM film
        JOIN film_actor ON film.film_id = film_actor.film_id
        JOIN actor ON film_actor.actor_id = actor.actor_id
        WHERE (actor.first_name ILIKE '%F' OR actor.last_name ILIKE '%F%')
    )
), 
customers AS (
    SELECT film_id
    FROM film
    WHERE film_id NOT IN (SELECT film.film_id
        FROM film
        JOIN inventory ON film.film_id = inventory.film_id
        JOIN rental ON inventory.inventory_id = rental.inventory_id
        JOIN customer ON rental.customer_id = customer.customer_id
        WHERE (customer.first_name ILIKE '%F%' 
            OR customer.last_name ILIKE '%F%')
    )
), 
addresses AS (
    SELECT film_id
    FROM film
    WHERE film_id NOT IN (SELECT film.film_id
        FROM film
        JOIN inventory ON film.film_id = inventory.film_id
        JOIN rental ON inventory.inventory_id = rental.inventory_id
        JOIN customer ON rental.customer_id = customer.customer_id
        JOIN address ON address.address_id = customer.address_id
        JOIN city ON city.city_id = address.city_id
        JOIN country ON country.country_id = city.country_id
        WHERE (country.country ILIKE '%F%' 
            OR city.city ILIKE '%F%' 
            OR address.address ILIKE '%F%' 
            OR address.address2 ILIKE '%F%')
    )
)

SELECT DISTINCT film.title
FROM film
WHERE film_id IN (SELECT * FROM titles)
AND film_id IN (SELECT * FROM actors)
AND film_id IN (SELECT * FROM customers)
AND film_id IN (SELECT * FROM addresses)
ORDER BY title;        




















