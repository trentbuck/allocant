-- MariaDB dump 10.19  Distrib 10.11.4-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: alloc
-- ------------------------------------------------------
-- Server version	10.11.4-MariaDB-1~deb12u1-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `absence`
--

DROP TABLE IF EXISTS `absence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `absence` (
  `absenceID` int(11) NOT NULL AUTO_INCREMENT,
  `dateFrom` date DEFAULT NULL,
  `dateTo` date DEFAULT NULL,
  `absenceType` varchar(255) DEFAULT NULL,
  `contactDetails` text DEFAULT NULL,
  `personID` int(11) NOT NULL,
  PRIMARY KEY (`absenceID`),
  KEY `absence_absenceType` (`absenceType`),
  KEY `absence_personID` (`personID`),
  CONSTRAINT `absence_absenceType` FOREIGN KEY (`absenceType`) REFERENCES `absenceType` (`absenceTypeID`) ON UPDATE CASCADE,
  CONSTRAINT `absence_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_absence BEFORE INSERT ON absence
FOR EACH ROW
BEGIN
  IF emptyXXX(NEW.dateFrom) OR emptyXXX(NEW.dateTo) THEN
    call alloc_error('Absence must have a start and end date.');
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_absence BEFORE UPDATE ON absence
FOR EACH ROW
BEGIN
  IF emptyXXX(NEW.dateFrom) OR emptyXXX(NEW.dateTo) THEN
    call alloc_error('Absence must have a start and end date.');
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `absenceType`
--

DROP TABLE IF EXISTS `absenceType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `absenceType` (
  `absenceTypeID` varchar(255) NOT NULL,
  `absenceTypeSeq` int(11) NOT NULL,
  `absenceTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`absenceTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement` (
  `announcementID` int(11) NOT NULL AUTO_INCREMENT,
  `heading` varchar(255) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `personID` int(11) NOT NULL DEFAULT 0,
  `displayFromDate` date DEFAULT NULL,
  `displayToDate` date DEFAULT NULL,
  PRIMARY KEY (`announcementID`),
  KEY `announcement_personID` (`personID`),
  CONSTRAINT `announcement_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit` (
  `auditID` int(11) NOT NULL AUTO_INCREMENT,
  `taskID` int(11) DEFAULT NULL,
  `projectID` int(11) DEFAULT NULL,
  `personID` int(11) NOT NULL,
  `dateChanged` datetime NOT NULL,
  `field` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`auditID`),
  KEY `audit_personID` (`personID`),
  KEY `audit_taskID` (`taskID`),
  KEY `audit_projectID` (`projectID`),
  CONSTRAINT `audit_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `audit_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `audit_taskID` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`)
) ENGINE=InnoDB AUTO_INCREMENT=276176 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `clientID` int(11) NOT NULL AUTO_INCREMENT,
  `clientName` varchar(255) NOT NULL DEFAULT '',
  `clientStreetAddressOne` varchar(255) DEFAULT NULL,
  `clientStreetAddressTwo` varchar(255) DEFAULT NULL,
  `clientSuburbOne` varchar(255) DEFAULT NULL,
  `clientSuburbTwo` varchar(255) DEFAULT NULL,
  `clientStateOne` varchar(255) DEFAULT NULL,
  `clientStateTwo` varchar(255) DEFAULT NULL,
  `clientPostcodeOne` varchar(255) DEFAULT NULL,
  `clientPostcodeTwo` varchar(255) DEFAULT NULL,
  `clientPhoneOne` varchar(255) DEFAULT NULL,
  `clientFaxOne` varchar(255) DEFAULT NULL,
  `clientCountryOne` varchar(255) DEFAULT NULL,
  `clientCountryTwo` varchar(255) DEFAULT NULL,
  `clientModifiedTime` datetime DEFAULT NULL,
  `clientModifiedUser` int(11) DEFAULT NULL,
  `clientStatus` varchar(255) NOT NULL DEFAULT 'current',
  `clientCategory` int(11) DEFAULT 1,
  `clientCreatedTime` datetime DEFAULT NULL,
  `clientURL` text DEFAULT NULL,
  PRIMARY KEY (`clientID`),
  KEY `clientName` (`clientName`),
  KEY `client_clientStatus` (`clientStatus`),
  KEY `client_clientModifiedUser` (`clientModifiedUser`),
  CONSTRAINT `client_clientModifiedUser` FOREIGN KEY (`clientModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `client_clientStatus` FOREIGN KEY (`clientStatus`) REFERENCES `clientStatus` (`clientStatusID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4405 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientContact`
--

DROP TABLE IF EXISTS `clientContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientContact` (
  `clientContactID` int(11) NOT NULL AUTO_INCREMENT,
  `clientID` int(11) NOT NULL DEFAULT 0,
  `clientContactName` varchar(255) DEFAULT NULL,
  `clientContactStreetAddress` varchar(255) DEFAULT NULL,
  `clientContactSuburb` varchar(255) DEFAULT NULL,
  `clientContactState` varchar(255) DEFAULT NULL,
  `clientContactPostcode` varchar(255) DEFAULT NULL,
  `clientContactPhone` varchar(255) DEFAULT NULL,
  `clientContactMobile` varchar(255) DEFAULT NULL,
  `clientContactFax` varchar(255) DEFAULT NULL,
  `clientContactEmail` varchar(255) DEFAULT NULL,
  `clientContactOther` text DEFAULT NULL,
  `clientContactCountry` varchar(255) DEFAULT NULL,
  `primaryContact` tinyint(1) DEFAULT 0,
  `clientContactActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`clientContactID`),
  KEY `clientID` (`clientID`),
  CONSTRAINT `clientContact_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`)
) ENGINE=InnoDB AUTO_INCREMENT=4361 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientStatus`
--

DROP TABLE IF EXISTS `clientStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientStatus` (
  `clientStatusID` varchar(255) NOT NULL DEFAULT '',
  `clientStatusSeq` int(11) NOT NULL DEFAULT 0,
  `clientStatusActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`clientStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `commentMaster` varchar(255) NOT NULL DEFAULT '',
  `commentMasterID` int(11) NOT NULL DEFAULT 0,
  `commentType` varchar(255) NOT NULL DEFAULT '',
  `commentLinkID` int(11) NOT NULL DEFAULT 0,
  `commentCreatedTime` datetime DEFAULT NULL,
  `commentCreatedUser` int(11) DEFAULT NULL,
  `commentModifiedTime` datetime DEFAULT NULL,
  `commentModifiedUser` int(11) DEFAULT NULL,
  `commentCreatedUserClientContactID` int(11) DEFAULT NULL,
  `commentCreatedUserText` varchar(255) DEFAULT NULL,
  `commentEmailRecipients` text DEFAULT NULL,
  `commentEmailUID` varchar(255) DEFAULT NULL,
  `commentEmailMessageID` text DEFAULT NULL,
  `commentMimeParts` text DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `commentEmailUIDORIG` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `commentLinkID` (`commentLinkID`),
  KEY `commentType` (`commentType`),
  KEY `comment_commentCreatedUser` (`commentCreatedUser`),
  KEY `comment_commentModifiedUser` (`commentModifiedUser`),
  KEY `comment_commentCreatedUserClientContactID` (`commentCreatedUserClientContactID`),
  KEY `commentMaster` (`commentMaster`),
  KEY `commentMasterID` (`commentMasterID`),
  KEY `commentCreatedTime` (`commentCreatedTime`),
  CONSTRAINT `comment_commentCreatedUser` FOREIGN KEY (`commentCreatedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `comment_commentCreatedUserClientContactID` FOREIGN KEY (`commentCreatedUserClientContactID`) REFERENCES `clientContact` (`clientContactID`),
  CONSTRAINT `comment_commentModifiedUser` FOREIGN KEY (`commentModifiedUser`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=177301 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commentTemplate`
--

DROP TABLE IF EXISTS `commentTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commentTemplate` (
  `commentTemplateID` int(11) NOT NULL AUTO_INCREMENT,
  `commentTemplateName` varchar(255) DEFAULT NULL,
  `commentTemplateText` text DEFAULT NULL,
  `commentTemplateType` varchar(255) DEFAULT NULL,
  `commentTemplateModifiedTime` datetime DEFAULT NULL,
  PRIMARY KEY (`commentTemplateID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `configID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'text',
  PRIMARY KEY (`configID`),
  UNIQUE KEY `name` (`name`),
  KEY `config_configType` (`type`),
  CONSTRAINT `config_configType` FOREIGN KEY (`type`) REFERENCES `configType` (`configTypeID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `configType`
--

DROP TABLE IF EXISTS `configType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configType` (
  `configTypeID` varchar(255) NOT NULL DEFAULT '',
  `configTypeSeq` int(11) NOT NULL DEFAULT 0,
  `configTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`configTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currencyType`
--

DROP TABLE IF EXISTS `currencyType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencyType` (
  `currencyTypeID` char(3) NOT NULL DEFAULT '',
  `currencyTypeLabel` varchar(255) DEFAULT NULL,
  `currencyTypeName` varchar(255) DEFAULT NULL,
  `numberToBasic` int(11) DEFAULT 0,
  `currencyTypeSeq` int(11) NOT NULL DEFAULT 0,
  `currencyTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`currencyTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `error`
--

DROP TABLE IF EXISTS `error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `error` (
  `errorID` varchar(255) NOT NULL,
  PRIMARY KEY (`errorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchangeRate`
--

DROP TABLE IF EXISTS `exchangeRate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchangeRate` (
  `exchangeRateID` int(11) NOT NULL AUTO_INCREMENT,
  `exchangeRateCreatedDate` date NOT NULL DEFAULT '0000-00-00',
  `exchangeRateCreatedTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fromCurrency` char(3) NOT NULL DEFAULT '',
  `toCurrency` char(3) NOT NULL DEFAULT '',
  `exchangeRate` decimal(14,5) NOT NULL DEFAULT 0.00000,
  PRIMARY KEY (`exchangeRateID`),
  UNIQUE KEY `date_currency` (`exchangeRateCreatedDate`,`fromCurrency`,`toCurrency`)
) ENGINE=InnoDB AUTO_INCREMENT=1428 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expenseForm`
--

DROP TABLE IF EXISTS `expenseForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenseForm` (
  `expenseFormID` int(11) NOT NULL AUTO_INCREMENT,
  `clientID` int(11) DEFAULT NULL,
  `expenseFormModifiedUser` int(11) DEFAULT NULL,
  `expenseFormModifiedTime` datetime DEFAULT NULL,
  `paymentMethod` varchar(255) DEFAULT NULL,
  `reimbursementRequired` tinyint(1) NOT NULL DEFAULT 0,
  `expenseFormCreatedUser` int(11) DEFAULT NULL,
  `expenseFormCreatedTime` datetime DEFAULT NULL,
  `transactionRepeatID` int(11) DEFAULT NULL,
  `expenseFormFinalised` tinyint(1) NOT NULL DEFAULT 0,
  `seekClientReimbursement` tinyint(1) NOT NULL DEFAULT 0,
  `expenseFormComment` text DEFAULT NULL,
  PRIMARY KEY (`expenseFormID`),
  KEY `expenseForm_clientID` (`clientID`),
  KEY `expenseForm_expenseFormModifiedUser` (`expenseFormModifiedUser`),
  KEY `expenseForm_expenseFormCreatedUser` (`expenseFormCreatedUser`),
  KEY `expenseForm_transactionRepeatID` (`transactionRepeatID`),
  CONSTRAINT `expenseForm_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`),
  CONSTRAINT `expenseForm_expenseFormCreatedUser` FOREIGN KEY (`expenseFormCreatedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `expenseForm_expenseFormModifiedUser` FOREIGN KEY (`expenseFormModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `expenseForm_transactionRepeatID` FOREIGN KEY (`transactionRepeatID`) REFERENCES `transactionRepeat` (`transactionRepeatID`)
) ENGINE=InnoDB AUTO_INCREMENT=1541 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `historyID` int(11) NOT NULL AUTO_INCREMENT,
  `the_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `the_place` varchar(255) NOT NULL DEFAULT '',
  `the_args` varchar(255) DEFAULT NULL,
  `personID` int(11) NOT NULL DEFAULT 0,
  `the_label` varchar(255) DEFAULT '',
  PRIMARY KEY (`historyID`),
  KEY `idx_personID` (`personID`),
  CONSTRAINT `history_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=648717 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indexQueue`
--

DROP TABLE IF EXISTS `indexQueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indexQueue` (
  `indexQueueID` int(11) NOT NULL AUTO_INCREMENT,
  `entity` varchar(255) NOT NULL,
  `entityID` int(11) NOT NULL,
  PRIMARY KEY (`indexQueueID`),
  UNIQUE KEY `entity_entityID` (`entity`,`entityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `interestedParty`
--

DROP TABLE IF EXISTS `interestedParty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interestedParty` (
  `interestedPartyID` int(11) NOT NULL AUTO_INCREMENT,
  `entity` varchar(255) NOT NULL DEFAULT '',
  `entityID` int(11) NOT NULL DEFAULT 0,
  `fullName` text DEFAULT NULL,
  `emailAddress` text NOT NULL,
  `personID` int(11) DEFAULT NULL,
  `clientContactID` int(11) DEFAULT NULL,
  `external` tinyint(1) DEFAULT NULL,
  `interestedPartyCreatedUser` int(11) DEFAULT NULL,
  `interestedPartyCreatedTime` datetime DEFAULT NULL,
  `interestedPartyActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`interestedPartyID`),
  KEY `interestedParty_personID` (`personID`),
  KEY `interestedParty_clientContactID` (`clientContactID`),
  KEY `idx_interestedParty_entityID` (`entityID`),
  CONSTRAINT `interestedParty_clientContactID` FOREIGN KEY (`clientContactID`) REFERENCES `clientContact` (`clientContactID`),
  CONSTRAINT `interestedParty_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=208232 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_interestedParty AFTER INSERT ON interestedParty
FOR EACH ROW
BEGIN
  call audit_interested_parties(NEW.entity,NEW.entityID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_update_interestedParty AFTER UPDATE ON interestedParty
FOR EACH ROW
BEGIN
  call audit_interested_parties(NEW.entity,NEW.entityID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_delete_interestedParty AFTER DELETE ON interestedParty
FOR EACH ROW
BEGIN
  call audit_interested_parties(OLD.entity,OLD.entityID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `invoiceID` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceRepeatID` int(11) DEFAULT NULL,
  `invoiceRepeatDate` date DEFAULT NULL,
  `clientID` int(11) NOT NULL DEFAULT 0,
  `projectID` int(11) DEFAULT NULL,
  `tfID` int(11) NOT NULL,
  `invoiceDateFrom` date DEFAULT NULL,
  `invoiceDateTo` date DEFAULT NULL,
  `invoiceNum` int(11) NOT NULL DEFAULT 0,
  `invoiceName` varchar(255) NOT NULL DEFAULT '',
  `invoiceStatus` varchar(255) NOT NULL DEFAULT 'edit',
  `currencyTypeID` char(3) NOT NULL DEFAULT '',
  `maxAmount` bigint(20) DEFAULT 0,
  `invoiceCreatedTime` datetime DEFAULT NULL,
  `invoiceCreatedUser` int(11) DEFAULT NULL,
  `invoiceModifiedTime` datetime DEFAULT NULL,
  `invoiceModifiedUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoiceID`),
  UNIQUE KEY `invoiceNum` (`invoiceNum`),
  KEY `invoice_invoiceStatus` (`invoiceStatus`),
  KEY `invoice_clientID` (`clientID`),
  KEY `invoice_projectID` (`projectID`),
  KEY `invoice_currencyTypeID` (`currencyTypeID`),
  KEY `invoice_invoiceRepeatID` (`invoiceRepeatID`),
  KEY `invoice_tfID` (`tfID`),
  CONSTRAINT `invoice_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`),
  CONSTRAINT `invoice_currencyTypeID` FOREIGN KEY (`currencyTypeID`) REFERENCES `currencyType` (`currencyTypeID`),
  CONSTRAINT `invoice_invoiceRepeatID` FOREIGN KEY (`invoiceRepeatID`) REFERENCES `invoiceRepeat` (`invoiceRepeatID`),
  CONSTRAINT `invoice_invoiceStatus` FOREIGN KEY (`invoiceStatus`) REFERENCES `invoiceStatus` (`invoiceStatusID`) ON UPDATE CASCADE,
  CONSTRAINT `invoice_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `invoice_tfID` FOREIGN KEY (`tfID`) REFERENCES `tf` (`tfID`)
) ENGINE=InnoDB AUTO_INCREMENT=3802 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoiceEntity`
--

DROP TABLE IF EXISTS `invoiceEntity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoiceEntity` (
  `invoiceEntityID` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceID` int(11) NOT NULL,
  `timeSheetID` int(11) DEFAULT NULL,
  `expenseFormID` int(11) DEFAULT NULL,
  `productSaleID` int(11) DEFAULT NULL,
  `useItems` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`invoiceEntityID`),
  KEY `invoiceEntity_invoiceID` (`invoiceID`),
  KEY `invoiceEntity_timeSheetID` (`timeSheetID`),
  KEY `invoiceEntity_expenseFormID` (`expenseFormID`),
  KEY `invoiceEntity_productSaleID` (`productSaleID`),
  CONSTRAINT `invoiceEntity_expenseFormID` FOREIGN KEY (`expenseFormID`) REFERENCES `expenseForm` (`expenseFormID`),
  CONSTRAINT `invoiceEntity_invoiceID` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`invoiceID`),
  CONSTRAINT `invoiceEntity_productSaleID` FOREIGN KEY (`productSaleID`) REFERENCES `productSale` (`productSaleID`),
  CONSTRAINT `invoiceEntity_timeSheetID` FOREIGN KEY (`timeSheetID`) REFERENCES `timeSheet` (`timeSheetID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoiceItem`
--

DROP TABLE IF EXISTS `invoiceItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoiceItem` (
  `invoiceItemID` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceID` int(11) NOT NULL DEFAULT 0,
  `timeSheetID` int(11) DEFAULT NULL,
  `timeSheetItemID` int(11) DEFAULT NULL,
  `expenseFormID` int(11) DEFAULT NULL,
  `transactionID` int(11) DEFAULT NULL,
  `productSaleID` int(11) DEFAULT NULL,
  `productSaleItemID` int(11) DEFAULT NULL,
  `iiMemo` text DEFAULT NULL,
  `iiQuantity` decimal(19,2) DEFAULT NULL,
  `iiUnitPrice` bigint(20) DEFAULT NULL,
  `iiAmount` bigint(20) DEFAULT NULL,
  `iiTax` decimal(9,2) DEFAULT 0.00,
  `iiDate` date DEFAULT NULL,
  PRIMARY KEY (`invoiceItemID`),
  KEY `idx_invoiceID` (`invoiceID`),
  KEY `invoiceItem_timeSheetID` (`timeSheetID`),
  KEY `invoiceItem_timeSheetItemID` (`timeSheetItemID`),
  KEY `invoiceItem_expenseFormID` (`expenseFormID`),
  KEY `invoiceItem_transactionID` (`transactionID`),
  KEY `invoiceItem_productSaleID` (`productSaleID`),
  KEY `invoiceItem_productSaleItemID` (`productSaleItemID`),
  CONSTRAINT `invoiceItem_expenseFormID` FOREIGN KEY (`expenseFormID`) REFERENCES `expenseForm` (`expenseFormID`),
  CONSTRAINT `invoiceItem_invoiceID` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`invoiceID`),
  CONSTRAINT `invoiceItem_productSaleID` FOREIGN KEY (`productSaleID`) REFERENCES `productSale` (`productSaleID`),
  CONSTRAINT `invoiceItem_productSaleItemID` FOREIGN KEY (`productSaleItemID`) REFERENCES `productSaleItem` (`productSaleItemID`),
  CONSTRAINT `invoiceItem_timeSheetID` FOREIGN KEY (`timeSheetID`) REFERENCES `timeSheet` (`timeSheetID`),
  CONSTRAINT `invoiceItem_timeSheetItemID` FOREIGN KEY (`timeSheetItemID`) REFERENCES `timeSheetItem` (`timeSheetItemID`),
  CONSTRAINT `invoiceItem_transactionID` FOREIGN KEY (`transactionID`) REFERENCES `transaction` (`transactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=5376 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoiceRepeat`
--

DROP TABLE IF EXISTS `invoiceRepeat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoiceRepeat` (
  `invoiceRepeatID` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceID` int(11) NOT NULL,
  `personID` int(11) NOT NULL,
  `message` text DEFAULT NULL,
  `active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`invoiceRepeatID`),
  KEY `invoiceRepeat_invoiceID` (`invoiceID`),
  KEY `invoiceRepeat_personID` (`personID`),
  CONSTRAINT `invoiceRepeat_invoiceID` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`invoiceID`),
  CONSTRAINT `invoiceRepeat_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoiceRepeatDate`
--

DROP TABLE IF EXISTS `invoiceRepeatDate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoiceRepeatDate` (
  `invoiceRepeatDateID` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceRepeatID` int(11) NOT NULL,
  `invoiceDate` date NOT NULL,
  PRIMARY KEY (`invoiceRepeatDateID`),
  KEY `invoiceRepeat_invoiceRepeatID` (`invoiceRepeatID`),
  CONSTRAINT `invoiceRepeat_invoiceRepeatID` FOREIGN KEY (`invoiceRepeatID`) REFERENCES `invoiceRepeat` (`invoiceRepeatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoiceStatus`
--

DROP TABLE IF EXISTS `invoiceStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoiceStatus` (
  `invoiceStatusID` varchar(255) NOT NULL DEFAULT '',
  `invoiceStatusSeq` int(11) NOT NULL DEFAULT 0,
  `invoiceStatusActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`invoiceStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `itemID` int(11) NOT NULL AUTO_INCREMENT,
  `itemName` varchar(255) DEFAULT '',
  `itemNotes` text DEFAULT NULL,
  `itemModifiedTime` datetime DEFAULT NULL,
  `itemModifiedUser` int(11) DEFAULT NULL,
  `itemType` varchar(255) NOT NULL DEFAULT 'cd',
  `itemAuthor` varchar(255) DEFAULT '',
  `personID` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemID`),
  KEY `item_itemType` (`itemType`),
  KEY `item_itemModifiedUser` (`itemModifiedUser`),
  KEY `item_personID` (`personID`),
  CONSTRAINT `item_itemModifiedUser` FOREIGN KEY (`itemModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `item_itemType` FOREIGN KEY (`itemType`) REFERENCES `itemType` (`itemTypeID`) ON UPDATE CASCADE,
  CONSTRAINT `item_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=486 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemType`
--

DROP TABLE IF EXISTS `itemType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemType` (
  `itemTypeID` varchar(255) NOT NULL DEFAULT '',
  `itemTypeSeq` int(11) NOT NULL DEFAULT 0,
  `itemTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`itemTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loan`
--

DROP TABLE IF EXISTS `loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loan` (
  `loanID` int(11) NOT NULL AUTO_INCREMENT,
  `itemID` int(11) NOT NULL DEFAULT 0,
  `personID` int(11) NOT NULL DEFAULT 0,
  `loanModifiedUser` int(11) DEFAULT NULL,
  `loanModifiedTime` datetime DEFAULT NULL,
  `dateBorrowed` date NOT NULL DEFAULT '0000-00-00',
  `dateToBeReturned` date DEFAULT NULL,
  `dateReturned` date DEFAULT NULL,
  PRIMARY KEY (`loanID`),
  KEY `loan_itemID` (`itemID`),
  KEY `loan_personID` (`personID`),
  KEY `loan_loanModifiedUser` (`loanModifiedUser`),
  CONSTRAINT `loan_itemID` FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`),
  CONSTRAINT `loan_loanModifiedUser` FOREIGN KEY (`loanModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `loan_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patchLog`
--

DROP TABLE IF EXISTS `patchLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patchLog` (
  `patchLogID` int(11) NOT NULL AUTO_INCREMENT,
  `patchName` varchar(255) NOT NULL DEFAULT '',
  `patchDesc` text DEFAULT NULL,
  `patchDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`patchLogID`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pendingTask`
--

DROP TABLE IF EXISTS `pendingTask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pendingTask` (
  `taskID` int(11) NOT NULL,
  `pendingTaskID` int(11) NOT NULL,
  PRIMARY KEY (`taskID`,`pendingTaskID`),
  KEY `pendingTask_pendingTaskID` (`pendingTaskID`),
  CONSTRAINT `pendingTask_pendingTaskID` FOREIGN KEY (`pendingTaskID`) REFERENCES `task` (`taskID`),
  CONSTRAINT `pendingTask_taskID` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_pendingTask BEFORE INSERT ON pendingTask
FOR EACH ROW
BEGIN
  DECLARE pID INTEGER;
  SELECT projectID INTO pID FROM task WHERE taskID = NEW.taskID;
  call check_edit_task(pID);
  IF (NEW.taskID = NEW.pendingTaskID) THEN
    call alloc_error('Task cannot be pending itself.');
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_pendingTask AFTER INSERT ON pendingTask
FOR EACH ROW
BEGIN
  DECLARE num_rows INTEGER;
  DECLARE t1status varchar(255);
  DECLARE t2status varchar(255);

  
  SELECT taskStatus INTO t1status FROM task WHERE taskID = NEW.taskID;
  SELECT taskStatus INTO t2status FROM task WHERE taskID = NEW.pendingTaskID;
  IF (neq(t1status,"pending_tasks") AND neq(SUBSTRING(t2status,1,6),"closed")) THEN
    call change_task_status(NEW.taskID,"pending_tasks");
  END IF;

  
  IF (t1status = "pending_tasks") THEN
    SELECT count(pendingTask.taskID) INTO num_rows FROM pendingTask
 LEFT JOIN task ON task.taskID = pendingTask.pendingTaskID
     WHERE pendingTask.taskID = NEW.taskID
       AND SUBSTRING(task.taskStatus,1,6) != "closed";
  
    IF (num_rows = 0) THEN
      call change_task_status(NEW.taskID,"open_notstarted");
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_pendingTask BEFORE UPDATE ON pendingTask
FOR EACH ROW
BEGIN
  DECLARE pID INTEGER;
  SELECT projectID INTO pID FROM task WHERE taskID = NEW.taskID;
  call check_edit_task(pID);

  IF (NEW.taskID = NEW.pendingTaskID) THEN
    call alloc_error('Task cannot be pending itself.');
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_pendingTask BEFORE DELETE ON pendingTask
FOR EACH ROW
BEGIN
  DECLARE pID INTEGER;
  SELECT projectID INTO pID FROM task WHERE taskID = OLD.taskID;
  call check_edit_task(pID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_delete_pendingTask AFTER DELETE ON pendingTask
FOR EACH ROW
BEGIN
  DECLARE num_rows INTEGER;
  DECLARE t1status varchar(255);

  SELECT taskStatus INTO t1status FROM task WHERE taskID = OLD.taskID;
  IF (t1status = "pending_tasks") THEN

    
    SELECT count(pendingTask.taskID) INTO num_rows FROM pendingTask
 LEFT JOIN task ON task.taskID = pendingTask.pendingTaskID
     WHERE pendingTask.taskID = OLD.taskID
       AND SUBSTRING(task.taskStatus,1,6) != "closed";
  
    IF (num_rows = 0) THEN
      call change_task_status(OLD.taskID,"open_notstarted");
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `permissionID` int(11) NOT NULL AUTO_INCREMENT,
  `tableName` varchar(255) DEFAULT NULL,
  `entityID` int(11) DEFAULT NULL,
  `roleName` varchar(255) DEFAULT NULL,
  `sortKey` int(11) DEFAULT 100,
  `actions` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`permissionID`),
  KEY `tableName` (`tableName`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `personID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `perms` varchar(255) DEFAULT NULL,
  `emailAddress` varchar(255) DEFAULT NULL,
  `availability` text DEFAULT NULL,
  `areasOfInterest` text DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `managementComments` text DEFAULT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `personModifiedUser` int(11) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `preferred_tfID` int(11) DEFAULT NULL,
  `personActive` tinyint(1) DEFAULT 1,
  `sessData` text DEFAULT NULL,
  `phoneNo1` varchar(255) DEFAULT '',
  `phoneNo2` varchar(255) DEFAULT '',
  `emergencyContact` varchar(255) DEFAULT '',
  `defaultTimeSheetRate` bigint(20) DEFAULT NULL,
  `defaultTimeSheetRateUnitID` int(11) DEFAULT NULL,
  PRIMARY KEY (`personID`),
  UNIQUE KEY `username` (`username`),
  KEY `person_personModifiedUser` (`personModifiedUser`),
  KEY `person_preferred_tfID` (`preferred_tfID`),
  KEY `person_defaultTimeSheetUnit` (`defaultTimeSheetRateUnitID`),
  CONSTRAINT `person_defaultTimeSheetUnit` FOREIGN KEY (`defaultTimeSheetRateUnitID`) REFERENCES `timeUnit` (`timeUnitID`),
  CONSTRAINT `person_personModifiedUser` FOREIGN KEY (`personModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `person_preferred_tfID` FOREIGN KEY (`preferred_tfID`) REFERENCES `tf` (`tfID`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `productID` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(255) NOT NULL DEFAULT '',
  `sellPrice` bigint(20) DEFAULT 0,
  `sellPriceCurrencyTypeID` char(3) NOT NULL DEFAULT '',
  `sellPriceIncTax` tinyint(1) NOT NULL DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `productActive` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=293 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productCost`
--

DROP TABLE IF EXISTS `productCost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productCost` (
  `productCostID` int(11) NOT NULL AUTO_INCREMENT,
  `productID` int(11) NOT NULL DEFAULT 0,
  `tfID` int(11) DEFAULT NULL,
  `amount` bigint(20) NOT NULL DEFAULT 0,
  `currencyTypeID` char(3) NOT NULL DEFAULT '',
  `isPercentage` tinyint(1) NOT NULL DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `tax` tinyint(1) DEFAULT NULL,
  `productCostActive` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`productCostID`),
  KEY `productCost_productID` (`productID`),
  KEY `productCost_currencyTypeID` (`currencyTypeID`),
  CONSTRAINT `productCost_currencyTypeID` FOREIGN KEY (`currencyTypeID`) REFERENCES `currencyType` (`currencyTypeID`),
  CONSTRAINT `productCost_productID` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=719 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productSale`
--

DROP TABLE IF EXISTS `productSale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productSale` (
  `productSaleID` int(11) NOT NULL AUTO_INCREMENT,
  `clientID` int(11) DEFAULT NULL,
  `projectID` int(11) DEFAULT NULL,
  `personID` int(11) DEFAULT NULL,
  `tfID` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT '',
  `productSaleCreatedTime` datetime DEFAULT NULL,
  `productSaleCreatedUser` int(11) DEFAULT NULL,
  `productSaleModifiedTime` datetime DEFAULT NULL,
  `productSaleModifiedUser` int(11) DEFAULT NULL,
  `productSaleDate` date DEFAULT NULL,
  `extRef` varchar(255) DEFAULT NULL,
  `extRefDate` date DEFAULT NULL,
  PRIMARY KEY (`productSaleID`),
  KEY `productSale_status` (`status`),
  KEY `productSale_clientID` (`clientID`),
  KEY `productSale_projectID` (`projectID`),
  KEY `productSale_productSaleCreatedUser` (`productSaleCreatedUser`),
  KEY `productSale_productSaleModifiedUser` (`productSaleModifiedUser`),
  KEY `productSale_personID` (`personID`),
  KEY `productSale_tfID` (`tfID`),
  CONSTRAINT `productSale_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`),
  CONSTRAINT `productSale_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `productSale_productSaleCreatedUser` FOREIGN KEY (`productSaleCreatedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `productSale_productSaleModifiedUser` FOREIGN KEY (`productSaleModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `productSale_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `productSale_status` FOREIGN KEY (`status`) REFERENCES `productSaleStatus` (`productSaleStatusID`) ON UPDATE CASCADE,
  CONSTRAINT `productSale_tfID` FOREIGN KEY (`tfID`) REFERENCES `tf` (`tfID`)
) ENGINE=InnoDB AUTO_INCREMENT=567 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productSaleItem`
--

DROP TABLE IF EXISTS `productSaleItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productSaleItem` (
  `productSaleItemID` int(11) NOT NULL AUTO_INCREMENT,
  `productID` int(11) NOT NULL DEFAULT 0,
  `productSaleID` int(11) NOT NULL DEFAULT 0,
  `sellPrice` bigint(20) DEFAULT 0,
  `sellPriceCurrencyTypeID` char(3) NOT NULL DEFAULT '',
  `sellPriceIncTax` tinyint(1) NOT NULL DEFAULT 0,
  `quantity` decimal(19,2) NOT NULL DEFAULT 1.00,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`productSaleItemID`),
  KEY `productSaleItem_productID` (`productID`),
  KEY `productSaleItem_productSaleID` (`productSaleID`),
  CONSTRAINT `productSaleItem_productID` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`),
  CONSTRAINT `productSaleItem_productSaleID` FOREIGN KEY (`productSaleID`) REFERENCES `productSale` (`productSaleID`)
) ENGINE=InnoDB AUTO_INCREMENT=877 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `productSaleStatus`
--

DROP TABLE IF EXISTS `productSaleStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productSaleStatus` (
  `productSaleStatusID` varchar(255) NOT NULL DEFAULT '',
  `productSaleStatusSeq` int(11) NOT NULL DEFAULT 0,
  `productSaleStatusActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`productSaleStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proficiency`
--

DROP TABLE IF EXISTS `proficiency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proficiency` (
  `proficiencyID` int(11) NOT NULL AUTO_INCREMENT,
  `personID` int(11) NOT NULL DEFAULT 0,
  `skillID` int(11) NOT NULL DEFAULT 0,
  `skillProficiency` varchar(255) NOT NULL DEFAULT 'Novice',
  PRIMARY KEY (`proficiencyID`),
  KEY `proficiency_skillProficiency` (`skillProficiency`),
  KEY `proficiency_personID` (`personID`),
  KEY `proficiency_skillID` (`skillID`),
  CONSTRAINT `proficiency_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `proficiency_skillID` FOREIGN KEY (`skillID`) REFERENCES `skill` (`skillID`),
  CONSTRAINT `proficiency_skillProficiency` FOREIGN KEY (`skillProficiency`) REFERENCES `skillProficiency` (`skillProficiencyID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1820 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `projectID` int(11) NOT NULL AUTO_INCREMENT,
  `projectName` varchar(255) NOT NULL DEFAULT '',
  `projectComments` text DEFAULT NULL,
  `clientID` int(11) DEFAULT NULL,
  `clientContactID` int(11) DEFAULT NULL,
  `projectCreatedTime` datetime DEFAULT NULL,
  `projectCreatedUser` int(11) DEFAULT NULL,
  `projectModifiedTime` datetime DEFAULT NULL,
  `projectModifiedUser` int(11) DEFAULT NULL,
  `projectType` varchar(255) DEFAULT NULL,
  `projectClientName` varchar(255) DEFAULT NULL,
  `projectClientPhone` varchar(255) DEFAULT NULL,
  `projectClientMobile` varchar(255) DEFAULT NULL,
  `projectClientEMail` text DEFAULT NULL,
  `projectClientAddress` text DEFAULT NULL,
  `dateTargetStart` date DEFAULT NULL,
  `dateTargetCompletion` date DEFAULT NULL,
  `dateActualStart` date DEFAULT NULL,
  `dateActualCompletion` date DEFAULT NULL,
  `projectBudget` bigint(20) DEFAULT NULL,
  `currencyTypeID` char(3) NOT NULL DEFAULT '',
  `projectShortName` varchar(255) DEFAULT NULL,
  `projectStatus` varchar(255) NOT NULL DEFAULT 'current',
  `projectPriority` int(11) DEFAULT NULL,
  `cost_centre_tfID` int(11) DEFAULT NULL,
  `customerBilledDollars` bigint(20) DEFAULT NULL,
  `defaultTaskLimit` decimal(7,2) DEFAULT NULL,
  `defaultTimeSheetRate` bigint(20) DEFAULT NULL,
  `defaultTimeSheetRateUnitID` int(11) DEFAULT NULL,
  PRIMARY KEY (`projectID`),
  UNIQUE KEY `projectShortName` (`projectShortName`),
  KEY `projectName` (`projectName`),
  KEY `project_projectType` (`projectType`),
  KEY `project_projectStatus` (`projectStatus`),
  KEY `project_clientContactID` (`clientContactID`),
  KEY `project_projectModifiedUser` (`projectModifiedUser`),
  KEY `idx_clientID` (`clientID`),
  KEY `project_currencyTypeID` (`currencyTypeID`),
  KEY `project_defaultTimeSheetUnit` (`defaultTimeSheetRateUnitID`),
  CONSTRAINT `project_clientContactID` FOREIGN KEY (`clientContactID`) REFERENCES `clientContact` (`clientContactID`),
  CONSTRAINT `project_clientID` FOREIGN KEY (`clientID`) REFERENCES `client` (`clientID`),
  CONSTRAINT `project_currencyTypeID` FOREIGN KEY (`currencyTypeID`) REFERENCES `currencyType` (`currencyTypeID`),
  CONSTRAINT `project_defaultTimeSheetUnit` FOREIGN KEY (`defaultTimeSheetRateUnitID`) REFERENCES `timeUnit` (`timeUnitID`),
  CONSTRAINT `project_projectModifiedUser` FOREIGN KEY (`projectModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `project_projectStatus` FOREIGN KEY (`projectStatus`) REFERENCES `projectStatus` (`projectStatusID`) ON UPDATE CASCADE,
  CONSTRAINT `project_projectType` FOREIGN KEY (`projectType`) REFERENCES `projectType` (`projectTypeID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1030 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_project AFTER INSERT ON project
FOR EACH ROW
BEGIN
  call alloc_log("project", NEW.projectID, "created",                   NULL, "The project was created.");
  call alloc_log("project", NEW.projectID, "projectName",               NULL, NEW.projectName);
  call alloc_log("project", NEW.projectID, "projectShortName",          NULL, NEW.projectShortName);
  call alloc_log("project", NEW.projectID, "projectComments",           NULL, NEW.projectComments);
  call alloc_log("project", NEW.projectID, "clientID",                  NULL, NEW.clientID);
  call alloc_log("project", NEW.projectID, "clientContactID",           NULL, NEW.clientContactID);
  call alloc_log("project", NEW.projectID, "projectType",               NULL, NEW.projectType);
  call alloc_log("project", NEW.projectID, "dateTargetStart",           NULL, NEW.dateTargetStart);
  call alloc_log("project", NEW.projectID, "dateTargetCompletion",      NULL, NEW.dateTargetCompletion);
  call alloc_log("project", NEW.projectID, "dateActualStart",           NULL, NEW.dateActualStart);
  call alloc_log("project", NEW.projectID, "dateActualCompletion",      NULL, NEW.dateActualCompletion);
  call alloc_log("project", NEW.projectID, "projectBudget",             NULL, NEW.projectBudget);
  call alloc_log("project", NEW.projectID, "currencyTypeID",            NULL, NEW.currencyTypeID);
  call alloc_log("project", NEW.projectID, "projectStatus",             NULL, NEW.projectStatus);
  call alloc_log("project", NEW.projectID, "projectPriority",           NULL, NEW.projectPriority);
  call alloc_log("project", NEW.projectID, "cost_centre_tfID",          NULL, NEW.cost_centre_tfID);
  call alloc_log("project", NEW.projectID, "customerBilledDollars",     NULL, NEW.customerBilledDollars);
  call alloc_log("project", NEW.projectID, "defaultTaskLimit",          NULL, NEW.defaultTaskLimit);
  call alloc_log("project", NEW.projectID, "defaultTimeSheetRate",      NULL, NEW.defaultTimeSheetRate);
  call alloc_log("project", NEW.projectID, "defaultTimeSheetRateUnitID",NULL, NEW.defaultTimeSheetRateUnitID);
  call update_search_index("project",NEW.projectID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_update_project AFTER UPDATE ON project
FOR EACH ROW
BEGIN
  call alloc_log("project", OLD.projectID, "projectName",             OLD.projectName,             NEW.projectName);
  call alloc_log("project", OLD.projectID, "projectShortName",        OLD.projectShortName,        NEW.projectShortName);
  call alloc_log("project", OLD.projectID, "projectComments",         OLD.projectComments,         NEW.projectComments);
  call alloc_log("project", OLD.projectID, "clientID",                OLD.clientID,                NEW.clientID);
  call alloc_log("project", OLD.projectID, "clientContactID",         OLD.clientContactID,         NEW.clientContactID);
  call alloc_log("project", OLD.projectID, "projectType",             OLD.projectType,             NEW.projectType);
  call alloc_log("project", OLD.projectID, "dateTargetStart",         OLD.dateTargetStart,         NEW.dateTargetStart);
  call alloc_log("project", OLD.projectID, "dateTargetCompletion",    OLD.dateTargetCompletion,    NEW.dateTargetCompletion);
  call alloc_log("project", OLD.projectID, "dateActualStart",         OLD.dateActualStart,         NEW.dateActualStart);
  call alloc_log("project", OLD.projectID, "dateActualCompletion",    OLD.dateActualCompletion,    NEW.dateActualCompletion);
  call alloc_log("project", OLD.projectID, "projectBudget",           OLD.projectBudget,           NEW.projectBudget);
  call alloc_log("project", OLD.projectID, "currencyTypeID",          OLD.currencyTypeID,          NEW.currencyTypeID);
  call alloc_log("project", OLD.projectID, "projectStatus",           OLD.projectStatus,           NEW.projectStatus);
  call alloc_log("project", OLD.projectID, "projectPriority",         OLD.projectPriority,         NEW.projectPriority);
  call alloc_log("project", OLD.projectID, "cost_centre_tfID",        OLD.cost_centre_tfID,        NEW.cost_centre_tfID);
  call alloc_log("project", OLD.projectID, "customerBilledDollars",   OLD.customerBilledDollars,   NEW.customerBilledDollars);
  call alloc_log("project", OLD.projectID, "defaultTaskLimit",        OLD.defaultTaskLimit,        NEW.defaultTaskLimit);
  call alloc_log("project", OLD.projectID, "defaultTimeSheetRate",    OLD.defaultTimeSheetRate,    NEW.defaultTimeSheetRate);
  call alloc_log("project", OLD.projectID, "defaultTimeSheetRateUnitID",OLD.defaultTimeSheetRateUnitID,NEW.defaultTimeSheetRateUnitID);
  call update_search_index("project",NEW.projectID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `projectCommissionPerson`
--

DROP TABLE IF EXISTS `projectCommissionPerson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectCommissionPerson` (
  `projectCommissionPersonID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL DEFAULT 0,
  `personID` int(11) DEFAULT NULL,
  `commissionPercent` decimal(5,3) DEFAULT 0.000,
  `tfID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`projectCommissionPersonID`),
  KEY `projectCommissionPerson_projectID` (`projectID`),
  KEY `projectCommissionPerson_personID` (`personID`),
  KEY `projectCommissionPerson_tfID` (`tfID`),
  CONSTRAINT `projectCommissionPerson_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `projectCommissionPerson_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `projectCommissionPerson_tfID` FOREIGN KEY (`tfID`) REFERENCES `tf` (`tfID`)
) ENGINE=InnoDB AUTO_INCREMENT=1194 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectPerson`
--

DROP TABLE IF EXISTS `projectPerson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectPerson` (
  `projectPersonID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL DEFAULT 0,
  `personID` int(11) NOT NULL DEFAULT 0,
  `roleID` int(11) NOT NULL DEFAULT 0,
  `emailType` varchar(255) DEFAULT NULL,
  `rate` bigint(20) DEFAULT NULL,
  `rateUnitID` int(11) DEFAULT NULL,
  `projectPersonModifiedUser` int(11) DEFAULT NULL,
  `emailDateRegex` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`projectPersonID`),
  KEY `idx_person_project` (`projectID`,`personID`),
  KEY `projectPerson_personID` (`personID`),
  KEY `projectPerson_roleID` (`roleID`),
  KEY `projectPerson_projectPersonModifiedUser` (`projectPersonModifiedUser`),
  CONSTRAINT `projectPerson_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `projectPerson_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `projectPerson_projectPersonModifiedUser` FOREIGN KEY (`projectPersonModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `projectPerson_roleID` FOREIGN KEY (`roleID`) REFERENCES `role` (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=21517 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectStatus`
--

DROP TABLE IF EXISTS `projectStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectStatus` (
  `projectStatusID` varchar(255) NOT NULL DEFAULT '',
  `projectStatusSeq` int(11) NOT NULL DEFAULT 0,
  `projectStatusActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`projectStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projectType`
--

DROP TABLE IF EXISTS `projectType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectType` (
  `projectTypeID` varchar(255) NOT NULL DEFAULT '',
  `projectTypeSeq` int(11) NOT NULL DEFAULT 0,
  `projectTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`projectTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminder`
--

DROP TABLE IF EXISTS `reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminder` (
  `reminderID` int(11) NOT NULL AUTO_INCREMENT,
  `reminderType` varchar(255) DEFAULT NULL,
  `reminderLinkID` int(11) NOT NULL DEFAULT 0,
  `reminderTime` datetime DEFAULT NULL,
  `reminderHash` varchar(255) DEFAULT NULL,
  `reminderRecuringInterval` varchar(255) NOT NULL DEFAULT 'No',
  `reminderRecuringValue` int(11) NOT NULL DEFAULT 0,
  `reminderAdvNoticeSent` tinyint(1) NOT NULL DEFAULT 0,
  `reminderAdvNoticeInterval` varchar(255) NOT NULL DEFAULT 'No',
  `reminderAdvNoticeValue` int(11) NOT NULL DEFAULT 0,
  `reminderSubject` varchar(255) NOT NULL DEFAULT '',
  `reminderContent` text DEFAULT NULL,
  `reminderCreatedTime` datetime NOT NULL,
  `reminderCreatedUser` int(11) NOT NULL,
  `reminderModifiedTime` datetime DEFAULT NULL,
  `reminderModifiedUser` int(11) DEFAULT NULL,
  `reminderActive` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`reminderID`),
  KEY `reminder_reminderRecuringInterval` (`reminderRecuringInterval`),
  KEY `reminder_reminderAdvNoticeInterval` (`reminderAdvNoticeInterval`),
  KEY `reminder_reminderModifiedUser` (`reminderModifiedUser`),
  KEY `reminder_reminderHash` (`reminderHash`),
  KEY `reminder_reminderCreatedUser` (`reminderCreatedUser`),
  CONSTRAINT `reminder_reminderAdvNoticeInterval` FOREIGN KEY (`reminderAdvNoticeInterval`) REFERENCES `reminderAdvNoticeInterval` (`reminderAdvNoticeIntervalID`) ON UPDATE CASCADE,
  CONSTRAINT `reminder_reminderCreatedUser` FOREIGN KEY (`reminderCreatedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `reminder_reminderHash` FOREIGN KEY (`reminderHash`) REFERENCES `token` (`tokenHash`),
  CONSTRAINT `reminder_reminderModifiedUser` FOREIGN KEY (`reminderModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `reminder_reminderRecuringInterval` FOREIGN KEY (`reminderRecuringInterval`) REFERENCES `reminderRecuringInterval` (`reminderRecuringIntervalID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8382 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_reminder BEFORE DELETE ON reminder
FOR EACH ROW
BEGIN
  IF (has_perm(personID(),4,"reminder")) THEN
    DELETE FROM reminderRecipient WHERE reminderID = OLD.reminderID;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reminderAdvNoticeInterval`
--

DROP TABLE IF EXISTS `reminderAdvNoticeInterval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminderAdvNoticeInterval` (
  `reminderAdvNoticeIntervalID` varchar(255) NOT NULL DEFAULT '',
  `reminderAdvNoticeIntervalSeq` int(11) NOT NULL DEFAULT 0,
  `reminderAdvNoticeIntervalActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`reminderAdvNoticeIntervalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminderRecipient`
--

DROP TABLE IF EXISTS `reminderRecipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminderRecipient` (
  `reminderRecipientID` int(11) NOT NULL AUTO_INCREMENT,
  `reminderID` int(11) NOT NULL,
  `personID` int(11) DEFAULT NULL,
  `metaPersonID` int(11) DEFAULT NULL,
  PRIMARY KEY (`reminderRecipientID`),
  KEY `reminderRecipient_personID` (`personID`),
  KEY `reminderRecipient_reminderID` (`reminderID`),
  CONSTRAINT `reminderRecipient_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `reminderRecipient_reminderID` FOREIGN KEY (`reminderID`) REFERENCES `reminder` (`reminderID`)
) ENGINE=InnoDB AUTO_INCREMENT=6157 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reminderRecuringInterval`
--

DROP TABLE IF EXISTS `reminderRecuringInterval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminderRecuringInterval` (
  `reminderRecuringIntervalID` varchar(255) NOT NULL DEFAULT '',
  `reminderRecuringIntervalSeq` int(11) NOT NULL DEFAULT 0,
  `reminderRecuringIntervalActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`reminderRecuringIntervalID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `roleID` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) DEFAULT NULL,
  `roleHandle` varchar(255) DEFAULT NULL,
  `roleLevel` varchar(255) NOT NULL DEFAULT '',
  `roleSequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`roleID`),
  KEY `role_roleLevel` (`roleLevel`),
  CONSTRAINT `role_roleLevel` FOREIGN KEY (`roleLevel`) REFERENCES `roleLevel` (`roleLevelID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roleLevel`
--

DROP TABLE IF EXISTS `roleLevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roleLevel` (
  `roleLevelID` varchar(255) NOT NULL DEFAULT '',
  `roleLevelSeq` int(11) NOT NULL DEFAULT 0,
  `roleLevelActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`roleLevelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sentEmailLog`
--

DROP TABLE IF EXISTS `sentEmailLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sentEmailLog` (
  `sentEmailLogID` int(11) NOT NULL AUTO_INCREMENT,
  `sentEmailTo` text NOT NULL,
  `sentEmailSubject` varchar(255) DEFAULT NULL,
  `sentEmailBody` text DEFAULT NULL,
  `sentEmailHeader` text DEFAULT NULL,
  `sentEmailType` varchar(255) DEFAULT NULL,
  `sentEmailLogCreatedTime` datetime DEFAULT NULL,
  `sentEmailLogCreatedUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`sentEmailLogID`),
  KEY `sentEmailLog_sentEmailType` (`sentEmailType`),
  KEY `sentEmailLog_sentEmailLogCreatedUser` (`sentEmailLogCreatedUser`),
  CONSTRAINT `sentEmailLog_sentEmailLogCreatedUser` FOREIGN KEY (`sentEmailLogCreatedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `sentEmailLog_sentEmailType` FOREIGN KEY (`sentEmailType`) REFERENCES `sentEmailType` (`sentEmailTypeID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=240157 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sentEmailType`
--

DROP TABLE IF EXISTS `sentEmailType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sentEmailType` (
  `sentEmailTypeID` varchar(255) NOT NULL DEFAULT '',
  `sentEmailTypeSeq` int(11) NOT NULL DEFAULT 0,
  `sentEmailTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`sentEmailTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sess`
--

DROP TABLE IF EXISTS `sess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sess` (
  `sessID` varchar(32) NOT NULL DEFAULT '',
  `personID` int(11) NOT NULL DEFAULT 0,
  `sessData` text DEFAULT NULL,
  PRIMARY KEY (`sessID`),
  KEY `sess_personID` (`personID`),
  CONSTRAINT `sess_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill` (
  `skillID` int(11) NOT NULL AUTO_INCREMENT,
  `skillName` varchar(40) NOT NULL DEFAULT '',
  `skillDescription` text DEFAULT NULL,
  `skillClass` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`skillID`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skillProficiency`
--

DROP TABLE IF EXISTS `skillProficiency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skillProficiency` (
  `skillProficiencyID` varchar(255) NOT NULL DEFAULT '',
  `skillProficiencySeq` int(11) NOT NULL DEFAULT 0,
  `skillProficiencyActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`skillProficiencyID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `taskID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  KEY `tag_taskID` (`taskID`),
  CONSTRAINT `tag_taskID` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskID` int(11) NOT NULL AUTO_INCREMENT,
  `taskName` varchar(255) NOT NULL DEFAULT '',
  `taskDescription` text DEFAULT NULL,
  `creatorID` int(11) NOT NULL DEFAULT 0,
  `closerID` int(11) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT 0,
  `timeLimit` decimal(7,2) DEFAULT NULL,
  `timeBest` decimal(7,2) DEFAULT NULL,
  `timeExpected` decimal(7,2) DEFAULT NULL,
  `timeWorst` decimal(7,2) DEFAULT NULL,
  `dateCreated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dateAssigned` datetime DEFAULT NULL,
  `dateClosed` datetime DEFAULT NULL,
  `dateTargetCompletion` date DEFAULT NULL,
  `projectID` int(11) DEFAULT NULL,
  `dateActualCompletion` date DEFAULT NULL,
  `dateActualStart` date DEFAULT NULL,
  `dateTargetStart` date DEFAULT NULL,
  `personID` int(11) DEFAULT NULL,
  `managerID` int(11) DEFAULT NULL,
  `parentTaskID` int(11) DEFAULT NULL,
  `taskTypeID` varchar(255) NOT NULL DEFAULT '',
  `taskModifiedUser` int(11) DEFAULT NULL,
  `duplicateTaskID` int(11) DEFAULT NULL,
  `estimatorID` int(11) DEFAULT NULL,
  `taskStatus` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`taskID`),
  KEY `taskName` (`taskName`),
  KEY `projectID` (`projectID`),
  KEY `parentTaskID` (`parentTaskID`),
  KEY `taskTypeID` (`taskTypeID`),
  KEY `taskStatus` (`taskStatus`),
  KEY `dateCreated` (`dateCreated`),
  KEY `task_creatorID` (`creatorID`),
  KEY `task_closerID` (`closerID`),
  KEY `task_personID` (`personID`),
  KEY `task_managerID` (`managerID`),
  KEY `task_taskModifiedUser` (`taskModifiedUser`),
  KEY `task_duplicateTaskID` (`duplicateTaskID`),
  KEY `task_estimatorID` (`estimatorID`),
  CONSTRAINT `task_closerID` FOREIGN KEY (`closerID`) REFERENCES `person` (`personID`),
  CONSTRAINT `task_creatorID` FOREIGN KEY (`creatorID`) REFERENCES `person` (`personID`),
  CONSTRAINT `task_duplicateTaskID` FOREIGN KEY (`duplicateTaskID`) REFERENCES `task` (`taskID`),
  CONSTRAINT `task_estimatorID` FOREIGN KEY (`estimatorID`) REFERENCES `person` (`personID`),
  CONSTRAINT `task_managerID` FOREIGN KEY (`managerID`) REFERENCES `person` (`personID`),
  CONSTRAINT `task_parentTaskID` FOREIGN KEY (`parentTaskID`) REFERENCES `task` (`taskID`),
  CONSTRAINT `task_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `task_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `task_taskModifiedUser` FOREIGN KEY (`taskModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `task_taskStatus` FOREIGN KEY (`taskStatus`) REFERENCES `taskStatus` (`taskStatusID`),
  CONSTRAINT `task_taskTypeID` FOREIGN KEY (`taskTypeID`) REFERENCES `taskType` (`taskTypeID`)
) ENGINE=InnoDB AUTO_INCREMENT=35072 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_task BEFORE INSERT ON task
FOR EACH ROW
BEGIN
  DECLARE defTaskLimit DECIMAL(7,2);
  call check_edit_task(NEW.projectID);

  IF (NEW.parentTaskID) THEN CALL check_for_parent_task_loop(NEW.parentTaskID, NULL); END IF;

  SET NEW.creatorID = personID();
  SET NEW.dateCreated = current_timestamp();

  
  IF (substring(NEW.taskStatus,1,6) = 'closed') THEN
    SET NEW.dateActualCompletion = current_date();
  END IF;

  IF (emptyXXX(NEW.taskStatus)) THEN SET NEW.taskStatus = 'open_notstarted'; END IF;
  IF (emptyXXX(NEW.priority)) THEN SET NEW.priority = 3; END IF;
  IF (emptyXXX(NEW.taskTypeID)) THEN SET NEW.taskTypeID = 'Task'; END IF;
  IF (NEW.personID) THEN SET NEW.dateAssigned = current_timestamp(); END IF;
  IF (NEW.closerID) THEN SET NEW.dateClosed = current_timestamp(); END IF;
  IF (emptyXXX(NEW.timeLimit)) THEN SET NEW.timeLimit = NEW.timeExpected; END IF;
  
  IF (emptyXXX(NEW.timeLimit) AND NEW.projectID) THEN
    SELECT defaultTaskLimit INTO defTaskLimit FROM project WHERE projectID = NEW.projectID;
    SET NEW.timeLimit = defTaskLimit;
  END IF;
 
  IF (emptyXXX(NEW.estimatorID) AND (NEW.timeWorst OR NEW.timeBest OR NEW.timeExpected)) THEN
    SET NEW.estimatorID = personID();
  END IF;

  IF (emptyXXX(NEW.timeWorst) AND emptyXXX(NEW.timeBest) AND emptyXXX(NEW.timeExpected)) THEN
    SET NEW.estimatorID = NULL;
  END IF;

  IF (NEW.taskStatus = 'open_inprogress' AND emptyXXX(NEW.dateActualStart)) THEN
    SET NEW.dateActualStart = current_date();
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_task AFTER INSERT ON task
FOR EACH ROW
BEGIN
  call alloc_log("task", NEW.taskID, "created",              NULL, "The task was created.");
  call alloc_log("task", NEW.taskID, "taskName",             NULL, NEW.taskName);
  call alloc_log("task", NEW.taskID, "taskDescription",      NULL, NEW.taskDescription);
  call alloc_log("task", NEW.taskID, "priority",             NULL, NEW.priority);
  call alloc_log("task", NEW.taskID, "timeLimit",            NULL, NEW.timeLimit);
  call alloc_log("task", NEW.taskID, "timeBest",             NULL, NEW.timeBest);
  call alloc_log("task", NEW.taskID, "timeWorst",            NULL, NEW.timeWorst);
  call alloc_log("task", NEW.taskID, "timeExpected",         NULL, NEW.timeExpected);
  call alloc_log("task", NEW.taskID, "dateTargetStart",      NULL, NEW.dateTargetStart);
  call alloc_log("task", NEW.taskID, "dateActualStart",      NULL, NEW.dateActualStart);
  call alloc_log("task", NEW.taskID, "projectID",            NULL, NEW.projectID);
  call alloc_log("task", NEW.taskID, "parentTaskID",         NULL, NEW.parentTaskID);
  call alloc_log("task", NEW.taskID, "taskTypeID",           NULL, NEW.taskTypeID);
  call alloc_log("task", NEW.taskID, "personID",             NULL, NEW.personID);
  call alloc_log("task", NEW.taskID, "managerID",            NULL, NEW.managerID);
  call alloc_log("task", NEW.taskID, "estimatorID",          NULL, NEW.estimatorID);
  call alloc_log("task", NEW.taskID, "duplicateTaskID",      NULL, NEW.duplicateTaskID);
  call alloc_log("task", NEW.taskID, "dateTargetCompletion", NULL, NEW.dateTargetCompletion);
  call alloc_log("task", NEW.taskID, "dateActualCompletion", NULL, NEW.dateActualCompletion);
  call alloc_log("task", NEW.taskID, "taskStatus",           NULL, NEW.taskStatus);
  call update_search_index("task",NEW.taskID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_task BEFORE UPDATE ON task
FOR EACH ROW
BEGIN
  call check_edit_task(OLD.projectID);

  IF (neq(@in_change_task_status,1) AND neq(OLD.taskStatus,NEW.taskStatus)) THEN
    call alloc_error('Must use: call change_task_status(taskID,status)');
  END IF;

  IF (NEW.parentTaskID) THEN CALL check_for_parent_task_loop(NEW.parentTaskID, OLD.taskID); END IF;

  SET NEW.taskID = OLD.taskID;
  SET NEW.creatorID = OLD.creatorID;
  SET NEW.dateCreated = OLD.dateCreated;
  SET NEW.taskModifiedUser = personID();

  IF (emptyXXX(NEW.taskStatus)) THEN
    SET NEW.taskStatus = OLD.taskStatus;
  END IF;

  IF (emptyXXX(NEW.taskStatus)) THEN
    SET NEW.taskStatus = 'open_notstarted';
  END IF;

  IF (NEW.taskStatus = 'open_inprogress' AND neq(NEW.taskStatus, OLD.taskStatus) AND emptyXXX(NEW.dateActualStart)) THEN
    SET NEW.dateActualStart = current_date();
  END IF;

  IF ((SUBSTRING(NEW.taskStatus,1,4) = 'open' OR SUBSTRING(NEW.taskStatus,1,4) = 'pend')) THEN
    SET NEW.closerID = NULL;  
    SET NEW.dateClosed = NULL;  
    SET NEW.dateActualCompletion = NULL;  
    SET NEW.duplicateTaskID = NULL;  
  ELSEIF (SUBSTRING(NEW.taskStatus,1,6) = 'closed' AND neq(NEW.taskStatus, OLD.taskStatus)) THEN
    IF (emptyXXX(NEW.dateActualStart)) THEN SET NEW.dateActualStart = current_date(); END IF;
    IF (emptyXXX(NEW.dateClosed)) THEN SET NEW.dateClosed = current_timestamp(); END IF;
    IF (emptyXXX(NEW.closerID)) THEN SET NEW.closerID = personID(); END IF;
    SET NEW.dateActualCompletion = current_date();
  END IF;

  IF (NEW.personID AND neq(NEW.personID, OLD.personID)) THEN
    SET NEW.dateAssigned = current_timestamp();
  ELSEIF (emptyXXX(NEW.personID)) THEN
    SET NEW.dateAssigned = NULL;
  END IF;

  IF (NEW.closerID AND neq(NEW.closerID, OLD.closerID)) THEN
    SET NEW.dateClosed = current_timestamp();
  ELSEIF (emptyXXX(NEW.closerID)) THEN
    SET NEW.dateClosed = NULL;
  END IF;

  IF ((neq(NEW.timeWorst, OLD.timeWorst) OR neq(NEW.timeBest, OLD.timeBest) OR neq(NEW.timeExpected, OLD.timeExpected))
  AND emptyXXX(NEW.estimatorID)) THEN
    SET NEW.estimatorID = personID();
  END IF;

  IF (emptyXXX(NEW.timeWorst) AND emptyXXX(NEW.timeBest) AND emptyXXX(NEW.timeExpected)) THEN
    SET NEW.estimatorID = NULL;
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_update_task AFTER UPDATE ON task
FOR EACH ROW
BEGIN
  call alloc_log("task", OLD.taskID, "taskName",             OLD.taskName,             NEW.taskName);
  call alloc_log("task", OLD.taskID, "taskDescription",      OLD.taskDescription,      NEW.taskDescription);
  call alloc_log("task", OLD.taskID, "priority",             OLD.priority,             NEW.priority);
  call alloc_log("task", OLD.taskID, "timeLimit",            OLD.timeLimit,            NEW.timeLimit);
  call alloc_log("task", OLD.taskID, "timeBest",             OLD.timeBest,             NEW.timeBest);
  call alloc_log("task", OLD.taskID, "timeWorst",            OLD.timeWorst,            NEW.timeWorst);
  call alloc_log("task", OLD.taskID, "timeExpected",         OLD.timeExpected,         NEW.timeExpected);
  call alloc_log("task", OLD.taskID, "dateTargetStart",      OLD.dateTargetStart,      NEW.dateTargetStart);
  call alloc_log("task", OLD.taskID, "dateActualStart",      OLD.dateActualStart,      NEW.dateActualStart);
  call alloc_log("task", OLD.taskID, "projectID",            OLD.projectID,            NEW.projectID);
  call alloc_log("task", OLD.taskID, "parentTaskID",         OLD.parentTaskID,         NEW.parentTaskID);
  call alloc_log("task", OLD.taskID, "taskTypeID",           OLD.taskTypeID,           NEW.taskTypeID);
  call alloc_log("task", OLD.taskID, "personID",             OLD.personID,             NEW.personID);
  call alloc_log("task", OLD.taskID, "managerID",            OLD.managerID,            NEW.managerID);
  call alloc_log("task", OLD.taskID, "estimatorID",          OLD.estimatorID,          NEW.estimatorID);
  call alloc_log("task", OLD.taskID, "duplicateTaskID",      OLD.duplicateTaskID,      NEW.duplicateTaskID);
  call alloc_log("task", OLD.taskID, "dateTargetCompletion", OLD.dateTargetCompletion, NEW.dateTargetCompletion);
  call alloc_log("task", OLD.taskID, "dateActualCompletion", OLD.dateActualCompletion, NEW.dateActualCompletion);
  call alloc_log("task", OLD.taskID, "taskStatus",           OLD.taskStatus,           NEW.taskStatus);
  call update_search_index("task",NEW.taskID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_task BEFORE DELETE ON task
FOR EACH ROW
BEGIN
  call check_edit_task(OLD.projectID);
  call check_delete_task(OLD.taskID);
  DELETE FROM pendingTask WHERE taskID = OLD.taskID OR pendingTaskID = OLD.taskID;
  DELETE FROM audit WHERE taskID = OLD.taskID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `taskStatus`
--

DROP TABLE IF EXISTS `taskStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taskStatus` (
  `taskStatusID` varchar(255) NOT NULL DEFAULT '',
  `taskStatusLabel` varchar(255) DEFAULT NULL,
  `taskStatusColour` varchar(255) DEFAULT NULL,
  `taskStatusSeq` int(11) NOT NULL DEFAULT 0,
  `taskStatusActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`taskStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taskType`
--

DROP TABLE IF EXISTS `taskType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taskType` (
  `taskTypeID` varchar(255) NOT NULL DEFAULT '',
  `taskTypeSeq` int(11) NOT NULL DEFAULT 0,
  `taskTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`taskTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tf`
--

DROP TABLE IF EXISTS `tf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tf` (
  `tfID` int(11) NOT NULL AUTO_INCREMENT,
  `tfName` varchar(255) NOT NULL DEFAULT '',
  `tfComments` text DEFAULT NULL,
  `tfModifiedTime` datetime DEFAULT NULL,
  `tfModifiedUser` int(11) DEFAULT NULL,
  `qpEmployeeNum` int(11) DEFAULT NULL,
  `quickenAccount` varchar(255) DEFAULT NULL,
  `tfActive` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`tfID`),
  KEY `tf_tfModifiedUser` (`tfModifiedUser`),
  KEY `tf_tfActive` (`tfActive`),
  CONSTRAINT `tf_tfModifiedUser` FOREIGN KEY (`tfModifiedUser`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tfPerson`
--

DROP TABLE IF EXISTS `tfPerson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tfPerson` (
  `tfPersonID` int(11) NOT NULL AUTO_INCREMENT,
  `tfID` int(11) NOT NULL DEFAULT 0,
  `personID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`tfPersonID`),
  KEY `tfPerson_personID` (`personID`),
  KEY `idx_tfPerson_tfID` (`tfID`),
  CONSTRAINT `tfPerson_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `tfPerson_tfID` FOREIGN KEY (`tfID`) REFERENCES `tf` (`tfID`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeSheet`
--

DROP TABLE IF EXISTS `timeSheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeSheet` (
  `timeSheetID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL DEFAULT 0,
  `dateFrom` date DEFAULT NULL,
  `dateTo` date DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `personID` int(11) NOT NULL DEFAULT 0,
  `approvedByManagerPersonID` int(11) DEFAULT NULL,
  `approvedByAdminPersonID` int(11) DEFAULT NULL,
  `dateSubmittedToManager` date DEFAULT NULL,
  `dateSubmittedToAdmin` date DEFAULT NULL,
  `dateRejected` date DEFAULT NULL,
  `invoiceDate` date DEFAULT NULL,
  `billingNote` text DEFAULT NULL,
  `recipient_tfID` int(11) DEFAULT NULL,
  `customerBilledDollars` bigint(20) DEFAULT NULL,
  `currencyTypeID` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`timeSheetID`),
  KEY `timeSheet_status` (`status`),
  KEY `timeSheet_projectID` (`projectID`),
  KEY `timeSheet_personID` (`personID`),
  KEY `timeSheet_approvedByManagerPersonID` (`approvedByManagerPersonID`),
  KEY `timeSheet_approvedByAdminPersonID` (`approvedByAdminPersonID`),
  KEY `timeSheet_recipient_tfID` (`recipient_tfID`),
  KEY `timeSheet_currencyTypeID` (`currencyTypeID`),
  CONSTRAINT `timeSheet_approvedByAdminPersonID` FOREIGN KEY (`approvedByAdminPersonID`) REFERENCES `person` (`personID`),
  CONSTRAINT `timeSheet_approvedByManagerPersonID` FOREIGN KEY (`approvedByManagerPersonID`) REFERENCES `person` (`personID`),
  CONSTRAINT `timeSheet_currencyTypeID` FOREIGN KEY (`currencyTypeID`) REFERENCES `currencyType` (`currencyTypeID`),
  CONSTRAINT `timeSheet_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `timeSheet_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `timeSheet_recipient_tfID` FOREIGN KEY (`recipient_tfID`) REFERENCES `tf` (`tfID`),
  CONSTRAINT `timeSheet_status` FOREIGN KEY (`status`) REFERENCES `timeSheetStatus` (`timeSheetStatusID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25383 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_timeSheet BEFORE INSERT ON timeSheet
FOR EACH ROW
BEGIN
  DECLARE pref_tfID INTEGER;
  DECLARE cbd BIGINT(20);
  DECLARE cur VARCHAR(3);
  SET NEW.personID = personID();
  SET NEW.status = 'edit';
  SELECT preferred_tfID INTO pref_tfID FROM person WHERE personID = personID();
  SET NEW.recipient_tfID = pref_tfID;
  SELECT customerBilledDollars,currencyTypeID INTO cbd,cur FROM project WHERE projectID = NEW.projectID;
  SET NEW.customerBilledDollars = cbd;
  SET NEW.currencyTypeID = cur;
  SET NEW.dateFrom = null;
  SET NEW.dateTo = null;
  SET NEW.approvedByManagerPersonID = null;
  SET NEW.approvedByAdminPersonID = null;
  SET NEW.dateSubmittedToManager = null;
  SET NEW.dateSubmittedToAdmin = null;
  SET NEW.dateRejected = null;
  SET NEW.invoiceDate = null;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_timeSheet BEFORE UPDATE ON timeSheet
FOR EACH ROW
BEGIN
  DECLARE has_bastard_tasks INTEGER;
  DECLARE cbd BIGINT(20);
  DECLARE cur VARCHAR(3);

  IF (has_perm(personID(),512,"timeSheet")) THEN
    SELECT 1 INTO @null;
  ELSEIF (OLD.status = 'manager' AND NEW.status = 'rejected' AND has_perm(personID(),256,"timeSheet")) THEN
    SELECT 1 INTO @null;
  ELSEIF (OLD.status = 'manager' AND NEW.status = 'admin' AND has_perm(personID(),256,"timeSheet")) THEN
    SELECT 1 INTO @null;
  ELSEIF (neq(OLD.status, 'edit') AND neq(OLD.status, 'rejected')) THEN
    call alloc_error('Time sheet is not editable(2).');
  ELSEIF (neq(NEW.status, 'edit') AND neq(OLD.status, 'rejected') AND using_views()) THEN
    call alloc_error('Not permitted to change time sheet status.');
  ELSEIF (using_views()) THEN
    
    SET NEW.timeSheetID = OLD.timeSheetID;
    SET NEW.personID = OLD.personID;
    SET NEW.status = 'edit';
    SET NEW.recipient_tfID = OLD.recipient_tfID;
    SET NEW.customerBilledDollars = OLD.customerBilledDollars;
    SET NEW.currencyTypeID = OLD.currencyTypeID;
    SET NEW.dateFrom = OLD.dateFrom;
    SET NEW.dateTo = OLD.dateTo;
    SET NEW.approvedByManagerPersonID = OLD.approvedByManagerPersonID;
    SET NEW.approvedByAdminPersonID = OLD.approvedByAdminPersonID;
    SET NEW.dateSubmittedToManager = OLD.dateSubmittedToManager;
    SET NEW.dateSubmittedToAdmin = OLD.dateSubmittedToAdmin;
    SET NEW.dateRejected = OLD.dateRejected;
    SET NEW.invoiceDate = OLD.invoiceDate;
  END IF;

  IF ((OLD.status = 'edit' AND NEW.status = 'edit') OR (OLD.status = 'rejected' AND NEW.status = 'rejected')) AND neq(OLD.projectID,NEW.projectID) THEN
    SELECT count(*) INTO has_bastard_tasks FROM timeSheetItem
 LEFT JOIN timeSheet ON timeSheet.timeSheetID = timeSheetItem.timeSheetID
 LEFT JOIN task ON timeSheetItem.taskID = task.taskID
     WHERE task.projectID != NEW.projectID
       AND timeSheetItem.timeSheetID = OLD.timeSheetID;
    IF has_bastard_tasks THEN
      call alloc_error("Task belongs to wrong project.");
    END IF;

    SELECT customerBilledDollars,currencyTypeID INTO cbd,cur FROM project WHERE projectID = NEW.projectID;
    SET NEW.customerBilledDollars = cbd;
    SET NEW.currencyTypeID = cur;
    UPDATE timeSheetItem
       SET rate = (SELECT rate FROM projectPerson WHERE projectID = NEW.projectID AND personID = personID() LIMIT 1)
     WHERE timeSheetID = OLD.timeSheetID;

  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_timeSheet BEFORE DELETE ON timeSheet
FOR EACH ROW
BEGIN
  DECLARE num_timeSheetItems INTEGER;

  IF (neq(OLD.status, 'edit') AND neq(OLD.status, 'rejected')) THEN
    call alloc_error('Not permitted to delete time sheet unless status is edit.');
  END IF;

  SELECT count(timeSheetID) INTO num_timeSheetItems FROM timeSheetItem WHERE timeSheetID = OLD.timeSheetID;
  IF (num_timeSheetItems > 0) THEN
    call alloc_error('Not permitted to delete time sheet that has items.');
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `timeSheetItem`
--

DROP TABLE IF EXISTS `timeSheetItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeSheetItem` (
  `timeSheetItemID` int(11) NOT NULL AUTO_INCREMENT,
  `timeSheetID` int(11) NOT NULL DEFAULT 0,
  `dateTimeSheetItem` date DEFAULT NULL,
  `timeSheetItemDuration` decimal(9,2) DEFAULT 0.00,
  `timeSheetItemDurationUnitID` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` text DEFAULT NULL,
  `personID` int(11) NOT NULL DEFAULT 0,
  `taskID` int(11) DEFAULT NULL,
  `rate` bigint(20) DEFAULT 0,
  `commentPrivate` tinyint(1) DEFAULT 0,
  `comment` text DEFAULT NULL,
  `multiplier` decimal(9,2) NOT NULL DEFAULT 1.00,
  `emailUID` varchar(255) DEFAULT NULL,
  `emailMessageID` varchar(255) DEFAULT NULL,
  `timeSheetItemCreatedTime` datetime DEFAULT NULL,
  `timeSheetItemCreatedUser` int(11) DEFAULT NULL,
  `timeSheetItemModifiedTime` datetime DEFAULT NULL,
  `timeSheetItemModifiedUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`timeSheetItemID`),
  KEY `idx_taskID` (`taskID`),
  KEY `timeSheetItem_personID` (`personID`),
  KEY `timeSheetItem_timeSheetItemDurationUnitID` (`timeSheetItemDurationUnitID`),
  KEY `idx_timeSheetItem_timeSheetID` (`timeSheetID`),
  KEY `timeSheetItem_multiplier` (`multiplier`),
  KEY `dateTimeSheetItem` (`dateTimeSheetItem`),
  CONSTRAINT `timeSheetItem_multiplier` FOREIGN KEY (`multiplier`) REFERENCES `timeSheetItemMultiplier` (`timeSheetItemMultiplierID`) ON UPDATE CASCADE,
  CONSTRAINT `timeSheetItem_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `timeSheetItem_taskID` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`),
  CONSTRAINT `timeSheetItem_timeSheetID` FOREIGN KEY (`timeSheetID`) REFERENCES `timeSheet` (`timeSheetID`),
  CONSTRAINT `timeSheetItem_timeSheetItemDurationUnitID` FOREIGN KEY (`timeSheetItemDurationUnitID`) REFERENCES `timeUnit` (`timeUnitID`)
) ENGINE=InnoDB AUTO_INCREMENT=94381 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_insert_timeSheetItem BEFORE INSERT ON timeSheetItem
FOR EACH ROW
BEGIN
  DECLARE validDate DATE;
  DECLARE pID INTEGER;
  DECLARE r BIGINT(20);
  DECLARE rUnitID INTEGER;
  DECLARE description VARCHAR(255);
  DECLARE dClosed DATETIME;
  DECLARE taskWindow INTEGER;
  call check_edit_timeSheet(NEW.timeSheetID);

  SET NEW.timeSheetItemCreatedUser = personID();
  SET NEW.timeSheetItemCreatedTime = current_timestamp();

  SELECT IFNULL(value,0) INTO taskWindow FROM config WHERE name = 'taskWindow';
  SELECT dateClosed INTO dClosed FROM task WHERE taskID = NEW.taskID;

  IF NEW.taskID AND taskWindow AND dClosed THEN
    IF now() > DATE_ADD(dClosed, INTERVAL taskWindow DAY) THEN
      call alloc_error("Time not recorded. Task has been closed for too long.");
    END IF;
  END IF;

  SELECT DATE(NEW.dateTimeSheetItem) INTO validDate;
  IF (validDate = '0000-00-00') THEN
    call alloc_error("Invalid date.");
  END IF;

  IF (NEW.timeSheetItemDuration IS NULL OR NEW.timeSheetItemDuration < 0) THEN
    call alloc_error("Invalid time duration.");
  END IF;

  SET NEW.personID = personID();
  SELECT projectID INTO pID FROM timeSheet WHERE timeSheet.timeSheetID = NEW.timeSheetID;
  SELECT rate,rateUnitID INTO r,rUnitID FROM projectPerson WHERE projectID = pID AND personID = personID() LIMIT 1;

  
  IF (neq(NEW.rate,r) AND NOT can_edit_rate(personID(),pID)) THEN
    call alloc_error("Time sheet's rate is not editable.");
  END IF;

  IF (NEW.rate IS NULL AND r) THEN
    SET NEW.rate = r;
    SET NEW.timeSheetItemDurationUnitID = rUnitID;
  END IF;

  IF (NEW.taskID) THEN
    SELECT taskName INTO description FROM task WHERE taskID = NEW.taskID;
    SET NEW.description = description;
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_insert_timeSheetItem AFTER INSERT ON timeSheetItem
FOR EACH ROW
BEGIN
  DECLARE isTask BOOLEAN;
  call updateTimeSheetDates(NEW.timeSheetID);

  SELECT count(*) INTO isTask FROM task WHERE taskID = NEW.taskID AND taskStatus = 'open_notstarted';
  IF (isTask) THEN
    call change_task_status(NEW.taskID,'open_inprogress');
  END IF;
  UPDATE task SET dateActualStart = (SELECT min(dateTimeSheetItem) FROM timeSheetItem WHERE taskID = NEW.taskID)
   WHERE taskID = NEW.taskID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_update_timeSheetItem BEFORE UPDATE ON timeSheetItem
FOR EACH ROW
BEGIN
  DECLARE validDate DATE;
  DECLARE pID INTEGER;
  DECLARE r BIGINT(20);
  DECLARE rUnitID INTEGER;
  DECLARE taskTitle varchar(255);
  call check_edit_timeSheet(OLD.timeSheetID);

  SET NEW.timeSheetItemModifiedUser = personID();
  SET NEW.timeSheetItemModifiedTime = current_timestamp();

  SELECT DATE(NEW.dateTimeSheetItem) INTO validDate;
  IF (validDate = '0000-00-00') THEN
    call alloc_error("Invalid date.");
  END IF;

  IF (NEW.timeSheetItemDuration IS NULL OR NEW.timeSheetItemDuration < 0) THEN
    call alloc_error("Invalid time duration.");
  END IF;

  SET NEW.timeSheetItemID = OLD.timeSheetItemID;
  SET NEW.personID = OLD.personID;
  SELECT projectID INTO pID FROM timeSheet WHERE timeSheet.timeSheetID = NEW.timeSheetID;
  SELECT rate,rateUnitID INTO r,rUnitID FROM projectPerson WHERE projectID = pID AND personID = OLD.personID LIMIT 1;

  
  IF (neq(NEW.rate,r) AND NOT can_edit_rate(personID(),pID)) THEN
    call alloc_error("Time sheet's rate is not editable.");
  END IF;

  IF (NEW.rate IS NULL AND r) THEN
    SET NEW.rate = r;
    SET NEW.timeSheetItemDurationUnitID = rUnitID;
  END IF;
  SELECT taskName INTO taskTitle FROM task WHERE taskID = NEW.taskID;
  SET NEW.description = taskTitle;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_update_timeSheetItem AFTER UPDATE ON timeSheetItem
FOR EACH ROW
BEGIN
  IF (neq(OLD.dateTimeSheetItem, NEW.dateTimeSheetItem)) THEN
    call updateTimeSheetDates(NEW.timeSheetID);
  END IF;
  UPDATE task SET dateActualStart = (SELECT min(dateTimeSheetItem) FROM timeSheetItem WHERE taskID = NEW.taskID)
   WHERE taskID = NEW.taskID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER before_delete_timeSheetItem BEFORE DELETE ON timeSheetItem
FOR EACH ROW
BEGIN
  call check_edit_timeSheet(OLD.timeSheetID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_delete_timeSheetItem AFTER DELETE ON timeSheetItem
FOR EACH ROW
BEGIN
  call updateTimeSheetDates(OLD.timeSheetID);
  UPDATE task SET dateActualStart = (SELECT min(dateTimeSheetItem) FROM timeSheetItem WHERE taskID = OLD.taskID)
   WHERE taskID = OLD.taskID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `timeSheetItemMultiplier`
--

DROP TABLE IF EXISTS `timeSheetItemMultiplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeSheetItemMultiplier` (
  `timeSheetItemMultiplierID` decimal(9,2) NOT NULL DEFAULT 0.00,
  `timeSheetItemMultiplierName` varchar(255) DEFAULT NULL,
  `timeSheetItemMultiplierSeq` int(11) NOT NULL DEFAULT 0,
  `timeSheetItemMultiplierActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`timeSheetItemMultiplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeSheetStatus`
--

DROP TABLE IF EXISTS `timeSheetStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeSheetStatus` (
  `timeSheetStatusID` varchar(255) NOT NULL DEFAULT '',
  `timeSheetStatusSeq` int(11) NOT NULL DEFAULT 0,
  `timeSheetStatusActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`timeSheetStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `timeUnit`
--

DROP TABLE IF EXISTS `timeUnit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeUnit` (
  `timeUnitID` int(11) NOT NULL AUTO_INCREMENT,
  `timeUnitName` varchar(30) DEFAULT NULL,
  `timeUnitLabelA` varchar(30) DEFAULT NULL,
  `timeUnitLabelB` varchar(30) DEFAULT NULL,
  `timeUnitSeconds` int(11) DEFAULT NULL,
  `timeUnitActive` tinyint(1) DEFAULT 0,
  `timeUnitSequence` int(11) DEFAULT NULL,
  PRIMARY KEY (`timeUnitID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `tokenID` int(11) NOT NULL AUTO_INCREMENT,
  `tokenHash` varchar(255) NOT NULL DEFAULT '',
  `tokenEntity` varchar(32) DEFAULT '',
  `tokenEntityID` int(11) DEFAULT NULL,
  `tokenActionID` int(11) NOT NULL DEFAULT 0,
  `tokenExpirationDate` datetime DEFAULT NULL,
  `tokenUsed` int(11) DEFAULT 0,
  `tokenMaxUsed` int(11) DEFAULT 0,
  `tokenActive` tinyint(1) DEFAULT 0,
  `tokenCreatedBy` int(11) NOT NULL DEFAULT 0,
  `tokenCreatedDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`tokenID`),
  UNIQUE KEY `tokenHash` (`tokenHash`),
  KEY `token_tokenActionID` (`tokenActionID`),
  KEY `token_tokenCreatedBy` (`tokenCreatedBy`),
  KEY `token_tokenEntityID` (`tokenEntityID`),
  CONSTRAINT `token_tokenActionID` FOREIGN KEY (`tokenActionID`) REFERENCES `tokenAction` (`tokenActionID`),
  CONSTRAINT `token_tokenCreatedBy` FOREIGN KEY (`tokenCreatedBy`) REFERENCES `person` (`personID`)
) ENGINE=InnoDB AUTO_INCREMENT=61941 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokenAction`
--

DROP TABLE IF EXISTS `tokenAction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokenAction` (
  `tokenActionID` int(11) NOT NULL AUTO_INCREMENT,
  `tokenAction` varchar(32) NOT NULL DEFAULT '',
  `tokenActionType` varchar(32) DEFAULT NULL,
  `tokenActionMethod` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`tokenActionID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `transactionID` int(11) NOT NULL AUTO_INCREMENT,
  `companyDetails` text NOT NULL,
  `product` varchar(255) NOT NULL DEFAULT '',
  `amount` bigint(20) NOT NULL DEFAULT 0,
  `currencyTypeID` char(3) NOT NULL DEFAULT '',
  `destCurrencyTypeID` char(3) NOT NULL DEFAULT '',
  `exchangeRate` decimal(14,5) NOT NULL DEFAULT 1.00000,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `dateApproved` date DEFAULT NULL,
  `expenseFormID` int(11) DEFAULT NULL,
  `tfID` int(11) NOT NULL DEFAULT 0,
  `fromTfID` int(11) NOT NULL DEFAULT 0,
  `projectID` int(11) DEFAULT NULL,
  `transactionModifiedUser` int(11) DEFAULT NULL,
  `transactionModifiedTime` datetime DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `transactionCreatedUser` int(11) DEFAULT NULL,
  `transactionCreatedTime` datetime DEFAULT NULL,
  `transactionDate` date NOT NULL DEFAULT '0000-00-00',
  `invoiceID` int(11) DEFAULT NULL,
  `invoiceItemID` int(11) DEFAULT NULL,
  `transactionType` varchar(255) NOT NULL DEFAULT '',
  `timeSheetID` int(11) DEFAULT NULL,
  `productSaleID` int(11) DEFAULT NULL,
  `productSaleItemID` int(11) DEFAULT NULL,
  `productCostID` int(11) DEFAULT NULL,
  `transactionRepeatID` int(11) DEFAULT NULL,
  `transactionGroupID` int(11) DEFAULT NULL,
  PRIMARY KEY (`transactionID`),
  KEY `idx_invoiceItemID` (`invoiceItemID`),
  KEY `idx_fromTfID` (`fromTfID`),
  KEY `idx_productSaleID` (`productSaleID`),
  KEY `idx_productSaleItemID` (`productSaleItemID`),
  KEY `idx_transactionGroupID` (`transactionGroupID`),
  KEY `transaction_status` (`status`),
  KEY `transaction_transactionType` (`transactionType`),
  KEY `transaction_expenseFormID` (`expenseFormID`),
  KEY `transaction_projectID` (`projectID`),
  KEY `transaction_transactionModifiedUser` (`transactionModifiedUser`),
  KEY `transaction_transactionCreatedUser` (`transactionCreatedUser`),
  KEY `transaction_invoiceID` (`invoiceID`),
  KEY `transaction_transactionRepeatID` (`transactionRepeatID`),
  KEY `idx_transaction_timeSheetID` (`timeSheetID`),
  KEY `idx_transaction_tfID` (`tfID`),
  KEY `transaction_currencyTypeID` (`currencyTypeID`),
  KEY `idx_productCostID` (`productCostID`),
  KEY `idx_tfID_currencyTypeID_status_amount_exchangeRate` (`tfID`,`currencyTypeID`,`status`,`amount`,`exchangeRate`),
  CONSTRAINT `transaction_currencyTypeID` FOREIGN KEY (`currencyTypeID`) REFERENCES `currencyType` (`currencyTypeID`),
  CONSTRAINT `transaction_expenseFormID` FOREIGN KEY (`expenseFormID`) REFERENCES `expenseForm` (`expenseFormID`),
  CONSTRAINT `transaction_fromTfID` FOREIGN KEY (`fromTfID`) REFERENCES `tf` (`tfID`),
  CONSTRAINT `transaction_invoiceID` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`invoiceID`),
  CONSTRAINT `transaction_invoiceItemID` FOREIGN KEY (`invoiceItemID`) REFERENCES `invoiceItem` (`invoiceItemID`),
  CONSTRAINT `transaction_productCostID` FOREIGN KEY (`productCostID`) REFERENCES `productCost` (`productCostID`),
  CONSTRAINT `transaction_productSaleID` FOREIGN KEY (`productSaleID`) REFERENCES `productSale` (`productSaleID`),
  CONSTRAINT `transaction_productSaleItemID` FOREIGN KEY (`productSaleItemID`) REFERENCES `productSaleItem` (`productSaleItemID`),
  CONSTRAINT `transaction_projectID` FOREIGN KEY (`projectID`) REFERENCES `project` (`projectID`),
  CONSTRAINT `transaction_status` FOREIGN KEY (`status`) REFERENCES `transactionStatus` (`transactionStatusID`) ON UPDATE CASCADE,
  CONSTRAINT `transaction_tfID` FOREIGN KEY (`tfID`) REFERENCES `tf` (`tfID`),
  CONSTRAINT `transaction_timeSheetID` FOREIGN KEY (`timeSheetID`) REFERENCES `timeSheet` (`timeSheetID`),
  CONSTRAINT `transaction_transactionCreatedUser` FOREIGN KEY (`transactionCreatedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `transaction_transactionModifiedUser` FOREIGN KEY (`transactionModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `transaction_transactionRepeatID` FOREIGN KEY (`transactionRepeatID`) REFERENCES `transactionRepeat` (`transactionRepeatID`),
  CONSTRAINT `transaction_transactionType` FOREIGN KEY (`transactionType`) REFERENCES `transactionType` (`transactionTypeID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87084 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionRepeat`
--

DROP TABLE IF EXISTS `transactionRepeat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionRepeat` (
  `transactionRepeatID` int(11) NOT NULL AUTO_INCREMENT,
  `tfID` int(11) NOT NULL DEFAULT 0,
  `fromTfID` int(11) NOT NULL DEFAULT 0,
  `payToName` text NOT NULL,
  `payToAccount` text NOT NULL,
  `companyDetails` text NOT NULL,
  `emailOne` varchar(255) DEFAULT '',
  `emailTwo` varchar(255) DEFAULT '',
  `transactionRepeatModifiedUser` int(11) DEFAULT NULL,
  `transactionRepeatModifiedTime` datetime DEFAULT NULL,
  `transactionRepeatCreatedUser` int(11) DEFAULT NULL,
  `transactionRepeatCreatedTime` datetime DEFAULT NULL,
  `transactionStartDate` date NOT NULL DEFAULT '0000-00-00',
  `transactionFinishDate` date NOT NULL DEFAULT '0000-00-00',
  `paymentBasis` varchar(255) NOT NULL DEFAULT '',
  `amount` bigint(20) NOT NULL DEFAULT 0,
  `currencyTypeID` char(3) NOT NULL DEFAULT '',
  `product` varchar(255) NOT NULL DEFAULT '',
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `transactionType` varchar(255) NOT NULL DEFAULT '',
  `reimbursementRequired` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`transactionRepeatID`),
  KEY `transactionRepeat_transactionType` (`transactionType`),
  KEY `transactionRepeat_tfID` (`tfID`),
  KEY `transactionRepeat_fromTfID` (`fromTfID`),
  KEY `transactionRepeat_transactionRepeatModifiedUser` (`transactionRepeatModifiedUser`),
  KEY `transactionRepeat_transactionRepeatCreatedUser` (`transactionRepeatCreatedUser`),
  KEY `transactionRepeat_currencyTypeID` (`currencyTypeID`),
  CONSTRAINT `transactionRepeat_currencyTypeID` FOREIGN KEY (`currencyTypeID`) REFERENCES `currencyType` (`currencyTypeID`),
  CONSTRAINT `transactionRepeat_fromTfID` FOREIGN KEY (`fromTfID`) REFERENCES `tf` (`tfID`),
  CONSTRAINT `transactionRepeat_tfID` FOREIGN KEY (`tfID`) REFERENCES `tf` (`tfID`),
  CONSTRAINT `transactionRepeat_transactionRepeatCreatedUser` FOREIGN KEY (`transactionRepeatCreatedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `transactionRepeat_transactionRepeatModifiedUser` FOREIGN KEY (`transactionRepeatModifiedUser`) REFERENCES `person` (`personID`),
  CONSTRAINT `transactionRepeat_transactionType` FOREIGN KEY (`transactionType`) REFERENCES `transactionType` (`transactionTypeID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionStatus`
--

DROP TABLE IF EXISTS `transactionStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionStatus` (
  `transactionStatusID` varchar(255) NOT NULL DEFAULT '',
  `transactionStatusSeq` int(11) NOT NULL DEFAULT 0,
  `transactionStatusActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`transactionStatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactionType`
--

DROP TABLE IF EXISTS `transactionType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactionType` (
  `transactionTypeID` varchar(255) NOT NULL DEFAULT '',
  `transactionTypeSeq` int(11) NOT NULL DEFAULT 0,
  `transactionTypeActive` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`transactionTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tsiHint`
--

DROP TABLE IF EXISTS `tsiHint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tsiHint` (
  `tsiHintID` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `duration` decimal(9,2) DEFAULT 0.00,
  `personID` int(11) NOT NULL,
  `taskID` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `tsiHintCreatedTime` datetime DEFAULT NULL,
  `tsiHintCreatedUser` int(11) DEFAULT NULL,
  `tsiHintModifiedTime` datetime DEFAULT NULL,
  `tsiHintModifiedUser` int(11) DEFAULT NULL,
  PRIMARY KEY (`tsiHintID`),
  KEY `idx_tsiHinttaskID` (`taskID`),
  KEY `idx_tsiHintDate` (`date`),
  KEY `tsiHint_personID` (`personID`),
  CONSTRAINT `tsiHint_personID` FOREIGN KEY (`personID`) REFERENCES `person` (`personID`),
  CONSTRAINT `tsiHint_taskID` FOREIGN KEY (`taskID`) REFERENCES `task` (`taskID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-17 12:56:18
