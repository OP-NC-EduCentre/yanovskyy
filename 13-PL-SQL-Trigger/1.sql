/*
1. Створити інформуючий тригер для виведення повідомлення на екран після додавання,
 зміни або видалення рядка з будь-якої таблиці Вашої бази даних із зазначенням у 
 повідомленні операції, на яку зреагував тригер. Навести тест-кейс перевірки роботи тригера.
*/
CREATE OR REPLACE TRIGGER bills_triger
    AFTER INSERT OR UPDATE OR DELETE ON BILLS
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('INSERTING SOME VALUES INTO BILLS table ...');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('UPDATING SOME VALUES INTO BILLS table ...');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DELETING SOME VALUES INTO BILLS table ...');
    END IF;
END;
/
/*
QUERY: 
INSERT INTO BILLS VALUES ('1', 1, 1, 99, '10/10/2010'); 
RESULT: 
INSERTING SOME VALUES INTO BILLS table ...

QUERY: 
UPDATE BILLS SET BILLDATE = '11/11/2011' WHERE BILLID = '1'; 
RESULT: 
UPDATING SOME VALUES INTO BILLS table ...

QUERY: 
DELETE FROM BILLS WHERE BILLID = '1'; 
RESULT: 
DELETING SOME VALUES INTO BILLS table ...
*/

/*
2. Повторити попереднє завдання лише під час роботи користувача, ім'я якого збігається 
з вашим логіном. Навести тест-кейс перевірки роботи тригера.
*/
CREATE OR REPLACE TRIGGER bills_triger_with_user_name
    AFTER INSERT OR UPDATE OR DELETE ON BILLS
    FOR EACH ROW
    WHEN (USER = 'ADMIN')
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('INSERTING SOME VALUES INTO BILLS table WITH USER `ADMIN` ...');
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('UPDATING SOME VALUES INTO BILLS table WITH USER `ADMIN` ...');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DELETING SOME VALUES INTO BILLS table WITH USER `ADMIN` ...');
    END IF;
END;
/
/*
QUERIS: 
INSERT INTO BILLS VALUES('1', 1, 1, 99, '10/10/2010'); 
UPDATE BILLS SET BILLAMOUNT = 199 WHERE BILLID = '1'; 
DELETE FROM BILLS WHERE BILLID = '1'; 

RESULT OUTPUT: 
INSERTING SOME VALUES INTO BILLS table WITH USER `ADMIN` ...

UPDATING SOME VALUES INTO BILLS table WITH USER `ADMIN` ...

DELETING SOME VALUES INTO BILLS table WITH USER `ADMIN` ...
*/


