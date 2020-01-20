-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 09. Dez 2019 um 09:49
-- Server-Version: 10.3.15-MariaDB
-- PHP-Version: 7.2.19

-- Edit
-- @editor Richard Schlossarek
-- @date 09.12.2019
--

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00"; 							-- +01:00 cause germany and not England;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `sportfest`
--
CREATE DATABASE IF NOT EXISTS `sportfest` DEFAULT CHARACTER SET latin1 COLLATE latin1_german1_ci;
USE `sportfest`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `disziplin`
--

CREATE TABLE `disziplin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bezeichnung` varchar(255) NOT NULL,
  `wertung_id` int(11) DEFAULT NULL,
  `rekord` varchar(100) DEFAULT NULL,
  `einheit` varchar(10) NOT NULL,
  `ordering` varchar(5) NOT NULL DEFAULT 'ASC',
  `picture` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `klasse`
--

CREATE TABLE `klasse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `klassenstufe_id` int(11) NOT NULL,
  `klasse` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `klassenstufen`
--

CREATE TABLE `klassenstufen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nummer` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `noten`
--

CREATE TABLE `noten` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `schueler_id` int(11) NOT NULL,
  `gesamtpunkte` float(11,11) NOT NULL,
  `note` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Disziplin-Klasse`
--

CREATE TABLE `Disziplin-Klasse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disziplin_id` int(11) NOT NULL,
  `klasse_id` int(11) NOT NULL,
  `wahl_gruppe` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schueler`
--

CREATE TABLE `schueler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vname` varchar(100) NOT NULL,
  `nname` varchar(100) NOT NULL,
  `gebdatum` date NOT NULL,
  `klasse_id` int(11) NOT NULL,
  `geschlecht` varchar(1) NOT NULL,
  `anwesend` int(1) NOT NULL,
  `klassenplus` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `werte`
--

CREATE TABLE `werte` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `schueler_id` int(11) NOT NULL,
  `disziplin_id` int(11) NOT NULL,
  `wert` float(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `wertung`
--

CREATE TABLE `wertung` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geschlecht` varchar(1) NOT NULL, 
  `klassenstufen_id` int(11) NOT NULL,
  `valuetable` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `disziplin`
--
ALTER TABLE `disziplin`
  ADD PRIMARY KEY (`id`);							-- bezeichnung

--
-- Indizes für die Tabelle `klasse`
--
ALTER TABLE `klasse`
  ADD PRIMARY KEY (`id`);							-- klassenstufe_id + klasse

--
-- Indizes für die Tabelle `klassenstufen`
--
ALTER TABLE `klassenstufen`
  ADD PRIMARY KEY (`id`);							-- nummer

--
-- Indizes für die Tabelle `noten`
--
ALTER TABLE `noten`
  ADD PRIMARY KEY (`id`);							-- schueler_id

--
-- Indizes für die Tabelle `schueler`
--
ALTER TABLE `schueler`
  ADD PRIMARY KEY (`id`);							-- vname + nname + gebdatum

--
-- Indizes für die Tabelle `werte`
--
ALTER TABLE `werte`
  ADD PRIMARY KEY (`id`);							-- schueler_id + disziplin_id

--
-- Indizes für die Tabelle `wertung`
--
ALTER TABLE `wertung`
  ADD PRIMARY KEY (`id`);							-- ??

--
-- AUTO_INCREMENT für exportierte Tabellen
--

		


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
