-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 18, 2021 at 09:34 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testnode`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `name`, `email`, `password`) VALUES
(1, 'test', 'test@test.com', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location_id` int(100) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `uuid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`id`, `name`, `location_id`, `date`, `uuid`) VALUES
(1, 'HUT RI Concert', 1, '2021-08-18', 'e4ef812a-e83e-4e65-9550-79ae783bf651'),
(3, 'Seminar Bitcoin', 2, '2021-08-20', 'bafd658d-2fbf-4f6d-b274-a31119d11026'),
(4, 'Lomba 17-an', 1, '2021-08-20', 'a94fa458-9061-4346-a34f-77e5fc38945a');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `id` int(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`id`, `name`, `uuid`) VALUES
(1, 'Jakarta', 'f163524a-d563-45d0-b18f-9f2c93e503a2'),
(2, 'Bali', '4d8cfa33-4f1f-45ae-98f4-31a4b59eb24e'),
(3, 'Jateng', 'ec04db6c-1454-4faa-805f-558810f5cfe9'),
(4, 'Banjarmasin', 'c78a46d9-00fa-4ed0-bc7a-2fae77c5ef8c'),
(6, 'Aceh', '9a5c077f-93ce-4a80-afca-a9fe848bcc2d');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE `ticket` (
  `id` int(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `event_id` int(100) NOT NULL,
  `price` varchar(255) NOT NULL,
  `quota` int(255) NOT NULL,
  `uuid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`id`, `name`, `event_id`, `price`, `quota`, `uuid`) VALUES
(1, 'Tiket 17an', 1, '100000', 94, '84cf4d8e-1fa1-4d98-842a-37131111a0f3'),
(2, 'Tiket Lomba 17-an', 4, '50000', 100, '44cd1df5-01a7-4f25-aa18-367f743de512'),
(5, 'Tiket Lomba 17-an', 4, '50000', 100, '0ec3db44-941f-4fce-868a-a03aec43cc8b');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(100) NOT NULL,
  `ticket_id` int(100) NOT NULL,
  `customer_id` int(100) NOT NULL,
  `trans_date` date NOT NULL DEFAULT current_timestamp(),
  `uuid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `ticket_id`, `customer_id`, `trans_date`, `uuid`) VALUES
(1, 1, 1, '2021-08-19', ''),
(2, 1, 1, '2021-08-19', ''),
(3, 1, 1, '2021-08-20', ''),
(4, 1, 1, '2021-08-20', 'f742717e-9b8b-479f-8ec7-0543121c1bf2'),
(5, 1, 1, '2021-08-20', 'd49b40c8-8c38-4cac-a804-00df74f73a6b'),
(6, 1, 1, '2021-08-20', '3ff26c4b-0e3d-430b-b631-637f2474dbaa'),
(7, 1, 1, '2021-08-20', '43cbe0fd-ec71-4fdf-8249-d7701b861b8c'),
(8, 1, 1, '2021-08-20', 'c3572742-679c-42ca-937e-b7100de2af79'),
(9, 1, 1, '2021-08-20', '660d557b-dc24-4e05-85fd-c12fdcc0f71c'),
(10, 1, 1, '2021-08-20', 'ace26153-ed8c-4b3c-8039-419d15893062'),
(11, 1, 1, '2021-08-20', 'da8c7d31-dc8b-4811-86ba-a48f99fbb0c5'),
(12, 1, 1, '2021-08-20', '8fdcfffa-debb-4226-9d51-145197f7dac8'),
(13, 1, 1, '2021-08-20', 'a1177936-85d9-4310-a089-041d3ec08614'),
(14, 1, 1, '2021-08-20', '218b8ef7-1001-40f6-94f5-3b25cab27273'),
(15, 1, 1, '2021-08-20', 'dd8fe8d2-6fea-4407-853c-0339de9b9ff9');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `location`
--
ALTER TABLE `location`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ticket`
--
ALTER TABLE `ticket`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
