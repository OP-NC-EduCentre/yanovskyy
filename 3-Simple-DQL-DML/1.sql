ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

-- 1.1 Для кожної таблиці БД створити команди внесення даних, тобто внести по два рядки.
INSERT INTO MANAGER (managerId, managerName) 
    VALUES ('1', 'manager name 1'); 
INSERT INTO MANAGER (managerId, managerName) 
    VALUES ('2', 'manager name 2'); 

INSERT INTO Client (clientId, clientName, birthday, managerId)
    VALUES ('1', 'name 1', '1/1/2001', '1');
INSERT INTO Client (clientId, clientName, birthday, managerId)
    VALUES ('2', 'name 2', '2/2/2002', '2');

INSERT INTO InternetPackage (packageId, packageTitle, pricePerMonth)
    VALUES ('1', 'standart', 199); 
INSERT INTO InternetPackage (packageId, packageTitle, pricePerMonth)
    VALUES ('2', 'pro', 299); 

INSERT INTO Bill (billId, clientId, packageId, billAmount,billDate) 
    VALUES ('1', '1', '1', 199,'2/10/2022');
INSERT INTO Bill (billId, clientId, packageId, billAmount,billDate) 
    VALUES ('2', '2', '2', 299,'2/11/2022');

-- 1.2 Для однієї з таблиць створити команду додавання колонки типу date з урахуванням
-- предметної області.
ALTER TABLE Manager ADD birthday DATE; 

-- 1.3 Для зазначеної таблиці створити команду на внесення одного рядка, але з невизначеним
-- значенням колонки типу date
INSERT INTO Manager (managerId, managerName) 
    VALUES ('3', 'manager name 3'); 

-- 1.4 Створити команду налаштування формату date = dd/mm/yyyy.
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

-- 1.5 Для задіяної в завданні 1.2 таблиці створити ще одну команду на внесення одного рядка
-- з урахуванням значення колонки типу date
INSERT INTO Manager (managerId, managerName, birthday) 
    VALUES ('4', 'manager name 4', '17/10/1989'); 

-- 1.6 Для однієї з таблиць, що містить обмеження цілісності потенційного ключа, виконати
-- команду додавання нового рядка зі значенням колонки, що порушує це обмеження. Перевірити
-- sреакцію СКБД на таку зміну.
INSERT INTO Client (clientId, clientName, birthday, managerId)
    VALUES ('5', 'name 5', '1/1/2001', '1');
/*
ERROR at line 1:
ORA-00001: unique constraint (SYSTEM.CLIENT_MANAGERID_UNIQUE) violated
*/

-- 1.7 Для однієї з таблиць, що містить обмеження цілісності зовнішнього ключа, виконати
-- команду додавання нового рядка зі значенням колонки зовнішнього ключа, який відсутній у
-- колонці первинного ключа відповідної таблиці. Перевірити реакцію СКБД на подібне додавання,
-- яке порушує обмеження цілісності зовнішнього ключа.
INSERT INTO Client (clientId, clientName, birthday, managerId)
    VALUES ('5', 'name 5', '1/1/2001', '5');
-- ERROR at line 1:
-- ORA-02291: integrity constraint (SYSTEM.CLIENT_MANAGER_FK) violated - parent
-- key not found