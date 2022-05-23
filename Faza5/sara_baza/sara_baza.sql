-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 23, 2022 at 06:31 AM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydb`
--
CREATE DATABASE IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `mydb`;

-- --------------------------------------------------------

--
-- Table structure for table `adresa`
--

DROP TABLE IF EXISTS `adresa`;
CREATE TABLE IF NOT EXISTS `adresa` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ulica` varchar(45) NOT NULL,
  `Broj` varchar(45) NOT NULL,
  `Sprat` int(11) DEFAULT NULL,
  `BrojStana` int(11) DEFAULT NULL,
  `PostanskiBroj` int(11) NOT NULL,
  `Mesto` varchar(45) NOT NULL,
  `IdKorisnik` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Korisnik_idx` (`IdKorisnik`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kartica`
--

DROP TABLE IF EXISTS `kartica`;
CREATE TABLE IF NOT EXISTS `kartica` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Broj` int(11) NOT NULL,
  `CSV` int(11) NOT NULL,
  `DatumIsteka` datetime NOT NULL,
  `idKorisnik` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_idKorisnik_idx` (`idKorisnik`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

DROP TABLE IF EXISTS `komentar`;
CREATE TABLE IF NOT EXISTS `komentar` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Text` varchar(100) NOT NULL,
  `Datum` datetime NOT NULL,
  `IDKorisnik` int(11) NOT NULL,
  `IDProizvod` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_idKorisnik_idx` (`IDKorisnik`),
  KEY `fk_idProizvod_idx` (`IDProizvod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

DROP TABLE IF EXISTS `korisnik`;
CREATE TABLE IF NOT EXISTS `korisnik` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `ImeIPrezime` varchar(100) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Pol` char(1) NOT NULL,
  `Potroseno` double NOT NULL DEFAULT 0,
  `Datum` date NOT NULL,
  `Tip` char(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username_UNIQUE` (`Username`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`ID`, `Username`, `Password`, `ImeIPrezime`, `Email`, `Pol`, `Potroseno`, `Datum`, `Tip`) VALUES
(1, 'janko', 'janko', 'Janko Tufegdzic', 'janko@gmail.com', 'M', 0, '2022-10-10', 'K'),
(2, 'A', 'B', 'AB', 'AB@e.com', 'M', 0, '2022-10-01', 'K'),
(4, 'sa', 'ds', 'a', 's', 's', 0, '2022-02-02', 'K'),
(5, 'v', '23', 'd', 'a', 'v', 9, '2022-02-02', 'K'),
(6, 'dusa', 'sda', 'dsad', 's@a.com', 'm', 0, '2022-01-01', 'K'),
(7, 'dd', 'as', 'dd', 'das', 'M', 0, '2022-12-12', 'K'),
(9, 'mirko', 'mdas', 'sad', 'asd', 'M', 0, '2022-11-11', 'K'),
(10, 'dakica', 'peder', 'dsa', 'savv', 'Z', 1, '2022-12-12', 'K');

-- --------------------------------------------------------

--
-- Table structure for table `odobravanje`
--

DROP TABLE IF EXISTS `odobravanje`;
CREATE TABLE IF NOT EXISTS `odobravanje` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `ImeIPrezime` varchar(100) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Pol` char(1) NOT NULL,
  `Potroseno` double NOT NULL DEFAULT 0,
  `Datum` date NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `odobravanje`
--

INSERT INTO `odobravanje` (`ID`, `Username`, `Password`, `ImeIPrezime`, `Email`, `Pol`, `Potroseno`, `Datum`) VALUES
(18, 'ssada', 'asdasd', 'adsdaasd', 'asdad', 'M', 0, '2022-05-10'),
(19, 'dusan-test', 'jakaSifra', 'Dusan Todorovic', 'moj@email.com', 'M', 0, '2000-06-25'),
(20, 'dusan-tesst', 'jakaSifra', 'Dusan Todorovic', 'moji@email.com', 'M', 0, '2000-06-25');

-- --------------------------------------------------------

--
-- Table structure for table `porudzbina`
--

DROP TABLE IF EXISTS `porudzbina`;
CREATE TABLE IF NOT EXISTS `porudzbina` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IDAdresa` int(11) NOT NULL,
  `IDKartica` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_idAdresa_idx` (`IDAdresa`),
  KEY `fk_isKartica_idx` (`IDKartica`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `proizvod`
--

DROP TABLE IF EXISTS `proizvod`;
CREATE TABLE IF NOT EXISTS `proizvod` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Naziv` varchar(45) NOT NULL,
  `Opis` varchar(45) DEFAULT NULL,
  `Putanja` varchar(45) DEFAULT NULL,
  `Cena` double NOT NULL,
  `Sezona` varchar(45) NOT NULL,
  `Tagovi` varchar(45) DEFAULT NULL,
  `godinaOd` int(11) DEFAULT NULL,
  `godinaDo` int(11) DEFAULT NULL,
  `Pol` char(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `proizvod`
--

INSERT INTO `proizvod` (`ID`, `Naziv`, `Opis`, `Putanja`, `Cena`, `Sezona`, `Tagovi`, `godinaOd`, `godinaDo`, `Pol`) VALUES
(1, 'Haljina', 'Ovo je haljina', 'putanjica', 1200, 'Leto', 'Leto, Prolece, Cvetno', 15, 55, 'Z'),
(2, 'Muska Kosulja', 'Muska kosulja', '/muska_kosulja', 999, 'Prolece', 'Prolece, Leto, Prugasto, Crno-Belo', 16, 30, 'M'),
(3, 'Zenska Kosulja', 'zenska kosuljica', 'zenska_kosulja', 1500, 'Prolece', 'Jednobojna', 20, 40, 'Z');

-- --------------------------------------------------------

--
-- Table structure for table `sadrzi`
--

DROP TABLE IF EXISTS `sadrzi`;
CREATE TABLE IF NOT EXISTS `sadrzi` (
  `IDProizvod` int(11) NOT NULL,
  `IDPorudzbina` int(11) NOT NULL,
  `Velicina` varchar(45) NOT NULL,
  `Kolicina` int(11) NOT NULL,
  PRIMARY KEY (`IDProizvod`,`IDPorudzbina`,`Velicina`),
  KEY `fk_idPorudzbina_idx` (`IDPorudzbina`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `zeli`
--

DROP TABLE IF EXISTS `zeli`;
CREATE TABLE IF NOT EXISTS `zeli` (
  `IdKorisnika` int(11) NOT NULL,
  `IdProizvoda` int(11) NOT NULL,
  `Obavesti` char(1) DEFAULT 'N',
  PRIMARY KEY (`IdKorisnika`,`IdProizvoda`),
  KEY `idPro_idx` (`IdProizvoda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `adresa`
--
ALTER TABLE `adresa`
  ADD CONSTRAINT `fk_Korisnike` FOREIGN KEY (`IdKorisnik`) REFERENCES `korisnik` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `kartica`
--
ALTER TABLE `kartica`
  ADD CONSTRAINT `fk_idKorisnika` FOREIGN KEY (`idKorisnik`) REFERENCES `korisnik` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `fk_idKorisnik` FOREIGN KEY (`IDKorisnik`) REFERENCES `korisnik` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_idProizvod` FOREIGN KEY (`IDProizvod`) REFERENCES `proizvod` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `porudzbina`
--
ALTER TABLE `porudzbina`
  ADD CONSTRAINT `fk_idAdresa` FOREIGN KEY (`IDAdresa`) REFERENCES `adresa` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_isKartica` FOREIGN KEY (`IDKartica`) REFERENCES `kartica` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `sadrzi`
--
ALTER TABLE `sadrzi`
  ADD CONSTRAINT `fk_idPorudzbina` FOREIGN KEY (`IDPorudzbina`) REFERENCES `porudzbina` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_idProizvoda` FOREIGN KEY (`IDProizvod`) REFERENCES `proizvod` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `zeli`
--
ALTER TABLE `zeli`
  ADD CONSTRAINT `IdKor` FOREIGN KEY (`IdKorisnika`) REFERENCES `korisnik` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `idPro` FOREIGN KEY (`IdProizvoda`) REFERENCES `proizvod` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
