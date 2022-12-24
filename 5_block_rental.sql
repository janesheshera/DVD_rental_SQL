-- 1. Сделайте запрос к таблице rental. Используя оконную функцию, добавьте колонку с порядковым номером аренды для каждого пользователя (сортировать по rental_date)
select customer_id, rental_date, row_number() over(partition by customer_id order by rental_date asc) as rental_number 
from rental r;

-- 2.Для каждого пользователя подсчитайте сколько он брал в аренду фильмов со специальным атрибутом Behind the Scenes
select r.customer_id, count (rental_id) as qty_rental from rental r
join inventory i using (inventory_id)
join film f using (film_id)
where special_features @> array ['Behind the Scenes']
group by customer_id
order by customer_id;

-- Создайте материализованное представление с этим запросом
create materialized view rental_BTS as
select r.customer_id, count (rental_id) as qty_rental from rental r
join inventory i using (inventory_id)
join film f using (film_id)
where special_features @> array ['Behind the Scenes']
group by customer_id
order by customer_id;

select * from rental_BTS;
-- Обновите материализованное представление
refresh materialized view rental_BTS


--1. Написать SQL-запрос, который выводит всю информацию о фильмах со специальным атрибутом "Behind the Scenes".
select * from film f 
where special_features && array['Behind the Scenes'];

--2. Написать еще 2 варианта поиска фильмов с атрибутом "Behind the Scenes", используя другие функции или операторы языка SQL для поиска значения в массиве.
select * from film f 
where special_features @> array['Behind the Scenes'];

select film_id, title, array_agg(unnest)
from (
	select film_id, title, unnest(special_features)
	from film) t
where unnest = 'Behind the Scenes'
group by film_id, title;

--3. Для каждого покупателя посчитать сколько он брал в аренду фильмов со специальным атрибутом "Behind the Scenes".
-- Условие: использовать запрос из задания 1, помещенный в CTE.

with cte as (
select * from film f 
where special_features @> array['Behind the Scenes']
)
select distinct customer_id, count(rental_id) over(partition by customer_id), special_features from rental
join inventory using (inventory_id)
join cte using (film_id)
order by 1;

--4. Для каждого покупателя посчитать сколько он брал в аренду фильмов со специальным атрибутом "Behind the Scenes".
--Обязательное условие: использовать запрос из задания 1, помещенный в подзапрос.
select customer_id, film_id, title, rental_id, special_features, count(special_features) over(partition by customer_id) from rental
join inventory using (inventory_id)
join (select * from film f 
where special_features && array['Behind the Scenes']) as foo
using (film_id);

--5. Вывеcти сколько специальных атребутов (special_features) у фильма
select film_id, title, special_features, array_length(special_features, 1) from film

--6. Вывеcти сколько максимально элементов содержит атрибут special_features

select max(array_length(special_features, 1)) from film

--7. Вывести все фильмы содержащие специальные атрибуты: 'Trailers','Commentaries'
-- * Используйте операторы: @> - содержит; <@ - содержится в

select * from film
where special_features @> array ['Trailers'] or special_features @> array ['Commentaries']

select * from film
where array ['Trailers'] <@ special_features or array ['Commentaries'] <@ special_features

--8. Создать материализованное представление с запросом из предыдущего задания и написать запрос для обновления материализованного представления

create materialized view features as 
select * from film
where special_features @> array ['Trailers'] or special_features @> array ['Commentaries']

refresh materialized view features

--9. Создать материализованное представление с колонками клиент (ФИО; email) и title фильма, который он брал в прокат последним
-- Создать материализованное представление без наполнения (with NO DATA):

create materialized view last_rental as 
	with maxi as  (
	select distinct customer_id, inventory_id, max(rental_date) as last_rent from rental
	group by 1,2
	)
	select first_name ||' '|| last_name as customer, email, title as film_title, last_rent::date from customer
	join maxi using (customer_id)
	join inventory using (inventory_id)
	join film using (film_id)
with no data

--10. Используя оконную функцию вывести для каждого сотрудника сведения о самой первой продаже.
select s.first_name ||' '|| s.last_name as staff, c.first_name ||' '|| c.last_name as customer, payment_date::date,  title as film from staff s
join (select *, rank() over(partition by staff_id order by payment_date) from payment) as f
using (staff_id)
join customer c using (customer_id)
join rental r using (rental_id)
join inventory i using (inventory_id)
join film using (film_id)
where rank = 1;

--11. Для каждого магазина определить и вывести одним SQL-запросом следующие аналитические показатели:
-- день, в который арендовали больше всего фильмов (день в формате год-месяц-день)
-- количество фильмов взятых в аренду в этот день
-- день, в который продали фильмов на наименьшую сумму (день в формате год-месяц-день)
-- сумму продажи в этот день

select distinct store_id, payment_date::date, sum(amount) over(partition by store_id, payment_date::date), qty.rental_date, qty.count from payment p 
join rental using (rental_id)
join inventory i using (inventory_id)
join (select distinct store_id, rental_date::date as rental_date, count(film_id) over(partition by store_id,rental_date::date) from rental
join inventory using (inventory_id)
order by 3 desc
limit 2) as qty using (store_id)
order by 3 asc
limit 2
