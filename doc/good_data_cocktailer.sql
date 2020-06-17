-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 17, 2020 at 10:42 AM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cocktailer`
--

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE `comment` (
  `c_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`c_id`, `recipe_id`, `content`, `user_id`) VALUES
(1, 1, 'Best cocktail ever!!', 19),
(2, 2, 'Amazing!!!', 19),
(3, 1, 'Indeed it is.', 18);

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `i_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `measurement` int(11) NOT NULL,
  `item` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`i_id`, `recipe_id`, `quantity`, `measurement`, `item`) VALUES
(1, 1, '1', 3, 'sugar'),
(2, 1, '3', 2, 'Angostura bitters'),
(3, 1, '2', 3, 'bourbon'),
(4, 1, '1', 7, 'orange peel'),
(5, 2, '2', 3, 'Blanco tequila'),
(6, 2, '1', 3, 'Lime juice'),
(7, 2, '1', 3, 'Orange liqueur'),
(8, 2, '1', 3, 'Agave syrup'),
(9, 2, '1', 7, 'Lime wheel'),
(10, 2, '1', 13, 'Kosher salt'),
(11, 3, '1', 3, 'Gosling\'s Black Seal rum'),
(12, 3, '1', 3, 'Stormy ginger beer'),
(13, 3, '1', 7, 'Lime wedge'),
(14, 4, '2', 3, 'gin or vodka'),
(15, 4, '1', 3, 'dry vermouth'),
(16, 4, '1', 7, 'olive brine'),
(17, 4, '2', 7, 'olives'),
(18, 5, '2', 3, 'Gin'),
(19, 5, '1', 3, 'Dry vermouth'),
(20, 5, '1', 2, 'Orange bitters'),
(21, 5, '1', 7, 'Lemon twist'),
(22, 6, '2', 3, 'Tincup whiskey'),
(23, 6, '3', 3, 'Leopold Bros Georgia Peach whiskey'),
(24, 6, '2', 2, 'The Dead Rabbit Orinoco bitters'),
(25, 6, '1', 7, 'orange twist'),
(26, 7, '2', 3, 'bourbon or rye'),
(27, 7, '1', 3, 'sweet vermouth'),
(28, 7, '2', 2, 'Angostura bitters'),
(29, 7, '1', 2, 'orange bitters'),
(30, 7, '1', 7, 'brandied cherry'),
(31, 8, '2', 3, 'light rum'),
(32, 8, '1', 7, 'fresh lime juice'),
(33, 8, '3', 3, 'demerara sugar syrup'),
(34, 8, '1', 7, 'lime twist'),
(35, 9, '1', 3, 'Gin'),
(36, 9, '1', 3, 'Campari'),
(37, 9, '1', 3, 'sweet vermouth'),
(38, 9, '1', 7, 'orange peel'),
(39, 10, '2', 7, 'Orange slices'),
(40, 10, '2', 7, 'Brandied or maraschino cherries'),
(41, 10, '3', 2, 'Angostura bitters'),
(42, 10, '1', 8, 'Sugar'),
(43, 10, '1', 2, 'sour mix and soda water'),
(44, 10, '2', 3, 'Brandy'),
(45, 11, '2', 3, 'brandy'),
(46, 11, '1', 3, 'sweet vermouth'),
(47, 11, '1', 3, 'simple syrup'),
(48, 11, '2', 2, 'Angostura bitters'),
(49, 12, '2', 3, 'tequila'),
(50, 12, '15', 3, 'lime juice'),
(51, 12, '4', 3, 'grapefruit soda'),
(52, 13, '30', 1, 'vodka'),
(53, 13, '15', 1, 'Lychee');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `log_id` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `browser` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `success` varchar(255) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`log_id`, `ip`, `browser`, `action`, `success`, `time`) VALUES
(2, '::1', 'PostmanRuntime/7.25.0', 'login', 'success', '2020-06-14 02:00:37'),
(3, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-14 02:01:30'),
(4, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'fail', '2020-06-14 02:02:00'),
(5, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'register', 'success', '2020-06-14 02:08:06'),
(6, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-14 02:08:20'),
(7, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'logout', 'success', '2020-06-14 02:09:11'),
(8, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-14 02:09:22'),
(9, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'create recipe', 'success', '2020-06-14 02:11:04'),
(10, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-14 02:11:55'),
(11, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'create recipe', 'success', '2020-06-14 02:12:08'),
(12, '::1', 'PostmanRuntime/7.25.0', 'login', 'success', '2020-06-14 02:12:31'),
(13, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:13:36'),
(14, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:17:19'),
(15, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:18:42'),
(16, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:19:34'),
(17, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:20:25'),
(18, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:21:05'),
(19, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:21:34'),
(20, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:22:33'),
(21, '::1', 'PostmanRuntime/7.25.0', 'create recipe', 'success', '2020-06-14 02:23:27'),
(22, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-14 02:23:42'),
(23, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'create recipe', 'success', '2020-06-14 02:24:49'),
(24, '::1', 'PostmanRuntime/7.25.0', 'delete recipe', 'fail', '2020-06-14 02:25:46'),
(25, '::1', 'PostmanRuntime/7.25.0', 'delete recipe', 'fail', '2020-06-14 02:26:06'),
(26, '::1', 'PostmanRuntime/7.25.0', 'delete recipe', 'fail', '2020-06-14 02:26:08'),
(27, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-14 02:27:16'),
(28, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-14 02:27:44'),
(29, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:28:23'),
(30, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'create comment', 'success', '2020-06-14 02:28:32'),
(31, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete comment', 'success', '2020-06-14 02:28:36'),
(32, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:29:36'),
(33, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:29:41'),
(34, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:29:46'),
(35, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:30:11'),
(36, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:30:17'),
(37, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:30:22'),
(38, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:30:27'),
(39, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:30:32'),
(40, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 02:30:36'),
(41, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-14 03:45:46'),
(42, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'delete recipe', 'success', '2020-06-14 03:45:58'),
(43, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-17 20:19:07'),
(44, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'login', 'success', '2020-06-17 20:28:51'),
(45, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:29:22'),
(46, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:29:57'),
(47, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:30:15'),
(48, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:30:39'),
(49, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:30:48'),
(50, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:30:58'),
(51, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:31:17'),
(52, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:31:26'),
(53, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:33:00'),
(54, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:33:25'),
(55, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:33:51'),
(56, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:34:35'),
(57, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:35:42'),
(58, '::1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:35:54'),
(59, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:38:01'),
(60, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:38:04'),
(61, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:38:07'),
(62, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:38:24'),
(63, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:38:45'),
(64, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:39:01'),
(65, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:39:14'),
(66, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:39:20'),
(67, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:39:36'),
(68, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:39:51'),
(69, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:40:08'),
(70, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:40:26'),
(71, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:40:39'),
(72, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:40:45'),
(73, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:40:49'),
(74, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:41:11'),
(75, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:41:18'),
(76, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:41:23'),
(77, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1', 'update recipe', 'success', '2020-06-17 20:41:33');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `privilege` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`user_id`, `username`, `password`, `privilege`) VALUES
(17, 'Frederick', '$2y$10$EbFllraPXX8nkd.4TXSfi.DRd6b7hPgq.fWBWRVCIHGhXcPPysvHm', 1),
(18, 'uxboi', '$2y$10$SmJ4l7NqeGDusc9MwyoVn.Qb5Mkb5F3dZnDUAz5xnKL28nW6o86l6', 2),
(19, 'uxgurl', '$2y$10$8oJj8qEdird3YIFp7VLOneujk1ZYt4grFehQtpMIY3rR.NNJlHjEC', 2),
(20, 'admin', '$2y$10$cScn7le/WJVxAyGpe/69VOxAjBT1ZLywL4it7SYovi42Jmnm1ZJ4C', 1),
(21, 'uxtest', '$2y$10$je10c95XB7JoVie239QQtun2iClR1PrxEJQBKZbxJKVXs5B.uyw9a', 2);

-- --------------------------------------------------------

--
-- Table structure for table `measurement`
--

CREATE TABLE `measurement` (
  `mea_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `measurement`
--

INSERT INTO `measurement` (`mea_id`, `type`) VALUES
(1, 'ml'),
(2, 'dash(es)'),
(3, 'oz'),
(4, 'drop(s)'),
(5, 'cup(s)'),
(6, 'slice(s)'),
(7, 'fresh'),
(8, 'cube(s)'),
(9, 'tsp'),
(10, 'tbsp'),
(11, 'bottle(s)'),
(12, 'can(s)'),
(13, 'pinch');

-- --------------------------------------------------------

--
-- Table structure for table `method`
--

CREATE TABLE `method` (
  `met_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  `step` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `method`
--

INSERT INTO `method` (`met_id`, `recipe_id`, `step`) VALUES
(1, 1, 'Add the sugar, bitters and water into a rocks glass, and stir until sugar is nearly dissolved.'),
(2, 1, 'Fill the glass with large ice cubes, add the bourbon, and gently stir to combine.'),
(3, 1, 'Express the oil of an orange peel over the glass, then drop in.'),
(4, 2, 'Add all the ingredients into a shaker with ice, and shake until chilled.'),
(5, 2, 'Strain into the prepared rocks glass over fresh ice.'),
(6, 2, 'Garnish with a lime wheel and kosher salt (optional).'),
(7, 3, 'Fill a tall glass with ice, and add the rum.'),
(8, 3, 'Top with the ginger beer.'),
(9, 3, 'Garnish with a lime wedge.'),
(10, 4, 'Add all the ingredients into a mixing glass with ice and stir.'),
(11, 4, 'Strain into a chilled cocktail glass.'),
(12, 4, 'Garnish with 2 olives.'),
(13, 5, 'Add all the ingredients into a mixing glass with ice and stir until very cold.'),
(14, 5, 'Strain into a chilled cocktail glass.'),
(15, 5, 'Garnish with a lemon twist.'),
(16, 6, 'Combine all ingredients in a rocks glass and fill with ice.'),
(17, 6, 'Garnish with an orange twist.'),
(18, 7, 'Add all the ingredients into a mixing glass with ice, and stir until well chilled.'),
(19, 7, 'Strain into a chilled coupe.'),
(20, 7, 'Garnish with a brandied cherry.'),
(21, 8, 'Add all the ingredients into a shaker with ice, and shake until well chilled.'),
(22, 8, 'Strain into a chilled coupe.'),
(23, 8, 'Garnish with a lime twist.'),
(24, 9, 'Add all the ingredients into a mixing glass with ice, and stir until well chilled.'),
(25, 9, 'Strain into a rocks glass filled with large ice cubes.'),
(26, 9, 'Garnish with an orange peel.'),
(27, 10, 'Add all of the ingredients except for the brandy to an Old Fashioned glass and muddle.'),
(28, 10, 'Add ice to fill the glass, add the brandy, then top with the 7Up/Sprite (or seltzer or sour soda).'),
(29, 10, 'Garnish with a skewered brandied or maraschino cherry and an orange slice.'),
(30, 11, 'Pour the ingredients into a cocktail shaker with ice cubes.'),
(31, 11, 'Shake well until the shaker is chilled.'),
(32, 11, 'Strain into a chilled cocktail glass.'),
(33, 12, 'Gather the ingredients'),
(34, 12, 'If desired, rim a collins glass with salt. Begin by wetting the rim with a lime wedge, then roll it in a small dish of salt.'),
(35, 12, 'Fill the glass with ice and add the tequila and lime juice.'),
(36, 12, 'Top it off with grapefruit soda and enjoy!'),
(37, 13, 'Shake well, pour mix in martini glass.');

-- --------------------------------------------------------

--
-- Table structure for table `recipe`
--

CREATE TABLE `recipe` (
  `recipe_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(2083) NOT NULL,
  `imgUrl` varchar(2083) NOT NULL DEFAULT 'https://via.placeholder.com/150',
  `thumbsUp` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipe`
--

INSERT INTO `recipe` (`recipe_id`, `name`, `description`, `imgUrl`, `thumbsUp`, `user_id`) VALUES
(1, 'Old Fashioned', 'One of the great classic bourbon cocktails, the Old Fashioned was invented in Louisville, KY. Try bourbon, rye, or a blended whiskey in this cocktail. You can also sub one sugar cube for the simple syrup.', 'https://www.liquor.com/thmb/lavmUGaMMriZPSxfHsPnyK15bSY=/720x720/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__05__08113350__bourbon-old-fashioned-720x720-recipe-ade6f7780c304999be3577e565c9bcdd.jpg', 93, 18),
(2, 'Margarita', 'The Margarita is one of the most popular cocktails in North America—for good reason. Combining the tang of lime and the sweetness of orange liqueur with the distinctive strength of tequila, our classic Margarita strikes all of the right keys.', 'https://www.liquor.com/thmb/HzYcHscHlBK0Dj5M6eJOb5M9YjQ=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__04__23134943__Margarita-720x720-recipe-v2-6dc3213825c94a9cb6d7ce1818ce6e31.jpg', 86, 18),
(3, 'Dark \'n Stormy', 'The Dark ’n Stormy is a simple but delicious two-ingredient cocktail of dark rum (the “dark”) and ginger beer (the “stormy”) and is trademarked by Gosling\'s.\n\nIt’s usually garnished with a lime wedge. But any way it’s served, the Dark ’n Stormy is tasty and refreshing.', 'https://www.liquor.com/thmb/e5U_ixZzKIComkO9okCMkXMwUNE=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/dark-and-stormy-720x720-recipe-95f288ed6697444ab3301f8670b4564e.jpg', 76, 18),
(4, 'Dirty Martini', 'In 1901, New York bartender John O\'Connor found inspiration for the Dirty Martini in the classic Martini\'s famous olive garnish. First made by muddling the olive into the drink, and later by adding a splash of olive brine, the Dirty Martini took decades to reach a wide fan base. Today, it’s the go-to sipper for salt-craving drinkers.', 'https://www.liquor.com/thmb/bQAA1NeVHM-ZiyMdSYvJzo9b2tA=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2011__04__15150034__dirty-martini-720x720-recipe-7127449167d548c981c6103fd60f49b0.jpg', 52, 18),
(5, 'Dry Martini', 'You could stumble down a very deep, very dark rabbit hole trying to determine who mixed the world’s first Martini. Was it a California prospector during the 1849 Gold Rush or the barman at a flossy New York City hotel 50 years later? Both stories hold water. Neither will leave you feeling as blissful and content as a well-made Dry Martini.\n\n', 'https://www.liquor.com/thmb/SAWLaMg8mlwccCqsBRdF9aHLsMw=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__09__05093330__dry-martini-720x720-recipe-8a80821c4ca944849690af8cda90cc03.jpg', 40, 18),
(6, 'Rocky Manhattan', 'Try this fresh take on the timeless Manhattan.', 'https://www.liquor.com/thmb/IasQ7NLWztA7cwCLgkLA6uBKmtM=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__12__04142002__rocky-manhattan-720x720-recipe-17bb20ac0a324a16bdbc182f6cca5a8e.jpg', 43, 18),
(7, 'Manhattan', 'The Manhattan was the most famous cocktail in the world shortly after it was invented in New York City’s Manhattan Club, some time around 1880 (as the story goes). Over the years, the whiskey classic has dipped in and out of fashion before finding its footing as one of the cornerstones of the craft cocktail renaissance.', 'https://www.liquor.com/thmb/gSN7fXX_rGkGi-3M6bmPhE7BqAk=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__05__10144903__Manhattan-720x720-recipe-9497922907c14d91898f557cb51f2ea3.jpg', 66, 18),
(8, 'Daiquiri', 'No drink has suffered more abuse than the Daiquiri. In the roughly 130 years since its inception, the granddaddy of rum cocktails has gone from the pride of Havana to an unloved extra on the back of a Senor Frog’s table tent.', 'https://www.liquor.com/thmb/fBdarldJ6my-jGyIsAIH0NvZsW4=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__04__23143458__daiquiri-720x720-recipe-09f1d5665a794eddbbfb997876736136.jpg', 49, 18),
(9, 'Negroni', 'Easy to make and refreshingly bitter, the Negroni is said to have been invented in Florence by a dauntless Italian count who demanded that the bartender replace the club soda in his Americano with gin. It was a substitution that launched a thousand riffs.', 'https://www.liquor.com/thmb/PGdbkJ8aJBacJ3o2TaTBpcl-luQ=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2018__05__08110806__negroni-720x720-recipe-7c1b747a616f4659af4008d025ab55df.jpg', 82, 18),
(10, 'Wisconsin Old Fashioned', 'This cocktail, aka the Brandy Old Fashioned, is practically the official Wisconsin state drink and takes brandy instead of whiskey.', 'https://www.liquor.com/thmb/8X0aqBEX6KDXmQY1v3Ezt1i5PAw=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/__opt__aboutcom__coeus__resources__content_migration__liquor__2017__01__05101700__Wisconsin-Old-Fashioned-720x720-recipe-f89974544ab04118ac85f5f51c46ca49.jpg', 22, 18),
(11, 'Metropolitan', 'A Metropolitan recipe appears in the 1935 The Old Waldorf-Astoria Bar Book, but it calls for 2 Manhattan bitters (obsolete, possibly similar to Amer Picon) and 1 vermouth. While that sounds like an interesting mix, the more common brandy recipe has been noted with the year 1900.', 'https://www.thespruceeats.com/thmb/DEL6rv9WWJ54JqRuODQEI8BpEq0=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/metropolitan-cocktail-578d0a553df78c09e918e700.jpg', 11, 18),
(12, 'Paloma', 'update The paloma is a thirst quenching tequila cocktail that\'s very easy to mix up. A favorite drink from Mexico, it is equally popular worldwide and one of the best ways to show off a great tequila. Paloma is the Spanish word for dove and it\'s a fitting name for this sparkling grapefruit drink.', 'https://www.thespruceeats.com/thmb/lWukwx1jz811AV-R8DKhLEtckW4=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/paloma-cocktail-recipe-760852-5147_preview-5b0ec0bd8e1b6e003e9c35b7.jpeg', 16, 18),
(13, 'Lychee Martini', 'This is a sweet cocktail.', 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2008/6/1/0/RB0109_Lychee-Martini.jpg.rend.hgtvcom.826.620.suffix/1371587301139.jpeg', 0, 18);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`c_id`),
  ADD KEY `recipe_id` (`recipe_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`i_id`),
  ADD KEY `measurement` (`measurement`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `measurement`
--
ALTER TABLE `measurement`
  ADD PRIMARY KEY (`mea_id`);

--
-- Indexes for table `method`
--
ALTER TABLE `method`
  ADD PRIMARY KEY (`met_id`),
  ADD KEY `recipe_id` (`recipe_id`);

--
-- Indexes for table `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`recipe_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
  MODIFY `c_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `i_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `measurement`
--
ALTER TABLE `measurement`
  MODIFY `mea_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `method`
--
ALTER TABLE `method`
  MODIFY `met_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `recipe`
--
ALTER TABLE `recipe`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`),
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `login` (`user_id`);

--
-- Constraints for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`measurement`) REFERENCES `measurement` (`mea_id`),
  ADD CONSTRAINT `ingredient_ibfk_2` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`);

--
-- Constraints for table `method`
--
ALTER TABLE `method`
  ADD CONSTRAINT `method_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`recipe_id`);

--
-- Constraints for table `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `recipe_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `login` (`user_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
