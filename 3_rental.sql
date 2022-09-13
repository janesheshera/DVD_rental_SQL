-- 1. �������� ������ � ������� rental. ��������� ������� �������, �������� ������� � ���������� ������� ������ ��� ������� ������������ (����������� �� rental_date)
select customer_id, rental_date, row_number() over(partition by customer_id order by rental_date asc) as rental_number 
from rental r;

-- 2.��� ������� ������������ ����������� ������� �� ���� � ������ ������� �� ����������� ��������� Behind the Scenes
select r.customer_id, count (rental_id) as qty_rental from rental r
join inventory i using (inventory_id)
join film f using (film_id)
where special_features @> array ['Behind the Scenes']
group by customer_id
order by customer_id;

-- �������� ����������������� ������������� � ���� ��������
create materialized view rental_BTS as
select r.customer_id, count (rental_id) as qty_rental from rental r
join inventory i using (inventory_id)
join film f using (film_id)
where special_features @> array ['Behind the Scenes']
group by customer_id
order by customer_id;

select * from rental_BTS;
-- �������� ����������������� �������������
refresh materialized view rental_BTS