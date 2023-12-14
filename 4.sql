use hr;
select
	max(salary) as max_salary,
    min(salary) as min_salary,    -- 
    avg(salary) as avg_salary,    -- среднее значение
	sum(salary) as sum_salary,    -- суммарное значение
    count(salary) as count_salary -- количество NULL значений
from employees;


-- найти кол-во не NULL job_id
select
	count(job_id) as job_id
from employees;


-- найти максимальное значение max_salary и минимальное значение min_salary
select
	max(max_salary),
    min(min_salary)
from jobs;


-- вывести сотрудника с максимальной зп
select 
	first_name,
    last_name
from employees
where salary = (select max(salary) from employees);


-- вывести сотрудников, у которых зп меньше средней
select 
	first_name,
    last_name
from employees
where salary < (select avg(salary) from employees);

select 
	first_name,
    last_name
from employees
where department_id in (select department_id from department_id);


-- вывести департаменты, в которых нет сотрудников (решить через подзапрос)
select 
	department_name
from departments
where department_id not in (select department_id from employees
							where department_id is not null);
                            
-- групировка 
select 
	job_id,
	avg(salary)
from employees
group by job_id;


-- найти максимальную зп для каждого департамента. 
-- вывести department_id и max_salary
select 
	department_id,
	max(salary) as max_salary
from employees
group by department_id;


select
	t1.department_name,
    t2.max_salary
from departments t1
inner join(select department_id, max(salary) as max_salary
from employees
group by department_id) t2
on t1.department_id = t2.department_id;

-- вывести job_title и avg_salary
select
	t1.job_title,
    t2.avg_salary
from jobs t1
inner join(select job_id, avg(salary) as avg_salary
from employees
group by job_id) t2
on t1.job_id = t2.job_id;

use shop;
-- найти название самого дорогого товара
select
	name
from products
where price = (select max(price) from products);


-- customer_id 
-- price - цена товара, который быз заказан данным покупателем 
-- product_count - кол-во товара в заказе
select 
	t1.customer_id,
    t2.product_count,
    t3.price
from orders t1
inner join order_details t2
on t1.id = t2.order_id
inner join products t3
on t2.product_id = t3.id;

-- написать запрос, который выведит customer_id и общую сумму заказов
select 
	t1.customer_id,
    sum(t2.product_count * t3.price) as total_order_price
from orders t1
inner join order_details t2 on t1.id = t2.order_id
inner join products t3 on t2.product_id = t3.id
GROUP BY t1.customer_id;

-- написать запрос, который выведит first_name и last_name и общую сумму заказов
select
	t1.first_name,
    t1.last_name,
    sum(t1.id * t2.price) as total_order_price
from customers t1
inner join products t2 on t1.id = t2.id
group by t1.id;


use shop;
-- написать запрос, который выводит кол-во мужчин и женщин
-- поля 
-- gender 
-- cnt
select 
	gender,
    count(id) as cnt
from customers
group by gender;


-- написать запрос, который выводит название самого дорогого товара
select 
	name,
	price
from products
where price = (select max(price) from products);

-- написать запрос, который выводит название самого дорогого и самого дешевого товара
select 
	name,
	price
from products
where price = (select max(price) from products)
or price = (select min(price) from products);

-- написать запрос, который выводит имя и фамилию покупателя и кол-во заказов у каждого

SELECT * FROM orders;
SELECT * FROM customers;

-- НЕ ГРУППИРОВАТЬ ПО ИМЕНИ И ФАМИЛИИ
select
	t1.first_name,
    t1.last_name,
    t2.cnt
from customers t1
left join (select customer_id, count(customer_id) as cnt from orders group by customer_id) t2
on t1.id = t2.customer_id;



-- INNER JOIN
select
	t1.first_name,
    t1.last_name,
    t2.id
from customers t1
inner join orders t2 on t1.id = t2.customer_id;

-- LEFT JOIN
select
	t1.first_name,
    t1.last_name,
    t2.id
from customers t1
left join orders t2 on t1.id = t2.customer_id;

