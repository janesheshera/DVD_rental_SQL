
-- ������� ���������� �����������:
select * from customer where active = 0;

-- ������� ������ 2006 ����:
select * from film where release_year = 2006;

-- ������� 10 ��������� ��������:
select * from payment order by payment_date desc limit 10;