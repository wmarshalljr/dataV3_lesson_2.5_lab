USE sakila;

-- LAB 2.5

-- 1. Select all the actors with the first name ‘Scarlett’

SELECT * FROM sakila.actor WHERE (first_name = 'Scarlett');

-- 2. How many films (movies) are available for rent and how many films have been rented?

SELECT * FROM sakila.rental;

SELECT COUNT(film_id) FROM sakila.film; -- Do we mean films to rent in their inventory? If so, there are 1,000 titles available for rent

SELECT COUNT(rental_id) FROM sakila.rental; -- If rental_id means a film has been rented (and therefore a unique code has been created), then 16,044 total rentals

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.

SELECT * FROM sakila.film;
SELECT MIN(length) AS 'min_duration', MAX(length) AS 'max_duration' FROM sakila.film; -- Shortest: 46, Longest: 185

-- 4. What's the average movie duration expressed in format (hours, minutes)?

SELECT CONCAT(length DIV 60,':',length % 60) AS 'runtime' FROM sakila.film; -- COULD NOT FINISH THE STEP TO CONVERT TO THE AVERAGE 

SELECT SEC_TO_TIME(ROUND(AVG(length)*60,-2)) FROM Sakila.film; -- Found this SEC_TO_TIME ready-built function instead...

-- 5. How many distinct (different) actors' last names are there?

SELECT COUNT(DISTINCT(last_name)) FROM sakila.actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?

SELECT * FROM sakila.rental
ORDER BY rental_date ASC; -- Looking to see when they first started renting because this may be the only proxy for day 0 operating date

SELECT DATEDIFF(MAX(last_update), MIN(rental_date)) FROM sakila.rental; -- Time between the first rental and the last update as a proxy for 'operating' time. 275 days

-- 7. Show rental info with additional columns month and weekday. Get 20 results.

SELECT *, DAYNAME(rental_date) as Weekday, MONTHNAME(rental_date) as Month FROM sakila.rental
LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

-- Option 1:
SELECT *, DAYNAME(rental_date),
CASE 
WHEN DAYNAME(rental_date) in ('Monday','Tuesday','Wednesday','Thursday','Friday') then 'workday'
WHEN DAYNAME(rental_date) in ('Saturday','Sunday') then 'weekend'
END AS 'day_type' FROM sakila.rental; 

-- Option 2:
SELECT *, DAYOFWEEK(rental_date), 
CASE
WHEN DAYOFWEEK(rental_date) in (2,3,4,5,6) then 'workday'
WHEN DAYOFWEEK(rental_date) in (1,7) then 'weekend'
END AS 'day_type' FROM sakila.rental;

-- 9. Get release years.

SELECT release_year FROM sakila.film; -- Easy peasy...

-- 10. Get all films with ARMAGEDDON in the title.

SELECT title
FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO.

SELECT title
FROM sakila.film
WHERE title LIKE '%APOLLO'; -- Could also use the string function for RIGHT

-- 12. Get 10 the longest films.

SELECT *, length FROM sakila.film -- Looks like the longest films are <= 185 mins
ORDER BY length DESC
LIMIT 10;

-- 13. How many films include Behind the Scenes content?

SELECT DISTINCT(special_features) FROM sakila.film
WHERE special_features LIKE '%Behind the Scenes%'; -- Looking at the special features column for unique data types. Looks like the strings are mixed so we need LIKE function

SELECT COUNT(DISTINCT IF(special_features LIKE '%Behind the Scenes%', film_id, NULL)) AS 'Behind_the_Scenes' FROM sakila.film; -- 538 films with Behind the Scenes content

