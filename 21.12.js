// Task 1
// Выведите сотрудников, профессия которых SA_REP или IT_PROG и запралата которых больше 10000

// use groups_090523_300523.employees;

db.employees.find({
    job_id: {$in: ['SA_REP', 'IT_PROG']},
    salary: {$gt: 10000}
})

// -------------------------
// Task 2

// Выведите сотрудников, которые получают зарплату от 5000 до 9000 включительно 
// ИЛИ профессия определяется как АD_PRES
db.employees.find({
    $or: [
        {salary: {
            $gte: 5000, $lte: 9000
        }}, 
        {job_id: 'АD_PRES'}
    ]
})

// -------------------------
// Task 3
// Для всех записей сформируйте новое поле languages , которое будет хранить 1 значение 'Engl'
db.employees.updateMany(
    { _id: 1 },
    {$set: {languages: 'Engl'}}
)

// -------------------------
// Task 3 
// Доавьте всем сотрудникам новые языкы: Franc, Germ с условием: 
// Сотрудники должны работаь в департмантах: 50,70,90,100,110
db.employees.updateMany(
    { dep_id: 
        {$in: [50, 70, 90, 100, 110]}
    },
    {$push: 
        {languages: 
            {$each: ['Franc', 'Germ']}
        }
    }
)


// -------------------------
// Task 5
// Добавьте всем сотрудникам язык Arm, которые не из профессии SA_REP и IT_PROG

db.employees.updateMany(
    { job_id: 
        {$ne: ['SA_REP', 'IT_PROG']}
    },
    {$set: 
        {languages: 'Arm'}
    }
)

// -------------------------
// Task 6

// Увеличьте троекратно запралту всем сотрудникам, а также уберите язык "Franc"
db.employees.updateMany(
    {},
    {$mul: 
        {salary: 3}
    },
    {$pull: 
        {languages: 'Franc'}
    }
)