--1. Вывести уникальные названия городов из таблицы городов
select distinct city from city c;

--2. Вывести города, названия которых начинаются на 'L' и заканчиваются на 'a' и не содержат пробелов
select distinct city from city c 
where city like 'L%a' and city not like '% %';

--3. Получить из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 17 марта 2007 года по 19 марта 2007 года включительно, а также стоимость которых превышает 1.00. Платежи нужно отсортировать по дате
select * from payment p
where payment_date::date between '2007-03-17' and '2007-03-19' and amount > 1.00
order by 6 asc;

--4. Вывести информацию о 10-ти последних платежах за прокат фильмов
select * from payment p 
order by payment_date desc 
limit 10;

--5. Вывести следующую информацию по покупателям:
-- Фамилия и имя (в одной колонке через пробел)
-- Электронная почта
-- Длину значения поля email
-- Дату последнего обновления записи о покупателе (без времени)
-- Каждой колонке задайте наименование на русском языке
select first_name||' '||last_name as ФИО, email as почта, last_update::date as обновление, length(email) as длина_почты from customer c;

--6. Вывести одним запросом только активных покупателей, имена которых Kelly или Willie. Все буквы в фамилии и имени перевести в верхний регистр
select upper(first_name), upper(last_name), active from customer c 
where first_name like 'Kelly' or first_name like 'Willie' and active=1;

--7. Вывести одним запросом информацию о фильмах, у которых рейтинг 'R' и стоимость аренды указана от 0.00 до 3.00 включительно, а также фильмы c рейтингом 'PG-13' и стоимостью аренды больше или равной 4.00
select * from film
where (rating ='R' and rental_rate between 0 and 3) or (rating = 'PG-13' and rental_rate >= 4);

--8. Получить информацию о трёх фильмах с самым длинным описанием
select *, length(description) as len from film
order by len desc limit 3;

--9. Вывести Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
-- в первой колонке должно быть значение, указанное до @,
-- во второй колонке должно быть значение, указанное после @.
select split_part(email,'@',1) as left_part, split_part(email,'@',2) as right_part, email
from customer c;

--10. Cкорректировать значения в новых колонках: первая буква должна быть заглавной, остальные строчными
select upper(left(split_part(email,'@',1),1)) ||''|| lower(right(split_part(email,'@',1),-1)) as left_part,
upper(left(split_part(email,'@',2),1)) ||''|| lower(right(split_part(email,'@',2),-1)) as right_part
from customer c;
