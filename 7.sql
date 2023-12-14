use hr;
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from jobs;
select * from employees_it_prog;
-- написать запрос, который выводит имя и фамилию сотрудника и название департамента
select 
	t1.first_name,
    t1.last_name,
    t2.department_name 
FROM 
	employees t1
LEFT JOIN
    departments t2
ON
    t1.department_id = t2.department_id;
    
-- вывести названия департаментов, в которых встречаются сотрудники 
-- с зп больше 12000
select distinct
    t2.department_name 
FROM 
	employees t1
INNER JOIN
    departments t2
ON
    t1.department_id = t2.department_id
WHERE t1.salary > 12000;

-- вывести названия департаментов, которые находятся в городах, которые начинаются на South
select 
    t1.department_name,
    t2.city
FROM 
	departments t1
INNER JOIN
    locations t2
ON
    t1.location_id = t2.location_id
WHERE t2.city like 'South%';
-- к прежней выборке добавить вывод названия страны
select 
    t1.department_name,
    t2.city,
    t3.country_name
FROM 
	departments t1
INNER JOIN
    locations t2
inner join 
	countries t3
ON
    t1.location_id = t2.location_id and t2.country_id = t3.country_id
WHERE t2.city like 'South%';

-- добавить в выборку название региона
select 
    t1.department_name,
    t2.city,
    t3.country_name,
    t4.region_name
FROM 
	departments t1
INNER JOIN
    locations t2
inner join 
	countries t3
inner join 
	regions t4
ON
    t1.location_id = t2.location_id and t2.country_id = t3.country_id and t3.region_id = t4.region_id
WHERE t2.city like 'South%';

-- написать запрос, который выводит название депаратментов, в которых нет ни одного 
-- сотрудника
select
	t1.department_name
from 
	departments t1
left join 
	employees t2
on 
	t1.department_id = t2.department_id
where t2.employee_id is null;

-- написать запрос, который выводит job_title которого нет ни у одного сотрудника
select
	t1.job_title
from 
	jobs t1
left join 
	employees t2
on 
	t1.job_id = t2.job_id
where t2.employee_id is null;

-- написать запрос, котоый выводит имя и фамилию сотрудника и имя и фамилию его менеджера
select 
	t1.first_name,
    t1.last_name,
    t2.first_name as manager_first_name,
    t2.last_name as manager_last_name
from
	employees t1
left join 
	employees t2
on 
	t1.manager_id = t2.employee_id;