
ALTER SESSION SET NLS_DATE_FORMAT = 'dd/mm/yyyy';

ALTER TABLE Client ADD CONSTRAINT client_clientId_unique
    UNIQUE (clientId);
ALTER TABLE Client ADD CONSTRAINT client_managerId_unique
    UNIQUE (managerId);
ALTER TABLE Client MODIFY (clientId NOT NULL); 
ALTER TABLE Client MODIFY (managerId NOT NULL); 
ALTER TABLE Client MODIFY (clientName NOT NULL);
ALTER TABLE Client MODIFY (birthday NOT NULL); 

ALTER TABLE Manager ADD CONSTRAINT manager_managerId_unique
    UNIQUE (managerId);
ALTER TABLE Manager MODIFY (managerId NOT NULL); 
ALTER TABLE Manager MODIFY (managerName NOT NULL); 

ALTER TABLE Bill ADD CONSTRAINT bill_billId_unique
    UNIQUE (billId); 
ALTER TABLE Bill MODIFY (clientId NOT NULL); 
ALTER TABLE Bill MODIFY (billId NOT NULL); 
ALTER TABLE Bill MODIFY (packageId NOT NULL); 
ALTER TABLE Bill MODIFY (billAmount NOT NULL); 
ALTER TABLE Bill MODIFY (billDate NOT NULL); 

ALTER TABLE InternetPackage ADD CONSTRAINT internetPackage_unique 
    UNIQUE (packageId); 
ALTER TABLE InternetPackage MODIFY (packageId NOT NULL); 
ALTER TABLE InternetPackage MODIFY (packageTitle NOT NULL); 
ALTER TABLE InternetPackage MODIFY (pricePerMonth NOT NULL); 

ALTER TABLE Client ADD CONSTRAINT client_pk 
    PRIMARY KEY (clientId);
ALTER TABLE Manager ADD CONSTRAINT manager_pk
    PRIMARY KEY (managerId);
ALTER TABLE Bill ADD CONSTRAINT bill_pk 
    PRIMARY KEY (billId); 
ALTER TABLE InternetPackage ADD CONSTRAINT internetPackage_pk
    PRIMARY KEY (packageId); 

ALTER TABLE Client ADD CONSTRAINT client_managerId_fk
    FOREIGN KEY (managerId) REFERENCES Manager(managerId); 
ALTER TABLE Bill ADD CONSTRAINT bill_packageId_fk
    FOREIGN KEY (packageId) REFERENCES InternetPackage(packageId); 
ALTER TABLE Bill ADD CONSTRAINT bill_clientId_fk 
    FOREIGN KEY (clientId) REFERENCES Client(clientId); 

