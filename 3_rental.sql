-- 1. —делайте запрос к таблице rental. »спользу€ оконную функцию, добавьте колонку с пор€дковым номером аренды дл€ каждого пользовател€ (сортировать по rental_date)
select customer_id, rental_date, row_number() over(partition by customer_id order by rental_date asc) as rental_number 
from rental r;

-- 2.ƒл€ каждого пользовател€ подсчитайте сколько он брал в аренду фильмов со специальным атрибутом Behind the Scenes
select r.customer_id, count (rental_id) as qty_rental from rental r
join inventory i using (inventory_id)
join film f using (film_id)
where special_features @> array ['Behind the Scenes']
group by customer_id
order by customer_id;

-- —оздайте материализованное представление с этим запросом
create materialized view rental_BTS as
select r.customer_id, count (rental_id) as qty_rental from rental r
join inventory i using (inventory_id)
join film f using (film_id)
where special_features @> array ['Behind the Scenes']
group by customer_id
order by customer_id;

select * from rental_BTS;
-- ќбновите материализованное представление
refresh materialized view rental_BTS