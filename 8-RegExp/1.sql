/*
1. Одна з колонок таблиць повинна містити строкове значення з трьома різними буквами у
першій позиції. Створіть запит, який отримає три рядки таблиці з урахуванням трьох букв,
використовуючи оператор LIKE.
*/
SELECT * FROM CLIENT 
WHERE 
CLIENTNAME LIKE 'Lia%'
OR CLIENTNAME LIKE 'Nis%' 
OR CLIENTNAME LIKE 'Sno%';

/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY   CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- --------- ---------- ------------------------------ ----------------------------------------
4          Nisson Liam                              6          01-JAN-01
5          Liam Nisson                              7          01-JAN-01            +38(077)777-77-77
555        Snow Snow Ho                             8          01-JAN-78         45 +38(077)777-77-77              testUsetLogin@eml.com.ua
*/

/*
2. Повторіть завдання 1, використовуючи регулярні вирази з альтернативними варіантами.
*/

SELECT * FROM CLIENT 
WHERE regexp_like(CLIENTNAME, '^Lia|^Nis|^Sno'); 
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY   CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- --------- ---------- ------------------------------ ----------------------------------------
4          Nisson Liam                              6          01-JAN-01
5          Liam Nisson                              7          01-JAN-01            +38(077)777-77-77
555        Snow Snow Ho                             8          01-JAN-78         45 +38(077)777-77-77              testUsetLogin@eml.com.ua
*/

/*
3. Одна з колонок таблиць повинна містити строкове значення з цифрами від 3 до 8 у
будь-якій позиції. Створіть запит, який отримає рядки таблиці з урахуванням присутності у
вказаній колонці будь-якої цифри від 3 до 8.
*/
SELECT * FROM CLIENT 
WHERE regexp_like(CLIENTID, '.*[3-8].*');
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY   CLIENTAGE
---------- ---------------------------------------- ---------- --------- ----------
6          Name3                                    4          10-OCT-10
3          L                                        5          01-JAN-01
4          Liam Nisson                              6          01-JAN-01
5          Liam Nisson                              7          01-JAN-01
*/


/*
4. Створіть запит, який отримає рядки таблиці з урахуванням відсутності в зазначеній
колонці будь-якої цифри від 3 до 8.
*/
SELECT * FROM CLIENT 
WHERE NOT regexp_like(CLIENTID, '.*[3-8].*');
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY    CLIENTAGE
---------- ---------------------------------------- ---------- ---------- ----------
1          Name 1                                   1          01/01/2001
2          Name 2                                   2          02/02/2002
*/


/*
5. Створіть запит, який отримає рядки таблиці з урахуванням присутності в раніше вказаній
колонці поєднання будь-яких трьох цифр розміщених підряд від 3 до 8.
*/
SELECT * FROM CLIENT 
WHERE regexp_like(CLIENTID, '[3-8][3-8][3-8]');
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY   CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- --------- ---------- ------------------------------ ----------------------------------------
555        Snow Snow Ho                             8          01-JAN-78         45 +38(077)777-77-77              testUsetLogin@eml.com.ua
*/