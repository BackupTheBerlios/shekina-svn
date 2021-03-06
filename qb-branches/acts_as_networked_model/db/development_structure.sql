CREATE TABLE `authors` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `ip` varchar(255) character set latin1 default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `linked_pages` (
  `page_id` int(11) NOT NULL default '0',
  `linked_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`page_id`,`linked_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `revisions` (
  `id` int(11) NOT NULL auto_increment,
  `page_id` int(11) default NULL,
  `author_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `body` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO schema_info (version) VALUES (2)