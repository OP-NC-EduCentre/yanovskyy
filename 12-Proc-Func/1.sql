/*
1.1. Повторіть виконання завдання 4 етапу 1 із попередньої лабораторної роботи:
− циклічно внести 5000 рядків;
− визначити загальний час на внесення зазначених рядків;
− вивести на екран значення часу.
*/
DECLARE 
    b_bill_id BILLS.BILLID%TYPE := 'ID-'; 
    b_bill_c_id BILLS.CLIENTID%TYPE := 1; 
    b_pakcakge_id BILLS.PACKAGEID%TYPE := 1; 
    b_bill_amt BILLS.BILLAMOUNT%TYPE := 0; 
    b_bill_date BILLS.BILLDATE%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY');
    
    t1 TIMESTAMP;
    t2 TIMESTAMP;
    delta number; 
BEGIN 
    t1 := SYSTIMESTAMP;
    FOR i IN 1..5000
    LOOP
		INSERT INTO BILLS
					(BILLID, CLIENTID, PACKAGEID, BILLAMOUNT,BILLDATE)
		VALUES(	b_bill_id || i, 
				b_bill_c_id, 
				b_pakcakge_id,
				b_bill_amt,
				b_bill_date);
	END LOOP;
	t2 := SYSTIMESTAMP;
	delta := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
			TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
	DBMS_OUTPUT.PUT_LINE('Time (millisec) = ' || delta);
END; 
/
/*
Time (millisec) = ,118
*/


/*
1.2. Повторіть виконання попереднього завдання, порівнявши час виконання циклічних внесень рядків, використовуючи два способи: FOR і FORALL.
*/
DECLARE
    TYPE NumList IS VARRAY(20) OF NUMBER;
    depts NumList := NumList(1, 2, 3);  
    iterations CONSTANT PLS_INTEGER := 5000;
   
    TYPE IdsTab IS TABLE OF bills.billid%TYPE INDEX BY PLS_INTEGER;

    billids1 IdsTab; 
    billids2 IdsTab;
    
    t1 TIMESTAMP;
    t2 TIMESTAMP;
    delta1 number; 
    delta2 number; 
    
BEGIN

    FOR I IN 1..iterations LOOP 
        billids1(i) := 'a-'|| i; 
        billids2(i) := 'b-'|| i; 
    END LOOP; 
   
    t1 := SYSTIMESTAMP;
    FOR I IN 1..iterations LOOP
		INSERT INTO BILLS
					(BILLID, CLIENTID, PACKAGEID, BILLAMOUNT,BILLDATE)
		VALUES(	billids1(i), 
				1, 
				1,
				99,
				'10/10/2010');
	END LOOP;
    t2 := SYSTIMESTAMP;
	delta1 := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
			TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
   
    t1 := SYSTIMESTAMP;
    FORALL i IN 1..iterations
      INSERT INTO BILLS2 VALUES (billids2(i), 1, 1, 99, '10/10/2010'); 
      
    t2 := SYSTIMESTAMP;
	delta2 := TO_NUMBER(TO_CHAR(t2, 'HHMISS.FF3'),'999999.999') - 
			TO_NUMBER(TO_CHAR(t1, 'HHMISS.FF3'),'999999.999');
    
    DBMS_OUTPUT.PUT_LINE('Execution time (sec)');
    DBMS_OUTPUT.PUT_LINE('-------------------------------');
    DBMS_OUTPUT.PUT_LINE('FOR-loop: ' || TO_CHAR((delta1)/100));
    DBMS_OUTPUT.PUT_LINE('FORALL-operator:   ' || TO_CHAR((delta2)/100));
    DBMS_OUTPUT.PUT_LINE('-------------------------------');
    
END;
/
/*
Execution time (sec)
-------------------------------
FOR-loop: ,00149
FORALL-operator:   ,00057
-------------------------------
*/

/*
1.3. Для однієї з таблиць отримайте рядки з використанням курсору та пакетної обробки SELECT-операції з оператором BULK COLLECT.
*/
DECLARE
   TYPE BILL IS TABLE OF BILLS%ROWTYPE;
   bill_list bill;
BEGIN
  SELECT billid, clientid, packageid, billamount, billdate
     BULK COLLECT INTO bill_list FROM BILLS;
  DBMS_OUTPUT.PUT_LINE('Bills list:');
  FOR i IN bill_list.FIRST .. bill_list.LAST
       LOOP
         DBMS_OUTPUT.PUT_LINE(bill_list(i).billid || ':' || 
            bill_list(i).clientid || ':' || 
            bill_list(i).packageid  || ':' || 
            bill_list(i).billamount  || ':' || 
            bill_list(i).billdate);
       END LOOP;
END;
/
/*  
Bills list:
QCi9KeyQAj:1:4:600:23.08.1951
Rj0r6Uc7OF:2:1:199:28.07.2022
aiCZXPTui1:3:1:199:01.08.2022
fkK5GWXlAs:4:2:249:16.09.2022
3CJjuvIm1Q:5:2:249:26.09.2022
p5M8qoU3VJ:6:3:400:02.10.2022
DmBpJSHc2A:7:2:249:14.10.2022
388PDOzHMY:8:1:199:23.10.2022
21P6Bv6roU:1:4:600:15.11.2022
dzNPNw0eOW:2:1:199:16.11.2022
*/