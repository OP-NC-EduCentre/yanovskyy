/*
2.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
2.3 з лабораторної роботи №5, але враховує опцію «WITH READ ONLY»: отримати інформацію
про атрибутні типи. Отримати вміст таблиці.
*/
CREATE OR REPLACE VIEW ATTRTYPE_LIST 
(OBJECT_CODE,ATTR_ID,ATTR_CODE,NAME)
AS
SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME
	FROM OBJTYPE O, ATTRTYPE A
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID
WITH READ ONLY;
SELECT * 
FROM ATTRTYPE_LIST;
/*
OBJECT_CODE           ATTR_ID ATTR_CODE            NAME
-------------------- -------- -------------------- ------------------------------
Manager                     1 managerId            persomal manager id
Manager                     2 managerName          name
Manager                    12 support              mng support client
Client                      3 clientId             personal client id
Client                      4 clientName           name
Client                      5 managerId            manager id
Client                      6 birthday             birthday
Client                     13 have                 clnt have bill
BILL                        7 billId               bill id
BILL                        8 clientId             client id
BILL                        9 packageId            package id
BILL                       10 billAmount           amount of bill
BILL                       11 billDate             date of bill

*/

/*
2.2 Виконати видалення одного рядка з віртуальної таблиці, створеної у попередньому
завданні. Прокоментувати реакцію СУБД.
*/
UPDATE ATTRTYPE_LIST 
SET ATTR_CODE = 'NEW ATTR CODE' 
WHERE ATTR_ID = '12'; 
/*
ERROR at line 2:
ORA-42399: cannot perform a DML operation on a read-only view
*/

/*
2.3 Створити віртуальну таблицю, що містить дві колонки:
назва класу, кількість екземплярів об'єктів класу. Отримати вміст таблиці.
*/
CREATE OR REPLACE VIEW ATTRTYPE_COUNTS
AS
    select OBJECT_CODE, COUNT(OBJECT_CODE) AS COUNT
FROM ATTRTYPE_LIST GROUP BY OBJECT_CODE;

SELECT * FROM ATTRTYPE_COUNTS; 



/*
OBJECT_CODE               COUNT
-------------------- ----------
BILL                          5
Client                        5
Manager                       3
*/

/*
2.4 Перевірити можливість виконання операції зміни даних у віртуальній таблиці,
створеної у попередньому завданні. Прокоментувати реакцію СУБД.
*/
UPDATE ATTRTYPE_COUNTS
SET ATTR_ID_C = '-1'
WHERE OBJCODE_C = '13';
/*
UPDATE ATTRTYPE_COUNTS
       *
ERROR at line 1:
ORA-01732: data manipulation operation not legal on this view
*/