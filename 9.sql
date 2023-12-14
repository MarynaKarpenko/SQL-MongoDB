use shop_2;

-- 1. Выведите имена покупателей, которые сделали заказ. 
-- Предусмотрите в выборке также имена продавцов.
-- Примечание: покупатели и продавцы должны быть из разных городов.
-- В выборке должно присутствовать два атрибута — cname, sname.

select
	t1.cname,
	t3.sname
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
inner join sellers t3
on t2.sell_id = t3.sell_id
where t1.city <> t3.city;


-- 2. Выведите имена продавцов, которые обслуживали покупателей с максимальным рейтингом.
-- Вывести: sname.
select
	t3.sname
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
inner join sellers t3
on t2.sell_id = t3.sell_id
where t1.rating = (select max(rating) from customers);

select distinct
    t3.sname
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
inner join sellers t3
on t2.sell_id = t3.sell_id
where t1.rating = (
 select
  max(t1.rating)
 from customers t1
 inner join orders t2
 on t1.cust_id = t2.cust_id
);


-- 3. Выведите города, хотя бы один покупатель из которых сделал покупку на более чем 80% от максимальной стоимости.
-- Вывести : city.
select 
	t1.city
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
where t2.amt > (select max(amt) * 0.8 from orders);


-- 4. Для каждого сотрудника выведите разницу между коммисионными его босса и его собственными. 
-- Если у сотрудника босса нет, выведите NULL.
-- Вывести : sname, difference.

select
	t1.sname,
    (t2.comm - t1.comm) as difference
from sellers t1
left join sellers t2
on t1.boss_id = t2.sell_id;


-- 5. Вывести имена продавцов, у которых коммиссионные выше, чем у их боссов. 
-- Вывести: sname
select distinct
	t1.sname
from sellers t1
left join sellers t2
on t1.boss_id = t2.sell_id
WHERE t1.comm > t2.comm;

-- 6. Вывести имена покупателей, которые совершили только одну покупку.
-- Вывести: cname, orders_cnt
select distinct
	t1.cname,
    COUNT(*) as orders_cnt
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
group by t1.cname
having orders_cnt = 1;
