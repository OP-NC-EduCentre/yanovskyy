/*
1.1 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
4.2 з лабораторної роботи №3: для однієї з таблиць створити команду отримання значень усіх
колонок (явно перерахувати) за окремими рядками з урахуванням умови, в якій рядкове
значення однієї з колонок має співпадати з якимось константним значенням. Отримати вміст
таблиці.
*/
CREATE OR REPLACE VIEW CLIENT_LIST
AS 
    SELECT ClientID, ClientName, birthday as B_day, managerId
    FROM Client 
    WHERE CLIENTNAME LIKE '%Liam%'; 
SELECT * FROM CLIENT_LIST; 
/*
CLIENTID   CLIENTNAME                               B_DAY     MANAGERID
---------- ---------------------------------------- --------- ----------
4          Liam                                     01-JAN-01 6
5          Liam Nisson                              01-JAN-01 7
*/

/*
1.2 Виконати команду зміни значення колонки створеної віртуальної таблиці на
значення, яка входить в умову вибірки рядків із рішення попереднього завдання, при цьому нове
значення має відрізнятись від поточного.
*/
UPDATE CLIENT_LIST SET CLIENTNAME = (SELECT CLIENTNAME AS NAME FROM CLIENT_LIST 
    WHERE CLIENTID = '5')
WHERE CLIENTNAME = 'Liam'; 
SELECT * FROM CLIENT_LIST; 
/*
CLIENTID   CLIENTNAME                               B_DAY     MANAGERID
---------- ---------------------------------------- --------- ----------
4          Liam Nisson                              01-JAN-01 6
5          Liam Nisson                              01-JAN-01 7
*/

/*
1.3 Створити віртуальну таблицю, структура та вміст якої відповідає рішенню завдання
3.2 з лабораторної роботи №4: для двох таблиць, пов'язаних через PK-колонку та FK-колонку,
створити команду отримання двох колонок першої та другої таблиць з використанням екві-
сполучення таблиць. Отримати вміст таблиці.
*/
CREATE OR REPLACE VIEW NEW_VIEW 
AS 
    SELECT billamount, billdate, clientname 
    FROM CLIENT 
    RIGHT JOIN BILL ON CLIENT.clientid = BILL.clientid;

SELECT * FROM NEW_VIEW; 
/*
BILLAMOUNT BILLDATE  CLIENTNAME
---------- --------- ----------------------------------------
       199 02-OCT-22 Name 1
       199 10-OCT-22 Name 1
       199 01-MAR-23 Name 1
       199 01-MAR-21 Name 1
       299 02-NOV-22 Name 2
       199 10-OCT-22 Name 2
       199 10-OCT-22 Name3
       199 10-OCT-22 L
       199 10-OCT-22 L
       199 10-OCT-22 Liam Nisson
*/

/*
1.4 Виконати команду додавання нового рядка до однієї з таблиць, що входить до запиту
з попереднього завдання.
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

INSERT INTO NEW_VIEW (BILLAMOUNT, BILLDATE, CLIENTNAME) 
VALUES ('399', '10/10/10', 'new name'); 
/*

*/