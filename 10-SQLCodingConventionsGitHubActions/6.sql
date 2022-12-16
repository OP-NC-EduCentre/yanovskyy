/*
2.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
2.3 з лабораторної роботи №5, але враховує опцію «WITH READ ONLY»: отримати інформацію
про атрибутні типи. Отримати вміст таблиці.
*/
/*
L001	1 / 37	
Unnecessary trailing whitespace.
L008	2 / 13	
Commas should be followed by a single whitespace unless followed by a comment.
L008	2 / 21	
Commas should be followed by a single whitespace unless followed by a comment.
L008	2 / 31	
Commas should be followed by a single whitespace unless followed by a comment.
L036	4 / 1	
Select targets should be on a new line unless there is only one select target.
L008	4 / 14	
Commas should be followed by a single whitespace unless followed by a comment.
L008	4 / 24	
Commas should be followed by a single whitespace unless followed by a comment.
L008	4 / 31	
Commas should be followed by a single whitespace unless followed by a comment.
L004	5 / 1	
Incorrect indentation type found in file.
L003	5 / 2	
Expected 0 indentations, found 1 [compared to line 04]
L011	5 / 15	
Implicit/explicit aliasing of table.
L031	5 / 15	
Avoid aliases in from clauses and join conditions.
L011	5 / 27	
Implicit/explicit aliasing of table.
L031	5 / 27	
Avoid aliases in from clauses and join conditions.
L004	6 / 1	
Incorrect indentation type found in file.
L003	6 / 2	
Expected 0 indentations, found 1 [compared to line 04]
L004	7 / 1	
Incorrect indentation type found in file.
L003	7 / 2	
Expected 0 indentations, found 1 [compared to line 04]
L008	7 / 27	
Commas should be followed by a single whitespace unless followed by a comment.
PRS	8 / 1	
Line 8, Position 1: Found unparsable section: 'WITH READ ONLY'
L044	9 / 1	
Query produces an unknown number of result columns.
L001	9 / 9	
Unnecessary trailing whitespace.
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
/*
L001	1 / 21	
Unnecessary trailing whitespace.
L001	2 / 32	
Unnecessary trailing whitespace.
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
/*
L003	3 / 5	
Expected 0 indentations, found 1 [compared to line 02]
L010	3 / 5	
Keywords must be consistently upper case.
L036	3 / 5	
Select targets should be on a new line unless there is only one select target.
L010	3 / 24	
Keywords must be consistently upper case.
L014	3 / 27	
Unquoted identifiers must be consistently upper case.
L029	3 / 27	
Keywords should not be used as identifiers.
L029	3 / 56	
Keywords should not be used as identifiers.
*/
CREATE OR REPLACE VIEW OBJECTS_COUNTS
AS
    select DESCRIPTION as Class, COUNT(DESCRIPTION) AS COUNT
FROM OBJECTS GROUP BY DESCRIPTION;

/*
L044	1 / 1	
Query produces an unknown number of result columns.
*/
SELECT * FROM OBJECTS_COUNTS; 

/*
CLASS                     COUNT
-------------------- ----------
Manager                       1
Client                        7
*/

/*
2.4 Перевірити можливість виконання операції зміни даних у віртуальній таблиці,
створеної у попередньому завданні. Прокоментувати реакцію СУБД.
*/
/*
No problems! Nice job friend.
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