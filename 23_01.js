// 1. Выбрать БД в качсетве текущей

use groups_090523_300523

// 2. Создать коллекцию orders

db.createCollection('orders')

// 3. Заполнить коллекцию, используя массив

db.orders.insertMany([
	{
		_id: 1,
		customer: 'Olga',
		product: 'Apple',
		amount: 15.55,
		city: 'Berlin'
	},
	{
		_id: 2,
		customer: 'Anna',
		product: 'Apple',
		amount: 10.05,
		city: 'Madrid'
	},
	{
		_id: 3,
		customer: 'Olga',
		product: 'Kiwi',
		amount: 9.6,
		city: 'Berlin'
	},
	{
		_id: 4,
		customer: 'Anton',
		product: 'Apple',
		amount: 20,
		city: 'Roma'
	},
	{
		_id: 5,
		customer: 'Olga',
		product: 'Banana',
		amount: 8,
		city: 'Madrid'
	},
	{
		_id: 6,
		customer: 'Petr',
		product: 'Orange',
		amount: 18.3,
		city: 'Paris'
	}
])

// 4. Проверить содержимое коллекции

db.orders.find()

// 5. Найти сколько всего было совершено покупок

db.orders.countDocuments()

db.orders.find().count()

// 6. Найти сколько всего покупок было совершено в городах Берлин и Мадрид в сумме

db.orders.countDocuments({ city: {$in: ['Berlin', 'Madrid']} })

db.orders.find({ city: {$in: ['Berlin', 'Madrid']} }).count()


// 7. Найти сколько раз были куплены яблоки

db.orders.countDocuments({ product: 'Apple' })

db.orders.find({ product: 'Apple' }).count()


// 8. Вывести все документы отсортированными по стоимости покупки - от самой недорогой до самой дорогой

db.orders.find().sort({ amount: 1 })


// 9. Вывести три самые дорогие покупки в коллекции

db.orders.find().sort({ amount: -1 }).limit(3)

// 10. Всем документам добавить свойство rate со значением 10

db.orders.updateMany(
  {},
  {$set: {rate: 10}}
)

// 11. Документам с айди 3, 5 и 6 увеличить значение rate на 5

db.orders.updateMany(
  {_id: {$in: [3, 5, 6]}},
  {$inc: {rate: 5}}
)

// 12. Товарам дороже 10 уменьшить значение rate на 2.5

db.orders.updateMany(
  {amount: {$gt: 10}},
  {$inc: {rate: -2.5}}
)


// АГРЕГАЦИЯ И ГРУППИРОВКА

// 13. Найти сколько денег было потрачено на все покупки

db.orders.aggregate([
  {$match: {}},
  {$group: {_id: 'all orders', total_amt: {$sum: '$amount'}}}
])

// 14. Найти сколько денег было потрачено на яблоки и киви (с разбивкой на продукты)

db.orders.aggregate([
  {$match: { product: {$in: ['Apple', 'Kiwi']} }},
  {$group: {_id: '$product', total_amt: {$sum: '$amount'}}}
])

// 15. Найти сколько денег было потрачено на яблоки и киви (без разбивки)

db.orders.aggregate([
  {$match: { product: {$in: ['Apple', 'Kiwi']} }},
  {$group: {_id: 'Apples and Kiwi', total_amt: {$sum: '$amount'}}}
])

// 16. Найти сколько было потрачено на каждый товар

db.orders.aggregate([
  {$match: {}},
  {$group: {_id: '$product', total_amt: {$sum: '$amount'}}}
])


// 17. Найти сколько совершила покупок Ольга

db.orders.countDocuments({ customer: 'Olga' })

db.orders.find({ customer: 'Olga' }).count()

// 18. Найти сколько денег потратила Ольга

db.orders.aggregate([
  {$match: {customer: 'Olga'}},
  {$group: {_id: '$customer', total_amt: {$sum: '$amount'}}}
])

// 19. Добавить всем документам свойство count со значением 0

db.orders.updateMany(
	{},
	{$set: {count: 0}}
)

// 20. Документам с id 1 и 3 задать значение count 3. Документу с id 4 задать count 2. Всем документам увеличить count на 1

db.orders.updateMany(
	{_id: {$in: [1, 3]}},
	{$set: {count: 3}}
)

db.orders.updateOne(
	{_id: 4},
	{$set: {count: 2}}
)

db.orders.updateMany(
	{},
	{$inc: {count: 1}}
)


// 21. Найти общее кол-во проданных в Берлине яблок

db.orders.aggregate([
  {$match: {
    product: 'Apple',
    city: 'Berlin'
  }},
  {$group: {_id: '$product', total_cnt: {$sum: '$count'}}}
])


// 22. Найти в каких городах совершала покупки Ольга

db.orders.aggregate([
  {$match: {customer: 'Olga'}},
  {$group: {_id: '$city'}}
])

db.orders.aggregate([
  {$match: {customer: 'Olga'}},
  {$group: {_id: '$city'}}
]).map(el => el._id)


// 23. Найти сколько было потрачено в каждом городе. Вывести результат отсортированным в порядке убывания (от большего к меньшему)

db.orders.aggregate([
  {$match: {}},
  {$group: {_id: '$city', total_amt: {$sum: '$amount'}}}
]).sort({ total_amt: -1 })


db.orders.aggregate([
  {$match: {}},
  {$group: {_id: '$city', total_amt: {$sum: '$amount'}}},
  {$sort: {total_amt: -1}}
])
