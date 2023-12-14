-- ПРАКТИКА / ПОВТОРЕНИЕ

use group_090523_300523;

-- 1. Создать таблицу goods (товары) с полями:

-- id (первичный ключ, авто инкеремент)
-- title (cтрока максимум 30 символов)
-- quantity (целое число больше 0)
-- price (число макс 7 символов, 3 из которых после точки)
-- in_stock (символ (Y/N))

CREATE TABLE goods (
	id integer primary key auto_increment,
	title varchar(30),
	quantity integer check (quantity > 0) default 10,
	price numeric(7, 3),
	in_stock char(1) check (in_stock in ('Y', 'N'))
);

drop table goods;

-- 2. Заполните созданную таблицу данными, минимум 10 строк.

insert into goods (title, quantity, price, in_stock) values ('Apple', 5, 500, 'Y'),
															('Orange', 3, 400, 'Y'),
                                                            ('Kiwi', 1, 150, 'N'),
                                                            ('Banana', 13, 850, 'Y'),
                                                            ('Pineapple', 11, 340, 'N');
									
insert into goods (title, in_stock) values ('Lemon', 'Y');

-- 3. Проверить содержимое таблицы

select * from goods;

-- 4. Удалить два последних продукта из таблицы 

delete from goods
where id != 5;

-- 5. Удалить все киви из таблицы

delete from goods
where title = 'Kiwi';

-- 6. Удалить все строки из таблицы 

delete from goods;

-- 7. Отключить безопасный режим

set sql_safe_updates = 0;

-- 8. Включить безопасный режим

set sql_safe_updates = 1;

-- 9. Сбросить таблицу до изначального состояния

truncate goods;


-- 10. Переименовать товар с айди 1 в Pomegranate

update goods
set title = 'Pomegranate'
where id = 1;

-- 11. Переименовать товар с title Pomegranate в Apple

update goods
set title = 'Apple'
where title = 'Pomegranate';


-- 12. Всем товарам дороже 400 увеличить количество на 10

update goods
set quantity = quantity + 10
where price > 400;


-- 13. Товарам с айдишниками от 2 до 7 поменять значение в поле price на 755

update goods
set price = 755
where id between 2 and 7;


-- 14. Товарам, в названии которых есть буква p очистить значение в поле price

update goods
set price = null
where title like '%p%';


-- ИЗМЕНЕНИЕ ПОЛЕЙ В ТАБЛИЦЕ

-- Добавить новое поле

alter table goods
add column country varchar(64) default 'Germany';

-- Удалить поле

alter table goods
drop column country;

-- Переименовать поле

alter table goods
change country origin_country varchar(64);

alter table goods
rename column origin_country to country;

-- Изменить поле (тип данных, констрейнт и тд)

alter table goods
modify column price numeric(6, 2) check (price > 100);

-- Удалить значение default 

alter table goods
alter quantity drop default;


-- Удалить check

alter table goods
drop check goods_chk_3;


select * from goods;


-- ПРАКТИКА 

-- 1. Создать таблицу students c полями

-- id первичный ключ авто инкремент
-- name (строка 64, не null)
-- lastname (строка 64, не null)
-- avg_mark (от 0 до 5)
-- gender varchar(128) (или “M” или “F”)

create table students(
	id integer primary key auto_increment,
	name varchar(64) not null,
	lastname varchar(64) not null,
	avg_mark numeric(2,1) check(avg_mark between 0 and 5),
	gender varchar(128) check(gender in ("M", "F"))
);


-- 2. Добавить 5 записей студентов

-- Олег Петров 4.3 M
-- Семен Степанов 3.1 M 
-- Ольга Семенова 4.7 F 
-- Игорь Романов 3.1 M 
-- Ирина Иванова 2.2 F


insert into students(name, lastname, avg_mark, gender) values ("Олег", "Петров", 4.3,    "M");
insert into students(name, lastname, avg_mark, gender) values ("Семен", "Степанов", 3.1, "M");
insert into students(name, lastname, avg_mark, gender) values ("Ольга", "Семенова", 4.7, "F");
insert into students(name, lastname, avg_mark, gender) values ("Игорь", "Романов", 3.1,  "M");
insert into students(name, lastname, avg_mark, gender) values ("Ирина", "Иванова", 2.2,  "F");


-- 3. Поменять у поля gender тип данных на char(1)

alter table students
modify column gender char(1);


-- 4. У поля name изменить название на first_name

alter table students
rename column name to first_name;

-- 5. Увеличить всем учащимся оценку в 10 раз

set sql_safe_updates = 0;

alter table students
modify column avg_mark numeric(3, 1);

alter table students
drop check students_chk_1;

update students
set avg_mark = avg_mark * 10;


select * from students;