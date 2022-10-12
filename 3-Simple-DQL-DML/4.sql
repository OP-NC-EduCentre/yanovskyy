-- 4.1 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: цілочисельне значення однієї з колонок
-- має бути більшим за якесь константне значення.
SELECT packageId as id, pricePerMonth as Price 
FROM InternetPackage
WHERE pricePerMonth > 299; 
/*
ID              PRICE
---------- ----------
3                 399
4                 499
5                 599
*/

-- 4.2 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
-- має співпадати з якимось константним значенням.
SELECT ClientID, ClientName, birthday as B_day, managerId
FROM Client 
WHERE clientName = 'name 1'; 
/*
CLIENTID   CLIENTNAME                               B_DAY      MANAGERID
---------- ---------------------------------------- ---------- ----------
1          name 1                                   01/01/2001 1
*/

-- 4.3 Для однієї з таблиць створити команду отримання значень всіх колонок (явно
-- перерахувати) за окремими рядками з урахуванням умови: символьне значення однієї з колонок
-- повинно містити в першому та третьому знакомісті якісь надані вами символи.
SELECT ClientID, ClientName, birthday as B_day, managerId
FROM Client 
WHERE clientName LIKE 'n_m%1'; 
/*
CLIENTID   CLIENTNAME                               B_DAY      MANAGERID
---------- ---------------------------------------- ---------- ----------
1          name 1                                   01/01/2001 1
*/

-- 4.4 У завданні 1.2 було додано колонку типу date. Створити команду отримання значень
-- всіх колонок (явно перерахувати) за окремими рядками з урахуванням умови: значення доданої
-- колонки містить невизначене значення.
SELECT managerId as id, managerName as name, birthday as b_day
FROM Manager
WHERE birthday IS NULL; 
/*
ID         NAME                                     B_DAY
---------- ---------------------------------------- ----------
1          manager name 1
2          manager name 2
3          manager name 3
*/

-- 4.5 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
-- рядками з урахуванням умови, що поєднує умови з рішень завдань 4.1 та 4.2
SELECT managerId as id, managerName as name, birthday as b_day
FROM Manager
WHERE managerId = '2' AND managerName = 'manager name 2';
/*
ID         NAME                                     B_DAY
---------- ---------------------------------------- ----------
2          manager name 2
*/

-- 4.6 Створити команду отримання значень всіх колонок (явно перерахувати) за окремими
-- рядками з урахуванням умови, що інвертує результат рішення 4.5
SELECT managerId as id, managerName as name, birthday as b_day
FROM Manager
WHERE managerId != '2' AND managerName != 'manager name 2';
/*
ID         NAME                                     B_DAY
---------- ---------------------------------------- ----------
1          manager name 1
3          manager name 3
4          manager name 4                           17/10/1989
*/