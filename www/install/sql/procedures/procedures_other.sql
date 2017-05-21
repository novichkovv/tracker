CREATE PROCEDURE backup_load () BEGIN
	/*Binom 11000 1.1*/
	IF((SELECT @@global.event_scheduler)!='ON')THEN
		SET GLOBAL event_scheduler=ON;
		SELECT 1;
	ELSE
		SELECT 0;
	END IF;
END
<next>
CREATE PROCEDURE clear_all () BEGIN
	/*Binom 11000 1.1*/
	DECLARE time_client DATETIME;
	DECLARE time_client_unix, id_proc INT;
	DECLARE i, count_1, check_id, camp_id, check_err_tc, check_err_tt,count_cl_info INT;
	DECLARE table_name, err_info VARCHAR(128);
	DECLARE flag INT DEFAULT 0;
	CALL time_convert(NOW(),time_client);
	SET time_client_unix = UNIX_TIMESTAMP(time_client);
	SET count_cl_info = (SELECT COUNT(*) FROM clicks_info);
	IF(count_cl_info >300000)THEN
		SET check_id = (SELECT id FROM clicks_info WHERE cnv=0 ORDER BY id DESC LIMIT 200000, 1);
		DELETE FROM clicks_info WHERE id < check_id;
	ELSE
		DELETE FROM clicks_info WHERE (UNIX_TIMESTAMP(NOW())-time_cl)>(86400*3);
	END IF;
	SET count_1 = (SELECT COUNT(*) FROM proc_1);
	IF(count_1 >1000)THEN
		SET check_id = (SELECT id FROM proc_1 WHERE end_date !=0 ORDER BY id DESC LIMIT 1000, 1);
		DELETE FROM proc_1 WHERE id < check_id;
	END IF;
	SET count_1 = (SELECT COUNT(*) FROM proc_2);
	IF(count_1 >720)THEN
		SET check_id = (SELECT id FROM proc_2 WHERE end_date !=0 ORDER BY id DESC LIMIT 720, 1);
		DELETE FROM proc_2 WHERE id < check_id;
	END IF;
	SET count_1 = (SELECT COUNT(*) FROM proc_3);
	IF(count_1 >515)THEN
		SET check_id = (SELECT id FROM proc_3 WHERE end_date !=0 ORDER BY id DESC LIMIT 515, 1);
		DELETE FROM proc_3 WHERE id < check_id;
	END IF;
	SET count_1 = (SELECT COUNT(*) FROM proc_4);
	IF(count_1 >515)THEN
		SET check_id = (SELECT id FROM proc_4 WHERE end_date !=0 ORDER BY id DESC LIMIT 515, 1);
		DELETE FROM proc_4 WHERE id < check_id;
	END IF;
	SET count_1 = (SELECT COUNT(*) FROM err_log);
	IF(count_1 >500)THEN
		SET check_id = (SELECT id FROM err_log ORDER BY id DESC LIMIT 500, 1);
		DELETE FROM err_log WHERE id < check_id;
	END IF;
	SET check_err_tt = (SELECT COUNT(*) FROM temp_table WHERE (SELECT id FROM clicks WHERE id = click_id) IS NULL);
	IF(check_err_tt>0)THEN
		INSERT INTO temp_table_err(`click_id`, `cvr_id`, `offer_click`, `pay`, `cpc`, `info`) SELECT click_id,cvr_id,offer_click,pay,cpc, 'err_tt' FROM temp_table WHERE (SELECT id FROM clicks WHERE id = click_id) IS NULL;
		DELETE FROM temp_table WHERE (SELECT id FROM clicks WHERE id = click_id) IS NULL;
	END IF;
	SET id_proc = (SELECT id FROM proc_1 WHERE end_date = 0 AND (time_client_unix-start_date) > 5 AND start_date!=0 LIMIT 1);
	IF(id_proc IS NOT NULL)THEN
		SET check_err_tc = (SELECT COUNT(*) AS err_clicks FROM temp_clicks AS tc WHERE (SELECT id FROM clicks WHERE id = tc.id) IS NOT NULL);
		IF(check_err_tc>0)THEN
			DELETE FROM temp_clicks WHERE (SELECT id FROM clicks WHERE id = temp_clicks.id) IS NOT NULL;
			SET err_info = (SELECT CONCAT(id,':',start_date,',',dop_info) AS err_info FROM proc_1 WHERE id = id_proc);
			INSERT INTO err_log(`type`, info, `date`)VALUES(9,err_info,time_client_unix);
		ELSE
			SET err_info = (SELECT CONCAT(id,':',start_date,',',dop_info) AS err_info FROM proc_1 WHERE id = id_proc);
			INSERT INTO err_log(`type`, info, `date`)VALUES(1,err_info,time_client_unix);
		END IF;
		DELETE FROM proc_1 WHERE end_date = 0 AND (time_client_unix-start_date) > 5 AND start_date!=0;
	END IF;
	SET id_proc = (SELECT id FROM proc_2 WHERE end_date = 0 AND (time_client_unix-start_date) > 600 AND start_date!=0 LIMIT 1);
	IF(id_proc IS NOT NULL)THEN
		SET err_info = (SELECT CONCAT(id,':',start_date,',',dop_info) AS err_info FROM proc_2 WHERE id = id_proc);
		INSERT INTO err_log(`type`, info, `date`)VALUES(2,err_info,time_client_unix);
		DELETE FROM proc_2 WHERE end_date = 0 AND (time_client_unix-start_date) > 600 AND start_date!=0;
	END IF;
	SET id_proc = (SELECT id FROM proc_3 WHERE end_date = 0 AND (time_client_unix-start_date) > 600 AND start_date!=0 LIMIT 1);
	IF(id_proc IS NOT NULL)THEN
		SET err_info = (SELECT CONCAT(id,':',start_date,',',dop_info) AS err_info FROM proc_3 WHERE id = id_proc);
		INSERT INTO err_log(`type`, info, `date`)VALUES(3,err_info,time_client_unix);
		DELETE FROM proc_3 WHERE end_date = 0 AND (time_client_unix-start_date) > 600 AND start_date!=0;
	END IF;
	SET id_proc = (SELECT id FROM proc_4 WHERE end_date = 0 AND (time_client_unix-start_date) > 600 AND start_date!=0 LIMIT 1);
	IF(id_proc IS NOT NULL)THEN
		SET err_info = (SELECT CONCAT(id,':',start_date,',',dop_info) AS err_info FROM proc_4 WHERE id = id_proc);
		INSERT INTO err_log(`type`, info, `date`)VALUES(4,err_info,time_client_unix);
		DELETE FROM proc_4 WHERE end_date = 0 AND (time_client_unix-start_date) > 600 AND start_date!=0;
	END IF;
END
<next>
CREATE PROCEDURE clear_camp(IN camp_id_var INT) BEGIN
	/*Binom 16000*/
	DECLARE flag INT DEFAULT 0;
	DECLARE var_temp_click_id INT;
	DECLARE table_name_var VARCHAR(32);
	DECLARE var_clicks, var_clicks_offer, var_clicks_landing, var_leads, var_bots,var_el_id INT;
	DECLARE var_pay, var_spend decimal(9,5);
	DECLARE cursor_1 CURSOR FOR
		SELECT table_name FROM information_schema.tables WHERE table_name REGEXP CONCAT("^report_camp_",camp_id_var,"_") OR table_name REGEXP CONCAT("^report_camp_token_",camp_id_var,"_") AND TABLE_SCHEMA = '{data_base}';
	DECLARE cursor_month CURSOR FOR
		SELECT table_name FROM information_schema.tables WHERE table_name REGEXP CONCAT("^month_report_camp_",camp_id_var,"_") OR table_name REGEXP CONCAT("^month_report_camp_token_",camp_id_var,"_") OR table_name REGEXP CONCAT("^month_report_camp_ip_",camp_id_var,"_") AND TABLE_SCHEMA = '{data_base}';
	DECLARE cursor_2 CURSOR FOR
		SELECT table_name FROM information_schema.tables WHERE table_name REGEXP CONCAT("^report_camp_ip_",camp_id_var,"_") AND TABLE_SCHEMA = '{data_base}';
	DECLARE cursor_3 CURSOR FOR
		SELECT table_name FROM information_schema.tables WHERE table_name REGEXP CONCAT("^report_camp_token_",camp_id_var,"_") AND TABLE_SCHEMA = '{data_base}';
	DECLARE cursor_4 CURSOR FOR
		SELECT id FROM clicks WHERE camp_id = camp_id_var;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	DELETE FROM temp_clicks WHERE camp_id = camp_id_var;
	DELETE FROM showcase_landings WHERE camp_id = camp_id_var;
	DELETE FROM showcase_networks WHERE camp_id = camp_id_var;
	DELETE FROM showcase_offers WHERE camp_id = camp_id_var;
	DELETE FROM showcase_sources WHERE camp_id = camp_id_var;
	DELETE FROM showcase_campaigns WHERE el_id = camp_id_var;
	DELETE FROM tokens_lp WHERE camp_id = camp_id_var;
	OPEN cursor_month;
		REPEAT
			FETCH cursor_month INTO table_name_var;
			IF NOT flag THEN
				SET @sql_delete = CONCAT('DROP TABLE IF EXISTS ',table_name_var);
				PREPARE delete_camp_table FROM @sql_delete;
				EXECUTE delete_camp_table;
				DEALLOCATE PREPARE delete_camp_table;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_month;
	SET flag=0;
	OPEN cursor_1;
		REPEAT
			FETCH cursor_1 INTO table_name_var;
			IF NOT flag THEN
				SET @sql_delete = CONCAT('DROP TABLE IF EXISTS ',table_name_var);
				PREPARE delete_camp_table FROM @sql_delete;
				EXECUTE delete_camp_table;
				DEALLOCATE PREPARE delete_camp_table;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_1;
	SET flag=0;
	OPEN cursor_3;
		REPEAT
			FETCH cursor_3 INTO table_name_var;
			IF NOT flag THEN
				SET @sql_delete = CONCAT('DROP TABLE IF EXISTS ',table_name_var);
				PREPARE delete_camp_table FROM @sql_delete;
				EXECUTE delete_camp_table;
				DEALLOCATE PREPARE delete_camp_table;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_3;
	SET flag=0;
	
	OPEN cursor_4;
		REPEAT
			FETCH cursor_4 INTO var_temp_click_id;
			IF NOT flag THEN
				DELETE FROM clicks_referer_url WHERE click_id = var_temp_click_id;
				DELETE FROM clicks_tokens WHERE click_id = var_temp_click_id;
				DELETE FROM clicks_tokens_lp WHERE click_id = var_temp_click_id;
				DELETE FROM clicks WHERE id = var_temp_click_id;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_4;
	SET flag=0;
	OPEN cursor_2;
		REPEAT
			FETCH cursor_2 INTO table_name_var;
			IF NOT flag THEN
				SET @sql_delete = CONCAT('DROP TABLE IF EXISTS ',table_name_var);
				PREPARE delete_camp_table FROM @sql_delete;
				EXECUTE delete_camp_table;
				DEALLOCATE PREPARE delete_camp_table;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_2;
	DELETE FROM conversion WHERE camp_id = camp_id_var;
END
<next>
CREATE PROCEDURE clear_report_ip () BEGIN
	DECLARE flag INT DEFAULT 0;
	DECLARE clear_info, var_table_name VARCHAR(512);
	DECLARE create_table DATE;
	DECLARE cursor_2 CURSOR FOR SELECT table_name FROM information_schema.tables WHERE table_name REGEXP CONCAT("^report_camp_ip_[0-9]*_", DATE_FORMAT((time_client - INTERVAL 15 DAY),  '%d%m%Y')) OR table_name REGEXP CONCAT("^report_camp_ip_[0-9]*_", DATE_FORMAT((time_client - INTERVAL 3 MONTH),  '%m%Y')) AND table_schema = '{data_base}';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_2;
		REPEAT
			FETCH cursor_2 INTO var_table_name;
			IF NOT flag THEN
				SET @clear_all_sql_drop = CONCAT('DROP TABLE IF EXISTS ',var_table_name);
				PREPARE drop_ip FROM @clear_all_sql_drop;
				EXECUTE drop_ip;
				DEALLOCATE PREPARE drop_ip;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_2;
END
<next>
CREATE PROCEDURE ip_convert (IN ip BIGINT, OUT var_ip VARCHAR(13), OUT var_ip_1 INT, OUT var_ip_2 INT, OUT var_ip_3 INT, OUT var_ip_4 INT) BEGIN
	DECLARE length_ip INT;
	SET length_ip = LENGTH(ip);
	SET var_ip_1=SUBSTRING(ip,1,(3-(12-length_ip)));
	SET var_ip_2=SUBSTRING(ip,(4-(12-length_ip)),3);
	SET var_ip_3=SUBSTRING(ip,(7-(12-length_ip)),3);
	SET var_ip_4=SUBSTRING(ip,(10-(12-length_ip)),3);
	SET var_ip=CONCAT(var_ip_1,'.',var_ip_2,'.',var_ip_3,'.',var_ip_4);
END
<next>
CREATE PROCEDURE reload_all() BEGIN
	/*Binom 11000 1.1*/
	DECLARE flag INT DEFAULT 0;
	DECLARE table_name_var VARCHAR(64);
	DECLARE check_table INT;
	DECLARE cursor_1 CURSOR FOR
		SELECT table_name FROM information_schema.tables WHERE table_name REGEXP "^month_report_camp_" OR table_name REGEXP "^month_report_camp_ip_" OR table_name REGEXP "^month_report_camp_token_" OR table_name REGEXP "^report_camp_" OR table_name REGEXP "^report_camp_ip_" OR table_name REGEXP "^report_camp_token_" AND TABLE_SCHEMA = '{data_base}';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'proc_reload_all' AND table_schema = '{data_base}');
	IF(check_table=0)THEN
		/*очищаем все данные*/
		OPEN cursor_1;
			REPEAT
				FETCH cursor_1 INTO table_name_var;
				IF NOT flag THEN
					SET @sql_delete = CONCAT('DROP TABLE IF EXISTS ',table_name_var);
					PREPARE delete_camp_table FROM @sql_delete;
					EXECUTE delete_camp_table;
					DEALLOCATE PREPARE delete_camp_table;
				END IF;
			UNTIL flag END REPEAT;
		CLOSE cursor_1;
		TRUNCATE showcase_sources;
		TRUNCATE showcase_offers;
		TRUNCATE showcase_networks;
		TRUNCATE showcase_landings;
		TRUNCATE showcase_campaigns;
		SET @create_ra_table="
			CREATE TABLE IF NOT EXISTS `proc_reload_all` (
				id int(11) NOT NULL AUTO_INCREMENT,
				`date_name` VARCHAR(16),
				`month` INT,
				`year` INT,
				`cnt` INT,
				`start_click` INT,
				`end_click` INT,
				`start_date` INT,
				`end_date` INT,
				`status` TINYINT,
				PRIMARY KEY (`id`)
			) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
		";
		PREPARE create_ra FROM @create_ra_table;
		EXECUTE create_ra;
		DEALLOCATE PREPARE create_ra;
		INSERT INTO proc_reload_all(date_name, `month`, `year`, cnt, start_click, end_click, start_date, end_date, status) 
		SELECT 
			FROM_UNIXTIME(click_time, '%d%m%Y') AS date_name,
			FROM_UNIXTIME(click_time, '%m'),
			FROM_UNIXTIME(click_time, '%Y'),
			COUNT(*) AS cnt,
			MAX(id) AS start_click,
			MIN(id) AS end_click,
			0,
			0,
			0
		FROM 
			clicks 
		WHERE 
			id != 0
		GROUP BY 
			FROM_UNIXTIME(click_time, '%d%m%Y')
		ORDER BY click_time DESC;
	ELSE
		SELECT("Is_reload");
	END IF;
END
<next>
CREATE PROCEDURE reload_all_process(IN var_date_name VARCHAR(16), IN var_month_s INT, IN var_month_e INT, IN var_year INT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE flag,var_start_click,var_end_click,i INT DEFAULT 0;
	DECLARE table_name_var,table_name_check_sc VARCHAR(64);
	IF(var_date_name!=0)THEN
		SELECT start_click, end_click INTO var_start_click, var_end_click FROM proc_reload_all WHERE date_name=var_date_name;
		SET var_end_click=var_end_click-1;
		CALL report_load(var_end_click,var_start_click,1);
		UPDATE proc_reload_all SET end_date=UNIX_TIMESTAMP(NOW()),status=2 WHERE `date_name` = var_date_name;
	ELSE
		UPDATE proc_reload_all SET status=3 WHERE `year` = var_year;
		CALL report_month_all(var_month_s,var_month_e,var_year);
		UPDATE proc_reload_all SET status=4 WHERE `year` = var_year;
		WHILE i < 6 DO
			SET i=i+1;
			CASE i  
				WHEN 1 THEN  
					SET table_name_check_sc = '{data_base}.showcase_campaigns';
				WHEN 2 THEN  
					SET table_name_check_sc = '{data_base}.showcase_landings';
				WHEN 3 THEN  
					SET table_name_check_sc = '{data_base}.showcase_networks';
				WHEN 4 THEN  
					SET table_name_check_sc = '{data_base}.showcase_offers';
				ELSE  
					SET table_name_check_sc = '{data_base}.showcase_sources';
			END CASE; 
			SET @sql1=CONCAT(
				'DELETE FROM ',table_name_check_sc,' WHERE date_type=3 OR date_type=2'
			);
			PREPARE sql1 FROM @sql1;
			EXECUTE sql1;
			DEALLOCATE PREPARE sql1;
			SET @sql2=CONCAT(
				'INSERT INTO ',table_name_check_sc,'(
					el_id,
					date_type,
					date_name,
					clicks,
					clicks_offer,
					clicks_landing,
					leads,
					bots,
					spend,
					pay,
					last_click,
					camp_id
				) 
				SELECT
					el_id,
					2,
					RIGHT(date_name,6),
					SUM(clicks),
					SUM(clicks_offer),
					SUM(clicks_landing),
					SUM(leads),
					SUM(bots),
					SUM(spend),
					SUM(pay),
					last_click,
					camp_id
				FROM
					',table_name_check_sc,'
				WHERE
					date_type=1
				GROUP BY
					camp_id,el_id,RIGHT(date_name,6)'
			);
			PREPARE sql2 FROM @sql2;
			EXECUTE sql2;
			DEALLOCATE PREPARE sql2;
			SET @sql3=CONCAT(
				'INSERT INTO ',table_name_check_sc,'(
					el_id,
					date_type,
					date_name,
					clicks,
					clicks_offer,
					clicks_landing,
					leads,
					bots,
					spend,
					pay,
					last_click,
					camp_id
				) 
				SELECT
					el_id,
					3,
					RIGHT(date_name,4),
					SUM(clicks),
					SUM(clicks_offer),
					SUM(clicks_landing),
					SUM(leads),
					SUM(bots),
					SUM(spend),
					SUM(pay),
					last_click,
					camp_id
				FROM
					',table_name_check_sc,'
				WHERE
					date_type=1
				GROUP BY
					camp_id,el_id,RIGHT(date_name,4)'
			);
			PREPARE sql3 FROM @sql3;
			EXECUTE sql3;
			DEALLOCATE PREPARE sql3;
		END WHILE;
	END IF;
END; 
<next>
CREATE PROCEDURE update_costs_step_1(IN start_row INT, IN finish_row INT) BEGIN
	/*Binom 14000 1.4*/
	IF((SELECT COUNT(*) FROM temp_update_costs WHERE status=1)=0)THEN
		UPDATE temp_update_costs SET status=1 WHERE id>=start_row AND id<=finish_row;
		CREATE TEMPORARY TABLE temp_table_update_costs
		SELECT 
			cl.id AS clicks,
			FROM_UNIXTIME(cl.click_time, '%H') AS click_hour,
			tup.cpc AS cpc,
			cl.cpc AS old_cpc, 
			cl.camp_id AS camp,
			cl.offer AS offer,
			cl.landing_page AS landing_page,
			cl.an AS an,
			cl.ts_id AS ts_id,
			CONCAT('_',cl.camp_id,'_',FROM_UNIXTIME(cl.click_time, '%d%m%Y')) AS date_table, 
			CONCAT('_',cl.camp_id,'_',FROM_UNIXTIME(cl.click_time, '%m%Y')) AS m_date_table,
			FROM_UNIXTIME(cl.click_time, '%d%m%Y') AS date_table_1, 
			FROM_UNIXTIME(cl.click_time, '%m%Y') AS date_table_2, 
			FROM_UNIXTIME(cl.click_time, '%Y') AS date_table_3
		FROM temp_update_costs AS tup
		LEFT JOIN clicks AS cl ON cl.id=tup.click_id
		WHERE tup.id>=start_row AND tup.id<=finish_row
		GROUP BY clicks;
		CALL update_costs_step_2(start_row, finish_row);
		DELETE FROM temp_update_costs WHERE id>=start_row AND id<=finish_row;
	END IF;
END
<next>
CREATE PROCEDURE update_costs_step_2(IN start_row INT, IN finish_row INT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE 
		test
	LONGTEXT;
	DECLARE 
		flag,var_clicks,var_clicks_hour, var_camp, var_sh_t1, var_sh_t2, var_sh_t3, var_offer, var_lp, var_an, var_ts
	INT DEFAULT 0;
	DECLARE
		var_date_table,var_m_date_table
	VARCHAR(64);
	DECLARE
		var_cpc,var_new_spend,var_old_spend,new_cpc,var_old_cpc
	DECIMAL(15,5);
	DECLARE cursor_1 CURSOR FOR 
		SELECT 
			COUNT(*) AS clicks,
			click_hour,
			cpc,
			old_cpc,
			cpc*COUNT(*) AS new_spend,
			SUM(old_cpc) AS old_spend,
			date_table
		FROM temp_table_update_costs
		GROUP BY
			click_hour,
			date_table;	
	DECLARE cursor_2 CURSOR FOR 
		SELECT 
			COUNT(*) AS clicks,
			click_hour,
			cpc,
			old_cpc,
			cpc*COUNT(*) AS new_spend,
			SUM(old_cpc) AS old_spend,
			m_date_table
		FROM temp_table_update_costs
		WHERE m_date_table NOT LIKE CONCAT('%_',FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()), '%m%Y'),'%')
		GROUP BY 
			click_hour,
			m_date_table;
	DECLARE cursor_camp CURSOR FOR 
		SELECT 
			COUNT(*) AS clicks,
			cpc,
			old_cpc,
			cpc*COUNT(*) AS new_spend,
			SUM(old_cpc) AS old_spend,
			camp,
			date_table_1,
			date_table_2,
			date_table_3
		FROM temp_table_update_costs
		GROUP BY
			camp,
			date_table_1;
	DECLARE cursor_offer CURSOR FOR 
		SELECT 
			COUNT(*) AS clicks,
			cpc,
			old_cpc,
			cpc*COUNT(*) AS new_spend,
			SUM(old_cpc) AS old_spend,
			camp,
			offer,
			date_table_1,
			date_table_2,
			date_table_3
		FROM temp_table_update_costs
		GROUP BY
			offer,
			camp,
			date_table_1;
	DECLARE cursor_lp CURSOR FOR 
		SELECT 
			COUNT(*) AS clicks,
			cpc,
			old_cpc,
			cpc*COUNT(*) AS new_spend,
			SUM(old_cpc) AS old_spend,
			camp,
			landing_page,
			date_table_1,
			date_table_2,
			date_table_3
		FROM temp_table_update_costs
		GROUP BY
			landing_page,
			camp,
			date_table_1;
	DECLARE cursor_an CURSOR FOR 
		SELECT 
			COUNT(*) AS clicks,
			cpc,
			old_cpc,
			cpc*COUNT(*) AS new_spend,
			SUM(old_cpc) AS old_spend,
			camp,
			an,
			date_table_1,
			date_table_2,
			date_table_3
		FROM temp_table_update_costs
		GROUP BY
			an,
			camp,
			date_table_1;
	DECLARE cursor_ts CURSOR FOR 
		SELECT 
			COUNT(*) AS clicks,
			cpc,
			old_cpc,
			cpc*COUNT(*) AS new_spend,
			SUM(old_cpc) AS old_spend,
			camp,
			ts_id,
			date_table_1,
			date_table_2,
			date_table_3
		FROM temp_table_update_costs
		GROUP BY
			ts_id,
			camp,
			date_table_1;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_1;
		REPEAT
			FETCH cursor_1 INTO var_clicks, var_clicks_hour, var_cpc, var_old_cpc, var_new_spend, var_old_spend, var_date_table;
			IF NOT flag THEN
				IF((SELECT COUNT(*) FROM information_schema.tables WHERE table_name = CONCAT('report_camp',var_date_table) AND table_schema = '{data_base}')>0)THEN
					SET @sql_update_1=CONCAT('UPDATE report_camp',var_date_table,' SET spend = clicks * ',var_cpc,' WHERE hour_click = ',var_clicks_hour);
					PREPARE sql_cost_update_1 FROM @sql_update_1;
					EXECUTE sql_cost_update_1;
					DEALLOCATE PREPARE sql_cost_update_1;
				END IF;
				
				IF((SELECT COUNT(*) FROM information_schema.tables WHERE table_name = CONCAT('report_camp_ip',var_date_table) AND table_schema = '{data_base}')>0)THEN
					SET @sql_update_2=CONCAT('UPDATE report_camp_ip',var_date_table,' SET spend = clicks * ',var_cpc,' WHERE hour_click = ',var_clicks_hour);
					PREPARE sql_cost_update_2 FROM @sql_update_2;
					EXECUTE sql_cost_update_2;
					DEALLOCATE PREPARE sql_cost_update_2;
				END IF;
				
				IF((SELECT COUNT(*) FROM information_schema.tables WHERE table_name = CONCAT('report_camp_token',var_date_table) AND table_schema = '{data_base}')>0)THEN
					SET @sql_update_3=CONCAT('UPDATE report_camp_token',var_date_table,' SET spend = clicks * ',var_cpc,' WHERE hour_click = ',var_clicks_hour);
					PREPARE sql_cost_update_3 FROM @sql_update_3;
					EXECUTE sql_cost_update_3;
					DEALLOCATE PREPARE sql_cost_update_3;
				END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_1;
	SET flag = 0;
	OPEN cursor_2;
		REPEAT
			FETCH cursor_2 INTO var_clicks, var_clicks_hour, var_cpc, var_old_cpc, var_new_spend, var_old_spend, var_m_date_table;
			IF NOT flag THEN
				IF((SELECT COUNT(*) FROM information_schema.tables WHERE table_name = CONCAT('month_report_camp',var_m_date_table) AND table_schema = '{data_base}')>0)THEN
					SET @sql_select_1=CONCAT('SELECT (SUM(spend)-',var_old_spend,'+',var_new_spend,')/SUM(clicks) INTO @new_cpc FROM month_report_camp',var_m_date_table,' WHERE hour_click = ',var_clicks_hour);
					PREPARE sql_cost_select_1 FROM @sql_select_1;
					EXECUTE sql_cost_select_1;
					DEALLOCATE PREPARE sql_cost_select_1;
					
					SET @sql_update_1=CONCAT('UPDATE month_report_camp',var_m_date_table,' SET spend = clicks * ',@new_cpc,'
					WHERE hour_click = ',var_clicks_hour);
					PREPARE sql_cost_update_1 FROM @sql_update_1;
					EXECUTE sql_cost_update_1;
					DEALLOCATE PREPARE sql_cost_update_1;
					
					IF((SELECT COUNT(*) FROM information_schema.tables WHERE table_name = CONCAT('month_report_camp_ip',var_m_date_table) AND table_schema = '{data_base}')>0)THEN
						SET @sql_update_2=CONCAT('UPDATE month_report_camp_ip',var_m_date_table,' SET spend = clicks * ',@new_cpc,'
						WHERE hour_click = ',var_clicks_hour);
						PREPARE sql_cost_update_2 FROM @sql_update_2;
						EXECUTE sql_cost_update_2;
						DEALLOCATE PREPARE sql_cost_update_2;
					END IF;
					
					IF((SELECT COUNT(*) FROM information_schema.tables WHERE table_name = CONCAT('month_report_camp_token',var_m_date_table) AND table_schema = '{data_base}')>0)THEN
						SET @sql_update_3=CONCAT('UPDATE month_report_camp_token',var_m_date_table,' SET spend = clicks * ',@new_cpc,'
						WHERE hour_click = ',var_clicks_hour);
						PREPARE sql_cost_update_2 FROM @sql_update_2;
						EXECUTE sql_cost_update_2;
						DEALLOCATE PREPARE sql_cost_update_2;
					END IF;
				END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_2;
	SET flag = 0;
	OPEN cursor_camp;
		REPEAT
			FETCH cursor_camp INTO var_clicks, var_cpc, var_old_cpc, var_new_spend, var_old_spend, var_camp, var_sh_t1, var_sh_t2, var_sh_t3;
			IF NOT flag THEN
				UPDATE showcase_campaigns SET spend=spend-var_old_spend+var_new_spend WHERE el_id = var_camp 
				AND (date_name=var_sh_t1 OR date_name=var_sh_t2 OR date_name=var_sh_t3);
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_camp;
	SET flag = 0;
	OPEN cursor_offer;
		REPEAT
			FETCH cursor_offer INTO var_clicks, var_cpc, var_old_cpc, var_new_spend, var_old_spend, var_camp, var_offer, var_sh_t1, var_sh_t2, var_sh_t3;
			IF NOT flag THEN
				UPDATE showcase_offers SET spend=spend-var_old_spend+var_new_spend WHERE el_id = var_offer AND camp_id = var_camp 
				AND (date_name=var_sh_t1 OR date_name=var_sh_t2 OR date_name=var_sh_t3);
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_offer;
	SET flag = 0;
	OPEN cursor_lp;
		REPEAT
			FETCH cursor_lp INTO var_clicks, var_cpc, var_old_cpc, var_new_spend, var_old_spend, var_camp, var_lp, var_sh_t1, var_sh_t2, var_sh_t3;
			IF NOT flag THEN
				UPDATE showcase_landings SET spend=spend-var_old_spend+var_new_spend WHERE el_id = var_lp AND camp_id = var_camp 
				AND (date_name=var_sh_t1 OR date_name=var_sh_t2 OR date_name=var_sh_t3);
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_lp;
	SET flag = 0;
	OPEN cursor_an;
		REPEAT
			FETCH cursor_an INTO var_clicks, var_cpc, var_old_cpc, var_new_spend, var_old_spend, var_camp, var_an, var_sh_t1, var_sh_t2, var_sh_t3;
			IF NOT flag THEN
				UPDATE 	showcase_networks SET spend=spend-var_old_spend+var_new_spend WHERE el_id = var_an AND camp_id = var_camp 
				AND (date_name=var_sh_t1 OR date_name=var_sh_t2 OR date_name=var_sh_t3);
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_an;
	SET flag = 0;
	OPEN cursor_ts;
		REPEAT
			FETCH cursor_ts INTO var_clicks, var_cpc, var_old_cpc, var_new_spend, var_old_spend, var_camp, var_ts, var_sh_t1, var_sh_t2, var_sh_t3;
			IF NOT flag THEN
				UPDATE 	showcase_sources SET spend=spend-var_old_spend+var_new_spend WHERE el_id = var_ts AND camp_id = var_camp 
				AND (date_name=var_sh_t1 OR date_name=var_sh_t2 OR date_name=var_sh_t3);
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_ts;
	UPDATE clicks AS cl
		JOIN
	temp_update_costs AS tuc ON cl.id = tuc.click_id 
	SET cl.cpc = tuc.cpc
	WHERE tuc.id>=start_row AND tuc.id<=finish_row;
END;
<next>
CREATE PROCEDURE time_convert (IN time_server DATETIME, OUT time_client DATETIME) BEGIN
	DECLARE timezone INT;
	SET timezone={timezone};
	IF(timezone>0 OR timezone=0)THEN
		SET time_client=convert_tz(time_server,@@session.time_zone,CONCAT('+',timezone,':00'));
	ELSE
		SET time_client=convert_tz(time_server,@@session.time_zone,CONCAT(timezone,':00'));
	END IF;
END
<next>
CREATE PROCEDURE check_all_step_1() BEGIN
	/*Binom 11000 1.1*/
	DECLARE
		flag, true_clicks, true_leads, false_day, fail_days
	INT DEFAULT 0;
	DECLARE
		var_date_day,var_date_month,var_date_year
	VARCHAR(32);
	DECLARE
		true_cost
	decimal(15,4) DEFAULT 0;
	DECLARE
		dop_info,where_days
	LONGTEXT DEFAULT '';
	DECLARE cursor_clicks CURSOR FOR 
		SELECT
			COUNT(*) AS clicks,
			SUM(IF(cvr_id=0,0,1)) AS leads,
			SUM(cpc) AS cost,
			FROM_UNIXTIME(click_time, '%d%m%Y') AS date_day,
			FROM_UNIXTIME(click_time, '%m%Y') AS date_month,
			FROM_UNIXTIME(click_time, '%Y') AS date_year
		FROM
			clicks
		WHERE 
			id!=0
		GROUP BY date_day;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	INSERT INTO proc_1(start_date, end_date) VALUES (0,0);
	INSERT INTO proc_2(start_date, end_date) VALUES (0,0);
	INSERT INTO proc_3(start_date, end_date) VALUES (0,0);
	INSERT INTO proc_4(start_date, end_date) VALUES (0,0);
	INSERT INTO proc_5(start_date, end_date) VALUES (0,0);
	OPEN cursor_clicks;
		REPEAT
			FETCH cursor_clicks INTO true_clicks, true_leads, true_cost, var_date_day,var_date_month,var_date_year;
			IF NOT flag THEN
				CALL check_all_step_2(true_clicks, true_leads, true_cost, var_date_day, false_day, dop_info);
				IF(false_day=1)THEN
					SET fail_days = fail_days + 1;
					CALL check_all_step_3(var_date_day,var_date_month,var_date_year);
					SET where_days = CONCAT(where_days,' OR date_name = "',var_date_day,'"');
				END IF;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_clicks;
	SET @create_ra_table="
		CREATE TABLE IF NOT EXISTS `proc_reload_all` (
			id int(11) NOT NULL AUTO_INCREMENT,
			`date_name` VARCHAR(16),
			`month` INT,
			`year` INT,
			`cnt` INT,
			`start_click` INT,
			`end_click` INT,
			`start_date` INT,
			`end_date` INT,
			`status` TINYINT,
			PRIMARY KEY (`id`)
		) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
	";
	PREPARE create_ra FROM @create_ra_table;
	EXECUTE create_ra;
	DEALLOCATE PREPARE create_ra;
	SET @sql_reload=CONCAT('
		INSERT INTO proc_reload_all(date_name, `month`, `year`, cnt, start_click, end_click, start_date, end_date, status) 
		SELECT
			date_name,
			`month`,
			`year`,
			cnt,
			start_click,
			end_click,
			start_date,
			end_date,
			status
		FROM (
			SELECT
				FROM_UNIXTIME(click_time, "%d%m%Y") AS date_name,
				FROM_UNIXTIME(click_time, "%m") AS `month`,
				FROM_UNIXTIME(click_time, "%Y") AS `year`,
				COUNT(*) AS cnt,
				MAX(id) AS start_click,
				MIN(id) AS end_click,
				0 AS start_date,
				0 AS end_date,
				0 AS status
			FROM
				clicks
			WHERE 
				id!=0
			GROUP BY date_name
		) AS temp WHERE date_name="1" ',where_days,';
	');
	PREPARE sql_reload FROM @sql_reload;
	EXECUTE sql_reload;
	DEALLOCATE PREPARE sql_reload;
	DELETE FROM proc_1 WHERE end_date=0 AND start_date=0;
	DELETE FROM proc_2 WHERE end_date=0 AND start_date=0;
	DELETE FROM proc_3 WHERE end_date=0 AND start_date=0;
	DELETE FROM proc_4 WHERE end_date=0 AND start_date=0;
	DELETE FROM proc_5 WHERE end_date=0 AND start_date=0;
	SELECT fail_days;
END;
<next>
CREATE PROCEDURE check_all_step_2(IN true_clicks INT, IN true_leads INT, IN true_cost decimal(15,4), IN var_date_day VARCHAR(32), OUT false_day TINYINT, OUT dop_info TEXT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE
		flag
	INT DEFAULT 0;
	DECLARE 
		var_report_name
	VARCHAR(64);
	DECLARE 
		all_sql,all_sql_temp
	LONGTEXT DEFAULT '';
	DECLARE cursor_reports CURSOR FOR 
		SELECT 
			table_name
		FROM 
			information_schema.tables
		WHERE 
			(table_name REGEXP CONCAT("^report_camp_[0-9]*_",var_date_day)
			OR
			table_name REGEXP CONCAT("^report_camp_ip_[0-9]*_",var_date_day))
			AND 
			TABLE_SCHEMA = '{data_base}';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	SET dop_info = '';
	SET false_day = 0;
	SET all_sql_temp = CONCAT(
					all_sql_temp,
					'(
						SELECT
							0 AS clicks,
							0 AS leads,
							0 AS spend,
							0 AS offer,
							0 AS offer_type,
							0 AS landing,
							0 AS an
					)'
				);
	OPEN cursor_reports;
		REPEAT
			FETCH cursor_reports INTO var_report_name;
			IF NOT flag THEN
				SET all_sql_temp = CONCAT(
					all_sql_temp,
					'UNION ALL (
						SELECT
							SUM(clicks) AS clicks,
							SUM(leads) AS leads,
							SUM(spend) AS spend,
							offer AS offer,
							offer_type AS offer_type,
							landing_page AS landing,
							an AS an
						FROM ',var_report_name,'
						GROUP BY offer, offer_type, an, landing
					)'
				);
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_reports;
	SET all_sql=CONCAT(
		'SELECT 
			SUM(clicks) AS clicks,
			SUM(leads) AS leads,
			SUM(spend) AS spend
		INTO
			@report_clicks,
			@report_leads,
			@report_cost
		FROM (',all_sql_temp,') AS reports'
	);
	SET @sql_report = all_sql;
	PREPARE sql_report FROM @sql_report;
	EXECUTE sql_report;
	DEALLOCATE PREPARE sql_report;
	IF(ABS((@report_clicks/2)-true_clicks)>3 OR ABS((@report_leads/2)-true_leads)>2 OR ABS((@report_cost/2)-true_cost)>0.1)THEN
		SET false_day = 1;
		SET dop_info=CONCAT(dop_info,'report:',ABS((@report_clicks/2)-true_clicks),'(',(@report_clicks/2),'-',true_clicks,'),',ABS((@report_leads/2)-true_leads),',',ABS((@report_cost/2)-true_cost),'; ');
	END IF;
	SELECT 
		SUM(clicks) AS clicks,
		SUM(leads) AS leads,
		SUM(spend) AS cost
	INTO
		@showcase_camp_clicks,
		@showcase_camp_leads,
		@showcase_camp_costs
	FROM
		showcase_campaigns
	WHERE 
		date_type = 1
		AND
		date_name = var_date_day
	GROUP BY date_name;
	IF(ABS(@showcase_camp_clicks-true_clicks)>3 OR ABS(@showcase_camp_leads-true_leads)>2 OR ABS(@showcase_camp_costs-true_cost)>0.1)THEN
		SET false_day = 1;
		SET dop_info=CONCAT(dop_info,'camp:',ABS(@showcase_camp_clicks-true_clicks),',',ABS(@showcase_camp_leads-true_leads),',',ABS(@showcase_camp_costs-true_cost),'; ');
	END IF;
	SELECT 
		SUM(clicks) AS clicks,
		SUM(leads) AS leads,
		SUM(spend) AS cost
	INTO
		@showcase_ts_clicks,
		@showcase_ts_leads,
		@showcase_ts_costs
	FROM
		showcase_sources
	WHERE 
		date_type = 1
		AND
		date_name = var_date_day
	GROUP BY date_name;
	IF(ABS(@showcase_ts_clicks-true_clicks)>3 OR ABS(@showcase_ts_leads-true_leads)>2 OR ABS(@showcase_ts_costs-true_cost)>0.1)THEN
		SET false_day = 1;
		SET dop_info=CONCAT(dop_info,'ts:',ABS(@showcase_ts_clicks-true_clicks),',',ABS(@showcase_ts_leads-true_leads),',',ABS(@showcase_ts_costs-true_cost),'; ');
	END IF;
	SELECT 
		SUM(clicks) AS clicks,
		SUM(leads) AS leads,
		SUM(spend) AS cost
	INTO
		@showcase_of_clicks,
		@showcase_of_leads,
		@showcase_of_costs
	FROM
		showcase_offers
	WHERE 
		date_type = 1
		AND
		date_name = var_date_day
	GROUP BY date_name;
	SET all_sql=CONCAT(
		'SELECT 
			SUM(clicks) AS clicks,
			SUM(leads) AS leads,
			SUM(spend) AS spend
		INTO
			@report_clicks,
			@report_leads,
			@report_cost
		FROM (',all_sql_temp,') AS reports
		WHERE offer!=0 AND offer_type=3'
	);
	SET @sql_report = all_sql;
	PREPARE sql_report FROM @sql_report;
	EXECUTE sql_report;
	DEALLOCATE PREPARE sql_report;
	IF(ABS(@showcase_of_clicks-(@report_clicks/2))>3 OR ABS(@showcase_of_leads-(@report_leads/2))>2 OR ABS(@showcase_of_costs-(@report_cost/2))>0.1)THEN
		SET false_day = 1;
		SET dop_info=CONCAT(dop_info,'of:',ABS(@showcase_of_clicks-@report_clicks),',',ABS(@showcase_of_leads-@report_leads),',',ABS(@showcase_of_costs-@report_cost),'; ');
	END IF;
	SELECT 
		SUM(clicks) AS clicks,
		SUM(leads) AS leads,
		SUM(spend) AS cost
	INTO
		@showcase_lp_clicks,
		@showcase_lp_leads,
		@showcase_lp_costs
	FROM
		showcase_landings
	WHERE 
		date_type = 1
		AND
		date_name = var_date_day
	GROUP BY date_name;
	SET all_sql=CONCAT(
		'SELECT 
			SUM(clicks) AS clicks,
			SUM(leads) AS leads,
			SUM(spend) AS spend
		INTO
			@report_clicks,
			@report_leads,
			@report_cost
		FROM (',all_sql_temp,') AS reports
		WHERE landing!=0'
	);
	SET @sql_report = all_sql;
	PREPARE sql_report FROM @sql_report;
	EXECUTE sql_report;
	DEALLOCATE PREPARE sql_report;
	IF(ABS(@showcase_lp_clicks-(@report_clicks/2))>3 OR ABS(@showcase_lp_leads-(@report_leads/2))>2 OR ABS(@showcase_lp_costs-(@report_cost/2))>0.1)THEN
		SET false_day = 1;
		SET dop_info=CONCAT(dop_info,'lp:',ABS(@showcase_lp_clicks-@report_clicks),',',ABS(@showcase_lp_leads-@report_leads),',',ABS(@showcase_lp_costs-@report_cost),'; ');
	END IF;
END;
<next>
CREATE PROCEDURE check_all_step_3(IN var_date_day VARCHAR(32),IN var_date_month VARCHAR(32),IN var_date_year VARCHAR(32)) BEGIN
	/*Binom 11000 1.1*/
	DECLARE
		flag, var_date_day_int, var_date_month_int, var_date_year_int
	INT DEFAULT 0;
	DECLARE 
		var_report_name
	VARCHAR(64);
	DECLARE cursor_reports CURSOR FOR 
		SELECT 
			table_name
		FROM 
			information_schema.tables
		WHERE 
			(table_name REGEXP CONCAT("^report_camp_[0-9]*_",var_date_day)
			OR
			table_name REGEXP CONCAT("^report_camp_ip_[0-9]*_",var_date_day)
			OR
			table_name REGEXP CONCAT("^report_camp_token_[0-9]*_",var_date_day))
			AND 
			TABLE_SCHEMA = '{data_base}';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_reports;
		REPEAT
			FETCH cursor_reports INTO var_report_name;
			IF NOT flag THEN
				SET @sql_drop=CONCAT('DROP TABLE IF EXISTS ',var_report_name);
				PREPARE sql_drop FROM @sql_drop;
				EXECUTE sql_drop;
				DEALLOCATE PREPARE sql_drop;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_reports;
	SET var_date_day_int = var_date_day;
	SET var_date_month_int = var_date_month;
	SET var_date_year_int = var_date_year;
	DELETE FROM showcase_campaigns WHERE date_name = var_date_day_int OR  date_name = var_date_month_int OR  date_name = var_date_year_int;
	DELETE FROM showcase_landings WHERE date_name = var_date_day_int OR  date_name = var_date_month_int OR  date_name = var_date_year_int;
	DELETE FROM showcase_networks WHERE date_name = var_date_day_int OR  date_name = var_date_month_int OR  date_name = var_date_year_int;
	DELETE FROM showcase_offers WHERE date_name = var_date_day_int OR  date_name = var_date_month_int OR  date_name = var_date_year_int;
	DELETE FROM showcase_sources WHERE date_name = var_date_day_int OR  date_name = var_date_month_int OR  date_name = var_date_year_int;
END;
<next>
CREATE PROCEDURE check_reboot () BEGIN
	/*Binom 12100 1.2.1*/
	SET GLOBAL sql_mode='';
	SET GLOBAL event_scheduler=ON;
	SET GLOBAL max_heap_table_size=2147483648;
	TRUNCATE {data_base}.temp_clicks;
	SET @last_temp_click_id = CONCAT('ALTER TABLE {data_base}.temp_clicks AUTO_INCREMENT=',(SELECT id+1 FROM {data_base}.clicks ORDER BY id DESC LIMIT 1));
	PREPARE load_last_id FROM @last_temp_click_id;
	EXECUTE load_last_id;
	DEALLOCATE PREPARE load_last_id;
END
<next>
CREATE PROCEDURE create_columns (IN var_table_name VARCHAR(128), IN var_column_name VARCHAR(128), IN sql_all TEXT) BEGIN
	IF((SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = var_table_name AND table_schema = '{data_base}' AND column_name = var_column_name)=0)THEN
		SET @all_sql = sql_all;
		PREPARE create_columns FROM @all_sql;
		EXECUTE create_columns;
		DEALLOCATE PREPARE create_columns;
	END IF;
END
<next>
CREATE PROCEDURE drop_columns (IN var_table_name VARCHAR(128), IN var_column_name VARCHAR(128), IN sql_all TEXT) BEGIN
	IF((SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = var_table_name AND table_schema = '{data_base}' AND column_name = var_column_name)!=0)THEN
		SET @all_sql = sql_all;
		PREPARE drop_columns FROM @all_sql;
		EXECUTE drop_columns;
		DEALLOCATE PREPARE drop_columns;
	END IF;
END
<next>
CREATE PROCEDURE drop_foreign_keys (IN var_table_name VARCHAR(128), IN var_column_name VARCHAR(128)) BEGIN
	/*Binom 16100*/
	DECLARE flag INT DEFAULT 0;
	DECLARE var_key_name VARCHAR(128);
	DECLARE cursor_1 CURSOR FOR
		SELECT constraint_name FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA ='{data_base}' AND TABLE_NAME = var_table_name AND CONSTRAINT_NAME <>'PRIMARY' AND REFERENCED_TABLE_NAME is not null AND COLUMN_NAME = var_column_name;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	SET flag=0;
	OPEN cursor_1;
		REPEAT
			FETCH cursor_1 INTO var_key_name;
			IF NOT flag THEN
				SET @sql_q=CONCAT('ALTER TABLE ',var_table_name,' DROP FOREIGN KEY ',var_key_name,';');
				PREPARE delete_key FROM @sql_q;
				EXECUTE delete_key;
				DEALLOCATE PREPARE delete_key;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_1;
END