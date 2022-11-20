--1. ¬ывести уникальные названи€ городов из таблицы городов
select distinct city from city c;

--2. ¬ывести города, названи€ которых начинаютс€ на 'L' и заканчиваютс€ на 'a' и не содержат пробелов
select distinct city from city c 
where city like 'L%a' and city not like '% %';

--3. ѕолучить из таблицы платежей за прокат фильмов информацию по платежам, которые выполн€лись в промежуток с 17 марта 2007 года по 19 марта 2007 года включительно, а также стоимость которых превышает 1.00. ѕлатежи нужно отсортировать по дате
select * from payment p
where payment_date::date between '2007-03-17' and '2007-03-19' and amount > 1.00
order by 6 asc;

--4. ¬ывести информацию о 10-ти последних платежах за прокат фильмов
select * from payment p 
order by payment_date desc 
limit 10;

--5. ¬ывести следующую информацию по покупател€м:
-- ‘амили€ и им€ (в одной колонке через пробел)
-- Ёлектронна€ почта
-- ƒлину значени€ пол€ email
-- ƒату последнего обновлени€ записи о покупателе (без времени)
--  аждой колонке задайте наименование на русском €зыке
select first_name||' '||last_name as ‘»ќ, email as почта, last_update::date as обновление, length(email) as длина_почты from customer c;

--6. ¬ывести одним запросом только активных покупателей, имена которых Kelly или Willie. ¬се буквы в фамилии и имени перевести в верхний регистр
select upper(first_name), upper(last_name), active from customer c 
where first_name like 'Kelly' or first_name like 'Willie' and active=1;

--7. ¬ывести одним запросом информацию о фильмах, у которых рейтинг 'R' и стоимость аренды указана от 0.00 до 3.00 включительно, а также фильмы c рейтингом 'PG-13' и стоимостью аренды больше или равной 4.00
select * from film
where (rating ='R' and rental_rate between 0 and 3) or (rating = 'PG-13' and rental_rate >= 4);

--8. ѕолучить информацию о трЄх фильмах с самым длинным описанием
select *, length(description) as len from film
order by len desc limit 3;

--9. ¬ывести Email каждого покупател€, разделив значение Email на 2 отдельных колонки:
-- в первой колонке должно быть значение, указанное до @,
-- во второй колонке должно быть значение, указанное после @.
select split_part(email,'@',1) as left_part, split_part(email,'@',2) as right_part, email
from customer c;

--10. Cкорректировать значени€ в новых колонках: перва€ буква должна быть заглавной, остальные строчными
select upper(left(split_part(email,'@',1),1)) ||''|| lower(right(split_part(email,'@',1),-1)) as left_part,
upper(left(split_part(email,'@',2),1)) ||''|| lower(right(split_part(email,'@',2),-1)) as right_part
from customer c;










