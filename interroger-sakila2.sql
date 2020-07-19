use sakila; 

# 1) 10locations les plus longues 
select customer.first_name, customer.last_name, film.title, store.store_id as video_club, datediff(rental.return_date, rental.rental_date) as duree_location
from customer 
join rental on customer.customer_id= rental.customer_id 
join inventory on inventory.inventory_id=rental.inventory_id
join film on inventory.film_id= film.film_id
join store on store.store_id= inventory.store_id
order by duree_location DESC 
limit 10;
 
# 2) 10meilleurs clients actifs par montant dépensé
SELECT customer.first_name, customer.last_name,sum(payment.amount) as montant_depense
from customer
join payment on payment.customer_id = customer.customer_id
group by customer.customer_id
order by montant_depense DESC 
limit 10;

# 3) durée moyenne de location par film triée de manière descendante
select film.title, inventory.film_id , AVG(datediff(rental.return_date, rental.rental_date)) as duree_moyenne
from film 
join inventory on film.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
where return_date is not null
group by inventory.film_id
order by duree_moyenne DESC;

#4) Afficher tous les films n'ayant jamais été empruntés
select film.title 
from film 
 left join inventory on inventory.film_id = film.film_id
 join rental on inventory.inventory_id = rental.inventory_id
 where rental.rental_id is null;


# 5) Afficher le nombre d'employés (staff) par video club 

select store.store_id as video_club , count(staff.staff_id) as nbre_employes
from staff
join store on store.store_id= staff.store_id
group by store.store_id;

#6) Afficher les 10 villes avec le plus de video clubs
select city.city, count(store.store_id)
from city
join address on address.city_id= city.city_id
join store on store.address_id= address.address_id
group by address.city_id
order by count(store.store_id) DESC
limit 10;

#7) Afficher le film le plus long dans lequel joue Johnny Lollobrigida 
select film.title 
from film 
join  film_actor on film_actor.film_id=film.film_id
join actor on actor.actor_id= film_actor.actor_id
where actor.first_name='Johnny' and actor.last_name='Lollobrigida'
order by film.length 
limit 1;
 
 #8- Afficher le temps moyen de location du film 'Academy dinosaur' 
 select avg (datediff(rental.return_date, rental.rental_date)) as temps_moy_location, count(film.title) as nbre_films
 from film 
 join inventory on film.film_id= inventory.film_id
 join rental on rental.inventory_id= inventory.inventory_id
 where film.title='Academy dinosaur';
 
#9- Afficher les films avec plus de deux exemplaires en invenatire (store id, titre du film, nombre d'exemplaires)  
select  inventory.store_id, film.title,  count(inventory.film_id) as nbre_exemplaires 
from film 
join inventory on inventory.film_id=film.film_id 
group by film.title,inventory.store_id
having nbre_exemplaires>2;

#10)Lister les films contenant 'din' dans le titre 
select film.title from film where title like '%din%';

# 11) Lister les 5 films les plus empruntés 
select  film.film_id , film.title, count(film.film_id) as nbre_film
from film
join inventory on inventory.film_id=film.film_id
join rental on rental.inventory_id= inventory.inventory_id
group by film.film_id 
order by nbre_film DESC 
limit 5;

#12- Lister les films sortis en 2003, 2005 et 2006 

select title, release_year from film where (release_year=2003 or release_year=2005 or release_year=2006);

#13) Afficher les films ayant été empruntés mais n'ayant pas encore été restitués, triés par date 

select  distinct film.title, rental.rental_date, rental.return_date 
from film
join inventory on inventory.film_id= film.film_id
join rental on rental.inventory_id= inventory.inventory_id
where return_date is null 
order by rental.rental_date desc;


#14) Afficher les films d'action durant plus de 2h
select film.title, category.name, film.length
from film
join film_category on film_category.film_id=film.film_id
join category on category.category_id=film_category.category_id 
where (category.name='action' and film.length>120);

#15- Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17
select DISTINCT customer.customer_id,  customer.first_name, customer.last_name 
from customer
join rental on rental.customer_id=customer.customer_id
join inventory on inventory.inventory_id=rental.inventory_id
join film on film.film_id=inventory.film_id
where film.rating='NC-17'
order by customer.first_name;

#16) Afficher les films d'animation dont la langue originale est l'anglais 
select film.title, film.original_language_id 
from category
join film_category on film_category.category_id=category.category_id
join film on film.film_id= film_category.film_id
join language on language.language_id=film.original_language_id 
where category.name='Animation' and language.name='English';


#17- Afficher les films dans lesquels une actrice nommée Jennifer a joué (bonus: en même temps qu'un acteur nommé Johnny) 
select film.title 
from film
join film_actor on film_actor.film_id=film.film_id
join actor on actor.actor_id= film_actor.film_id
where (actor.first_name='JENNIFER' and actor.first_name='JOHNNY');

#18- Quelles sont les 3 catégories les plus empruntées?
select  category.name, count(film.film_id)
from category
join film_category on film_category.category_id= category.category_id
join film on film.film_id=film_category.film_id
join inventory on inventory.film_id=film.film_id
join rental on rental.inventory_id= inventory.inventory_id
group by category.name
order by count(film.film_id) DESC
limit 3; 

#19- Quelles sont les 10 villes où on a fait le plus de locations?
 select city.city, count(rental.rental_id)
 from city 
 join address on address.city_id=city.city_id
 join store on store.address_id=address.address_id
 join customer on customer.store_id= store.store_id
 join rental on rental.customer_id=customer.customer_id
 group by city.city
 order by count(rental.rental_id) DESC
 limit 10;
 
 #20- Lister les acteurs ayant joué dans au moins 1 film
 select actor.first_name, actor.last_name, count(film.film_id) as nbre_films
 from actor
 join film_actor on film_actor.actor_id= actor.actor_id
 join film on film.film_id=film_actor.film_id 
 group by actor.actor_id
 having count(film.film_id)>=1
 order by count(film.film_id) DESC;
 

