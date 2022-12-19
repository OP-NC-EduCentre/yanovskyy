/*
2.1. Повторити виконання завдання 2 етапу 1, забезпечивши контроль відсутності 
даних у відповіді на запит із використанням винятку.
*/
DECLARE
	b_bill_id BILLS.BILLID%TYPE := 'someID'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 1; 
    b_pakcakge_id BILLS.PACKAGEID%TYPE := 4; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');

BEGIN
    SELECT PRICEPERMONTH INTO b_bill_amt FROM PACKAGES WHERE PACKAGEID = 8; 
    INSERT INTO BILLS (BILLID, CLIENTID, PACKAGEID, BILLAMOUNT, BILLDATE)
        VALUES (b_bill_id || bills_seq.NEXTVAL, b_bill_c_id, b_pakcakge_id, b_bill_amt, b_bill_date);
    DBMS_OUTPUT.PUT_LINE('Data inserted!!!'); 
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Package price not found');
END;
/
/* result output: 
Package price not found
*/

/*
2.2. Повторити виконання завдання 2 етапу 1, забезпечивши контроль отримання багаторядкової відповіді на запит.
*/
DECLARE
	b_bill_id BILLS.BILLID%TYPE := 'someID'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 1; 
    b_pakcakge_id BILLS.PACKAGEID%TYPE := 4; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');

BEGIN
    SELECT PRICEPERMONTH INTO b_bill_amt FROM PACKAGES WHERE PACKAGEID = 1 OR PACKAGEID = 2; -- simulation error
    INSERT INTO BILLS (BILLID, CLIENTID, PACKAGEID, BILLAMOUNT, BILLDATE)
        VALUES (b_bill_id || bills_seq.NEXTVAL, b_bill_c_id, b_pakcakge_id, b_bill_amt, b_bill_date);
    DBMS_OUTPUT.PUT_LINE('Data inserted!!!'); 
EXCEPTION
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('Only one value is expected for package price');
END;
/
/* result output
Only one value is expected for package price
*/
DECLARE 
    i NUMBER; 
    b_bill_id BILLS.BILLID%TYPE := 'someID'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 2; 
    b_pakcakge_id BILLS.PACKAGEID%TYPE := 1; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE := 199; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');
BEGIN 
    i:=1;
	LOOP
		INSERT INTO BILLS
					(BILLID, CLIENTID, PACKAGEID, BILLAMOUNT,BILLDATE)
		VALUES(	b_bill_id || i, 
				b_bill_c_id, 
				b_pakcakge_id,
				b_bill_amt,
				b_bill_date);
		i := i + 1;
		EXIT WHEN i > 5;
	END LOOP;	
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('BILLID is already exists!!!');
END; 
/
/*
2.3. Повторити виконання завдання 3 етапу 1, забезпечивши контроль за внесенням унікальних значень.
*/

/* result output
BILLID is already exists!!!
*/