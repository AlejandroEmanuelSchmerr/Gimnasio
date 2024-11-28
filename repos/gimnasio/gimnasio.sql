-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-11-2024 a las 03:59:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gimnasio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comidas`
--

CREATE TABLE `comidas` (
  `id` int(11) NOT NULL,
  `dieta_id` int(11) NOT NULL,
  `dia` varchar(20) NOT NULL,
  `tipo_comida` enum('desayuno','almuerzo','merienda','cena') NOT NULL,
  `comida` varchar(100) NOT NULL,
  `cantidad` varchar(100) NOT NULL,
  `ingredientes` text NOT NULL,
  `preparacion` text NOT NULL,
  `semana` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comidas`
--

INSERT INTO `comidas` (`id`, `dieta_id`, `dia`, `tipo_comida`, `comida`, `cantidad`, `ingredientes`, `preparacion`, `semana`) VALUES
(57, 1, 'Lunes', 'desayuno', 'Tortilla de espinacas', '4 claras', 'Claras de huevo, espinacas, sal', 'Batir y cocinar en sartén.', 2),
(58, 1, 'Lunes', 'almuerzo', 'Filete de ternera a la plancha', '200g', 'Ternera, especias', 'Cocinar a la plancha.', 2),
(59, 1, 'Lunes', 'merienda', 'Frutos secos', '30g', 'Almendras, nueces', 'Servir.', 2),
(60, 1, 'Lunes', 'cena', 'Salmón a la parrilla', '150g', 'Salmón, limón, especias', 'Asar a la parrilla.', 2),
(61, 1, 'Martes', 'desayuno', 'Avena con frutas', '1 taza', 'Avena, plátano, miel', 'Cocinar avena y añadir frutas.', 2),
(62, 1, 'Martes', 'almuerzo', 'Pasta integral con tomate', '150g', 'Pasta integral, salsa de tomate', 'Cocinar la pasta y mezclar con salsa.', 2),
(63, 1, 'Martes', 'merienda', 'Yogur con nueces', '1 taza', 'Yogur natural, nueces', 'Mezclar y servir frío.', 2),
(64, 1, 'Martes', 'cena', 'Pechuga de pollo con verduras', '150g', 'Pechuga de pollo, brócoli, zanahoria', 'Asar el pollo y hervir las verduras.', 2),
(65, 1, 'Miércoles', 'desayuno', 'Smoothie verde', '1 vaso', 'Espinacas, plátano, leche de almendra', 'Mezclar en licuadora.', 2),
(66, 1, 'Miércoles', 'almuerzo', 'Ensalada de atún', '1 plato', 'Atún, lechuga, tomate', 'Mezclar los ingredientes.', 2),
(67, 1, 'Miércoles', 'merienda', 'Barra de cereales', '1 unidad', 'Cereales integrales, frutos secos', 'Servir.', 2),
(68, 1, 'Miércoles', 'cena', 'Tacos de pollo', '2 tacos', 'Pollo desmenuzado, tortillas integrales, lechuga', 'Armar los tacos y servir.', 2),
(69, 1, 'Jueves', 'desayuno', 'Huevos revueltos con champiñones', '2 huevos', 'Huevos, champiñones, cebolla', 'Revolver y cocinar.', 2),
(70, 1, 'Jueves', 'almuerzo', 'Pollo al curry con arroz', '200g', 'Pechuga de pollo, arroz, curry', 'Cocinar el pollo con curry y servir con arroz.', 2),
(71, 1, 'Jueves', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, leche de avena', 'Mezclar en licuadora.', 2),
(72, 1, 'Jueves', 'cena', 'Sopa de lentejas', '1 plato', 'Lentejas, zanahorias, cebolla', 'Cocinar a fuego lento.', 2),
(73, 1, 'Viernes', 'desayuno', 'Pan integral con aguacate', '1 rebanada', 'Pan integral, aguacate', 'Untar aguacate sobre el pan.', 2),
(74, 1, 'Viernes', 'almuerzo', 'Salmón al horno con verduras', '200g', 'Salmón, espárragos, especias', 'Hornear el salmón y servir con verduras.', 2),
(75, 1, 'Viernes', 'merienda', 'Fruta fresca', '1 pieza', 'Manzana, pera', 'Servir fresca.', 2),
(76, 1, 'Viernes', 'cena', 'Ensalada César', '1 plato', 'Lechuga, pollo, aderezo César', 'Mezclar los ingredientes.', 2),
(77, 1, 'Sábado', 'desayuno', 'Batido de avena', '1 vaso', 'Avena, plátano, leche', 'Mezclar en licuadora.', 2),
(78, 1, 'Sábado', 'almuerzo', 'Pechuga de pollo a la plancha', '200g', 'Pechuga de pollo, especias', 'Cocinar a la plancha.', 2),
(79, 1, 'Sábado', 'merienda', 'Galletas de avena', '2 unidades', 'Avena, miel', 'Hornear y servir.', 2),
(80, 1, 'Sábado', 'cena', 'Pasta con salsa pesto', '150g', 'Pasta integral, pesto', 'Cocinar la pasta y mezclar con pesto.', 2),
(81, 1, 'Domingo', 'desayuno', 'Tortilla de espinacas', '4 claras', 'Claras de huevo, espinacas, sal', 'Batir y cocinar en sartén.', 2),
(82, 1, 'Domingo', 'almuerzo', 'Quinoa con pollo', '150g', 'Quinoa, pollo a la plancha', 'Cocinar y mezclar.', 2),
(83, 1, 'Domingo', 'merienda', 'Batido de frutas', '1 vaso', 'Frutas, leche', 'Mezclar en licuadora.', 2),
(84, 1, 'Domingo', 'cena', 'Sopa de verduras', '1 plato', 'Verduras, caldo de pollo', 'Cocinar a fuego lento.', 2),
(85, 1, 'Lunes', 'desayuno', 'Tortilla de claras', '4 claras', 'Claras de huevo, sal', 'Batir y cocinar en sartén.', 1),
(86, 1, 'Lunes', 'almuerzo', 'Pollo a la plancha', '200g', 'Pechuga de pollo, especias', 'Cocinar a la plancha.', 1),
(87, 1, 'Lunes', 'merienda', 'Yogur natural', '1 taza', 'Yogur, frutas', 'Servir frío.', 1),
(88, 1, 'Lunes', 'cena', 'Ensalada de atún', '150g', 'Atún, lechuga, tomate', 'Mezclar y servir.', 1),
(89, 1, 'Martes', 'desayuno', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, leche', 'Mezclar en licuadora.', 1),
(90, 1, 'Martes', 'almuerzo', 'Pasta integral', '150g', 'Pasta, salsa de tomate', 'Cocinar y servir.', 1),
(91, 1, 'Martes', 'merienda', 'Fruta fresca', '1 pieza', 'Manzana, plátano', 'Servir fresco.', 1),
(92, 1, 'Martes', 'cena', 'Salmón al horno', '200g', 'Salmón, especias', 'Hornear y servir.', 1),
(93, 1, 'Miércoles', 'desayuno', 'Avena', '100g', 'Avena, leche', 'Cocinar hasta espesar.', 1),
(94, 1, 'Miércoles', 'almuerzo', 'Bowl de quinoa', '200g', 'Quinoa, verduras', 'Cocinar y mezclar.', 1),
(95, 1, 'Miércoles', 'merienda', 'Frutos secos', '30g', 'Nueces, almendras', 'Servir.', 1),
(96, 1, 'Miércoles', 'cena', 'Pechuga de pollo con verduras', '200g', 'Pollo, brócoli', 'Cocinar al vapor.', 1),
(97, 1, 'Jueves', 'desayuno', 'Huevos revueltos', '2 huevos', 'Huevos, cebolla', 'Revolver y cocinar.', 1),
(98, 1, 'Jueves', 'almuerzo', 'Tacos de carne', '2 tacos', 'Carne, tortillas', 'Armar y servir.', 1),
(99, 1, 'Jueves', 'merienda', 'Galletas de avena', '2 galletas', 'Avena, miel', 'Hornear.', 1),
(100, 1, 'Jueves', 'cena', 'Sopa de verduras', '1 plato', 'Verduras, caldo', 'Cocinar a fuego lento.', 1),
(101, 1, 'Viernes', 'desayuno', 'Smoothie verde', '1 vaso', 'Espinacas, plátano', 'Mezclar en licuadora.', 1),
(102, 1, 'Viernes', 'almuerzo', 'Hamburguesa de pavo', '1 unidad', 'Carne de pavo, pan', 'Armar y cocinar.', 1),
(103, 1, 'Viernes', 'merienda', 'Batido de frutas', '1 vaso', 'Frutas, leche', 'Mezclar en licuadora.', 1),
(104, 1, 'Viernes', 'cena', 'Tortilla de verduras', '1 unidad', 'Verduras, huevos', 'Cocinar en sartén.', 1),
(105, 1, 'Sábado', 'desayuno', 'Pan integral con aguacate', '1 rebanada', 'Pan, aguacate', 'Untar aguacate.', 1),
(106, 1, 'Sábado', 'almuerzo', 'Ensalada César', '1 plato', 'Lechuga, pollo, aderezo', 'Mezclar y servir.', 1),
(107, 1, 'Sábado', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, agua', 'Mezclar en licuadora.', 1),
(108, 1, 'Sábado', 'cena', 'Pizza integral', '1 rebanada', 'Masa integral, ingredientes', 'Hornear y servir.', 1),
(109, 1, 'Domingo', 'desayuno', 'Panqueques de avena', '2 unidades', 'Avena, leche, huevo', 'Cocinar en sartén.', 1),
(110, 1, 'Domingo', 'almuerzo', 'Pollo al horno con papas', '200g', 'Pechuga de pollo, papas', 'Hornear y servir.', 1),
(111, 1, 'Domingo', 'merienda', 'Fruta fresca', '1 pieza', 'Naranja, kiwi', 'Servir fresca.', 1),
(112, 1, 'Domingo', 'cena', 'Sopa de lentejas', '1 plato', 'Lentejas, zanahorias, especias', 'Cocinar a fuego lento.', 1),
(113, 1, 'Lunes', 'desayuno', 'Tortilla de espinacas', '4 claras', 'Claras de huevo, espinacas', 'Batir y cocinar en sartén con espinacas.', 3),
(114, 1, 'Lunes', 'almuerzo', 'Pollo al curry', '200g', 'Pechuga de pollo, especias, curry', 'Cocinar a la plancha con curry.', 3),
(115, 1, 'Lunes', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, leche de almendras', 'Mezclar en licuadora.', 3),
(116, 1, 'Lunes', 'cena', 'Ensalada de garbanzos', '1 plato', 'Garbanzos, tomate, pepino', 'Mezclar y servir.', 3),
(117, 1, 'Martes', 'desayuno', 'Avena con frutos rojos', '100g', 'Avena, frutos rojos, leche', 'Cocinar y agregar frutos rojos.', 3),
(118, 1, 'Martes', 'almuerzo', 'Salmón a la plancha', '200g', 'Salmón, limón, especias', 'Cocinar a la plancha.', 3),
(119, 1, 'Martes', 'merienda', 'Tostadas integrales', '2 rebanadas', 'Pan integral, aguacate', 'Untar aguacate en tostadas.', 3),
(120, 1, 'Martes', 'cena', 'Sopa de verduras y quinoa', '1 plato', 'Verduras, quinoa, caldo', 'Cocinar a fuego lento.', 3),
(121, 1, 'Miércoles', 'desayuno', 'Batido verde', '1 vaso', 'Espinacas, plátano, leche de almendras', 'Mezclar en licuadora.', 3),
(122, 1, 'Miércoles', 'almuerzo', 'Pechuga de pavo al horno', '200g', 'Pechuga de pavo, especias', 'Hornear con especias.', 3),
(123, 1, 'Miércoles', 'merienda', 'Yogur natural con nueces', '1 taza', 'Yogur natural, nueces', 'Servir frío con nueces.', 3),
(124, 1, 'Miércoles', 'cena', 'Tacos vegetarianos', '2 tacos', 'Tortillas, verduras, aguacate', 'Armar tacos con verduras.', 3),
(125, 1, 'Jueves', 'desayuno', 'Smoothie de plátano', '1 vaso', 'Plátano, leche, avena', 'Mezclar en licuadora.', 3),
(126, 1, 'Jueves', 'almuerzo', 'Pollo asado con batatas', '200g', 'Pechuga de pollo, batatas', 'Asar con especias.', 3),
(127, 1, 'Jueves', 'merienda', 'Frutos secos', '30g', 'Nueces, almendras, pasas', 'Servir en porción.', 3),
(128, 1, 'Jueves', 'cena', 'Pizza de coliflor', '1 porción', 'Base de coliflor, tomate, queso', 'Hornear con ingredientes.', 3),
(129, 1, 'Viernes', 'desayuno', 'Tostadas con mantequilla de maní', '2 rebanadas', 'Pan integral, mantequilla de maní', 'Untar mantequilla de maní.', 3),
(130, 1, 'Viernes', 'almuerzo', 'Ensalada de atún', '1 plato', 'Atún, lechuga, tomate, aderezo', 'Mezclar y servir.', 3),
(131, 1, 'Viernes', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, agua', 'Mezclar en licuadora.', 3),
(132, 1, 'Viernes', 'cena', 'Sopa de pollo con fideos integrales', '1 plato', 'Pechuga de pollo, fideos integrales, caldo', 'Cocinar a fuego lento.', 3),
(133, 1, 'Sábado', 'desayuno', 'Pan integral con aguacate', '1 rebanada', 'Pan integral, aguacate', 'Untar aguacate en el pan.', 3),
(134, 1, 'Sábado', 'almuerzo', 'Ensalada de quinoa', '1 plato', 'Quinoa, pepino, zanahoria', 'Mezclar y servir fría.', 3),
(135, 1, 'Sábado', 'merienda', 'Batido de frutas', '1 vaso', 'Frutas, leche de almendras', 'Mezclar en licuadora.', 3),
(136, 1, 'Sábado', 'cena', 'Pasta integral con salsa de tomate', '1 porción', 'Pasta integral, salsa de tomate', 'Cocinar y servir.', 3),
(137, 1, 'Domingo', 'desayuno', 'Panqueques de avena y plátano', '2 unidades', 'Avena, plátano, huevo', 'Cocinar en sartén.', 3),
(138, 1, 'Domingo', 'almuerzo', 'Pollo a la plancha con verduras', '200g', 'Pechuga de pollo, calabacín, zanahoria', 'Cocinar a la plancha.', 3),
(139, 1, 'Domingo', 'merienda', 'Fruta fresca', '1 pieza', 'Manzana, naranja', 'Servir fresca.', 3),
(140, 1, 'Domingo', 'cena', 'Ensalada de lentejas', '1 plato', 'Lentejas, espinacas, tomate', 'Mezclar y servir fría.', 3),
(141, 1, 'Lunes', 'desayuno', 'Tostadas con aguacate y huevo', '2 rebanadas', 'Pan integral, aguacate, huevo', 'Tostar el pan, untar aguacate y añadir huevo cocido.', 4),
(142, 1, 'Lunes', 'almuerzo', 'Ensalada de pollo con quinua', '1 plato', 'Pechuga de pollo, quinua, espinacas', 'Cocinar la quinua y el pollo, mezclar con espinacas.', 4),
(143, 1, 'Lunes', 'merienda', 'Batido de frutos rojos', '1 vaso', 'Frutos rojos, yogur griego', 'Mezclar en licuadora.', 4),
(144, 1, 'Lunes', 'cena', 'Sopa de lentejas', '1 plato', 'Lentejas, zanahoria, cebolla', 'Cocinar a fuego lento.', 4),
(145, 1, 'Martes', 'desayuno', 'Avena con banana y almendras', '1 taza', 'Avena, banana, almendras', 'Cocinar la avena y añadir banana en rodajas y almendras.', 4),
(146, 1, 'Martes', 'almuerzo', 'Pescado al horno con verduras', '200g', 'Pescado blanco, zanahoria, calabacín', 'Hornear pescado con verduras.', 4),
(147, 1, 'Martes', 'merienda', 'Yogur con granola', '1 taza', 'Yogur natural, granola', 'Servir con granola.', 4),
(148, 1, 'Martes', 'cena', 'Pollo asado con brócoli', '200g', 'Pechuga de pollo, brócoli', 'Asar pollo y acompañar con brócoli al vapor.', 4),
(149, 1, 'Miércoles', 'desayuno', 'Batido de espinacas y manzana', '1 vaso', 'Espinacas, manzana, agua', 'Mezclar en licuadora.', 4),
(150, 1, 'Miércoles', 'almuerzo', 'Tacos de pescado', '2 tacos', 'Tortillas, pescado, col', 'Armar tacos con pescado y col rallada.', 4),
(151, 1, 'Miércoles', 'merienda', 'Frutos secos', '30g', 'Nueces, almendras, pasas', 'Servir en porción.', 4),
(152, 1, 'Miércoles', 'cena', 'Frittata de verduras', '1 porción', 'Huevos, espinacas, pimientos', 'Cocinar en sartén.', 4),
(153, 1, 'Jueves', 'desayuno', 'Smoothie de plátano y mantequilla de maní', '1 vaso', 'Plátano, mantequilla de maní, leche', 'Mezclar en licuadora.', 4),
(154, 1, 'Jueves', 'almuerzo', 'Ensalada griega', '1 plato', 'Pepino, tomate, queso feta, aceitunas', 'Mezclar los ingredientes y aliñar.', 4),
(155, 1, 'Jueves', 'merienda', 'Tostadas con hummus', '2 rebanadas', 'Pan integral, hummus', 'Untar hummus en las tostadas.', 4),
(156, 1, 'Jueves', 'cena', 'Pollo a la plancha con batatas', '200g', 'Pechuga de pollo, batatas', 'Cocinar el pollo a la plancha y hornear las batatas.', 4),
(157, 1, 'Viernes', 'desayuno', 'Pan integral con aguacate y tomate', '2 rebanadas', 'Pan integral, aguacate, tomate', 'Untar aguacate en las tostadas y añadir tomate.', 4),
(158, 1, 'Viernes', 'almuerzo', 'Pasta integral con verduras', '1 porción', 'Pasta integral, verduras mixtas', 'Cocinar pasta y mezclar con verduras.', 4),
(159, 1, 'Viernes', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, leche', 'Mezclar en licuadora.', 4),
(160, 1, 'Viernes', 'cena', 'Sopa de zanahoria y jengibre', '1 plato', 'Zanahoria, jengibre, caldo de verduras', 'Cocinar a fuego lento.', 4),
(161, 1, 'Sábado', 'desayuno', 'Pan integral con mermelada natural', '2 rebanadas', 'Pan integral, mermelada de frutos rojos', 'Untar mermelada en el pan.', 4),
(162, 1, 'Sábado', 'almuerzo', 'Ensalada de pasta', '1 porción', 'Pasta integral, tomate, pepino, aceitunas', 'Mezclar y servir fría.', 4),
(163, 1, 'Sábado', 'merienda', 'Yogur con frutas', '1 taza', 'Yogur natural, fresas, moras', 'Servir con frutas.', 4),
(164, 1, 'Sábado', 'cena', 'Pizza de coliflor con queso', '1 porción', 'Base de coliflor, queso, salsa de tomate', 'Hornear con ingredientes.', 4),
(165, 1, 'Domingo', 'desayuno', 'Panqueques de avena y arándanos', '2 unidades', 'Avena, arándanos, huevo', 'Cocinar en sartén.', 4),
(166, 1, 'Domingo', 'almuerzo', 'Pollo al horno con calabacín', '200g', 'Pechuga de pollo, calabacín, especias', 'Hornear con especias.', 4),
(167, 1, 'Domingo', 'merienda', 'Fruta fresca', '1 pieza', 'Manzana, plátano', 'Servir fresca.', 4),
(168, 1, 'Domingo', 'cena', 'Ensalada de garbanzos con espinacas', '1 plato', 'Garbanzos, espinacas, tomate', 'Mezclar y servir fría.', 4),
(169, 2, 'Lunes', 'desayuno', 'Tortilla de espinacas', '4 claras', 'Claras de huevo, espinacas, sal', 'Batir y cocinar en sartén.', 2),
(170, 2, 'Lunes', 'almuerzo', 'Filete de ternera a la plancha', '200g', 'Ternera, especias', 'Cocinar a la plancha.', 2),
(171, 2, 'Lunes', 'merienda', 'Frutos secos', '30g', 'Almendras, nueces', 'Servir.', 2),
(172, 2, 'Lunes', 'cena', 'Salmón a la parrilla', '150g', 'Salmón, limón, especias', 'Asar a la parrilla.', 2),
(173, 2, 'Martes', 'desayuno', 'Avena con frutas', '1 taza', 'Avena, plátano, miel', 'Cocinar avena y añadir frutas.', 2),
(174, 2, 'Martes', 'almuerzo', 'Pasta integral con tomate', '150g', 'Pasta integral, salsa de tomate', 'Cocinar la pasta y mezclar con salsa.', 2),
(175, 2, 'Martes', 'merienda', 'Yogur con nueces', '1 taza', 'Yogur natural, nueces', 'Mezclar y servir frío.', 2),
(176, 2, 'Martes', 'cena', 'Pechuga de pollo con verduras', '150g', 'Pechuga de pollo, brócoli, zanahoria', 'Asar el pollo y hervir las verduras.', 2),
(177, 2, 'Miércoles', 'desayuno', 'Smoothie verde', '1 vaso', 'Espinacas, plátano, leche de almendra', 'Mezclar en licuadora.', 2),
(178, 2, 'Miércoles', 'almuerzo', 'Ensalada de atún', '1 plato', 'Atún, lechuga, tomate', 'Mezclar los ingredientes.', 2),
(179, 2, 'Miércoles', 'merienda', 'Barra de cereales', '1 unidad', 'Cereales integrales, frutos secos', 'Servir.', 2),
(180, 2, 'Miércoles', 'cena', 'Tacos de pollo', '2 tacos', 'Pollo desmenuzado, tortillas integrales, lechuga', 'Armar los tacos y servir.', 2),
(181, 2, 'Jueves', 'desayuno', 'Huevos revueltos con champiñones', '2 huevos', 'Huevos, champiñones, cebolla', 'Revolver y cocinar.', 2),
(182, 2, 'Jueves', 'almuerzo', 'Pollo al curry con arroz', '200g', 'Pechuga de pollo, arroz, curry', 'Cocinar el pollo con curry y servir con arroz.', 2),
(183, 2, 'Jueves', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, leche de avena', 'Mezclar en licuadora.', 2),
(184, 2, 'Jueves', 'cena', 'Sopa de lentejas', '1 plato', 'Lentejas, zanahorias, cebolla', 'Cocinar a fuego lento.', 2),
(185, 2, 'Viernes', 'desayuno', 'Pan integral con aguacate', '1 rebanada', 'Pan integral, aguacate', 'Untar aguacate sobre el pan.', 2),
(186, 2, 'Viernes', 'almuerzo', 'Salmón al horno con verduras', '200g', 'Salmón, espárragos, especias', 'Hornear el salmón y servir con verduras.', 2),
(187, 2, 'Viernes', 'merienda', 'Fruta fresca', '1 pieza', 'Manzana, pera', 'Servir fresca.', 2),
(188, 2, 'Viernes', 'cena', 'Ensalada César', '1 plato', 'Lechuga, pollo, aderezo César', 'Mezclar los ingredientes.', 2),
(189, 2, 'Sábado', 'desayuno', 'Batido de avena', '1 vaso', 'Avena, plátano, leche', 'Mezclar en licuadora.', 2),
(190, 2, 'Sábado', 'almuerzo', 'Pechuga de pollo a la plancha', '200g', 'Pechuga de pollo, especias', 'Cocinar a la plancha.', 2),
(191, 2, 'Sábado', 'merienda', 'Galletas de avena', '2 unidades', 'Avena, miel', 'Hornear y servir.', 2),
(192, 2, 'Sábado', 'cena', 'Pasta con salsa pesto', '150g', 'Pasta integral, pesto', 'Cocinar la pasta y mezclar con pesto.', 2),
(193, 2, 'Domingo', 'desayuno', 'Tortilla de espinacas', '4 claras', 'Claras de huevo, espinacas, sal', 'Batir y cocinar en sartén.', 2),
(194, 2, 'Domingo', 'almuerzo', 'Ensalada de pollo', '1 plato', 'Pollo a la plancha, lechuga, tomate, zanahoria', 'Cortar y mezclar los ingredientes.', 2),
(195, 2, 'Domingo', 'merienda', 'Batido de frutas', '1 vaso', 'Plátano, fresas, leche de almendra', 'Licuar todos los ingredientes.', 2),
(196, 2, 'Domingo', 'cena', 'Sopa de verduras', '1 plato', 'Calabacín, zanahoria, cebolla, espinacas', 'Cocinar los ingredientes en agua y sazonar.', 2),
(197, 2, 'Lunes', 'desayuno', 'Avena con manzana', '1 taza', 'Avena, manzana, canela', 'Cocinar la avena y añadir manzana y canela.', 1),
(198, 2, 'Lunes', 'almuerzo', 'Pollo a la plancha con arroz integral', '150g', 'Pollo, arroz integral, especias', 'Cocinar el pollo y servir con arroz.', 1),
(199, 2, 'Lunes', 'merienda', 'Yogur con frutos rojos', '1 taza', 'Yogur natural, frutos rojos', 'Mezclar y servir frío.', 1),
(200, 2, 'Lunes', 'cena', 'Pescado al vapor con brócoli', '120g', 'Pescado blanco, brócoli, limón', 'Cocinar al vapor y servir con limón.', 1),
(201, 2, 'Martes', 'desayuno', 'Tortilla de claras con espinacas', '4 claras', 'Claras de huevo, espinacas', 'Batir y cocinar en sartén.', 1),
(202, 2, 'Martes', 'almuerzo', 'Pasta integral con verduras', '150g', 'Pasta integral, pimientos, calabacín', 'Cocinar pasta y mezclar con verduras salteadas.', 1),
(203, 2, 'Martes', 'merienda', 'Frutos secos', '30g', 'Almendras, nueces', 'Servir.', 1),
(204, 2, 'Martes', 'cena', 'Ensalada de atún', '1 plato', 'Atún, lechuga, tomate', 'Mezclar los ingredientes.', 1),
(205, 2, 'Miércoles', 'desayuno', 'Batido de plátano y avena', '1 vaso', 'Plátano, avena, leche de almendra', 'Licuar todos los ingredientes.', 1),
(206, 2, 'Miércoles', 'almuerzo', 'Carne magra a la plancha con puré de patata', '150g', 'Carne magra, patata', 'Cocinar carne a la plancha y hacer puré de patata.', 1),
(207, 2, 'Miércoles', 'merienda', 'Yogur con semillas', '1 taza', 'Yogur natural, semillas de chía', 'Mezclar y servir frío.', 1),
(208, 2, 'Miércoles', 'cena', 'Tacos de pollo', '2 tacos', 'Pollo desmenuzado, tortillas de maíz, lechuga', 'Armar los tacos y servir.', 1),
(209, 2, 'Jueves', 'desayuno', 'Pan integral con aguacate', '1 rebanada', 'Pan integral, aguacate', 'Untar aguacate sobre el pan.', 1),
(210, 2, 'Jueves', 'almuerzo', 'Pechuga de pollo con quinoa', '150g', 'Pechuga de pollo, quinoa, espinacas', 'Cocinar el pollo y servir con quinoa y espinacas.', 1),
(211, 2, 'Jueves', 'merienda', 'Fruta fresca', '1 pieza', 'Manzana', 'Servir fresca.', 1),
(212, 2, 'Jueves', 'cena', 'Sopa de verduras', '1 plato', 'Zanahoria, calabacín, espinacas', 'Cocinar a fuego lento.', 1),
(213, 2, 'Viernes', 'desayuno', 'Smoothie de frutas', '1 vaso', 'Plátano, fresas, leche', 'Licuar todos los ingredientes.', 1),
(214, 2, 'Viernes', 'almuerzo', 'Salmón al horno con patatas', '150g', 'Salmón, patatas, especias', 'Hornear el salmón con patatas.', 1),
(215, 2, 'Viernes', 'merienda', 'Nueces y almendras', '30g', 'Nueces, almendras', 'Servir.', 1),
(216, 2, 'Viernes', 'cena', 'Ensalada César', '1 plato', 'Lechuga, pollo, aderezo César', 'Mezclar los ingredientes.', 1),
(217, 2, 'Sábado', 'desayuno', 'Tostadas de pan integral con miel', '2 rebanadas', 'Pan integral, miel', 'Untar miel sobre el pan.', 1),
(218, 2, 'Sábado', 'almuerzo', 'Ternera a la plancha con arroz', '150g', 'Ternera, arroz integral', 'Cocinar la ternera a la plancha y servir con arroz.', 1),
(219, 2, 'Sábado', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, agua', 'Mezclar en licuadora.', 1),
(220, 2, 'Sábado', 'cena', 'Pasta con salsa de tomate', '150g', 'Pasta integral, salsa de tomate', 'Cocinar la pasta y añadir salsa.', 1),
(221, 2, 'Domingo', 'desayuno', 'Avena con frutas y nueces', '1 taza', 'Avena, plátano, nueces', 'Cocinar la avena y añadir frutas y nueces.', 1),
(222, 2, 'Domingo', 'almuerzo', 'Pollo asado con ensalada', '150g', 'Pollo, lechuga, tomate, zanahoria', 'Asar el pollo y mezclar con ensalada.', 1),
(223, 2, 'Domingo', 'merienda', 'Yogur con frutos secos', '1 taza', 'Yogur natural, frutos secos', 'Mezclar y servir frío.', 1),
(224, 2, 'Domingo', 'cena', 'Sopa de pollo con verduras', '1 plato', 'Pollo, zanahoria, apio', 'Cocinar a fuego lento.', 1),
(225, 2, 'Lunes', 'desayuno', 'Smoothie de espinacas y plátano', '1 vaso', 'Espinacas, plátano, leche de almendra', 'Licuar todos los ingredientes.', 3),
(226, 2, 'Lunes', 'almuerzo', 'Pechuga de pollo con batatas asadas', '150g', 'Pechuga de pollo, batatas', 'Asar las batatas y cocinar el pollo.', 3),
(227, 2, 'Lunes', 'merienda', 'Yogur con semillas de chía', '1 taza', 'Yogur natural, semillas de chía', 'Mezclar y servir frío.', 3),
(228, 2, 'Lunes', 'cena', 'Merluza al horno con espárragos', '120g', 'Merluza, espárragos, limón', 'Hornear la merluza y espárragos.', 3),
(229, 2, 'Martes', 'desayuno', 'Avena con frutos rojos y nueces', '1 taza', 'Avena, frutos rojos, nueces', 'Cocinar la avena y añadir frutos y nueces.', 3),
(230, 2, 'Martes', 'almuerzo', 'Bistec a la plancha con puré de patata', '150g', 'Bistec, patata', 'Cocinar el bistec y hacer puré de patata.', 3),
(231, 2, 'Martes', 'merienda', 'Frutas frescas', '1 porción', 'Manzana, plátano', 'Servir fresca.', 3),
(232, 2, 'Martes', 'cena', 'Ensalada de salmón y aguacate', '1 plato', 'Salmón, aguacate, espinacas', 'Mezclar los ingredientes.', 3),
(233, 2, 'Miércoles', 'desayuno', 'Pan integral con crema de cacahuate', '1 rebanada', 'Pan integral, crema de cacahuate', 'Untar la crema en el pan.', 3),
(234, 2, 'Miércoles', 'almuerzo', 'Lentejas con arroz integral', '150g', 'Lentejas, arroz integral, zanahoria', 'Cocinar las lentejas y el arroz.', 3),
(235, 2, 'Miércoles', 'merienda', 'Batido de proteínas', '1 vaso', 'Proteína en polvo, agua', 'Mezclar en licuadora.', 3),
(236, 2, 'Miércoles', 'cena', 'Pasta integral con pimientos', '150g', 'Pasta integral, pimientos, cebolla', 'Cocinar la pasta y saltear con pimientos.', 3),
(237, 2, 'Jueves', 'desayuno', 'Tortilla de champiñones', '2 huevos', 'Huevos, champiñones, cebolla', 'Batir y cocinar en sartén.', 3),
(238, 2, 'Jueves', 'almuerzo', 'Pechuga de pavo con quinoa', '150g', 'Pechuga de pavo, quinoa', 'Cocinar el pavo y servir con quinoa.', 3),
(239, 2, 'Jueves', 'merienda', 'Frutos secos variados', '30g', 'Almendras, nueces, avellanas', 'Servir.', 3),
(240, 2, 'Jueves', 'cena', 'Sopa de tomate', '1 plato', 'Tomate, ajo, cebolla', 'Cocinar a fuego lento y licuar.', 3),
(241, 2, 'Viernes', 'desayuno', 'Yogur con granola y miel', '1 taza', 'Yogur natural, granola, miel', 'Mezclar y servir frío.', 3),
(242, 2, 'Viernes', 'almuerzo', 'Salmón a la parrilla con verduras', '150g', 'Salmón, calabacín, pimientos', 'Asar el salmón y las verduras.', 3),
(243, 2, 'Viernes', 'merienda', 'Barra de cereales', '1 unidad', 'Cereales integrales, frutos secos', 'Servir.', 3),
(244, 2, 'Viernes', 'cena', 'Tacos de carne magra', '2 tacos', 'Carne magra, tortillas de maíz, lechuga', 'Armar los tacos y servir.', 3),
(245, 2, 'Sábado', 'desayuno', 'Avena con plátano y miel', '1 taza', 'Avena, plátano, miel', 'Cocinar la avena y añadir plátano y miel.', 3),
(246, 2, 'Sábado', 'almuerzo', 'Filete de pescado con ensalada verde', '150g', 'Pescado blanco, lechuga, espinacas', 'Cocinar el pescado y servir con ensalada.', 3),
(247, 2, 'Sábado', 'merienda', 'Batido de frutas', '1 vaso', 'Frutas mixtas, agua', 'Licuar y servir frío.', 3),
(248, 2, 'Sábado', 'cena', 'Pizza de verduras', '2 porciones', 'Masa integral, tomate, espinacas, champiñones', 'Hornear la pizza con los ingredientes.', 3),
(249, 2, 'Domingo', 'desayuno', 'Tortilla de espinacas y queso', '3 claras', 'Claras de huevo, espinacas, queso', 'Batir y cocinar en sartén.', 3),
(250, 2, 'Domingo', 'almuerzo', 'Ensalada de quinoa y verduras', '1 plato', 'Quinoa, pimientos, pepino, espinacas', 'Mezclar los ingredientes cocidos.', 3),
(251, 2, 'Domingo', 'merienda', 'Nueces y yogur', '30g', 'Nueces, yogur natural', 'Mezclar y servir.', 3),
(252, 2, 'Domingo', 'cena', 'Caldo de pollo con verduras', '1 plato', 'Pollo, zanahoria, apio', 'Cocinar a fuego lento.', 3),
(253, 2, 'Lunes', 'desayuno', 'Avena con almendras y frutas', '1 taza', 'Avena, almendras, fresas', 'Cocinar la avena y añadir almendras y fresas.', 4),
(254, 2, 'Lunes', 'almuerzo', 'Pollo al horno con batatas', '200g', 'Pechuga de pollo, batatas, especias', 'Hornear el pollo con batatas.', 4),
(255, 2, 'Lunes', 'merienda', 'Frutos secos variados', '30g', 'Almendras, nueces, avellanas', 'Servir.', 4),
(256, 2, 'Lunes', 'cena', 'Merluza con espinacas salteadas', '150g', 'Merluza, espinacas, ajo', 'Saltear las espinacas y servir con la merluza.', 4),
(257, 2, 'Martes', 'desayuno', 'Pan integral con aguacate y tomate', '1 rebanada', 'Pan integral, aguacate, tomate', 'Untar aguacate en pan y añadir tomate.', 4),
(258, 2, 'Martes', 'almuerzo', 'Ternera a la plancha con arroz integral', '150g', 'Ternera, arroz integral', 'Cocinar la ternera a la plancha y servir con arroz.', 4),
(259, 2, 'Martes', 'merienda', 'Yogur con frutas frescas', '1 taza', 'Yogur natural, frutas mixtas', 'Mezclar y servir frío.', 4),
(260, 2, 'Martes', 'cena', 'Ensalada de garbanzos y verduras', '1 plato', 'Garbanzos, lechuga, tomate, pepino', 'Mezclar los ingredientes.', 4),
(261, 2, 'Miércoles', 'desayuno', 'Smoothie de proteínas y frutas', '1 vaso', 'Proteína en polvo, plátano, leche de almendra', 'Licuar todos los ingredientes.', 4),
(262, 2, 'Miércoles', 'almuerzo', 'Pechuga de pollo con puré de calabaza', '150g', 'Pechuga de pollo, calabaza', 'Asar el pollo y preparar puré de calabaza.', 4),
(263, 2, 'Miércoles', 'merienda', 'Tostadas integrales con queso', '2 unidades', 'Pan integral, queso cottage', 'Untar el queso en las tostadas.', 4),
(264, 2, 'Miércoles', 'cena', 'Tacos de pescado', '2 tacos', 'Pescado blanco, tortillas de maíz, lechuga', 'Preparar los tacos y servir.', 4),
(265, 2, 'Jueves', 'desayuno', 'Tortilla de espinacas y champiñones', '3 claras', 'Claras de huevo, espinacas, champiñones', 'Batir y cocinar en sartén.', 4),
(266, 2, 'Jueves', 'almuerzo', 'Lomo de cerdo con brócoli', '150g', 'Lomo de cerdo, brócoli, especias', 'Asar el cerdo y cocinar el brócoli.', 4),
(267, 2, 'Jueves', 'merienda', 'Manzana con crema de cacahuate', '1 manzana', 'Manzana, crema de cacahuate', 'Cortar la manzana y untar crema.', 4),
(268, 2, 'Jueves', 'cena', 'Caldo de pollo y verduras', '1 plato', 'Pollo, zanahoria, apio, cebolla', 'Cocinar todo a fuego lento.', 4),
(269, 2, 'Viernes', 'desayuno', 'Avena con chía y plátano', '1 taza', 'Avena, semillas de chía, plátano', 'Cocinar la avena y añadir chía y plátano.', 4),
(270, 2, 'Viernes', 'almuerzo', 'Hamburguesa de pavo con ensalada', '1 hamburguesa', 'Pavo molido, lechuga, tomate, pan integral', 'Armar la hamburguesa y servir con ensalada.', 4),
(271, 2, 'Viernes', 'merienda', 'Batido de frutas tropicales', '1 vaso', 'Piña, mango, leche de coco', 'Licuar todos los ingredientes.', 4),
(272, 2, 'Viernes', 'cena', 'Pasta con verduras asadas', '150g', 'Pasta integral, pimientos, calabacín', 'Cocinar la pasta y mezclar con verduras asadas.', 4),
(273, 2, 'Sábado', 'desayuno', 'Yogur con avena y arándanos', '1 taza', 'Yogur natural, avena, arándanos', 'Mezclar y servir frío.', 4),
(274, 2, 'Sábado', 'almuerzo', 'Pollo al curry con arroz integral', '150g', 'Pechuga de pollo, arroz integral, curry', 'Cocinar el pollo con curry y servir con arroz.', 4),
(275, 2, 'Sábado', 'merienda', 'Galletas de avena', '2 unidades', 'Avena, miel', 'Hornear y servir.', 4),
(276, 2, 'Sábado', 'cena', 'Ensalada de quinoa y verduras', '1 plato', 'Quinoa, espinacas, pimientos', 'Mezclar todos los ingredientes.', 4),
(277, 2, 'Domingo', 'desayuno', 'Tortilla de pimientos y cebolla', '3 claras', 'Claras de huevo, pimientos, cebolla', 'Batir y cocinar en sartén.', 4),
(278, 2, 'Domingo', 'almuerzo', 'Pescado a la plancha con espárragos', '150g', 'Pescado blanco, espárragos, limón', 'Cocinar el pescado a la plancha y servir con espárragos.', 4),
(279, 2, 'Domingo', 'merienda', 'Frutas frescas variadas', '1 porción', 'Sandía, melón', 'Servir fresca.', 4),
(280, 2, 'Domingo', 'cena', 'Calabacines rellenos de quinoa', '2 unidades', 'Calabacines, quinoa, tomate', 'Rellenar los calabacines y hornear.', 4),
(281, 2, 'Lunes', 'desayuno', 'Batido de proteínas con frutas', '1 vaso', 'Proteína en polvo, plátano, fresas, leche de almendra', 'Licuar todos los ingredientes.', 5),
(282, 2, 'Lunes', 'almuerzo', 'Pollo al horno con papas y espárragos', '200g', 'Pechuga de pollo, papas, espárragos', 'Hornear el pollo con papas y espárragos.', 5),
(283, 2, 'Lunes', 'merienda', 'Tostada integral con hummus', '1 rebanada', 'Pan integral, hummus', 'Untar el hummus en la tostada.', 5),
(284, 2, 'Lunes', 'cena', 'Salmón a la parrilla con verduras', '150g', 'Salmón, zanahorias, calabacín', 'Asar el salmón y servir con verduras.', 5),
(285, 2, 'Martes', 'desayuno', 'Avena con nueces y miel', '1 taza', 'Avena, nueces, miel', 'Cocinar la avena y añadir nueces y miel.', 5),
(286, 2, 'Martes', 'almuerzo', 'Lentejas guisadas con arroz integral', '1 plato', 'Lentejas, arroz integral, zanahoria, cebolla', 'Cocinar las lentejas y servir con arroz.', 5),
(287, 2, 'Martes', 'merienda', 'Fruta fresca', '1 porción', 'Manzana, pera', 'Servir fresca.', 5),
(288, 2, 'Martes', 'cena', 'Tortilla de espárragos y champiñones', '1 tortilla', 'Huevos, espárragos, champiñones', 'Cocinar la tortilla en sartén.', 5),
(289, 2, 'Miércoles', 'desayuno', 'Yogur con semillas de chía y frutas', '1 taza', 'Yogur natural, semillas de chía, frutas mixtas', 'Mezclar y servir frío.', 5),
(290, 2, 'Miércoles', 'almuerzo', 'Filete de ternera con puré de batata', '150g', 'Ternera, batatas', 'Asar el filete y preparar el puré.', 5),
(291, 2, 'Miércoles', 'merienda', 'Barra de granola casera', '1 unidad', 'Avena, miel, frutos secos', 'Hornear y servir.', 5),
(292, 2, 'Miércoles', 'cena', 'Pasta integral con verduras al vapor', '150g', 'Pasta integral, brócoli, zanahorias', 'Cocinar la pasta y añadir las verduras al vapor.', 5),
(293, 2, 'Jueves', 'desayuno', 'Tostada de aguacate con tomate', '1 rebanada', 'Pan integral, aguacate, tomate', 'Untar el aguacate y añadir tomate.', 5),
(294, 2, 'Jueves', 'almuerzo', 'Pechuga de pollo con quinoa y verduras', '150g', 'Pechuga de pollo, quinoa, pimientos', 'Asar el pollo y mezclar con quinoa y verduras.', 5),
(295, 2, 'Jueves', 'merienda', 'Batido de frutas cítricas', '1 vaso', 'Naranja, piña, limón', 'Licuar todos los ingredientes.', 5),
(296, 2, 'Jueves', 'cena', 'Sopa de verduras y lentejas', '1 plato', 'Lentejas, zanahoria, apio, cebolla', 'Cocinar a fuego lento.', 5),
(297, 2, 'Viernes', 'desayuno', 'Avena con plátano y cacao', '1 taza', 'Avena, plátano, cacao en polvo', 'Cocinar la avena y añadir plátano y cacao.', 5),
(298, 2, 'Viernes', 'almuerzo', 'Pescado a la plancha con puré de coliflor', '150g', 'Pescado blanco, coliflor', 'Cocinar el pescado a la plancha y preparar el puré.', 5),
(299, 2, 'Viernes', 'merienda', 'Nueces y almendras', '30g', 'Nueces, almendras', 'Servir.', 5),
(300, 2, 'Viernes', 'cena', 'Pimientos rellenos de arroz y carne', '2 unidades', 'Pimientos, carne molida, arroz', 'Rellenar los pimientos y hornear.', 5),
(301, 2, 'Sábado', 'desayuno', 'Yogur con granola y frutas', '1 taza', 'Yogur natural, granola, frutas mixtas', 'Mezclar y servir frío.', 5),
(302, 2, 'Sábado', 'almuerzo', 'Hamburguesa de pollo con ensalada', '1 hamburguesa', 'Pechuga de pollo, pan integral, lechuga, tomate', 'Armar la hamburguesa y servir con ensalada.', 5),
(303, 2, 'Sábado', 'merienda', 'Batido de proteína de vainilla', '1 vaso', 'Proteína de vainilla, leche de almendra', 'Mezclar en licuadora.', 5),
(304, 2, 'Sábado', 'cena', 'Ensalada de pasta integral con atún', '1 plato', 'Pasta integral, atún, pimientos', 'Mezclar todos los ingredientes.', 5),
(305, 2, 'Domingo', 'desayuno', 'Tortilla de espinacas y queso', '3 claras', 'Claras de huevo, espinacas, queso rallado', 'Batir y cocinar en sartén.', 5),
(306, 2, 'Domingo', 'almuerzo', 'Brochetas de pollo y verduras', '2 brochetas', 'Pechuga de pollo, pimientos, cebolla, calabacín', 'Armar las brochetas y asar.', 5),
(307, 2, 'Domingo', 'merienda', 'Fruta fresca', '1 porción', 'Piña, sandía', 'Servir fresca.', 5),
(308, 2, 'Domingo', 'cena', 'Calabacines rellenos de quinoa y verduras', '2 unidades', 'Calabacines, quinoa, espinacas, tomate', 'Rellenar los calabacines y hornear.', 5),
(309, 2, 'Lunes', 'desayuno', 'Tortilla de claras con tomate y espinacas', '4 claras', 'Claras de huevo, tomate, espinacas', 'Batir y cocinar en sartén.', 6),
(310, 2, 'Lunes', 'almuerzo', 'Pechuga de pollo a la plancha con ensalada', '200g', 'Pechuga de pollo, lechuga, tomate, pepino', 'Cocinar a la plancha y servir con ensalada.', 6),
(311, 2, 'Lunes', 'merienda', 'Batido de proteínas con frutos rojos', '1 vaso', 'Proteína en polvo, fresas, frambuesas, leche', 'Licuar todos los ingredientes.', 6),
(312, 2, 'Lunes', 'cena', 'Filete de pescado con brócoli al vapor', '150g', 'Pescado blanco, brócoli', 'Cocinar el pescado y hervir el brócoli.', 6),
(313, 2, 'Martes', 'desayuno', 'Avena cocida con manzana y canela', '1 taza', 'Avena, manzana, canela', 'Cocinar la avena y añadir manzana y canela.', 6),
(314, 2, 'Martes', 'almuerzo', 'Tacos de pollo con guacamole', '2 tacos', 'Pollo desmenuzado, tortillas, aguacate', 'Armar los tacos y servir con guacamole.', 6),
(315, 2, 'Martes', 'merienda', 'Frutos secos', '30g', 'Almendras, nueces', 'Servir.', 6),
(316, 2, 'Martes', 'cena', 'Ensalada de atún', '1 plato', 'Atún, lechuga, tomate, cebolla', 'Mezclar los ingredientes y servir.', 6),
(317, 2, 'Miércoles', 'desayuno', 'Yogur con granola y frutas', '1 taza', 'Yogur natural, granola, plátano', 'Mezclar y servir.', 6),
(318, 2, 'Miércoles', 'almuerzo', 'Lentejas estofadas', '1 plato', 'Lentejas, zanahorias, cebolla', 'Cocinar a fuego lento.', 6),
(319, 2, 'Miércoles', 'merienda', 'Batido de plátano y espinacas', '1 vaso', 'Plátano, espinacas, leche de almendra', 'Licuar todos los ingredientes.', 6),
(320, 2, 'Miércoles', 'cena', 'Pasta integral con pollo y verduras', '150g', 'Pasta integral, pechuga de pollo, verduras', 'Cocinar la pasta y añadir pollo y verduras.', 6),
(321, 2, 'Jueves', 'desayuno', 'Smoothie de mango y plátano', '1 vaso', 'Mango, plátano, leche de almendra', 'Licuar todos los ingredientes.', 6),
(322, 2, 'Jueves', 'almuerzo', 'Quinoa con verduras asadas', '1 plato', 'Quinoa, pimientos, calabacín, cebolla', 'Cocinar la quinoa y añadir verduras asadas.', 6),
(323, 2, 'Jueves', 'merienda', 'Tostada integral con aguacate', '1 rebanada', 'Pan integral, aguacate', 'Untar el aguacate en la tostada.', 6),
(324, 2, 'Jueves', 'cena', 'Sopa de verduras', '1 plato', 'Zanahorias, apio, cebolla', 'Cocinar a fuego lento.', 6),
(325, 2, 'Viernes', 'desayuno', 'Pancakes de avena', '2 unidades', 'Avena, huevo, leche', 'Mezclar y cocinar en sartén.', 6),
(326, 2, 'Viernes', 'almuerzo', 'Salmón al horno con espárragos', '200g', 'Salmón, espárragos', 'Hornear el salmón y servir con espárragos.', 6),
(327, 2, 'Viernes', 'merienda', 'Yogur griego con miel', '1 taza', 'Yogur griego, miel', 'Mezclar y servir.', 6),
(328, 2, 'Viernes', 'cena', 'Pechuga de pollo al curry con arroz', '200g', 'Pechuga de pollo, arroz, curry', 'Cocinar el pollo con curry y servir con arroz.', 6),
(329, 2, 'Sábado', 'desayuno', 'Tortilla de claras con espinacas', '4 claras', 'Claras de huevo, espinacas', 'Batir y cocinar en sartén.', 6),
(330, 2, 'Sábado', 'almuerzo', 'Hamburguesa de pavo con ensalada', '1 hamburguesa', 'Carne de pavo, pan integral, lechuga, tomate', 'Armar la hamburguesa y servir con ensalada.', 6),
(331, 2, 'Sábado', 'merienda', 'Fruta fresca', '1 porción', 'Manzana, plátano', 'Servir fresca.', 6),
(332, 2, 'Sábado', 'cena', 'Pasta con salsa de tomate', '150g', 'Pasta, salsa de tomate, albahaca', 'Cocinar la pasta y mezclar con salsa.', 6),
(333, 2, 'Domingo', 'desayuno', 'Avena con almendras', '1 taza', 'Avena, almendras, miel', 'Cocinar la avena y añadir almendras y miel.', 6),
(334, 2, 'Domingo', 'almuerzo', 'Ensalada de pollo con garbanzos', '1 plato', 'Pechuga de pollo, garbanzos, lechuga, tomate', 'Mezclar los ingredientes.', 6),
(335, 2, 'Domingo', 'merienda', 'Batido de proteína de chocolate', '1 vaso', 'Proteína de chocolate, leche de almendra', 'Licuar todos los ingredientes.', 6),
(336, 2, 'Domingo', 'cena', 'Salmón con puré de coliflor', '150g', 'Salmón, coliflor', 'Cocinar el salmón y preparar el puré.', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dietas`
--

CREATE TABLE `dietas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `duracion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dietas`
--

INSERT INTO `dietas` (`id`, `nombre`, `tipo`, `imagen`, `duracion`) VALUES
(1, 'Ganar fuerza', 'Musculación', 'dietaFuerza.jpg', '4 semanas'),
(2, 'Ganar Musuculo', 'Musculacion', 'dietaMusculo.jpg', '6 semanas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ejercicios`
--

CREATE TABLE `ejercicios` (
  `id` int(11) NOT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `video_url` varchar(255) DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `repeticiones` varchar(50) DEFAULT NULL,
  `semana` int(11) DEFAULT NULL,
  `dia` varchar(20) DEFAULT NULL,
  `series` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ejercicios`
--

INSERT INTO `ejercicios` (`id`, `plan_id`, `nombre`, `video_url`, `imagen_url`, `repeticiones`, `semana`, `dia`, `series`) VALUES
(1, 1, 'Sentadilla con barra', 'sentadillabarra.mp4', 'sentadillabarra.jfif', '10', 1, 'Lunes', 3),
(2, 1, 'Press de banca', 'press_banca.mp4', 'press_banca.jpg', '8', 1, 'Lunes', NULL),
(3, 1, 'Dominadas', 'https://example.com/dominadas.mp4', 'dominada.jpg', '6', 1, 'Lunes', NULL),
(4, 1, 'Peso muerto', 'https://example.com/peso_muerto.mp4', 'peso_muerto.jpg', '10', 1, 'Martes', NULL),
(5, 1, 'Remo con barra', 'https://youtu.be/GFdyY7mQq9I?si=efLWIBWZlS-E-XzR', 'remo_barra.jpg', '12', 1, 'Martes', NULL),
(6, 1, 'Press militar', 'https://example.com/press_militar.mp4', 'press_militar.jpg', '8', 1, 'Martes', NULL),
(7, 1, 'Sentadilla búlgara', 'https://example.com/sentadilla_bulgara.mp4', 'sentadilla_bulgara.jpg', '12', 1, 'Miércoles', NULL),
(8, 1, 'Flexiones de brazos', 'https://example.com/flexiones.mp4', 'flexiones.jpg', '15', 1, 'Miércoles', NULL),
(9, 1, 'Curl de bíceps', 'https://example.com/curl_biceps.mp4', 'curl_biceps.jpg', '10', 1, 'Miércoles', NULL),
(10, 1, 'Zancadas', 'https://example.com/zancadas.mp4', 'zancadas.jpg', '12', 1, 'Jueves', NULL),
(11, 1, 'Press inclinado', 'https://example.com/press_inclinado.mp4', 'press_inclinado.jpg', '10', 1, 'Jueves', NULL),
(12, 1, 'Jalones dorsales', 'https://example.com/jalones_dorsales.mp4', 'jalones_dorsales.jpg', '12', 1, 'Jueves', NULL),
(13, 1, 'Sentadilla sumo', 'https://example.com/sentadilla_sumo.mp4', 'sentadilla_sumo.jpg', '10', 1, 'Viernes', NULL),
(14, 1, 'Press con mancuernas', 'https://example.com/press_mancuernas.mp4', 'press_mancuernas.jpg', '12', 1, 'Viernes', NULL),
(15, 1, 'Remo con mancuerna', 'https://example.com/remo_mancuerna.mp4', 'remo_mancuerna.jpg', '10', 1, 'Viernes', NULL),
(16, 1, 'Peso muerto rumano', 'https://example.com/peso_muerto_rumano.mp4', 'peso_muerto_rumano.jpg', '8', 1, 'Sábado', NULL),
(17, 1, 'Extensiones de tríceps', 'https://example.com/ext_triceps.mp4', 'ext_triceps.jpg', '10', 1, 'Sábado', NULL),
(18, 1, 'Plancha abdominal', 'https://example.com/plancha_abdominal.mp4', 'plancha_abdominal.jpg', '60', 1, 'Sábado', NULL),
(19, 1, 'Descanso activo', 'https://example.com/descanso_activo.mp4', 'descanso_activo.jpg', '0', 1, 'Domingo', NULL),
(20, 1, 'Sentadilla frontal', 'https://example.com/sentadilla_frontal.mp4', 'sentadilla_frontal.jpg', '8', 1, 'Lunes', NULL),
(21, 1, 'Press de banca inclinado', 'https://example.com/press_banca_inclinado.mp4', 'press_banca_inclinado.jpg', '8', 1, 'Lunes', NULL),
(22, 1, 'Dominadas con peso', 'https://example.com/dominadas_peso.mp4', 'dominadas_peso.jpg', '6', 1, 'Lunes', NULL),
(23, 1, 'Peso muerto con piernas rígidas', 'https://example.com/peso_muerto_rigido.mp4', 'peso_muerto_rigido.jpg', '10', 1, 'Martes', NULL),
(24, 1, 'Remo con barra T', 'https://example.com/remo_barra_T.mp4', 'remo_barra_T.jpg', '10', 1, 'Martes', NULL),
(25, 1, 'Press militar con mancuernas', 'https://example.com/press_militar_mancuernas.mp4', 'press_militar_mancuernas.jpg', '8', 1, 'Martes', NULL),
(26, 1, 'Sentadilla con salto', 'https://example.com/sentadilla_salto.mp4', 'sentadilla_salto.jpg', '10', 1, 'Miércoles', NULL),
(27, 1, 'Flexiones con aplauso', 'https://example.com/flexiones_aplauso.mp4', 'flexiones_aplauso.jpg', '10', 1, 'Miércoles', NULL),
(28, 1, 'Curl de bíceps alterno', 'https://example.com/curl_biceps_alterno.mp4', 'curl_biceps_alterno.jpg', '10', 1, 'Miércoles', NULL),
(29, 1, 'Zancadas con mancuernas', 'https://example.com/zancadas_mancuernas.mp4', 'zancadas_mancuernas.jpg', '10', 1, 'Jueves', NULL),
(30, 1, 'Press inclinado con mancuernas', 'https://example.com/press_inclinado_mancuernas.mp4', 'press_inclinado_mancuernas.jpg', '10', 1, 'Jueves', NULL),
(31, 1, 'Jalones al pecho', 'https://example.com/jalones_al_pecho.mp4', 'jalones_al_pecho.jpg', '10', 1, 'Jueves', NULL),
(32, 1, 'Sentadilla con mancuernas', 'https://example.com/sentadilla_mancuernas.mp4', 'sentadilla_mancuernas.jpg', '10', 1, 'Viernes', NULL),
(33, 1, 'Press con mancuernas en banco plano', 'https://example.com/press_mancuernas_plano.mp4', 'press_mancuernas_plano.jpg', '10', 1, 'Viernes', NULL),
(34, 1, 'Remo a una mano', 'https://example.com/remo_un_mano.mp4', 'remo_un_mano.jpg', '10', 1, 'Viernes', NULL),
(35, 1, 'Peso muerto sumo', 'https://example.com/peso_muerto_sumo.mp4', 'peso_muerto_sumo.jpg', '8', 1, 'Sábado', NULL),
(36, 1, 'Extensiones de tríceps en polea', 'https://example.com/ext_triceps_polea.mp4', 'ext_triceps_polea.jpg', '10', 1, 'Sábado', NULL),
(37, 1, 'Plancha lateral', 'https://example.com/plancha_lateral.mp4', 'plancha_lateral.jpg', '30', 1, 'Sábado', NULL),
(38, 1, 'Descanso activo', 'https://example.com/descanso_activo_semanal.mp4', 'descanso_activo_semanal.jpg', '0', 1, 'Domingo', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `planes`
--

CREATE TABLE `planes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `duracion` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `planes`
--

INSERT INTO `planes` (`id`, `nombre`, `imagen`, `descripcion`, `duracion`) VALUES
(1, 'Ganar Fuerza', 'ganarfuerza.jpg', 'Un plan diseñado para aumentar la fuerza y la masa muscular.', '12 semanas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `genero` varchar(10) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `edad` int(11) DEFAULT NULL,
  `altura` float DEFAULT NULL,
  `objetivo` varchar(50) DEFAULT NULL,
  `peso` float DEFAULT NULL,
  `semanas` int(11) DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `nombre`, `apellido`, `genero`, `email`, `password`, `edad`, `altura`, `objetivo`, `peso`, `semanas`, `role`) VALUES
(6, 'emanuel', 'schmer', 'masculino', 'emanuelschmer777@gmail.com', '$2y$10$TsHw021Ouw.176oUw19twuOvDV4gKytZJQyTdiwMcwmMw/xxN3xTO', 19, 1.66, 'ganar fuerza', 73, 3, 'user'),
(7, 'juana', 'duartez', 'femenino', 'juanaduartez32@gmail.com', '$2y$10$DTLtd5cbgVa3jd3a4mRdC.EeW6z7Yz/DiONoNzcAluDKvrzBNS0WK', 34, 1.6, 'Ganar Musculo', 65, 5, 'user'),
(8, 'eduardo', 'diaz', 'masculino', 'xordobaemanuel@hotmail.com', '$2y$10$bvlp1EVh/Bt.J7weK7nYhO/1ZitMKZDYK3exE/ANNN0JWQ9YlE4Ga', 19, 1.75, 'Perder grasa', 80, 8, 'user'),
(9, 'juana', 'saca', 'masculino', 'xordobaemanuel12@gmail.com', '$2y$10$fUXQ1wDlkC00V3gAEYINJ.CIazLqnFFCgoGDV/jtIIKhv6WB8rmvC', 18, 1.65, 'ganar musculos', 63, 7, 'user'),
(10, 'Admin', 'Admin', 'M', 'emanuelschmer@hotmail.com', '$2y$10$fUXQ1wDlkC00V3gAEYINJ.CIazLqnFFCgoGDV/jtIIKhv6WB8rmvC', 30, 170, 'mantener', 70, 10, 'admin'),
(11, 'juan ', 'alberto', 'masculino', 'juan@gmail.com', '$2y$10$iDlEFkSgbzThzwS9zmK0s.6DYlslwZ4NhyV082hsfRPzu1b9foVbe', 19, 1, 'Ganar masa muscular', 70, 8, 'user');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_dietas`
--

CREATE TABLE `user_dietas` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `dieta_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `user_dietas`
--

INSERT INTO `user_dietas` (`id`, `user_id`, `dieta_id`) VALUES
(1, 8, 1),
(6, 9, 1),
(7, 9, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_planes`
--

CREATE TABLE `usuario_planes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_planes`
--

INSERT INTO `usuario_planes` (`id`, `user_id`, `plan_id`) VALUES
(4, 9, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comidas`
--
ALTER TABLE `comidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dieta_id` (`dieta_id`);

--
-- Indices de la tabla `dietas`
--
ALTER TABLE `dietas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_id` (`plan_id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `planes`
--
ALTER TABLE `planes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `user_dietas`
--
ALTER TABLE `user_dietas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `dieta_id` (`dieta_id`);

--
-- Indices de la tabla `usuario_planes`
--
ALTER TABLE `usuario_planes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `plan_id` (`plan_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comidas`
--
ALTER TABLE `comidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=337;

--
-- AUTO_INCREMENT de la tabla `dietas`
--
ALTER TABLE `dietas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `planes`
--
ALTER TABLE `planes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `user_dietas`
--
ALTER TABLE `user_dietas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `usuario_planes`
--
ALTER TABLE `usuario_planes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comidas`
--
ALTER TABLE `comidas`
  ADD CONSTRAINT `comidas_ibfk_1` FOREIGN KEY (`dieta_id`) REFERENCES `dietas` (`id`);

--
-- Filtros para la tabla `ejercicios`
--
ALTER TABLE `ejercicios`
  ADD CONSTRAINT `ejercicios_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`);

--
-- Filtros para la tabla `user_dietas`
--
ALTER TABLE `user_dietas`
  ADD CONSTRAINT `user_dietas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_dietas_ibfk_2` FOREIGN KEY (`dieta_id`) REFERENCES `dietas` (`id`);

--
-- Filtros para la tabla `usuario_planes`
--
ALTER TABLE `usuario_planes`
  ADD CONSTRAINT `usuario_planes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usuario_planes_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `planes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
