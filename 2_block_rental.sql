--1. ������� ��� ������� ���������� ��� �����, ����� � ������ ����������
select customer_id, first_name ||' '|| last_name as name, address, city, country from customer c
join address a using (address_id)
join city using (city_id)
join country using (country_id);

--2. ��������� ��� ������� �������� ���������� �����������. ���������� ������ � ������� ������ �� ��������, � ������� ���������� ����������� ������ 300
-- ���������� ������, ������� � ���� ���������� � ������ ��������, ������� � ����� ��������, ������� �������� � ��
select store_id, count(customer_id), city, s2.first_name ||' '|| s2.last_name as staff_name from store s 
join customer c using (store_id)
join address a on s.address_id = a.address_id 
join city using (city_id)
join staff s2 using (store_id)
group by store_id, city, staff_name having count(customer_id) > 300

--3. ������� ��� 5 �����������, ������� ����� � ������ �� �� ����� ���������� ���������� �������
select customer_id, first_name ||' '|| last_name as name, count(rental_id) as count_rental from rental r 
join customer using (customer_id)
group by customer_id, name
order by 3 desc limit 5

--4. ��������� ��� ������� ���������� 4 ������������� ����������:
-- ���������� ������ � ������ �������;
-- ����� ��������� �������� �� ������ ���� ������� (�������� ��������� �� ������ �����);
-- ����������� �������� ������� �� ������ ������;
-- ������������ �������� ������� �� ������ ������.
select r.customer_id, count(rental_id), sum(amount), max(amount), min(amount) from rental r
join payment using (rental_id)
group by r.customer_id

--5. ��������� ������ �� ������� �������, ��������� ����� �������� ��� ��������� ���� ������� ���, ����� � ���������� �� ���� ��� � ����������� ���������� ������� (������������ ��������� ������������)
select c1.city, c2.city from city c1, city c2
where c1.city <> c2.city 

--6. ��������� ������ �� ������� rental � ���� ������ ������ � ������ (���� rental_date) � ���� �������� (���� return_date), ��������� ��� ������� ���������� ������� ���������� ����, �� ������� �� ���������� ������
select customer_id, round(avg(return_date::date-rental_date::date), 2) as "������� ���-�� ���� ��������" from rental
group by customer_id

--7. ��������� ��� ������� ������, ������� ��� ��� ����� � ������, � ����� ����� ��������� ������ ������ �� �� �����
select film_id, title as "�������� ������", count(i.film_id) as "���-�� �����", sum(p.amount) as "����� ��-�� ������" from film f
join inventory i using (film_id)
join rental r using (inventory_id)
join payment p using (rental_id)
group by film_id
order by 4 desc

--8. ���������� ������ �� ����������� ������� � ������� � ������� ���� ������, ������� �� ���� �� ����� � ������
select f.title as "�������� ������", count(i.film_id) as "���-�� �����", sum(p.amount) as "����� ��-�� ������" from film f
left join inventory i using (film_id)
left join rental r using (inventory_id)
left join payment p using (rental_id)
group by 1
having count(i.film_id) = 0

--9. ��������� ���������� ������, ����������� ������ ���������. �������� ����������� ������� ��������. ���� ���������� ������ ��������� 7 300, �� �������� � ������� ����� ���, ����� ������ ���� �������� ����
select staff_id, count(payment_id) as "���������� ������",
case when count(payment_id) > 7300 then '��' else '���' end as "������"
from payment
group by staff_id