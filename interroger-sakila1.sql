use sakila; 

#*********************************************INTEROGATION AVANCEE*************************************************************

#1 Afficher tout les emprunt ayant été réalisé en 2006. Le mois doit être écrit en toute lettre et le résultat doit s’afficher dans une seul colonne.
select *, MONTHNAME(rental_date) as date_location from rental where year(rental_date)=2006; 

#2 Afficher la colonne qui donne la durée de location des films en jour.
select DATEDIFF(return_date,rental_date ) from rental;

#3 Afficher les emprunts réalisés avant 1h du matin en 2005. Afficher la date dans un format lisible.
select *, rental_date from rental where hour(rental_date)<1 AND year(rental_date)=2005;

#4 Afficher les emprunts réalisé entre le mois d’avril et le moi de mai. La liste doit être trié du plus ancien au plus récent.
##select * from rental where MONTHNAME(rental_date) between 'april' and 'may' order by rental_date; ca marche pas!
select * from rental where MONTHNAME(rental_date) ='april' or MONTHNAME(rental_date) ='may' order by rental_date;


#5 Lister les film dont le nom ne commence pas par le « Le ».
select * from film where title not like 'le%';
select title from film where left (title,2)<> 'Le';

#6 Lister les films ayant la mention « PG-13 » ou « NC-17 ». Ajouter une colonne qui affichera « oui » si « NC-17 » et « non » Sinon.
select *, 
case rating 
	when 'NC-17'  then  'oui' 
    when 'PG-13' then 'non'
end 
from film 
where rating='PG-13' OR rating='NC-17' ;

#7 Fournir la liste des catégorie qui commence par un ‘A’ ou un ‘C’. (Utiliser LEFT).
select * from category where name LIKE 'A%' OR name LIKE'C%';
select * from category where left (name,1)='A'or left (name,1)='C' ;

#8 Lister les trois premiers caractères des noms des catégorie.
select LEFT (name, 3) from category;

#9 Lister les premiers acteurs en remplaçant dans leur prenom les E par des A.
select replace(last_name, 'E', 'A')FROM actor;

#***********************************************JOINTURES***************************************************************

#1 Lister les 10 premiers films ainsi que leur langues.
select film.title, language.name  
from film 
inner join language on film.language_id=language.language_id 
limit 10;

#2 Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.
SELECT title, actor.first_name ,actor.last_name, film.release_year 
from film  
join film_actor on film.film_id = film_actor.film_id 
join actor on film_actor.actor_id=actor.actor_id 
where (actor.first_name='JENNIFER' and actor.last_name='DAVIS') and film.release_year=2006;

#3 Afficher le noms des client ayant emprunté « ALABAMA DEVIL ».
SELECT film.title, customer.first_name , customer.last_name
from customer 
join  rental on customer.customer_id=rental.customer_id 
join inventory on rental.inventory_id=inventory.inventory_id 
join film on inventory.film_id=film.film_id 
where film.title='ALABAMA DEVIL';

# pour unir deux select il faut qu elles aient le meme nombre de colonnes et le meme nom
# Afficher les films louer par des personne habitant à « Woodridge ». Vérifier s’il y a des films qui n’ont jamais été emprunté.
select film.title, customer.last_name, customer.first_name, city.city 
from city
join address on city.city_id=address.city_id 
join customer on address.address_id= customer.address_id 
join rental on customer.customer_id=rental.customer_id 
join inventory on rental.inventory_id= inventory.inventory_id
join film on inventory.film_id = film.film_id
where city.city='Woodridge';
##union 
 select film.title, film.film_id from film 
 join inventory on film.film_id= inventory.film_id
 left join rental on inventory.inventory_id= rental.inventory_id
 where rental.rental_id is null;
 
 #5 Quel sont les 10 films dont la durée d’emprunt à été la plus courte ?
 select film.title, rental.rental_date, rental.return_date, datediff(rental.return_date,rental.rental_date) as duree_location
 from film 
 join inventory on film.film_id=inventory.film_id
 join rental on rental.inventory_id=inventory.inventory_id
 where rental.return_date  is not null
 order by duree_location
 limit 10;
 
 #6 Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.
select film.title, category.name 
from film 
join  film_category on film.film_id=film_category.film_id
join category on category.category_id =film_category.category_id
where category.name='Action'
order by film.title;

#7 Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour ?
select film.title, rental.rental_date, rental.return_date 
from film 
join inventory on film.film_id=inventory.film_id
join rental on rental.inventory_id=inventory.inventory_id
where datediff(rental.return_date,rental.rental_date) is not null
and datediff(rental.return_date,rental.rental_date)<2; 

# jointure a gauche et a droite 
select language.name, film.title  from film
right join language
on film.language_id = language.language_id 
where language.name <> 'English';

#REQUETES D'AGREGATION 
# 01
SELECT  count(film_category.film_id) as nbre_films, category.category_id, category.name, actor.first_name, actor.last_name
from category
join film_category 
on category.category_id=film_category.category_id
join film
on film_category.film_id=film.film_id
join film_actor
on film_actor.film_id=film.film_id
join actor
on actor.actor_id=film_actor.actor_id
where actor.first_name='JOHNNY' and actor.last_name='LOLLOBRIGIDA'
group by category.category_id;

# code Nededra
select count(film.film_id),film_category.category_id 
from film_category 
join film on film.film_id = film_category.film_id 
join film_actor on film.film_id =film_actor.film_id 
inner join actor on actor.actor_id = film_actor.actor_id 
where actor.first_name ='JOHNNY' and actor.last_name = 'LOLLOBRIGIDA' 
group by film_category.category_id;

#2 
SELECT  count(film.film_id) as nbre_films, category.category_id, category.name, actor.first_name, actor.last_name
from category
join film_category 
on category.category_id=film_category.category_id
join film
on film.film_id=film_category.film_id
join film_actor
on film_actor.film_id=film.film_id
join actor
on actor.actor_id=film_actor.actor_id
where actor.first_name='JOHNNY' and actor.last_name='LOLLOBRIGIDA'
group by category.category_id
having nbre_films>=3;
#3 
select avg(datediff(rental.return_date, rental.rental_date )), film.title, actor.actor_id
from actor
join film_actor on film_actor.actor_id= actor.actor_id
join film on film_actor.film_id=film.film_id
join inventory on inventory.film_id=film.film_id
join rental on rental.inventory_id=inventory.inventory_id
group by actor.actor_id;

#1- Quels acteurs ont le prénom "Scarlett "
SELECT * FROM actor WHERE first_name='Scarlett';

#2 Quels acteurs ont le nom de famille "Johansson "
SELECT * FROM actor WHERE last_name='Johansson';

# 3Combien de noms de famille d'acteurs distincts y a-t-il ?
select count(DISTINCT (last_name)) from actor; 

#4 Quels noms de famille ne sont pas répétés ? 

select count(last_name) as nbre, last_name  from actor group by last_name  having nbre=1;

#5 Quels noms de famille apparaissent plus d'une fois ?

select distinct last_name, count(last_name) from actor group by last_name having count(last_name)>1;

#6 Quel acteur est apparu dans le plus grand nombre de films ? 
select count(film_actor.film_id) as nbre_films, film_actor.actor_id, actor.first_name, actor.last_name from film_actor
join actor on actor.actor_id=film_actor.actor_id
group by film_actor.actor_id
##having max(nbre_films); 
order by  nbre_films desc
limit 1;

#Quand "Academy Dinosaur" est-il sortie ?  
select release_year from film where title='Academy Dinosaur';

#Quelle est la durée moyenne de tous les films ? 
 select avg(length) from film;  
 
#Quelle est la durée moyenne des films par catégorie ?
select avg(film.length), category.name from film
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
group by film_category.category_id;

 





