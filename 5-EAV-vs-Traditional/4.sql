
/*
4.1 Створити таблицю описів екземплярів об'єктів.
*/
CREATE TABLE OBJECTS (
	OBJECT_ID      NUMBER(20),
	PARENT_ID      NUMBER(20),
	OBJECT_TYPE_ID NUMBER(20),
	NAME           VARCHAR2(2000),
	DESCRIPTION    VARCHAR2(4000)
);

ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PK
	PRIMARY KEY (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_PARENT_ID_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJECTS (OBJECT_ID);
ALTER TABLE OBJECTS ADD CONSTRAINT OBJECTS_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
/*

*/


/*
4.2 На основі вмісту двох рядків двох таблиць, заповнених у лабораторній роботі №3,
заповнити описи екземплярів об'єктів.
*/
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION)
    VALUES (1, NULL, 1, 'Ivanov Ivan Ivanovich', 'Manager');
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION)
    VALUES (2, 1, 2, 'Stepan Bendera', 'Client');
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION)
    VALUES (3, 1, 2, 'Taras Grugorocich Shevchenko', 'Client');
INSERT INTO OBJECTS (OBJECT_ID,PARENT_ID,OBJECT_TYPE_ID,NAME,DESCRIPTION)
    VALUES (4, 1, 2, 'Artemenko Artem Artemovich', 'Client');
/*

*/


/*
4.3 Отримати колекцію екземплярів об'єктів для одного з об'єктних типів, використовуючи
його код.
*/
SELECT OBJECT_ID,NAME
FROM OBJECTS;
/*
OBJECT_ID NAME
--------- --------------------
        1 Ivanov Ivan Ivanovic
          h

        2 Stepan Bendera
        3 Taras Grugorocich Sh
          evchenko

        4 Artemenko Artem Arte
          movich
*/


/*
4.4 Отримати один екземпляр об'єкта заданого імені для одного з об'єктних типів,
використовуючи його код.
*/
SELECT OBJECT_ID,NAME
	FROM OBJECTS
	WHERE OBJECT_TYPE_ID = 1;
/*
OBJECT_ID NAME
--------- --------------------
        1 Ivanov Ivan Ivanovic
          h
*/