// https://western-appeal-39b.notion.site/GenTech-Dec-19-2023-0271079050044423bc33d29313df1544

// Основные операторы модификации:
// - `$set` установить поля
// - `$inc` инкремент значений
// - `$mul` умножение
// - `$push` добавить элементы в массив
// - `$addToSet` добавить элементы в множество
// - `$pull` удалить элементы из массива
// - `$pullAll` удалить несколько элементов из массива
// - `$each` (используется в связке c `$push` и `$addToSet`)

db.users.findOne({ _id: 1 }, 
            { country: 1, _id: 1 })

db.users.countDocuments({country: 'Germany'})

db.users.insertMany([
    { _id: 2, country: "USA", full_name: "Petr Petrov" },
  { _id: 3, country: "Italy", full_name: "Ivav Ivanov" },
  { _id: 4, country: "Germany", full_name: "Anna Ivanovna" }
])

// Задача. Вывести незаблокированных юзеров
db.users.find({ is_blocked: { $ne: true } })

// Задача. Вывести незаблокированных юзеров из France
db.users.find({ is_blocked: { $ne: true }, country: 'France' })

// Заблокировать юзера 1
db.users.updateOne(
    { _id: 1 }, // filter
    {           // action
        $set: {
            is_blocked: true
        }
    }
)

// Задача. Установить юзерам не из Germany баланс в 500 (EUR) (поле balance)
db.users.updateMany(
    { country: {$ne: 'Germany'} }, 
    { $set: { balance: 500 } }
)

// Задача. Увеличить баланс на 10% всем юзером с балансом выше 0
db.users.updateMany(
    { balance: { $gt: 0 } },    // filter
    { $mul: { balance: 1.1 } }  // action
)

