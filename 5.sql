-- групировка
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
