
/*
4.1 Повторити рішення завдання 3.1
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