-- MySQL dump 10.15  Distrib 10.0.31-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: snorby
-- ------------------------------------------------------
-- Server version	10.3.0-MariaDB-10.3.0+maria~jessie

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
-- Table structure for table `agent_asset_names`
--

DROP TABLE IF EXISTS `agent_asset_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agent_asset_names` (
  `sensor_sid` int(10) unsigned NOT NULL,
  `asset_name_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sensor_sid`,`asset_name_id`),
  KEY `index_agent_asset_names_sensor` (`sensor_sid`),
  KEY `index_agent_asset_names_asset_name` (`asset_name_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent_asset_names`
--

LOCK TABLES `agent_asset_names` WRITE;
/*!40000 ALTER TABLE `agent_asset_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `agent_asset_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `aggregated_events`
--

DROP TABLE IF EXISTS `aggregated_events`;
/*!50001 DROP VIEW IF EXISTS `aggregated_events`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `aggregated_events` (
  `ip_src` tinyint NOT NULL,
  `ip_dst` tinyint NOT NULL,
  `signature` tinyint NOT NULL,
  `event_id` tinyint NOT NULL,
  `number_of_events` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `asset_names`
--

DROP TABLE IF EXISTS `asset_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_names` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` int(10) unsigned NOT NULL DEFAULT 0,
  `name` varchar(1024) NOT NULL,
  `global` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `index_asset_names_ip_address` (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_names`
--

LOCK TABLES `asset_names` WRITE;
/*!40000 ALTER TABLE `asset_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caches`
--

DROP TABLE IF EXISTS `caches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caches` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `ran_at` datetime DEFAULT NULL,
  `event_count` int(11) DEFAULT 0,
  `tcp_count` int(11) DEFAULT 0,
  `udp_count` int(11) DEFAULT 0,
  `icmp_count` int(11) DEFAULT 0,
  `severity_metrics` mediumtext DEFAULT NULL,
  `signature_metrics` mediumtext DEFAULT NULL,
  `src_ips` mediumtext DEFAULT NULL,
  `dst_ips` mediumtext DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_caches_ran_at` (`ran_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caches`
--

LOCK TABLES `caches` WRITE;
/*!40000 ALTER TABLE `caches` DISABLE KEYS */;
/*!40000 ALTER TABLE `caches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classifications`
--

DROP TABLE IF EXISTS `classifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `hotkey` int(11) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT 0,
  `events_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `index_classifications_id` (`id`),
  KEY `index_classifications_hotkey` (`hotkey`),
  KEY `index_classifications_locked` (`locked`),
  KEY `index_classifications_events_count` (`events_count`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classifications`
--

LOCK TABLES `classifications` WRITE;
/*!40000 ALTER TABLE `classifications` DISABLE KEYS */;
INSERT INTO `classifications` VALUES (1,'Unauthorized Root Access','Unauthorized Root Access',1,1,0),(2,'Unauthorized User Access','Unauthorized User Access',2,1,0),(3,'Attempted Unauthorized Access','Attempted Unauthorized Access',3,1,0),(4,'Denial of Service Attack','Denial of Service Attack',4,1,0),(5,'Policy Violation','Policy Violation',5,1,0),(6,'Reconnaissance','Reconnaissance',6,1,0),(7,'Virus Infection','Virus Infection',7,1,0),(8,'False Positive','False Positive',8,1,0);
/*!40000 ALTER TABLE `classifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `data_payload` text DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `index_data_sid` (`sid`),
  KEY `index_data_cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data`
--

LOCK TABLES `data` WRITE;
/*!40000 ALTER TABLE `data` DISABLE KEYS */;
/*!40000 ALTER TABLE `data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delayed_jobs`
--

DROP TABLE IF EXISTS `delayed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delayed_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `priority` int(11) DEFAULT 0,
  `attempts` int(11) DEFAULT 0,
  `handler` text DEFAULT NULL,
  `run_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `locked_by` text DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `last_error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_delayed_jobs_run_at_priority` (`priority`,`run_at`),
  KEY `index_delayed_jobs_locked_at` (`locked_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delayed_jobs`
--

LOCK TABLES `delayed_jobs` WRITE;
/*!40000 ALTER TABLE `delayed_jobs` DISABLE KEYS */;
INSERT INTO `delayed_jobs` VALUES (3,1,0,'--- !ruby/struct:Snorby::Jobs::SensorCacheJob \nverbose: false\n','2017-08-28 22:48:40',NULL,NULL,NULL,NULL),(4,1,0,'--- !ruby/struct:Snorby::Jobs::GeoipUpdatedbJob \nverbose: false\n','2017-09-04 22:38:41',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `delayed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detail` (
  `detail_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `detail_text` text DEFAULT NULL,
  PRIMARY KEY (`detail_type`),
  KEY `index_detail_detail_type` (`detail_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail`
--

LOCK TABLES `detail` WRITE;
/*!40000 ALTER TABLE `detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encoding`
--

DROP TABLE IF EXISTS `encoding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encoding` (
  `encoding_type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `encoding_text` text DEFAULT NULL,
  PRIMARY KEY (`encoding_type`),
  KEY `index_encoding_encoding_type` (`encoding_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encoding`
--

LOCK TABLES `encoding` WRITE;
/*!40000 ALTER TABLE `encoding` DISABLE KEYS */;
/*!40000 ALTER TABLE `encoding` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `signature` int(10) unsigned DEFAULT NULL,
  `classification_id` int(10) unsigned DEFAULT NULL,
  `users_count` int(10) unsigned DEFAULT 0,
  `user_id` int(10) unsigned DEFAULT NULL,
  `notes_count` int(10) unsigned DEFAULT 0,
  `type` int(10) unsigned DEFAULT 1,
  `number_of_events` int(10) unsigned DEFAULT 0,
  `timestamp` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sid`,`cid`),
  KEY `index_event_sid` (`sid`),
  KEY `index_event_cid` (`cid`),
  KEY `index_event_signature` (`signature`),
  KEY `index_event_classification_id` (`classification_id`),
  KEY `index_event_users_count` (`users_count`),
  KEY `index_event_user_id` (`user_id`),
  KEY `index_event_notes_count` (`notes_count`),
  KEY `index_timestamp_cid_sid` (`timestamp`,`cid`,`sid`),
  KEY `index_event_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `events_with_join`
--

DROP TABLE IF EXISTS `events_with_join`;
/*!50001 DROP VIEW IF EXISTS `events_with_join`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `events_with_join` (
  `sid` tinyint NOT NULL,
  `cid` tinyint NOT NULL,
  `signature` tinyint NOT NULL,
  `classification_id` tinyint NOT NULL,
  `users_count` tinyint NOT NULL,
  `user_id` tinyint NOT NULL,
  `notes_count` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `number_of_events` tinyint NOT NULL,
  `timestamp` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `ip_src` tinyint NOT NULL,
  `ip_dst` tinyint NOT NULL,
  `sig_priority` tinyint NOT NULL,
  `sig_name` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_favorites_id` (`id`),
  KEY `index_favorites_sid` (`sid`),
  KEY `index_favorites_cid` (`cid`),
  KEY `index_favorites_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icmphdr`
--

DROP TABLE IF EXISTS `icmphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icmphdr` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `icmp_type` int(10) unsigned DEFAULT NULL,
  `icmp_code` int(10) unsigned DEFAULT NULL,
  `icmp_csum` int(10) unsigned DEFAULT NULL,
  `icmp_id` int(10) unsigned DEFAULT NULL,
  `icmp_seq` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `index_icmphdr_sid` (`sid`),
  KEY `index_icmphdr_cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icmphdr`
--

LOCK TABLES `icmphdr` WRITE;
/*!40000 ALTER TABLE `icmphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `icmphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iphdr`
--

DROP TABLE IF EXISTS `iphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iphdr` (
  `sid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `ip_src` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_dst` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_ver` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_hlen` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_tos` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_len` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_flags` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_off` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_ttl` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_proto` int(10) unsigned NOT NULL DEFAULT 0,
  `ip_csum` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`sid`,`cid`),
  KEY `index_iphdr_sid` (`sid`),
  KEY `index_iphdr_cid` (`cid`),
  KEY `index_iphdr_ip_src` (`ip_src`),
  KEY `index_iphdr_ip_dst` (`ip_dst`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iphdr`
--

LOCK TABLES `iphdr` WRITE;
/*!40000 ALTER TABLE `iphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `iphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookups`
--

DROP TABLE IF EXISTS `lookups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookups`
--

LOCK TABLES `lookups` WRITE;
/*!40000 ALTER TABLE `lookups` DISABLE KEYS */;
/*!40000 ALTER TABLE `lookups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `body` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notes_sid` (`sid`),
  KEY `index_notes_cid` (`cid`),
  KEY `index_notes_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` text DEFAULT NULL,
  `sig_id` int(11) DEFAULT NULL,
  `ip_src` varchar(50) DEFAULT NULL,
  `ip_dst` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_ids` mediumtext DEFAULT NULL,
  `sensor_ids` mediumtext DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opt`
--

DROP TABLE IF EXISTS `opt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opt` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `optid` int(10) unsigned NOT NULL,
  `opt_proto` int(10) unsigned DEFAULT NULL,
  `opt_code` int(10) unsigned DEFAULT NULL,
  `opt_len` int(10) unsigned DEFAULT NULL,
  `opt_data` text DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`,`optid`),
  KEY `index_opt_sid` (`sid`),
  KEY `index_opt_cid` (`cid`),
  KEY `index_opt_optid` (`optid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opt`
--

LOCK TABLES `opt` WRITE;
/*!40000 ALTER TABLE `opt` DISABLE KEYS */;
/*!40000 ALTER TABLE `opt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference`
--

DROP TABLE IF EXISTS `reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference` (
  `ref_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_system_id` int(10) unsigned DEFAULT NULL,
  `ref_tag` text DEFAULT NULL,
  PRIMARY KEY (`ref_id`),
  KEY `index_reference_ref_id` (`ref_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference`
--

LOCK TABLES `reference` WRITE;
/*!40000 ALTER TABLE `reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reference_system`
--

DROP TABLE IF EXISTS `reference_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference_system` (
  `ref_system_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_system_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ref_system_id`),
  KEY `index_reference_system_ref_system_id` (`ref_system_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reference_system`
--

LOCK TABLES `reference_system` WRITE;
/*!40000 ALTER TABLE `reference_system` DISABLE KEYS */;
/*!40000 ALTER TABLE `reference_system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema`
--

DROP TABLE IF EXISTS `schema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vseq` int(10) unsigned DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_schema_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema`
--

LOCK TABLES `schema` WRITE;
/*!40000 ALTER TABLE `schema` DISABLE KEYS */;
INSERT INTO `schema` VALUES (1,107,'2017-08-28 22:38:14','Snorby 2.6.2');
/*!40000 ALTER TABLE `schema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search`
--

DROP TABLE IF EXISTS `search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `rule_count` int(11) DEFAULT 0,
  `public` tinyint(1) DEFAULT 0,
  `title` varchar(50) DEFAULT NULL,
  `search` mediumtext DEFAULT NULL,
  `checksum` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_search_user_id` (`user_id`),
  KEY `index_search_rule_count` (`rule_count`),
  KEY `index_search_public` (`public`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search`
--

LOCK TABLES `search` WRITE;
/*!40000 ALTER TABLE `search` DISABLE KEYS */;
/*!40000 ALTER TABLE `search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensor`
--

DROP TABLE IF EXISTS `sensor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT 'Click To Change Me',
  `hostname` text DEFAULT NULL,
  `interface` text DEFAULT NULL,
  `filter` text DEFAULT NULL,
  `detail` int(10) unsigned DEFAULT NULL,
  `encoding` int(10) unsigned DEFAULT NULL,
  `last_cid` int(10) unsigned DEFAULT NULL,
  `pending_delete` tinyint(1) DEFAULT 0,
  `updated_at` datetime DEFAULT NULL,
  `events_count` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`sid`),
  KEY `index_sensor_sid` (`sid`),
  KEY `index_sensor_detail` (`detail`),
  KEY `index_sensor_encoding` (`encoding`),
  KEY `index_sensor_last_cid` (`last_cid`),
  KEY `index_sensor_events_count` (`events_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensor`
--

LOCK TABLES `sensor` WRITE;
/*!40000 ALTER TABLE `sensor` DISABLE KEYS */;
/*!40000 ALTER TABLE `sensor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `name` varchar(50) NOT NULL,
  `value` mediumtext DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `index_settings_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('autodrop',NULL),('autodrop_count',NULL),('company','BAhJIg9Tbm9yYnkub3JnBjoGRUY=\n'),('daily','BAhpBg==\n'),('email','BAhJIhZzbm9yYnlAc25vcmJ5Lm9yZwY6BkVG\n'),('event_notifications','BAhpAA==\n'),('geoip','BAhpAA==\n'),('lookups','BAhpBg==\n'),('monthly','BAhpBg==\n'),('notes','BAhpBg==\n'),('packet_capture',NULL),('packet_capture_auto_auth','BAhpBg==\n'),('packet_capture_password',NULL),('packet_capture_type','BAhJIgxvcGVuZnBjBjoGRUY=\n'),('packet_capture_url',NULL),('packet_capture_user',NULL),('signature_lookup','BAhJIjdodHRwOi8vcm9vdGVkeW91ci5jb20vc25vcnRzaWQ/c2lkPSQkZ2lk\nJCQ6JCRzaWQkJAY6BkVG\n'),('update_notifications','BAhpAA==\n'),('utc','BAhpAA==\n'),('weekly','BAhpBg==\n');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `severities`
--

DROP TABLE IF EXISTS `severities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `severities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sig_id` int(10) unsigned DEFAULT NULL,
  `events_count` int(10) unsigned DEFAULT 0,
  `name` varchar(50) DEFAULT NULL,
  `text_color` varchar(50) DEFAULT '#ffffff',
  `bg_color` varchar(50) DEFAULT '#dddddd',
  PRIMARY KEY (`id`),
  KEY `index_severities_id` (`id`),
  KEY `index_severities_sig_id` (`sig_id`),
  KEY `index_severities_events_count` (`events_count`),
  KEY `index_severities_text_color` (`text_color`),
  KEY `index_severities_bg_color` (`bg_color`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `severities`
--

LOCK TABLES `severities` WRITE;
/*!40000 ALTER TABLE `severities` DISABLE KEYS */;
INSERT INTO `severities` VALUES (1,1,0,'High Severity','#ffffff','#ff0000'),(2,2,0,'Medium Severity','#ffffff','#fab908'),(3,3,0,'Low Severity','#ffffff','#3a781a');
/*!40000 ALTER TABLE `severities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sig_class`
--

DROP TABLE IF EXISTS `sig_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sig_class` (
  `sig_class_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sig_class_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sig_class_id`),
  KEY `index_sig_class_sig_class_id` (`sig_class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sig_class`
--

LOCK TABLES `sig_class` WRITE;
/*!40000 ALTER TABLE `sig_class` DISABLE KEYS */;
/*!40000 ALTER TABLE `sig_class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sig_reference`
--

DROP TABLE IF EXISTS `sig_reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sig_reference` (
  `sig_id` int(10) unsigned NOT NULL,
  `ref_seq` int(10) unsigned NOT NULL,
  `ref_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`sig_id`,`ref_seq`),
  KEY `index_sig_reference_sig_id` (`sig_id`),
  KEY `index_sig_reference_ref_seq` (`ref_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sig_reference`
--

LOCK TABLES `sig_reference` WRITE;
/*!40000 ALTER TABLE `sig_reference` DISABLE KEYS */;
/*!40000 ALTER TABLE `sig_reference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `signature`
--

DROP TABLE IF EXISTS `signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `signature` (
  `sig_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sig_class_id` int(10) unsigned DEFAULT NULL,
  `sig_name` text DEFAULT NULL,
  `sig_priority` int(10) unsigned DEFAULT NULL,
  `sig_rev` int(10) unsigned DEFAULT NULL,
  `sig_sid` int(10) unsigned DEFAULT NULL,
  `sig_gid` int(10) unsigned DEFAULT NULL,
  `events_count` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`sig_id`),
  KEY `index_signature_sig_id` (`sig_id`),
  KEY `index_signature_sig_class_id` (`sig_class_id`),
  KEY `index_signature_sig_priority` (`sig_priority`),
  KEY `index_signature_events_count` (`events_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `signature`
--

LOCK TABLES `signature` WRITE;
/*!40000 ALTER TABLE `signature` DISABLE KEYS */;
/*!40000 ALTER TABLE `signature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcphdr`
--

DROP TABLE IF EXISTS `tcphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcphdr` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `tcp_sport` int(10) unsigned DEFAULT NULL,
  `tcp_dport` int(10) unsigned DEFAULT NULL,
  `tcp_seq` int(10) unsigned DEFAULT NULL,
  `tcp_ack` int(10) unsigned DEFAULT NULL,
  `tcp_off` int(10) unsigned DEFAULT NULL,
  `tcp_res` int(10) unsigned DEFAULT NULL,
  `tcp_flags` int(10) unsigned DEFAULT NULL,
  `tcp_win` int(10) unsigned DEFAULT NULL,
  `tcp_csum` int(10) unsigned DEFAULT NULL,
  `tcp_urp` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `index_tcphdr_sid` (`sid`),
  KEY `index_tcphdr_cid` (`cid`),
  KEY `index_tcphdr_tcp_sport` (`tcp_sport`),
  KEY `index_tcphdr_tcp_dport` (`tcp_dport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcphdr`
--

LOCK TABLES `tcphdr` WRITE;
/*!40000 ALTER TABLE `tcphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `tcphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `udphdr`
--

DROP TABLE IF EXISTS `udphdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `udphdr` (
  `sid` int(10) unsigned NOT NULL,
  `cid` int(10) unsigned NOT NULL,
  `udp_sport` int(10) unsigned DEFAULT NULL,
  `udp_dport` int(10) unsigned DEFAULT NULL,
  `udp_len` int(10) unsigned DEFAULT NULL,
  `udp_csum` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`sid`,`cid`),
  KEY `index_udphdr_sid` (`sid`),
  KEY `index_udphdr_cid` (`cid`),
  KEY `index_udphdr_udp_sport` (`udp_sport`),
  KEY `index_udphdr_udp_dport` (`udp_dport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `udphdr`
--

LOCK TABLES `udphdr` WRITE;
/*!40000 ALTER TABLE `udphdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `udphdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(128) NOT NULL DEFAULT '',
  `remember_token` varchar(255) DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `reset_password_token` varchar(255) DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT 0,
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `favorites_count` int(11) DEFAULT 0,
  `accept_notes` int(11) DEFAULT 1,
  `notes_count` int(11) DEFAULT 0,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `per_page_count` int(11) DEFAULT 45,
  `name` varchar(50) DEFAULT NULL,
  `timezone` varchar(50) DEFAULT 'UTC',
  `admin` tinyint(1) DEFAULT 0,
  `enabled` tinyint(1) DEFAULT 1,
  `gravatar` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `online` tinyint(1) DEFAULT 0,
  `last_daily_report_at` datetime DEFAULT '2017-08-28 22:38:12',
  `last_weekly_report_at` int(11) DEFAULT 201735,
  `last_monthly_report_at` int(11) DEFAULT 201708,
  `last_email_report_at` datetime DEFAULT NULL,
  `email_reports` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `index_users_favorites_count` (`favorites_count`),
  KEY `index_users_notes_count` (`notes_count`),
  KEY `index_users_id` (`id`),
  KEY `index_users_per_page_count` (`per_page_count`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('snorby@snorby.org','$2a$10$tRBNiMf6e0kPOseUJeSXjudfTqCkqQ7WKR.wkT7d4t9QgRFpjdSRu',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0,1,0,1,45,'Administrator','UTC',1,1,1,'2017-08-28 22:38:15','2017-08-28 22:38:15',0,'2017-08-28 22:38:12',201735,201708,NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `aggregated_events`
--

/*!50001 DROP TABLE IF EXISTS `aggregated_events`*/;
/*!50001 DROP VIEW IF EXISTS `aggregated_events`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`snort`@`172.18.0.2` SQL SECURITY DEFINER */
/*!50001 VIEW `aggregated_events` AS select `iphdr`.`ip_src` AS `ip_src`,`iphdr`.`ip_dst` AS `ip_dst`,`event`.`signature` AS `signature`,max(`event`.`id`) AS `event_id`,count(0) AS `number_of_events` from (`event` join `iphdr` on(`event`.`sid` = `iphdr`.`sid` and `event`.`cid` = `iphdr`.`cid`)) where `event`.`classification_id` is null group by `iphdr`.`ip_src`,`iphdr`.`ip_dst`,`event`.`signature` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `events_with_join`
--

/*!50001 DROP TABLE IF EXISTS `events_with_join`*/;
/*!50001 DROP VIEW IF EXISTS `events_with_join`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`snort`@`172.18.0.2` SQL SECURITY DEFINER */
/*!50001 VIEW `events_with_join` AS select `event`.`sid` AS `sid`,`event`.`cid` AS `cid`,`event`.`signature` AS `signature`,`event`.`classification_id` AS `classification_id`,`event`.`users_count` AS `users_count`,`event`.`user_id` AS `user_id`,`event`.`notes_count` AS `notes_count`,`event`.`type` AS `type`,`event`.`number_of_events` AS `number_of_events`,`event`.`timestamp` AS `timestamp`,`event`.`id` AS `id`,`iphdr`.`ip_src` AS `ip_src`,`iphdr`.`ip_dst` AS `ip_dst`,`signature`.`sig_priority` AS `sig_priority`,`signature`.`sig_name` AS `sig_name` from ((`event` join `iphdr` on(`event`.`sid` = `iphdr`.`sid` and `event`.`cid` = `iphdr`.`cid`)) join `signature` on(`event`.`signature` = `signature`.`sig_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-29  0:39:23