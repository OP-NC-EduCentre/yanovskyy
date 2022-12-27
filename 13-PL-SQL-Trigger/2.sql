/*
1. Створити тригер для реалізації каскадного видалення рядків зі значеннями PK- колонки,
 пов'язаних з FK-колонкою. Навести тест-кейс перевірки роботи тригера.
*/
CREATE OR REPLACE TRIGGER CASCAD_DELETING_CLIENT_AND_MANAGE
    BEFORE DELETE
    ON CLIENTS
    FOR EACH ROW
BEGIN
    DELETE
    FROM MANAGERS
    WHERE MANAGERS.MANAGERID = :old.MANAGERID;
END;
/
/*
BEFORE: 
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY  
---------- ---------------------------------------- ---------- ----------
1          Andrey Yanovskiy                         3          17.09.2000
2          Filip Mueller                            2          13.10.2001
9          TEST CLIENT                              5          10.10.2010
3          Sulaiman Davis                           1          02.09.1993
4          Faisal Wall                              2          25.05.1973
5          Olivier Farrell                          2          16.11.1964
6          Brandon Buchanan                         1          15.03.1996
7          Stuart Glass                             1          10.10.1964
8          Rafael Petersen                          2          19.11.1955

MANAGERID  MANAGERNAME                              POSITION                 
---------- ---------------------------------------- -------------------------
1          Nick Johanson                            Junior Manager           
2          Kamal Elliott                            Junior Manager           
3          Kelvin Tate                              Higt Manager             
4          Tomas Glover                             BOSS                     
5          TEST MANAGER                             TEST POSS                

AFTER: 
CLIENTID   CLIENTNAME                               MANAGERID  BIRTHDAY  
---------- ---------------------------------------- ---------- ----------
1          Andrey Yanovskiy                         3          17.09.2000
2          Filip Mueller                            2          13.10.2001
3          Sulaiman Davis                           1          02.09.1993
4          Faisal Wall                              2          25.05.1973
5          Olivier Farrell                          2          16.11.1964
6          Brandon Buchanan                         1          15.03.1996
7          Stuart Glass                             1          10.10.1964
8          Rafael Petersen                          2          19.11.1955

MANAGERID  MANAGERNAME                              POSITION                 
---------- ---------------------------------------- -------------------------
1          Nick Johanson                            Junior Manager           
2          Kamal Elliott                            Junior Manager           
3          Kelvin Tate                              Higt Manager             
4          Tomas Glover                             BOSS                     
*/

/*
2. Створити тригер для реалізації предметно-орієнтованого контролю спроби додавання значення
 FK-колонки, що не існує у PK-колонці. Навести тест-кейс перевірки роботи тригера.
*/
CREATE OR REPLACE TRIGGER client_insert_check_managerid_valid
    BEFORE INSERT
    ON CLIENTS
    FOR EACH ROW
DECLARE
    manager_id clients.managerid%TYPE;
BEGIN
    SELECT MANAGERID
    INTO manager_id
    FROM MANAGERS
    WHERE MANAGERID = :new.MANAGERID;
EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20551, 'Manager with id=' || :new.MANAGERID || ' NOT exist!!!');
END;
/
/*
--insert into clients values ('9', 'Test client', 9, '10/10/2010'); 
Error starting at line : 1 in command -
insert into clients values ('9', 'Test client', 9, '10/10/2010')
Error report -
ORA-20551: Manager with id=9 NOT exist!!!
ORA-06512: at "ADMIN.CLIENT_INSERT_CHECK_MANAGERID_VALID", line 10
ORA-04088: error during execution of trigger 'ADMIN.CLIENT_INSERT_CHECK_MANAGERID_VALID'
*/


