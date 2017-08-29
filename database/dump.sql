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
INSERT INTO `filemap` VALUES (27,74);
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (27,'http://10.20.204.64/_uploads/files/test.txt');
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
  `voiceid` int(11) DEFAULT NULL,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `images_imageid_uindex` (`imageid`),
  KEY `postid` (`postid`),
  KEY `voiceid` (`voiceid`),
  CONSTRAINT `postid` FOREIGN KEY (`postid`) REFERENCES `posts` (`postid`),
  CONSTRAINT `voiceid` FOREIGN KEY (`voiceid`) REFERENCES `files` (`fileid`)
) ENGINE=InnoDB AUTO_INCREMENT=239 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (230,'http://10.20.204.64/_uploads/images/Fab_Lab_logo.png',74,'http://10.20.204.64/_uploads/images/thumbnails/Fab_Lab_logo.png',NULL,NULL),(231,'http://10.20.204.64/_uploads/images/fab-academy2.jpg',74,'http://10.20.204.64/_uploads/images/thumbnails/fab-academy2.jpg','My notes.',NULL),(232,'http://10.20.204.64/_uploads/images/concat_f7c7ef21-0d5e-41f6-b4e5-c22353fe7325.png',74,'http://10.20.204.64/_uploads/images/thumbnails/concat_f7c7ef21-0d5e-41f6-b4e5-c22353fe7325.png',NULL,NULL),(235,'http://10.20.204.64/_uploads/images/20170824_140023_1.jpg',78,'http://10.20.204.64/_uploads/images/thumbnails/20170824_140023_1.jpg',NULL,NULL),(236,'http://10.20.204.64/_uploads/images/20170824_145013.jpg',78,'http://10.20.204.64/_uploads/images/thumbnails/20170824_145013.jpg',NULL,NULL),(237,'http://10.20.204.64/_uploads/images/20170824_151648.jpg',78,'http://10.20.204.64/_uploads/images/thumbnails/20170824_151648.jpg',NULL,NULL),(238,'http://10.20.204.64/_uploads/images/20170824_155730.jpg',78,'http://10.20.204.64/_uploads/images/thumbnails/20170824_155730.jpg',NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (74,4,'2017-08-28 09:05:14','# Lorem Ipsum\n\n> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque tincidunt sed ipsum eget auctor. Morbi tempor enim sit amet leo ultricies, ut facilisis nunc pharetra. Nullam in eros sed augue commodo ornare.\n\n**Aliquam varius eros consectetur, gravida nisi non, semper enim.** ~~Fusce semper sapien eget elit lobortis consequat.~~ *Pellentesque eu pellentesque neque, eu luctus augue.* Nunc magna enim, lobortis vel erat eget, posuere consequat magna. Donec commodo hendrerit nunc, a molestie turpis lobortis non. Sed tempor laoreet nisi, id placerat ex luctus at. Donec ac lorem sit amet risus eleifend convallis.\n\n![](http://10.20.204.64/_uploads/images/Fab_Lab_logo.png)\n\n![Fab Academy](http://10.20.204.64/_uploads/images/concat_f7c7ef21-0d5e-41f6-b4e5-c22353fe7325.png)\n\n\nPellentesque quis pharetra neque. Aenean lacus ante, vestibulum et dolor et, sodales sodales metus. Morbi bibendum nisl odio, eget dapibus odio viverra sit amet. Phasellus malesuada auctor efficitur. Praesent enim ligula, gravida aliquam mattis id, ullamcorper a orci. Curabitur ac mi ut arcu rhoncus commodo et viverra leo. Praesent in urna accumsan, tincidunt mi at, iaculis justo. Donec dignissim sapien et cursus placerat. Sed quam nibh, tincidunt ac cursus interdum, cursus vitae lacus. Donec feugiat purus a pulvinar pulvinar. Sed vitae accumsan leo. Nullam vel tincidunt sem. Aliquam nec enim a diam aliquet mollis.\n\nSed id tristique nulla. Donec dignissim odio sem, ac convallis justo mollis ut. Morbi in ornare dui. Proin iaculis varius auctor. Integer vel ante tellus. Ut tortor mauris, placerat et ultricies eget, tincidunt at sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sagittis quam quis enim rutrum rhoncus. Sed pharetra, arcu vitae lobortis tincidunt, lorem ligula pulvinar eros, ac pellentesque massa nunc non elit.\n\nSed id dolor at erat sodales eleifend. Nunc sed ante consequat, finibus turpis sodales, congue ipsum. Nam tincidunt interdum lorem nec mattis. Suspendisse bibendum, lacus quis cursus ullamcorper, mauris nunc hendrerit nunc, et aliquet est tellus vel augue. Curabitur a porta dolor. Donec tincidunt risus ac velit hendrerit, eu pulvinar nunc finibus. Nulla faucibus, augue at vulputate pretium, magna dui rutrum nisl, vel feugiat est lectus in odio. Donec sit amet eleifend augue. Nunc fringilla odio et magna dictum pellentesque. Pellentesque aliquam hendrerit arcu, at aliquam velit commodo quis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras a ipsum facilisis, tristique tellus ut, feugiat ex. Vestibulum ipsum nulla, commodo sed ullamcorper vitae, aliquet quis elit. Ut volutpat odio dui, nec bibendum erat fermentum eget. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vivamus accumsan sem nec pretium aliquet.\n\nProin eleifend, velit a consectetur lobortis, leo metus elementum tortor, non pharetra magna felis ac sem. Ut at sodales sapien, nec congue libero. Donec auctor finibus pharetra. Pellentesque pretium nisi id laoreet consequat. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas nec ipsum feugiat, semper odio at, iaculis orci. Phasellus imperdiet enim a neque semper euismod. Donec a consectetur nulla. Ut at nunc imperdiet, mattis augue non, vulputate urna. Cras egestas arcu sed nulla euismod, vel mattis est bibendum. Aenean finibus magna ac tempus mollis.',1,'My Project'),(75,4,'2017-08-28 09:06:59','',0,'New Project'),(78,4,'2017-08-28 10:15:30','Today we leraned three creative ideatetion methods.\n\n- Property mapping method.\n- Mind map method.\n- Brainwriting / 6-3-5 method.\n\nWe had 2 indivudual tasks and 1 task with 5 people group.\n\n## Task 1: Property Mapping Method\n\nIn this task, it was asked to choose five living things and five man-made objects. After that, I followed the below steps:\n\n- Combine them.\n- Select pairs that seems interesting.\n- Create new concept by using the `a <man-made object> like a <living thing>` formula.\n\nI created 4 concepts by using my pairs: \n\n- A bicycle with wheels like a snake.\n- A frog car to jump a place when there is traffic :)\n- A bird-computer, the computer that makes calculation by using birds. They will solve problems to get food and these solutions actualy will be the logic gates in CPU.\n- Flying Phone. When your phone realized it is falling down, it will begin to fly and land on the place that it began to fall.\n\n![My Concepts](http://10.20.204.64/_uploads/images/20170824_140023_1.jpg)\n\nAll of them are crazy but it was fun to imagine to live in a crazy world.\n\n## Task 2: Mind Map Method\n\nIn this task, the topic was mosquitos. First everyone created their own mind maps, then we combined them as one.\n\nI imagined them as *bad boys of the town* who are called as *MosQ* before begin to create.\n\n![My Mind Map](http://10.20.204.64/_uploads/images/20170824_145013.jpg)\n\n![End Result of Combination](http://10.20.204.64/_uploads/images/20170824_151648.jpg)\n\n## Task 3: Brainwriting / 6-3-5 Method\n\nIn this method, everyone propose 3 ideas about the problem then pass the sheet to next person. After recieving other person\'s sheet, two actions can be done: improve the previous idea or suggest a totally new solution. This process goes until everyone ends up with the first sheet they have at the beginning.\n\n6-3-5 refers 6 people, 3 ideas, 5 minutes. We were only 5 people so, it was 5-3-5 in our case.\n\nBelow picture shows the sheet that I began with at the end. The first column belongs to me and it can be seen how it went during the exercise.\n\n![](http://10.20.204.64/_uploads/images/20170824_155730.jpg)\n\n## Reflection\n\nToday, I had fun more than other lectures. It was very nice to learn ideatation mehods and going crazy while creating new ideas. At the beginning, I could not be sure about what was the point of doing this but, after exercises, I got the point.\n\nIn addition, I learned it is better to sketch your ideas than only writing them.\n',0,'Ex5'),(79,4,'2017-08-28 13:58:15','',0,'New Project');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'User1','pass'),(6,'User','pass');
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

-- Dump completed on 2017-08-28 17:37:45
