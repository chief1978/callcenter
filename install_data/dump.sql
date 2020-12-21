-- MySQL dump 10.14  Distrib 5.5.64-MariaDB, for Linux (x86_64)
--
-- Host: 10.10.0.171    Database: asterisk
-- ------------------------------------------------------
-- Server version	10.4.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cdr`
--

DROP TABLE IF EXISTS `cdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cdr` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `calldate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `clid` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `src` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `dst` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `dcontext` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `lastapp` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `lastdata` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `duration` float unsigned DEFAULT NULL,
  `billsec` float unsigned DEFAULT NULL,
  `disposition` enum('ANSWERED','BUSY','FAILED','NO ANSWER','CONGESTION') COLLATE utf8_unicode_ci DEFAULT NULL,
  `channel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dstchannel` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amaflags` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accountcode` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uniqueid` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `userfield` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `did` varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `answer` datetime NOT NULL,
  `end` datetime NOT NULL,
  `recordingfile` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `val` TINYINT NOT NULL DEFAULT 0,
  `ivr_choose` int(11) NOT NULL DEFAULT 0,
  `ivr_quit` datetime DEFAULT NULL,
  `ivr_chk_quantity` int(11) NOT NULL DEFAULT 0,
  `ivr_chk_numbers` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ivr_status` varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `calldate` (`calldate`),
  KEY `dst` (`dst`),
  KEY `src` (`src`),
  KEY `dcontext` (`dcontext`),
  KEY `clid` (`clid`)
) ENGINE=InnoDB AUTO_INCREMENT=75579 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cel`
--

DROP TABLE IF EXISTS `cel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cel` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `eventtype` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `eventtime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `userdeftype` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cid_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `cid_num` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `cid_ani` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `cid_rdnis` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `cid_dnid` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `exten` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `context` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `channame` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `appname` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `appdata` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `amaflags` int(11) NOT NULL,
  `accountcode` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `peeraccount` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `uniqueid` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `linkedid` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `userfield` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `peer` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=708484 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_log`
--

DROP TABLE IF EXISTS `queue_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue_log` (
  `time` varchar(32) DEFAULT NULL,
  `callid` char(64) DEFAULT NULL,
  `queuename` char(64) DEFAULT NULL,
  `agent` char(64) DEFAULT NULL,
  `event` char(32) DEFAULT NULL,
  `data` char(64) DEFAULT NULL,
  `data1` char(64) DEFAULT NULL,
  `data2` char(64) DEFAULT NULL,
  `data3` char(64) DEFAULT NULL,
  `data4` char(64) DEFAULT NULL,
  `data5` char(64) DEFAULT NULL,
  KEY `time` (`time`),
  KEY `callid` (`callid`),
  KEY `event` (`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-24 19:52:50
