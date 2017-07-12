-- MySQL dump 10.13  Distrib 5.7.18, for Linux (x86_64)
--
-- Host: localhost    Database: fablab
-- ------------------------------------------------------
-- Server version	5.7.18-0ubuntu0.16.04.1

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
-- Current Database: `fablab`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `fablab` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `fablab`;

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
INSERT INTO `filemap` VALUES (1,5),(2,1),(3,1),(4,11),(5,12),(6,12);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1,'xxx'),(2,'http://localhost:5000/_uploads/files/README.md'),(3,'http://localhost:5000/_uploads/files/README_1.md'),(4,'http://localhost:5000/_uploads/files/LICENSE.txt'),(5,'http://localhost:5000/_uploads/files/uploadme.txt'),(6,'http://localhost:5000/_uploads/files/uploadme_1.txt');
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
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (49,'http://localhost:5000/_uploads/images/rm_1920_1080.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080.jpg',NULL),(50,'http://localhost:5000/_uploads/images/rm_1920_1080_1.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_1.jpg',NULL),(51,'http://localhost:5000/_uploads/images/rm_350_506.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506.jpg',NULL),(52,'http://localhost:5000/_uploads/images/rm_1041_389.png',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1041_389.png',NULL),(54,'http://localhost:5000/_uploads/images/tuxwithfriends.png',1,'http://localhost:5000/_uploads/images/thumbnails/tuxwithfriends.png',NULL),(55,'http://localhost:5000/_uploads/images/rm_1920_1080_2.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_2.jpg',NULL),(56,'http://localhost:5000/_uploads/images/rm_1920_1080_3.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_3.jpg',NULL),(57,'http://localhost:5000/_uploads/images/rm_350_506_1.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506_1.jpg',NULL),(58,'http://localhost:5000/_uploads/images/rm_350_506_2.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506_2.jpg',NULL),(59,'http://localhost:5000/_uploads/images/rm_350_506_3.jpg',1,'http://localhost:5000/_uploads/images/thumbnails/rm_350_506_3.jpg',NULL),(60,'http://localhost:5000/_uploads/images/rm_1041_389_1.png',1,'http://localhost:5000/_uploads/images/thumbnails/rm_1041_389_1.png',NULL),(61,'http://localhost:5000/_uploads/images/tuxwithfriends_1.png',1,'http://localhost:5000/_uploads/images/thumbnails/tuxwithfriends_1.png',NULL),(62,'http://localhost:5000/_uploads/images/caption_3fb663be-bfcc-4de4-a11e-b3fa046b9e52.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_3fb663be-bfcc-4de4-a11e-b3fa046b9e52.png',NULL),(63,'http://localhost:5000/_uploads/images/caption_c66e4882-4682-4ccf-a0c8-d655881a1616.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_c66e4882-4682-4ccf-a0c8-d655881a1616.png',NULL),(64,'http://localhost:5000/_uploads/images/caption_8f002ecb-80d3-42c5-9b94-01c132c4864f.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_8f002ecb-80d3-42c5-9b94-01c132c4864f.png',NULL),(65,'http://localhost:5000/_uploads/images/Togepi.png',11,'http://localhost:5000/_uploads/images/thumbnails/Togepi.png',NULL),(66,'http://localhost:5000/_uploads/images/caption_43aacca1-6463-4209-af88-9122fb1078bc.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_43aacca1-6463-4209-af88-9122fb1078bc.png',NULL),(68,'http://localhost:5000/_uploads/images/caption_49a30db3-ba4e-4d68-a7c0-b8d1d5841022.png',1,'http://localhost:5000/_uploads/images/thumbnails/caption_49a30db3-ba4e-4d68-a7c0-b8d1d5841022.png',NULL),(71,'http://localhost:5000/_uploads/images/rm_1041_389_2.png',11,'http://localhost:5000/_uploads/images/thumbnails/rm_1041_389_2.png',NULL),(73,'http://localhost:5000/_uploads/images/caption_93afc553-3ca1-47a6-9979-0c580f583b71.png',11,'http://localhost:5000/_uploads/images/thumbnails/caption_93afc553-3ca1-47a6-9979-0c580f583b71.png',NULL),(75,'http://localhost:5000/_uploads/images/rm_1920_1080_4.jpg',11,'http://localhost:5000/_uploads/images/thumbnails/rm_1920_1080_4.jpg',NULL),(76,'http://localhost:5000/_uploads/images/caption_a3ec010d-1e6f-4ea1-a465-2733d54ca874.png',11,'http://localhost:5000/_uploads/images/thumbnails/caption_a3ec010d-1e6f-4ea1-a465-2733d54ca874.png',NULL),(77,'http://localhost:5000/_uploads/images/caption_e2a6c89e-b067-4fc3-9d0c-b7e0661ac54a.png',11,'http://localhost:5000/_uploads/images/thumbnails/caption_e2a6c89e-b067-4fc3-9d0c-b7e0661ac54a.png',NULL),(81,'http://localhost:5000/_uploads/images/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png',12,'http://localhost:5000/_uploads/images/thumbnails/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png',NULL),(82,'http://localhost:5000/_uploads/images/tuxwithfriends_2.png',12,'http://localhost:5000/_uploads/images/thumbnails/tuxwithfriends_2.png',NULL),(83,'http://localhost:5000/_uploads/images/caption_7e518ef4-4299-48f7-acf0-ebda81edc258.png',12,'http://localhost:5000/_uploads/images/thumbnails/caption_7e518ef4-4299-48f7-acf0-ebda81edc258.png',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,1,'2017-06-26 10:20:25','[TOC]\n\ntest data\n![](http://localhost:5000/_uploads/images/rm_1920_1080.jpg)\n![](http://localhost:5000/_uploads/images/rm_1920_1080_2.jpg)\n\n![](http://localhost:5000/_uploads/images/rm_1920_1080_1.jpg)\n![](http://localhost:5000/_uploads/images/rm_1920_1080_3.jpg)\n\n![](http://localhost:5000/_uploads/images/rm_350_506.jpg)\n![](http://localhost:5000/_uploads/images/rm_350_506_3.jpg)\n\n![](http://localhost:5000/_uploads/images/rm_1041_389.png)\n![](http://localhost:5000/_uploads/images/rm_1041_389_1.png)\n\n![](http://localhost:5000/_uploads/images/rm_350_506_2.jpg)\n\n![](http://localhost:5000/_uploads/images/tuxwithfriends.png)\n![](http://localhost:5000/_uploads/images/tuxwithfriends_1.png)\n\n## Caption Test\n\n![](http://localhost:5000/_uploads/images/caption_43aacca1-6463-4209-af88-9122fb1078bc.png)\n\n**If text is longer than width, text size will be smaller!**\n\n![](http://localhost:5000/_uploads/images/caption_49a30db3-ba4e-4d68-a7c0-b8d1d5841022.png)\n',1,'Project'),(3,3,'2017-06-28 11:16:56','# Project for User 3\n\n\n------------\n\nThis is a test for user.\n\n[Basic link](https://www.google.com \"Basic link\")',0,'Second'),(5,3,'2017-06-28 11:23:44',NULL,0,'thirdContent'),(8,1,'2017-06-29 09:00:34','Test body',0,'Create test33'),(11,1,'2017-07-04 09:55:11','# Huge Title\n\n[TOC]\n\n## Resized Image\n\n![](http://localhost:5000/_uploads/images/rm_1920_1080_4.jpg)\n\n![](http://localhost:5000/_uploads/images/caption_a3ec010d-1e6f-4ea1-a465-2733d54ca874.png)\n\n![](http://localhost:5000/_uploads/images/caption_93afc553-3ca1-47a6-9979-0c580f583b71.png)\n\n## First\n\n**This is first.**\n\n### Something\n\nI am inside first.:fa-check-circle:\n\n```java\nvoid swap(int[] array, int i, int j) {\n	int temp = array[i];\n	array[i] = array[j];\n	array[j] = temp;\n  }\n```\n\n## Second\n\nSecond rocks.\n\n## Third\n\nWhaaaatttttt?!\n',1,'My Project'),(12,1,'2017-07-11 12:38:54','# Testing It\n\n- Upload images with size options\n- Thumbnails\n- Copy image link\n- Add image link from gallery\n- Create caption for an image\n- Upload files\n- Make project public/private\n\n## Do Something Here\n![](http://localhost:5000/_uploads/images/caption_7e518ef4-4299-48f7-acf0-ebda81edc258.png)\n\n![](http://localhost:5000/_uploads/images/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png)\n\n![](http://localhost:5000/_uploads/images/tuxwithfriends_2.png)\n\n![](http://localhost:5000/_uploads/images/tuxwithfriends_2.png)\n![](http://localhost:5000/_uploads/images/caption_d0879fb4-5b7d-4e85-a328-8d54693d52b5.png)\n\n\n',1,'Testing Testing... 1.. 2.. 3..');
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

-- Dump completed on 2017-07-12 11:24:55
