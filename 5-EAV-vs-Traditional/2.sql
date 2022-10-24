
/*
2.1. Створити таблицю описів атрибутних типів.
*/
CREATE TABLE ATTRTYPE (
    ATTR_ID      		NUMBER(20),
    OBJECT_TYPE_ID 		NUMBER(20),
	OBJECT_TYPE_ID_REF 	NUMBER(20),
    CODE         		VARCHAR2(20),
    NAME         		VARCHAR2(200)
);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_PK
	PRIMARY KEY (ATTR_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_FK
	FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
ALTER TABLE ATTRTYPE ADD CONSTRAINT ATTRTYPE_OBJECT_TYPE_ID_REF_FK
	FOREIGN KEY (OBJECT_TYPE_ID_REF) REFERENCES OBJTYPE (OBJECT_TYPE_ID);
/*
Table altered.
*/

/*
2.2 Для раніше використаних класів UML-діаграми заповнити описи атрибутних типів.
*/
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (1, 1, NULL, 'managerId', 'persomal manager id');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (2, 1, NULL, 'managerName', 'name');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (3, 2, NULL, 'clientId', 'personal client id');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (4, 2, NULL, 'clientName', 'name');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (5, 2, NULL, 'managerId', 'manager id');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (6, 2, NULL, 'birthday', 'birthday');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (7, 3, NULL, 'billId', 'bill id');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (8, 3, NULL, 'clientId', 'client id');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (9, 3, NULL, 'packageId', 'package id');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (10, 3, NULL, 'billAmount', 'amount of bill');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (11, 3, NULL, 'billDate', 'date of bill');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (12, 1, 2, 'support', 'mng support client');
INSERT INTO ATTRTYPE (ATTR_ID,OBJECT_TYPE_ID,OBJECT_TYPE_ID_REF,CODE,NAME)
    VALUES (13, 2, 3, 'have', 'clnt have bill');
/*

*/

/*
2.3 Отримати інформацію про атрибутні типи.
*/
SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME
	FROM OBJTYPE O, ATTRTYPE A
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;
/*

*/

/*
2.4 Отримати інформацію про атрибутні типи та можливі зв'язки між ними типу «іменована
асоціація».
*/
SELECT O.CODE,A.ATTR_ID,A.CODE,A.NAME, O_REF.CODE O_REF
	FROM OBJTYPE O, ATTRTYPE A LEFT JOIN OBJTYPE O_REF ON 
								(A.OBJECT_TYPE_ID_REF = O_REF.OBJECT_TYPE_ID)
	WHERE O.OBJECT_TYPE_ID = A.OBJECT_TYPE_ID
	ORDER BY A.OBJECT_TYPE_ID,A.ATTR_ID;
/*
CODE        ATTR_ID CODE       NAME                 O_REF
---------- -------- ---------- -------------------- --------------------
Manager           1 managerId  persomal manager id
Manager           2 managerNam name
                    e

Manager          12 support    mng support client   Client
Client            3 clientId   personal client id
Client            4 clientName name
Client            5 managerId  manager id
Client            6 birthday   birthday
Client           13 have       clnt have bill       BILL
BILL              7 billId     bill id
BILL              8 clientId   client id
BILL              9 packageId  package id
BILL             10 billAmount amount of bill
BILL             11 billDate   date of bill

13 rows selected.

*/