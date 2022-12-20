/*
4.1. Виконайте введення 5 рядків у таблицю бази даних із
 динамічною генерацією команди. Значення первинного ключа 
 генеруються автоматично, решта даних дублюється.
*/
DECLARE 
    billid bills.billid%TYPE := '1';
    clientid bills.clientid%TYPE := 1; 
    packageid bills.packageid%TYPE := 4; 
    amount bills.billamount%TYPE := 600; 
    billdate bills.billdate%TYPE := TO_DATE(CURRENT_DATE,'DD/MM/YYYY'); 
    sql_str VARCHAR2(500);
BEGIN 
    sql_str := 'INSERT INTO BILLS(BILLID, CLIENTID, PACKAGEID, BILLAMOUNT, BILLDATE)' 
					|| ' VALUES(:1,:2,:3,:4,:5)';
	FOR i IN 1..5 LOOP
		billid := TO_CHAR(sysdate, 'yyyy/mm') || '-' || TO_CHAR(i); 
		EXECUTE IMMEDIATE sql_str 
			USING billid, clientid, packageid, 
					amount, billdate;
	END LOOP;
END; 
/
/*
BILLID     CLIENTID   PACKAGEID  BILLAMOUNT BILLDATE  
---------- ---------- ---------- ---------- ----------
2022/12-1  1          4                 600 18.12.2022
2022/12-2  1          4                 600 18.12.2022
2022/12-3  1          4                 600 18.12.2022
2022/12-4  1          4                 600 18.12.2022
2022/12-5  1          4                 600 18.12.2022
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

15 rows selected. 
*/

/*
4.2. Скласти динамічний запит створення таблиці, іменами колонок якої 
будуть значення будь-якої символьної колонки. Попередньо виконати перевірку існування таблиці з її видаленням.

*/
DECLARE 
    CURSOR bills_ids IS
        SELECT BILLID FROM BILLS; 
    bill_id_rack bills_ids%ROWTYPE; 
    table_cols_names VARCHAR(8000);
BEGIN
    FOR i IN bills_ids
    LOOP
        table_cols_names := table_cols_names || 'a' || i.BILLID || ' VARCHAR(10), '; 
    END LOOP; 
    EXECUTE IMMEDIATE 'CREATE TABLE TEST_L_11 (' || SUBSTR(table_cols_names, '0', (LENGTH(table_cols_names)-2)) || ' )';
END;    
/
/*
COLUMN_NAME DATA_TYPE           NULLABLE COLUMN_ID
A21P6BV6ROU	VARCHAR2(10 BYTE)	Yes		1	
A388PDOZHMY	VARCHAR2(10 BYTE)	Yes		2	
A3CJJUVIM1Q	VARCHAR2(10 BYTE)	Yes		3	
ADMBPJSHC2A	VARCHAR2(10 BYTE)	Yes		4	
AQCI9KEYQAJ	VARCHAR2(10 BYTE)	Yes		5	
ARJ0R6UC7OF	VARCHAR2(10 BYTE)	Yes		6	
AAICZXPTUI1	VARCHAR2(10 BYTE)	Yes		7	
ADZNPNW0EOW	VARCHAR2(10 BYTE)	Yes		8	
AFKK5GWXLAS	VARCHAR2(10 BYTE)	Yes		9	
AP5M8QOU3VJ	VARCHAR2(10 BYTE)	Yes		10	
*/

/*
4.3. Команда ALTER SEQUENCE може змінювати початкове значення генератора починаючи з СУБД версії 12.
Для ранніх версій доводиться виконувати дві команди: видалення генератора та створення генератора з 
новим початковим значенням.
З урахуванням вашої предметної області створити анонімний PL/SQL-блок, який викликатиме один із 
варіантів SQL-запитів зміни початкового значення генератора залежно від значення версії СУБД.
*/
DECLARE 
    seq_count NUMBER(10) := 0; 
    seq_name VARCHAR(15) := 'test_seq'; 
    seq_start_with NUMBER(10) := 1; 
    seq_increment_by NUMBER(10) := 1; 
BEGIN 
    SELECT COUNT(*) INTO seq_count FROM all_sequences WHERE sequence_name = UPPER(seq_name); 
    DBMS_OUTPUT.PUT_LINE('Current DB verion is: ' || DBMS_DB_VERSION.VERSION); 
    IF (DBMS_DB_VERSION.VERSION > 12) THEN 
        IF (seq_count > 0) THEN 
            EXECUTE IMMEDIATE 'ALTER SEQUENCE ' ||  UPPER(seq_name) || ' CACHE 10'; 
            DBMS_OUTPUT.PUT_LINE('Sequence ' || seq_name || ' altered'); 
        ELSE
            EXECUTE IMMEDIATE 'CREATE SEQUENCE ' ||  UPPER(seq_name)
                    || ' START WITH ' || seq_start_with 
                    || ' INCREMENT BY ' || seq_increment_by 
                    || ' CACHE 10';
            DBMS_OUTPUT.PUT_LINE('Sequence ' || seq_name || ' created'); 
        END IF;
    ELSE 
        IF (seq_count > 0) THEN 
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' ||  UPPER(seq_name); 
            DBMS_OUTPUT.PUT_LINE('Sequence ' || seq_name || ' droped'); 
            EXECUTE IMMEDIATE 'CREATE SEQUENCE ' ||  UPPER(seq_name)
                    || ' START WITH ' || seq_start_with 
                    || ' INCREMENT BY ' || seq_increment_by; 
            DBMS_OUTPUT.PUT_LINE('Sequence ' || seq_name || ' created'); 
                
        ELSE
            EXECUTE IMMEDIATE 'CREATE SEQUENCE ' ||  UPPER(seq_name)
                    || ' START WITH ' || seq_start_with 
                    || ' INCREMENT BY ' || seq_increment_by;
            DBMS_OUTPUT.PUT_LINE('Sequence ' || seq_name || ' created'); 
        END IF;
    END IF; 
     
END; 
/
/*
Current DB verion is: 19
Sequence test_seq altered

For lower version should return: 

Current DB verion is: [DB_VERSION]
Sequence test_seq droped
Sequence test_seq created
*/
