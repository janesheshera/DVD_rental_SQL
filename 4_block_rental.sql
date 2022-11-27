-- 1. С помощью оконных функций добавить вычисляемые колонки согласно условиям:
-- Пронумеровать все платежи от 1 до N по дате
select payment_id, customer_id, amount, payment_date, row_number() over(order by payment_date) from payment;

-- Пронумеровать платежи для каждого покупателя, сортировка платежей должна быть по дате
select payment_id, customer_id, amount, payment_date, row_number() over(partition by customer_id order by payment_date, amount) from payment;

-- Расчет нарастающим итогом суммы всех платежей для каждого покупателя, сортировка должна сперва по дате платежа, а затем по сумме платежа от наименьшей к большей
select payment_id, customer_id, amount, payment_date, sum(amount) over(partition by customer_id order by payment_date) from payment;

-- Нумерация платежей для каждого покупателя по стоимости платежа от наибольших к меньшим так, чтобы платежи с одинаковым значением имели одинаковое значение номера
select payment_id, customer_id, amount, payment_date, dense_rank() over(partition by customer_id order by amount) from payment;

-- 2. С помощью оконной функции вывести для каждого покупателя стоимость платежа и стоимость платежа из предыдущей строки с сортировкой по дате (для первой строки значение по умолчанию 0.0).
select payment_id, customer_id, payment_date, amount, lag(amount, 1, 0.) over(partition by customer_id order by payment_id) from payment;

-- 3. С помощью оконной функции определить, на сколько каждый следующий платеж покупателя больше или меньше текущего.
select payment_id, customer_id, payment_date, amount, lead(amount, 1, 0.) over(partition by customer_id order by payment_id) - amount as delta
from payment

-- 4. С помощью оконной функции для каждого покупателя вывести данные о его последней оплате аренды.
select * from (select customer_id, payment_date, amount, rental_id, row_number() over (partition by customer_id order by payment_date desc) from payment) t
where row_number = 1

-- 5. С помощью оконной функции вывести для каждого сотрудника сумму продаж за апрель 2007 года:
select staff_id, payment_date, amount, sum(amount) over(partition by staff_id) from payment p 
where payment_date::date between '2007-04-01' and '2007-04-30'

-- с нарастающим итогом по каждому сотруднику и по каждой дате продажи (без учёта времени) 
select staff_id, amount, date_m, sum(amount) over(partition by staff_id order by date_m) from (select staff_id, amount, payment_date::date as date_m from payment) as foo
where date_m between '2007-04-01' and '2007-04-30'

-- с сортировкой customer_id, payment_date, amount
select customer_id, staff_id, amount, date_m, sum(amount) over(partition by staff_id order by customer_id, date_m, amount) from (select customer_id, staff_id, amount, payment_date::date as date_m from payment) as foo
where date_m between '2007-04-01' and '2007-04-30'

--6. 20 августа 2005 года в магазинах проходила акция: покупатель каждого сотого платежа получал дополнительную скидку на следующую аренду. С помощью оконной функции вывести всех покупателей, которые в день проведения акции получили скидку
select * from (select *, row_number() over (order by payment_id) % 100 = 0 as r from payment) as foo1
where payment_date::date = '2007-03-20' and r = true 

-- 7. Для каждой страны определить и вывести одним SQL-запросом покупателей, которые попадают под условия:
-- покупатель, арендовавший наибольшее количество фильмов
-- покупатель, который последним арендовал фильм
select country, customer_id, max(count2) from (
select country, customer_id, count(rental_id) over (partition by customer_id) as count2 from country
join city using (country_id)
join address using (city_id)
join customer using (address_id)
join rental using (customer_id)
order by country) as foo2
group by (country, customer_id)
order by max desc

-- покупатель, арендовавший фильмов на самую большую сумму
select country, customer_id, max(amount2) from (
select country, customer_id, sum(amount) over (partition by customer_id) as amount2 from country
join city using (country_id)
join address using (city_id)
join customer using (address_id)
join payment using (customer_id)
order by country) as foo3
group by (country, customer_id)
order by max desc

-- покупатель, который последним арендовал фильм
select country, customer_id, max(count2) from (
select country, customer_id, count(rental_id) over (partition by customer_id) as count2 from country
join city using (country_id)
join address using (city_id)
join customer using (address_id)
join rental using (customer_id)
order by country) as foo2
group by (country, customer_id)
order by max desc