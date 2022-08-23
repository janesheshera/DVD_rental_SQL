-- Вывести неактивных покупателей:
select * from customer where active = 0;

-- Вывести фильмы 2006 года:
select * from film where release_year = 2006;

--Вывести 10 последних платежей:
select * from payment order by payment_date desc limit 10;
