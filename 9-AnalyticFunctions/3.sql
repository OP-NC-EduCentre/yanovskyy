/*
1. Класифікуйте значення однієї з колонок на 3 категорії залежно від загальної суми
значень у будь-якій числовій колонці.
*/

SELECT NTILE(3) OVER (ORDER BY CLIENTID) AS C_GROUP, CLIENTNAME, (SELECT SUM(BILLAMOUNT)FROM BILL WHERE CLIENTID = C.CLIENTID) AS TOTALPAYED, PHONE, EMAIL 
FROM CLIENT C;

/*
   C_GROUP CLIENTNAME           TOTALPAYED PHONE                EMAIL
---------- -------------------- ---------- -------------------- ------------------------------
         1 Andrew Fuller               250 +380111111111        AndrewFuller@gmail.com
         1 Nancy Cruy                  598 +380222222222        Nancycruyy@gmail.com
         1 Micke Robinson              698 +380333333333       s mickyy@gmail.com
         2 Andrey Yanovskiy            398 +380664127998        andreyyanokvsiy@gmail.com
         2 Samantha Roudes             398 +380444444444        samanthar@gmail.com
         2 Bobby Axelrod               199 +380555555555        bobbyaxe@axe.cap
         3 Graice Vanpelt             1194 +380666666666        gracevp@gmail.com
         3 Kimbl Cho                       +380777777777        kimcho@gmail.com

8 rows selected.
*/


/*
2. Складіть запит, який поверне списки лідерів у підгрупах, отриманих у першому
завданні етапу 1.
*/
SELECT
  C_GROUP,
  CLIENTNAME,
  TOTALPAYED,
  PHONE,
  EMAIL
FROM
  (
    SELECT
      C_GROUP,
      CLIENTNAME,
      PHONE,
      EMAIL,
      TOTALPAYED,
      RANK() OVER (
      PARTITION BY C_GROUP
    ORDER BY
      TOTALPAYED DESC) AS PAYEDTOP
    FROM CLIENTPAYMENT
  )
WHERE
  PAYEDTOP = 1;

/*
   C_GROUP CLIENTNAME           TOTALPAYED PHONE                EMAIL
---------- -------------------- ---------- -------------------- ----------------------------------------
         1 Micke Robinson              698 +380333333333        mickyy@gmail.com
         2 Samantha Roudes             597 +380444444444        samanthar@gmail.com
         3 Graice Vanpelt             1194 +380666666666        gracevp@gmail.com
*/


/*
3. Модифікуйте рішення попереднього завдання, повернувши по 2 лідери у кожній
підгрупі.
*/
SELECT
  C_GROUP,
  CLIENTNAME,
  TOTALPAYED,
  PHONE,
  EMAIL
FROM
  (
    SELECT
      C_GROUP,
      CLIENTNAME,
      PHONE,
      EMAIL,
      TOTALPAYED,
      RANK() OVER (
      PARTITION BY C_GROUP
    ORDER BY
      TOTALPAYED DESC) AS PAYEDTOP
    FROM CLIENTPAYMENT
  )
WHERE
  PAYEDTOP = 1 OR PAYEDTOP = 2;
/*
   C_GROUP CLIENTNAME           TOTALPAYED PHONE                EMAIL
---------- -------------------- ---------- -------------------- ----------------------------------------
         1 Micke Robinson              698 +380333333333        mickyy@gmail.com
         1 Nancy Cruy                  598 +380222222222        Nancycruyy@gmail.com
         2 Samantha Roudes             597 +380444444444        samanthar@gmail.com
         2 Andrey Yanovskiy            398 +380664127998        andreyyanokvsiy@gmail.com
         3 Graice Vanpelt             1194 +380666666666        gracevp@gmail.com
         3 Kimbl Cho                   250 +380777777777        kimcho@gmail.com

6 rows selected.

*/


/*
4. Складіть запит, який повертає рейтинг будь-якого з перерахованих значень
відповідно до вашої предметноїобласті: товарів/послуг/співробітників/клієнтів тощо.
*/
SELECT
  CLIENTNAME,
  SUM(TOTALPAYED) AS PAYED
FROM
  CLIENTPAYMENT
GROUP BY
  CLIENTNAME
ORDER BY
  PAYED DESC;

/*
топ по суммі уплат за весь період користування інтернетом
CLIENTNAME                PAYED
-------------------- ----------
Graice Vanpelt             1194
Micke Robinson              698
Nancy Cruy                  598
Samantha Roudes             597
Andrey Yanovskiy            398
Andrew Fuller               250
Kimbl Cho                   250
Bobby Axelrod               199

8 rows selected.
*/

/*
5. Одна з колонок таблиці повинна містити значення, що повторюються, для
виділення підгруп, інша колонка повинна мати числові значення. Створіть запит, який
отримає перше значення у кожній підгрупі.
*/
SELECT
  CLIENTID,
  (
  SELECT
    BILLID
  FROM
    BILL
  WHERE
    CLIENTID = B.CLIENTID
    AND ROWNUM = 1) TOPITEM
  FROM
    BILL B
  GROUP BY
    CLIENTID;

/*
CLIENTID   TOPITEM
---------- ----------
1          a1
2          b1
3          c1
4          ac1
5          ac2
6          ac3
7          aca5
8          c11

8 rows selected.
*/