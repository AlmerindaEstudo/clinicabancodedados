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
-- Table structure for table `Pacientes`
--

DROP TABLE IF EXISTS `Pacientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pacientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `cpf` varchar(14) NOT NULL,
  `telefone` varchar(14) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `ficha_medica` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pacientes`
--

LOCK TABLES `Pacientes` WRITE;
/*!40000 ALTER TABLE `Pacientes` DISABLE KEYS */;
INSERT INTO `Pacientes` VALUES (1,'Carlos Mendes','1980-05-15','111.111.111-11','11-99999-9999','carlos.mendes@email.com','Histórico de alergias e cirurgias.'),(2,'Mariana Cunha','1995-08-22','222.222.222-22','21-88888-8888','mariana.cunha@email.com','Acompanhamento de diabetes.'),(3,'Roberto Almeida','1975-03-10','333.333.333-33','31-77777-7777','roberto.almeida@email.com','Problemas cardíacos e medicação.'),(4,'Fernanda Souza','2000-11-05','444.444.444-44','41-66666-6666','fernanda.souza@email.com','Histórico de asma.'),(5,'Lucas Oliveira','1990-07-18','555.555.555-55','51-55555-5555','lucas.oliveira@email.com','Acompanhamento de colesterol.'),(6,'Amanda Rocha','1988-02-28','666.666.666-66','61-44444-4444','amanda.rocha@email.com','Histórico de enxaquecas.'),(7,'Rafael Pereira','1983-12-01','777.777.777-77','71-33333-3333','rafael.pereira@email.com','Acompanhamento de pressão alta.'),(8,'Juliana Gomes','1998-09-12','888.888.888-88','81-22222-2222','juliana.gomes@email.com','Histórico de alergias alimentares.'),(9,'Bruno Rodrigues','1970-06-25','999.999.999-99','91-11111-1111','bruno.rodrigues@email.com','Acompanhamento de problemas de coluna.'),(10,'Patrícia Costa','2005-04-03','000.000.000-00','27-98765-4321','patricia.costa@email.com','Histórico de alergias sazonais.'),(11,'juju','2004-03-09','31-77777-7717','7788332233','juju@gmail.com','diarreia'),(12,'Cristina','1996-03-05',' 31-77777-7718','776645242121','cristina@gmail.com','febre'),(13,'marcela','1993-03-15','212.212.121-11','7734242131','marcela@gmail.com','ansiedade'),(14,'Almerinda Araujo','2004-01-19','666.666.666-68','77911223344','almerinda@gmail.com','febre'),(15,'Juranti Pereira','2025-03-01','555.555.555.44','9191919191','juranti@gmail.com','remarcação'),(16,'Juranti Pereira','2025-03-01','555.555.555-44','9191919191','juranti@gmail.com','remarcação'),(17,'Amora de Jesus','2025-02-28','123.123.123-33','91010101','amora@gmail.com','vacinação'),(18,'Irsael ','2004-03-03','234.567.890-11','77911111111','irsael@gmail.com','retorno de consulta'),(19,'Almerinda Po','2016-03-08','135.345.570-00','7711224432','almerindapo@gmail.com','retorno de consulta');
/*!40000 ALTER TABLE `Pacientes` ENABLE KEYS */;
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
