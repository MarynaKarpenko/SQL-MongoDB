-- ПРАКТИКА 

use group_090523_300523;

-- 1. Создайте таблицу products (id, title, quantity)
-- id первичный ключ автоинкремент
-- title строка 64 символа 
-- quantity целое число от 0 до 10 (вкл)

create table products(
	id integer primary key auto_increment,
	title varchar(64),
	quantity integer check(quantity between 0 and 10)
);

-- 2. Добавить 5 строк

insert into products (title, quantity) values('велосипед', 4);
insert into products (title, quantity) values('лыжи',  5);
insert into products (title, quantity) values('коньки',  7);
insert into products (title, quantity) values('скейт', 2);
insert into products (title, quantity) values('сноуборд', 8);


-- 3. Проверить содержимое таблицы

select * from products;


-- 4. Добавить поле price (integer) со значением по умолчанию 0

alter table products
add column price integer default 0;


-- 5. У поля price изменить тип данных на numeric(8, 2)

alter table products
modify column price numeric(8, 2);


-- 6. Переименовать поле price на item_price

alter table products
rename column price to item_price;


-- 7. Всем продуктам, количество которых превышает 6 (>6) установить в поле item_price значение 100. 

set sql_safe_updates = 0;

update products
set item_price = 100
where quantity > 6;

-- 8. Всем продуктам увеличить текущее значение price на 150

update products
set item_price = item_price + 150;


-- 9. Всем продуктам увеличить значение quantity в 10 раз

alter table products
drop check products_chk_1;

alter table products
add check (quantity between 0 and 100);

update products
set quantity = quantity * 10;


-- ПРЕДСТАВЛЕНИЯ (view)
-- Представления позволяют нам сохранить не данные, а запрос. 
-- При каждом обращении к представлению выполняется запрос и формируется выборка в соответствии с запросом из представления.

-- 1. Создать представление из всех продуктов, стоимость которых меньше 200

create view cheap_products as
select
	*
from products
where item_price < 200;

-- 2. Просмотреть содержимое по запросу к представлению cheap_products

select * from cheap_products;

select 
	*
from (
	select
		*
	from products
	where item_price < 200
);


-- 3. Найти все продукты дешевле 200, количество которых больше 30

select
	*
from cheap_products
where quantity > 30;


select
	*
from products
where quantity > 30 and item_price < 200;


-- 4. Из таблицы students создать представление, которое содержит всех женщин

create view female_students as
select
	*
from students
where gender = 'f';

select * from female_students;



-- ПРАКТИКА (БД airport)

use airport;

-- 1. Аналитическое подразделение решило уточнить у авиакомпании количество билетов не бизнес-класса.
-- Напишите запрос, который выведет id билетов, класс обслуживания в которых отличен от бизнес-класса (Business).
-- В выборке должен присутствовать один атрибут —  id.

select
	id
from tickets
where service_class != 'Business';


-- 2. Определите рейсы с точкой назначения в аэропортах (arrival), коды которых PEZ, MMK и VKO.
-- В выборке должен присутствовать один атрибут — id.

select
	id
from trips
where arrival in ('PEZ', 'MMK', 'VKO');


-- 3. Определите id рейсов, которые должны были вылететь из аэропорта Домодедово (DME), но были отменены (cancelled).
-- В выборке должен присутствовать один атрибут — id.

select 
	id
from trips
where departure = 'DME' and status = 'Cancelled';


-- 4. После каждого рейса проходит плановая уборка салона. Результаты уборки вносятся в отчет-лист. 
-- Авиакомпания получила отчет, в котором указано, что во всех самолетах все места чистые, а спинки кресел исправные.
-- Выведите бортовой номер самолета, cформировав для каждой строки поле index с значением 'clean'.
-- В выборке должны присутствовать два атрибута — side_number и index.

select
	side_number,
    'clean' as 'index'
from airliners;


-- 5. Выведите бортовой номер самолета, cформировав для каждой строки поле status с значением 'clean', если бортовой номер больше или равен 4000, или со значением 'not clean', если бортовой номер меньше 4000

select
	side_number,
	case
		when side_number >= 4000 then 'clean'
        else 'not clean'
    end as status
from airliners;


-- 6. Разделите самолеты на три класса по возрасту. 
-- Если самолет произведен раньше 2000 года, то отнесите его к классу 'Old'. 
-- Если самолет произведен между 2000 и 2010 годами включительно, то отнесите его к классу 'Mid'. 
-- Более новые самолеты отнесите к классу 'New'. 
-- Исключите из выборки дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. 
-- В выборке должны присутствовать два атрибута — side_number, age.

select
	side_number,
    case
		when production_year < 2000 then 'Old'
        when production_year between 2000 and 2010 then 'Mid'
        else 'New'
    end as age
from airliners
where range_ <= 10000;


-- 7. Определите имена и фамилии пассажиров, чьи идентификаторы заканчиваются на RCB или FCV, а номера телефонов не начинаются на +705.
-- В выборке должен присутствовать один атрибут — name.

select 
	name
from clients
where (id like '%RCB' or id like '%FCV')
and phone not like '+705%';






