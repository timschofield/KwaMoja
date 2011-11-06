CREATE DATABASE IF NOT EXISTS weberpdemo;
USE weberpdemo;
SET FOREIGN_KEY_CHECKS = 0;
-- MySQL dump 10.13  Distrib 5.1.47-MariaDB, for pc-linux-gnu (i686)
--
-- Host: localhost    Database: weberpdemo
-- ------------------------------------------------------
-- Server version	5.1.47-MariaDB
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accountgroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountgroups` (
  `groupname` char(30) NOT NULL DEFAULT '',
  `sectioninaccounts` int(11) NOT NULL DEFAULT '0',
  `pandl` tinyint(4) NOT NULL DEFAULT '1',
  `sequenceintb` smallint(6) NOT NULL DEFAULT '0',
  `parentgroupname` varchar(30) NOT NULL,
  PRIMARY KEY (`groupname`),
  KEY `SequenceInTB` (`sequenceintb`),
  KEY `sectioninaccounts` (`sectioninaccounts`),
  KEY `parentgroupname` (`parentgroupname`),
  CONSTRAINT `accountgroups_ibfk_1` FOREIGN KEY (`sectioninaccounts`) REFERENCES `accountsection` (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accountsection`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountsection` (
  `sectionid` int(11) NOT NULL DEFAULT '0',
  `sectionname` text NOT NULL,
  PRIMARY KEY (`sectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `areas`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `areas` (
  `areacode` char(3) NOT NULL,
  `areadescription` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`areacode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assetmanager`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetmanager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `location` varchar(15) NOT NULL DEFAULT '',
  `cost` double NOT NULL DEFAULT '0',
  `depn` double NOT NULL DEFAULT '0',
  `datepurchased` date NOT NULL DEFAULT '0000-00-00',
  `disposalvalue` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audittrail`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audittrail` (
  `transactiondate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `userid` varchar(20) NOT NULL DEFAULT '',
  `querystring` text,
  KEY `UserID` (`userid`),
  CONSTRAINT `audittrail_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `www_users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bankaccounts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bankaccounts` (
  `accountcode` int(11) NOT NULL DEFAULT '0',
  `currcode` char(3) NOT NULL,
  `invoice` smallint(2) NOT NULL DEFAULT '0',
  `bankaccountcode` varchar(50) NOT NULL DEFAULT '',
  `bankaccountname` char(50) NOT NULL DEFAULT '',
  `bankaccountnumber` char(50) NOT NULL DEFAULT '',
  `bankaddress` char(50) DEFAULT NULL,
  PRIMARY KEY (`accountcode`),
  KEY `currcode` (`currcode`),
  KEY `BankAccountName` (`bankaccountname`),
  KEY `BankAccountNumber` (`bankaccountnumber`),
  CONSTRAINT `bankaccounts_ibfk_1` FOREIGN KEY (`accountcode`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banktrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banktrans` (
  `banktransid` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `transno` bigint(20) NOT NULL DEFAULT '0',
  `bankact` int(11) NOT NULL DEFAULT '0',
  `ref` varchar(50) NOT NULL DEFAULT '',
  `amountcleared` double NOT NULL DEFAULT '0',
  `exrate` double NOT NULL DEFAULT '1' COMMENT 'From bank account currency to payment currency',
  `functionalexrate` double NOT NULL DEFAULT '1' COMMENT 'Account currency to functional currency',
  `transdate` date NOT NULL DEFAULT '0000-00-00',
  `banktranstype` varchar(30) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `currcode` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`banktransid`),
  KEY `BankAct` (`bankact`,`ref`),
  KEY `TransDate` (`transdate`),
  KEY `TransType` (`banktranstype`),
  KEY `Type` (`type`,`transno`),
  KEY `CurrCode` (`currcode`),
  KEY `ref` (`ref`),
  CONSTRAINT `banktrans_ibfk_1` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `banktrans_ibfk_2` FOREIGN KEY (`bankact`) REFERENCES `bankaccounts` (`accountcode`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bom`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bom` (
  `parent` char(20) NOT NULL DEFAULT '',
  `component` char(20) NOT NULL DEFAULT '',
  `workcentreadded` char(5) NOT NULL DEFAULT '',
  `loccode` char(5) NOT NULL DEFAULT '',
  `effectiveafter` date NOT NULL DEFAULT '0000-00-00',
  `effectiveto` date NOT NULL DEFAULT '9999-12-31',
  `quantity` double NOT NULL DEFAULT '1',
  `autoissue` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`parent`,`component`,`workcentreadded`,`loccode`),
  KEY `Component` (`component`),
  KEY `EffectiveAfter` (`effectiveafter`),
  KEY `EffectiveTo` (`effectiveto`),
  KEY `LocCode` (`loccode`),
  KEY `Parent` (`parent`,`effectiveafter`,`effectiveto`,`loccode`),
  KEY `Parent_2` (`parent`),
  KEY `WorkCentreAdded` (`workcentreadded`),
  CONSTRAINT `bom_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `bom_ibfk_2` FOREIGN KEY (`component`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `bom_ibfk_3` FOREIGN KEY (`workcentreadded`) REFERENCES `workcentres` (`code`),
  CONSTRAINT `bom_ibfk_4` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chartdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chartdetails` (
  `accountcode` int(11) NOT NULL DEFAULT '0',
  `period` smallint(6) NOT NULL DEFAULT '0',
  `budget` double NOT NULL DEFAULT '0',
  `actual` double NOT NULL DEFAULT '0',
  `bfwd` double NOT NULL DEFAULT '0',
  `bfwdbudget` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`accountcode`,`period`),
  KEY `Period` (`period`),
  CONSTRAINT `chartdetails_ibfk_1` FOREIGN KEY (`accountcode`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `chartdetails_ibfk_2` FOREIGN KEY (`period`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chartmaster`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chartmaster` (
  `accountcode` int(11) NOT NULL DEFAULT '0',
  `accountname` char(50) NOT NULL DEFAULT '',
  `group_` char(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`accountcode`),
  KEY `AccountName` (`accountname`),
  KEY `Group_` (`group_`),
  CONSTRAINT `chartmaster_ibfk_1` FOREIGN KEY (`group_`) REFERENCES `accountgroups` (`groupname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cogsglpostings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cogsglpostings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area` char(3) NOT NULL DEFAULT '',
  `stkcat` varchar(6) NOT NULL DEFAULT '',
  `glcode` int(11) NOT NULL DEFAULT '0',
  `salestype` char(2) NOT NULL DEFAULT 'AN',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `GLCode` (`glcode`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `coycode` int(11) NOT NULL DEFAULT '1',
  `coyname` varchar(50) NOT NULL DEFAULT '',
  `gstno` varchar(20) NOT NULL DEFAULT '',
  `companynumber` varchar(20) NOT NULL DEFAULT '0',
  `regoffice1` varchar(40) NOT NULL DEFAULT '',
  `regoffice2` varchar(40) NOT NULL DEFAULT '',
  `regoffice3` varchar(40) NOT NULL DEFAULT '',
  `regoffice4` varchar(40) NOT NULL DEFAULT '',
  `regoffice5` varchar(20) NOT NULL DEFAULT '',
  `regoffice6` varchar(15) NOT NULL DEFAULT '',
  `telephone` varchar(25) NOT NULL DEFAULT '',
  `fax` varchar(25) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `currencydefault` varchar(4) NOT NULL DEFAULT '',
  `debtorsact` int(11) NOT NULL DEFAULT '70000',
  `pytdiscountact` int(11) NOT NULL DEFAULT '55000',
  `creditorsact` int(11) NOT NULL DEFAULT '80000',
  `payrollact` int(11) NOT NULL DEFAULT '84000',
  `grnact` int(11) NOT NULL DEFAULT '72000',
  `exchangediffact` int(11) NOT NULL DEFAULT '65000',
  `purchasesexchangediffact` int(11) NOT NULL DEFAULT '0',
  `retainedearnings` int(11) NOT NULL DEFAULT '90000',
  `gllink_debtors` tinyint(1) DEFAULT '1',
  `gllink_creditors` tinyint(1) DEFAULT '1',
  `gllink_stock` tinyint(1) DEFAULT '1',
  `freightact` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`coycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `confname` varchar(35) NOT NULL DEFAULT '',
  `confvalue` text NOT NULL,
  PRIMARY KEY (`confname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contractbom`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contractbom` (
  `contractref` varchar(20) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `workcentreadded` char(5) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`contractref`,`stockid`,`workcentreadded`),
  KEY `Stockid` (`stockid`),
  KEY `ContractRef` (`contractref`),
  KEY `WorkCentreAdded` (`workcentreadded`),
  CONSTRAINT `contractbom_ibfk_1` FOREIGN KEY (`workcentreadded`) REFERENCES `workcentres` (`code`),
  CONSTRAINT `contractbom_ibfk_3` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contractcharges`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contractcharges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contractref` varchar(20) NOT NULL,
  `transtype` smallint(6) NOT NULL DEFAULT '20',
  `transno` int(11) NOT NULL DEFAULT '0',
  `amount` double NOT NULL DEFAULT '0',
  `narrative` text NOT NULL,
  `anticipated` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `contractref` (`contractref`,`transtype`,`transno`),
  KEY `contractcharges_ibfk_2` (`transtype`),
  CONSTRAINT `contractcharges_ibfk_1` FOREIGN KEY (`contractref`) REFERENCES `contracts` (`contractref`),
  CONSTRAINT `contractcharges_ibfk_2` FOREIGN KEY (`transtype`) REFERENCES `systypes` (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contractreqts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contractreqts` (
  `contractreqid` int(11) NOT NULL AUTO_INCREMENT,
  `contractref` varchar(20) NOT NULL DEFAULT '0',
  `requirement` varchar(40) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '1',
  `costperunit` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`contractreqid`),
  KEY `ContractRef` (`contractref`),
  CONSTRAINT `contractreqts_ibfk_1` FOREIGN KEY (`contractref`) REFERENCES `contracts` (`contractref`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contracts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracts` (
  `contractref` varchar(20) NOT NULL DEFAULT '',
  `contractdescription` text NOT NULL,
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `categoryid` varchar(6) NOT NULL DEFAULT '',
  `orderno` int(11) NOT NULL DEFAULT '0',
  `customerref` varchar(20) NOT NULL DEFAULT '',
  `margin` double NOT NULL DEFAULT '1',
  `wo` int(11) NOT NULL DEFAULT '0',
  `requireddate` date NOT NULL DEFAULT '0000-00-00',
  `drawing` varchar(50) NOT NULL DEFAULT '',
  `exrate` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`contractref`),
  KEY `OrderNo` (`orderno`),
  KEY `CategoryID` (`categoryid`),
  KEY `Status` (`status`),
  KEY `WO` (`wo`),
  KEY `loccode` (`loccode`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`debtorno`, `branchcode`) REFERENCES `custbranch` (`debtorno`, `branchcode`),
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `contracts_ibfk_3` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currencies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currencies` (
  `currency` char(20) NOT NULL DEFAULT '',
  `currabrev` char(3) NOT NULL DEFAULT '',
  `country` char(50) NOT NULL DEFAULT '',
  `hundredsname` char(15) NOT NULL DEFAULT 'Cents',
  `decimalplaces` tinyint(3) NOT NULL DEFAULT '2',
  `rate` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`currabrev`),
  KEY `Country` (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custallocns`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custallocns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amt` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `datealloc` date NOT NULL DEFAULT '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL DEFAULT '0',
  `transid_allocto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `DateAlloc` (`datealloc`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`),
  CONSTRAINT `custallocns_ibfk_1` FOREIGN KEY (`transid_allocfrom`) REFERENCES `debtortrans` (`id`),
  CONSTRAINT `custallocns_ibfk_2` FOREIGN KEY (`transid_allocto`) REFERENCES `debtortrans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custbranch`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custbranch` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `brname` varchar(40) NOT NULL DEFAULT '',
  `braddress1` varchar(40) NOT NULL DEFAULT '',
  `braddress2` varchar(40) NOT NULL DEFAULT '',
  `braddress3` varchar(40) NOT NULL DEFAULT '',
  `braddress4` varchar(50) NOT NULL DEFAULT '',
  `braddress5` varchar(20) NOT NULL DEFAULT '',
  `braddress6` varchar(15) NOT NULL DEFAULT '',
  `lat` float(10,6) NOT NULL DEFAULT '0.000000',
  `lng` float(10,6) NOT NULL DEFAULT '0.000000',
  `estdeliverydays` smallint(6) NOT NULL DEFAULT '1',
  `area` char(3) NOT NULL,
  `salesman` varchar(4) NOT NULL DEFAULT '',
  `fwddate` smallint(6) NOT NULL DEFAULT '0',
  `phoneno` varchar(20) NOT NULL DEFAULT '',
  `faxno` varchar(20) NOT NULL DEFAULT '',
  `contactname` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `defaultlocation` varchar(5) NOT NULL DEFAULT '',
  `taxgroupid` tinyint(4) NOT NULL DEFAULT '1',
  `defaultshipvia` int(11) NOT NULL DEFAULT '1',
  `deliverblind` tinyint(1) DEFAULT '1',
  `disabletrans` tinyint(4) NOT NULL DEFAULT '0',
  `brpostaddr1` varchar(40) NOT NULL DEFAULT '',
  `brpostaddr2` varchar(40) NOT NULL DEFAULT '',
  `brpostaddr3` varchar(30) NOT NULL DEFAULT '',
  `brpostaddr4` varchar(20) NOT NULL DEFAULT '',
  `brpostaddr5` varchar(20) NOT NULL DEFAULT '',
  `brpostaddr6` varchar(15) NOT NULL DEFAULT '',
  `specialinstructions` text NOT NULL,
  `custbranchcode` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`branchcode`,`debtorno`),
  KEY `BrName` (`brname`),
  KEY `DebtorNo` (`debtorno`),
  KEY `Salesman` (`salesman`),
  KEY `Area` (`area`),
  KEY `DefaultLocation` (`defaultlocation`),
  KEY `DefaultShipVia` (`defaultshipvia`),
  KEY `taxgroupid` (`taxgroupid`),
  CONSTRAINT `custbranch_ibfk_1` FOREIGN KEY (`debtorno`) REFERENCES `debtorsmaster` (`debtorno`),
  CONSTRAINT `custbranch_ibfk_2` FOREIGN KEY (`area`) REFERENCES `areas` (`areacode`),
  CONSTRAINT `custbranch_ibfk_3` FOREIGN KEY (`salesman`) REFERENCES `salesman` (`salesmancode`),
  CONSTRAINT `custbranch_ibfk_4` FOREIGN KEY (`defaultlocation`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `custbranch_ibfk_6` FOREIGN KEY (`defaultshipvia`) REFERENCES `shippers` (`shipper_id`),
  CONSTRAINT `custbranch_ibfk_7` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custcontacts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custcontacts` (
  `contid` int(11) NOT NULL AUTO_INCREMENT,
  `debtorno` varchar(10) NOT NULL,
  `contactname` varchar(40) NOT NULL,
  `role` varchar(40) NOT NULL,
  `phoneno` varchar(20) NOT NULL,
  `notes` varchar(255) NOT NULL,
  `email` varchar(55) NOT NULL,
  PRIMARY KEY (`contid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custnotes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custnotes` (
  `noteid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `debtorno` varchar(10) NOT NULL DEFAULT '0',
  `href` varchar(100) NOT NULL,
  `note` text NOT NULL,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `priority` varchar(20) NOT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtorsmaster`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtorsmaster` (
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(40) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `address4` varchar(50) NOT NULL DEFAULT '',
  `address5` varchar(20) NOT NULL DEFAULT '',
  `address6` varchar(15) NOT NULL DEFAULT '',
  `currcode` char(3) NOT NULL DEFAULT '',
  `salestype` char(2) NOT NULL DEFAULT '',
  `clientsince` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `holdreason` smallint(6) NOT NULL DEFAULT '0',
  `paymentterms` char(2) NOT NULL DEFAULT 'f',
  `discount` double NOT NULL DEFAULT '0',
  `pymtdiscount` double NOT NULL DEFAULT '0',
  `lastpaid` double NOT NULL DEFAULT '0',
  `lastpaiddate` datetime DEFAULT NULL,
  `creditlimit` double NOT NULL DEFAULT '1000',
  `invaddrbranch` tinyint(4) NOT NULL DEFAULT '0',
  `discountcode` char(2) NOT NULL DEFAULT '',
  `ediinvoices` tinyint(4) NOT NULL DEFAULT '0',
  `ediorders` tinyint(4) NOT NULL DEFAULT '0',
  `edireference` varchar(20) NOT NULL DEFAULT '',
  `editransport` varchar(5) NOT NULL DEFAULT 'email',
  `ediaddress` varchar(50) NOT NULL DEFAULT '',
  `ediserveruser` varchar(20) NOT NULL DEFAULT '',
  `ediserverpwd` varchar(20) NOT NULL DEFAULT '',
  `taxref` varchar(20) NOT NULL DEFAULT '',
  `customerpoline` tinyint(1) NOT NULL DEFAULT '0',
  `typeid` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`debtorno`),
  KEY `Currency` (`currcode`),
  KEY `HoldReason` (`holdreason`),
  KEY `Name` (`name`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SalesType` (`salestype`),
  KEY `EDIInvoices` (`ediinvoices`),
  KEY `EDIOrders` (`ediorders`),
  KEY `debtorsmaster_ibfk_5` (`typeid`),
  CONSTRAINT `debtorsmaster_ibfk_1` FOREIGN KEY (`holdreason`) REFERENCES `holdreasons` (`reasoncode`),
  CONSTRAINT `debtorsmaster_ibfk_2` FOREIGN KEY (`currcode`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `debtorsmaster_ibfk_3` FOREIGN KEY (`paymentterms`) REFERENCES `paymentterms` (`termsindicator`),
  CONSTRAINT `debtorsmaster_ibfk_4` FOREIGN KEY (`salestype`) REFERENCES `salestypes` (`typeabbrev`),
  CONSTRAINT `debtorsmaster_ibfk_5` FOREIGN KEY (`typeid`) REFERENCES `debtortype` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortrans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transno` int(11) NOT NULL DEFAULT '0',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `trandate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `inputdate` datetime NOT NULL,
  `prd` smallint(6) NOT NULL DEFAULT '0',
  `settled` tinyint(4) NOT NULL DEFAULT '0',
  `reference` varchar(20) NOT NULL DEFAULT '',
  `tpe` char(2) NOT NULL DEFAULT '',
  `order_` int(11) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '0',
  `ovamount` double NOT NULL DEFAULT '0',
  `ovgst` double NOT NULL DEFAULT '0',
  `ovfreight` double NOT NULL DEFAULT '0',
  `ovdiscount` double NOT NULL DEFAULT '0',
  `diffonexch` double NOT NULL DEFAULT '0',
  `alloc` double NOT NULL DEFAULT '0',
  `invtext` text,
  `shipvia` int(11) NOT NULL DEFAULT '0',
  `edisent` tinyint(4) NOT NULL DEFAULT '0',
  `consignment` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `DebtorNo` (`debtorno`,`branchcode`),
  KEY `Order_` (`order_`),
  KEY `Prd` (`prd`),
  KEY `Tpe` (`tpe`),
  KEY `Type` (`type`),
  KEY `Settled` (`settled`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type_2` (`type`,`transno`),
  KEY `EDISent` (`edisent`),
  CONSTRAINT `debtortrans_ibfk_1` FOREIGN KEY (`debtorno`) REFERENCES `custbranch` (`debtorno`),
  CONSTRAINT `debtortrans_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `debtortrans_ibfk_3` FOREIGN KEY (`prd`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortranstaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortranstaxes` (
  `debtortransid` int(11) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `taxamount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`debtortransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `debtortranstaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `debtortranstaxes_ibfk_2` FOREIGN KEY (`debtortransid`) REFERENCES `debtortrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortype`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortype` (
  `typeid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `debtortypenotes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debtortypenotes` (
  `noteid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `typeid` tinyint(4) NOT NULL DEFAULT '0',
  `href` varchar(100) NOT NULL,
  `note` varchar(200) NOT NULL,
  `date` date NOT NULL DEFAULT '0000-00-00',
  `priority` varchar(20) NOT NULL,
  PRIMARY KEY (`noteid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deliverynotes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliverynotes` (
  `deliverynotenumber` int(11) NOT NULL,
  `deliverynotelineno` tinyint(4) NOT NULL,
  `salesorderno` int(11) NOT NULL,
  `salesorderlineno` int(11) NOT NULL,
  `qtydelivered` double NOT NULL DEFAULT '0',
  `printed` tinyint(4) NOT NULL DEFAULT '0',
  `invoiced` tinyint(4) NOT NULL DEFAULT '0',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`deliverynotenumber`,`deliverynotelineno`),
  KEY `deliverynotes_ibfk_2` (`salesorderno`,`salesorderlineno`),
  CONSTRAINT `deliverynotes_ibfk_1` FOREIGN KEY (`salesorderno`) REFERENCES `salesorders` (`orderno`),
  CONSTRAINT `deliverynotes_ibfk_2` FOREIGN KEY (`salesorderno`, `salesorderlineno`) REFERENCES `salesorderdetails` (`orderno`, `orderlineno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `discountmatrix`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discountmatrix` (
  `salestype` char(2) NOT NULL DEFAULT '',
  `discountcategory` char(2) NOT NULL DEFAULT '',
  `quantitybreak` int(11) NOT NULL DEFAULT '1',
  `discountrate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`salestype`,`discountcategory`,`quantitybreak`),
  KEY `QuantityBreak` (`quantitybreak`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `SalesType` (`salestype`),
  CONSTRAINT `discountmatrix_ibfk_1` FOREIGN KEY (`salestype`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edi_orders_seg_groups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edi_orders_seg_groups` (
  `seggroupno` tinyint(4) NOT NULL DEFAULT '0',
  `maxoccur` int(4) NOT NULL DEFAULT '0',
  `parentseggroup` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`seggroupno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edi_orders_segs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edi_orders_segs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `segtag` char(3) NOT NULL DEFAULT '',
  `seggroup` tinyint(4) NOT NULL DEFAULT '0',
  `maxoccur` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `SegTag` (`segtag`),
  KEY `SegNo` (`seggroup`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ediitemmapping`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ediitemmapping` (
  `supporcust` varchar(4) NOT NULL DEFAULT '',
  `partnercode` varchar(10) NOT NULL DEFAULT '',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `partnerstockid` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`supporcust`,`partnercode`,`stockid`),
  KEY `PartnerCode` (`partnercode`),
  KEY `StockID` (`stockid`),
  KEY `PartnerStockID` (`partnerstockid`),
  KEY `SuppOrCust` (`supporcust`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `edimessageformat`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edimessageformat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partnercode` varchar(10) NOT NULL DEFAULT '',
  `messagetype` varchar(6) NOT NULL DEFAULT '',
  `section` varchar(7) NOT NULL DEFAULT '',
  `sequenceno` int(11) NOT NULL DEFAULT '0',
  `linetext` varchar(70) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `PartnerCode` (`partnercode`,`messagetype`,`sequenceno`),
  KEY `Section` (`section`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emailsettings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(30) NOT NULL,
  `port` char(5) NOT NULL,
  `heloaddress` varchar(20) NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `timeout` int(11) DEFAULT '5',
  `companyname` varchar(50) DEFAULT NULL,
  `auth` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factorcompanies`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factorcompanies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coyname` varchar(50) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `address4` varchar(40) NOT NULL DEFAULT '',
  `address5` varchar(20) NOT NULL DEFAULT '',
  `address6` varchar(15) NOT NULL DEFAULT '',
  `contact` varchar(25) NOT NULL DEFAULT '',
  `telephone` varchar(25) NOT NULL DEFAULT '',
  `fax` varchar(25) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `factor_name` (`coyname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassetcategories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassetcategories` (
  `categoryid` char(6) NOT NULL DEFAULT '',
  `categorydescription` char(20) NOT NULL DEFAULT '',
  `costact` int(11) NOT NULL DEFAULT '0',
  `depnact` int(11) NOT NULL DEFAULT '0',
  `disposalact` int(11) NOT NULL DEFAULT '80000',
  `accumdepnact` int(11) NOT NULL DEFAULT '0',
  `defaultdepnrate` double NOT NULL DEFAULT '0.2',
  `defaultdepntype` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassetlocations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassetlocations` (
  `locationid` char(6) NOT NULL DEFAULT '',
  `locationdescription` char(20) NOT NULL DEFAULT '',
  `parentlocationid` char(6) DEFAULT '',
  PRIMARY KEY (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassets`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassets` (
  `assetid` int(11) NOT NULL AUTO_INCREMENT,
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `barcode` varchar(20) NOT NULL,
  `assetlocation` varchar(6) NOT NULL DEFAULT '',
  `cost` double NOT NULL DEFAULT '0',
  `accumdepn` double NOT NULL DEFAULT '0',
  `datepurchased` date NOT NULL DEFAULT '0000-00-00',
  `disposalproceeds` double NOT NULL DEFAULT '0',
  `assetcategoryid` varchar(6) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `longdescription` text NOT NULL,
  `depntype` int(11) NOT NULL DEFAULT '1',
  `depnrate` double NOT NULL,
  `disposaldate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`assetid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fixedassettrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixedassettrans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetid` int(11) NOT NULL,
  `transtype` tinyint(4) NOT NULL,
  `transdate` date NOT NULL,
  `transno` int(11) NOT NULL,
  `periodno` smallint(6) NOT NULL,
  `inputdate` date NOT NULL,
  `fixedassettranstype` varchar(8) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assetid` (`assetid`,`transtype`,`transno`),
  KEY `inputdate` (`inputdate`),
  KEY `transdate` (`transdate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `freightcosts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `freightcosts` (
  `shipcostfromid` int(11) NOT NULL AUTO_INCREMENT,
  `locationfrom` varchar(5) NOT NULL DEFAULT '',
  `destination` varchar(40) NOT NULL DEFAULT '',
  `shipperid` int(11) NOT NULL DEFAULT '0',
  `cubrate` double NOT NULL DEFAULT '0',
  `kgrate` double NOT NULL DEFAULT '0',
  `maxkgs` double NOT NULL DEFAULT '999999',
  `maxcub` double NOT NULL DEFAULT '999999',
  `fixedprice` double NOT NULL DEFAULT '0',
  `minimumchg` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`shipcostfromid`),
  KEY `Destination` (`destination`),
  KEY `LocationFrom` (`locationfrom`),
  KEY `ShipperID` (`shipperid`),
  KEY `Destination_2` (`destination`,`locationfrom`,`shipperid`),
  CONSTRAINT `freightcosts_ibfk_1` FOREIGN KEY (`locationfrom`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `freightcosts_ibfk_2` FOREIGN KEY (`shipperid`) REFERENCES `shippers` (`shipper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `geocode_param`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `geocode_param` (
  `geocodeid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `geocode_key` varchar(200) NOT NULL DEFAULT '',
  `center_long` varchar(20) NOT NULL DEFAULT '',
  `center_lat` varchar(20) NOT NULL DEFAULT '',
  `map_height` varchar(10) NOT NULL DEFAULT '',
  `map_width` varchar(10) NOT NULL DEFAULT '',
  `map_host` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`geocodeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gltrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gltrans` (
  `counterindex` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `typeno` bigint(16) NOT NULL DEFAULT '1',
  `chequeno` int(11) NOT NULL DEFAULT '0',
  `trandate` date NOT NULL DEFAULT '0000-00-00',
  `periodno` smallint(6) NOT NULL DEFAULT '0',
  `account` int(11) NOT NULL DEFAULT '0',
  `narrative` varchar(200) NOT NULL DEFAULT '',
  `amount` double NOT NULL DEFAULT '0',
  `posted` tinyint(4) NOT NULL DEFAULT '0',
  `jobref` varchar(20) NOT NULL DEFAULT '',
  `tag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`counterindex`),
  KEY `Account` (`account`),
  KEY `ChequeNo` (`chequeno`),
  KEY `PeriodNo` (`periodno`),
  KEY `Posted` (`posted`),
  KEY `TranDate` (`trandate`),
  KEY `TypeNo` (`typeno`),
  KEY `Type_and_Number` (`type`,`typeno`),
  KEY `JobRef` (`jobref`),
  CONSTRAINT `gltrans_ibfk_1` FOREIGN KEY (`account`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `gltrans_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `gltrans_ibfk_3` FOREIGN KEY (`periodno`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grns`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grns` (
  `grnbatch` smallint(6) NOT NULL DEFAULT '0',
  `grnno` int(11) NOT NULL AUTO_INCREMENT,
  `podetailitem` int(11) NOT NULL DEFAULT '0',
  `itemcode` varchar(20) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `itemdescription` varchar(100) NOT NULL DEFAULT '',
  `qtyrecd` double NOT NULL DEFAULT '0',
  `quantityinv` double NOT NULL DEFAULT '0',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `stdcostunit` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`grnno`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `ItemCode` (`itemcode`),
  KEY `PODetailItem` (`podetailitem`),
  KEY `SupplierID` (`supplierid`),
  CONSTRAINT `grns_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `grns_ibfk_2` FOREIGN KEY (`podetailitem`) REFERENCES `purchorderdetails` (`podetailitem`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `holdreasons`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `holdreasons` (
  `reasoncode` smallint(6) NOT NULL DEFAULT '1',
  `reasondescription` char(30) NOT NULL DEFAULT '',
  `dissallowinvoices` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`reasoncode`),
  KEY `ReasonDescription` (`reasondescription`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lastcostrollup`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lastcostrollup` (
  `stockid` char(20) NOT NULL DEFAULT '',
  `totalonhand` double NOT NULL DEFAULT '0',
  `matcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `labcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `oheadcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `categoryid` char(6) NOT NULL DEFAULT '',
  `stockact` int(11) NOT NULL DEFAULT '0',
  `adjglact` int(11) NOT NULL DEFAULT '0',
  `newmatcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `newlabcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `newoheadcost` decimal(20,4) NOT NULL DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `locationname` varchar(50) NOT NULL DEFAULT '',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) NOT NULL DEFAULT '',
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `tel` varchar(30) NOT NULL DEFAULT '',
  `fax` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `taxprovinceid` tinyint(4) NOT NULL DEFAULT '1',
  `cashsalecustomer` varchar(10) DEFAULT '',
  `managed` int(11) DEFAULT '0',
  `cashsalebranch` varchar(10) DEFAULT '',
  PRIMARY KEY (`loccode`),
  KEY `taxprovinceid` (`taxprovinceid`),
  CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`taxprovinceid`) REFERENCES `taxprovinces` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locstock`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locstock` (
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '0',
  `reorderlevel` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`loccode`,`stockid`),
  KEY `StockID` (`stockid`),
  CONSTRAINT `locstock_ibfk_1` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `locstock_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loctransfers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loctransfers` (
  `reference` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `shipqty` double NOT NULL DEFAULT '0',
  `recqty` double NOT NULL DEFAULT '0',
  `shipdate` date NOT NULL DEFAULT '0000-00-00',
  `recdate` date NOT NULL DEFAULT '0000-00-00',
  `shiploc` varchar(7) NOT NULL DEFAULT '',
  `recloc` varchar(7) NOT NULL DEFAULT '',
  KEY `Reference` (`reference`,`stockid`),
  KEY `ShipLoc` (`shiploc`),
  KEY `RecLoc` (`recloc`),
  KEY `StockID` (`stockid`),
  CONSTRAINT `loctransfers_ibfk_1` FOREIGN KEY (`shiploc`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `loctransfers_ibfk_2` FOREIGN KEY (`recloc`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `loctransfers_ibfk_3` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Shipments To And From Locations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpcalendar`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpcalendar` (
  `calendardate` date NOT NULL,
  `daynumber` int(6) NOT NULL,
  `manufacturingflag` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`calendardate`),
  KEY `daynumber` (`daynumber`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpdemands`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpdemands` (
  `demandid` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `mrpdemandtype` varchar(6) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '0',
  `duedate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`demandid`),
  KEY `StockID` (`stockid`),
  KEY `mrpdemands_ibfk_1` (`mrpdemandtype`),
  CONSTRAINT `mrpdemands_ibfk_1` FOREIGN KEY (`mrpdemandtype`) REFERENCES `mrpdemandtypes` (`mrpdemandtype`),
  CONSTRAINT `mrpdemands_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpdemandtypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpdemandtypes` (
  `mrpdemandtype` varchar(6) NOT NULL DEFAULT '',
  `description` char(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`mrpdemandtype`),
  KEY `mrpdemandtype` (`mrpdemandtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mrpplannedorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mrpplannedorders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `part` char(20) DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `supplyquantity` double DEFAULT NULL,
  `ordertype` varchar(6) DEFAULT NULL,
  `orderno` int(11) DEFAULT NULL,
  `mrpdate` date DEFAULT NULL,
  `updateflag` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offers` (
  `offerid` int(11) NOT NULL AUTO_INCREMENT,
  `tenderid` int(11) NOT NULL DEFAULT '0',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantity` double NOT NULL DEFAULT '0',
  `uom` varchar(15) NOT NULL DEFAULT '',
  `price` double NOT NULL DEFAULT '0',
  `expirydate` date NOT NULL DEFAULT '0000-00-00',
  `currcode` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`offerid`),
  KEY `offers_ibfk_1` (`supplierid`),
  KEY `offers_ibfk_2` (`stockid`),
  CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `offers_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orderdeliverydifferenceslog`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderdeliverydifferenceslog` (
  `orderno` int(11) NOT NULL DEFAULT '0',
  `invoiceno` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `quantitydiff` double NOT NULL DEFAULT '0',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branch` varchar(10) NOT NULL DEFAULT '',
  `can_or_bo` char(3) NOT NULL DEFAULT 'CAN',
  KEY `StockID` (`stockid`),
  KEY `DebtorNo` (`debtorno`,`branch`),
  KEY `Can_or_BO` (`can_or_bo`),
  KEY `OrderNo` (`orderno`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_2` FOREIGN KEY (`debtorno`, `branch`) REFERENCES `custbranch` (`debtorno`, `branchcode`),
  CONSTRAINT `orderdeliverydifferenceslog_ibfk_3` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentmethods`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentmethods` (
  `paymentid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `paymentname` varchar(15) NOT NULL DEFAULT '',
  `paymenttype` int(11) NOT NULL DEFAULT '1',
  `receipttype` int(11) NOT NULL DEFAULT '1',
  `usepreprintedstationery` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`paymentid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentterms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentterms` (
  `termsindicator` char(2) NOT NULL DEFAULT '',
  `terms` char(40) NOT NULL DEFAULT '',
  `daysbeforedue` smallint(6) NOT NULL DEFAULT '0',
  `dayinfollowingmonth` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`termsindicator`),
  KEY `DaysBeforeDue` (`daysbeforedue`),
  KEY `DayInFollowingMonth` (`dayinfollowingmonth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pcashdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcashdetails` (
  `counterindex` int(20) NOT NULL AUTO_INCREMENT,
  `tabcode` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  `amount` double NOT NULL,
  `authorized` date NOT NULL COMMENT 'date cash assigment was revised and authorized by authorizer from tabs table',
  `posted` tinyint(4) NOT NULL COMMENT 'has (or has not) been posted into gltrans',
  `notes` text NOT NULL,
  `receipt` text COMMENT 'filename or path to scanned receipt or code of receipt to find physical receipt if tax guys or auditors show up',
  PRIMARY KEY (`counterindex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pcexpenses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pcexpenses` (
  `codeexpense` varchar(20) NOT NULL COMMENT 'code for the group',
  `description` varchar(50) NOT NULL COMMENT 'text description, e.g. meals, train tickets, fuel, etc',
  `glaccount` int(11) NOT NULL COMMENT 'GL related account',
  `tag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codeexpense`),
  KEY `glaccount` (`glaccount`),
  CONSTRAINT `pcexpenses_ibfk_1` FOREIGN KEY (`glaccount`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pctabexpenses`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pctabexpenses` (
  `typetabcode` varchar(20) NOT NULL,
  `codeexpense` varchar(20) NOT NULL,
  KEY `typetabcode` (`typetabcode`),
  KEY `codeexpense` (`codeexpense`),
  CONSTRAINT `pctabexpenses_ibfk_1` FOREIGN KEY (`typetabcode`) REFERENCES `pctypetabs` (`typetabcode`),
  CONSTRAINT `pctabexpenses_ibfk_2` FOREIGN KEY (`codeexpense`) REFERENCES `pcexpenses` (`codeexpense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pctabs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pctabs` (
  `tabcode` varchar(20) NOT NULL,
  `usercode` varchar(20) NOT NULL COMMENT 'code of user employee from www_users',
  `typetabcode` varchar(20) NOT NULL,
  `currency` char(3) NOT NULL,
  `tablimit` double NOT NULL,
  `assigner` varchar(20) NOT NULL COMMENT 'Cash assigner for the tab',
  `authorizer` varchar(20) NOT NULL COMMENT 'code of user from www_users',
  `glaccountassignment` int(11) NOT NULL COMMENT 'gl account where the money comes from',
  `glaccountpcash` int(11) NOT NULL,
  PRIMARY KEY (`tabcode`),
  KEY `usercode` (`usercode`),
  KEY `typetabcode` (`typetabcode`),
  KEY `currency` (`currency`),
  KEY `authorizer` (`authorizer`),
  KEY `glaccountassignment` (`glaccountassignment`),
  CONSTRAINT `pctabs_ibfk_1` FOREIGN KEY (`usercode`) REFERENCES `www_users` (`userid`),
  CONSTRAINT `pctabs_ibfk_2` FOREIGN KEY (`typetabcode`) REFERENCES `pctypetabs` (`typetabcode`),
  CONSTRAINT `pctabs_ibfk_3` FOREIGN KEY (`currency`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `pctabs_ibfk_4` FOREIGN KEY (`authorizer`) REFERENCES `www_users` (`userid`),
  CONSTRAINT `pctabs_ibfk_5` FOREIGN KEY (`glaccountassignment`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pctypetabs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pctypetabs` (
  `typetabcode` varchar(20) NOT NULL COMMENT 'code for the type of petty cash tab',
  `typetabdescription` varchar(50) NOT NULL COMMENT 'text description, e.g. tab for CEO',
  PRIMARY KEY (`typetabcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `periods`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periods` (
  `periodno` smallint(6) NOT NULL DEFAULT '0',
  `lastdate_in_period` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`periodno`),
  KEY `LastDate_in_Period` (`lastdate_in_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pickinglistdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickinglistdetails` (
  `pickinglistno` int(11) NOT NULL DEFAULT '0',
  `pickinglistlineno` int(11) NOT NULL DEFAULT '0',
  `orderlineno` int(11) NOT NULL DEFAULT '0',
  `qtyexpected` double NOT NULL DEFAULT '0',
  `qtypicked` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`pickinglistno`,`pickinglistlineno`),
  CONSTRAINT `pickinglistdetails_ibfk_1` FOREIGN KEY (`pickinglistno`) REFERENCES `pickinglists` (`pickinglistno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pickinglists`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pickinglists` (
  `pickinglistno` int(11) NOT NULL DEFAULT '0',
  `orderno` int(11) NOT NULL DEFAULT '0',
  `pickinglistdate` date NOT NULL DEFAULT '0000-00-00',
  `dateprinted` date NOT NULL DEFAULT '0000-00-00',
  `deliverynotedate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`pickinglistno`),
  KEY `pickinglists_ibfk_1` (`orderno`),
  CONSTRAINT `pickinglists_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prices`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prices` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `typeabbrev` char(2) NOT NULL DEFAULT '',
  `currabrev` char(3) NOT NULL DEFAULT '',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `price` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `startdate` date NOT NULL DEFAULT '0000-00-00',
  `enddate` date NOT NULL DEFAULT '9999-12-31',
  PRIMARY KEY (`stockid`,`typeabbrev`,`currabrev`,`debtorno`,`branchcode`,`startdate`,`enddate`),
  KEY `CurrAbrev` (`currabrev`),
  KEY `DebtorNo` (`debtorno`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`),
  CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `prices_ibfk_2` FOREIGN KEY (`currabrev`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `prices_ibfk_3` FOREIGN KEY (`typeabbrev`) REFERENCES `salestypes` (`typeabbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchdata`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchdata` (
  `supplierno` char(10) NOT NULL DEFAULT '',
  `stockid` char(20) NOT NULL DEFAULT '',
  `price` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `suppliersuom` char(50) NOT NULL DEFAULT '',
  `conversionfactor` double NOT NULL DEFAULT '1',
  `supplierdescription` char(50) NOT NULL DEFAULT '',
  `leadtime` smallint(6) NOT NULL DEFAULT '1',
  `preferred` tinyint(4) NOT NULL DEFAULT '0',
  `effectivefrom` date NOT NULL,
  `suppliers_partno` varchar(50) NOT NULL DEFAULT '',
  `minorderqty` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`supplierno`,`stockid`,`effectivefrom`),
  KEY `StockID` (`stockid`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Preferred` (`preferred`),
  CONSTRAINT `purchdata_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `purchdata_ibfk_2` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchorderauth`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchorderauth` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `currabrev` char(3) NOT NULL DEFAULT '',
  `cancreate` smallint(2) NOT NULL DEFAULT '0',
  `authlevel` int(11) NOT NULL DEFAULT '0',
  `offhold` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`,`currabrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchorderdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchorderdetails` (
  `podetailitem` int(11) NOT NULL AUTO_INCREMENT,
  `orderno` int(11) NOT NULL DEFAULT '0',
  `itemcode` varchar(20) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `itemdescription` varchar(100) NOT NULL DEFAULT '',
  `glcode` int(11) NOT NULL DEFAULT '0',
  `qtyinvoiced` double NOT NULL DEFAULT '0',
  `unitprice` double NOT NULL DEFAULT '0',
  `actprice` double NOT NULL DEFAULT '0',
  `stdcostunit` double NOT NULL DEFAULT '0',
  `quantityord` double NOT NULL DEFAULT '0',
  `quantityrecd` double NOT NULL DEFAULT '0',
  `shiptref` int(11) NOT NULL DEFAULT '0',
  `jobref` varchar(20) NOT NULL DEFAULT '',
  `completed` tinyint(4) NOT NULL DEFAULT '0',
  `suppliersunit` varchar(50) DEFAULT NULL,
  `suppliers_partno` varchar(50) NOT NULL DEFAULT '',
  `assetid` int(11) NOT NULL DEFAULT '0',
  `conversionfactor` double NOT NULL DEFAULT '1',
  PRIMARY KEY (`podetailitem`),
  KEY `DeliveryDate` (`deliverydate`),
  KEY `GLCode` (`glcode`),
  KEY `ItemCode` (`itemcode`),
  KEY `JobRef` (`jobref`),
  KEY `OrderNo` (`orderno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `Completed` (`completed`),
  CONSTRAINT `purchorderdetails_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `purchorders` (`orderno`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchorders` (
  `orderno` int(11) NOT NULL AUTO_INCREMENT,
  `supplierno` varchar(10) NOT NULL DEFAULT '',
  `comments` longblob,
  `orddate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rate` double NOT NULL DEFAULT '1',
  `dateprinted` datetime DEFAULT NULL,
  `allowprint` tinyint(4) NOT NULL DEFAULT '1',
  `initiator` varchar(10) DEFAULT NULL,
  `requisitionno` varchar(15) DEFAULT NULL,
  `intostocklocation` varchar(5) NOT NULL DEFAULT '',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) NOT NULL DEFAULT '',
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `tel` varchar(15) NOT NULL DEFAULT '',
  `suppdeladdress1` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress2` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress3` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress4` varchar(40) NOT NULL DEFAULT '',
  `suppdeladdress5` varchar(20) NOT NULL DEFAULT '',
  `suppdeladdress6` varchar(15) NOT NULL DEFAULT '',
  `suppliercontact` varchar(30) NOT NULL DEFAULT '',
  `supptel` varchar(30) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `version` decimal(3,2) NOT NULL DEFAULT '1.00',
  `revised` date NOT NULL DEFAULT '0000-00-00',
  `realorderno` varchar(16) NOT NULL DEFAULT '',
  `deliveryby` varchar(100) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `status` varchar(12) NOT NULL DEFAULT '',
  `stat_comment` text NOT NULL,
  `paymentterms` char(2) NOT NULL DEFAULT '',
  `port` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`orderno`),
  KEY `OrdDate` (`orddate`),
  KEY `SupplierNo` (`supplierno`),
  KEY `IntoStockLocation` (`intostocklocation`),
  KEY `AllowPrintPO` (`allowprint`),
  CONSTRAINT `purchorders_ibfk_1` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`),
  CONSTRAINT `purchorders_ibfk_2` FOREIGN KEY (`intostocklocation`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurringsalesorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurringsalesorders` (
  `recurrorderno` int(11) NOT NULL AUTO_INCREMENT,
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `customerref` varchar(50) NOT NULL DEFAULT '',
  `buyername` varchar(50) DEFAULT NULL,
  `comments` longblob,
  `orddate` date NOT NULL DEFAULT '0000-00-00',
  `ordertype` char(2) NOT NULL DEFAULT '',
  `shipvia` int(11) NOT NULL DEFAULT '0',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) DEFAULT NULL,
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `contactphone` varchar(25) DEFAULT NULL,
  `contactemail` varchar(25) DEFAULT NULL,
  `deliverto` varchar(40) NOT NULL DEFAULT '',
  `freightcost` double NOT NULL DEFAULT '0',
  `fromstkloc` varchar(5) NOT NULL DEFAULT '',
  `lastrecurrence` date NOT NULL DEFAULT '0000-00-00',
  `stopdate` date NOT NULL DEFAULT '0000-00-00',
  `frequency` tinyint(4) NOT NULL DEFAULT '1',
  `autoinvoice` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`recurrorderno`),
  KEY `debtorno` (`debtorno`),
  KEY `orddate` (`orddate`),
  KEY `ordertype` (`ordertype`),
  KEY `locationindex` (`fromstkloc`),
  KEY `branchcode` (`branchcode`,`debtorno`),
  CONSTRAINT `recurringsalesorders_ibfk_1` FOREIGN KEY (`branchcode`, `debtorno`) REFERENCES `custbranch` (`branchcode`, `debtorno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurrsalesorderdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recurrsalesorderdetails` (
  `recurrorderno` int(11) NOT NULL DEFAULT '0',
  `stkcode` varchar(20) NOT NULL DEFAULT '',
  `unitprice` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `discountpercent` double NOT NULL DEFAULT '0',
  `narrative` text NOT NULL,
  KEY `orderno` (`recurrorderno`),
  KEY `stkcode` (`stkcode`),
  CONSTRAINT `recurrsalesorderdetails_ibfk_1` FOREIGN KEY (`recurrorderno`) REFERENCES `recurringsalesorders` (`recurrorderno`),
  CONSTRAINT `recurrsalesorderdetails_ibfk_2` FOREIGN KEY (`stkcode`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportcolumns`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportcolumns` (
  `reportid` smallint(6) NOT NULL DEFAULT '0',
  `colno` smallint(6) NOT NULL DEFAULT '0',
  `heading1` varchar(15) NOT NULL DEFAULT '',
  `heading2` varchar(15) DEFAULT NULL,
  `calculation` tinyint(1) NOT NULL DEFAULT '0',
  `periodfrom` smallint(6) DEFAULT NULL,
  `periodto` smallint(6) DEFAULT NULL,
  `datatype` varchar(15) DEFAULT NULL,
  `colnumerator` tinyint(4) DEFAULT NULL,
  `coldenominator` tinyint(4) DEFAULT NULL,
  `calcoperator` char(1) DEFAULT NULL,
  `budgetoractual` tinyint(1) NOT NULL DEFAULT '0',
  `valformat` char(1) NOT NULL DEFAULT 'N',
  `constant` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`reportid`,`colno`),
  CONSTRAINT `reportcolumns_ibfk_1` FOREIGN KEY (`reportid`) REFERENCES `reportheaders` (`reportid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportfields`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportfields` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `reportid` int(5) NOT NULL DEFAULT '0',
  `entrytype` varchar(15) NOT NULL DEFAULT '',
  `seqnum` int(3) NOT NULL DEFAULT '0',
  `fieldname` varchar(80) NOT NULL DEFAULT '',
  `displaydesc` varchar(25) NOT NULL DEFAULT '',
  `visible` enum('1','0') NOT NULL DEFAULT '1',
  `columnbreak` enum('1','0') NOT NULL DEFAULT '1',
  `params` text,
  PRIMARY KEY (`id`),
  KEY `reportid` (`reportid`)
) ENGINE=MyISAM AUTO_INCREMENT=1805 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportheaders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportheaders` (
  `reportid` smallint(6) NOT NULL AUTO_INCREMENT,
  `reportheading` varchar(80) NOT NULL DEFAULT '',
  `groupbydata1` varchar(15) NOT NULL DEFAULT '',
  `newpageafter1` tinyint(1) NOT NULL DEFAULT '0',
  `lower1` varchar(10) NOT NULL DEFAULT '',
  `upper1` varchar(10) NOT NULL DEFAULT '',
  `groupbydata2` varchar(15) DEFAULT NULL,
  `newpageafter2` tinyint(1) NOT NULL DEFAULT '0',
  `lower2` varchar(10) DEFAULT NULL,
  `upper2` varchar(10) DEFAULT NULL,
  `groupbydata3` varchar(15) DEFAULT NULL,
  `newpageafter3` tinyint(1) NOT NULL DEFAULT '0',
  `lower3` varchar(10) DEFAULT NULL,
  `upper3` varchar(10) DEFAULT NULL,
  `groupbydata4` varchar(15) NOT NULL DEFAULT '',
  `newpageafter4` tinyint(1) NOT NULL DEFAULT '0',
  `upper4` varchar(10) NOT NULL DEFAULT '',
  `lower4` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`reportid`),
  KEY `ReportHeading` (`reportheading`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportlinks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportlinks` (
  `table1` varchar(25) NOT NULL DEFAULT '',
  `table2` varchar(25) NOT NULL DEFAULT '',
  `equation` varchar(75) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reports`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `reportname` varchar(30) NOT NULL DEFAULT '',
  `reporttype` char(3) NOT NULL DEFAULT 'rpt',
  `groupname` varchar(9) NOT NULL DEFAULT 'misc',
  `defaultreport` enum('1','0') NOT NULL DEFAULT '0',
  `papersize` varchar(15) NOT NULL DEFAULT 'A4,210,297',
  `paperorientation` enum('P','L') NOT NULL DEFAULT 'P',
  `margintop` int(3) NOT NULL DEFAULT '10',
  `marginbottom` int(3) NOT NULL DEFAULT '10',
  `marginleft` int(3) NOT NULL DEFAULT '10',
  `marginright` int(3) NOT NULL DEFAULT '10',
  `coynamefont` varchar(20) NOT NULL DEFAULT 'Helvetica',
  `coynamefontsize` int(3) NOT NULL DEFAULT '12',
  `coynamefontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `coynamealign` enum('L','C','R') NOT NULL DEFAULT 'C',
  `coynameshow` enum('1','0') NOT NULL DEFAULT '1',
  `title1desc` varchar(50) NOT NULL DEFAULT '%reportname%',
  `title1font` varchar(20) NOT NULL DEFAULT 'Helvetica',
  `title1fontsize` int(3) NOT NULL DEFAULT '10',
  `title1fontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `title1fontalign` enum('L','C','R') NOT NULL DEFAULT 'C',
  `title1show` enum('1','0') NOT NULL DEFAULT '1',
  `title2desc` varchar(50) NOT NULL DEFAULT 'Report Generated %date%',
  `title2font` varchar(20) NOT NULL DEFAULT 'Helvetica',
  `title2fontsize` int(3) NOT NULL DEFAULT '10',
  `title2fontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `title2fontalign` enum('L','C','R') NOT NULL DEFAULT 'C',
  `title2show` enum('1','0') NOT NULL DEFAULT '1',
  `filterfont` varchar(10) NOT NULL DEFAULT 'Helvetica',
  `filterfontsize` int(3) NOT NULL DEFAULT '8',
  `filterfontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `filterfontalign` enum('L','C','R') NOT NULL DEFAULT 'L',
  `datafont` varchar(10) NOT NULL DEFAULT 'Helvetica',
  `datafontsize` int(3) NOT NULL DEFAULT '10',
  `datafontcolor` varchar(10) NOT NULL DEFAULT 'black',
  `datafontalign` enum('L','C','R') NOT NULL DEFAULT 'L',
  `totalsfont` varchar(10) NOT NULL DEFAULT 'Helvetica',
  `totalsfontsize` int(3) NOT NULL DEFAULT '10',
  `totalsfontcolor` varchar(11) NOT NULL DEFAULT '0,0,0',
  `totalsfontalign` enum('L','C','R') NOT NULL DEFAULT 'L',
  `col1width` int(3) NOT NULL DEFAULT '25',
  `col2width` int(3) NOT NULL DEFAULT '25',
  `col3width` int(3) NOT NULL DEFAULT '25',
  `col4width` int(3) NOT NULL DEFAULT '25',
  `col5width` int(3) NOT NULL DEFAULT '25',
  `col6width` int(3) NOT NULL DEFAULT '25',
  `col7width` int(3) NOT NULL DEFAULT '25',
  `col8width` int(3) NOT NULL DEFAULT '25',
  `col9width` int(3) NOT NULL DEFAULT '25',
  `col10width` int(3) NOT NULL DEFAULT '25',
  `col11width` int(3) NOT NULL DEFAULT '25',
  `col12width` int(3) NOT NULL DEFAULT '25',
  `col13width` int(3) NOT NULL DEFAULT '25',
  `col14width` int(3) NOT NULL DEFAULT '25',
  `col15width` int(3) NOT NULL DEFAULT '25',
  `col16width` int(3) NOT NULL DEFAULT '25',
  `col17width` int(3) NOT NULL DEFAULT '25',
  `col18width` int(3) NOT NULL DEFAULT '25',
  `col19width` int(3) NOT NULL DEFAULT '25',
  `col20width` int(3) NOT NULL DEFAULT '25',
  `table1` varchar(25) NOT NULL DEFAULT '',
  `table2` varchar(25) DEFAULT NULL,
  `table2criteria` varchar(75) DEFAULT NULL,
  `table3` varchar(25) DEFAULT NULL,
  `table3criteria` varchar(75) DEFAULT NULL,
  `table4` varchar(25) DEFAULT NULL,
  `table4criteria` varchar(75) DEFAULT NULL,
  `table5` varchar(25) DEFAULT NULL,
  `table5criteria` varchar(75) DEFAULT NULL,
  `table6` varchar(25) DEFAULT NULL,
  `table6criteria` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`reportname`,`groupname`)
) ENGINE=MyISAM AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesanalysis`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesanalysis` (
  `typeabbrev` char(2) NOT NULL DEFAULT '',
  `periodno` smallint(6) NOT NULL DEFAULT '0',
  `amt` double NOT NULL DEFAULT '0',
  `cost` double NOT NULL DEFAULT '0',
  `cust` varchar(10) NOT NULL DEFAULT '',
  `custbranch` varchar(10) NOT NULL DEFAULT '',
  `qty` double NOT NULL DEFAULT '0',
  `disc` double NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `area` varchar(3) NOT NULL,
  `budgetoractual` tinyint(1) NOT NULL DEFAULT '0',
  `salesperson` char(3) NOT NULL DEFAULT '',
  `stkcategory` varchar(6) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `CustBranch` (`custbranch`),
  KEY `Cust` (`cust`),
  KEY `PeriodNo` (`periodno`),
  KEY `StkCategory` (`stkcategory`),
  KEY `StockID` (`stockid`),
  KEY `TypeAbbrev` (`typeabbrev`),
  KEY `Area` (`area`),
  KEY `BudgetOrActual` (`budgetoractual`),
  KEY `Salesperson` (`salesperson`),
  CONSTRAINT `salesanalysis_ibfk_1` FOREIGN KEY (`periodno`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salescat`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salescat` (
  `salescatid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `parentcatid` tinyint(4) DEFAULT NULL,
  `salescatname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`salescatid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salescatprod`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salescatprod` (
  `salescatid` tinyint(4) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`salescatid`,`stockid`),
  KEY `salescatid` (`salescatid`),
  KEY `stockid` (`stockid`),
  CONSTRAINT `salescatprod_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `salescatprod_ibfk_2` FOREIGN KEY (`salescatid`) REFERENCES `salescat` (`salescatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesglpostings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesglpostings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `area` varchar(3) NOT NULL,
  `stkcat` varchar(6) NOT NULL DEFAULT '',
  `discountglcode` int(11) NOT NULL DEFAULT '0',
  `salesglcode` int(11) NOT NULL DEFAULT '0',
  `salestype` char(2) NOT NULL DEFAULT 'AN',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Area_StkCat` (`area`,`stkcat`,`salestype`),
  KEY `Area` (`area`),
  KEY `StkCat` (`stkcat`),
  KEY `SalesType` (`salestype`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesman`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesman` (
  `salesmancode` char(3) NOT NULL DEFAULT '',
  `salesmanname` char(30) NOT NULL DEFAULT '',
  `smantel` char(20) NOT NULL DEFAULT '',
  `smanfax` char(20) NOT NULL DEFAULT '',
  `commissionrate1` double NOT NULL DEFAULT '0',
  `breakpoint` decimal(10,0) NOT NULL DEFAULT '0',
  `commissionrate2` double NOT NULL DEFAULT '0',
  `current` tinyint(4) NOT NULL COMMENT 'Salesman current (1) or not (0)',
  PRIMARY KEY (`salesmancode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesorderdetails`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesorderdetails` (
  `orderlineno` int(11) NOT NULL DEFAULT '0',
  `orderno` int(11) NOT NULL DEFAULT '0',
  `stkcode` varchar(20) NOT NULL DEFAULT '',
  `qtyinvoiced` double NOT NULL DEFAULT '0',
  `unitprice` double NOT NULL DEFAULT '0',
  `quantity` double NOT NULL DEFAULT '0',
  `estimate` tinyint(4) NOT NULL DEFAULT '0',
  `discountpercent` double NOT NULL DEFAULT '0',
  `actualdispatchdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `completed` tinyint(1) NOT NULL DEFAULT '0',
  `narrative` text,
  `itemdue` date DEFAULT NULL COMMENT 'Due date for line item.  Some customers require \r\nacknowledgements with due dates by line item',
  `poline` varchar(10) DEFAULT NULL COMMENT 'Some Customers require acknowledgements with a PO line number for each sales line',
  `commissionrate` double NOT NULL DEFAULT '0',
  `commissionearned` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`orderlineno`,`orderno`),
  KEY `OrderNo` (`orderno`),
  KEY `StkCode` (`stkcode`),
  KEY `Completed` (`completed`),
  CONSTRAINT `salesorderdetails_ibfk_1` FOREIGN KEY (`orderno`) REFERENCES `salesorders` (`orderno`),
  CONSTRAINT `salesorderdetails_ibfk_2` FOREIGN KEY (`stkcode`) REFERENCES `stockmaster` (`stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salesorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesorders` (
  `orderno` int(11) NOT NULL,
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `customerref` varchar(50) NOT NULL DEFAULT '',
  `buyername` varchar(50) DEFAULT NULL,
  `comments` longblob,
  `orddate` date NOT NULL DEFAULT '0000-00-00',
  `ordertype` char(2) NOT NULL DEFAULT '',
  `shipvia` int(11) NOT NULL DEFAULT '0',
  `deladd1` varchar(40) NOT NULL DEFAULT '',
  `deladd2` varchar(40) NOT NULL DEFAULT '',
  `deladd3` varchar(40) NOT NULL DEFAULT '',
  `deladd4` varchar(40) DEFAULT NULL,
  `deladd5` varchar(20) NOT NULL DEFAULT '',
  `deladd6` varchar(15) NOT NULL DEFAULT '',
  `contactphone` varchar(25) DEFAULT NULL,
  `contactemail` varchar(40) DEFAULT NULL,
  `deliverto` varchar(40) NOT NULL DEFAULT '',
  `deliverblind` tinyint(1) DEFAULT '1',
  `freightcost` double NOT NULL DEFAULT '0',
  `fromstkloc` varchar(5) NOT NULL DEFAULT '',
  `deliverydate` date NOT NULL DEFAULT '0000-00-00',
  `confirmeddate` date NOT NULL DEFAULT '0000-00-00',
  `printedpackingslip` tinyint(4) NOT NULL DEFAULT '0',
  `datepackingslipprinted` date NOT NULL DEFAULT '0000-00-00',
  `quotation` tinyint(4) NOT NULL DEFAULT '0',
  `quotedate` date NOT NULL DEFAULT '0000-00-00',
  `poplaced` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`orderno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `OrdDate` (`orddate`),
  KEY `OrderType` (`ordertype`),
  KEY `LocationIndex` (`fromstkloc`),
  KEY `BranchCode` (`branchcode`,`debtorno`),
  KEY `ShipVia` (`shipvia`),
  KEY `quotation` (`quotation`),
  KEY `poplaced` (`poplaced`),
  CONSTRAINT `salesorders_ibfk_1` FOREIGN KEY (`branchcode`, `debtorno`) REFERENCES `custbranch` (`branchcode`, `debtorno`),
  CONSTRAINT `salesorders_ibfk_2` FOREIGN KEY (`shipvia`) REFERENCES `shippers` (`shipper_id`),
  CONSTRAINT `salesorders_ibfk_3` FOREIGN KEY (`fromstkloc`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `salestypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salestypes` (
  `typeabbrev` char(2) NOT NULL DEFAULT '',
  `sales_type` varchar(40) NOT NULL DEFAULT '',
  PRIMARY KEY (`typeabbrev`),
  KEY `Sales_Type` (`sales_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scripts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `script` varchar(78) NOT NULL DEFAULT '',
  `pagesecurity` int(11) NOT NULL DEFAULT '1',
  `description` text NOT NULL,
  PRIMARY KEY (`script`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `securitygroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroups` (
  `secroleid` int(11) NOT NULL DEFAULT '0',
  `tokenid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`secroleid`,`tokenid`),
  KEY `secroleid` (`secroleid`),
  KEY `tokenid` (`tokenid`),
  CONSTRAINT `securitygroups_secroleid_fk` FOREIGN KEY (`secroleid`) REFERENCES `securityroles` (`secroleid`),
  CONSTRAINT `securitygroups_tokenid_fk` FOREIGN KEY (`tokenid`) REFERENCES `securitytokens` (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `securityroles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securityroles` (
  `secroleid` int(11) NOT NULL AUTO_INCREMENT,
  `secrolename` text NOT NULL,
  PRIMARY KEY (`secroleid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `securitytokens`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitytokens` (
  `tokenid` int(11) NOT NULL DEFAULT '0',
  `tokenname` text NOT NULL,
  PRIMARY KEY (`tokenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipmentcharges`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipmentcharges` (
  `shiptchgid` int(11) NOT NULL AUTO_INCREMENT,
  `shiptref` int(11) NOT NULL DEFAULT '0',
  `transtype` smallint(6) NOT NULL DEFAULT '0',
  `transno` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `value` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`shiptchgid`),
  KEY `TransType` (`transtype`,`transno`),
  KEY `ShiptRef` (`shiptref`),
  KEY `StockID` (`stockid`),
  KEY `TransType_2` (`transtype`),
  CONSTRAINT `shipmentcharges_ibfk_1` FOREIGN KEY (`shiptref`) REFERENCES `shipments` (`shiptref`),
  CONSTRAINT `shipmentcharges_ibfk_2` FOREIGN KEY (`transtype`) REFERENCES `systypes` (`typeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipments` (
  `shiptref` int(11) NOT NULL DEFAULT '0',
  `voyageref` varchar(20) NOT NULL DEFAULT '0',
  `vessel` varchar(50) NOT NULL DEFAULT '',
  `eta` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `accumvalue` double NOT NULL DEFAULT '0',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shiptref`),
  KEY `ETA` (`eta`),
  KEY `SupplierID` (`supplierid`),
  KEY `ShipperRef` (`voyageref`),
  KEY `Vessel` (`vessel`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shippers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shippers` (
  `shipper_id` int(11) NOT NULL AUTO_INCREMENT,
  `shippername` char(40) NOT NULL DEFAULT '',
  `mincharge` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcategory`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcategory` (
  `categoryid` char(6) NOT NULL DEFAULT '',
  `categorydescription` char(20) NOT NULL DEFAULT '',
  `stocktype` char(1) NOT NULL DEFAULT 'F',
  `stockact` int(11) NOT NULL DEFAULT '0',
  `adjglact` int(11) NOT NULL DEFAULT '0',
  `purchpricevaract` int(11) NOT NULL DEFAULT '80000',
  `materialuseagevarac` int(11) NOT NULL DEFAULT '80000',
  `wipact` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`categoryid`),
  KEY `CategoryDescription` (`categorydescription`),
  KEY `StockType` (`stocktype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcatproperties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcatproperties` (
  `stkcatpropid` int(11) NOT NULL AUTO_INCREMENT,
  `categoryid` char(6) NOT NULL,
  `label` text NOT NULL,
  `controltype` tinyint(4) NOT NULL DEFAULT '0',
  `defaultvalue` varchar(100) NOT NULL DEFAULT '''''',
  `maximumvalue` double NOT NULL DEFAULT '999999999',
  `reqatsalesorder` tinyint(4) NOT NULL DEFAULT '0',
  `minimumvalue` double NOT NULL DEFAULT '-999999999',
  `numericvalue` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stkcatpropid`),
  KEY `categoryid` (`categoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcheckfreeze`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcheckfreeze` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `qoh` double NOT NULL DEFAULT '0',
  `stockcheckdate` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`stockid`,`loccode`),
  KEY `LocCode` (`loccode`),
  CONSTRAINT `stockcheckfreeze_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockcheckfreeze_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockcounts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockcounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `qtycounted` double NOT NULL DEFAULT '0',
  `reference` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`),
  CONSTRAINT `stockcounts_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockcounts_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockitemproperties`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockitemproperties` (
  `stockid` varchar(20) NOT NULL,
  `stkcatpropid` int(11) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`stockid`,`stkcatpropid`),
  KEY `stockid` (`stockid`),
  KEY `value` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockmaster`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockmaster` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `categoryid` varchar(6) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `longdescription` text NOT NULL,
  `units` varchar(20) NOT NULL DEFAULT 'each',
  `mbflag` char(1) NOT NULL DEFAULT 'B',
  `actualcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `lastcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `materialcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `labourcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `overheadcost` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `lowestlevel` smallint(6) NOT NULL DEFAULT '0',
  `discontinued` tinyint(4) NOT NULL DEFAULT '0',
  `controlled` tinyint(4) NOT NULL DEFAULT '0',
  `eoq` double NOT NULL DEFAULT '0',
  `volume` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `kgs` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `barcode` varchar(50) NOT NULL DEFAULT '',
  `discountcategory` char(2) NOT NULL DEFAULT '',
  `taxcatid` tinyint(4) NOT NULL DEFAULT '1',
  `serialised` tinyint(4) NOT NULL DEFAULT '0',
  `appendfile` varchar(40) NOT NULL DEFAULT 'none',
  `perishable` tinyint(1) NOT NULL DEFAULT '0',
  `decimalplaces` tinyint(4) NOT NULL DEFAULT '0',
  `pansize` double NOT NULL DEFAULT '0',
  `shrinkfactor` double NOT NULL DEFAULT '0',
  `nextserialno` bigint(20) NOT NULL DEFAULT '0',
  `netweight` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `lastcostupdate` date NOT NULL,
  PRIMARY KEY (`stockid`),
  KEY `CategoryID` (`categoryid`),
  KEY `Description` (`description`),
  KEY `MBflag` (`mbflag`),
  KEY `StockID` (`stockid`,`categoryid`),
  KEY `Controlled` (`controlled`),
  KEY `DiscountCategory` (`discountcategory`),
  KEY `taxcatid` (`taxcatid`),
  CONSTRAINT `stockmaster_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `stockcategory` (`categoryid`),
  CONSTRAINT `stockmaster_ibfk_2` FOREIGN KEY (`taxcatid`) REFERENCES `taxcategories` (`taxcatid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockmoves`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockmoves` (
  `stkmoveno` int(11) NOT NULL AUTO_INCREMENT,
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `transno` int(11) NOT NULL DEFAULT '0',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `trandate` date NOT NULL DEFAULT '0000-00-00',
  `debtorno` varchar(10) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `price` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `prd` smallint(6) NOT NULL DEFAULT '0',
  `reference` varchar(40) NOT NULL DEFAULT '',
  `qty` double NOT NULL DEFAULT '1',
  `discountpercent` double NOT NULL DEFAULT '0',
  `standardcost` double NOT NULL DEFAULT '0',
  `show_on_inv_crds` tinyint(4) NOT NULL DEFAULT '1',
  `newqoh` double NOT NULL DEFAULT '0',
  `hidemovt` tinyint(4) NOT NULL DEFAULT '0',
  `narrative` text,
  PRIMARY KEY (`stkmoveno`),
  KEY `DebtorNo` (`debtorno`),
  KEY `LocCode` (`loccode`),
  KEY `Prd` (`prd`),
  KEY `StockID_2` (`stockid`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`),
  KEY `Show_On_Inv_Crds` (`show_on_inv_crds`),
  KEY `Hide` (`hidemovt`),
  KEY `reference` (`reference`),
  CONSTRAINT `stockmoves_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockmoves_ibfk_2` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `stockmoves_ibfk_3` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`),
  CONSTRAINT `stockmoves_ibfk_4` FOREIGN KEY (`prd`) REFERENCES `periods` (`periodno`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockmovestaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockmovestaxes` (
  `stkmoveno` int(11) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `taxrate` double NOT NULL DEFAULT '0',
  `taxontax` tinyint(4) NOT NULL DEFAULT '0',
  `taxcalculationorder` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stkmoveno`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  KEY `calculationorder` (`taxcalculationorder`),
  CONSTRAINT `stockmovestaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockserialitems`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockserialitems` (
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `loccode` varchar(5) NOT NULL DEFAULT '',
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `expirationdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `quantity` double NOT NULL DEFAULT '0',
  `qualitytext` text NOT NULL,
  PRIMARY KEY (`stockid`,`serialno`,`loccode`),
  KEY `StockID` (`stockid`),
  KEY `LocCode` (`loccode`),
  KEY `serialno` (`serialno`),
  CONSTRAINT `stockserialitems_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `stockserialitems_ibfk_2` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stockserialmoves`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockserialmoves` (
  `stkitmmoveno` int(11) NOT NULL AUTO_INCREMENT,
  `stockmoveno` int(11) NOT NULL DEFAULT '0',
  `stockid` varchar(20) NOT NULL DEFAULT '',
  `serialno` varchar(30) NOT NULL DEFAULT '',
  `moveqty` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`stkitmmoveno`),
  KEY `StockMoveNo` (`stockmoveno`),
  KEY `StockID_SN` (`stockid`,`serialno`),
  KEY `serialno` (`serialno`),
  CONSTRAINT `stockserialmoves_ibfk_1` FOREIGN KEY (`stockmoveno`) REFERENCES `stockmoves` (`stkmoveno`),
  CONSTRAINT `stockserialmoves_ibfk_2` FOREIGN KEY (`stockid`, `serialno`) REFERENCES `stockserialitems` (`stockid`, `serialno`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppallocs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppallocs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amt` double NOT NULL DEFAULT '0',
  `datealloc` date NOT NULL DEFAULT '0000-00-00',
  `transid_allocfrom` int(11) NOT NULL DEFAULT '0',
  `transid_allocto` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `TransID_AllocFrom` (`transid_allocfrom`),
  KEY `TransID_AllocTo` (`transid_allocto`),
  KEY `DateAlloc` (`datealloc`),
  CONSTRAINT `suppallocs_ibfk_1` FOREIGN KEY (`transid_allocfrom`) REFERENCES `supptrans` (`id`),
  CONSTRAINT `suppallocs_ibfk_2` FOREIGN KEY (`transid_allocto`) REFERENCES `supptrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliercontacts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliercontacts` (
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `contact` varchar(30) NOT NULL DEFAULT '',
  `position` varchar(30) NOT NULL DEFAULT '',
  `tel` varchar(30) NOT NULL DEFAULT '',
  `fax` varchar(30) NOT NULL DEFAULT '',
  `mobile` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) NOT NULL DEFAULT '',
  `ordercontact` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`supplierid`,`contact`),
  KEY `Contact` (`contact`),
  KEY `SupplierID` (`supplierid`),
  CONSTRAINT `suppliercontacts_ibfk_1` FOREIGN KEY (`supplierid`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `suppname` varchar(40) NOT NULL DEFAULT '',
  `address1` varchar(40) NOT NULL DEFAULT '',
  `address2` varchar(40) NOT NULL DEFAULT '',
  `address3` varchar(40) NOT NULL DEFAULT '',
  `address4` varchar(50) NOT NULL DEFAULT '',
  `address5` varchar(20) NOT NULL DEFAULT '',
  `address6` varchar(15) NOT NULL DEFAULT '',
  `supptype` tinyint(4) NOT NULL DEFAULT '1',
  `lat` float(10,6) NOT NULL DEFAULT '0.000000',
  `lng` float(10,6) NOT NULL DEFAULT '0.000000',
  `currcode` char(3) NOT NULL DEFAULT '',
  `suppliersince` date NOT NULL DEFAULT '0000-00-00',
  `paymentterms` char(2) NOT NULL DEFAULT '',
  `lastpaid` double NOT NULL DEFAULT '0',
  `lastpaiddate` datetime DEFAULT NULL,
  `bankact` varchar(30) NOT NULL DEFAULT '',
  `bankref` varchar(12) NOT NULL DEFAULT '',
  `bankpartics` varchar(12) NOT NULL DEFAULT '',
  `remittance` tinyint(4) NOT NULL DEFAULT '1',
  `taxgroupid` tinyint(4) NOT NULL DEFAULT '1',
  `factorcompanyid` int(11) NOT NULL DEFAULT '1',
  `taxref` varchar(20) NOT NULL DEFAULT '',
  `phn` varchar(50) NOT NULL DEFAULT '',
  `port` varchar(200) NOT NULL DEFAULT '',
  `email` varchar(55) DEFAULT NULL,
  `fax` varchar(25) DEFAULT NULL,
  `telephone` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`supplierid`),
  KEY `CurrCode` (`currcode`),
  KEY `PaymentTerms` (`paymentterms`),
  KEY `SuppName` (`suppname`),
  KEY `taxgroupid` (`taxgroupid`),
  CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`currcode`) REFERENCES `currencies` (`currabrev`),
  CONSTRAINT `suppliers_ibfk_2` FOREIGN KEY (`paymentterms`) REFERENCES `paymentterms` (`termsindicator`),
  CONSTRAINT `suppliers_ibfk_3` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliertype`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliertype` (
  `typeid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `typename` varchar(100) NOT NULL,
  PRIMARY KEY (`typeid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supptrans`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supptrans` (
  `transno` int(11) NOT NULL DEFAULT '0',
  `type` smallint(6) NOT NULL DEFAULT '0',
  `supplierno` varchar(10) NOT NULL DEFAULT '',
  `suppreference` varchar(20) NOT NULL DEFAULT '',
  `trandate` date NOT NULL DEFAULT '0000-00-00',
  `duedate` date NOT NULL DEFAULT '0000-00-00',
  `inputdate` datetime NOT NULL,
  `settled` tinyint(4) NOT NULL DEFAULT '0',
  `rate` double NOT NULL DEFAULT '1',
  `ovamount` double NOT NULL DEFAULT '0',
  `ovgst` double NOT NULL DEFAULT '0',
  `diffonexch` double NOT NULL DEFAULT '0',
  `alloc` double NOT NULL DEFAULT '0',
  `transtext` text,
  `hold` tinyint(4) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `TypeTransNo` (`transno`,`type`),
  KEY `DueDate` (`duedate`),
  KEY `Hold` (`hold`),
  KEY `SupplierNo` (`supplierno`),
  KEY `Settled` (`settled`),
  KEY `SupplierNo_2` (`supplierno`,`suppreference`),
  KEY `SuppReference` (`suppreference`),
  KEY `TranDate` (`trandate`),
  KEY `TransNo` (`transno`),
  KEY `Type` (`type`),
  CONSTRAINT `supptrans_ibfk_1` FOREIGN KEY (`type`) REFERENCES `systypes` (`typeid`),
  CONSTRAINT `supptrans_ibfk_2` FOREIGN KEY (`supplierno`) REFERENCES `suppliers` (`supplierid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supptranstaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supptranstaxes` (
  `supptransid` int(11) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `taxamount` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`supptransid`,`taxauthid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `supptranstaxes_ibfk_1` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `supptranstaxes_ibfk_2` FOREIGN KEY (`supptransid`) REFERENCES `supptrans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systypes` (
  `typeid` smallint(6) NOT NULL DEFAULT '0',
  `typename` char(50) NOT NULL DEFAULT '',
  `typeno` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`typeid`),
  KEY `TypeNo` (`typeno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `tagref` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tagdescription` varchar(50) NOT NULL,
  PRIMARY KEY (`tagref`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxauthorities`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxauthorities` (
  `taxid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `description` varchar(20) NOT NULL DEFAULT '',
  `taxglcode` int(11) NOT NULL DEFAULT '0',
  `purchtaxglaccount` int(11) NOT NULL DEFAULT '0',
  `bank` varchar(50) NOT NULL DEFAULT '',
  `bankacctype` varchar(20) NOT NULL DEFAULT '',
  `bankacc` varchar(50) NOT NULL DEFAULT '',
  `bankswift` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxid`),
  KEY `TaxGLCode` (`taxglcode`),
  KEY `PurchTaxGLAccount` (`purchtaxglaccount`),
  CONSTRAINT `taxauthorities_ibfk_1` FOREIGN KEY (`taxglcode`) REFERENCES `chartmaster` (`accountcode`),
  CONSTRAINT `taxauthorities_ibfk_2` FOREIGN KEY (`purchtaxglaccount`) REFERENCES `chartmaster` (`accountcode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxauthrates`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxauthrates` (
  `taxauthority` tinyint(4) NOT NULL DEFAULT '1',
  `dispatchtaxprovince` tinyint(4) NOT NULL DEFAULT '1',
  `taxcatid` tinyint(4) NOT NULL DEFAULT '0',
  `taxrate` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`taxauthority`,`dispatchtaxprovince`,`taxcatid`),
  KEY `TaxAuthority` (`taxauthority`),
  KEY `dispatchtaxprovince` (`dispatchtaxprovince`),
  KEY `taxcatid` (`taxcatid`),
  CONSTRAINT `taxauthrates_ibfk_1` FOREIGN KEY (`taxauthority`) REFERENCES `taxauthorities` (`taxid`),
  CONSTRAINT `taxauthrates_ibfk_2` FOREIGN KEY (`taxcatid`) REFERENCES `taxcategories` (`taxcatid`),
  CONSTRAINT `taxauthrates_ibfk_3` FOREIGN KEY (`dispatchtaxprovince`) REFERENCES `taxprovinces` (`taxprovinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxcategories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxcategories` (
  `taxcatid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `taxcatname` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxcatid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxgroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxgroups` (
  `taxgroupid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `taxgroupdescription` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxgroupid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxgrouptaxes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxgrouptaxes` (
  `taxgroupid` tinyint(4) NOT NULL DEFAULT '0',
  `taxauthid` tinyint(4) NOT NULL DEFAULT '0',
  `calculationorder` tinyint(4) NOT NULL DEFAULT '0',
  `taxontax` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`taxgroupid`,`taxauthid`),
  KEY `taxgroupid` (`taxgroupid`),
  KEY `taxauthid` (`taxauthid`),
  CONSTRAINT `taxgrouptaxes_ibfk_1` FOREIGN KEY (`taxgroupid`) REFERENCES `taxgroups` (`taxgroupid`),
  CONSTRAINT `taxgrouptaxes_ibfk_2` FOREIGN KEY (`taxauthid`) REFERENCES `taxauthorities` (`taxid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taxprovinces`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxprovinces` (
  `taxprovinceid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `taxprovincename` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`taxprovinceid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unitsofmeasure`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitsofmeasure` (
  `unitid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `unitname` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`unitid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `woitems`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `woitems` (
  `wo` int(11) NOT NULL,
  `stockid` char(20) NOT NULL DEFAULT '',
  `qtyreqd` double NOT NULL DEFAULT '1',
  `qtyrecd` double NOT NULL DEFAULT '0',
  `stdcost` double NOT NULL,
  `nextlotsnref` varchar(20) DEFAULT '',
  PRIMARY KEY (`wo`,`stockid`),
  KEY `stockid` (`stockid`),
  CONSTRAINT `woitems_ibfk_1` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `woitems_ibfk_2` FOREIGN KEY (`wo`) REFERENCES `workorders` (`wo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worequirements`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `worequirements` (
  `wo` int(11) NOT NULL,
  `parentstockid` varchar(20) NOT NULL,
  `stockid` varchar(20) NOT NULL,
  `qtypu` double NOT NULL DEFAULT '1',
  `stdcost` double NOT NULL DEFAULT '0',
  `autoissue` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`wo`,`parentstockid`,`stockid`),
  KEY `stockid` (`stockid`),
  KEY `worequirements_ibfk_3` (`parentstockid`),
  CONSTRAINT `worequirements_ibfk_1` FOREIGN KEY (`wo`) REFERENCES `workorders` (`wo`),
  CONSTRAINT `worequirements_ibfk_2` FOREIGN KEY (`stockid`) REFERENCES `stockmaster` (`stockid`),
  CONSTRAINT `worequirements_ibfk_3` FOREIGN KEY (`wo`, `parentstockid`) REFERENCES `woitems` (`wo`, `stockid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workcentres`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workcentres` (
  `code` char(5) NOT NULL DEFAULT '',
  `location` char(5) NOT NULL DEFAULT '',
  `description` char(20) NOT NULL DEFAULT '',
  `capacity` double NOT NULL DEFAULT '1',
  `overheadperhour` decimal(10,0) NOT NULL DEFAULT '0',
  `overheadrecoveryact` int(11) NOT NULL DEFAULT '0',
  `setuphrs` decimal(10,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`code`),
  KEY `Description` (`description`),
  KEY `Location` (`location`),
  CONSTRAINT `workcentres_ibfk_1` FOREIGN KEY (`location`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `workorders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workorders` (
  `wo` int(11) NOT NULL,
  `loccode` char(5) NOT NULL DEFAULT '',
  `requiredby` date NOT NULL DEFAULT '0000-00-00',
  `startdate` date NOT NULL DEFAULT '0000-00-00',
  `costissued` double NOT NULL DEFAULT '0',
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`wo`),
  KEY `LocCode` (`loccode`),
  KEY `StartDate` (`startdate`),
  KEY `RequiredBy` (`requiredby`),
  CONSTRAINT `worksorders_ibfk_1` FOREIGN KEY (`loccode`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `woserialnos`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `woserialnos` (
  `wo` int(11) NOT NULL,
  `stockid` varchar(20) NOT NULL,
  `serialno` varchar(30) NOT NULL,
  `quantity` double NOT NULL DEFAULT '1',
  `qualitytext` text NOT NULL,
  PRIMARY KEY (`wo`,`stockid`,`serialno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `www_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `www_users` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `password` text NOT NULL,
  `realname` varchar(35) NOT NULL DEFAULT '',
  `customerid` varchar(10) NOT NULL DEFAULT '',
  `supplierid` varchar(10) NOT NULL DEFAULT '',
  `salesman` char(3) NOT NULL,
  `phone` varchar(30) NOT NULL DEFAULT '',
  `email` varchar(55) DEFAULT NULL,
  `defaultlocation` varchar(5) NOT NULL DEFAULT '',
  `fullaccess` int(11) NOT NULL DEFAULT '1',
  `lastvisitdate` datetime DEFAULT NULL,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `pagesize` varchar(20) NOT NULL DEFAULT 'A4',
  `modulesallowed` varchar(40) NOT NULL DEFAULT '',
  `blocked` tinyint(4) NOT NULL DEFAULT '0',
  `displayrecordsmax` int(11) NOT NULL DEFAULT '0',
  `theme` varchar(30) NOT NULL DEFAULT 'fresh',
  `language` varchar(10) NOT NULL DEFAULT 'en_GB.utf8',
  `pdflanguage` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`),
  KEY `CustomerID` (`customerid`),
  KEY `DefaultLocation` (`defaultlocation`),
  CONSTRAINT `www_users_ibfk_1` FOREIGN KEY (`defaultlocation`) REFERENCES `locations` (`loccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-11-06 19:52:31
-- MySQL dump 10.13  Distrib 5.1.47-MariaDB, for pc-linux-gnu (i686)
--
-- Host: localhost    Database: weberpdemo
-- ------------------------------------------------------
-- Server version	5.1.47-MariaDB
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `accountgroups`
--

INSERT INTO `accountgroups` VALUES ('BBQs',5,1,6000,'Promotions');
INSERT INTO `accountgroups` VALUES ('Cost of Goods Sold',2,1,5000,'');
INSERT INTO `accountgroups` VALUES ('Current Assets',20,0,1000,'');
INSERT INTO `accountgroups` VALUES ('Equity',50,0,3000,'');
INSERT INTO `accountgroups` VALUES ('Fixed Assets',10,0,500,'');
INSERT INTO `accountgroups` VALUES ('Giveaways',5,1,6000,'Promotions');
INSERT INTO `accountgroups` VALUES ('Income Tax',5,1,9000,'');
INSERT INTO `accountgroups` VALUES ('Liabilities',30,0,2000,'');
INSERT INTO `accountgroups` VALUES ('Marketing Expenses',5,1,6000,'');
INSERT INTO `accountgroups` VALUES ('Operating Expenses',5,1,7000,'');
INSERT INTO `accountgroups` VALUES ('Other Revenue and Expenses',5,1,8000,'');
INSERT INTO `accountgroups` VALUES ('Outward Freight',2,1,5000,'Cost of Goods Sold');
INSERT INTO `accountgroups` VALUES ('Promotions',5,1,6000,'Marketing Expenses');
INSERT INTO `accountgroups` VALUES ('Revenue',1,1,4000,'');
INSERT INTO `accountgroups` VALUES ('Sales',1,1,10,'');

--
-- Dumping data for table `accountsection`
--

INSERT INTO `accountsection` VALUES (1,'Income');
INSERT INTO `accountsection` VALUES (2,'Cost Of Sales');
INSERT INTO `accountsection` VALUES (5,'Overheads');
INSERT INTO `accountsection` VALUES (10,'Fixed Assets');
INSERT INTO `accountsection` VALUES (20,'Amounts Receivable');
INSERT INTO `accountsection` VALUES (30,'Amounts Payable');
INSERT INTO `accountsection` VALUES (50,'Financed By');

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` VALUES ('DE','Default');
INSERT INTO `areas` VALUES ('FL','Florida');
INSERT INTO `areas` VALUES ('TR','Toronto');

--
-- Dumping data for table `assetmanager`
--


--
-- Dumping data for table `audittrail`
--


--
-- Dumping data for table `bankaccounts`
--

INSERT INTO `bankaccounts` VALUES (1030,'AUD',1,'12445','Cheque Account','124455667789','123 Straight Street');
INSERT INTO `bankaccounts` VALUES (1040,'AUD',0,'','Savings Account','','');
INSERT INTO `bankaccounts` VALUES (1060,'EUR',0,'','Risaerts Account','0679893946','');

--
-- Dumping data for table `banktrans`
--

INSERT INTO `banktrans` VALUES (1,12,1,1030,'',0,1,1,'2007-10-23','Cheque',150,'AUD');
INSERT INTO `banktrans` VALUES (2,1,2,1030,'',-500,1,1,'2008-07-26','Cheque',-500,'AUD');
INSERT INTO `banktrans` VALUES (3,12,2,1030,'',0,1,1,'2009-02-04','Cash',99,'USD');
INSERT INTO `banktrans` VALUES (4,12,3,1030,'',0,1,1,'2009-02-04','Cash',299,'AUD');
INSERT INTO `banktrans` VALUES (5,12,5,1040,'Melbourne Counter Sale 10',0,1,1,'2010-05-31','2',10.5,'USD');
INSERT INTO `banktrans` VALUES (8,12,8,1030,'Melbourne Counter Sale 13',0,0.85,1,'2010-05-31','2',5.8823529411765,'USD');
INSERT INTO `banktrans` VALUES (9,12,9,1030,'Melbourne Counter Sale 14',0,0.85,1,'2010-05-31','1',138.23529411765,'USD');
INSERT INTO `banktrans` VALUES (10,12,10,1030,'',0,0.85,1,'2011-03-23','Cheque',10,'USD');
INSERT INTO `banktrans` VALUES (11,12,11,1030,'test',0,1,1,'2011-05-26','Cash',34,'AUD');
INSERT INTO `banktrans` VALUES (12,1,3,1060,'4812559 A. Elderman\r\nDEEL 2 FACTUUR DOC3649\r\n',-740,1,0.523,'2011-07-18','Imported',-740,'EUR');
INSERT INTO `banktrans` VALUES (13,1,4,1060,'9971294 SCARVA PRODUCTIONS B.V.\r\nDOC3617 2E HELFT\r',-1660.05,1,0.523,'2011-07-19','Imported',-1660.05,'EUR');
INSERT INTO `banktrans` VALUES (14,2,1,1060,'6244024 Dura\r\n2011.02\r\n',4725.1,1,0.523,'2011-07-19','Imported',4725.1,'EUR');
INSERT INTO `banktrans` VALUES (15,2,2,1060,'9354603 Proserve\r\n1023351\r\n',98.97,1,0.523,'2011-07-19','Imported',98.97,'EUR');
INSERT INTO `banktrans` VALUES (16,12,12,1060,'9354603 Proserve\r\n1023659\r\n',98.97,1,0.521,'2011-07-19','Imported',98.97,'EUR');
INSERT INTO `banktrans` VALUES (17,12,13,1060,'9354603 Proserve\r\n1023659\r\n',98.97,1,0.521,'2011-07-19','Imported',98.97,'EUR');
INSERT INTO `banktrans` VALUES (18,12,14,1060,'9354603 Proserve\r\n1023659\r\n',98.97,1,0.521,'2011-07-19','Imported',98.97,'EUR');
INSERT INTO `banktrans` VALUES (19,22,7,1060,'5771148 doc3673 fact\r\nHr C Veldhuizen\r\n',-59.5,1,0.521,'2011-07-21','Imported',-59.5,'EUR');
INSERT INTO `banktrans` VALUES (20,22,8,1060,'4753160 MAXXINNO\r\nWYCHEN MAXXINNO WYCHEN\r\nFact. DO',-148.75,1,0.44,'2011-07-18','Imported',-148.75,'EUR');
INSERT INTO `banktrans` VALUES (21,22,9,1060,'DUBROW-',0,1,0.44,'2011-09-04','Cash',-100,'EUR');
INSERT INTO `banktrans` VALUES (22,12,15,1060,'8839206 Meijboom\r\n2111439\r\n',56.55,1,0.44,'2011-07-19','Imported',56.55,'EUR');
INSERT INTO `banktrans` VALUES (23,22,10,1060,'9238272 PLEXX BV\r\nJULI\r\n',-340,1,0.44,'2011-07-25','Imported',-340,'EUR');
INSERT INTO `banktrans` VALUES (24,22,11,1060,'DUBROW-',0,1,0.5,'2011-09-05','Cash',-100,'EUR');
INSERT INTO `banktrans` VALUES (25,22,12,1060,'DUBROW-',0,1,0.5,'2011-09-05','Cash',-1000,'EUR');
INSERT INTO `banktrans` VALUES (26,12,16,1030,'',0,1,1,'2011-11-02','Cash',15.21,'AUD');
INSERT INTO `banktrans` VALUES (27,12,18,1030,'',0,1,1,'2011-11-03','Cash',2011.98,'AUD');

--
-- Dumping data for table `bom`
--

INSERT INTO `bom` VALUES ('BIGEARS12','DVD-CASE','MEL','TOR','2010-08-14','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('BirthdayCakeConstruc','BREAD','MEL','TOR','2010-08-14','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('BirthdayCakeConstruc','DVD-CASE','MEL','TOR','2010-08-14','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('BirthdayCakeConstruc','FLOUR','MEL','TOR','2010-08-14','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('BirthdayCakeConstruc','SALT','MEL','TOR','2010-08-14','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('BirthdayCakeConstruc','YEAST','MEL','TOR','2010-08-14','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('BREAD','SALT','ASS','MEL','2007-06-19','2037-06-20',0.0265,1);
INSERT INTO `bom` VALUES ('BREAD','YEAST','ASS','MEL','2007-06-19','2037-06-20',0.015,0);
INSERT INTO `bom` VALUES ('DFS-20','DR_TUMMY','ASS','TOR','2011-06-16','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('DFS-20','DVD-CASE','ASS','TOR','2011-06-16','2037-12-31',1,0);
INSERT INTO `bom` VALUES ('DVD_ACTION','DVD-CASE','ASS','MEL','2007-06-12','2037-06-13',4,0);
INSERT INTO `bom` VALUES ('DVD_ACTION','DVD-DHWV','ASS','MEL','2007-06-12','2037-06-13',1,1);
INSERT INTO `bom` VALUES ('DVD_ACTION','DVD-LTWP','ASS','MEL','2007-06-12','2037-06-13',1,1);
INSERT INTO `bom` VALUES ('DVD_ACTION','DVD-UNSG','ASS','MEL','2007-06-12','2037-06-13',1,1);
INSERT INTO `bom` VALUES ('DVD_ACTION','DVD-UNSG2','ASS','MEL','2007-06-12','2037-06-13',1,1);
INSERT INTO `bom` VALUES ('FUJI9901ASS','FUJI990101','ASS','MEL','2005-06-04','2035-06-05',1,0);
INSERT INTO `bom` VALUES ('FUJI9901ASS','FUJI990102','ASS','MEL','2005-02-12','2037-06-13',1,0);
INSERT INTO `bom` VALUES ('SLICE','BREAD','ASS','MEL','2007-06-19','2037-06-20',0.1,1);

--
-- Dumping data for table `chartdetails`
--

INSERT INTO `chartdetails` VALUES (1,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1010,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1020,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,5,0,150,0,0);
INSERT INTO `chartdetails` VALUES (1030,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1030,7,0,11.764705882353,0,0);
INSERT INTO `chartdetails` VALUES (1030,8,0,0,11.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,9,0,34,11.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,10,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,11,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,12,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,13,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,14,0,-500,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,15,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,16,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,17,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,18,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,19,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,20,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,21,0,398,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,22,0,0,443.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,23,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,24,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,25,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,26,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,27,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,28,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,29,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,30,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,31,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,32,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,33,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,34,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,35,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,36,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1030,37,0,0,45.764705882353,0);
INSERT INTO `chartdetails` VALUES (1040,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1040,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1050,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1060,11,0,4108.248,0,0);
INSERT INTO `chartdetails` VALUES (1060,12,0,0,4108.248,0);
INSERT INTO `chartdetails` VALUES (1060,13,0,-2427.27272727273,4108.248,0);
INSERT INTO `chartdetails` VALUES (1060,14,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,15,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,16,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,17,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,18,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,19,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,20,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,21,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,22,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,23,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,24,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,25,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,26,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,27,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,28,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,29,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,30,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,31,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,32,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,33,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,34,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,35,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,36,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1060,37,0,0,1680.97527272727,0);
INSERT INTO `chartdetails` VALUES (1070,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1070,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1080,6,0,25,0,0);
INSERT INTO `chartdetails` VALUES (1080,7,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,8,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,9,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,10,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,11,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,12,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,13,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,14,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,15,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,16,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,17,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,18,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,19,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,20,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,21,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,22,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,23,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,24,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,25,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,26,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,27,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,28,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,29,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,30,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,31,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,32,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,33,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,34,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,35,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,36,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1080,37,0,0,25,0);
INSERT INTO `chartdetails` VALUES (1090,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1090,6,0,-25,0,0);
INSERT INTO `chartdetails` VALUES (1090,7,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,8,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,9,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,10,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,11,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,12,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,13,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,14,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,15,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,16,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,17,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,18,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,19,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,20,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,21,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,22,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,23,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,24,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,25,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,26,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,27,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,28,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,29,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,30,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,31,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,32,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,33,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,34,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,35,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,36,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1090,37,0,0,-25,0);
INSERT INTO `chartdetails` VALUES (1100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,2,0,46.4,0,0);
INSERT INTO `chartdetails` VALUES (1100,3,0,-15.95,0,0);
INSERT INTO `chartdetails` VALUES (1100,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1100,6,0,-45,0,0);
INSERT INTO `chartdetails` VALUES (1100,7,0,-47.332205882353,-45,0);
INSERT INTO `chartdetails` VALUES (1100,8,0,108.27058823529,-92.332205882353,0);
INSERT INTO `chartdetails` VALUES (1100,9,0,1120.5529411765,15.938382352937,0);
INSERT INTO `chartdetails` VALUES (1100,10,0,0,1136.49132352944,0);
INSERT INTO `chartdetails` VALUES (1100,11,0,-698.409,1136.49132352944,0);
INSERT INTO `chartdetails` VALUES (1100,12,0,65.518181818182,438.082323529437,0);
INSERT INTO `chartdetails` VALUES (1100,13,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,14,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,15,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,16,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,17,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,18,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,19,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,20,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,21,0,-99,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,22,0,0,404.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,23,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,24,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,25,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,26,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,27,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,28,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,29,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,30,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,31,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,32,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,33,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,34,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,35,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,36,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1100,37,0,0,503.600505347619,0);
INSERT INTO `chartdetails` VALUES (1150,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1150,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1250,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1300,9,0,-34,0,0);
INSERT INTO `chartdetails` VALUES (1300,10,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,11,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,12,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,13,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,14,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,15,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,16,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,17,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,18,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,19,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,20,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,21,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,22,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,23,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,24,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,25,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,26,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,27,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,28,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,29,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,30,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,31,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,32,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,33,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,34,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,35,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,36,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1300,37,0,0,-34,0);
INSERT INTO `chartdetails` VALUES (1350,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,14,0,500,0,0);
INSERT INTO `chartdetails` VALUES (1350,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1350,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1400,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,21,0,-299,0,0);
INSERT INTO `chartdetails` VALUES (1420,22,0,0,-299,0);
INSERT INTO `chartdetails` VALUES (1420,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1420,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1440,0,0,1425.5905,0,0);
INSERT INTO `chartdetails` VALUES (1440,1,0,1883.917,1425.5905,0);
INSERT INTO `chartdetails` VALUES (1440,2,0,15.56,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,3,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,4,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,5,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,6,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,7,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,8,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,9,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,10,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,11,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,12,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,13,0,0.75,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,14,0,0,3310.2575,0);
INSERT INTO `chartdetails` VALUES (1440,15,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,16,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,17,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,18,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,19,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,20,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,21,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,22,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,23,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,24,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,25,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,26,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,27,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,28,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,29,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,30,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,31,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,32,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,33,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,34,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,35,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,36,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1440,37,0,0,3309.5075,0);
INSERT INTO `chartdetails` VALUES (1460,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1460,0,0,125.90325,0,0);
INSERT INTO `chartdetails` VALUES (1460,1,0,0,125.90325,0);
INSERT INTO `chartdetails` VALUES (1460,2,0,-28.91,125.90325,0);
INSERT INTO `chartdetails` VALUES (1460,3,0,14.19,125.90325,0);
INSERT INTO `chartdetails` VALUES (1460,4,0,0,134.84325,0);
INSERT INTO `chartdetails` VALUES (1460,5,0,0,134.84325,0);
INSERT INTO `chartdetails` VALUES (1460,6,0,59.3,125.90325,0);
INSERT INTO `chartdetails` VALUES (1460,7,0,41.73,185.20325,0);
INSERT INTO `chartdetails` VALUES (1460,8,0,-11.5,226.93325,0);
INSERT INTO `chartdetails` VALUES (1460,9,0,6229.67294090909,215.43325,0);
INSERT INTO `chartdetails` VALUES (1460,10,0,0,6445.10619090909,0);
INSERT INTO `chartdetails` VALUES (1460,11,0,0,6445.10619090909,0);
INSERT INTO `chartdetails` VALUES (1460,12,0,-373.457969775,6445.10619090909,0);
INSERT INTO `chartdetails` VALUES (1460,13,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,14,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,15,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,16,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,17,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,18,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,19,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,20,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,21,0,637.25,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,22,0,0,6708.89822113409,0);
INSERT INTO `chartdetails` VALUES (1460,23,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,24,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,25,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,26,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,27,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,28,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,29,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,30,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,31,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,32,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,33,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,34,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,35,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,36,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1460,37,0,0,6071.64822113409,0);
INSERT INTO `chartdetails` VALUES (1500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1550,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1600,9,0,22.73,0,0);
INSERT INTO `chartdetails` VALUES (1600,10,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,11,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,12,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,13,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,14,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,15,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,16,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,17,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,18,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,19,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,20,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,21,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,22,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,23,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,24,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,25,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,26,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,27,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,28,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,29,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,30,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,31,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,32,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,33,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,34,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,35,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,36,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1600,37,0,0,22.73,0);
INSERT INTO `chartdetails` VALUES (1620,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1620,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1650,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1670,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1700,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1710,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1720,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1730,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1740,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1750,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1760,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1770,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1780,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1790,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1800,9,0,132436.36363636,0,0);
INSERT INTO `chartdetails` VALUES (1800,10,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,11,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,12,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,13,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,14,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,15,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,16,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,17,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,18,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,19,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,20,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,21,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,22,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,23,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,24,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,25,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,26,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,27,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,28,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,29,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,30,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,31,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,32,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,33,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,34,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,35,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,36,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1800,37,0,0,132436.36363636,0);
INSERT INTO `chartdetails` VALUES (1850,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1850,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (1900,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2010,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2020,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2050,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2100,0,0,-1447.74,0,0);
INSERT INTO `chartdetails` VALUES (2100,1,0,0,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,2,0,0,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,3,0,0,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,4,0,0,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,5,0,0,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,6,0,0,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,7,0,0,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,8,0,-182.44,-1447.74,0);
INSERT INTO `chartdetails` VALUES (2100,9,0,-145821.95,-1630.18,0);
INSERT INTO `chartdetails` VALUES (2100,10,0,0,-147452.13,0);
INSERT INTO `chartdetails` VALUES (2100,11,0,1224.998,-147452.13,0);
INSERT INTO `chartdetails` VALUES (2100,12,0,0,-146227.132,0);
INSERT INTO `chartdetails` VALUES (2100,13,0,268.1827272727,-146227.132,0);
INSERT INTO `chartdetails` VALUES (2100,14,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,15,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,16,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,17,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,18,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,19,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,20,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,21,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,22,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,23,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,24,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,25,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,26,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,27,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,28,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,29,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,30,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,31,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,32,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,33,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,34,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,35,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,36,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2100,37,0,0,-145958.949272727,0);
INSERT INTO `chartdetails` VALUES (2150,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2150,7,0,-13.5,0,0);
INSERT INTO `chartdetails` VALUES (2150,8,0,0,-13.5,0);
INSERT INTO `chartdetails` VALUES (2150,9,0,-10.2894,-13.5,0);
INSERT INTO `chartdetails` VALUES (2150,10,0,0,-23.7894,0);
INSERT INTO `chartdetails` VALUES (2150,11,0,0,-23.7894,0);
INSERT INTO `chartdetails` VALUES (2150,12,0,-40.875,-23.7894,0);
INSERT INTO `chartdetails` VALUES (2150,13,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,14,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,15,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,16,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,17,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,18,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,19,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,20,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,21,0,-36.4,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,22,0,0,-101.0644,0);
INSERT INTO `chartdetails` VALUES (2150,23,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,24,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,25,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,26,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,27,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,28,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,29,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,30,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,31,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,32,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,33,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,34,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,35,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,36,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2150,37,0,0,-64.6644,0);
INSERT INTO `chartdetails` VALUES (2200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2230,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2250,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2300,12,0,-7.0189090909091,0,0);
INSERT INTO `chartdetails` VALUES (2300,13,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,14,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,15,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,16,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,17,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,18,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,19,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,20,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,21,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,22,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,23,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,24,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,25,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,26,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,27,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,28,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,29,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,30,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,31,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,32,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,33,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,34,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,35,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,36,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2300,37,0,0,-7.0189090909091,0);
INSERT INTO `chartdetails` VALUES (2310,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2310,9,0,13256.54,0,0);
INSERT INTO `chartdetails` VALUES (2310,10,0,0,13256.54,0);
INSERT INTO `chartdetails` VALUES (2310,11,0,1338.432,13256.54,0);
INSERT INTO `chartdetails` VALUES (2310,12,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,13,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,14,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,15,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,16,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,17,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,18,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,19,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,20,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,21,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,22,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,23,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,24,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,25,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,26,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,27,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,28,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,29,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,30,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,31,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,32,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,33,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,34,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,35,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,36,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2310,37,0,0,14594.972,0);
INSERT INTO `chartdetails` VALUES (2320,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2320,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2330,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2340,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2350,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2360,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2400,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2410,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2420,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2450,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2460,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2470,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2480,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2550,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2560,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2600,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2700,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2720,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2740,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2760,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2800,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (2900,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3100,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3300,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3400,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (3500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,2,0,-46.4,0,0);
INSERT INTO `chartdetails` VALUES (4100,3,0,15.95,0,0);
INSERT INTO `chartdetails` VALUES (4100,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4100,6,0,45,0,0);
INSERT INTO `chartdetails` VALUES (4100,7,0,37.6375,45,0);
INSERT INTO `chartdetails` VALUES (4100,8,0,-113.52941176471,82.6375,0);
INSERT INTO `chartdetails` VALUES (4100,9,0,-1149.2894117647,-30.89191176471,0);
INSERT INTO `chartdetails` VALUES (4100,10,0,0,-1180.18132352941,0);
INSERT INTO `chartdetails` VALUES (4100,11,0,0,-1180.18132352941,0);
INSERT INTO `chartdetails` VALUES (4100,12,0,-60.372727272727,-1180.18132352941,0);
INSERT INTO `chartdetails` VALUES (4100,13,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,14,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,15,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,16,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,17,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,18,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,19,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,20,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,21,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,22,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,23,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,24,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,25,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,26,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,27,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,28,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,29,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,30,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,31,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,32,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,33,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,34,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,35,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,36,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4100,37,0,0,-1240.55405080214,0);
INSERT INTO `chartdetails` VALUES (4200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4600,8,0,62.5,0,0);
INSERT INTO `chartdetails` VALUES (4600,9,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,10,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,11,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,12,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,13,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,14,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,15,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,16,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,17,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,18,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,19,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,20,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,21,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,22,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,23,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,24,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,25,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,26,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,27,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,28,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,29,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,30,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,31,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,32,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,33,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,34,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,35,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,36,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4600,37,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (4700,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4700,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4800,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (4900,7,0,-2.07,0,0);
INSERT INTO `chartdetails` VALUES (4900,8,0,5.264705882353,-2.07,0);
INSERT INTO `chartdetails` VALUES (4900,9,0,28.732235294118,3.194705882353,0);
INSERT INTO `chartdetails` VALUES (4900,10,0,0,31.926941176471,0);
INSERT INTO `chartdetails` VALUES (4900,11,0,0,31.926941176471,0);
INSERT INTO `chartdetails` VALUES (4900,12,0,1.8818181818182,31.926941176471,0);
INSERT INTO `chartdetails` VALUES (4900,13,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,14,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,15,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,16,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,17,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,18,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,19,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,20,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,21,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,22,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,23,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,24,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,25,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,26,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,27,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,28,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,29,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,30,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,31,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,32,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,33,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,34,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,35,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,36,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (4900,37,0,0,33.8087593582892,0);
INSERT INTO `chartdetails` VALUES (5000,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5000,1,0,-1883.917,0,0);
INSERT INTO `chartdetails` VALUES (5000,2,0,13.35,-1883.917,0);
INSERT INTO `chartdetails` VALUES (5000,3,0,-5.25,-1883.917,0);
INSERT INTO `chartdetails` VALUES (5000,4,0,0,-1883.917,0);
INSERT INTO `chartdetails` VALUES (5000,5,0,0,-1883.917,0);
INSERT INTO `chartdetails` VALUES (5000,6,0,-59.3,-1883.917,0);
INSERT INTO `chartdetails` VALUES (5000,7,0,-28.23,-1943.217,0);
INSERT INTO `chartdetails` VALUES (5000,8,0,11.5,-1971.447,0);
INSERT INTO `chartdetails` VALUES (5000,9,0,15.56,-1959.947,0);
INSERT INTO `chartdetails` VALUES (5000,10,0,0,-1944.387,0);
INSERT INTO `chartdetails` VALUES (5000,11,0,0,-1944.387,0);
INSERT INTO `chartdetails` VALUES (5000,12,0,58.2952,-1944.387,0);
INSERT INTO `chartdetails` VALUES (5000,13,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,14,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,15,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,16,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,17,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,18,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,19,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,20,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,21,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,22,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,23,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,24,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,25,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,26,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,27,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,28,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,29,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,30,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,31,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,32,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,33,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,34,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,35,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,36,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5000,37,0,0,-1886.0918,0);
INSERT INTO `chartdetails` VALUES (5100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5100,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5600,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5700,0,0,-166.25,0,0);
INSERT INTO `chartdetails` VALUES (5700,1,0,0,-166.25,0);
INSERT INTO `chartdetails` VALUES (5700,2,0,0,-166.25,0);
INSERT INTO `chartdetails` VALUES (5700,3,0,-8.94,-166.25,0);
INSERT INTO `chartdetails` VALUES (5700,4,0,0,-175.19,0);
INSERT INTO `chartdetails` VALUES (5700,5,0,0,-175.19,0);
INSERT INTO `chartdetails` VALUES (5700,6,0,0,-166.25,0);
INSERT INTO `chartdetails` VALUES (5700,7,0,0,-166.25,0);
INSERT INTO `chartdetails` VALUES (5700,8,0,0,-166.25,0);
INSERT INTO `chartdetails` VALUES (5700,9,0,-6144.03445,-166.25,0);
INSERT INTO `chartdetails` VALUES (5700,10,0,0,-6310.28445,0);
INSERT INTO `chartdetails` VALUES (5700,11,0,0,-6310.28445,0);
INSERT INTO `chartdetails` VALUES (5700,12,0,356.037769775,-6310.28445,0);
INSERT INTO `chartdetails` VALUES (5700,13,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,14,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,15,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,16,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,17,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,18,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,19,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,20,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,21,0,-600.85,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,22,0,0,-6555.096680225,0);
INSERT INTO `chartdetails` VALUES (5700,23,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,24,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,25,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,26,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,27,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,28,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,29,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,30,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,31,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,32,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,33,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,34,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,35,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,36,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5700,37,0,0,-5954.246680225,0);
INSERT INTO `chartdetails` VALUES (5800,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5800,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (5900,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6100,0,0,62.5,0,0);
INSERT INTO `chartdetails` VALUES (6100,1,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,2,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,3,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,4,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,5,0,-150,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,6,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,7,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,8,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,9,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,10,0,0,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,11,0,2868.069,62.5,0);
INSERT INTO `chartdetails` VALUES (6100,12,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,13,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,14,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,15,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,16,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,17,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,18,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,19,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,20,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,21,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,22,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,23,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,24,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,25,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,26,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,27,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,28,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,29,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,30,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,31,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,32,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,33,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,34,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,35,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,36,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6100,37,0,0,2930.569,0);
INSERT INTO `chartdetails` VALUES (6150,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6150,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6250,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6300,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6400,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6550,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6590,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6600,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6700,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6800,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (6900,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7020,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7030,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7040,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7050,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7060,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7070,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7080,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7090,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7100,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7150,11,0,-4588.91,0,0);
INSERT INTO `chartdetails` VALUES (7150,12,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,13,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,14,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,15,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,16,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,17,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,18,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,19,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,20,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,21,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,22,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,23,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,24,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,25,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,26,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,27,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,28,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,29,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,30,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,31,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,32,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,33,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,34,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,35,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,36,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7150,37,0,0,-4588.91,0);
INSERT INTO `chartdetails` VALUES (7200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7210,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7220,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7230,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7240,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7260,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7280,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7300,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7350,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7390,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7400,8,0,119.94,0,0);
INSERT INTO `chartdetails` VALUES (7400,9,0,0,119.94,0);
INSERT INTO `chartdetails` VALUES (7400,10,0,0,119.94,0);
INSERT INTO `chartdetails` VALUES (7400,11,0,0,119.94,0);
INSERT INTO `chartdetails` VALUES (7400,12,0,0,119.94,0);
INSERT INTO `chartdetails` VALUES (7400,13,0,2159.09,119.94,0);
INSERT INTO `chartdetails` VALUES (7400,14,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,15,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,16,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,17,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,18,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,19,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,20,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,21,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,22,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,23,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,24,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,25,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,26,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,27,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,28,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,29,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,30,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,31,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,32,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,33,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,34,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,35,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,36,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7400,37,0,0,2279.03,0);
INSERT INTO `chartdetails` VALUES (7450,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7450,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7550,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7600,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7610,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7620,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7630,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7640,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7650,9,0,15.41,0,0);
INSERT INTO `chartdetails` VALUES (7650,10,0,0,15.41,0);
INSERT INTO `chartdetails` VALUES (7650,11,0,306.023,15.41,0);
INSERT INTO `chartdetails` VALUES (7650,12,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,13,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,14,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,15,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,16,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,17,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,18,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,19,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,20,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,21,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,22,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,23,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,24,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,25,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,26,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,27,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,28,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,29,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,30,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,31,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,32,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,33,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,34,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,35,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,36,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7650,37,0,0,321.433,0);
INSERT INTO `chartdetails` VALUES (7660,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7660,11,0,-4445.698,0,0);
INSERT INTO `chartdetails` VALUES (7660,12,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,13,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,14,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,15,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,16,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,17,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,18,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,19,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,20,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,21,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,22,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,23,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,24,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,25,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,26,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,27,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,28,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,29,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,30,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,31,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,32,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,33,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,34,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,35,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,36,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7660,37,0,0,-4445.698,0);
INSERT INTO `chartdetails` VALUES (7700,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7700,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7750,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7800,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (7900,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8100,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8200,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8300,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8400,11,0,76.482,0,0);
INSERT INTO `chartdetails` VALUES (8400,12,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,13,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,14,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,15,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,16,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,17,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,18,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,19,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,20,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,21,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,22,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,23,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,24,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,25,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,26,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,27,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,28,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,29,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,30,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,31,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,32,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,33,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,34,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,35,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,36,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8400,37,0,0,76.482,0);
INSERT INTO `chartdetails` VALUES (8500,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8500,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8600,11,0,-189.235,0,0);
INSERT INTO `chartdetails` VALUES (8600,12,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,13,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,14,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,15,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,16,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,17,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,18,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,19,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,20,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,21,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,22,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,23,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,24,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,25,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,26,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,27,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,28,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,29,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,30,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,31,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,32,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,33,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,34,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,35,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,36,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8600,37,0,0,-189.235,0);
INSERT INTO `chartdetails` VALUES (8900,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (8900,37,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,-1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,0,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,1,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,2,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,3,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,4,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,5,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,6,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,7,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,8,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,9,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,10,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,11,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,12,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,13,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,14,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,15,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,16,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,17,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,18,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,19,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,20,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,21,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,22,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,23,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,24,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,25,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,26,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,27,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,28,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,29,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,30,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,31,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,32,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,33,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,34,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,35,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,36,0,0,0,0);
INSERT INTO `chartdetails` VALUES (9100,37,0,0,0,0);

--
-- Dumping data for table `chartmaster`
--

INSERT INTO `chartmaster` VALUES (1,'Default Sales/Discounts','Sales');
INSERT INTO `chartmaster` VALUES (1010,'Petty Cash','Current Assets');
INSERT INTO `chartmaster` VALUES (1020,'Cash on Hand','Current Assets');
INSERT INTO `chartmaster` VALUES (1030,'Cheque Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES (1040,'Savings Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES (1050,'Payroll Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES (1060,'Special Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES (1070,'Money Market Investments','Current Assets');
INSERT INTO `chartmaster` VALUES (1080,'Short-Term Investments (< 90 days)','Current Assets');
INSERT INTO `chartmaster` VALUES (1090,'Interest Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES (1100,'Accounts Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES (1150,'Allowance for Doubtful Accounts','Current Assets');
INSERT INTO `chartmaster` VALUES (1200,'Notes Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES (1250,'Income Tax Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES (1300,'Prepaid Expenses','Current Assets');
INSERT INTO `chartmaster` VALUES (1350,'Advances','Current Assets');
INSERT INTO `chartmaster` VALUES (1400,'Supplies Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES (1420,'Raw Material Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES (1440,'Work in Progress Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES (1460,'Finished Goods Inventory','Current Assets');
INSERT INTO `chartmaster` VALUES (1500,'Land','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1550,'Bonds','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1600,'Buildings','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1620,'Accumulated Depreciation of Buildings','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1650,'Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1670,'Accumulated Depreciation of Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1700,'Furniture & Fixtures','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1710,'Accumulated Depreciation of Furniture & Fixtures','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1720,'Office Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1730,'Accumulated Depreciation of Office Equipment','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1740,'Software','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1750,'Accumulated Depreciation of Software','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1760,'Vehicles','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1770,'Accumulated Depreciation Vehicles','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1780,'Other Depreciable Property','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1790,'Accumulated Depreciation of Other Depreciable Prop','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1800,'Patents','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1850,'Goodwill','Fixed Assets');
INSERT INTO `chartmaster` VALUES (1900,'Future Income Tax Receivable','Current Assets');
INSERT INTO `chartmaster` VALUES (2010,'Bank Indedebtedness (overdraft)','Liabilities');
INSERT INTO `chartmaster` VALUES (2020,'Retainers or Advances on Work','Liabilities');
INSERT INTO `chartmaster` VALUES (2050,'Interest Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2100,'Accounts Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2150,'Goods Received Suspense','Liabilities');
INSERT INTO `chartmaster` VALUES (2200,'Short-Term Loan Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2230,'Current Portion of Long-Term Debt Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2250,'Income Tax Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2300,'GST Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2310,'GST Recoverable','Liabilities');
INSERT INTO `chartmaster` VALUES (2320,'PST Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2330,'PST Recoverable (commission)','Liabilities');
INSERT INTO `chartmaster` VALUES (2340,'Payroll Tax Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2350,'Withholding Income Tax Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2360,'Other Taxes Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2400,'Employee Salaries Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2410,'Management Salaries Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2420,'Director / Partner Fees Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2450,'Health Benefits Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2460,'Pension Benefits Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2470,'Canada Pension Plan Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2480,'Employment Insurance Premiums Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2500,'Land Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2550,'Long-Term Bank Loan','Liabilities');
INSERT INTO `chartmaster` VALUES (2560,'Notes Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2600,'Building & Equipment Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2700,'Furnishing & Fixture Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2720,'Office Equipment Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2740,'Vehicle Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2760,'Other Property Payable','Liabilities');
INSERT INTO `chartmaster` VALUES (2800,'Shareholder Loans','Liabilities');
INSERT INTO `chartmaster` VALUES (2900,'Suspense','Liabilities');
INSERT INTO `chartmaster` VALUES (3100,'Capital Stock','Equity');
INSERT INTO `chartmaster` VALUES (3200,'Capital Surplus / Dividends','Equity');
INSERT INTO `chartmaster` VALUES (3300,'Dividend Taxes Payable','Equity');
INSERT INTO `chartmaster` VALUES (3400,'Dividend Taxes Refundable','Equity');
INSERT INTO `chartmaster` VALUES (3500,'Retained Earnings','Equity');
INSERT INTO `chartmaster` VALUES (4100,'Product / Service Sales','Revenue');
INSERT INTO `chartmaster` VALUES (4200,'Sales Exchange Gains/Losses','Revenue');
INSERT INTO `chartmaster` VALUES (4500,'Consulting Services','Revenue');
INSERT INTO `chartmaster` VALUES (4600,'Rentals','Revenue');
INSERT INTO `chartmaster` VALUES (4700,'Finance Charge Income','Revenue');
INSERT INTO `chartmaster` VALUES (4800,'Sales Returns & Allowances','Revenue');
INSERT INTO `chartmaster` VALUES (4900,'Sales Discounts','Revenue');
INSERT INTO `chartmaster` VALUES (5000,'Cost of Sales','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES (5100,'Production Expenses','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES (5200,'Purchases Exchange Gains/Losses','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES (5500,'Direct Labour Costs','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES (5600,'Freight Charges','Outward Freight');
INSERT INTO `chartmaster` VALUES (5700,'Inventory Adjustment','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES (5800,'Purchase Returns & Allowances','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES (5900,'Purchase Discounts','Cost of Goods Sold');
INSERT INTO `chartmaster` VALUES (6100,'Advertising','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6150,'Promotion','Promotions');
INSERT INTO `chartmaster` VALUES (6200,'Communications','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6250,'Meeting Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6300,'Travelling Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6400,'Delivery Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6500,'Sales Salaries & Commission','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6550,'Sales Salaries & Commission Deductions','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6590,'Benefits','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6600,'Other Selling Expenses','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6700,'Permits, Licenses & License Fees','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6800,'Research & Development','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (6900,'Professional Services','Marketing Expenses');
INSERT INTO `chartmaster` VALUES (7020,'Support Salaries & Wages','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7030,'Support Salary & Wage Deductions','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7040,'Management Salaries','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7050,'Management Salary deductions','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7060,'Director / Partner Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7070,'Director / Partner Deductions','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7080,'Payroll Tax','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7090,'Benefits','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7100,'Training & Education Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7150,'Dues & Subscriptions','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7200,'Accounting Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7210,'Audit Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7220,'Banking Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7230,'Credit Card Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7240,'Consulting Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7260,'Legal Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7280,'Other Professional Fees','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7300,'Business Tax','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7350,'Property Tax','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7390,'Corporation Capital Tax','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7400,'Office Rent','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7450,'Equipment Rental','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7500,'Office Supplies','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7550,'Office Repair & Maintenance','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7600,'Automotive Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7610,'Communication Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7620,'Insurance Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7630,'Postage & Courier Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7640,'Miscellaneous Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7650,'Travel Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7660,'Utilities','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7700,'Ammortization Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7750,'Depreciation Expenses','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7800,'Interest Expense','Operating Expenses');
INSERT INTO `chartmaster` VALUES (7900,'Bad Debt Expense','Operating Expenses');
INSERT INTO `chartmaster` VALUES (8100,'Gain on Sale of Assets','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES (8200,'Interest Income','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES (8300,'Recovery on Bad Debt','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES (8400,'Other Revenue','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES (8500,'Loss on Sale of Assets','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES (8600,'Charitable Contributions','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES (8900,'Other Expenses','Other Revenue and Expenses');
INSERT INTO `chartmaster` VALUES (9100,'Income Tax Provision','Income Tax');

--
-- Dumping data for table `cogsglpostings`
--

INSERT INTO `cogsglpostings` VALUES (5,'AN','ANY',5000,'AN');

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` VALUES (1,'weberpdemo','not entered yet','','123 Web Way','PO Box 123','Queen Street','Melbourne','Victoria 3043','Australia','+61 3 4567 8901','+61 3 4567 8902','weberp@weberpdemo.com','AUD',1100,4900,2100,2400,2150,4200,5200,3500,1,1,1,5600);

--
-- Dumping data for table `config`
--

INSERT INTO `config` VALUES ('AllowOrderLineItemNarrative','1');
INSERT INTO `config` VALUES ('AllowSalesOfZeroCostItems','0');
INSERT INTO `config` VALUES ('AutoAuthorisePO','1');
INSERT INTO `config` VALUES ('AutoCreateWOs','1');
INSERT INTO `config` VALUES ('AutoDebtorNo','0');
INSERT INTO `config` VALUES ('AutoIssue','1');
INSERT INTO `config` VALUES ('CheckCreditLimits','1');
INSERT INTO `config` VALUES ('Check_Price_Charged_vs_Order_Price','1');
INSERT INTO `config` VALUES ('Check_Qty_Charged_vs_Del_Qty','1');
INSERT INTO `config` VALUES ('CountryOfOperation','AUD');
INSERT INTO `config` VALUES ('CreditingControlledItems_MustExist','0');
INSERT INTO `config` VALUES ('DB_Maintenance','30');
INSERT INTO `config` VALUES ('DB_Maintenance_LastRun','2011-11-01');
INSERT INTO `config` VALUES ('DefaultBlindPackNote','1');
INSERT INTO `config` VALUES ('DefaultCreditLimit','1000');
INSERT INTO `config` VALUES ('DefaultCustomerType','1');
INSERT INTO `config` VALUES ('DefaultDateFormat','d/m/Y');
INSERT INTO `config` VALUES ('DefaultDisplayRecordsMax','50');
INSERT INTO `config` VALUES ('DefaultFactoryLocation','MEL');
INSERT INTO `config` VALUES ('DefaultPriceList','DE');
INSERT INTO `config` VALUES ('DefaultSupplierType','1');
INSERT INTO `config` VALUES ('DefaultTaxCategory','1');
INSERT INTO `config` VALUES ('DefaultTheme','silverwolf');
INSERT INTO `config` VALUES ('Default_Shipper','1');
INSERT INTO `config` VALUES ('DefineControlledOnWOEntry','1');
INSERT INTO `config` VALUES ('DispatchCutOffTime','14');
INSERT INTO `config` VALUES ('DoFreightCalc','0');
INSERT INTO `config` VALUES ('EDIHeaderMsgId','D:01B:UN:EAN010');
INSERT INTO `config` VALUES ('EDIReference','WEBERP');
INSERT INTO `config` VALUES ('EDI_Incoming_Orders','companies/weberpdemo/EDI_Incoming_Orders');
INSERT INTO `config` VALUES ('EDI_MsgPending','companies/weberpdemo/EDI_MsgPending');
INSERT INTO `config` VALUES ('EDI_MsgSent','companies/weberpdemo/EDI_Sent');
INSERT INTO `config` VALUES ('Extended_CustomerInfo','1');
INSERT INTO `config` VALUES ('Extended_SupplierInfo','0');
INSERT INTO `config` VALUES ('FactoryManagerEmail','manager@company.com');
INSERT INTO `config` VALUES ('FreightChargeAppliesIfLessThan','1000');
INSERT INTO `config` VALUES ('FreightTaxCategory','1');
INSERT INTO `config` VALUES ('FrequentlyOrderedItems','0');
INSERT INTO `config` VALUES ('geocode_integration','0');
INSERT INTO `config` VALUES ('HTTPS_Only','0');
INSERT INTO `config` VALUES ('InventoryManagerEmail','');
INSERT INTO `config` VALUES ('InvoicePortraitFormat','0');
INSERT INTO `config` VALUES ('LogPath','');
INSERT INTO `config` VALUES ('LogSeverity','0');
INSERT INTO `config` VALUES ('MaxImageSize','300');
INSERT INTO `config` VALUES ('MonthsAuditTrail','1');
INSERT INTO `config` VALUES ('NumberOfMonthMustBeShown','6');
INSERT INTO `config` VALUES ('NumberOfPeriodsOfStockUsage','12');
INSERT INTO `config` VALUES ('OverChargeProportion','30');
INSERT INTO `config` VALUES ('OverReceiveProportion','20');
INSERT INTO `config` VALUES ('PackNoteFormat','1');
INSERT INTO `config` VALUES ('PageLength','48');
INSERT INTO `config` VALUES ('part_pics_dir','companies/weberpdemo/part_pics');
INSERT INTO `config` VALUES ('PastDueDays1','30');
INSERT INTO `config` VALUES ('PastDueDays2','60');
INSERT INTO `config` VALUES ('PO_AllowSameItemMultipleTimes','1');
INSERT INTO `config` VALUES ('ProhibitJournalsToControlAccounts','1');
INSERT INTO `config` VALUES ('ProhibitNegativeStock','1');
INSERT INTO `config` VALUES ('ProhibitPostingsBefore','2010-09-30');
INSERT INTO `config` VALUES ('PurchasingManagerEmail','test@company.com');
INSERT INTO `config` VALUES ('QuickEntries','10');
INSERT INTO `config` VALUES ('RadioBeaconFileCounter','/home/RadioBeacon/FileCounter');
INSERT INTO `config` VALUES ('RadioBeaconFTP_user_name','RadioBeacon ftp server user name');
INSERT INTO `config` VALUES ('RadioBeaconHomeDir','/home/RadioBeacon');
INSERT INTO `config` VALUES ('RadioBeaconStockLocation','BL');
INSERT INTO `config` VALUES ('RadioBraconFTP_server','192.168.2.2');
INSERT INTO `config` VALUES ('RadioBreaconFilePrefix','ORDXX');
INSERT INTO `config` VALUES ('RadionBeaconFTP_user_pass','Radio Beacon remote ftp server password');
INSERT INTO `config` VALUES ('reports_dir','companies/weberpdemo/reportwriter');
INSERT INTO `config` VALUES ('RequirePickingNote','0');
INSERT INTO `config` VALUES ('RomalpaClause','Ownership will not pass to the buyer until the goods have been paid for in full.');
INSERT INTO `config` VALUES ('ShowValueOnGRN','1');
INSERT INTO `config` VALUES ('Show_Settled_LastMonth','1');
INSERT INTO `config` VALUES ('SO_AllowSameItemMultipleTimes','1');
INSERT INTO `config` VALUES ('TaxAuthorityReferenceName','Not set');
INSERT INTO `config` VALUES ('UpdateCurrencyRatesDaily','0');
INSERT INTO `config` VALUES ('VersionNumber','4.05.3');
INSERT INTO `config` VALUES ('WeightedAverageCosting','1');
INSERT INTO `config` VALUES ('WikiApp','Disabled');
INSERT INTO `config` VALUES ('WikiPath','wiki');
INSERT INTO `config` VALUES ('WorkingDaysWeek','5');
INSERT INTO `config` VALUES ('YearEnd','3');

--
-- Dumping data for table `contractbom`
--

INSERT INTO `contractbom` VALUES ('DFS-20','DR_TUMMY','ASS',1);
INSERT INTO `contractbom` VALUES ('DFS-20','DVD-CASE','ASS',1);

--
-- Dumping data for table `contractcharges`
--

INSERT INTO `contractcharges` VALUES (1,'BirthdayCakeConstruc',20,20,1569.0625,'TEsting one two three',0);
INSERT INTO `contractcharges` VALUES (2,'BirthdayCakeConstruc',20,21,12.5,'test 9844',0);
INSERT INTO `contractcharges` VALUES (3,'BirthdayCakeConstruc',20,22,125,'te 9554788 great',1);
INSERT INTO `contractcharges` VALUES (4,'BirthdayCakeConstruc',20,0,-112.5,'TEsting one two three',1);
INSERT INTO `contractcharges` VALUES (6,'BirthdayCakeConstruc',20,0,-125,'if you think so',0);
INSERT INTO `contractcharges` VALUES (8,'BirthdayCakeConstruc',21,7,-122.7625,'I hope so',1);
INSERT INTO `contractcharges` VALUES (9,'BirthdayCakeConstruc',21,7,-7.75,'And this one too',0);

--
-- Dumping data for table `contractreqts`
--

INSERT INTO `contractreqts` VALUES (2,'DFS-20','summat else',3,23.9);

--
-- Dumping data for table `contracts`
--

INSERT INTO `contracts` VALUES ('DFS-20','GSGF DFS-20001 DOG CAT ANIMAL','QUARTER','QUARTER','TOR',2,'AIRCON',30,'',50,14,'2011-07-16','',0.68);

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` VALUES ('Australian Dollars','AUD','Australia','cents',2,1);
INSERT INTO `currencies` VALUES ('Swiss Francs','CHF','Swizerland','centimes',2,1);
INSERT INTO `currencies` VALUES ('Euro','EUR','Euroland','cents',2,0.44);
INSERT INTO `currencies` VALUES ('Pounds','GBP','England','Pence',2,0.67);
INSERT INTO `currencies` VALUES ('US Dollars','USD','United States','Cents',2,1.1);

--
-- Dumping data for table `custallocns`
--

INSERT INTO `custallocns` VALUES (1,'15.9500','2007-08-02',2,1);
INSERT INTO `custallocns` VALUES (2,'117.5000','2010-05-31',18,17);
INSERT INTO `custallocns` VALUES (3,'24.0000','2011-02-16',21,7);
INSERT INTO `custallocns` VALUES (4,'28.3800','2011-03-29',24,5);

--
-- Dumping data for table `custbranch`
--

INSERT INTO `custbranch` VALUES ('ANGRY','ANGRY','Angus Rouledge - Toronto','P O Box 671','Gowerbridge','Upperton','Toronto ','Canada','',0.000000,0.000000,3,'TR','ERI',0,'0422 2245 2213','0422 2245 2215','Granville Thomas','graville@angry.com','TOR',2,1,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('ANGRYFL','ANGRY','Angus Rouledge - Florida','1821 Sunnyside','Ft Lauderdale','Florida','42554','','',0.000000,0.000000,3,'FL','PHO',0,'2445 2232 524','2445 2232 522','Wendy Blowers','wendy@angry.com','TOR',1,1,1,0,'','','','','','','Watch out can bite!','');
INSERT INTO `custbranch` VALUES ('CASH','CASH','Cash Sales - from POS','','','','','','',0.000000,0.000000,0,'DE','DE',0,'','','','','MEL',1,1,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('CHABAL','CHABAL','Beastly Ventures','','','','','','',0.000000,0.000000,0,'DE','DE',0,'','','','','MEL',1,1,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('DUMBLE','DUMBLE','Dumbledoor McGonagal & Co','Hogwarts castle','Platform 9.75','','','','',0.000000,0.000000,1,'TR','ERI',0,'Owls only','Owls only','Minerva McGonagal','mmgonagal@hogwarts.edu.uk','TOR',3,10,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('JOLOMU','JOLOMU','Lorrima Productions Inc','3215 Great Western Highway','Blubberhouses','Yorkshire','England','','',0.000000,0.000000,20,'FL','PHO',0,'+44 812 211456','+44 812 211 554','Jo Lomu','jolomu@lorrima.co.uk','TOR',3,1,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('QUARTER','QUARTER','Quarter Back to Back','1356 Union Drive','Holborn','England','','','',0.000000,0.000000,5,'FL','ERI',0,'123456','1234567','','','TOR',3,1,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('QUIC','QUICK','Quick Brown PLC','Fox Street','Jumped Over','The Lazy Dog','','','',0.000000,0.000000,1,'FL','ERI',0,'','','','','TOR',1,1,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('SLOW','QUICK','Slow Dog','Hunstman Road','Woofton','','','','',0.000000,0.000000,1,'TR','ERI',0,'','','Staffordshire Terrier','','TOR',2,1,1,0,'','','','','','','','');
INSERT INTO `custbranch` VALUES ('SNAPE','DUMBLE','Severus Sharples','','','','','','',0.000000,0.000000,3,'DE','DE',0,'','','Snappy Snape','','TOR',1,1,1,0,'','','','','','','','');

--
-- Dumping data for table `custcontacts`
--

INSERT INTO `custcontacts` VALUES (2,'ANGRY','Hamish McKay','CEO','12334302','Whisky drinker single malt only','');
INSERT INTO `custcontacts` VALUES (3,'ANGRY','Gavin McDonald','Purchasing','12334990','Golfer, 5 handicap','');
INSERT INTO `custcontacts` VALUES (4,'ANGRY','Bill (William) Wallace','Mover and shaker','10292811','English hater!','dog@spanner.co.uk');

--
-- Dumping data for table `custnotes`
--

INSERT INTO `custnotes` VALUES (1,'ANGRY','http://www.logicworks.co.nz','Test note','2011-06-16','2');

--
-- Dumping data for table `debtorsmaster`
--

INSERT INTO `debtorsmaster` VALUES ('ANGRY','Angus Rouledge Younger &amp; Son','P O Box 67','Gowerbridge','Upperton','Michigan','','','USD','DE','2005-04-30 00:00:00',1,'7',0,0,10,'2011-03-23 00:00:00',5000,0,'',0,0,'','email','','','','1344-654-112',0,1);
INSERT INTO `debtorsmaster` VALUES ('CASH','Cash Sales - from POS','','','','','','','AUD','DE','2011-06-20 00:00:00',1,'CA',0,0,2011.98,'2011-11-03 00:00:00',1000,0,'',0,0,'','email','','','','',0,1);
INSERT INTO `debtorsmaster` VALUES ('CHABAL','Beastly Ventures','','','','','','','EUR','DE','2011-09-03 00:00:00',1,'20',0,0,56.55,'2011-07-19 00:00:00',1000,0,'',0,0,'','email','','','','',0,1);
INSERT INTO `debtorsmaster` VALUES ('DUMBLE','Dumbledoor McGonagal & Co','Hogwarts castle','Platform 9.75','','','','','GBP','DE','2005-06-18 00:00:00',1,'30',0,0,0,NULL,1000,0,'',0,0,'','email','','','','',0,1);
INSERT INTO `debtorsmaster` VALUES ('JOLOMU','Lorrima Productions Inc','3215 Great Western Highway','Blubberhouses','Yorkshire','England','','','GBP','DE','2005-06-15 00:00:00',1,'30',0,0,0,NULL,1000,0,'',0,0,'','email','','','','',0,1);
INSERT INTO `debtorsmaster` VALUES ('QUARTER','Quarter Back to Back','1356 Union Drive','Holborn','England','','','','CHF','DE','2005-09-03 00:00:00',1,'20',0,0,0,NULL,1000,0,'',0,0,'','email','','','','',0,1);
INSERT INTO `debtorsmaster` VALUES ('QUICK','Quick Brown PLC','Fox Street','Jumped Over','The Lazy Dog','','','','USD','DE','2007-01-30 00:00:00',1,'20',0,0,0,NULL,1000,0,'',0,0,'','email','','','','',0,1);

--
-- Dumping data for table `debtortrans`
--

INSERT INTO `debtortrans` VALUES (1,1,10,'QUARTER','QUARTER','2007-06-26 00:00:00','0000-00-00 00:00:00',2,0,'','DE',1,1,46.4,0,0,0,0,15.95,'Some narrative for testing the output on the printed invoice',1,0,'');
INSERT INTO `debtortrans` VALUES (2,1,11,'QUARTER','QUARTER','2007-08-02 00:00:00','0000-00-00 00:00:00',3,1,'Inv-1','DE',1,1,-15.95,0,0,0,0,-15.95,'',0,0,'');
INSERT INTO `debtortrans` VALUES (3,2,12,'ANGRY','','2009-02-04 00:00:00','0000-00-00 00:00:00',21,0,'Cash ','',0,1,-99,0,0,0,0,0,'',0,0,'');
INSERT INTO `debtortrans` VALUES (5,4,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 12:02:42',-11,1,'','DE',8,1,28.38,0,0,0,0,28.38,'Testing comments',1,0,'');
INSERT INTO `debtortrans` VALUES (6,5,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 12:09:46',-11,0,'211547','DE',9,1,26.40515,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (7,6,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 12:14:47',-11,1,'','DE',10,1,24,0,0,0,0,24,'',1,0,'');
INSERT INTO `debtortrans` VALUES (8,7,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 12:53:46',-11,0,'','DE',11,1,0,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (9,2,11,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 12:55:30',36,0,'Inv-7','DE',11,1,0,0,0,0,0,0,'',0,0,'');
INSERT INTO `debtortrans` VALUES (11,9,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 16:49:14',-11,0,'','DE',13,1,50,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (12,10,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 16:50:53',-11,0,'','DE',14,1,10.5,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (13,11,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 17:00:43',-11,0,'','DE',15,0.85,5,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (14,12,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 17:01:30',-11,0,'','DE',16,0.85,5,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (15,13,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 17:02:36',-11,0,'','DE',17,0.85,5,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (16,8,12,'ANGRY','','2010-05-31 00:00:00','2010-05-31 17:02:36',-11,0,'13','',0,0.85,-5,0,0,0,0,0,'Melbourne Counter Sale',0,0,'');
INSERT INTO `debtortrans` VALUES (17,14,10,'ANGRY','ANGRY','2010-05-31 00:00:00','2010-05-31 17:20:14',-11,0,'','DE',18,0.85,117.5,0,0,0,0,117.5,'',1,0,'');
INSERT INTO `debtortrans` VALUES (18,9,12,'ANGRY','','2010-05-31 00:00:00','2010-05-31 17:20:14',-11,0,'14','',0,0.85,-117.5,0,0,0,0,-117.5,'Melbourne Counter Sale',0,0,'');
INSERT INTO `debtortrans` VALUES (19,3,11,'DUMBLE','DUMBLE','2011-02-16 00:00:00','2011-02-16 23:18:48',6,0,'','DE',0,0.8,0,0,0,0,0,0,'',0,0,'');
INSERT INTO `debtortrans` VALUES (20,4,11,'DUMBLE','DUMBLE','2011-02-16 00:00:00','2011-02-16 23:20:33',6,0,'','DE',0,0.8,-16.8,0,0,0,0,0,'',0,0,'');
INSERT INTO `debtortrans` VALUES (21,5,11,'ANGRY','ANGRY','2011-02-16 00:00:00','2011-02-16 23:33:44',6,1,'Inv-6','DE',10,1,-24,0,0,0,0,-24,'',0,0,'');
INSERT INTO `debtortrans` VALUES (22,10,12,'ANGRY','','2011-03-23 00:00:00','2011-03-23 21:28:01',7,0,'Cheque ','',0,0.85,-10,0,0,0,0,0,'',0,0,'');
INSERT INTO `debtortrans` VALUES (23,6,11,'DUMBLE','DUMBLE','2011-03-26 00:00:00','2011-03-26 22:36:46',7,0,'','DE',0,0.8,-5.75,0,0,0,0,0,'test',0,0,'');
INSERT INTO `debtortrans` VALUES (24,7,11,'ANGRY','ANGRY','2011-03-29 00:00:00','2011-03-29 08:47:23',7,1,'Inv-4','DE',8,1,-28.38,0,0,0,0,-28.38,'',0,0,'');
INSERT INTO `debtortrans` VALUES (25,15,10,'QUICK','SLOW','2011-04-18 00:00:00','2011-04-16 05:42:39',8,0,'','DE',28,0.85,92.03,0,0,0,0,0,'test inbvoice narrative',1,0,'');
INSERT INTO `debtortrans` VALUES (26,16,10,'QUICK','SLOW','2011-05-03 00:00:00','2011-05-02 22:34:24',9,0,'','DE',29,0.85,952.47,0,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (27,17,10,'ANGRY','ANGRY','2011-08-09 00:00:00','2011-08-08 20:53:48',12,0,'','DE',11,1.1,11.96,1.44,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (28,18,10,'ANGRY','ANGRY','2011-08-24 00:00:00','2011-08-23 21:46:18',12,0,'','DE',10,1.1,24,2.88,0,0,0,0,'',1,0,'HD009221');
INSERT INTO `debtortrans` VALUES (29,19,10,'ANGRY','ANGRY','2011-08-24 00:00:00','2011-08-23 22:12:30',12,0,'','DE',8,1.1,28.38,3.41,0,0,0,0,'',1,0,'');
INSERT INTO `debtortrans` VALUES (30,12,12,'CHABAL','','2011-07-19 00:00:00','2011-09-03 08:09:46',11,0,'9354603 Proserve\r\n10','',0,0.521,98.97,0,0,0,0,0,'9354603 Proserve\r\n1023659\r\n',0,0,'');
INSERT INTO `debtortrans` VALUES (31,13,12,'CHABAL','','2011-07-19 00:00:00','2011-09-03 08:09:04',11,0,'9354603 Proserve\r\n10','',0,0.521,98.97,0,0,0,0,0,'9354603 Proserve\r\n1023659\r\n',0,0,'');
INSERT INTO `debtortrans` VALUES (32,14,12,'CHABAL','','2011-07-19 00:00:00','2011-09-03 09:09:52',11,0,'9354603 Proserve\r\n10','',0,0.521,98.97,0,0,0,0,0,'9354603 Proserve\r\n1023659\r\n',0,0,'');
INSERT INTO `debtortrans` VALUES (33,15,12,'CHABAL','','2011-07-19 00:00:00','2011-09-04 05:09:34',11,0,'8839206 Meijboom\r\n21','',0,0.44,-56.55,0,0,0,0,0,'8839206 Meijboom\r\n2111439\r\n',0,0,'');
INSERT INTO `debtortrans` VALUES (34,16,12,'CASH','','2011-11-02 00:00:00','2011-11-02 21:27:07',0,0,'Cash ','',0,1,-15.21,0,0,-1.5,0,0,'test',0,0,'');
INSERT INTO `debtortrans` VALUES (35,18,12,'CASH','','2011-11-03 00:00:00','2011-11-03 20:23:59',0,0,'Cash ','',0,1,-2011.98,0,0,-2.91,0,0,'',0,0,'');

--
-- Dumping data for table `debtortranstaxes`
--

INSERT INTO `debtortranstaxes` VALUES (1,13,0);
INSERT INTO `debtortranstaxes` VALUES (2,13,0);
INSERT INTO `debtortranstaxes` VALUES (5,13,0);
INSERT INTO `debtortranstaxes` VALUES (6,13,0);
INSERT INTO `debtortranstaxes` VALUES (7,13,0);
INSERT INTO `debtortranstaxes` VALUES (8,13,0);
INSERT INTO `debtortranstaxes` VALUES (9,13,0);
INSERT INTO `debtortranstaxes` VALUES (17,13,0);
INSERT INTO `debtortranstaxes` VALUES (19,13,0);
INSERT INTO `debtortranstaxes` VALUES (20,13,0);
INSERT INTO `debtortranstaxes` VALUES (21,13,0);
INSERT INTO `debtortranstaxes` VALUES (23,13,0);
INSERT INTO `debtortranstaxes` VALUES (24,13,0);
INSERT INTO `debtortranstaxes` VALUES (25,13,0);
INSERT INTO `debtortranstaxes` VALUES (26,13,0);
INSERT INTO `debtortranstaxes` VALUES (27,11,0.76109090909091);
INSERT INTO `debtortranstaxes` VALUES (27,12,0.54363636363636);
INSERT INTO `debtortranstaxes` VALUES (28,11,1.5272727272727);
INSERT INTO `debtortranstaxes` VALUES (28,12,1.0909090909091);
INSERT INTO `debtortranstaxes` VALUES (29,11,1.806);
INSERT INTO `debtortranstaxes` VALUES (29,12,1.29);

--
-- Dumping data for table `debtortype`
--

INSERT INTO `debtortype` VALUES (1,'Default');

--
-- Dumping data for table `debtortypenotes`
--

INSERT INTO `debtortypenotes` VALUES (1,0,' sakk','Test group note','0000-00-00','2');

--
-- Dumping data for table `deliverynotes`
--


--
-- Dumping data for table `discountmatrix`
--

INSERT INTO `discountmatrix` VALUES ('DE','DE',3,0.025);

--
-- Dumping data for table `edi_orders_seg_groups`
--

INSERT INTO `edi_orders_seg_groups` VALUES (0,1,0);
INSERT INTO `edi_orders_seg_groups` VALUES (1,9999,0);
INSERT INTO `edi_orders_seg_groups` VALUES (2,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (3,99,2);
INSERT INTO `edi_orders_seg_groups` VALUES (5,5,2);
INSERT INTO `edi_orders_seg_groups` VALUES (6,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (7,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (8,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (9,9999,8);
INSERT INTO `edi_orders_seg_groups` VALUES (10,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (11,10,10);
INSERT INTO `edi_orders_seg_groups` VALUES (12,5,0);
INSERT INTO `edi_orders_seg_groups` VALUES (13,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (14,5,13);
INSERT INTO `edi_orders_seg_groups` VALUES (15,10,0);
INSERT INTO `edi_orders_seg_groups` VALUES (19,99,0);
INSERT INTO `edi_orders_seg_groups` VALUES (20,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (21,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (22,2,19);
INSERT INTO `edi_orders_seg_groups` VALUES (23,1,19);
INSERT INTO `edi_orders_seg_groups` VALUES (24,5,19);
INSERT INTO `edi_orders_seg_groups` VALUES (28,200000,0);
INSERT INTO `edi_orders_seg_groups` VALUES (32,25,28);
INSERT INTO `edi_orders_seg_groups` VALUES (33,9999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (34,99,28);
INSERT INTO `edi_orders_seg_groups` VALUES (36,5,34);
INSERT INTO `edi_orders_seg_groups` VALUES (37,9999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (38,10,28);
INSERT INTO `edi_orders_seg_groups` VALUES (39,999,28);
INSERT INTO `edi_orders_seg_groups` VALUES (42,5,39);
INSERT INTO `edi_orders_seg_groups` VALUES (43,99,28);
INSERT INTO `edi_orders_seg_groups` VALUES (44,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (45,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (46,2,43);
INSERT INTO `edi_orders_seg_groups` VALUES (47,1,43);
INSERT INTO `edi_orders_seg_groups` VALUES (48,5,43);
INSERT INTO `edi_orders_seg_groups` VALUES (49,10,28);
INSERT INTO `edi_orders_seg_groups` VALUES (50,1,0);

--
-- Dumping data for table `edi_orders_segs`
--

INSERT INTO `edi_orders_segs` VALUES (1,'UNB',0,1);
INSERT INTO `edi_orders_segs` VALUES (2,'UNH',0,1);
INSERT INTO `edi_orders_segs` VALUES (3,'BGM',0,1);
INSERT INTO `edi_orders_segs` VALUES (4,'DTM',0,35);
INSERT INTO `edi_orders_segs` VALUES (5,'PAI',0,1);
INSERT INTO `edi_orders_segs` VALUES (6,'ALI',0,5);
INSERT INTO `edi_orders_segs` VALUES (7,'FTX',0,99);
INSERT INTO `edi_orders_segs` VALUES (8,'RFF',1,1);
INSERT INTO `edi_orders_segs` VALUES (9,'DTM',1,5);
INSERT INTO `edi_orders_segs` VALUES (10,'NAD',2,1);
INSERT INTO `edi_orders_segs` VALUES (11,'LOC',2,99);
INSERT INTO `edi_orders_segs` VALUES (12,'FII',2,5);
INSERT INTO `edi_orders_segs` VALUES (13,'RFF',3,1);
INSERT INTO `edi_orders_segs` VALUES (14,'CTA',5,1);
INSERT INTO `edi_orders_segs` VALUES (15,'COM',5,5);
INSERT INTO `edi_orders_segs` VALUES (16,'TAX',6,1);
INSERT INTO `edi_orders_segs` VALUES (17,'MOA',6,1);
INSERT INTO `edi_orders_segs` VALUES (18,'CUX',7,1);
INSERT INTO `edi_orders_segs` VALUES (19,'DTM',7,5);
INSERT INTO `edi_orders_segs` VALUES (20,'PAT',8,1);
INSERT INTO `edi_orders_segs` VALUES (21,'DTM',8,5);
INSERT INTO `edi_orders_segs` VALUES (22,'PCD',8,1);
INSERT INTO `edi_orders_segs` VALUES (23,'MOA',9,1);
INSERT INTO `edi_orders_segs` VALUES (24,'TDT',10,1);
INSERT INTO `edi_orders_segs` VALUES (25,'LOC',11,1);
INSERT INTO `edi_orders_segs` VALUES (26,'DTM',11,5);
INSERT INTO `edi_orders_segs` VALUES (27,'TOD',12,1);
INSERT INTO `edi_orders_segs` VALUES (28,'LOC',12,2);
INSERT INTO `edi_orders_segs` VALUES (29,'PAC',13,1);
INSERT INTO `edi_orders_segs` VALUES (30,'PCI',14,1);
INSERT INTO `edi_orders_segs` VALUES (31,'RFF',14,1);
INSERT INTO `edi_orders_segs` VALUES (32,'DTM',14,5);
INSERT INTO `edi_orders_segs` VALUES (33,'GIN',14,10);
INSERT INTO `edi_orders_segs` VALUES (34,'EQD',15,1);
INSERT INTO `edi_orders_segs` VALUES (35,'ALC',19,1);
INSERT INTO `edi_orders_segs` VALUES (36,'ALI',19,5);
INSERT INTO `edi_orders_segs` VALUES (37,'DTM',19,5);
INSERT INTO `edi_orders_segs` VALUES (38,'QTY',20,1);
INSERT INTO `edi_orders_segs` VALUES (39,'RNG',20,1);
INSERT INTO `edi_orders_segs` VALUES (40,'PCD',21,1);
INSERT INTO `edi_orders_segs` VALUES (41,'RNG',21,1);
INSERT INTO `edi_orders_segs` VALUES (42,'MOA',22,1);
INSERT INTO `edi_orders_segs` VALUES (43,'RNG',22,1);
INSERT INTO `edi_orders_segs` VALUES (44,'RTE',23,1);
INSERT INTO `edi_orders_segs` VALUES (45,'RNG',23,1);
INSERT INTO `edi_orders_segs` VALUES (46,'TAX',24,1);
INSERT INTO `edi_orders_segs` VALUES (47,'MOA',24,1);
INSERT INTO `edi_orders_segs` VALUES (48,'LIN',28,1);
INSERT INTO `edi_orders_segs` VALUES (49,'PIA',28,25);
INSERT INTO `edi_orders_segs` VALUES (50,'IMD',28,99);
INSERT INTO `edi_orders_segs` VALUES (51,'MEA',28,99);
INSERT INTO `edi_orders_segs` VALUES (52,'QTY',28,99);
INSERT INTO `edi_orders_segs` VALUES (53,'ALI',28,5);
INSERT INTO `edi_orders_segs` VALUES (54,'DTM',28,35);
INSERT INTO `edi_orders_segs` VALUES (55,'MOA',28,10);
INSERT INTO `edi_orders_segs` VALUES (56,'GIN',28,127);
INSERT INTO `edi_orders_segs` VALUES (57,'QVR',28,1);
INSERT INTO `edi_orders_segs` VALUES (58,'FTX',28,99);
INSERT INTO `edi_orders_segs` VALUES (59,'PRI',32,1);
INSERT INTO `edi_orders_segs` VALUES (60,'CUX',32,1);
INSERT INTO `edi_orders_segs` VALUES (61,'DTM',32,5);
INSERT INTO `edi_orders_segs` VALUES (62,'RFF',33,1);
INSERT INTO `edi_orders_segs` VALUES (63,'DTM',33,5);
INSERT INTO `edi_orders_segs` VALUES (64,'PAC',34,1);
INSERT INTO `edi_orders_segs` VALUES (65,'QTY',34,5);
INSERT INTO `edi_orders_segs` VALUES (66,'PCI',36,1);
INSERT INTO `edi_orders_segs` VALUES (67,'RFF',36,1);
INSERT INTO `edi_orders_segs` VALUES (68,'DTM',36,5);
INSERT INTO `edi_orders_segs` VALUES (69,'GIN',36,10);
INSERT INTO `edi_orders_segs` VALUES (70,'LOC',37,1);
INSERT INTO `edi_orders_segs` VALUES (71,'QTY',37,1);
INSERT INTO `edi_orders_segs` VALUES (72,'DTM',37,5);
INSERT INTO `edi_orders_segs` VALUES (73,'TAX',38,1);
INSERT INTO `edi_orders_segs` VALUES (74,'MOA',38,1);
INSERT INTO `edi_orders_segs` VALUES (75,'NAD',39,1);
INSERT INTO `edi_orders_segs` VALUES (76,'CTA',42,1);
INSERT INTO `edi_orders_segs` VALUES (77,'COM',42,5);
INSERT INTO `edi_orders_segs` VALUES (78,'ALC',43,1);
INSERT INTO `edi_orders_segs` VALUES (79,'ALI',43,5);
INSERT INTO `edi_orders_segs` VALUES (80,'DTM',43,5);
INSERT INTO `edi_orders_segs` VALUES (81,'QTY',44,1);
INSERT INTO `edi_orders_segs` VALUES (82,'RNG',44,1);
INSERT INTO `edi_orders_segs` VALUES (83,'PCD',45,1);
INSERT INTO `edi_orders_segs` VALUES (84,'RNG',45,1);
INSERT INTO `edi_orders_segs` VALUES (85,'MOA',46,1);
INSERT INTO `edi_orders_segs` VALUES (86,'RNG',46,1);
INSERT INTO `edi_orders_segs` VALUES (87,'RTE',47,1);
INSERT INTO `edi_orders_segs` VALUES (88,'RNG',47,1);
INSERT INTO `edi_orders_segs` VALUES (89,'TAX',48,1);
INSERT INTO `edi_orders_segs` VALUES (90,'MOA',48,1);
INSERT INTO `edi_orders_segs` VALUES (91,'TDT',49,1);
INSERT INTO `edi_orders_segs` VALUES (92,'UNS',50,1);
INSERT INTO `edi_orders_segs` VALUES (93,'MOA',50,1);
INSERT INTO `edi_orders_segs` VALUES (94,'CNT',50,1);
INSERT INTO `edi_orders_segs` VALUES (95,'UNT',50,1);

--
-- Dumping data for table `ediitemmapping`
--


--
-- Dumping data for table `edimessageformat`
--


--
-- Dumping data for table `emailsettings`
--

INSERT INTO `emailsettings` VALUES (1,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (2,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (3,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (4,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (5,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (6,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (7,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (8,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (9,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (10,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (11,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (12,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (13,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (14,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (15,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (16,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (17,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (18,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (19,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (20,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (21,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (22,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (23,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (24,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (25,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (26,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (27,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (28,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (29,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (30,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (31,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (32,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (33,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (34,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (35,'localhost','25','helo','','',5,'',0);
INSERT INTO `emailsettings` VALUES (36,'localhost','25','helo','','',5,'',0);

--
-- Dumping data for table `factorcompanies`
--


--
-- Dumping data for table `fixedassetcategories`
--

INSERT INTO `fixedassetcategories` VALUES ('PLANT','Plant and Equipment',1650,7750,8100,1670,0.2,1);

--
-- Dumping data for table `fixedassetlocations`
--

INSERT INTO `fixedassetlocations` VALUES ('HEADOF','Head Office','');

--
-- Dumping data for table `fixedassets`
--


--
-- Dumping data for table `fixedassettrans`
--


--
-- Dumping data for table `freightcosts`
--


--
-- Dumping data for table `geocode_param`
--


--
-- Dumping data for table `gltrans`
--

INSERT INTO `gltrans` VALUES (3,26,1,0,'2007-06-14',2,1460,'3 DVD-DHWV x 2 @ 5.25',10.5,1,'',0);
INSERT INTO `gltrans` VALUES (4,26,1,0,'2007-06-14',2,1460,'3 DVD-DHWV x 2 @ 5.25',-10.5,1,'',0);
INSERT INTO `gltrans` VALUES (5,28,2,0,'2007-06-18',2,1460,'3 DVD-TOPGUN x 1 @ 6.50',6.5,1,'',0);
INSERT INTO `gltrans` VALUES (6,28,2,0,'2007-06-18',2,1460,'3 DVD-TOPGUN x 1 @ 6.50',-6.5,1,'',0);
INSERT INTO `gltrans` VALUES (7,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION Component: DVD-DHWV - 10 x 1 @ 5.25',52.5,1,'',0);
INSERT INTO `gltrans` VALUES (8,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION -> DVD-DHWV - 10 x 1 @ 5.25',-52.5,1,'',0);
INSERT INTO `gltrans` VALUES (9,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION Component: DVD-LTWP - 10 x 1 @ 2.85',28.5,1,'',0);
INSERT INTO `gltrans` VALUES (10,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION -> DVD-LTWP - 10 x 1 @ 2.85',-28.5,1,'',0);
INSERT INTO `gltrans` VALUES (11,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION Component: DVD-UNSG - 10 x 1 @ 5.00',50,1,'',0);
INSERT INTO `gltrans` VALUES (12,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION -> DVD-UNSG - 10 x 1 @ 5.00',-50,1,'',0);
INSERT INTO `gltrans` VALUES (13,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION Component: DVD-UNSG2 - 10 x 1 @ 5.00',50,1,'',0);
INSERT INTO `gltrans` VALUES (14,28,3,0,'2007-06-18',2,1460,'3 - DVD_ACTION -> DVD-UNSG2 - 10 x 1 @ 5.00',-50,1,'',0);
INSERT INTO `gltrans` VALUES (15,26,2,0,'2007-06-18',2,1460,'3 DVD_ACTION - Action Series Bundle x 10 @ 18.40',184,1,'',0);
INSERT INTO `gltrans` VALUES (16,26,2,0,'2007-06-18',2,1460,'3 DVD_ACTION - Action Series Bundle x 10 @ 18.40',-184,1,'',0);
INSERT INTO `gltrans` VALUES (17,29,1,0,'2007-06-18',2,1460,'3 - DVD_ACTION share of variance',5,1,'',0);
INSERT INTO `gltrans` VALUES (18,29,1,0,'2007-06-18',2,1460,'3 - DVD_ACTION share of variance',-5,1,'',0);
INSERT INTO `gltrans` VALUES (19,28,4,0,'2007-06-21',2,1440,'5 FLOUR x 4 @ 3.89',15.56,1,'',0);
INSERT INTO `gltrans` VALUES (20,28,4,0,'2007-06-21',2,1460,'5 FLOUR x 4 @ 3.89',-15.56,1,'',0);
INSERT INTO `gltrans` VALUES (21,10,1,0,'2007-06-26',2,5000,'QUARTER - DVD-DHWV x 2 @ 5.2500',10.5,1,'',0);
INSERT INTO `gltrans` VALUES (22,10,1,0,'2007-06-26',2,1460,'QUARTER - DVD-DHWV x 2 @ 5.2500',-10.5,1,'',0);
INSERT INTO `gltrans` VALUES (23,10,1,0,'2007-06-26',2,4100,'QUARTER - DVD-DHWV x 2 @ 15.95',-31.9,1,'',0);
INSERT INTO `gltrans` VALUES (24,10,1,0,'2007-06-26',2,5000,'QUARTER - DVD-LTWP x 1 @ 2.8500',2.85,1,'',0);
INSERT INTO `gltrans` VALUES (25,10,1,0,'2007-06-26',2,1460,'QUARTER - DVD-LTWP x 1 @ 2.8500',-2.85,1,'',0);
INSERT INTO `gltrans` VALUES (26,10,1,0,'2007-06-26',2,4100,'QUARTER - DVD-LTWP x 1 @ 14.5',-14.5,1,'',0);
INSERT INTO `gltrans` VALUES (27,10,1,0,'2007-06-26',2,1100,'QUARTER',46.4,1,'',0);
INSERT INTO `gltrans` VALUES (28,11,1,0,'2007-08-02',3,5000,'QUARTER - DVD-DHWV x 1 @ 5.2500',-5.25,1,'',0);
INSERT INTO `gltrans` VALUES (29,11,1,0,'2007-08-02',3,1460,'QUARTER - DVD-DHWV x 1 @ 5.2500',5.25,1,'',0);
INSERT INTO `gltrans` VALUES (30,11,1,0,'2007-08-02',3,4100,'QUARTER - DVD-DHWV x 1 @ 15.950',15.95,1,'',0);
INSERT INTO `gltrans` VALUES (31,11,1,0,'2007-08-02',3,1100,'QUARTER',-15.95,1,'',0);
INSERT INTO `gltrans` VALUES (32,35,3,0,'2007-08-08',3,5700,'DVD-LTWP cost was 2.85 changed to 2.65 x Quantity on hand of -11',-2.2,1,'',0);
INSERT INTO `gltrans` VALUES (33,35,3,0,'2007-08-08',3,1460,'DVD-LTWP cost was 2.85 changed to 2.65 x Quantity on hand of -11',2.2,1,'',0);
INSERT INTO `gltrans` VALUES (34,35,4,0,'2007-08-08',3,5700,'DVD-LTWP cost was 2.65 changed to 2.66 x Quantity on hand of -11',0.11,1,'',0);
INSERT INTO `gltrans` VALUES (35,35,4,0,'2007-08-08',3,1460,'DVD-LTWP cost was 2.65 changed to 2.66 x Quantity on hand of -11',-0.11,1,'',0);
INSERT INTO `gltrans` VALUES (36,35,5,0,'2007-08-08',3,5700,'DVD-LTWP cost was 2.66 changed to 2.7 x Quantity on hand of -11',0.44,1,'',0);
INSERT INTO `gltrans` VALUES (37,35,5,0,'2007-08-08',3,1460,'DVD-LTWP cost was 2.66 changed to 2.7 x Quantity on hand of -11',-0.44,1,'',0);
INSERT INTO `gltrans` VALUES (38,35,6,0,'2007-08-08',3,5700,'DVD_ACTION cost was 19.3000 changed to 19.15 x Quantity on hand of 10',1.5,1,'',0);
INSERT INTO `gltrans` VALUES (39,35,6,0,'2007-08-08',3,1460,'DVD_ACTION cost was 19.3000 changed to 19.15 x Quantity on hand of 10',-1.5,1,'',0);
INSERT INTO `gltrans` VALUES (40,35,7,0,'2007-08-09',3,5700,'DVD-DHWV cost was 5.25 changed to 5.3 x Quantity on hand of -13',0.65,1,'',0);
INSERT INTO `gltrans` VALUES (41,35,7,0,'2007-08-09',3,1460,'DVD-DHWV cost was 5.25 changed to 5.3 x Quantity on hand of -13',-0.65,1,'',0);
INSERT INTO `gltrans` VALUES (42,35,8,0,'2007-08-09',3,5700,'DVD_ACTION cost was 19.1500 changed to 19.2 x Quantity on hand of 10',-0.50000000000001,1,'',0);
INSERT INTO `gltrans` VALUES (43,35,8,0,'2007-08-09',3,1460,'DVD_ACTION cost was 19.1500 changed to 19.2 x Quantity on hand of 10',0.50000000000001,1,'',0);
INSERT INTO `gltrans` VALUES (44,35,9,0,'2007-08-09',3,5700,'DVD-DHWV cost was 5.3 changed to 5.35 x Quantity on hand of -13',0.65,1,'',0);
INSERT INTO `gltrans` VALUES (45,35,9,0,'2007-08-09',3,1460,'DVD-DHWV cost was 5.3 changed to 5.35 x Quantity on hand of -13',-0.65,1,'',0);
INSERT INTO `gltrans` VALUES (46,35,10,0,'2007-08-09',3,5700,'DVD_ACTION cost was 19.2000 changed to 19.25 x Quantity on hand of 10',-0.50000000000001,1,'',0);
INSERT INTO `gltrans` VALUES (47,35,10,0,'2007-08-09',3,1460,'DVD_ACTION cost was 19.2000 changed to 19.25 x Quantity on hand of 10',0.50000000000001,1,'',0);
INSERT INTO `gltrans` VALUES (48,35,11,0,'2007-08-09',3,5700,'DVD-DHWV cost was 5.35 changed to 5.5 x Quantity on hand of -13',1.95,1,'',0);
INSERT INTO `gltrans` VALUES (49,35,11,0,'2007-08-09',3,1460,'DVD-DHWV cost was 5.35 changed to 5.5 x Quantity on hand of -13',-1.95,1,'',0);
INSERT INTO `gltrans` VALUES (50,35,12,0,'2007-08-09',3,5700,'DVD_ACTION cost was 19.2500 changed to 19.4 x Quantity on hand of 10',-1.5,1,'',0);
INSERT INTO `gltrans` VALUES (51,35,12,0,'2007-08-09',3,1460,'DVD_ACTION cost was 19.2500 changed to 19.4 x Quantity on hand of 10',1.5,1,'',0);
INSERT INTO `gltrans` VALUES (52,35,13,0,'2007-08-09',3,5700,'DVD-DHWV cost was 5.5 changed to 2.32 x Quantity on hand of -13',-41.34,1,'',0);
INSERT INTO `gltrans` VALUES (53,35,13,0,'2007-08-09',3,1460,'DVD-DHWV cost was 5.5 changed to 2.32 x Quantity on hand of -13',41.34,1,'',0);
INSERT INTO `gltrans` VALUES (54,35,14,0,'2007-08-09',3,5700,'DVD_ACTION cost was 19.4000 changed to 16.22 x Quantity on hand of 10',31.8,1,'',0);
INSERT INTO `gltrans` VALUES (55,35,14,0,'2007-08-09',3,1460,'DVD_ACTION cost was 19.4000 changed to 16.22 x Quantity on hand of 10',-31.8,1,'',0);
INSERT INTO `gltrans` VALUES (56,12,1,0,'2007-10-23',5,6100,'test',-150,1,'',0);
INSERT INTO `gltrans` VALUES (57,12,1,0,'2007-10-23',5,1030,'',150,1,'',0);
INSERT INTO `gltrans` VALUES (58,28,5,0,'2008-06-27',13,1440,'5 - BREAD Component: SALT - 12 x 0.025 @ 2.50',0.75,1,'',0);
INSERT INTO `gltrans` VALUES (59,1,2,0,'2008-07-26',14,1350,'testrg',500,1,'',0);
INSERT INTO `gltrans` VALUES (60,1,2,0,'2008-07-26',14,1030,'',-500,1,'',0);
INSERT INTO `gltrans` VALUES (61,12,2,0,'2009-02-04',21,1030,'',99,1,'',0);
INSERT INTO `gltrans` VALUES (62,12,2,0,'2009-02-04',21,1100,'',-99,1,'',0);
INSERT INTO `gltrans` VALUES (63,12,3,0,'2009-02-04',21,1420,'',-299,1,'',0);
INSERT INTO `gltrans` VALUES (64,12,3,0,'2009-02-04',21,1030,'',299,1,'',0);
INSERT INTO `gltrans` VALUES (65,35,15,0,'2009-02-04',21,5700,'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10',0,1,'',0);
INSERT INTO `gltrans` VALUES (66,35,15,0,'2009-02-04',21,1460,'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10',0,1,'',0);
INSERT INTO `gltrans` VALUES (67,35,16,0,'2009-02-04',21,5700,'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10',0,1,'',0);
INSERT INTO `gltrans` VALUES (68,35,16,0,'2009-02-04',21,1460,'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10',0,1,'',0);
INSERT INTO `gltrans` VALUES (69,35,17,0,'2009-02-04',21,5700,'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10',0,1,'',0);
INSERT INTO `gltrans` VALUES (70,35,17,0,'2009-02-04',21,1460,'DVD_ACTION cost was 16.2200 changed to 16.22 x Quantity on hand of 10',0,1,'',0);
INSERT INTO `gltrans` VALUES (71,25,18,0,'2009-02-04',21,1460,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (72,25,18,0,'2009-02-04',21,2150,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (73,25,19,0,'2009-02-05',21,1460,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (74,25,19,0,'2009-02-05',21,2150,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (75,25,20,0,'2009-02-05',21,1460,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (76,25,20,0,'2009-02-05',21,2150,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (77,25,21,0,'2009-02-05',21,1460,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (78,25,21,0,'2009-02-05',21,2150,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (79,25,22,0,'2009-02-05',21,1460,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (80,25,22,0,'2009-02-05',21,2150,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (81,25,23,0,'2009-02-05',21,1460,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (82,25,23,0,'2009-02-05',21,2150,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (83,25,24,0,'2009-02-05',21,1460,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (84,25,24,0,'2009-02-05',21,2150,'PO: 1 CAMPBELL - DVD-LTWP - Lethal Weapon Linked x 1 @ 2.70',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (85,25,25,0,'2009-02-05',21,1460,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (86,25,25,0,'2009-02-05',21,2150,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',-2.5,1,'',0);
INSERT INTO `gltrans` VALUES (87,25,26,0,'2009-02-05',21,1460,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (88,25,26,0,'2009-02-05',21,2150,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',-2.5,1,'',0);
INSERT INTO `gltrans` VALUES (89,25,27,0,'2009-02-05',21,1460,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (90,25,27,0,'2009-02-05',21,2150,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',-2.5,1,'',0);
INSERT INTO `gltrans` VALUES (91,25,28,0,'2009-02-05',21,1460,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (92,25,28,0,'2009-02-05',21,2150,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',-2.5,1,'',0);
INSERT INTO `gltrans` VALUES (93,25,29,0,'2009-02-05',21,1460,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (94,25,29,0,'2009-02-05',21,2150,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',-2.5,1,'',0);
INSERT INTO `gltrans` VALUES (95,25,30,0,'2009-02-05',21,1460,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (96,25,30,0,'2009-02-05',21,2150,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',-2.5,1,'',0);
INSERT INTO `gltrans` VALUES (97,25,31,0,'2009-02-05',21,1460,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (98,25,31,0,'2009-02-05',21,2150,'PO: 2 GOTSTUFF - SALT - Salt x 1 @ 2.50',-2.5,1,'',0);
INSERT INTO `gltrans` VALUES (99,17,17,0,'2009-02-05',21,5700,'BREAD x 100 @ 6.0085 ',-600.85,1,'',0);
INSERT INTO `gltrans` VALUES (100,17,17,0,'2009-02-05',21,1460,'BREAD x 100 @ 6.0085 ',600.85,1,'',0);
INSERT INTO `gltrans` VALUES (101,10,4,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 3 @ 6.0085',18.0255,0,'',0);
INSERT INTO `gltrans` VALUES (102,10,4,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 3 @ 6.0085',-18.0255,0,'',0);
INSERT INTO `gltrans` VALUES (103,10,4,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 3 @ 6.9',-20.7,0,'',0);
INSERT INTO `gltrans` VALUES (104,10,4,0,'2010-05-31',-11,4900,'ANGRY - BREAD @ 10%',2.07,0,'',0);
INSERT INTO `gltrans` VALUES (105,10,4,0,'2010-05-31',-11,5000,'ANGRY - SALT x 3 @ 2.5000',7.5,0,'',0);
INSERT INTO `gltrans` VALUES (106,10,4,0,'2010-05-31',-11,1460,'ANGRY - SALT x 3 @ 2.5000',-7.5,0,'',0);
INSERT INTO `gltrans` VALUES (107,10,4,0,'2010-05-31',-11,4100,'ANGRY - SALT x 3 @ 3.25',-9.75,0,'',0);
INSERT INTO `gltrans` VALUES (108,10,4,0,'2010-05-31',-11,1100,'ANGRY',28.38,0,'',0);
INSERT INTO `gltrans` VALUES (109,10,5,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 4 @ 6.0085',24.034,0,'',0);
INSERT INTO `gltrans` VALUES (110,10,5,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 4 @ 6.0085',-24.034,0,'',0);
INSERT INTO `gltrans` VALUES (111,10,5,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 4 @ 6.9',-27.6,0,'',0);
INSERT INTO `gltrans` VALUES (112,10,5,0,'2010-05-31',-11,4900,'ANGRY - BREAD @ 15%',4.14,0,'',0);
INSERT INTO `gltrans` VALUES (113,10,5,0,'2010-05-31',-11,5000,'ANGRY - SALT x 1 @ 2.5000',2.5,0,'',0);
INSERT INTO `gltrans` VALUES (114,10,5,0,'2010-05-31',-11,1460,'ANGRY - SALT x 1 @ 2.5000',-2.5,0,'',0);
INSERT INTO `gltrans` VALUES (115,10,5,0,'2010-05-31',-11,4100,'ANGRY - SALT x 1 @ 2.99',-2.99,0,'',0);
INSERT INTO `gltrans` VALUES (116,10,5,0,'2010-05-31',-11,4900,'ANGRY - SALT @ 1.5%',0.04485,0,'',0);
INSERT INTO `gltrans` VALUES (117,10,5,0,'2010-05-31',-11,1100,'ANGRY',26.40515,0,'',0);
INSERT INTO `gltrans` VALUES (118,10,6,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 2 @ 6.0085',12.017,0,'',0);
INSERT INTO `gltrans` VALUES (119,10,6,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 2 @ 6.0085',-12.017,0,'',0);
INSERT INTO `gltrans` VALUES (120,10,6,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 2 @ 12',-24,0,'',0);
INSERT INTO `gltrans` VALUES (121,10,6,0,'2010-05-31',-11,1100,'ANGRY',24,0,'',0);
INSERT INTO `gltrans` VALUES (122,10,7,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 5 @ 6.0085',30.0425,0,'',0);
INSERT INTO `gltrans` VALUES (123,10,7,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 5 @ 6.0085',-30.0425,0,'',0);
INSERT INTO `gltrans` VALUES (124,11,2,0,'2010-05-31',36,5000,'ANGRY - BREAD x 5 @ 6.0085',-30.04,0,'',0);
INSERT INTO `gltrans` VALUES (125,11,2,0,'2010-05-31',36,1460,'ANGRY - BREAD x 5 @ 6.0085',30.04,0,'',0);
INSERT INTO `gltrans` VALUES (130,10,9,0,'2010-05-31',-11,5000,'ANGRY - SALT x 2 @ 2.5000',5,0,'',0);
INSERT INTO `gltrans` VALUES (131,10,9,0,'2010-05-31',-11,1460,'ANGRY - SALT x 2 @ 2.5000',-5,0,'',0);
INSERT INTO `gltrans` VALUES (132,10,9,0,'2010-05-31',-11,4100,'ANGRY - SALT x 2 @ 25',-50,0,'',0);
INSERT INTO `gltrans` VALUES (133,10,9,0,'2010-05-31',-11,1100,'ANGRY',50,0,'',0);
INSERT INTO `gltrans` VALUES (136,10,10,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 2 @ 6.0085',12.017,0,'',0);
INSERT INTO `gltrans` VALUES (137,10,10,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 2 @ 6.0085',-12.017,0,'',0);
INSERT INTO `gltrans` VALUES (138,10,10,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 2 @ 5.25',-10.5,0,'',0);
INSERT INTO `gltrans` VALUES (139,10,10,0,'2010-05-31',-11,1100,'ANGRY',10.5,0,'',0);
INSERT INTO `gltrans` VALUES (140,12,5,0,'2010-05-31',-11,1040,'Melbourne Counter Sale 10',10.5,0,'',0);
INSERT INTO `gltrans` VALUES (141,12,5,0,'2010-05-31',-11,1100,'Melbourne Counter Sale 10',-10.5,0,'',0);
INSERT INTO `gltrans` VALUES (142,10,11,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 1 @ 6.0085',6.0085,0,'',0);
INSERT INTO `gltrans` VALUES (143,10,11,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 1 @ 6.0085',-6.0085,0,'',0);
INSERT INTO `gltrans` VALUES (144,10,11,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 1 @ 5',-5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (145,10,11,0,'2010-05-31',-11,1100,'ANGRY',5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (148,10,12,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 1 @ 6.0085',6.0085,0,'',0);
INSERT INTO `gltrans` VALUES (149,10,12,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 1 @ 6.0085',-6.0085,0,'',0);
INSERT INTO `gltrans` VALUES (150,10,12,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 1 @ 5',-5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (151,10,12,0,'2010-05-31',-11,1100,'ANGRY',5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (154,10,13,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 1 @ 6.0085',6.0085,0,'',0);
INSERT INTO `gltrans` VALUES (155,10,13,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 1 @ 6.0085',-6.0085,0,'',0);
INSERT INTO `gltrans` VALUES (156,10,13,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 1 @ 5',-5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (157,10,13,0,'2010-05-31',-11,1100,'ANGRY',5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (158,12,8,0,'2010-05-31',-11,1030,'Melbourne Counter Sale 13',5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (159,12,8,0,'2010-05-31',-11,1100,'Melbourne Counter Sale 13',-5.8823529411765,0,'',0);
INSERT INTO `gltrans` VALUES (160,10,14,0,'2010-05-31',-11,5000,'ANGRY - BREAD x 12 @ 6.0085',72.102,0,'',0);
INSERT INTO `gltrans` VALUES (161,10,14,0,'2010-05-31',-11,1460,'ANGRY - BREAD x 12 @ 6.0085',-72.102,0,'',0);
INSERT INTO `gltrans` VALUES (162,10,14,0,'2010-05-31',-11,4100,'ANGRY - BREAD x 12 @ 9.50',-134.11764705882,0,'',0);
INSERT INTO `gltrans` VALUES (163,10,14,0,'2010-05-31',-11,5000,'ANGRY - SALT x .7 @ 2.5000',1.75,0,'',0);
INSERT INTO `gltrans` VALUES (164,10,14,0,'2010-05-31',-11,1460,'ANGRY - SALT x .7 @ 2.5000',-1.75,0,'',0);
INSERT INTO `gltrans` VALUES (165,10,14,0,'2010-05-31',-11,4100,'ANGRY - SALT x .7 @ 5',-4.1176470588235,0,'',0);
INSERT INTO `gltrans` VALUES (166,10,14,0,'2010-05-31',-11,1100,'ANGRY',138.23529411765,0,'',0);
INSERT INTO `gltrans` VALUES (167,12,9,0,'2010-05-31',-11,1030,'Melbourne Counter Sale 14',138.23529411765,0,'',0);
INSERT INTO `gltrans` VALUES (168,12,9,0,'2010-05-31',-11,1100,'Melbourne Counter Sale 14',-138.23529411765,0,'',0);
INSERT INTO `gltrans` VALUES (169,20,18,0,'2010-08-13',0,6100,'CRUISE ',62.5,1,'',0);
INSERT INTO `gltrans` VALUES (170,20,18,0,'2010-08-13',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',31.69375,1,'',0);
INSERT INTO `gltrans` VALUES (171,20,18,0,'2010-08-13',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',15,1,'',0);
INSERT INTO `gltrans` VALUES (172,20,18,0,'2010-08-13',0,2100,'CRUISE - Inv assssa GBP50.00 @ a rate of 0.8',-109.19,1,'',0);
INSERT INTO `gltrans` VALUES (175,20,20,0,'2010-08-13',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',1569.0625,1,'',0);
INSERT INTO `gltrans` VALUES (176,20,20,0,'2010-08-13',0,2100,'CRUISE - Inv 21221-DFR GBP1,255.25 @ a rate of 0.8',-1569.06,1,'',0);
INSERT INTO `gltrans` VALUES (177,20,21,0,'2010-08-13',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',12.5,1,'',0);
INSERT INTO `gltrans` VALUES (178,20,21,0,'2010-08-13',0,2100,'CRUISE - Inv 9877 GBP10.00 @ a rate of 0.8',-12.5,1,'',0);
INSERT INTO `gltrans` VALUES (179,20,22,0,'2010-08-13',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',125,1,'',0);
INSERT INTO `gltrans` VALUES (180,20,22,0,'2010-08-13',0,2100,'CRUISE - Inv 9877-877 GBP100.00 @ a rate of 0.8',-125,1,'',0);
INSERT INTO `gltrans` VALUES (181,21,5,0,'0000-00-00',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',-112.5,1,'',0);
INSERT INTO `gltrans` VALUES (182,21,5,0,'2010-08-13',0,2310,'CRUISE - Credit note 30299 GBP0 @ a rate of 0.8',0,1,'',0);
INSERT INTO `gltrans` VALUES (183,21,5,0,'2010-08-13',0,2100,'CRUISE - Credit Note 30299 GBP90.00 @ a rate of 0.8',112.5,1,'',0);
INSERT INTO `gltrans` VALUES (184,21,6,0,'0000-00-00',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',-125,1,'',0);
INSERT INTO `gltrans` VALUES (185,21,6,0,'2010-08-13',0,2100,'CRUISE - Credit Note 57748-OPP GBP100.00 @ a rate of 0.8',125,1,'',0);
INSERT INTO `gltrans` VALUES (186,21,7,0,'0000-00-00',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',-122.7625,1,'',0);
INSERT INTO `gltrans` VALUES (187,21,7,0,'0000-00-00',0,1440,'CRUISE Contract charge against BirthdayCakeConstruc',-7.75,1,'',0);
INSERT INTO `gltrans` VALUES (188,21,7,0,'2010-08-13',0,2100,'CRUISE - Credit Note 9sjkja_099 GBP104.41 @ a rate of 0.8',130.51,1,'',0);
INSERT INTO `gltrans` VALUES (189,28,6,0,'2010-08-14',0,1440,'12 BREAD x 3.5 @ 6.01',21.02975,1,'',0);
INSERT INTO `gltrans` VALUES (190,28,6,0,'2010-08-14',0,1460,'12 BREAD x 3.5 @ 6.01',-21.02975,1,'',0);
INSERT INTO `gltrans` VALUES (191,28,7,0,'2010-08-15',0,1440,'12 BREAD x 2 @ 6.01',12.017,1,'',0);
INSERT INTO `gltrans` VALUES (192,28,7,0,'2010-08-15',0,1460,'12 BREAD x 2 @ 6.01',-12.017,1,'',0);
INSERT INTO `gltrans` VALUES (193,17,18,0,'2010-08-15',0,5700,'DVD-CASE x 180 @ 0.3 ',-54,1,'',0);
INSERT INTO `gltrans` VALUES (194,17,18,0,'2010-08-15',0,1460,'DVD-CASE x 180 @ 0.3 ',54,1,'',0);
INSERT INTO `gltrans` VALUES (195,28,8,0,'2010-08-15',0,1440,'12 DVD-CASE x 1 @ 0.30',0.3,1,'',0);
INSERT INTO `gltrans` VALUES (196,28,8,0,'2010-08-15',0,1460,'12 DVD-CASE x 1 @ 0.30',-0.3,1,'',0);
INSERT INTO `gltrans` VALUES (197,17,19,0,'2010-08-15',0,5700,'YEAST x 9.95 @ 5 ',-49.75,1,'',0);
INSERT INTO `gltrans` VALUES (198,17,19,0,'2010-08-15',0,1460,'YEAST x 9.95 @ 5 ',49.75,1,'',0);
INSERT INTO `gltrans` VALUES (199,28,9,0,'2010-08-15',0,1440,'12 YEAST x .75 @ 5.00',3.75,1,'',0);
INSERT INTO `gltrans` VALUES (200,28,9,0,'2010-08-15',0,1460,'12 YEAST x .75 @ 5.00',-3.75,1,'',0);
INSERT INTO `gltrans` VALUES (201,17,20,0,'2010-08-15',0,5700,'SALT x 25 @ 2.5 ',-62.5,1,'',0);
INSERT INTO `gltrans` VALUES (202,17,20,0,'2010-08-15',0,1460,'SALT x 25 @ 2.5 ',62.5,1,'',0);
INSERT INTO `gltrans` VALUES (203,28,10,0,'2010-08-15',0,1440,'12 SALT x 1.3 @ 2.50',3.25,1,'',0);
INSERT INTO `gltrans` VALUES (204,28,10,0,'2010-08-15',0,1460,'12 SALT x 1.3 @ 2.50',-3.25,1,'',0);
INSERT INTO `gltrans` VALUES (205,32,2,0,'2010-08-22',1,1440,'Variance on contract BirthdayCakeConstruc',470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (206,32,2,0,'2010-08-22',1,5000,'Variance on contract BirthdayCakeConstruc',-470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (209,32,4,0,'2010-08-22',1,1440,'Variance on contract BirthdayCakeConstruc',470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (210,32,4,0,'2010-08-22',1,5000,'Variance on contract BirthdayCakeConstruc',-470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (213,32,5,0,'2010-08-22',1,1440,'Variance on contract BirthdayCakeConstruc',470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (214,32,5,0,'2010-08-22',1,5000,'Variance on contract BirthdayCakeConstruc',-470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (215,32,6,0,'2010-08-22',1,1440,'Variance on contract BirthdayCakeConstruc',470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (216,32,6,0,'2010-08-22',1,5000,'Variance on contract BirthdayCakeConstruc',-470.97925,1,'',0);
INSERT INTO `gltrans` VALUES (217,11,3,0,'2011-02-16',6,5000,'DUMBLE - DVD-CASE x 2 @ 0.3000',-0.6,1,'',0);
INSERT INTO `gltrans` VALUES (218,11,3,0,'2011-02-16',6,1460,'DUMBLE - DVD-CASE x 2 @ 0.3000',0.6,1,'',0);
INSERT INTO `gltrans` VALUES (219,11,4,0,'2011-02-16',6,5000,'DUMBLE - FLOUR x 12 @ 3.8900',-46.68,1,'',0);
INSERT INTO `gltrans` VALUES (220,11,4,0,'2011-02-16',6,1460,'DUMBLE - FLOUR x 12 @ 3.8900',46.68,1,'',0);
INSERT INTO `gltrans` VALUES (221,11,4,0,'2011-02-16',6,4100,'DUMBLE - FLOUR x 12 @ 1.4',21,1,'',0);
INSERT INTO `gltrans` VALUES (222,11,4,0,'2011-02-16',6,1100,'DUMBLE',-21,1,'',0);
INSERT INTO `gltrans` VALUES (223,11,5,0,'2011-02-16',6,5000,'ANGRY - BREAD x 2 @ 6.0085',-12.02,1,'',0);
INSERT INTO `gltrans` VALUES (224,11,5,0,'2011-02-16',6,1460,'ANGRY - BREAD x 2 @ 6.0085',12.02,1,'',0);
INSERT INTO `gltrans` VALUES (225,11,5,0,'2011-02-16',6,4100,'ANGRY - BREAD x 2 @ 12.0000',24,1,'',0);
INSERT INTO `gltrans` VALUES (226,11,5,0,'2011-02-16',6,1100,'ANGRY',-24,1,'',0);
INSERT INTO `gltrans` VALUES (227,25,32,0,'2011-03-10',7,1460,'PO: 1 CAMPBELL - DVD-CASE - webERP Demo DVD Case x 45 @ 0.30',13.5,1,'',0);
INSERT INTO `gltrans` VALUES (228,25,32,0,'2011-03-10',7,2150,'PO1299749410: 1 CAMPBELL - DVD-CASE - webERP Demo DVD Case x 45 @ 0.30',-13.5,1,'',0);
INSERT INTO `gltrans` VALUES (229,0,3,0,'2011-02-28',6,1080,'toast',25,1,'',0);
INSERT INTO `gltrans` VALUES (230,0,3,0,'2011-02-28',6,1090,'bread',-25,1,'',0);
INSERT INTO `gltrans` VALUES (231,12,10,0,'2011-03-23',7,1030,'',11.764705882353,1,'',0);
INSERT INTO `gltrans` VALUES (232,12,10,0,'2011-03-23',7,1100,'',-11.764705882353,1,'',0);
INSERT INTO `gltrans` VALUES (233,11,6,0,'2011-03-26',7,5000,'DUMBLE - DVD-LTWP x 1 @ 2.7000',-2.7,1,'',0);
INSERT INTO `gltrans` VALUES (234,11,6,0,'2011-03-26',7,1460,'DUMBLE - DVD-LTWP x 1 @ 2.7000',2.7,1,'',0);
INSERT INTO `gltrans` VALUES (235,11,6,0,'2011-03-26',7,4100,'DUMBLE - DVD-LTWP x 1 @ 5.75',7.1875,1,'',0);
INSERT INTO `gltrans` VALUES (236,11,6,0,'2011-03-26',7,1100,'DUMBLE',-7.1875,1,'',0);
INSERT INTO `gltrans` VALUES (237,11,7,0,'2011-03-29',7,5000,'ANGRY - BREAD x 3 @ 6.0085',-18.03,1,'',0);
INSERT INTO `gltrans` VALUES (238,11,7,0,'2011-03-29',7,1460,'ANGRY - BREAD x 3 @ 6.0085',18.03,1,'',0);
INSERT INTO `gltrans` VALUES (239,11,7,0,'2011-03-29',7,4100,'ANGRY - BREAD x 3 @ 6.9000',20.7,1,'',0);
INSERT INTO `gltrans` VALUES (240,11,7,0,'2011-03-29',7,4900,'ANGRY - BREAD @ 10%',-2.07,1,'',0);
INSERT INTO `gltrans` VALUES (241,11,7,0,'2011-03-29',7,5000,'ANGRY - SALT x 3 @ 2.5000',-7.5,1,'',0);
INSERT INTO `gltrans` VALUES (242,11,7,0,'2011-03-29',7,1460,'ANGRY - SALT x 3 @ 2.5000',7.5,1,'',0);
INSERT INTO `gltrans` VALUES (243,11,7,0,'2011-03-29',7,4100,'ANGRY - SALT x 3 @ 3.2500',9.75,1,'',0);
INSERT INTO `gltrans` VALUES (244,11,7,0,'2011-03-29',7,1100,'ANGRY',-28.38,1,'',0);
INSERT INTO `gltrans` VALUES (245,20,23,0,'2011-04-03',8,4600,'CRUISE ',62.5,1,'',0);
INSERT INTO `gltrans` VALUES (246,20,23,0,'2011-04-03',8,7400,'CRUISE ',119.94,1,'',0);
INSERT INTO `gltrans` VALUES (247,20,23,0,'2011-04-03',8,2100,'CRUISE - Inv 389100 GBP145.95 @ a rate of 0.8',-182.44,1,'',0);
INSERT INTO `gltrans` VALUES (248,10,15,0,'2011-04-18',8,5000,'QUICK - DVD-CASE x 5 @ 0.3000',1.5,1,'',0);
INSERT INTO `gltrans` VALUES (249,10,15,0,'2011-04-18',8,1460,'QUICK - DVD-CASE x 5 @ 0.3000',-1.5,1,'',0);
INSERT INTO `gltrans` VALUES (250,10,15,0,'2011-04-18',8,4100,'QUICK - DVD-CASE x 5 @ 16.5',-97.058823529412,1,'',0);
INSERT INTO `gltrans` VALUES (251,10,15,0,'2011-04-18',8,4900,'QUICK - DVD-CASE @ 5%',4.8529411764706,1,'',0);
INSERT INTO `gltrans` VALUES (252,10,15,0,'2011-04-18',8,5000,'QUICK - SALT x 4 @ 2.5000',10,1,'',0);
INSERT INTO `gltrans` VALUES (253,10,15,0,'2011-04-18',8,1460,'QUICK - SALT x 4 @ 2.5000',-10,1,'',0);
INSERT INTO `gltrans` VALUES (254,10,15,0,'2011-04-18',8,4100,'QUICK - SALT x 4 @ 3.5',-16.470588235294,1,'',0);
INSERT INTO `gltrans` VALUES (255,10,15,0,'2011-04-18',8,4900,'QUICK - SALT @ 2.5%',0.41176470588235,1,'',0);
INSERT INTO `gltrans` VALUES (256,10,15,0,'2011-04-18',8,1100,'QUICK',108.27058823529,1,'',0);
INSERT INTO `gltrans` VALUES (257,35,18,0,'2011-05-01',9,5700,'BREAD cost was 6.0085 changed to 6.01225 x Quantity on hand of 73.5',-0.27562500000001,1,'',0);
INSERT INTO `gltrans` VALUES (258,35,18,0,'2011-05-01',9,1460,'BREAD cost was 6.0085 changed to 6.01225 x Quantity on hand of 73.5',0.27562500000001,1,'',0);
INSERT INTO `gltrans` VALUES (259,35,19,0,'2011-05-01',9,5700,'BREAD cost was 6.0123 changed to 5.58725 x Quantity on hand of 73.5',31.241175,1,'',0);
INSERT INTO `gltrans` VALUES (260,35,19,0,'2011-05-01',9,1460,'BREAD cost was 6.0123 changed to 5.58725 x Quantity on hand of 73.5',-31.241175,1,'',0);
INSERT INTO `gltrans` VALUES (261,10,16,0,'2011-05-03',9,5000,'QUICK - FLOUR x 4 @ 3.8900',15.56,1,'',0);
INSERT INTO `gltrans` VALUES (262,10,16,0,'2011-05-03',9,1460,'QUICK - FLOUR x 4 @ 3.8900',-15.56,1,'',0);
INSERT INTO `gltrans` VALUES (263,10,16,0,'2011-05-03',9,4100,'QUICK - FLOUR x 4 @ 244.224',-1149.2894117647,1,'',0);
INSERT INTO `gltrans` VALUES (264,10,16,0,'2011-05-03',9,4900,'QUICK - FLOUR @ 2.5%',28.732235294118,1,'',0);
INSERT INTO `gltrans` VALUES (265,10,16,0,'2011-05-03',9,1100,'QUICK',1120.5529411765,1,'',0);
INSERT INTO `gltrans` VALUES (266,20,24,0,'2011-05-17',9,1600,'BINGO ',22.73,1,'',0);
INSERT INTO `gltrans` VALUES (267,20,24,0,'2011-05-17',9,2310,'BINGO - Inv asass Australian GST 10.00% USD2.5 @ exch rate 1.1',2.27,1,'',0);
INSERT INTO `gltrans` VALUES (268,20,24,0,'2011-05-17',9,2100,'BINGO - Inv asass USD27.50 @ a rate of 1.1',-25,1,'',0);
INSERT INTO `gltrans` VALUES (269,25,33,0,'2011-05-19',9,1800,'PO: 17 GOTSTUFF -  - Some rubbish or other x 3 @ 55,000.00',165000,1,'',0);
INSERT INTO `gltrans` VALUES (270,25,33,0,'2011-05-19',9,2150,'PO1305794408: 17 GOTSTUFF -  - Some rubbish or other x 3 @ 55,000.00',-165000,1,'',0);
INSERT INTO `gltrans` VALUES (271,20,25,0,'2011-05-18',9,7650,'GOTSTUFF Parking',15.41,1,'',0);
INSERT INTO `gltrans` VALUES (272,20,25,0,'2011-05-18',9,2150,'GOTSTUFF - GRN 14 - SALT x 1 @  std cost of 2.5',2.5,1,'',0);
INSERT INTO `gltrans` VALUES (273,20,25,0,'2011-05-18',9,1460,'GOTSTUFF - Average Cost Adj - SALT x 22.7 x 88.41',88.409090909091,1,'',0);
INSERT INTO `gltrans` VALUES (274,20,25,0,'2011-05-18',9,2150,'GOTSTUFF - GRN 16 -  x 3 @  std cost of 55000',165000,1,'',0);
INSERT INTO `gltrans` VALUES (275,20,25,0,'2011-05-18',9,1800,'GOTSTUFF - GRN 16 - Some rubbish or other x 3 x  price var -10854.55',-32563.636363636,1,'',0);
INSERT INTO `gltrans` VALUES (276,20,25,0,'2011-05-18',9,2310,'GOTSTUFF - Inv 43434343 Australian GST 10.00% USD14579.695 @ exch rate 1.1',13254.27,1,'',0);
INSERT INTO `gltrans` VALUES (277,20,25,0,'2011-05-18',9,2100,'GOTSTUFF - Inv 43434343 USD160,376.65 @ a rate of 1.1',-145796.95,1,'',0);
INSERT INTO `gltrans` VALUES (278,25,34,0,'2011-05-19',9,1460,'PO: 2 GOTSTUFF - SALT - Salt x 2 @ 6.39',12.7894,1,'',0);
INSERT INTO `gltrans` VALUES (279,25,34,0,'2011-05-19',9,2150,'PO1305801077: 2 GOTSTUFF - SALT - Salt x 2 @ 6.39',-12.7894,1,'',0);
INSERT INTO `gltrans` VALUES (280,12,11,0,'2011-05-26',9,1300,'bull',-34,1,'',0);
INSERT INTO `gltrans` VALUES (281,12,11,0,'2011-05-26',9,1030,'test',34,1,'',0);
INSERT INTO `gltrans` VALUES (282,17,21,0,'2011-05-30',9,5700,'HIT3043-5 x 5 @ 1235 ',-6175,1,'',0);
INSERT INTO `gltrans` VALUES (283,17,21,0,'2011-05-30',9,1460,'HIT3043-5 x 5 @ 1235 ',6175,1,'',0);
INSERT INTO `gltrans` VALUES (284,10,17,0,'2011-08-09',12,5000,'ANGRY - BREAD x 2 @ 5.5873',11.1746,1,'',0);
INSERT INTO `gltrans` VALUES (285,10,17,0,'2011-08-09',12,1460,'ANGRY - BREAD x 2 @ 5.5873',-11.1746,1,'',0);
INSERT INTO `gltrans` VALUES (286,10,17,0,'2011-08-09',12,4100,'ANGRY - BREAD x 2 @ 5.98',-10.872727272727,1,'',0);
INSERT INTO `gltrans` VALUES (287,10,17,0,'2011-08-09',12,1100,'ANGRY',12.181818181818,1,'',0);
INSERT INTO `gltrans` VALUES (288,10,17,0,'2011-08-09',12,2300,'ANGRY',-0.54363636363636,1,'',0);
INSERT INTO `gltrans` VALUES (289,10,17,0,'2011-08-09',12,2300,'ANGRY',-0.76109090909091,1,'',0);
INSERT INTO `gltrans` VALUES (290,25,35,0,'2011-08-10',12,1460,'PO: 16 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x 95 @ 0.30',28.5,1,'',0);
INSERT INTO `gltrans` VALUES (291,25,35,0,'2011-08-10',12,2150,'PO1312922174: 16 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x 95 @ 0.30',-28.5,1,'',0);
INSERT INTO `gltrans` VALUES (292,25,36,0,'2011-08-11',12,1460,'PO: 15 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x .25 @ 0.30',0.075,1,'',0);
INSERT INTO `gltrans` VALUES (293,25,36,0,'2011-08-11',12,2150,'PO1313055983: 15 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x .25 @ 0.30',-0.075,1,'',0);
INSERT INTO `gltrans` VALUES (294,25,37,0,'2011-08-11',12,1460,'PO: 15 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x 25 @ 0.30',7.5,1,'',0);
INSERT INTO `gltrans` VALUES (295,25,37,0,'2011-08-11',12,2150,'PO1313056800: 15 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x 25 @ 0.30',-7.5,1,'',0);
INSERT INTO `gltrans` VALUES (296,25,38,0,'2011-08-11',12,1460,'PO: 15 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x 16 @ 0.30',4.8,1,'',0);
INSERT INTO `gltrans` VALUES (297,25,38,0,'2011-08-11',12,2150,'PO1313056837: 15 WHYNOT - DVD-CASE - CrystalCase50 - Crystal Cases 50 Pack x 16 @ 0.30',-4.8,1,'',0);
INSERT INTO `gltrans` VALUES (298,10,18,0,'2011-08-24',12,5000,'ANGRY - BREAD x 2 @ 5.5873',11.1746,1,'',0);
INSERT INTO `gltrans` VALUES (299,10,18,0,'2011-08-24',12,1460,'ANGRY - BREAD x 2 @ 5.5873',-11.1746,1,'',0);
INSERT INTO `gltrans` VALUES (300,10,18,0,'2011-08-24',12,4100,'ANGRY - BREAD x 2 @ 12',-21.818181818182,1,'',0);
INSERT INTO `gltrans` VALUES (301,10,18,0,'2011-08-24',12,1100,'ANGRY',24.436363636364,1,'',0);
INSERT INTO `gltrans` VALUES (302,10,18,0,'2011-08-24',12,2300,'ANGRY',-1.0909090909091,1,'',0);
INSERT INTO `gltrans` VALUES (303,10,18,0,'2011-08-24',12,2300,'ANGRY',-1.5272727272727,1,'',0);
INSERT INTO `gltrans` VALUES (304,10,19,0,'2011-08-24',12,5000,'ANGRY - BREAD x 3 @ 5.5873',16.7619,1,'',0);
INSERT INTO `gltrans` VALUES (305,10,19,0,'2011-08-24',12,1460,'ANGRY - BREAD x 3 @ 5.5873',-16.7619,1,'',0);
INSERT INTO `gltrans` VALUES (306,10,19,0,'2011-08-24',12,4100,'ANGRY - BREAD x 3 @ 6.9',-18.818181818182,1,'',0);
INSERT INTO `gltrans` VALUES (307,10,19,0,'2011-08-24',12,4900,'ANGRY - BREAD @ 10%',1.8818181818182,1,'',0);
INSERT INTO `gltrans` VALUES (308,10,19,0,'2011-08-24',12,5000,'ANGRY - SALT x 3 @ 6.3947',19.1841,1,'',0);
INSERT INTO `gltrans` VALUES (309,10,19,0,'2011-08-24',12,1460,'ANGRY - SALT x 3 @ 6.3947',-19.1841,1,'',0);
INSERT INTO `gltrans` VALUES (310,10,19,0,'2011-08-24',12,4100,'ANGRY - SALT x 3 @ 3.25',-8.8636363636364,1,'',0);
INSERT INTO `gltrans` VALUES (311,10,19,0,'2011-08-24',12,1100,'ANGRY',28.9,1,'',0);
INSERT INTO `gltrans` VALUES (312,10,19,0,'2011-08-24',12,2300,'ANGRY',-1.29,1,'',0);
INSERT INTO `gltrans` VALUES (313,10,19,0,'2011-08-24',12,2300,'ANGRY',-1.806,1,'',0);
INSERT INTO `gltrans` VALUES (314,35,20,0,'2011-08-28',12,5700,'BREAD cost was 5.5873 changed to 10.94195955 x Quantity on hand of 66.5',-356.084860075,1,'',0);
INSERT INTO `gltrans` VALUES (315,35,20,0,'2011-08-28',12,1460,'BREAD cost was 5.5873 changed to 10.94195955 x Quantity on hand of 66.5',356.084860075,1,'',0);
INSERT INTO `gltrans` VALUES (316,35,21,0,'2011-08-28',12,5700,'BREAD cost was 10.9420 changed to 10.94195955 x Quantity on hand of 66.5',0.0026899250000127,1,'',0);
INSERT INTO `gltrans` VALUES (317,35,21,0,'2011-08-28',12,1460,'BREAD cost was 10.9420 changed to 10.94195955 x Quantity on hand of 66.5',-0.0026899250000127,1,'',0);
INSERT INTO `gltrans` VALUES (318,35,22,0,'2011-08-28',12,5700,'BREAD cost was 10.9420 changed to 0.24445955 x Quantity on hand of 66.5',711.386439925,1,'',0);
INSERT INTO `gltrans` VALUES (319,35,22,0,'2011-08-28',12,1460,'BREAD cost was 10.9420 changed to 0.24445955 x Quantity on hand of 66.5',-711.386439925,1,'',0);
INSERT INTO `gltrans` VALUES (320,17,22,0,'2011-08-31',12,5700,'BREAD x -3 @ 0.2445 ',0.7335,1,'',0);
INSERT INTO `gltrans` VALUES (321,17,22,0,'2011-08-31',12,1460,'BREAD x -3 @ 0.2445 ',-0.7335,1,'',0);
INSERT INTO `gltrans` VALUES (322,1,3,0,'2011-07-18',11,2310,' 4812559 A. Elderman\r\nDEEL 2 FACTUUR DOC3649\r\n',1338.432,1,'',0);
INSERT INTO `gltrans` VALUES (323,1,3,0,'2011-07-18',11,8400,'write back of shortfall 4812559 A. Elderman\r\nDEEL 2 FACTUUR DOC3649\r\n',76.482,1,'',0);
INSERT INTO `gltrans` VALUES (324,1,3,0,'2011-07-18',11,1060,'4812559 A. Elderman\r\nDEEL 2 FACTUUR DOC3649\r\n',-1414.914,1,'',0);
INSERT INTO `gltrans` VALUES (325,1,4,0,'2011-07-19',11,6100,'from to where 9971294 SCARVA PRODUCTIONS B.V.\r\nDOC3617 2E HELFT\r\n',2868.069,1,'',0);
INSERT INTO `gltrans` VALUES (326,1,4,0,'2011-07-19',11,7650,'To Auckland 9971294 SCARVA PRODUCTIONS B.V.\r\nDOC3617 2E HELFT\r\n',306.023,1,'',0);
INSERT INTO `gltrans` VALUES (327,1,4,0,'2011-07-19',11,1060,'9971294 SCARVA PRODUCTIONS B.V.\r\nDOC3617 2E HELFT\r\n',-3174.092,1,'',0);
INSERT INTO `gltrans` VALUES (328,2,1,0,'2011-07-19',11,7150,'test 33 6244024 Dura\r\n2011.02\r\n',-4588.91,1,'',0);
INSERT INTO `gltrans` VALUES (329,2,1,0,'2011-07-19',11,7660,'fdee saa 6244024 Dura\r\n2011.02\r\n',-4445.698,1,'',0);
INSERT INTO `gltrans` VALUES (330,2,1,0,'2011-07-19',11,1060,'6244024 Dura\r\n2011.02\r\n',9034.608,1,'',0);
INSERT INTO `gltrans` VALUES (331,2,2,0,'2011-07-19',11,8600,'Red Cross donation received 9354603 Proserve\r\n1023351\r\n',-189.235,1,'',0);
INSERT INTO `gltrans` VALUES (332,2,2,0,'2011-07-19',11,1060,'9354603 Proserve\r\n1023351\r\n',189.235,1,'',0);
INSERT INTO `gltrans` VALUES (333,12,12,0,'2011-07-19',11,1100,'9354603 Proserve\r\n1023659\r\n',-189.962,1,'',0);
INSERT INTO `gltrans` VALUES (334,12,12,0,'2011-07-19',11,1060,'9354603 Proserve\r\n1023659\r\n',189.962,1,'',0);
INSERT INTO `gltrans` VALUES (335,12,13,0,'2011-07-19',11,1100,'9354603 Proserve\r\n1023659\r\n',-189.962,1,'',0);
INSERT INTO `gltrans` VALUES (336,12,13,0,'2011-07-19',11,1060,'9354603 Proserve\r\n1023659\r\n',189.962,1,'',0);
INSERT INTO `gltrans` VALUES (337,12,14,0,'2011-07-19',11,1100,'9354603 Proserve\r\n1023659\r\n',-189.962,1,'',0);
INSERT INTO `gltrans` VALUES (338,12,14,0,'2011-07-19',11,1060,'9354603 Proserve\r\n1023659\r\n',189.962,1,'',0);
INSERT INTO `gltrans` VALUES (339,22,7,0,'2011-07-21',11,2100,'5771148 doc3673 fact\r\nHr C Veldhuizen\r\n',114.203,1,'',0);
INSERT INTO `gltrans` VALUES (340,22,7,0,'2011-07-21',11,1060,'5771148 doc3673 fact\r\nHr C Veldhuizen\r\n',-114.203,1,'',0);
INSERT INTO `gltrans` VALUES (341,22,8,0,'2011-07-18',11,2100,'4753160 MAXXINNO\r\nWYCHEN MAXXINNO WYCHEN\r\nFact. DOC3654 24-06-2011 transactiedatum: 18-07-2011\r\n',338.068,1,'',0);
INSERT INTO `gltrans` VALUES (342,22,8,0,'2011-07-18',11,1060,'4753160 MAXXINNO\r\nWYCHEN MAXXINNO WYCHEN\r\nFact. DOC3654 24-06-2011 transactiedatum: 18-07-2011\r\n',-338.068,1,'',0);
INSERT INTO `gltrans` VALUES (343,22,9,0,'2011-09-04',13,2100,'DUBROW-',227.27272727273,1,'',0);
INSERT INTO `gltrans` VALUES (344,22,9,0,'2011-09-04',13,1060,'DUBROW-',-227.27272727273,1,'',0);
INSERT INTO `gltrans` VALUES (345,20,26,0,'2011-09-03',13,7400,'DUBROW ',2159.09,1,'',0);
INSERT INTO `gltrans` VALUES (346,20,26,0,'2011-09-03',13,2100,'DUBROW - Inv 2211 EUR950.00 @ a rate of 0.44',-2159.09,1,'',0);
INSERT INTO `gltrans` VALUES (347,12,15,0,'2011-07-19',11,1100,'8839206 Meijboom\r\n2111439\r\n',-128.523,1,'',0);
INSERT INTO `gltrans` VALUES (348,12,15,0,'2011-07-19',11,1060,'8839206 Meijboom\r\n2111439\r\n',128.523,1,'',0);
INSERT INTO `gltrans` VALUES (349,22,10,0,'2011-07-25',11,2100,'9238272 PLEXX BV\r\nJULI\r\n',772.727,1,'',0);
INSERT INTO `gltrans` VALUES (350,22,10,0,'2011-07-25',11,1060,'9238272 PLEXX BV\r\nJULI\r\n',-772.727,1,'',0);
INSERT INTO `gltrans` VALUES (351,22,11,0,'2011-09-05',13,2100,'DUBROW-',200,1,'',0);
INSERT INTO `gltrans` VALUES (352,22,11,0,'2011-09-05',13,1060,'DUBROW-',-200,1,'',0);
INSERT INTO `gltrans` VALUES (353,22,12,0,'2011-09-05',13,2100,'DUBROW-',2000,1,'',0);
INSERT INTO `gltrans` VALUES (354,22,12,0,'2011-09-05',13,1060,'DUBROW-',-2000,1,'',0);
INSERT INTO `gltrans` VALUES (355,12,16,0,'2011-11-02',0,1030,'',15.21,0,'',0);
INSERT INTO `gltrans` VALUES (356,12,16,0,'2011-11-02',0,1100,'',-16.71,0,'',0);
INSERT INTO `gltrans` VALUES (357,12,16,0,'2011-11-02',0,4900,'',1.5,0,'',0);
INSERT INTO `gltrans` VALUES (358,12,18,0,'2011-11-03',0,1030,'',2011.98,0,'',0);
INSERT INTO `gltrans` VALUES (359,12,18,0,'2011-11-03',0,1100,'',-2014.89,0,'',0);
INSERT INTO `gltrans` VALUES (360,12,18,0,'2011-11-03',0,4900,'',2.91,0,'',0);

--
-- Dumping data for table `grns`
--

INSERT INTO `grns` VALUES (18,1,2,'DVD-LTWP','2009-02-04','Lethal Weapon Linked',1,0,'CAMPBELL',2.7);
INSERT INTO `grns` VALUES (19,2,2,'DVD-LTWP','2009-02-05','Lethal Weapon Linked',1,0,'CAMPBELL',2.7);
INSERT INTO `grns` VALUES (20,3,2,'DVD-LTWP','2009-02-05','Lethal Weapon Linked',1,0,'CAMPBELL',2.7);
INSERT INTO `grns` VALUES (21,4,2,'DVD-LTWP','2009-02-05','Lethal Weapon Linked',1,0,'CAMPBELL',2.7);
INSERT INTO `grns` VALUES (22,5,2,'DVD-LTWP','2009-02-05','Lethal Weapon Linked',1,0,'CAMPBELL',2.7);
INSERT INTO `grns` VALUES (23,6,2,'DVD-LTWP','2009-02-05','Lethal Weapon Linked',1,0,'CAMPBELL',2.7);
INSERT INTO `grns` VALUES (24,7,2,'DVD-LTWP','2009-02-05','Lethal Weapon Linked',1,0,'CAMPBELL',2.7);
INSERT INTO `grns` VALUES (25,8,3,'SALT','2009-02-05','Salt',1,0,'GOTSTUFF',2.5);
INSERT INTO `grns` VALUES (26,9,3,'SALT','2009-02-05','Salt',1,0,'GOTSTUFF',2.5);
INSERT INTO `grns` VALUES (27,10,3,'SALT','2009-02-05','Salt',1,0,'GOTSTUFF',2.5);
INSERT INTO `grns` VALUES (28,11,3,'SALT','2009-02-05','Salt',1,0,'GOTSTUFF',2.5);
INSERT INTO `grns` VALUES (29,12,3,'SALT','2009-02-05','Salt',1,0,'GOTSTUFF',2.5);
INSERT INTO `grns` VALUES (30,13,3,'SALT','2009-02-05','Salt',1,0,'GOTSTUFF',2.5);
INSERT INTO `grns` VALUES (31,14,3,'SALT','2009-02-05','Salt',1,1,'GOTSTUFF',2.5);
INSERT INTO `grns` VALUES (32,15,1,'DVD-CASE','2011-03-10','webERP Demo DVD Case',45,0,'CAMPBELL',0.3);
INSERT INTO `grns` VALUES (33,16,24,'','2011-05-19','Some rubbish or other',3,3,'GOTSTUFF',55000);
INSERT INTO `grns` VALUES (34,17,3,'SALT','2011-05-19','Salt',2,0,'GOTSTUFF',6.3947);
INSERT INTO `grns` VALUES (35,18,23,'DVD-CASE','2011-08-10','CrystalCase50 - Crystal Cases 50 Pack',95,0,'WHYNOT',0.3);
INSERT INTO `grns` VALUES (36,19,29,'DVD-CASE','2011-08-11','CrystalCase50 - Crystal Cases 50 Pack',0.25,0,'WHYNOT',0.3);
INSERT INTO `grns` VALUES (37,20,29,'DVD-CASE','2011-08-11','CrystalCase50 - Crystal Cases 50 Pack',25,0,'WHYNOT',0.3);
INSERT INTO `grns` VALUES (38,21,29,'DVD-CASE','2011-08-11','CrystalCase50 - Crystal Cases 50 Pack',16,0,'WHYNOT',0.3);

--
-- Dumping data for table `holdreasons`
--

INSERT INTO `holdreasons` VALUES (1,'Good History',0);
INSERT INTO `holdreasons` VALUES (20,'Watch',0);
INSERT INTO `holdreasons` VALUES (51,'In liquidation',1);

--
-- Dumping data for table `lastcostrollup`
--


--
-- Dumping data for table `locations`
--

INSERT INTO `locations` VALUES ('MEL','Melbourne','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','+61 3 56789013','jacko@webdemo.com','Jack Roberts',1,'ANGRY',0,'ANGRY');
INSERT INTO `locations` VALUES ('TOR','Toronto','Level 100 ','CN Tower','Toronto','','','','','','','Clive Contrary',1,'',1,'');

--
-- Dumping data for table `locstock`
--

INSERT INTO `locstock` VALUES ('MEL','BIGEARS12',0,0);
INSERT INTO `locstock` VALUES ('MEL','BirthdayCakeConstruc',0,0);
INSERT INTO `locstock` VALUES ('MEL','BREAD',57,0);
INSERT INTO `locstock` VALUES ('MEL','DFS-20',0,0);
INSERT INTO `locstock` VALUES ('MEL','DR_TUMMY',0,0);
INSERT INTO `locstock` VALUES ('MEL','DVD-CASE',170.25,0);
INSERT INTO `locstock` VALUES ('MEL','DVD-DHWV',-12,0);
INSERT INTO `locstock` VALUES ('MEL','DVD-LTWP',-3,0);
INSERT INTO `locstock` VALUES ('MEL','DVD-TOPGUN',-1,0);
INSERT INTO `locstock` VALUES ('MEL','DVD-UNSG',-10,0);
INSERT INTO `locstock` VALUES ('MEL','DVD-UNSG2',-10,0);
INSERT INTO `locstock` VALUES ('MEL','DVD_ACTION',10,0);
INSERT INTO `locstock` VALUES ('MEL','FLOUR',-4,0);
INSERT INTO `locstock` VALUES ('MEL','FREIGHT',0,0);
INSERT INTO `locstock` VALUES ('MEL','FROAYLANDO',0,0);
INSERT INTO `locstock` VALUES ('MEL','FUJI990101',0,0);
INSERT INTO `locstock` VALUES ('MEL','FUJI990102',0,0);
INSERT INTO `locstock` VALUES ('MEL','FUJI9901ASS',0,0);
INSERT INTO `locstock` VALUES ('MEL','HIT3042-4',0,0);
INSERT INTO `locstock` VALUES ('MEL','HIT3043-5',5,0);
INSERT INTO `locstock` VALUES ('MEL','SALT',2,0);
INSERT INTO `locstock` VALUES ('MEL','SLICE',0,0);
INSERT INTO `locstock` VALUES ('MEL','YEAST',0,0);
INSERT INTO `locstock` VALUES ('TOR','BIGEARS12',0,0);
INSERT INTO `locstock` VALUES ('TOR','BirthdayCakeConstruc',0,0);
INSERT INTO `locstock` VALUES ('TOR','BREAD',6.5,0);
INSERT INTO `locstock` VALUES ('TOR','DFS-20',0,0);
INSERT INTO `locstock` VALUES ('TOR','DR_TUMMY',0,0);
INSERT INTO `locstock` VALUES ('TOR','DVD-CASE',187,0);
INSERT INTO `locstock` VALUES ('TOR','DVD-DHWV',-1,0);
INSERT INTO `locstock` VALUES ('TOR','DVD-LTWP',0,0);
INSERT INTO `locstock` VALUES ('TOR','DVD-TOPGUN',0,0);
INSERT INTO `locstock` VALUES ('TOR','DVD-UNSG',0,0);
INSERT INTO `locstock` VALUES ('TOR','DVD-UNSG2',0,0);
INSERT INTO `locstock` VALUES ('TOR','DVD_ACTION',0,0);
INSERT INTO `locstock` VALUES ('TOR','FLOUR',8,0);
INSERT INTO `locstock` VALUES ('TOR','FREIGHT',0,0);
INSERT INTO `locstock` VALUES ('TOR','FROAYLANDO',0,0);
INSERT INTO `locstock` VALUES ('TOR','FUJI990101',0,0);
INSERT INTO `locstock` VALUES ('TOR','FUJI990102',0,0);
INSERT INTO `locstock` VALUES ('TOR','FUJI9901ASS',0,0);
INSERT INTO `locstock` VALUES ('TOR','HIT3042-4',0,0);
INSERT INTO `locstock` VALUES ('TOR','HIT3043-5',0,0);
INSERT INTO `locstock` VALUES ('TOR','SALT',19.7,0);
INSERT INTO `locstock` VALUES ('TOR','SLICE',0,0);
INSERT INTO `locstock` VALUES ('TOR','YEAST',9.2,0);

--
-- Dumping data for table `loctransfers`
--

INSERT INTO `loctransfers` VALUES (13,'BREAD',10,10,'2009-02-05','2009-02-06','MEL','TOR');
INSERT INTO `loctransfers` VALUES (18,'BREAD',1,1,'2009-02-05','2009-02-06','MEL','TOR');
INSERT INTO `loctransfers` VALUES (19,'BREAD',1,1,'2009-02-05','2009-02-06','MEL','TOR');
INSERT INTO `loctransfers` VALUES (20,'BREAD',1,0,'2009-02-05','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (21,'BREAD',1,0,'2009-02-05','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (22,'BREAD',1,0,'2009-02-05','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (13,'BREAD',10,10,'2009-02-05','2009-02-06','MEL','TOR');
INSERT INTO `loctransfers` VALUES (18,'BREAD',1,1,'2009-02-05','2009-02-06','MEL','TOR');
INSERT INTO `loctransfers` VALUES (19,'BREAD',1,1,'2009-02-05','2009-02-06','MEL','TOR');
INSERT INTO `loctransfers` VALUES (20,'BREAD',1,0,'2009-02-05','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (21,'BREAD',1,0,'2009-02-05','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (22,'BREAD',1,0,'2009-02-05','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (26,'DVD-CASE',2,0,'2011-06-13','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (26,'BREAD',4,0,'2011-06-13','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (27,'DVD-CASE',2,0,'2011-07-06','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (27,'BREAD',5,0,'2011-07-06','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (28,'DVD-CASE',5,0,'2011-07-06','0000-00-00','MEL','TOR');
INSERT INTO `loctransfers` VALUES (28,'BREAD',5,0,'2011-07-06','0000-00-00','MEL','TOR');

--
-- Dumping data for table `mrpcalendar`
--

INSERT INTO `mrpcalendar` VALUES ('2011-07-19',1,0);
INSERT INTO `mrpcalendar` VALUES ('2011-07-20',2,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-21',3,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-22',4,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-23',5,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-24',5,0);
INSERT INTO `mrpcalendar` VALUES ('2011-07-25',6,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-26',7,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-27',8,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-28',9,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-29',10,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-30',11,1);
INSERT INTO `mrpcalendar` VALUES ('2011-07-31',11,0);
INSERT INTO `mrpcalendar` VALUES ('2011-08-01',12,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-02',13,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-03',14,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-04',15,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-05',16,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-06',17,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-07',17,0);
INSERT INTO `mrpcalendar` VALUES ('2011-08-08',18,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-09',19,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-10',20,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-11',21,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-12',22,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-13',23,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-14',23,0);
INSERT INTO `mrpcalendar` VALUES ('2011-08-15',24,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-16',25,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-17',26,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-18',27,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-19',28,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-20',29,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-21',29,0);
INSERT INTO `mrpcalendar` VALUES ('2011-08-22',30,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-23',31,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-24',32,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-25',33,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-26',34,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-27',35,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-28',35,0);
INSERT INTO `mrpcalendar` VALUES ('2011-08-29',36,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-30',37,1);
INSERT INTO `mrpcalendar` VALUES ('2011-08-31',38,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-01',39,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-02',40,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-03',41,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-04',41,0);
INSERT INTO `mrpcalendar` VALUES ('2011-09-05',42,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-06',43,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-07',44,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-08',45,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-09',46,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-10',47,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-11',47,0);
INSERT INTO `mrpcalendar` VALUES ('2011-09-12',48,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-13',49,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-14',50,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-15',51,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-16',52,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-17',53,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-18',53,0);
INSERT INTO `mrpcalendar` VALUES ('2011-09-19',54,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-20',55,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-21',56,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-22',57,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-23',58,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-24',59,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-25',59,0);
INSERT INTO `mrpcalendar` VALUES ('2011-09-26',60,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-27',61,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-28',62,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-29',63,1);
INSERT INTO `mrpcalendar` VALUES ('2011-09-30',64,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-01',65,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-02',65,0);
INSERT INTO `mrpcalendar` VALUES ('2011-10-03',66,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-04',67,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-05',68,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-06',69,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-07',70,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-08',71,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-09',71,0);
INSERT INTO `mrpcalendar` VALUES ('2011-10-10',72,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-11',73,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-12',74,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-13',75,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-14',76,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-15',77,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-16',77,0);
INSERT INTO `mrpcalendar` VALUES ('2011-10-17',78,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-18',79,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-19',80,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-20',81,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-21',82,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-22',83,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-23',83,0);
INSERT INTO `mrpcalendar` VALUES ('2011-10-24',84,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-25',85,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-26',86,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-27',87,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-28',88,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-29',89,1);
INSERT INTO `mrpcalendar` VALUES ('2011-10-30',89,0);
INSERT INTO `mrpcalendar` VALUES ('2011-10-31',90,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-01',91,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-02',92,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-03',93,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-04',94,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-05',95,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-06',95,0);
INSERT INTO `mrpcalendar` VALUES ('2011-11-07',96,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-08',97,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-09',98,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-10',99,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-11',100,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-12',101,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-13',101,0);
INSERT INTO `mrpcalendar` VALUES ('2011-11-14',102,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-15',103,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-16',104,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-17',105,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-18',106,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-19',107,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-20',107,0);
INSERT INTO `mrpcalendar` VALUES ('2011-11-21',108,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-22',109,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-23',110,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-24',111,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-25',112,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-26',113,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-27',113,0);
INSERT INTO `mrpcalendar` VALUES ('2011-11-28',114,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-29',115,1);
INSERT INTO `mrpcalendar` VALUES ('2011-11-30',116,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-01',117,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-02',118,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-03',119,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-04',119,0);
INSERT INTO `mrpcalendar` VALUES ('2011-12-05',120,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-06',121,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-07',122,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-08',123,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-09',124,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-10',125,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-11',125,0);
INSERT INTO `mrpcalendar` VALUES ('2011-12-12',126,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-13',127,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-14',128,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-15',129,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-16',130,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-17',131,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-18',131,0);
INSERT INTO `mrpcalendar` VALUES ('2011-12-19',132,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-20',133,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-21',134,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-22',135,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-23',136,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-24',137,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-25',137,0);
INSERT INTO `mrpcalendar` VALUES ('2011-12-26',138,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-27',139,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-28',140,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-29',141,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-30',142,1);
INSERT INTO `mrpcalendar` VALUES ('2011-12-31',143,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-01',143,0);
INSERT INTO `mrpcalendar` VALUES ('2012-01-02',144,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-03',145,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-04',146,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-05',147,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-06',148,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-07',149,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-08',149,0);
INSERT INTO `mrpcalendar` VALUES ('2012-01-09',150,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-10',151,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-11',152,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-12',153,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-13',154,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-14',155,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-15',155,0);
INSERT INTO `mrpcalendar` VALUES ('2012-01-16',156,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-17',157,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-18',158,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-19',159,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-20',160,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-21',161,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-22',161,0);
INSERT INTO `mrpcalendar` VALUES ('2012-01-23',162,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-24',163,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-25',164,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-26',165,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-27',166,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-28',167,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-29',167,0);
INSERT INTO `mrpcalendar` VALUES ('2012-01-30',168,1);
INSERT INTO `mrpcalendar` VALUES ('2012-01-31',169,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-01',170,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-02',171,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-03',172,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-04',173,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-05',173,0);
INSERT INTO `mrpcalendar` VALUES ('2012-02-06',174,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-07',175,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-08',176,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-09',177,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-10',178,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-11',179,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-12',179,0);
INSERT INTO `mrpcalendar` VALUES ('2012-02-13',180,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-14',181,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-15',182,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-16',183,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-17',184,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-18',185,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-19',185,0);
INSERT INTO `mrpcalendar` VALUES ('2012-02-20',186,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-21',187,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-22',188,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-23',189,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-24',190,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-25',191,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-26',191,0);
INSERT INTO `mrpcalendar` VALUES ('2012-02-27',192,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-28',193,1);
INSERT INTO `mrpcalendar` VALUES ('2012-02-29',194,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-01',195,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-02',196,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-03',197,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-04',197,0);
INSERT INTO `mrpcalendar` VALUES ('2012-03-05',198,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-06',199,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-07',200,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-08',201,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-09',202,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-10',203,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-11',203,0);
INSERT INTO `mrpcalendar` VALUES ('2012-03-12',204,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-13',205,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-14',206,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-15',207,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-16',208,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-17',209,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-18',209,0);
INSERT INTO `mrpcalendar` VALUES ('2012-03-19',210,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-20',211,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-21',212,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-22',213,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-23',214,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-24',215,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-25',215,0);
INSERT INTO `mrpcalendar` VALUES ('2012-03-26',216,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-27',217,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-28',218,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-29',219,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-30',220,1);
INSERT INTO `mrpcalendar` VALUES ('2012-03-31',221,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-01',221,0);
INSERT INTO `mrpcalendar` VALUES ('2012-04-02',222,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-03',223,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-04',224,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-05',225,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-06',226,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-07',227,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-08',227,0);
INSERT INTO `mrpcalendar` VALUES ('2012-04-09',228,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-10',229,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-11',230,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-12',231,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-13',232,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-14',233,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-15',233,0);
INSERT INTO `mrpcalendar` VALUES ('2012-04-16',234,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-17',235,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-18',236,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-19',237,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-20',238,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-21',239,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-22',239,0);
INSERT INTO `mrpcalendar` VALUES ('2012-04-23',240,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-24',241,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-25',242,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-26',243,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-27',244,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-28',245,1);
INSERT INTO `mrpcalendar` VALUES ('2012-04-29',245,0);
INSERT INTO `mrpcalendar` VALUES ('2012-04-30',246,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-01',247,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-02',248,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-03',249,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-04',250,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-05',251,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-06',251,0);
INSERT INTO `mrpcalendar` VALUES ('2012-05-07',252,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-08',253,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-09',254,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-10',255,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-11',256,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-12',257,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-13',257,0);
INSERT INTO `mrpcalendar` VALUES ('2012-05-14',258,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-15',259,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-16',260,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-17',261,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-18',262,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-19',263,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-20',263,0);
INSERT INTO `mrpcalendar` VALUES ('2012-05-21',264,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-22',265,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-23',266,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-24',267,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-25',268,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-26',269,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-27',269,0);
INSERT INTO `mrpcalendar` VALUES ('2012-05-28',270,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-29',271,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-30',272,1);
INSERT INTO `mrpcalendar` VALUES ('2012-05-31',273,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-01',274,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-02',275,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-03',275,0);
INSERT INTO `mrpcalendar` VALUES ('2012-06-04',276,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-05',277,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-06',278,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-07',279,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-08',280,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-09',281,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-10',281,0);
INSERT INTO `mrpcalendar` VALUES ('2012-06-11',282,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-12',283,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-13',284,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-14',285,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-15',286,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-16',287,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-17',287,0);
INSERT INTO `mrpcalendar` VALUES ('2012-06-18',288,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-19',289,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-20',290,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-21',291,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-22',292,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-23',293,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-24',293,0);
INSERT INTO `mrpcalendar` VALUES ('2012-06-25',294,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-26',295,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-27',296,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-28',297,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-29',298,1);
INSERT INTO `mrpcalendar` VALUES ('2012-06-30',299,1);

--
-- Dumping data for table `mrpdemands`
--

INSERT INTO `mrpdemands` VALUES (8,'DVD_ACTION','FOR',25,'2011-09-30');
INSERT INTO `mrpdemands` VALUES (9,'DVD-TOPGUN','FOR',50,'2011-09-30');
INSERT INTO `mrpdemands` VALUES (10,'SLICE','FOR',522,'2011-11-30');

--
-- Dumping data for table `mrpdemandtypes`
--

INSERT INTO `mrpdemandtypes` VALUES ('FOR','Forecast');

--
-- Dumping data for table `mrpplannedorders`
--

INSERT INTO `mrpplannedorders` VALUES (1,'BIRTHDAYCAKECONSTRUC','2010-12-20',1,'SO',23,'2010-12-20',0);
INSERT INTO `mrpplannedorders` VALUES (2,'SLICE','2011-11-30',422,'FOR',10,'2011-11-30',0);
INSERT INTO `mrpplannedorders` VALUES (3,'BIGEARS12','2011-04-12',2,'SO',27,'2011-04-12',0);
INSERT INTO `mrpplannedorders` VALUES (4,'DVD_ACTION','2011-09-30',15,'FOR',8,'2011-09-30',0);
INSERT INTO `mrpplannedorders` VALUES (5,'DVD-LTWP','2011-06-29',3,'REORD',1,'2011-06-29',0);
INSERT INTO `mrpplannedorders` VALUES (6,'DVD-LTWP','2011-09-30',15,'FOR',8,'2011-09-30',0);
INSERT INTO `mrpplannedorders` VALUES (7,'DVD-UNSG','2011-06-29',10,'REORD',1,'2011-06-29',0);
INSERT INTO `mrpplannedorders` VALUES (8,'DVD-UNSG','2011-09-30',15,'FOR',8,'2011-09-30',0);
INSERT INTO `mrpplannedorders` VALUES (9,'DVD-UNSG2','2011-06-29',10,'REORD',1,'2011-06-29',0);
INSERT INTO `mrpplannedorders` VALUES (10,'DVD-UNSG2','2011-09-25',15,'FOR',8,'2011-09-25',0);
INSERT INTO `mrpplannedorders` VALUES (11,'FLOUR','2007-06-21',8.8,'WO',5,'2007-06-21',0);
INSERT INTO `mrpplannedorders` VALUES (12,'FLOUR','2010-12-20',1,'SO',23,'2010-12-20',0);
INSERT INTO `mrpplannedorders` VALUES (13,'FLOUR','2011-03-28',2,'SO',26,'2011-03-28',0);
INSERT INTO `mrpplannedorders` VALUES (14,'FLOUR','2011-06-29',4,'REORD',1,'2011-06-29',0);
INSERT INTO `mrpplannedorders` VALUES (15,'DVD-TOPGUN','2011-06-29',1,'REORD',1,'2011-06-29',0);
INSERT INTO `mrpplannedorders` VALUES (16,'DVD-TOPGUN','2011-09-30',50,'FOR',9,'2011-09-30',0);

--
-- Dumping data for table `offers`
--


--
-- Dumping data for table `orderdeliverydifferenceslog`
--

INSERT INTO `orderdeliverydifferenceslog` VALUES (11,17,'BREAD',3,'ANGRY','ANGRY','CAN');

--
-- Dumping data for table `paymentmethods`
--

INSERT INTO `paymentmethods` VALUES (1,'Cheque',1,1,0);
INSERT INTO `paymentmethods` VALUES (2,'Cash',1,1,0);
INSERT INTO `paymentmethods` VALUES (3,'Direct Credit',1,1,0);

--
-- Dumping data for table `paymentterms`
--

INSERT INTO `paymentterms` VALUES ('20','Due 20th Of the Following Month',0,22);
INSERT INTO `paymentterms` VALUES ('30','Due By End Of The Following Month',0,30);
INSERT INTO `paymentterms` VALUES ('7','Payment due within 7 days',7,0);
INSERT INTO `paymentterms` VALUES ('CA','Cash Only',2,0);

--
-- Dumping data for table `pcashdetails`
--


--
-- Dumping data for table `pcexpenses`
--

INSERT INTO `pcexpenses` VALUES ('motor','Motor Expenses',7600,0);
INSERT INTO `pcexpenses` VALUES ('parking','Parking',7650,0);

--
-- Dumping data for table `pctabexpenses`
--

INSERT INTO `pctabexpenses` VALUES ('DEFAULT','motor');
INSERT INTO `pctabexpenses` VALUES ('DEFAULT','parking');

--
-- Dumping data for table `pctabs`
--


--
-- Dumping data for table `pctypetabs`
--

INSERT INTO `pctypetabs` VALUES ('Default','Default');

--
-- Dumping data for table `periods`
--

INSERT INTO `periods` VALUES (0,'2010-08-31');
INSERT INTO `periods` VALUES (1,'2010-09-30');
INSERT INTO `periods` VALUES (2,'2010-10-31');
INSERT INTO `periods` VALUES (3,'2010-11-30');
INSERT INTO `periods` VALUES (4,'2010-12-31');
INSERT INTO `periods` VALUES (5,'2011-01-31');
INSERT INTO `periods` VALUES (6,'2011-02-28');
INSERT INTO `periods` VALUES (7,'2011-03-31');
INSERT INTO `periods` VALUES (8,'2011-04-30');
INSERT INTO `periods` VALUES (9,'2011-05-31');
INSERT INTO `periods` VALUES (10,'2011-06-30');
INSERT INTO `periods` VALUES (11,'2011-07-31');
INSERT INTO `periods` VALUES (12,'2011-08-31');
INSERT INTO `periods` VALUES (13,'2011-09-30');
INSERT INTO `periods` VALUES (14,'2011-10-31');

--
-- Dumping data for table `pickinglistdetails`
--


--
-- Dumping data for table `pickinglists`
--


--
-- Dumping data for table `prices`
--

INSERT INTO `prices` VALUES ('BIGEARS12','DE','AUD','','4428.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('BirthdayCakeConstruc','DE','AUD','','1476.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('BREAD','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('DR_TUMMY','DE','AUD','','246.0000','','1999-01-01','2011-05-29');
INSERT INTO `prices` VALUES ('DR_TUMMY','DE','AUD','','250.0000','','2011-05-30','9999-12-31');
INSERT INTO `prices` VALUES ('DVD-CASE','DE','AUD','','124.5000','','1999-01-01','2011-06-08');
INSERT INTO `prices` VALUES ('DVD-CASE','DE','AUD','','135.0000','','2011-06-09','0000-00-00');
INSERT INTO `prices` VALUES ('DVD-CASE','DE','GBP','DUMBLE','52.6500','DUMBLE','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('DVD-CASE','DE','USD','ANGRY','150.0000','ANGRY','2011-05-13','0000-00-00');
INSERT INTO `prices` VALUES ('DVD-DHWV','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('DVD-LTWP','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('DVD-TOPGUN','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('DVD-UNSG','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('DVD-UNSG2','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('DVD_ACTION','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('FLOUR','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('FUJI990101','DE','AUD','','1353.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('FUJI990102','DE','AUD','','861.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('HIT3042-4','DE','AUD','','1107.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('HIT3043-5','DE','AUD','','1599.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('HIT3043-5','DE','USD','','2300.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('SALT','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('SLICE','DE','AUD','','123.0000','','1999-01-01','0000-00-00');
INSERT INTO `prices` VALUES ('YEAST','DE','AUD','','123.0000','','1999-01-01','0000-00-00');

--
-- Dumping data for table `purchdata`
--

INSERT INTO `purchdata` VALUES ('BINGO','DVD-CASE','123456.0000','pair',200000,'',1,1,'2011-03-26','',1);
INSERT INTO `purchdata` VALUES ('BINGO','HIT3043-5','1235.0000','',1,'',5,1,'2009-09-18','',1);
INSERT INTO `purchdata` VALUES ('CRUISE','DVD-UNSG2','200.0000','10 Pack',10,'',5,1,'2009-09-18','',1);
INSERT INTO `purchdata` VALUES ('WHYNOT','DVD-CASE','1500.0000','50 pack',50,'Crystal Cases 50 Pack',25,0,'2011-04-18','CrystalCase50',1);

--
-- Dumping data for table `purchorderauth`
--

INSERT INTO `purchorderauth` VALUES ('admin','AUD',0,50000,0);
INSERT INTO `purchorderauth` VALUES ('admin','EUR',0,999999999,0);
INSERT INTO `purchorderauth` VALUES ('admin','GBP',0,9999999,0);
INSERT INTO `purchorderauth` VALUES ('admin','USD',0,9999999,0);

--
-- Dumping data for table `purchorderdetails`
--

INSERT INTO `purchorderdetails` VALUES (1,1,'DVD-CASE','2007-06-25','webERP Demo DVD Case',1460,0,0.23,0,0.3,45,45,0,'',1,'','',0,1);
INSERT INTO `purchorderdetails` VALUES (2,1,'DVD-LTWP','2007-06-25','Lethal Weapon Linked',1460,0,2.98,0,2.7,7,7,0,'',1,'','',0,1);
INSERT INTO `purchorderdetails` VALUES (3,2,'SALT','2009-02-05','Salt',1460,1,100,100,3.3654888888889,20,9,0,'',0,'','',0,1);
INSERT INTO `purchorderdetails` VALUES (4,3,'BREAD','2010-08-14','Bread',1460,0,0.25,0,0,12,0,0,'0',0,'each','',0,1);
INSERT INTO `purchorderdetails` VALUES (5,4,'','2011-02-18','Test items with no stock code',1,0,0.19925,0,0,50000000,0,0,'',0,'each','',0,10000);
INSERT INTO `purchorderdetails` VALUES (6,4,'FUJI9901ASS','2011-02-18','Fujitsu 990101 Split type A/C 3.5kw complete',1460,0,2100,0,0,2,0,0,'0',0,'each','1',0,1);
INSERT INTO `purchorderdetails` VALUES (8,6,'','2011-03-08','Fish or ships',1,0,75,0,0,1,0,0,'',0,'each','',0,1);
INSERT INTO `purchorderdetails` VALUES (9,6,'BIGEARS12','2011-03-08','Big Ears and Noddy episodes on DVD',1460,0,0,0,0,2,0,0,'0',0,'each','1',0,1);
INSERT INTO `purchorderdetails` VALUES (11,7,'BREAD','2011-03-08','Bread',1460,0,0,0,0,2,0,0,'0',0,'each','1',0,1);
INSERT INTO `purchorderdetails` VALUES (12,8,'','2011-03-08','fddfdf',1400,0,95.5,0,0,10,0,0,'',0,'each','',0,1);
INSERT INTO `purchorderdetails` VALUES (13,8,'DVD-TOPGUN','2011-03-08','Top Gun DVD',1460,0,7.99,0,0,2,0,0,'0',0,'each','1',0,1);
INSERT INTO `purchorderdetails` VALUES (18,12,'DVD-CASE','2011-03-27',' - ',1460,0,622,0,0,104000,0,0,'0',0,'each','1',0,2);
INSERT INTO `purchorderdetails` VALUES (19,13,'DVD-DHWV','2011-04-12','Die Hard With A Vengeance Linked',1460,0,1240,0,0,5000,0,0,'0',0,'each','1',0,1);
INSERT INTO `purchorderdetails` VALUES (20,13,'SALT','2011-04-12','Salt',1460,0,3650,0,0,5,0,0,'0',0,'kgs','1',0,1);
INSERT INTO `purchorderdetails` VALUES (21,14,'DVD-CASE','2011-04-18','webERP Demo DVD Case',1460,0,12.5,0,0,3,0,0,'0',0,'each','1',0,1);
INSERT INTO `purchorderdetails` VALUES (23,16,'DVD-CASE','2011-04-18','CrystalCase50 - Crystal Cases 50 Pack',1460,0,30,0,0.3,100,95,0,'0',0,'50 pack','CrystalCase50',0,50);
INSERT INTO `purchorderdetails` VALUES (24,17,'','2011-05-19','Some rubbish or other',1800,3,60500,48560,55000,5,3,0,'',0,'each','0',0,1);
INSERT INTO `purchorderdetails` VALUES (25,17,'DVD-CASE','2011-05-19','webERP Demo DVD Case',1460,0,0,0,0,2,0,0,'0',0,'','',0,1);
INSERT INTO `purchorderdetails` VALUES (26,17,'DR_TUMMY','2011-05-19','Gastric exquisite diarrhea',1460,0,0,0,0,2,0,0,'0',0,'','',0,1);
INSERT INTO `purchorderdetails` VALUES (27,18,'DVD-DHWV','2011-06-27','Regional Code: 2 (Japan, Europe, Middle East, South Africa). &lt;br /&gt;Languages: English, Deutsch',1460,0,0,0,0,2,0,0,'0',0,'','',0,1);
INSERT INTO `purchorderdetails` VALUES (28,18,'DVD-DHWV','2011-06-27','Regional Code: 2 (Japan, Europe, Middle East, South Africa). &lt;br /&gt;Languages: English, Deutsch',1460,0,0,0,0,2,0,0,'0',0,'','',0,1);
INSERT INTO `purchorderdetails` VALUES (29,15,'DVD-CASE','2011-04-19','CrystalCase50 - Crystal Cases 50 Pack',1460,0,30,0,0.3,50,41.25,0,'0',1,'50 pack','CrystalCase50',0,50);
INSERT INTO `purchorderdetails` VALUES (30,19,'DVD-CASE','2011-08-06','webERP Demo DVD Case',1460,0,30,0,0,50,0,0,'',0,'50 pack','CrystalCase50',0,50);
INSERT INTO `purchorderdetails` VALUES (31,20,'DVD-CASE','2011-08-06','webERP Demo DVD Case',1460,0,2.25,0,0,200000,0,0,'',0,'pair','',0,200000);
INSERT INTO `purchorderdetails` VALUES (32,21,'DVD-CASE','2011-08-10','CrystalCase50 - Crystal Cases 50 Pack',1460,0,30,0,0,50,0,0,'0',0,'50 pack','CrystalCase50',0,50);
INSERT INTO `purchorderdetails` VALUES (33,22,'BREAD','2011-09-04','Bread',1460,0,0.65,0,0,1,0,0,'0',0,'each','',0,1);
INSERT INTO `purchorderdetails` VALUES (34,22,'DVD-CASE','2011-09-04','webERP Demo DVD Case',1460,0,0.95,0,0,3,0,0,'0',0,'each','',0,1);
INSERT INTO `purchorderdetails` VALUES (35,22,'DVD-UNSG','2011-09-04','Under Siege Linked',1460,0,5.62,0,0,4,0,0,'0',0,'each','',0,1);

--
-- Dumping data for table `purchorders`
--

INSERT INTO `purchorders` VALUES (1,'CAMPBELL','','2007-06-25 00:00:00',1,'2007-06-25 00:00:00',0,'','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','','','','','','','','','','','1.00','0000-00-00','','','2007-06-25','Completed','10/03/2011 - Order Completed<br />','','');
INSERT INTO `purchorders` VALUES (2,'GOTSTUFF','','2009-02-05 00:00:00',1,'2011-05-02 00:00:00',1,'','0','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','','','','','','','','','Mr salesman','','','3.00','2011-08-11','','1','2009-02-05','Completed','11/08/2011 - Order completed by Demonstration user <br />','20','');
INSERT INTO `purchorders` VALUES (3,'BINGO','','2010-08-14 00:00:00',0.85,'2010-08-14 00:00:00',1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','1.00','2010-08-14','','1','2010-08-14','Authorised','16/05/2011 - Authorised by Demonstration user <br />16/05/2011 - Order set to pending status by Demonstration user <br />14/08/2010 - Printed by <a href=\"mailto:\">admin</a><br>14/08/2010 - Authorised by <a href=\"mailto:\">admin</a><br>14/08/2010 - Order Created by &lt;a href=&quot;mailto:&quot;&gt;admin&lt;/a&gt; - &lt;br&gt;','30','');
INSERT INTO `purchorders` VALUES (4,'BINGO','','2011-02-18 00:00:00',0.85,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','3.00','2011-02-18','','1','2011-02-18','Authorised','18/02/2011 - Order Created and Authorised by <a href=\"mailto:phil@logicworks.co.nz\">Demonstration user</a> - <br />','30','');
INSERT INTO `purchorders` VALUES (6,'CAMPBELL','','2011-03-08 00:00:00',0.85,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Box 9882','Ottowa Rise','','','','','','','Jack Roberts','1.00','2011-03-08','','1','2011-03-08','Authorised','08/03/2011 - Order Created and Authorised by <a href=\"mailto:phil@logicworks.co.nz\">Demonstration user</a> - <br />','30','');
INSERT INTO `purchorders` VALUES (7,'BINGO','','2011-03-08 00:00:00',0.85,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','3.00','2011-05-17','','1','2011-03-08','Authorised','08/03/2011 - Order Created and Authorised by <a href=\"mailto:phil@logicworks.co.nz\">Demonstration user</a> - <br />','30','');
INSERT INTO `purchorders` VALUES (8,'CRUISE','','2011-03-08 00:00:00',0.8,'2011-03-26 00:00:00',0,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Box 2001','Ft Lauderdale, Florida','','','','','Barry Toad','','Jack Roberts','1.00','2011-03-08','','1','2011-03-08','Rejected','27/03/2011 - Rejected by <a href=\"mailto:info@weberp.org\">Demonstration user</a><br>27/03/2011 - Order set to pending status by &lt;a href=&quot;mailto:info@weberp.org&quot;&gt;Demonstration user&lt;/a&gt;&lt;br&gt;26/03/2011 - Printed by&lt;a href=&quot;mailto:info@weberp.org&quot;&gt;Demonstration user&lt;/a&gt;&lt;br /&gt;08/03/2011 - Order Created and Authorised by &lt;a href=&quot;mailto:phil@logicworks.co.nz&quot;&gt;Demonstration user&lt;/a&gt; - &lt;br /&gt;','30','');
INSERT INTO `purchorders` VALUES (9,'BINGO','','2011-03-26 00:00:00',0.85,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','2.00','2011-03-26','','1','2011-03-26','Authorised','26/03/2011 - Order Created and Authorised by <a href=\"mailto:info@weberp.org\">Demonstration user</a> - <br />','30','');
INSERT INTO `purchorders` VALUES (10,'BINGO','','2011-03-26 00:00:00',0.85,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','2.00','2011-03-26','','1','2011-03-26','Authorised','26/03/2011 - Order Created and Authorised by <a href=\"mailto:info@weberp.org\">Demonstration user</a> - <br />','30','');
INSERT INTO `purchorders` VALUES (11,'BINGO','','2011-03-27 00:00:00',0.85,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','2.00','2011-03-27','','1','2011-03-27','Authorised','18/04/2011 - Authorised by <a href=\"mailto:info@weberp.org\">admin</a><br>27/03/2011 - Order Created by &lt;a href=&quot;mailto:info@weberp.org&quot;&gt;Demonstration user&lt;/a&gt; - &lt;br /&gt;','30','');
INSERT INTO `purchorders` VALUES (12,'BINGO','','2011-03-27 00:00:00',0.85,NULL,0,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','6.00','2011-04-11','','1','2011-03-27','Pending','27/03/2011 - Authorised by <a href=\"mailto:info@weberp.org\">Demonstration user</a><br>27/03/2011 - Order Created by <a href=\"mailto:info@weberp.org\">Demonstration user</a> - <br />','30','');
INSERT INTO `purchorders` VALUES (13,'WHYNOT','','2011-04-12 00:00:00',1,NULL,0,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Well I will ','If I','Want ','To','','','','12323','Jack Roberts','1.00','2011-04-12','','1','2011-04-12','Pending','12/04/2011 - Order Created by <a href=\"mailto:info@weberp.org\">Demonstration user</a> - <br />','20','');
INSERT INTO `purchorders` VALUES (14,'WHYNOT','','2011-04-18 00:00:00',1,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Well I will ','If I','Want ','To','','','','12323','Jack Roberts','1.00','2011-04-18','','1','2011-04-18','Authorised','18/04/2011 - Order Created and Authorised by <a href=\"mailto:info@weberp.org\">Demonstration user</a> - <br />','20','');
INSERT INTO `purchorders` VALUES (15,'WHYNOT','','2011-04-18 00:00:00',1,'2011-08-11 00:00:00',0,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Well I will ','If I','Want ','To','','','You think','12323','Jack Roberts','6.00','2011-08-11','','1','2011-04-19','Completed','11/08/2011 - Order Completed<br />11/08/2011 - Printed by<a href=\"mailto:\">Demonstration user</a><br />','20','');
INSERT INTO `purchorders` VALUES (16,'WHYNOT','','2011-04-18 00:00:00',1,'2011-08-10 00:00:00',1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Well I will ','If I','Want ','To','','','You think','12323','Jack Roberts','3.00','2011-08-10','','1','2011-04-18','Authorised','10/08/2011 - Printed by<a href=\"mailto:\">Demonstration user</a><br />12/05/2011 - Authorised by <a href=\"mailto:phil@logicworks.co.nz\">admin</a>\n					<br />12/05/2011 - Order set to pending status by &lt;a href=&quot;mailto:phil@logicworks.co.nz&quot;&gt;Demonstration user&lt;/a&gt;&lt;br /&gt;18/04/2011 - Printed by&lt;a href=','20','');
INSERT INTO `purchorders` VALUES (17,'GOTSTUFF','','2011-05-19 00:00:00',1.1,'2011-05-19 00:00:00',1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','+61 3 56789012','+61 3 56789012','Test line 1','Test line 2','Test line 3','Test line 4 - editing','','','Mr salesman','','Jack Roberts','3.00','2011-06-09','','1','2011-05-19','Authorised','19/05/2011 - Printed by<a href=\"mailto:\">Demonstration user</a><br />19/05/2011 - Authorised by Demonstration user <br />19/05/2011 - Order Created by Demonstration user  - <br />','20','');
INSERT INTO `purchorders` VALUES (18,'CRUISE','','2011-06-27 00:00:00',0.67,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Box 2001','Ft Lauderdale, Florida','','','','','Barry Toad','','Jack Roberts','1.00','2011-06-27','','1','2011-06-27','Authorised','27/06/2011 - Order Created and Authorised by Demonstration user  - <br />','30','');
INSERT INTO `purchorders` VALUES (19,'WHYNOT','','2011-08-06 00:00:00',1,NULL,1,'','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Well I will ','If I','Want ','To','','','','12323','Jack Roberts','0.00','2011-08-06','','','2011-08-06','Authorised','06/08/2011 - Order Created and Authorised by Demonstration user  - <br />','20','');
INSERT INTO `purchorders` VALUES (20,'BINGO','','2011-08-06 00:00:00',1.1,NULL,1,'','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Box 3499','Gardenier','San Fransisco','California 54424','','','','','Jack Roberts','0.00','2011-08-06','','','2011-08-06','Authorised','06/08/2011 - Order Created and Authorised by Demonstration user  - <br />','30','');
INSERT INTO `purchorders` VALUES (21,'WHYNOT','','2011-08-10 00:00:00',1,NULL,1,'admin','','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','Well I will ','If I','Want ','To','','','You think','12323','Jack Roberts','1.00','2011-08-10','','1','2011-08-10','Authorised','10/08/2011 - Order Created and Authorised by Demonstration user <br /><br />','20','');
INSERT INTO `purchorders` VALUES (22,'DUBROW','One two three four fix','2011-09-04 00:00:00',0.44,NULL,1,'admin','test','MEL','1234 Collins Street','Melbourne','Victoria 2345','','','Australia','+61 3 56789012','','','','','','','','','Jack Roberts','1.00','2011-09-04','','1','2011-09-04','Authorised','04/09/2011 - Order Created and Authorised by Demonstration user <br /><br />','30','');

--
-- Dumping data for table `recurringsalesorders`
--

INSERT INTO `recurringsalesorders` VALUES (3,'ANGRY','ANGRY','',NULL,NULL,'2007-01-01','DE',1,'','','','','','','0422 2245 2213','graville@angry.com','Angus Rouledge - Toronto',0,'DEN','2007-01-01','2009-01-01',6,0);
INSERT INTO `recurringsalesorders` VALUES (4,'ANGRY','ANGRY','',NULL,NULL,'2007-01-02','DE',1,'','','','','','','0422 2245 2213','graville@angry.com','Angus Rouledge - Toronto',0,'DEN','2007-01-02','2009-01-02',6,0);
INSERT INTO `recurringsalesorders` VALUES (5,'ANGRY','ANGRY','',NULL,NULL,'2007-02-01','DE',1,'','','','','','','0422 2245 2213','graville@angry.com','Angus Rouledge - Toronto',0,'DEN','2007-02-01','2009-02-01',6,0);
INSERT INTO `recurringsalesorders` VALUES (6,'ANGRY','ANGRY','',NULL,NULL,'2007-03-01','DE',1,'','','','','','','0422 2245 2213','graville@angry.com','Angus Rouledge - Toronto',0,'DEN','2007-03-01','2009-03-01',6,0);
INSERT INTO `recurringsalesorders` VALUES (7,'ANGRY','ANGRY','',NULL,NULL,'2007-04-01','DE',1,'','','','','','','0422 2245 2213','graville@angry.com','Angus Rouledge - Toronto',0,'DEN','2007-04-01','2009-04-01',6,0);

--
-- Dumping data for table `recurrsalesorderdetails`
--

INSERT INTO `recurrsalesorderdetails` VALUES (3,'DVD-DHWV',50,2,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (4,'DVD-LTWP',28,3,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (5,'DVD-UNSG2',15,5,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (6,'DVD-UNSG',17.5,6,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (7,'DVD-DHWV',30,1,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (3,'DVD-DHWV',50,2,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (4,'DVD-LTWP',28,3,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (5,'DVD-UNSG2',15,5,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (6,'DVD-UNSG',17.5,6,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (7,'DVD-DHWV',30,1,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (3,'DVD-DHWV',50,2,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (4,'DVD-LTWP',28,3,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (5,'DVD-UNSG2',15,5,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (6,'DVD-UNSG',17.5,6,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (7,'DVD-DHWV',30,1,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (3,'DVD-DHWV',50,2,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (4,'DVD-LTWP',28,3,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (5,'DVD-UNSG2',15,5,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (6,'DVD-UNSG',17.5,6,0,'');
INSERT INTO `recurrsalesorderdetails` VALUES (7,'DVD-DHWV',30,1,0,'');

--
-- Dumping data for table `reportcolumns`
--

INSERT INTO `reportcolumns` VALUES (1,1,'Value','',0,0,7,'Net Value',0,0,'',1,'N',0);

--
-- Dumping data for table `reportfields`
--

INSERT INTO `reportfields` VALUES (1803,135,'critlist',1,'prices.currabrev','Currency','0','0','0');
INSERT INTO `reportfields` VALUES (1802,135,'fieldlist',4,'prices.currabrev','Currency','1','1','0');
INSERT INTO `reportfields` VALUES (1801,135,'fieldlist',3,'prices.typeabbrev','Price List','1','1','0');
INSERT INTO `reportfields` VALUES (1800,135,'fieldlist',2,'prices.price','Price','1','1','0');
INSERT INTO `reportfields` VALUES (1799,135,'fieldlist',1,'stockmaster.stockid','Item','1','1','0');
INSERT INTO `reportfields` VALUES (1797,135,'trunclong',0,'','','1','1','0');
INSERT INTO `reportfields` VALUES (1798,135,'dateselect',0,'','','1','1','a');
INSERT INTO `reportfields` VALUES (1804,135,'sortlist',1,'stockmaster.stockid','Item','0','0','1');

--
-- Dumping data for table `reportheaders`
--

INSERT INTO `reportheaders` VALUES (1,'Test report','Sales Area',0,'0','zzzzz','Customer Code',0,'1','zzzzzzzzzz','Product Code',0,'1','zzzzzzzzz','Not Used',0,'','');

--
-- Dumping data for table `reportlinks`
--

INSERT INTO `reportlinks` VALUES ('accountgroups','accountsection','accountgroups.sectioninaccounts=accountsection.sectionid');
INSERT INTO `reportlinks` VALUES ('accountsection','accountgroups','accountsection.sectionid=accountgroups.sectioninaccounts');
INSERT INTO `reportlinks` VALUES ('bankaccounts','chartmaster','bankaccounts.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','bankaccounts','chartmaster.accountcode=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('banktrans','systypes','banktrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','banktrans','systypes.typeid=banktrans.type');
INSERT INTO `reportlinks` VALUES ('banktrans','bankaccounts','banktrans.bankact=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('bankaccounts','banktrans','bankaccounts.accountcode=banktrans.bankact');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.parent=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.parent');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.component');
INSERT INTO `reportlinks` VALUES ('bom','workcentres','bom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','bom','workcentres.code=bom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('bom','locations','bom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','bom','locations.loccode=bom.loccode');
INSERT INTO `reportlinks` VALUES ('buckets','workcentres','buckets.workcentre=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','buckets','workcentres.code=buckets.workcentre');
INSERT INTO `reportlinks` VALUES ('chartdetails','chartmaster','chartdetails.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','chartdetails','chartmaster.accountcode=chartdetails.accountcode');
INSERT INTO `reportlinks` VALUES ('chartdetails','periods','chartdetails.period=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','chartdetails','periods.periodno=chartdetails.period');
INSERT INTO `reportlinks` VALUES ('chartmaster','accountgroups','chartmaster.group_=accountgroups.groupname');
INSERT INTO `reportlinks` VALUES ('accountgroups','chartmaster','accountgroups.groupname=chartmaster.group_');
INSERT INTO `reportlinks` VALUES ('contractbom','workcentres','contractbom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','contractbom','workcentres.code=contractbom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('contractbom','locations','contractbom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','contractbom','locations.loccode=contractbom.loccode');
INSERT INTO `reportlinks` VALUES ('contractbom','stockmaster','contractbom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','contractbom','stockmaster.stockid=contractbom.component');
INSERT INTO `reportlinks` VALUES ('contractreqts','contracts','contractreqts.contract=contracts.contractref');
INSERT INTO `reportlinks` VALUES ('contracts','contractreqts','contracts.contractref=contractreqts.contract');
INSERT INTO `reportlinks` VALUES ('contracts','custbranch','contracts.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','contracts','custbranch.debtorno=contracts.debtorno');
INSERT INTO `reportlinks` VALUES ('contracts','stockcategory','contracts.branchcode=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','contracts','stockcategory.categoryid=contracts.branchcode');
INSERT INTO `reportlinks` VALUES ('contracts','salestypes','contracts.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','contracts','salestypes.typeabbrev=contracts.typeabbrev');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocfrom=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocto=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocto');
INSERT INTO `reportlinks` VALUES ('custbranch','debtorsmaster','custbranch.debtorno=debtorsmaster.debtorno');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','custbranch','debtorsmaster.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','areas','custbranch.area=areas.areacode');
INSERT INTO `reportlinks` VALUES ('areas','custbranch','areas.areacode=custbranch.area');
INSERT INTO `reportlinks` VALUES ('custbranch','salesman','custbranch.salesman=salesman.salesmancode');
INSERT INTO `reportlinks` VALUES ('salesman','custbranch','salesman.salesmancode=custbranch.salesman');
INSERT INTO `reportlinks` VALUES ('custbranch','locations','custbranch.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','custbranch','locations.loccode=custbranch.defaultlocation');
INSERT INTO `reportlinks` VALUES ('custbranch','shippers','custbranch.defaultshipvia=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','custbranch','shippers.shipper_id=custbranch.defaultshipvia');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','holdreasons','debtorsmaster.holdreason=holdreasons.reasoncode');
INSERT INTO `reportlinks` VALUES ('holdreasons','debtorsmaster','holdreasons.reasoncode=debtorsmaster.holdreason');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','currencies','debtorsmaster.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','debtorsmaster','currencies.currabrev=debtorsmaster.currcode');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','paymentterms','debtorsmaster.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','debtorsmaster','paymentterms.termsindicator=debtorsmaster.paymentterms');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','salestypes','debtorsmaster.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','debtorsmaster','salestypes.typeabbrev=debtorsmaster.salestype');
INSERT INTO `reportlinks` VALUES ('debtortrans','custbranch','debtortrans.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','debtortrans','custbranch.debtorno=debtortrans.debtorno');
INSERT INTO `reportlinks` VALUES ('debtortrans','systypes','debtortrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','debtortrans','systypes.typeid=debtortrans.type');
INSERT INTO `reportlinks` VALUES ('debtortrans','periods','debtortrans.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','debtortrans','periods.periodno=debtortrans.prd');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','taxauthorities','debtortranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','debtortranstaxes','taxauthorities.taxid=debtortranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','debtortrans','debtortranstaxes.debtortransid=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','debtortranstaxes','debtortrans.id=debtortranstaxes.debtortransid');
INSERT INTO `reportlinks` VALUES ('discountmatrix','salestypes','discountmatrix.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','discountmatrix','salestypes.typeabbrev=discountmatrix.salestype');
INSERT INTO `reportlinks` VALUES ('freightcosts','locations','freightcosts.locationfrom=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','freightcosts','locations.loccode=freightcosts.locationfrom');
INSERT INTO `reportlinks` VALUES ('freightcosts','shippers','freightcosts.shipperid=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','freightcosts','shippers.shipper_id=freightcosts.shipperid');
INSERT INTO `reportlinks` VALUES ('gltrans','chartmaster','gltrans.account=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','gltrans','chartmaster.accountcode=gltrans.account');
INSERT INTO `reportlinks` VALUES ('gltrans','systypes','gltrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','gltrans','systypes.typeid=gltrans.type');
INSERT INTO `reportlinks` VALUES ('gltrans','periods','gltrans.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','gltrans','periods.periodno=gltrans.periodno');
INSERT INTO `reportlinks` VALUES ('grns','suppliers','grns.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','grns','suppliers.supplierid=grns.supplierid');
INSERT INTO `reportlinks` VALUES ('grns','purchorderdetails','grns.podetailitem=purchorderdetails.podetailitem');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','grns','purchorderdetails.podetailitem=grns.podetailitem');
INSERT INTO `reportlinks` VALUES ('locations','taxprovinces','locations.taxprovinceid=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','locations','taxprovinces.taxprovinceid=locations.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('locstock','locations','locstock.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','locstock','locations.loccode=locstock.loccode');
INSERT INTO `reportlinks` VALUES ('locstock','stockmaster','locstock.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','locstock','stockmaster.stockid=locstock.stockid');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.shiploc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.shiploc');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.recloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.recloc');
INSERT INTO `reportlinks` VALUES ('loctransfers','stockmaster','loctransfers.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','loctransfers','stockmaster.stockid=loctransfers.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','stockmaster','orderdeliverydifferenceslog.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','orderdeliverydifferencesl','stockmaster.stockid=orderdeliverydifferenceslog.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','custbranch','orderdeliverydifferenceslog.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','orderdeliverydifferencesl','custbranch.debtorno=orderdeliverydifferenceslog.debtorno');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','salesorders','orderdeliverydifferenceslog.branchcode=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','orderdeliverydifferencesl','salesorders.orderno=orderdeliverydifferenceslog.branchcode');
INSERT INTO `reportlinks` VALUES ('prices','stockmaster','prices.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','prices','stockmaster.stockid=prices.stockid');
INSERT INTO `reportlinks` VALUES ('prices','currencies','prices.currabrev=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','prices','currencies.currabrev=prices.currabrev');
INSERT INTO `reportlinks` VALUES ('prices','salestypes','prices.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','prices','salestypes.typeabbrev=prices.typeabbrev');
INSERT INTO `reportlinks` VALUES ('purchdata','stockmaster','purchdata.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','purchdata','stockmaster.stockid=purchdata.stockid');
INSERT INTO `reportlinks` VALUES ('purchdata','suppliers','purchdata.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchdata','suppliers.supplierid=purchdata.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','purchorders','purchorderdetails.orderno=purchorders.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','purchorderdetails','purchorders.orderno=purchorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','suppliers','purchorders.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchorders','suppliers.supplierid=purchorders.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorders','locations','purchorders.intostocklocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','purchorders','locations.loccode=purchorders.intostocklocation');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','custbranch','recurringsalesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','recurringsalesorders','custbranch.branchcode=recurringsalesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','recurringsalesorders','recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','recurrsalesorderdetails','recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','stockmaster','recurrsalesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','recurrsalesorderdetails','stockmaster.stockid=recurrsalesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('reportcolumns','reportheaders','reportcolumns.reportid=reportheaders.reportid');
INSERT INTO `reportlinks` VALUES ('reportheaders','reportcolumns','reportheaders.reportid=reportcolumns.reportid');
INSERT INTO `reportlinks` VALUES ('salesanalysis','periods','salesanalysis.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','salesanalysis','periods.periodno=salesanalysis.periodno');
INSERT INTO `reportlinks` VALUES ('salescatprod','stockmaster','salescatprod.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salescatprod','stockmaster.stockid=salescatprod.stockid');
INSERT INTO `reportlinks` VALUES ('salescatprod','salescat','salescatprod.salescatid=salescat.salescatid');
INSERT INTO `reportlinks` VALUES ('salescat','salescatprod','salescat.salescatid=salescatprod.salescatid');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','salesorders','salesorderdetails.orderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','salesorderdetails','salesorders.orderno=salesorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','stockmaster','salesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salesorderdetails','stockmaster.stockid=salesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('salesorders','custbranch','salesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','salesorders','custbranch.branchcode=salesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('salesorders','shippers','salesorders.debtorno=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','salesorders','shippers.shipper_id=salesorders.debtorno');
INSERT INTO `reportlinks` VALUES ('salesorders','locations','salesorders.fromstkloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','salesorders','locations.loccode=salesorders.fromstkloc');
INSERT INTO `reportlinks` VALUES ('securitygroups','securityroles','securitygroups.secroleid=securityroles.secroleid');
INSERT INTO `reportlinks` VALUES ('securityroles','securitygroups','securityroles.secroleid=securitygroups.secroleid');
INSERT INTO `reportlinks` VALUES ('securitygroups','securitytokens','securitygroups.tokenid=securitytokens.tokenid');
INSERT INTO `reportlinks` VALUES ('securitytokens','securitygroups','securitytokens.tokenid=securitygroups.tokenid');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','shipments','shipmentcharges.shiptref=shipments.shiptref');
INSERT INTO `reportlinks` VALUES ('shipments','shipmentcharges','shipments.shiptref=shipmentcharges.shiptref');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','systypes','shipmentcharges.transtype=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','shipmentcharges','systypes.typeid=shipmentcharges.transtype');
INSERT INTO `reportlinks` VALUES ('shipments','suppliers','shipments.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','shipments','suppliers.supplierid=shipments.supplierid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','stockmaster','stockcheckfreeze.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcheckfreeze','stockmaster.stockid=stockcheckfreeze.stockid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','locations','stockcheckfreeze.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcheckfreeze','locations.loccode=stockcheckfreeze.loccode');
INSERT INTO `reportlinks` VALUES ('stockcounts','stockmaster','stockcounts.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcounts','stockmaster.stockid=stockcounts.stockid');
INSERT INTO `reportlinks` VALUES ('stockcounts','locations','stockcounts.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcounts','locations.loccode=stockcounts.loccode');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcategory','stockmaster.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','stockmaster','stockcategory.categoryid=stockmaster.categoryid');
INSERT INTO `reportlinks` VALUES ('stockmaster','taxcategories','stockmaster.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','stockmaster','taxcategories.taxcatid=stockmaster.taxcatid');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockmaster','stockmoves.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockmoves','stockmaster.stockid=stockmoves.stockid');
INSERT INTO `reportlinks` VALUES ('stockmoves','systypes','stockmoves.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','stockmoves','systypes.typeid=stockmoves.type');
INSERT INTO `reportlinks` VALUES ('stockmoves','locations','stockmoves.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockmoves','locations.loccode=stockmoves.loccode');
INSERT INTO `reportlinks` VALUES ('stockmoves','periods','stockmoves.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','stockmoves','periods.periodno=stockmoves.prd');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','taxauthorities','stockmovestaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','stockmovestaxes','taxauthorities.taxid=stockmovestaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockmaster','stockserialitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockserialitems','stockmaster.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','locations','stockserialitems.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockserialitems','locations.loccode=stockserialitems.loccode');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockmoves','stockserialmoves.stockmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockserialmoves','stockmoves.stkmoveno=stockserialmoves.stockmoveno');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockserialitems','stockserialmoves.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockserialmoves','stockserialitems.stockid=stockserialmoves.stockid');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocfrom=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocto=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocto');
INSERT INTO `reportlinks` VALUES ('suppliercontacts','suppliers','suppliercontacts.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','suppliercontacts','suppliers.supplierid=suppliercontacts.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','currencies','suppliers.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','suppliers','currencies.currabrev=suppliers.currcode');
INSERT INTO `reportlinks` VALUES ('suppliers','paymentterms','suppliers.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','suppliers','paymentterms.termsindicator=suppliers.paymentterms');
INSERT INTO `reportlinks` VALUES ('suppliers','taxgroups','suppliers.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','suppliers','taxgroups.taxgroupid=suppliers.taxgroupid');
INSERT INTO `reportlinks` VALUES ('supptrans','systypes','supptrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','supptrans','systypes.typeid=supptrans.type');
INSERT INTO `reportlinks` VALUES ('supptrans','suppliers','supptrans.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','supptrans','suppliers.supplierid=supptrans.supplierno');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','taxauthorities','supptranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','supptranstaxes','taxauthorities.taxid=supptranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','supptrans','supptranstaxes.supptransid=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','supptranstaxes','supptrans.id=supptranstaxes.supptransid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.taxglcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.taxglcode');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.purchtaxglaccount=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.purchtaxglaccount');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxauthorities','taxauthrates.taxauthority=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxauthrates','taxauthorities.taxid=taxauthrates.taxauthority');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxcategories','taxauthrates.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','taxauthrates','taxcategories.taxcatid=taxauthrates.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxprovinces','taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','taxauthrates','taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxgroups','taxgrouptaxes.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','taxgrouptaxes','taxgroups.taxgroupid=taxgrouptaxes.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxauthorities','taxgrouptaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxgrouptaxes','taxauthorities.taxid=taxgrouptaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('workcentres','locations','workcentres.location=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','workcentres','locations.loccode=workcentres.location');
INSERT INTO `reportlinks` VALUES ('worksorders','locations','worksorders.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','worksorders','locations.loccode=worksorders.loccode');
INSERT INTO `reportlinks` VALUES ('worksorders','stockmaster','worksorders.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','worksorders','stockmaster.stockid=worksorders.stockid');
INSERT INTO `reportlinks` VALUES ('www_users','locations','www_users.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','www_users','locations.loccode=www_users.defaultlocation');
INSERT INTO `reportlinks` VALUES ('accountgroups','accountsection','accountgroups.sectioninaccounts=accountsection.sectionid');
INSERT INTO `reportlinks` VALUES ('accountsection','accountgroups','accountsection.sectionid=accountgroups.sectioninaccounts');
INSERT INTO `reportlinks` VALUES ('bankaccounts','chartmaster','bankaccounts.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','bankaccounts','chartmaster.accountcode=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('banktrans','systypes','banktrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','banktrans','systypes.typeid=banktrans.type');
INSERT INTO `reportlinks` VALUES ('banktrans','bankaccounts','banktrans.bankact=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('bankaccounts','banktrans','bankaccounts.accountcode=banktrans.bankact');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.parent=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.parent');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.component');
INSERT INTO `reportlinks` VALUES ('bom','workcentres','bom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','bom','workcentres.code=bom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('bom','locations','bom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','bom','locations.loccode=bom.loccode');
INSERT INTO `reportlinks` VALUES ('buckets','workcentres','buckets.workcentre=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','buckets','workcentres.code=buckets.workcentre');
INSERT INTO `reportlinks` VALUES ('chartdetails','chartmaster','chartdetails.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','chartdetails','chartmaster.accountcode=chartdetails.accountcode');
INSERT INTO `reportlinks` VALUES ('chartdetails','periods','chartdetails.period=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','chartdetails','periods.periodno=chartdetails.period');
INSERT INTO `reportlinks` VALUES ('chartmaster','accountgroups','chartmaster.group_=accountgroups.groupname');
INSERT INTO `reportlinks` VALUES ('accountgroups','chartmaster','accountgroups.groupname=chartmaster.group_');
INSERT INTO `reportlinks` VALUES ('contractbom','workcentres','contractbom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','contractbom','workcentres.code=contractbom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('contractbom','locations','contractbom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','contractbom','locations.loccode=contractbom.loccode');
INSERT INTO `reportlinks` VALUES ('contractbom','stockmaster','contractbom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','contractbom','stockmaster.stockid=contractbom.component');
INSERT INTO `reportlinks` VALUES ('contractreqts','contracts','contractreqts.contract=contracts.contractref');
INSERT INTO `reportlinks` VALUES ('contracts','contractreqts','contracts.contractref=contractreqts.contract');
INSERT INTO `reportlinks` VALUES ('contracts','custbranch','contracts.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','contracts','custbranch.debtorno=contracts.debtorno');
INSERT INTO `reportlinks` VALUES ('contracts','stockcategory','contracts.branchcode=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','contracts','stockcategory.categoryid=contracts.branchcode');
INSERT INTO `reportlinks` VALUES ('contracts','salestypes','contracts.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','contracts','salestypes.typeabbrev=contracts.typeabbrev');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocfrom=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocto=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocto');
INSERT INTO `reportlinks` VALUES ('custbranch','debtorsmaster','custbranch.debtorno=debtorsmaster.debtorno');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','custbranch','debtorsmaster.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','areas','custbranch.area=areas.areacode');
INSERT INTO `reportlinks` VALUES ('areas','custbranch','areas.areacode=custbranch.area');
INSERT INTO `reportlinks` VALUES ('custbranch','salesman','custbranch.salesman=salesman.salesmancode');
INSERT INTO `reportlinks` VALUES ('salesman','custbranch','salesman.salesmancode=custbranch.salesman');
INSERT INTO `reportlinks` VALUES ('custbranch','locations','custbranch.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','custbranch','locations.loccode=custbranch.defaultlocation');
INSERT INTO `reportlinks` VALUES ('custbranch','shippers','custbranch.defaultshipvia=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','custbranch','shippers.shipper_id=custbranch.defaultshipvia');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','holdreasons','debtorsmaster.holdreason=holdreasons.reasoncode');
INSERT INTO `reportlinks` VALUES ('holdreasons','debtorsmaster','holdreasons.reasoncode=debtorsmaster.holdreason');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','currencies','debtorsmaster.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','debtorsmaster','currencies.currabrev=debtorsmaster.currcode');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','paymentterms','debtorsmaster.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','debtorsmaster','paymentterms.termsindicator=debtorsmaster.paymentterms');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','salestypes','debtorsmaster.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','debtorsmaster','salestypes.typeabbrev=debtorsmaster.salestype');
INSERT INTO `reportlinks` VALUES ('debtortrans','custbranch','debtortrans.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','debtortrans','custbranch.debtorno=debtortrans.debtorno');
INSERT INTO `reportlinks` VALUES ('debtortrans','systypes','debtortrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','debtortrans','systypes.typeid=debtortrans.type');
INSERT INTO `reportlinks` VALUES ('debtortrans','periods','debtortrans.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','debtortrans','periods.periodno=debtortrans.prd');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','taxauthorities','debtortranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','debtortranstaxes','taxauthorities.taxid=debtortranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','debtortrans','debtortranstaxes.debtortransid=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','debtortranstaxes','debtortrans.id=debtortranstaxes.debtortransid');
INSERT INTO `reportlinks` VALUES ('discountmatrix','salestypes','discountmatrix.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','discountmatrix','salestypes.typeabbrev=discountmatrix.salestype');
INSERT INTO `reportlinks` VALUES ('freightcosts','locations','freightcosts.locationfrom=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','freightcosts','locations.loccode=freightcosts.locationfrom');
INSERT INTO `reportlinks` VALUES ('freightcosts','shippers','freightcosts.shipperid=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','freightcosts','shippers.shipper_id=freightcosts.shipperid');
INSERT INTO `reportlinks` VALUES ('gltrans','chartmaster','gltrans.account=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','gltrans','chartmaster.accountcode=gltrans.account');
INSERT INTO `reportlinks` VALUES ('gltrans','systypes','gltrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','gltrans','systypes.typeid=gltrans.type');
INSERT INTO `reportlinks` VALUES ('gltrans','periods','gltrans.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','gltrans','periods.periodno=gltrans.periodno');
INSERT INTO `reportlinks` VALUES ('grns','suppliers','grns.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','grns','suppliers.supplierid=grns.supplierid');
INSERT INTO `reportlinks` VALUES ('grns','purchorderdetails','grns.podetailitem=purchorderdetails.podetailitem');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','grns','purchorderdetails.podetailitem=grns.podetailitem');
INSERT INTO `reportlinks` VALUES ('locations','taxprovinces','locations.taxprovinceid=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','locations','taxprovinces.taxprovinceid=locations.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('locstock','locations','locstock.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','locstock','locations.loccode=locstock.loccode');
INSERT INTO `reportlinks` VALUES ('locstock','stockmaster','locstock.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','locstock','stockmaster.stockid=locstock.stockid');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.shiploc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.shiploc');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.recloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.recloc');
INSERT INTO `reportlinks` VALUES ('loctransfers','stockmaster','loctransfers.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','loctransfers','stockmaster.stockid=loctransfers.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','stockmaster','orderdeliverydifferenceslog.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','orderdeliverydifferencesl','stockmaster.stockid=orderdeliverydifferenceslog.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','custbranch','orderdeliverydifferenceslog.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','orderdeliverydifferencesl','custbranch.debtorno=orderdeliverydifferenceslog.debtorno');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','salesorders','orderdeliverydifferenceslog.branchcode=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','orderdeliverydifferencesl','salesorders.orderno=orderdeliverydifferenceslog.branchcode');
INSERT INTO `reportlinks` VALUES ('prices','stockmaster','prices.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','prices','stockmaster.stockid=prices.stockid');
INSERT INTO `reportlinks` VALUES ('prices','currencies','prices.currabrev=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','prices','currencies.currabrev=prices.currabrev');
INSERT INTO `reportlinks` VALUES ('prices','salestypes','prices.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','prices','salestypes.typeabbrev=prices.typeabbrev');
INSERT INTO `reportlinks` VALUES ('purchdata','stockmaster','purchdata.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','purchdata','stockmaster.stockid=purchdata.stockid');
INSERT INTO `reportlinks` VALUES ('purchdata','suppliers','purchdata.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchdata','suppliers.supplierid=purchdata.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','purchorders','purchorderdetails.orderno=purchorders.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','purchorderdetails','purchorders.orderno=purchorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','suppliers','purchorders.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchorders','suppliers.supplierid=purchorders.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorders','locations','purchorders.intostocklocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','purchorders','locations.loccode=purchorders.intostocklocation');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','custbranch','recurringsalesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','recurringsalesorders','custbranch.branchcode=recurringsalesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','recurringsalesorders','recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','recurrsalesorderdetails','recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','stockmaster','recurrsalesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','recurrsalesorderdetails','stockmaster.stockid=recurrsalesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('reportcolumns','reportheaders','reportcolumns.reportid=reportheaders.reportid');
INSERT INTO `reportlinks` VALUES ('reportheaders','reportcolumns','reportheaders.reportid=reportcolumns.reportid');
INSERT INTO `reportlinks` VALUES ('salesanalysis','periods','salesanalysis.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','salesanalysis','periods.periodno=salesanalysis.periodno');
INSERT INTO `reportlinks` VALUES ('salescatprod','stockmaster','salescatprod.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salescatprod','stockmaster.stockid=salescatprod.stockid');
INSERT INTO `reportlinks` VALUES ('salescatprod','salescat','salescatprod.salescatid=salescat.salescatid');
INSERT INTO `reportlinks` VALUES ('salescat','salescatprod','salescat.salescatid=salescatprod.salescatid');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','salesorders','salesorderdetails.orderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','salesorderdetails','salesorders.orderno=salesorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','stockmaster','salesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salesorderdetails','stockmaster.stockid=salesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('salesorders','custbranch','salesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','salesorders','custbranch.branchcode=salesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('salesorders','shippers','salesorders.debtorno=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','salesorders','shippers.shipper_id=salesorders.debtorno');
INSERT INTO `reportlinks` VALUES ('salesorders','locations','salesorders.fromstkloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','salesorders','locations.loccode=salesorders.fromstkloc');
INSERT INTO `reportlinks` VALUES ('securitygroups','securityroles','securitygroups.secroleid=securityroles.secroleid');
INSERT INTO `reportlinks` VALUES ('securityroles','securitygroups','securityroles.secroleid=securitygroups.secroleid');
INSERT INTO `reportlinks` VALUES ('securitygroups','securitytokens','securitygroups.tokenid=securitytokens.tokenid');
INSERT INTO `reportlinks` VALUES ('securitytokens','securitygroups','securitytokens.tokenid=securitygroups.tokenid');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','shipments','shipmentcharges.shiptref=shipments.shiptref');
INSERT INTO `reportlinks` VALUES ('shipments','shipmentcharges','shipments.shiptref=shipmentcharges.shiptref');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','systypes','shipmentcharges.transtype=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','shipmentcharges','systypes.typeid=shipmentcharges.transtype');
INSERT INTO `reportlinks` VALUES ('shipments','suppliers','shipments.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','shipments','suppliers.supplierid=shipments.supplierid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','stockmaster','stockcheckfreeze.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcheckfreeze','stockmaster.stockid=stockcheckfreeze.stockid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','locations','stockcheckfreeze.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcheckfreeze','locations.loccode=stockcheckfreeze.loccode');
INSERT INTO `reportlinks` VALUES ('stockcounts','stockmaster','stockcounts.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcounts','stockmaster.stockid=stockcounts.stockid');
INSERT INTO `reportlinks` VALUES ('stockcounts','locations','stockcounts.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcounts','locations.loccode=stockcounts.loccode');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcategory','stockmaster.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','stockmaster','stockcategory.categoryid=stockmaster.categoryid');
INSERT INTO `reportlinks` VALUES ('stockmaster','taxcategories','stockmaster.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','stockmaster','taxcategories.taxcatid=stockmaster.taxcatid');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockmaster','stockmoves.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockmoves','stockmaster.stockid=stockmoves.stockid');
INSERT INTO `reportlinks` VALUES ('stockmoves','systypes','stockmoves.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','stockmoves','systypes.typeid=stockmoves.type');
INSERT INTO `reportlinks` VALUES ('stockmoves','locations','stockmoves.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockmoves','locations.loccode=stockmoves.loccode');
INSERT INTO `reportlinks` VALUES ('stockmoves','periods','stockmoves.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','stockmoves','periods.periodno=stockmoves.prd');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','taxauthorities','stockmovestaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','stockmovestaxes','taxauthorities.taxid=stockmovestaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockmaster','stockserialitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockserialitems','stockmaster.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','locations','stockserialitems.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockserialitems','locations.loccode=stockserialitems.loccode');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockmoves','stockserialmoves.stockmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockserialmoves','stockmoves.stkmoveno=stockserialmoves.stockmoveno');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockserialitems','stockserialmoves.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockserialmoves','stockserialitems.stockid=stockserialmoves.stockid');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocfrom=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocto=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocto');
INSERT INTO `reportlinks` VALUES ('suppliercontacts','suppliers','suppliercontacts.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','suppliercontacts','suppliers.supplierid=suppliercontacts.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','currencies','suppliers.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','suppliers','currencies.currabrev=suppliers.currcode');
INSERT INTO `reportlinks` VALUES ('suppliers','paymentterms','suppliers.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','suppliers','paymentterms.termsindicator=suppliers.paymentterms');
INSERT INTO `reportlinks` VALUES ('suppliers','taxgroups','suppliers.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','suppliers','taxgroups.taxgroupid=suppliers.taxgroupid');
INSERT INTO `reportlinks` VALUES ('supptrans','systypes','supptrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','supptrans','systypes.typeid=supptrans.type');
INSERT INTO `reportlinks` VALUES ('supptrans','suppliers','supptrans.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','supptrans','suppliers.supplierid=supptrans.supplierno');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','taxauthorities','supptranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','supptranstaxes','taxauthorities.taxid=supptranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','supptrans','supptranstaxes.supptransid=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','supptranstaxes','supptrans.id=supptranstaxes.supptransid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.taxglcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.taxglcode');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.purchtaxglaccount=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.purchtaxglaccount');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxauthorities','taxauthrates.taxauthority=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxauthrates','taxauthorities.taxid=taxauthrates.taxauthority');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxcategories','taxauthrates.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','taxauthrates','taxcategories.taxcatid=taxauthrates.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxprovinces','taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','taxauthrates','taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxgroups','taxgrouptaxes.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','taxgrouptaxes','taxgroups.taxgroupid=taxgrouptaxes.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxauthorities','taxgrouptaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxgrouptaxes','taxauthorities.taxid=taxgrouptaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('workcentres','locations','workcentres.location=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','workcentres','locations.loccode=workcentres.location');
INSERT INTO `reportlinks` VALUES ('worksorders','locations','worksorders.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','worksorders','locations.loccode=worksorders.loccode');
INSERT INTO `reportlinks` VALUES ('worksorders','stockmaster','worksorders.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','worksorders','stockmaster.stockid=worksorders.stockid');
INSERT INTO `reportlinks` VALUES ('www_users','locations','www_users.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','www_users','locations.loccode=www_users.defaultlocation');
INSERT INTO `reportlinks` VALUES ('accountgroups','accountsection','accountgroups.sectioninaccounts=accountsection.sectionid');
INSERT INTO `reportlinks` VALUES ('accountsection','accountgroups','accountsection.sectionid=accountgroups.sectioninaccounts');
INSERT INTO `reportlinks` VALUES ('bankaccounts','chartmaster','bankaccounts.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','bankaccounts','chartmaster.accountcode=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('banktrans','systypes','banktrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','banktrans','systypes.typeid=banktrans.type');
INSERT INTO `reportlinks` VALUES ('banktrans','bankaccounts','banktrans.bankact=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('bankaccounts','banktrans','bankaccounts.accountcode=banktrans.bankact');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.parent=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.parent');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.component');
INSERT INTO `reportlinks` VALUES ('bom','workcentres','bom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','bom','workcentres.code=bom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('bom','locations','bom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','bom','locations.loccode=bom.loccode');
INSERT INTO `reportlinks` VALUES ('buckets','workcentres','buckets.workcentre=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','buckets','workcentres.code=buckets.workcentre');
INSERT INTO `reportlinks` VALUES ('chartdetails','chartmaster','chartdetails.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','chartdetails','chartmaster.accountcode=chartdetails.accountcode');
INSERT INTO `reportlinks` VALUES ('chartdetails','periods','chartdetails.period=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','chartdetails','periods.periodno=chartdetails.period');
INSERT INTO `reportlinks` VALUES ('chartmaster','accountgroups','chartmaster.group_=accountgroups.groupname');
INSERT INTO `reportlinks` VALUES ('accountgroups','chartmaster','accountgroups.groupname=chartmaster.group_');
INSERT INTO `reportlinks` VALUES ('contractbom','workcentres','contractbom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','contractbom','workcentres.code=contractbom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('contractbom','locations','contractbom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','contractbom','locations.loccode=contractbom.loccode');
INSERT INTO `reportlinks` VALUES ('contractbom','stockmaster','contractbom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','contractbom','stockmaster.stockid=contractbom.component');
INSERT INTO `reportlinks` VALUES ('contractreqts','contracts','contractreqts.contract=contracts.contractref');
INSERT INTO `reportlinks` VALUES ('contracts','contractreqts','contracts.contractref=contractreqts.contract');
INSERT INTO `reportlinks` VALUES ('contracts','custbranch','contracts.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','contracts','custbranch.debtorno=contracts.debtorno');
INSERT INTO `reportlinks` VALUES ('contracts','stockcategory','contracts.branchcode=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','contracts','stockcategory.categoryid=contracts.branchcode');
INSERT INTO `reportlinks` VALUES ('contracts','salestypes','contracts.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','contracts','salestypes.typeabbrev=contracts.typeabbrev');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocfrom=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocto=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocto');
INSERT INTO `reportlinks` VALUES ('custbranch','debtorsmaster','custbranch.debtorno=debtorsmaster.debtorno');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','custbranch','debtorsmaster.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','areas','custbranch.area=areas.areacode');
INSERT INTO `reportlinks` VALUES ('areas','custbranch','areas.areacode=custbranch.area');
INSERT INTO `reportlinks` VALUES ('custbranch','salesman','custbranch.salesman=salesman.salesmancode');
INSERT INTO `reportlinks` VALUES ('salesman','custbranch','salesman.salesmancode=custbranch.salesman');
INSERT INTO `reportlinks` VALUES ('custbranch','locations','custbranch.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','custbranch','locations.loccode=custbranch.defaultlocation');
INSERT INTO `reportlinks` VALUES ('custbranch','shippers','custbranch.defaultshipvia=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','custbranch','shippers.shipper_id=custbranch.defaultshipvia');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','holdreasons','debtorsmaster.holdreason=holdreasons.reasoncode');
INSERT INTO `reportlinks` VALUES ('holdreasons','debtorsmaster','holdreasons.reasoncode=debtorsmaster.holdreason');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','currencies','debtorsmaster.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','debtorsmaster','currencies.currabrev=debtorsmaster.currcode');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','paymentterms','debtorsmaster.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','debtorsmaster','paymentterms.termsindicator=debtorsmaster.paymentterms');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','salestypes','debtorsmaster.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','debtorsmaster','salestypes.typeabbrev=debtorsmaster.salestype');
INSERT INTO `reportlinks` VALUES ('debtortrans','custbranch','debtortrans.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','debtortrans','custbranch.debtorno=debtortrans.debtorno');
INSERT INTO `reportlinks` VALUES ('debtortrans','systypes','debtortrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','debtortrans','systypes.typeid=debtortrans.type');
INSERT INTO `reportlinks` VALUES ('debtortrans','periods','debtortrans.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','debtortrans','periods.periodno=debtortrans.prd');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','taxauthorities','debtortranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','debtortranstaxes','taxauthorities.taxid=debtortranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','debtortrans','debtortranstaxes.debtortransid=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','debtortranstaxes','debtortrans.id=debtortranstaxes.debtortransid');
INSERT INTO `reportlinks` VALUES ('discountmatrix','salestypes','discountmatrix.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','discountmatrix','salestypes.typeabbrev=discountmatrix.salestype');
INSERT INTO `reportlinks` VALUES ('freightcosts','locations','freightcosts.locationfrom=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','freightcosts','locations.loccode=freightcosts.locationfrom');
INSERT INTO `reportlinks` VALUES ('freightcosts','shippers','freightcosts.shipperid=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','freightcosts','shippers.shipper_id=freightcosts.shipperid');
INSERT INTO `reportlinks` VALUES ('gltrans','chartmaster','gltrans.account=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','gltrans','chartmaster.accountcode=gltrans.account');
INSERT INTO `reportlinks` VALUES ('gltrans','systypes','gltrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','gltrans','systypes.typeid=gltrans.type');
INSERT INTO `reportlinks` VALUES ('gltrans','periods','gltrans.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','gltrans','periods.periodno=gltrans.periodno');
INSERT INTO `reportlinks` VALUES ('grns','suppliers','grns.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','grns','suppliers.supplierid=grns.supplierid');
INSERT INTO `reportlinks` VALUES ('grns','purchorderdetails','grns.podetailitem=purchorderdetails.podetailitem');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','grns','purchorderdetails.podetailitem=grns.podetailitem');
INSERT INTO `reportlinks` VALUES ('locations','taxprovinces','locations.taxprovinceid=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','locations','taxprovinces.taxprovinceid=locations.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('locstock','locations','locstock.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','locstock','locations.loccode=locstock.loccode');
INSERT INTO `reportlinks` VALUES ('locstock','stockmaster','locstock.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','locstock','stockmaster.stockid=locstock.stockid');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.shiploc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.shiploc');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.recloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.recloc');
INSERT INTO `reportlinks` VALUES ('loctransfers','stockmaster','loctransfers.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','loctransfers','stockmaster.stockid=loctransfers.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','stockmaster','orderdeliverydifferenceslog.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','orderdeliverydifferencesl','stockmaster.stockid=orderdeliverydifferenceslog.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','custbranch','orderdeliverydifferenceslog.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','orderdeliverydifferencesl','custbranch.debtorno=orderdeliverydifferenceslog.debtorno');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','salesorders','orderdeliverydifferenceslog.branchcode=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','orderdeliverydifferencesl','salesorders.orderno=orderdeliverydifferenceslog.branchcode');
INSERT INTO `reportlinks` VALUES ('prices','stockmaster','prices.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','prices','stockmaster.stockid=prices.stockid');
INSERT INTO `reportlinks` VALUES ('prices','currencies','prices.currabrev=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','prices','currencies.currabrev=prices.currabrev');
INSERT INTO `reportlinks` VALUES ('prices','salestypes','prices.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','prices','salestypes.typeabbrev=prices.typeabbrev');
INSERT INTO `reportlinks` VALUES ('purchdata','stockmaster','purchdata.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','purchdata','stockmaster.stockid=purchdata.stockid');
INSERT INTO `reportlinks` VALUES ('purchdata','suppliers','purchdata.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchdata','suppliers.supplierid=purchdata.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','purchorders','purchorderdetails.orderno=purchorders.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','purchorderdetails','purchorders.orderno=purchorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','suppliers','purchorders.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchorders','suppliers.supplierid=purchorders.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorders','locations','purchorders.intostocklocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','purchorders','locations.loccode=purchorders.intostocklocation');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','custbranch','recurringsalesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','recurringsalesorders','custbranch.branchcode=recurringsalesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','recurringsalesorders','recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','recurrsalesorderdetails','recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','stockmaster','recurrsalesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','recurrsalesorderdetails','stockmaster.stockid=recurrsalesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('reportcolumns','reportheaders','reportcolumns.reportid=reportheaders.reportid');
INSERT INTO `reportlinks` VALUES ('reportheaders','reportcolumns','reportheaders.reportid=reportcolumns.reportid');
INSERT INTO `reportlinks` VALUES ('salesanalysis','periods','salesanalysis.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','salesanalysis','periods.periodno=salesanalysis.periodno');
INSERT INTO `reportlinks` VALUES ('salescatprod','stockmaster','salescatprod.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salescatprod','stockmaster.stockid=salescatprod.stockid');
INSERT INTO `reportlinks` VALUES ('salescatprod','salescat','salescatprod.salescatid=salescat.salescatid');
INSERT INTO `reportlinks` VALUES ('salescat','salescatprod','salescat.salescatid=salescatprod.salescatid');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','salesorders','salesorderdetails.orderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','salesorderdetails','salesorders.orderno=salesorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','stockmaster','salesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salesorderdetails','stockmaster.stockid=salesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('salesorders','custbranch','salesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','salesorders','custbranch.branchcode=salesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('salesorders','shippers','salesorders.debtorno=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','salesorders','shippers.shipper_id=salesorders.debtorno');
INSERT INTO `reportlinks` VALUES ('salesorders','locations','salesorders.fromstkloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','salesorders','locations.loccode=salesorders.fromstkloc');
INSERT INTO `reportlinks` VALUES ('securitygroups','securityroles','securitygroups.secroleid=securityroles.secroleid');
INSERT INTO `reportlinks` VALUES ('securityroles','securitygroups','securityroles.secroleid=securitygroups.secroleid');
INSERT INTO `reportlinks` VALUES ('securitygroups','securitytokens','securitygroups.tokenid=securitytokens.tokenid');
INSERT INTO `reportlinks` VALUES ('securitytokens','securitygroups','securitytokens.tokenid=securitygroups.tokenid');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','shipments','shipmentcharges.shiptref=shipments.shiptref');
INSERT INTO `reportlinks` VALUES ('shipments','shipmentcharges','shipments.shiptref=shipmentcharges.shiptref');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','systypes','shipmentcharges.transtype=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','shipmentcharges','systypes.typeid=shipmentcharges.transtype');
INSERT INTO `reportlinks` VALUES ('shipments','suppliers','shipments.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','shipments','suppliers.supplierid=shipments.supplierid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','stockmaster','stockcheckfreeze.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcheckfreeze','stockmaster.stockid=stockcheckfreeze.stockid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','locations','stockcheckfreeze.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcheckfreeze','locations.loccode=stockcheckfreeze.loccode');
INSERT INTO `reportlinks` VALUES ('stockcounts','stockmaster','stockcounts.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcounts','stockmaster.stockid=stockcounts.stockid');
INSERT INTO `reportlinks` VALUES ('stockcounts','locations','stockcounts.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcounts','locations.loccode=stockcounts.loccode');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcategory','stockmaster.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','stockmaster','stockcategory.categoryid=stockmaster.categoryid');
INSERT INTO `reportlinks` VALUES ('stockmaster','taxcategories','stockmaster.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','stockmaster','taxcategories.taxcatid=stockmaster.taxcatid');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockmaster','stockmoves.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockmoves','stockmaster.stockid=stockmoves.stockid');
INSERT INTO `reportlinks` VALUES ('stockmoves','systypes','stockmoves.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','stockmoves','systypes.typeid=stockmoves.type');
INSERT INTO `reportlinks` VALUES ('stockmoves','locations','stockmoves.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockmoves','locations.loccode=stockmoves.loccode');
INSERT INTO `reportlinks` VALUES ('stockmoves','periods','stockmoves.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','stockmoves','periods.periodno=stockmoves.prd');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','taxauthorities','stockmovestaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','stockmovestaxes','taxauthorities.taxid=stockmovestaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockmaster','stockserialitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockserialitems','stockmaster.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','locations','stockserialitems.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockserialitems','locations.loccode=stockserialitems.loccode');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockmoves','stockserialmoves.stockmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockserialmoves','stockmoves.stkmoveno=stockserialmoves.stockmoveno');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockserialitems','stockserialmoves.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockserialmoves','stockserialitems.stockid=stockserialmoves.stockid');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocfrom=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocto=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocto');
INSERT INTO `reportlinks` VALUES ('suppliercontacts','suppliers','suppliercontacts.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','suppliercontacts','suppliers.supplierid=suppliercontacts.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','currencies','suppliers.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','suppliers','currencies.currabrev=suppliers.currcode');
INSERT INTO `reportlinks` VALUES ('suppliers','paymentterms','suppliers.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','suppliers','paymentterms.termsindicator=suppliers.paymentterms');
INSERT INTO `reportlinks` VALUES ('suppliers','taxgroups','suppliers.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','suppliers','taxgroups.taxgroupid=suppliers.taxgroupid');
INSERT INTO `reportlinks` VALUES ('supptrans','systypes','supptrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','supptrans','systypes.typeid=supptrans.type');
INSERT INTO `reportlinks` VALUES ('supptrans','suppliers','supptrans.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','supptrans','suppliers.supplierid=supptrans.supplierno');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','taxauthorities','supptranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','supptranstaxes','taxauthorities.taxid=supptranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','supptrans','supptranstaxes.supptransid=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','supptranstaxes','supptrans.id=supptranstaxes.supptransid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.taxglcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.taxglcode');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.purchtaxglaccount=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.purchtaxglaccount');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxauthorities','taxauthrates.taxauthority=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxauthrates','taxauthorities.taxid=taxauthrates.taxauthority');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxcategories','taxauthrates.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','taxauthrates','taxcategories.taxcatid=taxauthrates.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxprovinces','taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','taxauthrates','taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxgroups','taxgrouptaxes.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','taxgrouptaxes','taxgroups.taxgroupid=taxgrouptaxes.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxauthorities','taxgrouptaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxgrouptaxes','taxauthorities.taxid=taxgrouptaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('workcentres','locations','workcentres.location=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','workcentres','locations.loccode=workcentres.location');
INSERT INTO `reportlinks` VALUES ('worksorders','locations','worksorders.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','worksorders','locations.loccode=worksorders.loccode');
INSERT INTO `reportlinks` VALUES ('worksorders','stockmaster','worksorders.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','worksorders','stockmaster.stockid=worksorders.stockid');
INSERT INTO `reportlinks` VALUES ('www_users','locations','www_users.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','www_users','locations.loccode=www_users.defaultlocation');
INSERT INTO `reportlinks` VALUES ('accountgroups','accountsection','accountgroups.sectioninaccounts=accountsection.sectionid');
INSERT INTO `reportlinks` VALUES ('accountsection','accountgroups','accountsection.sectionid=accountgroups.sectioninaccounts');
INSERT INTO `reportlinks` VALUES ('bankaccounts','chartmaster','bankaccounts.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','bankaccounts','chartmaster.accountcode=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('banktrans','systypes','banktrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','banktrans','systypes.typeid=banktrans.type');
INSERT INTO `reportlinks` VALUES ('banktrans','bankaccounts','banktrans.bankact=bankaccounts.accountcode');
INSERT INTO `reportlinks` VALUES ('bankaccounts','banktrans','bankaccounts.accountcode=banktrans.bankact');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.parent=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.parent');
INSERT INTO `reportlinks` VALUES ('bom','stockmaster','bom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','bom','stockmaster.stockid=bom.component');
INSERT INTO `reportlinks` VALUES ('bom','workcentres','bom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','bom','workcentres.code=bom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('bom','locations','bom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','bom','locations.loccode=bom.loccode');
INSERT INTO `reportlinks` VALUES ('buckets','workcentres','buckets.workcentre=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','buckets','workcentres.code=buckets.workcentre');
INSERT INTO `reportlinks` VALUES ('chartdetails','chartmaster','chartdetails.accountcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','chartdetails','chartmaster.accountcode=chartdetails.accountcode');
INSERT INTO `reportlinks` VALUES ('chartdetails','periods','chartdetails.period=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','chartdetails','periods.periodno=chartdetails.period');
INSERT INTO `reportlinks` VALUES ('chartmaster','accountgroups','chartmaster.group_=accountgroups.groupname');
INSERT INTO `reportlinks` VALUES ('accountgroups','chartmaster','accountgroups.groupname=chartmaster.group_');
INSERT INTO `reportlinks` VALUES ('contractbom','workcentres','contractbom.workcentreadded=workcentres.code');
INSERT INTO `reportlinks` VALUES ('workcentres','contractbom','workcentres.code=contractbom.workcentreadded');
INSERT INTO `reportlinks` VALUES ('contractbom','locations','contractbom.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','contractbom','locations.loccode=contractbom.loccode');
INSERT INTO `reportlinks` VALUES ('contractbom','stockmaster','contractbom.component=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','contractbom','stockmaster.stockid=contractbom.component');
INSERT INTO `reportlinks` VALUES ('contractreqts','contracts','contractreqts.contract=contracts.contractref');
INSERT INTO `reportlinks` VALUES ('contracts','contractreqts','contracts.contractref=contractreqts.contract');
INSERT INTO `reportlinks` VALUES ('contracts','custbranch','contracts.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','contracts','custbranch.debtorno=contracts.debtorno');
INSERT INTO `reportlinks` VALUES ('contracts','stockcategory','contracts.branchcode=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','contracts','stockcategory.categoryid=contracts.branchcode');
INSERT INTO `reportlinks` VALUES ('contracts','salestypes','contracts.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','contracts','salestypes.typeabbrev=contracts.typeabbrev');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocfrom=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('custallocns','debtortrans','custallocns.transid_allocto=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','custallocns','debtortrans.id=custallocns.transid_allocto');
INSERT INTO `reportlinks` VALUES ('custbranch','debtorsmaster','custbranch.debtorno=debtorsmaster.debtorno');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','custbranch','debtorsmaster.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','areas','custbranch.area=areas.areacode');
INSERT INTO `reportlinks` VALUES ('areas','custbranch','areas.areacode=custbranch.area');
INSERT INTO `reportlinks` VALUES ('custbranch','salesman','custbranch.salesman=salesman.salesmancode');
INSERT INTO `reportlinks` VALUES ('salesman','custbranch','salesman.salesmancode=custbranch.salesman');
INSERT INTO `reportlinks` VALUES ('custbranch','locations','custbranch.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','custbranch','locations.loccode=custbranch.defaultlocation');
INSERT INTO `reportlinks` VALUES ('custbranch','shippers','custbranch.defaultshipvia=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','custbranch','shippers.shipper_id=custbranch.defaultshipvia');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','holdreasons','debtorsmaster.holdreason=holdreasons.reasoncode');
INSERT INTO `reportlinks` VALUES ('holdreasons','debtorsmaster','holdreasons.reasoncode=debtorsmaster.holdreason');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','currencies','debtorsmaster.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','debtorsmaster','currencies.currabrev=debtorsmaster.currcode');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','paymentterms','debtorsmaster.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','debtorsmaster','paymentterms.termsindicator=debtorsmaster.paymentterms');
INSERT INTO `reportlinks` VALUES ('debtorsmaster','salestypes','debtorsmaster.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','debtorsmaster','salestypes.typeabbrev=debtorsmaster.salestype');
INSERT INTO `reportlinks` VALUES ('debtortrans','custbranch','debtortrans.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','debtortrans','custbranch.debtorno=debtortrans.debtorno');
INSERT INTO `reportlinks` VALUES ('debtortrans','systypes','debtortrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','debtortrans','systypes.typeid=debtortrans.type');
INSERT INTO `reportlinks` VALUES ('debtortrans','periods','debtortrans.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','debtortrans','periods.periodno=debtortrans.prd');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','taxauthorities','debtortranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','debtortranstaxes','taxauthorities.taxid=debtortranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('debtortranstaxes','debtortrans','debtortranstaxes.debtortransid=debtortrans.id');
INSERT INTO `reportlinks` VALUES ('debtortrans','debtortranstaxes','debtortrans.id=debtortranstaxes.debtortransid');
INSERT INTO `reportlinks` VALUES ('discountmatrix','salestypes','discountmatrix.salestype=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','discountmatrix','salestypes.typeabbrev=discountmatrix.salestype');
INSERT INTO `reportlinks` VALUES ('freightcosts','locations','freightcosts.locationfrom=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','freightcosts','locations.loccode=freightcosts.locationfrom');
INSERT INTO `reportlinks` VALUES ('freightcosts','shippers','freightcosts.shipperid=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','freightcosts','shippers.shipper_id=freightcosts.shipperid');
INSERT INTO `reportlinks` VALUES ('gltrans','chartmaster','gltrans.account=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','gltrans','chartmaster.accountcode=gltrans.account');
INSERT INTO `reportlinks` VALUES ('gltrans','systypes','gltrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','gltrans','systypes.typeid=gltrans.type');
INSERT INTO `reportlinks` VALUES ('gltrans','periods','gltrans.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','gltrans','periods.periodno=gltrans.periodno');
INSERT INTO `reportlinks` VALUES ('grns','suppliers','grns.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','grns','suppliers.supplierid=grns.supplierid');
INSERT INTO `reportlinks` VALUES ('grns','purchorderdetails','grns.podetailitem=purchorderdetails.podetailitem');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','grns','purchorderdetails.podetailitem=grns.podetailitem');
INSERT INTO `reportlinks` VALUES ('locations','taxprovinces','locations.taxprovinceid=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','locations','taxprovinces.taxprovinceid=locations.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('locstock','locations','locstock.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','locstock','locations.loccode=locstock.loccode');
INSERT INTO `reportlinks` VALUES ('locstock','stockmaster','locstock.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','locstock','stockmaster.stockid=locstock.stockid');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.shiploc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.shiploc');
INSERT INTO `reportlinks` VALUES ('loctransfers','locations','loctransfers.recloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','loctransfers','locations.loccode=loctransfers.recloc');
INSERT INTO `reportlinks` VALUES ('loctransfers','stockmaster','loctransfers.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','loctransfers','stockmaster.stockid=loctransfers.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','stockmaster','orderdeliverydifferenceslog.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','orderdeliverydifferencesl','stockmaster.stockid=orderdeliverydifferenceslog.stockid');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','custbranch','orderdeliverydifferenceslog.debtorno=custbranch.debtorno');
INSERT INTO `reportlinks` VALUES ('custbranch','orderdeliverydifferencesl','custbranch.debtorno=orderdeliverydifferenceslog.debtorno');
INSERT INTO `reportlinks` VALUES ('orderdeliverydifferencesl','salesorders','orderdeliverydifferenceslog.branchcode=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','orderdeliverydifferencesl','salesorders.orderno=orderdeliverydifferenceslog.branchcode');
INSERT INTO `reportlinks` VALUES ('prices','stockmaster','prices.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','prices','stockmaster.stockid=prices.stockid');
INSERT INTO `reportlinks` VALUES ('prices','currencies','prices.currabrev=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','prices','currencies.currabrev=prices.currabrev');
INSERT INTO `reportlinks` VALUES ('prices','salestypes','prices.typeabbrev=salestypes.typeabbrev');
INSERT INTO `reportlinks` VALUES ('salestypes','prices','salestypes.typeabbrev=prices.typeabbrev');
INSERT INTO `reportlinks` VALUES ('purchdata','stockmaster','purchdata.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','purchdata','stockmaster.stockid=purchdata.stockid');
INSERT INTO `reportlinks` VALUES ('purchdata','suppliers','purchdata.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchdata','suppliers.supplierid=purchdata.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorderdetails','purchorders','purchorderdetails.orderno=purchorders.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','purchorderdetails','purchorders.orderno=purchorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('purchorders','suppliers','purchorders.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','purchorders','suppliers.supplierid=purchorders.supplierno');
INSERT INTO `reportlinks` VALUES ('purchorders','locations','purchorders.intostocklocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','purchorders','locations.loccode=purchorders.intostocklocation');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','custbranch','recurringsalesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','recurringsalesorders','custbranch.branchcode=recurringsalesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','recurringsalesorders','recurrsalesorderdetails.recurrorderno=recurringsalesorders.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurringsalesorders','recurrsalesorderdetails','recurringsalesorders.recurrorderno=recurrsalesorderdetails.recurrorderno');
INSERT INTO `reportlinks` VALUES ('recurrsalesorderdetails','stockmaster','recurrsalesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','recurrsalesorderdetails','stockmaster.stockid=recurrsalesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('reportcolumns','reportheaders','reportcolumns.reportid=reportheaders.reportid');
INSERT INTO `reportlinks` VALUES ('reportheaders','reportcolumns','reportheaders.reportid=reportcolumns.reportid');
INSERT INTO `reportlinks` VALUES ('salesanalysis','periods','salesanalysis.periodno=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','salesanalysis','periods.periodno=salesanalysis.periodno');
INSERT INTO `reportlinks` VALUES ('salescatprod','stockmaster','salescatprod.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salescatprod','stockmaster.stockid=salescatprod.stockid');
INSERT INTO `reportlinks` VALUES ('salescatprod','salescat','salescatprod.salescatid=salescat.salescatid');
INSERT INTO `reportlinks` VALUES ('salescat','salescatprod','salescat.salescatid=salescatprod.salescatid');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','salesorders','salesorderdetails.orderno=salesorders.orderno');
INSERT INTO `reportlinks` VALUES ('salesorders','salesorderdetails','salesorders.orderno=salesorderdetails.orderno');
INSERT INTO `reportlinks` VALUES ('salesorderdetails','stockmaster','salesorderdetails.stkcode=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','salesorderdetails','stockmaster.stockid=salesorderdetails.stkcode');
INSERT INTO `reportlinks` VALUES ('salesorders','custbranch','salesorders.branchcode=custbranch.branchcode');
INSERT INTO `reportlinks` VALUES ('custbranch','salesorders','custbranch.branchcode=salesorders.branchcode');
INSERT INTO `reportlinks` VALUES ('salesorders','shippers','salesorders.debtorno=shippers.shipper_id');
INSERT INTO `reportlinks` VALUES ('shippers','salesorders','shippers.shipper_id=salesorders.debtorno');
INSERT INTO `reportlinks` VALUES ('salesorders','locations','salesorders.fromstkloc=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','salesorders','locations.loccode=salesorders.fromstkloc');
INSERT INTO `reportlinks` VALUES ('securitygroups','securityroles','securitygroups.secroleid=securityroles.secroleid');
INSERT INTO `reportlinks` VALUES ('securityroles','securitygroups','securityroles.secroleid=securitygroups.secroleid');
INSERT INTO `reportlinks` VALUES ('securitygroups','securitytokens','securitygroups.tokenid=securitytokens.tokenid');
INSERT INTO `reportlinks` VALUES ('securitytokens','securitygroups','securitytokens.tokenid=securitygroups.tokenid');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','shipments','shipmentcharges.shiptref=shipments.shiptref');
INSERT INTO `reportlinks` VALUES ('shipments','shipmentcharges','shipments.shiptref=shipmentcharges.shiptref');
INSERT INTO `reportlinks` VALUES ('shipmentcharges','systypes','shipmentcharges.transtype=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','shipmentcharges','systypes.typeid=shipmentcharges.transtype');
INSERT INTO `reportlinks` VALUES ('shipments','suppliers','shipments.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','shipments','suppliers.supplierid=shipments.supplierid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','stockmaster','stockcheckfreeze.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcheckfreeze','stockmaster.stockid=stockcheckfreeze.stockid');
INSERT INTO `reportlinks` VALUES ('stockcheckfreeze','locations','stockcheckfreeze.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcheckfreeze','locations.loccode=stockcheckfreeze.loccode');
INSERT INTO `reportlinks` VALUES ('stockcounts','stockmaster','stockcounts.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcounts','stockmaster.stockid=stockcounts.stockid');
INSERT INTO `reportlinks` VALUES ('stockcounts','locations','stockcounts.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockcounts','locations.loccode=stockcounts.loccode');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockcategory','stockmaster.categoryid=stockcategory.categoryid');
INSERT INTO `reportlinks` VALUES ('stockcategory','stockmaster','stockcategory.categoryid=stockmaster.categoryid');
INSERT INTO `reportlinks` VALUES ('stockmaster','taxcategories','stockmaster.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','stockmaster','taxcategories.taxcatid=stockmaster.taxcatid');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockmaster','stockmoves.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockmoves','stockmaster.stockid=stockmoves.stockid');
INSERT INTO `reportlinks` VALUES ('stockmoves','systypes','stockmoves.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','stockmoves','systypes.typeid=stockmoves.type');
INSERT INTO `reportlinks` VALUES ('stockmoves','locations','stockmoves.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockmoves','locations.loccode=stockmoves.loccode');
INSERT INTO `reportlinks` VALUES ('stockmoves','periods','stockmoves.prd=periods.periodno');
INSERT INTO `reportlinks` VALUES ('periods','stockmoves','periods.periodno=stockmoves.prd');
INSERT INTO `reportlinks` VALUES ('stockmovestaxes','taxauthorities','stockmovestaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','stockmovestaxes','taxauthorities.taxid=stockmovestaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockmaster','stockserialitems.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','stockserialitems','stockmaster.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','locations','stockserialitems.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','stockserialitems','locations.loccode=stockserialitems.loccode');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockmoves','stockserialmoves.stockmoveno=stockmoves.stkmoveno');
INSERT INTO `reportlinks` VALUES ('stockmoves','stockserialmoves','stockmoves.stkmoveno=stockserialmoves.stockmoveno');
INSERT INTO `reportlinks` VALUES ('stockserialmoves','stockserialitems','stockserialmoves.stockid=stockserialitems.stockid');
INSERT INTO `reportlinks` VALUES ('stockserialitems','stockserialmoves','stockserialitems.stockid=stockserialmoves.stockid');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocfrom=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocfrom');
INSERT INTO `reportlinks` VALUES ('suppallocs','supptrans','suppallocs.transid_allocto=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','suppallocs','supptrans.id=suppallocs.transid_allocto');
INSERT INTO `reportlinks` VALUES ('suppliercontacts','suppliers','suppliercontacts.supplierid=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','suppliercontacts','suppliers.supplierid=suppliercontacts.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','currencies','suppliers.currcode=currencies.currabrev');
INSERT INTO `reportlinks` VALUES ('currencies','suppliers','currencies.currabrev=suppliers.currcode');
INSERT INTO `reportlinks` VALUES ('suppliers','paymentterms','suppliers.paymentterms=paymentterms.termsindicator');
INSERT INTO `reportlinks` VALUES ('paymentterms','suppliers','paymentterms.termsindicator=suppliers.paymentterms');
INSERT INTO `reportlinks` VALUES ('suppliers','taxgroups','suppliers.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','suppliers','taxgroups.taxgroupid=suppliers.taxgroupid');
INSERT INTO `reportlinks` VALUES ('supptrans','systypes','supptrans.type=systypes.typeid');
INSERT INTO `reportlinks` VALUES ('systypes','supptrans','systypes.typeid=supptrans.type');
INSERT INTO `reportlinks` VALUES ('supptrans','suppliers','supptrans.supplierno=suppliers.supplierid');
INSERT INTO `reportlinks` VALUES ('suppliers','supptrans','suppliers.supplierid=supptrans.supplierno');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','taxauthorities','supptranstaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','supptranstaxes','taxauthorities.taxid=supptranstaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('supptranstaxes','supptrans','supptranstaxes.supptransid=supptrans.id');
INSERT INTO `reportlinks` VALUES ('supptrans','supptranstaxes','supptrans.id=supptranstaxes.supptransid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.taxglcode=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.taxglcode');
INSERT INTO `reportlinks` VALUES ('taxauthorities','chartmaster','taxauthorities.purchtaxglaccount=chartmaster.accountcode');
INSERT INTO `reportlinks` VALUES ('chartmaster','taxauthorities','chartmaster.accountcode=taxauthorities.purchtaxglaccount');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxauthorities','taxauthrates.taxauthority=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxauthrates','taxauthorities.taxid=taxauthrates.taxauthority');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxcategories','taxauthrates.taxcatid=taxcategories.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxcategories','taxauthrates','taxcategories.taxcatid=taxauthrates.taxcatid');
INSERT INTO `reportlinks` VALUES ('taxauthrates','taxprovinces','taxauthrates.dispatchtaxprovince=taxprovinces.taxprovinceid');
INSERT INTO `reportlinks` VALUES ('taxprovinces','taxauthrates','taxprovinces.taxprovinceid=taxauthrates.dispatchtaxprovince');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxgroups','taxgrouptaxes.taxgroupid=taxgroups.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgroups','taxgrouptaxes','taxgroups.taxgroupid=taxgrouptaxes.taxgroupid');
INSERT INTO `reportlinks` VALUES ('taxgrouptaxes','taxauthorities','taxgrouptaxes.taxauthid=taxauthorities.taxid');
INSERT INTO `reportlinks` VALUES ('taxauthorities','taxgrouptaxes','taxauthorities.taxid=taxgrouptaxes.taxauthid');
INSERT INTO `reportlinks` VALUES ('workcentres','locations','workcentres.location=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','workcentres','locations.loccode=workcentres.location');
INSERT INTO `reportlinks` VALUES ('worksorders','locations','worksorders.loccode=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','worksorders','locations.loccode=worksorders.loccode');
INSERT INTO `reportlinks` VALUES ('worksorders','stockmaster','worksorders.stockid=stockmaster.stockid');
INSERT INTO `reportlinks` VALUES ('stockmaster','worksorders','stockmaster.stockid=worksorders.stockid');
INSERT INTO `reportlinks` VALUES ('www_users','locations','www_users.defaultlocation=locations.loccode');
INSERT INTO `reportlinks` VALUES ('locations','www_users','locations.loccode=www_users.defaultlocation');

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` VALUES (135,'Currency Price List','rpt','inv','1','A4:210:297','P',10,10,10,10,'helvetica',12,'0:0:0','C','1','%reportname%','helvetica',10,'0:0:0','C','1','Report Generated %date%','helvetica',10,'0:0:0','C','1','helvetica',8,'0:0:0','L','helvetica',10,'0:0:0','L','helvetica',10,'0:0:0','L',25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,25,'stockmaster','prices','stockmaster.stockid=prices.stockid','','','','','','','','');

--
-- Dumping data for table `salesanalysis`
--

INSERT INTO `salesanalysis` VALUES ('DE',2,31.9,10.5,'QUARTER','QUARTER',2,0,'DVD-DHWV','FL',1,'ERI','DVD',1);
INSERT INTO `salesanalysis` VALUES ('DE',2,14.5,2.85,'QUARTER','QUARTER',1,0,'DVD-LTWP','FL',1,'ERI','DVD',2);
INSERT INTO `salesanalysis` VALUES ('DE',3,-15.95,-5.25,'QUARTER','QUARTER',-1,0,'DVD-DHWV','FL',1,'ERI','DVD',3);
INSERT INTO `salesanalysis` VALUES ('DE',-11,234.56470588235,186.2635,'ANGRY','ANGRY',31,6.21,'BREAD','TR',1,'ERI','FOOD',5);
INSERT INTO `salesanalysis` VALUES ('DE',-11,66.8576470588235,16.75,'ANGRY','ANGRY',6.7,0.04485,'SALT','TR',1,'ERI','BAKE',6);
INSERT INTO `salesanalysis` VALUES ('DE',36,0,-30.0425,'ANGRY','ANGRY',-5,0,'BREAD','TR',1,'ERI','FOOD',7);
INSERT INTO `salesanalysis` VALUES ('DE',6,0,-0.6,'DUMBLE','DUMBLE',-2,0,'DVD-CASE','TR',1,'ERI','DVD',8);
INSERT INTO `salesanalysis` VALUES ('DE',6,-21,-46.68,'DUMBLE','DUMBLE',-12,0,'FLOUR','TR',1,'ERI','AIRCON',9);
INSERT INTO `salesanalysis` VALUES ('DE',6,-24,-12.017,'ANGRY','ANGRY',-2,0,'BREAD','TR',1,'ERI','FOOD',10);
INSERT INTO `salesanalysis` VALUES ('DE',7,-7.1875,-2.7,'DUMBLE','DUMBLE',-1,0,'DVD-LTWP','TR',1,'ERI','AIRCON',11);
INSERT INTO `salesanalysis` VALUES ('DE',7,-20.7,-18.0255,'ANGRY','ANGRY',-3,-2.07,'BREAD','TR',1,'ERI','FOOD',12);
INSERT INTO `salesanalysis` VALUES ('DE',7,-9.75,-7.5,'ANGRY','ANGRY',-3,0,'SALT','TR',1,'ERI','BAKE',13);
INSERT INTO `salesanalysis` VALUES ('DE',8,97.058823529412,1.5,'QUICK','SLOW',5,4.8529411764706,'DVD-CASE','TR',1,'ERI','DVD',14);
INSERT INTO `salesanalysis` VALUES ('DE',8,16.470588235294,10,'QUICK','SLOW',4,0.41176470588235,'SALT','TR',1,'ERI','BAKE',15);
INSERT INTO `salesanalysis` VALUES ('DE',9,1149.2894117647,15.56,'QUICK','SLOW',4,28.732235294118,'FLOUR','TR',1,'ERI','AIRCON',16);
INSERT INTO `salesanalysis` VALUES ('DE',12,51.509090909091,39.1111,'ANGRY','ANGRY',7,1.8818181818182,'BREAD','TR',1,'ERI','FOOD',17);
INSERT INTO `salesanalysis` VALUES ('DE',12,8.8636363636364,19.1841,'ANGRY','ANGRY',3,0,'SALT','TR',1,'ERI','BAKE',18);

--
-- Dumping data for table `salescat`
--

INSERT INTO `salescat` VALUES (1,0,'test');
INSERT INTO `salescat` VALUES (2,0,'Dogs');

--
-- Dumping data for table `salescatprod`
--

INSERT INTO `salescatprod` VALUES (2,'DVD-CASE');
INSERT INTO `salescatprod` VALUES (2,'DVD_ACTION');

--
-- Dumping data for table `salesglpostings`
--

INSERT INTO `salesglpostings` VALUES (1,'AN','ANY',4900,4100,'AN');

--
-- Dumping data for table `salesman`
--

INSERT INTO `salesman` VALUES ('DE','Default Sales person','','',0,'0',0,1);
INSERT INTO `salesman` VALUES ('ERI','Eric Browlee','','',0,'0',0,0);
INSERT INTO `salesman` VALUES ('INT','Internet Shop','','',0,'0',0,1);
INSERT INTO `salesman` VALUES ('PHO','Phone Contact','','',0,'0',0,1);

--
-- Dumping data for table `salesorderdetails`
--

INSERT INTO `salesorderdetails` VALUES (0,6,'BREAD',3,6.9,3,0,0.1,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,7,'BREAD',3,6.9,3,0,0.1,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,8,'BREAD',3,6.9,3,0,0.1,'2011-08-24 00:00:00',1,'','2010-05-31','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,9,'BREAD',4,6.9,4,0,0.15,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,10,'BREAD',2,12,2,0,0,'2011-08-24 00:00:00',1,'','2010-05-31','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,11,'BREAD',2,5.98,2,0,0,'2011-08-09 00:00:00',1,'','2010-05-31','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,12,'SALT',2,25,2,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,13,'SALT',2,25,2,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,15,'BREAD',1,5,1,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,16,'BREAD',1,5,1,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,17,'BREAD',1,5,1,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,18,'BREAD',12,9.5,12,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (0,22,'BIGEARS12',0,5369.2307692308,1,0,0,'0000-00-00 00:00:00',0,'','2010-10-15','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,23,'BIRTHDAYCAKECONSTRUC',0,2500,1,0,0,'0000-00-00 00:00:00',0,'','2010-08-15','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,25,'FROAYLANDO',0,41.603614285714,1,0,0,'0000-00-00 00:00:00',0,NULL,'2011-03-25','87755',0,0);
INSERT INTO `salesorderdetails` VALUES (0,26,'DVD-CASE',0,52.25,1,0,0,'0000-00-00 00:00:00',0,'','2011-03-26','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,27,'BIGEARS12',0,2,2,0,0,'0000-00-00 00:00:00',0,'','2011-04-12','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,28,'DVD-CASE',5,16.5,5,0,0.05,'2011-04-18 00:00:00',1,'Testing one two three','2011-04-17','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,29,'FLOUR',4,244.224,4,0,0.025,'2011-05-03 00:00:00',1,'','2011-05-02','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,30,'DFS-20',0,255.986,1,0,0,'0000-00-00 00:00:00',0,NULL,'2011-07-16','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,31,'DVD-CASE',0,10,2,0,0,'0000-00-00 00:00:00',0,'','2011-06-21','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,33,'HIT3042-4',0,1331,12,0,0,'0000-00-00 00:00:00',0,'','2011-06-23','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,34,'DVD-CASE',0,52.95,2,0,0,'0000-00-00 00:00:00',0,'The narrative is apparently not wrapping as it should. This is just some test text to see how in fact it does look when there may be several lines of text on the quotation line. On the landscape version of the quotation printout there is a bunch of space and hard to see how many lines would be required','2011-07-10','',0,0);
INSERT INTO `salesorderdetails` VALUES (0,35,'BIGEARS12',0,25.95,1,0,0,'0000-00-00 00:00:00',0,'','2011-09-04','',0,0);
INSERT INTO `salesorderdetails` VALUES (1,6,'SALT',3,3.25,3,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (1,7,'SALT',3,3.25,3,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (1,8,'SALT',3,3.25,3,0,0,'2011-08-24 00:00:00',1,'','2010-05-31','',0,0);
INSERT INTO `salesorderdetails` VALUES (1,9,'SALT',1,2.99,1,0,0.015,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (1,14,'BREAD',2,5.25,2,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (1,18,'SALT',0.7,5,0.7,0,0,'2010-05-31 00:00:00',1,'','2010-05-31',NULL,0,0);
INSERT INTO `salesorderdetails` VALUES (1,26,'FLOUR',0,6.95,2,0,0,'0000-00-00 00:00:00',0,'test','2011-03-26','',0,0);
INSERT INTO `salesorderdetails` VALUES (1,27,'BREAD',0,5,2,0,0,'0000-00-00 00:00:00',0,'','2011-04-12','',0,0);
INSERT INTO `salesorderdetails` VALUES (1,28,'SALT',4,3.5,4,0,0.025,'2011-04-18 00:00:00',1,'ass','2011-04-16','',0,0);
INSERT INTO `salesorderdetails` VALUES (1,31,'BREAD',0,1.5,4,0,0,'0000-00-00 00:00:00',0,'','2011-06-21','',0,0);
INSERT INTO `salesorderdetails` VALUES (1,32,'BREAD',0,25,5,0,0,'0000-00-00 00:00:00',0,'','2011-06-23','',0,0);
INSERT INTO `salesorderdetails` VALUES (1,35,'BirthdayCakeConstruc',0,6.2,2,0,0,'0000-00-00 00:00:00',0,'','2011-09-04','',0,0);
INSERT INTO `salesorderdetails` VALUES (2,32,'DVD-CASE',0,250,15,0,0.025,'0000-00-00 00:00:00',0,'','2011-06-23','',0,0);
INSERT INTO `salesorderdetails` VALUES (2,35,'DVD-CASE',0,4.99,4,0,0.025,'0000-00-00 00:00:00',0,'','2011-09-04','',0,0);

--
-- Dumping data for table `salesorders`
--

INSERT INTO `salesorders` VALUES (6,'ANGRY','ANGRY','',NULL,'Testing comments','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','0422 2245 2213','graville@angry.com','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (7,'ANGRY','ANGRY','',NULL,'Testing comments','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','0422 2245 2213','graville@angry.com','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (8,'ANGRY','ANGRY','988757','Fred Rodgers','Testing comments Invoice: 4 Inv 19','2010-05-31','DE',1,'Counter Sale','','','','','','0422 2245 2213','graville@angry.com','Hanibal Lecter',1,0,'MEL','2010-05-31','2011-08-24',1,'2011-04-12',0,'2011-08-24',0);
INSERT INTO `salesorders` VALUES (9,'ANGRY','ANGRY','211547',NULL,' Invoice: 5','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','0422 2245 2213','graville@angry.com','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (10,'ANGRY','ANGRY','1234567',NULL,' Invoice: 6 Inv 18','2010-05-31','DE',1,'Counter Sale','','','','','','','','df',1,0,'MEL','2010-05-31','2011-08-24',0,'0000-00-00',0,'2011-08-24',0);
INSERT INTO `salesorders` VALUES (11,'ANGRY','ANGRY','',NULL,' Invoice: 7 Inv 17','2010-05-31','DE',1,'Counter Sale','','','','','','','','Ferdinand',1,0,'MEL','2010-05-31','2011-03-09',0,'0000-00-00',0,'2011-03-09',0);
INSERT INTO `salesorders` VALUES (12,'ANGRY','ANGRY','',NULL,'','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','','','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (13,'ANGRY','ANGRY','',NULL,' Invoice: 9','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','','','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (14,'ANGRY','ANGRY','',NULL,' Invoice: 10','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','','','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (15,'ANGRY','ANGRY','',NULL,' Invoice: 11','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','','','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (16,'ANGRY','ANGRY','',NULL,' Invoice: 12','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','','','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (17,'ANGRY','ANGRY','',NULL,' Invoice: 13','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','','','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (18,'ANGRY','ANGRY','',NULL,' Invoice: 14','2010-05-31','DE',1,'Counter Sale','','',NULL,'','','','','',0,0,'MEL','2010-05-31','2010-05-31',0,'0000-00-00',0,'0000-00-00',0);
INSERT INTO `salesorders` VALUES (19,'DUMBLE','DUMBLE','',NULL,NULL,'2010-08-08','DE',10,'Hogwarts castle','Platform 9.75','','','','','Owls only','mmgonagal@hogwarts.edu.uk','Dumbledoor McGonagal &amp; Co',1,0,'TOR','2010-09-08','0000-00-00',0,'0000-00-00',1,'2010-08-08',0);
INSERT INTO `salesorders` VALUES (22,'QUARTER','QUARTER','89-OOPDS',NULL,'','2010-08-08','DE',1,'1356 Union Drive','Holborn','England','','','','123456','','Quarter Back to Back',1,0,'TOR','2010-10-15','2010-08-16',0,'0000-00-00',0,'2010-08-16',0);
INSERT INTO `salesorders` VALUES (23,'DUMBLE','DUMBLE','',NULL,'','2010-08-08','DE',10,'Hogwarts castle','Platform 9.75','','','','','Owls only','mmgonagal@hogwarts.edu.uk','Dumbledoor McGonagal &amp;amp;amp; Co',1,0,'TOR','2010-12-20','2010-08-16',0,'0000-00-00',0,'2010-08-16',0);
INSERT INTO `salesorders` VALUES (25,'QUICK','SLOW','87755',NULL,NULL,'2011-02-25','DE',1,'Hunstman Road','Woofton','','','','','','','Slow Dog',1,0,'TOR','2011-03-25','0000-00-00',0,'0000-00-00',1,'2011-02-25',0);
INSERT INTO `salesorders` VALUES (26,'DUMBLE','DUMBLE','',NULL,'','2011-03-26','DE',10,'Hogwarts castle','Platform 9.75','','','','','Owls only','mmgonagal@hogwarts.edu.uk','Dumbledoor McGonagal &amp;amp; Co',1,0,'TOR','2011-03-28','2011-03-28',1,'2011-03-26',0,'2011-03-28',0);
INSERT INTO `salesorders` VALUES (27,'JOLOMU','JOLOMU','',NULL,'','2011-04-12','DE',1,'3215 Great Western Highway','Blubberhouses','Yorkshire','England','','','+44 812 211456','jolomu@lorrima.co.uk','Lorrima Productions Inc',1,0,'TOR','2011-04-12','2011-04-12',0,'0000-00-00',0,'2011-04-12',0);
INSERT INTO `salesorders` VALUES (28,'QUICK','SLOW','',NULL,' Inv 15','2011-04-16','DE',1,'Hunstman Road','Woofton','','','','','','','Slow Dog',1,0,'TOR','2011-04-18','2011-04-18',0,'0000-00-00',0,'2011-04-18',0);
INSERT INTO `salesorders` VALUES (29,'QUICK','SLOW','',NULL,' Inv 16','2011-05-02','DE',1,'Hunstman Road','Woofton','','','','','','','Slow Dog',1,0,'TOR','2011-05-03','2011-05-03',0,'0000-00-00',0,'2011-05-03',0);
INSERT INTO `salesorders` VALUES (30,'QUARTER','QUARTER','',NULL,'','2011-06-16','DE',1,'1356 Union Drive','Holborn','England','','','','123456','','Quarter Back to Back',1,0,'TOR','2011-07-16','2011-06-17',0,'0000-00-00',0,'2011-06-17',0);
INSERT INTO `salesorders` VALUES (31,'QUICK','SLOW','',NULL,'','2011-06-20','DE',1,'Hunstman Road','Woofton','','','','','','','Slow Dog',1,0,'TOR','2011-06-21','2011-06-21',0,'0000-00-00',0,'2011-06-21',0);
INSERT INTO `salesorders` VALUES (32,'ANGRY','ANGRY','',NULL,'','2011-06-23','DE',1,'P O Box 671','Gowerbridge','Upperton','Toronto ','Canada','','0422 2245 2213','graville@angry.com','Angus Rouledge - Toronto',1,0,'TOR','2011-06-24','2011-06-24',0,'0000-00-00',0,'2011-06-24',0);
INSERT INTO `salesorders` VALUES (33,'ANGRY','ANGRYFL','',NULL,'','2011-06-23','DE',1,'1821 Sunnyside','Ft Lauderdale','Florida','42554','','','2445 2232 524','wendy@angry.com','Angus Rouledge - Florida',1,0,'TOR','2011-06-24','2011-06-24',0,'0000-00-00',0,'2011-06-24',0);
INSERT INTO `salesorders` VALUES (34,'QUARTER','QUARTER','',NULL,'It could be that the comments written in the delivery details screen are not wrapped correctly. This is example text to test how comments get wrapped on a quotation printout. The landscape version of the quotation uses most of the width of the page to print the comments so unlikely really to be a problem in practise','2011-07-05','DE',1,'1356 Union Drive','Holborn','England','','','','123456','','Quarter Back to Back',1,0,'TOR','2011-07-06','2011-07-11',0,'0000-00-00',1,'2011-07-11',0);
INSERT INTO `salesorders` VALUES (35,'CHABAL','CHABAL','','','','2011-09-04','DE',1,'fdf','','','','','','','','Beastly Ventures',1,0,'MEL','2011-09-05','2011-09-05',0,'0000-00-00',0,'2011-09-05',0);

--
-- Dumping data for table `salestypes`
--

INSERT INTO `salestypes` VALUES ('DE','Default Price List');

--
-- Dumping data for table `scripts`
--

INSERT INTO `scripts` VALUES ('AccountGroups.php',10,'Defines the groupings of general ledger accounts');
INSERT INTO `scripts` VALUES ('AccountSections.php',10,'Defines the sections in the general ledger reports');
INSERT INTO `scripts` VALUES ('AddCustomerContacts.php',3,'Adds customer contacts');
INSERT INTO `scripts` VALUES ('AddCustomerNotes.php',3,'Adds notes about customers');
INSERT INTO `scripts` VALUES ('AddCustomerTypeNotes.php',3,'');
INSERT INTO `scripts` VALUES ('AgedDebtors.php',2,'Lists customer account balances in detail or summary in selected currency');
INSERT INTO `scripts` VALUES ('AgedSuppliers.php',2,'Lists supplier account balances in detail or summary in selected currency');
INSERT INTO `scripts` VALUES ('Areas.php',3,'Defines the sales areas - all customers must belong to a sales area for the purposes of sales analysis');
INSERT INTO `scripts` VALUES ('AuditTrail.php',15,'Shows the activity with SQL statements and who performed the changes');
INSERT INTO `scripts` VALUES ('BankAccounts.php',10,'Defines the general ledger code for bank accounts and specifies that bank transactions be created for these accounts for the purposes of reconciliation');
INSERT INTO `scripts` VALUES ('BankMatching.php',7,'Allows payments and receipts to be matched off against bank statements');
INSERT INTO `scripts` VALUES ('BankReconciliation.php',7,'Displays the bank reconciliation for a selected bank account');
INSERT INTO `scripts` VALUES ('BOMExtendedQty.php',2,'Shows the component requirements to make an item');
INSERT INTO `scripts` VALUES ('BOMIndented.php',2,'Shows the bill of material indented for each level');
INSERT INTO `scripts` VALUES ('BOMIndentedReverse.php',2,'');
INSERT INTO `scripts` VALUES ('BOMInquiry.php',2,'Displays the bill of material with cost information');
INSERT INTO `scripts` VALUES ('BOMListing.php',2,'Lists the bills of material for a selected range of items');
INSERT INTO `scripts` VALUES ('BOMs.php',9,'Administers the bills of material for a selected item');
INSERT INTO `scripts` VALUES ('COGSGLPostings.php',10,'Defines the general ledger account to be used for cost of sales entries');
INSERT INTO `scripts` VALUES ('CompanyPreferences.php',10,'Defines the settings applicable for the company, including name, address, tax authority reference, whether GL integration used etc.');
INSERT INTO `scripts` VALUES ('ConfirmDispatchControlled_Invoice.php',11,'Specifies the batch references/serial numbers of items dispatched that are being invoiced');
INSERT INTO `scripts` VALUES ('ConfirmDispatch_Invoice.php',2,'Creates sales invoices from entered sales orders based on the quantities dispatched that can be modified');
INSERT INTO `scripts` VALUES ('ContractBOM.php',6,'Creates the item requirements from stock for a contract as part of the contract cost build up');
INSERT INTO `scripts` VALUES ('ContractCosting.php',6,'Shows a contract cost - the components and other non-stock costs issued to the contract');
INSERT INTO `scripts` VALUES ('ContractOtherReqts.php',4,'Creates the other requirements for a contract cost build up');
INSERT INTO `scripts` VALUES ('Contracts.php',6,'Creates or modifies a customer contract costing');
INSERT INTO `scripts` VALUES ('CounterSales.php',1,'Allows sales to be entered against a cash sale customer account defined in the users location record');
INSERT INTO `scripts` VALUES ('CreditItemsControlled.php',3,'Specifies the batch references/serial numbers of items being credited back into stock');
INSERT INTO `scripts` VALUES ('CreditStatus.php',3,'Defines the credit status records. Each customer account is given a credit status from this table. Some credit status records can prohibit invoicing and new orders being entered.');
INSERT INTO `scripts` VALUES ('Credit_Invoice.php',3,'Creates a credit note based on the details of an existing invoice');
INSERT INTO `scripts` VALUES ('Currencies.php',9,'Defines the currencies available. Each customer and supplier must be defined as transacting in one of the currencies defined here.');
INSERT INTO `scripts` VALUES ('CustEDISetup.php',11,'Allows the set up the customer specified EDI parameters for server, email or ftp.');
INSERT INTO `scripts` VALUES ('CustLoginSetup.php',15,'');
INSERT INTO `scripts` VALUES ('CustomerAllocations.php',3,'Allows customer receipts and credit notes to be allocated to sales invoices');
INSERT INTO `scripts` VALUES ('CustomerBranches.php',3,'Defines the details of customer branches such as delivery address and contact details - also sales area, representative etc');
INSERT INTO `scripts` VALUES ('CustomerInquiry.php',1,'Shows the customers account transactions with balances outstanding, links available to drill down to invoice/credit note or email invoices/credit notes');
INSERT INTO `scripts` VALUES ('CustomerReceipt.php',3,'Entry of both customer receipts against accounts receivable and also general ledger or nominal receipts');
INSERT INTO `scripts` VALUES ('Customers.php',3,'Defines the setup of a customer account, including payment terms, billing address, credit status, currency etc');
INSERT INTO `scripts` VALUES ('CustomerTransInquiry.php',2,'Lists in html the sequence of customer transactions, invoices, credit notes or receipts by a user entered date range');
INSERT INTO `scripts` VALUES ('CustomerTypes.php',15,'');
INSERT INTO `scripts` VALUES ('CustWhereAlloc.php',2,'Shows to which invoices a receipt was allocated to');
INSERT INTO `scripts` VALUES ('DailyBankTransactions.php',8,'');
INSERT INTO `scripts` VALUES ('DailySalesInquiry.php',2,'Shows the daily sales with GP in a calendar format');
INSERT INTO `scripts` VALUES ('DebtorsAtPeriodEnd.php',2,'Shows the debtors control account as at a previous period end - based on system calendar monthly periods');
INSERT INTO `scripts` VALUES ('DeliveryDetails.php',1,'Used during order entry to allow the entry of delivery addresses other than the defaulted branch delivery address and information about carrier/shipping method etc');
INSERT INTO `scripts` VALUES ('DiscountCategories.php',11,'Defines the items belonging to a discount category. Discount Categories are used to allow discounts based on quantities across a range of producs');
INSERT INTO `scripts` VALUES ('DiscountMatrix.php',11,'Defines the rates of discount applicable to discount categories and the customer groupings to which the rates are to apply');
INSERT INTO `scripts` VALUES ('EDIMessageFormat.php',10,'Specifies the EDI message format used by a customer - administrator use only.');
INSERT INTO `scripts` VALUES ('EDIProcessOrders.php',11,'Processes incoming EDI orders into sales orders');
INSERT INTO `scripts` VALUES ('EDISendInvoices.php',15,'Processes invoiced EDI customer invoices into EDI messages and sends using the customers preferred method either ftp or email attachments.');
INSERT INTO `scripts` VALUES ('EmailConfirmation.php',2,'');
INSERT INTO `scripts` VALUES ('EmailCustTrans.php',2,'Emails selected invoice or credit to the customer');
INSERT INTO `scripts` VALUES ('ExchangeRateTrend.php',2,'Shows the trend in exchange rates as retrieved from ECB');
INSERT INTO `scripts` VALUES ('Factors.php',5,'Defines supplier factor companies');
INSERT INTO `scripts` VALUES ('FixedAssetCategories.php',11,'Defines the various categories of fixed assets');
INSERT INTO `scripts` VALUES ('FixedAssetDepreciation.php',10,'Calculates and creates GL transactions to post depreciation for a period');
INSERT INTO `scripts` VALUES ('FixedAssetItems.php',11,'Allows fixed assets to be defined');
INSERT INTO `scripts` VALUES ('FixedAssetList.php',11,'');
INSERT INTO `scripts` VALUES ('FixedAssetLocations.php',11,'Allows the locations of fixed assets to be defined');
INSERT INTO `scripts` VALUES ('FixedAssetRegister.php',11,'Produces a csv, html or pdf report of the fixed assets over a period showing period depreciation, additions and disposals');
INSERT INTO `scripts` VALUES ('FixedAssetTransfer.php',11,'Allows the fixed asset locations to be changed in bulk');
INSERT INTO `scripts` VALUES ('FormDesigner.php',14,'');
INSERT INTO `scripts` VALUES ('FormMaker.php',1,'Allows running user defined Forms');
INSERT INTO `scripts` VALUES ('FreightCosts.php',11,'Defines the setup of the freight cost using different shipping methods to different destinations. The system can use this information to calculate applicable freight if the items are defined with the correct kgs and cubic volume');
INSERT INTO `scripts` VALUES ('FTP_RadioBeacon.php',2,'FTPs sales orders for dispatch to a radio beacon software enabled warehouse dispatching facility');
INSERT INTO `scripts` VALUES ('geocode.php',3,'');
INSERT INTO `scripts` VALUES ('GeocodeSetup.php',3,'');
INSERT INTO `scripts` VALUES ('geocode_genxml_customers.php',3,'');
INSERT INTO `scripts` VALUES ('geocode_genxml_suppliers.php',3,'');
INSERT INTO `scripts` VALUES ('geo_displaymap_customers.php',3,'');
INSERT INTO `scripts` VALUES ('geo_displaymap_suppliers.php',3,'');
INSERT INTO `scripts` VALUES ('GetStockImage.php',1,'');
INSERT INTO `scripts` VALUES ('GLAccountCSV.php',8,'Produces a CSV of the GL transactions for a particular range of periods and GL account');
INSERT INTO `scripts` VALUES ('GLAccountInquiry.php',8,'Shows the general ledger transactions for a specified account over a specified range of periods');
INSERT INTO `scripts` VALUES ('GLAccountReport.php',8,'Produces a report of the GL transactions for a particular account');
INSERT INTO `scripts` VALUES ('GLAccounts.php',10,'Defines the general ledger accounts');
INSERT INTO `scripts` VALUES ('GLBalanceSheet.php',8,'Shows the balance sheet for the company as at a specified date');
INSERT INTO `scripts` VALUES ('GLBudgets.php',10,'Defines GL Budgets');
INSERT INTO `scripts` VALUES ('GLCodesInquiry.php',8,'Shows the list of general ledger codes defined with account names and groupings');
INSERT INTO `scripts` VALUES ('GLJournal.php',10,'Entry of general ledger journals, periods are calculated based on the date entered here');
INSERT INTO `scripts` VALUES ('GLProfit_Loss.php',8,'Shows the profit and loss of the company for the range of periods entered');
INSERT INTO `scripts` VALUES ('GLTagProfit_Loss.php',8,'');
INSERT INTO `scripts` VALUES ('GLTags.php',10,'Allows GL tags to be defined');
INSERT INTO `scripts` VALUES ('GLTransInquiry.php',8,'Shows the general ledger journal created for the sub ledger transaction specified');
INSERT INTO `scripts` VALUES ('GLTrialBalance.php',8,'Shows the trial balance for the month and the for the period selected together with the budgeted trial balances');
INSERT INTO `scripts` VALUES ('GLTrialBalance_csv.php',8,'Produces a CSV of the Trial Balance for a particular period');
INSERT INTO `scripts` VALUES ('GoodsReceived.php',11,'Entry of items received against purchase orders');
INSERT INTO `scripts` VALUES ('GoodsReceivedControlled.php',11,'Entry of the serial numbers or batch references for controlled items received against purchase orders');
INSERT INTO `scripts` VALUES ('index.php',1,'The main menu from where all functions available to the user are accessed by clicking on the links');
INSERT INTO `scripts` VALUES ('InventoryPlanning.php',2,'Creates a pdf report showing the last 4 months use of items including as a component of assemblies together with stock quantity on hand, current demand for the item and current quantity on sales order.');
INSERT INTO `scripts` VALUES ('InventoryPlanningPrefSupplier.php',2,'Produces a report showing the inventory to be ordered by supplier');
INSERT INTO `scripts` VALUES ('InventoryQuantities.php',2,'');
INSERT INTO `scripts` VALUES ('InventoryValuation.php',2,'Creates a pdf report showing the value of stock at standard cost for a range of product categories selected');
INSERT INTO `scripts` VALUES ('Labels.php',15,'Produces item pricing labels in a pdf from a range of selected criteria');
INSERT INTO `scripts` VALUES ('Locations.php',11,'Defines the inventory stocking locations or warehouses');
INSERT INTO `scripts` VALUES ('Logout.php',1,'Shows when the user logs out of webERP');
INSERT INTO `scripts` VALUES ('MailInventoryValuation.php',1,'Meant to be run as a scheduled process to email the stock valuation off to a specified person. Creates the same stock valuation report as InventoryValuation.php');
INSERT INTO `scripts` VALUES ('ManualContents.php',1,'');
INSERT INTO `scripts` VALUES ('MenuAccess.php',15,'');
INSERT INTO `scripts` VALUES ('MRP.php',9,'');
INSERT INTO `scripts` VALUES ('MRPCalendar.php',9,'');
INSERT INTO `scripts` VALUES ('MRPCreateDemands.php',9,'');
INSERT INTO `scripts` VALUES ('MRPDemands.php',9,'');
INSERT INTO `scripts` VALUES ('MRPDemandTypes.php',9,'');
INSERT INTO `scripts` VALUES ('MRPPlannedPurchaseOrders.php',2,'');
INSERT INTO `scripts` VALUES ('MRPPlannedWorkOrders.php',2,'');
INSERT INTO `scripts` VALUES ('MRPReport.php',2,'');
INSERT INTO `scripts` VALUES ('MRPReschedules.php',2,'');
INSERT INTO `scripts` VALUES ('MRPShortages.php',2,'');
INSERT INTO `scripts` VALUES ('OffersReceived.php',4,'');
INSERT INTO `scripts` VALUES ('OrderDetails.php',2,'Shows the detail of a sales order');
INSERT INTO `scripts` VALUES ('OutstandingGRNs.php',2,'Creates a pdf showing all GRNs for which there has been no purchase invoice matched off against.');
INSERT INTO `scripts` VALUES ('PageSecurity.php',15,'');
INSERT INTO `scripts` VALUES ('PaymentAllocations.php',5,'');
INSERT INTO `scripts` VALUES ('PaymentMethods.php',15,'');
INSERT INTO `scripts` VALUES ('Payments.php',5,'Entry of bank account payments either against an AP account or a general ledger payment - if the AP-GL link in company preferences is set');
INSERT INTO `scripts` VALUES ('PaymentTerms.php',10,'Defines the payment terms records, these can be expressed as either a number of days credit or a day in the following month. All customers and suppliers must have a corresponding payment term recorded against their account');
INSERT INTO `scripts` VALUES ('PcAssignCashToTab.php',6,'');
INSERT INTO `scripts` VALUES ('PcAuthorizeExpenses.php',6,'');
INSERT INTO `scripts` VALUES ('PcClaimExpensesFromTab.php',6,'');
INSERT INTO `scripts` VALUES ('PcExpenses.php',15,'');
INSERT INTO `scripts` VALUES ('PcExpensesTypeTab.php',15,'');
INSERT INTO `scripts` VALUES ('PcReportTab.php',6,'');
INSERT INTO `scripts` VALUES ('PcTabs.php',15,'');
INSERT INTO `scripts` VALUES ('PcTypeTabs.php',15,'');
INSERT INTO `scripts` VALUES ('PDFBankingSummary.php',3,'Creates a pdf showing the amounts entered as receipts on a specified date together with references for the purposes of banking');
INSERT INTO `scripts` VALUES ('PDFChequeListing.php',3,'Creates a pdf showing all payments that have been made from a specified bank account over a specified period. This can be emailed to an email account defined in config.php - ie a financial controller');
INSERT INTO `scripts` VALUES ('PDFCustomerList.php',2,'Creates a report of the customer and branch information held. This report has options to print only customer branches in a specified sales area and sales person. Additional option allows to list only those customers with activity either under or over a specified amount, since a specified date.');
INSERT INTO `scripts` VALUES ('PDFCustTransListing.php',3,'');
INSERT INTO `scripts` VALUES ('PDFDeliveryDifferences.php',3,'Creates a pdf report listing the delivery differences from what the customer requested as recorded in the order entry. The report calculates a percentage of order fill based on the number of orders filled in full on time');
INSERT INTO `scripts` VALUES ('PDFDIFOT.php',3,'Produces a pdf showing the delivery in full on time performance');
INSERT INTO `scripts` VALUES ('PDFGrn.php',2,'Produces a GRN report on the receipt of stock');
INSERT INTO `scripts` VALUES ('PDFLowGP.php',2,'Creates a pdf report showing the low gross profit sales made in the selected date range. The percentage of gp deemed acceptable can also be entered');
INSERT INTO `scripts` VALUES ('PDFOrdersInvoiced.php',3,'Produces a pdf of orders invoiced based on selected criteria');
INSERT INTO `scripts` VALUES ('PDFOrderStatus.php',3,'Reports on sales order status by date range, by stock location and stock category - producing a pdf showing each line items and any quantites delivered');
INSERT INTO `scripts` VALUES ('PDFPeriodStockTransListing.php',3,'Allows stock transactions of a specific transaction type to be listed over a single day or period range');
INSERT INTO `scripts` VALUES ('PDFPickingList.php',2,'');
INSERT INTO `scripts` VALUES ('PDFPriceList.php',2,'Creates a pdf of the price list applicable to a given sales type and customer. Also allows the listing of prices specific to a customer');
INSERT INTO `scripts` VALUES ('PDFPrintLabel.php',10,'');
INSERT INTO `scripts` VALUES ('PDFQuotation.php',2,'');
INSERT INTO `scripts` VALUES ('PDFQuotationPortrait.php',2,'Quotation printout in portrait');
INSERT INTO `scripts` VALUES ('PDFReceipt.php',2,'');
INSERT INTO `scripts` VALUES ('PDFRemittanceAdvice.php',2,'');
INSERT INTO `scripts` VALUES ('PDFStockCheckComparison.php',2,'Creates a pdf comparing the quantites entered as counted at a given range of locations against the quantity stored as on hand as at the time a stock check was initiated.');
INSERT INTO `scripts` VALUES ('PDFStockLocTransfer.php',1,'Creates a stock location transfer docket for the selected location transfer reference number');
INSERT INTO `scripts` VALUES ('PDFStockNegatives.php',1,'Produces a pdf of the negative stocks by location');
INSERT INTO `scripts` VALUES ('PDFStockTransfer.php',2,'Produces a report for stock transfers');
INSERT INTO `scripts` VALUES ('PDFSuppTransListing.php',3,'');
INSERT INTO `scripts` VALUES ('PDFTopItems.php',2,'Produces a pdf report of the top items sold');
INSERT INTO `scripts` VALUES ('PeriodsInquiry.php',2,'Shows a list of all the system defined periods');
INSERT INTO `scripts` VALUES ('POReport.php',2,'');
INSERT INTO `scripts` VALUES ('PO_AuthorisationLevels.php',15,'');
INSERT INTO `scripts` VALUES ('PO_AuthoriseMyOrders.php',4,'');
INSERT INTO `scripts` VALUES ('PO_Header.php',4,'Entry of a purchase order header record - date, references buyer etc');
INSERT INTO `scripts` VALUES ('PO_Items.php',4,'Entry of a purchase order items - allows entry of items with lookup of currency cost from Purchasing Data previously entered also allows entry of nominal items against a general ledger code if the AP is integrated to the GL');
INSERT INTO `scripts` VALUES ('PO_OrderDetails.php',2,'Purchase order inquiry shows the quantity received and invoiced of purchase order items as well as the header information');
INSERT INTO `scripts` VALUES ('PO_PDFPurchOrder.php',2,'Creates a pdf of the selected purchase order for printing or email to one of the supplier contacts entered');
INSERT INTO `scripts` VALUES ('PO_SelectOSPurchOrder.php',2,'Shows the outstanding purchase orders for selecting with links to receive or modify the purchase order header and items');
INSERT INTO `scripts` VALUES ('PO_SelectPurchOrder.php',2,'Allows selection of any purchase order with links to the inquiry');
INSERT INTO `scripts` VALUES ('Prices.php',9,'Entry of prices for a selected item also allows selection of sales type and currency for the price');
INSERT INTO `scripts` VALUES ('PricesBasedOnMarkUp.php',11,'');
INSERT INTO `scripts` VALUES ('PricesByCost.php',11,'Allows prices to be updated based on cost');
INSERT INTO `scripts` VALUES ('Prices_Customer.php',11,'Entry of prices for a selected item and selected customer/branch. The currency and sales type is defaulted from the customer\'s record');
INSERT INTO `scripts` VALUES ('PrintCheque.php',5,'');
INSERT INTO `scripts` VALUES ('PrintCustOrder.php',2,'Creates a pdf of the dispatch note - by default this is expected to be on two part pre-printed stationery to allow pickers to note discrepancies for the confirmer to update the dispatch at the time of invoicing');
INSERT INTO `scripts` VALUES ('PrintCustOrder_generic.php',2,'Creates two copies of a laser printed dispatch note - both copies need to be written on by the pickers with any discrepancies to advise customer of any shortfall and on the office copy to ensure the correct quantites are invoiced');
INSERT INTO `scripts` VALUES ('PrintCustStatements.php',2,'Creates a pdf for the customer statements in the selected range');
INSERT INTO `scripts` VALUES ('PrintCustTrans.php',1,'Creates either a html invoice or credit note or a pdf. A range of invoices or credit notes can be selected also.');
INSERT INTO `scripts` VALUES ('PrintCustTransPortrait.php',1,'');
INSERT INTO `scripts` VALUES ('PrintSalesOrder_generic.php',2,'');
INSERT INTO `scripts` VALUES ('PurchData.php',4,'Entry of supplier purchasing data, the suppliers part reference and the suppliers currency cost of the item');
INSERT INTO `scripts` VALUES ('RecurringSalesOrders.php',1,'');
INSERT INTO `scripts` VALUES ('ReorderLevel.php',2,'Allows reorder levels of inventory to be updated');
INSERT INTO `scripts` VALUES ('ReorderLevelLocation.php',2,'');
INSERT INTO `scripts` VALUES ('ReportBug.php',15,'');
INSERT INTO `scripts` VALUES ('ReportCreator.php',13,'Report Writer and Form Creator script that creates templates for user defined reports and forms');
INSERT INTO `scripts` VALUES ('ReportletContainer.php',1,'');
INSERT INTO `scripts` VALUES ('ReportMaker.php',1,'Produces reports from the report writer templates created');
INSERT INTO `scripts` VALUES ('ReprintGRN.php',11,'Allows selection of a goods received batch for reprinting the goods received note given a purchase order number');
INSERT INTO `scripts` VALUES ('ReverseGRN.php',11,'Reverses the entry of goods received - creating stock movements back out and necessary general ledger journals to effect the reversal');
INSERT INTO `scripts` VALUES ('SalesAnalReptCols.php',2,'Entry of the definition of a sales analysis report\'s columns.');
INSERT INTO `scripts` VALUES ('SalesAnalRepts.php',2,'Entry of the definition of a sales analysis report headers');
INSERT INTO `scripts` VALUES ('SalesAnalysis_UserDefined.php',2,'Creates a pdf of a selected user defined sales analysis report');
INSERT INTO `scripts` VALUES ('SalesByTypePeriodInquiry.php',2,'Shows sales for a selected date range by sales type/price list');
INSERT INTO `scripts` VALUES ('SalesCategories.php',11,'');
INSERT INTO `scripts` VALUES ('SalesCategoryPeriodInquiry.php',2,'Shows sales for a selected date range by stock category');
INSERT INTO `scripts` VALUES ('SalesGLPostings.php',10,'Defines the general ledger accounts used to post sales to based on product categories and sales areas');
INSERT INTO `scripts` VALUES ('SalesGraph.php',6,'');
INSERT INTO `scripts` VALUES ('SalesInquiry.php',2,'');
INSERT INTO `scripts` VALUES ('SalesPeople.php',3,'Defines the sales people of the business');
INSERT INTO `scripts` VALUES ('SalesTopItemsInquiry.php',2,'Shows the top item sales for a selected date range');
INSERT INTO `scripts` VALUES ('SalesTypes.php',15,'Defines the sales types - prices are held against sales types they can be considered price lists. Sales analysis records are held by sales type too.');
INSERT INTO `scripts` VALUES ('SecurityTokens.php',15,'Administration of security tokens');
INSERT INTO `scripts` VALUES ('SelectAsset.php',2,'Allows a fixed asset to be selected for modification or viewing');
INSERT INTO `scripts` VALUES ('SelectCompletedOrder.php',1,'Allows the selection of completed sales orders for inquiries - choices to select by item code or customer');
INSERT INTO `scripts` VALUES ('SelectContract.php',6,'Allows a contract costing to be selected for modification or viewing');
INSERT INTO `scripts` VALUES ('SelectCreditItems.php',3,'Entry of credit notes from scratch, selecting the items in either quick entry mode or searching for them manually');
INSERT INTO `scripts` VALUES ('SelectCustomer.php',2,'Selection of customer - from where all customer related maintenance, transactions and inquiries start');
INSERT INTO `scripts` VALUES ('SelectGLAccount.php',8,'Selection of general ledger account from where all general ledger account maintenance, or inquiries are initiated');
INSERT INTO `scripts` VALUES ('SelectOrderItems.php',1,'Entry of sales order items with both quick entry and part search functions');
INSERT INTO `scripts` VALUES ('SelectProduct.php',2,'Selection of items. All item maintenance, transactions and inquiries start with this script');
INSERT INTO `scripts` VALUES ('SelectRecurringSalesOrder.php',2,'');
INSERT INTO `scripts` VALUES ('SelectSalesOrder.php',2,'Selects a sales order irrespective of completed or not for inquiries');
INSERT INTO `scripts` VALUES ('SelectSupplier.php',2,'Selects a supplier. A supplier is required to be selected before any AP transactions and before any maintenance or inquiry of the supplier');
INSERT INTO `scripts` VALUES ('SelectWorkOrder.php',2,'');
INSERT INTO `scripts` VALUES ('ShipmentCosting.php',11,'Shows the costing of a shipment with all the items invoice values and any shipment costs apportioned. Updating the shipment has an option to update standard costs of all items on the shipment and create any general ledger variance journals');
INSERT INTO `scripts` VALUES ('Shipments.php',11,'Entry of shipments from outstanding purchase orders for a selected supplier - changes in the delivery date will cascade into the different purchase orders on the shipment');
INSERT INTO `scripts` VALUES ('Shippers.php',15,'Defines the shipping methods available. Each customer branch has a default shipping method associated with it which must match a record from this table');
INSERT INTO `scripts` VALUES ('ShiptsList.php',2,'Shows a list of all the open shipments for a selected supplier. Linked from POItems.php');
INSERT INTO `scripts` VALUES ('Shipt_Select.php',11,'Selection of a shipment for displaying and modification or updating');
INSERT INTO `scripts` VALUES ('SMTPServer.php',15,'');
INSERT INTO `scripts` VALUES ('SpecialOrder.php',4,'Allows for a sales order to be created and an indent order to be created on a supplier for a one off item that may never be purchased again. A dummy part is created based on the description and cost details given.');
INSERT INTO `scripts` VALUES ('StockAdjustments.php',11,'Entry of quantity corrections to stocks in a selected location.');
INSERT INTO `scripts` VALUES ('StockAdjustmentsControlled.php',11,'Entry of batch references or serial numbers on controlled stock items being adjusted');
INSERT INTO `scripts` VALUES ('StockCategories.php',11,'Defines the stock categories. All items must refer to one of these categories. The category record also allows the specification of the general ledger codes where stock items are to be posted - the balance sheet account and the profit and loss effect of any adjustments and the profit and loss effect of any price variances');
INSERT INTO `scripts` VALUES ('StockCheck.php',2,'Allows creation of a stock check file - copying the current quantites in stock for later comparison to the entered counts. Also produces a pdf for the count sheets.');
INSERT INTO `scripts` VALUES ('StockCostUpdate.php',9,'Allows update of the standard cost of items producing general ledger journals if the company preferences stock GL interface is active');
INSERT INTO `scripts` VALUES ('StockCounts.php',2,'Allows entry of stock counts');
INSERT INTO `scripts` VALUES ('StockDispatch.php',2,'');
INSERT INTO `scripts` VALUES ('StockLocMovements.php',2,'Inquiry shows the Movements of all stock items for a specified location');
INSERT INTO `scripts` VALUES ('StockLocStatus.php',2,'Shows the stock on hand together with outstanding sales orders and outstanding purchase orders by stock location for all items in the selected stock category');
INSERT INTO `scripts` VALUES ('StockLocTransfer.php',11,'Entry of a bulk stock location transfer for many parts from one location to another.');
INSERT INTO `scripts` VALUES ('StockLocTransferReceive.php',11,'Effects the transfer and creates the stock movements for a bulk stock location transfer initiated from StockLocTransfer.php');
INSERT INTO `scripts` VALUES ('StockMovements.php',2,'Shows a list of all the stock movements for a selected item and stock location including the price at which they were sold in local currency and the price at which they were purchased for in local currency');
INSERT INTO `scripts` VALUES ('StockQties_csv.php',5,'Makes a comma separated values (CSV)file of the stock item codes and quantities');
INSERT INTO `scripts` VALUES ('StockQuantityByDate.php',2,'Shows the stock on hand for each item at a selected location and stock category as at a specified date');
INSERT INTO `scripts` VALUES ('StockReorderLevel.php',4,'Entry and review of the re-order level of items by stocking location');
INSERT INTO `scripts` VALUES ('Stocks.php',11,'Defines an item - maintenance and addition of new parts');
INSERT INTO `scripts` VALUES ('StockSerialItemResearch.php',3,'');
INSERT INTO `scripts` VALUES ('StockSerialItems.php',2,'Shows a list of the serial numbers or the batch references and quantities of controlled items. This inquiry is linked from the stock status inquiry');
INSERT INTO `scripts` VALUES ('StockStatus.php',2,'Shows the stock on hand together with outstanding sales orders and outstanding purchase orders by stock location for a selected part. Has a link to show the serial numbers in stock at the location selected if the item is controlled');
INSERT INTO `scripts` VALUES ('StockTransferControlled.php',11,'Entry of serial numbers/batch references for controlled items being received on a stock transfer. The script is used by both bulk transfers and point to point transfers');
INSERT INTO `scripts` VALUES ('StockTransfers.php',11,'Entry of point to point stock location transfers of a single part');
INSERT INTO `scripts` VALUES ('StockUsage.php',2,'Inquiry showing the quantity of stock used by period calculated from the sum of the stock movements over that period - by item and stock location. Also available over all locations');
INSERT INTO `scripts` VALUES ('StockUsageGraph.php',2,'');
INSERT INTO `scripts` VALUES ('SuppContractChgs.php',5,'');
INSERT INTO `scripts` VALUES ('SuppCreditGRNs.php',5,'Entry of a supplier credit notes (debit notes) against existing GRN which have already been matched in full or in part');
INSERT INTO `scripts` VALUES ('SuppFixedAssetChgs.php',5,'');
INSERT INTO `scripts` VALUES ('SuppInvGRNs.php',5,'Entry of supplier invoices against goods received');
INSERT INTO `scripts` VALUES ('SupplierAllocations.php',5,'Entry of allocations of supplier payments and credit notes to invoices');
INSERT INTO `scripts` VALUES ('SupplierBalsAtPeriodEnd.php',2,'');
INSERT INTO `scripts` VALUES ('SupplierContacts.php',5,'Entry of supplier contacts and contact details including email addresses');
INSERT INTO `scripts` VALUES ('SupplierCredit.php',5,'Entry of supplier credit notes (debit notes)');
INSERT INTO `scripts` VALUES ('SupplierInquiry.php',2,'Inquiry showing invoices, credit notes and payments made to suppliers together with the amounts outstanding');
INSERT INTO `scripts` VALUES ('SupplierInvoice.php',5,'Entry of supplier invoices');
INSERT INTO `scripts` VALUES ('Suppliers.php',5,'Entry of new suppliers and maintenance of existing suppliers');
INSERT INTO `scripts` VALUES ('SupplierTenders.php',9,'');
INSERT INTO `scripts` VALUES ('SupplierTransInquiry.php',2,'');
INSERT INTO `scripts` VALUES ('SupplierTypes.php',4,'');
INSERT INTO `scripts` VALUES ('SuppLoginSetup.php',15,'');
INSERT INTO `scripts` VALUES ('SuppPaymentRun.php',5,'Automatic creation of payment records based on calculated amounts due from AP invoices entered');
INSERT INTO `scripts` VALUES ('SuppPriceList.php',2,'');
INSERT INTO `scripts` VALUES ('SuppShiptChgs.php',5,'Entry of supplier invoices against shipments as charges against a shipment');
INSERT INTO `scripts` VALUES ('SuppTransGLAnalysis.php',5,'Entry of supplier invoices against general ledger codes');
INSERT INTO `scripts` VALUES ('SystemCheck.php',10,'');
INSERT INTO `scripts` VALUES ('SystemParameters.php',15,'');
INSERT INTO `scripts` VALUES ('Tax.php',2,'Creates a report of the ad-valoerm tax - GST/VAT - for the period selected from accounts payable and accounts receivable data');
INSERT INTO `scripts` VALUES ('TaxAuthorities.php',15,'Entry of tax authorities - the state intitutions that charge tax');
INSERT INTO `scripts` VALUES ('TaxAuthorityRates.php',11,'Entry of the rates of tax applicable to the tax authority depending on the item tax level');
INSERT INTO `scripts` VALUES ('TaxCategories.php',15,'Allows for categories of items to be defined that might have different tax rates applied to them');
INSERT INTO `scripts` VALUES ('TaxGroups.php',15,'Allows for taxes to be grouped together where multiple taxes might apply on sale or purchase of items');
INSERT INTO `scripts` VALUES ('TaxProvinces.php',15,'Allows for inventory locations to be defined so that tax applicable from sales in different provinces can be dealt with');
INSERT INTO `scripts` VALUES ('TopItems.php',2,'Shows the top selling items');
INSERT INTO `scripts` VALUES ('UnitsOfMeasure.php',15,'Allows for units of measure to be defined');
INSERT INTO `scripts` VALUES ('UpgradeDatabase.php',15,'Allows for the database to be automatically upgraded based on currently recorded DBUpgradeNumber config option');
INSERT INTO `scripts` VALUES ('UserSettings.php',1,'Allows the user to change system wide defaults for the theme - appearance, the number of records to show in searches and the language to display messages in');
INSERT INTO `scripts` VALUES ('WhereUsedInquiry.php',2,'Inquiry showing where an item is used ie all the parents where the item is a component of');
INSERT INTO `scripts` VALUES ('WorkCentres.php',9,'Defines the various centres of work within a manufacturing company. Also the overhead and labour rates applicable to the work centre and its standard capacity');
INSERT INTO `scripts` VALUES ('WorkOrderCosting.php',11,'');
INSERT INTO `scripts` VALUES ('WorkOrderEntry.php',10,'Entry of new work orders');
INSERT INTO `scripts` VALUES ('WorkOrderIssue.php',11,'Issue of materials to a work order');
INSERT INTO `scripts` VALUES ('WorkOrderReceive.php',11,'Allows for receiving of works orders');
INSERT INTO `scripts` VALUES ('WorkOrderStatus.php',11,'Shows the status of works orders');
INSERT INTO `scripts` VALUES ('WOSerialNos.php',10,'');
INSERT INTO `scripts` VALUES ('WWW_Access.php',15,'');
INSERT INTO `scripts` VALUES ('WWW_Users.php',15,'Entry of users and security settings of users');
INSERT INTO `scripts` VALUES ('Z_BottomUpCosts.php',15,'');
INSERT INTO `scripts` VALUES ('Z_ChangeBranchCode.php',15,'Utility to change the branch code of a customer that cascades the change through all the necessary tables');
INSERT INTO `scripts` VALUES ('Z_ChangeCustomerCode.php',15,'Utility to change a customer code that cascades the change through all the necessary tables');
INSERT INTO `scripts` VALUES ('Z_ChangeStockCategory.php',15,'');
INSERT INTO `scripts` VALUES ('Z_ChangeStockCode.php',15,'Utility to change an item code that cascades the change through all the necessary tables');
INSERT INTO `scripts` VALUES ('Z_ChangeSupplierCode.php',15,'Script to change a supplier code accross all tables necessary');
INSERT INTO `scripts` VALUES ('Z_CheckAllocationsFrom.php',15,'');
INSERT INTO `scripts` VALUES ('Z_CheckAllocs.php',2,'');
INSERT INTO `scripts` VALUES ('Z_CheckDebtorsControl.php',15,'Inquiry that shows the total local currency (functional currency) balance of all customer accounts to reconcile with the general ledger debtors account');
INSERT INTO `scripts` VALUES ('Z_CheckGLTransBalance.php',15,'Checks all GL transactions balance and reports problem ones');
INSERT INTO `scripts` VALUES ('Z_CopyBOM.php',9,'Allows a bill of material to be copied between items');
INSERT INTO `scripts` VALUES ('Z_CreateChartDetails.php',9,'Utility page to create chart detail records for all general ledger accounts and periods created - needs expert assistance in use');
INSERT INTO `scripts` VALUES ('Z_CreateCompany.php',15,'Utility to insert company number 1 if not already there - actually only company 1 is used - the system is not multi-company');
INSERT INTO `scripts` VALUES ('Z_CreateCompanyTemplateFile.php',15,'');
INSERT INTO `scripts` VALUES ('Z_CurrencyDebtorsBalances.php',15,'Inquiry that shows the total foreign currency together with the total local currency (functional currency) balances of all customer accounts to reconcile with the general ledger debtors account');
INSERT INTO `scripts` VALUES ('Z_CurrencySuppliersBalances.php',15,'Inquiry that shows the total foreign currency amounts and also the local currency (functional currency) balances of all supplier accounts to reconcile with the general ledger creditors account');
INSERT INTO `scripts` VALUES ('Z_DataExport.php',15,'');
INSERT INTO `scripts` VALUES ('Z_DeleteCreditNote.php',15,'Utility to reverse a customer credit note - a desperate measure that should not be used except in extreme circumstances');
INSERT INTO `scripts` VALUES ('Z_DeleteInvoice.php',15,'Utility to reverse a customer invoice - a desperate measure that should not be used except in extreme circumstances');
INSERT INTO `scripts` VALUES ('Z_DeleteSalesTransActions.php',15,'Utility to delete all sales transactions, sales analysis the lot! Extreme care required!!!');
INSERT INTO `scripts` VALUES ('Z_DescribeTable.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportChartOfAccounts.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportFixedAssets.php',15,'Allow fixed assets to be imported from a csv');
INSERT INTO `scripts` VALUES ('Z_ImportGLAccountGroups.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportGLAccountSections.php',11,'');
INSERT INTO `scripts` VALUES ('Z_ImportPartCodes.php',11,'Allows inventory items to be imported from a csv');
INSERT INTO `scripts` VALUES ('Z_ImportStocks.php',15,'');
INSERT INTO `scripts` VALUES ('Z_index.php',15,'Utility menu page');
INSERT INTO `scripts` VALUES ('Z_MakeNewCompany.php',15,'');
INSERT INTO `scripts` VALUES ('Z_MakeStockLocns.php',15,'Utility to make LocStock records for all items and locations if not already set up.');
INSERT INTO `scripts` VALUES ('Z_poAddLanguage.php',15,'Allows a new language po file to be created');
INSERT INTO `scripts` VALUES ('Z_poAdmin.php',15,'Allows for a gettext language po file to be administered');
INSERT INTO `scripts` VALUES ('Z_poEditLangHeader.php',15,'');
INSERT INTO `scripts` VALUES ('Z_poEditLangModule.php',15,'');
INSERT INTO `scripts` VALUES ('Z_poEditLangRemaining.php',15,'');
INSERT INTO `scripts` VALUES ('Z_poRebuildDefault.php',15,'');
INSERT INTO `scripts` VALUES ('Z_PriceChanges.php',15,'Utility to make bulk pricing alterations to selected sales type price lists or selected customer prices only');
INSERT INTO `scripts` VALUES ('Z_ReApplyCostToSA.php',15,'Utility to allow the sales analysis table to be updated with the latest cost information - the sales analysis takes the cost at the time the sale was made to reconcile with the enteries made in the gl.');
INSERT INTO `scripts` VALUES ('Z_RePostGLFromPeriod.php',15,'Utility to repost all general ledger transaction commencing from a specified period. This can take some time in busy environments. Normally GL transactions are posted automatically each time a trial balance or profit and loss account is run');
INSERT INTO `scripts` VALUES ('Z_ReverseSuppPaymentRun.php',15,'Utility to reverse an entire Supplier payment run');
INSERT INTO `scripts` VALUES ('Z_SalesIntegrityCheck.php',15,'');
INSERT INTO `scripts` VALUES ('Z_UpdateChartDetailsBFwd.php',15,'Utility to recalculate the ChartDetails table B/Fwd balances - extreme care!!');
INSERT INTO `scripts` VALUES ('Z_Upgrade3.10.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.01-3.02.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.04-3.05.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.05-3.06.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.07-3.08.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.08-3.09.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.09-3.10.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.10-3.11.php',15,'');
INSERT INTO `scripts` VALUES ('Z_Upgrade_3.11-4.00.php',15,'');
INSERT INTO `scripts` VALUES ('Z_UploadForm.php',15,'Utility to upload a file to a remote server');
INSERT INTO `scripts` VALUES ('Z_UploadResult.php',15,'Utility to upload a file to a remote server');

--
-- Dumping data for table `securitygroups`
--

INSERT INTO `securitygroups` VALUES (1,1);
INSERT INTO `securitygroups` VALUES (1,2);
INSERT INTO `securitygroups` VALUES (2,1);
INSERT INTO `securitygroups` VALUES (2,2);
INSERT INTO `securitygroups` VALUES (2,11);
INSERT INTO `securitygroups` VALUES (3,1);
INSERT INTO `securitygroups` VALUES (3,2);
INSERT INTO `securitygroups` VALUES (3,3);
INSERT INTO `securitygroups` VALUES (3,4);
INSERT INTO `securitygroups` VALUES (3,5);
INSERT INTO `securitygroups` VALUES (3,11);
INSERT INTO `securitygroups` VALUES (4,1);
INSERT INTO `securitygroups` VALUES (4,2);
INSERT INTO `securitygroups` VALUES (4,5);
INSERT INTO `securitygroups` VALUES (5,1);
INSERT INTO `securitygroups` VALUES (5,2);
INSERT INTO `securitygroups` VALUES (5,3);
INSERT INTO `securitygroups` VALUES (5,11);
INSERT INTO `securitygroups` VALUES (6,1);
INSERT INTO `securitygroups` VALUES (6,2);
INSERT INTO `securitygroups` VALUES (6,3);
INSERT INTO `securitygroups` VALUES (6,4);
INSERT INTO `securitygroups` VALUES (6,5);
INSERT INTO `securitygroups` VALUES (6,6);
INSERT INTO `securitygroups` VALUES (6,7);
INSERT INTO `securitygroups` VALUES (6,8);
INSERT INTO `securitygroups` VALUES (6,9);
INSERT INTO `securitygroups` VALUES (6,10);
INSERT INTO `securitygroups` VALUES (6,11);
INSERT INTO `securitygroups` VALUES (7,1);
INSERT INTO `securitygroups` VALUES (8,1);
INSERT INTO `securitygroups` VALUES (8,2);
INSERT INTO `securitygroups` VALUES (8,3);
INSERT INTO `securitygroups` VALUES (8,4);
INSERT INTO `securitygroups` VALUES (8,5);
INSERT INTO `securitygroups` VALUES (8,6);
INSERT INTO `securitygroups` VALUES (8,7);
INSERT INTO `securitygroups` VALUES (8,8);
INSERT INTO `securitygroups` VALUES (8,9);
INSERT INTO `securitygroups` VALUES (8,10);
INSERT INTO `securitygroups` VALUES (8,11);
INSERT INTO `securitygroups` VALUES (8,12);
INSERT INTO `securitygroups` VALUES (8,13);
INSERT INTO `securitygroups` VALUES (8,14);
INSERT INTO `securitygroups` VALUES (8,15);
INSERT INTO `securitygroups` VALUES (9,9);

--
-- Dumping data for table `securityroles`
--

INSERT INTO `securityroles` VALUES (1,'Inquiries/Order Entry');
INSERT INTO `securityroles` VALUES (2,'Manufac/Stock Admin');
INSERT INTO `securityroles` VALUES (3,'Purchasing Officer');
INSERT INTO `securityroles` VALUES (4,'AP Clerk');
INSERT INTO `securityroles` VALUES (5,'AR Clerk');
INSERT INTO `securityroles` VALUES (6,'Accountant');
INSERT INTO `securityroles` VALUES (7,'Customer Log On Only');
INSERT INTO `securityroles` VALUES (8,'System Administrator');
INSERT INTO `securityroles` VALUES (9,'Supplier Log On Only');

--
-- Dumping data for table `securitytokens`
--

INSERT INTO `securitytokens` VALUES (1,'Order Entry/Inquiries customer access only');
INSERT INTO `securitytokens` VALUES (2,'Basic Reports and Inquiries with selection options');
INSERT INTO `securitytokens` VALUES (3,'Credit notes and AR management');
INSERT INTO `securitytokens` VALUES (4,'Purchase Orders');
INSERT INTO `securitytokens` VALUES (5,'Accounts Payable');
INSERT INTO `securitytokens` VALUES (6,'Petty Cash');
INSERT INTO `securitytokens` VALUES (7,'Bank Reconciliations');
INSERT INTO `securitytokens` VALUES (8,'General ledger reports/inquiries');
INSERT INTO `securitytokens` VALUES (9,'Supplier centre - Supplier access only');
INSERT INTO `securitytokens` VALUES (10,'General Ledger Maintenance, stock valuation & Configuration');
INSERT INTO `securitytokens` VALUES (11,'Inventory Management and Pricing');
INSERT INTO `securitytokens` VALUES (12,'Prices Security');
INSERT INTO `securitytokens` VALUES (13,'SQL Report Creation');
INSERT INTO `securitytokens` VALUES (14,'Form Design');
INSERT INTO `securitytokens` VALUES (15,'User Management and System Administration');

--
-- Dumping data for table `shipmentcharges`
--


--
-- Dumping data for table `shipments`
--


--
-- Dumping data for table `shippers`
--

INSERT INTO `shippers` VALUES (1,'DHL',0);
INSERT INTO `shippers` VALUES (8,'UPS',0);
INSERT INTO `shippers` VALUES (10,'Not Specified',0);

--
-- Dumping data for table `stockcategory`
--

INSERT INTO `stockcategory` VALUES ('AIRCON','Air Conditioning','F',1460,5700,5200,5100,1440);
INSERT INTO `stockcategory` VALUES ('BAKE','Baking Ingredients','F',1460,5700,5200,5000,1440);
INSERT INTO `stockcategory` VALUES ('DVD','DVDs','F',1460,5700,5000,5200,1440);
INSERT INTO `stockcategory` VALUES ('FOOD','Food','F',1460,5700,5200,5000,1440);
INSERT INTO `stockcategory` VALUES ('ZFR','Freight','D',1460,5600,5600,5600,1440);

--
-- Dumping data for table `stockcatproperties`
--

INSERT INTO `stockcatproperties` VALUES (1,'AIRCON','kw heating',0,'',999999999,0,-999999999,0);
INSERT INTO `stockcatproperties` VALUES (2,'AIRCON','kw cooling',0,'',999999999,0,-999999999,0);
INSERT INTO `stockcatproperties` VALUES (3,'AIRCON','inverter',2,'',999999999,0,-999999999,0);
INSERT INTO `stockcatproperties` VALUES (4,'DVD','Genre',1,'Action,Thriller,Comedy,Romance,Kids,Adult',999999999,0,-999999999,0);
INSERT INTO `stockcatproperties` VALUES (5,'PLANT','Depreciation Type',1,'Straight Line,Reducing Balance',999999999,0,-999999999,0);
INSERT INTO `stockcatproperties` VALUES (6,'PLANT','Annual Depreciation Percentage',0,'5',999999999,0,-999999999,0);

--
-- Dumping data for table `stockcheckfreeze`
--


--
-- Dumping data for table `stockcounts`
--


--
-- Dumping data for table `stockitemproperties`
--

INSERT INTO `stockitemproperties` VALUES ('FREIGHT',6,'');
INSERT INTO `stockitemproperties` VALUES ('DVD-CASE',4,'Action');
INSERT INTO `stockitemproperties` VALUES ('DVD-DHWV',4,'Action');
INSERT INTO `stockitemproperties` VALUES ('DVD-UNSG2',4,'Action');
INSERT INTO `stockitemproperties` VALUES ('FREIGHT',5,'Straight Line');

--
-- Dumping data for table `stockmaster`
--

INSERT INTO `stockmaster` VALUES ('BIGEARS12','DVD','Big Ears and Noddy episodes on DVD','Big Ears and Noddy episodes on DVD','each','M','0.0000','0.0000','3490.0000','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('BirthdayCakeConstruc','BAKE','12 foot birthday cake for wrestling tournament','12 foot birthday cake for wrestling tournament','each','M','0.0000','0.0000','15.8292','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('BREAD','FOOD','Bread','Bread','each','M','0.0000','8.8785','0.2445','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DFS-20','AIRCON','GSGF DFS-20001 DOG CAT ANIMAL','GSGF DFS-20001 DOG CAT ANIMAL','each','M','0.0000','0.0000','188.2250','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DR_TUMMY','FOOD','Gastric exquisite diarrhea','Gastric exquisite diarrhea','each','M','0.0000','0.0000','116.2250','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DVD-CASE','DVD','webERP Demo DVD Case','webERP Demo DVD Case','each','B','0.0000','0.0000','0.3000','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','DE',1,0,'0',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DVD-DHWV','DVD','Die Hard With A Vengeance Linked','Regional Code: 2 (Japan, Europe, Middle East, South Africa). &lt;br /&gt;Languages: English, Deutsch. &lt;br /&gt;Subtitles: English, Deutsch, Spanish. &lt;br /&gt;Audio: Dolby Surround 5.1. &lt;br /&gt;Picture Format: 16:9 Wide-Screen. &lt;br /&gt;Length: (approx) 122 minutes. &lt;br /&gt;Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','each','B','0.0000','5.5000','2.3200','0.0000','0.0000',0,0,0,3,'0.0000','7.0000','','',1,0,'0',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DVD-LTWP','AIRCON','Lethal Weapon Linked','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n<br />\r\nLanguages: English, Deutsch.\r\n<br />\r\nSubtitles: English, Deutsch, Spanish.\r\n<br />\r\nAudio: Dolby Surround 5.1.\r\n<br />\r\nPicture Format: 16:9 Wide-Screen.\r\n<br />\r\nLength: (approx) 100 minutes.\r\n<br />\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','each','B','0.0000','2.6600','2.7000','0.0000','0.0000',0,0,0,0,'0.0000','7.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DVD-TOPGUN','DVD','Top Gun DVD','Top Gun DVD','each','B','0.0000','0.0000','6.5000','0.0000','0.0000',0,0,1,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DVD-UNSG','DVD','Under Siege Linked','Regional Code: 2 (Japan, Europe, Middle East, South Africa). <br />Languages: English, Deutsch. <br />Subtitles: English, Deutsch, Spanish. <br />Audio: Dolby Surround 5.1. <br />Picture Format: 16:9 Wide-Screen. <br />Length: (approx) 98 minutes. <br />Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','each','B','0.0000','0.0000','5.0000','0.0000','0.0000',0,0,0,0,'0.0000','7.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DVD-UNSG2','DVD','Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n&lt;br /&gt;\r\nLanguages: English, Deutsch.\r\n&lt;br /&gt;\r\nSubtitles: English, Deutsch, Spanish.\r\n&lt;br /&gt;\r\nAudio: Dolby Surround 5.1.\r\n&lt;br /&gt;\r\nPicture Format: 16:9 Wide-Screen.\r\n&lt;br /&gt;\r\nLength: (approx) 98 minutes.\r\n&lt;br /&gt;\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).','each','B','0.0000','0.0000','5.0000','0.0000','0.0000',0,1,0,0,'0.0000','7.0000','','',1,0,'0',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('DVD_ACTION','DVD','Action Series Bundle','Under Seige I and Under Seige II\r\n','each','M','0.0000','0.0000','16.2200','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('FLOUR','AIRCON','High Grade Flour','High Grade Flour','kgs','B','0.0000','0.0000','3.8900','0.0000','0.0000',0,0,1,0,'0.0000','0.0000','','',1,0,'none',0,1,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('FREIGHT','ZFR','Freight','Freight','each','D','0.0000','0.0000','0.0000','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'0',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('FROAYLANDO','FOOD','Fried Orange Yoke Flan D\'Or','Fried Orange Yoke Flan D\'Or','each','M','0.0000','0.0000','34.2618','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('FUJI990101','AIRCON','Fujitsu 990101 Split type Indoor Unit 3.5kw','Fujitsu 990101 Split type Indoor Unit 3.5kw Heat Pump with mounting screws and isolating switch','each','B','0.0000','995.7138','1015.6105','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,4,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('FUJI990102','AIRCON','Fujitsu 990102 split type A/C Outdoor unit 3.5kw','Fujitsu 990102 split type A/C Outdoor unit 3.5kw with 5m piping & insulation','each','B','0.0000','0.0000','633.0000','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('FUJI9901ASS','AIRCON','Fujitsu 990101 Split type A/C 3.5kw complete','Fujitsu 990101 Split type A/C 3.5kw complete with indoor and outdoor units 5m pipe and insulation isolating switch. 5 year warranty','each','A','0.0000','0.0000','0.0000','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('HIT3042-4','AIRCON','Hitachi Aircond Rev Cycle Split Type 6.5kw Indoor','Hitachi Aircond Rev Cycle Split Type 6.5kw Indoor Unit - wall hung complete with brackets and screws. 220V-240V AC\r\n5 year guaranttee','each','M','0.0000','0.0000','853.0000','0.0000','0.0000',0,0,1,5,'0.4000','7.8000','','',1,1,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('HIT3043-5','AIRCON','Hitachi Aircond Rev Cycle Split Type 6.5kw Outdoor','Hitachi Aircond Rev Cycle Split Type 6.5kw Outdoor unit - including 5m piping for fitting to HIT3042-4 indoor unit\r\n5 year guaranttee','each','B','0.0000','0.0000','1235.0000','0.0000','0.0000',0,0,1,5,'0.8500','16.0000','','',1,1,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('SALT','BAKE','Salt','Salt','kgs','B','0.0000','2.5000','6.3947','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,3,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('SLICE','FOOD','Slice Of Bread','Slice Of Bread','each','M','0.0000','0.0000','0.0245','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');
INSERT INTO `stockmaster` VALUES ('YEAST','BAKE','Yeast','Yeast','kgs','B','0.0000','3.8500','5.0000','0.0000','0.0000',0,0,0,0,'0.0000','0.0000','','',1,0,'none',0,0,0,0,0,'0.0000','0000-00-00');

--
-- Dumping data for table `stockmoves`
--

INSERT INTO `stockmoves` VALUES (2,'DVD-DHWV',28,1,'MEL','2007-06-14','','','5.2500',2,'3',-2,0,5.25,1,-2,0,NULL);
INSERT INTO `stockmoves` VALUES (3,'DVD-TOPGUN',28,2,'MEL','2007-06-18','','','6.5000',2,'3',-1,0,6.5,1,-1,0,NULL);
INSERT INTO `stockmoves` VALUES (4,'DVD-DHWV',28,3,'MEL','2007-06-18','','','0.0000',2,'3',-10,0,5.25,1,-12,0,NULL);
INSERT INTO `stockmoves` VALUES (5,'DVD-LTWP',28,3,'MEL','2007-06-18','','','0.0000',2,'3',-10,0,2.85,1,-10,0,NULL);
INSERT INTO `stockmoves` VALUES (6,'DVD-UNSG',28,3,'MEL','2007-06-18','','','0.0000',2,'3',-10,0,5,1,-10,0,NULL);
INSERT INTO `stockmoves` VALUES (7,'DVD-UNSG2',28,3,'MEL','2007-06-18','','','0.0000',2,'3',-10,0,5,1,-10,0,NULL);
INSERT INTO `stockmoves` VALUES (8,'DVD_ACTION',26,2,'MEL','2007-06-18','','','18.4000',2,'3',10,0,18.4,1,10,0,NULL);
INSERT INTO `stockmoves` VALUES (9,'FLOUR',28,4,'MEL','2007-06-21','','','3.8900',2,'5',-4,0,3.89,1,-4,0,NULL);
INSERT INTO `stockmoves` VALUES (10,'DVD-DHWV',10,1,'TOR','2007-06-26','QUARTER','QUARTER','15.9500',2,'1',-2,0,5.25,1,-2,0,'');
INSERT INTO `stockmoves` VALUES (11,'DVD-LTWP',10,1,'TOR','2007-06-26','QUARTER','QUARTER','14.5000',2,'1',-1,0,2.85,1,-1,0,'');
INSERT INTO `stockmoves` VALUES (12,'DVD-DHWV',11,1,'TOR','2007-08-02','QUARTER','QUARTER','15.9500',3,'Ex Inv - 1',1,0,5.25,1,-1,0,'');
INSERT INTO `stockmoves` VALUES (13,'SALT',28,5,'MEL','2008-06-27','','','0.0000',13,'5',-0.3,0,2.5,1,-0.3,0,NULL);
INSERT INTO `stockmoves` VALUES (14,'DVD-LTWP',25,18,'MEL','2009-02-04','','','2.9800',21,'CAMPBELL (Campbell Roberts Inc) - 1',1,0,2.7,1,-9,0,NULL);
INSERT INTO `stockmoves` VALUES (15,'DVD-LTWP',25,19,'MEL','2009-02-05','','','2.9800',21,'CAMPBELL (Campbell Roberts Inc) - 1',1,0,2.7,1,-8,0,NULL);
INSERT INTO `stockmoves` VALUES (16,'DVD-LTWP',25,20,'MEL','2009-02-05','','','2.9800',21,'CAMPBELL (Campbell Roberts Inc) - 1',1,0,2.7,1,-7,0,NULL);
INSERT INTO `stockmoves` VALUES (17,'DVD-LTWP',25,21,'MEL','2009-02-05','','','2.9800',21,'CAMPBELL (Campbell Roberts Inc) - 1',1,0,2.7,1,-6,0,NULL);
INSERT INTO `stockmoves` VALUES (18,'DVD-LTWP',25,22,'MEL','2009-02-05','','','2.9800',21,'CAMPBELL (Campbell Roberts Inc) - 1',1,0,2.7,1,-5,0,NULL);
INSERT INTO `stockmoves` VALUES (19,'DVD-LTWP',25,23,'MEL','2009-02-05','','','2.9800',21,'CAMPBELL (Campbell Roberts Inc) - 1',1,0,2.7,1,-4,0,NULL);
INSERT INTO `stockmoves` VALUES (20,'DVD-LTWP',25,24,'MEL','2009-02-05','','','2.9800',21,'CAMPBELL (Campbell Roberts Inc) - 1',1,0,2.7,1,-3,0,NULL);
INSERT INTO `stockmoves` VALUES (21,'SALT',25,25,'MEL','2009-02-05','','','100.0000',21,'GOTSTUFF (We Got the Stuff Inc) - 2',1,0,2.5,1,0.7,0,NULL);
INSERT INTO `stockmoves` VALUES (22,'SALT',25,26,'MEL','2009-02-05','','','100.0000',21,'GOTSTUFF (We Got the Stuff Inc) - 2',1,0,2.5,1,1.7,0,NULL);
INSERT INTO `stockmoves` VALUES (23,'SALT',25,27,'MEL','2009-02-05','','','100.0000',21,'GOTSTUFF (We Got the Stuff Inc) - 2',1,0,2.5,1,2.7,0,NULL);
INSERT INTO `stockmoves` VALUES (24,'SALT',25,28,'MEL','2009-02-05','','','100.0000',21,'GOTSTUFF (We Got the Stuff Inc) - 2',1,0,2.5,1,3.7,0,NULL);
INSERT INTO `stockmoves` VALUES (25,'SALT',25,29,'MEL','2009-02-05','','','100.0000',21,'GOTSTUFF (We Got the Stuff Inc) - 2',1,0,2.5,1,4.7,0,NULL);
INSERT INTO `stockmoves` VALUES (26,'SALT',25,30,'MEL','2009-02-05','','','100.0000',21,'GOTSTUFF (We Got the Stuff Inc) - 2',1,0,2.5,1,5.7,0,NULL);
INSERT INTO `stockmoves` VALUES (27,'SALT',25,31,'MEL','2009-02-05','','','100.0000',21,'GOTSTUFF (We Got the Stuff Inc) - 2',1,0,2.5,1,6.7,0,NULL);
INSERT INTO `stockmoves` VALUES (28,'BREAD',17,17,'MEL','2009-02-05','','','0.0000',21,'',100,0,0,1,100,0,NULL);
INSERT INTO `stockmoves` VALUES (29,'BREAD',16,13,'MEL','2009-02-06','','','0.0000',21,'To Toronto',-10,0,0,1,90,0,NULL);
INSERT INTO `stockmoves` VALUES (30,'BREAD',16,13,'TOR','2009-02-06','','','0.0000',21,'From Melbourne',10,0,0,1,10,0,NULL);
INSERT INTO `stockmoves` VALUES (31,'BREAD',16,18,'MEL','2009-02-06','','','0.0000',21,'To Toronto',-1,0,0,1,89,0,NULL);
INSERT INTO `stockmoves` VALUES (32,'BREAD',16,18,'TOR','2009-02-06','','','0.0000',21,'From Melbourne',1,0,0,1,11,0,NULL);
INSERT INTO `stockmoves` VALUES (33,'BREAD',16,19,'MEL','2009-02-06','','','0.0000',21,'To Toronto',-1,0,0,1,88,0,NULL);
INSERT INTO `stockmoves` VALUES (34,'BREAD',16,19,'TOR','2009-02-06','','','0.0000',21,'From Melbourne',1,0,0,1,12,0,NULL);
INSERT INTO `stockmoves` VALUES (36,'BREAD',10,4,'MEL','2010-05-31','ANGRY','ANGRY','6.9000',-11,'8',-3,0.1,6.0085,1,85,0,'');
INSERT INTO `stockmoves` VALUES (37,'SALT',10,4,'MEL','2010-05-31','ANGRY','ANGRY','3.2500',-11,'8',-3,0,2.5,1,3.7,0,'');
INSERT INTO `stockmoves` VALUES (38,'BREAD',10,5,'MEL','2010-05-31','ANGRY','ANGRY','6.9000',-11,'9',-4,0.15,6.0085,1,81,0,'');
INSERT INTO `stockmoves` VALUES (39,'SALT',10,5,'MEL','2010-05-31','ANGRY','ANGRY','2.9900',-11,'9',-1,0.015,2.5,1,2.7,0,'');
INSERT INTO `stockmoves` VALUES (40,'BREAD',10,6,'MEL','2010-05-31','ANGRY','ANGRY','12.0000',-11,'10',-2,0,6.0085,1,79,0,'');
INSERT INTO `stockmoves` VALUES (41,'BREAD',10,7,'MEL','2010-05-31','ANGRY','ANGRY','0.0000',-11,'11',-5,0,6.0085,1,74,0,'');
INSERT INTO `stockmoves` VALUES (42,'BREAD',11,2,'MEL','2010-05-31','ANGRY','ANGRY','0.0000',36,'Ex Inv - 7',5,0,6.0085,1,79,0,'');
INSERT INTO `stockmoves` VALUES (44,'SALT',10,9,'MEL','2010-05-31','ANGRY','ANGRY','25.0000',-11,'13',-2,0,2.5,1,0.7,0,'');
INSERT INTO `stockmoves` VALUES (45,'BREAD',10,10,'MEL','2010-05-31','ANGRY','ANGRY','5.2500',-11,'14',-2,0,6.0085,1,77,0,'');
INSERT INTO `stockmoves` VALUES (46,'BREAD',10,11,'MEL','2010-05-31','ANGRY','ANGRY','5.8824',-11,'15',-1,0,6.0085,1,76,0,'');
INSERT INTO `stockmoves` VALUES (47,'BREAD',10,12,'MEL','2010-05-31','ANGRY','ANGRY','5.8824',-11,'16',-1,0,6.0085,1,75,0,'');
INSERT INTO `stockmoves` VALUES (48,'BREAD',10,13,'MEL','2010-05-31','ANGRY','ANGRY','5.8824',-11,'17',-1,0,6.0085,1,74,0,'');
INSERT INTO `stockmoves` VALUES (49,'BREAD',10,14,'MEL','2010-05-31','ANGRY','ANGRY','11.1765',-11,'18',-12,0,6.0085,1,62,0,'');
INSERT INTO `stockmoves` VALUES (50,'SALT',10,14,'MEL','2010-05-31','ANGRY','ANGRY','5.8824',-11,'18',-0.7,0,2.5,1,0,0,'');
INSERT INTO `stockmoves` VALUES (51,'BREAD',28,6,'TOR','2010-08-14','','','6.0085',0,'12',-3.5,0,6.0085,1,8.5,0,NULL);
INSERT INTO `stockmoves` VALUES (52,'BREAD',28,7,'TOR','2010-08-15','','','6.0085',0,'12',-2,0,6.0085,1,6.5,0,NULL);
INSERT INTO `stockmoves` VALUES (53,'DVD-CASE',17,18,'TOR','2010-08-15','','','0.0000',0,'',180,0,0,1,180,0,NULL);
INSERT INTO `stockmoves` VALUES (54,'DVD-CASE',28,8,'TOR','2010-08-15','','','0.3000',0,'12',-1,0,0.3,1,179,0,NULL);
INSERT INTO `stockmoves` VALUES (55,'YEAST',17,19,'TOR','2010-08-15','','','0.0000',0,'',9.95,0,0,1,9.95,0,NULL);
INSERT INTO `stockmoves` VALUES (56,'YEAST',28,9,'TOR','2010-08-15','','','5.0000',0,'12',-0.75,0,5,1,9.2,0,NULL);
INSERT INTO `stockmoves` VALUES (57,'SALT',17,20,'TOR','2010-08-15','','','0.0000',0,'',25,0,0,1,25,0,NULL);
INSERT INTO `stockmoves` VALUES (58,'SALT',28,10,'TOR','2010-08-15','','','2.5000',0,'12',-1.3,0,2.5,1,23.7,0,NULL);
INSERT INTO `stockmoves` VALUES (59,'DVD-CASE',11,3,'TOR','2011-02-16','DUMBLE','DUMBLE','0.0000',6,'',2,0,0.3,1,181,0,'');
INSERT INTO `stockmoves` VALUES (60,'FLOUR',11,4,'TOR','2011-02-16','DUMBLE','DUMBLE','1.7500',6,'',12,0,3.89,1,12,0,'');
INSERT INTO `stockmoves` VALUES (61,'BREAD',11,5,'MEL','2011-02-16','ANGRY','ANGRY','12.0000',6,'Ex Inv - 6',2,0,6.0085,1,64,0,'');
INSERT INTO `stockmoves` VALUES (62,'DVD-CASE',25,32,'MEL','2011-03-10','','','0.2300',7,'CAMPBELL (Campbell Roberts Inc) - 1',45,0,0.3,1,45,0,NULL);
INSERT INTO `stockmoves` VALUES (63,'DVD-LTWP',11,6,'TOR','2011-03-26','DUMBLE','DUMBLE','7.1875',7,'test',1,0,2.7,1,0,0,'');
INSERT INTO `stockmoves` VALUES (64,'BREAD',11,7,'MEL','2011-03-29','ANGRY','ANGRY','6.9000',7,'Ex Inv - 4',3,0.1,6.0085,1,67,0,'');
INSERT INTO `stockmoves` VALUES (65,'SALT',11,7,'MEL','2011-03-29','ANGRY','ANGRY','3.2500',7,'Ex Inv - 4',3,0,2.5,1,3,0,'');
INSERT INTO `stockmoves` VALUES (66,'DVD-CASE',16,23,'MEL','2011-04-10','','','0.0000',8,'To TOR',-10,0,0,1,35,0,NULL);
INSERT INTO `stockmoves` VALUES (67,'DVD-CASE',16,23,'TOR','2011-04-10','','','0.0000',8,'From MEL',10,0,0,1,191,0,NULL);
INSERT INTO `stockmoves` VALUES (68,'DVD-CASE',10,15,'TOR','2011-04-18','QUICK','SLOW','19.4118',8,'28',-5,0.05,0.3,1,186,0,'Testing one two three');
INSERT INTO `stockmoves` VALUES (69,'SALT',10,15,'TOR','2011-04-18','QUICK','SLOW','4.1176',8,'28',-4,0.025,2.5,1,19.7,0,'ass');
INSERT INTO `stockmoves` VALUES (70,'FLOUR',10,16,'TOR','2011-05-03','QUICK','SLOW','287.3224',9,'29',-4,0.025,3.89,1,8,0,'');
INSERT INTO `stockmoves` VALUES (71,'SALT',25,34,'MEL','2011-05-19','','','100.0000',9,'GOTSTUFF (We Got the Stuff Inc) - 2',2,0,3.3654888888889,1,5,0,NULL);
INSERT INTO `stockmoves` VALUES (72,'DVD-CASE',16,24,'MEL','2011-05-29','','','0.0000',9,'To TOR',-1,0,0,1,34,0,NULL);
INSERT INTO `stockmoves` VALUES (73,'DVD-CASE',16,24,'TOR','2011-05-29','','','0.0000',9,'From MEL',1,0,0,1,187,0,NULL);
INSERT INTO `stockmoves` VALUES (74,'HIT3043-5',17,21,'MEL','2011-05-30','','','0.0000',9,'',5,0,0,1,5,0,NULL);
INSERT INTO `stockmoves` VALUES (75,'BREAD',10,17,'MEL','2011-08-09','ANGRY','ANGRY','5.4364',12,'11',-2,0,5.5873,1,65,0,'');
INSERT INTO `stockmoves` VALUES (76,'DVD-CASE',25,35,'MEL','2011-08-10','','','30.0000',12,'WHYNOT (Why not add a new supplier) - 16',95,0,0.3,1,129,0,NULL);
INSERT INTO `stockmoves` VALUES (77,'DVD-CASE',25,36,'MEL','2011-08-11','','','30.0000',12,'WHYNOT (Why not add a new supplier) - 15',0.25,0,0.3,1,129.25,0,NULL);
INSERT INTO `stockmoves` VALUES (78,'DVD-CASE',25,37,'MEL','2011-08-11','','','30.0000',12,'WHYNOT (Why not add a new supplier) - 15',25,0,0.3,1,154.25,0,NULL);
INSERT INTO `stockmoves` VALUES (79,'DVD-CASE',25,38,'MEL','2011-08-11','','','30.0000',12,'WHYNOT (Why not add a new supplier) - 15',16,0,0.3,1,170.25,0,NULL);
INSERT INTO `stockmoves` VALUES (80,'BREAD',10,18,'MEL','2011-08-24','ANGRY','ANGRY','10.9091',12,'10',-2,0,5.5873,1,63,0,'');
INSERT INTO `stockmoves` VALUES (81,'BREAD',10,19,'MEL','2011-08-24','ANGRY','ANGRY','6.2727',12,'8',-3,0.1,5.5873,1,60,0,'');
INSERT INTO `stockmoves` VALUES (82,'SALT',10,19,'MEL','2011-08-24','ANGRY','ANGRY','2.9545',12,'8',-3,0,6.3947,1,2,0,'');
INSERT INTO `stockmoves` VALUES (83,'BREAD',17,22,'MEL','2011-08-31','','','0.0000',12,'',-3,0,0,1,57,0,NULL);

--
-- Dumping data for table `stockmovestaxes`
--

INSERT INTO `stockmovestaxes` VALUES (10,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (11,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (12,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (36,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (37,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (38,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (39,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (40,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (41,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (42,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (50,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (59,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (60,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (61,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (63,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (64,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (65,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (68,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (69,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (70,13,0,0,0);
INSERT INTO `stockmovestaxes` VALUES (75,11,0.07,0,2);
INSERT INTO `stockmovestaxes` VALUES (75,12,0.05,0,1);
INSERT INTO `stockmovestaxes` VALUES (80,11,0.07,0,2);
INSERT INTO `stockmovestaxes` VALUES (80,12,0.05,0,1);
INSERT INTO `stockmovestaxes` VALUES (81,11,0.07,0,2);
INSERT INTO `stockmovestaxes` VALUES (81,12,0.05,0,1);
INSERT INTO `stockmovestaxes` VALUES (82,11,0.07,0,2);
INSERT INTO `stockmovestaxes` VALUES (82,12,0.05,0,1);

--
-- Dumping data for table `stockserialitems`
--

INSERT INTO `stockserialitems` VALUES ('DVD-TOPGUN','MEL','23','0000-00-00 00:00:00',-1,'');
INSERT INTO `stockserialitems` VALUES ('FLOUR','MEL','5433','0000-00-00 00:00:00',-4,'');
INSERT INTO `stockserialitems` VALUES ('FLOUR','TOR','reww211','0000-00-00 00:00:00',8,'');
INSERT INTO `stockserialitems` VALUES ('HIT3043-5','MEL','122234','0000-00-00 00:00:00',1,'');
INSERT INTO `stockserialitems` VALUES ('HIT3043-5','MEL','12241','0000-00-00 00:00:00',1,'');
INSERT INTO `stockserialitems` VALUES ('HIT3043-5','MEL','122445','0000-00-00 00:00:00',1,'');
INSERT INTO `stockserialitems` VALUES ('HIT3043-5','MEL','1234','0000-00-00 00:00:00',1,'');
INSERT INTO `stockserialitems` VALUES ('HIT3043-5','MEL','123434','0000-00-00 00:00:00',1,'');

--
-- Dumping data for table `stockserialmoves`
--

INSERT INTO `stockserialmoves` VALUES (1,3,'DVD-TOPGUN','23',1);
INSERT INTO `stockserialmoves` VALUES (2,9,'FLOUR','5433',4);
INSERT INTO `stockserialmoves` VALUES (3,60,'FLOUR','reww211',12);
INSERT INTO `stockserialmoves` VALUES (4,70,'FLOUR','reww211',-4);
INSERT INTO `stockserialmoves` VALUES (5,74,'HIT3043-5','1234',1);
INSERT INTO `stockserialmoves` VALUES (6,74,'HIT3043-5','123434',1);
INSERT INTO `stockserialmoves` VALUES (7,74,'HIT3043-5','122234',1);
INSERT INTO `stockserialmoves` VALUES (8,74,'HIT3043-5','12241',1);
INSERT INTO `stockserialmoves` VALUES (9,74,'HIT3043-5','122445',1);

--
-- Dumping data for table `suppallocs`
--


--
-- Dumping data for table `suppliercontacts`
--

INSERT INTO `suppliercontacts` VALUES ('CAMPBELL','Freddy Mercurial','Scaramouse','12903','0120','0001','fred@topdog.com',0);
INSERT INTO `suppliercontacts` VALUES ('CRUISE','Barry Toad','Slips','92827','0204389','','',0);
INSERT INTO `suppliercontacts` VALUES ('GOTSTUFF','Mr salesman','Salesman','','','','mrsales@wegotstuff.com',0);
INSERT INTO `suppliercontacts` VALUES ('WHYNOT','You think','','','','','phil@logicworks.co.nz',0);

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` VALUES ('BINGO','Binary Green Ocean Inc','Box 3499','Gardenier','San Fransisco','California 54424','','',1,0.000000,0.000000,'USD','2003-03-01','30',12,'2007-04-26 00:00:00','','0','',0,1,0,'','','',NULL,NULL,NULL);
INSERT INTO `suppliers` VALUES ('CAMPBELL','Campbell Roberts Inc','Box 9882','Ottowa Rise','','','','',1,0.000000,0.000000,'USD','2005-06-23','30',0,NULL,'','0','',0,2,0,'','','',NULL,NULL,NULL);
INSERT INTO `suppliers` VALUES ('CRUISE','Cruise Company Inc','Box 2001','Ft Lauderdale, Florida','','','','',1,0.000000,0.000000,'GBP','2005-06-23','30',0,NULL,'123456789012345678901234567890','0','',0,3,0,'','','',NULL,NULL,NULL);
INSERT INTO `suppliers` VALUES ('DUBROW','Dublrowski and Associates','','','','','','',1,0.000000,0.000000,'EUR','2011-09-03','30',1000,'2011-09-05 00:00:00','','0','',0,1,0,'','','','','','');
INSERT INTO `suppliers` VALUES ('GOTSTUFF','We Got the Stuff Inc','Test line 1','Test line 2','Test line 3','Test line 4 - editing','','',1,0.000000,0.000000,'USD','2005-10-29','20',0,NULL,'','ok then','tell me abou',0,1,0,'','','',NULL,NULL,NULL);
INSERT INTO `suppliers` VALUES ('OTHER','Another ','Supplier','','','','','',2,0.000000,0.000000,'AUD','2011-04-01','20',0,NULL,'','0','',0,1,0,'','','','','','');
INSERT INTO `suppliers` VALUES ('REGNEW','Reg Newall Inc','P O 5432','Wichita','Wyoming','','','',1,0.000000,0.000000,'USD','2005-04-30','30',0,NULL,'','0','',0,1,0,'','','',NULL,NULL,NULL);
INSERT INTO `suppliers` VALUES ('WHYNOT','Why not add a new supplier','Well I will ','If I','Want ','To','','',1,0.000000,0.000000,'AUD','2011-04-01','20',0,NULL,'','0','',0,1,0,'','','','','','12323');

--
-- Dumping data for table `suppliertype`
--

INSERT INTO `suppliertype` VALUES (1,'Default');
INSERT INTO `suppliertype` VALUES (2,'Others');

--
-- Dumping data for table `supptrans`
--

INSERT INTO `supptrans` VALUES (18,20,'CRUISE','assssa','2010-08-13','2010-09-30','2010-08-14 05:56:12',0,0.8,50,0,0,0,'',0,1);
INSERT INTO `supptrans` VALUES (20,20,'CRUISE','21221-DFR','2010-08-13','2010-09-30','2010-08-14 06:48:55',0,0.8,1255.25,0,0,0,'',0,3);
INSERT INTO `supptrans` VALUES (21,20,'CRUISE','9877','2010-08-13','2010-09-30','2010-08-14 06:51:30',0,0.8,10,0,0,0,'',0,4);
INSERT INTO `supptrans` VALUES (22,20,'CRUISE','9877-877','2010-08-13','2010-09-30','2010-08-14 06:54:23',0,0.8,100,0,0,0,'',0,5);
INSERT INTO `supptrans` VALUES (5,21,'CRUISE','30299','2010-08-13','2010-09-30','2010-08-14 07:16:10',0,0.8,-90,0,0,0,'',0,6);
INSERT INTO `supptrans` VALUES (6,21,'CRUISE','57748-OPP','2010-08-13','2010-09-30','2010-08-14 07:35:46',0,0.8,-100,0,0,0,'',0,7);
INSERT INTO `supptrans` VALUES (7,21,'CRUISE','9sjkja_099','2010-08-13','2010-09-30','2010-08-14 07:39:38',0,0.8,-104.41,0,0,0,'',0,8);
INSERT INTO `supptrans` VALUES (23,20,'CRUISE','389100','2011-04-03','2011-05-31','2011-04-04 00:00:00',0,0.8,145.95,0,0,0,'test again',0,9);
INSERT INTO `supptrans` VALUES (24,20,'BINGO','asass','2011-05-17','2011-06-30','2011-05-18 00:00:00',0,1.1,25,2.5,0,0,'Some invoice header narrative??',0,10);
INSERT INTO `supptrans` VALUES (25,20,'GOTSTUFF','43434343','2011-05-18','2011-06-22','2011-05-19 00:00:00',0,1.1,145796.95,14579.7,0,0,'There it is',0,11);
INSERT INTO `supptrans` VALUES (7,22,'DUBROW','5771148 doc3673 fact','2011-07-21','2011-07-21','2011-09-03 09:09:52',0,0.521,59.5,0,0,0,'5771148 doc3673 fact\r\nHr C Veldhuizen\r\n',0,12);
INSERT INTO `supptrans` VALUES (8,22,'DUBROW','4753160 MAXXINNO\r\nWY','2011-07-18','2011-07-18','2011-09-04 03:09:49',0,0.44,148.75,0,0,0,'4753160 MAXXINNO\r\nWYCHEN MAXXINNO WYCHEN\r\nFact. DOC3654 24-06-2011 transactiedatum: 18-07-2011\r\n',0,13);
INSERT INTO `supptrans` VALUES (9,22,'DUBROW','Cash','2011-09-04','0000-00-00','2011-09-04 15:45:56',0,2.2727272727273,-100,0,0,0,'',0,14);
INSERT INTO `supptrans` VALUES (26,20,'DUBROW','2211','2011-09-03','2011-10-31','2011-09-04 00:00:00',0,0.44,950,0,0,0,'',0,15);
INSERT INTO `supptrans` VALUES (10,22,'DUBROW','9238272 PLEXX BV\r\nJU','2011-07-25','2011-07-25','2011-09-04 05:09:34',0,0.44,-340,0,0,0,'9238272 PLEXX BV\r\nJULI\r\n',0,16);
INSERT INTO `supptrans` VALUES (11,22,'DUBROW','Cash','2011-09-05','0000-00-00','2011-09-05 21:17:16',0,2,-100,0,0,0,'',0,17);
INSERT INTO `supptrans` VALUES (12,22,'DUBROW','Cash','2011-09-05','0000-00-00','2011-09-05 21:54:58',0,0.5,-1000,0,0,0,'',0,18);

--
-- Dumping data for table `supptranstaxes`
--

INSERT INTO `supptranstaxes` VALUES (1,13,0);
INSERT INTO `supptranstaxes` VALUES (3,13,0);
INSERT INTO `supptranstaxes` VALUES (4,13,0);
INSERT INTO `supptranstaxes` VALUES (5,13,0);
INSERT INTO `supptranstaxes` VALUES (6,13,0);
INSERT INTO `supptranstaxes` VALUES (7,13,0);
INSERT INTO `supptranstaxes` VALUES (8,13,0);
INSERT INTO `supptranstaxes` VALUES (9,13,0);
INSERT INTO `supptranstaxes` VALUES (10,1,2.5);
INSERT INTO `supptranstaxes` VALUES (11,1,14579.695);
INSERT INTO `supptranstaxes` VALUES (15,1,0);

--
-- Dumping data for table `systypes`
--

INSERT INTO `systypes` VALUES (0,'Journal - GL',3);
INSERT INTO `systypes` VALUES (1,'Payment - GL',4);
INSERT INTO `systypes` VALUES (2,'Receipt - GL',2);
INSERT INTO `systypes` VALUES (3,'Standing Journal',0);
INSERT INTO `systypes` VALUES (10,'Sales Invoice',19);
INSERT INTO `systypes` VALUES (11,'Credit Note',7);
INSERT INTO `systypes` VALUES (12,'Receipt',18);
INSERT INTO `systypes` VALUES (15,'Journal - Debtors',0);
INSERT INTO `systypes` VALUES (16,'Location Transfer',28);
INSERT INTO `systypes` VALUES (17,'Stock Adjustment',22);
INSERT INTO `systypes` VALUES (18,'Purchase Order',22);
INSERT INTO `systypes` VALUES (19,'Picking List',0);
INSERT INTO `systypes` VALUES (20,'Purchase Invoice',26);
INSERT INTO `systypes` VALUES (21,'Debit Note',7);
INSERT INTO `systypes` VALUES (22,'Creditors Payment',12);
INSERT INTO `systypes` VALUES (23,'Creditors Journal',0);
INSERT INTO `systypes` VALUES (25,'Purchase Order Delivery',38);
INSERT INTO `systypes` VALUES (26,'Work Order Receipt',4);
INSERT INTO `systypes` VALUES (28,'Work Order Issue',10);
INSERT INTO `systypes` VALUES (29,'Work Order Variance',1);
INSERT INTO `systypes` VALUES (30,'Sales Order',35);
INSERT INTO `systypes` VALUES (31,'Shipment Close',26);
INSERT INTO `systypes` VALUES (32,'Contract Close',6);
INSERT INTO `systypes` VALUES (35,'Cost Update',22);
INSERT INTO `systypes` VALUES (36,'Exchange Difference',1);
INSERT INTO `systypes` VALUES (40,'Work Order',18);
INSERT INTO `systypes` VALUES (41,'Asset Addition',1);
INSERT INTO `systypes` VALUES (42,'Asset Category Change',1);
INSERT INTO `systypes` VALUES (43,'Delete w/down asset',1);
INSERT INTO `systypes` VALUES (44,'Depreciation',1);
INSERT INTO `systypes` VALUES (49,'Import Fixed Assets',1);
INSERT INTO `systypes` VALUES (50,'Opening Balance',0);
INSERT INTO `systypes` VALUES (500,'Auto Debtor Number',0);

--
-- Dumping data for table `tags`
--


--
-- Dumping data for table `taxauthorities`
--

INSERT INTO `taxauthorities` VALUES (1,'Australian GST',2300,2310,'','','','');
INSERT INTO `taxauthorities` VALUES (5,'Sales Tax',2300,2310,'','','','');
INSERT INTO `taxauthorities` VALUES (11,'Canadian GST',2300,2310,'','','','');
INSERT INTO `taxauthorities` VALUES (12,'Ontario PST',2300,2310,'','','','');
INSERT INTO `taxauthorities` VALUES (13,'UK VAT',2300,2310,'','','','');

--
-- Dumping data for table `taxauthrates`
--

INSERT INTO `taxauthrates` VALUES (1,1,1,0.1);
INSERT INTO `taxauthrates` VALUES (1,1,2,0);
INSERT INTO `taxauthrates` VALUES (1,1,5,0);
INSERT INTO `taxauthrates` VALUES (5,1,1,0.2);
INSERT INTO `taxauthrates` VALUES (5,1,2,0.35);
INSERT INTO `taxauthrates` VALUES (5,1,5,0);
INSERT INTO `taxauthrates` VALUES (11,1,1,0.07);
INSERT INTO `taxauthrates` VALUES (11,1,2,0.12);
INSERT INTO `taxauthrates` VALUES (11,1,5,0);
INSERT INTO `taxauthrates` VALUES (12,1,1,0.05);
INSERT INTO `taxauthrates` VALUES (12,1,2,0.075);
INSERT INTO `taxauthrates` VALUES (12,1,5,0.05);
INSERT INTO `taxauthrates` VALUES (13,1,1,0);
INSERT INTO `taxauthrates` VALUES (13,1,2,0);
INSERT INTO `taxauthrates` VALUES (13,1,5,0);

--
-- Dumping data for table `taxcategories`
--

INSERT INTO `taxcategories` VALUES (1,'Taxable supply');
INSERT INTO `taxcategories` VALUES (2,'Luxury Items');
INSERT INTO `taxcategories` VALUES (4,'Exempt');
INSERT INTO `taxcategories` VALUES (5,'Freight');

--
-- Dumping data for table `taxgroups`
--

INSERT INTO `taxgroups` VALUES (1,'Default');
INSERT INTO `taxgroups` VALUES (2,'Ontario');
INSERT INTO `taxgroups` VALUES (3,'UK Inland Revenue');

--
-- Dumping data for table `taxgrouptaxes`
--

INSERT INTO `taxgrouptaxes` VALUES (1,1,1,0);
INSERT INTO `taxgrouptaxes` VALUES (2,11,2,0);
INSERT INTO `taxgrouptaxes` VALUES (2,12,1,0);
INSERT INTO `taxgrouptaxes` VALUES (3,13,0,0);

--
-- Dumping data for table `taxprovinces`
--

INSERT INTO `taxprovinces` VALUES (1,'Default Tax province');

--
-- Dumping data for table `unitsofmeasure`
--

INSERT INTO `unitsofmeasure` VALUES (1,'each');
INSERT INTO `unitsofmeasure` VALUES (2,'meters');
INSERT INTO `unitsofmeasure` VALUES (3,'kgs');
INSERT INTO `unitsofmeasure` VALUES (4,'litres');
INSERT INTO `unitsofmeasure` VALUES (5,'length');

--
-- Dumping data for table `woitems`
--

INSERT INTO `woitems` VALUES (3,'DVD_ACTION',10,10,18.4,'');
INSERT INTO `woitems` VALUES (4,'SLICE',100,0,0,'');
INSERT INTO `woitems` VALUES (5,'BREAD',12,0,11.39,'');
INSERT INTO `woitems` VALUES (12,'BirthdayCakeConstruc',1,0,1145.4175,'');
INSERT INTO `woitems` VALUES (13,'BIGEARS12',1,0,3490,'');
INSERT INTO `woitems` VALUES (14,'DFS-20',1,0,188.225,'');
INSERT INTO `woitems` VALUES (15,'BIGEARS12',2,0,0,'');
INSERT INTO `woitems` VALUES (16,'HIT3042-4',12,0,0,'');
INSERT INTO `woitems` VALUES (17,'BIRTHDAYCAKECONSTRUC',1,0,0,'');
INSERT INTO `woitems` VALUES (18,'BirthdayCakeConstruc',2,0,0,'');

--
-- Dumping data for table `worequirements`
--

INSERT INTO `worequirements` VALUES (3,'DVD_ACTION','DVD-CASE',4,0.3,0);
INSERT INTO `worequirements` VALUES (3,'DVD_ACTION','DVD-DHWV',1,5.25,1);
INSERT INTO `worequirements` VALUES (3,'DVD_ACTION','DVD-LTWP',1,2.85,1);
INSERT INTO `worequirements` VALUES (3,'DVD_ACTION','DVD-UNSG',1,5,1);
INSERT INTO `worequirements` VALUES (3,'DVD_ACTION','DVD-UNSG2',1,5,1);
INSERT INTO `worequirements` VALUES (4,'SLICE','BREAD',0.1,0,1);
INSERT INTO `worequirements` VALUES (5,'BREAD','FLOUR',1.4,3.89,0);
INSERT INTO `worequirements` VALUES (5,'BREAD','SALT',0.025,2.5,1);
INSERT INTO `worequirements` VALUES (5,'BREAD','YEAST',0.1,5,0);
INSERT INTO `worequirements` VALUES (12,'BirthdayCakeConstruc','BREAD',1,6.0085,0);
INSERT INTO `worequirements` VALUES (12,'BirthdayCakeConstruc','DVD-CASE',1,0.3,0);
INSERT INTO `worequirements` VALUES (12,'BirthdayCakeConstruc','FLOUR',1,3.89,0);
INSERT INTO `worequirements` VALUES (12,'BirthdayCakeConstruc','SALT',1,2.5,0);
INSERT INTO `worequirements` VALUES (12,'BirthdayCakeConstruc','YEAST',1,5,0);
INSERT INTO `worequirements` VALUES (13,'BIGEARS12','DVD-CASE',1,0.3,0);
INSERT INTO `worequirements` VALUES (14,'DFS-20','DR_TUMMY',1,116.225,0);
INSERT INTO `worequirements` VALUES (14,'DFS-20','DVD-CASE',1,0.3,0);

--
-- Dumping data for table `workcentres`
--

INSERT INTO `workcentres` VALUES ('ASS','TOR','Assembly',1,'50',1,'0');
INSERT INTO `workcentres` VALUES ('MEL','MEL','Default for MEL',1,'0',1,'0');

--
-- Dumping data for table `workorders`
--

INSERT INTO `workorders` VALUES (3,'MEL','2007-06-13','2007-06-13',198,1);
INSERT INTO `workorders` VALUES (4,'MEL','2007-06-21','2007-06-21',0,0);
INSERT INTO `workorders` VALUES (5,'MEL','2007-06-21','2007-06-21',16.31,0);
INSERT INTO `workorders` VALUES (6,'MEL','2007-07-15','2007-07-15',0,0);
INSERT INTO `workorders` VALUES (7,'MEL','2008-07-26','2008-07-26',0,0);
INSERT INTO `workorders` VALUES (8,'MEL','2008-07-26','2008-07-26',0,0);
INSERT INTO `workorders` VALUES (9,'MEL','2009-02-04','2009-02-04',0,0);
INSERT INTO `workorders` VALUES (12,'TOR','2010-12-20','2010-08-14',40.34675,1);
INSERT INTO `workorders` VALUES (13,'TOR','2010-10-15','2010-08-14',0,0);
INSERT INTO `workorders` VALUES (14,'TOR','2011-07-16','2011-06-16',0,0);
INSERT INTO `workorders` VALUES (15,'MEL','2011-04-12','2011-06-17',0,0);
INSERT INTO `workorders` VALUES (16,'MEL','2011-06-23','2011-06-23',0,0);
INSERT INTO `workorders` VALUES (17,'MEL','2010-12-20','2011-06-28',0,0);
INSERT INTO `workorders` VALUES (18,'MEL','2011-09-04','2011-09-04',0,0);

--
-- Dumping data for table `woserialnos`
--


--
-- Dumping data for table `www_users`
--

INSERT INTO `www_users` VALUES ('admin','f0f77a7f88e7c1e93ab4e316b4574c7843b00ea4','Demonstration user','','','','','','MEL',8,'2011-11-03 21:53:27','','A4','1,1,1,1,1,1,1,1,1,1,',0,50,'gel','en_GB.utf8',0);
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-11-06 19:52:31
SET FOREIGN_KEY_CHECKS = 1;
