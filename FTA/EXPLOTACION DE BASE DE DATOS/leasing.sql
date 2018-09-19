-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-09-2016 a las 17:57:49
-- Versión del servidor: 5.6.17
-- Versión de PHP: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `leasing`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_autos`
--

CREATE TABLE IF NOT EXISTS `categoria_autos` (
  `descripcion` varchar(20) DEFAULT NULL,
  `tarifaxdia` int(11) DEFAULT NULL,
  `idcategoria` int(11) NOT NULL,
  `idvehiculo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `categoria_autos`
--

INSERT INTO `categoria_autos` (`descripcion`, `tarifaxdia`, `idcategoria`, `idvehiculo`) VALUES
('SEDAN 4 PUERTAS', 1200, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `idcliente` int(11) NOT NULL,
  `genero` varchar(20) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `apellido` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `calle` varchar(20) DEFAULT NULL,
  `nrro` int(11) DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `recomendado` int(11) DEFAULT NULL,
  `idempleado` int(4) DEFAULT NULL,
  `localidad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  KEY `idempleado` (`idempleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idcliente`, `genero`, `dni`, `nombre`, `apellido`, `telefono`, `calle`, `nrro`, `dia`, `mes`, `ano`, `recomendado`, `idempleado`, `localidad`) VALUES
(1, 'f', '33333333', 'ROSANA', 'GARCIA', '4444-75351', 'AVDADF ', 3345, 1, 10, 1963, NULL, 1, NULL),
(2, 'FF', '33.3333.3333', 'ALBERTO', 'SSSSSS', '4444.44444', 'SFAFASDF', 6358, 11, 10, 1985, NULL, 1, NULL),
(3, 'F', '15.456.789', 'GABRIELA', 'SSASFSDF', '15-403-5290', NULL, 5375, 1, 3, 1985, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `idempleado` int(11) NOT NULL,
  `genero` varchar(20) DEFAULT NULL,
  `dni` varchar(20) DEFAULT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `apellido` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `calle` varchar(20) DEFAULT NULL,
  `nrro` int(11) DEFAULT NULL,
  `dia` int(11) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `recomendado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idempleado`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idempleado`, `genero`, `dni`, `nombre`, `apellido`, `telefono`, `calle`, `nrro`, `dia`, `mes`, `ano`, `recomendado`) VALUES
(1, 'M', '33.444.5555', 'DANIEL', 'SSSSSSS', '4444-4444', 'ADFASDFADF', 2567, 1, 2, 1970, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE IF NOT EXISTS `marca` (
  `idmarcar` int(11) NOT NULL,
  `descripcion` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idmarcar`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`idmarcar`, `descripcion`) VALUES
(1, 'FORD'),
(2, 'RENAULT'),
(3, 'HONDA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo`
--

CREATE TABLE IF NOT EXISTS `modelo` (
  `idmodelo` int(11) NOT NULL,
  `descripcion` varchar(20) NOT NULL,
  `idmarca` int(11) NOT NULL,
  PRIMARY KEY (`idmodelo`),
  KEY `idmarca` (`idmarca`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `modelo`
--

INSERT INTO `modelo` (`idmodelo`, `descripcion`, `idmarca`) VALUES
(1, 'FORD ', 1),
(2, 'MEGANE', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE IF NOT EXISTS `vehiculo` (
  `idvehiculo` int(11) NOT NULL,
  `patente` varchar(20) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `idalquiler` int(11) DEFAULT NULL,
  `costofinal` int(11) DEFAULT NULL,
  `fecha_retiro` date DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL,
  `idcategoria` int(11) DEFAULT NULL,
  `idmodelo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idvehiculo`),
  KEY `idmodelo` (`idmodelo`),
  KEY `idcategoria` (`idcategoria`),
  KEY `idcliente` (`idcliente`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`idvehiculo`, `patente`, `color`, `ano`, `idalquiler`, `costofinal`, `fecha_retiro`, `fecha_entrega`, `idcliente`, `idcategoria`, `idmodelo`) VALUES
(1, 'akk-173', 'marron', 2012, 1, 1250, '2016-09-15', '2016-09-16', 1, 1, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_fk` FOREIGN KEY (`idempleado`) REFERENCES `empleado` (`idempleado`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `modelo`
--
ALTER TABLE `modelo`
  ADD CONSTRAINT `modelo_fk` FOREIGN KEY (`idmarca`) REFERENCES `marca` (`idmarcar`);

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `vehiculo_fk` FOREIGN KEY (`idmodelo`) REFERENCES `modelo` (`idmodelo`),
  ADD CONSTRAINT `vehiculo_fk1` FOREIGN KEY (`idcategoria`) REFERENCES `categoria_autos` (`idcategoria`),
  ADD CONSTRAINT `vehiculo_fk2` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
