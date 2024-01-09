// ПРАКТИКА 2

use groups_090523_300523

// 1. Создать коллекцию products

db.createCollection('products')

// 2. заполнить коллекцию products, используя массив

db.products.insertMany([  
  {
  _id: 1,
  title: "Велосипед",
  price: 45000,
  count: 12
 },
    {
  _id: 2,
  title: "Самокат",
  price: 15000,
  count: 10
 },
  {
  _id: 3,
  title: "Ролики",
  price: 20000,
  count: 20
 },
  {
  _id: 4,
  title: "Лыжи",
  price: 22000,
  count: 15
 },
  {
  _id: 5,
  title: "Скейт",
  price: 19000,
  count: 4
 },
  {
  _id: 6,
  title: "Сноуборд",
  price: 33000,
  count: 17
 }
])

// 3. Проверить содержимое коллекции

db.products.find()

// 4. Найти товары, кол-во которых превышает 10

db.products.find({ count: {$gt: 10} })

// 5. Найти товары, кол-во которых от 10 до 20 (вкл) и цена которых превышает 20000

db.products.find({
    $and: [
        {count: {$gte: 10, $lte: 20}},
        {price: {$gt: 20000}}
    ]
})

db.products.find({
  count: {$gte: 10, $lte: 20},
  price: {$gt: 20000}
})

// 6. Вывести данные о продуктах с айди 2, 4 и 6

db.products.find({
    _id: {$in: [2, 4, 6]}
})

// 7. Документу с айди 2 изменить значение count на 13
db.products.updateOne(
  {_id: 2},
  {$set: {count: 13}}
)

// 9. Товарам с айди 1 и 4 добавить к списку стран-поставщиков USA

db.products.updateMany(
  {_id: {$in: [1, 4]}},
  {$addToSet: {country: 'USA'}}
)

// 10. Товарам с айди 1, 3, 5 добавить к списку стран-поставщиков USA и Brazil. Убедиться, что страны в массиве country не повторяются

db.products.updateMany(
  {_id: {$in: [1, 3, 5]}},
  {$addToSet: {country: {$each: ['USA', 'Brazil']}}}
)

// ИЗМЕНЕНИЕ ДАННЫХ (UPDATE)

// updateOne() - изменяет один документ в коллекции; самый первый, который подошел по условию
// updateMany() - изменяет все документы в коллекции, которые подошли по условию

// Операторы, используемые с update (операторы модификации)
// $set - добавляет новое свойство, если его не существует; или измениет значение уже существующего свойства
// $unset - удаляет свойство
// $rename - переименовывает свойство
// $inc - увеличивает/уменьшает значение на переданное число
// $push - добавляет любой/каждый элемент в массив
// $addToSet - добавляет уникальный элемент в массив (доп проверка на наличие элемента в массиве)
// $each - позволяет добавлять в массив более одного элемента за раз (список значений)

// 1. Всем документам добавить свойство country со значением Germany

db.products.updateMany(
  {},
  {$set: {country: 'Germany'}}
)

// 2. Всем товарам, кол-во которых превышает 15, изменить значение свойства country на Spain

db.products.updateMany(
  {count: {$gt: 15}},
  {$set: {country: 'Spain'}}
)

// 3. У всех документов удалить свойство county

db.products.updateMany(
  {},
  {$unset: {country: ''} }
)

// 4. Всем документам переименовать свойство title в product_title

db.products.updateMany(
  {},
  {$rename: {'title': 'product_title'}}
)

// 5. Документу с айди 1 увеличить значение свойства count на 5

db.products.updateOne(
  {_id: 1},
  {$inc: {count: 5}}
)

// 6. Документу с айди 1 уменьшить значение свойства count на 5

db.products.updateOne(
  {_id: 1},
  {$inc: {count: -5}}
)

// 7. Добавить всем документам свойство country со значением []

db.products.updateMany(
    {},
    {$set: {country: []}}
)

// 8. Всем товарам, цена которых выше 20000 в массив country добавить Germany

db.products.updateMany(
  {price: {$gt: 20000}},
  {$push: {country: 'Germany'}}
)

db.products.updateMany(
  {price: {$gt: 20000}},
  {$addToSet: {country: 'Germany'}}
)

// 9. Всем товарам в массив country добавить Germany, Spain, Poland. Не создавать дубликатов значений в массиве

db.products.updateMany(
  {},
  {$addToSet: {country: {$each: ['Germany', 'Spain', 'Poland']}}}
)

// 10. В документе с айди 1 заменить Brazil на Canada

db.products.updateOne(
  {_id: 1, country: 'Brazil'},
  {$set: { "country.$" : 'Canada' }}
)

// УДАЛЕНИЕ ДАННЫХ (DELETE)

// deleteOne() - удаляет один документ в коллекции; самый первый, который подошел по условию
// deleteMany() - удаляет все документы в коллекции, которые подошли по условию

// 10. Удалить все документы из коллекции products

db.products.deleteMany({})

// 11. Удалить все товары, количество которых меньше 10

db.products.deleteMany({ count: {$lt: 10} })



