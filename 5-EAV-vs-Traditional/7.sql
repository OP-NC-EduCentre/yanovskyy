/*
7.1 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
рішення завдання № 4.2 лабораторної роботи № 3:
Для однієї з таблиць створити команду отримання значень всіх колонок (явно перерахувати) за
окремими рядками з урахуванням умови: символьне значення однієї з колонок має співпадати з якимось
константним значенням.
*/
SELECT ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME
	FROM ATTRTYPE
    WHERE CODE = 'clientId'; 

/*
 ATTR_ID OBJECT_TYPE_ID OBJECT_TYPE_ID_REF CODE       NAME
-------- -------------- ------------------ ---------- --------------------
       3              2                    clientId   personal client id
       8              3                    clientId   client id
*/

/*
7.2 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
рішення завдання № 6.1 лабораторної роботи № 3:
Для однієї з таблиць створити команду отримання кількості рядків таблиці.
*/
SELECT COUNT(ATTR_ID) AS COUNT 
    FROM ATTRTYPE; 
/*
     COUNT
----------
        13
*/

/*
7.3 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
рішення завдання № 3.2 лабораторної роботи № 4:
Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду отримання двох
колонок першої та другої таблиць з використанням екві-з’єднання таблиць. Використовувати префікси.
*/
SELECT ATTRTYPE.CODE, OBJTYPE.OBJECT_TYPE_ID, OBJTYPE.NAME 
    FROM OBJTYPE RIGHT JOIN ATTRTYPE
    ON ATTRTYPE.OBJECT_TYPE_ID_REF = OBJTYPE.OBJECT_TYPE_ID;
/*
CODE       OBJECT_TYPE_ID NAME
---------- -------------- --------------------
managerId
managerNam
e

clientId
clientName
managerId
birthday
billId
clientId
packageId
billAmount
billDate
support                 2 Кл?єнт
have                    3 Рахунок

13 rows selected.
*/
