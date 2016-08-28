-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2016 at 11:46 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `peadiatric_hospital`
--
CREATE DATABASE IF NOT EXISTS `hospital` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `hospital`;

-- --------------------------------------------------------

--
-- Table structure for table `chemist`
--

DROP TABLE IF EXISTS `chemist`;

CREATE TABLE `chemist` (
  `medication_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `diagnosis_id` int(11) NOT NULL,
  `prescription` varchar(250) NOT NULL,
  `requested_date` date NOT NULL,
  `requested_time` time NOT NULL,
  `issued_date` date DEFAULT NULL,
  `issued_time` time DEFAULT NULL,
  PRIMARY KEY (`medication_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chemist`
--

INSERT INTO `chemist` VALUES (5,2,'300ml coldpol and 50 tablets of capsuline','2016-01-31','23:08:20','2016-02-01','00:46:42'),(6,1,'100 tablets of diclofenac','2016-01-31','23:09:57','2016-02-01','00:45:59'),(7,6,'5 tablets of metakelfin','2016-02-01','10:27:02','2016-02-01','10:55:30'),(8,5,'500ml typhoid syrup','2016-02-01','10:28:25','2016-02-01','10:57:15'),(9,3,'typhoid syrup 300ml','2016-02-01','10:46:06','2016-02-01','10:54:58'),(10,9,'500ml coldpol and 100 yellow fever tablets','2016-02-01','10:53:49','2016-02-02','12:38:09'),(11,13,'200 typhealia tablets','2016-02-02','12:33:46','2016-02-02','12:38:05'),(12,15,'50 antimalaria tablets','2016-02-02','12:34:29','2016-02-02','12:38:03'),(13,4,'150 typhelia tablets','2016-02-02','12:35:15','2016-03-30','22:05:51'),(14,8,'malariamellis 300gms','2016-03-30','23:39:43','2016-03-30','23:40:35'),(15,7,'100 typhoid tablets','2016-04-06','13:41:42','2016-04-06','13:44:58'),(16,14,'typhealis 300mg','2016-04-25','17:33:59',NULL,NULL);

--
-- Table structure for table `clinic_info`
--

DROP TABLE IF EXISTS `clinic_info`;

CREATE TABLE `clinic_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `child_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `temperature` int(11) NOT NULL,
  `blood_pressure` varchar(10) NOT NULL,
  `height` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `clinic_info`
--

INSERT INTO `clinic_info` VALUES (2,6,'2016-01-31','12:32:44',40,'25/74',14,20),(3,8,'2016-01-31','12:34:52',40,'45/40',14,14),(4,8,'2016-01-31','12:38:07',35,'62/41',10,21),(5,11,'2016-01-31','12:39:11',32,'74/24',14,21),(6,15,'2016-01-31','13:27:13',35,'75/45',14,20),(7,17,'2016-01-31','13:28:14',25,'41/41',41,21),(8,19,'2016-01-31','13:36:13',25,'41/41',10,12),(9,32,'2016-01-31','13:37:15',29,'52/65',18,12),(10,23,'2016-01-31','13:37:38',32,'36/65',12,12),(11,20,'2016-01-31','13:38:42',36,'85/52',21,21),(12,22,'2016-02-01','09:48:08',40,'41/41',21,40),(13,8,'2016-02-01','09:55:47',32,'45/95',41,20),(14,24,'2016-02-01','09:56:09',12,'52/85',32,81),(15,27,'2016-02-01','09:56:36',45,'95/25',12,14),(16,15,'2016-02-01','09:57:07',25,'21/36',32,10),(17,34,'2016-02-01','09:57:29',36,'56/98',74,14),(18,16,'2016-02-02','12:28:03',85,'14/87',41,21),(19,25,'2016-02-02','12:28:33',32,'45/98',74,45),(20,28,'2016-02-02','12:29:02',98,'32/45',74,12),(21,31,'2016-02-02','12:29:22',32,'85/87',21,78),(22,33,'2016-02-02','12:30:52',14,'13/98',21,65),(23,26,'2016-03-31','12:39:46',36,'74/54',32,45),(24,34,'2016-04-06','13:36:27',35,'47/25',14,54);

--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;

CREATE TABLE `diagnosis` (
  `diagnosis_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `test_id` int(11) DEFAULT NULL,
  `child_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `diagnosis` varchar(20) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `waiting_status` varchar(10) NOT NULL,
  PRIMARY KEY (`diagnosis_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `diagnosis`
--

INSERT INTO `diagnosis` VALUES (1,6,19,'2016-01-31','23:09:57','Malaria','diagnosed with malaria and early symptoms of typhoid','served'),(2,0,32,'2016-01-31','23:08:20','Typhoid','diagnosed with typhoid and high temperatures','served'),(3,7,23,'2016-02-01','10:46:06','Typhoid','early signs of typhoid','served'),(4,8,20,'2016-02-02','12:35:15','Typhoid','diagnosed with typhoid','served'),(5,NULL,22,'2016-02-01','10:28:25','Typhoid','diagnosed with typhoid','served'),(6,NULL,8,'2016-02-01','10:27:02','Malaria','diagnosed with malaria','served'),(7,9,24,'2016-04-06','13:41:42','Typhoid','diagnosed with typhoid','served'),(8,10,27,'2016-03-30','23:39:43','Malaria','diagnosed with malaria','served'),(9,NULL,15,'2016-02-01','10:53:49','Yellow fever','diagnosed with yellow fever and high temperature','served'),(10,11,34,NULL,NULL,NULL,NULL,'lab'),(11,12,16,NULL,NULL,NULL,NULL,'lab'),(12,13,25,NULL,NULL,NULL,NULL,'temp'),(13,NULL,28,'2016-02-02','12:33:46','Head worms','diagnosed with worms in head','served'),(14,14,31,'2016-04-25','17:33:59','Typhoid','diagnosed with malaria','chemist'),(15,NULL,33,'2016-02-02','12:34:29','Malaria','diagnosed with malaria','served'),(16,NULL,26,NULL,NULL,NULL,NULL,'nurse');

--
-- Table structure for table `lab`
--

DROP TABLE IF EXISTS `lab`;

CREATE TABLE `lab` (
  `test_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `child_id` int(11) NOT NULL,
  `test_type` varchar(20) NOT NULL,
  `requested_date` date NOT NULL,
  `requested_time` time NOT NULL,
  `results` varchar(100) DEFAULT NULL,
  `completed_date` date DEFAULT NULL,
  `completed_time` time DEFAULT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lab`
--

INSERT INTO `lab` VALUES (6,19,'urine and blood','2016-01-31','14:47:27','malaria found in blood and worms present in urine','0000-00-00','00:00:00'),(7,23,'stool and blood','2016-01-31','14:48:12','worms found in stool and presence of tb in blood','0000-00-00','00:00:00'),(8,20,'urine and blood','2016-02-01','10:03:15','microbacteria found in stool and blood','2016-02-01','10:41:44'),(9,24,'stool','2016-02-01','10:28:42','typhoid present','2016-02-01','10:42:21'),(10,27,'blood','2016-02-01','10:28:50','malaria found','2016-02-02','12:36:09'),(11,34,'blood','2016-02-02','12:32:38','typhoid and yellow fever present','2016-02-02','12:36:35'),(12,16,'stool','2016-02-02','12:32:52','cholera found','2016-03-31','00:17:28'),(13,25,'urine and stool','2016-03-30','23:33:04','empty',NULL,NULL),(14,31,'urine test','2016-04-06','10:37:11','positive, cholera found','2016-04-06','10:38:51'),(15,34,'stool','2016-04-06','13:40:40','cholera found','2016-04-06','13:43:54');

--
-- Table structure for table `login_log`
--

DROP TABLE IF EXISTS `login_log`;

CREATE TABLE `login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login_log`
--

INSERT INTO `login_log` VALUES (1,'rc_ekamau','2015-11-24','15:24:25'),(2,'rc_tmagodi','2015-11-25','09:39:12'),(3,'rc_tmagodi','2015-11-25','12:07:56'),(4,'rc_tmagodi','2015-11-25','12:10:06'),(5,'rc_tmagodi','2015-11-25','12:12:09'),(6,'cm_kgitau','2015-12-02','11:21:55'),(7,'cm_kgitau','2015-12-02','11:32:49'),(8,'ns_jonyach','2015-12-02','12:03:06'),(9,'lb_mkatele','2015-12-28','10:28:21'),(10,'lb_mkatele','2015-12-28','10:45:53'),(11,'lb_tlukwama','2016-01-14','11:53:32'),(12,'cm_kgitau','2016-01-15','11:35:31'),(13,'cm_kgitau','2016-01-27','17:54:20'),(14,'cm_kgitau','2016-01-27','17:56:14'),(15,'cm_kgitau','2016-01-27','17:58:04'),(16,'cm_kgitau','2016-01-27','17:59:08'),(17,'cm_kgitau','2016-01-27','18:00:32'),(18,'cm_kgitau','2016-01-27','18:17:10'),(19,'cm_kgitau','2016-01-27','18:17:16'),(20,'cm_kgitau','2016-01-27','18:20:01'),(21,'cm_kgitau','2016-01-27','18:27:32'),(22,'cm_kgitau','2016-01-27','18:30:19'),(23,'cm_kgitau','2016-01-27','18:30:41'),(24,'cm_kgitau','2016-01-27','18:32:12'),(25,'cm_kgitau','2016-01-27','18:32:34'),(26,'lb_mkatele','2016-01-28','09:09:58'),(27,'rc_ekamau','2016-01-28','09:10:58'),(28,'ns_rsoki','2016-01-28','09:13:11'),(29,'dr_kkimeo','2016-01-28','09:15:04'),(30,'cm_mtinje','2016-01-28','09:16:50'),(32,'rc_ekamau','2016-01-29','16:08:10'),(33,'ns_jonyach','2016-01-29','17:36:10'),(34,'dr_mnduchi','2016-01-31','13:29:09'),(35,'ns_jonyach','2016-01-31','13:35:54'),(36,'dr_mnduchi','2016-01-31','13:39:41'),(37,'lb_tlukwama','2016-01-31','14:51:25'),(38,'dr_mnduchi','2016-01-31','15:23:35'),(39,'cm_mtinje','2016-01-31','23:13:23'),(40,'cm_mtinje','2016-02-01','00:31:23'),(41,'rc_ekamau','2016-02-01','09:41:02'),(42,'ns_jonyach','2016-02-01','09:43:13'),(43,'dr_kkimeo','2016-02-01','09:58:01'),(44,'lb_mkatele','2016-02-01','10:30:21'),(45,'dr_kkimeo','2016-02-01','10:44:33'),(46,'cm_kgitau','2016-02-01','10:54:51'),(56,'cm_kgitau','2016-03-30','18:15:35'),(57,'cm_kgitau','2016-03-30','18:48:51'),(58,'rc_ekamau','2016-03-31','08:52:02'),(59,'ns_jonyach','2016-03-31','09:25:14'),(60,'ns_jonyach','2016-04-06','10:31:59'),(61,'dr_mnduchi','2016-04-06','10:35:36'),(62,'lb_mkatele','2016-04-06','10:37:38'),(63,'lb_mkatele','2016-04-06','10:37:48'),(64,'lb_mkatele','2016-04-06','10:37:56'),(65,'dr_mnduchi','2016-04-06','10:39:16'),(66,'ns_jonyach','2016-04-06','10:42:31'),(67,'rc_ekamau','2016-04-06','13:32:58'),(68,'ns_rsoki','2016-04-06','13:35:33'),(69,'dr_mnduchi','2016-04-06','13:39:55'),(70,'lb_mkatele','2016-04-06','13:43:07'),(71,'dr_mnduchi','2016-04-06','13:44:16'),(72,'cm_mtinje','2016-04-06','13:44:48'),(73,'dr_kkimeo','2016-04-09','23:06:51'),(74,'lb_mkatele','2016-04-10','19:06:43'),(75,'lb_mkatele','2016-04-10','19:12:50'),(76,'lb_mkatele','2016-04-10','19:18:53'),(77,'lb_mkatele','2016-04-10','19:21:12'),(78,'lb_mkatele','2016-04-10','19:23:36'),(79,'lb_mkatele','2016-04-10','19:24:56'),(80,'lb_mkatele','2016-04-10','19:26:16'),(81,'rc_ekamau','2016-04-11','07:32:52'),(82,'ns_rsoki','2016-04-11','08:09:14'),(83,'lb_tlukwama','2016-04-11','08:13:46'),(84,'dr_mnduchi','2016-04-11','08:24:26'),(85,'lb_mkatele','2016-04-11','08:30:25'),(86,'ns_rsoki','2016-04-11','08:33:52'),(87,'cm_mtinje','2016-04-11','08:37:17'),(88,'dr_kkimeo','2016-04-11','08:50:05'),(89,'dr_kkimeo','2016-04-11','08:52:31'),(90,'dr_kkimeo','2016-04-11','10:39:00'),(91,'admin_slalo','2016-04-11','13:19:46'),(92,'admin_kmwangi','2016-04-11','17:01:25'),(93,'dr_kkimeo','2016-04-12','09:43:47'),(94,'admin_slalo','2016-04-12','20:18:04'),(95,'admin_kmwangi','2016-04-13','11:56:51'),(96,'admin_kmwangi','2016-04-14','09:27:04'),(97,'admin_slalo','2016-04-14','22:36:24'),(98,'admin_slalo','2016-04-15','19:50:53'),(99,'admin_slalo','2016-04-20','10:11:31'),(100,'rc_ekamau','2016-04-20','14:15:11'),(101,'dr_mnduchi','2016-04-20','14:16:50'),(102,'ns_jonyach','2016-04-20','14:18:04'),(103,'admin_kmwangi','2016-04-20','14:19:49'),(104,'admin_kmwangi','2016-04-25','02:23:27'),(105,'dr_kkimeo','2016-04-25','02:24:42'),(106,'dr_kkimeo','2016-04-25','13:12:32'),(107,'admin_slalo','2016-04-25','13:14:53'),(108,'rc_tmagodi','2016-04-25','16:59:09'),(109,'ns_rsoki','2016-04-25','17:05:16'),(110,'lb_tlukwama','2016-04-25','17:09:22'),(111,'dr_mnduchi','2016-04-25','17:11:30'),(112,'cm_kgitau','2016-04-25','17:32:31'),(113,'dr_kkimeo','2016-04-25','17:33:11'),(114,'cm_kgitau','2016-04-25','17:34:29'),(115,'admin_slalo','2016-04-25','17:37:38');

--
-- Table structure for table `patient_visit_log`
--

DROP TABLE IF EXISTS `patient_visit_log`;

CREATE TABLE `patient_visit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `child_id` int(11) NOT NULL,
  `visit_date` date NOT NULL,
  `visit_time` time NOT NULL,
  `purpose` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_visit_log`
--

INSERT INTO `patient_visit_log` VALUES (1,13,'2016-01-28','09:11:57','vaccine'),(2,14,'2016-01-28','09:11:58','vaccine'),(3,6,'2016-01-29','16:25:12','vaccine'),(4,6,'2016-01-29','16:25:12','clinic'),(5,8,'2016-01-29','16:32:07','clinic'),(6,8,'2016-01-29','16:32:07','clinic'),(7,11,'2016-01-29','16:33:23','clinic'),(8,11,'2016-01-29','16:33:23','vaccine'),(9,15,'2016-01-29','16:45:56','clinic'),(10,17,'2016-01-29','16:53:18','clinic'),(11,19,'2016-01-29','16:56:11','clinic'),(12,20,'2016-01-29','16:56:11','clinic'),(13,21,'2016-01-29','16:56:37','vaccine'),(14,22,'2016-01-29','16:56:37','clinic'),(15,23,'2016-01-29','17:00:24','clinic'),(16,24,'2016-01-29','17:00:24','clinic'),(17,25,'2016-01-29','17:00:42','clinic'),(18,26,'2016-01-29','17:00:42','clinic'),(19,27,'2016-01-29','17:02:47','clinic'),(20,28,'2016-01-29','17:02:48','clinic'),(21,29,'2016-01-29','17:06:46','vaccine'),(22,30,'2016-01-29','17:13:41','vaccine'),(23,31,'2016-01-29','17:15:34','clinic'),(24,32,'2016-01-29','17:19:32','clinic'),(25,8,'2016-01-29','17:29:32','clinic'),(26,26,'2016-01-29','17:34:11','vaccine'),(27,33,'2016-01-29','17:35:07','clinic'),(28,15,'2016-02-01','09:41:12','clinic'),(29,34,'2016-02-01','09:42:31','clinic'),(30,34,'2016-02-02','10:16:18','vaccine'),(31,34,'2016-02-02','10:16:18','clinic'),(32,33,'2016-02-02','10:16:28','vaccine'),(33,33,'2016-02-02','10:16:28','new'),(34,8,'2016-02-02','10:24:24','new'),(35,8,'2016-02-02','10:24:24','new'),(36,35,'2016-02-02','10:31:02','new'),(37,36,'2016-02-02','10:31:02','new'),(38,22,'2016-02-02','10:38:45','new'),(39,22,'2016-02-02','10:38:45','new'),(40,12,'2016-02-02','10:57:13','new'),(41,12,'2016-02-02','10:57:13','new'),(42,16,'2016-02-02','11:13:33','new'),(43,16,'2016-02-02','11:13:33','new'),(44,13,'2016-02-02','11:19:39','new'),(45,13,'2016-02-02','11:19:39','new'),(46,9,'2016-02-02','11:25:03','new'),(47,9,'2016-02-02','11:25:03','new'),(48,5,'2016-02-02','11:29:22','new'),(49,5,'2016-02-02','11:29:22','new'),(50,8,'2016-02-02','11:33:45','new'),(51,8,'2016-02-02','11:33:45','new'),(52,23,'2016-02-02','11:35:57','new'),(53,23,'2016-02-02','11:35:57','new'),(54,9,'2016-02-02','11:36:46','new'),(55,11,'2016-02-02','11:39:45','new'),(56,16,'2016-02-02','11:42:38','clinic'),(57,32,'2016-02-02','11:54:10','new'),(58,23,'2016-02-02','11:56:48','new'),(59,31,'2016-02-02','12:24:49','new'),(60,11,'2016-02-02','12:26:58','new'),(61,22,'2016-02-02','12:52:14','new'),(62,37,'2016-02-02','12:53:01','new'),(63,12,'2016-03-31','08:40:30','new'),(64,34,'2016-03-31','08:52:31','new'),(65,38,'2016-03-31','09:05:46','new'),(66,16,'2016-04-06','13:33:22','new'),(67,39,'2016-04-06','13:34:59','new'),(68,14,'2016-04-20','14:15:45','new');

--
-- Table structure for table `personal_info`
--

DROP TABLE IF EXISTS `personal_info`;

CREATE TABLE `personal_info` (
  `child_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) NOT NULL,
  `second_name` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(6) NOT NULL,
  `guardian_first_name` varchar(20) NOT NULL,
  `guardian_surname` varchar(20) NOT NULL,
  `date_recieved` date NOT NULL,
  `time_recieved` time NOT NULL,
  PRIMARY KEY (`child_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personal_info`
--

INSERT INTO `personal_info` VALUES (1,'kaimenyi','mike','simiyu','2000-10-15','Male','beatrice','kaimenyi','2015-11-24','15:30:28'),(3,'kaimenyi','mike','simiyu','2000-10-15','Male','beatrice','kaimenyi','2015-11-24','15:32:09'),(4,'kaimenyi','mike','simiyu','2000-10-15','Male','gitonga','kaimenyi','2015-11-24','16:15:51'),(5,'kaimenyi','mike','simiyu','2000-10-15','Male','gitonga','kaimenyi','2015-11-24','16:16:47'),(6,'kaimenyi','mike','simiyu','2000-10-15','Male','beatrice','mike','2015-11-24','16:25:04'),(7,'kevin','kiatambi','sariuki','2001-12-10','Male','sariuki','chulaimbo','2015-11-25','09:20:23'),(8,'kevin','kiatambi','sariuki','2001-12-10','Male','sariuki','chulaimbo','2015-11-25','09:20:23'),(9,'kevin','kiatambi','sariuki','2000-10-15','Male','sariuki','chulaimbo','2015-11-25','09:20:33'),(10,'Magodi','Kamau','Kimaiu','2001-10-14','Male','Mikai','karioki','2015-11-25','09:41:18'),(11,'gitau','Kamau','simiyu','2002-09-21','Male','gitonga','chulaimbo','2015-11-25','09:45:50'),(12,'Kamau','Kiilu','Jacinta','2005-04-13','Male','Katembo','Suuri','2015-11-25','10:05:32'),(13,'Gitonga','Charles','Kamau','2005-04-13','Male','Stacy','Kamau','2016-01-28','09:11:57'),(14,'Gitonga','Charles','Kamau','2005-04-13','Male','Stacy','Kamau','2016-01-28','09:11:58'),(15,'Karanja','Gitosh','Simiyu','2010-09-21','Male','Kiilu','Katembo','2016-01-29','16:45:56'),(16,'Karanja','Gitosh','Simiyu','2010-09-21','Male','Kiilu','Katembo','2016-01-29','16:45:56'),(17,'Hamso','Lule','Kitambo','2012-01-20','Female','Kitambo','Hassan','2016-01-29','16:53:18'),(18,'Hamso','Lule','Kitambo','2012-01-20','Female','Kitambo','Hassan','2016-01-29','16:53:18'),(19,'Hamso','Lule','Kitambo','2012-01-20','Female','Kitambo','Hassan','2016-01-29','16:56:11'),(20,'Hamso','Lule','Kitambo','2012-01-20','Female','Kitambo','Hassan','2016-01-29','16:56:11'),(21,'Hamso','Lule','Kitambo','2012-01-20','Female','Kitambo','Hassan','2016-01-29','16:56:37'),(22,'Hamso','Lule','Kitambo','2012-01-20','Female','Kitambo','Hassan','2016-01-29','16:56:37'),(23,'Kasie','Aise','Lili','2014-10-07','Male','Hamri','Leta','2016-01-29','17:00:24'),(24,'Kasie','Aise','Lili','2014-10-07','Male','Hamri','Leta','2016-01-29','17:00:24'),(25,'Kasie','Aise','Lili','2014-10-07','Male','Hamri','Leta','2016-01-29','17:00:42'),(26,'Kasie','Aise','Lili','2014-10-07','Male','Hamri','Leta','2016-01-29','17:00:42'),(27,'Lili','Eloa','Iksa','2015-07-05','Male','Huyu','Yulw','2016-01-29','17:02:47'),(28,'Lili','Eloa','Iksa','2015-07-05','Male','Huyu','Yulw','2016-01-29','17:02:47'),(29,'Juja','Luljy','Jambo','2014-10-07','Female','Sera','Meera','2016-01-29','17:06:46'),(30,'Jujlo','Huyew','Hnlw','2012-01-20','Male','Killo','Huri','2016-01-29','17:13:41'),(31,'Hinu','Aghe','Lilo','2010-09-21','Female','Jilo','Likoni','2016-01-29','17:15:34'),(32,'Hello','Hello','Hello','2012-01-20','Female','Hello','Hello','2016-01-29','17:19:32'),(33,'Yule','Alikua','Pale','2011-11-24','Female','Sasa','Yeye','2016-01-29','17:35:07'),(34,'Gitonga','Lule','Shimosh','2013-04-15','Female','Alwala','Nyabundi','2016-02-01','09:42:31'),(35,'Kamau','Kansiime','Kitembo','2014-06-12','Female','Kariuki','Mugitha','2016-02-02','10:31:02'),(37,'Hamso','Sakina','Serume','2013-07-25','Male','Sallala','Taringi','2016-02-02','12:53:01'),(38,'Simiyu','Aliko','Okkora','2014-10-21','Male','Kirubi','Muhombe','2016-03-31','09:05:46'),(39,'Simiyu','Ali','Kevin','2012-01-20','Male','John','Kamau','2016-04-06','13:34:59');

--
-- Table structure for table `staff_info`
--

DROP TABLE IF EXISTS `staff_info`;

CREATE TABLE `staff_info` (
  `firstname` varchar(40) NOT NULL,
  `secondname` varchar(40) NOT NULL,
  `surname` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `role` varchar(20) NOT NULL,
  `phone` int(11) NOT NULL,
  `gender` varchar(6) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff_info`
--

INSERT INTO `staff_info` VALUES ('Karissa','Kalilu','Mwangi','admin_kmwangi','admin',784325486,'Male','karissakmwangi80'),('Satina','Tamara','Lalo','admin_slalo','admin',745368975,'Female','satinatlalo87'),('Kariuki','Gitau','Gitau','cm_kgitau','chemist',728507402,'Male','gitaugkariuki80'),('Mutiso','Musyoka','Tinje','cm_mtinje','chemist',784365215,'Male','mutisotmusyoka84'),('Kisau','Albert','Kimeo','dr_kkimeo','doctor',785123852,'Male','kisalberkim78'),('Mwakipitau','John','Nduchi','dr_mnduchi','doctor',724546817,'Male','mwakijohnnduchi84'),('Muriuki','Syokimau','Katele','lb_mkatele','lab',717987321,'Male','muriukiskatele85'),('Tamara','Kabuki','Lukwama','lb_tlukwama','lab',731249613,'Female','tamaralkabuki91'),('Jane','Onsirike','Onyach','ns_jonyach','nurse',736854162,'Female','onsirikeonyach91'),('Rita','Mtambara','Soki','ns_rsoki','nurse',719874698,'Female','ritasokim90'),('Emma','Nyatich','Kamau','rc_ekamau','receptionist',715231001,'Female','nyatichekamau86'),('Taabu','Alweiso','Magodi','rc_tmagodi','receptionist',778956215,'Female','alweisomtaabu88');

--
-- Table structure for table `vaccination`
--

DROP TABLE IF EXISTS `vaccination`;

CREATE TABLE `vaccination` (
  `vaccine_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `child_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `purpose` varchar(20) NOT NULL,
  `completion` date NOT NULL,
  `consumption` varchar(40) NOT NULL,
  PRIMARY KEY (`vaccine_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vaccination`
--

INSERT INTO `vaccination` VALUES (3,13,'polio','polio','2016-07-30','weekly'),(4,13,'measles','measles','2016-07-30','monthly'),(5,13,'growth','growth','2016-05-30','weekly'),(6,14,'Polio','Polio','2016-05-30','every 2 months'),(7,14,'Marasmus','Marasmus','2016-02-20','every 4 months'),(8,14,'Cancer','Cancer','2016-07-30','monthly'),(9,14,'Measles','Measles','2016-03-30','every 3 months'),(10,6,'Polio','Polio','2016-02-14','every 2 months'),(11,6,'Diarrhea','Diarrhea','2016-02-21','weekly'),(12,6,'Measles','Measles','2016-05-31','every 3 months'),(13,11,'Diarrhea','Diarrhea','2016-03-31','every 4 months'),(14,11,'Measles','Measles','2018-01-31','yearly'),(15,11,'Polio','Polio','2016-05-31','every 4 months'),(16,11,'Hepatitis','Hepatitis','2016-06-30','monthly'),(17,21,'Diarrhea','Diarrhea','2016-04-01','every 3 months'),(18,21,'Polio','Polio','2016-06-01','monthly'),(19,21,'Measles','Measles','2016-08-01','every 2 months'),(20,29,'Polio','Polio','2016-04-14','every 2 months'),(21,29,'Diarrhea','Diarrhea','2016-04-30','daily'),(22,29,'Measles','Measles','2016-06-30','monthly'),(23,30,'Polio','Polio','2016-04-07','every 2 months'),(24,30,'Measles','Measles','2016-07-31','monthly'),(25,26,'Polio','Measles','2016-04-14','daily'),(26,26,'Diarrhea','Polio','2016-04-21','weekly'),(27,34,'Polio','Polio','2016-08-06','monthly'),(28,34,'Measles','Measles','2016-05-06','weekly'),(29,33,'Polio','Polio','2016-05-06','weekly'),(30,33,'Measles','Measles','2016-04-07','daily');

--
-- Table structure for table `vaccine_administration`
--

DROP TABLE IF EXISTS `vaccine_administration`;

CREATE TABLE `vaccine_administration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vaccine_id` int(11) NOT NULL,
  `date_last_administered` date NOT NULL,
  `time_last_administered` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vaccine_administration`
--

/*!40000 ALTER TABLE `vaccine_administration` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaccine_administration` ENABLE KEYS */;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- Dump completed on 2016-04-29 13:07:11
