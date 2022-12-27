/*
1. Розробити механізм журналізації DML-операцій, що виконуються над таблицею вашої
 бази даних, враховуючи такі дії:
– створити таблицю з ім'ям LOG_ім'я_таблиці. Структура таблиці повинна 
включати: ім'я користувача, тип операції, дата виконання операції, атрибути, 
що містять старі та нові значення.
– створити тригер журналювання.
Перевірити роботу тригера журналювання для операцій INSERT, UPDATE, DELETE.
*/
CREATE TABLE LOG_MANAGERS (
	new_manager_id	     NUMBER,	
	new_manager_name	 CHAR(40),	
	new_manager_poition	 CHAR(25),	
	old_manager_name	 CHAR(40),
	old_manager_poition	 CHAR(25),	
	op_type	 	         CHAR(6),	
	user_name 	         CHAR(20),	
	change_date          DATE  
); 

CREATE OR REPLACE TRIGGER LOG_MANAGERS
	AFTER INSERT OR UPDATE OR DELETE ON MANAGERS 
	FOR EACH ROW
DECLARE 
	op_type_ LOG_MANAGERS.op_type%TYPE;
BEGIN
	IF INSERTING THEN 
        op_type_ := 'INSERT'; 
    END IF;
	IF UPDATING THEN 
        op_type_ := 'UPDATE';  
    END IF;
	IF DELETING THEN 
        op_type_ := 'DELETE'; 
    END IF;
	INSERT INTO LOG_MANAGERS VALUES (
		:NEW.MANAGERID,
		:NEW.MANAGERNAME,
		:NEW.POSITION,
		:OLD.MANAGERID,
		:OLD.MANAGERNAME, 
		op_type_,
		USER,
		SYSDATE
	);
END;
/
/*

INSERT INTO MANAGERS(MANAGERID, MANAGERNAME, POSITION) VALUES ('5', 'TEST MANAGER', 'TEST POSS'); 
UPDATE MANAGERS SET MANAGERNAME = 'TEST MANAGER 2' WHERE MANAGERID = '5; 
DELETE FROM MANAGERS WHERE MANAGERID = '5; 

NEW_MANAGER_ID NEW_MANAGER_NAME                         NEW_MANAGER_POITION       OLD_MANAGER_NAME                         OLD_MANAGER_POITION       OP_TYP USER_NAME            CHANGE_DAT
-------------- ---------------------------------------- ------------------------- ---------------------------------------- ------------------------- ------ -------------------- ----------
             5 TEST MANAGER                             TEST POSS                                                                                    INSERT ADMIN                27.12.2022
             5 TEST MANAGER 2                           TEST POSS                 5                                        TEST MANAGER              UPDATE ADMIN                27.12.2022
                                                                                  5                                        TEST MANAGER 2            DELETE ADMIN                27.12.2022
*/

/*
2. Припустимо, що використовується СУБД до 12-ї версії, яка не підтримує механізм
DEFAULT SEQUENCE, який дозволяє автоматично внести нове значення первинного ключа, 
якщо воно не задано при операції внесення. Для будь-якої колонки вашої бази даних 
створити тригер з підтримкою механізму DEFAULT SEQUENCE. Навести тест-кейс перевірки
роботи тригера.
*/
CREATE SEQUENCE CLIENTS_ID 
  MINVALUE 1
  MAXVALUE 1000
  START WITH 9
  INCREMENT BY 1
  CACHE 10;

CREATE TRIGGER client_default_sequence 
	BEFORE INSERT 
	ON CLIENTS 
	FOR EACH ROW
BEGIN
	if :NEW.clientid IS NULL THEN
		:NEW.clientid := CLIENTS_ID.NEXTVAL;
	END IF;
END;
/

/*
INSERT INTO CLIENTS (CLIENTID, CLIENTNAME, MANAGERID, BIRTHDAY)
VALUES (NULL, 'Test Name', '1', '10/10/2010'); 
-- new record inserted with CLIENTID value = 9
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY  
---------- ---------------------------------------- ---------- ----------
9          Test Name                                1          10.10.2010
1          Andrey Yanovskiy                         3          17.09.2000
2          Filip Mueller                            2          13.10.2001
3          Sulaiman Davis                           1          02.09.1993
4          Faisal Wall                              2          25.05.1973
5          Olivier Farrell                          2          16.11.1964
6          Brandon Buchanan                         1          15.03.1996
7          Stuart Glass                             1          10.10.1964
8          Rafael Petersen                          2          19.11.1955

9 rows selected. 
*/


