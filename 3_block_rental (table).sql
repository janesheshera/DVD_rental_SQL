--ЗАДАНИЕ №1
--Спроектируйте базу данных, содержащую три справочника:
--· язык (английский, французский и т. п.);
--· народность (славяне, англосаксы и т. п.);
--· страны (Россия, Германия и т. п.).
--Требования к таблицам-справочникам:
--· наличие ограничений первичных ключей.
--· идентификатору сущности должен присваиваться автоинкрементом;
--· наименования сущностей не должны содержать null-значения, не должны допускаться дубликаты в названиях сущностей.

--СОЗДАНИЕ ТАБЛИЦЫ ЯЗЫКИ
create table language_pop (
language_id serial primary key,
language_name varchar(20) not null unique
);

insert into language_pop (language_name)
select unnest(array['Английcкий язык','Французский язык','Немецкий язык','Шведский язык','Китайский язык']);

--СОЗДАНИЕ ТАБЛИЦЫ НАРОДНОСТИ
create table nation_pop (
nation_id serial primary key,
nation_name varchar(20) not null unique
);

insert into nation_pop (nation_name)
select unnest(array['Англосаксы','Франки','Саксы','Шведы','Финны','Ханьцы','Уйгуры'])

--СОЗДАНИЕ ТАБЛИЦЫ СТРАНЫ
create table country_pop (
country_id serial primary key,
country_name varchar(20) not null unique
);

insert into country_pop (country_name)
select unnest(array['Великобритания','Франция','Германия','Швеция','Китай']);

--Спроектируйте две таблицы со связями: язык-народность и народность-страна, отношения многие ко многим.
--Требования к таблицам со связями: наличие ограничений первичных и внешних ключей.

create table country_nation_pop (
country_id integer references country(country_id),
nation_id integer references nation(nation_id)
);

insert into country_nation_pop (country_id, nation_id)
values
('1','1'),
('2','2'),
('3','3'),
('4','4'),
('4','5'),
('5','6'),
('5','7');

create table nation_language_pop (
nation_id integer references nation(nation_id),
language_id integer references language(language_id)
);

insert into nation_language_pop (nation_id, language_id)
values
('1','1'),
('2','2'),
('3','3'),
('3','1'),
('4','4'),
('5','4'),
('6','5'),
('7','5');

--ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ
--ЗАДАНИЕ №1 
--Создайте новую таблицу film_new со следующими полями:
--· film_name - название фильма - тип данных varchar(255) и ограничение not null
--· film_year - год выпуска фильма - тип данных integer, условие, что значение должно быть больше 0
--· film_rental_rate - стоимость аренды фильма - тип данных numeric(4,2), значение по умолчанию 0.99
--· film_duration - длительность фильма в минутах - тип данных integer, ограничение not null и условие, что значение должно быть больше 0

create table film_new (
film_name varchar(255) not null,
film_year integer check (film_year > 0),
film_rental_rate numeric(4,2) default '0.99',
film_duration integer not null check(film_duration > 0)
);

--ЗАДАНИЕ №2 
--Заполните таблицу film_new данными с помощью SQL-запроса, где колонкам соответствуют массивы данных:
--· film_name - array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']
--· film_year - array[1994, 1999, 1985, 1994, 1993]
--· film_rental_rate - array[2.99, 0.99, 1.99, 2.99, 3.99]
--· film_duration - array[142, 189, 116, 142, 195]
insert into film_new(film_name, film_year, film_rental_rate, film_duration)
select unnest(array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']),
unnest(array[1994, 1999, 1985, 1994, 1993]),
unnest(array[2.99, 0.99, 1.99, 2.99, 3.99]),
unnest(array[142, 189, 116, 142, 195]);

--ЗАДАНИЕ №3
--Обновите стоимость аренды фильмов в таблице film_new с учетом информации, что стоимость аренды всех фильмов поднялась на 1.41
update film_new
set film_rental_rate = film_rental_rate+1.41;

--ЗАДАНИЕ №4
--Фильм с названием "Back to the Future" был снят с аренды, удалите строку с этим фильмом из таблицы film_new

delete from film_new
where film_name = 'Back to the Future';

--ЗАДАНИЕ №5
--Добавьте в таблицу film_new запись о любом другом новом фильме
insert into film_new (film_name, film_year, film_rental_rate, film_duration)
values ('The Green Knight', 2021, 6.1, 130);

--ЗАДАНИЕ №6
--Напишите SQL-запрос, который выведет все колонки из таблицы film_new, а также новую вычисляемую колонку "длительность фильма в часах", округлённую до десятых
select *, round(film_duration/60.0,1) as hour_duration from film_new;

--ЗАДАНИЕ №7 
--Удалите таблицу film_new
drop table film_new;