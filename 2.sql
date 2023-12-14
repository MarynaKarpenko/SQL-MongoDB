-- JOINs

use hr;

-- ПРАКТИКА (БД hr)

-- 1. Вывести имя, фамилию сотрудника и название департамента, в котором он работает 

-- Какие поля нужно вывести
-- В каких таблицах есть нужные поля
-- Как эти таблицы могут быть объединены (по какому полю)
select 
	t1.first_name,
    t1.last_name,
    t2.department_name
from employees t1
inner join departments t2
on t1.department_id = t2.department_id;

-- 2. Вывести имя, фамилию сотрудника и название его должности
select 
	t1.first_name,
    t1.last_name,
    t2.job_title
from employees t1
inner join jobs t2
on t1.job_id = t2.job_id;



-- ПРАКТИКА 

-- 1. Выведите пассажиров, которые хоть раз летали на самолете, зарегистрированном в России.
-- Вывести : id (клиента), name (клиента)

select distinct
	t1.id,
    t1.name
from clients t1
inner join tickets t2
on t1.id = t2.client_id
inner join trips t3
on t2.trip_id = t3.id
inner join airliners t4
where t4.country = 'Russia';

-- 2. Определите имена пассажиров и цену билета, класс обслуживания который эконом-премиум.
-- Примечание: цена билета не должна превышать средние значение среди всех купленных билетов.
-- В выборке должно присутствовать два атрибута — name, price.
select distinct
	t1.id,
    t1.name
from clients t1
inner join tickets t2
on t1.id = t2.client_id
inner join trips t3
on t2.trip_id = t3.id
inner join airliners t4
where t4.country = 'Russia';

-- 2. Определите имена пассажиров и цену билета, класс обслуживания который эконом-премиум.
-- Примечание: цена билета не должна превышать средние значение среди всех купленных билетов.
-- В выборке должно присутствовать два атрибута — name, price.

select
 t1.name,
    t2.price
from clients t1
inner join tickets t2
on t1.id = t2.client_id
where t2.service_class = 'PremiumEconomy'
and t2.price < (select avg(price) from tickets);

use shop;
-- 1. Выведите пары покупателей и обслуживших их продавцов из одного города.
-- Вывести: sname, cname, city

select
	t3.name,
    t1.name,
    t1.city
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
inner join sellers t3
on t2.sell_id = t3.sell_id
where t1.city = t3.city;

-- 2. Выведите города, хотя бы один покупатель из которых сделал покупку на более чем 80% от максимальной стоимости.
-- Вывести : city.

select
 t1.city
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
where t2.amt > (select max(amt) * 0.8 from orders);


-- 80% от максимальной суммы
select max(amt) * 0.8 from orders;

-- (select max(amt) from orders) * 0.8;

-- *1. Найти название департамента, в котором работает больше всего сотрудников
-- table hr

SELECT
 department_id
FROM (
 SELECT
  count(*) as empl_cnt,
  department_id
 FROM employees
 GROUP BY department_id
) t1
WHERE empl_cnt = (
 SELECT
  max(empl_cnt)
 FROM (
  SELECT
   count(*) as empl_cnt,
   department_id
  FROM employees
  GROUP BY department_id
  )t1
);


-- Task 1 
-- Посчитайте количество билетов для всех указанных в таблице классов перелета
select
	count(*)
	service_class
from tickets
group by service_class;

-- Выведти класс перелта, у которого наибольшее количество билетов в таблице tickets
with tmp as(
	select
	count(*) count_tck,
	service_class
from tickets
group by service_class
)
select
	service_class
from tmp
where count_tck = (select max(count_tck) from tmp);

-- Выведите моедли самолетов, у которых общая допустимая дистанция будет больше чем среднее значение дистацнии всех саомлетов в таблице airlines
select
	model_name
from airliners
where rangee > (select avg (rangee) from airliners);

-- ПРАКТИКА (БД airport)

use airport;


-- 1. Выведите среднюю цену билета для каждого класса обслуживания. 
-- Исключите из рассмотрения билеты, для которых класс обслуживания неизвестен (NULL). 
-- Исключите из выборки билеты рейсов FYHVSSGY и FYMKPDZC. 
-- Отсортируйте выборку по возрастанию средней цены.
-- В выборке должно присутствовать два атрибута — service_class, avg_price.

select
 service_class,
    avg(price) as avg_price
from tickets
where service_class is not null
and trip_id not in ('FYHVSSGY', 'FYMKPDZC')
group by service_class
order by avg_price;


-- 2. Разделите самолеты на ближне-, средне- и дальнемагистральные. 
-- Ближнемагистральными будем считать самолеты, дальность полета которых > 1000 км и <= 2500 км. 
-- Среднемагистральными — с дальностью полета > 2500 км и <= 6000 км. 
-- Дальнемагистральными — с дальностью полета > 6000 км. 
-- Для каждой категории определите средний год выпуска самолетов.
-- Исключите из выборки самолеты, у которых максимальная дальность полета <= 1000 км или данных о дальности полета нет.
-- В столбце с категорией самолета укажите значения short-haul, medium-haul, long-haul для ближне-, средне- и дальнемагистральных самолетов соответственно. 
-- В выборке должны присутствовать три атрибута — category, avg_year.

select
 case
  when rangee > 1000 and range_ <= 2500 then 'short-haul'
        when rangee > 2500 and range_ <= 6000 then 'medium-haul'
        when rangee > 6000 then 'long-haul'
    end as category,
    avg(production_year) as avg_year
from airliners
where rangee is not null
and rangee > 1000
group by category;

-- 3. Для каждого пассажира найдите билеты, стоимость которых составляет более 60% от максимальной стоимости билета, купленного данным пассажиром. 
-- Отсортируйте выборку по идентификатору клиента.
-- В выборке должно присутствовать два атрибута — client_id, id.
select
 client_id,
    id
from tickets
where price > 0.6 * (select max(price) from tickets)
order by client_id;

-- 4. Выведите разность средней стоимости билетов на рейс с идентификатором 8RF8OIOVFR и средней стоимости всех билетов.
-- В выборке должен присутствовать один атрибут — diff.

select
 avg(price) - (select avg(price) from tickets) as diff
from tickets
where trip_id = '8RF8OIOVFR';

select
	(select
		avg(price)
	from tickets
    where trip_id = '8RF8OIOVFR')
    -
    (select
		avg(price)
from tickets)
as diff;

-- 5. Найдите пассажира, имя которого Denis, а фамилия начинается на S. 
-- Кроме того известно, что номер его телефона имеет вид +7XXX0700202. 
-- Три цифры начиная со второй неизвестны и заменены на X. В базе имя клиента хранится в формате 'Имя Фамилия'.
-- В выборке должны присутствовать два атрибута — id и name.
select 
    id,
    name
from clients
where name like 'Denis S%' 
and phone like '+7___0700202';

-- 6. Руководство авиакомпании снизило цены на билеты рейсов OZAO28DLFP, 5QMWLJ4SOC и 8RF8OIOVFR. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет первого класса (FirstClass) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%.
-- Найдите затраты авиакомпании на акцию, то есть разность стоимости всех билетов и стоимости всех билетов с учетом скидки.
-- В выборке должен присутствовать один атрибут — expenses.

select
 sum(
  case
   when service_class = 'Economy' then price * 0.15
   when service_class = 'FirstClass' then price * 0.1
   when service_class = 'PremiumEconomy' then price * 0.2
  end
    ) as expenses
from tickets
where trip_id in ('OZAO28DLFP', '5QMWLJ4SOC', '8RF8OIOVFR');


-- * 5. Найти департаменты в которых ВСЕ работники зарабатывают больше 10 000. 
-- В результате выборки формируются два поля (department_id и поле со значениями 1 или 0)
-- 1 - если в департаменте ВСЕ сотрудники имеют зп больше 10000, 0 - если не все
use hr;
select 
	department_id,
    min(case
		when salary > 10000 then 1
        else 0
	end
    ) as salary_index
from employees
group by department_id;

use shop;
-- 1. Выведите имена покупателей, которые сделали более одной покупки.
-- В выборке должно присутствовать два атрибута — cname, cnt (количество покупок)

SELECT
    t1.first_name,
    CASE
        WHEN COUNT(t2.CUST_ID) > 0 THEN COUNT(t2.CUST_ID)
    END AS cnt
FROM customers t1
INNER JOIN orders t2 
ON t1.CUST_ID = t2.CUST_ID
GROUP BY t1.cname, t2.CUST_ID;




CREATE DATABASE shop_2;

USE shop_2;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
             BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);


-- ПРАКТИКА (БД shop)

-- 1. Выведите список имен покупателей, которые совершили покупку. Предусмотрите в выборке номер заказа.
-- В выборке должно присутствовать два атрибута — cname, order_id.

select
 t1.cname,
    t2.order_id
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id;

-- 2. Выведите список имен покупателей, продавцов и итоговую сумму заказа.
-- В выборке должны присутствовать три атрибута — cname, sname, amt.
select
 t1.cname,
    t3.sname,
    t2.amt
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
inner join sellers t3
on t2.sell_id = t3.sell_id;


-- 3. Выведите имена всех продавцов. 
-- Предусмотрите также в выборке имена их боссов, сформировав атрибут boss_name.
-- Если у сотрудника нет босса, то в boss_name должно быть null.
-- В выборке должно присутствовать два атрибута — sname, boss_name.


select
 t1.sname,
    t2.sname as boss_name
from sellers t1
left join sellers t2
on t1.boss_id = t2.sell_id;

-- 2. Вывести сотрудников (имя и фамилию, зп), которые зарабатывают больше своего менеджера 
-- Вывести три поля - имя и фамилию, зп сотрудника

select
 t1.first_name,
    t1.last_name,
    t1.salary
from employees t1
left join employees t2
on t1.manager_id = t2.employee_id
where t1.salary > t2.salary;

-- 4. Выведите имена покупателей, которые совершили покупку, чья итоговая сумма превышает среднее значение цен в таблице.
-- В выборке должно присутствовать два атрибута — cname, amt.
select cname,
	amt
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
where t2.amt > (select avg(amt) from orders);

-- 5. Выведите имена покупателей, которые сделали более одной покупки.
-- В выборке должно присутствовать два атрибута — cname, cnt (количество покупок)

select 
 t1.cname,
    count(t2.CUST_ID) as cnt
from customers t1
inner join orders t2
on t1.CUST_ID = t2.CUST_ID
group by t1.cname
having cnt > 1;


select
 t1.cname,
    t2.cnt
from customers t1
inner join (
 select
  cust_id,
        count(*) as cnt
 from orders
    group by cust_id
) t2
on t1.cust_id = t2.cust_id
where t2.cnt > 1;