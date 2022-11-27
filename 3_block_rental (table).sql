--������� �1
--������������� ���� ������, ���������� ��� �����������:
--� ���� (����������, ����������� � �. �.);
--� ���������� (�������, ���������� � �. �.);
--� ������ (������, �������� � �. �.).
--���������� � ��������-������������:
--� ������� ����������� ��������� ������.
--� �������������� �������� ������ ������������� ���������������;
--� ������������ ��������� �� ������ ��������� null-��������, �� ������ ����������� ��������� � ��������� ���������.

--�������� ������� �����
create table language_pop (
language_id serial primary key,
language_name varchar(20) not null unique
);

insert into language_pop (language_name)
select unnest(array['������c��� ����','����������� ����','�������� ����','�������� ����','��������� ����']);

--�������� ������� ����������
create table nation_pop (
nation_id serial primary key,
nation_name varchar(20) not null unique
);

insert into nation_pop (nation_name)
select unnest(array['����������','������','�����','�����','�����','������','������'])

--�������� ������� ������
create table country_pop (
country_id serial primary key,
country_name varchar(20) not null unique
);

insert into country_pop (country_name)
select unnest(array['��������������','�������','��������','������','�����']);

--������������� ��� ������� �� �������: ����-���������� � ����������-������, ��������� ������ �� ������.
--���������� � �������� �� �������: ������� ����������� ��������� � ������� ������.

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

--�������������� �����
--������� �1 
--�������� ����� ������� film_new �� ���������� ������:
--� film_name - �������� ������ - ��� ������ varchar(255) � ����������� not null
--� film_year - ��� ������� ������ - ��� ������ integer, �������, ��� �������� ������ ���� ������ 0
--� film_rental_rate - ��������� ������ ������ - ��� ������ numeric(4,2), �������� �� ��������� 0.99
--� film_duration - ������������ ������ � ������� - ��� ������ integer, ����������� not null � �������, ��� �������� ������ ���� ������ 0

create table film_new (
film_name varchar(255) not null,
film_year integer check (film_year > 0),
film_rental_rate numeric(4,2) default '0.99',
film_duration integer not null check(film_duration > 0)
);

--������� �2 
--��������� ������� film_new ������� � ������� SQL-�������, ��� �������� ������������� ������� ������:
--� film_name - array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']
--� film_year - array[1994, 1999, 1985, 1994, 1993]
--� film_rental_rate - array[2.99, 0.99, 1.99, 2.99, 3.99]
--� film_duration - array[142, 189, 116, 142, 195]
insert into film_new(film_name, film_year, film_rental_rate, film_duration)
select unnest(array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']),
unnest(array[1994, 1999, 1985, 1994, 1993]),
unnest(array[2.99, 0.99, 1.99, 2.99, 3.99]),
unnest(array[142, 189, 116, 142, 195]);

--������� �3
--�������� ��������� ������ ������� � ������� film_new � ������ ����������, ��� ��������� ������ ���� ������� ��������� �� 1.41
update film_new
set film_rental_rate = film_rental_rate+1.41;

--������� �4
--����� � ��������� "Back to the Future" ��� ���� � ������, ������� ������ � ���� ������� �� ������� film_new

delete from film_new
where film_name = 'Back to the Future';

--������� �5
--�������� � ������� film_new ������ � ����� ������ ����� ������
insert into film_new (film_name, film_year, film_rental_rate, film_duration)
values ('The Green Knight', 2021, 6.1, 130);

--������� �6
--�������� SQL-������, ������� ������� ��� ������� �� ������� film_new, � ����� ����� ����������� ������� "������������ ������ � �����", ���������� �� �������
select *, round(film_duration/60.0,1) as hour_duration from film_new;

--������� �7 
--������� ������� film_new
drop table film_new;