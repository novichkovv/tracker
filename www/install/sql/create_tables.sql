CREATE TABLE IF NOT EXISTS `offer_note` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `offer_id` int(12) NOT NULL DEFAULT '0',
  `text` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  INDEX offer_note_offer_id (`offer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `landing_note` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `landing_id` int(12) NOT NULL DEFAULT '0',
  `text` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  INDEX landing_note_landing_id (`landing_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `temp_update_costs` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_id` bigint(12) NOT NULL DEFAULT 0,
  `cpc` decimal(14,5) NOT NULL DEFAULT '0.000',
  `status` int(11) NOT NULL DEFAULT 0,
  `number` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 MAX_ROWS=10000000;
<next>
CREATE TABLE IF NOT EXISTS `clicks_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uclick` int(11) NOT NULL DEFAULT 0,
  `click` int(11) NOT NULL DEFAULT 0,
  `camp` int(11) NOT NULL DEFAULT 0,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `el_id` int(11) NOT NULL DEFAULT 0,
  `path` int(11) NOT NULL DEFAULT 0,
  `rule_id` INT(11) NOT NULL DEFAULT 0,
  `path_com` int(11) NOT NULL DEFAULT 0,
  `lp_id` int(11) NOT NULL DEFAULT 0,
  `cnv` int(11) NOT NULL DEFAULT 0,
  `of_cl` int(11) NOT NULL DEFAULT 0,
  `time_cl` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX clicks_info_uclick (`uclick`),
  INDEX clicks_info_time_cl (`time_cl`),
  INDEX clicks_info_click (`click`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 MAX_ROWS=10000000;
<next>
CREATE TABLE IF NOT EXISTS `ts_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL DEFAULT '',
  `postback_url` varchar(512) NOT NULL DEFAULT '',
  `tokens` tinyint(1) NOT NULL DEFAULT 0,
  `e_name` varchar(64) NOT NULL DEFAULT '',
  `e_value` varchar(64) NOT NULL DEFAULT '',
  `c_value` varchar(64) NOT NULL DEFAULT '',
  `c_name` varchar(64) NOT NULL DEFAULT '',
  `tokens_list` TEXT NULL,
  `description` TEXT NULL,
  `int1` int(11) NOT NULL DEFAULT 0,
  `int2` int(11) NOT NULL DEFAULT 0,
  `ads_format` varchar(512) NOT NULL DEFAULT '',
  `traffic_type` varchar(256) NOT NULL DEFAULT '',
  `self_serve` tinyint(1) NOT NULL DEFAULT 0,
  `geo` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 MAX_ROWS=10000000;
<next>
CREATE TABLE IF NOT EXISTS `domains` (
  id int(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(256) NULL,
  `default` TINYINT(1) DEFAULT 0,
  `status` TINYINT(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `base_browser` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `browser` varchar(128) NOT NULL DEFAULT 'Unknown',
  `browser_version` varchar(64) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`id`),
  KEY `browser` (`browser`),
  KEY `browser_version` (`browser_version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_device_brand` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_device_lang` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(7) NOT NULL  DEFAULT 'Unknown',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_device_model` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `model` varchar(128) NOT NULL DEFAULT 'Unknown',
  `name` varchar(128) NOT NULL DEFAULT 'Unknown',
  `model_dop_info` varchar(128) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_device_technical_data_1` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `display_size` varchar(16) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_device_technical_data_2` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `resolution` varchar(12) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_device_technical_data_3` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `pointing_method` varchar(32) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_device_technical_data_4` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `max_speed` int(12) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `base_os` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT 'Unknown',
  `os` varchar(128) NOT NULL DEFAULT 'Unknown',
  `version` varchar(128) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `os` (`os`),
  KEY `version` (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `campaigns` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(22) NOT NULL DEFAULT 0,
  `name` varchar(256) NOT NULL DEFAULT 0,
  `domain` INT(4) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `red_type` tinyint(1) NOT NULL DEFAULT '1',
  `group_id` int(12) NOT NULL DEFAULT '0',
  `sources_id` int(12) NOT NULL DEFAULT '0',
  `start_camp` int(10) NOT NULL DEFAULT 0,
  `cpc` decimal(9,5) NOT NULL DEFAULT 0,
  `is_cpm` TINYINT(1) NOT NULL DEFAULT 0,
  `auto_cpc` TINYINT( 1 ) NOT NULL DEFAULT  '0',
  `date_cr` int(10) NOT NULL DEFAULT 0,
  `detect_geo` tinyint(1) NOT NULL DEFAULT '1',
  `detect_device` tinyint(1) NOT NULL DEFAULT '1',
  `postback_url` VARCHAR(1024) NULL DEFAULT NULL,
  `land_tokens` TEXT NOT NULL DEFAULT "",
  `camp_tokens` TEXT NOT NULL DEFAULT "",
  `postback_using` TINYINT(1) NULL DEFAULT '0',
  `smart_rotation` TINYINT(1) NOT NULL DEFAULT 0,
  `losses` INT NOT NULL DEFAULT 0,
  `var_1` varchar(1024) NULL,
  `var_2` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `status` (`status`),
  KEY `date_cr` (`date_cr`),
  KEY `start_camp` (`start_camp`),
  KEY `FK_campaigns_groups` (`group_id`),
  KEY `FK_campaigns_traffic_sources` (`sources_id`),
  KEY `red_type` (`red_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `camp_note` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `camp_id` int(12) NOT NULL DEFAULT 0,
  `text` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_camp_note_campaigns` (`camp_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `clicks` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_time` int(10) NOT NULL DEFAULT 0,
  `camp_id` int(12) NOT NULL DEFAULT '0',
  `offer` int(12) NOT NULL DEFAULT '0',
  `path_id` int(12) NOT NULL DEFAULT '0',
  `landing_page` int(12) NOT NULL DEFAULT '0',
  `cvr_id` int(12) NOT NULL DEFAULT '0',
  `ts_id` int(12) NOT NULL DEFAULT '0',
  `rule_id` int(12) NOT NULL DEFAULT '0',
  `offer_click` tinyint(1) NOT NULL DEFAULT '0',
  `offer_type` tinyint(1) NOT NULL DEFAULT '3',
  `an` int(12) NOT NULL DEFAULT '0',
  `pay` decimal(7,3) NOT NULL DEFAULT 0,
  `cpc` decimal(9,5) NOT NULL DEFAULT 0,
  `geo` int(6) NOT NULL DEFAULT 0,
  `ua` int(12) NOT NULL DEFAULT 0,
  `ip` bigint(13) NOT NULL DEFAULT 0,
  `publisher` int(12) NOT NULL DEFAULT '0',
  `referer_domain` int(12) NOT NULL DEFAULT 0,
  `bidhash` varchar(512) NOT NULL DEFAULT 0,
  `is_bot` tinyint(1) NOT NULL DEFAULT '0',
  `token` tinyint(1) NOT NULL DEFAULT 0,
  `dop_int` int(16) NOT NULL DEFAULT 0,
  `dop_int_2` int(16) NOT NULL DEFAULT 0,
  `dop_int_3` int(16) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `click_time` (`click_time`),
  KEY `FK_clicks_campaigns` (`camp_id`),
  KEY `FK_clicks_offers` (`offer`),
  KEY `FK_clicks_landing_pages` (`landing_page`),
  KEY `FK_clicks_conversion` (`cvr_id`),
  KEY `geo` (`geo`),
  KEY `offer_click` (`offer_click`),
  KEY `FK_clicks_traffic_sources` (`ts_id`),
  KEY `FK_clicks_paths` (`path_id`),
  KEY `FK_clicks_rule` (`rule_id`),
  KEY `an` (`an`),
  KEY `offer_type` (`offer_type`),
  KEY `ip` (`ip`),
  KEY `click_time_2` (`click_time`),
  KEY `publisher` (`publisher`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `clicks_referer_url` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_id` int(12) DEFAULT NULL,
  `url` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  INDEX clicks_referer_url_click_id (`click_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `clicks_tokens` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_id` int(12) DEFAULT NULL,
  `t1` int(12) NOT NULL DEFAULT 0,
  `t2` int(12) NOT NULL DEFAULT 0,
  `t3` int(12) NOT NULL DEFAULT 0,
  `t4` int(12) NOT NULL DEFAULT 0,
  `t5` int(12) NOT NULL DEFAULT 0,
  `t6` int(12) NOT NULL DEFAULT 0,
  `t7` int(12) NOT NULL DEFAULT 0,
  `t8` int(12) NOT NULL DEFAULT 0,
  `t9` int(12) NOT NULL DEFAULT 0,
  `t10` int(12) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `click_id` (`click_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `conversion` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `camp_id` int(12) NOT NULL DEFAULT 0,
  `offer` int(12) NOT NULL DEFAULT 0,
  `offer_type` int(1) NOT NULL DEFAULT '3',
  `lp` int(12) NOT NULL DEFAULT 0,
  `pay` decimal(7,3) NOT NULL DEFAULT 0,
  `time` int(24) NOT NULL DEFAULT 0,
  `ts` tinyint(12) NOT NULL DEFAULT '0',
  `an` tinyint(12) NOT NULL DEFAULT '0',
  `geo` INT(6) NOT NULL DEFAULT '0',
  `click_id` INT(12) NOT NULL DEFAULT '0',
  `click_time` INT(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `time` (`time`),
  KEY `FK_conversion_campaigns` (`camp_id`),
  KEY `FK_conversion_offers` (`offer`),
  KEY `FK_conversion_landing_pages` (`lp`),
  KEY `ts` (`ts`),
  KEY `an` (`an`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `err_log` (
  id INT(11) NOT NULL AUTO_INCREMENT,
  `type` TINYINT(1) DEFAULT 0,
  `info` VARCHAR(64) DEFAULT 0,
  `date` INT(12) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MYISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL DEFAULT 0,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;
<next>
CREATE TABLE IF NOT EXISTS `landing_pages` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `type` TINYINT(1) NOT NULL DEFAULT 1,
  `status` int(1) NOT NULL DEFAULT '1',
  `offers` INT(3) NOT NULL DEFAULT '1',
  `name` varchar(256) NOT NULL DEFAULT '',
  `url` varchar(512) NOT NULL DEFAULT '',
  `group_lp` int(12) DEFAULT NULL DEFAULT 0,
  `lang` varchar(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `FK_landing_pages_groups` (`group_lp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `networks` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `status` int(1) NOT NULL DEFAULT '1',
  `name` varchar(256) NOT NULL DEFAULT '',
  `postback_url` varchar(512) NOT NULL DEFAULT '',
  options_using TINYINT(1) NULL DEFAULT 0,
  options TEXT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `report_drilldown` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
 `type` int(11) NOT NULL,
 `name` varchar(512) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 
<next>
CREATE TABLE IF NOT EXISTS `offers` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL DEFAULT '',
  `url` varchar(512) NOT NULL DEFAULT '',
  `network` int(12) NOT NULL DEFAULT 0,
  `payout` decimal(9,5) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `geo` varchar(2) NOT NULL DEFAULT '',
  `group_of` int(12) NOT NULL DEFAULT 0,
  `auto_payout` tinyint(1) NOT NULL DEFAULT '0',
  `cap` tinyint(3) NOT NULL DEFAULT '0',
  `upsell` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `FK_offers_networks` (`network`),
  KEY `FK_offers_groups` (`group_of`),
  KEY `auto_payout` (`auto_payout`),
  KEY `cap` (`cap`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `paths` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `camp_id` int(11) NOT NULL DEFAULT 0,
  `split` int(6) NOT NULL DEFAULT 0,
  `rule_id` int(11) NOT NULL DEFAULT 0,
  `is_rule` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_paths_campaigns` (`camp_id`),
  KEY `status` (`status`),
  KEY `split` (`split`),
  KEY `is_rule` (`is_rule`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `path_com` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `path_id` int(12) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `id_t` varchar(128) NOT NULL DEFAULT 0,
  `type` tinyint(1) NOT NULL DEFAULT '2',
  `split` int(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id_t` (`id_t`),
  KEY `type` (`type`),
  KEY `split` (`split`),
  KEY `FK_path_com_paths` (`path_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `proc_1` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `start_date` int(10) NOT NULL DEFAULT 0,
  `end_date` int(10) NOT NULL DEFAULT 0,
  `dop_info` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `proc_2` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `start_date` int(10) NOT NULL DEFAULT 0,
  `end_date` int(10) NOT NULL DEFAULT 0,
  `dop_info` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `proc_3` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `start_date` int(10) NOT NULL DEFAULT 0,
  `end_date` int(10) NOT NULL DEFAULT 0,
  `dop_info` varchar(80) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `proc_4` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date` int(16) NOT NULL DEFAULT 0,
  `end_date` int(16) NOT NULL DEFAULT 0,
  `dop_info` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `proc_5` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_date` int(16) NOT NULL DEFAULT 0,
  `end_date` int(16) NOT NULL DEFAULT 0,
  `dop_info` int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `referer_value` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `val` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `columns_settings` (
  id int(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `page` VARCHAR(32) NOT NULL,
  `column` VARCHAR(32) NOT NULL,
  status TINYINT(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `clicks_tokens_lp` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_id` int(11) NOT NULL,
  `value_id` int(11) NOT NULL,
  `name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX clicks_tokens_lp_click_id (`click_id`),
  INDEX clicks_tokens_lp_value_id (`value_id`),
  INDEX clicks_tokens_lp_name_id (`name_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `tokens_lp` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `camp_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `token_value_lp` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `val` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX token_value_lp_val (`val`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `rule` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `path_id` int(12) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `camp_id` int(12) NOT NULL DEFAULT 0,
  `name` varchar(256) DEFAULT NULL,
  `number` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_rule_paths` (`path_id`),
  KEY `FK_rule_campaigns` (`camp_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0 ;
<next>
CREATE TABLE IF NOT EXISTS `filters` (
  id int(11) NOT NULL AUTO_INCREMENT,
  status TINYINT(1) DEFAULT 0,
  date_create int(12) DEFAULT 0,
  name VARCHAR(256) NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `filters_com` (
  id int(11) NOT NULL AUTO_INCREMENT,
  fid INT(12) DEFAULT 0,
  group_num TINYINT(1) DEFAULT 1,
  type_1 VARCHAR(32) NULL DEFAULT '1',
  type_2 INT(2) DEFAULT 1,
  val DECIMAL(16,4) DEFAULT 0,
  val_string VARCHAR(256) DEFAULT "",
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `rule_com` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `type` int(6) NOT NULL DEFAULT '0',
  `type2` tinyint(1) NOT NULL DEFAULT '0',
  `type3` TINYINT(1) NOT NULL DEFAULT '0',
  `rule_id` int(9) NOT NULL DEFAULT 0,
  `number` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_rule_com_rule` (`rule_id`),
  KEY `type` (`type`),
  KEY `type2` (`type2`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `rule_criteria` (
  id int(11) NOT NULL AUTO_INCREMENT,
  `rule_com_id` int(9) NOT NULL DEFAULT '0',
  `value` varchar(1024) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY `FK_criteria_rule_com_id` (`rule_com_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS offer_direct_url (
  id INT(11) NOT NULL AUTO_INCREMENT,
  url VARCHAR(512),
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 
<next>
CREATE TABLE IF NOT EXISTS `showcase_campaigns` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `el_id` int(12) NOT NULL DEFAULT 0,
  `date_type` int(2) NOT NULL DEFAULT 0,
  `date_name` int(8) NOT NULL DEFAULT 0,
  `clicks` int(12) NOT NULL DEFAULT 0,
  `clicks_offer` int(12) NOT NULL DEFAULT 0,
  `clicks_landing` int(12) NOT NULL DEFAULT 0,
  `leads` int(12) NOT NULL DEFAULT 0,
  `bots` int(12) NOT NULL DEFAULT 0,
  `spend` decimal(15,5) NOT NULL DEFAULT 0,
  `pay` decimal(15,5) NOT NULL DEFAULT 0,
  `last_click` int(16) NOT NULL DEFAULT 0,
  `camp_id` INT( 12 ) NOT NULL DEFAULT  '0',
  PRIMARY KEY (`id`),
  KEY `el_id_idx1` (`el_id`),
  KEY `clicks_idx1` (`clicks`),
  KEY `clicks_offer_idx1` (`clicks_offer`),
  KEY `clicks_landing_idx1` (`clicks_landing`),
  KEY `leads_idx1` (`leads`),
  KEY `last_click_idx1` (`last_click`),
  KEY `date_type_idx1` (`date_type`),
  KEY `date_name_idx1` (`date_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `showcase_landings` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `el_id` int(12) NOT NULL DEFAULT 0,
  `date_type` int(2) NOT NULL DEFAULT 0,
  `date_name` int(8) NOT NULL DEFAULT 0,
  `clicks` int(12) NOT NULL DEFAULT 0,
  `clicks_offer` int(12) NOT NULL DEFAULT 0,
  `clicks_landing` int(12) NOT NULL DEFAULT 0,
  `leads` int(12) NOT NULL DEFAULT 0,
  `bots` int(12) NOT NULL DEFAULT 0,
  `spend` decimal(15,5) NOT NULL DEFAULT 0,
  `pay` decimal(15,5) NOT NULL DEFAULT 0,
  `last_click` int(16) NOT NULL DEFAULT 0,
  `camp_id` INT( 12 ) NOT NULL DEFAULT  '0',
  PRIMARY KEY (`id`),
  KEY `el_id_idx2` (`el_id`),
  KEY `clicks_idx2` (`clicks`),
  KEY `clicks_offer_idx2` (`clicks_offer`),
  KEY `clicks_landing_idx2` (`clicks_landing`),
  KEY `leads_idx2` (`leads`),
  KEY `last_click_idx2` (`last_click`),
  KEY `date_type_idx2` (`date_type`),
  KEY `date_name_idx2` (`date_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `showcase_networks` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `el_id` int(12) NOT NULL DEFAULT 0,
  `date_type` int(2) NOT NULL DEFAULT 0,
  `date_name` int(8) NOT NULL DEFAULT 0,
  `clicks` int(12) NOT NULL DEFAULT 0,
  `clicks_offer` int(12) NOT NULL DEFAULT 0,
  `clicks_landing` int(12) NOT NULL DEFAULT 0,
  `leads` int(12) NOT NULL DEFAULT 0,
  `bots` int(12) NOT NULL DEFAULT 0,
  `spend` decimal(15,5) NOT NULL DEFAULT 0,
  `pay` decimal(15,5) NOT NULL DEFAULT 0,
  `last_click` int(16) NOT NULL DEFAULT 0,
  `camp_id` INT( 12 ) NOT NULL DEFAULT  '0',
  PRIMARY KEY (`id`),
  KEY `el_id_idx3` (`el_id`),
  KEY `clicks_idx3` (`clicks`),
  KEY `clicks_offer_idx3` (`clicks_offer`),
  KEY `clicks_landing_idx3` (`clicks_landing`),
  KEY `leads_idx3` (`leads`),
  KEY `last_click_idx3` (`last_click`),
  KEY `date_type_idx3` (`date_type`),
  KEY `date_name_idx3` (`date_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `showcase_offers` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `el_id` int(12) NOT NULL DEFAULT 0,
  `date_type` int(2) NOT NULL DEFAULT 0,
  `date_name` int(8) NOT NULL DEFAULT 0,
  `clicks` int(12) NOT NULL DEFAULT 0,
  `clicks_offer` int(12) NOT NULL DEFAULT 0,
  `clicks_landing` int(12) NOT NULL DEFAULT 0,
  `leads` int(12) NOT NULL DEFAULT 0,
  `bots` int(12) NOT NULL DEFAULT 0,
  `spend` decimal(15,5) NOT NULL DEFAULT 0,
  `pay` decimal(15,5) NOT NULL DEFAULT 0,
  `last_click` int(16) NOT NULL DEFAULT 0,
  `camp_id` INT( 12 ) NOT NULL DEFAULT  '0',
  PRIMARY KEY (`id`),
  KEY `el_id_idx4` (`el_id`),
  KEY `clicks_idx4` (`clicks`),
  KEY `clicks_offer_idx4` (`clicks_offer`),
  KEY `clicks_landing_idx4` (`clicks_landing`),
  KEY `leads_idx4` (`leads`),
  KEY `last_click_idx4` (`last_click`),
  KEY `date_type_idx4` (`date_type`),
  KEY `date_name_idx4` (`date_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `showcase_sources` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `el_id` int(12) NOT NULL DEFAULT 0,
  `date_type` int(2) NOT NULL DEFAULT 0,
  `date_name` int(8) NOT NULL DEFAULT 0,
  `clicks` int(12) NOT NULL DEFAULT 0,
  `clicks_offer` int(12) NOT NULL DEFAULT 0,
  `clicks_landing` int(12) NOT NULL DEFAULT 0,
  `leads` int(12) NOT NULL DEFAULT 0,
  `bots` int(12) NOT NULL DEFAULT 0,
  `spend` decimal(15,5) NOT NULL DEFAULT 0,
  `pay` decimal(15,5) NOT NULL DEFAULT 0,
  `last_click` int(16) NOT NULL DEFAULT 0,
  `camp_id` INT( 12 ) NOT NULL DEFAULT  '0',
  PRIMARY KEY (`id`),
  KEY `el_id_idx5` (`el_id`),
  KEY `clicks_idx5` (`clicks`),
  KEY `clicks_offer_idx5` (`clicks_offer`),
  KEY `clicks_landing_idx5` (`clicks_landing`),
  KEY `leads_idx5` (`leads`),
  KEY `last_click_idx5` (`last_click`),
  KEY `date_type_idx5` (`date_type`),
  KEY `date_name_idx5` (`date_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `temp_clicks` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_time` int(10) NOT NULL DEFAULT 0,
  `camp_id` int(12) NOT NULL DEFAULT 0,
  `offer` int(12) NOT NULL DEFAULT 0,
  `path_id` int(12) NOT NULL DEFAULT 0,
  `landing_page` int(12) NOT NULL DEFAULT 0,
  `cvr_id` int(12) NOT NULL DEFAULT 0,
  `ts_id` int(12) NOT NULL DEFAULT 0,
  `rule_id` int(12) NOT NULL DEFAULT 0,
  `offer_click` TINYINT(1) NOT NULL DEFAULT 0,
  `an` int(12) NOT NULL DEFAULT 0,
  `pay` decimal(7,3) NOT NULL DEFAULT 0,
  `cpc` decimal(9,5) NOT NULL DEFAULT 0,
  `geo` int(5) NOT NULL DEFAULT 0,
  `ua` varchar(512) NOT NULL DEFAULT '',
  `ip` varchar(16) NOT NULL DEFAULT '',
  `publisher` int(12) NOT NULL DEFAULT 0,
  `referer_domain` int(12) NOT NULL DEFAULT 0,
  `bidhash` varchar(512) NOT NULL DEFAULT '',
  `offer_type` tinyint(1) NOT NULL DEFAULT 0,
  `is_bot` tinyint(1) NOT NULL DEFAULT '0',
  `token` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `camp_id` (`camp_id`),
  KEY `offer` (`offer`),
  KEY `offer_type` (`offer_type`),
  KEY `geo` (`geo`),
  KEY `an` (`an`),
  KEY `offer_click` (`offer_click`),
  KEY `rule_id` (`rule_id`),
  KEY `ts_id` (`ts_id`),
  KEY `cvr_id` (`cvr_id`),
  KEY `landing_page` (`landing_page`),
  KEY `path_id` (`path_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `conversion_status` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `cnv_id` int(11) NOT NULL,
  `status` varchar(128) NOT NULL,
  `status2` VARCHAR(128) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `temp_table` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_id` bigint(12) NOT NULL DEFAULT 0,
  `offer` INT NOT NULL DEFAULT '0',
  `offer_type` INT NOT NULL DEFAULT '0',
  `cvr_id` int(12) NOT NULL DEFAULT '0',
  `offer_click` tinyint(1) NOT NULL DEFAULT '0',
  `pay` decimal(7,3) NOT NULL DEFAULT '0.000',
  `cpc` decimal(14,5) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 MAX_ROWS=10000000;
<next>
CREATE TABLE IF NOT EXISTS `temp_table_2` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_id` int(12) NOT NULL DEFAULT 0,
  `offer` INT NOT NULL DEFAULT '0',
  `offer_type` INT NOT NULL DEFAULT '0',
  `cvr_id` int(12) NOT NULL DEFAULT '0',
  `offer_click` tinyint(1) NOT NULL DEFAULT '0',
  `pay` decimal(7,3) NOT NULL DEFAULT '0.000',
  `cpc` decimal(14,5) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 MAX_ROWS=10000000;
<next>
CREATE TABLE IF NOT EXISTS `tokens` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(128) NOT NULL DEFAULT '',
  `field` varchar(128) NOT NULL DEFAULT '',
  `val` varchar(128) NOT NULL DEFAULT '',
  `source_id` int(12) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `FK_tokens_traffic_sources` (`source_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `token_value` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `val` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `val` (`val`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 MAX_ROWS=10000000;
<next>
CREATE TABLE IF NOT EXISTS `traffic_sources` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL DEFAULT '',
  `tokens` tinyint(1) NOT NULL DEFAULT '0',
  `postback_url` varchar(512) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `e_name` varchar(64) NOT NULL DEFAULT '',
  `e_value` varchar(64) NOT NULL DEFAULT '',
  `c_name` VARCHAR( 32 ) NOT NULL DEFAULT '',
  `c_value` VARCHAR( 32 ) NOT NULL DEFAULT '',
  `losses` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `tokens` (`tokens`),
  KEY `status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `val` int(11) NOT NULL,
  `default_val` int(11) NOT NULL,
  `val_varchar` varchar(64) NOT NULL,
  `default_val_varchar` varchar(64) NOT NULL,
  `info` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(56) NOT NULL DEFAULT '',
  `password` varchar(256) NOT NULL DEFAULT '',
  `user_group` TINYINT(1) NOT NULL DEFAULT 2,
  `email` varchar(256) NOT NULL DEFAULT '',
  `time_zone` varchar(25) NOT NULL DEFAULT '',
  `temp_key` VARCHAR(64) NOT NULL DEFAULT '',
  `perm_cm` TINYINT(4) NOT NULL DEFAULT 0,
  `perm_of` TINYINT(4) NOT NULL DEFAULT 0,
  `perm_lp` TINYINT(4) NOT NULL DEFAULT 0,
  `perm_ts` TINYINT(4) NOT NULL DEFAULT 0,
  `perm_an` TINYINT(4) NOT NULL DEFAULT 0,
  `perm_pr` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX users_login (`login`)
) ENGINE=INNODB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
<next>
CREATE TABLE IF NOT EXISTS `users_permission` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `el_type` tinyint(3) NOT NULL,
  `el_id` int(11) NOT NULL,
  `el_perm` tinyint(1) NOT NULL,
  `himself` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
<next>
CREATE TABLE IF NOT EXISTS `temp_table_err` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `click_id` int(12) NOT NULL DEFAULT 0,
  `cvr_id` int(12) NOT NULL DEFAULT '0',
  `offer_click` tinyint(1) NOT NULL DEFAULT '0',
  `pay` decimal(7,3) NOT NULL DEFAULT '0.000',
  `cpc` decimal(14,5) NOT NULL DEFAULT '0.000',
  `info` varchar(128) NOT NULL DEFAULT '-',
  PRIMARY KEY (`id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `user_agents` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `user_agent` varchar(512) NOT NULL DEFAULT 'Unknown',
  `device_brand_id` int(12) NOT NULL DEFAULT 0,
  `device_model_id` int(12) NOT NULL DEFAULT 0,
  `device_lang_id` int(12) NOT NULL DEFAULT 0,
  `device_td1_id` int(12) NOT NULL DEFAULT 0,
  `device_td2_id` int(12) NOT NULL DEFAULT 0,
  `device_td3_id` int(12) NOT NULL DEFAULT 0,
  `device_td4_id` int(12) NOT NULL DEFAULT 0,
  `os` int(12) NOT NULL DEFAULT 0,
  `browser` int(12) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_agent` (`user_agent`),
  KEY `os` (`os`),
  KEY `browser` (`browser`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
<next>
CREATE TABLE IF NOT EXISTS `token_tags` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `token_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `camp_id` int(11) NOT NULL,
  `token_num` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
<next>
ALTER TABLE `rule_criteria` ADD FOREIGN KEY (`rule_com_id`) REFERENCES `rule_com`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
<next>
ALTER TABLE `conversion_status` ADD CONSTRAINT `conversion_status_ibfk_1` FOREIGN KEY (`cnv_id`) REFERENCES `conversion` (`id`);
<next>
ALTER TABLE `campaigns`
  ADD CONSTRAINT `FK_campaigns_groups` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  ADD CONSTRAINT `FK_campaigns_traffic_sources` FOREIGN KEY (`sources_id`) REFERENCES `traffic_sources` (`id`);
<next>
ALTER TABLE `camp_note`
  ADD CONSTRAINT `FK_camp_note_campaigns` FOREIGN KEY (`camp_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE;
<next>
ALTER TABLE `clicks`
  ADD CONSTRAINT `FK_clicks_campaigns2` FOREIGN KEY (`camp_id`) REFERENCES `campaigns` (`id`),
  ADD CONSTRAINT `FK_clicks_conversion` FOREIGN KEY (`cvr_id`) REFERENCES `conversion` (`id`),
  ADD CONSTRAINT `FK_clicks_landing_pages2` FOREIGN KEY (`landing_page`) REFERENCES `landing_pages` (`id`),
  ADD CONSTRAINT `FK_clicks_networks2` FOREIGN KEY (`an`) REFERENCES `networks` (`id`),
  ADD CONSTRAINT `FK_clicks_paths2` FOREIGN KEY (`path_id`) REFERENCES `paths` (`id`),
  ADD CONSTRAINT `FK_clicks_rule2` FOREIGN KEY (`rule_id`) REFERENCES `rule` (`id`),
  ADD CONSTRAINT `FK_clicks_traffic_sources2` FOREIGN KEY (`ts_id`) REFERENCES `traffic_sources` (`id`);  
<next>
ALTER TABLE `conversion`
  ADD CONSTRAINT `FK_conversion_campaigns` FOREIGN KEY (`camp_id`) REFERENCES `campaigns` (`id`),
  ADD CONSTRAINT `FK_conversion_landing_pages` FOREIGN KEY (`lp`) REFERENCES `landing_pages` (`id`);  
<next>
ALTER TABLE `landing_pages`
  ADD CONSTRAINT `landing_pages_ibfk_1` FOREIGN KEY (`group_lp`) REFERENCES `groups` (`id`) ON DELETE SET NULL;  
<next>
ALTER TABLE `offers`
  ADD CONSTRAINT `FK_offers_groups` FOREIGN KEY (`group_of`) REFERENCES `groups` (`id`),
  ADD CONSTRAINT `FK_offers_networks` FOREIGN KEY (`network`) REFERENCES `networks` (`id`);  
<next>
ALTER TABLE `paths`
  ADD CONSTRAINT `FK_paths_campaigns` FOREIGN KEY (`camp_id`) REFERENCES `campaigns` (`id`); 
<next> 
ALTER TABLE `path_com`
  ADD CONSTRAINT `FK_path_com_paths` FOREIGN KEY (`path_id`) REFERENCES `paths` (`id`) ON DELETE CASCADE;
<next>
ALTER TABLE `rule`
  ADD CONSTRAINT `FK_rule_campaigns` FOREIGN KEY (`camp_id`) REFERENCES `campaigns` (`id`),
  ADD CONSTRAINT `FK_rule_paths` FOREIGN KEY (`path_id`) REFERENCES `paths` (`id`);  
<next>
ALTER TABLE `rule_com`
  ADD CONSTRAINT `FK_rule_com_rule` FOREIGN KEY (`rule_id`) REFERENCES `rule` (`id`) ON DELETE CASCADE;
<next>
ALTER TABLE `tokens`
  ADD CONSTRAINT `FK_tokens_traffic_sources` FOREIGN KEY (`source_id`) REFERENCES `traffic_sources` (`id`);
<next>
ALTER TABLE `users_permission` ADD CONSTRAINT `users_permission_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);