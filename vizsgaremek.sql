-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 01, 2025 at 08:13 AM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAppointment` (IN `id` INT(11))   BEGIN
	UPDATE `appointment` SET `isDeleted`=1, `deletedAt`=CURRENT_DATE() WHERE `appointment`.`AppointmentId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFaculty` (IN `id` INT(11))   BEGIN
	UPDATE `faculties` SET `isDeleted`=1, `deletedAt`=CURRENT_DATE() WHERE `faculties`.`facultyId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUniversity` (IN `id` INT(11))   BEGIN
	UPDATE `universities` SET `isDeleted`=1, `deletedAt`=CURRENT_DATE() WHERE `universities`.`universityId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteWorker` (IN `id` INT(11))   BEGIN
	UPDATE `worker` SET `isDeleted`=1, `deletedAt`=CURRENT_DATE() WHERE `worker`.`WorkerId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deteteUser` (IN `id` INT(11))   BEGIN
	UPDATE `user` SET `isDeleted`=1, `deletedAt`=CURRENT_DATE() WHERE `user`.`UserId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAppointment` ()   BEGIN
	SELECT * FROM `appointment` WHERE `appointment`.`isDeleted` LIKE 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFaculties` ()   BEGIN
	SELECT * FROM `faculties` WHERE `faculties`.`isDeleted` LIKE 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUniversities` ()   BEGIN
	SELECT * FROM `universities` WHERE `universities`.`isDeleted` LIKE 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers` ()   BEGIN
	SELECT * FROM `user` WHERE `user`.`isDeleted` LIKE 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllWorker` ()   BEGIN
	SELECT * FROM `worker` WHERE `worker`.`isDeleted` LIKE 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointment` (IN `id` INT(11))   BEGIN
	SELECT * FROM `appointment` WHERE `appointment`.`AppointmentId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFaculty` (IN `id` INT(11))   BEGIN
	SELECT * FROM `faculties` WHERE `faculties`.`facultyId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversity` (IN `id` INT(11))   BEGIN
	SELECT * FROM `universities` WHERE `universities`.`universityId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUser` (IN `id` INT(11))   BEGIN
	SELECT * FROM `user` WHERE `user`.`UserId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getWorker` (IN `id` INT(11))   BEGIN
	SELECT * FROM `worker` WHERE `worker`.`WorkerId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setAppointment` (IN `date` DATE, IN `capacity` INT(2))   BEGIN
	INSERT INTO `appointment`( `Date`, `Capacity`, `IsFull`) VALUES (date,capacity,0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setFaculty` (IN `name` VARCHAR(100), IN `description` VARCHAR(500))   BEGIN
	INSERT INTO `faculties`(`name`, `description`) VALUES (name,description);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUniversity` (IN `name` VARCHAR(400), IN `location` VARCHAR(1000))   BEGIN
	INSERT INTO `universities`(`name`, `location`) VALUES (name,location);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUser` (IN `firstname` VARCHAR(50), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20))   BEGIN
	INSERT INTO `user`(`Firstname`, `Lastname`, `UserName`, `Email`, `password`, `isDeleted`) VALUES (firstname,lastname,username,email,password, 0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUserXAppointment` (IN `userId` INT(11), IN `appointmentId` INT(11))   BEGIN
	INSERT INTO `userxappointment` ( `UserId`, `AppointmentId`) VALUES (userId, appointmentId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setWorker` (IN `firstname` VARCHAR(50), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20), IN `phone` VARCHAR(15))   BEGIN
	INSERT INTO `worker`( `Firstname`, `Lastname`, `Phone`, `Email`, `Password`, `UserName`) VALUES (firstname,lastname,phone,email,password,username);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAppointment` (IN `idIN` INT(11), IN `dateIN` DATETIME, IN `capacityIN` INT(2), IN `isfullIN` INT(1))   BEGIN
	UPDATE `appointment` SET `Date`=dateIN, `Capacity`=capacityIN, `IsFull`=isfullIN WHERE `appointment`.`AppointmentId` LIKE idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFaculty` (IN `id` INT(11), IN `name` VARCHAR(100), IN `description` VARCHAR(500))   BEGIN
	UPDATE `faculties` SET `name`=name, `description`=description WHERE `faculties`.`facultyId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUniversity` (IN `idIN` INT(11), IN `nameIN` VARCHAR(400), IN `locationIN` VARCHAR(1000))   BEGIN
	UPDATE `universities` SET `name`=nameIN, `location`=locationIN WHERE `universities`.`universityId` LIKE idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUser` (IN `id` INT(11), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20), IN `firstname` VARCHAR(50))   BEGIN
	UPDATE `user` SET `Lastname`=lastname, `Firstname`=firstname, `UserName`=username, `Email`=email, `password`=password 
    WHERE `user`.`UserId` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateWorker` (IN `idIN` INT(11), IN `lastnameIN` VARCHAR(50), IN `firstnameIN` VARCHAR(50), IN `usernameIN` VARCHAR(50), IN `emailIN` VARCHAR(50), IN `passwordIN` VARCHAR(20), IN `phoneIN` VARCHAR(15))   BEGIN
	UPDATE `worker` SET `Lastname`=lastnameIN, `Firstname`=firstnameIN, `UserName`=usernameIN, `Email`=emailIN, `password`=passwordIN, `Phone`=phoneIN 
    WHERE `worker`.`WorkerId` LIKE idIN;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointmentId` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `capacity` int(2) NOT NULL,
  `IsFull` int(1) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointmentId`, `date`, `capacity`, `IsFull`, `isDeleted`, `deletedAt`) VALUES
(1, '2025-10-28 10:15:00', 20, 0, 1, '2025-11-25 00:00:00'),
(2, '2026-01-18 00:00:00', 30, 0, 0, NULL),
(3, '2026-06-27 00:00:00', 34, 0, 0, NULL),
(4, '2026-04-22 00:00:00', 25, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faculties`
--

CREATE TABLE `faculties` (
  `facultyId` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculties`
--

INSERT INTO `faculties` (`facultyId`, `name`, `description`, `isDeleted`, `deletedAt`) VALUES
(1, 'doktori', 'mert kellenek orvosok', 0, NULL),
(2, 'bölcsész', 'valamit csinál az biztos\r\n', 1, '2025-11-25 00:00:00'),
(3, 'jog', 'mert neked kell jogász', 0, NULL),
(4, 'mérnöki', 'nem tudom mit csinál', 0, NULL),
(5, 'tesnevelési', 'mert kell még több stadion', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `universities`
--

CREATE TABLE `universities` (
  `universityId` int(11) NOT NULL,
  `name` varchar(400) NOT NULL,
  `location` varchar(1000) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `universities`
--

INSERT INTO `universities` (`universityId`, `name`, `location`, `isDeleted`, `deletedAt`) VALUES
(1, 'Semmelweis Egyetem', 'https://www.google.com/maps/place/Semmelweis+Egyetem+%C3%81ltal%C3%A1nos+Orvostudom%C3%A1nyi+Kar/@47.4873751,19.0659224,18z/data=!4m10!1m2!2m1!1sSemmelweis+Egyetem!3m6!1s0x4741dc59ea3ba3cd:0xa255183ce04f11de!8m2!3d47.4873751!4d19.067379!15sChJTZW1tZWx3ZWlzIEVneWV0ZW0iA4gBAZIBCnVuaXZlcnNpdHmqAVQKDS9nLzExYmJybHNsMzkKCS9tLzA0dDduNBABMh4QASIa8dqFcZ0PBIXO2kLLHqByrKpDsJ_HbnD8mOkyFhACIhJzZW1tZWx3ZWlzIGVneWV0ZW3gAQA!16s%2Fg%2F12qfsrgp9?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL),
(2, 'ELTE Eötvös Loránd Tudományegyetem', 'https://www.google.com/maps/place/E%C3%B6tv%C3%B6s+Lor%C3%A1nd+Tudom%C3%A1nyegyetem/@47.4905698,19.0559696,17z/data=!3m1!4b1!4m6!3m5!1s0x4741dc44dc7c9251:0x2259d03e6d01806d!8m2!3d47.4905698!4d19.0585445!16zL20vMDMyZ240?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL),
(3, 'Budapesti Corvinus Egyetem', 'https://www.google.com/maps/place/Budapesti+Corvinus+Egyetem/@47.4861534,19.0556806,17z/data=!3m1!4b1!4m6!3m5!1s0x4741dc502488be69:0xc5b7e757fb438129!8m2!3d47.4861534!4d19.0582555!16zL20vMDRndl9r?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL),
(4, 'Magyar Testnevelési és Sporttudományi Egyetem', 'https://www.google.com/maps/place/Magyar+Testnevel%C3%A9si+%C3%A9s+Sporttudom%C3%A1nyi+Egyetem/@47.4928905,19.0231691,18.25z/data=!4m10!1m2!2m1!1sMagyar+Testnevel%C3%A9si+%C3%A9s+Sporttudom%C3%A1nyi+Egyetem!3m6!1s0x4741dc2f55636f27:0x4c3d127f8f623b6f!8m2!3d47.4929725!4d19.0254182!15sCjBNYWd5YXIgVGVzdG5ldmVsw6lzaSDDqXMgU3BvcnR0dWRvbcOhbnlpIEVneWV0ZW2SAQp1bml2ZXJzaXR5qgFnCg0vZy8xMWI2NnNsZDh3EAEyHhABIhrfflh5CWHUoGeqF5j2vVv7HLpcd8BPqqy-wTI0EAIiMG1hZ3lhciB0ZXN0bmV2ZWzDqXNpIMOpcyBzcG9ydHR1ZG9tw6FueWkgZWd5ZXRlbeABAA!16s%2Fg%2F11b66sld8w?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `universitiesxfaculties`
--

CREATE TABLE `universitiesxfaculties` (
  `universitiesxfacultiesId` int(11) NOT NULL,
  `universityId` int(11) NOT NULL,
  `facultyId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userId` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` longtext NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userId`, `lastName`, `firstName`, `userName`, `email`, `password`, `isDeleted`, `deletedAt`) VALUES
(4, 'Kis', 'József', 'Kisjozsef', 'kisjozsef@gmail.com', 'Jelszo', 0, NULL),
(5, 'Kovács', 'Bence', 'bkovacs', 'bence.kovacs@example.com', 'Passw0rd1', 0, NULL),
(6, 'Tóth', 'Anna', 'annat', 'anna.toth@example.com', 'Secure123!', 0, NULL),
(7, 'Szabó', 'Dávid', 'dszabo', 'david.szabo@example.com', 'Qwerty987', 0, NULL),
(8, 'Farkas', 'Eszter', 'efarkas', 'eszter.farkas@example.com', 'MyPass456', 1, '2025-11-25 00:00:00'),
(9, 'Nagy', 'Gábor', 'gnagy', 'gabor.nagy@example.com', 'TestUser!23', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `userxappointment`
--

CREATE TABLE `userxappointment` (
  `userXappointmentId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `AppointmentId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userxappointment`
--

INSERT INTO `userxappointment` (`userXappointmentId`, `UserId`, `AppointmentId`) VALUES
(3, 4, 1),
(4, 5, 2),
(9, 9, 4);

-- --------------------------------------------------------

--
-- Table structure for table `worker`
--

CREATE TABLE `worker` (
  `workerId` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `password` longtext NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `deletedAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `worker`
--

INSERT INTO `worker` (`workerId`, `lastName`, `firstName`, `userName`, `password`, `email`, `phone`, `isDeleted`, `deletedAt`) VALUES
(2, 'Dolgozó', 'Pista', 'DolgozóPista', 'Jelszo', 'dolgozopista@gmail.com', '123456789', 0, NULL);

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
  ADD PRIMARY KEY (`appointmentId`);

--
-- Indexes for table `faculties`
--
ALTER TABLE `faculties`
  ADD PRIMARY KEY (`facultyId`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`universityId`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `location` (`location`);

--
-- Indexes for table `universitiesxfaculties`
--
ALTER TABLE `universitiesxfaculties`
  ADD PRIMARY KEY (`universitiesxfacultiesId`),
  ADD KEY `egyetemId` (`universityId`),
  ADD KEY `karId` (`facultyId`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `UserName` (`userName`);

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
  ADD PRIMARY KEY (`workerId`),
  ADD UNIQUE KEY `UserName` (`userName`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `Phone` (`phone`);

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
  MODIFY `appointmentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `faculties`
--
ALTER TABLE `faculties`
  MODIFY `facultyId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `universityId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `universitiesxfaculties`
--
ALTER TABLE `universitiesxfaculties`
  MODIFY `universitiesxfacultiesId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `userxappointment`
--
ALTER TABLE `userxappointment`
  MODIFY `userXappointmentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `worker`
--
ALTER TABLE `worker`
  MODIFY `workerId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `universitiesxfaculties_ibfk_1` FOREIGN KEY (`universityId`) REFERENCES `universities` (`universityId`),
  ADD CONSTRAINT `universitiesxfaculties_ibfk_2` FOREIGN KEY (`facultyId`) REFERENCES `faculties` (`facultyId`);

--
-- Constraints for table `userxappointment`
--
ALTER TABLE `userxappointment`
  ADD CONSTRAINT `userxappointment_ibfk_1` FOREIGN KEY (`AppointmentId`) REFERENCES `appointment` (`appointmentId`),
  ADD CONSTRAINT `userxappointment_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `user` (`userId`);

--
-- Constraints for table `workerxappointment`
--
ALTER TABLE `workerxappointment`
  ADD CONSTRAINT `workerxappointment_ibfk_1` FOREIGN KEY (`AppointmentId`) REFERENCES `appointment` (`appointmentId`),
  ADD CONSTRAINT `workerxappointment_ibfk_2` FOREIGN KEY (`WorkerId`) REFERENCES `worker` (`workerId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
