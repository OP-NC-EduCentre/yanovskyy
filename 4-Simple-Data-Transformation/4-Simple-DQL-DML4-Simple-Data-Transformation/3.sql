
/*
3.1 Для будь-яких двох таблиць створити команду отримання декартового добутку
*/
SELECT CLIENTNAME, PACKAGETITLE FROM CLIENT CROSS JOIN INTERNETPACKAGE;
/*

CLIENTNAME                               PACKAGETITLE
---------------------------------------- --------------------
Name 1                                   standart
Name 1                                   pro
Name 1                                   ultra
Name 1                                   unlim
Name 1                                   unlim+
Name 2                                   standart
Name 2                                   pro
Name 2                                   ultra
Name 2                                   unlim
Name 2                                   unlim+
Name3                                    standart

CLIENTNAME                               PACKAGETITLE
---------------------------------------- --------------------
Name3                                    pro
Name3                                    ultra
Name3                                    unlim
Name3                                    unlim+
L                                        standart
L                                        pro
L                                        ultra
L                                        unlim
L                                        unlim+
Liam                                     standart
Liam                                     pro

CLIENTNAME                               PACKAGETITLE
---------------------------------------- --------------------
Liam                                     ultra
Liam                                     unlim
Liam                                     unlim+
Liam Nisson                              standart
Liam Nisson                              pro
Liam Nisson                              ultra
Liam Nisson                              unlim
Liam Nisson                              unlim+
*/

/*
3.2 Для двох таблиць, пов'язаних через PK-колонку та FK-колонку, створити команду
отримання двох колонок першої та другої таблиць з використанням екві-з’єднання таблиць.
Використовувати префікси.
*/
SELECT billamount, billdate, clientname FROM CLIENT RIGHT JOIN BILL ON CLIENT.clientid = BILL.clientid;
/*
BILLAMOUNT BILLDATE  CLIENTNAME
---------- --------- ----------------------------------------
       199 02-OCT-22 Name 1
       199 10-OCT-22 Name 1
       299 02-NOV-22 Name 2
*/

/*
3.3 Повторити рішення попереднього завдання, застосувавши автоматичне визначення умов
екві-з’єднання.
*/
SELECT b.billamount, b.billdate, c.clientname 
    FROM BILL b, CLIENT c;
/*
BILLAMOUNT BILLDATE  CLIENTNAME
---------- --------- ----------------------------------------
       199 02-OCT-22 Name 1
       199 02-OCT-22 Name 2
       199 02-OCT-22 Name3
       199 02-OCT-22 L
       199 02-OCT-22 Liam
       199 02-OCT-22 Liam Nisson
       299 02-NOV-22 Name 1
       299 02-NOV-22 Name 2
       299 02-NOV-22 Name3
       299 02-NOV-22 L
       299 02-NOV-22 Liam

BILLAMOUNT BILLDATE  CLIENTNAME
---------- --------- ----------------------------------------
       299 02-NOV-22 Liam Nisson
       199 10-OCT-22 Name 1
       199 10-OCT-22 Name 2
       199 10-OCT-22 Name3
       199 10-OCT-22 L
       199 10-OCT-22 Liam
       199 10-OCT-22 Liam Nisson
*/

/*
3.4 Повторити рішення завдання 3.2, замінивши еквіз'єднання на зовнішнє з'єднання
(лівостороннє або правостороннє), яке дозволить побачити рядки таблиці з PK-колонкою, не пов'язані
з FK-колонкою.
*/
SELECT billamount, billdate, clientname FROM BILL LEFT JOIN CLIENT ON BILL.CLIENTID = CLIENT.CLIENTID;
/*
BILLAMOUNT BILLDATE  CLIENTNAME
---------- --------- ----------------------------------------
       199 02-OCT-22 Name 1
       199 10-OCT-22 Name 1
       299 02-NOV-22 Name 2
*/