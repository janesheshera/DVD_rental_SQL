--1. ������� ���������� �������� ������� �� ������� �������
select distinct city from city c;

--2. ������� ������, �������� ������� ���������� �� 'L' � ������������� �� 'a' � �� �������� ��������
select distinct city from city c 
where city like 'L%a' and city not like '% %';

--3. �������� �� ������� �������� �� ������ ������� ���������� �� ��������, ������� ����������� � ���������� � 17 ����� 2007 ���� �� 19 ����� 2007 ���� ������������, � ����� ��������� ������� ��������� 1.00. ������� ����� ������������� �� ����
select * from payment p
where payment_date::date between '2007-03-17' and '2007-03-19' and amount > 1.00
order by 6 asc;

--4. ������� ���������� � 10-�� ��������� �������� �� ������ �������
select * from payment p 
order by payment_date desc 
limit 10;

--5. ������� ��������� ���������� �� �����������:
-- ������� � ��� (� ����� ������� ����� ������)
-- ����������� �����
-- ����� �������� ���� email
-- ���� ���������� ���������� ������ � ���������� (��� �������)
-- ������ ������� ������� ������������ �� ������� �����
select first_name||' '||last_name as ���, email as �����, last_update::date as ����������, length(email) as �����_����� from customer c;

--6. ������� ����� �������� ������ �������� �����������, ����� ������� Kelly ��� Willie. ��� ����� � ������� � ����� ��������� � ������� �������
select upper(first_name), upper(last_name), active from customer c 
where first_name like 'Kelly' or first_name like 'Willie' and active=1;

--7. ������� ����� �������� ���������� � �������, � ������� ������� 'R' � ��������� ������ ������� �� 0.00 �� 3.00 ������������, � ����� ������ c ��������� 'PG-13' � ���������� ������ ������ ��� ������ 4.00
select * from film
where (rating ='R' and rental_rate between 0 and 3) or (rating = 'PG-13' and rental_rate >= 4);

--8. �������� ���������� � ��� ������� � ����� ������� ���������
select *, length(description) as len from film
order by len desc limit 3;

--9. ������� Email ������� ����������, �������� �������� Email �� 2 ��������� �������:
-- � ������ ������� ������ ���� ��������, ��������� �� @,
-- �� ������ ������� ������ ���� ��������, ��������� ����� @.
select split_part(email,'@',1) as left_part, split_part(email,'@',2) as right_part, email
from customer c;

--10. C�������������� �������� � ����� ��������: ������ ����� ������ ���� ���������, ��������� ���������
select upper(left(split_part(email,'@',1),1)) ||''|| lower(right(split_part(email,'@',1),-1)) as left_part,
upper(left(split_part(email,'@',2),1)) ||''|| lower(right(split_part(email,'@',2),-1)) as right_part
from customer c;










