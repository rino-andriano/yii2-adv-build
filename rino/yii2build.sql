-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              5.5.41-0ubuntu0.14.04.1 - (Ubuntu)
-- S.O. server:                  debian-linux-gnu
-- HeidiSQL Versione:            9.1.0.4867
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dump della struttura del database yii2build
CREATE DATABASE IF NOT EXISTS `yii2build` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `yii2build`;


-- Dump della struttura di tabella yii2build.gender
CREATE TABLE IF NOT EXISTS `gender` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `gender_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella yii2build.gender: ~2 rows (circa)
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` (`id`, `gender_name`) VALUES
	(1, 'male'),
	(2, 'female');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;


-- Dump della struttura di tabella yii2build.profile
CREATE TABLE IF NOT EXISTS `profile` (
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
  KEY `FK_profile_user` (`user_id`),
  CONSTRAINT `FK_profile_gender` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`),
  CONSTRAINT `FK_profile_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella yii2build.profile: ~0 rows (circa)
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;


-- Dump della struttura di tabella yii2build.role
CREATE TABLE IF NOT EXISTS `role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) NOT NULL,
  `role_value` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella yii2build.role: ~2 rows (circa)
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `role_name`, `role_value`) VALUES
	(1, 'User', 10),
	(2, 'Admin', 20);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


-- Dump della struttura di tabella yii2build.status
CREATE TABLE IF NOT EXISTS `status` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) NOT NULL,
  `status_value` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella yii2build.status: ~2 rows (circa)
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` (`id`, `status_name`, `status_value`) VALUES
	(1, 'Active', 10),
	(2, 'Pending', 5);
/*!40000 ALTER TABLE `status` ENABLE KEYS */;


-- Dump della struttura di tabella yii2build.user
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
  KEY `FK_user_user_type` (`user_type_id`),
  CONSTRAINT `FK_user_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `FK_user_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `FK_user_user_type` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dump dei dati della tabella yii2build.user: ~0 rows (circa)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- Dump della struttura di tabella yii2build.user_type
CREATE TABLE IF NOT EXISTS `user_type` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `user_type_name` varchar(45) NOT NULL,
  `user_type_value` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella yii2build.user_type: ~2 rows (circa)
/*!40000 ALTER TABLE `user_type` DISABLE KEYS */;
INSERT INTO `user_type` (`id`, `user_type_name`, `user_type_value`) VALUES
	(1, 'Free', 10),
	(2, 'Paid', 30);
/*!40000 ALTER TABLE `user_type` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
