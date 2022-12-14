ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';
/**
1.1. Для всіх таблиць нової БД створити генератори послідовності, щоб забезпечити
автоматичне створення нових значень колонок, які входять у первинний ключ. Врахувати наявність
рядків у таблицях. Виконати тестове внесення одного рядка до кожної таблиці.
**/
create sequence client_seq start with 3;
create sequence bill_seq start with 3;
create sequence manager_seq start with 5;
create sequence internetpackage_seq start with 6;
/* equence created. */

/*
1.2 Для всіх пар взаємопов'язаних таблиць створити транзакції, що включають дві INSERT-
команди внесення рядка в дві таблиці кожної пари з урахуванням зв'язку між PK-колонкою першої
таблиці і FK-колонкою 2-ї таблиці пари з використанням псевдоколонок NEXTVAL і CURRVAL.
*/
INSERT INTO client (clientid, clientname, managerid, birthday) values (client_seq.NEXTVAL, 'name3', '4', '10/10/2010');
INSERT INTO BILL (billid, clientid, packageid, billamount, billdate) VALUES (bill_seq.NEXTVAL, '1', '4', '199', '10/10/2022');
/*
1 row created.
1 row created.
*/

/*
1.3 Отримати інформацію про створені генератори послідовностей, використовуючи системну
таблицю СУБД Oracle.
*/
SELECT * FROM ALL_SEQUENCES WHERE SEQUENCE_NAME = 'MANAGER_SEQ';
SELECT * FROM ALL_SEQUENCES WHERE SEQUENCE_NAME = 'CLIENT_SEQ';
/*
SEQUENCE_OWNER
--------------------------------------------------------------------------------
SEQUENCE_NAME
--------------------------------------------------------------------------------
 MIN_VALUE  MAX_VALUE INCREMENT_BY C O CACHE_SIZE LAST_NUMBER S E S S K
---------- ---------- ------------ - - ---------- ----------- - - - - -
SYSTEM
MANAGER_SEQ
         1 1.0000E+28            1 N N         20           5 N N N N N


SEQUENCE_OWNER
--------------------------------------------------------------------------------
SEQUENCE_NAME
--------------------------------------------------------------------------------
 MIN_VALUE  MAX_VALUE INCREMENT_BY C O CACHE_SIZE LAST_NUMBER S E S S K
---------- ---------- ------------ - - ---------- ----------- - - - - -
SYSTEM
CLIENT_SEQ
         1 1.0000E+28            1 N N         20          23 N N N N N
*/

/*
1.4 Використовуючи СУБД Oracle >= 12 для однієї з таблиць створити генерацію унікальних
значень PK-колонки через DEFAULT-оператор. Виконати тестове внесення одного рядка до таблиці.
*/
ALTER TABLE TEST MODIFY (id NUMBER GENERATED BY DEFAULT AS IDENTITY START WITH 3);
/*
Table altered.
*/

INSERT INTO TEST (id, description) VALUES ('3', 'hello world');
/*
        ID DESCRIPTION
---------- --------------------
         3 hello world
*/