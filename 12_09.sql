-- Выбрать базу в качестве текущей;

use hr;

use airport;

-- 1. Вывести сотрудников (имя, фамилия, зп), который зарабатывают больше 15000

select
	first_name,
    last_name,
    salary
from employees
where salary > 15000;


-- 2. Вывести сотрудников (имя, фамилия, зп), которые работают в департаментах 90, 110 и 30 и зарабатывают от 5000 до 10000

select
	first_name,
    last_name,
    salary
from employees
where department_id in (90, 110, 30)
and salary between 5000 and 10000;



-- РАБОТА с БД

-- Создать БД
create database Group_090523_300523;

-- Выбрать БД в качестве текущей

use Group_090523_300523;

-- Удалить БД

drop database Group_090523_300523;


-- РАБОТА С ТАБЛИЦАМИ

-- Создать таблицу

create table users (
	id integer primary key auto_increment,
    first_name varchar(64),
    last_name varchar(64),
    score numeric(4, 2) check (score <= 50),
    gender char(1) check (gender in ('F', 'M'))
);

-- ТИПЫ ДАННЫХ
-- INTEGER (INT) - целое число
-- VARCHAR - строка (макс длина строка)
-- CHAR - строка (конкретная длина строки)
-- NUMERIC / DECIMAL - не целое число


-- Удалить таблицу 

drop table users;


-- Заполнить таблицу

insert into users (first_name, last_name, score, gender) values ('Olga', 'Ivanova', 45.01, 'F'),
																('Ivan', 'Sidorov', 42.09, 'M'),
																('Igor', 'Petrov', 12.98, 'M'),
																('Irina', 'Gribova', 33.83, 'F');


insert into users (first_name, last_name, score, gender) values ('Boris', 'Ushanov', 27.45, 'M');

insert into users (id, first_name, last_name, score) values (3, 'Kirill', 'Pavlyukov', 13.32);


-- ОГРАНИЧЕНИЯ НА ПОЛЯ (КОНСТРЕЙНТЫ / constraints)
-- NOT NULL - значение в поле не может быть null
-- UNIQUE - значение в поле должно быть уникальным
-- PRIMARY KEY (первичный ключ) - NOT NULL + UNIQUE, значение в поле не может быть null и должны быть уникальным
-- CHECK - значение в поле должно соответствовать условию

-- Удалить строки

delete from users
where id between 1 and 4;


select * from users;









