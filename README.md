<h3> Проектная работа по модулю "SQL и получение данных" (учебный курс Нетологии) </h3>
В работе использовалась демонстрационная база данных, содержащая информацию по магазину проката DVD-дисков :cd:<br>
<br>
<img src="https://user-images.githubusercontent.com/63310859/185807045-309e0a92-544b-4507-8318-dd31c930f0ca.jpg" height="200"/>
Подключение к БД осуществлялось через облако, где развернута база данных. Поставленные задачи решались посредством системы управления базами данных PostgreSQL. Используемое программное приложение DBeaver.<br>
<br>
Для наглядности ER-диаграмма представлена ниже:<br>
<br>
<img src="https://user-images.githubusercontent.com/63310859/185806836-3ff2bcb9-1354-4e48-8348-e53cc89b6faa.jpg" height="500"/>
<br>
В проектной работе осуществленные запросы разбиты на блоки (ссылки на файлы .sql).<br>
<h5>В БЛОКЕ 1 используются следующие операторы:<br>
- select - выборки из БД по названиям столбцов<br>
- оператор as - перименование столбцов<br>
- distinct - выбор уникальных значений<br>
- фильтрация числовых, текстовых значений и дат - операторы where, limit, like/not like, between и др.<br>
- order by - сортировка <br>
- преобразование текстовых значений - операторы upper, lower, split_part, left, right <br></h5>
<details>
<summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/1_block_rental.sql"> Блок :one:</a></summary>
1. Вывести уникальные названия городов из таблицы городов.<br>
2. Вывести города, названия которых начинаются на 'L' и заканчиваются на 'a' и не содержат пробелов.<br>
3. Получить из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 17 марта 2007 года по 19 марта 2007 года включительно, а также стоимость которых превышает 1.00. Платежи нужно отсортировать по дате.<br>
4. Вывести информацию о 10-ти последних платежах за прокат фильмов.<br>
5. Вывести следующую информацию по покупателям:<br>
  - Фамилия и имя (в одной колонке через пробел)<br>
  - Электронная почта<br>
  - Длину значения поля email<br>
  - Дату последнего обновления записи о покупателе (без времени)<br>
  - Каждой колонке задайте наименование на русском языке <br>
6. Вывести одним запросом только активных покупателей, имена которых Kelly или Willie. Все буквы в фамилии и имени перевести в верхний регистр. <br>
7. Вывести одним запросом информацию о фильмах, у которых рейтинг 'R' и стоимость аренды указана от 0.00 до 3.00 включительно, а также фильмы c рейтингом 'PG-13' и стоимостью аренды больше или равной 4.00.<br>
8. Получить информацию о трёх фильмах с самым длинным описанием.<br>
9. Вывести Email каждого покупателя, разделив значение Email на 2 отдельных колонки: <br>
  - в первой колонке должно быть значение, указанное до @, <br>
  - во второй колонке должно быть значение, указанное после @. <br>
10. Cкорректировать значения в новых колонках: первая буква должна быть заглавной, остальные строчными.<br>
</details>
<h5>В БЛОКЕ 2 используются следующие операторы:<br>
- join (с using) - соединение таблиц <br>
- агрегирующие функции - count, sum, max, min, avg <br>
- фильтрация для агрегирующих функций - оператор having <br>
- применено декартово произведение <br>
- создан столбец с помощью условного выражения case</h5>
<details>
<summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/2_block_rental.sql"> Блок :two:</a></summary>
1. Вывести для каждого покупателя его адрес, город и страну проживания. <br>
2. Посчитать для каждого магазина количество покупателей. Доработать запрос и вывести только те магазины, у которых количество покупателей больше 300. Добавить в запрос информацию о городе магазина, фамилии и имени продавца, который работает в нём. <br>
3. Вывести топ 5 покупателей, которые взяли в аренду за всё время наибольшее количество фильмов. <br>
4. Посчитать для каждого покупателя 4 аналитических показателя: <br>
- количество взятых в аренду фильмов <br>
- общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа) <br>
- минимальное значение платежа за аренду фильма <br>
- максимальное значение платежа за аренду фильма <br>
5. Используя данные из таблицы городов, составить одним запросом все возможные пары городов так, чтобы в результате не было пар с одинаковыми названиями городов (использовано декартово произведение). <br>
6. Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date) и дате возврата (поле return_date), вычислить для каждого покупателя среднее количество дней, за которые он возвращает фильмы. <br>
7. Посчитать для каждого фильма, сколько раз его брали в аренду, а также общую стоимость аренды фильма за всё время. <br>
8. Доработать запрос из предыдущего задания и вывести с помощью него фильмы, которые ни разу не брали в аренду. <br>
9. Посчитать количество продаж, выполненных каждым продавцом. Добавить вычисляемую колонку «Премия». Если количество продаж превышает 7 300, то значение в колонке будет «Да», иначе должно быть значение «Нет». <br>
</details>
<details>
  <summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/2_rental.sql"> Блок :two: </a></summary>
Спроектируйте базу данных для следующих сущностей: <br>
- язык (английский, французский и т.д.) <br>
- народность (славяне, англосаксы и т.д.) <br>
- страны (Россия, Германия и т.д.) <br>
5 таблиц: 3 таблицы-справочника и 2 таблицы со связями.<br>
</details>
<details>
  <summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/3_rental.sql"> Блок :three: </a></summary>
1. Сделайте запрос к таблице rental. Используя оконную функцию, добавьте колонку с порядковым номером аренды для каждого пользователя (сортировать по rental_date) <br>
2. Для каждого пользователя подсчитайте сколько он брал в аренду фильмов со специальным атрибутом Behind the Scenes：<br>
- напишите запрос <br>
- создайте материализованное представление с этим запросом <br>
- обновите материализованное представление <br>
</details>

<h6>*все ссылки открываются в текущем окне</h6>
