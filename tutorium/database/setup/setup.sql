# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: tutorium
# Generation Time: 2017-11-21 13:12:57 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `studentID` int(11) NOT NULL AUTO_INCREMENT,
  `accountType` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `accountID` varchar(200) CHARACTER SET utf8 NOT NULL,
  `isTutor` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `username` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;

INSERT INTO `admin` (`username`, `password`)
VALUES
	('tutorium','8f7dd0890f92a2b12497f2009ac7bab80e9110898d45a281c0221adf66168c2b');

/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table attendance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `attendance`;

CREATE TABLE `attendance` (
  `attendanceID` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `attendance_studentID` int(11) NOT NULL,
  `attendance_tutorID` int(11) NOT NULL,
  PRIMARY KEY (`attendanceID`),
  KEY `studentID_idx` (`attendance_studentID`),
  KEY `tutorID_idx` (`attendance_tutorID`),
  CONSTRAINT `attendance_studentID` FOREIGN KEY (`attendance_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table bankaccount
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bankaccount`;

CREATE TABLE `bankaccount` (
  `bankAccount_studentID` int(11) NOT NULL,
  `bankaccountNo` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bankaccountNo`,`bankAccount_studentID`),
  KEY `bankAccount_studentID` (`bankAccount_studentID`),
  CONSTRAINT `bankAccount_studentID` FOREIGN KEY (`bankAccount_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table bankaccountpayment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bankaccountpayment`;

CREATE TABLE `bankaccountpayment` (
  `bankAccountPayment_paymentID` int(11) NOT NULL,
  `bankAccountNo` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`bankAccountPayment_paymentID`),
  CONSTRAINT `bankAccountPayment_paymentID` FOREIGN KEY (`bankAccountPayment_paymentID`) REFERENCES `paymentrecord` (`paymentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table contact
# ------------------------------------------------------------

DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `contact_studentID` int(11) NOT NULL,
  `phone` varchar(10) CHARACTER SET utf8 DEFAULT NULL,
  `LineID` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FacebookURL` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`contact_studentID`),
  CONSTRAINT `contact_studentID` FOREIGN KEY (`contact_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table course
# ------------------------------------------------------------

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `couseID` int(11) NOT NULL AUTO_INCREMENT,
  `course_tutorID` int(11) NOT NULL,
  `subject` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `acceptedDateTime` datetime NOT NULL,
  `isAccepted` bit(1) NOT NULL,
  `level` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`couseID`),
  KEY `course_tutorID_idx` (`course_tutorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table courserequest
# ------------------------------------------------------------

DROP TABLE IF EXISTS `courserequest`;

CREATE TABLE `courserequest` (
  `requestID` int(11) NOT NULL AUTO_INCREMENT,
  `courseRequest_studentID` int(11) NOT NULL,
  `courseRequest_tutorID` int(11) NOT NULL,
  `Subject` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `level` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`requestID`),
  KEY `courseRequest_studentID_idx` (`courseRequest_studentID`),
  KEY `courseRequest_tutorID_idx` (`courseRequest_tutorID`),
  CONSTRAINT `courseRequest_studentID` FOREIGN KEY (`courseRequest_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table creditcard
# ------------------------------------------------------------

DROP TABLE IF EXISTS `creditcard`;

CREATE TABLE `creditcard` (
  `creditCard_studentID` int(11) NOT NULL,
  `cardNo` int(11) NOT NULL AUTO_INCREMENT,
  `expireDate` date NOT NULL,
  `secureCode` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`cardNo`,`creditCard_studentID`),
  KEY `creditCard_studentID` (`creditCard_studentID`),
  CONSTRAINT `creditCard_studentID` FOREIGN KEY (`creditCard_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table creditcardpayment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `creditcardpayment`;

CREATE TABLE `creditcardpayment` (
  `creditCardPayment_paymentID` int(11) NOT NULL,
  `creditCardNo` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`creditCardPayment_paymentID`),
  CONSTRAINT `creditCardPayment_paymentID` FOREIGN KEY (`creditCardPayment_paymentID`) REFERENCES `paymentrecord` (`paymentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table enrolled
# ------------------------------------------------------------

DROP TABLE IF EXISTS `enrolled`;

CREATE TABLE `enrolled` (
  `enrolled_courseID` int(11) NOT NULL,
  `enrolled_studentID` int(11) NOT NULL,
  PRIMARY KEY (`enrolled_courseID`,`enrolled_studentID`),
  KEY `enrolled_studentID_idx` (`enrolled_studentID`),
  CONSTRAINT `enrolled_courseID` FOREIGN KEY (`enrolled_courseID`) REFERENCES `course` (`couseID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `enrolled_studentID` FOREIGN KEY (`enrolled_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table paymentrecord
# ------------------------------------------------------------

DROP TABLE IF EXISTS `paymentrecord`;

CREATE TABLE `paymentrecord` (
  `paymentID` int(11) NOT NULL AUTO_INCREMENT,
  `paymentRecord_studentID` int(11) NOT NULL,
  `paymentRecord_tutorID` int(11) NOT NULL,
  `paidDate` datetime NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`paymentID`),
  KEY `paymentRecord_studentID_idx` (`paymentRecord_studentID`),
  KEY `paymentRecord_tutorID_idx` (`paymentRecord_tutorID`),
  CONSTRAINT `paymentRecord_studentID` FOREIGN KEY (`paymentRecord_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table reservation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
  `reservationID` int(11) NOT NULL AUTO_INCREMENT,
  `reservation_studentID` int(11) NOT NULL,
  `reservation_tutorID` int(11) NOT NULL,
  `date` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  PRIMARY KEY (`reservationID`),
  KEY `reservation_studentID_idx` (`reservation_studentID`),
  KEY `reservation_tutorID_idx` (`reservation_tutorID`),
  CONSTRAINT `reservation_studentID` FOREIGN KEY (`reservation_studentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table student
# ------------------------------------------------------------

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `studentID` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `gender` enum('male','female','others') COLLATE utf8_unicode_ci NOT NULL,
  `educationLevel` enum('pratom','matthayomton','matthayomplai','bachelor','master','doctor') COLLATE utf8_unicode_ci NOT NULL,
  `facebookURL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lineID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `wantList` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `place` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time` varchar(1500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table tutor
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tutor`;

CREATE TABLE `tutor` (
  `studentID` int(11) NOT NULL,
  `education` varchar(2000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `teachList` varchar(2000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `place` varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `time` varchar(1500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `uploadEvidence` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isApproved` tinyint(11) NOT NULL DEFAULT '0',
  KEY `tutor_studentID` (`studentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



# Dump of table userreport
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userreport`;

CREATE TABLE `userreport` (
  `reportID` int(11) NOT NULL AUTO_INCREMENT,
  `reporterStudentID` int(11) NOT NULL,
  `reportedStudentID` int(11) NOT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `detail` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `reportedDate` date NOT NULL,
  `isRead` bit(1) NOT NULL,
  PRIMARY KEY (`reportID`),
  KEY `reporterStudentID_idx` (`reporterStudentID`),
  KEY `reportedStudentID_idx` (`reportedStudentID`),
  CONSTRAINT `reportedStudentID` FOREIGN KEY (`reportedStudentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `reporterStudentID` FOREIGN KEY (`reporterStudentID`) REFERENCES `student` (`studentID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
