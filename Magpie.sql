-- MySQL dump 10.13  Distrib 8.0.16, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: Magpie
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `chat`
--

CREATE SCHEMA Magpie;
USE Magpie;

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` longtext,
  `date` datetime DEFAULT NULL,
  `sender_id` int DEFAULT NULL,
  `receiver_id` int DEFAULT NULL,
  `chat_session_id` int DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chatSession`
--

DROP TABLE IF EXISTS `chatSession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `chatSession` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user1_id` int DEFAULT NULL,
  `user2_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nest`
--

DROP TABLE IF EXISTS `nest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `nest` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `total_worth` int DEFAULT '0',
  `favored` tinyint(1) DEFAULT NULL,
  `sort_mode` enum('SortByName','SortByWorth','SortByFavored','SortById') DEFAULT 'SortById',
  `is_asc` tinyint(1) DEFAULT '1',
  `only_favored` tinyint(1) DEFAULT '0',
  `is_public` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `nest_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `nest_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nestItem`
--

DROP TABLE IF EXISTS `nestItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `nestItem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `nest_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `photo` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `worth` int DEFAULT '0',
  `favored` tinyint(1) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `nest_id` (`nest_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `nestitem_ibfk_1` FOREIGN KEY (`nest_id`) REFERENCES `nest` (`id`),
  CONSTRAINT `nestitem_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `nestitem_ibfk_3` FOREIGN KEY (`nest_id`) REFERENCES `nest` (`id`),
  CONSTRAINT `nestitem_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT '',
  `created_at` date DEFAULT NULL,
  `sort_mode` enum('SortByName','SortByWorth','SortByFavored','SortById') DEFAULT 'SortById',
  `is_asc` tinyint(1) DEFAULT '1',
  `only_favored` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-28 23:18:21
