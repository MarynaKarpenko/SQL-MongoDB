// MongoDB - хранит данные в формате JSON

// Таблица = Коллекция []
// Запись (строка) = Документ {}
// Поле (колонка) = Свойство


// Пример документа

// {
//   id: 1,
//   firstname: 'Oleg',
//   lastname: 'Petrov',
//   age: 30,
//   skills: ['HTML', 'CSS', 'JS'],
//   address: {
//     city: 'Berlin',
//     country: 'Germany',
//     postcode: 12345
//   },
//   online: true
// }



// РАБОТА С БД

// Создать БД

use groups_090523_300523

// Показать список всех существующих БД

show databases

// Удалить БД

db.dropDatabase()


// РАБОТА С КОЛЛЕКЦИЕЙ

// Создать коллекцию

db.createCollection('users')

// Показать список всех существующих коллекций в БД

show collections

// Удалить коллекцию

db.users.drop()

// Просмотреть всё содержимое коллекции 

// select * from table

db.users.find()


// Добавить один документ {} в коллекцию []

db.users.insertOne({
  _id: 1,
  firstname: 'Oleg',
  lastname: 'Petrov',
  age: 30
})


// Добавить несколько документов {} в коллекцию []

db.users.insertMany([
  {
    _id: 2,
    firstname: 'Irina',
    lastname: 'Ivanova',
    age: 23
  },
  {
    _id: 3,
    firstname: 'Anna',
    lastname: 'Sorokina',
    age: 12
  },
  {
    _id: 4,
    firstname: 'Boris',
    lastname: 'Ushanov',
    age: 54
  }
])


// ОПЕРАТОРЫ СРАВНЕНИЯ

// $lt -  <
// $lte - <=
// $gt - >
// $gte - >=
// $eq - =
// $neq - !=
// $in - []


// ЛОГИЧЕСКИЕ ОПЕРАТОРЫ

// $and - И (если все указанные условия верны, то документ попадает в выборку)
// $or - ИЛИ (если хотя бы одно из указанных условий верно, то документ попадает в выборку)
// $nor - ни то, ни другое (если все указанные условия неверны, то документ попадает в выборку)
// $not - НЕ


// ПРАКТИКА 

// 1. Вывести пользователей, чей возраст равен 30

db.users.find({ age: 30 })


// 2. Вывести пользователей старше 20 лет

db.users.find({ age: {$gt: 20} })


// 3. Вывести всех пользователей по имени Олег

db.users.find({ firstname: 'Oleg' })


// 4. Вывести всех пользователей, которых зовут НЕ Олег

db.users.find({ firstname: {$ne: 'Oleg'} })


// 5. Вывести всех пользователей с именами Anna, Boris, Petr, Ivan

db.users.find({
  firstname: {$in: ['Anna', 'Boris', 'Petr', 'Ivan']}
})


// 6. Вывести всех пользователей старше 30 лет по имени Анна или Борис

// db.users.find({ age: {$gt: 30} })
// db.users.find({ firstname: {$in: ['Anna', 'Boris']} })


db.users.find({
  $and: [
    { age: {$gt: 30} },
    { firstname: {$in: ['Anna', 'Boris']} }
  ]
})


// ПРАКТИКА 2

/*
1. Создать коллекцию profiles и заполнить документами (4 штуки) со следующими 
	свойствами (_id, name, age, gender). Используйте следующие данные
	
1 Anatoliy 28 m
2 Svetlana 25 f
3 Nikita 33 m
4 Olga 22 f

*/

db.createCollection('profiles')

db.profiles.insertMany([  
  {
		_id: 1,
		name: "Anatoliy",
		age: 28,
		gender: "m"
	},
  {
		_id: 2,
		name: "Svetlana",
		age: 25,
		gender: "f"
	},
  {
		_id: 3,
		name: "Nikita",
		age: 33,
		gender: "m"
	},
  {
		_id: 4,
		name: "Olga",
		age: 22,
		gender: "f"
	}
])


// 2. Проверить содержимое коллекции

db.profiles.find()


// 3. Вывести данные о всех женщинах

db.profiles.find({ gender: 'f' })


// 4. Вывести данные о мужчинах старше 30 лет

db.profiles.find({
  $and: [
    { age: {$gt: 30} },
    { gender: 'm' }
  ]
})


// 5. Вывести пользователей с именами Anna, Oleg, Nikita, Svetlana

db.profiles.find({ 
  name: {$in: ['Anna', 'Oleg', 'Nikita', 'Svetlana']} 
})


// 6. Вывести всех пользователей в возрасте от 20 до 30 лет (вкл)

db.profiles.find({
  $and: [
    { age: {$gte: 20} },
    { age: {$lte: 30} }
  ]
})

db.profiles.find({ age: {$gte: 20, $lte: 30} })


// 7. Вывести всех мужчин в возрасте от 20 до 30 лет (вкл)

db.profiles.find({
  $and: [
    { age: {$gte: 20} },
    { age: {$lte: 30} },
    { gender: 'm' }
  ]
})


db.profiles.find({
  $and: [
    { age: {$gte: 20, $lte: 30} },
    { gender: 'm' }
  ]
})
