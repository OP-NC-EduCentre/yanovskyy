/*
2.1. Повторити виконання завдання 1 етапу 1, створивши процедуру 
з вхідним параметром у вигляді кількості рядків, що вносяться.
Навести приклад виконання створеної процедури.
*/
CREATE OR REPLACE PROCEDURE insert_into_bills_for_loop
(   inputLinesCount IN OUT NUMBER,
    b_bill_id BILLS.BILLID%TYPE,
    b_bill_c_id BILLS.CLIENTID%TYPE, 
    b_pakcakge_id BILLS.PACKAGEID%TYPE,
    b_bill_amt BILLS.BILLAMOUNT%TYPE,
    b_bill_date BILLS.BILLDATE%TYPE
)   
IS
BEGIN 
    FOR i IN 1..inputLinesCount
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
Procedure INSERT_INTO_BILLS_FOR_LOOP compiled
*/
DECLARE 
    b_bill_id BILLS.BILLID%TYPE := 'ID-'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 1; 
    b_package_id BILLS.PACKAGEID%TYPE := 1; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE := 0; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');
    
    t1 TIMESTAMP;
    t2 TIMESTAMP;
    delta number; 
    
    loopCount NUMBER := 5000; 
BEGIN 
    t1 := SYSTIMESTAMP;
    insert_into_bills_for_loop(
        loopCount,
        b_bill_id, 
        b_bill_c_id, 
        b_package_id, 
        b_bill_amt, 
        b_bill_date);
	t2 := SYSTIMESTAMP;
	delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
			TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
	DBMS_OUTPUT.PUT_LINE('Time (millisec) = ' || delta);
END; 
/
/*
PL/SQL procedure successfully completed.

part of result: 
ID-4978    1          1                   0 26.12.2022
ID-4979    1          1                   0 26.12.2022
ID-4980    1          1                   0 26.12.2022
ID-4981    1          1                   0 26.12.2022
ID-4982    1          1                   0 26.12.2022
ID-4983    1          1                   0 26.12.2022
ID-4984    1          1                   0 26.12.2022
ID-4985    1          1                   0 26.12.2022
ID-4986    1          1                   0 26.12.2022
ID-4987    1          1                   0 26.12.2022
ID-4988    1          1                   0 26.12.2022
ID-4989    1          1                   0 26.12.2022
ID-4990    1          1                   0 26.12.2022
*/

/*
2.2. Створити функцію, яка повертає суму значень однієї з цілих колонок 
однієї з таблиць. Навести приклад виконання створеної функції.
*/
CREATE OR REPLACE FUNCTION sum_bills_amount ( 
    clintTargetId IN NUMBER
)
RETURN NUMBER
IS
	resultSum NUMBER;
BEGIN
	select sum(billamount) INTO resultSum from bills where clientid = clintTargetId; 
    return resultSum; 
END;
/
/*
Function SUM_BILLS_AMOUNT compiled
*/
DECLARE 
    resultBillAmountSum NUMBER := 0; 
    targetClientId NUMBER := 1; 
BEGIN
    resultBillAmountSum := sum_bills_amount(targetClientId); 
    DBMS_OUTPUT.PUT_LINE('Total bills amount: ' || resultBillAmountSum); 
END; 
/*
PL/SQL procedure successfully completed.
Total bills amount: 1200
*/

