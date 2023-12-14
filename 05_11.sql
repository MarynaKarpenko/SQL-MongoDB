-- ПРАКТИКА (БД shop)

use shop;


-- 1. Выведите имена покупателей, которые сделали заказ. 
-- Предусмотрите в выборке также имена продавцов.
-- Примечание: покупатели и продавцы должны быть из разных городов.
-- В выборке должно присутствовать два атрибута — cname, sname.

select distinct
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


select distinct
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

select distinct
	t1.city
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
where t2.amt > 0.8 * (select max(amt) from orders);


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

select
	t1.sname
from sellers t1
left join sellers t2
on t1.boss_id = t2.sell_id
where t1.comm > t2.comm;


select
	t1.sname
from sellers t1
left join sellers t2
on t1.boss_id = t2.sell_id
where (t2.comm - t1.comm) < 0;



-- 6. Вывести имена покупателей, которые совершили только одну покупку.
-- Вывести: cname, orders_cnt


select 
	t1.cname,
    count(*) as orders_cnt
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
group by t1.cname
having orders_cnt = 1;


select
	t1.cname,
    t2.orders_cnt
from customers t1
inner join (
	select
		cust_id,
        count(*) as orders_cnt
	from orders
    group by cust_id
    having orders_cnt = 1
) t2
on t1.cust_id = t2.cust_id;



-- РАБОТА С ДАТОЙ И ВРЕМЕНЕМ

-- Типы данных
-- date - дата в формате 'YYYY-MM-DD'
-- time - время в формате 'hh:mm:ss'
-- datetime - дата и время в формате 'YYYY-MM-DD hh:mm:ss'
-- year - год в формате YYYY


-- Функции для работы с датой и временем (https://www.w3schools.com/sql/func_mysql_curdate.asp)

-- now() - возвращает текущие дату и время

select now() as today;

-- curdate() - возвращает текущую дату

select curdate() as today;

-- curtime() - возвращает текущее время

select curtime() as now;


-- weekday() - возвращает порядковый номер дня недели 
-- 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday

select weekday('2023-12-05'); -- 1


-- dayofweek() - возвращает порядковый номер дня недели 
-- 1 = Sunday, 2 = Monday, 3 = Tuesday, 4 = Wednesday, 5 = Thursday, 6 = Friday, 7 = Saturday

select dayofweek('2023-12-05'); -- 3


-- dayname() - возвращает название дня недели

select dayname('2023-12-05'); -- Tuesday
select dayname(now()); -- Tuesday


-- month() - возвращает порядковый номер месяца 1-12

select month('2023-12-05'); -- 12


-- monthname() - возвращает название месяца

select monthname('2023-12-05'); -- December


-- ПРАКТИКА (БД shop)

-- 1. Найти покупки, которые были сделаны в марте
-- Вывести: order_id, odate

select
	order_id,
    odate
from orders
where month(odate) = 3;

select
	order_id,
    odate
from orders
where monthname(odate) = 'March';


-- 2. Найти покупки, которые были совершены в промежуток между 30/04/2022 и 14/06/2022 (вкл)
-- Вывести: order_id, odate

select
	order_id,
    odate
from orders
where date(odate) between '2022-04-30' and '2022-06-14';


select
	order_id,
    odate
from orders
where odate between '2022-04-30' and '2022-06-14';


-- 3. Найти кол-во покупок в июне
-- Вывести orders_cnt

select
	count(*) as orders_cnt
from orders
where month(odate) = 6;


select
	count(*) as orders_cnt
from orders
where monthname(odate) = 'June';


-- 4. Выведите минимальный рейтинг покупателя среди сделавших заказ в марте 2022 года.
-- Вывести : min_rating

select
	min(t1.rating) as min_rating
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
where month(odate) = 3 and year(odate) = 2022;


-- 5. Вывести продавцов, оформивших заказ на наибольшую сумму в период с марта 2022 по май 2022
-- Вывести: sell_id, odate, amt

select
	sell_id,
    odate,
    amt
from orders
where amt = (
	select
		max(amt)
	from orders
    where date(odate) between '2022-03-01' and '2022-05-31'
);


-- 6. Вывести продавцов, оформивших заказ на наибольшую сумму в период с марта 2022 по май 2022
-- Вывести: sname, odate, amt


select
	t2.sname,
    t1.odate,
    t1.amt
from orders t1
inner join sellers t2
on t1.sell_id = t2.sell_id
where t1.amt = (
	select
		max(amt)
	from orders
    where date(odate) between '2022-03-01' and '2022-05-31'
);

-- ДЗ (ОБЯЗАТЕЛЬНО!!!)
-- Подготовиться к работе с mongoDB по видеоинструкции: https://drive.google.com/file/d/1Wx7YUvnp3a8wFp0yPOIfBaCYqxLXwC_q/view?usp=sharing







