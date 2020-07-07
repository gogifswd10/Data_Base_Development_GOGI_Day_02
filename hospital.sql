-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 07. Jul 2020 um 13:24
-- Server-Version: 10.4.13-MariaDB
-- PHP-Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `hospital`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `doctors`
--

CREATE TABLE `doctors` (
  `doctor_id` int(11) NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `specialization` varchar(55) DEFAULT NULL,
  `fk_unit_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `health_center`
--

CREATE TABLE `health_center` (
  `health_center_id` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `location` varchar(55) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `interventionss`
--

CREATE TABLE `interventionss` (
  `intervention_id` int(11) NOT NULL,
  `symptoms` varchar(250) DEFAULT NULL,
  `treatment` varchar(250) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `patient_id` int(11) DEFAULT NULL,
  `fk_doctor_id` int(11) DEFAULT NULL,
  `specialization` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(55) DEFAULT NULL,
  `last_name` varchar(55) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `admission` date DEFAULT NULL,
  `fk_unit_id` int(11) DEFAULT NULL,
  `fk_intervention_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `units`
--

CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL,
  `name` varchar(55) DEFAULT NULL,
  `floor` int(11) DEFAULT NULL,
  `fk_health_center_id` int(11) DEFAULT NULL,
  `fk_doctor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`doctor_id`),
  ADD KEY `fk_unit_id` (`fk_unit_id`);

--
-- Indizes für die Tabelle `health_center`
--
ALTER TABLE `health_center`
  ADD PRIMARY KEY (`health_center_id`);

--
-- Indizes für die Tabelle `interventionss`
--
ALTER TABLE `interventionss`
  ADD PRIMARY KEY (`intervention_id`),
  ADD KEY `fk_doctor_id` (`fk_doctor_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indizes für die Tabelle `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`),
  ADD KEY `fk_intervention_id` (`fk_intervention_id`),
  ADD KEY `fk_unit_id` (`fk_unit_id`);

--
-- Indizes für die Tabelle `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`),
  ADD KEY `fk_health_center_id` (`fk_health_center_id`),
  ADD KEY `fk_doctor_id` (`fk_doctor_id`);

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`fk_unit_id`) REFERENCES `units` (`unit_id`);

--
-- Constraints der Tabelle `interventionss`
--
ALTER TABLE `interventionss`
  ADD CONSTRAINT `interventionss_ibfk_1` FOREIGN KEY (`fk_doctor_id`) REFERENCES `doctors` (`doctor_id`),
  ADD CONSTRAINT `interventionss_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`);

--
-- Constraints der Tabelle `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`fk_intervention_id`) REFERENCES `interventionss` (`intervention_id`),
  ADD CONSTRAINT `patients_ibfk_2` FOREIGN KEY (`fk_unit_id`) REFERENCES `units` (`unit_id`);

--
-- Constraints der Tabelle `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_ibfk_1` FOREIGN KEY (`fk_health_center_id`) REFERENCES `health_center` (`health_center_id`),
  ADD CONSTRAINT `units_ibfk_2` FOREIGN KEY (`fk_doctor_id`) REFERENCES `doctors` (`doctor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
