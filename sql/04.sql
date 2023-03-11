/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query SELECT query that:
 * Lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 * (You may choose to either include or exclude the movie 'AMERICAN CIRCUS' in the results.)
 */


SELECT f.title
FROM film f
JOIN film_actor fa1 ON fa1.film_id = f.film_id
JOIN film_actor fa2 ON fa2.actor_id = fa1.actor_id
JOIN film fc ON fc.film_id = fa2.film_id AND fc.title = 'AMERICAN CIRCUS'
GROUP BY f.film_id
HAVING COUNT(DISTINCT fa1.actor_id) >= 2;








