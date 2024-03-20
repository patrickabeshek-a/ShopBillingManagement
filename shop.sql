-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `items_bought` varchar(255) DEFAULT NULL,
  `mode_of_pay` varchar(50) DEFAULT NULL,
  `tax` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (1,'2024-03-15','chips (Qty: 1), soap (Qty: 2), chips (Qty: 5), water (Qty: 2), chips (Qty: 2), water (Qty: 2), bag (Qty: 1), water (Qty: 1), water (Qty: 4), water (Qty: 1), soap (Qty: 2), chips (Qty: 2)','Cash',70.8,660.8),(2,'2024-03-15','water (Qty: 4), soap (Qty: 1)','Cash',13.8,128.8),(3,'2024-03-15','water (Qty: 4)','Cash',9.6,89.6),(4,'2024-03-15','soap (Qty: 2), bag (Qty: 3)','Cash',62.4,582.4),(5,'2024-03-15','chips (Qty: 1), ','Cash',0.67,11.2),(6,'2024-03-15','water (Qty: 1), ','Cash',1.34,22.4),(7,'2024-03-15','soap (Qty: 2), ','Cash',4.704,78.4),(8,'2024-03-15','water (Qty: 1), ','Cash',1.34,22.4),(9,'2024-03-15','chips (Qty: 3), ','Cash',2.01,33.6),(10,'2024-03-15','soap (Qty: 1), ','Cash',2.4,39.2),(11,'2024-03-15','cap (Qty: 4), water (Qty: 3), ','Cash',17.5,291.2),(12,'2024-03-15','water (Qty: 2), bag (Qty: 1), ','Cash',12.8,212.8),(13,'2024-03-15','water (Qty: 3), ','Cash',4,67.2),(14,'2024-03-15','water (Qty: 2), ','Cash',2.7,44.8),(15,'2024-03-15','water (Qty: 3), ','Cash',4,67.2),(16,'2024-03-15','cap (Qty: 2), ','Cash',6.7,112),(17,'2024-03-15','water (Qty: 3), ','Cash',4,67.2),(18,'2024-03-15','bag (Qty: 2), ','Cash',20.2,336),(19,'2024-03-15','chips (Qty: 2), ','Cash',1.3,22.4),(20,'2024-03-18','Glass (Qty: 1), ','Cash',6.7,112),(21,'2024-03-18','soap (Qty: 1), ','Cash',6.3,41.3),(22,'2024-03-18','water (Qty: 4), ','Cash',0,80),(23,'2024-03-18','soap (Qty: 4), cap (Qty: 5), ','Cash',37.7,427.7),(24,'2024-03-18','bag (Qty: 2), ','Cash',15,315),(25,'2024-03-18','milk (Qty: 1), bag (Qty: 1), ','Cash',7.5,177.5),(26,'2024-03-18','bag (Qty: 1), ','Cash',7.5,157.5),(27,'2024-03-18','water (Qty: 3), ','Cash',0,60),(28,'2024-03-18','bag (Qty: 1), water (Qty: 5), chips (Qty: 5), soap (Qty: 2), ','Cash',39.61,396.1),(29,'2024-03-19','bag (Qty: 1), water (Qty: 5), chips (Qty: 7), soap (Qty: 2), ','Cash',41.85,418.5),(30,'2024-03-19','bag (Qty: 1), water (Qty: 5), chips (Qty: 7), soap (Qty: 2), ','Cash',41.85,418.5),(31,'2024-03-19','water (Qty: 3), ','Cash',6,60),(32,'2024-03-19','milk (Qty: 2), ','Cash',0,40),(33,'2024-03-19','soap (Qty: 3), ','Cash',18.9,123.9),(34,'2024-03-19','soap (Qty: 2), ','Cash',12.6,82.6),(35,'2024-03-19','cap (Qty: 2), ','Cash',5,105),(36,'2024-03-19','water (Qty: 1), ','Cash',0,20),(37,'2024-03-19','soap (Qty: 1), ','Cash',6.3,41.3),(38,'2024-03-19','chips (Qty: 2), ','Cash',2.4,22.4),(39,'2024-03-19','cap (Qty: 2), ','Cash',5,105),(40,'2024-03-19','water (Qty: 1), ','Cash',0,20),(41,'2024-03-19','water (Qty: 1), ','Cash',0,20),(42,'2024-03-19','water (Qty: 1), ','Cash',0,20),(43,'2024-03-19','water (Qty: 2), ','Cash',0,40),(44,'2024-03-19','chips (Qty: 3), water (Qty: 1), ','Cash',3.6,53.6),(45,'2024-03-19','pen (Qty: 5), chips (Qty: 1), ','Cash',3.7,63.7),(46,'2024-03-19','soap (Qty: 1), ','Cash',6.3,41.3),(47,'2024-03-20','bag (Qty: 1), ','Cash',15,315),(48,'2024-03-20','pen (Qty: 2), ','Cash',1,21),(49,'2024-03-20','water (Qty: 1), ','Cash',0,20),(50,'2024-03-20','soap (Qty: 2), ','Cash',12.6,82.6),(51,'2024-03-20','chips (Qty: 1), milk (Qty: 1), bag (Qty: 2), ','Cash',31.2,661.2),(52,'2024-03-20','pen (Qty: 1), ','Cash',0.5,10.5),(53,'2024-03-20','shampoo (Qty: 1), ','Cash',36,236),(54,'2024-03-20','pen (Qty: 1), ','Cash',0.5,10.5),(55,'2024-03-20','water (Qty: 1), ','Cash',0,20),(56,'2024-03-20','milk (Qty: 1), water (Qty: 1), soap (Qty: 1), ','Cash',6.3,81.3),(57,'2024-03-20','chips (Qty: 1), ','Cash',1.2,11.2),(58,'2024-03-20','chips (Qty: 1), ','Cash',1.2,11.2),(59,'2024-03-20','chips (Qty: 1), ','Cash',1.2,11.2),(60,'2024-03-20','pen (Qty: 1), ','Cash',0.5,10.5),(61,'2024-03-20','shampoo (Qty: 1), ','Cash',36,236),(62,'2024-03-20','pen (Qty: 1), ','Cash',0.5,10.5),(63,'2024-03-20','pen (Qty: 1), ','Cash',0.5,10.5),(64,'2024-03-20','pen (Qty: 1), ','Cash',0.5,10.5),(65,'2024-03-20','pen (Qty: 1), chips (Qty: 2), ','Cash',2.9,32.9),(66,'2024-03-20','cheese (Qty: 1), ','Cash',4.2,39.2),(67,'2024-03-20','cheese (Qty: 1), ','Cash',4.2,39.2),(68,'2024-03-20','pen (Qty: 1), ','Cash',0.5,10.5),(69,'2024-03-20','milk (Qty: 1), water (Qty: 1), soap (Qty: 1), ','Cash',6.3,81.3),(70,'2024-03-20','chips (Qty: 2), ','Cash',2.4,22.4);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (135,6,1,20),(136,2,1,20),(137,3,1,35);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `managers`
--

DROP TABLE IF EXISTS `managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `managers` (
  `username` varchar(25) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `managers`
--

LOCK TABLES `managers` WRITE;
/*!40000 ALTER TABLE `managers` DISABLE KEYS */;
INSERT INTO `managers` VALUES ('manager','password'),('patrick','password');
/*!40000 ALTER TABLE `managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` int NOT NULL,
  `quantity` varchar(45) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'chips',10,'15','Processed Food'),(2,'water',20,'47','Groceries'),(3,'soap',35,'10','Personal Care and Hygiene'),(4,'cap',50,'21','Clothing'),(5,'bag',300,'26','Clothing'),(6,'milk',20,'53','Groceries'),(7,'pen',10,'85','Household Essentials'),(8,'shampoo',200,'48','Personal Care and Hygiene'),(9,'cheese',35,'13','Dairy');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `username` varchar(25) NOT NULL,
  `password` varchar(20) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES ('patrick','password'),('sales','password');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax`
--

DROP TABLE IF EXISTS `tax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_type` varchar(255) NOT NULL,
  `tax_percentage` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax`
--

LOCK TABLES `tax` WRITE;
/*!40000 ALTER TABLE `tax` DISABLE KEYS */;
INSERT INTO `tax` VALUES (1,'Groceries',0.00),(2,'Household Essentials',5.00),(3,'Electronics',12.00),(4,'Dairy',12.00),(5,'Processed Food',12.00),(6,'Personal Care and Hygiene',18.00),(7,'Luxury',28.00),(8,'Clothing',5.00);
/*!40000 ALTER TABLE `tax` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-20 16:51:36
