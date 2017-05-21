CREATE TABLE IF NOT EXISTS `base_geo_type` (
  `id` int(3) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
ALTER TABLE `base_geo_type`
 ADD PRIMARY KEY (`id`);
<next>
INSERT INTO `base_geo_type` (`id`, `name`) VALUES
(1, 'Cable/DSL'),
(2, 'Cellular'),
(3, 'Corporate'),
(4, 'Dialup'),
(5, 'Network Security'),
(0, 'Unknown');