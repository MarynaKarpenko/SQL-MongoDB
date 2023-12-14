-- ПРАКТИКА (БД shop)

use shop;

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


-- 4. Выведите имена покупателей, которые совершили покупку, чья итоговая сумма превышает среднее значение цен в таблице.
-- В выборке должно присутствовать два атрибута — cname, amt.

select
	t1.cname,
    t2.amt
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


-- ПРАКТИКА (БД hr)

use hr;

-- 1. Вывести имя/фамилию сотрудника и имя/фамилию его менеджера 
-- Если у сотрудника нет менеджера, то должно быть null в полях для менеджера.
-- Вывести 4 поля - employee_firstname, employee_lastname, manager_firstname, manager_lastname

select
	t1.first_name as employee_firstname,
    t1.last_name as employee_lastname,
    t2.first_name as manager_firstname,
    t2.last_name as manager_lastname
from employees t1
left join employees t2
on t1.manager_id = t2.employee_id;


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




