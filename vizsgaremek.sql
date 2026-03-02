-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 02, 2026 at 09:23 AM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteAppointment` (IN `idIN` INT(11))   BEGIN
	UPDATE `appointment` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `appointment`.`appointment_id` = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteFaculty` (IN `idIN` INT(11))   BEGIN
	UPDATE `faculty` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `faculty`.`faculty_id` LIKE idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUniversity` (IN `idIN` INT(11))   BEGIN
	UPDATE `university` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `university`.`university_id` = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteUser` (IN `idIN` INT(11))   BEGIN
	UPDATE `user` SET `is_deleted`=1, `deleted_at`=CURRENT_DATE() WHERE `user`.`user_id` = idIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllAppointment` ()   BEGIN
	SELECT * FROM `appointment` WHERE `appointment`.`is_deleted` = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllFaculties` ()   BEGIN
	SELECT * FROM faculty WHERE faculty.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUniversities` ()   BEGIN
	SELECT * FROM university WHERE university.`is_deleted` = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllUsers` ()   BEGIN
	SELECT * FROM `user` WHERE `user`.`is_deleted` = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllWorker` ()   BEGIN
	SELECT * FROM user 
    WHERE 
    user.role_id = 3
    AND 
    user.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointment` (IN `id` INT(11))   BEGIN
	SELECT * FROM `appointment` WHERE `appointment`.`appointment_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointmentBydate` (IN `dateIN` DATE)   BEGIN 
	SELECT * FROM appointment a
    WHERE 
    a.date = dateIN
    AND 
    a.is_deleted = 0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAppointmentByUserId` (IN `userId` INT(11))   BEGIN
	SELECT * FROM userxappointment WHERE userxappointment.user_id = userId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFaculty` (IN `id` INT(11))   BEGIN
	SELECT * FROM faculty WHERE faculty.faculty_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getFacultyByUniversityId` (IN `universityIdIN` INT(11))   BEGIN
	SELECT * FROM universityxfaculty WHERE universityxfaculty.university_id = universityIdIN;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversity` (IN `idIN` INT(11))   BEGIN
	SELECT * FROM university WHERE university.university_id = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversityByFacultyId` (IN `facultyIdIN` INT(11))   BEGIN
	SELECT * FROM universityxfaculty WHERE universityxfaculty.faculty_id = facultyId;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUniversityByName` (IN `nameIN` VARCHAR(255))   BEGIN 
	SELECT * FROM university
    WHERE
    university.name LIKE CONCAT(nameIN, "%");
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUser` (IN `id` INT(11))   BEGIN
	SELECT * FROM `user` WHERE `user`.`user_id` = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByAppointmentId` (IN `appointmentId` INT(11))   BEGIN
	SELECT * FROM userxappointment WHERE userxappointment.appointment_id = appointmentId;
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
	INSERT INTO `user`(`first_name`, `last_name`, `username`, `email`, `password`, `is_deleted`) VALUES (firstname,lastname,username,email,password, 0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setUserXAppointment` (IN `userId` INT(11), IN `appointmentId` INT(11))   BEGIN
	INSERT INTO `userxappointment` ( `user_id`, `appointment_id`) VALUES (userId, appointmentId);
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
	UPDATE `user` SET `last_name`=lastname, `first_name`=firstname, `username`=username, `email`=email, `password`=password 
    WHERE `user`.`user_id` = id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `capacity` int(2) NOT NULL,
  `Is_full` tinyint(1) NOT NULL DEFAULT '0',
  `is_online` tinyint(1) NOT NULL,
  `worker_id` int(11) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `title`, `date`, `start_time`, `end_time`, `capacity`, `Is_full`, `is_online`, `worker_id`, `is_deleted`, `deleted_at`) VALUES
(1, '', '2025-10-28', '00:00:00', '00:00:00', 20, 0, 0, 4, 1, '2025-11-25 00:00:00'),
(2, '', '2026-01-18', '00:00:00', '00:00:00', 30, 0, 0, 4, 0, NULL),
(3, '', '2026-06-27', '00:00:00', '00:00:00', 34, 0, 0, 4, 0, NULL),
(4, '', '2026-04-22', '00:00:00', '00:00:00', 25, 0, 0, 4, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `faculty_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`faculty_id`, `name`, `description`, `is_deleted`, `deleted_at`) VALUES
(1, 'csere', 'ez csak a cserét jelzi', 0, NULL),
(2, 'agrár- és üzleti digitalizáció', '\r\n', 0, '2025-11-25 00:00:00'),
(3, 'igazságügyi igazgatási', '', 0, NULL),
(4, 'mérnöki', 'nem tudom mit csinál', 0, NULL),
(5, 'Sporttudomány', 'mert kell még több stadion', 0, NULL),
(6, 'digitális fogászati tervezés', 'fogakkal foglalkozó tanfolyam', 0, NULL),
(7, 'Gyógyszerész', 'gyógyszeri alapok elsajátítása, gyógyszerek tanulmányozása, új gyógyszerek fifejlestése', 0, NULL),
(8, 'gazdasági és vidékfejlesztési agrármérnöki', '', 0, NULL),
(9, 'Gyógypedagógiai', 'terápiás tevékenységek elsajátítása, fejlesztésikésségek elsaátításadiagnózisok elemzése', 0, NULL),
(10, 'élelmiszermérnöki', '', 0, NULL),
(11, 'mezőgazdasági vízgazdálkodási és környezettechnológiai mérnöki', '', 0, NULL),
(12, 'Tanító- és Óvóképző', 'tanár és ovónő képző', 0, NULL),
(13, 'Jogász', '', 0, NULL),
(14, 'kertészmérnöki', '', 0, NULL),
(15, 'lótenyésztő, lovassport szervező agrármérnöki', '', 0, NULL),
(16, 'mezőgazdasági mérnöki', '', 0, NULL),
(17, 'Pénzügy és Számvitel', '', 0, NULL),
(18, 'Építészmérnöki', '', 0, NULL),
(19, 'Építőmérnöki', '', 0, NULL),
(20, 'precíziós mezőgazdasági mérnöki', '', 0, NULL),
(21, 'Gépészmérnöki', '', 0, NULL),
(22, 'természetvédelmi mérnöki', '', 0, NULL),
(23, 'vadgazda mérnöki', '', 0, NULL),
(24, 'anyagmérnöki', '', 0, NULL),
(25, 'biotechnológia', '', 0, NULL),
(26, 'Egészségügyi Közszolgálati', '', 0, NULL),
(27, 'Társadalomtudományi', '', 0, NULL),
(28, 'Pedagógusképző', '', 0, NULL),
(29, 'Gazdaságtudományi', '', 0, NULL),
(30, 'Általános Orvostudományi', '', 0, NULL),
(31, 'romológia', '', 0, NULL),
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
(71, 'szociális munka', '', 0, NULL),
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
(82, 'nemzetközi tanulmányok', '', 0, NULL),
(83, 'szociológia', '', 0, NULL),
(84, 'turizmus-vendéglátás', '', 0, NULL),
(85, 'biológia', '', 0, NULL),
(86, 'fizika', '', 0, NULL),
(87, 'földrajz', '', 0, NULL),
(88, 'földtudományi', '', 0, NULL),
(89, 'kémia', '', 0, NULL),
(90, 'környezettan', '', 0, NULL),
(91, 'matematika', '', 0, NULL),
(92, 'buddhista tanító', '', 0, NULL),
(93, 'teológia', '', 0, NULL),
(94, 'állatorvosi', '', 0, NULL),
(95, 'kutató zoológus', '', 0, NULL),
(96, 'szociálpedagógia', '', 0, NULL),
(97, 'kántor', '', 0, NULL),
(98, 'vaisnava jógamester', '', 0, NULL),
(99, 'vaisnava teológia', '', 0, NULL),
(100, 'osztatlan tanári', '', 0, NULL),
(101, 'filozófia, politika, gazdaság', '', 0, NULL),
(102, 'gazdaságinformatikus', '', 0, NULL),
(103, 'üzleti adattudomány', '', 0, NULL),
(104, 'szakoktató', '', 0, NULL),
(105, 'animáció', '', 0, NULL),
(106, 'designkultúra', '', 0, NULL),
(107, 'építőművészet', '', 0, NULL),
(108, 'formatervezés', '', 0, NULL),
(109, 'kézműves tárgykultúra', '', 0, NULL),
(110, 'környezetkultúra', '', 0, NULL),
(111, 'média design', '', 0, NULL),
(112, 'mozgóképkultúra és médiaismeret', '', 0, NULL),
(113, 'televíziós műsorkészítő', '', 0, NULL),
(114, 'tervezőgrafika', '', 0, NULL),
(115, 'textiltervezés', '', 0, NULL),
(116, 'energetikai mérnöki', '', 0, NULL),
(117, 'ipari termék- és formatervező mérnöki', '', 0, NULL),
(118, 'mechatronikai mérnöki', '', 0, NULL),
(119, 'járműmérnöki', '', 0, NULL),
(120, 'közlekedésmérnöki', '', 0, NULL),
(121, 'logisztikai mérnöki', '', 0, NULL),
(122, 'repülőmérnöki', '', 0, NULL),
(123, 'fizikus-mérnöki', '', 0, NULL),
(124, 'biomérnöki', '', 0, NULL),
(125, 'környezetmérnöki', '', 0, NULL),
(126, 'vegyészmérnöki', '', 0, NULL),
(127, 'mérnökinformatikus', '', 0, NULL),
(128, 'üzemmérnök-informatikus', '', 0, NULL),
(129, 'villamosmérnöki', '', 0, NULL),
(130, 'alkotóművészet és muzikológia', '', 0, NULL),
(131, 'előadó-művészet', '', 0, NULL),
(132, 'kortárs könnyűzene', '', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'ROLE_user'),
(2, 'ROLE_admin'),
(3, 'ROLE_worker');

-- --------------------------------------------------------

--
-- Table structure for table `university`
--

CREATE TABLE `university` (
  `university_id` int(11) NOT NULL,
  `name` varchar(400) NOT NULL,
  `description` longtext NOT NULL,
  `address` longtext NOT NULL,
  `google_maps_link` varchar(1000) NOT NULL,
  `page_link` varchar(1000) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `university`
--

INSERT INTO `university` (`university_id`, `name`, `description`, `address`, `google_maps_link`, `page_link`, `is_deleted`, `deleted_at`) VALUES
(1, 'Semmelweis Egyetem', 'A Semmelweis Egyetem Magyarország és a közép-európai régió vezető orvos-egészségügyi felsőoktatási intézménye, mely szakegyetemként egyedülálló az országban. Három fő tevékenysége az oktatás, kutatás-innováció és gyógyítás; e hármas egység teszi nemzetközileg is elismert tudásközponttá a több mint 250 éves egyetemet.\r\n\r\n', 'Budapest, Üllői út 26, 1085', 'https://www.google.com/maps/place/Semmelweis+Egyetem+%C3%81ltal%C3%A1nos+Orvostudom%C3%A1nyi+Kar/@47.4873751,19.0659224,18z/data=!4m10!1m2!2m1!1sSemmelweis+Egyetem!3m6!1s0x4741dc59ea3ba3cd:0xa255183ce04f11de!8m2!3d47.4873751!4d19.067379!15sChJTZW1tZWx3ZWlzIEVneWV0ZW0iA4gBAZIBCnVuaXZlcnNpdHmqAVQKDS9nLzExYmJybHNsMzkKCS9tLzA0dDduNBABMh4QASIa8dqFcZ0PBIXO2kLLHqByrKpDsJ_HbnD8mOkyFhACIhJzZW1tZWx3ZWlzIGVneWV0ZW3gAQA!16s%2Fg%2F12qfsrgp9?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 'http://www.semmelweis.hu', 0, NULL),
(2, 'Eötvös Loránd Tudományegyetem (Budapest)', 'Az Egyetemen oktatási és kutatási feladatot ellátó, szolgáltató, működést támogató szervezeti egységek és köznevelési intézmények is működnek. Az Egyetemen az oktatási és a szakképzési tevékenység, a tudományos munka elsősorban a karokon folyik, valamint működnek kari szervezeten kívüli sajátos oktatási-kutatási tevékenységet ellátó egységek is.', 'Budapest, Egyetem tér 1-3, 1053', 'https://www.google.com/maps/place/E%C3%B6tv%C3%B6s+Lor%C3%A1nd+Tudom%C3%A1nyegyetem/@47.4905698,19.0559696,17z/data=!3m1!4b1!4m6!3m5!1s0x4741dc44dc7c9251:0x2259d03e6d01806d!8m2!3d47.4905698!4d19.0585445!16zL20vMDMyZ240?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 'http://www.elte.hu', 0, NULL),
(3, 'Budapesti Corvinus Egyetem', 'A Budapesti Corvinus Egyetem (röviden: CORVINUS/Corvinus vagy Corvinus Egyetem) egy európai léptékben közepes méretű, üzleti, gazdaság- és társadalomtudományi fókuszú intézmény. Az Egyetem Magyarország egyik vezető oktatási intézménye a gazdaság- és társadalomtudományok területén. Sőt több annál: olyan közösség, amelyhez jó és érdemes tartozni.', 'Budapest, Fővám tér 8, 1093', 'https://www.google.com/maps/place/Budapesti+Corvinus+Egyetem/@47.4861534,19.0556806,17z/data=!3m1!4b1!4m6!3m5!1s0x4741dc502488be69:0xc5b7e757fb438129!8m2!3d47.4861534!4d19.0582555!16zL20vMDRndl9r?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 'http://www.uni-corvinus.hu', 0, NULL),
(4, 'Magyar Testnevelési és Sporttudományi Egyetem', 'A Magyar Testnevelési Egyetem életre hívásának gondolata már a századfordulón felmerült, de a konkrét előkészületek csak az 1920-as évek elején kezdődtek, majd alapítónk, Klebelsberg Kuno kultuszminiszter fáradozása nyomán az első tanév ünnepélyes megnyitására 1925 novemberében került sor.', 'Budapest, Alkotás u. 42-48, 1123', 'https://www.google.com/maps/place/Magyar+Testnevel%C3%A9si+%C3%A9s+Sporttudom%C3%A1nyi+Egyetem/@47.4928905,19.0231691,18.25z/data=!4m10!1m2!2m1!1sMagyar+Testnevel%C3%A9si+%C3%A9s+Sporttudom%C3%A1nyi+Egyetem!3m6!1s0x4741dc2f55636f27:0x4c3d127f8f623b6f!8m2!3d47.4929725!4d19.0254182!15sCjBNYWd5YXIgVGVzdG5ldmVsw6lzaSDDqXMgU3BvcnR0dWRvbcOhbnlpIEVneWV0ZW2SAQp1bml2ZXJzaXR5qgFnCg0vZy8xMWI2NnNsZDh3EAEyHhABIhrfflh5CWHUoGeqF5j2vVv7HLpcd8BPqqy-wTI0EAIiMG1hZ3lhciB0ZXN0bmV2ZWzDqXNpIMOpcyBzcG9ydHR1ZG9tw6FueWkgZWd5ZXRlbeABAA!16s%2Fg%2F11b66sld8w?entry=ttu&g_ep=EgoyMDI1MTExNy4wIKXMDSoASAFQAw%3D%3D', 'http://www.tf.hu', 0, NULL),
(5, 'Károli Gáspár Református Egyetem', 'Megjelent a HVG Diploma 2026 felsőoktatási rangsor, mely alapján a Károli Gáspár Református Egyetem – tavalyi helyezésén javítva  – a 6. legjobb* a 27 rangsorolt magyarországi felsőoktatási intézmény közül.\r\n\r\nA frissen megjelent kiadványban többek között olyan szempontok alapján rangsorolták a magyar felsőoktatási intézményeket, mint az elsőhelyes jelentkezők száma, a felvett hallgatók pontátlaga, a nyelvvizsgával felvettek aránya, a középiskolai versenyeken szerzett helyezések száma, valamint az oktatói kiválóság, publikációk aránya. ', 'Budapest, Kálvin tér 9, 1092', 'https://www.google.com/maps/place/K%C3%A1roli+G%C3%A1sp%C3%A1r+Reform%C3%A1tus+Egyetem/@47.4889557,19.0511305,1877m/data=!3m1!1e3!4m10!1m2!2m1!1zCUvDoXJvbGkgR8Ohc3DDoXIgUmVmb3Jtw6F0dXMgRWd5ZXRlbQ!3m6!1s0x4741dc5ae616f9f9:0x79cd925b374568bf!8m2!3d47.4889541!4d19.061843!15sCiRLw6Fyb2xpIEfDoXNww6FyIFJlZm9ybcOhdHVzIEVneWV0ZW2SAQp1bml2ZXJzaXR54AEA!16s%2Fg%2F11bc5lm7sl?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 'http://www.kre.hu', 0, NULL),
(6, 'Budapesti Gazdasági Egyetem', 'A Budapesti Gazdaságtudományi Egyetem (BGE) Magyarország legnagyobb gazdaságtudományi egyeteme és Magyarország 4. legnagyobb egyeteme, ahol közel 20.000 diák tanul jelenleg.  \r\n\r\n A BGE az összes gazdasági alapszakján piacvezető, itt végzett a hazai közgazdászok legnagyobb része, emellett ide nyernek a legtöbben felvételt gazdaságinformatikus, valamint kommunikáció és médiatudomány alapszakokra is, és a nemzetközi tanulmányok szak létszámában is a második legnagyobb képzés a BGE-é. ', 'Budapest, Markó u. 29-31, 1055', 'https://www.google.com/maps/place/Budapesti+Gazdas%C3%A1gi+Egyetem/@47.5088043,18.9683027,15008m/data=!3m1!1e3!4m10!1m2!2m1!1sBudapesti+Gazdas%C3%A1gi+Egyetem!3m6!1s0x4741dc127f42ee99:0xb8631187d54fedd6!8m2!3d47.5088043!4d19.0540419!15sChxCdWRhcGVzdGkgR2F6ZGFzw6FnaSBFZ3lldGVtkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F11g6nkx5g2?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 'http://www.uni-bge.hu', 0, NULL),
(7, 'Budapesti Műszaki és Gazdaságtudományi Egyetem', 'A Műegyetem elsődleges feladata műszaki, informatikai, természettudományi, valamint gazdasági, üzleti és menedzsment szakemberek képzése. A BME oktatástól elválaszthatatlan küldetése a tudományos kutatás, amely átfogja az innovációs láncot alkotó alap- és alkalmazott kutatást, a műszaki termék- és szolgáltatásfejlesztést, valamint az eredmények hasznosítását. ', 'Budapest, Műegyetem rkp. 3, 1111', 'https://www.google.com/maps/search/Budapesti+M%C5%B1szaki+%C3%A9s+Gazdas%C3%A1gtudom%C3%A1nyi+Egyetem/@47.5088043,18.9683027,15008m/data=!3m1!1e3?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 'https://www.bme.hu', 0, NULL),
(8, 'Debreceni Egyetem (Debrecen)', 'A Debreceni Egyetem a hazai felsőoktatás egyik kiemelkedő intézményeként - az európai egyetemek Magna Charta-jának szellemében - a legmagasabb szintű, sokoldalú, multidiszciplináris képzéssel, kutatással és fejlesztéssel járul hozzá az egyetemes tudomány és a magyar társadalom fejlődéséhez. Ezt a küldetést az egyetem oktatói, dolgozói és hallgatói közösen, a minőségügy elkötelezettjeként, hazai és nemzetközi partnerekkel együttműködve teljesítik.', 'Debrecen, Egyetem tér 1, 4032', 'google.com/maps/place/Debreceni+Egyetem/@47.5512318,21.5961877,7498m/data=!3m1!1e3!4m10!1m2!2m1!1sDebreceni+Egyetem!3m6!1s0x47470df39a92233b:0x158b32cc387080a5!8m2!3d47.5536257!4d21.6215102!15sChFEZWJyZWNlbmkgRWd5ZXRlbSIDiAEBkgEKdW5pdmVyc2l0eeABAA!16zL20vMDhzbWpx?entry=ttu&g_ep=EgoyMDI2MDEwNy4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 'https://www.unideb.hu', 0, NULL),
(9, 'Pécsi Tudományegyetem', 'A pécsi felsőoktatás története 1367-ig nyúlik vissza, amikor Nagy Lajos királyunk a püspöki székvárosban, Pécsett egyetem létrehozását kezdeményezte. Egy többlépcsős integrációs folyamat eredményeképpen létrejött a Pécsi Tudományegyetem, amely mára az ország egyik legnevesebb, regionális vezető szereppel bíró egyetemévé vált, ahol tíz karon a felsőoktatás teljes spektrumán magas színvonalú képzés folyik.', 'Pécs, Boszorkány út 2, 7624 ', 'https://www.google.com/maps/place/P%C3%A9csi+Tudom%C3%A1nyegyetem+M%C5%B1szaki+%C3%A9s+Informatikai+Kar/@46.0805525,17.6350114,61647m/data=!3m1!1e3!4m10!1m2!2m1!1zcHRlIHDDqWNz!3m6!1s0x4742b1bef45122bb:0xb5277a173d87a05b!8m2!3d46.0805525!4d18.2117936!15sCglwdGUgcMOpY3NaCyIJcHRlIHDDqWNzkgEKdW5pdmVyc2l0eZoBJENoZERTVWhOTUc5blMwVkpRMEZuU1VSbWRIRkhPRGxSUlJBQuABAPoBBAgAEB4!16s%2Fg%2F11xy39_h7?entry=ttu&g_ep=EgoyMDI2MDIwMS4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 'http://www.pte.hu', 0, NULL),
(10, 'Budapest Cirkuszművészeti és Kortárstánc Főiskola', 'A Budapest Cirkuszművészeti és Kortárstánc Főiskola az időben zajló, mozdulatalapú előadóművészetek tanulására, tanítására, kutatására és fejlesztésére szervezett tér és közösség. A Főiskola célja a tehetségek felkutatása, támogatása és olyan előadóművészek és pedagógusok képzése, akiknek a diplomája a világ bármely pontján egyet jelent a korszerű gyakorlati- és elméleti tudással és kreativitással. Küldetésünknek tekintjük, hogy a Főiskola művészetpedagógiai tevékenysége, valamint az itt végzett diákok a művészet eszköztárával alapértékeket jelenítsenek meg az élet kulturális és társadalmi színtereiben hazai és nemzetközi szinten egyaránt.', 'Budapest, Perc u. 2, 1036', 'https://www.google.com/maps/place/Budapest+Cirkuszm%C5%B1v%C3%A9szeti+%C3%A9s+Kort%C3%A1rst%C3%A1nc+F%C5%91iskola+-+Sz%C3%A9khely/@47.5358829,19.0404411,394m/data=!3m1!1e3!4m6!3m5!1s0x4741d9592c921463:0xc50511cf9dd9a8b9!8m2!3d47.5357446!4d19.0426993!16s%2Fg%2F12372h_x?entry=ttu&g_ep=EgoyMDI2MDEyMS4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 'https://bcdc.hu/', 0, NULL),
(11, 'Eötvös Loránd Tudományegyetem (Szombathely)', 'Elte csak Szombathelyen', 'Szombathely, Károlyi Gáspár tér 4, 9700', 'https://www.google.com/maps/place/ELTE+Savaria+Egyetemi+K%C3%B6zpont/@47.2300098,16.6089827,561m/data=!3m2!1e3!5s0x476eb9b19fc57dd3:0x33858e2982d877c0!4m15!1m8!3m7!1s0x476eb9b10d89423d:0x5db61ddbc6acbfe4!2sELTE+Savaria+Egyetemi+K%C3%B6zpont!8m2!3d47.2304519!4d16.6117225!10e3!16s%2Fg%2F12qf5mc7t!3m5!1s0x476eb9b10d89423d:0x5db61ddbc6acbfe4!8m2!3d47.2304519!4d16.6117225!16s%2Fg%2F12qf5mc7t?entry=ttu&g_ep=EgoyMDI2MDIwMS4wIKXMDSoKLDEwMDc5MjA3M0gBUAM%3D', 'http://www.elte.hu', 0, NULL),
(12, 'A Tan Kapuja Buddhista Főiskola', 'A Főiskola magáénak vallja a nagy magyar keletkutatók szellemi örökségét. Legfőbb szellemi előfutárunknak és példaképünknek Kőrösi Csoma Sándort tekintjük, akit a buddhizmus hívei világszerte bódhiszattvaként – szent törekvőként – tisztelnek, s úgy emlegetnek, mint „nyugati tanítvány”-t.', 'Budapest, Börzsöny u. 11, 1098', 'https://www.google.com/maps/place/A+Tan+Kapuja+Buddhista+F%C5%91iskola/@47.4631837,19.1099096,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dd2b7d99ca3f:0x47f4d1baa5ce0f46!8m2!3d47.4631837!4d19.1124845!16s%2Fg%2F11b7fvfmym?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'https://www.tkbf.hu', 0, NULL),
(13, 'Adventista Teológiai Főiskola', 'Az Adventista Teológiai Főiskola vallja, hogy az Atya, Fiú, Szentlélek Isten a világ teremtője és fenntartója, és Ő minden igaz ismeret forrása. Az ember a bűn következtében elidegenedett Istentől, Isten Fia azonban testetöltött, és helyreállítja a Teremtő és az ember harmonikus közösségét. Ezt a szolgálatot megváltásnak nevezzük, a keresztény nevelésre pedig úgy tekintünk, mint a megváltás egyik eszközére. A Főiskolán oktatott hitéleti tárgyakat a Hetednapi Adventista Egyház hitelveinek szellemében tanítjuk, a világi tudományok művelésekor tiszteletben tartjuk az adventista bibliaiértelmezés és teológiai látás iránymutatásait. Egészséges, kölcsönös tiszteleten alapuló párbeszédre törekszünk minden szellemi irányzattal, ezért követjük Pál apostol tanítását: „mindent vizsgáljatok meg, a jót tartsátok meg, a gonosz minden fajtájától tartózkodjatok” (1Thessz 5:21-22).', 'Pécel, Ráday u. 12, 2119', 'https://www.google.com/maps/place/Adventista+Teol%C3%B3giai+F%C5%91iskola+P%C3%A9cel/@47.489116,19.3451135,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741c76a5b15613b:0x3ff05085028e6c0b!8m2!3d47.489116!4d19.3476884!16s%2Fg%2F11xfjytkm?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'http://atf.adventista.hu/', 0, NULL),
(14, 'Állatorvostudományi Egyetem', 'A budapesti Állatorvostudományi Egyetem a gazdag örökség és a folyamatos jobbító célú erőfeszítések révén háromnyelvű, nemzetközileg elismert intézménnyé vált.\r\nÚj célkitűzésünk válaszol a növekvő társadalmi igényre, amely szerint az állatorvosnak nemcsak a gyógyításban és az egészség megőrzésében, hanem élő természeti környezetünk megőrzésében is hozzáértően és tevékenyen részt kell venniük.', 'Budapest, István u. 2, 1078', 'https://www.google.com/maps/place/%C3%81llatorvostudom%C3%A1nyi+Egyetem/@47.5032266,19.0747528,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc6369890843:0xdebb765b9240649!8m2!3d47.5032266!4d19.0773277!16s%2Fg%2F12391_cm?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'http://www.univet.hu', 0, NULL),
(15, 'Andrássy Gyula Budapesti Német Nyelvű Egyetem', 'Az Andrássy Gyula Német Nyelvű Egyetem nevű budapesti székhelyű felsőoktatási intézmény 2002 óta német nyelven kínál mester- és szakirányú továbbképzéseket. Ez az első teljesen német nyelvű felsőoktatási intézmény, melyet német nyelvterületen kívül alapítottak. Időközben a részben német nyelvű intézmények száma gyarapodott.', 'Budapest, Pollack Mihály tér 3, 1088', 'https://www.google.com/maps/place/Andr%C3%A1ssy+Gyula+Budapesti+N%C3%A9met+Nyelv%C5%B1+Egyetem/@47.4920573,19.0613617,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc5c9c7e57d9:0xe90139065d0ad585!8m2!3d47.4920573!4d19.0639366!16s%2Fm%2F03h4ygf?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'https://aub.eu/', 0, NULL),
(16, 'Apor Vilmos Katolikus Főiskola (Vác)', 'A svájci Ingenbohlban alapított Szent Keresztről Nevezett Irgalmas Nővérek 1865-ben telepedtek meg Magyarországon. 1901-ben a Budapesttől mintegy 30 kilométerre levő Zsámbék községben létrehozták első magyar noviciátusukat.', 'Vác Budapesti főút, 5, Schuszter Konstantin tér 1, 2600', 'https://www.google.com/maps/place/Apor+Vilmos+Katolikus+F%C5%91iskola/@47.7739868,18.5563717,59728m/data=!3m1!1e3!4m10!1m2!2m1!1sApor+Vilmos+Katolikus+F%C5%91iskola!3m6!1s0x47402aebe77ecfbf:0xed261dd6f20b30f5!8m2!3d47.7752878!4d19.1316244!15sCh9BcG9yIFZpbG1vcyBLYXRvbGlrdXMgRsWRaXNrb2xhkgEHbGlicmFyeeABAA!16s%2Fg%2F11xmsvxp3?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'https://www.avkf.hu/', 0, NULL),
(17, 'Baptista Teológiai Akadémia', 'A BTA autonóm tudományművelő, értékközvetítő és személyiségfejlesztő intézmény, amely a rá vonatkozó fenntartói útmutatások keretein belül a hatályos jogszabályok szerint, minőségügyi alapelveire épülő minőségpolitikájával összhangban, a főiskola hagyományait követve és folyamatos megújulásra nyitottan működik. \r\n\r\nA főiskola teológiai tanítás tekintetében a konzervatív irány elkötelezettje, vallja a teljes Szentírás ihletettségét és üzenetének mindenkori és egyetemes érvényét. Az oktatás módszertanában kutatja, biblikusan reflektálja és lehetőség szerint innovatív módon alkalmazza a korszerű formákat. ', 'Budapest, Benczúr u. 31, 1068', 'https://www.google.com/maps/place/Baptista+Teol%C3%B3giai+Akad%C3%A9mia/@47.5110969,19.0731201,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc79ef5cf7af:0x12da6d032b5eba30!8m2!3d47.5110969!4d19.075695!16s%2Fg%2F120wl3rw?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'https://www.bta.hu/', 0, NULL),
(18, 'Bhaktivedanta Hittudományi Főiskola', 'Az Alapítvány a hindu vaisnava filozófia oktatási intézményeként az emberiség egyik legősibb filozófiájának és kultúrájának széleskörű megismertetését, illetve a vaisnava filozófia szakembereinek képzését és továbbképzését jelölte meg céljául.\r\n\r\nAz MKTHK 2001-ben hozta létre a Bhaktivedanta Hittudományi Főiskolát, amelynek vaisnava teológus szakja 2003-ban nyert akkreditációt. A Főiskola 2004 szeptemberétől államilag elismert felsőfokú oktatási intézményként oktatja a hinduizmus vaisnava ágának filozófiáját, kultúráját. A Bhaktivedanta Hittudományi Főiskola elsőként a hinduizmus világvallását önállóan képviselő felsőfokú teológiai intézmény Magyarországon, illetve Európában, amely 2005 júniusában adta ki az első, államilag elismert diplomákat.', 'Budapest, Attila u. 8, 1039', 'https://www.google.com/maps/place/Bhaktivedanta+Hittudom%C3%A1nyi+F%C5%91iskola/@47.5850148,19.0450775,468m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc6e6da5d053:0x313805cc69c55729!8m2!3d47.5850148!4d19.0476524!16s%2Fg%2F11x9mcwb5?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(19, 'Brenner János Hittudományi Főiskola', 'A Brenner János Hittudományi Főiskola a Nyugat-Dunántúl egyik legrégebbi egyházi felsőoktatási intézménye, fenntartója a Győri Egyházmegye. A régióban a hitéleti, hittudományi, egyházzenei képzések és továbbképzések szellemi központja.\r\n\r\nFőiskolánk legfontosabb küldetésének tartja a papnövendékek és a hitoktatók képzését. Célunk nemzedékről nemzedékre átörökíteni, hogy az Isten titka felé nyitott emberi gondolkodás logikus, szép, értelmes és igaz.', 'Győr, Káptalandomb 7, 9021', 'https://www.google.com/maps/place/Brenner+J%C3%A1nos+Hittudom%C3%A1nyi+F%C5%91iskola/@47.6894757,17.6288115,467m/data=!3m2!1e3!4b1!4m6!3m5!1s0x476bbfe6ef3972a5:0x47714131f4f62ba2!8m2!3d47.6894757!4d17.6313864!16s%2Fm%2F0cpnh5j?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(20, 'Budapesti Metropolitan Egyetem', 'A Budapesti Metropolitan Egyetem számára kiemelten fontos, hogy minden hallgató és munkatárs biztonságban, elfogadó és támogató közegben érezze magát. Új érzékenyítő filmünk bemutatja, hogyan építjük közösségünket a sokszínűség, a nyitottság és az egymás iránti tisztelet értékein alapulva.', 'Budapest, Nagy Lajos király útja 1-9, 1148', 'https://www.google.com/maps/place/Budapesti+Metropolitan+Egyetem+-+Nagy+Lajos+kir%C3%A1ly+%C3%BAti+campus/@47.5063729,19.1325475,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741db56482532c1:0xc0da42e56c8938b9!8m2!3d47.5063729!4d19.1351224!16s%2Fm%2F02pshhf?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(21, 'Debreceni Református Hittudományi Egyetem', 'Egyetemünk tanbeli kérdésekben a Szentírás alapján áll, önmagára nézve kötelezőnek ismeri el a Magyarországi Református Egyház hitvallásait, alkotmányát, törvényeit és zsinati határozatait. Valamennyi oktatójától, dolgozójától és hallgatójától elvárja a református egyház hitelveinek és érdekeinek tiszteletben tartását, valamint a keresztyén értékrenddel össze-egyeztethető életfolytatást.\r\n\r\nEgyetemünk célja református lelkészek, teológusok és egyházi munkatársak képzése elsődlegesen a Magyarországi Református Egyház számára, továbbá olyan pedagógusok és egyéb világi szakemberek felkészítése a magyar köznevelés és kulturális intézményrendszer számára, akik a Magyarországi Református Egyház hitelveit és hagyományait ismerik, azokat képesek hitelesen megjeleníteni, református egyháztagságuk esetében pedig készek és hajlandók szakismeretükkel az egyház Urát szolgálni.', 'Debrecen, Kálvin tér 16, 4026', 'https://www.google.com/maps/place/Debreceni+Reform%C3%A1tus+Hittudom%C3%A1nyi+Egyetem/@47.5334538,21.6215356,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47470e0a56bde25d:0xbeb917d2f8d3d364!8m2!3d47.5334538!4d21.6241105!16s%2Fm%2F0gg6041?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(22, 'Dunaújvárosi Egyetem', '2000-ben, amikor önálló felsőoktatási intézménnyé válhattunk, határozott elképzelésünk volt arról, hogy miként váljunk Dunaújváros és a régió szellemi innovációs központjává. Képzési és kutatási területeink bővítését e cél szolgálatába állítottuk, hogy létrehozzunk egy korszerű intézményt, a Közép-európai Innovációs és Technológiai Campust.\r\nA Dunaújvárosi Egyetem egyik fő küldetése, hogy a műszaki, informatika tudományág, a hozzájuk kapcsolódó kutatások területén az országban és nemzetközileg is egyaránt vonzó, biztos szakmai tudást adó egyetem legyen. Legalább ennyire fontos pozícióink megőrzése a gazdaságtudományok, a társadalomtudomány és a pedagógusképzés képzési területeken is. Jelenleg 8 Bsc/BA alapszak és 5 felsőoktatási szakképzési szak, 2 mesterképzési szak, továbbá 17 szakirányú továbbképzés választható.', 'Dunaújváros, Táncsics Mihály u. 1/a, 2400', 'https://www.google.com/maps/place/Duna%C3%BAjv%C3%A1rosi+Egyetem/@46.960507,18.9311381,474m/data=!3m3!1e3!4b1!5s0x47421771c78629ab:0x2ca96a40b03bb779!4m6!3m5!1s0x47421770fc20ee09:0x47283785e7c94a6f!8m2!3d46.960507!4d18.933713!16s%2Fm%2F0cpbh0c?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(23, 'Edutus Egyetem (Tatabánya)', 'Hallgatók mondták:\r\n\r\n„Modern gondolkodású, emberséges iskola.”\r\n\r\n„Az Edutus Egyetem szigorú szabályzata mellet kompromisszum kész, igazi család barát. Jelenleg a kis létszám miatt többet tudnak foglalkozni az oktatok a diákokkal, más egyetemeken az óriási létszám miatt nehezebb a tanulás.”\r\n\r\n„Tanárok nem konzervatívak. A vezetőség fiatalos felfogású. Ott segítenek, ahol tényleg szükséges.”\r\n\r\n„A legjobb iskola mind közül ahová eddig jártam.”\r\n\r\n„Rendkívül tetszik a hibrid oktatási módszer, hogy amennyiben hallgató nem tudja megoldani 7é webináriumon is csatlakozhat az órákra. Az oktatók korrektek, felkészültek és hozzáértők. Nagyon érdekesnek találom az egyetemi projekteket, mint a Napcsiga és az Okosház.”', 'Tatabánya, Stúdium tér 1, 2800', 'https://www.google.com/maps/place/Edutus+Egyetem/@47.5869136,17.8229867,59942m/data=!3m1!1e3!4m10!1m2!2m1!1sEdutus+Egyetem!3m6!1s0x476a40df09814983:0x24f2f448fd5aa17e!8m2!3d47.5869136!4d18.3997689!15sCg5FZHV0dXMgRWd5ZXRlbZIBD2J1c2luZXNzX3NjaG9vbOABAA!16s%2Fg%2F121n9rw5?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(24, 'Edutus Egyetem (Budapest)', 'Hallgatói vélemények:\r\n\r\n„Modern gondolkodású, emberséges iskola.”\r\n\r\n„Az Edutus Egyetem szigorú szabályzata mellet kompromisszum kész, igazi család barát. Jelenleg a kis létszám miatt többet tudnak foglalkozni az oktatok a diákokkal, más egyetemeken az óriási létszám miatt nehezebb a tanulás.”\r\n\r\n„Tanárok nem konzervatívak. A vezetőség fiatalos felfogású. Ott segítenek, ahol tényleg szükséges.”\r\n\r\n„A legjobb iskola mind közül ahová eddig jártam.”\r\n\r\n„Rendkívül tetszik a hibrid oktatási módszer, hogy amennyiben hallgató nem tudja megoldani 7é webináriumon is csatlakozhat az órákra. Az oktatók korrektek, felkészültek és hozzáértők. Nagyon érdekesnek találom az egyetemi projekteket, mint a Napcsiga és az Okosház.”', 'Budapest, Fehérvári út 84/A, 1119', 'https://www.google.com/maps/place/Edutus+Egyetem/@47.5005089,18.8662932,17850m/data=!3m1!1e3!4m10!1m2!2m1!1sEdutus+Egyetem!3m6!1s0x4741d9ac74507399:0x5f491288e2432fb5!8m2!3d47.4641801!4d19.0434503!15sCg5FZHV0dXMgRWd5ZXRlbZIBCnVuaXZlcnNpdHngAQA!16s%2Fg%2F1pp2w_ypm?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(25, 'Egri Hittudományi Főiskola', 'Telekesy István püspök kezdeményezésére 1705-ben kezdődött meg a teológiai oktatás, azonban az intézet működésének hivatalos jóváhagyása a Rákóczi-szabadságharc Egerbe is átcsapó hullámai miatt 1709-ben történt meg. Az iskoláztatás fejlesztésében további lépés volt 1740-ben Foglár György kanonok jogi iskolájának alapítása, amelyet az országgyűlés törvénycikkben is rögzített, majd hamarosan Barkóczy Ferenc püspök filozófiai iskolát indított. Ezzel már kialakultak a leendő egri egyetem három fakultásának előzményei. Barkóczy terveit 1762-ben Eszterházy Károly püspök gondolta tovább. Elkezdődött az építkezés, a tervezett egyetem csillagvizsgálóval, könyvtárral, nagy előadótermekkel és nyomdával bővült. Mikor Eszterházy elfoglalta Egerben püspöki székét, magával hozta egy felsőfokú iskola építésének gondolatát. Ezt egyetemnek szánta s írásaiban mindig úgy említi az épületet, mint domus universitatist (egyetem háza).', 'Eger, Foglár György u. 6, 3300', 'https://www.google.com/maps/place/Egri+Hittudom%C3%A1nyi+F%C5%91iskola/@47.9013468,20.3702336,465m/data=!3m1!1e3!4m10!1m2!2m1!1sEgri+Hittudom%C3%A1nyi+F%C5%91iskola!3m6!1s0x47408d9e91663eb1:0x3a572b33e6d5b0e2!8m2!3d47.901379!4d20.3729869!15sChxFZ3JpIEhpdHR1ZG9tw6FueWkgRsWRaXNrb2xhkgEIc2VtaW5hcnngAQA!16s%2Fm%2F0cp4n42?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(26, 'Eötvös József Főiskola', 'Az Eötvös József Főiskola a város egyik legrégebbi, egyben legpatinásabb intézménye, amely 150 éves múltra tekint vissza. A város felsőoktatási intézményeként kiemelt szerepet vállal a város kulturális, oktatási és tudományos életében egyaránt. Az intézmény küldetéseként fogalmazta meg, hogy pedagógusok és közgazdászok képzésével járul hozzá a régió, illetve az ország társadalmi felemelkedéséhez. A továbbképzések, szakirányú képzések lehetőséget kínálnak a felnőtt lakosság számára az élethosszig tartó tanulásra.', 'Baja, Szegedi út 2, 6500', 'https://www.google.com/maps/place/E%C3%B6tv%C3%B6s+J%C3%B3zsef+F%C5%91iskola/@46.1839749,18.9522069,481m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47431fec5e7a754f:0xef689196c2d3ec2a!8m2!3d46.1839749!4d18.9547818!16s%2Fg%2F122dlf78?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(27, 'Esztergomi Hittudományi Főiskola', 'még egy hittudományi intézmény.... innem mnégis hova mennek az emberek, minek jó nekd, hogy ott végeztél???', 'Esztergom, Szent István tér 10, 2500', 'https://www.google.com/maps/place/Esztergomi+Hittudom%C3%A1nyi+F%C5%91iskola/@47.8006537,18.7346393,466m/data=!3m2!1e3!4b1!4m6!3m5!1s0x476a61f2af150829:0x9df0cd3c868f9096!8m2!3d47.8006537!4d18.7372142!16s%2Fg%2F11fmgypm4n?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(28, 'Eszterházy Károly Katolikus Egyetem (Eger)', 'legalább nem hittudományi egyetem', 'Eger, Eszterházy tér 1, 3300', 'https://www.google.com/maps/place/Eszterh%C3%A1zy+K%C3%A1roly+Katolikus+Egyetem+J%C3%A1szber%C3%A9nyi+Campus/@47.4969,17.5912711,240182m/data=!3m1!1e3!4m10!1m2!2m1!1sEszterh%C3%A1zy+K%C3%A1roly+Katolikus+Egyetem!3m6!1s0x47410708da3dcc31:0xc600d2c8cf24c85e!8m2!3d47.4969!4d19.8984!15sCiVFc3p0ZXJow6F6eSBLw6Fyb2x5IEthdG9saWt1cyBFZ3lldGVtIgOIAQGSAQp1bml2ZXJzaXR54AEA!16s%2Fg%2F1tgg8r5z?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(29, 'Evangélikus Hittudományi Egyetem', '.... miért is csodálkkozok azon, hogy még egy hitttudományi egyetem ez', 'Budapest, Rózsavölgyi u 3, 1141', 'https://www.google.com/maps/place/Evang%C3%A9likus+Hittudom%C3%A1nyi+Egyetem/@47.5201416,19.1124331,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741db6f60cf63d3:0x13a106dd9d31f0d3!8m2!3d47.5201416!4d19.115008!16s%2Fg%2F1xy2v7p4?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(30, 'Gábor Dénes Egyetem', 'miért egy csoport kép van fenn google maps-en első képként??', 'Budapest, Fejér Lipót u. 70, 1119', 'https://www.google.com/maps/place/G%C3%A1bor+D%C3%A9nes+Egyetem/@47.4652126,19.0345645,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741ddbc750650c7:0x5fcd166315a43910!8m2!3d47.4652126!4d19.0371394!16s%2Fg%2F11dyk8p78?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(31, 'Eszterházy Károly Katolikus Egyetem (Jászberény)', 'tényleg nem tudom mit tanulnak itt', 'Jászberény, Rákóczi út 53, 5100', 'https://www.google.com/maps/place/Eszterh%C3%A1zy+K%C3%A1roly+Katolikus+Egyetem+J%C3%A1szber%C3%A9nyi+Campus/@47.4969,19.8958251,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47410708da3dcc31:0xc600d2c8cf24c85e!8m2!3d47.4969!4d19.8984!16s%2Fg%2F1tgg8r5z?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(32, 'Gál Ferenc Egyetem (Szarvas)', 'nem tudom itt elvileg pedagógiát tanulhatsz', 'Szarvas, Szabadság út 4, 5540', 'https://www.google.com/maps/place/G%C3%A1l+Ferenc+Egyetem+Pedag%C3%B3giai+Kar/@46.8643475,19.3884705,121530m/data=!3m1!1e3!4m10!1m2!2m1!1s+G%C3%A1l+Ferenc+Egyetem!3m6!1s0x4746a8379d19084b:0xde67436a86a06a30!8m2!3d46.8643475!4d20.542035!15sChNHw6FsIEZlcmVuYyBFZ3lldGVtkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F11xc6576c?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(33, 'Gál Ferenc Egyetem (Gyula)', 'nézd én arról se tuddam, hogy vannak ilyen egyetemek, miért várod el tőlem, hogy tudjam mit csinálnak ott???', 'Gyula, Szent István u. 17-19, 5700', 'https://www.google.com/maps/place/G%C3%A1l+Ferenc+Egyetem/@46.6413047,20.1200896,122034m/data=!3m1!1e3!4m10!1m2!2m1!1s+G%C3%A1l+Ferenc+Egyetem!3m6!1s0x4745d7fbc8af36d9:0x1caaed263e2dee11!8m2!3d46.6413047!4d21.2736541!15sChNHw6FsIEZlcmVuYyBFZ3lldGVtkgEHY29sbGVnZeABAA!16s%2Fg%2F11s66mhq0z?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(34, 'Gál Ferenc Egyetem (Békéscsaba)', 'Békés csabán is tanulhatsz itt, de ez nem a székhelye', 'Békéscsaba, Bajza u. 33, 5600', 'https://www.google.com/maps/place/G%C3%A1l+Ferenc+Egyetem/@46.6413047,20.1200896,122034m/data=!3m1!1e3!4m10!1m2!2m1!1s+G%C3%A1l+Ferenc+Egyetem!3m6!1s0x47442b0a9dd6e435:0x3b429d8cfc9fc803!8m2!3d46.6792949!4d21.1132169!15sChNHw6FsIEZlcmVuYyBFZ3lldGVtkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F1tk6tpsg?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(35, 'Gál Ferenc Egyetem (Szeged)', 'na ez itt a székhely', 'Szeged, Dóm tér 6, 6720', 'https://www.google.com/maps/place/G%C3%A1l+Ferenc+Egyetem+-+Teol%C3%B3giai+Kar/@46.248169,18.9940025,122918m/data=!3m1!1e3!4m10!1m2!2m1!1s+G%C3%A1l+Ferenc+Egyetem!3m6!1s0x4744886fdeff2817:0x5a9d2e21be11c851!8m2!3d46.248169!4d20.147567!15sChNHw6FsIEZlcmVuYyBFZ3lldGVtkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F11byd5rjjx?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(36, 'IBS Nemzetközi Üzleti Főiskola', 'nem tudom, ez valami nemzetközi tanulmányi intézmény', 'Budapest, Záhony u. 7, 1031', 'https://www.google.com/maps/place/IBS+International+Business+School+-+Budapest/@47.5626864,19.0029449,7496m/data=!3m1!1e3!4m10!1m2!2m1!1zSUJTIE5lbXpldGvDtnppIMOcemxldGkgRsWRaXNrb2xh!3m6!1s0x4741ded0175c2447:0x5829748b1a8a177!8m2!3d47.5626864!4d19.0539257!15sCiFJQlMgTmVtemV0a8O2emkgw5x6bGV0aSBGxZFpc2tvbGGSAQ9idXNpbmVzc19zY2hvb2zgAQA!16s%2Fm%2F0ggb552?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(37, 'Kodolányi János Egyetem', 'nem is tudtam, hogy van ilyen településünk, szerintetek tudtam az egy etemről???', 'Orosháza, Gyopárosi út, 5900', 'https://www.google.com/maps/place/Kodol%C3%A1nyi+J%C3%A1nos+Egyetem/@46.5637168,20.6327674,477m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47443e40f007f221:0x8fde2f3a4e7c0bc6!8m2!3d46.5637168!4d20.6353423!16s%2Fm%2F0cpnh74?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(38, 'Liszt Ferenc Zeneművészeti Egyetem', 'zeneművészet... mert kellenek nekünk nem AI zenék is. Der amúgy itt mit tanulnal, nem tudom.', 'Budapest, Liszt Ferenc tér 8, 1061', 'https://www.google.com/maps/place/Liszt+Ferenc+Zenem%C5%B1v%C3%A9szeti+Egyetem/@47.5032647,19.0616961,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc6ec28f18e7:0x1724948e7efd6fff!8m2!3d47.5032647!4d19.064271!16zL20vMDlwa3N3?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(39, 'Magyar Agrár- és Élettudományi Egyetem (Budapest)', 'a maps buta, szerinte csak Budapesten van, de...', 'Budapest, Villányi út 29-43, 1118', 'https://www.google.com/maps/place/Magyar+Agr%C3%A1r-+%C3%A9s+%C3%89lettudom%C3%A1nyi+Egyetem/@47.4805283,19.0349238,469m/data=!3m1!1e3!4m10!1m2!2m1!1smate!3m6!1s0x4741ddb5546bcc47:0xccc86433fb8f4282!8m2!3d47.4806414!4d19.0389791!15sCgRtYXRlWgYiBG1hdGWSAQp1bml2ZXJzaXR5mgEkQ2hkRFNVaE5NRzluUzBWSlEwRm5TVVE1TldScVl6bDNSUkFC4AEA-gEECAAQEg!16s%2Fg%2F11h58fpg_f?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(40, 'Magyar Agrár- és Élettudományi Egyetem (Kaposvár)', '...van Kaposváron, ...', 'Kaposvár, Guba Sándor u. 40, 7400', 'https://www.google.com/maps/place/MATE+Kaposv%C3%A1ri+Campus/@46.3833915,17.8208248,479m/data=!3m1!1e3!4m10!1m2!2m1!1smate!3m6!1s0x47683ddba89835f5:0x816f57b0d10f099e!8m2!3d46.3833915!4d17.8253309!15sCgRtYXRlWgYiBG1hdGWSAQp1bml2ZXJzaXR5mgEjQ2haRFNVaE5NRzluUzBWSlEwRm5TVU4xYjNKRGJrSjNFQUXgAQD6AQUI6AQQIg!16s%2Fm%2F04yfmbt?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(41, 'Magyar Agrár- és Élettudományi Egyetem (Gödöllő)', '... Gödöllőn és...', 'Gödöllő, Páter Károly u. 1, 2100', 'https://www.google.com/maps/place/Magyar+Agr%C3%A1r-+%C3%A9s+%C3%89lettudom%C3%A1nyi+Egyetem/@47.5930204,19.3569932,468m/data=!3m1!1e3!4m10!1m2!2m1!1smate!3m6!1s0x4741c91eaf84d1ff:0xbf7cb0a0af6ff485!8m2!3d47.5930204!4d19.3614993!15sCgRtYXRlWgYiBG1hdGWSAQp1bml2ZXJzaXR5mgEkQ2hkRFNVaE5NRzluUzBWSlEwRm5TVU15TVZsbVp6aG5SUkFC4AEA-gEECHUQKQ!16s%2Fm%2F0vsy37_?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(42, 'Magyar Agrár- és Élettudományi Egyetem (Keszthely)', '... Keszthelyen is', 'Cserszegtomaj, 8372', 'https://www.google.com/maps/place/MATE+Georgikon+Sz%C5%91l%C3%A9szeti-Bor%C3%A1szati+K%C3%ADs%C3%A9rleti+Telep/@46.7944818,17.2379096,3803m/data=!3m1!1e3!4m10!1m2!2m1!1sMate+!3m6!1s0x47691d231d9c9b45:0x7619143d047c4e8c!8m2!3d46.7962781!4d17.2631631!15sCgRNYXRlkgEIdmluZXlhcmTgAQA!16s%2Fg%2F11bxc5rwng?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(43, 'Magyar Képzőművészeti Egyetem', 'vannak kérdéseim, de sz engem zavar, hogy olyan közel van a Terror Házához', 'Budapest, Andrássy út 69-71, 1062', 'https://www.google.com/maps/place/Magyar+K%C3%A9pz%C5%91m%C5%B1v%C3%A9szeti+Egyetem/@47.5074344,19.064477,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc71dcbacf47:0x1fbe91c8069d634f!8m2!3d47.5074344!4d19.0670519!16s%2Fm%2F02843_2?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(44, 'Magyar Táncművészeti Egyetem', 'kérdéseket vet fel az elhelyezkedése', 'Budapest, Amerikai út 96, 1145', 'https://www.google.com/maps/place/Magyar+T%C3%A1ncm%C5%B1v%C3%A9szeti+Egyetem/@47.5202217,19.0896763,469m/data=!3m1!1e3!4m10!1m2!2m1!1zTWFneWFyIFTDoW5jbcWxdsOpc3pldGkgRWd5ZXRlbQ!3m6!1s0x4741db31558145b9:0x578de2266d248f87!8m2!3d47.5203274!4d19.0941586!15sCh9NYWd5YXIgVMOhbmNtxbF2w6lzemV0aSBFZ3lldGVtkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F11f5dtn8yw?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(45, 'Milton Friedman Egyetem', 'az egyetemről hallottam már, de nem tudom mi van ott', 'Budapest, Kelta u. 2, 1039', 'https://www.google.com/maps/place/Milton+Friedman+Egyetem/@47.6010676,19.061297,468m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741d75fc483fcb5:0x69844aa373aec864!8m2!3d47.6010676!4d19.0638719!16s%2Fg%2F11c2kvlrnf?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(46, 'Miskolci Egyetem', 'már ott problémáim vannak, hogy nem Budapest', 'Miskolc, Egyetem út 1, 3515', 'https://www.google.com/maps/place/Miskolci+Egyetem/@48.0814275,20.761564,464m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47409f84ee990555:0x5f1a1e1d57dd9208!8m2!3d48.0814275!4d20.7641389!16zL20vMDVwems0?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(47, 'Moholy-Nagy Művészeti Egyetem', 'valami művészeteket tusz itt tanulni', 'Budapest, Zugligeti út 9, 1121', 'https://www.google.com/maps/place/Moholy-Nagy+M%C5%B1v%C3%A9szeti+Egyetem/@47.5166892,18.9885516,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dec4dd3c5fa1:0x6efcbad40e3e2191!8m2!3d47.5166892!4d18.9911265!16zL20vMGJkc2ww?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(48, 'Neumann János Egyetem', 'ő nem csinált valami fontosat?? mondjuk egy egyetem lett elnevezve róla... nwm', 'Budapest, Ludovika tér 2, 1083', 'https://www.google.com/maps/place/Nemzeti+K%C3%B6zszolg%C3%A1lati+Egyetem/@47.481786,19.0827991,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dcbe76677753:0x66a48e8f47eefe59!8m2!3d47.481786!4d19.085374!16s%2Fg%2F11bbmzzp4s?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(49, 'Nyíregyházi Egyetem', 'ez gondolom Nyíregyházán van', 'Nyíregyháza, Sóstói út 31/B, 4400', 'https://www.google.com/maps/place/Ny%C3%ADregyh%C3%A1zi+Egyetem/@47.9729444,21.7101752,465m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47389f77e6fc50c5:0x4ca55d4be2a5d21a!8m2!3d47.9729444!4d21.7127501!16s%2Fg%2F121_43vz?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(50, 'Óbudai Egyetem', 'Budán van, pontosabban Óbudán, de az is buda, úgyhogy olyan szar nem lehet', 'Budapest, Bécsi út 96/B, 1034', 'https://www.google.com/maps/place/%C3%93budai+Egyetem/@47.5338887,19.0318137,469m/data=!3m3!1e3!4b1!5s0x476a08557957781f:0xd2a040190bb767d9!4m6!3m5!1s0x4741d95a5e06c845:0x335116a5f1e32819!8m2!3d47.5338887!4d19.0343886!16s%2Fm%2F0b6gb7y?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(51, 'Nemzeti Közszolgálati Egyetem', 'ez vanlami közszolgálati egyetem nem tudom ez mit fed', 'Budapest, Ludovika tér 2, 1083', 'https://www.google.com/maps/place/Nemzeti+K%C3%B6zszolg%C3%A1lati+Egyetem/@47.481786,19.085374,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dcbe76677753:0x66a48e8f47eefe59!8m2!3d47.481786!4d19.085374!16s%2Fg%2F11bbmzzp4s?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(52, 'Országos Rabbiképző - Zsidó Egyetem', 'Az ember azt hinné, hogy van elég zsidó, de kell azért zsidóképző...', 'Budapest, Scheiber Sándor utca 2, 1084', 'https://www.google.com/maps/place/Orsz%C3%A1gos+Rabbik%C3%A9pz%C5%91+%E2%80%93+Zsid%C3%B3+Egyetem/@47.4934906,19.0675681,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc5e7f01e5d5:0x24c0b17afc750c8f!8m2!3d47.4934906!4d19.070143!16zL20vMGRqZDRs?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(53, 'Pannon Egyetem (Veszprém)', 'szeretném tudni, hogy ki baszta el a címét', 'Veszprém, https://maps.app.goo.gl/WNHhFweE5FxXdZY77, Egyetem u. 10, 8200', 'https://www.google.com/maps/place/Pannon+Egyetem/@47.0879453,15.6009259,242046m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x47699a6d01b066bd:0x848dc73247d42b80!8m2!3d47.0879453!4d17.9080548!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBWhAiDnBhbm5vbiBlZ3lldGVtkgEKdW5pdmVyc2l0eZoBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VOZk9WcDZZVXRSRUFF4AEA-gEECBAQNg!16zL20vMGRjd2px?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(54, 'Pannon Egyetem (Nagykanizsa)', 'itt legalább nincs elbaszva a cím', 'Nagykanizsa, Zrínyi Miklós u. 18, 8800', 'https://www.google.com/maps/place/Pannon+Egyetem/@47.0879453,15.6009259,242046m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x4768937427a5cfb7:0x15250036185d9f14!8m2!3d46.4533457!4d16.9851886!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBWhAiDnBhbm5vbiBlZ3lldGVtkgEKdW5pdmVyc2l0eZoBJENoZERTVWhOTUc5blMwVkpRMEZuU1VNdE5HOUxVVGgzUlJBQuABAPoBBAgAEA0!16s%2Fg%2F1tfm5g1h?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(55, 'Pannon Egyetem (Ajka)', 'miért cseszik el a címeket???', 'Ajka, 8400', 'https://www.google.com/maps/place/Pannon+Egyetem+Ajka+Kampusz/@47.0879453,15.6009259,242046m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x476973296687ed2d:0xd1241f93c0f3a72d!8m2!3d47.1053584!4d17.5556726!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBWhAiDnBhbm5vbiBlZ3lldGVtkgEHY29sbGVnZZoBJENoZERTVWhOTUc5blMwVkpRMEZuU1VST2MyWmxjV3hCUlJBQuABAPoBBAgAEDA!16s%2Fg%2F11q58f3p88?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(56, 'Pannon Egyetem (Zalaegerszeg)', 'mittom én mit tanulsz itt Zalaegerszegen', 'Zalaegerszeg, Gasparich Márk u. 18/A, 8900', 'https://www.google.com/maps/place/Pannon+Egyetem+Gazd%C3%A1lkod%C3%A1si+Kar+Zalaegerszeg/@46.8443225,14.5211589,243151m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x4769283b9ed6656f:0xcf153d701bc42a6!8m2!3d46.8443225!4d16.8282878!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F122jr56p?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(57, 'Pápai Református Teológiai Akadémia', 'szerintem elbaszta magát az id', 'Pápa, Március 15. tér 13-14, 8500', 'https://www.google.com/maps/place/P%C3%A1pai+Reform%C3%A1tus+Teol%C3%B3giai+Akad%C3%A9mia/@47.3286471,17.4671052,471m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4769610ed24cd5a1:0xbb068c059140d1c!8m2!3d47.3286471!4d17.4696801!16s%2Fg%2F11xlbsxpt?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(58, 'Pannon Egyetem (Székesfehérvár)', 'Miért van ebből ennyi???', 'Székesfehérvár, Cseh u., 8000', 'https://www.google.com/maps/place/Pannon+Egyetem/@46.7852469,16.3333058,204690m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x4769f752bb66f555:0x8ad15ccb168c1810!8m2!3d47.1422258!4d18.4130837!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F11h_6pmp3m?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(59, 'Pannon Egyetem (Pápa)', 'itt szerintem nem járt a pápa', 'Pápa, Nagysallói u. 2, 8500', 'https://www.google.com/maps/place/Pannon+Egyetem/@46.7852469,16.3333058,204690m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x47696142d26d1fbf:0xab28341e62ae04fd!8m2!3d47.309764!4d17.4818347!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBkgEKdW5pdmVyc2l0eeABAA!16s%2Fg%2F11fn6szp_n?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(60, 'Pannon Egyetem (Kaposvár)', 'itt valami lovas akadémiálya van', 'Kaposvár, Guba Sándor u. 40, 7400', 'https://www.google.com/maps/place/Pannon+Lovasakad%C3%A9mia/@46.7852469,16.3333058,204690m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x47683ddbdfd4c043:0x1d7c1d3bfb4ca2e9!8m2!3d46.3849018!4d17.8232711!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBWhAiDnBhbm5vbiBlZ3lldGVtkgEPZXF1ZXN0cmlhbl9jbHVimgEkQ2hkRFNVaE5NRzluUzBWSlEwRm5TVVJhT1haeVgyNVJSUkFC4AEA-gEECAAQPQ!16s%2Fg%2F11gdtz6785?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(61, 'Pannon Egyetem (Dunaújváros)', 'miért kell ebből ennyi????', 'Dunaújváros, Pannon kert 1, 2400', 'https://www.google.com/maps/place/Pannon+Oktat%C3%A1si+K%C3%B6zpont/@46.7852469,16.3333058,204690m/data=!3m1!1e3!4m10!1m2!2m1!1sPannon+Egyetem!3m6!1s0x4742176e9510fded:0xf075b499c980a38d!8m2!3d46.9609668!4d18.9238325!15sCg5QYW5ub24gRWd5ZXRlbSIDiAEBWhAiDnBhbm5vbiBlZ3lldGVtkgEQZWR1Y2F0aW9uX2NlbnRlcpoBJENoZERTVWhOTUc5blMwVkpRMEZuU1VRMWNVcDJhakpCUlJBQuABAPoBBAgAEBU!16s%2Fg%2F1tftd2v7?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(62, 'Pázmány Péter Katolikus Egyetem', 'Mit csinált Pázmány Péter, hogy van róla elnevezve egyetem?', 'Budapest, Szentkirályi u. 28, 1088', 'https://www.google.com/maps/place/P%C3%A1zm%C3%A1ny+P%C3%A9ter+Katolikus+Egyetem/@46.3005426,5.2005213,3929624m/data=!3m1!1e3!4m10!1m2!2m1!1sP%C3%A1zm%C3%A1ny+P%C3%A9ter+Katolikus+Egyetem!3m6!1s0x4741dc5c77be66d7:0x87a50b9cf530305b!8m2!3d47.4915855!4d19.0659823!15sCiJQw6F6bcOhbnkgUMOpdGVyIEthdG9saWt1cyBFZ3lldGVtkgEKdW5pdmVyc2l0eeABAA!16zL20vMDgxOGNr?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(63, 'Pécsi Püspöki Hittudományi Főiskola', 'jéj még egy hittudomány, minek?', 'Pécs, Hunyadi János u. 11, 7625', 'https://www.google.com/maps/place/P%C3%A9csi+P%C3%BCsp%C3%B6ki+Hittudom%C3%A1nyi+F%C5%91iskola/@46.0792829,18.2271612,482m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4742b1a3c2475a5d:0x56b8b8dfcf39315a!8m2!3d46.0792829!4d18.2271612!16s%2Fg%2F12384_m0?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(64, 'Pünkösdi Teológiai Főiskola', 'mé egy csoport kép', 'Budapest, Gyömrői út 89, 1183', 'https://www.google.com/maps/place/P%C3%BCnk%C3%B6sdi+Teol%C3%B3giai+F%C5%91iskola/@47.455414,19.185099,469m/data=!3m3!1e3!4b1!5s0x4741c24d526d1baf:0xaf5b59e79b845738!4m6!3m5!1s0x4741c24d526da5a7:0x6f7af6b1f842f06d!8m2!3d47.455414!4d19.185099!16s%2Fm%2F0cp3kxl?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(65, 'Sapientia Szerzetesi Hittudományi Főiskola', 'legalább szerzeti ez a hittudományi intézmény', 'Budapest, Piarista köz 1, 1052', 'https://www.google.com/maps/place/Sapientia+Szerzetesi+Hittudom%C3%A1nyi+F%C5%91iskola/@47.4925607,19.0530092,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc46bf63e02b:0xba185c7a519f8f59!8m2!3d47.4925607!4d19.0530092!16s%2Fg%2F122bfs11?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(66, 'Sárospataki Református Hittudományi Egyetem', 'még egy hittudomány, miért??', 'Sárospatak, Rákóczi út, 1', 'https://www.google.com/maps/place/S%C3%A1rospataki+Reform%C3%A1tus+Hittudom%C3%A1nyi+Egyetem/@48.3231392,21.5713207,462m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4738cb004f05f335:0x4341134ad38fead5!8m2!3d48.3231392!4d21.5713207!16s%2Fg%2F11y4n60225?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(67, 'Sola Scriptura Teológiai Főiskola', 'mi az a teológia??', 'Biatorbágy, Patak u. 34/a, 2051', 'https://www.google.com/maps/place/Sola+Scriptura+Teol%C3%B3giai+F%C5%91iskola/@47.4682359,18.829004,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741df211881b52f:0xea3209f857eebe53!8m2!3d47.4682359!4d18.829004!16s%2Fm%2F0cpdv_6?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(68, 'Soproni Egyetem', 'Sopron az ott a határnál van igaz?', 'Sopron, Bajcsy-Zsilinszky u. 4, 9400', 'https://www.google.com/maps/place/Soproni+Egyetem/@47.1006264,14.2573478,575549m/data=!3m1!1e3!4m10!1m2!2m1!1sSoproni+Egyetem!3m6!1s0x476c3ca61fb78a5b:0x8994a005403a417c!8m2!3d47.680273!4d16.5771423!15sCg9Tb3Byb25pIEVneWV0ZW1aESIPc29wcm9uaSBlZ3lldGVtkgEKdW5pdmVyc2l0eZoBI0NoWkRTVWhOTUc5blMwVkpRMEZuU1VSRU1uTnVNRmhCRUFF4AEA-gEECAAQNQ!16zL20vMDhscTRt?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(69, 'Széchenyi István Egyetem (Győr)', 'itt mit lehet tanulni? nem tudom', 'Győr, Egyetem tér 1, 9026', 'https://www.google.com/maps/place/Sz%C3%A9chenyi+Istv%C3%A1n+Egyetem/@47.7201618,16.4415529,239159m/data=!3m1!1e3!4m11!1m3!2m2!1sSz%C3%A9chenyi+Istv%C3%A1n+Egyetem!6e2!3m6!1s0x476bbfdfda327c3b:0xd0538eef80041623!8m2!3d47.6933064!4d17.6275327!15sChpTesOpY2hlbnlpIElzdHbDoW4gRWd5ZXRlbZIBCnVuaXZlcnNpdHngAQA!16s%2Fm%2F09gmw59?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(70, 'Széchenyi István Egyetem (Mosonmagyaróvár)', 'Miért ilyen hosszú Mosonmagyaróvár neve??', 'Mosonmagyaróvár, Vár tér 2, 9200', 'https://www.google.com/maps/place/Sz%C3%A9chenyi+Istv%C3%A1n+Egyetem,+Albert+K%C3%A1zm%C3%A9r+Mosonmagyar%C3%B3v%C3%A1ri+Kar/@47.7201618,16.4415529,239159m/data=!3m1!1e3!4m11!1m3!2m2!1sSz%C3%A9chenyi+Istv%C3%A1n+Egyetem!6e2!3m6!1s0x476c77e2ee553633:0xc416e33aca1d0bdd!8m2!3d47.8790636!4d17.2747233!15sChpTesOpY2hlbnlpIElzdHbDoW4gRWd5ZXRlbZIBB2NvbGxlZ2XgAQA!16s%2Fg%2F120xv34b?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(71, 'Szegedi Tudományegyetem (Szeged)', 'Ez szegeden található, de van egy nem Szegeden is', 'Szeged, Dugonics tér 13, 6720', 'https://www.google.com/maps/place/Szegedi+Tudom%C3%A1nyegyetem/@46.154902,19.7206898,123127m/data=!3m1!1e3!4m10!1m2!2m1!1sSzegedi+Tudom%C3%A1nyegyetem!3m6!1s0x4744886ff749d09b:0x3c136b11e025c582!8m2!3d46.2499492!4d20.14641!15sChhTemVnZWRpIFR1ZG9tw6FueWVneWV0ZW1aGiIYc3plZ2VkaSB0dWRvbcOhbnllZ3lldGVtkgEKdW5pdmVyc2l0eZoBJENoZERTVWhOTUc5blMwVkpRMEZuU1VSdWNFNHlNRE5SUlJBQuABAPoBBAgkEEI!16zL20vMDQ1cTl4?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(72, 'Szegedi Tudományegyetem (Hódmezővásárhely)', 'ott hódokat tusz venni egy mezei vásár helyen??', 'Hódmezővásárhely, Andrássy út 15, 6800', 'https://www.google.com/maps/place/Szegedi+Tudom%C3%A1nyegyetem+Mez%C5%91gazdas%C3%A1gi+Kar/@46.154902,19.7206898,123127m/data=!3m1!1e3!4m10!1m2!2m1!1sSzegedi+Tudom%C3%A1nyegyetem!3m6!1s0x47446f70a988e145:0x81e37880b1f53ad2!8m2!3d46.4149139!4d20.323036!15sChhTemVnZWRpIFR1ZG9tw6FueWVneWV0ZW1aGiIYc3plZ2VkaSB0dWRvbcOhbnllZ3lldGVtkgEKdW5pdmVyc2l0eZoBRENpOURRVWxSUVVOdlpFTm9kSGxqUmpsdlQydFdkV0ZFYUhOVFJsSkZZVzA1VVZaWFJYbFphVEIzV25wR2RVNXRZeEFC4AEA-gEECAAQEg!16s%2Fg%2F1tfk7s__?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(73, 'Szent Atanáz Görögkatolikus Hittudományi Főiskola', 'miért nem írta be a többit?????', 'Nyíregyháza, Bethlen Gábor u. 13-19, 4400', 'https://www.google.com/maps/place/Szent+Atan%C3%A1z+G%C3%B6r%C3%B6gkatolikus+Hittudom%C3%A1nyi+F%C5%91iskola/@47.9556687,21.7094895,465m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47389f95bd83590f:0x8a5d686b15365d38!8m2!3d47.9556687!4d21.7120644!16s%2Fg%2F12q4_21y8?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(74, 'Szent Pál Akadémia', 'az akadémia amit másodjára veszek fel... :)', 'Budapest, Gyömrői út 69, 1103', 'https://www.google.com/maps/place/Szent+P%C3%A1l+Akad%C3%A9mia/@47.4694564,19.1489862,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741c3185de1c907:0x970d0305c80139bc!8m2!3d47.4694564!4d19.1515611!16s%2Fg%2F121hftn1?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(75, 'Színház- és Filmművészeti Egyetem', 'hogy néz ki a Budai épülete?? nem is találom a maps utcaképén', 'Budapest, Szentkirályi u. 32, 1088', 'https://www.google.com/maps/place/Sz%C3%ADnh%C3%A1z-+%C3%A9s+Filmm%C5%B1v%C3%A9szeti+Egyetem/@47.4998449,18.9969423,7505m/data=!3m1!1e3!4m10!1m2!2m1!1zU3rDrW5ow6F6LSDDqXMgRmlsbW3FsXbDqXN6ZXRpIEVneWV0ZW0!3m6!1s0x4741dc5b8dad3543:0x6519ccdb71cf02ae!8m2!3d47.4910512!4d19.0660874!15sCiZTesOtbmjDoXotIMOpcyBGaWxtbcWxdsOpc3pldGkgRWd5ZXRlbZIBCnVuaXZlcnNpdHngAQA!16s%2Fg%2F11btwk1sdj?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(76, 'Tokaj-Hegyalja Egyetem', 'hol van Hegyalja, gondolom a hegy aljánál, de amúgy tényleg.\r\n... ez az egyetem miért Sárospatakon található?????', 'Sárospatak, Eötvös út 7, 3950', 'https://www.google.com/maps/place/Tokaj-Hegyalja+Egyetem/@48.3212342,21.5666857,462m/data=!3m2!1e3!4b1!4m6!3m5!1s0x6dc96986b9c1dd73:0x51a5a32ce20534d9!8m2!3d48.3212342!4d21.5666857!16s%2Fg%2F12qhl04ks?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(77, 'Tomori Pál Főiskola', 'kérlek nem akarom még egyszer ezek beírni', 'Budapest, Művelődés u. 21, 1223', 'https://www.google.com/maps/place/Tomori+P%C3%A1l+F%C5%91iskola/@47.4106203,19.010967,470m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741e7042a4574a3:0xca16f10d54ba6538!8m2!3d47.4106203!4d19.0135419!16s%2Fm%2F0cpbjfh?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(78, 'Veszprémi Érseki Főiskola', 'már negydjére írom ezeket a szarokat be!', 'Veszprém, Jutasi út 18/2, 8200', 'https://www.google.com/maps/place/Veszpr%C3%A9mi+%C3%89rseki+F%C5%91iskola/@47.1092508,17.9074094,473m/data=!3m2!1e3!4b1!4m6!3m5!1s0x47699a61b8044ee1:0x7ca6706e1062bd30!8m2!3d47.1092508!4d17.9099843!16s%2Fm%2F0cpbf2s?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(79, 'Wekerle Sándor Nemzetközi Egyetem', 'Ki ez a Sanyi akiről ellett nevezve?', 'Budapest, Jázmin u. 10, 1083', 'https://www.google.com/maps/place/Wekerle+S%C3%A1ndor+Nemzetk%C3%B6zi+Egyetem/@47.4857465,19.0785423,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dcf4644ded29:0xd2c66c65ed03e83c!8m2!3d47.4857465!4d19.0811172!16s%2Fm%2F0vsgpdt?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL);
INSERT INTO `university` (`university_id`, `name`, `description`, `address`, `google_maps_link`, `page_link`, `is_deleted`, `deleted_at`) VALUES
(80, 'Wesley János Lelkészképző Főiskola', 'ugye végeztem ezekkel a szarokkkal???? Kérlek, nem akarom őket újra beírni!!', 'Budapest, Dankó u. 11, 1086', 'https://www.google.com/maps/place/Wesley+J%C3%A1nos+Lelk%C3%A9szk%C3%A9pz%C5%91+F%C5%91iskola/@47.490954,19.0793737,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dcf0e7d9fe13:0xbd68724315b2e554!8m2!3d47.490954!4d19.0819486!16s%2Fg%2F11bzx32zmp?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', '', 0, NULL),
(81, 'Apor Vilmos Katolikus Főiskola (Budapest)', 'A svájci Ingenbohlban alapított Szent Keresztről Nevezett Irgalmas Nővérek 1865-ben telepedtek meg Magyarországon. 1901-ben a Budapesttől mintegy 30 kilométerre levő Zsámbék községben létrehozták első magyar noviciátusukat.', 'Budapest, Krisztina krt. 59, 1013', 'https://www.google.com/maps/place/Apor+Vilmos+Katolikus+F%C5%91iskola+Feln%C5%91ttk%C3%A9pz%C3%A9si+K%C3%B6zpont/@47.4975114,19.0276764,469m/data=!3m2!1e3!4b1!4m6!3m5!1s0x4741dc247640abfd:0x3dbfbf60dd46f11e!8m2!3d47.4975114!4d19.0302513!16s%2Fg%2F1vl9q82s?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'https://www.avkf.hu/', 0, NULL),
(82, 'Debreceni Egyetem (Siófok)', 'A Debreceni Egyetem a hazai felsőoktatás egyik kiemelkedő intézményeként - az európai egyetemek Magna Charta-jának szellemében - a legmagasabb szintű, sokoldalú, multidiszciplináris képzéssel, kutatással és fejlesztéssel járul hozzá az egyetemes tudomány és a magyar társadalom fejlődéséhez. Ezt a küldetést az egyetem oktatói, dolgozói és hallgatói közösen, a minőségügy elkötelezettjeként, hazai és nemzetközi partnerekkel együttműködve teljesítik.', 'Siófok, Petőfi stny. 1, 8600', 'https://www.google.com/maps/place/G%C3%A1bor+D%C3%A9nes+F%C5%91iskola+Si%C3%B3foki+Campus/@46.9076647,18.0174176,7590m/data=!3m1!1e3!4m6!3m5!1s0x4769c0835940fa19:0x27beb50d5bba16c9!8m2!3d46.9103067!4d18.0487296!16s%2Fg%2F11cnlcptp4?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'https://www.unideb.hu', 0, NULL),
(83, 'Debreceni Egyetem (Szolnok)', 'A Debreceni Egyetem a hazai felsőoktatás egyik kiemelkedő intézményeként - az európai egyetemek Magna Charta-jának szellemében - a legmagasabb szintű, sokoldalú, multidiszciplináris képzéssel, kutatással és fejlesztéssel járul hozzá az egyetemes tudomány és a magyar társadalom fejlődéséhez. Ezt a küldetést az egyetem oktatói, dolgozói és hallgatói közösen, a minőségügy elkötelezettjeként, hazai és nemzetközi partnerekkel együttműködve teljesítik.', 'Szolnok, Tiszaligeti stny. 14, 5000', 'https://www.google.com/maps/place/Debreceni+Egyetem+Szolnok+Campus/@47.164737,20.1814318,2246m/data=!3m2!1e3!5s0x47414142ca6f7799:0x356a7ee726e9f5e5!4m6!3m5!1s0x47414142c85b684b:0x85e52a257566c05d!8m2!3d47.1657583!4d20.1872312!16s%2Fm%2F0cpbkm4?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D', 'https://www.unideb.hu', 0, NULL),
(84, 'Debreceni Egyetem (Nyíregyháza)', 'A Debreceni Egyetem a hazai felsőoktatás egyik kiemelkedő intézményeként - az európai egyetemek Magna Charta-jának szellemében - a legmagasabb szintű, sokoldalú, multidiszciplináris képzéssel, kutatással és fejlesztéssel járul hozzá az egyetemes tudomány és a magyar társadalom fejlődéséhez. Ezt a küldetést az egyetem oktatói, dolgozói és hallgatói közösen, a minőségügy elkötelezettjeként, hazai és nemzetközi partnerekkel együttműködve teljesítik.', 'Nyíregyháza, Sóstói út 2-4, 4400', 'https://www.google.com/maps/place/Debreceni+Egyetem+-+Eg%C3%A9szs%C3%A9g%C3%BCgyi+Kar/@47.9529776,21.6845867,8848m/data=!3m1!1e3!4m6!3m5!1s0x47389f9be6772bbd:0x808b0c62ccccf4bb!8m2!3d47.9662676!4d21.7144061!16s%2Fg%2F11bv1rywzh?entry=ttu&g_ep=EgoyMDI2MDIyNS4wIKXMDSoASAFQAw%3D%3D', 'https://www.unideb.hu', 0, NULL),
(85, 'Debreceni Egyetem (Hajdúböszörmény)', 'A Debreceni Egyetem a hazai felsőoktatás egyik kiemelkedő intézményeként - az európai egyetemek Magna Charta-jának szellemében - a legmagasabb szintű, sokoldalú, multidiszciplináris képzéssel, kutatással és fejlesztéssel járul hozzá az egyetemes tudomány és a magyar társadalom fejlődéséhez. Ezt a küldetést az egyetem oktatói, dolgozói és hallgatói közösen, a minőségügy elkötelezettjeként, hazai és nemzetközi partnerekkel együttműködve teljesítik.', 'Hajdúböszörmény, Désány István u. 1-9, 4220', 'https://www.google.com/maps/place/Debreceni+Egyetem+Hajd%C3%BAb%C3%B6sz%C3%B6rm%C3%A9ny/@47.6675745,21.4939329,1528m/data=!3m1!1e3!4m10!1m2!2m1!1zZGVicmVjZW5pIGVneWV0ZW0gaGFqZMO6YsO2c3rDtnJtw6lueQ!3m6!1s0x47476ae467ce3463:0x7134e155a4c0d9bd!8m2!3d47.6679166!4d21.5078153!15sCiVkZWJyZWNlbmkgZWd5ZXRlbSBoYWpkw7piw7ZzesO2cm3DqW55IgOIAQFaJyIlZGVicmVjZW5pIGVneWV0ZW0gaGFqZMO6YsO2c3rDtnJtw6lueZIBDm51cnNlcnlfc2Nob29s4AEA!16s%2Fg%2F11y7z014t?entry=ttu&g_ep=EgoyMDI2MDIyNS4wIKXMDSoASAFQAw%3D%3D', 'https://www.unideb.hu', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `universityxfaculty`
--

CREATE TABLE `universityxfaculty` (
  `universityxfaculty_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL,
  `faculty_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `universityxfaculty`
--

INSERT INTO `universityxfaculty` (`universityxfaculty_id`, `university_id`, `faculty_id`) VALUES
(1, 5, 1),
(2, 5, 13),
(3, 5, 1),
(4, 5, 28),
(5, 1, 42),
(6, 1, 6),
(7, 1, 7),
(8, 1, 58),
(9, 2, 100),
(10, 2, 49),
(11, 2, 9),
(12, 2, 1),
(13, 2, 1),
(14, 2, 56),
(15, 6, 1),
(16, 6, 1),
(17, 6, 1),
(18, 7, 17),
(19, 7, 18),
(20, 7, 19),
(21, 7, 72),
(22, 7, 21),
(23, 7, 70),
(24, 7, 104),
(25, 7, 86),
(26, 7, 91),
(27, 8, 3),
(28, 1, 26),
(29, 2, 1),
(30, 2, 1),
(31, 4, 5),
(32, 4, 74),
(33, 3, 27),
(34, 3, 1),
(35, 3, 1),
(36, 7, 68),
(37, 7, 102),
(38, 7, 59),
(39, 8, 30),
(40, 8, 49),
(41, 8, 51),
(42, 8, 6),
(43, 8, 43),
(44, 85, 31),
(45, 8, 7),
(46, 8, 59),
(47, 8, 1),
(48, 8, 1),
(49, 8, 1),
(50, 8, 35),
(51, 8, 5),
(52, 8, 27),
(53, 8, 23),
(54, 9, 1),
(55, 9, 1),
(56, 9, 1),
(57, 9, 1),
(58, 9, 3),
(59, 9, 1),
(60, 9, 1),
(61, 9, 35),
(62, 9, 30),
(63, 9, 28),
(64, 9, 5),
(65, 9, 23),
(66, 9, 27),
(67, 9, 1),
(68, 9, 1),
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
(111, 11, 17),
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
(129, 2, 82),
(130, 2, 71),
(131, 2, 83),
(132, 11, 84),
(133, 2, 85),
(134, 2, 86),
(135, 2, 87),
(136, 2, 88),
(137, 2, 89),
(138, 2, 90),
(139, 2, 91),
(140, 12, 92),
(141, 13, 93),
(142, 14, 94),
(143, 14, 95),
(144, 15, 82),
(145, 81, 50),
(146, 16, 50),
(147, 81, 54),
(148, 16, 54),
(149, 16, 96),
(150, 16, 56),
(151, 17, 93),
(152, 17, 97),
(153, 18, 98),
(154, 18, 99),
(155, 19, 100),
(156, 10, 1),
(157, 10, 1),
(158, 10, 1),
(159, 3, 81),
(160, 3, 101),
(161, 3, 68),
(162, 3, 102),
(163, 3, 59),
(164, 3, 17),
(165, 3, 70),
(166, 3, 82),
(167, 3, 103),
(168, 6, 69),
(169, 6, 59),
(170, 6, 75),
(171, 6, 68),
(172, 6, 76),
(173, 6, 70),
(174, 6, 82),
(175, 6, 104),
(176, 6, 84),
(177, 6, 17),
(178, 6, 102),
(179, 20, 105),
(180, 20, 106),
(181, 20, 107),
(182, 20, 108),
(183, 20, 53),
(184, 20, 109),
(185, 20, 110),
(186, 20, 111),
(187, 20, 61),
(188, 20, 112),
(189, 20, 113),
(190, 20, 114),
(191, 20, 115),
(192, 20, 17),
(193, 20, 75),
(194, 20, 68),
(195, 20, 69),
(196, 20, 59),
(197, 20, 70),
(198, 20, 82),
(199, 20, 84),
(200, 7, 116),
(201, 7, 117),
(202, 7, 118),
(203, 7, 119),
(204, 7, 120),
(205, 7, 121),
(206, 7, 122),
(207, 7, 123),
(208, 7, 124),
(209, 7, 125),
(210, 7, 126),
(211, 7, 127),
(212, 7, 128),
(213, 7, 129),
(214, 4, 80),
(215, 4, 79),
(216, 8, 76),
(217, 8, 60),
(218, 8, 82),
(219, 8, 62),
(220, 8, 77),
(221, 8, 48),
(222, 8, 78),
(223, 8, 65),
(224, 8, 55),
(225, 84, 71),
(226, 8, 83),
(227, 8, 57),
(228, 8, 66),
(229, 8, 45),
(230, 8, 46),
(231, 84, 44),
(232, 8, 2),
(233, 8, 68),
(234, 8, 8),
(235, 8, 69),
(236, 8, 70),
(237, 8, 17),
(238, 8, 79),
(239, 8, 80),
(240, 8, 84),
(241, 85, 50),
(242, 85, 9),
(243, 85, 54),
(244, 85, 96),
(245, 8, 102),
(246, 8, 73),
(247, 8, 10),
(248, 8, 14),
(249, 8, 15),
(250, 8, 16),
(251, 8, 11),
(252, 8, 20),
(253, 8, 22),
(254, 8, 23),
(255, 8, 18),
(256, 8, 19),
(257, 8, 21),
(258, 8, 119),
(259, 8, 125),
(260, 8, 118),
(261, 8, 72),
(262, 8, 24),
(263, 8, 85),
(264, 8, 124),
(265, 8, 25),
(266, 8, 74),
(267, 8, 86),
(268, 8, 88),
(269, 84, 45),
(270, 82, 45),
(271, 83, 45),
(272, 84, 46),
(273, 83, 46),
(274, 83, 71),
(275, 82, 8),
(276, 83, 8),
(277, 83, 69),
(278, 83, 17),
(279, 82, 79),
(280, 83, 84),
(281, 82, 84),
(282, 82, 54),
(283, 82, 31),
(284, 82, 73),
(285, 83, 21),
(286, 83, 72),
(287, 82, 87),
(288, 8, 87),
(289, 8, 89),
(290, 8, 90),
(291, 8, 91),
(292, 8, 126),
(293, 8, 129),
(294, 8, 132),
(295, 8, 131),
(296, 8, 130);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` longtext NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT '1',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `last_name`, `first_name`, `username`, `email`, `password`, `role_id`, `is_deleted`, `deleted_at`) VALUES
(4, 'Kis', 'József', 'Kisjozsef', 'kisjozsef@gmail.com', 'Jelszo', 2, 0, NULL),
(5, 'Kovács', 'Bence', 'bkovacs', 'bence.kovacs@example.com', 'Passw0rd1', 1, 0, NULL),
(6, 'Tóth', 'Anna', 'annat', 'anna.toth@example.com', 'Secure123!', 1, 0, NULL),
(7, 'Szabó', 'Dávid', 'dszabo', 'david.szabo@example.com', 'Qwerty987', 1, 0, NULL),
(8, 'Farkas', 'Eszter', 'efarkas', 'eszter.farkas@example.com', 'MyPass456', 1, 1, '2025-11-25 00:00:00'),
(9, 'Nagy', 'Gábor', 'gnagy', 'gabor.nagy@example.com', 'TestUser!23', 1, 0, NULL),
(10, 'Zsófia', 'Ujsághy', 'UjZsofi', 'ujsaghy.zsofia@gmail.com', '$2a$10$4/w4CzPtjYVl1K5HBAHmJuiLpeld6iQmQA98PF2F39vBvjgnuC2XC', 2, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `userxappointment`
--

CREATE TABLE `userxappointment` (
  `userXappointment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `userxappointment`
--

INSERT INTO `userxappointment` (`userXappointment_id`, `user_id`, `appointment_id`) VALUES
(3, 4, 1),
(4, 5, 2),
(9, 9, 4),
(10, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `workerxappointment`
--

CREATE TABLE `workerxappointment` (
  `workerXappointment_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `worker_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `workerxappointment`
--

INSERT INTO `workerxappointment` (`workerXappointment_id`, `appointment_id`, `worker_id`) VALUES
(1, 4, 2),
(2, 3, 2),
(3, 2, 2),
(4, 4, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD UNIQUE KEY `date` (`date`),
  ADD KEY `user` (`worker_id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`faculty_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `university`
--
ALTER TABLE `university`
  ADD PRIMARY KEY (`university_id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `google_maps_link` (`google_maps_link`);

--
-- Indexes for table `universityxfaculty`
--
ALTER TABLE `universityxfaculty`
  ADD PRIMARY KEY (`universityxfaculty_id`),
  ADD KEY `egyetemId` (`university_id`),
  ADD KEY `karId` (`faculty_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `UserName` (`username`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `userxappointment`
--
ALTER TABLE `userxappointment`
  ADD PRIMARY KEY (`userXappointment_id`),
  ADD KEY `AppointmentId` (`appointment_id`),
  ADD KEY `UserId` (`user_id`);

--
-- Indexes for table `workerxappointment`
--
ALTER TABLE `workerxappointment`
  ADD PRIMARY KEY (`workerXappointment_id`),
  ADD KEY `AppointmentId` (`appointment_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `faculty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `university`
--
ALTER TABLE `university`
  MODIFY `university_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `universityxfaculty`
--
ALTER TABLE `universityxfaculty`
  MODIFY `universityxfaculty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=297;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `userxappointment`
--
ALTER TABLE `userxappointment`
  MODIFY `userXappointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `workerxappointment`
--
ALTER TABLE `workerxappointment`
  MODIFY `workerXappointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`worker_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `universityxfaculty`
--
ALTER TABLE `universityxfaculty`
  ADD CONSTRAINT `universityxfaculty_ibfk_1` FOREIGN KEY (`university_id`) REFERENCES `university` (`university_id`),
  ADD CONSTRAINT `universityxfaculty_ibfk_2` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);

--
-- Constraints for table `userxappointment`
--
ALTER TABLE `userxappointment`
  ADD CONSTRAINT `userxappointment_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
  ADD CONSTRAINT `userxappointment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `workerxappointment`
--
ALTER TABLE `workerxappointment`
  ADD CONSTRAINT `workerxappointment_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
