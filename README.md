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
В проектной работе осуществлены следующие запросы (ссылки на файлы .sql):<br>
<br>
<details>
  <summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/1_rental.sql"> Блок :one:</a></summary>
- Вывести всех неактивных покупателей <br>
- Вывести фильмы 2006 года <br>
- Вывести 10 последних платежей за прокат фильмов <br>
- Вывести магазины, имеющие больше 300-от покупателей <br>
- Вывести у каждого покупателя город, в котором он живет <br>
- Вывести ФИО сотрудников и города магазинов, имеющих больше 300-от покупателей <br>
- Вывести количество актеров, снимавшихся в фильмах, которые сдаются в аренду за 2,99 <br>
</details>
<details>
  <summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/2_rental.sql"> Блок :two: </a></summary>
Спроектируйте базу данных для следующих сущностей: <br>
- язык (английский, французский и т.д.) <br>
- народность (славяне, англосаксы и т.д.) <br>
- страны (Россия, Германия и т.д.) <br>
Должно получиться 5 таблиц. Три таблицы-справочника и две таблицы со связями.<br>
</details>
<details>
  <summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/3_rental.sql"> Блок :three: </a></summary>
1. Сделайте запрос к таблице rental. Используя оконую функцию, добавьте колонку с порядковым номером аренды для каждого пользователя (сортировать по rental_date) <br>
2. Для каждого пользователя подсчитайте сколько он брал в аренду фильмов со специальным атрибутом Behind the Scenes：<br>
- напишите этот запрос <br>
- создайте материализованное представление с этим запросом <br>
- обновите материализованное представление <br>
</details>
<details>
  <summary><a href="https://github.com/janesheshera/DVD_rental_SQL/blob/main/4_rental.sql"> Блок :four: </a></summary>
Спроектируйте базу данных для следующих сущностей: <br>
- язык (английский, французский и т.д.) <br>
- народность (славяне, англосаксы и т.д.) <br>
- страны (Россия, Германия и т.д.) <br>
Должно получиться 5 таблиц. Три таблицы-справочника и две таблицы со связями.<br>
</details>

<h6>*все ссылки открываются в текущем окне</h6>
