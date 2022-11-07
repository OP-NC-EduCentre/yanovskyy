/*
1. Виконання простих однорядкових підзапитів із екві-з'єднанням або тета-
з'єднанням.
Створіть схожий запит, використовуючи одну або дві таблиці вашої бази даних.
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