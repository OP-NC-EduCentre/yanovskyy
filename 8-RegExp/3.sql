/*
1. Одна з колонок таблиць повинна містити строкове значення з двома словами,
розділеними пробілом. Виконайте команду UPDATE, помінявши місцями ці два слова.
*/
UPDATE CLIENT 
SET CLIENTNAME = regexp_replace(CLIENTNAME, 
                      '(.*)\s(.*)', 
                      '\2 \1') 
WHERE CLIENTID = 4; 
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY    CLIENTAGE PHONE                EMAIL
---------- ---------------------------------------- ---------- ---------- ---------- -------------------- ----------------------------------------
1          Name 1                                   1          01/01/2001
2          Name 2                                   2          02/02/2002
6          Name3                                    4          10/10/2010
3          L                                        5          01/01/2001
4          Nisson Liam                              6          01/01/2001
5          Liam Nisson                              7          01/01/2001
555        Snow Snow Ho                             8          01/01/1978         45 +38(066)666-66-66    testUsetLogin@eml.com.ua
*/


/*
2. Одна з колонок таблиць має містити строкове значення з електронною поштовою
адресою у форматі EEE@EEE.EEE.UA, де E – будь-яка латинська буква. Створіть запит,
вилучення логіна користувача з електронної адреси (підстрока перед символом @).
*/
SELECT regexp_replace('someLogin@email.com.ua', 
                      '([[:alpha:]]+)@([[:alpha:]]+)\.([[:alpha:]]+)\.ua', '\1') 
AS EMAIL FROM DUAL;
/*
EMAIL
---------
someLogin
*/


/*
3. Одна з колонок таблиць повинна містити строкове значення з номером мобільного
телефону у форматі +XX(XXX)XXX-XX-XX, де X – цифра. Виконайте команду UPDATE,
додавши перед номером телефону фразу «Mobile:».
*/
UPDATE CLIENT SET phone = regexp_replace(phone, '(\+[0-9]{2}\([0-9]{3}\)[0-9]{3}\-[0-9]{2}\-[0-9]{2})', 'Mobile:\1')
WHERE CLIENTID = 555; 
/*
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY    CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- ---------- ---------- ------------------------------ ----------------------------------------
1          Name 1                                   1          01/01/2001
2          Name 2                                   2          02/02/2002
6          Name3                                    4          10/10/2010
3          L                                        5          01/01/2001
4          Nisson Liam                              6          01/01/2001
5          Liam Nisson                              7          01/01/2001
555        Snow Snow Ho                             8          01/01/1978         45 Mobile:+38(066)666-66-66       testUsetLogin@eml.com.ua
*/


/*
4. Додайте до колонки з електронною адресою обмеження цілісності, що забороняє
вносити дані, відмінні від формату електронної адреси, використовуючи команду ALTER TABLE
таблиця ADD CONSTRAINT обмеження CHECK (умова). Перевірте роботу обмеження на двох
прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.
*/
ALTER TABLE CLIENT 
ADD CONSTRAINT EMAIL_FORMAT 
CHECK (regexp_like(EMAIL, '(^.*\@.{3}\..{3}\..{2})')); 
/*
Table altered.

-- UPDATE CLIENT SET EMAIL = 'rightEmail@eml.com.ua' WHERE CLIENTID = 5;

CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY    CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- ---------- ---------- ------------------------------ ----------------------------------------
1          Name 1                                   1          01/01/2001
2          Name 2                                   2          02/02/2002
6          Name3                                    4          10/10/2010
3          L                                        5          01/01/2001
4          Nisson Liam                              6          01/01/2001
5          Liam Nisson                              7          01/01/2001                                           rightEmail@eml.com.ua
555        Snow Snow Ho                             8          01/01/1978         45 Mobile:+38(066)666-66-66       testUsetLogin@eml.com.ua

-- UPDATE CLIENT SET EMAIL = 'notRightEmail@email.comm.uaa' WHERE CLIENTID = 4;

UPDATE CLIENT SET EMAIL = 'notRightEmail@email.comm.uaa' WHERE CLIENTID = 4
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.EMAIL_FORMAT) violated

*/


/*
5. Видаліть зайві дані з колонки з номером мобільного телефону, залишивши тільки номер
телефону в заданому форматі.
*/
UPDATE CLIENT SET PHONE = regexp_substr(PHONE, '(\+[0-9]{2}\([0-9]{3}\)[0-9]{3}\-[0-9]{2}\-[0-9]{2})')
WHERE NOT regexp_like(PHONE, '^(\+[0-9]{2}\([0-9]{3}\)[0-9]{3}\-[0-9]{2}\-[0-9]{2})');

/*
RIGHT FORMAT PHONE: +38(066)666-66-66  

BEFORE: 

CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY   CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- --------- ---------- ------------------------------ ----------------------------------------
1          Name 1                                   1          01-JAN-01
2          Name 2                                   2          02-FEB-02
6          Name3                                    4          10-OCT-10
3          L                                        5          01-JAN-01
4          Nisson Liam                              6          01-JAN-01
5          Liam Nisson                              7          01-JAN-01            Mobile:+38(066)666-66-66
555        Snow Snow Ho                             8          01-JAN-78         45 +38(077)777-77-77              testUsetLogin@eml.com.ua

AFTER: 

CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY   CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- --------- ---------- ------------------------------ ----------------------------------------
1          Name 1                                   1          01-JAN-01
2          Name 2                                   2          02-FEB-02
6          Name3                                    4          10-OCT-10
3          L                                        5          01-JAN-01
4          Nisson Liam                              6          01-JAN-01
5          Liam Nisson                              7          01-JAN-01            +38(066)666-66-66
555        Snow Snow Ho                             8          01-JAN-78         45 +38(077)777-77-77              testUsetLogin@eml.com.ua
*/


/*
6. Додайте в колонку з мобільним телефоном обмеження цілісності, що забороняє вносити
дані, відмінні від формату, записаного в завданні 3. Перевірте роботу обмеження на двох
прикладах UPDATE-запитів із правильними та неправильними значеннями колонки.
*/
ALTER TABLE CLIENT 
ADD CONSTRAINT PHONE_FORMAT 
CHECK (regexp_like(PHONE, '^(\+[0-9]{2}\([0-9]{3}\)[0-9]{3}\-[0-9]{2}\-[0-9]{2})')); 
/*
Table altered.

RIGHT SET VALUE: 

UPDATE CLIENT SET PHONE = '+38(077)777-77-77' WHERE CLIENTID = 555;

RESULT:
LIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY    CLIENTAGE PHONE                          EMAIL
---------- ---------------------------------------- ---------- ---------- ---------- ------------------------------ ----------------------------------------
1          Name 1                                   1          01/01/2001
2          Name 2                                   2          02/02/2002
6          Name3                                    4          10/10/2010
3          L                                        5          01/01/2001
4          Nisson Liam                              6          01/01/2001
5          Liam Nisson                              7          01/01/2001            +38(077)777-77-77
555        Snow Snow Ho                             8          01/01/1978         45 +38(077)777-77-77              testUsetLogin@eml.com.ua


ERROR SET VALUE: 

UPDATE CLIENT SET PHONE = '+380777777777' WHERE CLIENTID = 5;

RESULT: 
UPDATE CLIENT SET PHONE = '+380777777777' WHERE CLIENTID = 5
*
ERROR at line 1:
ORA-02290: check constraint (SYSTEM.PHONE_FORMAT) violated

*/