/*
1.1. Виберіть таблицю бази даних, що містить стовпець типу date. 
Оголосіть змінні, що відповідають стовпцям цієї таблиці, використовуючи 
посилальні типи даних. Надайте змінним значення, використовуйте SQL-функції 
для формування значень послідовності, перетворення дати до вибраного стилю.
 Виведіть на екран рядок.
*/
DECLARE 
target_bill_id VARCHAR(30) := 'QCi9KeyQAj';  
bill_id bills.billid%TYPE;
bill_client_id bills.clientid%TYPE; 
bill_packageid bills.packageid%TYPE; 
bill_bill_amount bills.billamount%TYPE; 
bill_bill_date bills.billdate%TYPE; 

BEGIN 
SELECT 
    BILLID, 
    CLIENTID, 
    PACKAGEID, 
    BILLAMOUNT, 
    BILLDATE
INTO 
    bill_id, 
    bill_client_id, 
    bill_packageid, 
    bill_bill_amount, 
    bill_bill_date
FROM BILLS WHERE BILLID = target_bill_id; 

bill_id := 'someID' || TEST.NEXTVAL; 
bill_client_id := 1;
bill_packageid := 4;
bill_bill_amount := 600; 
bill_bill_date := TO_DATE(bill_bill_date,'DD/MM/YYYY');


DBMS_OUTPUT.PUT_LINE('BILL: id {' || bill_id || 
        '} client_id {' || bill_client_id || 
        '} package_id {' || bill_packageid || 
        '} amount {' || bill_bill_amount || 
        '} bill date {' || bill_bill_date || 
        '}');

END;
/
/*
BILL: id {QCi9KeyQAj} client_id {1} package_id {4} amount {600} bill date {23.08.1951}
*/

/*
1.2. Додати інформацію до однієї з таблиць, обрану у попередньому завданні.
Використовувати формування нового значення послідовності та перетворення формату дати.
*/
-- SEQUENCE
CREATE SEQUENCE bills_seq
  MINVALUE 1
  START WITH 8
  INCREMENT BY 1
  CACHE 20;
  


DECLARE
	b_bill_id BILLS.BILLID%TYPE := 'someID'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 1; 
    b_pakcakge_id BILLS.PACKAGEID%TYPE := 4; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE := 600; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');

BEGIN
    INSERT INTO BILLS (BILLID, CLIENTID, PACKAGEID, BILLAMOUNT, BILLDATE)
        VALUES (b_bill_id || bills_seq.NEXTVAL, b_bill_c_id, b_pakcakge_id, b_bill_amt, b_bill_date);
    DBMS_OUTPUT.PUT_LINE('Data inserted!!!'); 
END;
/
/*
BILLID     CLIENTID   PACKAGEID  BILLAMOUNT BILLDATE  
---------- ---------- ---------- ---------- ----------
someID8    1          4                 600 18.12.2022 ++++ this is new inserted line
QCi9KeyQAj 1          4                 600 23.08.1951
Rj0r6Uc7OF 2          1                 199 28.07.2022
aiCZXPTui1 3          1                 199 01.08.2022
fkK5GWXlAs 4          2                 249 16.09.2022
3CJjuvIm1Q 5          2                 249 26.09.2022
p5M8qoU3VJ 6          3                 400 02.10.2022
DmBpJSHc2A 7          2                 249 14.10.2022
388PDOzHMY 8          1                 199 23.10.2022
21P6Bv6roU 1          4                 600 15.11.2022
dzNPNw0eOW 2          1                 199 16.11.2022

11 rows selected. 
*/

/*
1.3. Для однієї з таблиць створити команду отримання середнього значення однієї з цілих колонок, 
використовуючи умову вибірки за заданим значенням іншої колонки. Результат присвоїти змінній і вивести на екран.
*/
DECLARE 
    client_id NUMBER := 1; 
	average NUMBER; 
BEGIN
    SELECT AVG(BILLAMOUNT) INTO average FROM BILLS WHERE CLIENTID = client_id; 
    DBMS_OUTPUT.PUT_LINE('Average bill amount for client with id ' || client_id 
    || ' is ' || average);
END; 
/
/*
Average bill amount for client with id 1 is 600
*/

/*
1.4. Виконайте введення 5 рядків у таблицю бази даних, використовуючи цикл з параметрами. 
Значення первинного ключа генеруються автоматично, решта даних дублюється.
*/
DECLARE 
    b_bill_id BILLS.BILLID%TYPE := 'someID'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 2; 
    b_pakcakge_id BILLS.PACKAGEID%TYPE := 1; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE := 199; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');
BEGIN 
	FOR i IN 1..5 
    LOOP
		INSERT INTO BILLS
					(BILLID, CLIENTID, PACKAGEID, BILLAMOUNT,BILLDATE)
		VALUES(	b_bill_id || i, 
				b_bill_c_id, 
				b_pakcakge_id,
				b_bill_amt,
				b_bill_date);
		
	END LOOP;	
END; 
/
/*
BILLID     CLIENTID   PACKAGEID  BILLAMOUNT BILLDATE  
---------- ---------- ---------- ---------- ----------
someID1    2          1                 199 18.12.2022
someID2    2          1                 199 18.12.2022
someID3    2          1                 199 18.12.2022
someID4    2          1                 199 18.12.2022
someID5    2          1                 199 18.12.2022
QCi9KeyQAj 1          4                 600 23.08.1951
Rj0r6Uc7OF 2          1                 199 28.07.2022
aiCZXPTui1 3          1                 199 01.08.2022
fkK5GWXlAs 4          2                 249 16.09.2022
3CJjuvIm1Q 5          2                 249 26.09.2022
p5M8qoU3VJ 6          3                 400 02.10.2022
DmBpJSHc2A 7          2                 249 14.10.2022
388PDOzHMY 8          1                 199 23.10.2022
21P6Bv6roU 1          4                 600 15.11.2022
dzNPNw0eOW 2          1                 199 16.11.2022
*/