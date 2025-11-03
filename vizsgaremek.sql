-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 03, 2025 at 09:38 AM
-- Server version: 5.7.24
-- PHP Version: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vizsgaremek`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAppointment` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFaculties` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUniversities` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllWorker` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointment` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFaculty` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversitiesXFaculties` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversity` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUser` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserXAppointment` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getWorker` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getWorkerXAppointment` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setAppointment` (IN `date` DATE, IN `capacity` INT(2))   BEGIN
	INSERT INTO `appointment`( `Date`, `Capacity`, `IsFull`) VALUES (date,capacity,0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setFaculty` (IN `name` VARCHAR(100), IN `description` VARCHAR(500))   BEGIN
	INSERT INTO `faculties`(`name`, `description`) VALUES (name,description);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUniversitiesXFaculties` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUniversity` (IN `name` VARCHAR(400), IN `location` VARCHAR(1000))   BEGIN
	INSERT INTO `universities`(`name`, `location`) VALUES (name,location);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUser` (IN `firstname` VARCHAR(50), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20))   BEGIN
	INSERT INTO `user`(`Firstname`, `Lastname`, `UserName`, `Email`, `password`) VALUES (firstname,lastname,username,email,password);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUserXAppointment` ()   BEGIN

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setWorker` (IN `firstname` VARCHAR(50), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20), IN `phone` VARCHAR(15))   BEGIN
	INSERT INTO `worker`( `Firstname`, `Lastname`, `Phone`, `Email`, `Password`, `UserName`) VALUES (firstname,lastname,phone,email,password,username);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setWorkerXAppointment` (IN `workerId` INT(11), IN `appointmentId` INT(11))   BEGIN
	INSERT INTO `workerxappointment`(`AppointmentId`, `WorkerId`) VALUES (workerId,appointmentId);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `AppointmentId` int(11) NOT NULL,
  `Date` datetime NOT NULL,
  `Capacity` int(2) NOT NULL,
  `IsFull` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`AppointmentId`, `Date`, `Capacity`, `IsFull`) VALUES
(1, '2025-10-28 10:15:00', 20, 0);

-- --------------------------------------------------------

--
-- Table structure for table `faculties`
--

CREATE TABLE `faculties` (
  `karId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `egyetemId` int(11) NOT NULL,
  `name` varchar(400) NOT NULL,
  `location` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `universitiesxfaculties`
--

CREATE TABLE `universitiesxfaculties` (
  `egyetemekXkarokId` int(11) NOT NULL,
  `egyetemId` int(11) NOT NULL,
  `karId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserId` int(11) NOT NULL,
  `Lastname` varchar(50) NOT NULL,
  `Firstname` varchar(50) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserId`, `Lastname`, `Firstname`, `UserName`, `Email`, `password`) VALUES
(4, 'Kis', 'József', 'Kisjozsef', 'kisjozsef@gmail.com', 'Jelszo');

-- --------------------------------------------------------

--
-- Table structure for table `userxappointment`
--

CREATE TABLE `userxappointment` (
  `userXappointmentId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `AppointmentId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `worker`
--

CREATE TABLE `worker` (
  `WorkerId` int(11) NOT NULL,
  `Lastname` varchar(50) NOT NULL,
  `Firstname` varchar(50) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `worker`
--

INSERT INTO `worker` (`WorkerId`, `Lastname`, `Firstname`, `UserName`, `Password`, `Email`, `Phone`) VALUES
(2, 'Dolgozó', 'Pista', 'DolgozóPista', 'Jelszo', 'dolgozopista@gmail.com', '123456789');

-- --------------------------------------------------------

--
-- Table structure for table `workerxappointment`
--

CREATE TABLE `workerxappointment` (
  `workerXappointmentId` int(11) NOT NULL,
  `AppointmentId` int(11) NOT NULL,
  `WorkerId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`AppointmentId`);

--
-- Indexes for table `faculties`
--
ALTER TABLE `faculties`
  ADD PRIMARY KEY (`karId`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`egyetemId`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `location` (`location`);

--
-- Indexes for table `universitiesxfaculties`
--
ALTER TABLE `universitiesxfaculties`
  ADD PRIMARY KEY (`egyetemekXkarokId`),
  ADD KEY `egyetemId` (`egyetemId`),
  ADD KEY `karId` (`karId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserId`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `UserName` (`UserName`);

--
-- Indexes for table `userxappointment`
--
ALTER TABLE `userxappointment`
  ADD PRIMARY KEY (`userXappointmentId`),
  ADD KEY `AppointmentId` (`AppointmentId`),
  ADD KEY `UserId` (`UserId`);

--
-- Indexes for table `worker`
--
ALTER TABLE `worker`
  ADD PRIMARY KEY (`WorkerId`),
  ADD UNIQUE KEY `UserName` (`UserName`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `Phone` (`Phone`);

--
-- Indexes for table `workerxappointment`
--
ALTER TABLE `workerxappointment`
  ADD PRIMARY KEY (`workerXappointmentId`),
  ADD KEY `AppointmentId` (`AppointmentId`),
  ADD KEY `WorkerId` (`WorkerId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `AppointmentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `faculties`
--
ALTER TABLE `faculties`
  MODIFY `karId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `egyetemId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `universitiesxfaculties`
--
ALTER TABLE `universitiesxfaculties`
  MODIFY `egyetemekXkarokId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `userxappointment`
--
ALTER TABLE `userxappointment`
  MODIFY `userXappointmentId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker`
--
ALTER TABLE `worker`
  MODIFY `WorkerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `workerxappointment`
--
ALTER TABLE `workerxappointment`
  MODIFY `workerXappointmentId` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `universitiesxfaculties`
--
ALTER TABLE `universitiesxfaculties`
  ADD CONSTRAINT `universitiesxfaculties_ibfk_1` FOREIGN KEY (`egyetemId`) REFERENCES `universities` (`egyetemId`),
  ADD CONSTRAINT `universitiesxfaculties_ibfk_2` FOREIGN KEY (`karId`) REFERENCES `faculties` (`karId`);

--
-- Constraints for table `userxappointment`
--
ALTER TABLE `userxappointment`
  ADD CONSTRAINT `userxappointment_ibfk_1` FOREIGN KEY (`AppointmentId`) REFERENCES `appointment` (`AppointmentId`),
  ADD CONSTRAINT `userxappointment_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `user` (`UserId`);

--
-- Constraints for table `workerxappointment`
--
ALTER TABLE `workerxappointment`
  ADD CONSTRAINT `workerxappointment_ibfk_1` FOREIGN KEY (`AppointmentId`) REFERENCES `appointment` (`AppointmentId`),
  ADD CONSTRAINT `workerxappointment_ibfk_2` FOREIGN KEY (`WorkerId`) REFERENCES `worker` (`WorkerId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
