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
-- Table structure for table `Consultas`
--

DROP TABLE IF EXISTS `Consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Consultas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `paciente_id` int DEFAULT NULL,
  `medico_id` int DEFAULT NULL,
  `data_consulta` date DEFAULT NULL,
  `hora_consulta` time DEFAULT NULL,
  `observacoes` text,
  PRIMARY KEY (`id`),
  KEY `paciente_id` (`paciente_id`),
  KEY `medico_id` (`medico_id`),
  CONSTRAINT `Consultas_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `Pacientes` (`id`),
  CONSTRAINT `Consultas_ibfk_2` FOREIGN KEY (`medico_id`) REFERENCES `Medicos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Consultas`
--

LOCK TABLES `Consultas` WRITE;
/*!40000 ALTER TABLE `Consultas` DISABLE KEYS */;
INSERT INTO `Consultas` VALUES (1,1,1,'2024-11-05','09:00:00','Consulta de rotina para alergias e check-up geral.'),(2,2,2,'2024-11-06','14:00:00','Acompanhamento de diabetes e avaliação de glicemia.'),(3,3,3,'2024-11-07','10:30:00','Avaliação de problemas cardíacos e ajuste de medicação.'),(4,4,4,'2024-11-08','15:30:00','Consulta para acompanhamento de asma e renovação de receita.'),(5,5,5,'2024-11-09','11:00:00','Acompanhamento de colesterol e avaliação de exames de sangue.'),(6,6,6,'2024-11-12','16:00:00','Consulta para avaliação de enxaquecas e tratamento.'),(7,7,7,'2024-11-13','09:30:00','Acompanhamento de pressão alta e ajuste de medicação.'),(8,8,8,'2024-11-14','14:30:00','Consulta para avaliação de alergias alimentares e plano de tratamento.'),(9,9,9,'2024-11-15','10:00:00','Acompanhamento de problemas de coluna e avaliação de fisioterapia.'),(10,10,10,'2024-11-16','15:00:00','Consulta para avaliação de alergias sazonais e tratamento.'),(11,1,1,'2026-11-05','11:30:00','Consulta agendada pelo paciente.'),(12,1,1,'2025-03-13','10:00:00','Consulta agendada pelo paciente.'),(13,13,2,'2025-03-05','09:30:00','paciente tomar dipirona por 7 dias'),(14,14,1,'2025-03-12','09:30:00','tomar dipirona'),(15,17,1,'2025-03-03','10:00:00','vacinação feita'),(16,19,3,'2025-03-18','09:30:00','tomei 2 dipironas antes de vir para consulta');
/*!40000 ALTER TABLE `Consultas` ENABLE KEYS */;
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
