CREATE TABLE `articles` (
  `id` int(11) NOT NULL auto_increment,
  `titolo` varchar(30) NOT NULL default '',
  `testo` text NOT NULL,
  `link` varchar(30) NOT NULL default '',
  `created_at` datetime NOT NULL default '0000-00-00 00:00:00',
  `category_id` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `categories` (
  `id` char(20) NOT NULL default '',
  `descrizione` char(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

