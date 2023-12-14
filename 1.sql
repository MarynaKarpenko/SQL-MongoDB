-- ПРАКТИКА

-- 1. Разделите самолеты на ближне-, средне- и дальнемагистральные. 
-- Ближнемагистральными будем считать самолеты, дальность полета которых > 1000 км и <= 2500 км. 
-- Среднемагистральными — с дальностью полета > 2500 км и <= 6000 км. 
-- Дальнемагистральными — с дальностью полета > 6000 км. 
-- В выборке должно быть два столбца, где в первом указана модель самолета. 
-- Во втором, category, — категория, со значениями short-haul, medium-haul, long-haul (ближне-, средне- и дальнемагистральные соответственно). Каждый самолет точно попадает ровно в одну категорию.
-- В выборке должны присутствовать два атрибута — model_name, category.

use airport;
select * from airliners;

select 
	model_name,
case 
when rangee > 1000 and rangee <= 2500 then 'short-haul'
when rangee > 2500 and rangee <= 6000 then 'medium-haul'
when rangee > 6000 then 'long-haul'
end as category
from airliners;

-- 2. Выведите данные о билетах разной ценовой категории. 
-- Среди билетов экономкласса (Economy) добавьте в выборку билеты с ценой от 10 000 до 11 000 включительно. 
-- Среди билетов комфорт-класса (PremiumEconomy) — билеты с ценой от 20 000 до 30 000 включительно. 
-- Среди билетов бизнес-класса (Business) — с ценой строго больше 100 000. 
-- В решении необходимо использовать оператор CASE.
-- В выборке должны присутствовать три атрибута — id, service_class, price.

select 
	id,
    service_class,
    price
from tickets
where (service_class = 'Economy' and price between 10000 and 11000)
or (service_class = 'PremiumEconomy' and price between 20000 and 30000)
or (service_class = 'Business' and price > 100000);

-- 3. Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%. 
-- Определите цену билета в каждом сегменте с учетом скидки.
-- В выборке должны присутствовать три атрибута — id, trip_id, new_price.
select 
	id,
    trip_id,
case 
	when service_class = 'Economy' then price = (price * 0.15)
    when service_class = 'Business' then price - (price * 0.1)
	when service_class = 'PremiumEconomy' then price - (price * 0.2)
	else price
end as new_price
from tickets
where trip_id in ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G');

-- 4. Некоторые самолеты авиакомпании требуют проверки бортовых документов. 
-- Выведите бортовые номера и статус проверки для всех самолетов. 
-- Если самолет выпущен ранее 2000 года, то выведите статус 'review_old'. 
-- Если самолет выпущен позже 2010 года, то выведите статус 'no_review'. 
-- Для самолетов, которые выпущены в промежутке с 2000 до 2010 года включительно статус завист от максимальной дальности полета. 
-- Если дальность полета более 6000 км, то выведите статус 'review_mid_long_haul'. 
-- Если дальность полета более 2500 км, но не более 6000 км, то выведите статус 'review_mid_medium_haul'. 
-- Иначе выведите статус 'review_mid_short_haul'.
-- В выборке должны присутствовать два атрибута — side_number, review_status.

select 
	side_number,
case 
	when production_year < 2000 then 'review_old'
    when production_year > 2010 then 'no_review'
    when production_year between 2000 and 2010 then
		case
			when rangee > 6000 then 'review_mid_long_haul'
            when rangee > 2500 and rangee < 6000 then 'review_mid_medium_haul'
            else 'review_mid_short_haul'
            end
end as rewiew_status
from airliners;