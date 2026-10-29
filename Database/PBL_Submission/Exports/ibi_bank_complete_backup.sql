-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: fintech_banking_db
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'd8f68f3b-b9de-11f1-ab51-0a0027000010:1-413';

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `account_type_id` int DEFAULT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT '0.00',
  `status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `customer_id` (`customer_id`),
  KEY `branch_id` (`branch_id`),
  KEY `account_type_id` (`account_type_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `account_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `account_ibfk_3` FOREIGN KEY (`account_type_id`) REFERENCES `account_type` (`account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,1,1,1,'100020003000',25000.50,'Active'),(7,6,1,12,'IBI0000000006',5354.78,'Active'),(8,7,5,13,'IBI0000000007',25014.10,'Active'),(9,8,6,14,'IBI0000000008',100000.00,'Active'),(10,9,7,15,'IBI0000000009',15000.00,'Active'),(11,10,8,11,'IBI0000000010',50000.00,'Active'),(12,11,9,12,'IBI0000000011',75000.00,'Active'),(13,12,10,13,'IBI0000000012',25000.00,'Active'),(14,13,11,14,'IBI0000000013',100000.00,'Active'),(15,14,12,15,'IBI0000000014',15010.00,'Active'),(16,15,13,11,'IBI0000000015',50000.00,'Active'),(17,16,14,12,'IBI0000000016',75000.00,'Active'),(18,17,15,13,'IBI0000000017',25000.00,'Active'),(19,18,16,14,'IBI0000000018',101000.00,'Active'),(20,19,17,15,'IBI0000000019',18166.05,'Active'),(21,20,18,11,'IBI0000000020',50000.00,'Active'),(22,21,19,12,'IBI0000000021',75000.00,'Active'),(23,22,20,13,'IBI0000000022',25000.00,'Active'),(24,23,21,14,'IBI0000000023',100000.00,'Active'),(25,24,22,15,'IBI0000000024',15000.00,'Active'),(26,25,23,11,'IBI0000000025',50000.00,'Active'),(27,26,24,12,'IBI0000000026',75000.00,'Active'),(28,27,25,13,'IBI0000000027',25000.00,'Active'),(29,28,26,14,'IBI0000000028',100000.00,'Active'),(30,29,27,15,'IBI0000000029',15000.00,'Active'),(31,30,28,11,'IBI0000000030',50000.00,'Active'),(32,31,29,12,'IBI0000000031',75000.00,'Active'),(33,32,30,13,'IBI0000000032',25000.00,'Active'),(34,33,31,14,'IBI0000000033',100000.00,'Active'),(35,34,32,15,'IBI0000000034',15000.00,'Active'),(36,35,33,11,'IBI0000000035',50000.00,'Active'),(37,36,34,12,'IBI0000000036',75000.00,'Active'),(38,37,35,13,'IBI0000000037',25000.00,'Active'),(39,38,36,14,'IBI0000000038',100000.00,'Active'),(40,39,37,15,'IBI0000000039',15000.00,'Active'),(41,40,38,11,'IBI0000000040',50000.00,'Active'),(42,41,39,12,'IBI0000000041',75000.00,'Active'),(43,42,40,13,'IBI0000000042',25000.00,'Active'),(44,43,41,14,'IBI0000000043',100000.00,'Active'),(45,44,42,15,'IBI0000000044',15000.00,'Active'),(46,45,43,11,'IBI0000000045',50000.00,'Active'),(47,46,44,12,'IBI0000000046',75000.00,'Active'),(48,47,45,13,'IBI0000000047',25000.00,'Active'),(49,48,46,14,'IBI0000000048',100000.00,'Active'),(50,49,47,15,'IBI0000000049',15000.00,'Active'),(51,50,48,11,'IBI0000000050',50000.00,'Active'),(52,51,49,12,'IBI0000000051',75000.00,'Active'),(53,52,50,13,'IBI0000000052',25000.00,'Active'),(54,53,51,14,'IBI0000000053',100000.00,'Active'),(55,54,52,15,'IBI0000000054',15000.00,'Active'),(56,55,53,11,'IBI0000000055',50000.00,'Active'),(57,56,54,12,'IBI0000000056',75000.00,'Active'),(58,57,55,13,'IBI0000000057',25000.00,'Active'),(59,58,56,14,'IBI0000000058',100000.00,'Active'),(60,59,57,15,'IBI0000000059',15000.00,'Active'),(61,60,58,11,'IBI0000000060',50000.00,'Active'),(62,61,59,12,'IBI0000000061',75000.00,'Active'),(63,62,60,13,'IBI0000000062',25000.00,'Active'),(64,63,61,14,'IBI0000000063',100000.00,'Active'),(65,64,62,15,'IBI0000000064',15000.00,'Active'),(66,65,63,11,'IBI0000000065',50000.00,'Active'),(67,66,64,12,'IBI0000000066',75000.00,'Active'),(68,67,65,13,'IBI0000000067',25000.00,'Active'),(69,68,66,14,'IBI0000000068',100000.00,'Active'),(70,69,67,15,'IBI0000000069',15000.00,'Active'),(71,70,68,11,'IBI0000000070',50000.00,'Active'),(72,71,69,12,'IBI0000000071',75000.00,'Active'),(73,72,70,13,'IBI0000000072',25000.00,'Active'),(74,73,71,14,'IBI0000000073',100000.00,'Active'),(75,74,72,15,'IBI0000000074',15000.00,'Active'),(76,75,73,11,'IBI0000000075',50000.00,'Active'),(77,76,74,12,'IBI0000000076',75000.00,'Active'),(78,77,75,13,'IBI0000000077',25000.00,'Active'),(79,78,76,14,'IBI0000000078',100000.00,'Active'),(80,79,77,15,'IBI0000000079',15000.00,'Active'),(81,80,78,11,'IBI0000000080',50000.00,'Active'),(82,81,79,12,'IBI0000000081',75000.00,'Active'),(83,82,80,13,'IBI0000000082',25000.00,'Active'),(84,83,81,14,'IBI0000000083',100000.00,'Active'),(85,84,82,15,'IBI0000000084',15000.00,'Active'),(86,85,83,11,'IBI0000000085',50000.00,'Active'),(87,86,84,12,'IBI0000000086',75000.00,'Active'),(88,87,85,13,'IBI0000000087',25000.00,'Active'),(89,88,86,14,'IBI0000000088',100000.00,'Active'),(90,89,87,15,'IBI0000000089',15000.00,'Active'),(91,90,88,11,'IBI0000000090',50000.00,'Active'),(92,91,89,12,'IBI0000000091',75000.00,'Active'),(93,92,90,13,'IBI0000000092',25000.00,'Active'),(94,93,91,14,'IBI0000000093',100000.00,'Active'),(95,94,92,15,'IBI0000000094',15000.00,'Active'),(96,95,93,11,'IBI0000000095',50000.00,'Active'),(97,96,94,12,'IBI0000000096',75000.00,'Active'),(98,97,95,13,'IBI0000000097',25000.00,'Active'),(99,98,96,14,'IBI0000000098',100000.00,'Active'),(100,99,97,15,'IBI0000000099',15000.00,'Active'),(101,100,98,11,'IBI0000000100',50000.00,'Active'),(102,101,99,12,'IBI0000000101',75000.00,'Active'),(103,104,100,15,'IBI0000000104',15000.00,'Active'),(104,105,101,11,'IBI0000000105',50000.00,'Active'),(105,106,102,12,'IBI0000000106',75000.00,'Active'),(106,107,103,13,'IBI0000000107',25000.00,'Active'),(107,108,104,14,'IBI0000000108',100000.00,'Active'),(108,109,105,15,'IBI0000000109',15000.00,'Active'),(109,110,106,11,'IBI0000000110',50000.00,'Active'),(110,111,107,12,'IBI0000000111',75000.00,'Active'),(111,112,108,13,'IBI0000000112',25000.00,'Active'),(112,113,109,14,'IBI0000000113',100000.00,'Active'),(113,114,110,15,'IBI0000000114',15000.00,'Active'),(114,115,111,11,'IBI0000000115',50000.00,'Active'),(115,116,112,12,'IBI0000000116',75000.00,'Active'),(116,117,113,13,'IBI0000000117',25000.00,'Active'),(117,118,114,14,'IBI0000000118',100000.00,'Active'),(118,119,115,15,'IBI0000000119',15000.00,'Active'),(119,120,116,11,'IBI0000000120',50000.00,'Active'),(120,121,117,12,'IBI0000000121',75000.00,'Active'),(121,122,118,13,'IBI0000000122',25000.00,'Active'),(122,123,119,14,'IBI0000000123',100000.00,'Active'),(123,124,120,15,'IBI0000000124',15000.00,'Active'),(124,125,121,11,'IBI0000000125',50000.00,'Active'),(125,126,122,12,'IBI0000000126',75000.00,'Active'),(126,127,123,13,'IBI0000000127',25000.00,'Active'),(127,128,124,14,'IBI0000000128',100000.00,'Active'),(128,129,125,15,'IBI0000000129',15000.00,'Active'),(129,130,126,11,'IBI0000000130',50000.00,'Active'),(130,131,127,12,'IBI0000000131',75000.00,'Active'),(131,132,128,13,'IBI0000000132',25000.00,'Active'),(132,133,129,14,'IBI0000000133',100000.00,'Active'),(133,134,130,15,'IBI0000000134',15000.00,'Active'),(134,135,1,11,'IBI0000000135',50000.00,'Active'),(135,136,1,12,'IBI0000000136',75000.00,'Active'),(136,137,1,13,'IBI0000000137',25000.00,'Active'),(137,138,1,14,'IBI0000000138',100000.00,'Active'),(138,139,5,15,'IBI0000000139',15000.00,'Active'),(139,140,6,11,'IBI0000000140',50000.00,'Active'),(140,141,7,12,'IBI0000000141',75000.00,'Active'),(141,142,8,13,'IBI0000000142',25000.00,'Active'),(142,143,9,14,'IBI0000000143',100000.00,'Active'),(143,144,10,15,'IBI0000000144',15000.00,'Active'),(144,145,11,11,'IBI0000000145',50000.00,'Active'),(145,146,12,12,'IBI0000000146',75000.00,'Active'),(146,147,13,13,'IBI0000000147',25000.00,'Active'),(147,148,14,14,'IBI0000000148',100000.00,'Active'),(148,149,15,15,'IBI0000000149',15000.00,'Active'),(149,150,16,11,'IBI0000000150',50000.00,'Active'),(150,151,17,12,'IBI0000000151',75000.00,'Active'),(151,152,18,13,'IBI0000000152',25000.00,'Active'),(152,153,19,14,'IBI0000000153',100000.00,'Active'),(153,154,20,15,'IBI0000000154',15000.00,'Active'),(154,155,21,11,'IBI0000000155',50000.00,'Active'),(155,156,22,12,'IBI0000000156',75000.00,'Active'),(156,157,23,13,'IBI0000000157',25000.00,'Active'),(157,158,24,14,'IBI0000000158',100000.00,'Active'),(158,159,25,15,'IBI0000000159',15000.00,'Active'),(159,160,26,11,'IBI0000000160',50000.00,'Active'),(160,161,27,12,'IBI0000000161',75000.00,'Active'),(161,162,28,13,'IBI0000000162',25000.00,'Active'),(162,163,29,14,'IBI0000000163',100000.00,'Active'),(163,164,30,15,'IBI0000000164',15000.00,'Active'),(164,165,31,11,'IBI0000000165',50000.00,'Active'),(165,166,32,12,'IBI0000000166',75000.00,'Active'),(166,167,33,13,'IBI0000000167',25000.00,'Active'),(167,168,34,14,'IBI0000000168',100000.00,'Active'),(168,169,35,15,'IBI0000000169',15000.00,'Active'),(169,170,36,11,'IBI0000000170',50000.00,'Active'),(170,171,37,12,'IBI0000000171',75000.00,'Active'),(171,172,38,13,'IBI0000000172',25000.00,'Active'),(172,173,39,14,'IBI0000000173',100000.00,'Active'),(173,174,40,15,'IBI0000000174',15000.00,'Active'),(174,175,41,11,'IBI0000000175',50000.00,'Active'),(175,176,42,12,'IBI0000000176',75000.00,'Active'),(176,177,43,13,'IBI0000000177',25000.00,'Active'),(177,178,44,14,'IBI0000000178',100000.00,'Active'),(178,179,45,15,'IBI0000000179',15000.00,'Active'),(179,180,46,11,'IBI0000000180',50000.00,'Active'),(180,181,47,12,'IBI0000000181',75000.00,'Active'),(181,182,48,13,'IBI0000000182',25000.00,'Active'),(182,183,49,14,'IBI0000000183',100000.00,'Active'),(183,184,50,15,'IBI0000000184',15000.00,'Active'),(184,185,51,11,'IBI0000000185',50000.00,'Active'),(185,186,52,12,'IBI0000000186',75000.00,'Active'),(186,187,53,13,'IBI0000000187',25000.00,'Active'),(187,188,54,14,'IBI0000000188',100000.00,'Active'),(188,189,55,15,'IBI0000000189',15000.00,'Active'),(189,190,56,11,'IBI0000000190',50000.00,'Active'),(190,191,57,12,'IBI0000000191',75000.00,'Active'),(191,192,58,13,'IBI0000000192',25000.00,'Active'),(192,193,59,14,'IBI0000000193',100000.00,'Active'),(193,194,60,15,'IBI0000000194',15000.00,'Active'),(194,195,61,11,'IBI0000000195',50000.00,'Active'),(195,196,62,12,'IBI0000000196',75000.00,'Active'),(196,197,63,13,'IBI0000000197',25000.00,'Active'),(197,198,64,14,'IBI0000000198',100000.00,'Active'),(198,199,65,15,'IBI0000000199',15000.00,'Active'),(199,200,66,11,'IBI0000000200',50000.00,'Active'),(200,201,67,12,'IBI0000000201',75000.00,'Active'),(201,202,68,13,'IBI0000000202',25000.00,'Active'),(202,203,69,14,'IBI0000000203',100000.00,'Active'),(203,204,70,15,'IBI0000000204',15000.00,'Active'),(204,205,71,11,'IBI0000000205',50000.00,'Active'),(205,206,72,12,'IBI0000000206',75000.00,'Active'),(206,207,73,13,'IBI0000000207',25000.00,'Active'),(207,208,74,14,'IBI0000000208',100000.00,'Active'),(208,209,75,15,'IBI0000000209',15000.00,'Active'),(209,210,76,11,'IBI0000000210',50000.00,'Active'),(210,211,77,12,'IBI0000000211',75000.00,'Active'),(211,212,78,13,'IBI0000000212',25000.00,'Active'),(212,213,79,14,'IBI0000000213',100000.00,'Active'),(213,214,80,15,'IBI0000000214',15000.00,'Active'),(214,215,81,11,'IBI0000000215',50000.00,'Active'),(215,216,82,12,'IBI0000000216',75000.00,'Active'),(216,217,83,13,'IBI0000000217',25000.00,'Active'),(217,218,84,14,'IBI0000000218',100000.00,'Active'),(218,219,85,15,'IBI0000000219',15000.00,'Active'),(219,220,86,11,'IBI0000000220',50000.00,'Active'),(220,221,87,12,'IBI0000000221',75000.00,'Active'),(221,222,88,13,'IBI0000000222',25000.00,'Active'),(222,223,89,14,'IBI0000000223',100000.00,'Active'),(223,224,90,15,'IBI0000000224',15000.00,'Active'),(224,225,91,11,'IBI0000000225',50000.00,'Active'),(261,226,59,3,'205504194083',167500.00,'Active'),(262,227,12,13,'708666888659',3000.00,'Active'),(263,228,9,12,'719002005065',136500.00,'Active');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_account_balance_audit` AFTER UPDATE ON `account` FOR EACH ROW BEGIN
    IF NOT (OLD.balance <=> NEW.balance) THEN
        INSERT INTO account_balance_audit (
            account_id,
            account_number,
            old_balance,
            new_balance
        )
        VALUES (
            NEW.account_id,
            NEW.account_number,
            OLD.balance,
            NEW.balance
        );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `account_balance_audit`
--

DROP TABLE IF EXISTS `account_balance_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_balance_audit` (
  `audit_id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `old_balance` decimal(15,2) DEFAULT NULL,
  `new_balance` decimal(15,2) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`),
  KEY `fk_balance_audit_account` (`account_id`),
  CONSTRAINT `fk_balance_audit_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_balance_audit`
--

LOCK TABLES `account_balance_audit` WRITE;
/*!40000 ALTER TABLE `account_balance_audit` DISABLE KEYS */;
INSERT INTO `account_balance_audit` VALUES (2,261,'205504194083',250000.00,225000.00,'2026-10-23 12:24:21'),(3,263,'719002005065',54000.00,79000.00,'2026-10-23 12:24:21'),(4,261,'205504194083',225000.00,200000.00,'2026-10-23 13:34:59'),(5,263,'719002005065',79000.00,104000.00,'2026-10-23 13:34:59'),(6,261,'205504194083',200000.00,175000.00,'2026-10-23 13:35:28'),(7,263,'719002005065',104000.00,129000.00,'2026-10-23 13:35:28'),(8,261,'205504194083',175000.00,172500.00,'2026-10-23 13:42:28'),(9,263,'719002005065',129000.00,131500.00,'2026-10-23 13:42:28'),(10,261,'205504194083',172500.00,170000.00,'2026-10-23 13:44:59'),(11,263,'719002005065',131500.00,134000.00,'2026-10-23 13:44:59'),(12,261,'205504194083',170000.00,167500.00,'2026-10-23 13:55:15'),(13,263,'719002005065',134000.00,136500.00,'2026-10-23 13:55:15');
/*!40000 ALTER TABLE `account_balance_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_type`
--

DROP TABLE IF EXISTS `account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_type` (
  `account_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) DEFAULT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `minimum_balance` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_type`
--

LOCK TABLES `account_type` WRITE;
/*!40000 ALTER TABLE `account_type` DISABLE KEYS */;
INSERT INTO `account_type` VALUES (1,'Savings',4.00,1000.00),(2,'Current',0.00,5000.00),(3,'Savings',4.00,1000.00),(4,'Current',0.00,5000.00),(5,'Savings',4.00,1000.00),(6,'Current',0.00,5000.00),(7,'Savings',4.00,1000.00),(8,'Current',0.00,5000.00),(9,'Savings',4.00,1000.00),(10,'Current',0.00,5000.00),(11,'Savings Account',4.00,1000.00),(12,'Current Account',0.00,5000.00),(13,'Salary Account',3.50,0.00),(14,'Fixed Deposit',7.00,5000.00),(15,'Recurring Deposit',6.50,500.00);
/*!40000 ALTER TABLE `account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beneficiary`
--

DROP TABLE IF EXISTS `beneficiary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beneficiary` (
  `beneficiary_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `account_type_id` int DEFAULT NULL,
  `beneficiary_name` varchar(100) DEFAULT NULL,
  `beneficiary_account_no` varchar(20) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `IFSC` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`beneficiary_id`),
  KEY `account_id` (`account_id`),
  KEY `fk_beneficiary_account_type` (`account_type_id`),
  CONSTRAINT `beneficiary_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_beneficiary_account_type` FOREIGN KEY (`account_type_id`) REFERENCES `account_type` (`account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beneficiary`
--

LOCK TABLES `beneficiary` WRITE;
/*!40000 ALTER TABLE `beneficiary` DISABLE KEYS */;
INSERT INTO `beneficiary` VALUES (1,1,12,'Aarav Sharma 001','IBI0000000006','IBI Bank','IBIB0001003','Active',NULL),(4,8,12,'Priya Gupta 006','IBI0000000011','Ballygunge Branch','IBIB0001005','Active',NULL),(8,7,15,'Riya Das 014','IBI0000000019','Dhanbad Bank More Branch','IBIB0001013','Inactive','2026-10-18 01:30:07'),(9,7,13,'Aditi Kumar 002','IBI0000000007','Salt Lake Sector V Branch','IBIB0001001','Inactive','2026-10-18 01:39:38');
/*!40000 ALTER TABLE `beneficiary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) DEFAULT NULL,
  `IFSC` varchar(20) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,'Newtown Main Branch','IBIB0001003','Kolkata'),(5,'Salt Lake Sector V Branch','IBIB0001001','Kolkata'),(6,'Park Street Branch','IBIB0001002','Kolkata'),(7,'New Town Action Area 1 Branch','IBIB0001003','Kolkata'),(8,'Howrah Station Branch','IBIB0001004','Howrah'),(9,'Ballygunge Branch','IBIB0001005','Kolkata'),(10,'Barasat Station Road Branch','IBIB0001006','Barasat'),(11,'Durgapur City Centre Branch','IBIB0001008','Durgapur'),(12,'Asansol Main Branch','IBIB0001009','Asansol'),(13,'Siliguri Hill Cart Road Branch','IBIB0001010','Siliguri'),(14,'Kharagpur Main Branch','IBIB0001011','Kharagpur'),(15,'Tatanagar Main Branch','IBIB0001007','Jamshedpur'),(16,'Ranchi Main Branch','IBIB0001012','Ranchi'),(17,'Dhanbad Bank More Branch','IBIB0001013','Dhanbad'),(18,'Bokaro Steel City Branch','IBIB0001014','Bokaro'),(19,'Deoghar Tower Chowk Branch','IBIB0001015','Deoghar'),(20,'Patna Fraser Road Branch','IBIB0001016','Patna'),(21,'Gaya Station Road Branch','IBIB0001017','Gaya'),(22,'Muzaffarpur Main Branch','IBIB0001018','Muzaffarpur'),(23,'Bhagalpur Main Branch','IBIB0001019','Bhagalpur'),(24,'Darbhanga Tower Chowk Branch','IBIB0001020','Darbhanga'),(25,'Bhubaneswar Saheed Nagar Branch','IBIB0001021','Bhubaneswar'),(26,'Cuttack Badambadi Branch','IBIB0001022','Cuttack'),(27,'Rourkela Main Branch','IBIB0001023','Rourkela'),(28,'Berhampur Main Branch','IBIB0001024','Berhampur'),(29,'Puri Grand Road Branch','IBIB0001025','Puri'),(30,'Guwahati GS Road Branch','IBIB0001026','Guwahati'),(31,'Dibrugarh Main Branch','IBIB0001027','Dibrugarh'),(32,'Silchar Central Road Branch','IBIB0001028','Silchar'),(33,'Jorhat Main Branch','IBIB0001029','Jorhat'),(34,'Connaught Place Branch','IBIB0001030','New Delhi'),(35,'Karol Bagh Branch','IBIB0001031','New Delhi'),(36,'Dwarka Sector 10 Branch','IBIB0001032','New Delhi'),(37,'Rohini Sector 7 Branch','IBIB0001033','New Delhi'),(38,'Saket Branch','IBIB0001034','New Delhi'),(39,'Lucknow Hazratganj Branch','IBIB0001035','Lucknow'),(40,'Noida Sector 18 Branch','IBIB0001036','Noida'),(41,'Kanpur Mall Road Branch','IBIB0001037','Kanpur'),(42,'Agra MG Road Branch','IBIB0001038','Agra'),(43,'Varanasi Cantt Branch','IBIB0001039','Varanasi'),(44,'Prayagraj Civil Lines Branch','IBIB0001040','Prayagraj'),(45,'Ghaziabad Raj Nagar Branch','IBIB0001041','Ghaziabad'),(46,'Meerut Garh Road Branch','IBIB0001042','Meerut'),(47,'Gorakhpur Golghar Branch','IBIB0001043','Gorakhpur'),(48,'Bareilly Civil Lines Branch','IBIB0001044','Bareilly'),(49,'Dehradun Rajpur Road Branch','IBIB0001045','Dehradun'),(50,'Haridwar Ranipur More Branch','IBIB0001046','Haridwar'),(51,'Haldwani Main Branch','IBIB0001047','Haldwani'),(52,'Gurugram MG Road Branch','IBIB0001048','Gurugram'),(53,'Faridabad Sector 15 Branch','IBIB0001049','Faridabad'),(54,'Panipat Main Branch','IBIB0001050','Panipat'),(55,'Karnal Mall Road Branch','IBIB0001051','Karnal'),(56,'Hisar Main Branch','IBIB0001052','Hisar'),(57,'Chandigarh Sector 17 Branch','IBIB0001053','Chandigarh'),(58,'Ludhiana Feroze Gandhi Market Branch','IBIB0001054','Ludhiana'),(59,'Amritsar Mall Road Branch','IBIB0001055','Amritsar'),(60,'Jalandhar Model Town Branch','IBIB0001056','Jalandhar'),(61,'Patiala Leela Bhawan Branch','IBIB0001057','Patiala'),(62,'Jaipur MI Road Branch','IBIB0001058','Jaipur'),(63,'Jodhpur Sardarpura Branch','IBIB0001059','Jodhpur'),(64,'Udaipur Chetak Circle Branch','IBIB0001060','Udaipur'),(65,'Kota Talwandi Branch','IBIB0001061','Kota'),(66,'Ajmer Civil Lines Branch','IBIB0001062','Ajmer'),(67,'Ahmedabad CG Road Branch','IBIB0001063','Ahmedabad'),(68,'Surat Ring Road Branch','IBIB0001064','Surat'),(69,'Vadodara Alkapuri Branch','IBIB0001065','Vadodara'),(70,'Rajkot Kalawad Road Branch','IBIB0001066','Rajkot'),(71,'Gandhinagar Sector 11 Branch','IBIB0001067','Gandhinagar'),(72,'Mumbai Nariman Point Branch','IBIB0001068','Mumbai'),(73,'Mumbai Andheri West Branch','IBIB0001069','Mumbai'),(74,'Pune FC Road Branch','IBIB0001070','Pune'),(75,'Nagpur Sitabuldi Branch','IBIB0001071','Nagpur'),(76,'Nashik College Road Branch','IBIB0001072','Nashik'),(77,'Thane Ghodbunder Road Branch','IBIB0001073','Thane'),(78,'Aurangabad CIDCO Branch','IBIB0001074','Aurangabad'),(79,'Kolhapur Rajarampuri Branch','IBIB0001075','Kolhapur'),(80,'Panaji MG Road Branch','IBIB0001076','Panaji'),(81,'Margao Main Branch','IBIB0001077','Margao'),(82,'Bhopal MP Nagar Branch','IBIB0001078','Bhopal'),(83,'Indore Vijay Nagar Branch','IBIB0001079','Indore'),(84,'Gwalior City Centre Branch','IBIB0001080','Gwalior'),(85,'Jabalpur Wright Town Branch','IBIB0001081','Jabalpur'),(86,'Ujjain Freeganj Branch','IBIB0001082','Ujjain'),(87,'Raipur GE Road Branch','IBIB0001083','Raipur'),(88,'Bhilai Civic Centre Branch','IBIB0001084','Bhilai'),(89,'Bilaspur Main Branch','IBIB0001085','Bilaspur'),(90,'Hyderabad Banjara Hills Branch','IBIB0001086','Hyderabad'),(91,'Hyderabad Hitech City Branch','IBIB0001087','Hyderabad'),(92,'Warangal Hanamkonda Branch','IBIB0001088','Warangal'),(93,'Nizamabad Main Branch','IBIB0001089','Nizamabad'),(94,'Vijayawada MG Road Branch','IBIB0001090','Vijayawada'),(95,'Visakhapatnam Dwaraka Nagar Branch','IBIB0001091','Visakhapatnam'),(96,'Guntur Main Branch','IBIB0001092','Guntur'),(97,'Tirupati Temple Road Branch','IBIB0001093','Tirupati'),(98,'Nellore Main Branch','IBIB0001094','Nellore'),(99,'Bengaluru MG Road Branch','IBIB0001095','Bengaluru'),(100,'Bengaluru Whitefield Branch','IBIB0001096','Bengaluru'),(101,'Mysuru Sayyaji Rao Road Branch','IBIB0001097','Mysuru'),(102,'Mangaluru Hampankatta Branch','IBIB0001098','Mangaluru'),(103,'Hubballi Main Branch','IBIB0001099','Hubballi'),(104,'Belagavi Main Branch','IBIB0001100','Belagavi'),(105,'Chennai Anna Salai Branch','IBIB0001101','Chennai'),(106,'Chennai T Nagar Branch','IBIB0001102','Chennai'),(107,'Coimbatore RS Puram Branch','IBIB0001103','Coimbatore'),(108,'Madurai KK Nagar Branch','IBIB0001104','Madurai'),(109,'Salem Main Branch','IBIB0001105','Salem'),(110,'Tiruchirappalli Cantonment Branch','IBIB0001106','Tiruchirappalli'),(111,'Tiruppur Main Branch','IBIB0001107','Tiruppur'),(112,'Thiruvananthapuram MG Road Branch','IBIB0001108','Thiruvananthapuram'),(113,'Kochi MG Road Branch','IBIB0001109','Kochi'),(114,'Kozhikode Main Branch','IBIB0001110','Kozhikode'),(115,'Thrissur Swaraj Round Branch','IBIB0001111','Thrissur'),(116,'Kollam Main Branch','IBIB0001112','Kollam'),(117,'Puducherry Mission Street Branch','IBIB0001113','Puducherry'),(118,'Srinagar Lal Chowk Branch','IBIB0001114','Srinagar'),(119,'Jammu Gandhi Nagar Branch','IBIB0001115','Jammu'),(120,'Shimla Mall Road Branch','IBIB0001116','Shimla'),(121,'Dharamshala Main Branch','IBIB0001117','Dharamshala'),(122,'Vasco Da Gama Branch','IBIB0001118','Vasco da Gama'),(123,'Imphal Main Branch','IBIB0001119','Imphal'),(124,'Shillong Police Bazar Branch','IBIB0001120','Shillong'),(125,'Agartala Main Branch','IBIB0001121','Agartala'),(126,'Aizawl Main Branch','IBIB0001122','Aizawl'),(127,'Kohima Main Branch','IBIB0001123','Kohima'),(128,'Itanagar Main Branch','IBIB0001124','Itanagar'),(129,'Gangtok MG Marg Branch','IBIB0001125','Gangtok'),(130,'Newtown Main Branch','BANK0001234','kolkata');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `status` varchar(20) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'SK JISHAN AHAMED','jishan@example.com','9876543210','Kolkata, West Bengal','Active'),(6,'Aarav Sharma 001','aarav.sharma001@gmail.com','9000000001','Salt Lake, Kolkata, West Bengal - 700091','Active'),(7,'Aditi Kumar 002','aditi.kumar002@gmail.com','9000000002','New Town, Kolkata, West Bengal - 700156','Active'),(8,'Arjun Singh 003','arjun.singh003@gmail.com','9000000003','Park Street, Kolkata, West Bengal - 700016','Active'),(9,'Ananya Das 004','ananya.das004@gmail.com','9000000004','Ballygunge, Kolkata, West Bengal - 700019','Active'),(10,'Rahul Patel 005','rahul.patel005@gmail.com','9000000005','Howrah, West Bengal - 711101','Active'),(11,'Priya Gupta 006','priya.gupta006@gmail.com','9000000006','Barasat, West Bengal - 700124','Active'),(12,'Rohan Roy 007','rohan.roy007@gmail.com','9000000007','Durgapur, West Bengal - 713216','Active'),(13,'Sneha Banerjee 008','sneha.banerjee008@gmail.com','9000000008','Asansol, West Bengal - 713301','Active'),(14,'Amit Mukherjee 009','amit.mukherjee009@gmail.com','9000000009','Siliguri, West Bengal - 734001','Active'),(15,'Neha Chatterjee 010','neha.chatterjee010@gmail.com','9000000010','Kharagpur, West Bengal - 721301','Active'),(16,'Vikram Sharma 011','vikram.sharma011@gmail.com','9000000011','Patna, Bihar - 800001','Active'),(17,'Pooja Kumar 012','pooja.kumar012@gmail.com','9000000012','Gaya, Bihar - 823001','Active'),(18,'Karan Singh 013','karan.singh013@gmail.com','9000000013','Muzaffarpur, Bihar - 842001','Active'),(19,'Riya Das 014','riya.das014@gmail.com','9000000014','Bhagalpur, Bihar - 812001','Active'),(20,'Sanjay Patel 015','sanjay.patel015@gmail.com','9000000015','Ranchi, Jharkhand - 834001','Active'),(21,'Kavya Gupta 016','kavya.gupta016@gmail.com','9000000016','Jamshedpur, Jharkhand - 831001','Active'),(22,'Nikhil Roy 017','nikhil.roy017@gmail.com','9000000017','Dhanbad, Jharkhand - 826001','Active'),(23,'Meera Banerjee 018','meera.banerjee018@gmail.com','9000000018','Bokaro, Jharkhand - 827004','Active'),(24,'Aditya Mukherjee 019','aditya.mukherjee019@gmail.com','9000000019','Bhubaneswar, Odisha - 751001','Active'),(25,'Ishita Chatterjee 020','ishita.chatterjee020@gmail.com','9000000020','Cuttack, Odisha - 753001','Active'),(26,'Varun Sharma 021','varun.sharma021@gmail.com','9000000021','Rourkela, Odisha - 769001','Active'),(27,'Simran Kumar 022','simran.kumar022@gmail.com','9000000022','Puri, Odisha - 752001','Active'),(28,'Aarav Singh 023','aarav.singh023@gmail.com','9000000023','Guwahati, Assam - 781001','Active'),(29,'Aditi Das 024','aditi.das024@gmail.com','9000000024','Dibrugarh, Assam - 786001','Active'),(30,'Arjun Patel 025','arjun.patel025@gmail.com','9000000025','Silchar, Assam - 788001','Active'),(31,'Ananya Gupta 026','ananya.gupta026@gmail.com','9000000026','Delhi - 110001','Active'),(32,'Rahul Roy 027','rahul.roy027@gmail.com','9000000027','Karol Bagh, New Delhi - 110005','Active'),(33,'Priya Banerjee 028','priya.banerjee028@gmail.com','9000000028','Dwarka, New Delhi - 110075','Active'),(34,'Rohan Mukherjee 029','rohan.mukherjee029@gmail.com','9000000029','Rohini, New Delhi - 110085','Active'),(35,'Sneha Chatterjee 030','sneha.chatterjee030@gmail.com','9000000030','Saket, New Delhi - 110017','Active'),(36,'Amit Sharma 031','amit.sharma031@gmail.com','9000000031','Lucknow, Uttar Pradesh - 226001','Active'),(37,'Neha Kumar 032','neha.kumar032@gmail.com','9000000032','Noida, Uttar Pradesh - 201301','Active'),(38,'Vikram Singh 033','vikram.singh033@gmail.com','9000000033','Kanpur, Uttar Pradesh - 208001','Active'),(39,'Pooja Das 034','pooja.das034@gmail.com','9000000034','Agra, Uttar Pradesh - 282001','Active'),(40,'Karan Patel 035','karan.patel035@gmail.com','9000000035','Varanasi, Uttar Pradesh - 221001','Active'),(41,'Riya Gupta 036','riya.gupta036@gmail.com','9000000036','Prayagraj, Uttar Pradesh - 211001','Active'),(42,'Sanjay Roy 037','sanjay.roy037@gmail.com','9000000037','Ghaziabad, Uttar Pradesh - 201001','Active'),(43,'Kavya Banerjee 038','kavya.banerjee038@gmail.com','9000000038','Meerut, Uttar Pradesh - 250001','Active'),(44,'Nikhil Mukherjee 039','nikhil.mukherjee039@gmail.com','9000000039','Gorakhpur, Uttar Pradesh - 273001','Active'),(45,'Meera Chatterjee 040','meera.chatterjee040@gmail.com','9000000040','Bareilly, Uttar Pradesh - 243001','Active'),(46,'Aditya Sharma 041','aditya.sharma041@gmail.com','9000000041','Dehradun, Uttarakhand - 248001','Active'),(47,'Ishita Kumar 042','ishita.kumar042@gmail.com','9000000042','Haridwar, Uttarakhand - 249401','Active'),(48,'Varun Singh 043','varun.singh043@gmail.com','9000000043','Haldwani, Uttarakhand - 263139','Active'),(49,'Simran Das 044','simran.das044@gmail.com','9000000044','Jaipur, Rajasthan - 302001','Active'),(50,'Aarav Patel 045','aarav.patel045@gmail.com','9000000045','Jodhpur, Rajasthan - 342001','Active'),(51,'Aditi Gupta 046','aditi.gupta046@gmail.com','9000000046','Udaipur, Rajasthan - 313001','Active'),(52,'Arjun Roy 047','arjun.roy047@gmail.com','9000000047','Kota, Rajasthan - 324001','Active'),(53,'Ananya Banerjee 048','ananya.banerjee048@gmail.com','9000000048','Ajmer, Rajasthan - 305001','Active'),(54,'Rahul Mukherjee 049','rahul.mukherjee049@gmail.com','9000000049','Ahmedabad, Gujarat - 380001','Active'),(55,'Priya Chatterjee 050','priya.chatterjee050@gmail.com','9000000050','Surat, Gujarat - 395003','Active'),(56,'Rohan Sharma 051','rohan.sharma051@gmail.com','9000000051','Vadodara, Gujarat - 390001','Active'),(57,'Sneha Kumar 052','sneha.kumar052@gmail.com','9000000052','Rajkot, Gujarat - 360001','Active'),(58,'Amit Singh 053','amit.singh053@gmail.com','9000000053','Gandhinagar, Gujarat - 382010','Active'),(59,'Neha Patel 054','neha.patel054@gmail.com','9000000054','Mumbai, Maharashtra - 400001','Active'),(60,'Vikram Gupta 055','vikram.gupta055@gmail.com','9000000055','Andheri, Mumbai - 400058','Active'),(61,'Pooja Roy 056','pooja.roy056@gmail.com','9000000056','Pune, Maharashtra - 411001','Active'),(62,'Karan Banerjee 057','karan.banerjee057@gmail.com','9000000057','Nagpur, Maharashtra - 440001','Active'),(63,'Riya Mukherjee 058','riya.mukherjee058@gmail.com','9000000058','Nashik, Maharashtra - 422001','Active'),(64,'Sanjay Chatterjee 059','sanjay.chatterjee059@gmail.com','9000000059','Thane, Maharashtra - 400601','Active'),(65,'Kavya Sharma 060','kavya.sharma060@gmail.com','9000000060','Kolhapur, Maharashtra - 416001','Active'),(66,'Nikhil Kumar 061','nikhil.kumar061@gmail.com','9000000061','Bhopal, Madhya Pradesh - 462001','Active'),(67,'Meera Singh 062','meera.singh062@gmail.com','9000000062','Indore, Madhya Pradesh - 452001','Active'),(68,'Aditya Das 063','aditya.das063@gmail.com','9000000063','Gwalior, Madhya Pradesh - 474001','Active'),(69,'Ishita Patel 064','ishita.patel064@gmail.com','9000000064','Jabalpur, Madhya Pradesh - 482001','Active'),(70,'Varun Gupta 065','varun.gupta065@gmail.com','9000000065','Ujjain, Madhya Pradesh - 456001','Active'),(71,'Simran Roy 066','simran.roy066@gmail.com','9000000066','Raipur, Chhattisgarh - 492001','Active'),(72,'Aarav Banerjee 067','aarav.banerjee067@gmail.com','9000000067','Bhilai, Chhattisgarh - 490001','Active'),(73,'Aditi Mukherjee 068','aditi.mukherjee068@gmail.com','9000000068','Bilaspur, Chhattisgarh - 495001','Active'),(74,'Arjun Chatterjee 069','arjun.chatterjee069@gmail.com','9000000069','Panaji, Goa - 403001','Active'),(75,'Ananya Sharma 070','ananya.sharma070@gmail.com','9000000070','Margao, Goa - 403601','Active'),(76,'Rahul Kumar 071','rahul.kumar071@gmail.com','9000000071','Hyderabad, Telangana - 500001','Active'),(77,'Priya Singh 072','priya.singh072@gmail.com','9000000072','Banjara Hills, Hyderabad - 500034','Active'),(78,'Rohan Das 073','rohan.das073@gmail.com','9000000073','Warangal, Telangana - 506001','Active'),(79,'Sneha Patel 074','sneha.patel074@gmail.com','9000000074','Vijayawada, Andhra Pradesh - 520001','Active'),(80,'Amit Gupta 075','amit.gupta075@gmail.com','9000000075','Visakhapatnam, Andhra Pradesh - 530001','Active'),(81,'Neha Roy 076','neha.roy076@gmail.com','9000000076','Guntur, Andhra Pradesh - 522001','Active'),(82,'Vikram Banerjee 077','vikram.banerjee077@gmail.com','9000000077','Tirupati, Andhra Pradesh - 517501','Active'),(83,'Pooja Mukherjee 078','pooja.mukherjee078@gmail.com','9000000078','Bengaluru, Karnataka - 560001','Active'),(84,'Karan Chatterjee 079','karan.chatterjee079@gmail.com','9000000079','Whitefield, Bengaluru - 560066','Active'),(85,'Riya Sharma 080','riya.sharma080@gmail.com','9000000080','Mysuru, Karnataka - 570001','Active'),(86,'Sanjay Kumar 081','sanjay.kumar081@gmail.com','9000000081','Mangaluru, Karnataka - 575001','Active'),(87,'Kavya Singh 082','kavya.singh082@gmail.com','9000000082','Hubballi, Karnataka - 580020','Active'),(88,'Nikhil Das 083','nikhil.das083@gmail.com','9000000083','Chennai, Tamil Nadu - 600001','Active'),(89,'Meera Patel 084','meera.patel084@gmail.com','9000000084','T Nagar, Chennai - 600017','Active'),(90,'Aditya Gupta 085','aditya.gupta085@gmail.com','9000000085','Coimbatore, Tamil Nadu - 641001','Active'),(91,'Ishita Roy 086','ishita.roy086@gmail.com','9000000086','Madurai, Tamil Nadu - 625001','Active'),(92,'Varun Banerjee 087','varun.banerjee087@gmail.com','9000000087','Salem, Tamil Nadu - 636001','Active'),(93,'Simran Mukherjee 088','simran.mukherjee088@gmail.com','9000000088','Kochi, Kerala - 682001','Active'),(94,'Aarav Chatterjee 089','aarav.chatterjee089@gmail.com','9000000089','Thiruvananthapuram, Kerala - 695001','Active'),(95,'Aditi Sharma 090','aditi.sharma090@gmail.com','9000000090','Kozhikode, Kerala - 673001','Active'),(96,'Arjun Kumar 091','arjun.kumar091@gmail.com','9000000091','Thrissur, Kerala - 680001','Active'),(97,'Ananya Singh 092','ananya.singh092@gmail.com','9000000092','Chandigarh - 160001','Active'),(98,'Rahul Das 093','rahul.das093@gmail.com','9000000093','Ludhiana, Punjab - 141001','Active'),(99,'Priya Patel 094','priya.patel094@gmail.com','9000000094','Amritsar, Punjab - 143001','Active'),(100,'Rohan Gupta 095','rohan.gupta095@gmail.com','9000000095','Jalandhar, Punjab - 144001','Active'),(101,'Sneha Roy 096','sneha.roy096@gmail.com','9000000096','Patiala, Punjab - 147001','Active'),(104,'Vikram Chatterjee 099','vikram.chatterjee099@gmail.com','9000000099','Panipat, Haryana - 132103','Active'),(105,'Pooja Sharma 100','pooja.sharma100@gmail.com','9000000100','Karnal, Haryana - 132001','Active'),(106,'Karan Kumar 101','karan.kumar101@gmail.com','9000000101','Shimla, Himachal Pradesh - 171001','Active'),(107,'Riya Singh 102','riya.singh102@gmail.com','9000000102','Dharamshala, Himachal Pradesh - 176215','Active'),(108,'Sanjay Das 103','sanjay.das103@gmail.com','9000000103','Jammu, Jammu and Kashmir - 180001','Active'),(109,'Kavya Patel 104','kavya.patel104@gmail.com','9000000104','Srinagar, Jammu and Kashmir - 190001','Active'),(110,'Nikhil Gupta 105','nikhil.gupta105@gmail.com','9000000105','Imphal, Manipur - 795001','Active'),(111,'Meera Roy 106','meera.roy106@gmail.com','9000000106','Shillong, Meghalaya - 793001','Active'),(112,'Aditya Banerjee 107','aditya.banerjee107@gmail.com','9000000107','Agartala, Tripura - 799001','Active'),(113,'Ishita Mukherjee 108','ishita.mukherjee108@gmail.com','9000000108','Aizawl, Mizoram - 796001','Active'),(114,'Varun Chatterjee 109','varun.chatterjee109@gmail.com','9000000109','Kohima, Nagaland - 797001','Active'),(115,'Simran Sharma 110','simran.sharma110@gmail.com','9000000110','Itanagar, Arunachal Pradesh - 791111','Active'),(116,'Aarav Kumar 111','aarav.kumar111@gmail.com','9000000111','Gangtok, Sikkim - 737101','Active'),(117,'Aditi Singh 112','aditi.singh112@gmail.com','9000000112','Ranchi, Jharkhand - 834001','Active'),(118,'Arjun Das 113','arjun.das113@gmail.com','9000000113','Dhanbad, Jharkhand - 826001','Active'),(119,'Ananya Patel 114','ananya.patel114@gmail.com','9000000114','Bokaro, Jharkhand - 827004','Active'),(120,'Rahul Gupta 115','rahul.gupta115@gmail.com','9000000115','Deoghar, Jharkhand - 814112','Active'),(121,'Priya Roy 116','priya.roy116@gmail.com','9000000116','Cuttack, Odisha - 753001','Active'),(122,'Rohan Banerjee 117','rohan.banerjee117@gmail.com','9000000117','Berhampur, Odisha - 760001','Active'),(123,'Sneha Mukherjee 118','sneha.mukherjee118@gmail.com','9000000118','Puri, Odisha - 752001','Active'),(124,'Amit Chatterjee 119','amit.chatterjee119@gmail.com','9000000119','Siliguri, West Bengal - 734001','Active'),(125,'Neha Sharma 120','neha.sharma120@gmail.com','9000000120','Durgapur, West Bengal - 713216','Active'),(126,'Vikram Kumar 121','vikram.kumar121@gmail.com','9000000121','Asansol, West Bengal - 713301','Active'),(127,'Pooja Singh 122','pooja.singh122@gmail.com','9000000122','Howrah, West Bengal - 711101','Active'),(128,'Karan Das 123','karan.das123@gmail.com','9000000123','Barasat, West Bengal - 700124','Active'),(129,'Riya Patel 124','riya.patel124@gmail.com','9000000124','Kolkata, West Bengal - 700001','Active'),(130,'Sanjay Gupta 125','sanjay.gupta125@gmail.com','9000000125','Kolkata, West Bengal - 700091','Active'),(131,'Kavya Roy 126','kavya.roy126@gmail.com','9000000126','Kolkata, West Bengal - 700156','Active'),(132,'Nikhil Banerjee 127','nikhil.banerjee127@gmail.com','9000000127','Kolkata, West Bengal - 700016','Active'),(133,'Meera Mukherjee 128','meera.mukherjee128@gmail.com','9000000128','Kolkata, West Bengal - 700019','Active'),(134,'Aditya Chatterjee 129','aditya.chatterjee129@gmail.com','9000000129','Kolkata, West Bengal - 700020','Active'),(135,'Ishita Sharma 130','ishita.sharma130@gmail.com','9000000130','Kolkata, West Bengal - 700029','Active'),(136,'Varun Kumar 131','varun.kumar131@gmail.com','9000000131','Mumbai, Maharashtra - 400001','Active'),(137,'Simran Singh 132','simran.singh132@gmail.com','9000000132','Pune, Maharashtra - 411001','Active'),(138,'Aarav Das 133','aarav.das133@gmail.com','9000000133','Nagpur, Maharashtra - 440001','Active'),(139,'Aditi Patel 134','aditi.patel134@gmail.com','9000000134','Nashik, Maharashtra - 422001','Active'),(140,'Arjun Gupta 135','arjun.gupta135@gmail.com','9000000135','Thane, Maharashtra - 400601','Active'),(141,'Ananya Roy 136','ananya.roy136@gmail.com','9000000136','Kolhapur, Maharashtra - 416001','Active'),(142,'Rahul Banerjee 137','rahul.banerjee137@gmail.com','9000000137','Ahmedabad, Gujarat - 380001','Active'),(143,'Priya Mukherjee 138','priya.mukherjee138@gmail.com','9000000138','Surat, Gujarat - 395003','Active'),(144,'Rohan Chatterjee 139','rohan.chatterjee139@gmail.com','9000000139','Vadodara, Gujarat - 390001','Active'),(145,'Sneha Sharma 140','sneha.sharma140@gmail.com','9000000140','Rajkot, Gujarat - 360001','Active'),(146,'Amit Kumar 141','amit.kumar141@gmail.com','9000000141','Ahmedabad, Gujarat - 380015','Active'),(147,'Neha Singh 142','neha.singh142@gmail.com','9000000142','Gandhinagar, Gujarat - 382010','Active'),(148,'Vikram Das 143','vikram.das143@gmail.com','9000000143','Jaipur, Rajasthan - 302001','Active'),(149,'Pooja Patel 144','pooja.patel144@gmail.com','9000000144','Jodhpur, Rajasthan - 342001','Active'),(150,'Karan Gupta 145','karan.gupta145@gmail.com','9000000145','Udaipur, Rajasthan - 313001','Active'),(151,'Riya Roy 146','riya.roy146@gmail.com','9000000146','Kota, Rajasthan - 324001','Active'),(152,'Sanjay Banerjee 147','sanjay.banerjee147@gmail.com','9000000147','Ajmer, Rajasthan - 305001','Active'),(153,'Kavya Mukherjee 148','kavya.mukherjee148@gmail.com','9000000148','Bhopal, Madhya Pradesh - 462001','Active'),(154,'Nikhil Chatterjee 149','nikhil.chatterjee149@gmail.com','9000000149','Indore, Madhya Pradesh - 452001','Active'),(155,'Meera Sharma 150','meera.sharma150@gmail.com','9000000150','Gwalior, Madhya Pradesh - 474001','Active'),(156,'Aditya Kumar 151','aditya.kumar151@gmail.com','9000000151','Jabalpur, Madhya Pradesh - 482001','Active'),(157,'Ishita Singh 152','ishita.singh152@gmail.com','9000000152','Ujjain, Madhya Pradesh - 456001','Active'),(158,'Varun Das 153','varun.das153@gmail.com','9000000153','Raipur, Chhattisgarh - 492001','Active'),(159,'Simran Patel 154','simran.patel154@gmail.com','9000000154','Bhilai, Chhattisgarh - 490001','Active'),(160,'Aarav Gupta 155','aarav.gupta155@gmail.com','9000000155','Bilaspur, Chhattisgarh - 495001','Active'),(161,'Aditi Roy 156','aditi.roy156@gmail.com','9000000156','Hyderabad, Telangana - 500001','Active'),(162,'Arjun Banerjee 157','arjun.banerjee157@gmail.com','9000000157','Hyderabad, Telangana - 500034','Active'),(163,'Ananya Mukherjee 158','ananya.mukherjee158@gmail.com','9000000158','Warangal, Telangana - 506001','Active'),(164,'Rahul Chatterjee 159','rahul.chatterjee159@gmail.com','9000000159','Vijayawada, Andhra Pradesh - 520001','Active'),(165,'Priya Sharma 160','priya.sharma160@gmail.com','9000000160','Visakhapatnam, Andhra Pradesh - 530001','Active'),(166,'Rohan Kumar 161','rohan.kumar161@gmail.com','9000000161','Guntur, Andhra Pradesh - 522001','Active'),(167,'Sneha Singh 162','sneha.singh162@gmail.com','9000000162','Tirupati, Andhra Pradesh - 517501','Active'),(168,'Amit Das 163','amit.das163@gmail.com','9000000163','Bengaluru, Karnataka - 560001','Active'),(169,'Neha Patel 164','neha.patel164@gmail.com','9000000164','Mysuru, Karnataka - 570001','Active'),(170,'Vikram Gupta 165','vikram.gupta165@gmail.com','9000000165','Mangaluru, Karnataka - 575001','Active'),(171,'Pooja Roy 166','pooja.roy166@gmail.com','9000000166','Hubballi, Karnataka - 580020','Active'),(172,'Karan Banerjee 167','karan.banerjee167@gmail.com','9000000167','Chennai, Tamil Nadu - 600001','Active'),(173,'Riya Mukherjee 168','riya.mukherjee168@gmail.com','9000000168','Coimbatore, Tamil Nadu - 641001','Active'),(174,'Sanjay Chatterjee 169','sanjay.chatterjee169@gmail.com','9000000169','Madurai, Tamil Nadu - 625001','Active'),(175,'Kavya Sharma 170','kavya.sharma170@gmail.com','9000000170','Salem, Tamil Nadu - 636001','Active'),(176,'Nikhil Kumar 171','nikhil.kumar171@gmail.com','9000000171','Kochi, Kerala - 682001','Active'),(177,'Meera Singh 172','meera.singh172@gmail.com','9000000172','Thiruvananthapuram, Kerala - 695001','Active'),(178,'Aditya Das 173','aditya.das173@gmail.com','9000000173','Kozhikode, Kerala - 673001','Active'),(179,'Ishita Patel 174','ishita.patel174@gmail.com','9000000174','Thrissur, Kerala - 680001','Active'),(180,'Varun Gupta 175','varun.gupta175@gmail.com','9000000175','Chandigarh - 160001','Active'),(181,'Simran Roy 176','simran.roy176@gmail.com','9000000176','Ludhiana, Punjab - 141001','Active'),(182,'Aarav Banerjee 177','aarav.banerjee177@gmail.com','9000000177','Amritsar, Punjab - 143001','Active'),(183,'Aditi Mukherjee 178','aditi.mukherjee178@gmail.com','9000000178','Jalandhar, Punjab - 144001','Active'),(184,'Arjun Chatterjee 179','arjun.chatterjee179@gmail.com','9000000179','Patiala, Punjab - 147001','Active'),(185,'Ananya Sharma 180','ananya.sharma180@gmail.com','9000000180','Gurugram, Haryana - 122001','Active'),(186,'Rahul Kumar 181','rahul.kumar181@gmail.com','9000000181','Faridabad, Haryana - 121001','Active'),(187,'Priya Singh 182','priya.singh182@gmail.com','9000000182','Panipat, Haryana - 132103','Active'),(188,'Rohan Das 183','rohan.das183@gmail.com','9000000183','Karnal, Haryana - 132001','Active'),(189,'Sneha Patel 184','sneha.patel184@gmail.com','9000000184','Shimla, Himachal Pradesh - 171001','Active'),(190,'Amit Gupta 185','amit.gupta185@gmail.com','9000000185','Dharamshala, Himachal Pradesh - 176215','Active'),(191,'Neha Roy 186','neha.roy186@gmail.com','9000000186','Jammu, Jammu and Kashmir - 180001','Active'),(192,'Vikram Banerjee 187','vikram.banerjee187@gmail.com','9000000187','Srinagar, Jammu and Kashmir - 190001','Active'),(193,'Pooja Mukherjee 188','pooja.mukherjee188@gmail.com','9000000188','Imphal, Manipur - 795001','Active'),(194,'Karan Chatterjee 189','karan.chatterjee189@gmail.com','9000000189','Shillong, Meghalaya - 793001','Active'),(195,'Riya Sharma 190','riya.sharma190@gmail.com','9000000190','Agartala, Tripura - 799001','Active'),(196,'Sanjay Kumar 191','sanjay.kumar191@gmail.com','9000000191','Aizawl, Mizoram - 796001','Active'),(197,'Kavya Singh 192','kavya.singh192@gmail.com','9000000192','Kohima, Nagaland - 797001','Active'),(198,'Nikhil Das 193','nikhil.das193@gmail.com','9000000193','Itanagar, Arunachal Pradesh - 791111','Active'),(199,'Meera Patel 194','meera.patel194@gmail.com','9000000194','Gangtok, Sikkim - 737101','Active'),(200,'Aditya Gupta 195','aditya.gupta195@gmail.com','9000000195','Patna, Bihar - 800001','Active'),(201,'Ishita Roy 196','ishita.roy196@gmail.com','9000000196','Gaya, Bihar - 823001','Active'),(202,'Varun Banerjee 197','varun.banerjee197@gmail.com','9000000197','Muzaffarpur, Bihar - 842001','Active'),(203,'Simran Mukherjee 198','simran.mukherjee198@gmail.com','9000000198','Bhagalpur, Bihar - 812001','Active'),(204,'Aarav Chatterjee 199','aarav.chatterjee199@gmail.com','9000000199','Ranchi, Jharkhand - 834001','Active'),(205,'Aditi Sharma 200','aditi.sharma200@gmail.com','9000000200','Jamshedpur, Jharkhand - 831001','Active'),(206,'Arjun Kumar 201','arjun.kumar201@gmail.com','9000000201','Dhanbad, Jharkhand - 826001','Active'),(207,'Ananya Singh 202','ananya.singh202@gmail.com','9000000202','Bokaro, Jharkhand - 827004','Active'),(208,'Rahul Das 203','rahul.das203@gmail.com','9000000203','Bhubaneswar, Odisha - 751001','Active'),(209,'Priya Patel 204','priya.patel204@gmail.com','9000000204','Cuttack, Odisha - 753001','Active'),(210,'Rohan Gupta 205','rohan.gupta205@gmail.com','9000000205','Rourkela, Odisha - 769001','Active'),(211,'Sneha Roy 206','sneha.roy206@gmail.com','9000000206','Puri, Odisha - 752001','Active'),(212,'Amit Banerjee 207','amit.banerjee207@gmail.com','9000000207','Guwahati, Assam - 781001','Active'),(213,'Neha Mukherjee 208','neha.mukherjee208@gmail.com','9000000208','Dibrugarh, Assam - 786001','Active'),(214,'Vikram Chatterjee 209','vikram.chatterjee209@gmail.com','9000000209','Silchar, Assam - 788001','Active'),(215,'Pooja Sharma 210','pooja.sharma210@gmail.com','9000000210','Jorhat, Assam - 785001','Active'),(216,'Karan Kumar 211','karan.kumar211@gmail.com','9000000211','Kolkata, West Bengal - 700001','Active'),(217,'Riya Singh 212','riya.singh212@gmail.com','9000000212','New Town, Kolkata - 700156','Active'),(218,'Sanjay Das 213','sanjay.das213@gmail.com','9000000213','Mumbai, Maharashtra - 400001','Active'),(219,'Kavya Patel 214','kavya.patel214@gmail.com','9000000214','Pune, Maharashtra - 411001','Active'),(220,'Nikhil Gupta 215','nikhil.gupta215@gmail.com','9000000215','Bengaluru, Karnataka - 560001','Active'),(221,'Meera Roy 216','meera.roy216@gmail.com','9000000216','Chennai, Tamil Nadu - 600001','Active'),(222,'Aditya Banerjee 217','aditya.banerjee217@gmail.com','9000000217','Hyderabad, Telangana - 500001','Active'),(223,'Ishita Mukherjee 218','ishita.mukherjee218@gmail.com','9000000218','Ahmedabad, Gujarat - 380001','Active'),(224,'Varun Chatterjee 219','varun.chatterjee219@gmail.com','9000000219','Jaipur, Rajasthan - 302001','Active'),(225,'Simran Sharma 220','simran.sharma220@gmail.com','9000000220','Lucknow, Uttar Pradesh - 226001','Active'),(226,'Narendra Da','narendrada29@gmail.com','86559628936','bardhaman','Active'),(227,'toufic raj','rajtoufick49@gmail.com','9638527410','arambag','Active'),(228,'tanamay mondal','mondaltanmay706@gmail.com','9632154876','akabpur','Active');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_verification_codes`
--

DROP TABLE IF EXISTS `email_verification_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification_codes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `purpose` enum('signup','login','password_reset') NOT NULL,
  `code_hash` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `consumed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_verification_email_purpose` (`email`,`purpose`),
  KEY `idx_verification_expiry` (`expires_at`),
  KEY `fk_verification_user` (`user_id`),
  CONSTRAINT `fk_verification_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_verification_codes`
--

LOCK TABLES `email_verification_codes` WRITE;
/*!40000 ALTER TABLE `email_verification_codes` DISABLE KEYS */;
INSERT INTO `email_verification_codes` VALUES (1,26,'narendrada29@gmail.com','login','3bbf2f7e2f70e8b46efcff0b8c1214691ff722f3bae196ea3b974336980b9168','2026-10-21 12:31:14',1,'2026-10-21 12:22:49','2026-10-21 12:21:14'),(2,NULL,'mondaltanmay706@gmail.com','signup','VERIFIED','2026-10-21 12:37:35',0,NULL,'2026-10-21 12:27:35'),(3,22,'admin@bank.com','login','21d874c90948c8c752f51953508dfd6c9cf11029a43f2a085e42267d90ee5fa5','2026-10-21 12:40:57',0,NULL,'2026-10-21 12:30:57'),(4,22,'skjishan0018@gmail.com','login','43f4a113dd898c1c3495c89320657f52b968603f8e79106ffb41b8891e4f2a5b','2026-10-21 13:04:19',0,'2026-10-21 12:55:26','2026-10-21 12:54:19'),(5,22,'skjishan0018@gmail.com','login','bd070ce134f0bac09b58d8f5b0d39af91813191d7103a9c4ca07fa11a451dce1','2026-10-21 18:16:39',0,'2026-10-21 18:07:23','2026-10-21 18:06:39'),(6,26,'narendrada29@gmail.com','login','e3b3dcb2103d17207a95fec52cff7e616e8d7734226d799657314fa5b742c52f','2026-10-21 18:17:42',0,'2026-10-21 18:08:16','2026-10-21 18:07:42'),(7,22,'skjishan0018@gmail.com','login','3b115b1bfbfc7b797b657239df8cf20b79ebb330d1d2c3ab57673ead343c1309','2026-10-21 22:25:05',0,'2026-10-21 22:16:35','2026-10-21 22:15:05'),(8,22,'skjishan0018@gmail.com','login','5d45ae61ec635593e234986dcc9ff97e4d03612a9a74beb42167a94340e11dca','2026-10-21 22:26:35',0,'2026-10-21 22:17:20','2026-10-21 22:16:35'),(9,22,'skjishan0018@gmail.com','login','d24af4532a043ac39061da0368fdf9cc2cdc81d8a26b386d97b378ea8c57031d','2026-10-21 22:27:20',0,'2026-10-21 22:17:46','2026-10-21 22:17:20'),(10,22,'skjishan0018@gmail.com','login','08c323952a88fca24918bda4f44ecc21373081c20357bb479f81a22a0c309d1f','2026-10-21 22:27:54',0,'2026-10-21 22:18:18','2026-10-21 22:17:54'),(11,22,'skjishan0018@gmail.com','login','9afe2b9c6e6099256582f0ec3fc6b77ebcf4f0d1effd7027a93921296211ad91','2026-10-21 22:54:49',0,'2026-10-21 22:45:13','2026-10-21 22:44:49'),(12,22,'skjishan0018@gmail.com','login','af5b2b28f5a0ca043e644ee3cb9db21a3b140e602fe1d56bf78b8666036c9a19','2026-10-21 23:12:21',0,'2026-10-21 23:02:55','2026-10-21 23:02:21'),(13,22,'skjishan0018@gmail.com','login','8770097589f25cdf04226a8245961dd236b626c54b4b561401f721ec89c25041','2026-10-22 01:49:27',0,'2026-10-22 01:40:16','2026-10-22 01:39:27'),(14,26,'narendrada29@gmail.com','login','d757d2537763534d68e82da81e1c2ebd6947cfa57577d0239184e78310ef340e','2026-10-22 02:02:20',0,'2026-10-22 01:52:53','2026-10-22 01:52:20'),(15,26,'narendrada29@gmail.com','password_reset','40fbf94d7a66910da894df87bccd452d5964487e1af9effbdbf0222ef9c520bb','2026-10-22 02:03:01',0,'2026-10-22 01:54:15','2026-10-22 01:53:01'),(16,26,'narendrada29@gmail.com','password_reset','493645592a27bbef6d083a8d188ed5ac711c4bdc01899d05c159c12bfd2f75e0','2026-10-22 02:05:04',0,'2026-10-22 01:55:04','2026-10-22 01:55:04'),(17,22,'skjishan0018@gmail.com','login','98940b5cdd70dc8e34a4ce359c24e9e99a2f1b522c4e587e5a269292ca6e7c35','2026-10-22 02:05:37',0,'2026-10-22 01:55:37','2026-10-22 01:55:37'),(18,26,'narendrada29@gmail.com','password_reset','9cf64295313404c59f334ba2772df8721d7dbcec0cd7953a8dbf6c97e02cb48b','2026-10-22 02:20:35',0,'2026-10-22 02:11:48','2026-10-22 02:10:35'),(19,22,'skjishan0018@gmail.com','login','277fe464cbffe7700a7e62998cba74c8031b4a31b3d5ee535a126851925086e6','2026-10-22 12:28:45',1,'2026-10-22 12:19:46','2026-10-22 12:18:45'),(20,26,'narendrada29@gmail.com','password_reset','3a57fd1cbd03e67614714c1b0717229c79a0d2735a70b289a7317543f0cf8513','2026-10-22 12:40:35',0,'2026-10-22 12:30:49','2026-10-22 12:30:35'),(21,26,'narendrada29@gmail.com','password_reset','df43acec6f6fd1572724ef9f90fa035f3f8f796109cc6791e2640e6dbc1cc73c','2026-10-22 12:40:49',0,'2026-10-22 12:32:02','2026-10-22 12:30:49'),(22,26,'narendrada29@gmail.com','password_reset','26d343047e1963e83e100ec914af9eb9ceddba749c02809722c4b01ac6a57b69','2026-10-22 12:50:15',0,'2026-10-22 12:41:12','2026-10-22 12:40:15'),(23,26,'narendrada29@gmail.com','password_reset','35352a616f385e11d76a6b9eb5c13fe082f181091148f2e87c64ad0d5656ccf0','2026-10-22 13:00:43',0,'2026-10-22 12:51:30','2026-10-22 12:50:43'),(24,26,'narendrada29@gmail.com','password_reset','37b64224de190b9871a34aabd5d16981b154e11b2654645da9f255f2b1f89e70','2026-10-22 13:09:00',0,'2026-10-22 12:59:57','2026-10-22 12:59:00'),(25,26,'narendrada29@gmail.com','login','8b5509a03caf58d7da54bc0c92d1172a44aea1fbca2a5628d80d76bab16f2b37','2026-10-22 14:05:40',0,'2026-10-22 13:56:10','2026-10-22 13:55:40'),(26,28,'anismondal377@gmail.com','password_reset','86329b8a3c47fd2475ac7e97d5b572e19252da02458e4648b8a04088363efb63','2026-10-22 14:07:42',0,'2026-10-22 13:58:44','2026-10-22 13:57:42'),(27,28,'anismondal377@gmail.com','login','2fd6f35a9366734fd1a4442ae2de40bdf0a5a9ec49d8ffcf6b4963cd03b66e1d','2026-10-22 14:08:57',0,'2026-10-22 13:59:22','2026-10-22 13:58:57'),(28,28,'anismondal377@gmail.com','login','3b01adbdc95263d32c412bbcfb09ac4d5ea2efd58345d06a63f147a09bf67fc2','2026-10-22 14:09:41',0,'2026-10-22 14:00:10','2026-10-22 13:59:41'),(29,28,'anismondal377@gmail.com','login','cf2486b4ed792b7c256c6d81a4e5261078ddff90c08b7c11ea0e729285e2da04','2026-10-22 14:32:59',0,'2026-10-22 14:23:28','2026-10-22 14:22:59'),(30,28,'anismondal377@gmail.com','login','b3350cd7910677e58e4b145713e4e2ce5ddc563b2c0e43a8f3f4382f9a20f583','2026-10-22 14:35:33',0,'2026-10-22 14:25:49','2026-10-22 14:25:33'),(31,22,'skjishan0018@gmail.com','login','1301b40db35c073a5e6ad289afee924253563bf7a89dad46659e84bfcfc66171','2026-10-22 15:03:15',0,'2026-10-22 14:53:34','2026-10-22 14:53:15'),(32,22,'skjishan0018@gmail.com','login','3ae3d415bfbc6aa04146fdde7059e1a1893d9bb7713b63dfc7c5d131fd0dadbe','2026-10-22 15:05:11',0,'2026-10-22 14:55:34','2026-10-22 14:55:11'),(33,26,'narendrada29@gmail.com','password_reset','69c1204d1bb2c0291b4ddfce67653719c38ef5d4e385aa87ce195e489154ac78','2026-10-22 15:34:51',0,'2026-10-22 15:25:59','2026-10-22 15:24:51'),(34,26,'narendrada29@gmail.com','login','a563b63b52f2758ece5b746c87b571d5e4f013a7a2782acb5bdcf191c0de47ce','2026-10-22 15:36:15',0,'2026-10-22 15:26:32','2026-10-22 15:26:15'),(35,26,'narendrada29@gmail.com','password_reset','b9f2938002f7157da9c77787d635efab46ad397bb5fafa6af449ab26914b8ba9','2026-10-22 15:57:16',0,'2026-10-22 23:14:15','2026-10-22 15:47:16'),(36,22,'skjishan0018@gmail.com','password_reset','3d2618535d0f288e09358a525d1e50367cf6e6d8b87a94007762164e57849b74','2026-10-22 15:58:47',0,'2026-10-22 15:49:08','2026-10-22 15:48:47'),(37,22,'skjishan0018@gmail.com','password_reset','3a9a7fe992871df60380dfb9336691aaf742c1b2146c32b20c00f542f4edc084','2026-10-22 15:59:08',0,'2026-10-22 15:50:17','2026-10-22 15:49:08'),(38,22,'skjishan0018@gmail.com','login','df9fd88cf67c418649410ea67aeb4a623d98f21617e84f15c995e92c5af163bd','2026-10-22 16:00:29',1,'2026-10-22 15:51:03','2026-10-22 15:50:29'),(39,22,'skjishan0018@gmail.com','password_reset','a8d86ef5ae099f9839debf37b08ffb7063f21c71ca6df873cfe83b57a33b9dd0','2026-10-22 17:26:34',0,'2026-10-23 00:03:44','2026-10-22 17:16:34'),(40,26,'narendrada29@gmail.com','password_reset','3cdfa427f5a59d9f656d80a5b5b0656cbfda7b7a5ab85cf74eb2fc99d19ec040','2026-10-22 23:24:15',0,'2026-10-22 23:15:51','2026-10-22 23:14:15'),(41,26,'narendrada29@gmail.com','login','a70066358e1e24d92eb0ab71688827a77084e4172062e525007375228c412faa','2026-10-22 23:52:04',0,'2026-10-22 23:45:24','2026-10-22 23:42:04'),(42,26,'narendrada29@gmail.com','login','ed3e33e92d9d60638093c8257af160d883801b8f5d3f3347a5bf1704236092cb','2026-10-22 23:55:24',0,'2026-10-22 23:56:10','2026-10-22 23:45:24'),(43,26,'narendrada29@gmail.com','login','f25e52d93744f5325f04e17c643334f94be0fab928e4422a777b1ac69abadb0b','2026-10-23 00:06:10',0,'2026-10-23 00:00:57','2026-10-22 23:56:10'),(44,26,'narendrada29@gmail.com','login','9700209c2a4f082c268c61951246f66b16a805177f8ccd729d18e91fc0c89b88','2026-10-23 00:10:57',0,'2026-10-23 00:42:32','2026-10-23 00:00:57'),(45,22,'skjishan0018@gmail.com','login','85b0b9b9647f7ddb93a4f3c708a5375e96af4f03a354fc8c0e5fe519bcb2d9b8','2026-10-23 00:12:33',0,'2026-10-23 00:03:29','2026-10-23 00:02:33'),(46,22,'skjishan0018@gmail.com','password_reset','e1561555b49c45fcd86b3e6384db8bee64e1d0568d7513881a830caf9455037b','2026-10-23 00:13:44',0,'2026-10-23 00:04:16','2026-10-23 00:03:44'),(47,22,'skjishan0018@gmail.com','password_reset','c72e628906a8ebdd88e5930697fe2e7c783e7fbfa81841f03c1083ae5cd27f1d','2026-10-23 00:14:16',1,'2026-10-23 00:06:04','2026-10-23 00:04:16'),(48,22,'skjishan0018@gmail.com','password_reset','6067320d5e376b697e99e047b927d028d8ce84803fe46b1bd28503725967f35a','2026-10-23 00:23:18',0,'2026-10-23 00:14:28','2026-10-23 00:13:18'),(49,22,'skjishan0018@gmail.com','password_reset','afc7962ca653bd083471ada67fe4ef60689fc2da2ec18e9f730073bad5c0b371','2026-10-23 00:27:38',0,'2026-10-23 00:19:17','2026-10-23 00:17:38'),(50,22,'skjishan0018@gmail.com','password_reset','c9f77c0334f8089c13638f3dfc728e16a939e0f73268dbe7465915ca18ee0d6c','2026-10-23 00:36:08',0,'2026-10-23 00:27:18','2026-10-23 00:26:08'),(51,22,'skjishan0018@gmail.com','password_reset','2cdd49fea2d65b80dd840088501ed7569e7d1ebd268291e6fbc3932c2e365100','2026-10-23 00:40:36',0,'2026-10-23 00:31:26','2026-10-23 00:30:36'),(52,26,'narendrada29@gmail.com','login','49d00d6bdc0c13a33ea7951232ddbac8bd5dd810407269da2aa35a5063bf3900','2026-10-23 00:52:32',5,'2026-10-23 17:51:46','2026-10-23 00:42:32'),(53,26,'narendrada29@gmail.com','login','f9245cd30016531c194f984bcfaf413f2a3fbed2c9853eea9578b183691edb3d','2026-10-23 18:01:46',1,'2026-10-23 17:52:22','2026-10-23 17:51:46');
/*!40000 ALTER TABLE `email_verification_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emi_payment`
--

DROP TABLE IF EXISTS `emi_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emi_payment` (
  `emi_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `late_fee` decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`emi_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `emi_payment_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emi_payment`
--

LOCK TABLES `emi_payment` WRITE;
/*!40000 ALTER TABLE `emi_payment` DISABLE KEYS */;
INSERT INTO `emi_payment` VALUES (1,2,'2026-10-08',13000.98,'2026-10-08','Paid',250.00),(2,2,'2026-12-07',13000.98,NULL,'Pending',0.00),(3,2,'2027-01-07',13000.98,NULL,'Pending',0.00),(4,2,'2027-02-07',13000.98,NULL,'Pending',0.00),(5,2,'2027-03-07',13000.98,NULL,'Pending',0.00),(6,2,'2027-04-07',13000.98,NULL,'Pending',0.00),(7,2,'2027-05-07',13000.98,NULL,'Pending',0.00),(8,2,'2027-06-07',13000.98,NULL,'Pending',0.00),(9,2,'2027-07-07',13000.98,NULL,'Pending',0.00),(10,2,'2027-08-07',13000.98,NULL,'Pending',0.00),(11,2,'2027-09-07',13000.98,NULL,'Pending',0.00),(12,2,'2027-10-07',13000.98,NULL,'Pending',0.00),(13,2,'2027-11-07',13000.98,NULL,'Pending',0.00),(14,2,'2027-12-07',13000.98,NULL,'Pending',0.00),(15,2,'2028-01-07',13000.98,NULL,'Pending',0.00),(16,2,'2028-02-07',13000.98,NULL,'Pending',0.00),(17,2,'2028-03-07',13000.98,NULL,'Pending',0.00),(18,2,'2028-04-07',13000.98,NULL,'Pending',0.00),(19,2,'2028-05-07',13000.98,NULL,'Pending',0.00),(20,2,'2028-06-07',13000.98,NULL,'Pending',0.00),(21,2,'2028-07-07',13000.98,NULL,'Pending',0.00),(22,2,'2028-08-07',13000.98,NULL,'Pending',0.00),(23,2,'2028-09-07',13000.98,NULL,'Pending',0.00),(24,2,'2028-10-07',13000.98,NULL,'Pending',0.00),(25,2,'2028-11-07',13000.98,NULL,'Pending',0.00),(26,2,'2028-12-07',13000.98,NULL,'Pending',0.00),(27,2,'2029-01-07',13000.98,NULL,'Pending',0.00),(28,2,'2029-02-07',13000.98,NULL,'Pending',0.00),(29,2,'2029-03-07',13000.98,NULL,'Pending',0.00),(30,2,'2029-04-07',13000.98,NULL,'Pending',0.00),(31,2,'2029-05-07',13000.98,NULL,'Pending',0.00),(32,2,'2029-06-07',13000.98,NULL,'Pending',0.00),(33,2,'2029-07-07',13000.98,NULL,'Pending',0.00),(34,2,'2029-08-07',13000.98,NULL,'Pending',0.00),(35,2,'2029-09-07',13000.98,NULL,'Pending',0.00),(36,2,'2029-10-07',13000.98,NULL,'Pending',0.00),(37,3,'2026-10-08',13215.07,'2026-10-08','Paid',250.00),(38,3,'2026-12-08',13215.07,NULL,'Pending',0.00),(39,3,'2027-01-08',13215.07,NULL,'Pending',0.00),(40,3,'2027-02-08',13215.07,NULL,'Pending',0.00),(41,3,'2027-03-08',13215.07,NULL,'Pending',0.00),(42,3,'2027-04-08',13215.07,NULL,'Pending',0.00),(43,3,'2027-05-08',13215.07,NULL,'Pending',0.00),(44,3,'2027-06-08',13215.07,NULL,'Pending',0.00),(45,3,'2027-07-08',13215.07,NULL,'Pending',0.00),(46,3,'2027-08-08',13215.07,NULL,'Pending',0.00),(47,3,'2027-09-08',13215.07,NULL,'Pending',0.00),(48,3,'2027-10-08',13215.07,NULL,'Pending',0.00),(49,3,'2027-11-08',13215.07,NULL,'Pending',0.00),(50,3,'2027-12-08',13215.07,NULL,'Pending',0.00),(51,3,'2028-01-08',13215.07,NULL,'Pending',0.00),(52,3,'2028-02-08',13215.07,NULL,'Pending',0.00),(53,3,'2028-03-08',13215.07,NULL,'Pending',0.00),(54,3,'2028-04-08',13215.07,NULL,'Pending',0.00),(55,3,'2028-05-08',13215.07,NULL,'Pending',0.00),(56,3,'2028-06-08',13215.07,NULL,'Pending',0.00),(57,3,'2028-07-08',13215.07,NULL,'Pending',0.00),(58,3,'2028-08-08',13215.07,NULL,'Pending',0.00),(59,3,'2028-09-08',13215.07,NULL,'Pending',0.00),(60,3,'2028-10-08',13215.07,NULL,'Pending',0.00),(61,3,'2028-11-08',13215.07,NULL,'Pending',0.00),(62,3,'2028-12-08',13215.07,NULL,'Pending',0.00),(63,3,'2029-01-08',13215.07,NULL,'Pending',0.00),(64,3,'2029-02-08',13215.07,NULL,'Pending',0.00),(65,3,'2029-03-08',13215.07,NULL,'Pending',0.00),(66,3,'2029-04-08',13215.07,NULL,'Pending',0.00),(67,3,'2029-05-08',13215.07,NULL,'Pending',0.00),(68,3,'2029-06-08',13215.07,NULL,'Pending',0.00),(69,3,'2029-07-08',13215.07,NULL,'Pending',0.00),(70,3,'2029-08-08',13215.07,NULL,'Pending',0.00),(71,3,'2029-09-08',13215.07,NULL,'Pending',0.00),(72,3,'2029-10-08',13215.07,NULL,'Pending',0.00),(73,3,'2029-11-08',13215.07,NULL,'Pending',0.00),(74,3,'2029-12-08',13215.07,NULL,'Pending',0.00),(75,3,'2030-01-08',13215.07,NULL,'Pending',0.00),(76,3,'2030-02-08',13215.07,NULL,'Pending',0.00),(77,3,'2030-03-08',13215.07,NULL,'Pending',0.00),(78,3,'2030-04-08',13215.07,NULL,'Pending',0.00),(79,3,'2030-05-08',13215.07,NULL,'Pending',0.00),(80,3,'2030-06-08',13215.07,NULL,'Pending',0.00),(81,3,'2030-07-08',13215.07,NULL,'Pending',0.00),(82,3,'2030-08-08',13215.07,NULL,'Pending',0.00),(83,3,'2030-09-08',13215.07,NULL,'Pending',0.00),(84,3,'2030-10-08',13215.07,NULL,'Pending',0.00),(85,3,'2030-11-08',13215.07,NULL,'Pending',0.00),(86,3,'2030-12-08',13215.07,NULL,'Pending',0.00),(87,3,'2031-01-08',13215.07,NULL,'Pending',0.00),(88,3,'2031-02-08',13215.07,NULL,'Pending',0.00),(89,3,'2031-03-08',13215.07,NULL,'Pending',0.00),(90,3,'2031-04-08',13215.07,NULL,'Pending',0.00),(91,3,'2031-05-08',13215.07,NULL,'Pending',0.00),(92,3,'2031-06-08',13215.07,NULL,'Pending',0.00),(93,3,'2031-07-08',13215.07,NULL,'Pending',0.00),(94,3,'2031-08-08',13215.07,NULL,'Pending',0.00),(95,3,'2031-09-08',13215.07,NULL,'Pending',0.00),(96,3,'2031-10-08',13215.07,NULL,'Pending',0.00),(97,3,'2031-11-08',13215.07,NULL,'Pending',0.00),(98,3,'2031-12-08',13215.07,NULL,'Pending',0.00),(99,3,'2032-01-08',13215.07,NULL,'Pending',0.00),(100,3,'2032-02-08',13215.07,NULL,'Pending',0.00),(101,3,'2032-03-08',13215.07,NULL,'Pending',0.00),(102,3,'2032-04-08',13215.07,NULL,'Pending',0.00),(103,3,'2032-05-08',13215.07,NULL,'Pending',0.00),(104,3,'2032-06-08',13215.07,NULL,'Pending',0.00),(105,3,'2032-07-08',13215.07,NULL,'Pending',0.00),(106,3,'2032-08-08',13215.07,NULL,'Pending',0.00),(107,3,'2032-09-08',13215.07,NULL,'Pending',0.00),(108,3,'2032-10-08',13215.07,NULL,'Pending',0.00),(109,3,'2032-11-08',13215.07,NULL,'Pending',0.00),(110,3,'2032-12-08',13215.07,NULL,'Pending',0.00),(111,3,'2033-01-08',13215.07,NULL,'Pending',0.00),(112,3,'2033-02-08',13215.07,NULL,'Pending',0.00),(113,3,'2033-03-08',13215.07,NULL,'Pending',0.00),(114,3,'2033-04-08',13215.07,NULL,'Pending',0.00),(115,3,'2033-05-08',13215.07,NULL,'Pending',0.00),(116,3,'2033-06-08',13215.07,NULL,'Pending',0.00),(117,3,'2033-07-08',13215.07,NULL,'Pending',0.00),(118,3,'2033-08-08',13215.07,NULL,'Pending',0.00),(119,3,'2033-09-08',13215.07,NULL,'Pending',0.00),(120,3,'2033-10-08',13215.07,NULL,'Pending',0.00),(121,3,'2033-11-08',13215.07,NULL,'Pending',0.00),(122,3,'2033-12-08',13215.07,NULL,'Pending',0.00),(123,3,'2034-01-08',13215.07,NULL,'Pending',0.00),(124,3,'2034-02-08',13215.07,NULL,'Pending',0.00),(125,3,'2034-03-08',13215.07,NULL,'Pending',0.00),(126,3,'2034-04-08',13215.07,NULL,'Pending',0.00),(127,3,'2034-05-08',13215.07,NULL,'Pending',0.00),(128,3,'2034-06-08',13215.07,NULL,'Pending',0.00),(129,3,'2034-07-08',13215.07,NULL,'Pending',0.00),(130,3,'2034-08-08',13215.07,NULL,'Pending',0.00),(131,3,'2034-09-08',13215.07,NULL,'Pending',0.00),(132,3,'2034-10-08',13215.07,NULL,'Pending',0.00),(133,3,'2034-11-08',13215.07,NULL,'Pending',0.00),(134,3,'2034-12-08',13215.07,NULL,'Pending',0.00),(135,3,'2035-01-08',13215.07,NULL,'Pending',0.00),(136,3,'2035-02-08',13215.07,NULL,'Pending',0.00),(137,3,'2035-03-08',13215.07,NULL,'Pending',0.00),(138,3,'2035-04-08',13215.07,NULL,'Pending',0.00),(139,3,'2035-05-08',13215.07,NULL,'Pending',0.00),(140,3,'2035-06-08',13215.07,NULL,'Pending',0.00),(141,3,'2035-07-08',13215.07,NULL,'Pending',0.00),(142,3,'2035-08-08',13215.07,NULL,'Pending',0.00),(143,3,'2035-09-08',13215.07,NULL,'Pending',0.00),(144,3,'2035-10-08',13215.07,NULL,'Pending',0.00),(145,3,'2035-11-08',13215.07,NULL,'Pending',0.00),(146,3,'2035-12-08',13215.07,NULL,'Pending',0.00),(147,3,'2036-01-08',13215.07,NULL,'Pending',0.00),(148,3,'2036-02-08',13215.07,NULL,'Pending',0.00),(149,3,'2036-03-08',13215.07,NULL,'Pending',0.00),(150,3,'2036-04-08',13215.07,NULL,'Pending',0.00),(151,3,'2036-05-08',13215.07,NULL,'Pending',0.00),(152,3,'2036-06-08',13215.07,NULL,'Pending',0.00),(153,3,'2036-07-08',13215.07,NULL,'Pending',0.00),(154,3,'2036-08-08',13215.07,NULL,'Pending',0.00),(155,3,'2036-09-08',13215.07,NULL,'Pending',0.00),(156,3,'2026-10-08',13215.07,'2026-10-08','Paid',0.00),(157,5,'2026-11-09',18155.56,NULL,'Pending',0.00),(158,5,'2026-12-09',18155.56,NULL,'Pending',0.00),(159,5,'2027-01-09',18155.56,NULL,'Pending',0.00),(160,5,'2027-02-09',18155.56,NULL,'Pending',0.00),(161,5,'2027-03-09',18155.56,NULL,'Pending',0.00),(162,5,'2027-04-09',18155.56,NULL,'Pending',0.00),(163,5,'2027-05-09',18155.56,NULL,'Pending',0.00),(164,5,'2027-06-09',18155.56,NULL,'Pending',0.00),(165,5,'2027-07-09',18155.56,NULL,'Pending',0.00),(166,5,'2027-08-09',18155.56,NULL,'Pending',0.00),(167,5,'2027-09-09',18155.56,NULL,'Pending',0.00),(168,5,'2027-10-09',18155.56,NULL,'Pending',0.00),(169,5,'2027-11-09',18155.56,NULL,'Pending',0.00),(170,5,'2027-12-09',18155.56,NULL,'Pending',0.00),(171,5,'2028-01-09',18155.56,NULL,'Pending',0.00),(172,5,'2028-02-09',18155.56,NULL,'Pending',0.00),(173,5,'2028-03-09',18155.56,NULL,'Pending',0.00),(174,5,'2028-04-09',18155.56,NULL,'Pending',0.00),(175,6,'2026-11-09',160890.78,NULL,'Pending',0.00),(176,6,'2026-12-09',160890.78,NULL,'Pending',0.00),(177,6,'2027-01-09',160890.78,NULL,'Pending',0.00),(178,6,'2027-02-09',160890.78,NULL,'Pending',0.00),(179,6,'2027-03-09',160890.78,NULL,'Pending',0.00),(180,6,'2027-04-09',160890.78,NULL,'Pending',0.00),(181,6,'2027-05-09',160890.78,NULL,'Pending',0.00),(182,6,'2027-06-09',160890.78,NULL,'Pending',0.00),(183,6,'2027-07-09',160890.78,NULL,'Pending',0.00),(184,6,'2027-08-09',160890.78,NULL,'Pending',0.00),(185,6,'2027-09-09',160890.78,NULL,'Pending',0.00),(186,6,'2027-10-09',160890.78,NULL,'Pending',0.00),(187,6,'2027-11-09',160890.78,NULL,'Pending',0.00),(188,6,'2027-12-09',160890.78,NULL,'Pending',0.00),(189,6,'2028-01-09',160890.78,NULL,'Pending',0.00),(190,6,'2028-02-09',160890.78,NULL,'Pending',0.00),(191,6,'2028-03-09',160890.78,NULL,'Pending',0.00),(192,6,'2028-04-09',160890.78,NULL,'Pending',0.00),(193,6,'2028-05-09',160890.78,NULL,'Pending',0.00),(194,6,'2028-06-09',160890.78,NULL,'Pending',0.00),(195,6,'2028-07-09',160890.78,NULL,'Pending',0.00),(196,6,'2028-08-09',160890.78,NULL,'Pending',0.00),(197,6,'2028-09-09',160890.78,NULL,'Pending',0.00),(198,6,'2028-10-09',160890.78,NULL,'Pending',0.00),(199,6,'2028-11-09',160890.78,NULL,'Pending',0.00),(200,6,'2028-12-09',160890.78,NULL,'Pending',0.00),(201,6,'2029-01-09',160890.78,NULL,'Pending',0.00),(202,6,'2029-02-09',160890.78,NULL,'Pending',0.00),(203,6,'2029-03-09',160890.78,NULL,'Pending',0.00),(204,6,'2029-04-09',160890.78,NULL,'Pending',0.00),(205,6,'2029-05-09',160890.78,NULL,'Pending',0.00),(206,6,'2029-06-09',160890.78,NULL,'Pending',0.00),(207,6,'2029-07-09',160890.78,NULL,'Pending',0.00),(208,6,'2029-08-09',160890.78,NULL,'Pending',0.00),(209,6,'2029-09-09',160890.78,NULL,'Pending',0.00),(210,6,'2029-10-09',160890.78,NULL,'Pending',0.00),(211,6,'2029-11-09',160890.78,NULL,'Pending',0.00),(212,6,'2029-12-09',160890.78,NULL,'Pending',0.00),(213,6,'2030-01-09',160890.78,NULL,'Pending',0.00),(214,6,'2030-02-09',160890.78,NULL,'Pending',0.00),(215,6,'2030-03-09',160890.78,NULL,'Pending',0.00),(216,6,'2030-04-09',160890.78,NULL,'Pending',0.00),(217,6,'2030-05-09',160890.78,NULL,'Pending',0.00),(218,6,'2030-06-09',160890.78,NULL,'Pending',0.00),(219,6,'2030-07-09',160890.78,NULL,'Pending',0.00),(220,6,'2030-08-09',160890.78,NULL,'Pending',0.00),(221,6,'2030-09-09',160890.78,NULL,'Pending',0.00),(222,6,'2030-10-09',160890.78,NULL,'Pending',0.00),(223,6,'2030-11-09',160890.78,NULL,'Pending',0.00),(224,6,'2030-12-09',160890.78,NULL,'Pending',0.00),(225,6,'2031-01-09',160890.78,NULL,'Pending',0.00),(226,6,'2031-02-09',160890.78,NULL,'Pending',0.00),(227,6,'2031-03-09',160890.78,NULL,'Pending',0.00),(228,6,'2031-04-09',160890.78,NULL,'Pending',0.00),(229,6,'2031-05-09',160890.78,NULL,'Pending',0.00),(230,6,'2031-06-09',160890.78,NULL,'Pending',0.00),(231,6,'2031-07-09',160890.78,NULL,'Pending',0.00),(232,6,'2031-08-09',160890.78,NULL,'Pending',0.00),(233,6,'2031-09-09',160890.78,NULL,'Pending',0.00),(234,6,'2031-10-09',160890.78,NULL,'Pending',0.00),(235,6,'2031-11-09',160890.78,NULL,'Pending',0.00),(236,6,'2031-12-09',160890.78,NULL,'Pending',0.00),(237,6,'2032-01-09',160890.78,NULL,'Pending',0.00),(238,6,'2032-02-09',160890.78,NULL,'Pending',0.00),(239,6,'2032-03-09',160890.78,NULL,'Pending',0.00),(240,6,'2032-04-09',160890.78,NULL,'Pending',0.00),(241,6,'2032-05-09',160890.78,NULL,'Pending',0.00),(242,6,'2032-06-09',160890.78,NULL,'Pending',0.00),(243,6,'2032-07-09',160890.78,NULL,'Pending',0.00),(244,6,'2032-08-09',160890.78,NULL,'Pending',0.00),(245,6,'2032-09-09',160890.78,NULL,'Pending',0.00),(246,6,'2032-10-09',160890.78,NULL,'Pending',0.00),(247,6,'2032-11-09',160890.78,NULL,'Pending',0.00),(248,6,'2032-12-09',160890.78,NULL,'Pending',0.00),(249,6,'2033-01-09',160890.78,NULL,'Pending',0.00),(250,6,'2033-02-09',160890.78,NULL,'Pending',0.00),(251,6,'2033-03-09',160890.78,NULL,'Pending',0.00),(252,6,'2033-04-09',160890.78,NULL,'Pending',0.00),(253,6,'2033-05-09',160890.78,NULL,'Pending',0.00),(254,6,'2033-06-09',160890.78,NULL,'Pending',0.00),(255,6,'2033-07-09',160890.78,NULL,'Pending',0.00),(256,6,'2033-08-09',160890.78,NULL,'Pending',0.00),(257,6,'2033-09-09',160890.78,NULL,'Pending',0.00),(258,6,'2033-10-09',160890.78,NULL,'Pending',0.00);
/*!40000 ALTER TABLE `emi_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fund_transfer`
--

DROP TABLE IF EXISTS `fund_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fund_transfer` (
  `transfer_id` int NOT NULL AUTO_INCREMENT,
  `sender_account_id` int DEFAULT NULL,
  `receiver_account_id` int DEFAULT NULL,
  `beneficiary_id` int DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `transfer_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`transfer_id`),
  KEY `sender_account_id` (`sender_account_id`),
  KEY `beneficiary_id` (`beneficiary_id`),
  CONSTRAINT `fund_transfer_ibfk_1` FOREIGN KEY (`sender_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fund_transfer_ibfk_2` FOREIGN KEY (`beneficiary_id`) REFERENCES `beneficiary` (`beneficiary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fund_transfer`
--

LOCK TABLES `fund_transfer` WRITE;
/*!40000 ALTER TABLE `fund_transfer` DISABLE KEYS */;
INSERT INTO `fund_transfer` VALUES (1,7,20,8,1000.00,'2026-10-07 14:37:04','Completed','TRF1791364024628'),(2,7,19,NULL,1000.00,'2026-10-07 14:37:36','Completed','TRF1791364056419'),(3,7,20,8,1000.00,'2026-10-07 16:49:37','Completed','TRF1791371977021'),(4,7,20,8,10.00,'2026-10-08 09:58:02','Completed','TRF1791433682330'),(5,7,20,8,10.00,'2026-10-09 02:09:36','Completed','TRF1791491976213'),(6,7,20,8,895.00,'2026-10-09 16:28:54','Completed','TRF1791543534375'),(7,7,20,8,10.00,'2026-10-14 09:42:52','Completed','TRF1791951172268'),(8,7,20,8,0.01,'2026-10-14 10:14:24','Completed','TRF1791953064786'),(9,7,20,8,0.01,'2026-10-14 10:22:34','Completed','TRF1791953554342'),(10,7,20,8,100.00,'2026-10-14 10:49:45','Completed','TRF1791955185843'),(11,7,20,8,10.00,'2026-10-14 10:50:00','Completed','TRF1791955200863'),(12,7,20,8,10.00,'2026-10-14 10:50:50','Completed','TRF1791955250241'),(13,7,20,8,10.00,'2026-10-14 10:54:59','Completed','TRF1791955499068'),(14,7,20,8,10.00,'2026-10-14 11:05:09','Completed','TRF1791956109755'),(15,7,20,8,10.00,'2026-10-14 11:18:54','Completed','TRF1791956934448'),(16,7,20,8,10.00,'2026-10-14 11:23:36','Completed','TRF1791957216003'),(17,7,20,8,1.00,'2026-10-14 11:40:53','Completed','TRF1791958253525'),(18,7,20,8,10.00,'2026-10-14 11:47:41','Completed','TRF1791958661620'),(19,7,20,8,10.00,'2026-10-14 11:55:20','Completed','TRF1791959120218'),(20,7,20,8,50.00,'2026-10-14 14:13:18','Completed','TRF1791967398700'),(21,7,20,8,0.03,'2026-10-14 20:30:00','Completed','TRF1791990000563'),(22,7,20,8,10.00,'2026-10-14 20:56:36','Completed','TRF1791991596017'),(23,7,15,NULL,10.00,'2026-10-14 21:30:56','Completed','TRF1791993656623'),(24,7,8,NULL,10.00,'2026-10-14 21:44:58','Completed','TRF1791994498845'),(25,7,8,9,0.10,'2026-10-17 20:52:23','Completed','TRF1792250543033'),(26,7,8,9,4.00,'2026-10-18 01:20:53','Completed','TRF1792266654597'),(27,261,263,NULL,25000.00,'2026-10-23 17:54:21','Completed','TRF1792758261351'),(28,261,263,NULL,25000.00,'2026-10-23 19:04:59','Completed','TRF1792762499742'),(29,261,263,NULL,25000.00,'2026-10-23 19:05:28','Completed','TRF1792762528022'),(30,261,263,NULL,2500.00,'2026-10-23 19:12:28','Completed','TRF1792762948911'),(31,261,263,NULL,2500.00,'2026-10-23 19:14:59','Completed','TRF1792763099665'),(32,261,263,NULL,2500.00,'2026-10-23 19:25:15','Completed','TRF1792763715942');
/*!40000 ALTER TABLE `fund_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `loan_type` varchar(50) DEFAULT NULL,
  `principal_amount` decimal(15,2) DEFAULT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `tenure_months` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan`
--

LOCK TABLES `loan` WRITE;
/*!40000 ALTER TABLE `loan` DISABLE KEYS */;
INSERT INTO `loan` VALUES (1,6,'Gold Loan',1000000.00,9.50,24,'Rejected'),(2,6,'Personal Loan',400000.00,10.50,36,'Approved'),(3,6,'Wedding Loan',1000000.00,10.00,120,'Approved'),(4,6,'Travel Loan',10000000.00,10.50,360,'Rejected'),(5,6,'Business Loan',300000.00,11.00,18,'Approved'),(6,6,'Vehicle Loan',10000000.00,9.00,84,'Approved'),(7,6,'Home Loan',200000.00,8.00,12,'Rejected'),(8,6,'Education Loan',100000.00,7.50,12,'Pending'),(9,6,'Personal Loan',1000000.00,10.50,6,'Pending'),(10,226,'Personal Loan',100000.00,10.50,6,'Pending');
/*!40000 ALTER TABLE `loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loan_type`
--

DROP TABLE IF EXISTS `loan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_type` (
  `loan_type_id` int NOT NULL AUTO_INCREMENT,
  `loan_type` varchar(50) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  PRIMARY KEY (`loan_type_id`),
  UNIQUE KEY `loan_type` (`loan_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_type`
--

LOCK TABLES `loan_type` WRITE;
/*!40000 ALTER TABLE `loan_type` DISABLE KEYS */;
INSERT INTO `loan_type` VALUES (1,'Personal Loan',10.50),(2,'Home Loan',8.00),(3,'Education Loan',7.50),(4,'Vehicle Loan',9.00),(5,'Business Loan',11.00),(6,'Gold Loan',9.50),(7,'Agricultural Loan',7.00),(8,'Medical Loan',8.50),(9,'Wedding Loan',10.00),(10,'Travel Loan',10.50);
/*!40000 ALTER TABLE `loan_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=838 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,1,'Deposit',25000.50,'2026-09-30 20:24:21','Initial Account Funding'),(2,1,'Deposit',25000.50,'2026-09-30 21:09:32','Initial Account Funding'),(3,1,'Deposit',25000.50,'2026-09-30 21:10:11','Initial Account Funding'),(4,1,'Deposit',25000.50,'2026-10-01 01:38:30','Initial Account Funding'),(5,1,'Deposit',25000.50,'2026-10-01 01:38:38','Initial Account Funding'),(6,7,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(7,8,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(8,9,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(9,10,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(10,11,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(11,12,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(12,13,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(13,14,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(14,15,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(15,16,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(16,17,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(17,18,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(18,19,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(19,20,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(20,21,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(21,22,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(22,23,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(23,24,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(24,25,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(25,26,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(26,27,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(27,28,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(28,29,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(29,30,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(30,31,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(31,32,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(32,33,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(33,34,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(34,35,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(35,36,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(36,37,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(37,38,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(38,39,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(39,40,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(40,41,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(41,42,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(42,43,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(43,44,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(44,45,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(45,46,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(46,47,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(47,48,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(48,49,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(49,50,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(50,51,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(51,52,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(52,53,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(53,54,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(54,55,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(55,56,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(56,57,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(57,58,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(58,59,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(59,60,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(60,61,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(61,62,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(62,63,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(63,64,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(64,65,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(65,66,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(66,67,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(67,68,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(68,69,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(69,70,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(70,71,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(71,72,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(72,73,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(73,74,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(74,75,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(75,76,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(76,77,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(77,78,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(78,79,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(79,80,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(80,81,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(81,82,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(82,83,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(83,84,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(84,85,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(85,86,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(86,87,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(87,88,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(88,89,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(89,90,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(90,91,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(91,92,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(92,93,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(93,94,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(94,95,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(95,96,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(96,97,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(97,98,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(98,99,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(99,100,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(100,101,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(101,102,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(102,103,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(103,104,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(104,105,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(105,106,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(106,107,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(107,108,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(108,109,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(109,110,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(110,111,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(111,112,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(112,113,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(113,114,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(114,115,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(115,116,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(116,117,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(117,118,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(118,119,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(119,120,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(120,121,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(121,122,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(122,123,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(123,124,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(124,125,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(125,126,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(126,127,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(127,128,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(128,129,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(129,130,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(130,131,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(131,132,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(132,133,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(133,134,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(134,135,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(135,136,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(136,137,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(137,138,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(138,139,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(139,140,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(140,141,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(141,142,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(142,143,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(143,144,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(144,145,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(145,146,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(146,147,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(147,148,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(148,149,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(149,150,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(150,151,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(151,152,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(152,153,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(153,154,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(154,155,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(155,156,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(156,157,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(157,158,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(158,159,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(159,160,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(160,161,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(161,162,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(162,163,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(163,164,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(164,165,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(165,166,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(166,167,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(167,168,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(168,169,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(169,170,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(170,171,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(171,172,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(172,173,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(173,174,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(174,175,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(175,176,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(176,177,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(177,178,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(178,179,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(179,180,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(180,181,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(181,182,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(182,183,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(183,184,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(184,185,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(185,186,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(186,187,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(187,188,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(188,189,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(189,190,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(190,191,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(191,192,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(192,193,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(193,194,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(194,195,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(195,196,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(196,197,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(197,198,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(198,199,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(199,200,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(200,201,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(201,202,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(202,203,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(203,204,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(204,205,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(205,206,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(206,207,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(207,208,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(208,209,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(209,210,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(210,211,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(211,212,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(212,213,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(213,214,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(214,215,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(215,216,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(216,217,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(217,218,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(218,219,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(219,220,'Deposit',10000.00,'2026-09-01 02:45:51','Initial account deposit'),(220,221,'Deposit',15000.00,'2026-09-01 02:45:51','Initial account deposit'),(221,222,'Deposit',20000.00,'2026-09-01 02:45:51','Initial account deposit'),(222,223,'Deposit',25000.00,'2026-09-01 02:45:51','Initial account deposit'),(223,224,'Deposit',30000.00,'2026-09-01 02:45:51','Initial account deposit'),(261,7,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(262,8,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(263,9,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(264,10,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(265,11,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(266,12,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(267,13,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(268,14,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(269,15,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(270,16,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(271,17,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(272,18,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(273,19,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(274,20,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(275,21,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(276,22,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(277,23,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(278,24,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(279,25,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(280,26,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(281,27,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(282,28,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(283,29,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(284,30,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(285,31,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(286,32,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(287,33,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(288,34,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(289,35,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(290,36,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(291,37,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(292,38,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(293,39,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(294,40,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(295,41,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(296,42,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(297,43,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(298,44,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(299,45,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(300,46,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(301,47,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(302,48,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(303,49,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(304,50,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(305,51,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(306,52,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(307,53,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(308,54,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(309,55,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(310,56,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(311,57,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(312,58,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(313,59,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(314,60,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(315,61,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(316,62,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(317,63,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(318,64,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(319,65,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(320,66,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(321,67,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(322,68,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(323,69,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(324,70,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(325,71,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(326,72,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(327,73,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(328,74,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(329,75,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(330,76,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(331,77,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(332,78,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(333,79,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(334,80,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(335,81,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(336,82,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(337,83,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(338,84,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(339,85,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(340,86,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(341,87,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(342,88,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(343,89,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(344,90,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(345,91,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(346,92,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(347,93,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(348,94,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(349,95,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(350,96,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(351,97,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(352,98,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(353,99,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(354,100,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(355,101,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(356,102,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(357,103,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(358,104,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(359,105,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(360,106,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(361,107,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(362,108,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(363,109,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(364,110,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(365,111,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(366,112,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(367,113,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(368,114,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(369,115,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(370,116,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(371,117,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(372,118,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(373,119,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(374,120,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(375,121,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(376,122,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(377,123,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(378,124,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(379,125,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(380,126,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(381,127,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(382,128,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(383,129,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(384,130,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(385,131,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(386,132,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(387,133,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(388,134,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(389,135,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(390,136,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(391,137,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(392,138,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(393,139,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(394,140,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(395,141,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(396,142,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(397,143,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(398,144,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(399,145,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(400,146,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(401,147,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(402,148,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(403,149,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(404,150,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(405,151,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(406,152,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(407,153,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(408,154,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(409,155,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(410,156,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(411,157,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(412,158,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(413,159,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(414,160,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(415,161,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(416,162,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(417,163,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(418,164,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(419,165,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(420,166,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(421,167,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(422,168,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(423,169,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(424,170,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(425,171,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(426,172,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(427,173,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(428,174,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(429,175,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(430,176,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(431,177,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(432,178,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(433,179,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(434,180,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(435,181,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(436,182,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(437,183,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(438,184,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(439,185,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(440,186,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(441,187,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(442,188,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(443,189,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(444,190,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(445,191,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(446,192,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(447,193,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(448,194,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(449,195,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(450,196,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(451,197,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(452,198,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(453,199,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(454,200,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(455,201,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(456,202,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(457,203,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(458,204,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(459,205,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(460,206,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(461,207,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(462,208,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(463,209,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(464,210,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(465,211,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(466,212,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(467,213,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(468,214,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(469,215,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(470,216,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(471,217,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(472,218,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(473,219,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(474,220,'Withdrawal',2000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(475,221,'Withdrawal',3000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(476,222,'Withdrawal',4000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(477,223,'Withdrawal',5000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(478,224,'Withdrawal',6000.00,'2026-09-16 02:45:51','ATM cash withdrawal'),(516,7,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(517,8,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(518,9,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(519,10,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(520,11,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(521,12,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(522,13,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(523,14,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(524,15,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(525,16,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(526,17,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(527,18,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(528,19,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(529,20,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(530,21,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(531,22,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(532,23,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(533,24,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(534,25,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(535,26,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(536,27,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(537,28,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(538,29,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(539,30,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(540,31,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(541,32,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(542,33,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(543,34,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(544,35,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(545,36,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(546,37,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(547,38,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(548,39,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(549,40,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(550,41,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(551,42,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(552,43,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(553,44,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(554,45,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(555,46,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(556,47,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(557,48,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(558,49,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(559,50,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(560,51,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(561,52,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(562,53,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(563,54,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(564,55,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(565,56,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(566,57,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(567,58,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(568,59,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(569,60,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(570,61,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(571,62,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(572,63,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(573,64,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(574,65,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(575,66,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(576,67,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(577,68,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(578,69,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(579,70,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(580,71,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(581,72,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(582,73,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(583,74,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(584,75,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(585,76,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(586,77,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(587,78,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(588,79,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(589,80,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(590,81,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(591,82,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(592,83,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(593,84,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(594,85,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(595,86,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(596,87,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(597,88,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(598,89,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(599,90,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(600,91,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(601,92,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(602,93,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(603,94,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(604,95,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(605,96,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(606,97,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(607,98,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(608,99,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(609,100,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(610,101,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(611,102,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(612,103,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(613,104,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(614,105,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(615,106,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(616,107,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(617,108,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(618,109,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(619,110,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(620,111,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(621,112,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(622,113,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(623,114,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(624,115,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(625,116,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(626,117,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(627,118,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(628,119,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(629,120,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(630,121,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(631,122,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(632,123,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(633,124,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(634,125,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(635,126,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(636,127,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(637,128,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(638,129,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(639,130,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(640,131,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(641,132,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(642,133,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(643,134,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(644,135,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(645,136,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(646,137,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(647,138,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(648,139,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(649,140,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(650,141,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(651,142,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(652,143,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(653,144,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(654,145,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(655,146,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(656,147,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(657,148,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(658,149,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(659,150,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(660,151,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(661,152,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(662,153,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(663,154,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(664,155,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(665,156,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(666,157,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(667,158,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(668,159,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(669,160,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(670,161,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(671,162,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(672,163,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(673,164,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(674,165,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(675,166,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(676,167,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(677,168,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(678,169,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(679,170,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(680,171,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(681,172,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(682,173,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(683,174,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(684,175,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(685,176,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(686,177,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(687,178,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(688,179,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(689,180,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(690,181,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(691,182,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(692,183,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(693,184,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(694,185,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(695,186,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(696,187,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(697,188,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(698,189,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(699,190,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(700,191,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(701,192,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(702,193,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(703,194,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(704,195,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(705,196,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(706,197,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(707,198,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(708,199,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(709,200,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(710,201,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(711,202,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(712,203,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(713,204,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(714,205,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(715,206,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(716,207,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(717,208,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(718,209,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(719,210,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(720,211,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(721,212,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(722,213,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(723,214,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(724,215,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(725,216,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(726,217,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(727,218,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(728,219,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(729,220,'Transfer',500.00,'2026-09-26 02:45:51','Online fund transfer'),(730,221,'Transfer',1000.00,'2026-09-26 02:45:51','Online fund transfer'),(731,222,'Transfer',1500.00,'2026-09-26 02:45:51','Online fund transfer'),(732,223,'Transfer',2000.00,'2026-09-26 02:45:51','Online fund transfer'),(733,224,'Transfer',2500.00,'2026-09-26 02:45:51','Online fund transfer'),(771,7,'Transfer',1000.00,'2026-10-07 14:37:04','Transfer to Riya Das 014'),(772,20,'Deposit',1000.00,'2026-10-07 14:37:04','Transfer received from IBI0000000006'),(773,7,'Transfer',1000.00,'2026-10-07 14:37:36','Transfer to IBI0000000018'),(774,19,'Deposit',1000.00,'2026-10-07 14:37:36','Transfer received from IBI0000000006'),(775,7,'Transfer',1000.00,'2026-10-07 16:49:37','Transfer to Riya Das 014'),(776,20,'Deposit',1000.00,'2026-10-07 16:49:37','Transfer received from IBI0000000006'),(777,7,'Transfer',10.00,'2026-10-08 09:58:02','Transfer to Riya Das 014'),(778,20,'Deposit',10.00,'2026-10-08 09:58:02','Transfer received from IBI0000000006'),(779,7,'EMI',13215.07,'2026-10-08 22:25:00','Automatic EMI Payment'),(780,7,'EMI',13250.98,'2026-10-08 22:46:00','Automatic EMI Payment + Late Fee'),(781,7,'EMI',13465.07,'2026-10-08 23:12:00','Automatic EMI Payment + Late Fee'),(782,7,'Transfer',10.00,'2026-10-09 02:09:36','Transfer to Riya Das 014'),(783,20,'Deposit',10.00,'2026-10-09 02:09:36','Transfer received from IBI0000000006'),(784,7,'Transfer',895.00,'2026-10-09 16:28:54','Transfer to Riya Das 014'),(785,20,'Deposit',895.00,'2026-10-09 16:28:54','Transfer received from IBI0000000006'),(786,7,'Transfer',10.00,'2026-10-14 09:42:52','Transfer to Riya Das 014'),(787,20,'Deposit',10.00,'2026-10-14 09:42:52','Transfer received from IBI0000000006'),(788,7,'Transfer',0.01,'2026-10-14 10:14:24','Transfer to Riya Das 014'),(789,20,'Deposit',0.01,'2026-10-14 10:14:24','Transfer received from IBI0000000006'),(790,7,'Transfer',0.01,'2026-10-14 10:22:34','Transfer to Riya Das 014'),(791,20,'Deposit',0.01,'2026-10-14 10:22:34','Transfer received from IBI0000000006'),(792,7,'Transfer',100.00,'2026-10-14 10:49:45','Transfer to Riya Das 014'),(793,20,'Deposit',100.00,'2026-10-14 10:49:45','Transfer received from IBI0000000006'),(794,7,'Transfer',10.00,'2026-10-14 10:50:00','Transfer to Riya Das 014'),(795,20,'Deposit',10.00,'2026-10-14 10:50:00','Transfer received from IBI0000000006'),(796,7,'Transfer',10.00,'2026-10-14 10:50:50','Transfer to Riya Das 014'),(797,20,'Deposit',10.00,'2026-10-14 10:50:50','Transfer received from IBI0000000006'),(798,7,'Transfer',10.00,'2026-10-14 10:54:59','Transfer to Riya Das 014'),(799,20,'Deposit',10.00,'2026-10-14 10:54:59','Transfer received from IBI0000000006'),(800,7,'Transfer',10.00,'2026-10-14 11:05:09','Transfer to Riya Das 014'),(801,20,'Deposit',10.00,'2026-10-14 11:05:09','Transfer received from IBI0000000006'),(802,7,'Transfer',10.00,'2026-10-14 11:18:54','Transfer to Riya Das 014'),(803,20,'Deposit',10.00,'2026-10-14 11:18:54','Transfer received from IBI0000000006'),(804,7,'Transfer',10.00,'2026-10-14 11:23:36','Transfer to Riya Das 014'),(805,20,'Deposit',10.00,'2026-10-14 11:23:36','Transfer received from IBI0000000006'),(806,7,'Transfer',1.00,'2026-10-14 11:40:53','Transfer to Riya Das 014'),(807,20,'Deposit',1.00,'2026-10-14 11:40:53','Transfer received from IBI0000000006'),(808,7,'Transfer',10.00,'2026-10-14 11:47:41','Transfer to Riya Das 014'),(809,20,'Deposit',10.00,'2026-10-14 11:47:41','Transfer received from IBI0000000006'),(810,7,'Transfer',10.00,'2026-10-14 11:55:20','Transfer to Riya Das 014'),(811,20,'Deposit',10.00,'2026-10-14 11:55:20','Transfer received from IBI0000000006'),(812,7,'Transfer',50.00,'2026-10-14 14:13:18','Transfer to Riya Das 014'),(813,20,'Deposit',50.00,'2026-10-14 14:13:18','Transfer received from IBI0000000006'),(814,7,'Transfer',0.03,'2026-10-14 20:30:00','Transfer to Riya Das 014'),(815,20,'Deposit',0.03,'2026-10-14 20:30:00','Transfer received from IBI0000000006'),(816,7,'Transfer',10.00,'2026-10-14 20:56:36','Transfer to Riya Das 014'),(817,20,'Deposit',10.00,'2026-10-14 20:56:36','Transfer received from IBI0000000006'),(818,7,'Transfer',10.00,'2026-10-14 21:30:56','Transfer to IBI0000000014'),(819,15,'Deposit',10.00,'2026-10-14 21:30:56','Transfer received from IBI0000000006'),(820,7,'Transfer',10.00,'2026-10-14 21:44:58','Transfer to IBI0000000007'),(821,8,'Deposit',10.00,'2026-10-14 21:44:58','Transfer received from IBI0000000006'),(822,7,'Transfer',0.10,'2026-10-17 20:52:23','Transfer to Aditi Kumar 002'),(823,8,'Deposit',0.10,'2026-10-17 20:52:23','Transfer received from IBI0000000006'),(824,7,'Transfer',4.00,'2026-10-18 01:20:53','Transfer to Aditi Kumar 002'),(825,8,'Deposit',4.00,'2026-10-18 01:20:53','Transfer received from IBI0000000006'),(826,261,'Transfer',25000.00,'2026-10-23 17:54:21','Transfer to 719002005065'),(827,263,'Deposit',25000.00,'2026-10-23 17:54:21','Transfer received from 205504194083'),(828,261,'Transfer',25000.00,'2026-10-23 19:04:59','Transfer to 719002005065'),(829,263,'Deposit',25000.00,'2026-10-23 19:04:59','Transfer received from 205504194083'),(830,261,'Transfer',25000.00,'2026-10-23 19:05:28','Transfer to 719002005065'),(831,263,'Deposit',25000.00,'2026-10-23 19:05:28','Transfer received from 205504194083'),(832,261,'Transfer',2500.00,'2026-10-23 19:12:28','Transfer to 719002005065'),(833,263,'Deposit',2500.00,'2026-10-23 19:12:28','Transfer received from 205504194083'),(834,261,'Transfer',2500.00,'2026-10-23 19:14:59','Transfer to 719002005065'),(835,263,'Deposit',2500.00,'2026-10-23 19:14:59','Transfer received from 205504194083'),(836,261,'Transfer',2500.00,'2026-10-23 19:25:15','Transfer to 719002005065'),(837,263,'Deposit',2500.00,'2026-10-23 19:25:15','Transfer received from 205504194083');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_validate_transaction_amount` BEFORE INSERT ON `transaction` FOR EACH ROW BEGIN
    IF NEW.amount IS NULL OR NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transaction amount must be greater than zero';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin','main_admin') NOT NULL DEFAULT 'user',
  `email_verified_at` datetime DEFAULT NULL,
  `token_version` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (22,'System Admin','skjishan0018@gmail.com','0000000000','$2b$12$kRuMCY74uNU/L2irAYYScOn4yVYRu6E.GbfROHs9k6Jpl.pqMrWR2','main_admin','2026-10-21 12:55:26',8,1),(23,'SK JISHAN AHAMED','jishan.user@bank.com','9876543310','$2b$10$epA1Xb3ZJq5C8R3wVq2wIe3d1pP7mE2rM9yH8L2cO7hU3kF4tD9eO','user',NULL,0,1),(24,'Aarav Sharma 001','aarav.sharma001@gmail.com','9874563210','$2b$10$tCcBj4VGo0yuaM2mFoGQh.dGH454Ql3doiGdw.zmWYmKfJq.bZKEG','user',NULL,0,1),(25,'aditi kumar','aditi.kumar002@gmail.com','8954488968','$2b$10$hxCXWZYd.SdCBT0jD.2vceHPA2MKQGW9cRWiroScT7K/XjcTjwbci','user',NULL,0,1),(26,'narendramodi','narendrada29@gmail.com','86559628936','$2b$12$kd2wAR6OedbIt4wfVdQ6EOnVgv2kZ2txT1NhlaO7UdwELqcTYblRa','user','2026-10-21 12:22:49',8,1),(27,'Test Employee','employee.test@ibibank.com','9876543210','$2b$12$REPLACE_WITH_A_REAL_BCRYPT_HASH','admin','2026-10-22 00:46:07',0,1),(28,'Anis Mondal','anismondal377@gmail.com','7898524560','$2b$12$HlPEZOHuBdptYLZnb2UR/OUFevoS97tw/s.QENtrqmACd6Ud1MOI2','admin','2026-10-22 01:41:24',3,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_account_details`
--

DROP TABLE IF EXISTS `vw_account_details`;
/*!50001 DROP VIEW IF EXISTS `vw_account_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_account_details` AS SELECT 
 1 AS `account_id`,
 1 AS `account_number`,
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `customer_email`,
 1 AS `branch_name`,
 1 AS `IFSC`,
 1 AS `branch_city`,
 1 AS `account_type`,
 1 AS `balance`,
 1 AS `account_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_fund_transfer_details`
--

DROP TABLE IF EXISTS `vw_fund_transfer_details`;
/*!50001 DROP VIEW IF EXISTS `vw_fund_transfer_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_fund_transfer_details` AS SELECT 
 1 AS `transfer_id`,
 1 AS `reference_no`,
 1 AS `transfer_date`,
 1 AS `transfer_status`,
 1 AS `amount`,
 1 AS `sender_account_id`,
 1 AS `sender_account_number`,
 1 AS `sender_customer_name`,
 1 AS `receiver_account_id`,
 1 AS `receiver_account_number`,
 1 AS `receiver_customer_name`,
 1 AS `beneficiary_id`,
 1 AS `beneficiary_name`,
 1 AS `beneficiary_account_no`,
 1 AS `beneficiary_bank_name`,
 1 AS `beneficiary_IFSC`,
 1 AS `beneficiary_status`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_loan_emi_summary`
--

DROP TABLE IF EXISTS `vw_loan_emi_summary`;
/*!50001 DROP VIEW IF EXISTS `vw_loan_emi_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_loan_emi_summary` AS SELECT 
 1 AS `loan_id`,
 1 AS `customer_id`,
 1 AS `customer_name`,
 1 AS `loan_type`,
 1 AS `principal_amount`,
 1 AS `interest_rate`,
 1 AS `tenure_months`,
 1 AS `loan_status`,
 1 AS `total_emi_records`,
 1 AS `paid_emi_count`,
 1 AS `unpaid_emi_count`,
 1 AS `total_emi_amount`,
 1 AS `total_late_fees`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_transaction_history`
--

DROP TABLE IF EXISTS `vw_transaction_history`;
/*!50001 DROP VIEW IF EXISTS `vw_transaction_history`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_transaction_history` AS SELECT 
 1 AS `transaction_id`,
 1 AS `account_id`,
 1 AS `account_number`,
 1 AS `customer_name`,
 1 AS `transaction_type`,
 1 AS `amount`,
 1 AS `transaction_date`,
 1 AS `description`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'fintech_banking_db'
--

--
-- Dumping routines for database 'fintech_banking_db'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_calculate_monthly_interest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_calculate_monthly_interest`(
    p_balance DECIMAL(15,2),
    p_annual_interest_rate DECIMAL(5,2)
) RETURNS decimal(15,2)
    NO SQL
    DETERMINISTIC
BEGIN
    IF p_balance IS NULL
       OR p_annual_interest_rate IS NULL
       OR p_balance < 0
       OR p_annual_interest_rate < 0 THEN

        RETURN NULL;

    END IF;

    RETURN ROUND(
        p_balance * p_annual_interest_rate / 100 / 12,
        2
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_account_transaction_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_account_transaction_history`(
    IN p_account_number VARCHAR(20),
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    IF p_start_date IS NULL
       OR p_end_date IS NULL
       OR p_start_date > p_end_date THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Please provide a valid date range';

    ELSE

        SELECT
            a.account_number,
            c.name AS customer_name,
            t.transaction_id,
            t.transaction_type,
            t.amount,
            t.transaction_date,
            t.description
        FROM `transaction` t
        INNER JOIN account a
            ON t.account_id = a.account_id
        LEFT JOIN customer c
            ON a.customer_id = c.customer_id
        WHERE a.account_number = p_account_number
          AND t.transaction_date >= p_start_date
          AND t.transaction_date < DATE_ADD(p_end_date, INTERVAL 1 DAY)
        ORDER BY t.transaction_date DESC;

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_customer_account_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_customer_account_summary`(
    IN p_customer_id INT
)
BEGIN
    IF p_customer_id IS NULL OR p_customer_id <= 0 THEN

        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Please provide a valid customer ID';

    ELSE

        SELECT
            customer_id,
            customer_name,
            customer_email,
            account_id,
            account_number,
            branch_name,
            IFSC,
            branch_city,
            account_type,
            balance,
            account_status
        FROM vw_account_details
        WHERE customer_id = p_customer_id
        ORDER BY account_id;

    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_account_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_account_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_account_details` AS select `a`.`account_id` AS `account_id`,`a`.`account_number` AS `account_number`,`c`.`customer_id` AS `customer_id`,`c`.`name` AS `customer_name`,`c`.`email` AS `customer_email`,`b`.`branch_name` AS `branch_name`,`b`.`IFSC` AS `IFSC`,`b`.`city` AS `branch_city`,`at`.`type_name` AS `account_type`,`a`.`balance` AS `balance`,`a`.`status` AS `account_status` from (((`account` `a` left join `customer` `c` on((`a`.`customer_id` = `c`.`customer_id`))) left join `branch` `b` on((`a`.`branch_id` = `b`.`branch_id`))) left join `account_type` `at` on((`a`.`account_type_id` = `at`.`account_type_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_fund_transfer_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_fund_transfer_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_fund_transfer_details` AS select `f`.`transfer_id` AS `transfer_id`,`f`.`reference_no` AS `reference_no`,`f`.`transfer_date` AS `transfer_date`,`f`.`status` AS `transfer_status`,`f`.`amount` AS `amount`,`f`.`sender_account_id` AS `sender_account_id`,`sender`.`account_number` AS `sender_account_number`,`sender_customer`.`name` AS `sender_customer_name`,`f`.`receiver_account_id` AS `receiver_account_id`,`receiver`.`account_number` AS `receiver_account_number`,`receiver_customer`.`name` AS `receiver_customer_name`,`f`.`beneficiary_id` AS `beneficiary_id`,`b`.`beneficiary_name` AS `beneficiary_name`,`b`.`beneficiary_account_no` AS `beneficiary_account_no`,`b`.`bank_name` AS `beneficiary_bank_name`,`b`.`IFSC` AS `beneficiary_IFSC`,`b`.`status` AS `beneficiary_status` from (((((`fund_transfer` `f` left join `account` `sender` on((`f`.`sender_account_id` = `sender`.`account_id`))) left join `customer` `sender_customer` on((`sender`.`customer_id` = `sender_customer`.`customer_id`))) left join `account` `receiver` on((`f`.`receiver_account_id` = `receiver`.`account_id`))) left join `customer` `receiver_customer` on((`receiver`.`customer_id` = `receiver_customer`.`customer_id`))) left join `beneficiary` `b` on((`f`.`beneficiary_id` = `b`.`beneficiary_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_loan_emi_summary`
--

/*!50001 DROP VIEW IF EXISTS `vw_loan_emi_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_loan_emi_summary` AS select `l`.`loan_id` AS `loan_id`,`l`.`customer_id` AS `customer_id`,`c`.`name` AS `customer_name`,`l`.`loan_type` AS `loan_type`,`l`.`principal_amount` AS `principal_amount`,`l`.`interest_rate` AS `interest_rate`,`l`.`tenure_months` AS `tenure_months`,`l`.`status` AS `loan_status`,count(`e`.`emi_id`) AS `total_emi_records`,sum((case when (`e`.`status` = 'Paid') then 1 else 0 end)) AS `paid_emi_count`,sum((case when ((`e`.`status` <> 'Paid') or (`e`.`status` is null)) then 1 else 0 end)) AS `unpaid_emi_count`,coalesce(sum(`e`.`amount`),0) AS `total_emi_amount`,coalesce(sum(`e`.`late_fee`),0) AS `total_late_fees` from ((`loan` `l` left join `customer` `c` on((`l`.`customer_id` = `c`.`customer_id`))) left join `emi_payment` `e` on((`l`.`loan_id` = `e`.`loan_id`))) group by `l`.`loan_id`,`l`.`customer_id`,`c`.`name`,`l`.`loan_type`,`l`.`principal_amount`,`l`.`interest_rate`,`l`.`tenure_months`,`l`.`status` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_transaction_history`
--

/*!50001 DROP VIEW IF EXISTS `vw_transaction_history`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_transaction_history` AS select `t`.`transaction_id` AS `transaction_id`,`t`.`account_id` AS `account_id`,`a`.`account_number` AS `account_number`,`c`.`name` AS `customer_name`,`t`.`transaction_type` AS `transaction_type`,`t`.`amount` AS `amount`,`t`.`transaction_date` AS `transaction_date`,`t`.`description` AS `description` from ((`transaction` `t` left join `account` `a` on((`t`.`account_id` = `a`.`account_id`))) left join `customer` `c` on((`a`.`customer_id` = `c`.`customer_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-23 21:03:54
