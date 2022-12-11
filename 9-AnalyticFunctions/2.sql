/*
1. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає накопичувальні підсумки другої колонки від початку
вікна до поточного рядка.
*/
select distinct clientid, sum(billamount) 
    over (order by clientid 
            ROWS 
                BETWEEN UNBOUNDED PRECEDING 
                AND UNBOUNDED FOLLOWING) as sum
from bill;
/*
CLIENTID          SUM
---------- ----------
1                3039
2                3039
3                3039
4                3039
5                3039
6                3039
7                3039
*/


/*
2. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає накопичувальні підсумки другої колонки
попереднього та поточного рядка (ковзаюче вікно розміром 2 рядки).
*/
select distinct clientid, sum(billamount)
    over (order by clientid 
            ROWS 
                BETWEEN 2 PRECEDING 
				AND CURRENT ROW) as sum 
from bill;
/*
CLIENTID          SUM
---------- ----------
1                 299
1                 549
2                 848
3                 947
3                 997
4                 897
4                 747
5                 597
6                 597
7                 597
*/


/*
3. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення.
Створіть запит, який отримає:

накопичувальні підсумки другої колонки від початку вікна до поточного
рядка для кожного вікна цілком

накопичувальний результат порядково (для демонстрації відмінностей
роботи типу RANG від ROWS).
*/
select distinct clientid, 
    sum(billamount) 
        over (order by clientid 
            ROWS 
                BETWEEN UNBOUNDED PRECEDING 
                AND UNBOUNDED FOLLOWING) as sum1, 
    sum(billamount) 
        over (order by clientid 
            RANGE 
                BETWEEN 2 PRECEDING 
                AND CURRENT ROW) as sumByRange
from bill;
/*

*/
