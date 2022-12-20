/*
3.1. Виконайте DELETE-запит із попередніх рішень, додавши аналіз 
даних із неявного курсору. Наприклад, кількість віддалених рядків
*/
BEGIN
	DELETE FROM BILLS WHERE BILLID LIKE 'someID%';
	DBMS_OUTPUT.PUT_LINE('Total deleted rows = ' || SQL%ROWCOUNT);
END;
/

ROLLBACK;
/*
Total deleted rows = 5
*/

/*
3.2. Повторіть виконання завдання 2 етапу 1 з використанням явного курсору.
*/
DECLARE
    CURSOR client_payments IS
        SELECT billid, CLIENTID, packageid, BILLAMOUNT, billdate FROM BILLS;     
    bill_rack BILLS%ROWTYPE; 
    
	b_bill_id BILLS.BILLID%TYPE := 'someID'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 1; 
    b_pakcakge_id BILLS.PACKAGEID%TYPE := 4; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE := 600; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');
    
BEGIN
    OPEN client_payments; 
    FETCH client_payments INTO bill_rack;
    WHILE client_payments%FOUND LOOP
		DBMS_OUTPUT.PUT_LINE('Client with id ' || bill_rack.clientid || ' payed: ' || bill_rack.billamount);
		FETCH client_payments INTO bill_rack;
	END LOOP;
     
    INSERT INTO BILLS (BILLID, CLIENTID, PACKAGEID, BILLAMOUNT, BILLDATE)
        VALUES (b_bill_id || bills_seq.NEXTVAL, b_bill_c_id, b_pakcakge_id, b_bill_amt, b_bill_date);
    DBMS_OUTPUT.PUT_LINE('Data inserted!!!'); 
    CLOSE client_payments; 
END;
/
/*
Client with id 1 payed: 600
Client with id 2 payed: 199
Client with id 3 payed: 199
Client with id 4 payed: 249
Client with id 5 payed: 249
Client with id 6 payed: 400
Client with id 7 payed: 249
Client with id 8 payed: 199
Client with id 1 payed: 600
Client with id 2 payed: 199
Data inserted!!!
*/

/*
3.3. У попередній лабораторній роботі розглядався приклад:
-- приклад 
З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який 
викликатиме один із варіантів подібних SQL-запитів залежно від значення версії СУБД.
При вирішенні використовувати:
− значення змінної DBMS_DB_VERSION.VERSION; 
− явний курсор із параметричним циклом.
*/
DECLARE 
    CURSOR top_pays_low_version IS 
        WITH cl_total_payed AS (
        SELECT 
            (SELECT CLIENTNAME FROM CLIENTS WHERE CLIENTID = B.CLIENTID) AS NAME,
            SUM(billamount) AS TOTALPAYED 
        FROM BILLS B 
        GROUP BY CLIENTID 
        ORDER BY TOTALPAYED DESC 
        ), 
        cl_total_payed_rows AS (
            SELECT 
                name, 
                totalpayed, 
                ROWNUM AS r
            FROM cl_total_payed
        )
        SELECT 
            name, 
            totalpayed
        FROM cl_total_payed_rows
        WHERE r <= 5; 
    CURSOR top_pays IS 
        SELECT DISTINCT (SELECT CLIENTNAME FROM CLIENTS WHERE CLIENTID = B.CLIENTID) AS NAME,
            SUM(billamount) OVER (partition by clientid) AS totalpayed 
        FROM BILLS B ORDER BY TOTALPAYED DESC 
        FETCH FIRST 5 ROWS ONLY; 
        
    top_pays_low_version_rack top_pays_low_version%ROWTYPE; 
    top_pays_rack top_pays%ROWTYPE; 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Current DB verion is: ' || DBMS_DB_VERSION.VERSION); 
    IF (DBMS_DB_VERSION.VERSION < 12) THEN
        FOR top_pays_low_version_rack IN top_pays_low_version
        LOOP
            DBMS_OUTPUT.PUT_LINE(top_pays_low_version_rack.name || ' payed ' || top_pays_low_version_rack.totalpayed || ' for all time.');
        END LOOP;
    ELSE 
        FOR top_pays_rack IN top_pays
        LOOP
            DBMS_OUTPUT.PUT_LINE(top_pays_rack.name || ' payed ' || top_pays_rack.totalpayed || ' for all time.');
        END LOOP;
    END IF; 
    
    CLOSE top_pays_low_version; 
    CLOSE top_pays; 
END; 
/
/*

-- version higher 12c result: 

Current DB verion is: 19
Andrey Yanovskiy payed 1800 for all time.
Brandon Buchanan payed 400 for all time.
Filip Mueller payed 398 for all time.
Faisal Wall payed 249 for all time.
Olivier Farrell payed 249 for all time.

*/