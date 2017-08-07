-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: fablab
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

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
-- Table structure for table `filemap`
--

DROP TABLE IF EXISTS `filemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filemap` (
  `ifile` int(11) DEFAULT NULL,
  `post` int(11) DEFAULT NULL,
  KEY `ifile` (`ifile`),
  KEY `post` (`post`),
  CONSTRAINT `ifile` FOREIGN KEY (`ifile`) REFERENCES `files` (`fileid`),
  CONSTRAINT `post` FOREIGN KEY (`post`) REFERENCES `posts` (`postid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filemap`
--

LOCK TABLES `filemap` WRITE;
/*!40000 ALTER TABLE `filemap` DISABLE KEYS */;
INSERT INTO `filemap` VALUES (1,5),(2,1),(3,1),(4,11),(6,12),(7,14);
/*!40000 ALTER TABLE `filemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `fileid` int(11) NOT NULL AUTO_INCREMENT,
  `filepath` text,
  PRIMARY KEY (`fileid`),
  UNIQUE KEY `files_fileid_uindex` (`fileid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1,'xxx'),(2,'http://localhost:5000/_uploads/files/README.md'),(3,'http://localhost:5000/_uploads/files/README_1.md'),(4,'http://localhost:5000/_uploads/files/LICENSE.txt'),(6,'http://localhost:5000/_uploads/files/uploadme_1.txt'),(7,'http://10.20.203.95/_uploads/files/test.txt');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `imageid` int(11) NOT NULL AUTO_INCREMENT,
  `imagepath` text,
  `postid` int(11) DEFAULT NULL,
  `thumbpath` text,
  `notes` longtext,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `images_imageid_uindex` (`imageid`),
  KEY `postid` (`postid`),
  CONSTRAINT `postid` FOREIGN KEY (`postid`) REFERENCES `posts` (`postid`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (49,'http://localhost:5000/_uploads/images/rm_1920_1080.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080.jpg',NULL),(50,'http://localhost:5000/_uploads/images/rm_1920_1080_1.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_1.jpg',NULL),(51,'http://localhost:5000/_uploads/images/rm_350_506.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506.jpg',NULL),(52,'http://localhost:5000/_uploads/images/rm_1041_389.png',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1041_389.png',NULL),(54,'http://localhost:5000/_uploads/images/tuxwithfriends.png',1,'http://localhost:5000/_uploads/images/thumbnails/tuxwithfriends.png',NULL),(55,'http://localhost:5000/_uploads/images/rm_1920_1080_2.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_2.jpg',NULL),(56,'http://localhost:5000/_uploads/images/rm_1920_1080_3.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_3.jpg',NULL),(57,'http://localhost:5000/_uploads/images/rm_350_506_1.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506_1.jpg',NULL),(58,'http://localhost:5000/_uploads/images/rm_350_506_2.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506_2.jpg',NULL),(59,'http://localhost:5000/_uploads/images/rm_350_506_3.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506_3.jpg',NULL),(60,'http://localhost:5000/_uploads/images/rm_1041_389_1.png',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1041_389_1.png',NULL),(61,'http://localhost:5000/_uploads/images/tuxwithfriends_1.png',1,'http://localhost:5000/_uploads/images/thumbnails/tuxwithfriends_1.png',NULL),(62,'http://localhost:5000/_uploads/images/caption_3fb663be-bfcc-4de4-a11e-b3fa046b9e52.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_3fb663be-bfcc-4de4-a11e-b3fa046b9e52.png',NULL),(63,'http://localhost:5000/_uploads/images/caption_c66e4882-4682-4ccf-a0c8-d655881a1616.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_c66e4882-4682-4ccf-a0c8-d655881a1616.png',NULL),(64,'http://localhost:5000/_uploads/images/caption_8f002ecb-80d3-42c5-9b94-01c132c4864f.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_8f002ecb-80d3-42c5-9b94-01c132c4864f.png',NULL),(65,'http://localhost:5000/_uploads/images/Togepi.png',11,'http://localhost:5000/_uploads/images/thumbnails/Togepi.png',NULL),(66,'http://localhost:5000/_uploads/images/caption_43aacca1-6463-4209-af88-9122fb1078bc.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_43aacca1-6463-4209-af88-9122fb1078bc.png',NULL),(68,'http://localhost:5000/_uploads/images/caption_49a30db3-ba4e-4d68-a7c0-b8d1d5841022.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_49a30db3-ba4e-4d68-a7c0-b8d1d5841022.png',NULL),(71,'http://localhost:5000/_uploads/images/rm_1041_389_2.png',11,'http://localhost:5000/_uploads/images/thumbnails/rm_1041_389_2.png',NULL),(73,'http://localhost:5000/_uploads/images/caption_93afc553-3ca1-47a6-9979-0c580f583b71.png',11,'http://localhost:5000/_uploads/images/thumbnails/caption_93afc553-3ca1-47a6-9979-0c580f583b71.png',NULL),(75,'http://localhost:5000/_uploads/images/rm_1920_1080_4.jpg',11,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_4.jpg',NULL),(76,'http://localhost:5000/_uploads/images/caption_a3ec010d-1e6f-4ea1-a465-2733d54ca874.png',11,'http://localhost:5000/_uploads/images/thumbnails/caption_a3ec010d-1e6f-4ea1-a465-2733d54ca874.png',NULL),(77,'http://localhost:5000/_uploads/images/caption_e2a6c89e-b067-4fc3-9d0c-b7e0661ac54a.png',11,'http://localhost:5000/_uploads/images/thumbnails/caption_e2a6c89e-b067-4fc3-9d0c-b7e0661ac54a.png',NULL),(81,'http://localhost:5000/_uploads/images/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png',12,'http://localhost:5000/_uploads/images/thumbnails/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png','test for 81'),(82,'http://localhost:5000/_uploads/images/tuxwithfriends_2.png',12,'http://localhost:5000/_uploads/images/thumbnails/tuxwithfriends_2.png','test for 82'),(84,'http://10.20.203.95/_uploads/images/Fab_Lab_logo.png',14,'http://10.20.203.95/_uploads/images/thumbnails/Fab_Lab_logo.png','test bcgcg'),(85,'http://10.20.203.95/_uploads/images/fab-academy2.jpg',14,'http://10.20.203.95/_uploads/images/thumbnails/fab-academy2.jpg','web t'),(89,'http://10.20.203.95/_uploads/images/last-product-8.jpg',14,'http://10.20.203.95/_uploads/images/thumbnails/last-product-8.jpg','upload test'),(90,'http://10.20.203.95/_uploads/images/last-product-8_1.jpg',14,'http://10.20.203.95/_uploads/images/thumbnails/last-product-8_1.jpg','Heeyyyyyy hooooo'),(91,'http://10.20.203.95/_uploads/images/last-product-0.jpg',14,'http://10.20.203.95/_uploads/images/thumbnails/last-product-0.jpg',NULL),(93,'http://10.20.203.95/_uploads/images/cut-7.jpg',14,'http://10.20.203.95/_uploads/images/thumbnails/cut-7.jpg',NULL),(94,'http://10.20.203.95/_uploads/images/cut-5.png',14,'http://10.20.203.95/_uploads/images/thumbnails/cut-5.png',NULL),(95,'http://10.20.203.95/_uploads/images/inkscape-design-3.png',14,'http://10.20.203.95/_uploads/images/thumbnails/inkscape-design-3.png',NULL),(96,'http://10.20.203.95/_uploads/images/concat_5cc2d7d1-5ef8-416b-8f25-00ebc4f4d89a.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_5cc2d7d1-5ef8-416b-8f25-00ebc4f4d89a.png',NULL),(97,'http://10.20.203.95/_uploads/images/concat_d3a5a493-3098-4520-97fa-7088529c7013.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_d3a5a493-3098-4520-97fa-7088529c7013.png',NULL),(98,'http://10.20.203.95/_uploads/images/concat_5ac7fb5d-14d8-473a-a84c-45b1af0c56de.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_5ac7fb5d-14d8-473a-a84c-45b1af0c56de.png','Two images in a row.'),(99,'http://10.20.203.95/_uploads/images/concat_8e6fc277-22eb-4293-a85f-36c04a3e535c.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_8e6fc277-22eb-4293-a85f-36c04a3e535c.png',NULL),(101,'http://10.20.203.95/_uploads/images/concat_f507dff2-e1da-4c6b-941a-9ad0219d2ddb.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_f507dff2-e1da-4c6b-941a-9ad0219d2ddb.png','Put note'),(103,'http://10.20.203.95/_uploads/images/inkscape-settings-2.png',14,'http://10.20.203.95/_uploads/images/thumbnails/inkscape-settings-2.png',NULL),(107,'http://10.20.203.95/_uploads/images/concat_db05d74f-b778-4bb3-a1ed-fa3681ea442d.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_db05d74f-b778-4bb3-a1ed-fa3681ea442d.png',NULL),(108,'http://10.20.203.95/_uploads/images/concat_f5857822-8d9f-4406-8e6f-435c642bb1c7.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_f5857822-8d9f-4406-8e6f-435c642bb1c7.png',NULL),(109,'http://10.20.203.95/_uploads/images/concat_23ec93a2-574d-4979-ad13-df008fe17bfc.png',14,'http://10.20.203.95/_uploads/images/thumbnails/concat_23ec93a2-574d-4979-ad13-df008fe17bfc.png','note from mobile'),(110,'http://10.20.203.95/_uploads/images/pika.png',15,'http://10.20.203.95/_uploads/images/thumbnails/pika.png','New note for this picture.'),(112,'http://10.20.203.95/_uploads/images/pika1.png',15,'http://10.20.203.95/_uploads/images/thumbnails/pika1.png','my hat is coooollll yeah'),(121,'http://10.20.203.95/_uploads/images/IMG_20170803_091549_-1075288302.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_091549_-1075288302.jpg','API 19 gallery'),(122,'http://10.20.203.95/_uploads/images/IMG_20170803_112131_1226599073.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_112131_1226599073.jpg','API19 camera size1'),(124,'http://10.20.203.95/_uploads/images/IMG_20170803_112526_-1584446793.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_112526_-1584446793.jpg','API 22 camera size1'),(125,'http://10.20.203.95/_uploads/images/IMG_20170803_112526_-1584446793_1.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_112526_-1584446793_1.jpg','API 22 gallery'),(126,'http://10.20.203.95/_uploads/images/IMG_20170803_113717_1632755366.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_113717_1632755366.jpg','api24 camera'),(127,'http://10.20.203.95/_uploads/images/IMG_20170803_113706.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_113706.jpg','api24 gallery'),(128,'http://10.20.203.95/_uploads/images/IMG_20170803_114211_1851149821.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_114211_1851149821.jpg','api25 camera'),(129,'http://10.20.203.95/_uploads/images/IMG_20170803_114211_1851149821_1.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_114211_1851149821_1.jpg','api25 gallery size1'),(130,'http://10.20.203.95/_uploads/images/IMG_20170803_114700_1539504131792189945.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_114700_1539504131792189945.jpg','api26 camera'),(131,'http://10.20.203.95/_uploads/images/IMG_20170803_094206_2024759984321389482.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_094206_2024759984321389482.jpg','api26 gallery'),(132,'http://10.20.203.95/_uploads/images/IMG_20170803_144942_1583181686.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_144942_1583181686.jpg','first test, wrong orientation'),(133,'http://10.20.203.95/_uploads/images/IMG_20170803_145131_-1557050318.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_145131_-1557050318.jpg',NULL),(134,'http://10.20.203.95/_uploads/images/IMG_20170803_145131_-1557050318_1.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_145131_-1557050318_1.jpg',NULL),(135,'http://10.20.203.95/_uploads/images/IMG_20170803_125604_2063337962.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170803_125604_2063337962.jpg',NULL),(136,'http://10.20.203.95/_uploads/images/IMG_20170804_121943_1583181686.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170804_121943_1583181686.jpg',NULL),(143,'http://10.20.203.95/_uploads/images/IMG_20170802_121132_3263738578409329445.jpg',61,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170802_121132_3263738578409329445.jpg','test notes'),(144,'http://10.20.203.95/_uploads/images/IMG_20170804_134339_1583181686.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170804_134339_1583181686.jpg','cam size1'),(145,'http://10.20.203.95/_uploads/images/IMG_20170804_134426_-1557050318.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170804_134426_-1557050318.jpg','cam size2'),(146,'http://10.20.203.95/_uploads/images/IMG_20170804_134500_1308403401.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170804_134500_1308403401.jpg','cam size3'),(147,'http://10.20.203.95/_uploads/images/IMG_20170804_134533_133307668.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/IMG_20170804_134533_133307668.jpg','cam size2 landscape'),(148,'http://10.20.203.95/_uploads/images/20170804_134504.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/20170804_134504.jpg','gallery size1'),(149,'http://10.20.203.95/_uploads/images/20170804_134504_1.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/20170804_134504_1.jpg','galley size2'),(150,'http://10.20.203.95/_uploads/images/20170804_134504_2.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/20170804_134504_2.jpg','gallery size3'),(151,'http://10.20.203.95/_uploads/images/20170804_134540.jpg',62,'http://10.20.203.95/_uploads/images/thumbnails/20170804_134540.jpg','gallery size2 landscape');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `postid` int(11) NOT NULL AUTO_INCREMENT,
  `authorid` int(11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `content` longtext,
  `status` tinyint(1) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`postid`),
  UNIQUE KEY `posts_postid_uindex` (`postid`),
  KEY `authorid` (`authorid`),
  CONSTRAINT `authorid` FOREIGN KEY (`authorid`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'2017-06-26 10:20:25','[TOC]\n\ntest data\n![](http://localhost:5000/_uploads/images/rm_1920_1080.jpg)\n![](http://localhost:5000/_uploads/images/rm_1920_1080_2.jpg)\n\n![](http://localhost:5000/_uploads/images/rm_1920_1080_1.jpg)\n![](http://localhost:5000/_uploads/images/rm_1920_1080_3.jpg)\n\n![](http://localhost:5000/_uploads/images/rm_350_506.jpg)\n![](http://localhost:5000/_uploads/images/rm_350_506_3.jpg)\n\n![](http://localhost:5000/_uploads/images/rm_1041_389.png)\n![](http://localhost:5000/_uploads/images/rm_1041_389_1.png)\n\n![](http://localhost:5000/_uploads/images/rm_350_506_2.jpg)\n\n![](http://localhost:5000/_uploads/images/tuxwithfriends.png)\n![](http://localhost:5000/_uploads/images/tuxwithfriends_1.png)\n\n## Caption Test\n\n![](http://localhost:5000/_uploads/images/caption_43aacca1-6463-4209-af88-9122fb1078bc.png)\n\n**If text is longer than width, text size will be smaller!**\n\n![](http://localhost:5000/_uploads/images/caption_49a30db3-ba4e-4d68-a7c0-b8d1d5841022.png)\n',1,'Project'),(3,3,'2017-06-28 11:16:56','# Project for User 3\n\n\n------------\n\nThis is a test for user.\n\n[Basic link](https://www.google.com \"Basic link\")',0,'Second'),(5,3,'2017-06-28 11:23:44',NULL,0,'thirdContent'),(11,1,'2017-07-04 09:55:11','# Huge Title\n\n[TOC]\n\n## Resized Image\n\n![](http://localhost:5000/_uploads/images/rm_1920_1080_4.jpg)\n\n![](http://localhost:5000/_uploads/images/caption_a3ec010d-1e6f-4ea1-a465-2733d54ca874.png)\n\n![](http://localhost:5000/_uploads/images/caption_93afc553-3ca1-47a6-9979-0c580f583b71.png)\n\n## First\n\n**This is first.**\n\n### Something\n\nI am inside first.:fa-check-circle:\n\n```java\nvoid swap(int[] array, int i, int j) {\n	int temp = array[i];\n	array[i] = array[j];\n	array[j] = temp;\n  }\n```\n\n## Second\n\nSecond rocks.\n\n## Third\n\nWhaaaatttttt?!\n',1,'My Project'),(12,1,'2017-07-11 12:38:54','# Testing It\n\n- Upload images with size options\n- Thumbnails\n- Copy image link\n- Add image link from gallery\n- Create caption for an image\n- Upload files\n- Make project public/private\n\n## Do Something Here\n![](http://localhost:5000/_uploads/images/caption_7e518ef4-4299-48f7-acf0-ebda81edc258.png)\n\n![](http://localhost:5000/_uploads/images/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png)\n\n![](http://localhost:5000/_uploads/images/tuxwithfriends_2.png)\n\n![](http://localhost:5000/_uploads/images/tuxwithfriends_2.png)\n![](http://localhost:5000/_uploads/images/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png)\n\n\n',1,'Testing Testing... 1.. 2.. 3..'),(14,1,'2017-07-14 09:45:47','## Caption Examples\n\n![Fablab academy](http://10.20.203.95/_uploads/images/fab-academy2.jpg)\n\n![Result](http://10.20.203.95/_uploads/images/concat_f5857822-8d9f-4406-8e6f-435c642bb1c7.png)\n\n\n![Collage from UI](http://10.20.203.95/_uploads/images/concat_db05d74f-b778-4bb3-a1ed-fa3681ea442d.png)\n\n\n![I am a caption](http://10.20.203.95/_uploads/images/last-product-8.jpg)\n\n![Tiny!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!second line!!!!!!!!!!!!](http://10.20.203.95/_uploads/images/last-product-8_1.jpg)\n\n## Concat Testing\n\n`http://10.20.203.95/concat/?images=[[91,93],[94,95]]`\n\n### Original Images\n\n![](http://10.20.203.95/_uploads/images/last-product-0.jpg)\n\n![](http://10.20.203.95/_uploads/images/cut-7.jpg)\n\n![](http://10.20.203.95/_uploads/images/cut-5.png)\n\n![](http://10.20.203.95/_uploads/images/inkscape-design-3.png)\n\n#### 4 Images\n\n![](http://10.20.203.95/_uploads/images/concat_5cc2d7d1-5ef8-416b-8f25-00ebc4f4d89a.png)\n\n#### 3 Images\n\n![](http://10.20.203.95/_uploads/images/concat_d3a5a493-3098-4520-97fa-7088529c7013.png)\n\n#### 2 Images\n\n![](http://10.20.203.95/_uploads/images/concat_5ac7fb5d-14d8-473a-a84c-45b1af0c56de.png)\n\n#### Vertical\n\n![](http://10.20.203.95/_uploads/images/concat_8e6fc277-22eb-4293-a85f-36c04a3e535c.png)\n\n',1,'Example'),(15,1,'2017-07-27 08:01:05','# Test',0,'Pika'),(61,1,'2017-08-02 12:36:43','',0,'New Project'),(62,1,'2017-08-03 11:49:28','![First trial, wrong orientation. Size1](http://10.20.203.95/_uploads/images/IMG_20170803_144942_1583181686.jpg)\n![cam size1](http://10.20.203.95/_uploads/images/IMG_20170804_134339_1583181686.jpg)\n![cam size2](http://10.20.203.95/_uploads/images/IMG_20170804_134426_-1557050318.jpg)\n![cam size3](http://10.20.203.95/_uploads/images/IMG_20170804_134500_1308403401.jpg)\n![cam size2 landscape](http://10.20.203.95/_uploads/images/IMG_20170804_134533_133307668.jpg)\n![gallery size1](http://10.20.203.95/_uploads/images/20170804_134504.jpg)\n![galley size2](http://10.20.203.95/_uploads/images/20170804_134504_1.jpg)\n![gallery size3](http://10.20.203.95/_uploads/images/20170804_134504_2.jpg)\n![gallery size2 landscape](http://10.20.203.95/_uploads/images/20170804_134540.jpg)\n',0,'Phone Test');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(120) NOT NULL,
  `password` varchar(120) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `users_userid_uindex` (`userid`),
  UNIQUE KEY `users_username_uindex` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'uname','pass'),(3,'secondUser','pass');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-07 12:29:02
