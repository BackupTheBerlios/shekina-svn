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
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `authors`
--

INSERT INTO `authors` VALUES (1,'i2','127.0.0.1');
INSERT INTO `authors` VALUES (2,'io',NULL);
INSERT INTO `authors` VALUES (3,'Anonymous Coward','127.0.0.1');
INSERT INTO `authors` VALUES (4,'has','127.0.0.1');
INSERT INTO `authors` VALUES (5,'Me','127.0.0.1');

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` VALUES (1,'Home Page','2005-10-31 11:30:15','2005-11-01 22:55:05');
INSERT INTO `pages` VALUES (2,'CiaoMiao','2005-10-31 11:32:18','2005-11-03 19:54:07');
INSERT INTO `pages` VALUES (4,'clicca qui','2005-11-01 22:32:42','2005-11-03 10:40:57');
INSERT INTO `pages` VALUES (5,'has','2005-11-01 22:34:09','2005-11-01 22:34:51');
INSERT INTO `pages` VALUES (6,'ciao caò','2005-11-01 22:55:13','2005-11-01 22:55:18');
INSERT INTO `pages` VALUES (7,'rerwe','2005-11-01 22:55:36','2005-11-01 22:55:40');
INSERT INTO `pages` VALUES (8,'12','2005-11-01 22:55:46','2005-11-03 00:06:31');
INSERT INTO `pages` VALUES (9,'quest\'altro','2005-11-01 22:56:04','2005-11-01 22:56:31');
INSERT INTO `pages` VALUES (10,'9','2005-11-01 22:56:33','2005-11-01 22:56:36');
INSERT INTO `pages` VALUES (11,'10','2005-11-01 22:56:44','2005-11-01 22:56:49');
INSERT INTO `pages` VALUES (12,'11','2005-11-01 22:56:55','2005-11-01 23:28:01');
INSERT INTO `pages` VALUES (13,'Wiki','2005-11-03 10:16:11','2005-11-03 19:46:45');
INSERT INTO `pages` VALUES (15,'Documentazione','2005-11-03 19:13:32','2005-11-03 19:13:37');
INSERT INTO `pages` VALUES (16,'Progetti','2005-11-03 19:19:56','2005-11-03 19:25:49');
INSERT INTO `pages` VALUES (17,'perché ci piace ruby','2005-11-03 19:43:26','2005-11-03 19:44:37');
INSERT INTO `pages` VALUES (18,'scoiattoli','2005-11-03 19:47:55','2005-11-03 19:48:02');
INSERT INTO `pages` VALUES (19,'alias','2005-11-03 19:54:11','2005-11-03 19:54:31');

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
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

--
-- Dumping data for table `versions`
--

INSERT INTO `versions` VALUES (1,1,1,'2005-10-31 11:30:15','Welcome to i2!');
INSERT INTO `versions` VALUES (2,2,2,'2005-10-31 11:32:18','qcorpo del messaggio [[clicca qui]]');
INSERT INTO `versions` VALUES (3,2,3,'2005-10-31 12:04:06','qcorpo del messaggio [[clicca qui]]\r\n\r\nrevisione 1');
INSERT INTO `versions` VALUES (4,2,3,'2005-10-31 12:04:17','qcorpo del messaggio [[clicca qui]]\r\n\r\nrevisione 2');
INSERT INTO `versions` VALUES (5,2,3,'2005-11-01 22:31:19','qcorpo del messaggio [[clicca qui]]\r\n\r\nrevisione 2\r\nrevisione 3');
INSERT INTO `versions` VALUES (6,2,3,'2005-11-01 22:32:26','qcorpo del messaggio [[clicca qui]]\r\n\r\nre4');
INSERT INTO `versions` VALUES (7,4,3,'2005-11-01 22:32:48','creare pagina ');
INSERT INTO `versions` VALUES (8,4,3,'2005-11-01 22:33:05','creare pagina \r\n\r\nrevisione numero 1');
INSERT INTO `versions` VALUES (9,4,4,'2005-11-01 22:33:43','creare pagina ');
INSERT INTO `versions` VALUES (10,4,4,'2005-11-01 22:33:44','creare pagina ');
INSERT INTO `versions` VALUES (11,5,4,'2005-11-01 22:34:51','io  http://wca.com !http://www.flickr.com/images/home_jellyfish.jpg!');
INSERT INTO `versions` VALUES (12,1,4,'2005-11-01 22:55:05','Welcome to i2!\r\n\r\n\r\n[[ciao caò]]\r\n\r\n chissa se viene pre\r\n questo\r\n\r\n[[12]]\r\n\r\n[[rerwe]]\r\n');
INSERT INTO `versions` VALUES (13,6,4,'2005-11-01 22:55:18','eheh');
INSERT INTO `versions` VALUES (14,7,4,'2005-11-01 22:55:40','eheheh');
INSERT INTO `versions` VALUES (15,8,4,'2005-11-01 22:56:01','QuestoLink ???[[quest\'altro]]');
INSERT INTO `versions` VALUES (16,9,4,'2005-11-01 22:56:08','okok');
INSERT INTO `versions` VALUES (17,9,4,'2005-11-01 22:56:31','okok\r\n\r\n[[9]]\r\n[[10]]\r\n[[11]]');
INSERT INTO `versions` VALUES (18,10,4,'2005-11-01 22:56:36','asfasf');
INSERT INTO `versions` VALUES (19,11,4,'2005-11-01 22:56:49','afsasf');
INSERT INTO `versions` VALUES (20,12,4,'2005-11-01 22:56:58','afasfas');
INSERT INTO `versions` VALUES (21,12,4,'2005-11-01 23:28:01','afasfas\r\nfff');
INSERT INTO `versions` VALUES (23,8,4,'2005-11-02 23:37:08','QuestoLink ???[[quest\'altro]]\r\n\r\n[[un simpatico link]] questa roba*dovrebbe* finire in _homepage_\r\n ma chi lo sa http://ffo.org');
INSERT INTO `versions` VALUES (24,8,4,'2005-11-03 00:06:31','QuestoLink ???[[quest\'altro]]\r\n\r\n[[un simpatico link]] questa roba*dovrebbe* finire in _homepage_ luiuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuugngo \r\n ma chi lo sa http://ffo.org');
INSERT INTO `versions` VALUES (25,13,4,'2005-11-03 10:16:26','Questa è la prima pagina del wiki bla bla bla ');
INSERT INTO `versions` VALUES (26,4,4,'2005-11-03 10:20:24','creare pagina si si è da sistemare');
INSERT INTO `versions` VALUES (27,4,4,'2005-11-03 10:40:57','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin in sapien non velit imperdiet porttitor. Nullam cursus lacus vitae sem. Cras at felis ac elit molestie rhoncus. Etiam nisi. Mauris malesuada. Nullam egestas, ipsum nec blandit sollicitudin, elit sapien faucibus velit, eu dictum orci nulla nec sem. Cras vehicula sapien quis nulla. Nam consequat diam nec leo. Pellentesque luctus consectetuer felis. Etiam metus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\r\n\r\nMaecenas porttitor ipsum eu dui. Nam sed dolor. Integer tristique. Vestibulum varius tincidunt massa. Nam purus odio, vestibulum eu, egestas tincidunt, fringilla nec, leo. Proin vitae erat ac nulla elementum hendrerit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Fusce lacus neque, scelerisque non, cursus sit amet, dictum et, lacus. Sed rhoncus elit a enim. Vivamus luctus enim vel enim. Aenean sem dui, congue a, suscipit quis, faucibus eget, enim. Phasellus leo ante, vulputate vitae, luctus vel, tincidunt non, justo. Quisque laoreet. ');
INSERT INTO `versions` VALUES (28,15,4,'2005-11-03 19:13:37','helo');
INSERT INTO `versions` VALUES (29,16,4,'2005-11-03 19:25:49','figo figo ');
INSERT INTO `versions` VALUES (30,17,5,'2005-11-03 19:44:37',' MITICO FUNZIONA UTF-8 NEI TITOLI\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Quisque ac purus sed nulla cursus facilisis. Morbi a nisl id lacus fringilla elementum. Praesent faucibus adipiscing massa. Fusce sit amet nisi ut risus dictum egestas. Vivamus at velit eget pede laoreet viverra. Sed ornare leo et turpis. Sed convallis nisi ut lorem. Sed libero mi, ultricies in, euismod eu, sollicitudin id, libero. Sed commodo, purus at congue fermentum, tellus leo pharetra nisi, at tincidunt quam felis in nibh. Quisque porta scelerisque odio.\r\n\r\nLorem ipsum dolor sit amet, consectetuer adipiscing elit. Nullam elit magna, vehicula at, aliquam nec, convallis eu, est. Phasellus nonummy, nisl vitae congue tempus, nisi pede feugiat justo, id volutpat lacus risus ac tellus. Ut felis. Ut non nisl nec nulla rhoncus adipiscing. Curabitur commodo. In a enim vitae nunc cursus porta. Maecenas consequat libero eu turpis. Sed arcu est, consectetuer nec, rutrum sit amet, porta ut, nulla. Aliquam enim ipsum, interdum quis, convallis et, elementum a, ante. In a purus. Praesent a nunc. Nulla facilisi. In gravida accumsan diam. Duis faucibus, pede at ultricies feugiat, lectus nulla mattis lacus, sit amet aliquam sapien orci sed leo. Aenean sed risus. Nunc et libero. Suspendisse ac magna.\r\n\r\nCurabitur magna. Phasellus lectus. Ut molestie euismod odio. Donec lobortis dui nec odio. Curabitur vehicula consequat metus. Sed quis ante id justo vulputate lacinia. Duis arcu. Nam ipsum lorem, pharetra eu, tincidunt in, commodo non, sapien. Curabitur vulputate fermentum velit. Cras vitae nulla. Mauris commodo, diam ut tincidunt vehicula, risus magna placerat ligula, vel lobortis lacus ante quis tortor. Suspendisse potenti. Aliquam dapibus varius nulla. Praesent malesuada mi et mauris. Praesent dui. Maecenas porttitor condimentum arcu. Vivamus rhoncus imperdiet urna.\r\n\r\nIn enim massa, adipiscing eget, vulputate at, porta quis, magna. Cras eu nulla gravida tortor sagittis bibendum. In malesuada ornare ipsum. Phasellus auctor dignissim velit. Vestibulum rutrum. Praesent pulvinar, augue sit amet tempor porta, magna justo molestie lectus, vel dignissim leo erat ut turpis. Maecenas mattis vehicula pede. Ut tellus sem, rutrum sit amet, aliquet faucibus, ultricies non, ipsum. In pellentesque, lectus at tempor blandit, dui pede pulvinar mauris, id aliquet nunc eros vel lacus. Vestibulum at elit. Ut vulputate auctor neque. Praesent urna odio, tristique id, blandit sit amet, gravida non, nunc. In nec purus. Pellentesque varius semper lorem. Nunc massa tellus, volutpat consectetuer, tincidunt id, cursus sed, leo. Nulla non elit non nunc venenatis dignissim. Sed dolor. Mauris pretium, quam vitae rhoncus porta, lacus sapien mollis arcu, sed condimentum nisl odio in turpis. ');
INSERT INTO `versions` VALUES (31,13,5,'2005-11-03 19:46:45','Questa è la prima pagina del wiki \r\n\r\nclicca su Recently revised per vedere le ultime pagine modificate ');
INSERT INTO `versions` VALUES (32,18,5,'2005-11-03 19:48:02','!http://web.tiscali.it/mephisto2000/scoiattoli.jpg!');
INSERT INTO `versions` VALUES (33,2,5,'2005-11-03 19:54:07','qcorpo del messaggio [[clicca qui]]\r\n\r\n[[alias | lungo lung lungo titolo]]');
INSERT INTO `versions` VALUES (34,19,5,'2005-11-03 19:54:31','funziona no anche gli alias ');

