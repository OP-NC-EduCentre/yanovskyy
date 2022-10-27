
/*
1.1. Створити таблицю опису об'єктних типів.
*/
CREATE TABLE OBJTYPE (
	OBJECT_TYPE_ID NUMBER(20),
	PARENT_ID      NUMBER(20),
	CODE           VARCHAR2(20),
	NAME           VARCHAR2(200),
	DESCRIPTION    VARCHAR2(1000)
);

ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_PK
	PRIMARY KEY (OBJECT_TYPE_ID);
ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_CODE_UNIQUE
	UNIQUE (CODE);
ALTER TABLE OBJTYPE 
	MODIFY (CODE NOT NULL);
ALTER TABLE OBJTYPE ADD CONSTRAINT OBJTYPE_FK
	FOREIGN KEY (PARENT_ID) REFERENCES OBJTYPE(OBJECT_TYPE_ID);
/*

*/

/*
1.2 Нехай у лабораторній роботі №1 було створено UML-діаграму концептуальних класів. Для
трьох класів з UML-діаграми, пов'язаних між собою, бажано зв'язком «узагальнення», «агрегатна
асоціація» та «іменована асоціація», заповнити опис об'єктних типів.
*/
INSERT INTO OBJTYPE (OBJECT_TYPE_ID,PARENT_ID,CODE,NAME,DESCRIPTION)
    VALUES (1, NULL, 'Manager', 'Менеджер', NULL);
INSERT INTO OBJTYPE (OBJECT_TYPE_ID,PARENT_ID,CODE,NAME,DESCRIPTION)
    VALUES (2, NULL, 'Client', 'Клієнт', NULL);
INSERT INTO OBJTYPE (OBJECT_TYPE_ID,PARENT_ID,CODE,NAME,DESCRIPTION)
    VALUES (3, NULL, 'BILL', 'Рахунок', NULL);
/*
1 row added
1 row added
1 row added
*/

/*
1.3 Отримати інформацію про об'єктні типи.
*/
SELECT * FROM OBJTYPE;
/*
OBJECT_TYPE_ID PARENT_ID CODE       NAME                 DESCRIPTION
-------------- --------- ---------- -------------------- -------------
             1           Manager    Менеджер
             2         1 Client     Кл?єнт
             3         2 BILL       Рахунок
*/

/*
1.4 Отримати інформацію про об'єктні типи та можливі зв'язки між ними типу «узагальнення»,
«агрегатна асоціація».
*/

/*

*/