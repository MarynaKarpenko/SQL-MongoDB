-- 1. Найти средний возраст в каждой из стран

select
 country,
    avg(age) as avg_age
from customers
group by country;

-- 2. Вывести средний возраст только тех стран, средний возраст которых больше или равен 25

select
 country,
    avg(age) as avg_age
from customers
group by country
having avg(age) >= 25;

use hr;

-- 1. Найти департаменты, в которых работает больше 10 сотрудников.
-- Вывести: айди департамента и кол-во сотрудников в нем
select
 department_id,
    count(*) as employees_cnt
from employees
group by department_id
having employees_cnt > 10;

-- 2. Найти департаменты, в которых работает больше 10 сотрудников.
-- Вывести: название департамента и кол-во сотрудников в нем

select
 t2.department_name,
    count(*) as employees_cnt
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
group by t2.department_name
having employees_cnt > 10;

select
 t1.department_name,
 t2.count_people
from departments t1
inner join
 (select 
  department_id,
  count(*) as count_people
 from employees
 group by department_id
 having count_people > 10) t2
on t1.department_id = t2.department_id;

-- 3. Вывести айди департаментов, в которых работает количество сотрудников выше среднего

-- найти кол-во сотрудников в каждом департаменте

select
 department_id,
    count(*) as employees_cnt
from employees
where department_id is not null
group by department_id;

-- найти среднее кол-во по всем департаментам

select
 avg(employees_cnt) as avg_cnt
from (
 select
  department_id,
  count(*) as employees_cnt
 from employees
 where department_id is not null
 group by department_id
) t1;

-- найти айди департаментов, где кол-во сотрудников превышает значение из п2

select
 department_id
from employees
group by department_id
having count(*) > (
 select
  avg(employees_cnt) as avg_cnt
 from (
  select
   department_id,
   count(*) as employees_cnt
  from employees
  where department_id is not null
  group by department_id
 ) t1
);

-- 4. Вывести названия департаментов, в которых работает количество сотрудников выше среднего

select
 t2.department_name
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
group by t2.department_name
having count(*) > (
 select
  avg(employees_cnt) as avg_cnt
 from (
  select
   department_id,
   count(*) as employees_cnt
  from employees
  where department_id is not null
  group by department_id
 ) t1
);