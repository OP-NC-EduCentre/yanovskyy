/*
3. Ієрархічні та рекурсивні запити
1. Виберіть таблицю вашої БД, до якої потрібно додати нову колонку, яка стане FK-
колонкою для PK-колонки цієї таблиці та буде використана для зберігання ієрархії.
Використовується команда ALTER TABLE таблиця ADD колонка тип_даних;
Заповніть дані для створеної колонки, виконавши серію команд UPDATE.
*/
ALTER TABLE CLIENT ADD CLIENTAGE NUMBER;
/*
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY    CLIENTAGE
---------- -------------------- ---------- ---------- ----------
1          Name 1               1          01/01/2001          2
2          Name 2               2          02/02/2002          3
6          Name3                4          10/10/2010          7
3          L                    5          01/01/2001          4
4          Liam Nisson          6          01/01/2001          5
5          Liam Nisson          7          01/01/2001          6
7          Andrey Yanovskiy     8          17/09/2000          8
*/

/*
2. Використовуючи створену колонку, отримайте дані з таблиці через ієрархічний зв'язок
типу «зверху-вниз».
*/
SELECT CLIENTNAME, CLIENTAGE, BIRTHDAY, LEVEL 
FROM CLIENT 
START WITH CLIENTID = 7
CONNECT BY PRIOR CLIENTID = CLIENTAGE 
ORDER BY LEVEL;
/*
CLIENTNAME            CLIENTAGE BIRTHDAY        LEVEL
-------------------- ---------- ---------- ----------
Andrey Yanovskiy              8 17/09/2000          1
Name3                         7 10/10/2010          2
Liam Nisson                   6 01/01/2001          3
Liam Nisson                   5 01/01/2001          4
L                             4 01/01/2001          5
Name 2                        3 02/02/2002          6
Name 1                        2 01/01/2001          7

*/


/*
3. Згенеруйте унікальну послідовність чисел, використовуючи рекурсивний запит, в
діапазоні від 1 до 100. На основі отриманого результату створіть запит, що виводить на екран
список ще не внесених значень однієї з PK-колонок однієї з таблиць БД за прикладом на рисунку
11.
*/
SELECT SQ.RN
FROM (SELECT ROWNUM AS RN 
		FROM DUAL CONNECT BY LEVEL <= 100
) SQ 
WHERE SQ.RN NOT IN (SELECT CLIENTID FROM CLIENT) 
ORDER BY RN;
	
/*
FOR TABLE 
CLIENTID   CLIENTNAME           MANAGERID  BIRTHDAY    CLIENTAGE
---------- -------------------- ---------- ---------- ----------
1          Name 1               1          01/01/2001
2          Name 2               2          02/02/2002
6          Name3                4          10/10/2010
3          L                    5          01/01/2001
4          Liam Nisson          6          01/01/2001
5          Liam Nisson          7          01/01/2001
11         test 2               8          01/01/2001          0

RESULT: 
        RN
----------
         7
         8
         9
        10
        12
        13
        14
        15
        16
        17
        18
        19
        20
        21
        22
        23
        24
        25
        26
        27
        28
        29
to 100.
*/