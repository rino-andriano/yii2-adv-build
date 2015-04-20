-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: Apr 20, 2015 alle 21:17
-- Versione del server: 5.5.41-0ubuntu0.14.04.1
-- Versione PHP: 5.5.9-1ubuntu4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `yii2build`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `gender`
--

CREATE TABLE IF NOT EXISTS `gender` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `gender_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `gender`
--

INSERT INTO `gender` (`id`, `gender_name`) VALUES
(1, 'male'),
(2, 'female');

-- --------------------------------------------------------

--
-- Struttura della tabella `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role_id` smallint(6) unsigned NOT NULL DEFAULT '10',
  `status_id` smallint(6) unsigned NOT NULL DEFAULT '10',
  `user_type_id` smallint(6) unsigned NOT NULL DEFAULT '10',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_role` (`role_id`),
  KEY `FK_user_status` (`status_id`),
  KEY `FK_user_user_type` (`user_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `user`
--

INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `role_id`, `status_id`, `user_type_id`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'ZORTRlBS-8m2bJD3c0XGze3QVrLIap7p', '$2y$13$ppMews.a/wJPokGvOiSh/OFRpqCYxxyn6HRs2VSWu3f3t59vMZ3vK', NULL, 'admin@localhost.com', 2, 1, 1, '2015-04-20 21:10:46', '2015-04-20 21:10:46'),
(2, 'user', 'wQgQ_ND3k_TaExqnkSHAXwzIBCx4ZVlA', '$2y$13$LpEpQlIcHygviM861ZJpkOixenQLkOnIMuf3yuLqfDRXeh6iASmXO', NULL, 'user@localhost.com', 1, 1, 1, '2015-04-20 21:12:05', '2015-04-20 21:12:05'),
(3, 'superuser', 'BU8A0hDt6BQM1Q5smqOvKmZSAWxy3MG0', '$2y$13$FaSBGLh3eCdY4F8gUQc3Wut3cuXY.s5ZewAqxlXEhEtukFpvw87lS', NULL, 'superuser@localhost.it', 3, 1, 1, '2015-04-20 21:16:19', '2015-04-20 21:16:19');

-- --------------------------------------------------------

--
-- Struttura della tabella `user_profile`
--

CREATE TABLE IF NOT EXISTS `user_profile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `first_name` varchar(60) DEFAULT NULL,
  `last_name` varchar(60) DEFAULT NULL,
  `birthdate` date NOT NULL,
  `gender_id` smallint(5) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_profile_gender` (`gender_id`),
  KEY `FK_profile_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struttura della tabella `user_role`
--

CREATE TABLE IF NOT EXISTS `user_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) NOT NULL,
  `role_value` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dump dei dati per la tabella `user_role`
--

INSERT INTO `user_role` (`id`, `role_name`, `role_value`) VALUES
(1, 'User', 10),
(2, 'Admin', 20),
(3, 'SuperUser', 30);

-- --------------------------------------------------------

--
-- Struttura della tabella `user_status`
--

CREATE TABLE IF NOT EXISTS `user_status` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) NOT NULL,
  `status_value` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `user_status`
--

INSERT INTO `user_status` (`id`, `status_name`, `status_value`) VALUES
(1, 'Active', 10),
(2, 'Pending', 5);

-- --------------------------------------------------------

--
-- Struttura della tabella `user_type`
--

CREATE TABLE IF NOT EXISTS `user_type` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `user_type_name` varchar(45) NOT NULL,
  `user_type_value` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dump dei dati per la tabella `user_type`
--

INSERT INTO `user_type` (`id`, `user_type_name`, `user_type_value`) VALUES
(1, 'Free', 10),
(2, 'Paid', 30);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_user_role` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`),
  ADD CONSTRAINT `FK_user_status` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`),
  ADD CONSTRAINT `FK_user_user_type` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`);

--
-- Limiti per la tabella `user_profile`
--
ALTER TABLE `user_profile`
  ADD CONSTRAINT `FK_profile_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`),
  ADD CONSTRAINT `FK_profile_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
