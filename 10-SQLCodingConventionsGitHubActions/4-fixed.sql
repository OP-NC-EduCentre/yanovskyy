SELECT
    client.clientname,
    internetpackage.packagetitle
FROM client, internetpackage;

SELECT
    bill.billamount,
    bill.billdate,
    client.clientname
FROM bill, client
WHERE client.clientid = bill.clientid;

SELECT
    bill.billamount,
    bill.billdate,
    client.clientname
FROM bill, client
WHERE
    bill.clientid = client.clientid;
