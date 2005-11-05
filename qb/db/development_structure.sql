CREATE TABLE `authors` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `ip` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) TYPE=MyISAM;

CREATE TABLE `versions` (
  `id` int(11) NOT NULL auto_increment,
  `page_id` int(11) default NULL,
  `author_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `body` text,
  PRIMARY KEY  (`id`)
) TYPE=InnoDB;

INSERT INTO schema_info (version) VALUES (8)