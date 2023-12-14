-- Однострочный комментарий

/*
Многострочный
комментарий
*/

-- ссылка на песочницу https://www.programiz.com/sql/online-compiler/

-- BETWEEN ... AND ... (NOT BETWEEN)
select 
  first_name, 
  last_name,
  age
from customers
where age between 25 and 30;


-- IN (NOT IN)
select 
  first_name, 
  last_name,
  age
from customers
where age in (20, 31, 22);


-- LIKE (NOT LIKE)
-- % - любое множество символов (0 - infinity)
-- _ - один любой символ

-- Фамилия начинается на r
select 
  first_name, 
  last_name,
  age
from customers
where last_name like 'r%';

-- Фамилия заканчивается на е
select 
  first_name, 
  last_name,
  age
from customers
where last_name like '%e';

-- Фамилия содержит о
select 
  first_name, 
  last_name,
  age
from customers
where last_name like '%o%';

-- У фамилии вторая буква о

select 
  first_name, 
  last_name,
  age
from customers
where last_name like '_o%';


-- AND (И), OR (ИЛИ)

select 
  first_name, 
  last_name,
  age
from customers
where last_name like 'r%'
and age >= 25;


select 
  first_name, 
  last_name,
  age
from customers
where last_name like 'r%'
or age >= 25;


-- () - указание приоритета, группировка
select 
  first_name, 
  last_name,
  age
from customers
where (last_name like 'r%' or last_name like '%e')
and age >= 25;


-- ПРАКТИКА
-- Ссылка на создание таблицы employees https://github.com/NelliEfr/MySQL_databases/blob/main/employees.txt

-- 1. Найти всех сотрудников (имя, фамилия, job_id), c job_id = IT_PROG
select
  first_name,
  last_name,
  job_id
from employees
where job_id = 'IT_PROG';


-- 2. Найти сотрудников (имя, фамилия, зп) с зп больше 10 000
select
  first_name, 
  last_name, 
  salary
from employees
where salary > 10000;


-- 3. Найти сотрудников (имя, фамилия, зп) с зп от 10 000 до 20 000 (включая концы)
select
  first_name,
  last_name,
  salary
from employees
where salary between 10000 and 20000;


select
  first_name,
  last_name,
  salary
from employees
where salary >= 10000 and salary <= 20000;


-- 4. Найти сотрудников (имя, фамилия, айди департамента) не из 60, 30 и 100 департаментов
select 
  first_name,
  last_name,
  department_id
from employees
where department_id not in (60, 30, 100);


-- 5. Найти сотрудников (имя, фамилия), у которых есть две буквы ll подряд в середине имени
select 
  first_name, 
  last_name
from employees
where first_name like '%_ll_%';


-- 6. Найти сотрудников (имя, фамилия), у которых фамилия кончается на a
select
  first_name,
  last_name
from employees
where last_name like '%a';


-- 7. Найти сотрудников (имя, фамилия, commission_pct), у которых commission_pct отсутствует
select
  first_name,
  last_name,
  commission_pct
from employees
where commission_pct is null;


-- 8. Вывести уникальные имена покупателей
select distinct
	first_name
from customers;


-- 9. Найти все имеющиеся уникальные job_id
select distinct
	job_id
from employees;


-- 10. Найти job_id, у которых нет COMMISSION_PCT или зп меньше 3000
select distinct
	job_id
from employees
where commission_PCT is null
or salary < 3000;



 

 

