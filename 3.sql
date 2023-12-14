create database shop;
use shop;
select * from customers;
select * from orders;
select * from products;
-- вывести имя и фамилию покупател и идентификаторы заказов
select 
	t1.first_name,
    t1.last_name,
    t2.id as order_id
from
	customers t1
inner join 
	orders t2
on 
	t1.id = t2.customer_id;
    
-- написать запрос, который выводит название продуктов, которые ни разу не заказывали
select 
	t1.name
from
	products t1
left join 
	order_details t2
on 
	t1.id = t2.product_id
where t2.id is null;

-- написать запрос, который выводит имя и фамилию покупателя, который хотябы раз заказывал "T-shirt"
select distinct
	t1.first_name,
    t1.last_name
from customers t1
inner join orders t2
on t1.id = t2.customer_id
inner join order_details t3
on t2.id = t3.order_id
inner join products t4
on t3.product_id = t4.id
where t4.name = 'T-shirt';

-- написать запрос, который выводит имя и фамилию покупателя и процент скидки
-- если у покупателя скидки нет, то в данном поле должно быть значение 0

