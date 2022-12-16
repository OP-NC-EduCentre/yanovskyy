/*
1. Виконання простих однорядкових підзапитів із екві-з'єднанням або тета-
з'єднанням.
Створіть схожий запит, використовуючи одну або дві таблиці вашої бази даних.
*/
/*
L001	1 / 18	
Unnecessary trailing whitespace.
L001	2 / 12	
Unnecessary trailing whitespace.
L007	3 / 16	
Operators near newlines should be after, not before the newline
L001	3 / 17	
Unnecessary trailing whitespace.
L003	4 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L003	5 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L003	6 / 17	
Expected 0 indentations, found 4 [compared to line 03]
*/
SELECT CLIENTNAME 
FROM CLIENT 
WHERE CLIENTID = 
                (
                SELECT CLIENTID FROM BILL WHERE BILLAMOUNT = 299
                );

/*
CLIENTNAME
-------------
Name 2
*/

/*
2. Використання агрегатних функцій у підзапитах.
Створіть схожий запит, використовуючи одну або дві таблиці вашої бази даних.
*/
/*
L001	1 / 20	
Unnecessary trailing whitespace.
L001	2 / 21	
Unnecessary trailing whitespace.
L007	3 / 17	
Operators near newlines should be after, not before the newline
L001	3 / 18	
Unnecessary trailing whitespace.
L003	4 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L003	5 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L001	5 / 33	
Unnecessary trailing whitespace.
L003	6 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L001	6 / 26	
Unnecessary trailing whitespace.
L003	7 / 21	
Expected 0 indentations, found 5 [compared to line 03]
L003	8 / 17	
Expected 0 indentations, found 4 [compared to line 03]
*/
SELECT PACKAGETITLE 
FROM INTERNETPACKAGE 
WHERE PACKAGEID = 
                (
                SELECT PACKAGEID 
                FROM BILL 
                    WHERE BILLAMOUNT = (SELECT MAX(BILLAMOUNT) FROM BILL)
                );
/*
PACKAGETITLE
--------------------
pro
*/

/*
3 Пропозиція HAVING із підзапитами.
Створіть схожий запит, використовуючи одну або дві таблиці вашої бази даних.
*/
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L013	1 / 16	
Column expression without alias. Use explicit `AS` clause.
L001	1 / 31	
Unnecessary trailing whitespace.
L001	3 / 16	
Unnecessary trailing whitespace.
*/
SELECT BILLID, AVG(BILLAMOUNT) 
FROM BILL
GROUP BY BILLID 
HAVING AVG(BILLAMOUNT) < (SELECT AVG(BILLAMOUNT) FROM BILL);
/*
BILLID     AVG(BILLAMOUNT)
---------- ---------------
1                      199
10                     199
3                      199
4                      199
5                      199
6                      199
7                      199
8                      199
9                      199
9 rows selected.
*/

/*
4 Виконання багаторядкових підзапитів
Створіть схожий запит, використовуючи одну або дві таблиці вашої бази даних.
*/
/*
L001	1 / 20	
Unnecessary trailing whitespace.
L001	2 / 21	
Unnecessary trailing whitespace.
L001	3 / 22	
Unnecessary trailing whitespace.
L017	3 / 22	
Function name not immediately followed by parenthesis.
L003	4 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L003	5 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L001	5 / 42	
Unnecessary trailing whitespace.
L003	6 / 17	
Expected 0 indentations, found 4 [compared to line 03]
L001	6 / 26	
Unnecessary trailing whitespace.
L003	7 / 21	
Expected 0 indentations, found 5 [compared to line 03]
L016	7 / 85	
Line is too long.
L003	8 / 17	
Expected 0 indentations, found 4 [compared to line 03]

*/
SELECT PACKAGETITLE 
FROM INTERNETPACKAGE 
WHERE PACKAGEID < ANY 
                (
                SELECT AVG(PRICEPERMONTH) 
                FROM BILL 
                    WHERE BILLAMOUNT = (SELECT MAX(BILLAMOUNT) FROM INTERNETPACKAGE)
                );
/*
PACKAGETITLE
--------------------
standart
pro
ultra
unlim
unlim+
*/

/*
5. Використання оператора WITH для структуризації запиту
Створіть схожий запит, використовуючи одну або дві таблиці вашої бази даних.
*/
/*
L036	2 / 5	
Select targets should be on a new line unless there is only one select target.
L010	2 / 36	
Keywords must be consistently upper case.
L001	2 / 77	
Unnecessary trailing whitespace.
L022	4 / 1	
Blank line expected but not found after CTE closing bracket.
L036	4 / 1	
Select targets should be on a new line unless there is only one select target.
L011	5 / 13	
Implicit/explicit aliasing of table.
L031	5 / 13	
Avoid aliases in from clauses and join conditions.
L011	5 / 21	
Implicit/explicit aliasing of table.
L031	5 / 21	
Avoid aliases in from clauses and join conditions.
L011	5 / 40	
Implicit/explicit aliasing of table.
L031	5 / 40	
Avoid aliases in from clauses and join conditions.
L011	5 / 58	
Implicit/explicit aliasing of table.
L031	5 / 58	
Avoid aliases in from clauses and join conditions.
L001	6 / 29	
Unnecessary trailing whitespace.
L003	7 / 1	
Expected 1 indentation, found 0 [compared to line 06]
*/
WITH BILLAMOUNT_AVG AS (
    SELECT BILLID, AVG(BILLAMOUNT) as AVG_B_AMOUNT FROM BILL GROUP BY BILLID 
)
SELECT C.CLIENTNAME, B.BILLAMOUNT, B.BILLDATE, I.PACKAGETITLE
FROM CLIENT C, BILL B, INTERNETPACKAGE I, BILLAMOUNT_AVG BI
WHERE BI.BILLID = C.CLIENTID 
AND B.BILLAMOUNT > BI.AVG_B_AMOUNT; 
/*
Name 1                      299 02-NOV-22 standart
Name3                       299 02-NOV-22 unlim+
Name 1                      299 02-NOV-22 pro
Name3                       299 02-NOV-22 unlim
Name3                       299 02-NOV-22 standart
L                           299 02-NOV-22 unlim
L                           299 02-NOV-22 unlim+
Liam Nisson                 299 02-NOV-22 unlim
*/

/*
6. Використання кореляційних підзапитів
Вибрати пакети які були хлчаб 1 раз оплачені користучавачи, тобто ними придбані
*/
/*
L001	1 / 26	
Unnecessary trailing whitespace.
L011	2 / 22	
Implicit/explicit aliasing of table.
L031	2 / 22	
Avoid aliases in from clauses and join conditions.
L001	4 / 20	
Unnecessary trailing whitespace.
L011	5 / 15	
Implicit/explicit aliasing of table.
L031	5 / 15	
Avoid aliases in from clauses and join conditions.
L001	5 / 16	
Unnecessary trailing whitespace.
*/
SELECT I_PAC.PACKAGETITLE 
FROM INTERNETPACKAGE I_PAC
WHERE EXISTS (
    SELECT B.BILLID 
    FROM BILL B 
    WHERE B.PACKAGEID = I_PAC.PACKAGEID
    );

/*
PACKAGETITLE
--------------------
unlim
pro
standart
*/