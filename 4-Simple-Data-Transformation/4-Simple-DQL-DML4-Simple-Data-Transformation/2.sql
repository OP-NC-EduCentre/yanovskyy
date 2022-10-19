ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

/*
2.1 Для однієї з таблиць створити команду отримання символьних значень колонки з
переведенням першого символу у верхній регістр, інших у нижній. При виведенні на екран визначити
для вказаної колонки нову назву псевдоніму.
*/
SELECT INITCAP(clientname) as NAME FROM CLIENT;
/*
NAME
----------------------------------------
Name 1
Name 2
Name3
*/

/*
2.2. Модифікувати рішення попереднього завдання, створивши команду оновлення значення
вказаної колонки у таблиці.
*/

-- update 1 value in table
UPDATE CLIENT SET CLIENTNAME = (SELECT INITCAP(CLIENTNAME) 
                                    FROM CLIENT WHERE CLIENTNAME = 'name 1') 
    WHERE CLIENTNAME = 'name 1';
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY
---------- ---------------------------------------- ---------- ----------
1          Name 1                                   1          01/01/2001
2          name 2                                   2          02/02/2002
6          name3                                    4          10/10/2010
*/
-- OR update ALL values in table
UPDATE CLIENT SET CLiENTNAME = INITCAP(CLIENTNAME);
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY
---------- ---------------------------------------- ---------- ----------
1          Name 1                                   1          01/01/2001
2          Name 2                                   2          02/02/2002
6          Name3                                    4          10/10/2010
*/

/*
2.3 Для однієї з символьних колонок однієї з таблиць створити команду отримання
мінімальної, середньої та максимальної довжин рядків.
*/
SELECT MAX(STRLENGTH) AS MAX, MIN(STRLENGTH) AS MIN, AVG(STRLENGTH) AS AVG 
    FROM (SELECT LENGTH(CLIENTNAME) AS STRLENGTH FROM CLIENT);
/*
       MAX        MIN        AVG
---------- ---------- ----------
        11          1        5.5
*/

/*
2.4 Для колонки типу date однієї з таблиць отримати кількість днів, тижнів та місяців, що
пройшли до сьогодні.
*/
-- days 
SELECT (SYSDATE - (SELECT BILLDATE FROM BILL WHERE BILLID = '10')) AS DAYS FROM DUAL;
/*
      DAYS
----------
597.887801
*/
-- weeks 
SELECT (SYSDATE - (SELECT BILLDATE FROM BILL WHERE BILLID = '10'))/7 AS WEEKS FROM DUAL;
/*
     WEEKS
----------
85.4126769
*/
-- month
SELECT MONTHS_BETWEEN (SYSDATE, (SELECT BILLDATE FROM BILL WHERE BILLID = '10')) AS MONTHS FROM DUAL;
/*
    MONTHS
----------
19.6093201
*/