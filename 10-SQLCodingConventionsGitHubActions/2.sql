/*
L014	2 / 5	
Unquoted identifiers must be consistently pascal case.
L001	2 / 26	
Unnecessary trailing whitespace.
L008	2 / 26	
Commas should be followed by a single whitespace unless followed by a comment.
L014	3 / 5	
Unquoted identifiers must be consistently pascal case.
L001	3 / 28	
Unnecessary trailing whitespace.
L008	3 / 28	
Commas should be followed by a single whitespace unless followed by a comment.
L014	4 / 5	
Unquoted identifiers must be consistently pascal case.
L014	5 / 5	
Unquoted identifiers must be consistently pascal case.
*/
CREATE TABLE Client(
    clientId VARCHAR(10), 
    clientName VARCHAR(40), 
    managerId VARCHAR(10),
    birthday DATE
);
/*
L014	2 / 5	
Unquoted identifiers must be consistently pascal case.
L001	2 / 27	
Unnecessary trailing whitespace.
L008	2 / 27	
Commas should be followed by a single whitespace unless followed by a comment.
L014	3 / 5	
Unquoted identifiers must be consistently pascal case.
*/
CREATE TABLE Manager(
    managerId VARCHAR(10), 
    managerName VARCHAR(40)
);
/*
L003	2 / 4	
Expected 1 indentation, found less than 1 [compared to line 01]
L014	2 / 4	
Unquoted identifiers must be consistently pascal case.
L001	2 / 23	
Unnecessary trailing whitespace.
L008	2 / 23	
Commas should be followed by a single whitespace unless followed by a comment.
L003	3 / 4	
Expected 1 indentation, found less than 1 [compared to line 01]
L014	3 / 4	
Unquoted identifiers must be consistently pascal case.
L003	4 / 4	
Expected 1 indentation, found less than 1 [compared to line 01]
L014	4 / 4	
Unquoted identifiers must be consistently pascal case.
L001	4 / 26	
Unnecessary trailing whitespace.
L008	4 / 26	
Commas should be followed by a single whitespace unless followed by a comment.
L003	5 / 4	
Expected 1 indentation, found less than 1 [compared to line 01]
L014	5 / 4	
Unquoted identifiers must be consistently pascal case.
L008	5 / 24	
Commas should be followed by a single whitespace unless followed by a comment.
L003	6 / 4	
Expected 1 indentation, found less than 1 [compared to line 01]
L014	6 / 4	
Unquoted identifiers must be consistently pascal case.
*/
CREATE TABLE Bill(
   billId VARCHAR(10), 
   clientId VARCHAR(10),
   packageId VARCHAR(10), 
   billAmount NUMBER(10,4),
   billDate DATE
);
/*
L014	2 / 5	
Unquoted identifiers must be consistently pascal case.
L001	2 / 27	
Unnecessary trailing whitespace.
L008	2 / 27	
Commas should be followed by a single whitespace unless followed by a comment.
L014	3 / 5	
Unquoted identifiers must be consistently pascal case.
L001	3 / 30	
Unnecessary trailing whitespace.
L008	3 / 30	
Commas should be followed by a single whitespace unless followed by a comment.
L014	4 / 5	
Unquoted identifiers must be consistently pascal case.
*/
CREATE TABLE InternetPackage(
    packageId VARCHAR(10), 
    packageTitle VARCHAR(20), 
    pricePerMonth NUMBER(6, 2)
);
