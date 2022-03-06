-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: CICLISTASCOMPLETA
-- ------------------------------------------------------
-- Server version	5.5.54-0ubuntu0.14.04.1

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


-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CICLISTASCOMPLETA
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CICLISTASCOMPLETA` ;

-- -----------------------------------------------------
-- Schema CICLISTASCOMPLETA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CICLISTASCOMPLETA` DEFAULT CHARACTER SET utf8 ;
USE `CICLISTASCOMPLETA` ;
--
-- Table structure for table `ciclistas`
--

DROP TABLE IF EXISTS `ciclistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ciclistas` (
  `dorsal` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `nomeq` varchar(45) NOT NULL,
  PRIMARY KEY (`dorsal`),
  KEY `fk_ciclistas_equipos_idx` (`nomeq`),
  CONSTRAINT `fk_ciclistas_equipos` FOREIGN KEY (`nomeq`) REFERENCES `equipos` (`nombre`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclistas`
--

LOCK TABLES `ciclistas` WRITE;
/*!40000 ALTER TABLE `ciclistas` DISABLE KEYS */;
INSERT INTO `ciclistas` VALUES (1,'Miguel Induráin',21,'Banesto'),(2,'Pedro Delgado',29,'Banesto'),(3,'Alex Zulle',20,'Navigare'),(4,'Alessio di Basco',30,'TVM'),(5,'Armand',17,'Amore Vita'),(8,'Jean van Poppel',24,'Bresciale-Refin'),(9,'Maximo Podel',17,'Telecom'),(10,'Mario Cipollini',31,'Carrera'),(11,'Eddie Seigneur',20,'Amore Vita'),(12,'Alberto Contador',34,'Bresciale-Refin'),(13,'Gianni Bugno',24,'Gatorade'),(15,'Jesús Montoya',25,'Amore Vita'),(16,'Dimitri Konishev',27,'Amore Vita'),(17,'Bruno Lealli',30,'Amore Vita'),(20,'Alfonso Gutiérrez',27,'Navigare'),(22,'Giorgio Furlan',22,'Kelme'),(26,'Mikel Zarrabeitia',30,'Carrera'),(27,'Laurent Jalabert',22,'Banesto'),(30,'Melchor Mauri',26,'Mapei-Clas'),(31,'Per Pedersen',33,'Banesto'),(32,'Tony Rominger',31,'Kelme'),(33,'Stefano della Sveitia',26,'Amore Vita'),(34,'Claudio Chiapucci',23,'Amore Vita'),(35,'Gian Mateo Faluca',34,'TVM');
/*!40000 ALTER TABLE `ciclistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipos` (
  `nombre` varchar(45) NOT NULL,
  `director` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES ('Amore Vita','Ricardo Padacci'),('Banesto','Miguel Echeverría'),('Bresciale-Refin','Pietro Armani'),('Carrera','Luigi Petroni'),('Gatorade','Gian Luca Pacelli'),('Kelme','Álvaro Pino'),('Mapei-Clas','Juan Fernández'),('Navigare','Lorenzo Sciacci'),('Telecom','Morgan Reikcard'),('TVM','Steevens Henk');
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etapas`
--

DROP TABLE IF EXISTS `etapas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etapas` (
  `numero` int(11) NOT NULL,
  `numkms` int(11) DEFAULT NULL,
  `salida` varchar(45) DEFAULT NULL,
  `llegada` varchar(45) DEFAULT NULL,
  `dorsalganador` int(11) DEFAULT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etapas`
--

LOCK TABLES `etapas` WRITE;
/*!40000 ALTER TABLE `etapas` DISABLE KEYS */;
INSERT INTO `etapas` VALUES (1,35,'Valladolid','Ávila',1),(2,70,'Salamanca','Zamora',2),(3,150,'Zamora','Almendralejo',1),(4,330,'Córdoba','Granada',1),(5,150,'Granada','Almería',3);
/*!40000 ALTER TABLE `etapas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `llevar`
--

DROP TABLE IF EXISTS `llevar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `llevar` (
  `dorsal` int(11) NOT NULL,
  `numetapa` int(11) NOT NULL,
  `codmaillot` varchar(45) NOT NULL,
  PRIMARY KEY (`dorsal`,`numetapa`),
  KEY `fk_maillots_has_ciclistas1_ciclistas1_idx` (`dorsal`),
  KEY `fk_maillots_has_ciclistas1_maillots1_idx` (`codmaillot`),
  KEY `fk_llevar_etapas1_idx` (`numetapa`),
  CONSTRAINT `fk_maillots_has_ciclistas1_maillots1` FOREIGN KEY (`codmaillot`) REFERENCES `maillots` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_maillots_has_ciclistas1_ciclistas1` FOREIGN KEY (`dorsal`) REFERENCES `ciclistas` (`dorsal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_llevar_etapas1` FOREIGN KEY (`numetapa`) REFERENCES `etapas` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `llevar`
--

LOCK TABLES `llevar` WRITE;
/*!40000 ALTER TABLE `llevar` DISABLE KEYS */;
INSERT INTO `llevar` VALUES (1,3,'MGE'),(1,4,'MGE'),(2,2,'MGE'),(3,1,'MGE'),(4,1,'MMO'),(5,2,'MMO'),(3,4,'MMV'),(3,3,'MRE');
/*!40000 ALTER TABLE `llevar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maillots`
--

DROP TABLE IF EXISTS `maillots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maillots` (
  `codigo` varchar(45) NOT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `premio` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maillots`
--

LOCK TABLES `maillots` WRITE;
/*!40000 ALTER TABLE `maillots` DISABLE KEYS */;
INSERT INTO `maillots` VALUES ('MGE','General','Amarillo',1000000),('MMO','Montaña','Blanco y Rojo',500000),('MMS','Más Sufrido','Estrellitas Rojas',400000),('MMV','Metas Volantes','Rojo',400000),('MRE','Regularidad','Verde',300000),('MSE','Sprints Especiales','Rosa',300000);
/*!40000 ALTER TABLE `maillots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maillots_has_ciclistas`
--

DROP TABLE IF EXISTS `maillots_has_ciclistas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maillots_has_ciclistas` (
  `maillots_codigo` varchar(3) NOT NULL,
  `ciclistas_dorsal` int(11) NOT NULL,
  PRIMARY KEY (`maillots_codigo`,`ciclistas_dorsal`),
  KEY `fk_maillots_has_ciclistas_ciclistas1_idx` (`ciclistas_dorsal`),
  KEY `fk_maillots_has_ciclistas_maillots1_idx` (`maillots_codigo`),
  CONSTRAINT `fk_maillots_has_ciclistas_maillots1` FOREIGN KEY (`maillots_codigo`) REFERENCES `maillots` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_maillots_has_ciclistas_ciclistas1` FOREIGN KEY (`ciclistas_dorsal`) REFERENCES `ciclistas` (`dorsal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maillots_has_ciclistas`
--

LOCK TABLES `maillots_has_ciclistas` WRITE;
/*!40000 ALTER TABLE `maillots_has_ciclistas` DISABLE KEYS */;
/*!40000 ALTER TABLE `maillots_has_ciclistas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puertos`
--

DROP TABLE IF EXISTS `puertos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puertos` (
  `nombre` varchar(30) NOT NULL,
  `altura` int(11) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `pendiente` int(11) DEFAULT NULL,
  `numetapa` int(11) NOT NULL,
  `dorsalganador` int(11) NOT NULL,
  PRIMARY KEY (`nombre`),
  KEY `fk_puertos_etapas1_idx` (`numetapa`),
  KEY `fk_puertos_ciclistas1_idx` (`dorsalganador`),
  CONSTRAINT `fk_puertos_etapas1` FOREIGN KEY (`numetapa`) REFERENCES `etapas` (`numero`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_puertos_ciclistas1` FOREIGN KEY (`dorsalganador`) REFERENCES `ciclistas` (`dorsal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puertos`
--

LOCK TABLES `puertos` WRITE;
/*!40000 ALTER TABLE `puertos` DISABLE KEYS */;
INSERT INTO `puertos` VALUES ('Andorra',1673,'E',9,4,2),('Angliru',1570,'E',10,4,2),('La Ragua',2041,'1',7,2,3),('Lagos de Covadonga',1134,'E',7,4,2),('Navacerrada',1858,'E',8,4,3),('Pajares',1300,'1',6,3,1),('Peña Cabarga',690,'1',8,1,1);
/*!40000 ALTER TABLE `puertos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-02 19:02:12
