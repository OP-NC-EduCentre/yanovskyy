/*
1. Багатотабличне внесення даних
Створіть один схожий запит, виконавши одночасне внесення до двох таблиць вашої БД.
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';
INSERT ALL 
    INTO CLIENT (CLIENTID, CLIENTNAME, MANAGERID, BIRTHDAY)
        VALUES (11, 'Georgiy Chifchan', 8, '1/1/2000')
    INTO BILL (BILLID, CLIENTID, PACKAGEID, BILLAMOUNT, BILLDATE)
        VALUES (11, 7, 1, 199, '3/11/2022')
SELECT A.CLIENTNAME, B.BILLDATE, B.BILLAMOUNT 
FROM CLIENT A, BILL B 
WHERE A.CLIENTID = B.CLIENTID; 
/*
CLIENTNAME                               BILLDATE   BILLAMOUNT
---------------------------------------- ---------- ----------
Name 1                                   02/10/2022        199
Name 2                                   02/11/2022        299
Name 1                                   10/10/2022        199
Name 2                                   10/10/2022        199
L                                        10/10/2022        199
Liam Nisson                              10/10/2022        199
L                                        10/10/2022        199
Name3                                    10/10/2022        199
Name 1                                   01/03/2023        199
Name 1                                   01/03/2021        199
*/

/*
2. Використання багатостовпцевих підзапитів при зміні даних
Створіть один схожий запит на зміну двох колонок однієї таблиці вашої БД,
використовуючи багатостовпцевий підзапит.
*/
UPDATE CLIENT
SET (CLIENTNAME, BIRTHDAY) = 
                        (SELECT CLIENTNAME, BIRTHDAY 
                            FROM CLIENT
                            WHERE CLIENTID = '4')
WHERE CLIENTNAME = 'L'; 
/*
BEFORE: 
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY
---------- -------------------- ---------- ---------
1          Name 1               1          01-JAN-01
2          Name 2               2          02-FEB-02
6          Name3                4          10-OCT-10
3          L                    5          01-JAN-01
4          Liam Nisson          6          01-JAN-01
5          Liam Nisson          7          01-JAN-01
AFTER: 
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY
---------- -------------------- ---------- ---------
1          Name 1               1          01-JAN-01
2          Name 2               2          02-FEB-02
6          Name3                4          10-OCT-10
3          Liam Nisson          5          01-JAN-01
4          Liam Nisson          6          01-JAN-01
5          Liam Nisson          7          01-JAN-01
*/

/*
3. Видалення рядків із використанням кореляційних підзапитів.
Створіть один схожий запит на видалення рядків таблиці за допомогою EXISTS або
NOT EXISTS.
*/
DELETE FROM (
    SELECT * FROM CLIENT 
    WHERE CLIENTNAME = (
        SELECT CLIENTNAME FROM CLIENT WHERE CLIENTNAME LIKE '%Name 1%'
    )
);
/*
BEFORE: 
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY
---------- -------------------- ---------- ---------
1          Name 1               1          01-JAN-01
2          Name 2               2          02-FEB-02
6          Name3                4          10-OCT-10
3          Liam Nisson          5          01-JAN-01
4          Liam Nisson          6          01-JAN-01
5          Liam Nisson          7          01-JAN-01
AFTER: 
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY
---------- -------------------- ---------- ---------
2          Name 2               2          02-FEB-02
6          Name3                4          10-OCT-10
3          Liam Nisson          5          01-JAN-01
4          Liam Nisson          6          01-JAN-01
5          Liam Nisson          7          01-JAN-01
*/


/*
4. Поєднаний INSERT/UPDATE запит – оператор MERGE
Створіть один схожий запит на видалення, використовуючи одну або дві таблиці вашої
бази даних.
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

CREATE TABLE CLIENT_INTERM AS SELECT * FROM CLIENT;
UPDATE CLIENT SET BIRTHDAY = '01/01/2001';

MERGE INTO CLIENT C 
    USING CLIENT_INTERM CI
        ON (C.CLIENTID = CI.CLIENTID)
    WHEN MATCHED THEN
        UPDATE SET C.BIRTHDAY = CI.BIRTHDAY
    WHEN NOT MATCHED THEN 
        INSERT (CLIENTID, CLIENTNAME, MANAGERID, BIRTHDAY)
        VALUES (CI.CLIENTID, CI.CLIENTNAME, CI.MANAGERID, CI.BIRTHDAY);

/*
CLIENT AFTER CHANGING AND DELETING SOMETHING 
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY
---------- -------------------- ---------- ----------
1          Name 1               1          01/01/2001
2          Name 2               2          01/01/2001
6          Name3                4          01/01/2001
3          L                    5          01/01/2001
4          Liam Nisson          6          01/01/2001
5          Liam Nisson          7          01/01/2001

AFTER MERGE: 
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY
---------- -------------------- ---------- ----------
1          Name 1               1          01/01/2001
2          Name 2               2          02/02/2002
6          Name3                4          10/10/2010
3          L                    5          01/01/2001
4          Liam Nisson          6          01/01/2001
5          Liam Nisson          7          01/01/2001
*/

