-- Спроектируйте базу данных для следующих сущностей:
-- 1. язык (английский, французский и т.д.)

create table language (
language_id serial PRIMARY KEY,
name varchar(20) not null unique
);

insert into language (name)
values
('Английcкий язык'),
('Французский язык'),
('Немецкий язык'),
('Шведский язык'),
('Китайский язык');

-- 2. народность (славяне, англосаксы и т.д.)
create table nation (
nation_id serial PRIMARY KEY,
name varchar(20) not null unique
);

insert into nation (name)
values
('Англосаксы'),
('Франки'),
('Саксы'),
('Шведы'),
('Финны'),
('Ханьцы'),
('Уйгуры');

-- 3. страны (Россия, Германия и т.д.)
create table country (
country_id serial PRIMARY KEY,
name varchar(20) not null unique
);

insert into country (name)
values
('Великобритания'),
('Франция'),
('Германия'),
('Швеция'),
('Китай');

create table country_nation (
country_id int references country(country_id),
nation_id int references nation(nation_id)
);

insert into country_nation (country_id, nation_id)
values
('1','1'),
('2','2'),
('3','3'),
('4','4'),
('4','5'),
('5','6'),
('5','7');

create table nation_language (
nation_id int references nation(nation_id),
language_id int references language(language_id)
);

insert into nation_language (nation_id, language_id)
values
('1','1'),
('2','2'),
('3','3'),
('3','1'),
('4','4'),
('5','4'),
('6','5'),
('7','5');
