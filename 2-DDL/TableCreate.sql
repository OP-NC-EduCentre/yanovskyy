
CREATE TABLE Client(
    clientId VARCHAR(10), 
    clientName VARCHAR(40), 
    managerId VARCHAR(10),
    birthday DATE
);

CREATE TABLE Manager(
    managerId VARCHAR(10), 
    managerName VARCHAR(40)
);

CREATE TABLE Bill(
   billId VARCHAR(10), 
   clientId VARCHAR(10),
   packageId VARCHAR(10), 
   billAmount NUMBER(10,4),
   billDate DATE
);

CREATE TABLE InternetPackage(
    packageId VARCHAR(10), 
    packageTitle VARCHAR(20), 
    pricePerMonth NUMBER(6, 2)
);
