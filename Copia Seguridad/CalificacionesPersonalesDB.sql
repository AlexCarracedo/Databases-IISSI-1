-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         12.0.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando datos para la tabla notas personales.asignaturas: ~20 rows (aproximadamente)
DELETE FROM `asignaturas`;
INSERT INTO `asignaturas` (`asignaturaId`, `nombre`, `acronimo`, `creditos`, `anyo`) VALUES
	(1, 'Álgebra Básica', 'AB', 6, 1),
	(2, 'Cálculo Numérico 1', 'CN 1', 6, 1),
	(3, 'Álgebra Lineal y Geometría 1', 'ALG 1', 12, 1),
	(4, 'Fundamentos de Programación', 'FP', 12, 1),
	(5, 'Estructura de Computadores', 'EdC', 6, 1),
	(6, 'Circuitos Electrónicos Digitales', 'CED', 6, 1),
	(7, 'Matemáticas Discretas', 'MD', 6, 1),
	(8, 'Cálculo Infinitesimal', 'CI', 12, 1),
	(9, 'Administración de Empresas', 'AE', 6, 1),
	(10, 'Introducción a la Ingeniería de Softwares y Sistemas Informáticos 1', 'IISSI 1', 6, 2),
	(11, 'Topología', 'Top', 6, 2),
	(12, 'Física 1', 'Fi 1', 6, 2),
	(13, 'Diferenciación de Funciones de Varias Variables', 'DFVV', 6, 2),
	(14, 'Series de Funciones e Integral de Lebesgue', 'SFIL', 6, 2),
	(15, 'Análisis y Diseño de Datos y Algoritmos', 'ADDA', 12, 2),
	(16, 'Introducción a la Ingeniería de Softwares y Sistemas Informáticos 2', 'IISSI 2', 6, 2),
	(17, 'Física 2', 'Fi 2', 6, 2),
	(18, 'Cálculo Numérico 2', 'CN 2', 6, 2),
	(19, 'Integración de Funciones de Varias Variables', 'IFVV', 6, 2),
	(20, 'Ecuaciones Diferenciales Ordinarias', 'EDO', 6, 2);

-- Volcando datos para la tabla notas personales.notas: ~9 rows (aproximadamente)
DELETE FROM `notas`;
INSERT INTO `notas` (`notaId`, `nota`, `matriculaHonor`, `convocatoria`, `asignaturaId`) VALUES
	(1, 6.0, 0, 0, 1),
	(2, 8.4, 0, 0, 2),
	(3, 7.1, 0, 0, 3),
	(4, 7.3, 0, 0, 4),
	(5, 6.8, 0, 0, 5),
	(6, 9.6, 0, 0, 6),
	(7, 9.8, 1, 0, 7),
	(8, 9.3, 0, 0, 8),
	(9, 8.3, 0, 0, 9);

-- Volcando datos para la tabla notas personales.notasparciales: ~3 rows (aproximadamente)
DELETE FROM `notasparciales`;
INSERT INTO `notasparciales` (`notaParcialId`, `numeroExamen`, `notaParcial`, `actividad`, `asignaturaId`) VALUES
	(1, 1, 8.40, 'Teoría', 10),
	(2, 1, 6.50, NULL, 12),
	(3, 1, 9.75, NULL, 13);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
