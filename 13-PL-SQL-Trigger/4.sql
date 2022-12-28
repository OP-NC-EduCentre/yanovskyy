/*
1. Створити таблицю для реєстрації наступних DDL-подій: тип події, 
що спричинила запуск тригера; ім'я користувача; ім'я об'єкта БД. 
Створити тригер реєстрації заданих подій створення об'єктів. 
Подати тест-кейси перевірки роботи тригера.
*/
CREATE TABLE DLL_TRACING
(
    operation   VARCHAR2(30),
    user_name   VARCHAR2(30),
    obj_name    VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER DLL_TRACING
    AFTER CREATE OR ALTER OR DROP
    ON ADMIN.SCHEMA
BEGIN
    INSERT INTO DLL_TRACING 
    VALUES(
		ORA_SYSEVENT, 
		ORA_LOGIN_USER, 
		ORA_DICT_OBJ_NAME
    );
END;
/
/*
RESULT DLL_TRACING TABLE: 
OPERATION                      USER_NAME                      OBJ_NAME                      
------------------------------ ------------------------------ ------------------------------
CREATE                         ADMIN                          TEST_TABLE                    
ALTER                          ADMIN                          TEST_TABLE                    
DROP                           ADMIN                          TEST_TABLE                    

*/


