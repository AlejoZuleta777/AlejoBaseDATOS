CREATE DATABASE  IF NOT EXISTS `banco` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `banco`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: banco
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `auditoria_sql`
--

DROP TABLE IF EXISTS `auditoria_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_sql` (
  `ID_Log` int NOT NULL AUTO_INCREMENT,
  `Fecha_Evento` datetime DEFAULT CURRENT_TIMESTAMP,
  `ID_Usuario` int DEFAULT NULL,
  `Accion` varchar(100) DEFAULT NULL,
  `Descripcion` text,
  PRIMARY KEY (`ID_Log`),
  KEY `ID_Usuario` (`ID_Usuario`),
  CONSTRAINT `auditoria_sql_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `usuarios` (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_sql`
--

LOCK TABLES `auditoria_sql` WRITE;
/*!40000 ALTER TABLE `auditoria_sql` DISABLE KEYS */;
INSERT INTO `auditoria_sql` VALUES (1,'2026-03-17 21:44:57',1,'LOGIN','Inicio de sesión exitoso'),(2,'2026-03-17 21:44:57',2,'LOGIN','Inicio de sesión exitoso'),(3,'2026-03-17 21:44:57',3,'TRANSFERENCIA','Transferencia enviada a CTA-1005'),(4,'2026-03-17 21:44:57',1,'CONSULTA','Consulta de saldo de cuenta'),(5,'2026-03-17 21:44:57',8,'APROBACION','Analista aprobó préstamo ID 1'),(6,'2026-03-17 21:44:57',6,'LOGIN','Empresa ingresa al sistema'),(7,'2026-03-17 21:44:57',10,'REGISTRO','Comercial registró nuevo cliente'),(8,'2026-03-17 21:44:57',9,'RETIRO','Ventanilla procesó retiro'),(9,'2026-03-17 21:44:57',11,'LOGIN','Inicio de sesión exitoso'),(10,'2026-03-17 21:44:57',12,'LOGIN','Inicio de sesión exitoso');
/*!40000 ALTER TABLE `auditoria_sql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes_empresa`
--

DROP TABLE IF EXISTS `clientes_empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes_empresa` (
  `NIT` varchar(20) NOT NULL,
  `Razon_Social` varchar(150) NOT NULL,
  `ID_Representante_Legal` int DEFAULT NULL,
  PRIMARY KEY (`NIT`),
  KEY `ID_Representante_Legal` (`ID_Representante_Legal`),
  CONSTRAINT `clientes_empresa_ibfk_1` FOREIGN KEY (`NIT`) REFERENCES `usuarios` (`Identificacion`),
  CONSTRAINT `clientes_empresa_ibfk_2` FOREIGN KEY (`ID_Representante_Legal`) REFERENCES `usuarios` (`ID_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes_empresa`
--

LOCK TABLES `clientes_empresa` WRITE;
/*!40000 ALTER TABLE `clientes_empresa` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes_empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas`
--

DROP TABLE IF EXISTS `cuentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas` (
  `Numero_Cuenta` varchar(20) NOT NULL,
  `ID_Titular` varchar(20) NOT NULL,
  `Tipo_Cuenta` enum('Ahorros','Corriente','Personal','Empresarial') NOT NULL,
  `Saldo` decimal(18,2) DEFAULT '0.00',
  `Moneda` varchar(5) DEFAULT 'COP',
  `Estado_Cuenta` enum('Activa','Bloqueada','Cancelada') DEFAULT 'Activa',
  `Fecha_Apertura` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Numero_Cuenta`),
  KEY `ID_Titular` (`ID_Titular`),
  CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`ID_Titular`) REFERENCES `usuarios` (`Identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas`
--

LOCK TABLES `cuentas` WRITE;
/*!40000 ALTER TABLE `cuentas` DISABLE KEYS */;
INSERT INTO `cuentas` VALUES ('CTA-1001','1001','Ahorros',1500000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1002','1002','Corriente',2500000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1003','1003','Ahorros',500000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1004','1004','Ahorros',4500000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1005','1005','Ahorros',120000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1011','1011','Ahorros',300000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1012','1012','Ahorros',450000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1013','1013','Ahorros',120000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1014','1014','Ahorros',900000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1015','1015','Ahorros',150000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1016','1016','Ahorros',200000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1017','1017','Ahorros',550000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1018','1018','Ahorros',780000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1019','1019','Ahorros',125000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-1020','1020','Ahorros',340000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-2001','2001','Empresarial',50000000.00,'COP','Activa','2026-03-17 21:44:57'),('CTA-2002','2002','Empresarial',80000000.00,'COP','Activa','2026-03-17 21:44:57');
/*!40000 ALTER TABLE `cuentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamos`
--

DROP TABLE IF EXISTS `prestamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamos` (
  `ID_Prestamo` int NOT NULL AUTO_INCREMENT,
  `ID_Cliente` varchar(20) NOT NULL,
  `Monto_Solicitado` decimal(18,2) NOT NULL,
  `Monto_Aprobado` decimal(18,2) DEFAULT '0.00',
  `Tasa_Interes` decimal(5,2) DEFAULT NULL,
  `Plazo_Meses` int DEFAULT NULL,
  `Estado_Prestamo` enum('En estudio','Aprobado','Rechazado','Desembolsado') DEFAULT 'En estudio',
  `Fecha_Solicitud` datetime DEFAULT CURRENT_TIMESTAMP,
  `ID_Analista_Asignado` int DEFAULT NULL,
  `Cuenta_Desembolso` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID_Prestamo`),
  KEY `ID_Cliente` (`ID_Cliente`),
  KEY `ID_Analista_Asignado` (`ID_Analista_Asignado`),
  KEY `Cuenta_Desembolso` (`Cuenta_Desembolso`),
  CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`ID_Cliente`) REFERENCES `usuarios` (`Identificacion`),
  CONSTRAINT `prestamos_ibfk_2` FOREIGN KEY (`ID_Analista_Asignado`) REFERENCES `usuarios` (`ID_Usuario`),
  CONSTRAINT `prestamos_ibfk_3` FOREIGN KEY (`Cuenta_Desembolso`) REFERENCES `cuentas` (`Numero_Cuenta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamos`
--

LOCK TABLES `prestamos` WRITE;
/*!40000 ALTER TABLE `prestamos` DISABLE KEYS */;
INSERT INTO `prestamos` VALUES (1,'1001',5000000.00,5000000.00,1.50,12,'Desembolsado','2026-03-17 21:44:57',8,NULL),(2,'1002',10000000.00,0.00,2.00,24,'En estudio','2026-03-17 21:44:57',8,NULL),(3,'2001',50000000.00,50000000.00,1.20,36,'Desembolsado','2026-03-17 21:44:57',8,NULL),(4,'1003',2000000.00,2000000.00,1.80,6,'Aprobado','2026-03-17 21:44:57',8,NULL);
/*!40000 ALTER TABLE `prestamos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferencias`
--

DROP TABLE IF EXISTS `transferencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transferencias` (
  `ID_Transferencia` int NOT NULL AUTO_INCREMENT,
  `Cuenta_Origen` varchar(20) NOT NULL,
  `Cuenta_Destino` varchar(20) NOT NULL,
  `Monto` decimal(18,2) NOT NULL,
  `Fecha_Operacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `Estado_Transferencia` enum('Ejecutada','En espera de aprobación','Rechazada','Vencida') DEFAULT 'Ejecutada',
  `ID_Usuario_Origen` int NOT NULL,
  `ID_Usuario_Autorizador` int DEFAULT NULL,
  PRIMARY KEY (`ID_Transferencia`),
  KEY `Cuenta_Origen` (`Cuenta_Origen`),
  KEY `Cuenta_Destino` (`Cuenta_Destino`),
  KEY `ID_Usuario_Origen` (`ID_Usuario_Origen`),
  KEY `ID_Usuario_Autorizador` (`ID_Usuario_Autorizador`),
  CONSTRAINT `transferencias_ibfk_1` FOREIGN KEY (`Cuenta_Origen`) REFERENCES `cuentas` (`Numero_Cuenta`),
  CONSTRAINT `transferencias_ibfk_2` FOREIGN KEY (`Cuenta_Destino`) REFERENCES `cuentas` (`Numero_Cuenta`),
  CONSTRAINT `transferencias_ibfk_3` FOREIGN KEY (`ID_Usuario_Origen`) REFERENCES `usuarios` (`ID_Usuario`),
  CONSTRAINT `transferencias_ibfk_4` FOREIGN KEY (`ID_Usuario_Autorizador`) REFERENCES `usuarios` (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferencias`
--

LOCK TABLES `transferencias` WRITE;
/*!40000 ALTER TABLE `transferencias` DISABLE KEYS */;
INSERT INTO `transferencias` VALUES (1,'CTA-1001','CTA-1002',50000.00,'2026-03-17 21:44:57','Ejecutada',1,NULL),(2,'CTA-1002','CTA-1001',20000.00,'2026-03-17 21:44:57','Ejecutada',2,NULL),(3,'CTA-1003','CTA-1005',15000.00,'2026-03-17 21:44:57','Ejecutada',3,NULL),(4,'CTA-1004','CTA-1001',100000.00,'2026-03-17 21:44:57','Ejecutada',4,NULL),(5,'CTA-2001','CTA-1005',500000.00,'2026-03-17 21:44:57','Ejecutada',6,NULL),(6,'CTA-2002','CTA-1002',1200000.00,'2026-03-17 21:44:57','Ejecutada',7,NULL),(7,'CTA-1011','CTA-1001',5000.00,'2026-03-17 21:44:57','Ejecutada',11,NULL),(8,'CTA-1012','CTA-1002',10000.00,'2026-03-17 21:44:57','Ejecutada',12,NULL),(9,'CTA-1013','CTA-1003',25000.00,'2026-03-17 21:44:57','Ejecutada',13,NULL),(10,'CTA-1014','CTA-1004',35000.00,'2026-03-17 21:44:57','Ejecutada',14,NULL);
/*!40000 ALTER TABLE `transferencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `ID_Usuario` int NOT NULL AUTO_INCREMENT,
  `Identificacion` varchar(20) NOT NULL,
  `Nombre_Completo` varchar(150) NOT NULL,
  `Correo_Electronico` varchar(100) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Direccion` text,
  `Rol` enum('Persona Natural','Cliente Empresa','Ventanilla','Comercial','Empleado Empresa','Supervisor Empresa','Analista Interno') NOT NULL,
  `Estado` enum('Activo','Inactivo','Bloqueado') DEFAULT 'Activo',
  `Fecha_Registro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Usuario`),
  UNIQUE KEY `Identificacion` (`Identificacion`),
  UNIQUE KEY `Correo_Electronico` (`Correo_Electronico`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'1001','Juan Alberto Perez','juan.perez@email.com','3001000001',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(2,'1002','Maria Paula Lopez','maria.lopez@email.com','3001000002',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(3,'1003','Carlos Eduardo Ruiz','carlos.ruiz@email.com','3001000003',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(4,'1004','Ana Milena Gomez','ana.gomez@email.com','3001000004',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(5,'1005','Luis Felipe Prado','luis.prado@email.com','3001000005',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(6,'2001','Tecnología Global SAS','contacto@tecglobal.com','6042000001',NULL,'Cliente Empresa','Activo','2026-03-17 21:44:57'),(7,'2002','Constructoras Unidas','admin@conunidas.com','6042000002',NULL,'Cliente Empresa','Activo','2026-03-17 21:44:57'),(8,'3001','Andres Analista','andres.a@banco.com','3001000008',NULL,'Analista Interno','Activo','2026-03-17 21:44:57'),(9,'3002','Sandra Ventanilla','sandra.v@banco.com','3001000009',NULL,'Ventanilla','Activo','2026-03-17 21:44:57'),(10,'3003','Pedro Comercial','pedro.c@banco.com','3001000010',NULL,'Comercial','Activo','2026-03-17 21:44:57'),(11,'1011','Usuario Prueba 11','user11@email.com','3001000011',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(12,'1012','Usuario Prueba 12','user12@email.com','3001000012',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(13,'1013','Usuario Prueba 13','user13@email.com','3001000013',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(14,'1014','Usuario Prueba 14','user14@email.com','3001000014',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(15,'1015','Usuario Prueba 15','user15@email.com','3001000015',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(16,'1016','Usuario Prueba 16','user16@email.com','3001000016',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(17,'1017','Usuario Prueba 17','user17@email.com','3001000017',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(18,'1018','Usuario Prueba 18','user18@email.com','3001000018',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(19,'1019','Usuario Prueba 19','user19@email.com','3001000019',NULL,'Persona Natural','Activo','2026-03-17 21:44:57'),(20,'1020','Usuario Prueba 20','user20@email.com','3001000020',NULL,'Persona Natural','Activo','2026-03-17 21:44:57');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-17 21:54:43
