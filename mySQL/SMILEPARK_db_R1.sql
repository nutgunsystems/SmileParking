-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 08, 2020 at 11:49 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `SMILEPARK`
--

-- --------------------------------------------------------

--
-- Table structure for table `carTable`
--

CREATE TABLE `carTable` (
  `id` int(11) NOT NULL,
  `car_identify` text COLLATE utf8_unicode_ci NOT NULL,
  `car_province` text COLLATE utf8_unicode_ci NOT NULL,
  `owner_name` text COLLATE utf8_unicode_ci NOT NULL,
  `owner_contact` text COLLATE utf8_unicode_ci NOT NULL,
  `park_date` date NOT NULL,
  `park_datetime` datetime NOT NULL,
  `url_image` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `expire_status` tinyint(1) NOT NULL DEFAULT 0,
  `device_id` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `device_token` text COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `carTable`
--

INSERT INTO `carTable` (`id`, `car_identify`, `car_province`, `owner_name`, `owner_contact`, `park_date`, `park_datetime`, `url_image`, `expire_status`, `device_id`, `device_token`) VALUES
(1, 'กษ-8618', 'กาญจนบุรี', 'ณัฐวัฒน์ วานิชธัญทรัพย์', '083-6141565', '2020-11-03', '2020-11-03 17:15:19', NULL, 0, NULL, NULL),
(16, 'ขธธ-9', 'ชลบุรี', 'Nutthawat', '000000000', '2020-11-03', '2020-11-03 07:58:59', 'car1.jpg', 0, NULL, NULL),
(20, 'abc-1234', 'กทม', 'วิมลสิริ', '0851654065', '2020-11-08', '2020-11-08 04:10:26', '/SMILEPARK/car/pic_car43982.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(21, 'xxx-888', 'กทม', 'Dr.dee', '089-99999', '2020-11-08', '2020-11-08 08:53:48', '', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(23, 'กกก-777', 'กทม', 'ไนท์', '085-555555', '2020-11-06', '2020-11-06 15:08:02', '/SMILEPARK/car/pic_car32832.jpg', 0, NULL, NULL),
(30, 'ททท-999', 'ชลบุรี', 'นัท', '0851654065', '2020-11-08', '2020-11-08 06:00:15', '/SMILEPARK/car/pic_car60595.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(31, 'ยยย-555', 'ชลบุรี', 'กันดัม', '8095636888', '2020-11-08', '2020-11-08 06:11:00', '/SMILEPARK/car/pic_car95430.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(32, 'รรร-123', 'ชลบุรี', 'พัฒนา', '089562355', '2020-11-08', '2020-11-08 06:28:51', '/SMILEPARK/car/pic_car94114.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K');

-- --------------------------------------------------------

--
-- Table structure for table `obstacleTable`
--

CREATE TABLE `obstacleTable` (
  `id` int(11) NOT NULL,
  `ref_car_id` text COLLATE utf8_unicode_ci NOT NULL,
  `issue_date` date NOT NULL,
  `issue_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `informer_name` text COLLATE utf8_unicode_ci NOT NULL,
  `informer_contact` text COLLATE utf8_unicode_ci NOT NULL,
  `expire_status` tinyint(1) NOT NULL DEFAULT 0,
  `device_id` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `url_image` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `acknowledge_status` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `obstacleTable`
--

INSERT INTO `obstacleTable` (`id`, `ref_car_id`, `issue_date`, `issue_datetime`, `informer_name`, `informer_contact`, `expire_status`, `device_id`, `url_image`, `acknowledge_status`) VALUES
(1, '1', '2020-11-05', '2020-11-05 22:24:59', 'ณัฐวัฒน์ สุดหล่อ', '088-777777', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0),
(6, '20', '2020-11-05', '2020-11-05 22:24:59', 'ประเสริฐ รุ่งเรือง', '088-8888888', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 1),
(8, '16', '2020-11-05', '2020-11-05 22:24:59', 'ป้าจุ๋ม', '44444444444', 1, NULL, '/SMILEPARK/obstacle/pic_obstacle58681.jpg', 0),
(11, '22', '2020-11-05', '2020-11-05 22:24:59', 'egg 8', '66666666', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0),
(15, '21', '2020-11-05', '2020-11-05 22:24:59', 'Mr.A', '089-787888', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0),
(16, '20', '2020-11-05', '2020-11-05 22:24:59', 'AAA', '000000000', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 1),
(17, '23', '2020-11-05', '2020-11-05 22:24:59', 'เอ', '089-1111111', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0),
(18, '22', '2020-11-06', '2020-11-05 22:56:44', 'ไก่', '88888', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle49554.jpg', 0),
(22, '23', '2020-11-06', '2020-11-06 06:26:46', 'ปลา', '78563215', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle1825.jpg', 0),
(24, '21', '2020-11-06', '2020-11-06 06:49:06', 'ฟ้า', '8845255', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle57818.jpg', 0),
(33, '20', '2020-11-06', '2020-11-06 00:36:37', 'ไฝ', '333', 0, NULL, '', 1),
(34, '20', '2020-11-07', '2020-11-06 23:04:19', 'นายเอ๊ก', '0836141565', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle85717.jpg', 1),
(35, '30', '2020-11-07', '2020-11-07 06:03:59', 'ไก่', '0856666111', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle13460.jpg', 0),
(36, '31', '2020-11-07', '2020-11-07 06:11:41', 'นัท', '386655896', 0, NULL, '', 0),
(37, '32', '2020-11-07', '2020-11-07 06:29:56', 'ใฝ', '085125455', 0, NULL, '', 0),
(41, '21', '2020-11-08', '2020-11-08 06:02:00', 'ปลา', '087452655', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle12260.jpg', 0),
(42, '20', '2020-11-08', '2020-11-08 06:03:49', 'ฝน', '085623455', 0, NULL, '', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carTable`
--
ALTER TABLE `carTable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `obstacleTable`
--
ALTER TABLE `obstacleTable`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carTable`
--
ALTER TABLE `carTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `obstacleTable`
--
ALTER TABLE `obstacleTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
