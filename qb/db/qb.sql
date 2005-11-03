-- MySQL dump 9.11
--
-- Host: localhost    Database: qb_development
-- ------------------------------------------------------
-- Server version	4.0.24_Debian-10ubuntu2-log

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `ip` varchar(255) default NULL,
  `book_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` VALUES (1,'i2','127.0.0.1',1);
INSERT INTO `authors` VALUES (2,'io',NULL,NULL);
INSERT INTO `authors` VALUES (3,'Anonymous Coward','127.0.0.1',1);
INSERT INTO `authors` VALUES (4,'has','127.0.0.1',NULL);

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `book_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` VALUES (1,'Home Page',1,'2005-10-31 11:30:15','2005-11-01 22:55:05');
INSERT INTO `pages` VALUES (2,'CiaoMiao',1,'2005-10-31 11:32:18','2005-11-01 22:32:26');
INSERT INTO `pages` VALUES (4,'clicca qui',NULL,'2005-11-01 22:32:42','2005-11-03 10:20:24');
INSERT INTO `pages` VALUES (5,'has',NULL,'2005-11-01 22:34:09','2005-11-01 22:34:51');
INSERT INTO `pages` VALUES (6,'ciao caò',NULL,'2005-11-01 22:55:13','2005-11-01 22:55:18');
INSERT INTO `pages` VALUES (7,'rerwe',NULL,'2005-11-01 22:55:36','2005-11-01 22:55:40');
INSERT INTO `pages` VALUES (8,'12',NULL,'2005-11-01 22:55:46','2005-11-03 00:06:31');
INSERT INTO `pages` VALUES (9,'quest\'altro',NULL,'2005-11-01 22:56:04','2005-11-01 22:56:31');
INSERT INTO `pages` VALUES (10,'9',NULL,'2005-11-01 22:56:33','2005-11-01 22:56:36');
INSERT INTO `pages` VALUES (11,'10',NULL,'2005-11-01 22:56:44','2005-11-01 22:56:49');
INSERT INTO `pages` VALUES (12,'11',NULL,'2005-11-01 22:56:55','2005-11-01 23:28:01');
INSERT INTO `pages` VALUES (13,'Wiki',NULL,'2005-11-03 10:16:11','2005-11-03 10:16:26');

--
-- Table structure for table `schema_info`
--

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) TYPE=MyISAM;

--
-- Dumping data for table `schema_info`
--

INSERT INTO `schema_info` VALUES (8);

--
-- Table structure for table `versions`
--

CREATE TABLE `versions` (
  `id` int(11) NOT NULL auto_increment,
  `page_id` int(11) default NULL,
  `author_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `body` text,
  `book_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `versions`
--

INSERT INTO `versions` VALUES (1,1,1,'2005-10-31 11:30:15','Welcome to i2!',1);
INSERT INTO `versions` VALUES (2,2,2,'2005-10-31 11:32:18','qcorpo del messaggio [[clicca qui]]',1);
INSERT INTO `versions` VALUES (3,2,3,'2005-10-31 12:04:06','qcorpo del messaggio [[clicca qui]]\r\n\r\nrevisione 1',1);
INSERT INTO `versions` VALUES (4,2,3,'2005-10-31 12:04:17','qcorpo del messaggio [[clicca qui]]\r\n\r\nrevisione 2',1);
INSERT INTO `versions` VALUES (5,2,3,'2005-11-01 22:31:19','qcorpo del messaggio [[clicca qui]]\r\n\r\nrevisione 2\r\nrevisione 3',NULL);
INSERT INTO `versions` VALUES (6,2,3,'2005-11-01 22:32:26','qcorpo del messaggio [[clicca qui]]\r\n\r\nre4',NULL);
INSERT INTO `versions` VALUES (7,4,3,'2005-11-01 22:32:48','creare pagina ',NULL);
INSERT INTO `versions` VALUES (8,4,3,'2005-11-01 22:33:05','creare pagina \r\n\r\nrevisione numero 1',NULL);
INSERT INTO `versions` VALUES (9,4,4,'2005-11-01 22:33:43','creare pagina ',NULL);
INSERT INTO `versions` VALUES (10,4,4,'2005-11-01 22:33:44','creare pagina ',NULL);
INSERT INTO `versions` VALUES (11,5,4,'2005-11-01 22:34:51','io  http://wca.com !http://www.flickr.com/images/home_jellyfish.jpg!',NULL);
INSERT INTO `versions` VALUES (12,1,4,'2005-11-01 22:55:05','Welcome to i2!\r\n\r\n\r\n[[ciao caò]]\r\n\r\n chissa se viene pre\r\n questo\r\n\r\n[[12]]\r\n\r\n[[rerwe]]\r\n',NULL);
INSERT INTO `versions` VALUES (13,6,4,'2005-11-01 22:55:18','eheh',NULL);
INSERT INTO `versions` VALUES (14,7,4,'2005-11-01 22:55:40','eheheh',NULL);
INSERT INTO `versions` VALUES (15,8,4,'2005-11-01 22:56:01','QuestoLink ???[[quest\'altro]]',NULL);
INSERT INTO `versions` VALUES (16,9,4,'2005-11-01 22:56:08','okok',NULL);
INSERT INTO `versions` VALUES (17,9,4,'2005-11-01 22:56:31','okok\r\n\r\n[[9]]\r\n[[10]]\r\n[[11]]',NULL);
INSERT INTO `versions` VALUES (18,10,4,'2005-11-01 22:56:36','asfasf',NULL);
INSERT INTO `versions` VALUES (19,11,4,'2005-11-01 22:56:49','afsasf',NULL);
INSERT INTO `versions` VALUES (20,12,4,'2005-11-01 22:56:58','afasfas',NULL);
INSERT INTO `versions` VALUES (21,12,4,'2005-11-01 23:28:01','afasfas\r\nfff',NULL);
INSERT INTO `versions` VALUES (23,8,4,'2005-11-02 23:37:08','QuestoLink ???[[quest\'altro]]\r\n\r\n[[un simpatico link]] questa roba*dovrebbe* finire in _homepage_\r\n ma chi lo sa http://ffo.org',NULL);
INSERT INTO `versions` VALUES (24,8,4,'2005-11-03 00:06:31','QuestoLink ???[[quest\'altro]]\r\n\r\n[[un simpatico link]] questa roba*dovrebbe* finire in _homepage_ luiuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuugngo \r\n ma chi lo sa http://ffo.org',NULL);
INSERT INTO `versions` VALUES (25,13,4,'2005-11-03 10:16:26','Questa è la prima pagina del wiki bla bla bla ',NULL);
INSERT INTO `versions` VALUES (26,4,4,'2005-11-03 10:20:24','creare pagina si si è da sistemare',NULL);

