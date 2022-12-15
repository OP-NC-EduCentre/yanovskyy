-- 6.1 Для однієї з таблиць створити команду отримання кількості рядків таблиці.
/*
L014	1 / 14	
Unquoted identifiers must be consistently upper case.
L029	1 / 27	
Keywords should not be used as identifiers.
*/
SELECT COUNT(clientId) AS COUNT FROM CLIENT;
/*
     COUNT
----------
         2
*/

-- 6.2 Для однієї з таблиць створити команду отримання суми значень однієї з цілих
-- колонок.
/*
L010	1 / 24	
Keywords must be consistently upper case.
L014	1 / 27	
Unquoted identifiers must be consistently lower case.
L029	1 / 27	
Keywords should not be used as identifiers.
*/
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
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L010	1 / 18	
Keywords must be consistently upper case.
L013	1 / 25	
Column expression without alias. Use explicit `AS` clause.
L014	1 / 31	
Unquoted identifiers must be consistently lower case.
L001	1 / 41	
Unnecessary trailing whitespace.
L014	2 / 6	
Unquoted identifiers must be consistently lower case.
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
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L010	1 / 18	
Keywords must be consistently upper case.
L013	1 / 25	
Column expression without alias. Use explicit `AS` clause.
L014	1 / 31	
Unquoted identifiers must be consistently lower case.
L001	1 / 41	
Unnecessary trailing whitespace.
L014	2 / 6	
Unquoted identifiers must be consistently lower case.
L014	4 / 16	
Unquoted identifiers must be consistently lower case.
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