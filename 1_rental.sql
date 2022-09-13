-- Вывести неактивных покупателей:
select * from customer where active = 0;

-- Вывести фильмы 2006 года:
select * from film where release_year = 2006;

-- Вывести 10 последних платежей:
select * from payment order by payment_date desc limit 10;

-- Вывести магазины, имеющие больше 300-от покупателей:
select store_id, count(customer_id) as qty_customer from customer c group by store_id
having count(customer_id) > 300;

-- Вывести у каждого покупателя город, в котором он живет:
select first_name||' '||last_name as customer_name, city from customer c 
join address a on c.address_id = a.address_id 
join city c2 on c2.city_id = a.city_id;

-- Вывести ФИО сотрудников и города магазинов, имеющих больше 300-от покупателей:
select s.store_id, s2.first_name, s2.last_name, city from store s
join staff s2 on s.store_id =s2.store_id 
join address a on s2.address_id = a.address_id 
join city c2 on c2.city_id =a.city_id
where s.store_id = (select store_id from customer c group by store_id
having count(customer_id) > 300);

-- Вывести количество актеров, снимавшихся в фильмах, которые сдаются в аренду за 2,99:
select title as film_title, count(actor_id) as qty_actors from film f 
join film_actor fa on f.film_id = fa.film_id 
where rental_rate = '2.99'
group by film_title
order by qty_actors desc;
