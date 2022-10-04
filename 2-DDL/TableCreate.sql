
CREATE TABLE Client(
    clientId VARCHAR(10), 
    clientName VARCHAR(40), 
    billId VARCHAR(25)
);

CREATE TABLE Bill(
   billId VARCHAR(10), 
   packageId VARCHAR(10), 
   billAmount NUMBER(10,4),
   billDate DATE
);

CREATE TABLE Manager(
    managerId VARCHAR(10), 
    managerName VARCHAR(40),
    clientId VARCHAR(10)
);

CREATE TABLE InternetPackage(
    packageId VARCHAR(10), 
    packagePrivaPerMonth NUMBER(10, 2)
);
