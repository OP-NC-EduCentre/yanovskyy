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
    SUM(BILLAMOUNT) AS TOTALPAYED
FROM
    BILL
GROUP BY
    CLIENTID;
/*
CLIENTID   TOTALPAYED
---------- ----------
1                 549
2                 598
3                 698
4                 398
5                 597
6                 199
7                1194
8                 250

8 rows selected.
*/


/*
3. Виконайте попереднє завдання, отримавши накопичувальні підсумки в кожній
підгрупі окремо.
*/
SELECT
    DISTINCT CLIENTID,
    SUM(BILLAMOUNT) OVER (
    PARTITION BY CLIENTID) AS TOTALPAYED
FROM
    BILL
ORDER BY
    TOTALPAYED DESC;
/*
CLIENTID   TOTALPAYED
---------- ----------
7                1194
3                 698
2                 598
5                 597
1                 549
4                 398
8                 250
6                 199

8 rows selected.
*/

