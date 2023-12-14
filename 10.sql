-- РАБОТА С ДАТОЙ И ВРЕМЕНЕМ

-- Типы данных
-- date - дата в формате 'YYYY-MM-DD'
-- time - время в формате 'hh:mm:ss'
-- datetime - дата и время в формате 'YYYY-MM-DD hh:mm:ss'
-- year - год в формате YYYY

-- Функции для работы с датой и временем 

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

- dayname() - возвращает название дня недели

select dayname('2023-12-05'); -- Tuesday
select dayname(now()); -- Tuesday


-- month() - возвращает порядковый номер месяца 1-12

select month('2023-12-05'); -- 12

-- monthname() - возвращает название месяца

select monthname('2023-12-05'); -- December
-- https://www.w3schools.com/sql/func_mysql_curdate.asp


-- 1. Найти покупки, которые были сделаны в марте
-- Вывести: order_id, odate
select 
	order_id,
    odate
from orders
where month(odate) =3;

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

-- 3. Найти кол-во покупок в июне
-- Вывести orders_cnt
select
 count(*) as orders_cnt
from orders
where month(odate) = 6;


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