/*
3.1 Створити нового користувача, ім'я якого = «ваше_прізвище_латиницею»+'EAV',
наприклад, blazhko_eav, з правами, достатніми для створення та заповнення таблиць БД EAV.
*/
CREATE USER YANOVSKIY_EAV IDENTIFIED BY p1234;
GRANT CONNECT TO YANOVSKIY_EAV;
/*
SQL> CREATE USER YANOVSKIY_EAV IDENTIFIED BY p1234;
User created.

SQL> GRANT CONNECT TO YANOVSKIY_EAV;
Grant succeeded.
*/

/*
3.2 Створити таблиці БД EAV та заповнити таблиці об'єктних типів та атрибутних типів,
взявши рішення з лабораторної роботи №5.
*/
CREATE OR REPLACE VIEW  OBJTYPE_EAV
(OBJECT_TYPE_ID, PARENT_ID,CODE,NAME,DESCRIPTION)
AS SELECT OBJECT_TYPE_ID, PARENT_ID,CODE,NAME,DESCRIPTION FROM OBJTYPE; 
SELECT OBJECT_TYPE_ID, PARENT_ID,CODE,DESCRIPTION FROM OBJTYPE_EAV;

CREATE OR REPLACE VIEW ATTRTYPE_EAV
(ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
AS SELECT ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME FROM ATTRTYPE; 
SELECT ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME FROM ATTRTYPE_EAV;
/*
OBJECT_TYPE_ID PARENT_ID CODE       DESCRIPTION
-------------- --------- ---------- --------------------
             1           Manager
             2           Client
             3           BILL

 ATTR_ID OBJECT_TYPE_ID OBJECT_TYPE_ID_REF CODE                 NAME
-------- -------------- ------------------ -------------------- --------------------
       1              1                    managerId            persomal manager id
       2              1                    managerName          name
       3              2                    clientId             personal client id
       4              2                    clientName           name
       5              2                    managerId            manager id
       6              2                    birthday             birthday
       7              3                    billId               bill id
       8              3                    clientId             client id
       9              3                    packageId            package id
      10              3                    billAmount           amount of bill
      11              3                    billDate             date of bill

 ATTR_ID OBJECT_TYPE_ID OBJECT_TYPE_ID_REF CODE                 NAME
-------- -------------- ------------------ -------------------- --------------------
      12              1                  2 support              mng support client
      13              2                  3 have                 clnt have bill
*/

/*
3.3 Створити генератор послідовності таблиці OBJECTS БД EAV, ініціалізувавши його
початковим значенням з урахуванням вже заповнених значень.
*/
SELECT MAX(OBJECT_TYPE_ID) FROM OBJTYPE_EAV; -- 3
CREATE SEQUENCE OBJECT_OBJECT_ID START WITH 4;
/*
Sequence created.
*/

/*
3.4 Налаштувати права доступу нового користувача до таблиць схеми даних із таблицями
реляційної БД вашої предметної області, створеної в лабораторній роботі №2.
*/
GRANT SELECT ON CLIENT TO YANOVSKIY_EAV;
GRANT SELECT ON MANAGER TO YANOVSKIY_EAV;
GRANT SELECT ON BILL TO YANOVSKIY_EAV;
GRANT SELECT ON INTERNETPACKAGE TO YANOVSKIY_EAV;

/*
Grant succeeded.
Grant succeeded.
Grant succeeded.
Grant succeeded.
*/

/*
3.5 Створити множину запитів типу INSERT INTO … SELECT, які автоматично заповнять
таблицю OBJECTS, взявши потрібні дані з реляційної бази даних вашої предметної області.
*/
CREATE SEQUENCE OBJECTS_SEQ START WITH 4;
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
VALUES (OBJECTS_SEQ.NEXTVAL, 1, 2, (SELECT CLIENTNAME FROM CLIENT WHERE CLIENTID = '1'), 'Client'); 

INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
VALUES (OBJECTS_SEQ.NEXTVAL, 1, 2, (SELECT CLIENTNAME FROM CLIENT WHERE CLIENTID = '2'), 'Client'); 
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
VALUES (OBJECTS_SEQ.NEXTVAL, 1, 2, (SELECT CLIENTNAME FROM CLIENT WHERE CLIENTID = '3'), 'Client'); 
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION) 
VALUES (OBJECTS_SEQ.NEXTVAL, 1, 2, (SELECT CLIENTNAME FROM CLIENT WHERE CLIENTID = '4'), 'Client'); 
/*
 OBJECT_ID  PARENT_ID OBJECT_TYPE_ID NAME                                DESCRIPTION
---------- ---------- -------------- ----------------------------------- -------------------------
         1                         1 Ivanov Ivan Ivanovich               Manager
         2          1              2 Stepan Bendera                      Client
         3          1              2 Taras Grugorocich Shevchenko        Client
         4          1              2 Artemenko Artem Artemovich          Client
         7          1              2 Name 1                              Client
         8          1              2 Name 2                              Client
         9          1              2 L                                   Client
        10          1              2 Liam Nisson                         Client
*/