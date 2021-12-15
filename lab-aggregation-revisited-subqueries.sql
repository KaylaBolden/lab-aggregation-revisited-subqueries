-- 1. Select the first name, last name, and email address of all the customers who have rented a movie.
select first_name, last_name, email from sakila.customer;
-- 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select c.customer_id, concat(first_name, " ", last_name) as full_name, avg(amount) as payment 
from sakila.customer c join sakila.payment p on c.customer_id=p.customer_id
group by c.customer_id, full_name;
-- 3. Select the name and email address of all the customers who have rented the "Action" movies.

-- 		Write the query using multiple join statements
select distinct concat(first_name, " ", last_name) as full_name, email from sakila.customer c
join sakila.rental r on c.customer_id=r.customer_id
join sakila.inventory i on r.inventory_id=i.inventory_id
join sakila.film f on i.film_id=f.film_id
join sakila.film_category fc on f.film_id=fc.film_id
join sakila.category ca on fc.category_id=ca.category_id
where ca.name="Action";
-- 		Write the query using sub queries with multiple WHERE clause and IN condition
select concat(first_name, " ", last_name) as full_name, email from sakila.customer c
where customer_id in (select customer_id from sakila.rental 
where inventory_id in (select inventory_id from sakila.inventory 
where film_id in (select film_id from sakila.film 
where film_id in (select film_id from sakila.film_category
where category_id = (select category_id from sakila.category
where name="Action")))));


-- 		Verify if the above two queries produce the same results or not
-- 		yes they do.

-- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
-- 		If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, 
-- 		and if it is more than 4, then it should be high.

select *, 
case when amount <=2 then "low"
when amount <=4 then "medium" 
when amount >4 then "high" end as classify 
from sakila.payment;