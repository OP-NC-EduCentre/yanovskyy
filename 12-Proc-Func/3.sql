/*
3.1. Оформіть рішення завдань етапу 2 у вигляді програмного пакета. 
Наведіть приклад виклику збереженої процедури та функції, враховуючи назву пакету.
*/
CREATE OR REPLACE PACKAGE bill_service IS
	PROCEDURE insert_into_bills_for_loop(
		inputLinesCount IN OUT NUMBER,
        b_bill_id BILLS.BILLID%TYPE,
        b_bill_c_id BILLS.CLIENTID%TYPE, 
        b_pakcakge_id BILLS.PACKAGEID%TYPE,
        b_bill_amt BILLS.BILLAMOUNT%TYPE,
        b_bill_date BILLS.BILLDATE%TYPE
        );
    FUNCTION sum_bills_amount(
        clintTargetId IN NUMBER
        )
    RETURN NUMBER;
END bill_service;
/
/*
Package BILL_SERVICE compiled
*/
CREATE OR REPLACE PACKAGE BODY bill_service IS
PROCEDURE insert_into_bills_for_loop(
		inputLinesCount IN OUT NUMBER,
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

FUNCTION sum_bills_amount ( 
    clintTargetId IN NUMBER
)
RETURN NUMBER
IS
	resultSum NUMBER;
BEGIN
	select sum(billamount) INTO resultSum from bills where clientid = clintTargetId; 
    return resultSum; 
END;

END bill_service;
/
/*
Package Body BILL_SERVICE compiled
*/

-- Example: 
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
    
    resultBillAmountSum NUMBER := 0; 
    targetClientId NUMBER := 1; 
BEGIN 
    t1 := SYSTIMESTAMP;
    bill_service.insert_into_bills_for_loop(
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
    
    resultBillAmountSum := bill_service.sum_bills_amount(targetClientId); 
    DBMS_OUTPUT.PUT_LINE('Total bills amount: ' || resultBillAmountSum); 
END; 
/
/*
Time (millisec) = ,138
Total bills amount: 1200
*/