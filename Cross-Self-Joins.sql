use sakila; 

# 1. Get all pairs of actors that worked together.
select * from actor; 
select * from film_actor;

select f1.film_id,
f.title as title_of_film,
f1.actor_id,
concat(a.first_name, ' ', a.last_name) as actor_1,
f2.actor_id,
concat(a.first_name, ' ', a.last_name) as actor_2
from film_actor f1
inner join film_actor f2 on f1.film_id = f2.film_id
and f1.actor_id < f2.actor_id
inner join film f on f.film_id = f1.film_id
inner join actor a on f1.actor_id = a.actor_id; 


# 2. Get all pairs of customers that have rented the same film more than 3 times
select * from customer; 
select * from rental; 

select c1.customer_id,
concat(c1.first_name, ' ', c1.last_name) as customer_name1,
c2.customer_id,
concat(c2.first_name, ' ', c2.last_name) as customer_name2,
count(r1.rental_id) as rentals_count
from customer c1
inner join rental r1 on r1.customer_id = c1.customer_id
inner join inventory i1 on i1.inventory_id = r1.inventory_id
inner join film f1 on i1.film_id = f1.film_id
inner join inventory i2 on f1.film_id = i2.film_id
inner join rental r2 on i2.inventory_id = r2.inventory_id
inner join customer c2 on r2.customer_id = c2.customer_id
where c1.customer_id != c2.customer_id
group by 1,3
having count(*) > 3
order by rentals_count desc; 


# 3. Get all possible pairs of actors and films
select * from film_actor; 
select * from actor; 
select * from film; 

select f.title as title_of_film,
concat(a1.first_name, ' ', a1.last_name) as actor_1,
concat(a2.first_name, ' ', a2.last_name) as actor_2
from film_actor f1
inner join film_actor f2 
on f1.actor_id > f2.actor_id
and f1.film_id = f2.film_id
inner join actor a1 
on f1.actor_id = a1.actor_id
inner join actor a2 on f2.actor_id = a2.actor_id
inner join film f on f1.film_id = f.film_id
order by title_of_film
limit 5;