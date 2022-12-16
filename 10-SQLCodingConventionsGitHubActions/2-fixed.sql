CREATE TABLE Client(
    ClientId VARCHAR(10),
    ClientName VARCHAR(40),
    ManagerId VARCHAR(10),
    Birthday DATE
);

CREATE TABLE Manager(
    ManagerId VARCHAR(10),
    ManagerName VARCHAR(40)
);

CREATE TABLE Bill(
    BillId VARCHAR(10),
    ClientId VARCHAR(10),
    PackageId VARCHAR(10),
    BillAmount NUMBER(10, 4),
    BillDate DATE
);

CREATE TABLE InternetPackage(
    PackageId VARCHAR(10),
    PackageTitle VARCHAR(20),
    PricePerMonth NUMBER(6, 2)
);
