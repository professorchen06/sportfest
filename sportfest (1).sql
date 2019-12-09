-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 09. Dez 2019 um 09:49
-- Server-Version: 10.3.15-MariaDB
-- PHP-Version: 7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


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
  `id` int(11) NOT NULL,
  `bezeichnung` text NOT NULL,						-- Length?
  `wertung_id` int(11) DEFAULT NULL,
  `rekord` text DEFAULT NULL,						-- Length?
  `einheit` text NOT NULL,							-- Length? -> performance
  `ordering` varchar(5) NOT NULL DEFAULT 'ASC',
  `picture` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;				-- Latin1 -> germanLatin

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `klasse`
--

CREATE TABLE `klasse` (
  `id` int(11) NOT NULL,
  `klassenstufe_id` int(11) NOT NULL,
  `klasse` text NOT NULL							-- Length?
) ENGINE=InnoDB DEFAULT CHARSET=latin1;				-- Latin1 -> germanLatin

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `klassenstufen`
--

CREATE TABLE `klassenstufen` (
  `id` int(11) NOT NULL,
  `nummer` int(11) NOT NULL,
  `disziplin1` int(11) NOT NULL,
  `disziplin2` int(11) NOT NULL,
  `disziplin3` int(11) NOT NULL,
  `disziplin4` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `noten`
--

CREATE TABLE `noten` (
  `id` int(11) NOT NULL,
  `schueler_id` text NOT NULL,						-- Text? -> id(int(11))
  `gesamtpunkte` text NOT NULL,						-- Text? -> Float(10)
  `note` text NOT NULL								-- Length?
) ENGINE=InnoDB DEFAULT CHARSET=latin1;				-- Latin1 -> germanLatin

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `schueler`
--

CREATE TABLE `schueler` (
  `id` int(11) NOT NULL,
  `vname` text NOT NULL,							-- Length
  `nname` text NOT NULL,							-- Length
  `gebdatum` text NOT NULL,							-- Text? -> Date
  `klasse_id` int(11) NOT NULL,
  `geschlecht` text NOT NULL,						-- Text? -> char/varchar(1)
  `anwesend` text NOT NULL,							-- Text? -> BOOLEAN/int(1)
  `klassenplus` text NOT NULL						-- ???
) ENGINE=InnoDB DEFAULT CHARSET=latin1;				-- Latin1 -> germanLatin

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `werte`
--

CREATE TABLE `werte` (
  `id` int(11) NOT NULL,
  `schueler_id` int(11) NOT NULL,					-- Verknüpfung?
  `disziplin_id` int(11) NOT NULL,					-- Verknüpfung?
  `wert` float(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;				-- Latin1 -> germanLatin

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `wertung`
--

CREATE TABLE `wertung` (							-- Name?
  `id` int(11) NOT NULL,
  `geschlecht` varchar(1) NOT NULL, 
  `klassenstufen_id` int(11) NOT NULL,
  `valuetable` text NOT NULL						-- Table??
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--------------------------------------------------- -- wirklich nötig?

--
-- Indizes für die Tabelle `disziplin`
--
ALTER TABLE `disziplin`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `klasse`
--
ALTER TABLE `klasse`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `klassenstufen`
--
ALTER TABLE `klassenstufen`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `noten`
--
ALTER TABLE `noten`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `schueler`
--
ALTER TABLE `schueler`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `werte`
--
ALTER TABLE `werte`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `wertung`
--
ALTER TABLE `wertung`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `disziplin`
--
ALTER TABLE `disziplin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `klasse`
--
ALTER TABLE `klasse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `klassenstufen`
--
ALTER TABLE `klassenstufen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `noten`
--
ALTER TABLE `noten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `schueler`
--
ALTER TABLE `schueler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `werte`
--
ALTER TABLE `werte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `wertung`
--
ALTER TABLE `wertung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
