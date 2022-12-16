
/*
4.1 Повторити рішення завдання 3.1
*/
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L027	1 / 8	
Unqualified reference 'clientname' found in select with more than one referenced table/view.
L027	1 / 20	
Unqualified reference 'packagetitle' found in select with more than one referenced table/view.
L014	1 / 38	
Unquoted identifiers must be consistently lower case.
L014	1 / 46	
Unquoted identifiers must be consistently lower case.
*/
SELECT clientname, packagetitle FROM CLIENT, INTERNETPACKAGE;
/*
CLIENTNAME                               PACKAGETITLE
---------------------------------------- --------------------
Name 1                                   standart
Name 1                                   pro
Name 1                                   ultra
Name 1                                   unlim
Name 1                                   unlim+
Name 2                                   standart
Name 2                                   pro
Name 2                                   ultra
Name 2                                   unlim
Name 2                                   unlim+
Name3                                    standart

CLIENTNAME                               PACKAGETITLE
---------------------------------------- --------------------
Name3                                    pro
Name3                                    ultra
Name3                                    unlim
Name3                                    unlim+
L                                        standart
L                                        pro
L                                        ultra
L                                        unlim
L                                        unlim+
Liam                                     standart
Liam                                     pro

CLIENTNAME                               PACKAGETITLE
---------------------------------------- --------------------
Liam                                     ultra
Liam                                     unlim
Liam                                     unlim+
Liam Nisson                              standart
Liam Nisson                              pro
Liam Nisson                              ultra
Liam Nisson                              unlim
Liam Nisson                              unlim+
*/

/*
4.2 Повторити рішення завдання 3.2
*/
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L001	1 / 46	
Unnecessary trailing whitespace.
L003	2 / 5	
Expected 0 indentations, found 1 [compared to line 01]
L014	2 / 10	
Unquoted identifiers must be consistently lower case.
L011	2 / 15	
Implicit/explicit aliasing of table.
L031	2 / 15	
Avoid aliases in from clauses and join conditions.
L014	2 / 18	
Unquoted identifiers must be consistently lower case.
L011	2 / 25	
Implicit/explicit aliasing of table.
L031	2 / 25	
Avoid aliases in from clauses and join conditions.
L001	2 / 26	
Unnecessary trailing whitespace.
L003	3 / 5	
Expected 0 indentations, found 1 [compared to line 01]
*/
SELECT b.billamount, b.billdate, c.clientname 
    FROM BILL b, CLIENT c 
    WHERE c.clientid = b.clientid;
/*
BILLAMOUNT BILLDATE  CLIENTNAME
---------- --------- ----------------------------------------
       199 02-OCT-22 Name 1
       199 10-OCT-22 Name 1
       299 02-NOV-22 Name 2
*/

/*
4.3 Повторити рішення завдання 3.4
*/
/*
L036	1 / 1	
Select targets should be on a new line unless there is only one select target.
L001	1 / 46	
Unnecessary trailing whitespace.
L003	2 / 5	
Expected 0 indentations, found 1 [compared to line 01]
L014	2 / 10	
Unquoted identifiers must be consistently lower case.
L011	2 / 15	
Implicit/explicit aliasing of table.
L031	2 / 15	
Avoid aliases in from clauses and join conditions.
L014	2 / 18	
Unquoted identifiers must be consistently lower case.
L011	2 / 25	
Implicit/explicit aliasing of table.
L031	2 / 25	
Avoid aliases in from clauses and join conditions.
L001	2 / 26	
Unnecessary trailing whitespace.
L003	3 / 5	
Expected 0 indentations, found 1 [compared to line 01]
PRS	3 / 35	
Line 3, Position 35: Found unparsable section: '+'
*/
SELECT b.billamount, b.billdate, c.clientname 
    FROM BILL b, CLIENT c 
    WHERE b.clientid = c.clientid(+);
/*
BILLAMOUNT BILLDATE  CLIENTNAME
---------- --------- ----------------------------------------
       199 02-OCT-22 Name 1
       199 10-OCT-22 Name 1
       299 02-NOV-22 Name 2
*/