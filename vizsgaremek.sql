-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2026. Feb 09. 13:08
-- Kiszolgáló verziója: 5.7.24
-- PHP verzió: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `vizsgaremek`
--

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAppointment` (IN `id` INT(11))   BEGIN
	UPDATE `appointment` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `appointment`.`appointment_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFaculty` (IN `id` INT(11))   BEGIN
	UPDATE `faculty` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `faculty`.`faculty_id` LIKE id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUniversity` (IN `id` INT(11))   BEGIN
	UPDATE `university` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `university`.`university_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteWorker` (IN `id` INT(11))   BEGIN
	UPDATE `worker` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `worker`.`workerI_id`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deteteUser` (IN `id` INT(11))   BEGIN
	UPDATE `user` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `user`.`user_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAppointment` ()   BEGIN
	SELECT * FROM `appointment` WHERE `appointment`.`is_deleted` = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFaculties` ()   BEGIN
	SELECT * FROM `faculties` WHERE `faculties`.`is_deleted` = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUniversities` ()   BEGIN
	SELECT * FROM university WHERE university.`is_deleted` LIKE 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers` ()   BEGIN
	SELECT * FROM `user` WHERE `user`.`is_deleted` = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllWorker` ()   BEGIN
	SELECT * FROM `worker` WHERE `worker`.`is_deleted` = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointment` (IN `id` INT(11))   BEGIN
	SELECT * FROM `appointment` WHERE `appointment`.`appointment_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointmentByUserId` (IN `userId` INT(11))   BEGIN
	SELECT * FROM userxappointment WHERE userxappointment.user_id = userId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointmentByWorkerId` (IN `workerId` INT(11))   BEGIN
	SELECT * FROM workerxappointment WHERE workerxappointment.worker_id = workerId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFaculty` (IN `id` INT(11))   BEGIN
	SELECT * FROM faculty WHERE faculty.faculty_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFacultyByUniversityId` (IN `universityId` INT(11))   BEGIN
	SELECT * FROM universityxfaculty WHERE universityxfaculty.university_id = universityId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversity` (IN `id` INT(11))   BEGIN
	SELECT * FROM university WHERE university.university_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversityByFacultyId` (IN `facultyId` INT(11))   BEGIN
	SELECT * FROM universityxfaculty WHERE universityxfaculty.faculty_id = facultyId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUser` (IN `id` INT(11))   BEGIN
	SELECT * FROM `user` WHERE `user`.`user_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByAppointmentId` (IN `appointmentId` INT(11))   BEGIN
	SELECT * FROM userxappointment WHERE userxappointment.appointment_id = appointmentId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getWorker` (IN `id` INT(11))   BEGIN
	SELECT * FROM `worker` WHERE `worker`.`worker_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getWorkerByAppointmentId` (IN `appointmentId` INT(11))   BEGIN
	SELECT * FROM workerxappointment WHERE workerxappointment.appointment_id = appointmentId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setAppointment` (IN `date` DATE, IN `capacity` INT(2))   BEGIN
	INSERT INTO `appointment`( `date`, `capacity`, `is_full`) VALUES (date,capacity,0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setFaculty` (IN `name` VARCHAR(100), IN `description` VARCHAR(500))   BEGIN
	INSERT INTO `faculty`(`name`, `description`) VALUES (name,description);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUniversity` (IN `name` VARCHAR(400), IN `location` VARCHAR(1000))   BEGIN
	INSERT INTO `university`(`name`, `location`) VALUES (name,location);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUniversityXFaculty` (IN `univrsityId` INT(11), IN `facultyId` INT(11))   BEGIN
	INSERT INTO `universityxfaculty`(`university_id`, `faculty_id`) VALUES (univrsityId,facultyId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUser` (IN `firstname` VARCHAR(50), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20))   BEGIN
	INSERT INTO `user`(`first_name`, `last_name`, `user_name`, `email`, `password`, `is_deleted`) VALUES (firstname,lastname,username,email,password, 0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUserXAppointment` (IN `userId` INT(11), IN `appointmentId` INT(11))   BEGIN
	INSERT INTO `userxappointment` ( `user_id`, `appointment_id`) VALUES (userId, appointmentId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setWorker` (IN `firstname` VARCHAR(50), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20), IN `phone` VARCHAR(15))   BEGIN
	INSERT INTO `worker`( `first_name`, `last_name`, `phone`, `email`, `password`, `user_name`) VALUES (firstname,lastname,phone,email,password,username);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setWorkerXAppointment` (IN `workerId` INT(11), IN `appointmentId` INT(11))   BEGIN
	INSERT INTO `workerxappointment`( `appointment_id`, `worker_id`) VALUES (appointmentId, workerId);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAppointment` (IN `idIN` INT(11), IN `dateIN` DATETIME, IN `capacityIN` INT(2), IN `isfullIN` INT(1))   BEGIN
	UPDATE `appointment` SET `date`=dateIN, `capacity`=capacityIN, `is_full`=isfullIN WHERE `appointment`.`appointment_id` = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateFaculty` (IN `id` INT(11), IN `name` VARCHAR(100), IN `description` VARCHAR(500))   BEGIN
	UPDATE `faculty` SET `name`=name, `description`=description WHERE `faculty`.`faculty_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUniversity` (IN `idIN` INT(11), IN `nameIN` VARCHAR(400), IN `locationIN` VARCHAR(1000))   BEGIN
	UPDATE `university` SET `name`=nameIN, `location`=locationIN WHERE `university`.`university_id` = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUser` (IN `id` INT(11), IN `lastname` VARCHAR(50), IN `username` VARCHAR(50), IN `email` VARCHAR(50), IN `password` VARCHAR(20), IN `firstname` VARCHAR(50))   BEGIN
	UPDATE `user` SET `last_name`=lastname, `first_name`=firstname, `user_name`=username, `email`=email, `password`=password 
    WHERE `user`.`user_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateWorker` (IN `idIN` INT(11), IN `lastnameIN` VARCHAR(50), IN `firstnameIN` VARCHAR(50), IN `usernameIN` VARCHAR(50), IN `emailIN` VARCHAR(50), IN `passwordIN` VARCHAR(20), IN `phoneIN` VARCHAR(15))   BEGIN
	UPDATE `worker` SET `last_name`=lastnameIN, `first_name`=firstnameIN, `user_name`=usernameIN, `email`=emailIN, `password`=passwordIN, `phone`=phoneIN 
    WHERE `worker`.`worker_id` = idIN;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `capacity` int(2) NOT NULL,
  `Is_full` int(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `date`, `capacity`, `Is_full`, `is_deleted`, `deleted_at`) VALUES
(1, '2025-10-28 10:15:00', 20, 0, 1, '2025-11-25 00:00:00'),
(2, '2026-01-18 00:00:00', 30, 0, 0, NULL),
(3, '2026-06-27 00:00:00', 34, 0, 0, NULL),
(4, '2026-04-22 00:00:00', 25, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `faculty`
--

CREATE TABLE `faculty` (
  `faculty_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `faculty`
--

INSERT INTO `faculty` (`faculty_id`, `name`, `description`, `is_deleted`, `deleted_at`) VALUES
(1, 'doktori', 'mert kellenek orvosok', 0, NULL),
(2, 'Bölcsésztudományi', 'valamit csinál az biztos\r\n', 0, '2025-11-25 00:00:00'),
(3, 'Állam- és Jogtudományi', 'mert neked kell jogász', 0, NULL),
(4, 'mérnöki', 'nem tudom mit csinál', 0, NULL),
(5, 'Sporttudomány', 'mert kell még több stadion', 0, NULL),
(6, 'digitális fogászati tervezés', 'fogakkal foglalkozó tanfolyam', 0, NULL),
(7, 'Gyógyszerésztudományi', 'gyógyszeri alapok elsajátítása, gyógyszerek tanulmányozása, új gyógyszerek fifejlestése', 0, NULL),
(8, 'Egészségtudományi', 'egészségügyi dolgok elsajátítása', 0, NULL),
(9, 'Gyógypedagógiai', 'terápiás tevékenységek elsajátítása, fejlesztésikésségek elsaátításadiagnózisok elemzése', 0, NULL),
(10, 'Informatikai', '', 0, NULL),
(11, 'Pedagógiai és Pszichológiai', 'tanárképzés és pszihológus képzés', 0, NULL),
(12, 'Tanító- és Óvóképző', 'tanár és ovónő képző', 0, NULL),
(13, 'Hittudományi', 'Hitek tanulmányozás, teológiák elsajátítása, hittan tanár és lelkész képzésa', 0, NULL),
(14, 'Szociális és Egészségtudományi', '', 0, NULL),
(15, 'Kereskedelmi, Vendéglátóipari és Idegenforgalmi', '', 0, NULL),
(16, 'Külkereskedelmi', '', 0, NULL),
(17, 'Pénzügyi és Számviteli', '', 0, NULL),
(18, 'Építészmérnöki', '', 0, NULL),
(19, 'Építőmérnöki', '', 0, NULL),
(20, 'Gazdaság- és Társadalomtudományi', '', 0, NULL),
(21, 'Gépészmérnöki', '', 0, NULL),
(22, 'Közlekedésmérnöki és Járműmérnöki', '', 0, NULL),
(23, 'Természettudományi', '', 0, NULL),
(24, 'Vegyészmérnöki és Biomérnöki', '', 0, NULL),
(25, 'Villamosmérnöki és Informatikai', '', 0, NULL),
(26, 'Egészségügyi Közszolgálati', '', 0, NULL),
(27, 'Társadalomtudományi', '', 0, NULL),
(28, 'Pedagógusképző', '', 0, NULL),
(29, 'Gazdaságtudományi', '', 0, NULL),
(30, 'Általános Orvostudományi', '', 0, NULL),
(31, 'Gyermeknevelési és Gyógypedagógiai', '', 0, NULL),
(32, 'műszaki', '', 0, NULL),
(33, 'agrár', '', 0, NULL),
(34, 'művészeti', '', 0, NULL),
(35, 'művészetközvetítési', '', 0, NULL),
(36, 'Közgazdaságtudományi', '', 0, NULL),
(37, 'Kultúratudományi', '', 0, NULL),
(38, 'Vidékfejlesztési', '', 0, NULL),
(39, 'cirkuszművészet', '', 0, NULL),
(40, 'táncművész [kortárstánc]', '', 0, NULL),
(41, 'táncos és próbavezető', '', 0, NULL),
(42, 'általános orvosi', '', 0, NULL),
(43, 'orvosi diagnosztikai analitikus', '', 0, NULL),
(44, 'egészségügyi szervező', '', 0, NULL),
(45, 'ápolás és betegellátás', '', 0, NULL),
(46, 'egészségügyi gondozás és prevenció', '', 0, NULL),
(47, 'konduktor', '', 0, NULL),
(48, 'politikatudomány', '', 0, NULL),
(49, 'anglisztika', '', 0, NULL),
(50, 'csecsemő- és kisgyermeknevelő', '', 0, NULL),
(51, 'germanisztika', '', 0, NULL),
(52, 'keleti nyelvek és kultúrák', '', 0, NULL),
(53, 'képi ábrázolás', '', 0, NULL),
(54, 'óvodapedagógus', '', 0, NULL),
(55, 'szlavisztika', '', 0, NULL),
(56, 'tanító', '', 0, NULL),
(57, 'történem', '', 0, NULL),
(58, 'informatikus könyvtáros', '', 0, NULL),
(59, 'kommunikáció- és médiatudomány', '', 0, NULL),
(60, 'magyar', '', 0, NULL),
(61, 'mozgókép', '', 0, NULL),
(62, 'néprajz', '', 0, NULL),
(63, 'ókori nyelvek és kultúrák', '', 0, NULL),
(64, 'régészet', '', 0, NULL),
(65, 'szabad bölcsészet', '', 0, NULL),
(66, 'újlatin nyelvek és kultúrák', '', 0, NULL),
(67, 'zenekultúra', '', 0, NULL),
(68, 'gazdálkodási és menedzsment', '', 0, NULL),
(69, 'kereskedelem és marketing', '', 0, NULL),
(70, 'nemzetközi gazdálkodás', '', 0, NULL),
(71, 'pénzügy és számvitel', '', 0, NULL),
(72, 'műszaki menedzser', '', 0, NULL),
(73, 'programtervező informatikus', '', 0, NULL),
(74, 'edző', '', 0, NULL),
(75, 'emberi erőforrások', '', 0, NULL),
(76, 'közösségszervezés', '', 0, NULL),
(77, 'pedagógia', '', 0, NULL),
(78, 'pszichológia', '', 0, NULL),
(79, 'rekreáció és életmód', '', 0, NULL),
(80, 'sportszervezés', '', 0, NULL),
(81, 'alkalmazott közgazdaságtan', '', 0, NULL),
(82, 'nemzetközi tanulmányok', '', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `university`
--

CREATE TABLE `university` (
  `university_id` int(11) NOT NULL,
  `name` varchar(400) NOT NULL,
  `location` varchar(1000) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `university`
--

INSERT INTO `university` (`university_id`, `name`, `location`, `is_deleted`, `deleted_at`) VALUES
(1, 'Semmelweis Egyetem', 'https://www.google.com/maps/place/Semmelweis+Egyetem+%C3%81ltal%C3%A1nos+Orvostudom%C3%A1nyi+Kar/@47.4873751,19.0659224,18z/data=!4m10!1m2!2m1!1sSemmelweis+Egyetem!3m6!1s0x4741dc59ea3ba3cd:0xa255183ce04f11de!8m2!3d47.4873751!4d19.067379!15sChJTZW1tZWx3ZWlzIEVneWV0ZW0iA4gBAZIBCnVuaXZlcnNpdHmqAVQKDS9nLzExYmJybHNsMzkKCS9tLzA0dDduNBABMh4QASIa8dqFcZ0PBIXO2kLLHqByrKpDsJ_HbnD8mOkyFhACIhJzZW1tZWx3ZWlzIGVneWV0ZW3gAQA!16s%2Fg%2F12qfsrgp9?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL),
(2, 'Eötvös Loránd Tudományegyetem (Budapest)', 'https://www.google.com/maps/place/E%C3%B6tv%C3%B6s+Lor%C3%A1nd+Tudom%C3%A1nyegyetem/@47.4905698,19.0559696,17z/data=!3m1!4b1!4m6!3m5!1s0x4741dc44dc7c9251:0x2259d03e6d01806d!8m2!3d47.4905698!4d19.0585445!16zL20vMDMyZ240?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL),
(3, 'Budapesti Corvinus Egyetem', 'https://www.google.com/maps/place/Budapesti+Corvinus+Egyetem/@47.4861534,19.0556806,17z/data=!3m1!4b1!4m6!3m5!1s0x4741dc502488be69:0xc5b7e757fb438129!8m2!3d47.4861534!4d19.0582555!16zL20vMDRndl9r?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL),
(4, 'Magyar Testnevelési és Sporttudományi Egyetem', 'https://www.google.com/maps/place/Magyar+Testnevel%C3%A9si+%C3%A9s+Sporttudom%C3%A1nyi+Egyetem/@47.4928905,19.0231691,18.25z/data=!4m10!1m2!2m1!1sMagyar+Testnevel%C3%A9si+%C3%A9s+Sporttudom%C3%A1nyi+Egyetem!3m6!1s0x4741dc2f55636f27:0x4c3d127f8f623b6f!8m2!3d47.4929725!4d19.0254182!15sCjBNYWd5YXIgVGVzdG5ldmVsw6lzaSDDqXMgU3BvcnR0dWRvbcOhbnlpIEVneWV0ZW2SAQp1bml2ZXJzaXR5qgFnCg0vZy8xMWI2NnNsZDh3EAEyHhABIhrfflh5CWHUoGeqF5j2vVv7HLpcd8BPqqy-wTI0EAIiMG1hZ3lhciB0ZXN0bmV2ZWzDqXNpIMOpcyBzcG9ydHR1ZG9tw6FueWkgZWd5ZXRlbeABAA!16s%2Fg%2F11b66sld8w?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 0, NULL),
(5, 'Károli Gáspár Református Egyetem', 'https://www.google.com/maps/place/K%C3%A1roli+G%C3%A1sp%C3%A1r+Reform%C3%A1tus+Egyetem/@47.4889557,19.0511305,1877m/data=!3m1!1e3!4m10!1m2!2m1!1zCUvDoXJvbGkgR8Ohc3DDoXIgUmVmb3Jtw6F0dXMgRWd5ZXRlbQ!3m6!1s0x4741dc5ae616f9f9:0x79cd925b374568bf!8m2!3d47.4889541!4d19.061843!15sCiRLw6Fyb2xpIEfDoXNww6FyIFJlZm9ybcOhdHVzIEVneWV0ZW2SAQp1bml2ZXJzaXR54AEA!16s%2Fg%2F11bc5lm7sl?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 0, NULL),
(6, 'Budapesti Gazdasági Egyetem', 'https://www.google.com/maps/place/Budapesti+Gazdas%C3%A1gi+Egyetem/@47.5088043,18.9683027,15008m/data=!3m1!1e3!4m10!1m2!2m1!1sBudapesti+Gazdas%C3%A1gi+Egyetem!3m6!1s0x4741dc127f42ee99:0xb8631187d54fedd6!8m2!3d47.5088043!4d19.0540419!15sChxCdWRhcGVzdGkgR2F6ZGFzw6FnaSBFZ3lldGVtkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F11g6nkx5g2?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 0, NULL),
(7, 'Budapesti Műszaki és Gazdaságtudományi Egyetem', 'https://www.google.com/maps/search/Budapesti+M%C5%B1szaki+%C3%A9s+Gazdas%C3%A1gtudom%C3%A1nyi+Egyetem/@47.5088043,18.9683027,15008m/data=!3m1!1e3?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 0, NULL),
(8, 'Debreceni Egyetem', 'google.com/maps/place/Debreceni+Egyetem/@47.5512318,21.5961877,7498m/data=!3m1!1e3!4m10!1m2!2m1!1sDebreceni+Egyetem!3m6!1s0x47470df39a92233b:0x158b32cc387080a5!8m2!3d47.5536257!4d21.6215102!15sChFEZWJyZWNlbmkgRWd5ZXRlbSIDiAEBkgEKdW5pdmVyc2l0eeABAA!16zL20vMDhzbWpx?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 0, NULL),
(9, 'Pécsi Tudományegyetem', '', 0, NULL),
(10, 'Budapest Cirkuszművészeti és Kortárstánc Főiskola', 'https://www.google.com/maps/place/Budapest+Cirkuszm%C5%B1v%C3%A9szeti+%C3%A9s+Kort%C3%A1rst%C3%A1nc+F%C5%91iskola+-+Sz%C3%A9khely/@47.5358829,19.0404411,394m/data=!3m1!1e3!4m6!3m5!1s0x4741d9592c921463:0xc50511cf9dd9a8b9!8m2!3d47.5357446!4d19.0426993!16s%2Fg%2F12372h_x?entry=ttu&g_ep=EgoyMDI2MDEyMS4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 0, NULL),
(11, 'Eötvös Loránd Tudományegyetem (Szombathely)', 'https://www.google.com/maps/place/ELTE+Savaria+Egyetemi+K%C3%B6zpont/@47.2300098,16.6089827,561m/data=!3m2!1e3!5s0x476eb9b19fc57dd3:0x33858e2982d877c0!4m15!1m8!3m7!1s0x476eb9b10d89423d:0x5db61ddbc6acbfe4!2sELTE+Savaria+Egyetemi+K%C3%B6zpont!8m2!3d47.2304519!4d16.6117225!10e3!16s%2Fg%2F12qf5mc7t!3m5!1s0x476eb9b10d89423d:0x5db61ddbc6acbfe4!8m2!3d47.2304519!4d16.6117225!16s%2Fg%2F12qf5mc7t?entry=ttu&g_ep=EgoyMDI2MDIwMS4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `universityxfaculty`
--

CREATE TABLE `universityxfaculty` (
  `universityxfaculty_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `universityxfaculty`
--

INSERT INTO `universityxfaculty` (`universityxfaculty_id`, `university_id`, `faculty_id`) VALUES
(1, 5, 14),
(2, 5, 13),
(3, 5, 3),
(4, 5, 28),
(5, 1, 42),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 2, 2),
(10, 2, 49),
(11, 2, 9),
(12, 2, 10),
(13, 2, 11),
(14, 2, 56),
(15, 6, 14),
(16, 6, 15),
(17, 6, 16),
(18, 7, 17),
(19, 7, 18),
(20, 7, 19),
(21, 7, 20),
(22, 7, 21),
(23, 7, 22),
(24, 7, 23),
(25, 7, 24),
(26, 7, 25),
(27, 8, 3),
(28, 1, 26),
(29, 2, 23),
(30, 2, 27),
(31, 4, 5),
(32, 4, 28),
(33, 3, 27),
(34, 3, 10),
(35, 3, 29),
(36, 7, 2),
(37, 7, 29),
(38, 7, 10),
(39, 8, 30),
(40, 8, 2),
(41, 8, 8),
(42, 8, 6),
(43, 8, 29),
(44, 8, 31),
(45, 8, 7),
(46, 8, 10),
(47, 8, 32),
(48, 8, 33),
(49, 8, 34),
(50, 8, 35),
(51, 8, 5),
(52, 8, 27),
(53, 8, 23),
(54, 9, 33),
(55, 9, 2),
(56, 9, 29),
(57, 9, 10),
(58, 9, 3),
(59, 9, 32),
(60, 9, 34),
(61, 9, 35),
(62, 9, 30),
(63, 9, 28),
(64, 9, 5),
(65, 9, 23),
(66, 9, 27),
(67, 9, 8),
(68, 9, 7),
(69, 9, 36),
(70, 9, 37),
(71, 9, 38),
(72, 10, 39),
(73, 10, 40),
(74, 10, 41),
(75, 1, 43),
(76, 1, 44),
(77, 1, 45),
(78, 1, 46),
(79, 1, 47),
(80, 2, 48),
(81, 2, 50),
(82, 11, 50),
(83, 11, 49),
(84, 2, 51),
(85, 11, 51),
(86, 11, 52),
(87, 2, 52),
(88, 11, 53),
(89, 2, 54),
(90, 11, 54),
(91, 2, 55),
(92, 11, 55),
(93, 11, 56),
(94, 2, 57),
(95, 11, 57),
(96, 2, 66),
(97, 2, 58),
(98, 2, 59),
(99, 2, 60),
(100, 2, 61),
(101, 2, 62),
(102, 2, 63),
(103, 2, 64),
(104, 2, 65),
(105, 2, 67),
(106, 2, 68),
(107, 11, 68),
(108, 2, 69),
(109, 11, 69),
(110, 2, 70),
(111, 11, 71),
(112, 2, 72),
(113, 11, 21),
(114, 2, 73),
(115, 11, 73),
(116, 2, 74),
(117, 11, 74),
(118, 2, 75),
(119, 2, 76),
(120, 11, 76),
(121, 2, 77),
(122, 2, 78),
(123, 11, 78),
(124, 2, 79),
(125, 11, 79),
(126, 2, 80),
(127, 11, 80),
(128, 2, 81),
(129, 2, 82);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` longtext NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `user`
--

INSERT INTO `user` (`user_id`, `last_name`, `first_name`, `user_name`, `email`, `password`, `is_deleted`, `deleted_at`) VALUES
(4, 'Kis', 'József', 'Kisjozsef', 'kisjozsef@gmail.com', 'Jelszo', 0, NULL),
(5, 'Kovács', 'Bence', 'bkovacs', 'bence.kovacs@example.com', 'Passw0rd1', 0, NULL),
(6, 'Tóth', 'Anna', 'annat', 'anna.toth@example.com', 'Secure123!', 0, NULL),
(7, 'Szabó', 'Dávid', 'dszabo', 'david.szabo@example.com', 'Qwerty987', 0, NULL),
(8, 'Farkas', 'Eszter', 'efarkas', 'eszter.farkas@example.com', 'MyPass456', 1, '2025-11-25 00:00:00'),
(9, 'Nagy', 'Gábor', 'gnagy', 'gabor.nagy@example.com', 'TestUser!23', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `userxappointment`
--

CREATE TABLE `userxappointment` (
  `userXappointment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `userxappointment`
--

INSERT INTO `userxappointment` (`userXappointment_id`, `user_id`, `appointment_id`) VALUES
(3, 4, 1),
(4, 5, 2),
(9, 9, 4),
(10, 4, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `worker`
--

CREATE TABLE `worker` (
  `worker_id` int(11) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `password` longtext NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `worker`
--

INSERT INTO `worker` (`worker_id`, `last_name`, `first_name`, `user_name`, `password`, `email`, `phone`, `is_deleted`, `deleted_at`) VALUES
(2, 'Dolgozó', 'Pista', 'DolgozóPista', 'Jelszo', 'dolgozopista@gmail.com', '123456789', 0, NULL),
(3, 'Kovács', 'Gábor', 'gkovacs', 'Teszt123!', 'gabor.kovacs@example.com', '+36 30 555 1122', 0, NULL),
(4, 'Szalai', 'Anna', 'annasz', 'AnnaPass456', 'anna.szalai@example.com', '+36 20 987 4433', 0, NULL),
(5, 'Tóth', 'Márton', 'marton.toth', 'Marton789#', 'mtoth@example.com', '+36 70 332 9911', 0, NULL);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `workerxappointment`
--

CREATE TABLE `workerxappointment` (
  `workerXappointment_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `workerxappointment`
--

INSERT INTO `workerxappointment` (`workerXappointment_id`, `appointment_id`, `worker_id`) VALUES
(1, 4, 2),
(2, 3, 2),
(3, 2, 2),
(4, 4, 5);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointment_id`);

--
-- A tábla indexei `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`faculty_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`);

--
-- A tábla indexei `university`
--
ALTER TABLE `university`
  ADD PRIMARY KEY (`university_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `location` (`location`);

--
-- A tábla indexei `universityxfaculty`
--
ALTER TABLE `universityxfaculty`
  ADD PRIMARY KEY (`universityxfaculty_id`),
  ADD KEY `egyetemId` (`university_id`),
  ADD KEY `karId` (`faculty_id`);

--
-- A tábla indexei `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `UserName` (`user_name`);

--
-- A tábla indexei `userxappointment`
--
ALTER TABLE `userxappointment`
  ADD PRIMARY KEY (`userXappointment_id`),
  ADD KEY `AppointmentId` (`appointment_id`),
  ADD KEY `UserId` (`user_id`);

--
-- A tábla indexei `worker`
--
ALTER TABLE `worker`
  ADD PRIMARY KEY (`worker_id`),
  ADD UNIQUE KEY `UserName` (`user_name`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `Phone` (`phone`);

--
-- A tábla indexei `workerxappointment`
--
ALTER TABLE `workerxappointment`
  ADD PRIMARY KEY (`workerXappointment_id`),
  ADD KEY `AppointmentId` (`appointment_id`),
  ADD KEY `WorkerId` (`worker_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `faculty`
--
ALTER TABLE `faculty`
  MODIFY `faculty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT a táblához `university`
--
ALTER TABLE `university`
  MODIFY `university_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT a táblához `universityxfaculty`
--
ALTER TABLE `universityxfaculty`
  MODIFY `universityxfaculty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT a táblához `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `userxappointment`
--
ALTER TABLE `userxappointment`
  MODIFY `userXappointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `worker`
--
ALTER TABLE `worker`
  MODIFY `worker_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `workerxappointment`
--
ALTER TABLE `workerxappointment`
  MODIFY `workerXappointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `universityxfaculty`
--
ALTER TABLE `universityxfaculty`
  ADD CONSTRAINT `universityxfaculty_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`),
  ADD CONSTRAINT `universityxfaculty_ibfk_2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`);

--
-- Megkötések a táblához `userxappointment`
--
ALTER TABLE `userxappointment`
  ADD CONSTRAINT `userxappointment_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  ADD CONSTRAINT `userxappointment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Megkötések a táblához `workerxappointment`
--
ALTER TABLE `workerxappointment`
  ADD CONSTRAINT `workerxappointment_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  ADD CONSTRAINT `workerxappointment_ibfk_2` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`worker_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
