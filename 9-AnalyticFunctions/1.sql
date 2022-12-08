/*
1. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає усереднені (avg) значення другої колонки кожного рядка в кожній підгрупі.
*/
SELECT
    DISTINCT CLIENTID,
    AVG(BILLAMOUNT) OVER (
    PARTITION BY CLIENTID) AS AVERAGE
FROM
    BILL;
/*
CLIENTID      AVERAGE
---------- ----------
1               274.5
2                 299
3                 349
4                 199
5                 199
6                 199
7                 199
8                 250

8 rows selected.
*/


/*
2. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає накопичувальні підсумки другої колонки.
*/
SELECT 
    CLIENTID,
    SUM(BILLAMOUNT) OVER (
        PARTITION BY CLIENTID
        ORDER BY BILLDATE
    ) AS PAYED
FROM BILL; 
/*
CLIENTID        PAYED
---------- ----------
1                 250
1                 549
2                 299
2                 598
3                 349
3                 698
4                 199
4                 398
5                 398
5                 398
5                 597
6                 199
7                 199
7                 398
7                 796
7                 796
7                 995
7                1194
8                 250

19 rows selected.
*/


/*
3. Виконайте попереднє завдання, отримавши накопичувальні підсумки в кожній
підгрупі окремо.
*/
WITH SUM_LIST AS (
    SELECT 
    CLIENTID,
    SUM(BILLAMOUNT) OVER (
        PARTITION BY CLIENTID
        ORDER BY BILLDATE
    ) AS PAYED
FROM BILL
)
SELECT 
    DISTINCT 
    CLIENTID, 
    SUM(PAYED) OVER (ORDER BY CLIENTID) AS TOTAL_BY_CLIENT
FROM SUM_LIST; 
/*
CLIENTID   TOTAL_BY_CLIENT
---------- ---------------
1                      799
2                     1696
3                     2743
4                     3340
5                     4733
6                     4932
7                     9310
8                     9560

8 rows selected.
*/

