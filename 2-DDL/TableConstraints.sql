
ALTER TABLE Client ADD CONSTRAINT client_clientId_billId_unique
    UNIQUE (clientId, billId);
ALTER TABLE Client MODIFY (clientId NOT NULL); 
ALTER TABLE Client MODIFY (clientName NOT NULL);

ALTER TABLE Manager MODIFY (clientId NOT NULL); 
ALTER TABLE Manager ADD CONSTRAINT managerId_unique
    UNIQUE (managerId, clientId);

ALTER TABLE Bill ADD CONSTRAINT bill_unique 
    UNIQUE (billId, packageId); 
ALTER TABLE Bill MODIFY (billId NOT NULL); 
ALTER TABLE Bill MODIFY (packageId NOT NULL); 
ALTER TABLE Bill MODIFY (billAmount NOT NULL); 
ALTER TABLE Bill MODIFY (billDate NOT NULL); 

ALTER TABLE InternetPackage ADD CONSTRAINT internetPackage_unique 
    UNIQUE (packageId); 


ALTER TABLE Client ADD CONSTRAINT client_pk 
    PRIMARY KEY (clientId);
ALTER TABLE Manager ADD CONSTRAINT manager_pk
    PRIMARY KEY managerId;
ALTER TABLE Bill ADD CONSTRAINT bill_pk 
    PRIMARY KEY (billId); 
ALTER TABLE InternetPackage ADD CONSTRAINT internetPackage_pk
    PRIMARY KEY (packageId); 

ALTER TABLE Client ADD CONSTRAINT client_fk 
    FOREIGN KEY (billId) REFERENCES Bill(billId); 
ALTER TABLE Manager ADD CONSTRAINT manager_clientId_fk
    FOREIGN KEY (clientId) REFERENCES Client(clientId);
ALTER TABLE Bill ADD CONSTRAINT bill_fk 
    FOREIGN KEY (packageId) REFERENCES InternetPackage(packageId); 

