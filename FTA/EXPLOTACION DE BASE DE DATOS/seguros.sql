-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-09-2016 a las 17:44:59
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `seguros`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accidente`
--

CREATE TABLE IF NOT EXISTS `accidente` (
  `parte` varchar(15) NOT NULL,
  `localidad` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `id-conductor` int(4) NOT NULL,
  `importe-daños` decimal(12,0) NOT NULL,
  PRIMARY KEY (`parte`),
  KEY `id-conductor` (`id-conductor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `accidente`
--

INSERT INTO `accidente` (`parte`, `localidad`, `fecha`, `id-conductor`, `importe-daños`) VALUES
('AR2196', 'CASEROS', '2016-09-01', 1, '2100'),
('AR3 525', 'HURLINGHAN', '2016-08-15', 2, '3571');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `choche`
--

CREATE TABLE IF NOT EXISTS `choche` (
  `matricula` varchar(10) NOT NULL,
  `modelo` varchar(20) NOT NULL,
  `año` int(4) NOT NULL,
  `id-conductor` int(4) NOT NULL,
  PRIMARY KEY (`matricula`),
  KEY `id-conductor` (`id-conductor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `choche`
--

INSERT INTO `choche` (`matricula`, `modelo`, `año`, `id-conductor`) VALUES
('ABC1 144', 'RENAULT TWINGO', 2005, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `id-conductor` int(4) NOT NULL,
  `localidad` varchar(26) NOT NULL,
  `calle` varchar(20) NOT NULL,
  `nro` int(4) DEFAULT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id-conductor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id-conductor`, `localidad`, `calle`, `nro`, `nombre`) VALUES
(1, 'SAN MARTIN', 'CALLE 54', 2114, 'SANCHEZ ROBERTO');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `choche`
--
ALTER TABLE `choche`
  ADD CONSTRAINT `choche_fk` FOREIGN KEY (`id-conductor`) REFERENCES `persona` (`id-conductor`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
