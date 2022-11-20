--1. Вывести для каждого покупателя его адрес, город и страну проживания
select customer_id, first_name ||' '|| last_name as name, address, city, country from customer c
join address a using (address_id)
join city using (city_id)
join country using (country_id);

--2. Посчитать для каждого магазина количество покупателей. Доработать запрос и вывести только те магазины, у которых количество покупателей больше 300
-- Доработать запрос, добавив в него информацию о городе магазина, фамилии и имени продавца, который работает в нём
select store_id, count(customer_id), city, s2.first_name ||' '|| s2.last_name as staff_name from store s 
join customer c using (store_id)
join address a on s.address_id = a.address_id 
join city using (city_id)
join staff s2 using (store_id)
group by store_id, city, staff_name having count(customer_id) > 300

--3. Вывести топ 5 покупателей, которые взяли в аренду за всё время наибольшее количество фильмов
select customer_id, first_name ||' '|| last_name as name, count(rental_id) as count_rental from rental r 
join customer using (customer_id)
group by customer_id, name
order by 3 desc limit 5

--4. Посчитать для каждого покупателя 4 аналитических показателя:
-- количество взятых в аренду фильмов;
-- общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа);
-- минимальное значение платежа за аренду фильма;
-- максимальное значение платежа за аренду фильма.
select r.customer_id, count(rental_id), sum(amount), max(amount), min(amount) from rental r
join payment using (rental_id)
group by r.customer_id

--5. Используя данные из таблицы городов, составить одним запросом все возможные пары городов так, чтобы в результате не было пар с одинаковыми названиями городов (использовано декартово произведение)
select c1.city, c2.city from city c1, city c2
where c1.city <> c2.city 

--6. Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date) и дате возврата (поле return_date), вычислить для каждого покупателя среднее количество дней, за которые он возвращает фильмы
select customer_id, round(avg(return_date::date-rental_date::date), 2) as "Среднее кол-во дней возврата" from rental
group by customer_id

--7. Посчитать для каждого фильма, сколько раз его брали в аренду, а также общую стоимость аренды фильма за всё время
select film_id, title as "Название фильма", count(i.film_id) as "Кол-во аренд", sum(p.amount) as "Общая ст-ть аренды" from film f
join inventory i using (film_id)
join rental r using (inventory_id)
join payment p using (rental_id)
group by film_id
order by 4 desc

--8. Доработать запрос из предыдущего задания и вывести с помощью него фильмы, которые ни разу не брали в аренду
select f.title as "Название фильма", count(i.film_id) as "Кол-во аренд", sum(p.amount) as "Общая ст-ть аренды" from film f
left join inventory i using (film_id)
left join rental r using (inventory_id)
left join payment p using (rental_id)
group by 1
having count(i.film_id) = 0

--9. Посчитать количество продаж, выполненных каждым продавцом. Добавить вычисляемую колонку «Премия». Если количество продаж превышает 7 300, то значение в колонке будет «Да», иначе должно быть значение «Нет»
select staff_id, count(payment_id) as "Количество продаж",
case when count(payment_id) > 7300 then 'Да' else 'Нет' end as "Премия"
from payment
group by staff_id