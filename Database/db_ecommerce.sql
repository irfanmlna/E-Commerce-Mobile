-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2024 at 03:42 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `id_product`, `id_user`) VALUES
(1, 25, 1),
(2, 39, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_product` int(11) NOT NULL,
  `status` enum('pending','success','failed') NOT NULL,
  `snap_tokep` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_stock` int(11) NOT NULL,
  `product_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_name`, `product_price`, `product_stock`, `product_image`) VALUES
(21, 'Casio G-Shock', 1200000, 50, 'casio_gshock.jpg'),
(22, 'Seiko 5 Sports', 1500000, 30, 'seiko_5_sports.jpg'),
(23, 'Citizen Eco-Drive', 2000000, 20, 'citizen_ecodrive.jpg'),
(24, 'Tissot Le Locle', 3500000, 10, 'tissot_le_locle.jpg'),
(25, 'Rolex Submariner', 75000000, 10, 'rolex_submariner.jpg'),
(26, 'Omega Seamaster', 45000000, 60, 'omega_seamaster.jpg'),
(27, 'Tag Heuer Carrera', 30000000, 25, 'tag_heuer_carrera.jpg'),
(28, 'Patek Philippe Nautilus', 100000000, 5, 'patek_philippe_nautilus.jpg'),
(29, 'Audemars Piguet Royal Oak', 85000000, 7, 'audemars_piguet_royal_oak.jpg'),
(30, 'Breitling Navitimer', 40000000, 15, 'breitling_navitimer.jpg'),
(31, 'Hamilton Khaki Field', 800000, 45, 'hamilton_khaki_field.jpg'),
(32, 'Oris Aquis', 2500000, 55, 'oris_aquis.jpg'),
(33, 'Longines Master Collection', 3000000, 35, 'longines_master.jpg'),
(34, 'Panerai Luminor', 50000000, 10, 'panerai_luminor.jpg'),
(35, 'Hublot Big Bang', 60000000, 12, 'hublot_big_bang.jpg'),
(36, 'Cartier Tank', 40000000, 8, 'cartier_tank.jpg'),
(37, 'IWC Portugieser', 45000000, 9, 'iwc_portugieser.jpg'),
(38, 'Jaeger-LeCoultre Reverso', 55000000, 6, 'jaeger_lecoultre_reverso.jpg'),
(39, 'Zenith El Primero', 35000000, 18, 'zenith_el_primero.jpg'),
(40, 'Montblanc TimeWalker', 15000000, 20, 'montblanc_timewalker.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `profil_image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `address`, `email_verified_at`, `profil_image`) VALUES
(1, 'abdillah', 'abdillah@gmail.com', 'test', 'padang', '2024-05-28 01:22:42', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_ibfk_1` (`id_product`),
  ADD KEY `cart_ibfk_2` (`id_user`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_product` (`id_product`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
