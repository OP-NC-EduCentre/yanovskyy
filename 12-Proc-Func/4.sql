/*
4.1. З урахуванням вашої предметної області створити табличну функцію, що повертає значення
будь-яких двох колонок будь-якої таблиці з урахуванням значення однієї з колонок, що передається як параметр.
Показати приклад виклику функції.
*/
CREATE TYPE bill_short_info AS OBJECT (
 billid 	    VARCHAR(10),
 clientid   	NUMBER(10),
 billamount 	NUMBER(10)
);
/*
Type BILL_SHORT_INFO compiled
*/

CREATE TYPE bill_short_info_list IS TABLE OF bill_short_info;
/*
Type BILL_SHORT_INFO_LIST compiled
*/
CREATE OR REPLACE FUNCTION get_bill_list(targetLessPackageId IN NUMBER)
RETURN BILL_SHORT_INFO_LIST 
AS
	bills_list BILL_SHORT_INFO_LIST := BILL_SHORT_INFO_LIST();
BEGIN
 	SELECT bill_short_info(billid,clientid,billamount) 
		 BULK COLLECT INTO bills_list 
		 FROM bills
		 WHERE packageid <= targetLessPackageId;
	RETURN bills_list;
END;
/
/*
Function GET_BILL_LIST compiled
*/

SELECT BILLID, CLIENTID, BILLAMOUNT FROM TABLE(get_bill_list(2));
/*
BILLID       CLIENTID BILLAMOUNT
---------- ---------- ----------
Rj0r6Uc7OF          2        199
aiCZXPTui1          3        199
fkK5GWXlAs          4        249
3CJjuvIm1Q          5        249
DmBpJSHc2A          7        249
388PDOzHMY          8        199
dzNPNw0eOW          2        199

7 rows selected. 
*/

/*
4.2. Повторіть рішення попереднього завдання, але з використанням конвеєрної табличної функції.
*/
CREATE OR REPLACE PACKAGE bill_pipeline_service IS
	TYPE bill_short IS RECORD (
		billid 	    VARCHAR(10),
		clientid 	NUMBER(10),
		billamount 	NUMBER(10)
	);
	TYPE bill_short_list IS TABLE OF bill_short;
	FUNCTION get_bill_short(targetPackageId IN NUMBER)
		RETURN bill_short_list PIPELINED;
END bill_pipeline_service;
/
/*
Package BILL_PIPE_LINE_SERVICE compiled
*/

CREATE OR REPLACE PACKAGE BODY bill_pipeline_service IS
	FUNCTION get_bill_short(targetPackageId IN NUMBER)
		RETURN bill_short_list PIPELINED
	AS
	BEGIN
		FOR elem IN (SELECT billid,clientid,billamount 
					FROM bills
                    WHERE packageid <= targetPackageId) LOOP
			PIPE ROW(elem);
		END LOOP;
	END;
END bill_pipeline_service; 
/
/*
BILLID       CLIENTID BILLAMOUNT
---------- ---------- ----------
Rj0r6Uc7OF          2        199
aiCZXPTui1          3        199
fkK5GWXlAs          4        249
3CJjuvIm1Q          5        249
DmBpJSHc2A          7        249
388PDOzHMY          8        199
dzNPNw0eOW          2        199
*/
