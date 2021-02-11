-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 12, 2020 at 06:55 AM
-- Server version: 10.1.44-MariaDB
-- PHP Version: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nutgunsy_smilepark`
--

-- --------------------------------------------------------

--
-- Table structure for table `announceTable`
--

CREATE TABLE `announceTable` (
  `id` int(11) NOT NULL,
  `ref_obstacle_id` int(11) NOT NULL,
  `announce_datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `announceTable`
--

INSERT INTO `announceTable` (`id`, `ref_obstacle_id`, `announce_datetime`) VALUES
(1, 63, '2020-12-02 16:23:03'),
(4, 77, '2020-12-03 14:39:12');

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
  `url_image` text COLLATE utf8_unicode_ci,
  `expire_status` tinyint(1) NOT NULL DEFAULT '0',
  `device_id` text COLLATE utf8_unicode_ci,
  `device_token` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `carTable`
--

INSERT INTO `carTable` (`id`, `car_identify`, `car_province`, `owner_name`, `owner_contact`, `park_date`, `park_datetime`, `url_image`, `expire_status`, `device_id`, `device_token`) VALUES
(1, 'กษ-8618', 'กาญจนบุรี', 'ณัฐวัฒน์ วานิชธัญทรัพย์', '083-6141565', '2020-11-03', '2020-11-03 17:15:19', NULL, 0, NULL, NULL),
(16, 'ขธธ-9', 'ชลบุรี', 'Nutthawat', '000000000', '2020-11-03', '2020-11-03 07:58:59', 'car1.jpg', 0, NULL, NULL),
(20, 'abc-1234', 'กทม', 'วิมลสิริ', '0851654065', '2020-11-09', '2020-11-09 04:10:26', '/SMILEPARK/car/pic_car43982.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(21, 'xxx-888', 'กทม', 'Dr.dee', '089-99999', '2020-11-08', '2020-11-08 08:53:48', '', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(23, 'กก-1111', 'กทม', 'ไนท์', '085-555555', '2020-11-21', '2020-11-21 15:08:02', '/SMILEPARK/car/pic_car32832.jpg', 0, NULL, NULL),
(30, 'ททท-999', 'ชลบุรี', 'นัท', '0851654065', '2020-11-08', '2020-11-08 06:00:15', '/SMILEPARK/car/pic_car60595.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(31, 'ยยย-555', 'ชลบุรี', 'กันดัม', '8095636888', '2020-11-09', '2020-11-09 06:11:00', '/SMILEPARK/car/pic_car95430.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(32, '3คค8888', 'ชลบุรี', 'พัฒนา', '089562355', '2020-11-09', '2020-11-09 06:28:51', '/SMILEPARK/car/pic_car43982.jpg', 0, NULL, 'eTVT2mbNRqGbO32snj7kQg:APA91bEIcKDmDEhBeeAOLchlok5M0z_ABs68S5Pi56vuIUMiwCR2nlyZBlMNGG1UFeZ9SAAige_UHdIERAxzYIofzjbKj3f9ml2z7cJg1aoN1PPJCp-Y1Os_iUyUfjcpd0BD66u3Bm9K'),
(33, 'ขข-9999', 'กทม', 'มหาสมคิด ', '9999999999', '2020-11-20', '2020-11-20 09:18:25', 'null', 0, NULL, '111sdsfekklmdvkdsnfw2e34rlfmfvmv'),
(34, 'จก 3072', 'ชลบุรี', 'วิมลสิริ', '0851654065', '2020-12-11', '2020-12-11 10:05:36', '/SMILEPARK/car/pic_car41419.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(35, 'กก-1111', 'ชลบุรี', 'เจตติน', '0882449829', '2020-11-21', '2020-11-21 12:34:16', '/SMILEPARK/car/pic_car66099.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(39, 'จญ 7777', 'กทม', 'เอ๋', '859555558', '2020-11-20', '2020-11-20 10:17:12', '/SMILEPARK/car/pic_car43982.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(40, 'กข 4455', 'ชลบุรี', 'ประดิษฐ์', '085142555', '2020-11-20', '2020-11-20 06:43:53', '/SMILEPARK/car/pic_car43982.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(41, '1คค-3333', 'ตาก', 'โอภาส', '089175488', '2020-11-21', '2020-11-21 10:01:10', '/SMILEPARK/car/pic_car26988.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(42, '3งง 4455', 'สระบุรี', 'เด็ด', '082865885', '2020-11-21', '2020-11-21 10:03:44', '/SMILEPARK/car/pic_car23981.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(43, 'ททท 6789', 'กทม', 'สามารถ', '08255588', '2020-11-22', '2020-11-22 06:37:45', '/SMILEPARK/car/pic_car49539.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(44, 'ททท 6789', 'นครปฐม', 'องอาจ', '089555555', '2020-11-22', '2020-11-22 07:01:05', '', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(47, 'วว 999', 'ชลบุรี', 'ปลา', '08285885', '2020-11-23', '2020-11-23 08:00:01', '/SMILEPARK/car/pic_car50399.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(48, 'รร 001', 'กทม', 'เอ็ดดี้', '085555855', '2020-11-23', '2020-11-23 08:27:04', '/SMILEPARK/car/pic_car30370.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(49, 'ขข222', 'ชลบุรี', 'เก๋', '0851654065', '2020-12-03', '2020-12-03 14:35:01', '/SMILEPARK/car/pic_car78080.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(50, 'กก 111', 'ชลบุรี', 'วัฒนา', '0895628855', '2020-12-11', '2020-12-11 14:35:10', '/SMILEPARK/car/pic_car90951.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(51, 'กก 3456', 'ชลบุรี', 'เอก', '0895258855', '2020-12-11', '2020-12-11 09:54:50', '/SMILEPARK/car/pic_car8916.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(52, 'กก 3456', 'สงขลา', 'หาญ', '085755485', '2020-12-11', '2020-12-11 19:30:38', '/SMILEPARK/car/pic_car86759.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs');

-- --------------------------------------------------------

--
-- Table structure for table `obstacleTable`
--

CREATE TABLE `obstacleTable` (
  `id` int(11) NOT NULL,
  `ref_car_id` text COLLATE utf8_unicode_ci NOT NULL,
  `ref_station_id` int(11) DEFAULT NULL,
  `issue_date` date NOT NULL,
  `issue_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `informer_name` text COLLATE utf8_unicode_ci NOT NULL,
  `informer_contact` text COLLATE utf8_unicode_ci NOT NULL,
  `expire_status` tinyint(1) NOT NULL DEFAULT '0',
  `device_id` text COLLATE utf8_unicode_ci,
  `url_image` text COLLATE utf8_unicode_ci,
  `acknowledge_status` tinyint(1) DEFAULT '0',
  `acknowledge_datetime` datetime DEFAULT NULL,
  `informer_device_token` text COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `obstacleTable`
--

INSERT INTO `obstacleTable` (`id`, `ref_car_id`, `ref_station_id`, `issue_date`, `issue_datetime`, `informer_name`, `informer_contact`, `expire_status`, `device_id`, `url_image`, `acknowledge_status`, `acknowledge_datetime`, `informer_device_token`) VALUES
(1, '1', 1, '2020-11-05', '2020-12-08 08:35:20', 'ณัฐวัฒน์ สุดหล่อ', '088-777777', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0, NULL, NULL),
(6, '20', 1, '2020-11-05', '2020-12-08 08:35:20', 'ประเสริฐ รุ่งเรือง', '088-8888888', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 1, NULL, NULL),
(8, '16', 1, '2020-11-05', '2020-12-08 08:35:20', 'ป้าจุ๋ม', '44444444444', 1, NULL, '/SMILEPARK/obstacle/pic_obstacle58681.jpg', 0, NULL, NULL),
(11, '22', 1, '2020-11-05', '2020-12-08 08:35:20', 'egg 8', '66666666', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0, NULL, NULL),
(15, '21', 1, '2020-11-05', '2020-12-08 08:35:20', 'Mr.A', '089-787888', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0, NULL, NULL),
(16, '20', 1, '2020-11-05', '2020-12-08 08:35:20', 'AAA', '000000000', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 1, NULL, NULL),
(17, '23', 1, '2020-11-05', '2020-12-08 08:35:20', 'เอ', '089-1111111', 1, NULL, '/SMILEPARK/obstacle/pic_default01.jpg', 0, NULL, NULL),
(18, '22', 1, '2020-11-06', '2020-12-08 08:35:20', 'ไก่', '88888', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle49554.jpg', 0, NULL, NULL),
(22, '23', 1, '2020-11-06', '2020-12-08 08:35:20', 'ปลา', '78563215', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle1825.jpg', 0, NULL, NULL),
(24, '21', 1, '2020-11-06', '2020-12-08 08:35:20', 'ฟ้า', '8845255', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle57818.jpg', 0, NULL, NULL),
(33, '20', 1, '2020-11-06', '2020-12-08 08:35:20', 'ไฝ', '333', 0, NULL, '', 1, NULL, NULL),
(34, '20', 1, '2020-11-07', '2020-12-08 08:35:20', 'นายเอ๊ก', '0836141565', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle85717.jpg', 1, NULL, NULL),
(35, '30', 1, '2020-11-07', '2020-12-08 08:35:20', 'ไก่', '0856666111', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle13460.jpg', 0, NULL, NULL),
(36, '31', 1, '2020-11-07', '2020-12-08 08:35:20', 'นัท', '386655896', 0, NULL, '', 0, NULL, NULL),
(37, '32', 1, '2020-11-11', '2020-12-08 08:35:20', 'ใฝ', '085125455', 0, NULL, '', 0, NULL, NULL),
(41, '21', 1, '2020-11-08', '2020-12-08 08:35:20', 'ปลา', '087452655', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle12260.jpg', 0, NULL, NULL),
(42, '20', 1, '2020-11-08', '2020-12-08 08:35:20', 'ฝน', '085623455', 0, NULL, '', 0, NULL, NULL),
(43, '33', 1, '2020-11-11', '2020-12-08 08:35:20', 'สมชาย', '086715258', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle69081.jpg', 0, NULL, NULL),
(44, '34', 1, '2020-11-11', '2020-12-10 10:12:52', 'สมหวัง', '0851654065', 0, NULL, '', 1, '2020-12-10 10:12:52', NULL),
(45, '35', 1, '2020-11-11', '2020-12-08 08:35:20', 'ไก่', '96355555', 0, NULL, '', 1, '2020-12-03 14:37:06', NULL),
(57, '36', 1, '2020-11-13', '2020-12-08 08:35:20', 'ภพ', '93865885', 0, NULL, '', 0, NULL, NULL),
(61, '39', 1, '2020-11-20', '2020-12-08 08:35:20', 'พะเนิน', '08625355', 0, NULL, '', 0, NULL, NULL),
(62, '34', 2, '2020-12-10', '2020-12-10 10:12:52', 'รักนะ', '08955655', 0, NULL, '', 1, '2020-12-10 10:12:52', NULL),
(63, '35', 1, '2020-12-10', '2020-12-10 08:48:21', 'แดง', '085452855', 0, NULL, '', 0, '2020-12-03 14:37:06', NULL),
(67, '41', 1, '2020-12-10', '2020-12-10 08:48:03', 'เกด', '082355558', 0, NULL, '', 0, '2020-12-03 12:15:18', NULL),
(68, '42', 1, '2020-11-21', '2020-12-08 08:35:20', 'พรเทพ', '08285585', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle32971.jpg', 0, NULL, NULL),
(69, '43', 1, '2020-11-22', '2020-12-08 08:35:20', 'สงกรานต์', '0895625855', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle82081.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(74, '47', 1, '2020-11-23', '2020-12-08 08:35:20', 'หมาก', '08528258', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle83853.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(76, '48', 1, '2020-11-23', '2020-12-08 08:35:20', 'องอาจ', '05865885', 0, NULL, '/SMILEPARK/car/pic_car30370.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(77, '50', 1, '2020-12-03', '2020-12-08 08:35:20', 'เก๋', '0851654065', 0, NULL, '/SMILEPARK/obstacle/pic_obstacle96647.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE'),
(78, '49', 1, '2020-12-03', '2020-12-08 08:35:20', 'หาญ', '089558888', 0, NULL, '/SMILEPARK/car/pic_car78080.jpg', 0, NULL, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs'),
(81, '51', 2, '2020-12-10', '2020-12-10 10:11:49', 'ภพ', '0856555555', 0, NULL, '/SMILEPARK/car/pic_car8916.jpg', 0, NULL, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE');

-- --------------------------------------------------------

--
-- Table structure for table `stationTable`
--

CREATE TABLE `stationTable` (
  `id` int(11) NOT NULL,
  `device_token` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ref_station_id` int(11) NOT NULL,
  `mod_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stationTable`
--

INSERT INTO `stationTable` (`id`, `device_token`, `ref_station_id`, `mod_date`) VALUES
(1, 'fXEM2EuVQ_q3r4p1a-wmq-:APA91bGAnf4cAo5ubcKiYQOmI-mbQSkSNOwkv2FZW51zRw5Ig9Xlxq8j2-F3hIPMVSDISV0cTr-5K7iROKYT7DVK5JqL8EHbnda1L4YKDtTHUDyxlN46abFnQug1b8nlxpH_W11YNCNs', 1, '2020-12-09 09:58:11'),
(2, 'xxxxxxxxx', 2, '2020-12-09 10:41:07'),
(8, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 2, '2020-12-09 12:42:51'),
(9, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 1, '2020-12-09 13:04:17'),
(10, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 2, '2020-12-09 13:04:27'),
(11, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 1, '2020-12-09 13:04:33'),
(12, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 2, '2020-12-10 09:45:53'),
(13, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 1, '2020-12-10 10:13:08'),
(14, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 2, '2020-12-11 16:15:53'),
(15, 'c1AmtyG7SPGQGcWsZ2v53E:APA91bG40zcL9BJKl4EQpdFxegnurq9VRgKBrYbH7sKHsyBFvKnuZ-H14uk1EL8Q047uqqTtUHAaVxGqaamCL02enLBoJJP-xJpNMMBtJQJDZJmPJVAcxL7kMyO4boDlIs_XkAHbrlqE', 1, '2020-12-11 16:21:02');

-- --------------------------------------------------------

--
-- Table structure for table `userTable`
--

CREATE TABLE `userTable` (
  `id` int(11) NOT NULL,
  `membertype` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `fullname` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `modifydate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userTable`
--

INSERT INTO `userTable` (`id`, `membertype`, `fullname`, `user`, `password`, `modifydate`) VALUES
(1, 'admin', 'nutthawat senior', 'nutthawat', 'Admin@1234', '2020-12-02 09:53:04');

-- --------------------------------------------------------

--
-- Table structure for table `workStation`
--

CREATE TABLE `workStation` (
  `station_id` int(11) NOT NULL,
  `station_name_en` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `station_name_th` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workStation`
--

INSERT INTO `workStation` (`station_id`, `station_name_en`, `station_name_th`, `description`, `create_date`) VALUES
(1, 'BangSaen Beach', 'หาดบางแสน', 'หาดบางแสน เทศบาลเมืองแสนสุข', '2020-12-08 08:32:39'),
(2, 'Wat Sothon', 'วัดโสธรวราราม', 'วัดหลวงพ่อโสธร [แปดริ้ว] อำเภอเมือง ฉะเชิงเทรา', '2020-12-08 08:38:43');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announceTable`
--
ALTER TABLE `announceTable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carTable`
--
ALTER TABLE `carTable`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `car_identify` (`car_identify`(50),`car_province`(255),`park_date`);

--
-- Indexes for table `obstacleTable`
--
ALTER TABLE `obstacleTable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stationTable`
--
ALTER TABLE `stationTable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userTable`
--
ALTER TABLE `userTable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workStation`
--
ALTER TABLE `workStation`
  ADD PRIMARY KEY (`station_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announceTable`
--
ALTER TABLE `announceTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `carTable`
--
ALTER TABLE `carTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `obstacleTable`
--
ALTER TABLE `obstacleTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `stationTable`
--
ALTER TABLE `stationTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `userTable`
--
ALTER TABLE `userTable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `workStation`
--
ALTER TABLE `workStation`
  MODIFY `station_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
