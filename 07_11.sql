-- ДЗ (БД airport)


-- 2. Определите клиентов, которые пользуются оператором МТС в Мурманской области (коды оператора 911, 981) и летали первым классом на самолетах, зарегистрированных не в России.
-- В выборке должен присутствовать один атрибут : id.

use airport;

select
	t1.id
from clients t1
inner join tickets t2
on t1.id = t2.client_id
inner join trips t3
on t2.trip_id = t3.id
inner join airliners t4
on t3.airliner_id = t4.id
where (t1.phone like '+7911%' or t1.phone like '+7981%')
and t2.service_class = 'FirstClass'
and t4.country <> 'Russia';

-- *3. Выведите возрастную категорию пассажиров, купивших билет в бизнес- или первый класс. 
-- Возрастные категории следующие : < 18 - Ребенок; 18-50 - Взрослый; > 50 Пожилой.
-- В выборке должны присутствовать два атрибута: id, age_category

select
	id,
    case
		when age < 18 then 'Ребенок'
        when age between 18 and 50 then 'Взрослый'
        else 'Пожилой'
    end as age_category
from clients
where id in (
	select
		client_id
	from tickets
	where service_class in ('Business', 'FirstClass')
);


select
	t1.id,
    case
		when t1.age < 18 then 'Ребенок'
        when t1.age between 18 and 50 then 'Взрослый'
        else 'Пожилой'
    end as age_category
from clients t1
inner join tickets t2
on t1.id = t2.client_id
where t2.service_class in ('Business', 'FirstClass');


-- *4. Вывести максимальную цену на билет среди рейсов на самолеты с максимальной дальностью полета.
-- Вывести : max_price

select
	max(t1.price) as max_price
from tickets t1
inner join trips t2
on t1.trip_id = t2.id
inner join airliners t3
on t2.airliner_id = t3.id
where t3.range_ = (select max(range_) from airliners);


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

select
	t1.name,
    t2.price
from clients t1
inner join tickets t2
on t1.id = t2.client_id
where t2.service_class = 'PremiumEconomy'
and t2.price < (select avg(price) from tickets);



-- ПРАКТИКА 2 (БД shop)

use shop;

-- 1. Выведите пары покупателей и обслуживших их продавцов из одного города.
-- Вывести: sname, cname, city

select
	t3.sname,
    t1.cname,
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



-- Группировка (GROUP BY)

-- 1. Вывести максимальный возраст среди покупателей по каждой из стран

select
	country,
	max(age)
from customers
group by country;


-- 2. Вывести количество покупателей из каждой страны

select
	country,
	count(*) as customers_cnt
from customers
group by country;


-- 3. Вывести имя/фамилию покупателя (-ей), являющегося (-щимися) самым молодым по своей стране

select
	t1.first_name,
    t1.last_name
from customers t1
inner join (
	select
      country,
      min(age) as min_age
  from customers
  group by country
) t2
on t1.country = t2.country
where t1.age = t2.min_age;


-- ПРАКТИКА (БД hr)

use hr;

-- 1. Найти кол-во сотрудников в каждом департаменте.
-- Вывести два поля - айди департамента и кол-во сотрудников в нем

select
	department_id,
	count(*) as employees_cnt
from employees
group by department_id;


-- 2. Найти кол-во сотрудников в каждом департаменте.
-- Вывести два поля - название департамента и кол-во сотрудников в нем

select
	t2.department_name,
    count(*) as employees_cnt
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
group by t2.department_name;


-- 3. Найти сотрудников (имя, фамилия, зп), у которых наибольшая зп в их департаменте

-- найти макс зп в каждом департаменте

select
	department_id,
    max(salary) as max_salary
from employees
group by department_id;

-- приджоинить результат к таблице с сотрудниками
-- найти сотрудников, чья зп равна макс из выборки

select
	t1.first_name,
    t1.last_name,
    t1.salary
from employees t1
inner join (
	select
		department_id,
		max(salary) as max_salary
	from employees
	group by department_id
) t2
on t1.department_id = t2.department_id
where t1.salary = t2.max_salary;


-- ДЗ
-- *1. Найти название департамента, в котором работает больше всего сотрудников













