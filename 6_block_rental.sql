--1. Рассчитать совокупный доход всех магазинов на каждую дату.
select distinct payment_date::date, sum(amount) over(partition by payment_date::date) from payment p 
join staff using (staff_id)
order by 1

--2. Вывести наиболее и наименее востребованные жанры.
select c.name, count(rental_id) as qty_rental from category c
join film_category fc using (category_id)
join inventory i using (film_id)
join rental using (inventory_id)
group by 1
order by 2 desc

--3. Рассчитать среднюю арендную ставку для каждого жанра.
select c.name, round (avg(amount),2) as avg_amount from category c
join film_category fc using (category_id)
join inventory i using (film_id)
join rental using (inventory_id)
join payment p using (rental_id)
group by 1
order by 2 desc

--4. Составить список из 5 самых дорогих клиентов.
select first_name||' '||last_name as client, sum(amount) as total_amount from customer
join rental using (customer_id)
join payment p using (rental_id)
group by 1
order by 2 desc
limit 5

--5. Статистика своевременности возврата арендованных фильмов.
select title, round(avg(return_date::date-rental_date::date),2) as avg_return from rental
join inventory i using (inventory_id)
join film using (film_id)
group by 1
order by 2 desc