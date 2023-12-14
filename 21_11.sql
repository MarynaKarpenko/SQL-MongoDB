-- ДЗ

use hr;

-- *3. Найти сумму зп тех сотрудников, кто зарабатывает больше 10000
-- Вывести одно значение - sum

select
	sum(salary) as sum
from employees
where salary > 10000;


select
	sum(
		case
			when salary <= 10000 then 0
			else salary
        end
    ) as sum
from employees;

-- *4. Найти департаменты в которых есть работники, зарабатывающие больше 10 000. 
-- В результате выборки формируются два поля (department_id и поле со значениями 1 или 0). 
-- 1 - если в департаменте есть хотя бы один сотрудник с зп больше 10000, 0 - если таких сотрудников нет

select
	department_id,
    max(
		case
			when salary > 10000 then 1
            else 0
        end
    ) as salary_index
from employees
group by department_id;

-- max(1, 1, 0) => 1
-- max(0, 0, 0, 0, 0) => 0
-- max(0, 1, 0, 0) => 1


-- * 5. Найти департаменты в которых ВСЕ работники зарабатывают больше 10 000. 
-- В результате выборки формируются два поля (department_id и поле со значениями 1 или 0)
-- 1 - если в департаменте ВСЕ сотрудники имеют зп больше 10000, 0 - если не все

select
	department_id,
    min(
		case
			when salary > 10000 then 1
            else 0
        end
    ) as salary_index
from employees
group by department_id;


-- min(1, 1, 0) => 0
-- min(0, 0, 0, 0, 0) => 0
-- min(0, 1, 0, 0) => 0
-- min(1, 1, 1, 1) => 1

SELECT 
  department_id,
  CASE
    WHEN COUNT(*) = SUM(CASE WHEN salary > 10000 THEN 1 ELSE 0 END) THEN 1
    ELSE 0
  END AS salary_index
FROM employees
GROUP BY department_id;


-- ПРАКТИКА (песочница)

-- 1. Найти сумму возрастов всех, кто старше 25 лет (>25). 
-- Предложить два варианта решения задачи.

select
	sum(age) as sum_age
from customers
where age > 25;


select
	sum(
    	case
      		when age > 25 then age
      		else 0
      	end
    ) as sum_age
from customers;


-- 2. Найти сумму потраченных средств на товары, стоимость которых выше 350
-- Предложить вариант решения задачи через case

select
	sum(
    	case
      		when amount > 350 then amount
      		else 0
      	end
    ) as sum_amount
from orders;


-- 3. Найти среднее значение потраченных средств на товары, стоимость которых выше 350
-- Предложить вариант решения задачи через case

select
	avg(
    	case
      		when amount > 350 then amount
      	end
    ) as avg_amount
from orders;


-- ПРАКТИКА (БД shop)

use shop;


-- 1. Выведите имена покупателей, которые сделали более одной покупки.
-- В выборке должно присутствовать два атрибута — cname, cnt (количество покупок)

select
	t1.cname,
    count(*) as cnt
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
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
	having cnt > 1
) t2
on t1.cust_id = t2.cust_id;








