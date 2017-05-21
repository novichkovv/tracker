CREATE PROCEDURE report_create (IN var_table_name VARCHAR(64)) BEGIN
	SET @report_create_sql_1 = CONCAT('CREATE TABLE ', var_table_name, ' (
			id INT(12) NOT NULL AUTO_INCREMENT,
			hour_click INT(2) NOT NULL,
			day_week INT(2) NOT NULL,
			offer INT(6) NOT NULL,
			path_id INT(6) NOT NULL,
			landing_page INT(6) NOT NULL,
			ts_id INT(6) NOT NULL,
			rule_id INT(6) NOT NULL,
			offer_type tinyint(1) NOT NULL,
			an INT(6) NOT NULL,
			isp INT(6) NOT NULL,
			country INT(6) NOT NULL,
			geo_type INT(6) NOT NULL,
			model INT(6) NOT NULL,
			brand INT(6) NOT NULL,
			lang INT(6) NOT NULL,
			td1 INT(6) NOT NULL,
			td2 INT(6) NOT NULL,
			td3 INT(6) NOT NULL,
			td4 INT(6) NOT NULL,
			os INT(6) NOT NULL,
			browser INT(6) NOT NULL,
			ua INT(6) NOT NULL,
			clicks INT(12) NOT NULL,
			bots INT(12) NOT NULL,
			clicks_offer INT(12) NOT NULL,
			clicks_landing INT(12) NOT NULL,
			leads INT(12) NOT NULL,
			spend DECIMAL(14,5) NOT NULL,
			pay DECIMAL(12,3) NOT NULL,
			publisher INT(12) NOT NULL,
			referer_domain INT(12) NOT NULL,
			PRIMARY KEY(`id`),
			INDEX hour_click_idx_',var_table_name,' (hour_click),
			INDEX day_week_idx_',var_table_name,' (day_week),
			INDEX offer_idx_',var_table_name,' (offer),
			INDEX path_id_idx_',var_table_name,' (path_id),
			INDEX landing_page_idx_',var_table_name,' (landing_page),
			INDEX ts_id_idx_',var_table_name,' (ts_id),
			INDEX an_idx_',var_table_name,' (an),
			INDEX isp_idx_',var_table_name,' (isp),
			INDEX country_idx_',var_table_name,' (country),
			INDEX geo_type_idx_',var_table_name,' (geo_type),
			INDEX ua_idx_',var_table_name,' (ua),
			INDEX model_idx_',var_table_name,' (model),
			INDEX brand_idx_',var_table_name,' (brand),
			INDEX lang_idx_',var_table_name,' (lang),
			INDEX td1_idx_',var_table_name,' (td1),
			INDEX td2_idx_',var_table_name,' (td2),
			INDEX td3_idx_',var_table_name,' (td3),
			INDEX td4_idx_',var_table_name,' (td4),
			INDEX os_idx_',var_table_name,' (os),
			INDEX browser_idx_',var_table_name,' (browser),
			INDEX leads_idx_',var_table_name,' (leads),
			INDEX clicks_offer_idx_',var_table_name,' (clicks_offer),
			INDEX clicks_idx_',var_table_name,' (clicks),
			INDEX bots_idx_',var_table_name,' (bots),
			INDEX publisher_idx_',var_table_name,' (publisher),
			INDEX referer_domain_idx_',var_table_name,' (referer_domain),
			INDEX clicks_landing_offer_idx_',var_table_name,' (clicks_landing)
		) CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=MyISAM;');
	PREPARE create_report FROM @report_create_sql_1;
	EXECUTE create_report;
	DEALLOCATE PREPARE create_report;
END
<next>
CREATE PROCEDURE report_create_ip (IN var_table_name VARCHAR(64)) BEGIN
	SET @report_create_sql_1 = CONCAT('CREATE TABLE ', var_table_name, ' (
			id INT(12) NOT NULL AUTO_INCREMENT,
			hour_click INT(2) NOT NULL,
			day_week INT(2) NOT NULL,
			offer INT(6) NOT NULL,
			path_id INT(6) NOT NULL,
			landing_page INT(6) NOT NULL,
			ts_id INT(6) NOT NULL,
			rule_id INT(6) NOT NULL,
			offer_type tinyint(1) NOT NULL,
			an INT(6) NOT NULL,
			isp INT(6) NOT NULL,
			country INT(6) NOT NULL,
			geo_type INT(6) NOT NULL,
			model INT(6) NOT NULL,
			brand INT(6) NOT NULL,
			lang INT(6) NOT NULL,
			td1 INT(6) NOT NULL,
			td2 INT(6) NOT NULL,
			td3 INT(6) NOT NULL,
			td4 INT(6) NOT NULL,
			os INT(6) NOT NULL,
			browser INT(6) NOT NULL,
			ua INT(6) NOT NULL,
			clicks INT(12) NOT NULL,
			bots INT(12) NOT NULL,
			clicks_offer INT(12) NOT NULL,
			clicks_landing INT(12) NOT NULL,
			leads INT(12) NOT NULL,
			spend DECIMAL(14,5) NOT NULL,
			pay DECIMAL(12,3) NOT NULL,
			publisher INT(12) NOT NULL,
			referer_domain INT(12) NOT NULL,
			ip_1 INT(3) NOT NULL,
			ip_2 INT(3) NOT NULL,
			ip_3 INT(3) NOT NULL,
			ip_4 INT(3) NOT NULL,
			ip_5 INT(3) NOT NULL,
			ip_6 INT(3) NOT NULL,
			PRIMARY KEY(`id`),
			INDEX hour_click_idx_',var_table_name,' (hour_click),
			INDEX offer_idx_',var_table_name,' (offer),
			INDEX path_id_idx_',var_table_name,' (path_id),
			INDEX landing_page_idx_',var_table_name,' (landing_page),
			INDEX ts_id_idx_',var_table_name,' (ts_id),
			INDEX an_idx_',var_table_name,' (an),
			INDEX isp_idx_',var_table_name,' (isp),
			INDEX country_idx_',var_table_name,' (country),
			INDEX geo_type_idx_',var_table_name,' (geo_type),
			INDEX ua_idx_',var_table_name,' (ua),
			INDEX model_idx_',var_table_name,' (model),
			INDEX brand_idx_',var_table_name,' (brand),
			INDEX lang_idx_',var_table_name,' (lang),
			INDEX td1_idx_',var_table_name,' (td1),
			INDEX td2_idx_',var_table_name,' (td2),
			INDEX td3_idx_',var_table_name,' (td3),
			INDEX td4_idx_',var_table_name,' (td4),
			INDEX os_idx_',var_table_name,' (os),
			INDEX browser_idx_',var_table_name,' (browser),
			INDEX leads_idx_',var_table_name,' (leads),
			INDEX clicks_offer_idx_',var_table_name,' (clicks_offer),
			INDEX clicks_idx_',var_table_name,' (clicks),
			INDEX bots_idx_',var_table_name,' (bots),
			INDEX clicks_landing_offer_idx_',var_table_name,' (clicks_landing),
			INDEX publisher_idx_',var_table_name,' (publisher),
			INDEX referer_domain_idx_',var_table_name,' (referer_domain),
			INDEX ip_1_idx_',var_table_name,' (ip_1),
			INDEX ip_2_idx_',var_table_name,' (ip_2),
			INDEX ip_3_idx_',var_table_name,' (ip_3),
			INDEX ip_4_idx_',var_table_name,' (ip_4),
			INDEX ip_5_idx_',var_table_name,' (ip_5),
			INDEX ip_6_idx_',var_table_name,' (ip_6)
		) CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=MyISAM;');
	PREPARE create_report FROM @report_create_sql_1;
	EXECUTE create_report;
	DEALLOCATE PREPARE create_report;
END
<next>
CREATE PROCEDURE report_create_token (IN var_table_name VARCHAR(64)) BEGIN
	SET @report_create_sql_1 = CONCAT('CREATE TABLE ', var_table_name, ' (
			id INT(12) NOT NULL AUTO_INCREMENT,
			hour_click INT(2) NOT NULL,
			day_week INT(2) NOT NULL,
			offer INT(6) NOT NULL,
			path_id INT(6) NOT NULL,
			landing_page INT(6) NOT NULL,
			ts_id INT(6) NOT NULL,
			rule_id INT(6) NOT NULL,
			offer_type tinyint(1) NOT NULL,
			an INT(6) NOT NULL,
			isp INT(6) NOT NULL,
			country INT(6) NOT NULL,
			geo_type INT(6) NOT NULL,
			clicks INT(12) NOT NULL,
			bots INT(12) NOT NULL,
			clicks_offer INT(12) NOT NULL,
			clicks_landing INT(12) NOT NULL,
			leads INT(12) NOT NULL,
			spend DECIMAL(14,5) NOT NULL,
			pay DECIMAL(12,3) NOT NULL,
			t1 INT(6) NOT NULL,
			t2 INT(6) NOT NULL,
			t3 INT(6) NOT NULL,
			t4 INT(6) NOT NULL,
			t5 INT(6) NOT NULL,
			t6 INT(6) NOT NULL,
			t7 INT(6) NOT NULL,
			t8 INT(6) NOT NULL,
			t9 INT(6) NOT NULL,
			t10 INT(6) NOT NULL,
			PRIMARY KEY(`id`),
			INDEX hour_click_idx_',var_table_name,' (hour_click),
			INDEX day_week_idx_',var_table_name,' (day_week),
			INDEX offer_idx_',var_table_name,' (offer),
			INDEX path_id_idx_',var_table_name,' (path_id),
			INDEX landing_page_idx_',var_table_name,' (landing_page),
			INDEX ts_id_idx_',var_table_name,' (ts_id),
			INDEX an_idx_',var_table_name,' (an),
			INDEX isp_idx_',var_table_name,' (isp),
			INDEX country_idx_',var_table_name,' (country),
			INDEX geo_type_idx_',var_table_name,' (geo_type),
			INDEX leads_idx_',var_table_name,' (leads),
			INDEX clicks_offer_idx_',var_table_name,' (clicks_offer),
			INDEX clicks_idx_',var_table_name,' (clicks),
			INDEX bots_idx_',var_table_name,' (bots),
			INDEX clicks_landing_offer_idx_',var_table_name,' (clicks_landing),
			INDEX t1_idx_',var_table_name,' (t1),
			INDEX t2_idx_',var_table_name,' (t2),
			INDEX t3_idx_',var_table_name,' (t3),
			INDEX t4_idx_',var_table_name,' (t4),
			INDEX t5_idx_',var_table_name,' (t5),
			INDEX t6_idx_',var_table_name,' (t6),
			INDEX t7_idx_',var_table_name,' (t7),
			INDEX t8_idx_',var_table_name,' (t8),
			INDEX t9_idx_',var_table_name,' (t9),
			INDEX t10_idx_',var_table_name,' (t10)
		) CHARACTER SET utf8 COLLATE utf8_general_ci ENGINE=MyISAM;');
	PREPARE create_report FROM @report_create_sql_1;
	EXECUTE create_report;
	DEALLOCATE PREPARE create_report;
END
<next>
CREATE PROCEDURE report_update_ip_m (IN var_id INT, IN var_click_time INT, IN var_camp_id INT, IN var_path_id INT, IN var_landing_page INT, IN var_ts_id INT, IN var_rule_id INT, IN var_geo INT, IN var_ua INT, IN var_publisher INT, IN var_table_name VARCHAR(64), IN var_ip_1 INT, IN var_ip_2 INT, IN var_ip_3 INT, IN var_ip_4 INT, IN var_ip_text INT, IN var_ref INT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE 
		var_isp, var_country, var_geo_type,
		var_os, var_browser,var_model, var_brand, var_lang, var_td1, var_td2,
		var_td3, var_td4, var_hour_click, var_day_week, flag, var_path_com, var_offer_type, var_offer,var_an
	INT DEFAULT 0;
	DECLARE var_id_t VARCHAR(512);
	DECLARE cursor_m1 CURSOR FOR 
		SELECT id,id_t,`type` FROM path_com WHERE path_id = var_path_id AND (`type`=3 OR `type`=4 OR `type`=5);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_m1;
		REPEAT
			FETCH cursor_m1 INTO var_path_com, var_id_t, var_offer_type;
			IF NOT flag THEN
				IF(var_offer_type=3)THEN
					SET var_an = (SELECT network FROM offers WHERE id = var_id_t);
				ELSE
					SET var_an = 0;
				END IF;
				IF(var_offer_type=3 OR var_offer_type=5)THEN
					SET var_offer=var_id_t;
				ELSE
					SET var_offer=var_path_com;
				END IF;
				SET var_hour_click = HOUR(FROM_UNIXTIME(var_click_time, '%Y-%m-%d %H:%i:%S'));
				SET var_day_week = FROM_UNIXTIME(var_click_time, '%w');
				SELECT isp, country, `type` INTO var_isp,var_country,var_geo_type FROM {data_base}.base_geo WHERE id = var_geo;
				SELECT  os, browser, device_model_id, device_brand_id, device_lang_id, device_td1_id, device_td2_id, device_td3_id, device_td4_id
					INTO var_os,var_browser,var_model,var_brand,var_lang,var_td1,var_td2,var_td3,var_td4
					FROM {data_base}.user_agents
					WHERE id = var_ua;
				SET @report_update_sql_1=CONCAT('SELECT COUNT(*) INTO @report_update_check_insrt FROM ', var_table_name, 
						' WHERE offer = ', var_offer, 
						' AND hour_click = ', var_hour_click,
						' AND day_week = ', var_day_week,
						' AND path_id = ', var_path_id,
						' AND landing_page = ', var_landing_page,
						' AND ts_id = ', var_ts_id,
						' AND rule_id = ', var_rule_id,
						' AND offer_type = ', var_offer_type,
						' AND an = ', var_an,
						' AND isp = ', var_isp,
						' AND country = ', var_country,
						' AND geo_type = ', var_geo_type,
						' AND model = ', var_model,
						' AND brand = ', var_brand,
						' AND lang = ', var_lang,
						' AND td1 = ', var_td1,
						' AND td2 = ', var_td2,
						' AND td3 = ', var_td3,
						' AND td4 = ', var_td4,
						' AND os = ', var_os,
						' AND browser = ', var_browser,
						' AND ua = ', var_ua,
						' AND publisher = ', var_publisher,
						' AND referer_domain = ', var_ref,
						' AND ip_1 = ', var_ip_1,
						' AND ip_2 = ', var_ip_2,
						' AND ip_3 = ', var_ip_3,
						' AND ip_4 = ', var_ip_4);
				PREPARE check_insrt_report FROM @report_update_sql_1;
				EXECUTE check_insrt_report;
				DEALLOCATE PREPARE check_insrt_report;
				IF(@report_update_check_insrt = 0) THEN 
					SET @report_update_sql_2 = CONCAT('INSERT INTO ',var_table_name,
							' (offer,hour_click,day_week,path_id,landing_page,ts_id,rule_id,offer_type,an,isp,country,geo_type,model,brand,lang,td1,td2,td3,td4,os, browser,ua,clicks,clicks_offer,clicks_landing,leads,spend,pay,ip_1,ip_2,ip_3,ip_4,ip_5,ip_6,publisher, referer_domain, bots) VALUES (',
								var_offer, ', ',
								var_hour_click, ', ',
								var_day_week, ', ',
								var_path_id, ', ',
								var_landing_page, ', ',
								var_ts_id, ', ',
								var_rule_id, ', ',
								var_offer_type, ', ',
								var_an, ', ',
								var_isp, ', ',
								var_country, ', ',
								var_geo_type, ', ',
								var_model, ', ',
								var_brand, ', ',
								var_lang, ', ',
								var_td1, ', ',
								var_td2, ', ',
								var_td3, ', ',
								var_td4, ', ',
								var_os, ', ',
								var_browser, ', ',
								var_ua, ', ',
								'0, ',
								'0, ',
								'0, ',
								'0, ',
								'0, ',
								'0, ',
								var_ip_1, ', ',
								var_ip_2, ', ',
								var_ip_3, ', ',
								var_ip_4, ', ',
								CONCAT(var_ip_2,var_ip_3),', ',
								CONCAT(var_ip_2,var_ip_3,var_ip_4),', ',
								var_publisher,', ',
								var_ref,', ',
								'0',
								')');
					PREPARE insert_report FROM @report_update_sql_2;
					EXECUTE insert_report;
					DEALLOCATE PREPARE insert_report;
				END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_m1;
END
<next>
CREATE PROCEDURE report_update_m (IN var_id INT, IN var_click_time INT, IN var_camp_id INT, IN var_path_id INT, IN var_landing_page INT, IN var_ts_id INT, IN var_rule_id INT, IN var_geo INT, IN var_ua INT, IN var_publisher INT, IN var_table_name VARCHAR(64), IN var_ref INT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE 
		var_isp, var_country, var_geo_type,
		var_os, var_browser,var_model, var_brand, var_lang, var_td1, var_td2,
		var_td3, var_td4, var_hour_click, var_day_week, flag, var_path_com, var_offer_type, var_offer,var_an
	INT DEFAULT 0;
	DECLARE var_id_t VARCHAR(512);
	DECLARE cursor_m1 CURSOR FOR 
		SELECT id,id_t,`type` FROM path_com WHERE path_id = var_path_id AND (`type`=3 OR `type`=4 OR `type`=5);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_m1;
		REPEAT
			FETCH cursor_m1 INTO var_path_com, var_id_t, var_offer_type;
			IF NOT flag THEN
				IF(var_offer_type=3)THEN
					SET var_an = (SELECT network FROM offers WHERE id = var_id_t);
				ELSE
					SET var_an = 0;
				END IF;
				IF(var_offer_type=3 OR var_offer_type=5)THEN
					SET var_offer=var_id_t;
				ELSE
					SET var_offer=var_path_com;
				END IF;
				SET var_hour_click = HOUR(FROM_UNIXTIME(var_click_time, '%Y-%m-%d %H:%i:%S'));
				SET var_day_week = FROM_UNIXTIME(var_click_time, '%w');
				SELECT isp, country, `type` INTO var_isp,var_country,var_geo_type FROM {data_base}.base_geo WHERE id = var_geo;
				SELECT  os, browser, device_model_id, device_brand_id, device_lang_id, device_td1_id, device_td2_id, device_td3_id, device_td4_id
					INTO var_os,var_browser,var_model,var_brand,var_lang,var_td1,var_td2,var_td3,var_td4
					FROM {data_base}.user_agents
					WHERE id = var_ua;
				SET @report_update_sql_1=CONCAT('SELECT COUNT(*) INTO @report_update_check_insrt FROM ', var_table_name, 
									' WHERE offer = ', var_offer,
									' AND hour_click = ', var_hour_click,
									' AND day_week = ', var_day_week,
									' AND path_id = ', var_path_id,
									' AND landing_page = ', var_landing_page,
									' AND ts_id = ', var_ts_id,
									' AND rule_id = ', var_rule_id,
									' AND offer_type = ', var_offer_type,
									' AND an = ', var_an,
									' AND isp = ', var_isp,
									' AND country = ', var_country,
									' AND geo_type = ', var_geo_type,
									' AND model = ', var_model,
									' AND brand = ', var_brand,
									' AND lang = ', var_lang,
									' AND td1 = ', var_td1,
									' AND td2 = ', var_td2,
									' AND td3 = ', var_td3,
									' AND td4 = ', var_td4,
									' AND os = ', var_os,
									' AND publisher = ', var_publisher,
									' AND referer_domain = ', var_ref,
									' AND browser = ', var_browser,
									' AND ua = ', var_ua);
				PREPARE check_insrt_report FROM @report_update_sql_1;
				EXECUTE check_insrt_report;
				DEALLOCATE PREPARE check_insrt_report;
				IF(@report_update_check_insrt = 0) THEN 
					SET @report_update_sql_2 = CONCAT('INSERT INTO ',var_table_name,
										' (offer,hour_click,day_week,path_id,landing_page,ts_id,rule_id,offer_type,an,isp,country,geo_type,model,brand,lang,td1,td2,td3,td4,os, browser,ua,clicks,clicks_offer,clicks_landing,leads,spend,pay,publisher,referer_domain, bots) VALUES (',
											var_offer, ', ',
											var_hour_click, ', ',
											var_day_week, ', ',
											var_path_id, ', ',
											var_landing_page, ', ',
											var_ts_id, ', ',
											var_rule_id, ', ',
											var_offer_type, ', ',
											var_an, ', ',
											var_isp, ', ',
											var_country, ', ',
											var_geo_type, ', ',
											var_model, ', ',
											var_brand, ', ',
											var_lang, ', ',
											var_td1, ', ',
											var_td2, ', ',
											var_td3, ', ',
											var_td4, ', ',
											var_os, ', ',
											var_browser, ', ',
											var_ua, ', ',
											'0, ',
											'0, ',
											'0, ',
											'0, ',
											'0, ',
											'0, ',
											var_publisher,', ',
											var_ref,', ',
											'0',
											')');
					PREPARE insert_report FROM @report_update_sql_2;
					EXECUTE insert_report;
					DEALLOCATE PREPARE insert_report;
				END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_m1;
END
<next>
CREATE PROCEDURE report_load (IN start_click_id INT, IN last_click_id INT, IN reload_stats INT) BEGIN 
	/*Binom 14000 1.4*/
	DECLARE 
		log_id,last_id,check_table,i,var_ip_1,var_ip_2,var_ip_3,var_ip_4,var_bot,check_agent,
		var_id,var_click_time,var_camp_id,var_offer,var_path_id,var_landing_page,var_cvr_id,
		var_ts_id,var_rule_id,var_offer_click,var_offer_type,var_an,var_geo,var_ua,
		var_publisher,var_ref,var_token,mul_of
	INT;
	DECLARE 
		var_table_name,var_table_name_ip,var_ip_text,var_table_name_token
	VARCHAR(64);
	DECLARE flag INT DEFAULT 0;
	DECLARE var_ip BIGINT;
	DECLARE var_pay, var_cpc DECIMAL(14,5);
	DECLARE time_client DATETIME;
	DECLARE cursor_1 CURSOR FOR
		SELECT id, click_time, camp_id, offer, path_id, landing_page, cvr_id, ts_id, rule_id, offer_click, offer_type, an, pay, cpc, geo, ua,publisher, ip, referer_domain, token, is_bot FROM {data_base}.clicks WHERE id > start_click_id AND id<=last_click_id ORDER BY id DESC;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	CALL {data_base}.time_convert(NOW(),time_client);
	IF(reload_stats=0)THEN
		INSERT INTO {data_base}.proc_2(start_date, end_date, dop_info) VALUES (UNIX_TIMESTAMP(time_client), 0, last_click_id);
		SET log_id=(SELECT LAST_INSERT_ID());
	END IF;
	OPEN cursor_1;
		REPEAT
			FETCH cursor_1 INTO var_id, var_click_time, var_camp_id, var_offer, var_path_id, var_landing_page, var_cvr_id, var_ts_id, var_rule_id, var_offer_click, var_offer_type, var_an, var_pay, var_cpc, var_geo, var_ua, var_publisher, var_ip, var_ref, var_token, var_bot;
			IF NOT flag THEN
				IF((SELECT COUNT(*) FROM base_geo WHERE id = var_geo)=0)THEN
					SET var_geo = 0;
				END IF;
				SET mul_of=0;
				IF((SELECT offers FROM landing_pages WHERE id = var_landing_page)>1)THEN
					SET mul_of=(SELECT offers FROM landing_pages WHERE id = var_landing_page);
				END IF;
				IF((SELECT COUNT(*) FROM {data_base}.user_agents WHERE id = var_ua)=0)THEN
					SET var_ua=0;
				END IF;
				CALL {data_base}.ip_convert(var_ip, var_ip_text, var_ip_1, var_ip_2, var_ip_3, var_ip_4);
					
				SET var_table_name = CONCAT('report_camp_', var_camp_id, '_', FROM_UNIXTIME(var_click_time, '%d%m%Y'));
				SET var_table_name_ip = CONCAT('report_camp_ip_',var_camp_id,'_',FROM_UNIXTIME(var_click_time, '%d%m%Y'));
				SET var_table_name_token = CONCAT('report_camp_token_', var_camp_id, '_', FROM_UNIXTIME(var_click_time, '%d%m%Y'));
				
				SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = var_table_name AND table_schema = '{data_base}');
				IF(check_table = 0) THEN
					CALL {data_base}.report_create(var_table_name);
				END IF;
				IF(mul_of>0)THEN
					CALL {data_base}.report_update_m(var_id, var_click_time, var_camp_id, var_path_id, var_landing_page, var_ts_id, var_rule_id, var_geo, var_ua, var_publisher, var_table_name, var_ref);
				END IF;
				CALL {data_base}.report_update(var_id, var_click_time, var_camp_id, var_offer, var_path_id, var_landing_page, var_cvr_id, var_ts_id, var_rule_id, var_offer_click, var_offer_type, var_an, var_pay, var_cpc, var_geo, var_ua, var_publisher, var_table_name, var_ref, var_bot);
				
				SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = var_table_name_ip AND table_schema = '{data_base}');
				IF(check_table = 0) THEN
					CALL {data_base}.report_create_ip(var_table_name_ip);
				END IF;
				IF(mul_of>0)THEN
					CALL {data_base}.report_update_ip_m(var_id, var_click_time, var_camp_id, var_path_id, var_landing_page, var_ts_id, var_rule_id, var_geo, var_ua, var_publisher, var_table_name_ip, var_ip_1, var_ip_2, var_ip_3, var_ip_4, var_ip_text, var_ref);
				END IF;
				CALL {data_base}.report_update_ip(var_id, var_click_time, var_camp_id, var_offer, var_path_id, var_landing_page, var_cvr_id, var_ts_id, var_rule_id, var_offer_click, var_offer_type, var_an, var_pay, var_cpc, var_geo, var_ua, var_publisher, var_table_name_ip, var_ip_1, var_ip_2, var_ip_3, var_ip_4, var_ip_text, var_ref, var_bot);
				IF(var_token!=0)THEN
					SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = var_table_name_token AND table_schema = '{data_base}');
					IF(check_table = 0) THEN
						CALL {data_base}.report_create_token(var_table_name_token);
					END IF;
					IF(mul_of>0)THEN
						CALL {data_base}.report_update_token_m(var_id, var_click_time, var_camp_id, var_path_id, var_landing_page, var_ts_id, var_rule_id, var_geo, var_table_name_token);
					END IF;
					CALL {data_base}.report_update_token(var_id, var_click_time, var_camp_id, var_offer, var_path_id, var_landing_page, var_cvr_id, var_ts_id, var_rule_id, var_offer_click, var_offer_type, var_an, var_pay, var_cpc, var_geo, var_table_name_token, var_bot);
				END IF;
				
				SET last_id = var_id;
				IF(mul_of>0)THEN
					CALL {data_base}.showcase_update_m(var_click_time, var_camp_id, var_path_id);
				END IF;
				CALL {data_base}.showcase_update(var_click_time, var_camp_id, var_offer, var_landing_page, var_ts_id, var_an, var_cvr_id, var_offer_click, var_pay, var_cpc, var_offer_type, var_bot);
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_1;
	IF(reload_stats=0)THEN
		CALL {data_base}.time_convert(NOW(),time_client);
		UPDATE {data_base}.proc_2 SET end_date=UNIX_TIMESTAMP(time_client) WHERE id = log_id;
	END IF;
END
<next>
CREATE PROCEDURE report_month (IN var_month VARCHAR(2), IN var_year INT, IN dop_parameter VARCHAR(12)) BEGIN
	/*Binom 16102*/
	DECLARE var_table_name, var_table_name_new, old_var_table_name VARCHAR(128);
	DECLARE SQL_MONTH, ALL_SQL_MONTH, LIST_VAL, SUM_LIST LONGTEXT;
	DECLARE flag, i, old_camp_id INT DEFAULT 0;
	DECLARE var_id, check_table INT;
	DECLARE cursor_tables CURSOR FOR	
		SELECT camp.id, tbl.table_name FROM (
			{data_base}.campaigns AS camp
			LEFT JOIN
			information_schema.tables AS tbl ON table_name REGEXP CONCAT("^report_",dop_parameter,camp.id,"_[0-9]{2}",var_month,var_year) AND table_schema = '{data_base}'
		) WHERE tbl.table_name IS NOT NULL AND camp.id!=0 ORDER BY camp.id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
		CASE dop_parameter
			WHEN 'camp_token_' THEN 
				SET LIST_VAL='t1,t2,t3,t4,t5,t6,t7,t8,t9,t10';
			WHEN 'camp_ip_' THEN  
				SET LIST_VAL='model,brand,lang,td1,td2,td3,td4,os,browser,ua,publisher,referer_domain,ip_1,ip_2,ip_3,ip_4,ip_5,ip_6';
			ELSE  
				SET LIST_VAL='model, brand, lang, td1, td2, td3, td4, os, browser, ua, publisher, referer_domain';
		END CASE;
	SET flag=0;
	SET SQL_MONTH='';
	SET ALL_SQL_MONTH='';
	SET old_var_table_name='';
	SET i = 0;
	SET old_camp_id = 0;
	OPEN cursor_tables;
		REPEAT
			IF NOT flag THEN
				FETCH cursor_tables INTO var_id, var_table_name;
					IF(var_table_name != old_var_table_name)THEN
						SET old_var_table_name = var_table_name;
						IF(var_id != old_camp_id)THEN
							IF(i > 0)THEN
								SET ALL_SQL_MONTH = LEFT(ALL_SQL_MONTH, (LENGTH(ALL_SQL_MONTH)-9));
								SET ALL_SQL_MONTH=CONCAT(ALL_SQL_MONTH,") AS month_stat
								GROUP BY hour_click, day_week, offer, path_id, landing_page, ts_id, rule_id, offer_type,
								an, isp, country, geo_type, ",LIST_VAL,";");
								SET @report_month = ALL_SQL_MONTH;
								SET ALL_SQL_MONTH = '';
								PREPARE month_create FROM @report_month;
								EXECUTE month_create;
								DEALLOCATE PREPARE month_create;
							ELSE
								SET i = 1;
							END IF;
							SET old_camp_id = var_id;
							SET var_table_name_new = CONCAT("month_report_",dop_parameter,var_id,"_",var_month,var_year);
							SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = var_table_name_new AND table_schema = '{data_base}');
							IF(check_table>0)THEN
								SET @month_table_drop=CONCAT('DROP TABLE {data_base}.',var_table_name_new);
								PREPARE table_drop FROM @month_table_drop;
								EXECUTE table_drop;
								DEALLOCATE PREPARE table_drop;
							END IF;
							CASE dop_parameter
								WHEN 'camp_token_' THEN 
									CALL {data_base}.report_create_token(var_table_name_new);
								WHEN 'camp_ip_' THEN  
									CALL {data_base}.report_create_ip(var_table_name_new);
								ELSE  
									CALL {data_base}.report_create(var_table_name_new);
							END CASE;
							SET ALL_SQL_MONTH = CONCAT(ALL_SQL_MONTH,"
								INSERT INTO ",var_table_name_new,"( hour_click, day_week, offer, path_id, landing_page, ts_id, rule_id, offer_type,an, isp, country, geo_type, ",LIST_VAL,", clicks, bots, clicks_offer, clicks_landing, leads, spend, pay
								)  
								SELECT 
									hour_click, day_week, offer, path_id, landing_page, ts_id, rule_id, offer_type,
									an, isp, country, geo_type, ",LIST_VAL,",  SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend),
									SUM(pay)
								FROM (");
						END IF;
						SET ALL_SQL_MONTH = CONCAT(ALL_SQL_MONTH,'
						SELECT 
							 hour_click, day_week, offer, path_id, landing_page, ts_id, rule_id, offer_type,
							an, isp, country, geo_type, ',LIST_VAL,', clicks, bots, clicks_offer, clicks_landing, leads, spend, pay
						FROM
							',var_table_name,'
						UNION ALL');
					END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_tables;
	IF(i>0)THEN
		SET ALL_SQL_MONTH = LEFT(ALL_SQL_MONTH, (LENGTH(ALL_SQL_MONTH)-9));
		SET ALL_SQL_MONTH=CONCAT(ALL_SQL_MONTH,") AS month_stat
		GROUP BY  hour_click, day_week, offer, path_id, landing_page, ts_id, rule_id, offer_type,
				an, isp, country, geo_type, ",LIST_VAL,";");
		
		SET @report_month = ALL_SQL_MONTH;
		SET ALL_SQL_MONTH = '';
		PREPARE month_create FROM @report_month;
		EXECUTE month_create;
		DEALLOCATE PREPARE month_create;
	END IF;
END
<next>
CREATE PROCEDURE report_month_all (IN var_start_month INT,IN var_end_month INT, IN var_year INT) BEGIN
	/*Binom 16000*/
	DECLARE real_month VARCHAR(2);
	WHILE var_start_month < (var_end_month+1) DO  
		IF(var_start_month!=MONTH(NOW()))THEN
			IF(var_start_month<10)THEN
				SET real_month = CONCAT('0',var_start_month);
			ELSE
				SET real_month = var_start_month;
			END IF;
			call report_month(real_month,var_year, 'camp_');
			call report_month(real_month,var_year, 'camp_token_');
			call report_month(real_month,var_year, 'camp_ip_');
		END IF;
		SET var_start_month=var_start_month+1;
	END WHILE;
END
<next>
CREATE PROCEDURE report_update (IN var_id INT, IN var_click_time INT, IN var_camp_id INT, IN var_offer INT, IN var_path_id INT, IN var_landing_page INT, IN var_cvr_id INT, IN var_ts_id INT, IN var_rule_id INT, IN var_offer_click INT, IN var_offer_type INT, IN var_an INT, IN var_pay DECIMAL(12,3), IN var_cpc DECIMAL(14,5), IN var_geo INT, IN var_ua INT, IN var_publisher INT, IN var_table_name VARCHAR(64), IN var_ref INT, IN var_bot INT) BEGIN
	DECLARE 
		var_clicks_landing,var_cvr,log_id,var_isp, var_country, var_geo_type,
		var_os, var_browser,var_model, var_brand, var_lang, var_td1, var_td2,
		var_td3, var_td4, var_hour_click, var_day_week
	INT;
	SET var_hour_click = HOUR(FROM_UNIXTIME(var_click_time, '%Y-%m-%d %H:%i:%S'));
	SET var_day_week = FROM_UNIXTIME(var_click_time, '%w');
	SELECT isp, country, `type` INTO var_isp,var_country,var_geo_type FROM {data_base}.base_geo WHERE id = var_geo;
	SELECT  os, browser, device_model_id, device_brand_id, device_lang_id, device_td1_id, device_td2_id, device_td3_id, device_td4_id
		INTO var_os,var_browser,var_model,var_brand,var_lang,var_td1,var_td2,var_td3,var_td4
		FROM {data_base}.user_agents
		WHERE id = var_ua;
	IF(var_landing_page!=0) THEN 
		SET var_clicks_landing=1;
	ELSE 
		SET var_clicks_landing=0;
		SET var_offer_click=0;
	END IF;
	IF(var_cvr_id!=0)THEN 
		SET var_cvr=1;
	ELSE 
		SET var_cvr=0;
	END IF;
	SET @report_update_sql_1=CONCAT('SELECT COUNT(*) INTO @report_update_check_insrt FROM ', var_table_name, 
						' WHERE offer = ', var_offer,
						' AND hour_click = ', var_hour_click,
						' AND day_week = ', var_day_week,
						' AND path_id = ', var_path_id,
						' AND landing_page = ', var_landing_page,
						' AND ts_id = ', var_ts_id,
						' AND rule_id = ', var_rule_id,
						' AND offer_type = ', var_offer_type,
						' AND an = ', var_an,
						' AND isp = ', var_isp,
						' AND country = ', var_country,
						' AND geo_type = ', var_geo_type,
						' AND model = ', var_model,
						' AND brand = ', var_brand,
						' AND lang = ', var_lang,
						' AND td1 = ', var_td1,
						' AND td2 = ', var_td2,
						' AND td3 = ', var_td3,
						' AND td4 = ', var_td4,
						' AND os = ', var_os,
						' AND publisher = ', var_publisher,
						' AND referer_domain = ', var_ref,
						' AND browser = ', var_browser,
						' AND ua = ', var_ua);
	PREPARE check_insrt_report FROM @report_update_sql_1;
	EXECUTE check_insrt_report;
	DEALLOCATE PREPARE check_insrt_report;
	IF(@report_update_check_insrt = 0) THEN 
		SET @report_update_sql_2 = CONCAT('INSERT INTO ',var_table_name,
							' (offer,hour_click,day_week,path_id,landing_page,ts_id,rule_id,offer_type,an,isp,country,geo_type,model,brand,lang,td1,td2,td3,td4,os, browser,ua,clicks,clicks_offer,clicks_landing,leads,spend,pay,publisher,referer_domain, bots) VALUES (',
								var_offer, ', ',
								var_hour_click, ', ',
								var_day_week, ', ',
								var_path_id, ', ',
								var_landing_page, ', ',
								var_ts_id, ', ',
								var_rule_id, ', ',
								var_offer_type, ', ',
								var_an, ', ',
								var_isp, ', ',
								var_country, ', ',
								var_geo_type, ', ',
								var_model, ', ',
								var_brand, ', ',
								var_lang, ', ',
								var_td1, ', ',
								var_td2, ', ',
								var_td3, ', ',
								var_td4, ', ',
								var_os, ', ',
								var_browser, ', ',
								var_ua, ', ',
								'1, ',
								var_offer_click, ', ',
								var_clicks_landing, ', ',
								var_cvr, ', ',
								var_cpc, ', ',
								var_pay,', ',
								var_publisher,', ',
								var_ref,', ',
								var_bot,
								')');
		PREPARE insert_report FROM @report_update_sql_2;
		EXECUTE insert_report;
		DEALLOCATE PREPARE insert_report;
	ELSE
		SET @report_update_sql_2 = CONCAT(
				'UPDATE ',var_table_name,' SET ',
					'clicks = clicks + 1',
					', clicks_offer = clicks_offer + ', var_offer_click,
					', clicks_landing = clicks_landing + ', var_clicks_landing,
					', bots = bots + ', var_bot,
					', leads = leads + ',var_cvr,
					', spend = spend + ', var_cpc,
					', pay = pay + ', var_pay,
					' WHERE offer = ', var_offer,
						' AND hour_click = ', var_hour_click,
						' AND day_week = ', var_day_week,
						' AND path_id = ', var_path_id,
						' AND landing_page = ', var_landing_page,
						' AND ts_id = ', var_ts_id,
						' AND rule_id = ', var_rule_id,
						' AND offer_type = ', var_offer_type,
						' AND an = ', var_an,
						' AND isp = ', var_isp,
						' AND country = ', var_country,
						' AND geo_type = ', var_geo_type,
						' AND model = ', var_model,
						' AND brand = ', var_brand,
						' AND lang = ', var_lang,
						' AND td1 = ', var_td1,
						' AND td2 = ', var_td2,
						' AND td3 = ', var_td3,
						' AND td4 = ', var_td4,
						' AND os = ', var_os,
						' AND publisher = ', var_publisher,
						' AND referer_domain = ', var_ref,
						' AND browser = ', var_browser,
						' AND ua = ', var_ua
			);
		PREPARE update_report FROM @report_update_sql_2;
		EXECUTE update_report;
		DEALLOCATE PREPARE update_report;
	END IF;
END
<next>
CREATE PROCEDURE report_update_ip (IN var_id INT, IN var_click_time INT, IN var_camp_id INT, IN var_offer INT, IN var_path_id INT, IN var_landing_page INT, IN var_cvr_id INT, IN var_ts_id INT, IN var_rule_id INT, IN var_offer_click INT, IN var_offer_type INT, IN var_an INT, IN var_pay DECIMAL(12,3), IN var_cpc DECIMAL(14,5), IN var_geo INT, IN var_ua INT, IN var_publisher INT, IN var_table_name VARCHAR(64), IN var_ip_1 INT, IN var_ip_2 INT, IN var_ip_3 INT, IN var_ip_4 INT, IN var_ip_text INT, IN var_ref INT, IN var_bot INT) BEGIN
	DECLARE var_clicks_landing,var_cvr, log_id INT;
	DECLARE var_isp, var_country, var_geo_type INT;
	DECLARE var_os, var_browser INT;
	DECLARE var_model, var_brand, var_lang, var_td1, var_td2, var_td3, var_td4, var_hour_click, var_day_week INT;
	SET var_hour_click = HOUR(FROM_UNIXTIME(var_click_time, '%Y-%m-%d %H:%i:%S'));
	SET var_day_week = FROM_UNIXTIME(var_click_time, '%w');
	SELECT isp, country, `type` INTO var_isp,var_country,var_geo_type FROM {data_base}.base_geo WHERE id = var_geo;
	SELECT  os, browser, device_model_id, device_brand_id, device_lang_id, device_td1_id, device_td2_id, device_td3_id, device_td4_id
		INTO var_os,var_browser,var_model,var_brand,var_lang,var_td1,var_td2,var_td3,var_td4
		FROM {data_base}.user_agents
		WHERE id = var_ua;
	IF(var_landing_page!=0) THEN 
		SET var_clicks_landing=1;
	ELSE 
		SET var_clicks_landing=0;
		SET var_offer_click=0;
	END IF;	
	IF(var_cvr_id!=0)THEN 
		SET var_cvr=1; 
	ELSE 
		SET var_cvr=0;
	END IF;
	SET @report_update_ip_sql_1=CONCAT('SELECT COUNT(*) INTO @report_update_ip_check_insrt FROM ', var_table_name, 
						' WHERE offer = ', var_offer, 
						' AND hour_click = ', var_hour_click,
						' AND day_week = ', var_day_week,
						' AND path_id = ', var_path_id,
						' AND landing_page = ', var_landing_page,
						' AND ts_id = ', var_ts_id,
						' AND rule_id = ', var_rule_id,
						' AND offer_type = ', var_offer_type,
						' AND an = ', var_an,
						' AND isp = ', var_isp,
						' AND country = ', var_country,
						' AND geo_type = ', var_geo_type,
						' AND model = ', var_model,
						' AND brand = ', var_brand,
						' AND lang = ', var_lang,
						' AND td1 = ', var_td1,
						' AND td2 = ', var_td2,
						' AND td3 = ', var_td3,
						' AND td4 = ', var_td4,
						' AND os = ', var_os,
						' AND browser = ', var_browser,
						' AND ua = ', var_ua,
						' AND publisher = ', var_publisher,
						' AND referer_domain = ', var_ref,
						' AND ip_1 = ', var_ip_1,
						' AND ip_2 = ', var_ip_2,
						' AND ip_3 = ', var_ip_3,
						' AND ip_4 = ', var_ip_4);
	PREPARE check_insrt_report FROM @report_update_ip_sql_1;
	EXECUTE check_insrt_report;
	DEALLOCATE PREPARE check_insrt_report;
	IF(@report_update_ip_check_insrt = 0) THEN 
		SET @report_update_ip_sql_2 = CONCAT('INSERT INTO ',var_table_name,
							' (offer,hour_click,day_week,path_id,landing_page,ts_id,rule_id,offer_type,an,isp,country,geo_type,model,brand,lang,td1,td2,td3,td4,os, browser,ua,clicks,clicks_offer,clicks_landing,leads,spend,pay,ip_1,ip_2,ip_3,ip_4,ip_5,ip_6,publisher, referer_domain, bots) VALUES (',
								var_offer, ', ',
								var_hour_click, ', ',
								var_day_week, ', ',
								var_path_id, ', ',
								var_landing_page, ', ',
								var_ts_id, ', ',
								var_rule_id, ', ',
								var_offer_type, ', ',
								var_an, ', ',
								var_isp, ', ',
								var_country, ', ',
								var_geo_type, ', ',
								var_model, ', ',
								var_brand, ', ',
								var_lang, ', ',
								var_td1, ', ',
								var_td2, ', ',
								var_td3, ', ',
								var_td4, ', ',
								var_os, ', ',
								var_browser, ', ',
								var_ua, ', ',
								'1, ',
								var_offer_click, ', ',
								var_clicks_landing, ', ',
								var_cvr, ', ',
								var_cpc, ', ',
								var_pay, ', ',
								var_ip_1, ', ',
								var_ip_2, ', ',
								var_ip_3, ', ',
								var_ip_4, ', ',
								CONCAT(var_ip_2,var_ip_3),', ',
								CONCAT(var_ip_2,var_ip_3,var_ip_4),', ',
								var_publisher,', ',
								var_ref,', ',
								var_bot,
								')');
		PREPARE insert_report FROM @report_update_ip_sql_2;
		EXECUTE insert_report;
		DEALLOCATE PREPARE insert_report;
	ELSE
		SET @report_update_ip_sql_2 = CONCAT(
				'UPDATE ',var_table_name,' SET ',
					'clicks = clicks + 1',
					', clicks_offer = clicks_offer + ', var_offer_click,
					', clicks_landing = clicks_landing + ', var_clicks_landing,
					', bots = bots + ', var_bot,
					', leads = leads + ',var_cvr,
					', spend = spend + ', var_cpc,
					', pay = pay + ', var_pay,
					' WHERE offer = ', var_offer, 
						' AND hour_click = ', var_hour_click,
						' AND day_week = ', var_day_week,
						' AND path_id = ', var_path_id,
						' AND landing_page = ', var_landing_page,
						' AND ts_id = ', var_ts_id,
						' AND rule_id = ', var_rule_id,
						' AND offer_type = ', var_offer_type,
						' AND an = ', var_an,
						' AND isp = ', var_isp,
						' AND country = ', var_country,
						' AND geo_type = ', var_geo_type,
						' AND model = ', var_model,
						' AND brand = ', var_brand,
						' AND lang = ', var_lang,
						' AND td1 = ', var_td1,
						' AND td2 = ', var_td2,
						' AND td3 = ', var_td3,
						' AND td4 = ', var_td4,
						' AND os = ', var_os,
						' AND browser = ', var_browser,
						' AND ua = ', var_ua,
						' AND publisher = ', var_publisher,
						' AND referer_domain = ', var_ref,
						' AND ip_1 = ', var_ip_1,
						' AND ip_2 = ', var_ip_2,
						' AND ip_3 = ', var_ip_3,
						' AND ip_4 = ', var_ip_4
			);
		PREPARE update_report FROM @report_update_ip_sql_2;
		EXECUTE update_report;
		DEALLOCATE PREPARE update_report;
	END IF;
END
<next>
CREATE PROCEDURE report_update_temp (IN start_click_id INT, IN last_click_id INT) BEGIN
	/*Binom 14000 1.4*/
	DECLARE 
		test_int1,test_int2
	INT DEFAULT 0;
	DECLARE 
		test_text1,test_text2
	LONGTEXT DEFAULT '';
	DECLARE 
		flag, log_id, check_all_table, check_agent, i, i2, var_el_id, m_check_table
	INT DEFAULT 0; 
	DECLARE 
		tt_id, tt_click_id, tt_cvr_id, tt_offer
	INT DEFAULT 0; 
	DECLARE 
		tt2_id, tt2_cvr_id, tt2_offer
	INT DEFAULT 0; 
	DECLARE 
		cl_click_time, cl_camp_id, cl_offer, cl_path_id, cl_landing_page, cl_cvr_id, cl_ts_id, cl_rule_id,
		cl_an, cl_geo, cl_ua, cl_publisher, cl_referer_domain, cl_token, cl_hour_click, cl_day_week,
		cl_isp, cl_country, cl_geo_type, cl_os, cl_browser, cl_model, cl_brand, cl_lang, cl_td1, cl_td2, cl_td3, cl_td4,
		cl_t1,cl_t2,cl_t3,cl_t4,cl_t5,cl_t6,cl_t7,cl_t8,cl_t9,cl_t10, cl_ip_1, cl_ip_2, cl_ip_3, cl_ip_4
	INT DEFAULT 0; 
	DECLARE 
		tt_offer_click, tt_offer_type, tt_cvr_id_temp
	TINYINT(1) DEFAULT 0;
	DECLARE 
		tt2_offer_click, tt2_offer_type
	TINYINT(1) DEFAULT 0;
	DECLARE
		cl_offer_click, cl_offer_type, cl_is_bot, tokens_on, cl_cvr_id_temp
	TINYINT(1) DEFAULT 0;
	DECLARE
		tt_pay, tt_cpc
	DECIMAL(9,5) DEFAULT 0;
	DECLARE
		tt2_pay, tt2_cpc
	DECIMAL(9,5) DEFAULT 0;
	DECLARE
		cl_pay, cl_cpc
	DECIMAL(9,5) DEFAULT 0;
	DECLARE
		cl_ip
	BIGINT DEFAULT 0;
	DECLARE 
		time_client 
	DATETIME;
	DECLARE
		table_name_check, table_name_check2, table_name_check3,
		m_table_name_check, m_table_name_check2, m_table_name_check3,
		cl_ip_text, var_date_name, var_table_name
	VARCHAR (128) DEFAULT '';
	
	DECLARE
		in_cnv, out_cnv, in_offer_click, out_offer_click,in_click,in_clicks_landing
	INT DEFAULT 0;
	DECLARE
		in_pay, out_pay,
		in_cpc, out_cpc
	DECIMAL(9,5) DEFAULT 0;

	/*перебираем доходящие данные*/
	DECLARE cursor_temp_clicks CURSOR FOR 
		SELECT id, click_id, cvr_id, offer_click, pay, cpc, offer, offer_type FROM {data_base}.temp_table WHERE (id >= start_click_id) AND (id <= last_click_id) AND  click_id<=(SELECT dop_info FROM {data_base}.proc_2 WHERE end_date > 0 ORDER BY id DESC LIMIT 0,1) ORDER BY id ASC;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	/*запись лога*/
	CALL {data_base}.time_convert(NOW(),time_client);
	INSERT INTO {data_base}.proc_3(start_date, end_date) VALUES (UNIX_TIMESTAMP(time_client),0);
	SET log_id=(SELECT LAST_INSERT_ID());
	/*----------*/
	OPEN cursor_temp_clicks;
		REPEAT
			FETCH cursor_temp_clicks INTO tt_id, tt_click_id, tt_cvr_id, tt_offer_click, tt_pay, tt_cpc, tt_offer, tt_offer_type;
			IF NOT flag THEN
				SET in_cnv =0; 
				SET out_cnv =0; 
				SET in_offer_click =0; 
				SET out_offer_click =0; 
				SET in_click =0; 
				SET in_clicks_landing =0; 
				SET in_pay =0; 
				SET out_pay =0; 
				SET in_cpc =0; 
				SET out_cpc =0; 
				/*перебор курсора*/
				IF(tt_click_id!=0)THEN
					/*считывание обновляемой информации из clicks*/
					SELECT 
						click_time,
						camp_id,
						offer,
						path_id,
						landing_page,
						cvr_id,
						ts_id,
						rule_id,
						an,
						geo,
						ua,
						publisher,
						referer_domain,
						offer_click,
						offer_type,
						is_bot,
						token,
						pay,
						cpc,
						ip
					INTO 
						cl_click_time, cl_camp_id, cl_offer, cl_path_id, cl_landing_page, 
						cl_cvr_id, cl_ts_id, cl_rule_id, cl_an, cl_geo, 
						cl_ua, cl_publisher, cl_referer_domain, cl_offer_click, cl_offer_type, 
						cl_is_bot, cl_token, cl_pay, cl_cpc, cl_ip
					FROM 
						{data_base}.clicks
					WHERE 
						id = tt_click_id;
					/*производим наложение из temp_table_2*/
					IF((SELECT COUNT(*) FROM {data_base}.temp_table_2 WHERE click_id = tt_click_id)>0)THEN
						SELECT
							id,
							cvr_id,
							offer_click,
							pay,
							cpc,
							offer,
							offer_type
						INTO 
							tt2_id, tt2_cvr_id, tt2_offer_click, tt2_pay, tt2_cpc, tt2_offer, tt2_offer_type
						FROM 
							{data_base}.temp_table_2
						WHERE 
							click_id = tt_click_id
						ORDER BY id DESC
						LIMIT 1;
						/*алгоритм сведения побочных данных*/
						SET cl_cvr_id = tt2_cvr_id;
						SET cl_offer_click = tt2_offer_click;
						SET cl_pay = tt2_pay;
						SET cl_cpc = tt2_cpc;
						IF(tt2_offer!=cl_offer AND tt2_offer!=0)THEN
							SET cl_offer=tt2_offer;
							SET cl_offer_type=tt2_offer_type;
							IF(tt2_offer_type=3)THEN
								SET cl_an=(SELECT network FROM offers WHERE id = cl_offer);
							ELSE
								SET cl_an = 0;
							END IF;
						END IF;
					END IF;
					/*чекаем наличие всех таблиц*/
					SET tokens_on=(SELECT tokens FROM traffic_sources WHERE id = cl_ts_id);
					SET table_name_check = CONCAT('report_camp_',cl_camp_id,'_',FROM_UNIXTIME(cl_click_time, '%d%m%Y'));  
					SET table_name_check2 = CONCAT('report_camp_ip_',cl_camp_id,'_',FROM_UNIXTIME(cl_click_time, '%d%m%Y'));
					SET table_name_check3 = CONCAT('report_camp_token_',cl_camp_id,'_',FROM_UNIXTIME(cl_click_time, '%d%m%Y'));  
					SET m_table_name_check = CONCAT('month_report_camp_',cl_camp_id,'_',FROM_UNIXTIME(cl_click_time, '%m%Y'));  
					SET m_table_name_check2 = CONCAT('month_report_camp_ip_',cl_camp_id,'_',FROM_UNIXTIME(cl_click_time, '%m%Y'));
					SET m_table_name_check3 = CONCAT('month_report_camp_token_',cl_camp_id,'_',FROM_UNIXTIME(cl_click_time, '%m%Y')); 
					SET check_all_table=(SELECT COUNT(*) FROM information_schema.tables WHERE (table_name = table_name_check OR table_name = table_name_check2 OR table_name = table_name_check3) AND table_schema = '{data_base}');
					IF(((tokens_on=1 AND check_all_table>2) OR (tokens_on!=1 AND check_all_table>1)) AND cl_click_time IS NOT NULL)THEN
						/*имеем новые данные в tt и корректные старые данные в cl, все таблицы для записи присутствуют*/
						/*фиксируем приход с мультиофферности*/
						/*формируем идентификаторы конверсий*/
						IF(cl_cvr_id>0)THEN
							SET cl_cvr_id_temp=1;
						ELSE
							SET cl_cvr_id_temp=0;
						END IF;
						IF(tt_cvr_id>0)THEN
							SET tt_cvr_id_temp=1;
						ELSE
							SET tt_cvr_id_temp=0;
						END IF;
						/*----------------------*/
						/*считаем что данные пришли с изменением оффера*/
						IF(tt_offer!=0 AND tt_offer!=cl_offer)THEN
							SET in_click=1;
							/*чекаем измененные параметры, записывая их в переменные с индексом in и out*/
							/*конверсии и выплаты*/
							IF(cl_cvr_id_temp!=tt_cvr_id_temp)THEN
								IF(tt_cvr_id_temp>cl_cvr_id_temp)THEN
									/*добавление конверсии*/
									SET in_cnv=1;
									SET in_pay=tt_pay;
									SET out_cnv=0;
								ELSE
									/*убираем конверсию*/
									SET in_cnv=0;
									SET out_cnv=1;
									SET out_pay=cl_pay;
								END IF;
							ELSE
								/*конверсия не изменилась, но могла перенестись к другому офферу*/
								IF(cl_cvr_id_temp=1)THEN
									SET in_cnv=1;
									SET out_cnv=1;
									SET out_pay=cl_pay;
									SET in_pay=tt_pay;
								END IF;
							END IF;
							/*cpc, при смене оффера изменяется обязательно*/
							SET in_cpc=tt_cpc;
							SET out_cpc=cl_cpc;
							/*чекаем переход на оффер. Имеет значение при первом переходе*/
							IF(cl_offer_click!=0)THEN
								SET in_offer_click=1;
								SET out_offer_click=1;
							ELSE
								SET in_offer_click=1;
								SET out_offer_click=0;
							END IF;
						ELSE
							/*определяем условия для обычных доходящих данных*/
							/*доход/обновление конверсии*/
							SET in_click=0;
							IF(tt_cvr_id_temp=1 AND cl_cvr_id_temp=0)THEN
								SET in_cnv=1;
								SET in_pay=tt_pay;
							ELSE
								IF(cl_cvr_id_temp=1)THEN
									SET in_cnv=0;
									SET in_pay=tt_pay-cl_pay;
								END IF;
							END IF;
							/*доход информации о переходе на оффер*/
							IF(tt_offer_click>cl_offer_click)THEN
								SET in_offer_click=1;
							ELSE
								SET in_offer_click=0;
							END IF;
							/*обновление cpc, старая функция для update costs по токенам*/
							IF(cl_cpc!=tt_cpc)THEN
								SET in_cpc=tt_cpc-cl_cpc;
							ELSE
								SET in_cpc=0;
							END IF;
						END IF;
						/*Добиваем дополнительные данные для витрин*/
						SET cl_hour_click = FROM_UNIXTIME(cl_click_time, '%H');
						SET cl_day_week = FROM_UNIXTIME(cl_click_time, '%w');
						/*SELECT isp, country, `type` INTO cl_isp, cl_country, cl_geo_type FROM {data_base}.base_geo WHERE id = cl_geo;*/
						/*фикс для старых баз*/
						IF((SELECT COUNT(*) FROM base_geo WHERE id = cl_geo)=0)THEN
							SELECT isp, country, `type` INTO cl_isp, cl_country, cl_geo_type FROM {data_base}.base_geo_old WHERE id = cl_geo;
						ELSE
							SELECT isp, country, `type` INTO cl_isp, cl_country, cl_geo_type FROM {data_base}.base_geo WHERE id = cl_geo;
						END IF;
						/*-------------------*/
						SET check_agent = (SELECT COUNT(*) FROM {data_base}.user_agents WHERE id = cl_ua);
						IF(check_agent>0)THEN
							SELECT  os, browser, device_model_id, device_brand_id, device_lang_id, device_td1_id, device_td2_id, device_td3_id, device_td4_id
							INTO cl_os,cl_browser,cl_model,cl_brand,cl_lang,cl_td1,cl_td2,cl_td3,cl_td4
							FROM {data_base}.user_agents
							WHERE id = cl_ua;
						ELSE
							SET cl_os = 0;
							SET cl_browser = 0;
							SET cl_model = 0;
							SET cl_brand = 0;
							SET cl_lang = 0;
							SET cl_td1 = 0;
							SET cl_td2 = 0;
							SET cl_td3 = 0;
							SET cl_td4 = 0;
						END IF;
						IF(tokens_on=1 AND (SELECT COUNT(*) FROM {data_base}.clicks_tokens WHERE click_id = tt_click_id)>0)THEN
							SELECT 
								t1,t2,t3,t4,t5,t6,t7,t8,t9,t10
							INTO 
								cl_t1, cl_t2, cl_t3, cl_t4, cl_t5, cl_t6, cl_t7, cl_t8, cl_t9, cl_t10
							FROM 
								{data_base}.clicks_tokens
							WHERE 
								click_id = tt_click_id LIMIT 0,1;
						ELSE
							SET tokens_on = 0;
						END IF;
						CALL {data_base}.ip_convert(cl_ip, cl_ip_text, cl_ip_1, cl_ip_2, cl_ip_3, cl_ip_4);
						/*выполняем out*/
						IF(tt_offer!=0 AND tt_offer!=cl_offer)THEN
							SET i = 1;
							WHILE i < 4 DO
								/*перебираем типы дат*/
								CASE i  
									WHEN 1 THEN  
										SET var_date_name = FROM_UNIXTIME(cl_click_time, '%d%m%Y');  
									WHEN 2 THEN  
										SET var_date_name = FROM_UNIXTIME(cl_click_time, '%m%Y'); 
									ELSE  
										SET var_date_name = FROM_UNIXTIME(cl_click_time, '%Y');  
								END CASE;  
								/*перебираем типы общих витрин*/
								SET i2 = 1;
								WHILE i2 < 6 DO  
									CASE i2  
										WHEN 1 THEN  
											SET var_table_name = '{data_base}.showcase_campaigns';
											SET var_el_id = cl_camp_id;
											SET test_int1=test_int1+in_click;
										WHEN 2 THEN  
											SET var_table_name = '{data_base}.showcase_landings';
											SET var_el_id = cl_landing_page;
										WHEN 3 THEN  
											SET var_table_name = '{data_base}.showcase_networks';
											SET var_el_id = cl_an;
										WHEN 4 THEN  
											SET var_table_name = '{data_base}.showcase_offers';
											SET var_el_id = cl_offer;
										ELSE  
											SET var_table_name = '{data_base}.showcase_sources';
											SET var_el_id = cl_ts_id; 
									END CASE; 
									/*вычитаем*/
									SET @report_update_temp_sql_update_showcase = CONCAT('UPDATE ', var_table_name, ' SET clicks_offer = clicks_offer - ', out_offer_click, ', leads = leads - ', out_cnv, ', spend = spend - ', out_cpc, ', pay = pay - ', out_pay, ', clicks=clicks-',in_click,', clicks_landing=clicks_landing-1 WHERE el_id = ', var_el_id, ' AND date_name = ', var_date_name, ' AND camp_id = ',cl_camp_id);
									PREPARE update_1 FROM @report_update_temp_sql_update_showcase;
									EXECUTE update_1;
									DEALLOCATE PREPARE update_1;
									SET i2 = i2 + 1;
								END WHILE; 
								SET i = i + 1;
							END WHILE;
							/*вычитание из общих витрин произведено*/
							/*корректируем данные в репортах*/
							/*репорты первого вида*/
							SET @report_update_temp_sql_check_1 = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_zp FROM ', table_name_check, ' WHERE 
										hour_click = ',cl_hour_click,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										country = ',cl_country,' AND 
										geo_type = ',cl_geo_type,' AND 
										model = ',cl_model,' AND 
										brand = ',cl_brand,' AND 
										lang = ',cl_lang,' AND 
										td1 = ',cl_td1,' AND 
										td2 = ',cl_td2,' AND 
										td3 = ',cl_td3,' AND 
										td4 = ',cl_td4,' AND 
										os = ',cl_os,' AND 
										publisher = ',cl_publisher,' AND 
										referer_domain = ',cl_referer_domain,' AND 
										browser =',cl_browser,'  AND 
										ua = ',cl_ua);
							PREPARE check_1 FROM @report_update_temp_sql_check_1;
							EXECUTE check_1;
							DEALLOCATE PREPARE check_1;
							IF(@report_update_temp_check_report_zp > 0) THEN
								SET @report_update_temp_sql_update_report = CONCAT('UPDATE ', table_name_check, ' SET clicks_offer = clicks_offer - ', out_offer_click, ', leads = leads - ', out_cnv, ', spend = spend - ', out_cpc, ', pay = pay - ', out_pay, ', clicks=clicks-',in_click,', clicks_landing=clicks_landing-1 WHERE 
										hour_click = ',cl_hour_click,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										country = ',cl_country,' AND 
										geo_type = ',cl_geo_type,' AND 
										model = ',cl_model,' AND 
										brand = ',cl_brand,' AND 
										lang = ',cl_lang,' AND 
										td1 = ',cl_td1,' AND 
										td2 = ',cl_td2,' AND 
										td3 = ',cl_td3,' AND 
										td4 = ',cl_td4,' AND 
										os = ',cl_os,' AND 
										publisher = ',cl_publisher,' AND 
										referer_domain = ',cl_referer_domain,' AND 
										browser =',cl_browser,'  AND 
										ua = ',cl_ua);
								PREPARE update_3 FROM @report_update_temp_sql_update_report;
								EXECUTE update_3;
								DEALLOCATE PREPARE update_3;
							END IF;
							
							/*корректируем репорты по ip*/
							SET @report_update_temp_sql_check_2 = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_ip FROM ', table_name_check2, ' WHERE 
										hour_click = ',cl_hour_click,' AND 
										ip_2 = ',cl_ip_2,' AND 
										ip_3 = ',cl_ip_3,' AND 
										ip_4 = ',cl_ip_4,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										geo_type = ',cl_geo_type,' AND 
										country = ',cl_country,' AND 
										model = ',cl_model,' AND 
										brand = ',cl_brand,' AND 
										lang = ',cl_lang,' AND 
										td1 = ',cl_td1,' AND 
										td2 = ',cl_td2,' AND 
										td3 = ',cl_td3,' AND 
										td4 = ',cl_td4,' AND 
										os = ',cl_os,' AND 
										browser =',cl_browser,'  AND 
										publisher =',cl_publisher,'  AND 
										referer_domain = ',cl_referer_domain,' AND 
										ua = ',cl_ua);
							PREPARE check_2 FROM @report_update_temp_sql_check_2;
							EXECUTE check_2;
							DEALLOCATE PREPARE check_2;
							IF(@report_update_temp_check_report_ip > 0) THEN
								SET @report_update_temp_sql_update_report_ip = CONCAT('UPDATE ', table_name_check2, ' SET clicks_offer = clicks_offer - ', out_offer_click, ', leads = leads - ', out_cnv, ', spend = spend - ', out_cpc, ', pay = pay - ', out_pay, ', clicks=clicks-',in_click,', clicks_landing=clicks_landing-1 WHERE 
										hour_click = ',cl_hour_click,' AND 
										ip_2 = ',cl_ip_2,' AND 
										ip_3 = ',cl_ip_3,' AND 
										ip_4 = ',cl_ip_4,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										geo_type = ',cl_geo_type,' AND 
										country = ',cl_country,' AND 
										model = ',cl_model,' AND 
										brand = ',cl_brand,' AND 
										lang = ',cl_lang,' AND 
										td1 = ',cl_td1,' AND 
										td2 = ',cl_td2,' AND 
										td3 = ',cl_td3,' AND 
										td4 = ',cl_td4,' AND 
										os = ',cl_os,' AND 
										browser =',cl_browser,'  AND 
										publisher =',cl_publisher,'  AND 
										referer_domain = ',cl_referer_domain,' AND 
										ua = ',cl_ua);
								PREPARE update_4 FROM @report_update_temp_sql_update_report_ip;
								EXECUTE update_4;
								DEALLOCATE PREPARE update_4;
							END IF;
							
							/*корректируем репорты по токенам, если они есть*/
							IF(tokens_on=1)THEN	  	
								SET @report_update_temp_sql_check_token = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_token FROM ', table_name_check3, ' WHERE 
											hour_click = ',cl_hour_click,' AND 
											day_week = ',cl_day_week,' AND 
											offer = ',cl_offer,' AND 
											path_id = ',cl_path_id,' AND 
											landing_page =',cl_landing_page,'  AND 
											ts_id = ',cl_ts_id,' AND 
											rule_id = ',cl_rule_id,' AND 
											offer_type = ',cl_offer_type,' AND 
											an = ',cl_an,' AND 
											isp = ',cl_isp,' AND 
											country = ',cl_country,' AND 
											geo_type = ',cl_geo_type,' AND 
											t1 = ',cl_t1,' AND 
											t2 = ',cl_t2,' AND 
											t3 = ',cl_t3,' AND 
											t4 = ',cl_t4,' AND 
											t5 = ',cl_t5,' AND 
											t6 = ',cl_t6,' AND 
											t7 = ',cl_t7,' AND 
											t8 = ',cl_t8,' AND 
											t9 = ',cl_t9,' AND 
											t10 = ',cl_t10);
								PREPARE check_1 FROM @report_update_temp_sql_check_token;
								EXECUTE check_1;
								DEALLOCATE PREPARE check_1;
								IF(@report_update_temp_check_report_token > 0) THEN
									SET @report_update_temp_sql_update_report = CONCAT('UPDATE ', table_name_check3, ' SET clicks_offer = clicks_offer - ', out_offer_click, ', leads = leads - ', out_cnv, ', spend = spend - ', out_cpc, ', pay = pay - ', out_pay, ', clicks=clicks-',in_click,', clicks_landing=clicks_landing-1 WHERE 
											hour_click = ',cl_hour_click,' AND 
											day_week = ',cl_day_week,' AND 
											offer = ',cl_offer,' AND 
											path_id = ',cl_path_id,' AND 
											landing_page =',cl_landing_page,'  AND 
											ts_id = ',cl_ts_id,' AND 
											rule_id = ',cl_rule_id,' AND 
											offer_type = ',cl_offer_type,' AND 
											an = ',cl_an,' AND 
											isp = ',cl_isp,' AND 
											country = ',cl_country,' AND 
											geo_type = ',cl_geo_type,' AND 
											t1 = ',cl_t1,' AND 
											t2 = ',cl_t2,' AND 
											t3 = ',cl_t3,' AND 
											t4 = ',cl_t4,' AND 
											t5 = ',cl_t5,' AND 
											t6 = ',cl_t6,' AND 
											t7 = ',cl_t7,' AND 
											t8 = ',cl_t8,' AND 
											t9 = ',cl_t9,' AND 
											t10 = ',cl_t10);
									PREPARE update_3 FROM @report_update_temp_sql_update_report;
									EXECUTE update_3;
									DEALLOCATE PREPARE update_3;
								END IF;
							END IF;	
							/*корректировка данных мультиофферности завершена*/
							/*корректируем переменные для алгоритмов включения данных*/
							SET cl_offer=tt_offer;
							SET cl_offer_type=tt_offer_type;
							IF(cl_offer_type=3)THEN
								SET cl_an=(SELECT network FROM offers WHERE id = cl_offer);
							ELSE
								SET cl_an=0;
							END IF;
							SET in_clicks_landing=1;
						END IF;
						
						/*применяем доходящие данные к общим статистикам*/
						SET i = 1;
						WHILE i < 4 DO
							CASE i  
								WHEN 1 THEN  
									SET var_date_name = FROM_UNIXTIME(cl_click_time, '%d%m%Y');  
								WHEN 2 THEN  
									SET var_date_name = FROM_UNIXTIME(cl_click_time, '%m%Y'); 
								ELSE  
									SET var_date_name = FROM_UNIXTIME(cl_click_time, '%Y');  
							END CASE;  
							SET i2 = 1;
							WHILE i2 < 6 DO  
								CASE i2  
									WHEN 1 THEN  
										SET var_table_name = '{data_base}.showcase_campaigns';
										SET var_el_id = cl_camp_id;
										SET test_int2=test_int2+in_click;
									WHEN 2 THEN  
										SET var_table_name = '{data_base}.showcase_landings';
										SET var_el_id = cl_landing_page;
									WHEN 3 THEN  
										SET var_table_name = '{data_base}.showcase_networks';
										SET var_el_id = cl_an;
									WHEN 4 THEN  
										SET var_table_name = '{data_base}.showcase_offers';
										SET var_el_id = cl_offer;
									ELSE  
										SET var_table_name = '{data_base}.showcase_sources';
										SET var_el_id = cl_ts_id; 
								END CASE; 
								SET @report_update_temp_sql_update_showcase = CONCAT('UPDATE ', var_table_name, ' SET clicks = clicks + ',in_click,', clicks_landing = clicks_landing + ',in_clicks_landing,', clicks_offer = clicks_offer + ', in_offer_click, ', leads = leads + ', in_cnv, ', spend = spend + ', in_cpc, ', pay = pay + ', in_pay, ' WHERE el_id = ', var_el_id, ' AND date_name = ', var_date_name, ' AND camp_id = ',cl_camp_id);
								PREPARE update_1 FROM @report_update_temp_sql_update_showcase;
								EXECUTE update_1;
								DEALLOCATE PREPARE update_1;
								SET i2 = i2 + 1;
							END WHILE; 
							SET i = i + 1;
						END WHILE;
						
						/*заполняем репорты*/
						/*общие репорты*/
						SET @report_update_temp_sql_check_1 = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_zp FROM ', table_name_check, ' WHERE 
									hour_click = ',cl_hour_click,' AND 
									day_week = ',cl_day_week,' AND 
									offer = ',cl_offer,' AND 
									path_id = ',cl_path_id,' AND 
									landing_page =',cl_landing_page,'  AND 
									ts_id = ',cl_ts_id,' AND 
									rule_id = ',cl_rule_id,' AND 
									offer_type = ',cl_offer_type,' AND 
									an = ',cl_an,' AND 
									isp = ',cl_isp,' AND 
									country = ',cl_country,' AND 
									geo_type = ',cl_geo_type,' AND 
									model = ',cl_model,' AND 
									brand = ',cl_brand,' AND 
									lang = ',cl_lang,' AND 
									td1 = ',cl_td1,' AND 
									td2 = ',cl_td2,' AND 
									td3 = ',cl_td3,' AND 
									td4 = ',cl_td4,' AND 
									os = ',cl_os,' AND 
									publisher = ',cl_publisher,' AND 
									referer_domain = ',cl_referer_domain,' AND 
									browser =',cl_browser,'  AND 
									ua = ',cl_ua);
						PREPARE check_1 FROM @report_update_temp_sql_check_1;
						EXECUTE check_1;
						DEALLOCATE PREPARE check_1;
						IF(@report_update_temp_check_report_zp > 0) THEN
							SET @report_update_temp_sql_update_report = CONCAT('UPDATE ', table_name_check, ' SET  clicks = clicks + ',in_click,', clicks_landing = clicks_landing + ',in_clicks_landing,', clicks_offer = clicks_offer + ', in_offer_click, ', leads = leads + ', in_cnv, ', spend = spend + ', in_cpc, ', pay = pay + ', in_pay, ' WHERE 
									hour_click = ',cl_hour_click,' AND 
									day_week = ',cl_day_week,' AND 
									offer = ',cl_offer,' AND 
									path_id = ',cl_path_id,' AND 
									landing_page =',cl_landing_page,'  AND 
									ts_id = ',cl_ts_id,' AND 
									rule_id = ',cl_rule_id,' AND 
									offer_type = ',cl_offer_type,' AND 
									an = ',cl_an,' AND 
									isp = ',cl_isp,' AND 
									country = ',cl_country,' AND 
									geo_type = ',cl_geo_type,' AND 
									model = ',cl_model,' AND 
									brand = ',cl_brand,' AND 
									lang = ',cl_lang,' AND 
									td1 = ',cl_td1,' AND 
									td2 = ',cl_td2,' AND 
									td3 = ',cl_td3,' AND 
									td4 = ',cl_td4,' AND 
									os = ',cl_os,' AND 
									publisher = ',cl_publisher,' AND 
									referer_domain = ',cl_referer_domain,' AND 
									browser =',cl_browser,'  AND 
									ua = ',cl_ua);
							PREPARE update_3 FROM @report_update_temp_sql_update_report;
							EXECUTE update_3;
							DEALLOCATE PREPARE update_3;
						END IF;
						/*добиваем инфой за месяц*/
						SET m_check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE (table_name = m_table_name_check) AND table_schema = '{data_base}');
						IF(m_check_table>0)THEN
							SET @report_update_temp_sql_check_1 = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_zp FROM ', m_table_name_check, ' WHERE 
									hour_click = ',cl_hour_click,' AND 
									day_week = ',cl_day_week,' AND 
									offer = ',cl_offer,' AND 
									path_id = ',cl_path_id,' AND 
									landing_page =',cl_landing_page,'  AND 
									ts_id = ',cl_ts_id,' AND 
									rule_id = ',cl_rule_id,' AND 
									offer_type = ',cl_offer_type,' AND 
									an = ',cl_an,' AND 
									isp = ',cl_isp,' AND 
									country = ',cl_country,' AND 
									geo_type = ',cl_geo_type,' AND 
									model = ',cl_model,' AND 
									brand = ',cl_brand,' AND 
									lang = ',cl_lang,' AND 
									td1 = ',cl_td1,' AND 
									td2 = ',cl_td2,' AND 
									td3 = ',cl_td3,' AND 
									td4 = ',cl_td4,' AND 
									os = ',cl_os,' AND 
									publisher = ',cl_publisher,' AND 
									referer_domain = ',cl_referer_domain,' AND 
									browser =',cl_browser,'  AND 
									ua = ',cl_ua);
							PREPARE check_1 FROM @report_update_temp_sql_check_1;
							EXECUTE check_1;
							DEALLOCATE PREPARE check_1;
							IF(@report_update_temp_check_report_zp > 0) THEN
								SET @report_update_temp_sql_update_report = CONCAT('UPDATE ', m_table_name_check, ' SET  clicks_offer = clicks_offer + ', in_offer_click, ', leads = leads + ', in_cnv, ', spend = spend + ', in_cpc, ', pay = pay + ', in_pay, ' WHERE 
										hour_click = ',cl_hour_click,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										country = ',cl_country,' AND 
										geo_type = ',cl_geo_type,' AND 
										model = ',cl_model,' AND 
										brand = ',cl_brand,' AND 
										lang = ',cl_lang,' AND 
										td1 = ',cl_td1,' AND 
										td2 = ',cl_td2,' AND 
										td3 = ',cl_td3,' AND 
										td4 = ',cl_td4,' AND 
										os = ',cl_os,' AND 
										publisher = ',cl_publisher,' AND 
										referer_domain = ',cl_referer_domain,' AND 
										browser =',cl_browser,'  AND 
										ua = ',cl_ua);
								PREPARE update_3 FROM @report_update_temp_sql_update_report;
								EXECUTE update_3;
								DEALLOCATE PREPARE update_3;
							END IF;
						END IF;
						
						/*заполняем инфу по ip*/
						SET @report_update_temp_sql_check_2 = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_ip FROM ', table_name_check2, ' WHERE 
									hour_click = ',cl_hour_click,' AND 
									ip_2 = ',cl_ip_2,' AND 
									ip_3 = ',cl_ip_3,' AND 
									ip_4 = ',cl_ip_4,' AND 
									day_week = ',cl_day_week,' AND 
									offer = ',cl_offer,' AND 
									path_id = ',cl_path_id,' AND 
									landing_page =',cl_landing_page,'  AND 
									ts_id = ',cl_ts_id,' AND 
									rule_id = ',cl_rule_id,' AND 
									offer_type = ',cl_offer_type,' AND 
									an = ',cl_an,' AND 
									isp = ',cl_isp,' AND 
									geo_type = ',cl_geo_type,' AND 
									country = ',cl_country,' AND 
									model = ',cl_model,' AND 
									brand = ',cl_brand,' AND 
									lang = ',cl_lang,' AND 
									td1 = ',cl_td1,' AND 
									td2 = ',cl_td2,' AND 
									td3 = ',cl_td3,' AND 
									td4 = ',cl_td4,' AND 
									os = ',cl_os,' AND 
									browser =',cl_browser,'  AND 
									publisher =',cl_publisher,'  AND 
									referer_domain = ',cl_referer_domain,' AND 
									ua = ',cl_ua);
						PREPARE check_2 FROM @report_update_temp_sql_check_2;
						EXECUTE check_2;
						DEALLOCATE PREPARE check_2;
						IF(@report_update_temp_check_report_ip > 0) THEN
							SET @report_update_temp_sql_update_report_ip = CONCAT('UPDATE ', table_name_check2, ' SET clicks = clicks + ',in_click,', clicks_landing = clicks_landing + ',in_clicks_landing,', clicks_offer = clicks_offer + ', in_offer_click, ', leads = leads + ', in_cnv, ', spend = spend + ', in_cpc, ', pay = pay + ', in_pay, ' WHERE 
									hour_click = ',cl_hour_click,' AND 
									ip_2 = ',cl_ip_2,' AND 
									ip_3 = ',cl_ip_3,' AND 
									ip_4 = ',cl_ip_4,' AND 
									day_week = ',cl_day_week,' AND 
									offer = ',cl_offer,' AND 
									path_id = ',cl_path_id,' AND 
									landing_page =',cl_landing_page,'  AND 
									ts_id = ',cl_ts_id,' AND 
									rule_id = ',cl_rule_id,' AND 
									offer_type = ',cl_offer_type,' AND 
									an = ',cl_an,' AND 
									isp = ',cl_isp,' AND 
									geo_type = ',cl_geo_type,' AND 
									country = ',cl_country,' AND 
									model = ',cl_model,' AND 
									brand = ',cl_brand,' AND 
									lang = ',cl_lang,' AND 
									td1 = ',cl_td1,' AND 
									td2 = ',cl_td2,' AND 
									td3 = ',cl_td3,' AND 
									td4 = ',cl_td4,' AND 
									os = ',cl_os,' AND 
									browser =',cl_browser,'  AND 
									publisher =',cl_publisher,'  AND 
									referer_domain = ',cl_referer_domain,' AND 
									ua = ',cl_ua);
							PREPARE update_4 FROM @report_update_temp_sql_update_report_ip;
							EXECUTE update_4;
							DEALLOCATE PREPARE update_4;
						END IF;
						SET m_check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE (table_name = m_table_name_check2) AND table_schema = '{data_base}');
						IF(m_check_table>0)THEN
							SET @report_update_temp_sql_check_2 = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_ip FROM ', m_table_name_check2, ' WHERE 
										hour_click = ',cl_hour_click,' AND 
										ip_2 = ',cl_ip_2,' AND 
										ip_3 = ',cl_ip_3,' AND 
										ip_4 = ',cl_ip_4,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										geo_type = ',cl_geo_type,' AND 
										country = ',cl_country,' AND 
										model = ',cl_model,' AND 
										brand = ',cl_brand,' AND 
										lang = ',cl_lang,' AND 
										td1 = ',cl_td1,' AND 
										td2 = ',cl_td2,' AND 
										td3 = ',cl_td3,' AND 
										td4 = ',cl_td4,' AND 
										os = ',cl_os,' AND 
										browser =',cl_browser,'  AND 
										publisher =',cl_publisher,'  AND 
										referer_domain = ',cl_referer_domain,' AND 
										ua = ',cl_ua);
							PREPARE check_2 FROM @report_update_temp_sql_check_2;
							EXECUTE check_2;
							DEALLOCATE PREPARE check_2;
							IF(@report_update_temp_check_report_ip > 0) THEN
								SET @report_update_temp_sql_update_report_ip = CONCAT('UPDATE ', m_table_name_check2, ' SET clicks_offer = clicks_offer + ', in_offer_click, ', leads = leads + ', in_cnv, ', spend = spend + ', in_cpc, ', pay = pay + ', in_pay, ' WHERE 
										hour_click = ',cl_hour_click,' AND 
										ip_2 = ',cl_ip_2,' AND 
										ip_3 = ',cl_ip_3,' AND 
										ip_4 = ',cl_ip_4,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										geo_type = ',cl_geo_type,' AND 
										country = ',cl_country,' AND 
										model = ',cl_model,' AND 
										brand = ',cl_brand,' AND 
										lang = ',cl_lang,' AND 
										td1 = ',cl_td1,' AND 
										td2 = ',cl_td2,' AND 
										td3 = ',cl_td3,' AND 
										td4 = ',cl_td4,' AND 
										os = ',cl_os,' AND 
										browser =',cl_browser,'  AND 
										publisher =',cl_publisher,'  AND 
										referer_domain = ',cl_referer_domain,' AND 
										ua = ',cl_ua);
								PREPARE update_4 FROM @report_update_temp_sql_update_report_ip;
								EXECUTE update_4;
								DEALLOCATE PREPARE update_4;
							END IF;
						END IF;
						
						/*заполняем информацию по токенам, при условии, что таковые имеются :)*/
						IF(tokens_on=1)THEN	  	
							SET @report_update_temp_sql_check_token = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_token FROM ', table_name_check3, ' WHERE 
										hour_click = ',cl_hour_click,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										country = ',cl_country,' AND 
										geo_type = ',cl_geo_type,' AND 
										t1 = ',cl_t1,' AND 
										t2 = ',cl_t2,' AND 
										t3 = ',cl_t3,' AND 
										t4 = ',cl_t4,' AND 
										t5 = ',cl_t5,' AND 
										t6 = ',cl_t6,' AND 
										t7 = ',cl_t7,' AND 
										t8 = ',cl_t8,' AND 
										t9 = ',cl_t9,' AND 
										t10 = ',cl_t10);
							PREPARE check_1 FROM @report_update_temp_sql_check_token;
							EXECUTE check_1;
							DEALLOCATE PREPARE check_1;
							IF(@report_update_temp_check_report_token > 0) THEN
								SET @report_update_temp_sql_update_report = CONCAT('UPDATE ', table_name_check3, ' SET clicks = clicks + ',in_click,', clicks_landing = clicks_landing + ',in_clicks_landing,', clicks_offer = clicks_offer + ', in_offer_click, ', leads = leads + ', in_cnv, ', spend = spend + ', in_cpc, ', pay = pay + ', in_pay, ' WHERE 
										hour_click = ',cl_hour_click,' AND 
										day_week = ',cl_day_week,' AND 
										offer = ',cl_offer,' AND 
										path_id = ',cl_path_id,' AND 
										landing_page =',cl_landing_page,'  AND 
										ts_id = ',cl_ts_id,' AND 
										rule_id = ',cl_rule_id,' AND 
										offer_type = ',cl_offer_type,' AND 
										an = ',cl_an,' AND 
										isp = ',cl_isp,' AND 
										country = ',cl_country,' AND 
										geo_type = ',cl_geo_type,' AND 
										t1 = ',cl_t1,' AND 
										t2 = ',cl_t2,' AND 
										t3 = ',cl_t3,' AND 
										t4 = ',cl_t4,' AND 
										t5 = ',cl_t5,' AND 
										t6 = ',cl_t6,' AND 
										t7 = ',cl_t7,' AND 
										t8 = ',cl_t8,' AND 
										t9 = ',cl_t9,' AND 
										t10 = ',cl_t10);
								PREPARE update_3 FROM @report_update_temp_sql_update_report;
								EXECUTE update_3;
								DEALLOCATE PREPARE update_3;
							END IF;
							SET m_check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE (table_name = m_table_name_check3) AND table_schema = '{data_base}');
							IF(m_check_table>0)THEN
								SET @report_update_temp_sql_check_token = CONCAT('SELECT COUNT(*) INTO @report_update_temp_check_report_token FROM ', m_table_name_check3, ' WHERE 
											hour_click = ',cl_hour_click,' AND 
											day_week = ',cl_day_week,' AND 
											offer = ',cl_offer,' AND 
											path_id = ',cl_path_id,' AND 
											landing_page =',cl_landing_page,'  AND 
											ts_id = ',cl_ts_id,' AND 
											rule_id = ',cl_rule_id,' AND 
											offer_type = ',cl_offer_type,' AND 
											an = ',cl_an,' AND 
											isp = ',cl_isp,' AND 
											country = ',cl_country,' AND 
											geo_type = ',cl_geo_type,' AND 
											t1 = ',cl_t1,' AND 
											t2 = ',cl_t2,' AND 
											t3 = ',cl_t3,' AND 
											t4 = ',cl_t4,' AND 
											t5 = ',cl_t5,' AND 
											t6 = ',cl_t6,' AND 
											t7 = ',cl_t7,' AND 
											t8 = ',cl_t8,' AND 
											t9 = ',cl_t9,' AND 
											t10 = ',cl_t10);
								PREPARE check_1 FROM @report_update_temp_sql_check_token;
								EXECUTE check_1;
								DEALLOCATE PREPARE check_1;
								IF(@report_update_temp_check_report_token > 0) THEN
									SET @report_update_temp_sql_update_report = CONCAT('UPDATE ', m_table_name_check3, ' SET clicks_offer = clicks_offer + ', in_offer_click, ', leads = leads + ', in_cnv, ', spend = spend + ', in_cpc, ', pay = pay + ', in_pay, ' WHERE 
											hour_click = ',cl_hour_click,' AND 
											day_week = ',cl_day_week,' AND 
											offer = ',cl_offer,' AND 
											path_id = ',cl_path_id,' AND 
											landing_page =',cl_landing_page,'  AND 
											ts_id = ',cl_ts_id,' AND 
											rule_id = ',cl_rule_id,' AND 
											offer_type = ',cl_offer_type,' AND 
											an = ',cl_an,' AND 
											isp = ',cl_isp,' AND 
											country = ',cl_country,' AND 
											geo_type = ',cl_geo_type,' AND 
											t1 = ',cl_t1,' AND 
											t2 = ',cl_t2,' AND 
											t3 = ',cl_t3,' AND 
											t4 = ',cl_t4,' AND 
											t5 = ',cl_t5,' AND 
											t6 = ',cl_t6,' AND 
											t7 = ',cl_t7,' AND 
											t8 = ',cl_t8,' AND 
											t9 = ',cl_t9,' AND 
											t10 = ',cl_t10);
									PREPARE update_3 FROM @report_update_temp_sql_update_report;
									EXECUTE update_3;
									DEALLOCATE PREPARE update_3;
								END IF;
							END IF;
						END IF;	
						/*перебрасываем на редактирование clicks*/
						INSERT INTO temp_table_2(click_id, cvr_id, offer_click, pay, cpc, offer, offer_type) VALUES (tt_click_id,tt_cvr_id,tt_offer_click,tt_pay,tt_cpc,tt_offer,tt_offer_type);
						DELETE FROM {data_base}.temp_table WHERE id = tt_id;
					ELSE
						INSERT INTO temp_table_err(click_id, cvr_id, offer_click, pay, cpc, info) VALUES (tt_click_id, tt_cvr_id, tt_offer_click, tt_pay, tt_cpc,CONCAT('tokens_on=',tokens_on,';check_all_table=',check_all_table,';var_click_time=',cl_click_time,''));
						DELETE FROM {data_base}.temp_table WHERE id = tt_id;
					END IF;
				ELSE
					INSERT INTO temp_table_err(click_id, cvr_id, offer_click, pay, cpc, info) VALUES (tt_click_id, tt_cvr_id, tt_offer_click, tt_pay, tt_cpc,'click_id=0');
					DELETE FROM {data_base}.temp_table WHERE id = tt_id;
				END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_temp_clicks;
	/*запись лога*/
	CALL {data_base}.time_convert(NOW(),time_client);
	UPDATE {data_base}.proc_3 SET end_date=UNIX_TIMESTAMP(time_client) WHERE id = log_id;
	/*----------*/
END
<next>
CREATE PROCEDURE report_update_token_m (IN var_id INT, IN var_click_time INT, IN var_camp_id INT, IN var_path_id INT, IN var_landing_page INT, IN var_ts_id INT, IN var_rule_id INT, IN var_geo INT, IN var_table_name VARCHAR(64)) BEGIN
	/*Binom 11000 1.1*/
	DECLARE var_isp, var_country, var_geo_type, flag, var_path_com, var_offer_type, var_offer,var_an INT DEFAULT 0;
	DECLARE var_t1, var_t2, var_t3, var_t4, var_t5, var_t6, var_t7, var_t8, var_t9, var_t10 INT DEFAULT 0;
	DECLARE  var_hour_click, var_day_week INT;
	DECLARE var_id_t VARCHAR(512);
	DECLARE cursor_m1 CURSOR FOR 
		SELECT id,id_t,`type` FROM path_com WHERE path_id = var_path_id AND (`type`=3 OR `type`=4 OR `type`=5);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_m1;
		REPEAT
			FETCH cursor_m1 INTO var_path_com, var_id_t, var_offer_type;
			IF NOT flag THEN
				IF(var_offer_type=3)THEN
					SET var_an = (SELECT network FROM offers WHERE id = var_id_t);
				ELSE
					SET var_an = 0;
				END IF;
				IF(var_offer_type=3 OR var_offer_type=5)THEN
					SET var_offer=var_id_t;
				ELSE
					SET var_offer=var_path_com;
				END IF;
				SET var_hour_click = HOUR(FROM_UNIXTIME(var_click_time, '%Y-%m-%d %H:%i:%S'));
				SET var_day_week = FROM_UNIXTIME(var_click_time, '%w');
				SELECT isp, country, `type` INTO var_isp,var_country,var_geo_type FROM {data_base}.base_geo WHERE id = var_geo;
				IF((SELECT COUNT(*) FROM {data_base}.clicks_tokens WHERE click_id = var_id)>0) THEN
					SELECT  t1,t2,t3,t4,t5,t6,t7,t8,t9,t10
						INTO var_t1,var_t2,var_t3,var_t4,var_t5,var_t6,var_t7,var_t8,var_t9,var_t10
						FROM {data_base}.clicks_tokens
						WHERE click_id = var_id LIMIT 0,1;
				END IF;
				SET @report_update_token_sql_1=CONCAT('SELECT COUNT(*) INTO @report_update_token_check_insrt FROM ', var_table_name, 
									' WHERE offer = ', var_offer,
									' AND hour_click = ', var_hour_click,
									' AND day_week = ', var_day_week,
									' AND path_id = ', var_path_id,
									' AND landing_page = ', var_landing_page,
									' AND ts_id = ', var_ts_id,
									' AND rule_id = ', var_rule_id,
									' AND offer_type = ', var_offer_type,
									' AND an = ', var_an,
									' AND isp = ', var_isp,
									' AND t1 = ', var_t1,
									' AND t2 = ', var_t2,
									' AND t3 = ', var_t3,
									' AND t4 = ', var_t4,
									' AND t5 = ', var_t5,
									' AND t6 = ', var_t6,
									' AND t7 = ', var_t7,
									' AND t8 = ', var_t8,
									' AND t9 = ', var_t9,
									' AND t10 = ', var_t10,
									' AND geo_type = ', var_geo_type,
									' AND country = ', var_country);
				IF(@report_update_token_sql_1 IS NOT NULL)THEN
					PREPARE check_insrt_report FROM @report_update_token_sql_1;
					EXECUTE check_insrt_report;
					DEALLOCATE PREPARE check_insrt_report;
					IF(@report_update_token_check_insrt = 0) THEN 
						SET @report_update_token_sql_2 = CONCAT('INSERT INTO ',var_table_name,
											' (offer,hour_click,day_week,path_id,landing_page,ts_id,rule_id,offer_type,an,isp,country,geo_type,clicks,clicks_offer,clicks_landing,leads,spend,pay,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10, bots) VALUES (',
												var_offer, ', ',
												var_hour_click, ', ',
												var_day_week, ', ',
												var_path_id, ', ',
												var_landing_page, ', ',
												var_ts_id, ', ',
												var_rule_id, ', ',
												var_offer_type, ', ',
												var_an, ', ',
												var_isp, ', ',
												var_country, ', ',
												var_geo_type, ', ',
												'0, ',
												'0, ',
												'0, ',
												'0, ',
												'0, ',
												'0, ',
												var_t1,', ',
												var_t2,', ',
												var_t3,', ',
												var_t4,', ',
												var_t5,', ',
												var_t6,', ',
												var_t7,', ',
												var_t8,', ',
												var_t9,', ',
												var_t10,', ',
												'0',
												')');
						PREPARE insert_report FROM @report_update_token_sql_2;
						EXECUTE insert_report;
						DEALLOCATE PREPARE insert_report;
					END IF;
				END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_m1;
END
<next>
CREATE PROCEDURE report_update_temp_2 (IN start_click_id INT, IN last_click_id INT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE flag, var_an INT DEFAULT 0;
	DECLARE log_id, var_id, var_click_id, var_cvr_id, var_offer_click, var_offer, var_offer_type INT;
	DECLARE time_client DATETIME;
	DECLARE var_pay, var_cpc DECIMAL(9,5);
	DECLARE cursor_1 CURSOR FOR 
		SELECT id, click_id, cvr_id, offer_click, pay, cpc, offer, offer_type FROM {data_base}.temp_table_2 WHERE (id > start_click_id OR id = start_click_id) AND (id < last_click_id OR id = last_click_id) ORDER BY id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	CALL {data_base}.time_convert(NOW(),time_client);
	INSERT INTO {data_base}.proc_4(start_date, end_date) VALUES (UNIX_TIMESTAMP(time_client),0);
	SET log_id=(SELECT LAST_INSERT_ID());
	OPEN cursor_1;
		REPEAT
			FETCH cursor_1 INTO var_id, var_click_id, var_cvr_id, var_offer_click, var_pay, var_cpc, var_offer, var_offer_type;
			IF NOT flag THEN
				IF(var_offer>0)THEN
					IF(var_offer_type=3)THEN
						SET var_an = (SELECT network FROM offers WHERE id = var_offer);
					END IF;
					UPDATE {data_base}.clicks SET an = var_an, cvr_id = var_cvr_id, offer_click = var_offer_click, pay = var_pay, cpc = var_cpc, offer = var_offer, offer_type = var_offer_type WHERE id = var_click_id;
				ELSE
					UPDATE {data_base}.clicks SET cvr_id = var_cvr_id, offer_click = var_offer_click, pay = var_pay, cpc = var_cpc WHERE id = var_click_id;
				END IF;
				DELETE FROM {data_base}.temp_table_2 WHERE id = var_id;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_1;
	CALL {data_base}.time_convert(NOW(),time_client);
	UPDATE {data_base}.proc_4 SET end_date=UNIX_TIMESTAMP(time_client) WHERE id = log_id;
END
<next>
CREATE PROCEDURE report_update_token (IN var_id INT, IN var_click_time INT, IN var_camp_id INT, IN var_offer INT, IN var_path_id INT, IN var_landing_page INT, IN var_cvr_id INT, IN var_ts_id INT, IN var_rule_id INT, IN var_offer_click INT, IN var_offer_type INT, IN var_an INT, IN var_pay DECIMAL(12,3), IN var_cpc DECIMAL(14,5), IN var_geo INT, IN var_table_name VARCHAR(64), IN var_bot INT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE var_clicks_landing,var_cvr INT;
	DECLARE var_isp, var_country, var_geo_type INT;
	DECLARE var_t1, var_t2, var_t3, var_t4, var_t5, var_t6, var_t7, var_t8, var_t9, var_t10 INT DEFAULT 0;
	DECLARE  var_hour_click, var_day_week INT;
	SET var_hour_click = HOUR(FROM_UNIXTIME(var_click_time, '%Y-%m-%d %H:%i:%S'));
	SET var_day_week = FROM_UNIXTIME(var_click_time, '%w');
	SELECT isp, country, `type` INTO var_isp,var_country,var_geo_type FROM {data_base}.base_geo WHERE id = var_geo;
	IF((SELECT COUNT(*) FROM {data_base}.clicks_tokens WHERE click_id = var_id)>0) THEN
		SELECT  t1,t2,t3,t4,t5,t6,t7,t8,t9,t10
			INTO var_t1,var_t2,var_t3,var_t4,var_t5,var_t6,var_t7,var_t8,var_t9,var_t10
			FROM {data_base}.clicks_tokens
			WHERE click_id = var_id LIMIT 0,1;
	END IF;
	IF(var_landing_page!=0) THEN 
		SET var_clicks_landing=1;
	ELSE 
		SET var_clicks_landing=0;
		SET var_offer_click=0;
	END IF;
	IF(var_cvr_id!=0)THEN 
		SET var_cvr=1; 
	ELSE 
		SET var_cvr=0;
	END IF;
	SET @report_update_token_sql_1=CONCAT('SELECT COUNT(*) INTO @report_update_token_check_insrt FROM ', var_table_name, 
						' WHERE offer = ', var_offer,
						' AND hour_click = ', var_hour_click,
						' AND day_week = ', var_day_week,
						' AND path_id = ', var_path_id,
						' AND landing_page = ', var_landing_page,
						' AND ts_id = ', var_ts_id,
						' AND rule_id = ', var_rule_id,
						' AND offer_type = ', var_offer_type,
						' AND an = ', var_an,
						' AND isp = ', var_isp,
						' AND t1 = ', var_t1,
						' AND t2 = ', var_t2,
						' AND t3 = ', var_t3,
						' AND t4 = ', var_t4,
						' AND t5 = ', var_t5,
						' AND t6 = ', var_t6,
						' AND t7 = ', var_t7,
						' AND t8 = ', var_t8,
						' AND t9 = ', var_t9,
						' AND t10 = ', var_t10,
						' AND geo_type = ', var_geo_type,
						' AND country = ', var_country);
	IF(@report_update_token_sql_1 IS NOT NULL)THEN
		PREPARE check_insrt_report FROM @report_update_token_sql_1;
		EXECUTE check_insrt_report;
		DEALLOCATE PREPARE check_insrt_report;
		IF(@report_update_token_check_insrt = 0) THEN 
			SET @report_update_token_sql_2 = CONCAT('INSERT INTO ',var_table_name,
								' (offer,hour_click,day_week,path_id,landing_page,ts_id,rule_id,offer_type,an,isp,country,geo_type,clicks,clicks_offer,clicks_landing,leads,spend,pay,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10, bots) VALUES (',
									var_offer, ', ',
									var_hour_click, ', ',
									var_day_week, ', ',
									var_path_id, ', ',
									var_landing_page, ', ',
									var_ts_id, ', ',
									var_rule_id, ', ',
									var_offer_type, ', ',
									var_an, ', ',
									var_isp, ', ',
									var_country, ', ',
									var_geo_type, ', ',
									'1, ',
									var_offer_click, ', ',
									var_clicks_landing, ', ',
									var_cvr, ', ',
									var_cpc, ', ',
									var_pay,', ',
									var_t1,', ',
									var_t2,', ',
									var_t3,', ',
									var_t4,', ',
									var_t5,', ',
									var_t6,', ',
									var_t7,', ',
									var_t8,', ',
									var_t9,', ',
									var_t10,', ',
									var_bot,
									')');
			PREPARE insert_report FROM @report_update_token_sql_2;
			EXECUTE insert_report;
			DEALLOCATE PREPARE insert_report;
		ELSE
			SET @report_update_token_sql_2 = CONCAT(
					'UPDATE ',var_table_name,' SET ',
						'clicks = clicks + 1',
						', clicks_offer = clicks_offer + ', var_offer_click,
						', clicks_landing = clicks_landing + ', var_clicks_landing,
						', leads = leads + ',var_cvr,
						', bots = bots + ',var_bot,
						', spend = spend + ', var_cpc,
						', pay = pay + ', var_pay,
						' WHERE offer = ', var_offer,
						' AND hour_click = ', var_hour_click,
						' AND day_week = ', var_day_week,
						' AND path_id = ', var_path_id,
						' AND landing_page = ', var_landing_page,
						' AND ts_id = ', var_ts_id,
						' AND rule_id = ', var_rule_id,
						' AND offer_type = ', var_offer_type,
						' AND an = ', var_an,
						' AND isp = ', var_isp,
						' AND t1 = ', var_t1,
						' AND t2 = ', var_t2,
						' AND t3 = ', var_t3,
						' AND t4 = ', var_t4,
						' AND t5 = ', var_t5,
						' AND t6 = ', var_t6,
						' AND t7 = ', var_t7,
						' AND t8 = ', var_t8,
						' AND t9 = ', var_t9,
						' AND t10 = ', var_t10,
						' AND geo_type = ', var_geo_type,
						' AND country = ', var_country
				);
			PREPARE update_report FROM @report_update_token_sql_2;
			EXECUTE update_report;
			DEALLOCATE PREPARE update_report;
		END IF;
	END IF;
END
<next>
CREATE PROCEDURE report_order (IN table_name VARCHAR(64), IN var_order VARCHAR(64)) BEGIN
	/*Binom 15000 1.5*/
	DECLARE sql_1, sql_2, sql_3, sql_4, sql_5 TEXT;
	SET sql_1=CONCAT('
		UPDATE
		  ',table_name,'
		SET
		  id1 = (SELECT @a:= @a + 1 FROM (SELECT @a:= 0) as tbl)
		WHERE num = 1
		ORDER BY ',var_order,';
	');
	SET sql_2=CONCAT('
		UPDATE
			',table_name,' AS table_1
			JOIN (
				SELECT group_1, id1 FROM ',table_name,' WHERE num=1
			) AS test ON 
			table_1.group_1=test.group_1
		SET table_1.id1=test.id1
		WHERE num!=1;
	');
	SET sql_3=CONCAT('
		UPDATE
		  ',table_name,'
		SET
		  id2 = (SELECT @a:= @a + 1 FROM (SELECT @a:= 0) as tbl)
		WHERE num = 2
		ORDER BY ',var_order,';
	');
	SET sql_4=CONCAT('
		UPDATE
			',table_name,' AS table_1
			JOIN (
				SELECT group_1, group_2, id2 FROM ',table_name,' WHERE num=2
			) AS test ON 
			table_1.group_1=test.group_1 AND table_1.group_2=test.group_2
		SET table_1.id2=test.id2
		WHERE num=3;
	');
	SET sql_5=CONCAT('
		UPDATE
		  ',table_name,'
		SET
		  id3 = (SELECT @a:= @a + 1 FROM (SELECT @a:= 0) as tbl)
		WHERE num = 3
		ORDER BY ',var_order,';
	');
	
	SET @sql_1=sql_1;
	PREPARE sql_1 FROM @sql_1;
	EXECUTE sql_1;
	DEALLOCATE PREPARE sql_1;
	
	SET @sql_2=sql_2;
	PREPARE sql_2 FROM @sql_2;
	EXECUTE sql_2;
	DEALLOCATE PREPARE sql_2;
	
	SET @sql_3=sql_3;
	PREPARE sql_3 FROM @sql_3;
	EXECUTE sql_3;
	DEALLOCATE PREPARE sql_3;
	
	SET @sql_4=sql_4;
	PREPARE sql_4 FROM @sql_4;
	EXECUTE sql_4;
	DEALLOCATE PREPARE sql_4;
	
	SET @sql_5=sql_5;
	PREPARE sql_5 FROM @sql_5;
	EXECUTE sql_5;
	DEALLOCATE PREPARE sql_5;
END
<next>
CREATE PROCEDURE report_select_group (IN group_num INT, IN var_group INT, IN camp_id INT, IN type_group VARCHAR(10), IN date_row VARCHAR(32), OUT var_group_title TEXT, OUT var_select_group TEXT, OUT name_group TEXT) BEGIN
	/*Binom 16101*/
	DECLARE var_token_select_group TEXT;
	DECLARE temp_var_group INT;
	SET var_select_group = group_num;
	SET name_group=CONCAT('group_',group_num);
	IF(var_group=27)THEN
		SET temp_var_group = 1;
	ELSE
		SET temp_var_group = var_group-280;
	END IF;
	SET var_token_select_group = CONCAT('
		(IF(group_',group_num,'=0,"Unknown",
			(SELECT 
				CONCAT(
					(SELECT val FROM {data_base}.token_value WHERE id = group_',group_num,'),
					(SELECT  
						IF(
							GROUP_CONCAT(name SEPARATOR "" ) IS NOT NULL,
							CONCAT(" ",GROUP_CONCAT(name SEPARATOR "" )),
							""
						)
					FROM {data_base}.token_tags WHERE token_id = group_',group_num,' AND token_num=',temp_var_group,' AND camp_id=',camp_id,')
				) AS val)	
		))
	');
	CASE var_group
		WHEN 1 THEN 
			SET var_group_title = 'NULL';
			SET var_select_group = 'NULL';
		WHEN 2 THEN 
			SET var_group_title = 'IF(rule_id>0,0,path_id)'; 
			SET var_select_group = CONCAT('(SELECT IF(id!=0,CONCAT(name, " #tag:",status),name) AS name FROM {data_base}.paths WHERE id = group_',group_num,')');
		WHEN 3 THEN 
			SET var_group_title = CONCAT('CONCAT(path_id,"-",offer,"-",offer_type,"-",(SELECT IFNULL((SELECT status FROM path_com WHERE path_id = table_rp.path_id AND type=table_rp.offer_type AND id_t=offer LIMIT 1),3)))');
			SET var_select_group = CONCAT('
				IF(
					SUBSTRING_INDEX(SUBSTRING_INDEX(group_',group_num,',"-",-2),"-",1)=4,
					CONCAT("Direct: ",(SELECT CONCAT(url," #tag:",status) AS id_t FROM {data_base}.offer_direct_url WHERE id = SUBSTRING_INDEX(SUBSTRING_INDEX(group_',group_num,',"-",2),"-",-1))),
					IF(
						SUBSTRING_INDEX(SUBSTRING_INDEX(group_',group_num,',"-",-2),"-",1)=3,
						(
							SELECT 
								CONCAT((SELECT IF(id!=0,CONCAT(name," - "),"") AS name FROM networks WHERE id = offr.network),name," #tag:",
								SUBSTRING_INDEX(group_',group_num,',"-",-1)
							) AS name
							FROM 
								{data_base}.offers AS offr
							WHERE 
								id = SUBSTRING_INDEX(SUBSTRING_INDEX(group_',group_num,',"-",2),"-",-1)
						),
						CONCAT("Campaign: ",(SELECT name FROM {data_base}.campaigns WHERE id = SUBSTRING_INDEX(SUBSTRING_INDEX(group_',group_num,',"-",2),"-",-1)))
					)
				)');
			SET name_group=CONCAT('CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(group_',group_num,',"-",2),"-",-1),"-",SUBSTRING_INDEX(group_',group_num,',"-",-1))');
		WHEN 4 THEN 
			SET var_group_title = CONCAT('CONCAT(path_id,"-",landing_page)');
			SET var_select_group = CONCAT('
				(
					SELECT
						IF(
							lang="0" OR lang="",
							CONCAT(name," #tag:",
								IF(
									(SELECT status FROM path_com WHERE path_id = SUBSTRING_INDEX(group_',group_num,',"-",1) AND (type=1 OR type=2) AND id_t=SUBSTRING_INDEX(group_',group_num,',"-",-1)+0 LIMIT 1) IS NOT NULL,
									(SELECT status FROM path_com WHERE path_id = SUBSTRING_INDEX(group_',group_num,',"-",1) AND (type=1 OR type=2) AND id_t=SUBSTRING_INDEX(group_',group_num,',"-",-1)+0 LIMIT 1),
									3
								)
							),
							CONCAT(
								name,
								" #tag:",
								IF(
									(SELECT status FROM path_com WHERE path_id = SUBSTRING_INDEX(group_',group_num,',"-",1) AND (type=1 OR type=2) AND id_t=SUBSTRING_INDEX(group_',group_num,',"-",-1) LIMIT 1) IS NOT NULL,
									(SELECT status FROM path_com WHERE path_id = SUBSTRING_INDEX(group_',group_num,',"-",1) AND (type=1 OR type=2) AND id_t=SUBSTRING_INDEX(group_',group_num,',"-",-1) LIMIT 1),
									3
								),
								" (", lang, ")"
							)
						) 
					FROM 
						{data_base}.landing_pages
						WHERE 
						id = SUBSTRING_INDEX(group_',group_num,',"-",-1)
				)');
			SET name_group=CONCAT('SUBSTRING_INDEX(group_',group_num,',"-",-1)');
		WHEN 5 THEN 
			SET var_group_title = 'path_id';
			SET var_select_group = CONCAT('
				(
					SELECT 
						IF(
							rule_id=0,
							"Default",
							CONCAT((SELECT name FROM rule WHERE id = rule_id)," - ", name)
						) AS name FROM {data_base}.paths WHERE id = group_',group_num,')
			');
		WHEN 6 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT isp FROM {data_base}.base_geo WHERE id = table_rp.geo)';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_geo_isp WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'isp';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_geo_isp WHERE id = group_',group_num,')');
			END IF;
		WHEN 7 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(CONCAT(SUBSTRING(ip,1,(3-(12-LENGTH(ip))))+0,".",SUBSTRING(ip,(4-(12-LENGTH(ip))),3)+0,".", SUBSTRING(ip,(7-(12-LENGTH(ip))),3)+0,".", SUBSTRING(ip,(10-(12-LENGTH(ip))),3)+0))';
				SET var_select_group = CONCAT('group_',group_num);
			ELSE
				SET var_group_title = 'CONCAT(ip_1,".",ip_2,".",ip_3,".", ip_4)';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 8 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = ' (CONCAT(SUBSTRING(ip,1,(3-(12-LENGTH(ip))))+0,".",SUBSTRING(ip,(4-(12-LENGTH(ip))),3)+0,".", SUBSTRING(ip,(7-(12-LENGTH(ip))),3)+0,".0 - ",SUBSTRING(ip,1,(3-(12-LENGTH(ip))))+0,".",SUBSTRING(ip,(4-(12-LENGTH(ip))),3)+0,".", SUBSTRING(ip,(7-(12-LENGTH(ip))),3)+0,".255"))';
				SET var_select_group = CONCAT('group_',group_num);
			ELSE
				SET var_group_title = 'CONCAT(ip_1,".",ip_2,".",ip_3,".0 - ",ip_1,".",ip_2,".",ip_3,".255")';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 9 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(CONCAT(SUBSTRING(ip,1,(3-(12-LENGTH(ip))))+0,".",SUBSTRING(ip,(4-(12-LENGTH(ip))),3)+0,".0.0 - ",SUBSTRING(ip,1,(3-(12-LENGTH(ip))))+0,".",SUBSTRING(ip,(4-(12-LENGTH(ip))),3)+0,".255.255"))';
				SET var_select_group = CONCAT('group_',group_num);
			ELSE
				SET var_group_title = 'CONCAT(ip_1,".",ip_2,".0.0 - ",ip_1,".",ip_2,".255.255")';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 10 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT device_td3_id FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT pointing_method FROM {data_base}.base_device_technical_data_3 WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'td3';
				SET var_select_group = CONCAT('(SELECT pointing_method FROM {data_base}.base_device_technical_data_3 WHERE id = group_',group_num,')');
			END IF;
		WHEN 29 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT device_model_id FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_device_model WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = '(SELECT name FROM {data_base}.base_device_model WHERE id = table_rp.model)';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 11 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT device_brand_id FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_device_brand WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'brand';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_device_brand WHERE id = group_',group_num,')');
			END IF;
		WHEN 12 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT device_model_id FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT model FROM {data_base}.base_device_model WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'model';
				SET var_select_group = CONCAT('(SELECT model FROM {data_base}.base_device_model WHERE id = group_',group_num,')');
			END IF;
		WHEN 13 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT device_td2_id FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT resolution FROM {data_base}.base_device_technical_data_2 WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'td2';
				SET var_select_group = CONCAT('(SELECT resolution FROM {data_base}.base_device_technical_data_2 WHERE id = group_',group_num,')');
			END IF;
		WHEN 14 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT device_td4_id FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT max_speed FROM {data_base}.base_device_technical_data_4 WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'td4';
				SET var_select_group = CONCAT('(SELECT max_speed FROM {data_base}.base_device_technical_data_4 WHERE id = group_',group_num,')');
			END IF;
		WHEN 15 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT browser FROM base_browser WHERE id=(SELECT browser FROM user_agents WHERE id = table_rp.ua))';
				SET var_select_group = CONCAT('group_',group_num);
			ELSE
				SET var_group_title = '(SELECT browser FROM base_browser WHERE id=table_rp.browser)';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 16 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT browser FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT CONCAT(browser," ",browser_version) FROM {data_base}.base_browser WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'browser';
				SET var_select_group = CONCAT('(SELECT CONCAT(browser," ",browser_version) FROM {data_base}.base_browser WHERE id = group_',group_num,')');
			END IF;
		WHEN 17 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT os FROM base_os WHERE id =(SELECT os FROM user_agents WHERE id = table_rp.ua))';
				SET var_select_group = CONCAT('group_',group_num);
			ELSE
				SET var_group_title = '(SELECT os FROM base_os WHERE id = table_rp.os)';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 18 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT os FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_os WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'os';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_os WHERE id = group_',group_num,')');
			END IF;
		WHEN 19 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT country FROM {data_base}.base_geo WHERE id = table_rp.geo)';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_geo_country WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'country';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_geo_country WHERE id = group_',group_num,')');
			END IF;
		WHEN 20 THEN 
			SET var_group_title = '(SELECT city FROM {data_base}.base_geo WHERE id = geo)';
			SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_geo_city WHERE id = group_',group_num,')');
		WHEN 30 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT type FROM {data_base}.base_geo WHERE id = table_rp.geo)';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_geo_type WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'geo_type';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_geo_type WHERE id = group_',group_num,')');
			END IF;
		WHEN 31 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = CONCAT('UNIX_TIMESTAMP(FROM_UNIXTIME(table_rp.click_time,  "%Y-%m-%d 00:00:00"))'); 
				SET var_select_group = CONCAT('FROM_UNIXTIME(group_',group_num,',  "%Y-%m-%d")');
			ELSE
				SET var_group_title = CONCAT('"',date_row,'"'); 
				SET var_select_group = CONCAT('FROM_UNIXTIME(group_',group_num,',  "%Y-%m-%d")');
			END IF;
		WHEN 21 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT device_lang_id FROM user_agents WHERE id = table_rp.ua)';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_device_lang WHERE id = group_',group_num,')');
			ELSE
				SET var_group_title = 'lang';
				SET var_select_group = CONCAT('(SELECT name FROM {data_base}.base_device_lang WHERE id = group_',group_num,')');
			END IF;
		WHEN 22 THEN 
			SET var_group_title = 'an';
			SET var_select_group = CONCAT('(SELECT name FROM {data_base}.networks WHERE id = group_',group_num,')');
		WHEN 23 THEN 
				SET var_group_title = '(SELECT url FROM {data_base}.clicks_referer_url WHERE click_id = table_rp.id LIMIT 1)';
				SET var_select_group = CONCAT('group_',group_num);
		WHEN 24 THEN 
			SET var_group_title = 'referer_domain';
			SET var_select_group = CONCAT('(SELECT val FROM {data_base}.referer_value WHERE id = group_',group_num,')');
		WHEN 25 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(FROM_UNIXTIME(table_rp.click_time, "%w"))';
				SET var_select_group = CONCAT('group_',group_num);
			ELSE
				SET var_group_title = 'day_week';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 26 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(HOUR(FROM_UNIXTIME(table_rp.click_time)))';
				SET var_select_group = CONCAT('group_',group_num);
			ELSE
				SET var_group_title = 'hour_click';
				SET var_select_group = CONCAT('group_',group_num);
			END IF;
		WHEN 27 THEN 
			IF(type_group='token_')THEN
				SET var_group_title = 't1';
			ELSE
				SET var_group_title = 'publisher';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 282 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t2 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't2';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 283 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t3 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't3';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 284 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t4 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't4';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 285 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t5 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't5';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 286 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t6 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't6';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 287 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t7 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't7';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 288 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t8 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't8';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 289 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t9 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't9';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 290 THEN 
			IF(type_group='direct')THEN
				SET var_group_title = '(SELECT t10 FROM clicks_tokens WHERE click_id = table_rp.id LIMIT 1)';
			ELSE
				SET var_group_title = 't10';
			END IF;
			SET var_select_group = var_token_select_group;
		WHEN 32 THEN 
			SET var_group_title = 'ts_id';
			SET var_select_group = CONCAT('(SELECT name FROM {data_base}.traffic_sources WHERE id = group_',group_num,')');
		WHEN 33 THEN 
			SET var_group_title = CONCAT('"',camp_id,'"'); 
			SET var_select_group = CONCAT('(SELECT name FROM {data_base}.campaigns WHERE id = group_',group_num,')');
		WHEN 34 THEN 
			SET var_group_title = '(SELECT status FROM {data_base}.conversion_status WHERE cnv_id = table_rp.cvr_id)';
			SET var_select_group = CONCAT('group_',group_num);
		WHEN 38 THEN 
			SET var_group_title = '(SELECT status2 FROM {data_base}.conversion_status WHERE cnv_id = table_rp.cvr_id)';
			SET var_select_group = CONCAT('group_',group_num);
		WHEN 35 THEN 
			SET var_group_title = '(table_rp.cpc)';
			SET var_select_group = CONCAT('group_',group_num);
		WHEN 36 THEN 
			SET var_group_title = '(table_rp.pay)';
			SET var_select_group = CONCAT('group_',group_num);
		WHEN 37 THEN 
			SET var_group_title = '(FROM_UNIXTIME(table_rp.click_time,  "%i"))';
			SET var_select_group = CONCAT('group_',group_num);
		ELSE
			IF(var_group>300)THEN
				SET var_group_title = CONCAT('(SELECT value_id FROM clicks_tokens_lp WHERE click_id = table_rp.id AND name_id=',(var_group-300),' LIMIT 1)');
				SET var_select_group = CONCAT('(SELECT val FROM {data_base}.token_value_lp WHERE id = group_',group_num,')');
			END IF;
	END CASE;
END
<next>
CREATE PROCEDURE report_upload (IN var_group_1 INT, IN var_group_2 INT, IN var_group_3 INT, IN camp_id INT, IN date_type INT, IN report_table VARCHAR(32), IN emulation_mode INT) BEGIN
	/*Binom 15000 1.5*/
	DECLARE type_report VARCHAR(10);
	DECLARE time_client DATETIME;
	DECLARE var_table_name VARCHAR(128);
	DECLARE count_date INT(3);
	DECLARE var_group_title_1,var_group_title_2,var_group_title_3 TEXT DEFAULT '';
	DECLARE var_select_group_1,var_select_group_2,var_select_group_3 TEXT DEFAULT '';
	DECLARE sql_group_select LONGTEXT DEFAULT '';
	DECLARE i INT(9);
	DECLARE temp_date_type INT;
	DECLARE check_table INT;
	DECLARE check_report INT DEFAULT 0;
	DECLARE sql_tr_temp LONGTEXT DEFAULT '';
	DECLARE sql_tr LONGTEXT DEFAULT '';
	DECLARE sql_TRUNCATE TEXT DEFAULT '';
	DECLARE name_group_1,name_group_2,name_group_3 TEXT DEFAULT '';
	DECLARE sql_all_report,sql_group1,sql_group2 LONGTEXT DEFAULT '';
	SET type_report='';
	IF(var_group_1>280 OR var_group_2>280 OR var_group_3>280)THEN
		SET type_report ='token_';
	END IF;
	IF(var_group_1=7 OR var_group_2=7 OR var_group_3=7)THEN
		SET type_report ='ip_';
	END IF;
	IF(var_group_1=8 OR var_group_2=8 OR var_group_3=8)THEN
		SET type_report ='ip_';
	END IF;
	IF(var_group_1=9 OR var_group_2=9 OR var_group_3=9)THEN
		SET type_report ='ip_';
	END IF;
	CALL {data_base}.time_convert(NOW(),time_client);
	CASE date_type
		WHEN 1 THEN 
			SET var_table_name = CONCAT('report_camp_',type_report,camp_id,'_', DATE_FORMAT(time_client,  '%d%m%Y'));
			SET count_date = 1;
		WHEN 2 THEN 
			SET var_table_name = CONCAT('report_camp_',type_report,camp_id,'_', DATE_FORMAT((time_client- INTERVAL 1 DAY),  '%d%m%Y'));
			SET count_date = 1;
		WHEN 3 THEN 
			SET count_date = 7;
		WHEN 11 THEN 
			SET count_date=DATE_FORMAT(time_client, '%w');
		WHEN 4 THEN 
			SET count_date = 14;
		WHEN 5 THEN 
			SET count_date = DATE_FORMAT(time_client,  '%e');
		WHEN 6 THEN 
			SET var_table_name = CONCAT('month_report_camp_',type_report,camp_id,'_', DATE_FORMAT((time_client- INTERVAL 1 MONTH),  '%m%Y'));
			SET count_date = 1;
		WHEN 7 THEN 
			SET count_date = DATE_FORMAT(time_client,  '%c');
		WHEN 8 THEN 
			SET count_date = 13;
		WHEN 9 THEN 
			SET count_date = 64;
	END CASE;
	CALL report_select_group(1, var_group_1, camp_id, type_report, '', var_group_title_1, var_select_group_1, name_group_1);
	CALL report_select_group(2, var_group_2, camp_id, type_report, '', var_group_title_2, var_select_group_2, name_group_2);
	CALL report_select_group(3, var_group_3, camp_id, type_report, '', var_group_title_3, var_select_group_3, name_group_3);
	SET sql_group_select=CONCAT('SELECT 
			sum(clicks) AS clicks,
			sum(bots) AS bots,
			sum(clicks_offer) AS clicks_offer,
			sum(clicks_landing) AS clicks_landing,
			sum(leads) AS leads,
			sum(spend) AS spend,
			sum(pay) AS pay,
			',var_group_title_1,' AS group_1,
			',var_group_title_2,' AS group_2,
			',var_group_title_3,' AS group_3
		FROM
	');
	SET	temp_date_type=date_type;
	WHILE count_date > 0 DO
		SET count_date = count_date - 1;
		IF(temp_date_type = 3 OR temp_date_type = 11 OR temp_date_type = 4 OR temp_date_type = 5)THEN
			SET var_table_name = CONCAT('report_camp_',type_report,camp_id,'_', DATE_FORMAT((time_client- INTERVAL count_date DAY),  '%d%m%Y'));
		ELSE
			CASE temp_date_type
				WHEN 7 THEN 
					IF(count_date = 0) THEN
						SET count_date = DATE_FORMAT(time_client,  '%e');
						SET temp_date_type = 5;
						SET var_table_name = '0';
					ELSE
						SET var_table_name = CONCAT('month_report_camp_',type_report,camp_id,'_', DATE_FORMAT((time_client- INTERVAL count_date MONTH),  '%m%Y'));
					END IF;
				WHEN 8 THEN 
					IF(count_date>0)THEN
						IF(count_date<10)THEN
							SET var_table_name = CONCAT('month_report_camp_',type_report,camp_id,'_', DATE_FORMAT((time_client- INTERVAL 1 YEAR),  CONCAT('0',count_date,'%Y')));
						ELSE
							SET var_table_name = CONCAT('month_report_camp_',type_report,camp_id,'_', DATE_FORMAT((time_client- INTERVAL 1 YEAR),  CONCAT(count_date,'%Y')));
						END IF;
					ELSE
						SET var_table_name = '0';
					END IF;
				WHEN 9 THEN 
					IF(count_date = 0) THEN
						SET count_date = DATE_FORMAT(time_client,  '%e');
						SET temp_date_type = 5;
						SET var_table_name = '0';
					ELSE
						SET var_table_name = CONCAT('month_report_camp_',type_report,camp_id,'_', DATE_FORMAT((time_client- INTERVAL count_date MONTH),  '%m%Y'));
					END IF;
				ELSE
					SET var_table_name = var_table_name;
			END CASE;
		END IF;
		SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = var_table_name AND table_schema = '{data_base}');
		IF(check_table>0 AND var_table_name!='0')THEN
			SET check_report=check_report+1;
			SET sql_tr_temp=CONCAT('(',sql_group_select,var_table_name,' AS table_rp GROUP BY ',name_group_1,',',name_group_2,',',name_group_3,')');
			SET sql_tr=CONCAT(sql_tr,sql_tr_temp,' UNION ALL ');
		END IF;
	END WHILE;
	IF(RIGHT(sql_tr,4) = 'ALL ')THEN
		SET sql_tr = LEFT(sql_tr, (LENGTH(sql_tr)-11));
	END IF;
	SET sql_TRUNCATE=CONCAT('TRUNCATE ',report_table);
	SET sql_all_report=CONCAT('
		INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
			SELECT 3,group_1,group_2,group_3, SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM(
				',sql_tr,'
			) AS report
			GROUP BY
			',name_group_1,',',name_group_2,',',name_group_3,';
	');
	IF(var_group_2=1 AND var_group_3=1)THEN
		SET sql_group1=CONCAT('
			UPDATE ',report_table,' SET num = 1;
		');
		SET sql_group2='0';
	ELSE
		SET sql_group1=CONCAT('
			INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
			SELECT 1,group_1, 0,0,SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM 
			',report_table,'
			GROUP BY
			group_1;
		');
		IF(var_group_3=1)THEN
			SET sql_group2=CONCAT('
				UPDATE ',report_table,' SET num = 2 WHERE num != 1;
			');
		ELSE
			SET sql_group2=CONCAT('
				INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
				SELECT 2,group_1, group_2,0,SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM 
				',report_table,'
				WHERE num!=1
				GROUP BY
				group_1,
				group_2;
			');
		END IF;
	END IF;
	IF(check_report>0)THEN
		CASE emulation_mode
			WHEN 0 THEN 
				SET @sql_TRUNCATE=sql_TRUNCATE;
				PREPARE reports_TRUNCATE FROM @sql_TRUNCATE;
				EXECUTE reports_TRUNCATE;
				DEALLOCATE PREPARE reports_TRUNCATE;
				
				SET @report_all_sql=sql_all_report;
				PREPARE reports FROM @report_all_sql;
				EXECUTE reports;
				DEALLOCATE PREPARE reports;
				
				SET @sql_group1=sql_group1;
				PREPARE sql_group1 FROM @sql_group1;
				EXECUTE sql_group1;
				DEALLOCATE PREPARE sql_group1;
				IF(sql_group2!='0')THEN
					SET @sql_group2=sql_group2;
					PREPARE sql_group2 FROM @sql_group2;
					EXECUTE sql_group2;
					DEALLOCATE PREPARE sql_group2;
				END IF;
				SELECT var_select_group_1,var_select_group_2,var_select_group_3, check_report AS status;
			WHEN 1 THEN 
				SELECT sql_TRUNCATE, sql_all_report, sql_tr, sql_group1, sql_group2, var_select_group_1, var_select_group_2, var_select_group_3, check_report AS status, name_group_1,name_group_2,name_group_3;
			WHEN 2 THEN 
				SELECT sql_TRUNCATE, sql_all_report, sql_tr, sql_group1, sql_group2, var_select_group_1, var_select_group_2, var_select_group_3, check_report AS status, name_group_1,name_group_2,name_group_3;
		END CASE;
	ELSE
		IF(emulation_mode!=2)THEN
			SET @sql_TRUNCATE=sql_TRUNCATE;
			PREPARE reports_TRUNCATE FROM @sql_TRUNCATE;
			EXECUTE reports_TRUNCATE;
			DEALLOCATE PREPARE reports_TRUNCATE;
		END IF;
		SELECT 0 AS status;
	END IF;
END
<next>
CREATE PROCEDURE report_upload_custom(IN var_group_1 INT, IN var_group_2 INT, IN var_group_3 INT, IN camp_id INT, IN start_date VARCHAR(32), IN end_date VARCHAR(32),IN report_table VARCHAR(32), IN emulation_mode INT) BEGIN
	/*Binom 16000 1.6*/
	DECLARE type_report VARCHAR(10);
	DECLARE time_client DATETIME;
	DECLARE var_table_name VARCHAR(128);
	DECLARE count_date INT(3);
	DECLARE  start_date_u, end_date_u, date_now INT DEFAULT 0;
	DECLARE i INT(9);
	DECLARE check_table INT;
	DECLARE check_report INT DEFAULT 0;
	DECLARE var_group_title_1,var_group_title_2,var_group_title_3 TEXT DEFAULT '';
	DECLARE var_select_group_1,var_select_group_2,var_select_group_3 TEXT DEFAULT '';
	DECLARE sql_tr_temp LONGTEXT DEFAULT '';
	DECLARE sql_tr LONGTEXT DEFAULT '';
	DECLARE sql_TRUNCATE TEXT DEFAULT '';
	DECLARE sql_group_select LONGTEXT DEFAULT '';
	DECLARE sql_all_report,sql_group1,sql_group2 LONGTEXT DEFAULT '';
	DECLARE check_start_time, check_end_time, start_hour, end_hour  INT DEFAULT 0;
	DECLARE last_check_date VARCHAR(32);
	DECLARE name_group_1,name_group_2,name_group_3 TEXT DEFAULT '';
	DECLARE developer_mode LONGTEXT DEFAULT '';
	SET type_report='';
	IF(var_group_1>280 OR var_group_2>280 OR var_group_3>280)THEN
		SET type_report ='token_';
	END IF;
	IF(var_group_1=7 OR var_group_2=7 OR var_group_3=7)THEN
		SET type_report ='ip_';
	END IF;
	IF(var_group_1=8 OR var_group_2=8 OR var_group_3=8)THEN
		SET type_report ='ip_';
	END IF;
	IF(var_group_1=9 OR var_group_2=9 OR var_group_3=9)THEN
		SET type_report ='ip_';
	END IF;
	CALL {data_base}.time_convert(NOW(),time_client);
	SET start_date_u=UNIX_TIMESTAMP(start_date);
	SET end_date_u=UNIX_TIMESTAMP(end_date);
	SET start_hour=FROM_UNIXTIME(start_date_u,'%H');
	SET end_hour=FROM_UNIXTIME(end_date_u,'%H');
	SET count_date = CEILING(((UNIX_TIMESTAMP(FROM_UNIXTIME(end_date_u,'%Y-%m-%d 23:59:59'))+1) - (UNIX_TIMESTAMP(FROM_UNIXTIME(start_date_u,'%Y-%m-%d 00:00'))))/(60*60*24));
	WHILE count_date > 0 DO
		SET count_date = count_date - 1;
		SET date_now=UNIX_TIMESTAMP(end_date- INTERVAL count_date DAY);
		CALL report_select_group(1, var_group_1, camp_id, type_report, date_now, var_group_title_1, var_select_group_1, name_group_1);
		CALL report_select_group(2, var_group_2, camp_id, type_report, date_now, var_group_title_2, var_select_group_2, name_group_2);
		CALL report_select_group(3, var_group_3, camp_id, type_report, date_now, var_group_title_3, var_select_group_3, name_group_3);
		SET sql_group_select=CONCAT('SELECT 
				sum(clicks) AS clicks,
				sum(bots) AS bots,
				sum(clicks_offer) AS clicks_offer,
				sum(clicks_landing) AS clicks_landing,
				sum(leads) AS leads,
				sum(spend) AS spend,
				sum(pay) AS pay,
				',var_group_title_1,' AS group_1,
				',var_group_title_2,' AS group_2,
				',var_group_title_3,' AS group_3
			FROM
		');
		SET var_table_name = CONCAT('report_camp_',type_report,camp_id,'_', DATE_FORMAT((end_date- INTERVAL count_date DAY),  '%d%m%Y'));
		SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = var_table_name AND table_schema = '{data_base}');
		IF(check_table>0 AND var_table_name!='0')THEN
			SET check_report=check_report+1;
			SET last_check_date = DATE_FORMAT((end_date- INTERVAL count_date DAY),  '%d%m%Y');
			SET developer_mode=CONCAT(developer_mode,DATE_FORMAT((end_date- INTERVAL count_date DAY),  '%d%m%Y'),'-',FROM_UNIXTIME(start_date_u, '%d%m%Y'),';');
			IF(check_start_time=0 AND DATE_FORMAT((end_date- INTERVAL count_date DAY),  '%d%m%Y') = FROM_UNIXTIME(start_date_u, '%d%m%Y'))THEN
				SET check_start_time=1;
				SET sql_tr_temp=CONCAT('(',sql_group_select,var_table_name,' AS table_rp WHERE (hour_click>',start_hour,' OR hour_click=',start_hour,') GROUP BY ',name_group_1,',',name_group_2,',',name_group_3,')');
			ELSE
				SET sql_tr_temp=CONCAT('(',sql_group_select,var_table_name,' AS table_rp WHERE 1 GROUP BY ',name_group_1,',',name_group_2,',',name_group_3,')');
			END IF;
			SET sql_tr=CONCAT(sql_tr,sql_tr_temp,' UNION ALL ');
		END IF;
	END WHILE;
	IF(RIGHT(sql_tr,4) = 'ALL ')THEN
		SET sql_tr = LEFT(sql_tr, (LENGTH(sql_tr)-(LENGTH(name_group_1)+LENGTH(name_group_2)+LENGTH(name_group_3)+23)));
		IF(last_check_date=FROM_UNIXTIME(end_date_u, '%d%m%Y'))THEN
			SET sql_tr=CONCAT(sql_tr,' AND hour_click<=',end_hour,' GROUP BY ',name_group_1,',',name_group_2,',',name_group_3,')');
		ELSE
			SET sql_tr=CONCAT(sql_tr,' GROUP BY ',name_group_1,',',name_group_2,',',name_group_3,')');
		END IF;
	END IF;
	SET sql_TRUNCATE=CONCAT('TRUNCATE ',report_table);
	SET sql_all_report=CONCAT('
		INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
			SELECT 3,group_1,group_2,group_3, SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM(
				',sql_tr,'
			) AS report
			GROUP BY
			',name_group_1,',',name_group_2,',',name_group_3,';
	');
	IF(var_group_2=1 AND var_group_3=1)THEN
		SET sql_group1=CONCAT('
			UPDATE ',report_table,' SET num = 1;
		');
		SET sql_group2='0';
	ELSE
		SET sql_group1=CONCAT('
			INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
			SELECT 1,group_1, 0,0,SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM 
			',report_table,'
			GROUP BY
			group_1;
		');
		IF(var_group_3=1)THEN
			SET sql_group2=CONCAT('
				UPDATE ',report_table,' SET num = 2 WHERE num != 1;
			');
		ELSE
			SET sql_group2=CONCAT('
				INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
				SELECT 2,group_1, group_2,0,SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM 
				',report_table,'
				WHERE num!=1
				GROUP BY
				group_1,
				group_2;
			');
		END IF;
	END IF;
	IF(check_report>0)THEN
		CASE emulation_mode
			WHEN 0 THEN 
				SET @sql_TRUNCATE=sql_TRUNCATE;
				PREPARE reports_TRUNCATE FROM @sql_TRUNCATE;
				EXECUTE reports_TRUNCATE;
				DEALLOCATE PREPARE reports_TRUNCATE;
				
				SET @report_all_sql=sql_all_report;
				PREPARE reports FROM @report_all_sql;
				EXECUTE reports;
				DEALLOCATE PREPARE reports;
				
				SET @sql_group1=sql_group1;
				PREPARE sql_group1 FROM @sql_group1;
				EXECUTE sql_group1;
				DEALLOCATE PREPARE sql_group1;
				
				IF(sql_group2!='0')THEN
					SET @sql_group2=sql_group2;
					PREPARE sql_group2 FROM @sql_group2;
					EXECUTE sql_group2;
					DEALLOCATE PREPARE sql_group2;
				END IF;
				SELECT var_select_group_1,var_select_group_2,var_select_group_3, check_report AS status;
			WHEN 1 THEN 
				SELECT sql_TRUNCATE, sql_all_report, sql_tr, sql_group1, sql_group2, var_select_group_1, var_select_group_2, var_select_group_3, check_report AS status, developer_mode, name_group_1,name_group_2,name_group_3;
			WHEN 2 THEN 
				SELECT sql_TRUNCATE, sql_all_report, sql_tr, sql_group1, sql_group2, var_select_group_1, var_select_group_2, var_select_group_3, check_report AS status, developer_mode, name_group_1,name_group_2,name_group_3;
		END CASE;
	ELSE
		IF(emulation_mode!=2)THEN
			SET @sql_TRUNCATE=sql_TRUNCATE;
			PREPARE reports_TRUNCATE FROM @sql_TRUNCATE;
			EXECUTE reports_TRUNCATE;
			DEALLOCATE PREPARE reports_TRUNCATE;
		END IF;
		SELECT 0 AS status;
	END IF;
END
<next>
CREATE PROCEDURE report_upload_direct (IN var_group_1 INT, IN var_group_2 INT, IN var_group_3 INT, IN camp_id INT, IN start_date VARCHAR(32), IN end_date VARCHAR(32), IN report_table VARCHAR(32), IN emulation_mode INT) BEGIN
	/*Binom 15000 1.5*/
	DECLARE type_report VARCHAR(10) DEFAULT 'direct';
	DECLARE var_group_title_1,var_group_title_2,var_group_title_3 TEXT DEFAULT '';
	DECLARE var_select_group_1,var_select_group_2,var_select_group_3 TEXT DEFAULT '';
	DECLARE sql_all_report,sql_tr LONGTEXT DEFAULT '';
	DECLARE sql_group1,sql_group2,sql_TRUNCATE LONGTEXT DEFAULT '';
	DECLARE name_group_1,name_group_2,name_group_3 TEXT DEFAULT '';
	SET start_date=UNIX_TIMESTAMP(start_date);
	SET end_date=UNIX_TIMESTAMP(end_date);
	CALL report_select_group(1, var_group_1, camp_id, type_report, '', var_group_title_1, var_select_group_1,name_group_1);
	CALL report_select_group(2, var_group_2, camp_id, type_report, '', var_group_title_2, var_select_group_2,name_group_2);
	CALL report_select_group(3, var_group_3, camp_id, type_report, '', var_group_title_3, var_select_group_3,name_group_3);
	SET sql_tr=CONCAT('
		(SELECT 
			COUNT(*) AS clicks,
			sum(is_bot) AS bots,
			sum(IF(landing_page>0,offer_click,0)) AS clicks_offer,
			sum(IF(landing_page>0,1,0)) AS clicks_landing,
			sum(IF(cvr_id>0,1,0)) AS leads,
			sum(cpc) AS spend,
			sum(pay) AS pay,
			',var_group_title_1,' AS group_1,
			',var_group_title_2,' AS group_2,
			',var_group_title_3,' AS group_3
		FROM clicks AS table_rp 
		WHERE camp_id = ',camp_id,' AND click_time>',start_date,' AND click_time<',end_date,'
		GROUP BY ',name_group_1,',',name_group_2,',',name_group_3,')
	');
	SET sql_all_report=CONCAT('
		INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
			SELECT 3,group_1,group_2,group_3, SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM(
				(
					',sql_tr,'
				)
			) AS report
			GROUP BY
			',name_group_1,',',name_group_2,',',name_group_3,';
	');
	IF(var_group_2=1 AND var_group_3=1)THEN
		SET sql_group1=CONCAT('
			UPDATE ',report_table,' SET num = 1;
		');
		SET sql_group2='0';
	ELSE
		SET sql_group1=CONCAT('
			INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
			SELECT 1,group_1, 0,0,SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM 
			',report_table,'
			GROUP BY
			group_1;
		');
		IF(var_group_3=1)THEN
			SET sql_group2=CONCAT('
				UPDATE ',report_table,' SET num = 2 WHERE num != 1;
			');
		ELSE
			SET sql_group2=CONCAT('
				INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
				SELECT 2,group_1, group_2,0,SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM 
				',report_table,'
				WHERE num!=1
				GROUP BY
				group_1,
				group_2;
			');
		END IF;
	END IF;
	SET sql_TRUNCATE=CONCAT('TRUNCATE ',report_table);
	SET sql_all_report=CONCAT('
		INSERT INTO `',report_table,'`(`num`,`group_1`, `group_2`, `group_3`, `clicks`,`bots`,`clicks_offer`,`clicks_landing`,`leads`,`spend`,`pay`) 
			SELECT 3,group_1,group_2,group_3, SUM(clicks), SUM(bots), SUM(clicks_offer), SUM(clicks_landing), SUM(leads), SUM(spend), SUM(pay) FROM(
				',sql_tr,'
			) AS report
			GROUP BY
			group_1,group_2,group_3;
	');
	CASE emulation_mode
		WHEN 0 THEN 
			SET @sql_TRUNCATE=sql_TRUNCATE;
			PREPARE reports_TRUNCATE FROM @sql_TRUNCATE;
			EXECUTE reports_TRUNCATE;
			DEALLOCATE PREPARE reports_TRUNCATE;
			
			SET @report_all_sql=sql_all_report;
			PREPARE reports FROM @report_all_sql;
			EXECUTE reports;
			DEALLOCATE PREPARE reports;
			
			SET @sql_group1=sql_group1;
			PREPARE sql_group1 FROM @sql_group1;
			EXECUTE sql_group1;
			DEALLOCATE PREPARE sql_group1;
			IF(sql_group2!='0')THEN
				SET @sql_group2=sql_group2;
				PREPARE sql_group2 FROM @sql_group2;
				EXECUTE sql_group2;
				DEALLOCATE PREPARE sql_group2;
			END IF;
			SELECT var_select_group_1,var_select_group_2,var_select_group_3, 1 AS status;
		WHEN 1 THEN 
			SELECT sql_TRUNCATE, sql_all_report, sql_tr, sql_group1, sql_group2, var_select_group_1, var_select_group_2, var_select_group_3, 1 AS status, name_group_1,name_group_2,name_group_3;
		WHEN 2 THEN 
			SELECT sql_TRUNCATE, sql_all_report, sql_tr, sql_group1, sql_group2, var_select_group_1, var_select_group_2, var_select_group_3, 1 AS status, name_group_1,name_group_2,name_group_3;
	END CASE;
END;