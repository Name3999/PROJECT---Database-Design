-- MySQL dump 10.13  Distrib 8.4.13, for Linux (x86_64)
--
-- Host: localhost    Database: targ_auto_hub
-- ------------------------------------------------------
-- Server version	8.4.13-0ubuntu0.26.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cereri_listare`
--

DROP TABLE IF EXISTS `cereri_listare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cereri_listare` (
  `id_cerere` int NOT NULL AUTO_INCREMENT,
  `id_utilizator` int NOT NULL,
  `id_parc` int NOT NULL,
  `detalii_masina` text NOT NULL,
  `status_cerere` enum('in_asteptare','aprobata','respinsa') DEFAULT 'in_asteptare',
  `data_cerere` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cerere`),
  KEY `id_utilizator` (`id_utilizator`),
  KEY `id_parc` (`id_parc`),
  CONSTRAINT `cereri_listare_ibfk_1` FOREIGN KEY (`id_utilizator`) REFERENCES `utilizatori` (`id_utilizator`) ON DELETE CASCADE,
  CONSTRAINT `cereri_listare_ibfk_2` FOREIGN KEY (`id_parc`) REFERENCES `parcuri_auto` (`id_parc`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cereri_listare`
--

LOCK TABLES `cereri_listare` WRITE;
/*!40000 ALTER TABLE `cereri_listare` DISABLE KEYS */;
/*!40000 ALTER TABLE `cereri_listare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locuri_parcare`
--

DROP TABLE IF EXISTS `locuri_parcare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locuri_parcare` (
  `id_loc` int NOT NULL AUTO_INCREMENT,
  `id_parc` int NOT NULL,
  `cod_loc` varchar(10) NOT NULL,
  `coord_x` int DEFAULT NULL,
  `coord_y` int DEFAULT NULL,
  `status` enum('liber','ocupat','inactiv') DEFAULT 'liber',
  `taxa_ocupare` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_loc`),
  UNIQUE KEY `id_parc` (`id_parc`,`cod_loc`),
  CONSTRAINT `locuri_parcare_ibfk_1` FOREIGN KEY (`id_parc`) REFERENCES `parcuri_auto` (`id_parc`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locuri_parcare`
--

LOCK TABLES `locuri_parcare` WRITE;
/*!40000 ALTER TABLE `locuri_parcare` DISABLE KEYS */;
INSERT INTO `locuri_parcare` VALUES (1,1,'A1',NULL,NULL,'liber',15.00),(2,1,'A2',NULL,NULL,'liber',15.00);
/*!40000 ALTER TABLE `locuri_parcare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marci_auto`
--

DROP TABLE IF EXISTS `marci_auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marci_auto` (
  `id_marca` int NOT NULL AUTO_INCREMENT,
  `nume_marca` varchar(50) NOT NULL,
  PRIMARY KEY (`id_marca`),
  UNIQUE KEY `nume_marca` (`nume_marca`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marci_auto`
--

LOCK TABLES `marci_auto` WRITE;
/*!40000 ALTER TABLE `marci_auto` DISABLE KEYS */;
INSERT INTO `marci_auto` VALUES (2,'BMW'),(3,'Toyota'),(1,'Volkswagen');
/*!40000 ALTER TABLE `marci_auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `masini`
--

DROP TABLE IF EXISTS `masini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `masini` (
  `id_masina` int NOT NULL AUTO_INCREMENT,
  `id_utilizator` int NOT NULL,
  `id_loc` int DEFAULT NULL,
  `id_model` int NOT NULL,
  `an_fabricatie` year NOT NULL,
  `kilometraj` int NOT NULL,
  `motorizare` varchar(50) DEFAULT NULL,
  `combustibil` enum('Benzina','Motorina','Electrica','GPL','Hibrid') NOT NULL,
  `pret` decimal(10,2) NOT NULL,
  `status_vanzare` enum('Disponibila','Rezervata','Vanduta') DEFAULT 'Disponibila',
  `descriere` text,
  `data_adaugare` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_masina`),
  UNIQUE KEY `id_loc` (`id_loc`),
  KEY `id_utilizator` (`id_utilizator`),
  KEY `id_model` (`id_model`),
  CONSTRAINT `masini_ibfk_1` FOREIGN KEY (`id_utilizator`) REFERENCES `utilizatori` (`id_utilizator`) ON DELETE CASCADE,
  CONSTRAINT `masini_ibfk_2` FOREIGN KEY (`id_loc`) REFERENCES `locuri_parcare` (`id_loc`) ON DELETE SET NULL,
  CONSTRAINT `masini_ibfk_3` FOREIGN KEY (`id_model`) REFERENCES `modele_auto` (`id_model`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `masini`
--

LOCK TABLES `masini` WRITE;
/*!40000 ALTER TABLE `masini` DISABLE KEYS */;
INSERT INTO `masini` VALUES (1,1,1,1,2019,150000,'2.0 TDI','Motorina',14500.00,'Disponibila','Navigatie, scaune incalzite, unic proprietar in RO.','2026-11-13 07:21:05'),(2,1,2,3,2021,85000,'2.0d','Motorina',25900.00,'Disponibila','Pachet M de fabrica, istoric complet la reprezentanta.','2026-11-13 07:21:05');
/*!40000 ALTER TABLE `masini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `masini_favorite`
--

DROP TABLE IF EXISTS `masini_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `masini_favorite` (
  `id_utilizator` int NOT NULL,
  `id_masina` int NOT NULL,
  PRIMARY KEY (`id_utilizator`,`id_masina`),
  KEY `id_masina` (`id_masina`),
  CONSTRAINT `masini_favorite_ibfk_1` FOREIGN KEY (`id_utilizator`) REFERENCES `utilizatori` (`id_utilizator`) ON DELETE CASCADE,
  CONSTRAINT `masini_favorite_ibfk_2` FOREIGN KEY (`id_masina`) REFERENCES `masini` (`id_masina`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `masini_favorite`
--

LOCK TABLES `masini_favorite` WRITE;
/*!40000 ALTER TABLE `masini_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `masini_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modele_auto`
--

DROP TABLE IF EXISTS `modele_auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modele_auto` (
  `id_model` int NOT NULL AUTO_INCREMENT,
  `id_marca` int NOT NULL,
  `nume_model` varchar(50) NOT NULL,
  PRIMARY KEY (`id_model`),
  KEY `id_marca` (`id_marca`),
  CONSTRAINT `modele_auto_ibfk_1` FOREIGN KEY (`id_marca`) REFERENCES `marci_auto` (`id_marca`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modele_auto`
--

LOCK TABLES `modele_auto` WRITE;
/*!40000 ALTER TABLE `modele_auto` DISABLE KEYS */;
INSERT INTO `modele_auto` VALUES (1,1,'Passat'),(2,1,'Golf'),(3,2,'Seria 3'),(4,3,'RAV4');
/*!40000 ALTER TABLE `modele_auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcuri_auto`
--

DROP TABLE IF EXISTS `parcuri_auto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parcuri_auto` (
  `id_parc` int NOT NULL AUTO_INCREMENT,
  `nume_parc` varchar(100) NOT NULL,
  `adresa` varchar(255) NOT NULL,
  `cui` varchar(20) NOT NULL,
  `taxa_inscriere` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id_parc`),
  UNIQUE KEY `cui` (`cui`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcuri_auto`
--

LOCK TABLES `parcuri_auto` WRITE;
/*!40000 ALTER TABLE `parcuri_auto` DISABLE KEYS */;
INSERT INTO `parcuri_auto` VALUES (1,'Auto Rulate Bucuresti','Splaiul Unirii 10','RO123456',500.00);
/*!40000 ALTER TABLE `parcuri_auto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rezervari`
--

DROP TABLE IF EXISTS `rezervari`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rezervari` (
  `id_rezervare` int NOT NULL AUTO_INCREMENT,
  `id_utilizator` int NOT NULL,
  `id_masina` int NOT NULL,
  `taxa_rezervare` decimal(10,2) NOT NULL,
  `status_rezervare` enum('activa','expirata','finalizata') DEFAULT 'activa',
  `data_rezervare` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rezervare`),
  UNIQUE KEY `id_masina` (`id_masina`),
  KEY `id_utilizator` (`id_utilizator`),
  CONSTRAINT `rezervari_ibfk_1` FOREIGN KEY (`id_utilizator`) REFERENCES `utilizatori` (`id_utilizator`) ON DELETE CASCADE,
  CONSTRAINT `rezervari_ibfk_2` FOREIGN KEY (`id_masina`) REFERENCES `masini` (`id_masina`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rezervari`
--

LOCK TABLES `rezervari` WRITE;
/*!40000 ALTER TABLE `rezervari` DISABLE KEYS */;
/*!40000 ALTER TABLE `rezervari` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilizatori`
--

DROP TABLE IF EXISTS `utilizatori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utilizatori` (
  `id_utilizator` int NOT NULL AUTO_INCREMENT,
  `nume_complet` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `parola_hash` varchar(255) NOT NULL,
  `rol` enum('admin','client') DEFAULT 'client',
  `badge_curent` varchar(50) DEFAULT 'Nou Venit',
  `discount` decimal(5,2) DEFAULT '0.00',
  `data_inregistrare` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_utilizator`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilizatori`
--

LOCK TABLES `utilizatori` WRITE;
/*!40000 ALTER TABLE `utilizatori` DISABLE KEYS */;
INSERT INTO `utilizatori` VALUES (1,'Ion Popescu','ion@test.com','parola_criptata','client','Nou Venit',0.00,'2026-11-13 07:21:03');
/*!40000 ALTER TABLE `utilizatori` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-25 19:21:27
