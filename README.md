# cloud_broker_SQL_project

Cloud Broker is a company which helps customers to buy their own servers and databases and host them on their chosen cloud provider

The ERD for the Database 
![Cloud BRroker ERD](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/3a05b189-6941-4af0-a4ca-eb573f3545ac)

After the DB is created , there are 10 cases to provide some query that produces important data.

1. Display customer name and Cloud Providers Count (obtained from the total of purchased cloud providers by the customer) for every customer whose name contains the letter “e” and the birthdate day is even number.

SELECT c.Name, COUNT(trans.TransactionID) AS `Cloud Providers Count`
FROM CustomerData AS c
JOIN TransactionHeader AS trans ON c.CustomerID = trans.CustomerID
JOIN TransactionDetail AS td ON trans.TransactionID = td.TransactionID
WHERE (c.Name LIKE '%e%' AND DAY(c.DoB) % 2 = 0)
GROUP BY c.Name, trans.TransactionID;

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/9445e9b0-e2df-4375-8970-e8a701f1c242)

2.	Display server name and Total Price (obtained from the sum of server price, operating system price, and database price with “Rp” added at  the front, then replacing “.00” with “,-”, for every server with memory more than 2 and database storage more than 1

SELECT DISTINCT s.Name, CONCAT('Rp. ', CAST((s.Price + db.Price + os.Price) AS CHAR), '.-') AS `Price`
FROM `Database` AS db
JOIN TransactionDetail AS td ON db.DBID = td.DBID
JOIN `Server` AS s ON td.ServerID = s.ServerID
JOIN OperatingSystem AS os ON s.OSID = os.OSID
WHERE (s.Memory > 2 AND db.Storage > 1);

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/199c1729-a8e6-4c50-b6fe-704daf6667b6)

3.	Display Initial (obtained from the first letter from the first word of customer name and first letter from the second word of customer name), Database Price (obtained from the total of all databases price which was purchased by the customer), and Transaction Count (obtained from the total of transactions made by the customer) for every database with storage more than 2 and the customer gender is female.

SELECT DISTINCT c.Name, CONCAT(LEFT(c.Name, 1), SUBSTRING(c.Name, INSTR(c.Name, ' ') + 1, 1)) AS `Name`,
       COUNT(trans.TransactionID) AS `Database Count`,
       SUM(db.Price) AS `Database Price`
FROM CustomerData AS c
JOIN TransactionHeader AS trans ON c.CustomerID = trans.CustomerID
JOIN TransactionDetail AS td ON trans.TransactionID = td.TransactionID
JOIN `Database` AS db ON td.DBID = db.DBID
WHERE (c.Gender LIKE 'Female' AND db.Storage > 2)
GROUP BY c.Name, db.Price;

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/9eb870ab-67b1-4941-a707-add373f2a1c4)

4.	Display Cloud Company (obtained from the first word of cloud provider name and “ Company” added at the end), Total Transaction (obtained from the total of transactions which include the cloud provider), and Customer Average Account Balance (obtained from the average of customer account balance) for every cloud provider name which contains the word “Cloud” and Total Transaction more than 1.

SELECT CONCAT(LEFT(p.Name, INSTR(p.Name, ' ') - 1), 'Company') AS `Cloud Company`,
       COUNT(td.TransactionID) AS `Total Transaction`,
       AVG(cd.MoneyBalance) AS `Customer Average Account Balance`
FROM Provider p
JOIN TransactionHeader th ON th.ProviderID = p.ProviderID
JOIN CustomerData cd ON cd.CustomerID = th.CustomerID
JOIN TransactionDetail td ON td.TransactionID = th.TransactionID
GROUP BY p.Name, td.TransactionID, cd.MoneyBalance
HAVING p.Name LIKE '%Cloud%' AND COUNT(td.TransactionID) > 1;

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/578028e3-3cb2-434c-a03c-5ac339374d33)

5.	Display Server Initial (obtained from the first five letters of server name, combined with “-“, and combined with the last three letters of server ID in uppercased form), processor name, and server storage for every server storage that is more than maximum storage of all databases and processor cores at least 4.

SELECT CONCAT(UPPER(LEFT(p.Name, 5)), '-', SUBSTRING(s.ServerID, 3, 3)) AS `Server Initial`,
       process.Name,
       s.Storage AS `Server Storage`,
       process.Cores AS `Cores`
FROM Provider p
JOIN TransactionHeader th ON th.ProviderID = p.ProviderID
JOIN CustomerData cd ON cd.CustomerID = th.CustomerID
JOIN TransactionDetail td ON td.TransactionID = th.TransactionID
JOIN Server s ON s.ServerID = td.ServerID
JOIN `Database` db ON td.DBID = db.DBID
JOIN Processor process ON process.ProcessorID = s.ProcessorID
WHERE (s.Storage > db.Storage AND process.Cores >= 4);

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/2db373fa-238d-4f4a-b024-d230e3575ee2)

6.	Display DBMS software name, database price, database storage with “GB” added at the back, and DBMS software website URL with “https://” removed for every database with price above the average price of all servers and DBMS software name contains “DB”.

SELECT `Name`, Price,
       CONCAT(CAST(Storage AS CHAR), 'GB') AS `Database Storage`,
       REPLACE(`Name`, 'https://', '') AS `Website URL`
FROM DatabaseSoftware ds
JOIN `Database` d ON d.DSID = ds.DSID
WHERE d.Price > (
    SELECT AVG(Price)
    FROM `Server`
) AND ds.`Name` LIKE '%DB%';

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/619a5ac6-9df5-45b1-aacc-b2cc4e25292f)

7.	Display Server Code (obtained from the first five letters of server name, combined with “-“, combined with the last two letters of server ID, combined with “-“, and combined with database storage, all in uppercase), Storage (obtained from database storage with “GB” added at the end), and Price (obtained from database price with “Rp” added at the front) for every server with price above the maximum price from all operating systems, and server storage above the average storage of all databases.

SELECT CONCAT(UPPER(SUBSTRING(s.`Name`, 1, 5)), '-', RIGHT(s.ServerID, 2), '-', CAST(s.Storage AS CHAR)) AS `Server Code`,
       CONCAT(CAST(d.Storage AS CHAR), 'GB') AS `Storage`,
       CONCAT('Rp', CAST(d.Price AS CHAR)) AS `Price`
FROM `Server` s
JOIN TransactionDetail td ON td.ServerID = s.ServerID
JOIN `Database` d ON d.DBID = td.DBID
WHERE s.Price > (
    SELECT MAX(Price)
    FROM OperatingSystem
) AND s.Storage > (
    SELECT AVG(Storage)
    FROM `Database`
);

8.	Display Database Code (obtained from the last three letters from database ID, combined with “-“, combined with the last three letters from DBMS software ID, combined with “-“, and combined with database storage with “GB” added at the end) for every database with price between the minimum price of all servers and the average price of all operating systems, and DBMS software ID either “DS006” or “DS007”.

SELECT CONCAT(RIGHT(d.DBID, 3), '-', RIGHT(ds.DSID, 3), '-GB') AS `Database Code`
FROM `Database` d
JOIN DatabaseSoftware ds ON d.DSID = ds.DSID
WHERE (d.Price BETWEEN
    (SELECT MIN(Price) FROM `Server`) AND
    (SELECT AVG(Price) FROM OperatingSystem)
) AND ds.DSID IN ('DS006', 'DS007');

9.	Create a view named as “Affordable Server View” to display server name, processor name, operating system name, and server memory with “GB” added at the end for every server with price is between the cheapest price of all servers and average price of all servers, and memory is at least 4.

CREATE VIEW `Affordable Server View` AS
SELECT s.`Name` AS `Server Name`,
       p.`Name` AS `Processor Name`,
       os.`Name` AS `Operating System Name`,
       CONCAT(CAST(s.Memory AS CHAR), 'GB') AS `Server Memory`
FROM `Server` s
JOIN Processor p ON p.ProcessorID = s.ProcessorID
JOIN OperatingSystem os ON os.OSID = s.OSID
WHERE s.Price BETWEEN
    (SELECT MIN(Price) FROM `Server`) AND
    (SELECT AVG(Price) FROM `Server`);

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/d2ffe084-494d-49fb-862e-60c8791f51fe)

10.	Create a view named as “Popular Cheap Databases View” to display database name, website URL, and storage with “GB” added at the end, and Transaction Count (obtained from the total of transactions which include the database) for every database with price equals or below the average price of all databases and Transaction Count more than 2.

CREATE VIEW `Popular Cheap Databases View` AS
SELECT ds.`Name` AS `Database Name`,
       ds.`URL` AS `Website URL`,
       CONCAT(CAST(d.Storage AS CHAR), 'GB') AS `Storage`,
       (
          SELECT COUNT(TransactionID)
          FROM TransactionDetail td
          WHERE td.DBID = d.DBID
          HAVING COUNT(TransactionID) > 2
       ) AS `Transaction Count`
FROM DatabaseSoftware ds
JOIN `Database` d ON d.DSID = ds.DSID
WHERE d.Price <= (
    SELECT AVG(Price)
    FROM `Database`
) AND (
    SELECT COUNT(TransactionID)
    FROM TransactionDetail td
    WHERE td.DBID = d.DBID
) > 2;

![image](https://github.com/KevinTanoto/cloud_broker_SQL_project/assets/105341706/811c636e-5079-4819-a835-216f980d6a94)






