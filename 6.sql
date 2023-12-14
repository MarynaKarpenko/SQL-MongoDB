-- Агрегационные функции (+ группировка)
use hr;
-- 1. Найти сумму возрастов всех покупателей

select
 sum(age) as sum_age
from customers;


-- 2. Найти средний возраст покупателей

select
 avg(age) as avg_age
from customers;


-- 3. Найти минимальный возраст среди всех покупателей

select
 min(age) as min_age
from customers;

-- 4. Найти максимальный возраст среди всех покупателей

select
 max(age) as max_age
from customers;

-- 5. Найти количество всех покупателей


select
 count(*) as customers_cnt
from customers;


/*
update customers
set age = null
where customer_id = 5;
*/

-- 6. Найти самых младших покупателей (имя, фамилия, возраст)
-- 6. Найти покупателей (имя, фамилия, возраст), чей возраст равен минимальному

select
 first_name,
    last_name,
    age
from customers
where age = (select min(age) from customers);

-- 1. Найти сотрудников (имя, фамилия, зп), которые зарабатывают меньше всех
select
	first_name,
    last_name,
    salary
from employees
where salary = (select min(salary) from employees);

-- 2. Найти сотрудников (имя, фамилия, зп), которые зарабатывают меньше среднего по компании и работают в департаментах (90, 100, 60)
select
	first_name,
    last_name,
    salary
from employees
where salary < (select avg(salary) from employees)
and department_id in(90, 100, 60);

-- 3. Найти сотрудников (имя, фамилия, зп), которые зарабатывают меньше среднего по компании и работают в департаментах ('Executive', 'Finance', 'IT')
select
	t1.first_name,
    t1.last_name,
    t1.salary,
    t2.department_name
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
where t1.salary < (select avg(t1.salary) from employees t1)
and department_name in('Executive', 'Finance', 'IT');

select
	first_name,
    last_name,
    salary
from employees
where salary < (select avg(salary) from employees)
and department_id in (
 select
  department_id
 from departments
 where department_name in ('Executive', 'Finance', 'IT')
);

-- 4. Вывести сотрудников (имя, фамилия, job_id), работающих на должностях 'Finance Manager', 'Programmer', 'Sales Manager'
select
	t1.first_name,
    t1.last_name,
    t1.job_id,
    t2.department_name
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
where department_name in('Finance Manager', 'Programmer', 'Sales Manager');

-- ПРАКТИКА (БД airport)

use airport;

-- 1. Вывести пассажиров, которые хоть раз летали первым классом.
-- Вывести : clients.id, clients.name
use airport;

select
	t1.name as clients_name,
    t2.id
from clients t1
inner join tickets t2 on t1.id = t2.client_id
where t2.service_class = 'FirstClass';

select
 id,
    name
from clients
where id in (
 select
  client_id
 from tickets
    where service_class = 'FirstClass'
);

-- 2. Вывести количество Надежд ('Nadezhda') на самолетах в пути (departed).
-- Вывести: hope_count


-- 3. Найдите билеты на рейсы из аэропорта Саратова (код аэропорта RTW). 
-- В выборке должен присутствовать один атрибут - id.