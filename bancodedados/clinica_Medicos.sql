-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: clinica
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `Medicos`
--

DROP TABLE IF EXISTS `Medicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Medicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `especialidade_id` int DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `telefone` varchar(14) DEFAULT NULL,
  `crm` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `crm` (`crm`),
  KEY `especialidade_id` (`especialidade_id`),
  CONSTRAINT `Medicos_ibfk_1` FOREIGN KEY (`especialidade_id`) REFERENCES `Especialidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medicos`
--

LOCK TABLES `Medicos` WRITE;
/*!40000 ALTER TABLE `Medicos` DISABLE KEYS */;
INSERT INTO `Medicos` VALUES (1,1,'Dr. João Silva','11-99999-9999','CRM12345'),(2,2,'Dra. Maria Oliveira','21-88888-8888','CRM67890'),(3,3,'Dr. Pedro Santos','31-77777-7777','CRM13579'),(4,4,'Dra. Ana Costa','41-66666-6666','CRM24680'),(5,5,'Dr. Ricardo Souza','51-55555-5555','CRM11223'),(6,6,'Dra. Laura Almeida','61-44444-4444','CRM44556'),(7,7,'Dr. Fernando Rocha','71-33333-3333','CRM77889'),(8,8,'Dra. Camila Pereira','81-22222-2222','CRM99001'),(9,9,'Dr. Lucas Rodrigues','91-11111-1111','CRM22334'),(10,10,'Dra. Patrícia Gomes','27-98765-4321','CRM55667');
/*!40000 ALTER TABLE `Medicos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-05 21:59:18
