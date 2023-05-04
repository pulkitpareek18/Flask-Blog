-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2023 at 11:52 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` longtext NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` longtext NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'Pulkit Pareke', '9090909090', 'Hi!, this is a test message.', '0000-00-00 00:00:00', 'pulkitpareekofficial@gmai.com'),
(2, 'Pulkit Pareke', '9090909090', 'Hi!, this is a test message.', '2023-05-02 09:16:03', 'pulkitpareekofficial@gmai.com'),
(3, 'Pulkit Pareek', '9090909090', 'Hi!, this is a test message.', '2023-05-02 09:19:46', 'pulkitpareekofficial@gmail.com'),
(4, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:34:30', 'pulkitpareekofficial@gmail.com'),
(5, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:36:11', 'pulkitpareekofficial@gmail.com'),
(6, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:44:25', 'pulkitpareekofficial@gmail.com'),
(7, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:45:08', 'pulkitpareekofficial@gmail.com'),
(8, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:47:30', 'pulkitpareekofficial@gmail.com'),
(9, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:57:03', 'pulkitpareekofficial@gmail.com'),
(10, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:58:57', 'pulkitpareekofficial@gmail.com'),
(11, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 10:59:59', 'pulkitpareekofficial@gmail.com'),
(12, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 11:00:45', 'pulkitpareekofficial@gmail.com'),
(13, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 11:00:57', 'pulkitpareekofficial@gmail.com'),
(14, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 11:01:33', 'pulkitpareekofficial@gmail.com'),
(15, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 11:03:00', 'pulkitpareekofficial@gmail.com'),
(16, 'Pulkit Pareek', '9090909090', 'Hi, this is test message for gmail.', '2023-05-02 11:03:31', 'pulkitpareekofficial@gmail.com'),
(17, 'Pulkit Pareek', '9090909090', 'ryedfghm', '2023-05-02 11:03:52', 'pulkitpareekofficial@gmai.com'),
(18, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:04:12', 'pulkitpareekofficial@gmail.com'),
(19, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:06:11', 'pulkitpareekofficial@gmail.com'),
(20, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:06:28', 'pulkitpareekofficial@gmail.com'),
(21, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:06:34', 'pulkitpareekofficial@gmail.com'),
(22, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:06:50', 'pulkitpareekofficial@gmail.com'),
(23, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:06:56', 'pulkitpareekofficial@gmail.com'),
(24, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:07:17', 'pulkitpareekofficial@gmail.com'),
(25, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:07:45', 'pulkitpareekofficial@gmail.com'),
(26, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:08:21', 'pulkitpareekofficial@gmail.com'),
(27, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:09:14', 'pulkitpareekofficial@gmail.com'),
(28, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:09:28', 'pulkitpareekofficial@gmail.com'),
(29, 'Pulkit Pareek', '9090909090', ' fdhg dfh fgh', '2023-05-02 11:09:43', 'pulkitpareekofficial@gmail.com'),
(30, 'Pulkit Pareek', '1234567890', 'Dear TheCodingThunder team,\r\n\r\nI wanted to take a moment to express my sincere thanks and appreciation for the amazing content that you provide on your website. Your website has been an invaluable resource for me in my journey to improve my coding skills and knowledge.\r\n\r\nI have been consistently impressed with the high quality of your content, which is always well-researched, informative, and engaging. Your articles and tutorials have helped me to better understand complex coding concepts and have provided me with valuable insights and tips that I have been able to apply in my own work.\r\n\r\nI am truly grateful for the time and effort that you put into creating such great content and for sharing your knowledge and expertise with the community. You are making a real difference in the lives of coders everywhere, and I am honored to be a part of your audience.\r\n\r\nOnce again, thank you so much for everything that you do. I look forward to continuing to learn from you and to seeing all the great content that you will produce in the future.\r\n\r\nBest regards,\r\nPulkit Pareek', '2023-05-02 11:19:31', 'pulkitpareekofficial@gmail.com'),
(31, 'Your father', '9724973340', 'Gandu*', '2023-05-03 21:54:38', 'misstoxicxyz@gmail.com'),
(32, 'Your father', '9724973340', 'Gandu*', '2023-05-03 21:54:54', 'misstoxicxyz@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` longtext NOT NULL,
  `tagline` longtext NOT NULL,
  `content` longtext NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `slug` varchar(1100) NOT NULL,
  `img_file` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `content`, `date`, `slug`, `img_file`) VALUES
(5, 'This is third post.', 'Tagline 3.', 'This is content for 3rd post.', '2023-05-02 21:38:38', 'fifth-post', ''),
(6, 'title', 'har khoon mein swag', 'contentwa', '2023-05-04 11:33:41', 'slugji', 'home-bg.jpg'),
(7, 'Everest', 'Taste me best, Mummy aur Everest', 'Everest Kitchen King', '2023-05-04 15:12:21', 'taste', 'about-bg.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`),
  ADD UNIQUE KEY `slug` (`slug`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
