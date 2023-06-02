CREATE TABLE CustomerData (
    CustomerID CHAR(5) PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Address VARCHAR(255),
    DoB DATE,
    Gender VARCHAR(255),
    PhoneNumber VARCHAR(255),
    Password VARCHAR(255),
    MoneyBalance DECIMAL(15,2)
);

CREATE TABLE Provider (
    ProviderID CHAR(5) PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    Region VARCHAR(255),
    URL VARCHAR(255)
);

CREATE TABLE TransactionHeader (
    TransactionID VARCHAR(5) PRIMARY KEY,
    CustomerID VARCHAR(5),
    ProviderID VARCHAR(5),
    TransactionDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES CustomerData(CustomerID),
    FOREIGN KEY (ProviderID) REFERENCES Provider(ProviderID)
);

CREATE TABLE DatabaseSoftware (
    DSID CHAR(5) PRIMARY KEY,
    Name VARCHAR(255),
    URL VARCHAR(255)
);

CREATE TABLE `Database` (
    DBID CHAR(5) PRIMARY KEY,
    DSID CHAR(5),
    Storage INT,
    Price DECIMAL(15,2),
    FOREIGN KEY (DSID) REFERENCES DatabaseSoftware(DSID)
);

CREATE TABLE Processor (
    ProcessorID CHAR(5) PRIMARY KEY,
    Name VARCHAR(255),
    Cores INT,
    BaseClock INT,
    BoostClock INT
);

CREATE TABLE OperatingSystem (
    OSID CHAR(5) PRIMARY KEY,
    Name VARCHAR(255),
    Family VARCHAR(255),
    Price DECIMAL(15,2)
);

CREATE TABLE `Server` (
    ServerID CHAR(5) PRIMARY KEY,
    Name VARCHAR(255),
    Memory INT,
    Price DECIMAL(15,2),
    Storage INT,
    ProcessorID CHAR(5),
    OSID CHAR(5),
    FOREIGN KEY (ProcessorID) REFERENCES Processor(ProcessorID),
    FOREIGN KEY (OSID) REFERENCES OperatingSystem(OSID)
);


CREATE TABLE TransactionDetail (
    TransactionID CHAR(5),
    DBID CHAR(5),
    ServerID CHAR(5),
    PRIMARY KEY (TransactionID, DBID, ServerID),
    FOREIGN KEY (TransactionID) REFERENCES TransactionHeader(TransactionID),
    FOREIGN KEY (DBID) REFERENCES `Database`(DBID),
    FOREIGN KEY (ServerID) REFERENCES `Server`(ServerID)
);


ALTER TABLE CustomerData
ADD CONSTRAINT CHK_Gender CHECK (Gender LIKE 'MALE' OR Gender LIKE 'FEMALE');

ALTER TABLE CustomerData
ADD CONSTRAINT CHK_Name CHECK (Name LIKE '% %');

ALTER TABLE CustomerData
ADD CONSTRAINT CHK_PhoneNumber CHECK (LENGTH(PhoneNumber) = 12);

ALTER TABLE OperatingSystem
ADD CONSTRAINT CHK_OSPrice CHECK (Price BETWEEN 500000 AND 15000000);

ALTER TABLE `Server`
ADD CONSTRAINT CHK_Memory CHECK (Price % 2 = 0);

ALTER TABLE `Server`
ADD CONSTRAINT CHK_ServerPrice CHECK (Price BETWEEN 10000 AND 300000);

ALTER TABLE OperatingSystem
ADD CONSTRAINT CHK_Price CHECK (Price BETWEEN 500000 AND 15000000);

ALTER TABLE `Database`
ADD CONSTRAINT CHK_Storage CHECK (Storage > 0);

INSERT INTO customerdata VALUES 
	('CU001','Budi Ayam', 'budi_a@gmail.com', 'jl.Budiman', '2010-05-01', 'Male', '081919191919', 'budi123', 500000.00),
	('CU002','Noel Cacing', 'noel_a@gmail.com', 'jl.Noelman', '2011-05-01', 'Male', '081919191920', 'noel123', 1500000.00),
	('CU003','Sandi Baby', 'sandi_b@gmail.com', 'jl.Sandiman', '2012-05-01', 'Female', '081919191921', 'sandi123', 2500000.00),
	('CU004','Farah Goreng', 'farah_g@gmail.com', 'jl.Farahman', '2013-05-01', 'Female', '081919191922', 'farah123', 3500000.00),
	('CU005','Goa Bobi', 'goa_b@gmail.com', 'jl.Goaman', '2014-05-01', 'Male', '081919191923', 'goa123', 4500000.00),
	('CU006','Bambang Kevin','bambang_kevin@gmail.com','Jalan Kevin No.1','1970-01-01','Male','081123456780','bambang123',5000.00),
	('CU007','Awan Ganas','awan_ganas@gmail.com','Jalan Pemuda No.1','1990-01-01','Male','081123456781','awan123',50000.00),
	('CU008','Mawar Kembang','mawar_kembang@gmail.com','Jalan Bunga No.1','2000-01-01','Female','081123456782','mawar123',100000.00),
	('CU009','Anggun Sekali','anggun_sekali@gmail.com','Jalan Kelapa No.1','1995-01-01','Female','081123456783','anggun123',500000.00),
	('CU010','Wangi Deterjen','wangi_deterjen@gmail.com','Jalan Salak No.1','1985-01-01','Female','081123456784','wangi123',2000000.00),
	('CU011','Sutiono Budi', 'sutiono_budi@gmail.com', 'jl.sutiono 1', '2010-07-02', 'Male', '081919192525', 'sutiono123', 500000.00),
	('CU012','Kesya Nirmana', 'kesya_nirmana@gmail.com', 'jl. kesya 2', '2009-11-11', 'Female', '082021191920', 'kesya123', 300000.00),
	('CU013','Toni Star', 'toni_star@gmail.com', 'jl.toni 3', '2011-12-01', 'Male', '081617181921', 'toni123', 600000.00),
	('CU014','Fatih Kemangi', 'fatih_kemangi@gmail.com', 'jl.fatih 4', '2008-06-20', 'Female', '081122334422', 'farah123', 250000.00),
	('CU015','Tirta Krisnadi', 'tirta_krisnadi@gmail.com', 'jl.tirta 5', '2007-04-05', 'Male', '081919202225', 'tirta123', 550000.00);


INSERT INTO `Provider` VALUES 
('CP001','Google Cloud','google@gmail.com','Jakarta Barat','https://www.google.com'),
('CP002','Yahoo Cloud','yahoo@gmail.com','Jakarta Utara','https://www.yahoo.com'),
('CP003','Telkom Cloud','telkom@gmail.com','Jakarta Pusat','https://www.telkom.com'),
('CP004','Amazon Cloud','amazon@gmail.com','Bandung','https://www.amazon.com'),
('CP005','Alibaba Cloud','alibaba@gmail.com','Semarang','https://www.alibaba.com'),
('CP006','Apple Cloud','apple@gmail.com','Surabaya','https://www.apple.com'),
('CP007','Kompas Cloud','kompas@gmail.com','Solo','https://www.kompas.com'),
('CP008','Samsung Cloud','samsung@gmail.com','Makasar','https://www.samsung.com'),
('CP009','Microsoft Cloud','microsoft@gmail.com','Bali','https://www.microsoft.com'),
('CP010','Lippo Cloud','lippo@gmail.com','Jambi','https://www.lippo.com'),
('CP011','Orion Cloud','orion@gmail.com','Belitung','https://www.orion.com'),
('CP012','Sasa Cloud','sasa@gmail.com','Aceh','https://www.sasa.com'),
('CP013','Daikin Cloud','daikin@gmail.com','Kalimantan','https://www.daikin.com'),
('CP014','Toyota Cloud','toyoya@gmail.com','Pontianak','https://www.toyota.com'),
('CP015','Honda Cloud','honda@gmail.com','Medan','https://www.honda.com');


INSERT INTO DatabaseSoftware VALUES
('DS001','DBMyBody','https://www.MyBody.com'),
('DS002','MyHeadDB','https://www.MyHead.com'),
('DS003','MyFinger','https://www.MyFinger.com'),
('DS004','MyNail','https://www.MyNail.com'),
('DS005','MyToes','https://www.MyToes.com'),
('DS006','MyMouth','https://www.MyMouth.com'),
('DS007','MyNose','https://www.MyNose.com'),
('DS008','Cincin Hilang DB','https://www.cincinhilang.com'),
('DS009','Setya Raharja','https://www.setyaraharja.com'),
('DS010','Combro Gosong DB','https://www.combrogosong.com'),
('DS011','Kentang Goreng','https://www.kentanggoreng.com'),
('DS012','Macaroni Ou','https://www.macaroniou.com'),
('DS013','Steve Apple','https://www.steveapple.com'),
('DS014','Bob Bob','https://www.bobbob.com'),
('DS015','Bon Bon','https://www.bonbon.com');

INSERT INTO Processor VALUES
('PR001','Pros1',1,1,2),
('PR002','Pros2',2,1,2),
('PR003','Pros3',5,1,2),
('PR004','Pros4',1,1,2),
('PR005','Pros5',2,1,2),
('PR006','Pros6',6,1,2),
('PR007','Pros7',1,1,2),
('PR008','Pros8',2,1,2),
('PR009','Pros9',7,1,2),
('PR010','Pros10',1,1,2),
('PR011','Pros11',2,1,2),
('PR012','Pros12',3,1,2),
('PR013','Pros13',1,1,2),
('PR014','Pros14',2,1,2),
('PR015','Pros15',3,1,2);



INSERT INTO OperatingSystem VALUES
('OS001','Microsoft 1','Family 1',500000.00),
('OS002','Microsoft 2', 'Family 2',600000.00),
('OS003','Microsoft 3','Family 3',700000.00),
('OS004','Microsoft 4', 'Family 4',800000.00),
('OS005','Microsoft 5','Family 5',900000.00),
('OS006','Apple 1', 'Family 6',1000000.00),
('OS007','Apple 2','Family 7',1100000.00),
('OS008','Apple 3', 'Family 8',1150000.00),
('OS009','Apple 4','Family 9',1200000.00),
('OS010','Apple 5', 'Family 10',1250000.00),
('OS011','MacOS 1','Family 11',1300000.00),
('OS012','MacOS 2', 'Family 12',1350000.00),
('OS013','MacOS 3', 'Family 13',1400000.00),
('OS014','MacOS 4', 'Family 14',1450000.00),
('OS015','MacOS 5', 'Family 15',1500000.00);



INSERT INTO `Server` VALUES
('SV001','Server 1',4,115000.00,5,'PR001','OS001'),
('SV002','Server 2',8,120000.00,6,'PR002','OS002'),
('SV003','Server 3',12,125000.00,7,'PR003','OS003'),
('SV004','Server 4',16,130000.00,8,'PR004','OS004'),
('SV005','Server 5',20,135000.00,9,'PR005','OS005'),
('SV006','Server 6',24,140000.00,10,'PR006','OS006'),
('SV007','Server 7',28,145000.00,11,'PR007','OS007'),
('SV008','Server 8',32,150000.00,4,'PR008','OS008'),
('SV009','Server 9',36,155000.00,7,'PR009','OS009'),
('SV010','Server 10',40,160000.00,8,'PR010','OS010'),
('SV011','Server 11',44,165000.00,9,'PR011','OS011'),
('SV012','Server 12',48,170000.00,10,'PR012','OS012'),
('SV013','Server 13',52,175000.00,12,'PR013','OS013'),
('SV014','Server 14',56,180000.00,15,'PR014','OS014'),
('SV015','Server 15',60,185000.00,11,'PR015','OS015');



insert into `Database` values
('DB001','DS001',1,1000000.00),
('DB002','DS002',2,1100000.00),
('DB003','DS003',3,1200000.00),
('DB004','DS004',1,1300000.00),
('DB005','DS005',2,1400000.00),
('DB006','DS006',3,1500000.00),
('DB007','DS007',1,1600000.00),
('DB008','DS008',2,1700000.00),
('DB009','DS009',3,1800000.00),
('DB010','DS010',1,1900000.00),
('DB011','DS011',2,200000.00),
('DB012','DS012',3,2100000.00),
('DB013','DS013',1,2200000.00),
('DB014','DS014',1,2300000.00),
('DB015','DS015',3,2400000.00);


INSERT INTO TransactionHeader VALUES
('TR001','CU001','CP001','2020-01-01'),
('TR002','CU002','CP002','2020-01-02'),
('TR003','CU003','CP003','2020-01-03'),
('TR004','CU004','CP004','2020-01-05'),
('TR005','CU005','CP005','2020-01-06'),
('TR006','CU006','CP006','2020-01-07'),
('TR007','CU007','CP007','2020-01-08'),
('TR008','CU008','CP008','2020-01-09'),
('TR009','CU009','CP009','2020-01-10'),
('TR010','CU010','CP010','2020-01-11'),
('TR011','CU011','CP011','2020-01-12'),
('TR012','CU012','CP012','2020-01-13'),
('TR013','CU013','CP013','2020-01-14'),
('TR014','CU014','CP014','2020-01-15'),
('TR015','CU015','CP015','2020-01-16');


INSERT INTO TransactionDetail VALUES
('TR001','DB001','SV001'),
('TR002','DB002','SV002'),
('TR003','DB003','SV003'),
('TR004','DB001','SV001'),
('TR005','DB002','SV002'),
('TR006','DB003','SV003'),
('TR007','DB001','SV001'),
('TR008','DB002','SV002'),
('TR009','DB003','SV003'),
('TR010','DB001','SV001'),
('TR011','DB002','SV002'),
('TR012','DB003','SV003'),
('TR014','DB001','SV001'),
('TR015','DB002','SV002'),
('TR001','DB003','SV003'),
('TR002','DB001','SV001'),
('TR003','DB002','SV002'),
('TR004','DB003','SV003'),
('TR005','DB001','SV001'),
('TR001','DB002','SV002'),
('TR002','DB003','SV003'),
('TR003','DB001','SV001'),
('TR004','DB002','SV002'),
('TR005','DB003','SV003'),
('TR006','DB004','SV004');



-- DROP TABLE transactiondetail;
-- DROP TABLE `Server`;
-- DROP TABLE `Database`;
-- DROP TABLE databasesoftware;
-- DROP TABLE OperatingSystem;
-- DROP TABLE Processor;
-- DROP TABLE TransactionHeader;
-- DROP TABLE Provider;
-- DROP TABLE CustomerData;



-- 4.	Query to simulate the transactions processes.

/* 
Customer bernama Nobert Tanoto ingin membeli sebuah server cloud.
Ia tertarik dengan Provider Telkom (CP003) dengan nama Server 3
Untuk itu, ia harus mendaftar terlebih dahulu.

Setelah beberapa tahun, ia pindah alamat dan mengganti emailnya.
Dengan begitu, ia harus merubah data dalam server CloudBroker

 */
insert into CustomerData values
('CU016','Nobert Tanoto', 'nobert_tanoto@gmail.com', 'Jl.Irvin', '2014-10-06', 'Male', '081919191920', 'noberttanoto123', 550000);

INSERT INTO TransactionHeader VALUES
('TR016','CU016','CP003','2020-05-17');

INSERT INTO TransactionDetail VALUES
('TR016','DB004','SV003');


-- UPDATE EMAIL DAN ALAMAT

UPDATE CustomerData
SET Email = 'nobert_tanoto123@gmail.com', Address = 'Jalan Jeremy 2 no 3'
WHERE CustomerID = 'CU016';

-- Case 1

SELECT c.Name, COUNT(trans.TransactionID) AS `Cloud Providers Count`
FROM CustomerData AS c
JOIN TransactionHeader AS trans ON c.CustomerID = trans.CustomerID
JOIN TransactionDetail AS td ON trans.TransactionID = td.TransactionID
WHERE (c.Name LIKE '%e%' AND DAY(c.DoB) % 2 = 0)
GROUP BY c.Name, trans.TransactionID;

-- Case 2
SELECT DISTINCT s.Name, CONCAT('Rp. ', CAST((s.Price + db.Price + os.Price) AS CHAR), '.-') AS `Price`
FROM `Database` AS db
JOIN TransactionDetail AS td ON db.DBID = td.DBID
JOIN `Server` AS s ON td.ServerID = s.ServerID
JOIN OperatingSystem AS os ON s.OSID = os.OSID
WHERE (s.Memory > 2 AND db.Storage > 1);

-- Case 3
SELECT DISTINCT c.Name, CONCAT(LEFT(c.Name, 1), SUBSTRING(c.Name, INSTR(c.Name, ' ') + 1, 1)) AS `Name`,
       COUNT(trans.TransactionID) AS `Database Count`,
       SUM(db.Price) AS `Database Price`
FROM CustomerData AS c
JOIN TransactionHeader AS trans ON c.CustomerID = trans.CustomerID
JOIN TransactionDetail AS td ON trans.TransactionID = td.TransactionID
JOIN `Database` AS db ON td.DBID = db.DBID
WHERE (c.Gender LIKE 'Female' AND db.Storage > 2)
GROUP BY c.Name, db.Price;


-- Case 4
SELECT CONCAT(LEFT(p.Name, INSTR(p.Name, ' ') - 1), 'Company') AS `Cloud Company`,
       COUNT(td.TransactionID) AS `Total Transaction`,
       AVG(cd.MoneyBalance) AS `Customer Average Account Balance`
FROM Provider p
JOIN TransactionHeader th ON th.ProviderID = p.ProviderID
JOIN CustomerData cd ON cd.CustomerID = th.CustomerID
JOIN TransactionDetail td ON td.TransactionID = th.TransactionID
GROUP BY p.Name, td.TransactionID, cd.MoneyBalance
HAVING p.Name LIKE '%Cloud%' AND COUNT(td.TransactionID) > 1;

-- Case 5
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

-- Case 6
SELECT `Name`, Price,
       CONCAT(CAST(Storage AS CHAR), 'GB') AS `Database Storage`,
       REPLACE(`Name`, 'https://', '') AS `Website URL`
FROM DatabaseSoftware ds
JOIN `Database` d ON d.DSID = ds.DSID
WHERE d.Price > (
    SELECT AVG(Price)
    FROM `Server`
) AND ds.`Name` LIKE '%DB%';

-- Case 7
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

-- Case 8 
SELECT CONCAT(RIGHT(d.DBID, 3), '-', RIGHT(ds.DSID, 3), '-GB') AS `Database Code`
FROM `Database` d
JOIN DatabaseSoftware ds ON d.DSID = ds.DSID
WHERE (d.Price BETWEEN
    (SELECT MIN(Price) FROM `Server`) AND
    (SELECT AVG(Price) FROM OperatingSystem)
) AND ds.DSID IN ('DS006', 'DS007');

-- Case 9
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

-- Case 10
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






