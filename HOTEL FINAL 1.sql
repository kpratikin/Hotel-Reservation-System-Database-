-- MySQL dump 10.13  Distrib 8.0.15, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: hotel
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Booking_Delete_History`
--

DROP TABLE IF EXISTS `Booking_Delete_History`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Booking_Delete_History` (
  `Booking_ID` int(11) NOT NULL,
  `Room_ID` varchar(45) DEFAULT NULL,
  `Customer_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking_Delete_History`
--

LOCK TABLES `Booking_Delete_History` WRITE;
/*!40000 ALTER TABLE `Booking_Delete_History` DISABLE KEYS */;
INSERT INTO `Booking_Delete_History` VALUES (10,'12001',4);
/*!40000 ALTER TABLE `Booking_Delete_History` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Booking_Insert`
--

DROP TABLE IF EXISTS `Booking_Insert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Booking_Insert` (
  `Booking_ID` int(11) NOT NULL,
  `Room_ID` varchar(45) DEFAULT NULL,
  `Date_From` date DEFAULT NULL,
  `Date_To` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking_Insert`
--

LOCK TABLES `Booking_Insert` WRITE;
/*!40000 ALTER TABLE `Booking_Insert` DISABLE KEYS */;
/*!40000 ALTER TABLE `Booking_Insert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Booking_Room_Update`
--

DROP TABLE IF EXISTS `Booking_Room_Update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Booking_Room_Update` (
  `Booking_ID` int(11) NOT NULL,
  `Old_Room_ID` varchar(45) DEFAULT NULL,
  `New_Room_ID` varchar(45) DEFAULT NULL,
  `Date_Updated` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking_Room_Update`
--

LOCK TABLES `Booking_Room_Update` WRITE;
/*!40000 ALTER TABLE `Booking_Room_Update` DISABLE KEYS */;
INSERT INTO `Booking_Room_Update` VALUES (2,'1001','1002','2019-03-04'),(4,'2001','3001','2019-03-04');
/*!40000 ALTER TABLE `Booking_Room_Update` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Booking_Status`
--

DROP TABLE IF EXISTS `Booking_Status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Booking_Status` (
  `Booking_Status_Code` char(18) NOT NULL,
  `Booking_Status_Description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Booking_Status_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Booking_Status`
--

LOCK TABLES `Booking_Status` WRITE;
/*!40000 ALTER TABLE `Booking_Status` DISABLE KEYS */;
INSERT INTO `Booking_Status` VALUES ('B','Booked'),('C','Canceled'),('P','Processed');
/*!40000 ALTER TABLE `Booking_Status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bookings`
--

DROP TABLE IF EXISTS `Bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Bookings` (
  `Booking_ID` int(11) NOT NULL,
  `Customer_ID` int(11) DEFAULT NULL,
  `Room_ID` int(11) DEFAULT NULL,
  `Booking_Status_Code` char(18) DEFAULT NULL,
  `Date_From` date DEFAULT NULL,
  `Date_To` date DEFAULT NULL,
  PRIMARY KEY (`Booking_ID`),
  KEY `fk_Bookings_Customer1` (`Customer_ID`),
  KEY `fk_Bookings_Booking_Status1_idx` (`Booking_Status_Code`),
  KEY `fk_Bookings_Rooms1_idx` (`Room_ID`),
  CONSTRAINT `fk_Bookings_Booking_Status1` FOREIGN KEY (`Booking_Status_Code`) REFERENCES `booking_status` (`Booking_Status_Code`),
  CONSTRAINT `fk_Bookings_Customers1` FOREIGN KEY (`Customer_ID`) REFERENCES `customers` (`Customer_ID`),
  CONSTRAINT `fk_Bookings_Rooms1` FOREIGN KEY (`Room_ID`) REFERENCES `rooms` (`Room_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bookings`
--

LOCK TABLES `Bookings` WRITE;
/*!40000 ALTER TABLE `Bookings` DISABLE KEYS */;
INSERT INTO `Bookings` VALUES (1,1,1001,'B','2019-02-01','2019-02-03'),(2,2,1002,'P','2019-02-05','2019-02-06'),(3,1,2001,'C','2019-02-01','2019-02-02'),(4,3,3001,'P','2019-02-02','2019-02-06'),(5,4,3001,'P','2019-02-03','2019-02-05'),(6,6,5001,'B','2019-02-01','2019-02-03'),(7,7,6001,'P','2019-02-05','2019-02-06'),(8,8,8003,'C','2019-02-01','2019-02-02'),(9,9,10001,'B','2019-02-02','2019-02-06'),(11,1,11001,'B','2019-02-01','2019-02-03'),(12,5,9001,'P','2019-02-05','2019-02-06'),(13,7,5001,'B','2019-02-01','2019-02-02'),(14,9,4001,'C','2019-02-02','2019-02-06'),(15,10,7001,'P','2019-02-03','2019-02-05'),(16,11,6001,'B','2019-02-01','2019-02-03'),(17,12,7001,'P','2019-02-05','2019-02-06'),(18,14,12001,'C','2019-02-06','2019-02-07'),(19,15,15001,'P','2019-02-02','2019-02-03'),(20,16,12001,'B','2019-02-05','2019-02-07'),(21,10,9001,'B','2019-02-02','2019-02-03'),(22,13,7001,'P','2019-02-05','2019-02-07'),(23,5,12001,'C','2019-02-02','2019-02-03'),(24,2,15001,'P','2019-02-01','2019-02-06'),(25,11,4001,'B','2019-02-03','2019-02-05');
/*!40000 ALTER TABLE `Bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `City`
--

DROP TABLE IF EXISTS `City`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `City` (
  `City_Code` varchar(18) NOT NULL,
  `City_Name` varchar(250) DEFAULT NULL,
  `Country_Code` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`City_Code`),
  KEY `fk_City_Country1_idx` (`Country_Code`),
  CONSTRAINT `fk_City_Country1` FOREIGN KEY (`Country_Code`) REFERENCES `country` (`Country_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `City`
--

LOCK TABLES `City` WRITE;
/*!40000 ALTER TABLE `City` DISABLE KEYS */;
INSERT INTO `City` VALUES ('LV','Las Vegas','USA'),('NO','New Orleans','USA'),('NY','New Yor','USA'),('P1','Paris','FR'),('S1','Singapore','SG'),('SC','Santa Clara','USA'),('SF','San Francisco','USA'),('SJ','San Jose','USA'),('T2','Toronto','CA'),('V1','Vancouver','CA');
/*!40000 ALTER TABLE `City` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Country`
--

DROP TABLE IF EXISTS `Country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Country` (
  `Country_Code` varchar(18) NOT NULL,
  `Country_Currency` char(18) DEFAULT NULL,
  `Country_Name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Country_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Country`
--

LOCK TABLES `Country` WRITE;
/*!40000 ALTER TABLE `Country` DISABLE KEYS */;
INSERT INTO `Country` VALUES ('CA','CAD','Canada'),('FR','EUR','France'),('IT','EUR','Italy'),('SG','SGD','Singapore'),('USA','USD','United States');
/*!40000 ALTER TABLE `Country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Customers` (
  `Customer_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Customer_Lastname` varchar(250) DEFAULT NULL,
  `Customer_Firstname` varchar(250) DEFAULT NULL,
  `Address` varchar(250) DEFAULT NULL,
  `Country_Code` varchar(18) DEFAULT NULL,
  `City_Code` varchar(18) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`),
  KEY `fk_Customers_Country1` (`Country_Code`),
  CONSTRAINT `fk_Customers_Country1` FOREIGN KEY (`Country_Code`) REFERENCES `country` (`Country_Code`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (1,'Amber','John','Cherry Avenue','USA','SC',25),(2,'Smith','Joe','Orange','USA','LA',45),(3,'Brown','Marry','The Alemeda','USA','HOUSTON',30),(4,'Taylor','Lucas','Champs','FR','P1',28),(5,'Dexter','Joseph','Nulla Av.','USA','SF',88),(6,'Abbot','Mendez','Et Ave','CA','T2',46),(7,'Kieran','Rosa','Aliquam Rd.','USA','SJ',60),(8,'Lara','Sweeney','Facilisis Av.','FR','P1',18),(9,'Graham','Woodward','Id St.','USA','NY',29),(10,'Benjamin','Mcdowell','Lacinia Ave','FR','P1',26),(11,'Fritz','Campos','Ultrices Avenue','CA','T2',82),(12,'Aline','Keller','A Road','USA','NO',47),(13,'Signe','Powell','Primis Rd.','USA','LV',75),(14,'Ramona','Lynn','Magna. Road','CA','V1',37),(15,'Bertha','Carey','Ipsum Rd.','USA','SC',84),(16,'Ina','Workman','Iaculis Av.','CA','T2',34),(17,'Jade','Douglas','Aliquam Ave','CA','V1',40),(18,'Kai','Pearson','Nulla Rd.','CA','V1',72),(19,'James','Bond','738 Franklin St','USA','SC',26);
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Daily_Room_Rates`
--

DROP TABLE IF EXISTS `Daily_Room_Rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Daily_Room_Rates` (
  `Hotel_ID` int(11) NOT NULL,
  `Day_Date` date NOT NULL,
  `Room_ID` int(11) NOT NULL,
  `Daily_Room_Rate` decimal(20,4) DEFAULT NULL,
  PRIMARY KEY (`Hotel_ID`,`Day_Date`,`Room_ID`),
  KEY `fk_Daily_Room_Rates_Rooms1_idx` (`Room_ID`),
  CONSTRAINT `fk_Daily_Room_Rates_Rooms1` FOREIGN KEY (`Room_ID`) REFERENCES `rooms` (`Room_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Daily_Room_Rates`
--

LOCK TABLES `Daily_Room_Rates` WRITE;
/*!40000 ALTER TABLE `Daily_Room_Rates` DISABLE KEYS */;
INSERT INTO `Daily_Room_Rates` VALUES (1,'2018-04-11',8001,265.0000),(1,'2018-05-30',10002,200.0000),(1,'2019-03-19',8001,256.0000),(1,'2019-04-05',2001,101.0000),(1,'2019-05-24',13002,215.0000),(1,'2019-06-03',13002,272.0000),(1,'2020-01-30',4001,300.0000),(2,'2018-09-07',11002,222.0000),(2,'2018-10-14',4002,228.0000),(2,'2019-01-01',13001,195.0000),(2,'2019-01-03',1003,142.0000),(2,'2019-03-17',13001,124.0000),(2,'2019-04-21',1004,278.0000),(2,'2019-05-28',1003,215.0000),(2,'2019-06-07',6002,248.0000),(2,'2019-06-12',1001,292.0000),(2,'2019-09-14',8001,213.0000),(2,'2019-11-07',3001,162.0000),(2,'2019-11-26',1002,292.0000),(2,'2019-12-19',4002,202.0000),(3,'2018-02-28',2004,264.0000),(3,'2018-03-15',5001,245.0000),(3,'2018-09-21',2005,106.0000),(3,'2018-10-15',7002,208.0000),(3,'2018-11-04',11002,101.0000),(3,'2019-05-26',7002,189.0000),(3,'2019-05-30',1005,156.0000),(4,'2018-06-28',8001,252.0000),(4,'2018-08-11',13001,131.0000),(4,'2018-09-16',12003,215.0000),(4,'2018-11-16',12001,167.0000),(4,'2019-02-25',11001,164.0000),(4,'2019-06-02',6002,283.0000),(4,'2019-09-22',6001,230.0000),(4,'2019-09-29',11001,113.0000),(4,'2019-12-07',5003,205.0000),(4,'2020-01-14',5003,168.0000),(4,'2020-01-24',6002,277.0000),(5,'2019-02-07',2004,181.0000),(5,'2019-03-12',7003,206.0000),(5,'2019-05-28',7002,190.0000),(5,'2019-07-01',3001,246.0000),(5,'2019-07-04',12001,244.0000),(5,'2019-07-07',8001,110.0000),(5,'2019-10-08',1005,170.0000),(6,'2018-02-16',5003,213.0000),(6,'2018-03-24',12002,247.0000),(6,'2018-04-27',2002,278.0000),(6,'2018-05-21',7001,102.0000),(6,'2019-01-01',3001,215.0000),(6,'2019-03-18',7003,182.0000),(6,'2019-06-13',10002,170.0000),(6,'2019-06-24',3002,150.0000),(7,'2018-03-15',2002,113.0000),(7,'2019-09-23',6001,157.0000),(7,'2020-01-05',8002,274.0000),(8,'2019-01-21',11001,253.0000),(8,'2019-04-14',3001,237.0000),(9,'2018-05-14',2004,136.0000),(9,'2018-09-26',11001,127.0000),(9,'2018-11-13',7001,265.0000),(9,'2018-12-01',11001,219.0000),(9,'2019-12-12',7001,213.0000),(9,'2020-01-17',5001,243.0000),(9,'2020-02-06',2005,118.0000),(10,'2018-02-04',2004,267.0000),(10,'2018-08-08',7002,245.0000),(10,'2018-10-14',6001,269.0000),(10,'2018-12-07',3001,188.0000),(10,'2019-01-08',1004,250.0000),(10,'2019-01-30',1005,286.0000),(10,'2020-01-06',14001,146.0000),(11,'2018-06-13',10001,209.0000),(11,'2018-11-08',11003,299.0000),(11,'2019-08-21',3002,164.0000),(12,'2019-01-05',5003,214.0000),(12,'2019-03-15',10001,201.0000),(12,'2019-04-20',6001,146.0000),(13,'2018-02-15',14001,163.0000),(13,'2018-07-03',5001,185.0000),(13,'2019-05-19',4003,266.0000),(14,'2018-06-11',11002,211.0000),(14,'2018-06-30',6001,261.0000),(14,'2018-12-23',2004,244.0000),(14,'2019-04-10',14001,101.0000),(14,'2019-06-04',9001,174.0000),(14,'2019-06-10',8002,175.0000),(14,'2019-08-15',13002,283.0000),(14,'2019-11-01',12002,266.0000),(14,'2019-11-19',6002,250.0000),(15,'2018-04-06',10002,276.0000),(15,'2018-07-30',3001,124.0000),(15,'2018-12-24',13001,147.0000),(15,'2018-12-25',11003,284.0000),(15,'2018-12-30',1004,268.0000),(15,'2019-02-25',1002,101.0000),(15,'2019-04-27',2002,243.0000),(15,'2019-05-03',4002,124.0000),(15,'2019-07-14',3001,273.0000),(15,'2019-07-26',8001,246.0000);
/*!40000 ALTER TABLE `Daily_Room_Rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hotel_Chains`
--

DROP TABLE IF EXISTS `Hotel_Chains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Hotel_Chains` (
  `Hotel_Chain_Code` varchar(250) NOT NULL,
  `Hotel_Chain_Name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Hotel_Chain_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hotel_Chains`
--

LOCK TABLES `Hotel_Chains` WRITE;
/*!40000 ALTER TABLE `Hotel_Chains` DISABLE KEYS */;
INSERT INTO `Hotel_Chains` VALUES ('L1','JW Marriot Hotels'),('L2','The Ritz-Carlton Hotel'),('P1','Sheraton Hotels and Resorts'),('P2','Westin Hotels and Resorts'),('S1','AC Hotels'),('S2','Four Points');
/*!40000 ALTER TABLE `Hotel_Chains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hotel_Features`
--

DROP TABLE IF EXISTS `Hotel_Features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Hotel_Features` (
  `Feature_Code` char(18) NOT NULL,
  `Feature_Code_Description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Feature_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hotel_Features`
--

LOCK TABLES `Hotel_Features` WRITE;
/*!40000 ALTER TABLE `Hotel_Features` DISABLE KEYS */;
INSERT INTO `Hotel_Features` VALUES ('BC','Business Center'),('GM','Gym'),('LA','Laundry Service'),('SA','Spa'),('SM','Smoking Room'),('SP','Swimming Pool');
/*!40000 ALTER TABLE `Hotel_Features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Hotels`
--

DROP TABLE IF EXISTS `Hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Hotels` (
  `Hotel_ID` int(11) NOT NULL,
  `Country_Code` varchar(18) NOT NULL,
  `Hotel_Chain_Code` varchar(250) DEFAULT NULL,
  `Hotel_Name` varchar(250) DEFAULT NULL,
  `Email_Address` varchar(250) DEFAULT NULL,
  `Hotel_Address` varchar(250) DEFAULT NULL,
  `Hotel_URL` varchar(250) DEFAULT NULL,
  `Other_Details` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Hotel_ID`),
  KEY `fk_Hotels_Hotel_Chains1_idx` (`Hotel_Chain_Code`),
  KEY `fk_Hotels_Country1_idx` (`Country_Code`),
  CONSTRAINT `fk_Hotels_Country1` FOREIGN KEY (`Country_Code`) REFERENCES `country` (`Country_Code`),
  CONSTRAINT `fk_Hotels_Hotel_Chains1` FOREIGN KEY (`Hotel_Chain_Code`) REFERENCES `hotel_chains` (`Hotel_Chain_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Hotels`
--

LOCK TABLES `Hotels` WRITE;
/*!40000 ALTER TABLE `Hotels` DISABLE KEYS */;
INSERT INTO `Hotels` VALUES (1,'USA','L1','JW Marriott Las Vegas','jwmlv@gmail.com','Las Vegas',NULL,NULL),(2,'USA','L2','Ritz-Carlton New York','rcny@gmail.com','New York',NULL,NULL),(3,'USA','L1','JW Marriott New Orleans','jwmno@gmail.com','New Orleans',NULL,NULL),(4,'USA','P1','Sheraton Las Vegas','slv@gmail.com','Las Vegas',NULL,NULL),(5,'USA','P2','The Westin San Jose','wsj@gmail.com','San Jose',NULL,NULL),(6,'USA','S2','Four Points Las Vegas','jwmlv@gmail.com','Las Vegas',NULL,NULL),(7,'USA','P2','The Westin New York','rcny@gmail.com','New York',NULL,NULL),(8,'USA','P1','Sheraton New Orleans','jwmno@gmail.com','New Orleans',NULL,NULL),(9,'USA','P1','Sheraton San Francisco','slv@gmail.com','Las Vegas',NULL,NULL),(10,'USA','S2','AC Hotels San Jose','wsj@gmail.com','San Jose',NULL,NULL),(11,'USA','S2','Four Points Singapore','jwmlv@gmail.com','Las Vegas',NULL,NULL),(12,'USA','L1','JW Marriott San Francisco','rcny@gmail.com','New York',NULL,NULL),(13,'USA','L1','JW Marriot New Orleans','jwmno@gmail.com','New Orleans',NULL,NULL),(14,'USA','L2','Ritz-Carlton Tokyo','slv@gmail.com','Las Vegas',NULL,NULL),(15,'USA','P2','The Westin San Francisco','wsj@gmail.com','San Jose',NULL,NULL);
/*!40000 ALTER TABLE `Hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room_Availability`
--

DROP TABLE IF EXISTS `Room_Availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Room_Availability` (
  `Day_Date` date NOT NULL,
  `Room_ID` int(11) NOT NULL,
  `Room_Availability_Status` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Day_Date`,`Room_ID`),
  KEY `fk_Room_Availability_Rooms1_idx` (`Room_ID`),
  CONSTRAINT `fk_Room_Availability_Rooms1` FOREIGN KEY (`Room_ID`) REFERENCES `rooms` (`Room_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room_Availability`
--

LOCK TABLES `Room_Availability` WRITE;
/*!40000 ALTER TABLE `Room_Availability` DISABLE KEYS */;
INSERT INTO `Room_Availability` VALUES ('2019-02-01',1001,'Booked'),('2019-02-01',1002,'Available'),('2019-02-01',1003,'Available'),('2019-02-01',1004,'Available'),('2019-02-01',1005,'Available'),('2019-02-01',2001,'Available'),('2019-02-01',2002,'Available'),('2019-02-01',2003,'Available'),('2019-02-01',2004,'Available'),('2019-02-01',2005,'Available'),('2019-02-01',3001,'Available'),('2019-02-01',3002,'Available'),('2019-02-01',4001,'Available'),('2019-02-01',4002,'Available'),('2019-02-01',4003,'Available'),('2019-02-01',5001,'Booked'),('2019-02-01',5002,'Available'),('2019-02-01',5003,'Available'),('2019-02-01',6001,'Booked'),('2019-02-01',6002,'Available'),('2019-02-01',7001,'Available'),('2019-02-01',7002,'Available'),('2019-02-01',7003,'Available'),('2019-02-01',8001,'Available'),('2019-02-01',8002,'Available'),('2019-02-01',8003,'Available'),('2019-02-01',9001,'Booked'),('2019-02-01',9002,'Available'),('2019-02-01',10001,'Available'),('2019-02-01',10002,'Available'),('2019-02-01',10003,'Available'),('2019-02-01',11001,'Booked'),('2019-02-01',11002,'Available'),('2019-02-01',11003,'Available'),('2019-02-01',12001,'Available'),('2019-02-01',12002,'Available'),('2019-02-01',12003,'Available'),('2019-02-01',13001,'Available'),('2019-02-01',13002,'Available'),('2019-02-01',14001,'Available'),('2019-02-01',14002,'Available'),('2019-02-01',15001,'Hold'),('2019-02-01',15002,'Available'),('2019-02-01',15003,'Available'),('2019-02-01',15004,'Available'),('2019-02-02',1001,'Booked'),('2019-02-02',1002,'Available'),('2019-02-02',1003,'Available'),('2019-02-02',1004,'Available'),('2019-02-02',1005,'Available'),('2019-02-02',2001,'Available'),('2019-02-02',2002,'Available'),('2019-02-02',2003,'Available'),('2019-02-02',2004,'Available'),('2019-02-02',2005,'Available'),('2019-02-02',3001,'Available'),('2019-02-02',3002,'Available'),('2019-02-02',4001,'Available'),('2019-02-02',4002,'Available'),('2019-02-02',4003,'Available'),('2019-02-02',5001,'Booked'),('2019-02-02',5002,'Available'),('2019-02-02',5003,'Available'),('2019-02-02',6001,'Booked'),('2019-02-02',6002,'Available'),('2019-02-02',7001,'Available'),('2019-02-02',7002,'Available'),('2019-02-02',7003,'Available'),('2019-02-02',8001,'Available'),('2019-02-02',8002,'Available'),('2019-02-02',8003,'Available'),('2019-02-02',9001,'Booked'),('2019-02-02',9002,'Available'),('2019-02-02',10001,'Booked'),('2019-02-02',10002,'Available'),('2019-02-02',10003,'Available'),('2019-02-02',11001,'Booked'),('2019-02-02',11002,'Available'),('2019-02-02',11003,'Available'),('2019-02-02',12001,'Available'),('2019-02-02',12002,'Available'),('2019-02-02',12003,'Available'),('2019-02-02',13001,'Available'),('2019-02-02',13002,'Available'),('2019-02-02',14001,'Available'),('2019-02-02',14002,'Available'),('2019-02-02',15001,'Hold'),('2019-02-02',15002,'Available'),('2019-02-02',15003,'Available'),('2019-02-02',15004,'Available'),('2019-02-03',1001,'Booked'),('2019-02-03',1002,'Available'),('2019-02-03',1003,'Available'),('2019-02-03',1004,'Available'),('2019-02-03',1005,'Available'),('2019-02-03',2001,'Hold'),('2019-02-03',2002,'Available'),('2019-02-03',2003,'Available'),('2019-02-03',2004,'Available'),('2019-02-03',2005,'Available'),('2019-02-03',3001,'Hold'),('2019-02-03',3002,'Available'),('2019-02-03',4001,'Booked'),('2019-02-03',4002,'Available'),('2019-02-03',4003,'Available'),('2019-02-03',5001,'Booked'),('2019-02-03',5002,'Available'),('2019-02-03',5003,'Available'),('2019-02-03',6001,'Booked'),('2019-02-03',6002,'Available'),('2019-02-03',7001,'Hold'),('2019-02-03',7002,'Available'),('2019-02-03',7003,'Available'),('2019-02-03',8001,'Available'),('2019-02-03',8002,'Available'),('2019-02-03',8003,'Available'),('2019-02-03',9001,'Booked'),('2019-02-03',9002,'Available'),('2019-02-03',10001,'Booked'),('2019-02-03',10002,'Available'),('2019-02-03',10003,'Available'),('2019-02-03',11001,'Booked'),('2019-02-03',11002,'Available'),('2019-02-03',11003,'Available'),('2019-02-03',12001,'Available'),('2019-02-03',12002,'Available'),('2019-02-03',12003,'Available'),('2019-02-03',13001,'Available'),('2019-02-03',13002,'Available'),('2019-02-03',14001,'Available'),('2019-02-03',14002,'Available'),('2019-02-03',15001,'Hold'),('2019-02-03',15002,'Available'),('2019-02-03',15003,'Available'),('2019-02-03',15004,'Available'),('2019-02-04',1001,'Available'),('2019-02-04',1002,'Available'),('2019-02-04',1003,'Available'),('2019-02-04',1004,'Available'),('2019-02-04',1005,'Available'),('2019-02-04',2001,'Hold'),('2019-02-04',2002,'Available'),('2019-02-04',2003,'Available'),('2019-02-04',2004,'Available'),('2019-02-04',2005,'Available'),('2019-02-04',3001,'Hold'),('2019-02-04',3002,'Available'),('2019-02-04',4001,'Booked'),('2019-02-04',4002,'Available'),('2019-02-04',4003,'Available'),('2019-02-04',5001,'Available'),('2019-02-04',5002,'Available'),('2019-02-04',5003,'Available'),('2019-02-04',6001,'Available'),('2019-02-04',6002,'Available'),('2019-02-04',7001,'Hold'),('2019-02-04',7002,'Available'),('2019-02-04',7003,'Available'),('2019-02-04',8001,'Available'),('2019-02-04',8002,'Available'),('2019-02-04',8003,'Available'),('2019-02-04',9001,'Available'),('2019-02-04',9002,'Available'),('2019-02-04',10001,'Booked'),('2019-02-04',10002,'Available'),('2019-02-04',10003,'Available'),('2019-02-04',11001,'Available'),('2019-02-04',11002,'Available'),('2019-02-04',11003,'Available'),('2019-02-04',12001,'Hold'),('2019-02-04',12002,'Available'),('2019-02-04',12003,'Available'),('2019-02-04',13001,'Available'),('2019-02-04',13002,'Available'),('2019-02-04',14001,'Available'),('2019-02-04',14002,'Available'),('2019-02-04',15001,'Hold'),('2019-02-04',15002,'Available'),('2019-02-04',15003,'Available'),('2019-02-04',15004,'Available'),('2019-02-05',1001,'Hold'),('2019-02-05',1002,'Available'),('2019-02-05',1003,'Available'),('2019-02-05',1004,'Available'),('2019-02-05',1005,'Available'),('2019-02-05',2001,'Hold'),('2019-02-05',2002,'Available'),('2019-02-05',2003,'Available'),('2019-02-05',2004,'Available'),('2019-02-05',2005,'Available'),('2019-02-05',3001,'Hold'),('2019-02-05',3002,'Available'),('2019-02-05',4001,'Booked'),('2019-02-05',4002,'Available'),('2019-02-05',4003,'Available'),('2019-02-05',5001,'Available'),('2019-02-05',5002,'Available'),('2019-02-05',5003,'Available'),('2019-02-05',6001,'Hold'),('2019-02-05',6002,'Available'),('2019-02-05',7001,'Hold'),('2019-02-05',7002,'Available'),('2019-02-05',7003,'Available'),('2019-02-05',8001,'Available'),('2019-02-05',8002,'Available'),('2019-02-05',8003,'Available'),('2019-02-05',9001,'Hold'),('2019-02-05',9002,'Available'),('2019-02-05',10001,'Booked'),('2019-02-05',10002,'Available'),('2019-02-05',10003,'Available'),('2019-02-05',11001,'Available'),('2019-02-05',11002,'Available'),('2019-02-05',11003,'Available'),('2019-02-05',12001,'Hold'),('2019-02-05',12002,'Available'),('2019-02-05',12003,'Available'),('2019-02-05',13001,'Available'),('2019-02-05',13002,'Available'),('2019-02-05',14001,'Available'),('2019-02-05',14002,'Available'),('2019-02-05',15001,'Hold'),('2019-02-05',15002,'Available'),('2019-02-05',15003,'Available'),('2019-02-05',15004,'Available'),('2019-02-06',1001,'Hold'),('2019-02-06',1002,'Available'),('2019-02-06',1003,'Available'),('2019-02-06',1004,'Available'),('2019-02-06',1005,'Available'),('2019-02-06',2001,'Hold'),('2019-02-06',2002,'Available'),('2019-02-06',2003,'Available'),('2019-02-06',2004,'Available'),('2019-02-06',2005,'Available'),('2019-02-06',3001,'Available'),('2019-02-06',3002,'Available'),('2019-02-06',4001,'Available'),('2019-02-06',4002,'Available'),('2019-02-06',4003,'Available'),('2019-02-06',5001,'Available'),('2019-02-06',5002,'Available'),('2019-02-06',5003,'Available'),('2019-02-06',6001,'Hold'),('2019-02-06',6002,'Available'),('2019-02-06',7001,'Hold'),('2019-02-06',7002,'Available'),('2019-02-06',7003,'Available'),('2019-02-06',8001,'Available'),('2019-02-06',8002,'Available'),('2019-02-06',8003,'Available'),('2019-02-06',9001,'Hold'),('2019-02-06',9002,'Available'),('2019-02-06',10001,'Booked'),('2019-02-06',10002,'Available'),('2019-02-06',10003,'Available'),('2019-02-06',11001,'Available'),('2019-02-06',11002,'Available'),('2019-02-06',11003,'Available'),('2019-02-06',12001,'Booked'),('2019-02-06',12002,'Available'),('2019-02-06',12003,'Available'),('2019-02-06',13001,'Available'),('2019-02-06',13002,'Available'),('2019-02-06',14001,'Available'),('2019-02-06',14002,'Available'),('2019-02-06',15001,'Hold'),('2019-02-06',15002,'Available'),('2019-02-06',15003,'Available'),('2019-02-06',15004,'Available'),('2019-02-07',1001,'Available'),('2019-02-07',1002,'Available'),('2019-02-07',1003,'Available'),('2019-02-07',1004,'Available'),('2019-02-07',1005,'Available'),('2019-02-07',2001,'Available'),('2019-02-07',2002,'Available'),('2019-02-07',2003,'Available'),('2019-02-07',2004,'Available'),('2019-02-07',2005,'Available'),('2019-02-07',3001,'Available'),('2019-02-07',3002,'Available'),('2019-02-07',4001,'Available'),('2019-02-07',4002,'Available'),('2019-02-07',4003,'Available'),('2019-02-07',5001,'Available'),('2019-02-07',5002,'Available'),('2019-02-07',5003,'Available'),('2019-02-07',6001,'Available'),('2019-02-07',6002,'Available'),('2019-02-07',7001,'Hold'),('2019-02-07',7002,'Available'),('2019-02-07',7003,'Available'),('2019-02-07',8001,'Available'),('2019-02-07',8002,'Available'),('2019-02-07',8003,'Available'),('2019-02-07',9001,'Available'),('2019-02-07',9002,'Available'),('2019-02-07',10001,'Available'),('2019-02-07',10002,'Available'),('2019-02-07',10003,'Available'),('2019-02-07',11001,'Available'),('2019-02-07',11002,'Available'),('2019-02-07',11003,'Available'),('2019-02-07',12001,'Booked'),('2019-02-07',12002,'Available'),('2019-02-07',12003,'Available'),('2019-02-07',13001,'Available'),('2019-02-07',13002,'Available'),('2019-02-07',14001,'Available'),('2019-02-07',14002,'Available'),('2019-02-07',15001,'Available'),('2019-02-07',15002,'Available'),('2019-02-07',15003,'Available'),('2019-02-07',15004,'Available');
/*!40000 ALTER TABLE `Room_Availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Room_Types`
--

DROP TABLE IF EXISTS `Room_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Room_Types` (
  `Room_Type_Code` char(18) NOT NULL,
  `Standard_Room_Rate` decimal(20,4) DEFAULT NULL,
  `Room_Type_Description` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`Room_Type_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Room_Types`
--

LOCK TABLES `Room_Types` WRITE;
/*!40000 ALTER TABLE `Room_Types` DISABLE KEYS */;
INSERT INTO `Room_Types` VALUES ('CL',190.0000,'Club Lounge'),('DL',150.0000,'Deluxe'),('E',200.0000,'Executive'),('GD',110.0000,'Guest Double'),('GK',100.0000,'Guest King'),('SU',280.0000,'Suite');
/*!40000 ALTER TABLE `Room_Types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rooms`
--

DROP TABLE IF EXISTS `Rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Rooms` (
  `Room_ID` int(11) NOT NULL,
  `Hotel_ID` int(11) DEFAULT NULL,
  `Room_Type_Code` char(18) NOT NULL,
  `Room_Floor` int(11) DEFAULT NULL,
  `Room_Number` int(11) DEFAULT NULL,
  PRIMARY KEY (`Room_ID`),
  KEY `fk_Rooms_Hotels1` (`Hotel_ID`),
  KEY `fk_Rooms_Room_Types1` (`Room_Type_Code`),
  CONSTRAINT `fk_Rooms_Hotels1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`),
  CONSTRAINT `fk_Rooms_Hotels2` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`),
  CONSTRAINT `fk_Rooms_Hotels3` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`),
  CONSTRAINT `fk_Rooms_Room_Types1` FOREIGN KEY (`Room_Type_Code`) REFERENCES `room_types` (`Room_Type_Code`),
  CONSTRAINT `fk_Rooms_Room_Types2` FOREIGN KEY (`Room_Type_Code`) REFERENCES `room_types` (`Room_Type_Code`),
  CONSTRAINT `fk_Rooms_Room_Types3` FOREIGN KEY (`Room_Type_Code`) REFERENCES `room_types` (`Room_Type_Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rooms`
--

LOCK TABLES `Rooms` WRITE;
/*!40000 ALTER TABLE `Rooms` DISABLE KEYS */;
INSERT INTO `Rooms` VALUES (1001,1,'DL',3,1),(1002,1,'DL',3,2),(1003,1,'DL',3,3),(1004,1,'E',4,4),(1005,1,'SU',5,5),(2001,2,'DL',3,1),(2002,2,'DL',3,2),(2003,2,'E',6,3),(2004,2,'E',7,4),(2005,2,'SU',10,5),(3001,3,'DL',3,1),(3002,3,'DL',3,2),(4001,4,'GD',3,1),(4002,4,'GD',4,2),(4003,4,'GK',4,3),(5001,5,'GD',3,1),(5002,5,'GK',4,2),(5003,5,'CL',5,3),(6001,6,'GD',3,1),(6002,6,'GD',3,2),(7001,7,'CL',3,1),(7002,7,'CL',3,2),(7003,7,'DL',4,3),(8001,8,'DL',3,1),(8002,8,'DL',3,2),(8003,8,'CL',4,3),(9001,9,'CL',3,1),(9002,9,'E',4,2),(10001,10,'DL',3,1),(10002,10,'DL',3,2),(10003,10,'DL',3,3),(11001,11,'GD',3,1),(11002,11,'GD',4,2),(11003,11,'GK',3,3),(12001,12,'DL',3,1),(12002,12,'E',3,2),(12003,12,'E',3,3),(13001,13,'E',4,1),(13002,13,'SU',3,2),(14001,14,'DL',3,1),(14002,14,'DL',3,2),(15001,15,'GD',3,1),(15002,15,'GD',4,2),(15003,15,'GD',3,3),(15004,15,'GK',3,4);
/*!40000 ALTER TABLE `Rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Specific_Hotel_Feature`
--

DROP TABLE IF EXISTS `Specific_Hotel_Feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Specific_Hotel_Feature` (
  `Hotel_ID` int(11) NOT NULL,
  `Feature_Code` char(18) NOT NULL,
  PRIMARY KEY (`Hotel_ID`,`Feature_Code`),
  KEY `fk_Specific_Hotel_Feature_Hotels1` (`Hotel_ID`),
  KEY `fk_Specific_Hotel_Feature_Hotel_Features1_idx` (`Feature_Code`),
  CONSTRAINT `fk_Specific_Hotel_Feature_Hotel_Features1` FOREIGN KEY (`Feature_Code`) REFERENCES `hotel_features` (`Feature_Code`),
  CONSTRAINT `fk_Specific_Hotel_Feature_Hotels1` FOREIGN KEY (`Hotel_ID`) REFERENCES `hotels` (`Hotel_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Specific_Hotel_Feature`
--

LOCK TABLES `Specific_Hotel_Feature` WRITE;
/*!40000 ALTER TABLE `Specific_Hotel_Feature` DISABLE KEYS */;
INSERT INTO `Specific_Hotel_Feature` VALUES (1,'BC'),(1,'SA'),(1,'SP'),(2,'SA'),(2,'SP'),(3,'SP'),(4,'SA'),(4,'SP'),(5,'SA'),(5,'SP'),(6,'BC'),(7,'SP'),(8,'SP'),(9,'GM'),(10,'BC'),(11,'BC'),(12,'LA'),(13,'SM'),(14,'SP'),(15,'SP');
/*!40000 ALTER TABLE `Specific_Hotel_Feature` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-04 21:13:04
