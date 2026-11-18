-- q1: List names of all the languages in the database (sorted
-- alphabetically)?
select name
from language
order by name;

-- q2: List full names of actors with “GER” in their last name,
-- ordered by their first name
select first_name, last_name
from actor
where last_name like '%GER%'
order by first_name;

-- q3: Find all the addresses where postal code starts with “57”, and
-- return addresses sorted.
select address, postal_code
from address
where postal_code like '57%'
order by address asc;

-- q4: How many films involve a “DWARF” in their titles?
select count(*) as number_of_films
from film
where title like '%DWARF%';

-- q5: Find full names of actors who played in a film involving ‘WAR’
-- in title and longer than 2.5 hours, along with the title, run
-- length and release year of the movie, sorted by the actors’ last
-- names.
select
    a.first_name,
    a.last_name,
    f.title,
    f.length,
    f.release_year

from actor as a
join film_actor as f_a
    on a.actor_id = f_a.actor_id
join film as f
    on f_a.film_id = f.film_id
where f.length > 150 and f.title like '%WAR%'
order by a.last_name;

-- q6: Find all the film categories in which there are between 55 and
-- 65 films. Return the names of these categories and the number
-- of films per category, sorted by the number of films descending.
select
    c.name,
    count(*) as number_of_films
from category as c
join film_category as f_c
    on c.category_id = f_c.category_id
group by c.category_id, c.name
having count(*) between 55 and 65
order by number_of_films desc;

-- q7: In how many film categories is the average difference between
-- the film replacement cost and the rental rate larger than 17?
select count(*) as number_of_categories
from (
    select c.category_id
    from category as c
    join film_category as fc
        on c.category_id = fc.category_id
    join film as f
        on fc.film_id = f.film_id
    group by c.category_id
    having avg(f.replacement_cost - f.rental_rate) > 17
) as qualifying_categories;

-- q8: Find the address district(s) name(s) such that the minimal
-- postal code in the district(s) is maximal over all the districts.
-- Make sure your query ignores empty postal codes and district names.
select district
from address
where trim(postal_code) <> '' and trim(district) <> ''
group by district
having min(trim(postal_code)) >= all (
    select min(trim(postal_code))
    from address
    where trim(postal_code) <> '' and trim(district) <> ''
    group by district
)
order by district;

-- q9: Find the names (first and last) of all the actors and customers
-- whose first name is the same as the first name of the actor
-- with ID 101 (exclude the actor with ID 101).
select a.first_name, a.last_name
from actor as a
join actor as reference_actor
    on a.first_name = reference_actor.first_name
where reference_actor.actor_id = 101 and a.actor_id <> 101
union all
select c.first_name, c.last_name
from customer as c
join actor as reference_actor
    on c.first_name = reference_actor.first_name
where reference_actor.actor_id = 101;
