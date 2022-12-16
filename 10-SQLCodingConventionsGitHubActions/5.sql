/*
7.1 Виконати запит до БД, результат якого відповідає результату виконання запиту на підставі
рішення завдання № 4.2 лабораторної роботи № 3:
Для однієї з таблиць створити команду отримання значень всіх колонок (явно перерахувати) за
окремими рядками з урахуванням умови: символьне значення однієї з колонок має співпадати з якимось
константним значенням.
*/
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L008	1 / 15	
Commas should be followed by a single whitespace unless followed by a comment.
L008	1 / 30	
Commas should be followed by a single whitespace unless followed by a comment.
L008	1 / 49	
Commas should be followed by a single whitespace unless followed by a comment.
L008	1 / 54	
Commas should be followed by a single whitespace unless followed by a comment.
L004	2 / 1	
Incorrect indentation type found in file.
L003	2 / 2	
Expected 0 indentations, found 1 [compared to line 01]
L003	3 / 5	
Expected 0 indentations, found 1 [compared to line 01]
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
/*
L029	1 / 26	
Keywords should not be used as identifiers.
L001	1 / 31	
Unnecessary trailing whitespace.
L003	2 / 5	
Expected 0 indentations, found 1 [compared to line 01]
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
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L001	1 / 59	
Unnecessary trailing whitespace.
L003	2 / 5	
Expected 0 indentations, found 1 [compared to line 01]
L055	2 / 18	
Use 'LEFT JOIN' instead of 'RIGHT JOIN'.
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
