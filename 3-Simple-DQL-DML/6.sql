-- 6.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці.
SELECT COUNT(clientId) AS COUNT FROM CLIENT;
/*
     COUNT
----------
         2
*/

-- 6.2 Для однієї з таблиць створити команду отримання суми значень однієї з цілих
-- колонок.
SELECT SUM(billamount) as SUM FROM bill; 
/*
       SUM
----------
       498
*/

/*
6.3 Для однієї з таблиць створити команду отримання статистики появи значень однієї з
колонок у таблиці, наприклад:
- значення 1, кількість появи значення 1
- значення 2, кількість появи значення 2
*/
SELECT managerid as id, COUNT(managerId) 
FROM CLIENT
GROUP BY managerid;
/*
ID         COUNT(MANAGERID)
---------- ----------------
1                         1
2                         1
*/

/*
6.4 Модифікувати рішення попереднього завдання так, щоб у відповіді були
відфільтровані рядки з урахуванням заданої умови, що включає використану функцію агрегації
*/
SELECT managerid as id, COUNT(managerId) 
FROM CLIENT
GROUP BY managerid
ORDER BY COUNT(MANAGERID) ASC; 
/*
ID         COUNT(MANAGERID)
---------- ----------------
1                         1
2                         1
*/