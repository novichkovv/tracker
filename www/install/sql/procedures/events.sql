CREATE EVENT clear_event ON SCHEDULE EVERY 30 SECOND DO CALL {data_base}.clear_all(); 
<next>
CREATE EVENT reload_all_event ON SCHEDULE EVERY 15 SECOND DO BEGIN
	/*Binom 11000 1.1*/
	DECLARE check_proc,check_proc2,check_table,var_month_s,var_month_e,var_year INT;
	DECLARE var_date_name VARCHAR(16);
	SET check_table = (SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'proc_reload_all' AND table_schema = '{data_base}');
	IF(check_table!=0)THEN
		SET check_proc = (SELECT COUNT(*) FROM proc_reload_all WHERE start_date>0 AND end_date=0);
		SET check_proc2 = (SELECT COUNT(*) FROM proc_reload_all WHERE status=0);
		IF(check_proc=0 AND check_proc2>0)THEN
			SET var_date_name = (SELECT date_name FROM proc_reload_all WHERE start_date=0 AND end_date=0 ORDER BY id ASC LIMIT 1);
			UPDATE proc_reload_all SET start_date=UNIX_TIMESTAMP(NOW()),status=1 WHERE `date_name` = var_date_name;
			CALL reload_all_process(var_date_name,0,0,0);
		ELSE
			SET check_proc = (SELECT COUNT(*) FROM proc_reload_all WHERE status = 3 OR status=0 OR status=1);
			IF(check_proc=0)THEN
				SET check_proc = (SELECT COUNT(*) FROM proc_reload_all WHERE status != 4);
				IF(check_proc!=0)THEN
					SELECT MIN(`month`), MAX(`month`), `year` INTO var_month_s, var_month_e, var_year FROM proc_reload_all WHERE status = 2 GROUP BY `year` LIMIT 1;
					CALL reload_all_process(0, var_month_s, var_month_e, var_year);
				ELSE
					DROP TABLE proc_reload_all;
				END IF;
			END IF;
		END IF;
	END IF;
END;
<next>
CREATE EVENT report_event ON SCHEDULE EVERY 5 SECOND DO BEGIN
	/*Binom 11000 1.1*/
	DECLARE check_log, start_click_id, last_click_id INT;
	SET check_log = (SELECT COUNT(*) FROM {data_base}.proc_2 WHERE end_date = 0);
	IF(check_log=0)THEN
		SET start_click_id = (SELECT dop_info FROM {data_base}.proc_2 ORDER BY id DESC LIMIT 1);
		IF(start_click_id IS NULL)THEN
			SET start_click_id = 0;
		END IF;
		SET last_click_id = (SELECT id FROM {data_base}.clicks ORDER BY id DESC LIMIT 1);
		IF(last_click_id IS NOT NULL AND last_click_id!=0 AND start_click_id!=last_click_id)THEN
			IF((last_click_id - start_click_id)>500)THEN
				SET last_click_id = start_click_id+500;
			END IF;
			CALL {data_base}.report_load(start_click_id, last_click_id, 0); 
		END IF;
	END IF;
END
<next>
CREATE EVENT report_month ON SCHEDULE EVERY 1 MONTH STARTS '2016-01-01 00:15:00' DO BEGIN
	CALL report_month_all(MONTH(NOW() - INTERVAL 1 MONTH),MONTH(NOW()),YEAR(NOW()));
END
<next>
CREATE EVENT report_update_temp_event ON SCHEDULE EVERY 7 SECOND DO BEGIN
	DECLARE check_log, start_click_id, last_click_id INT;
	SET check_log = (SELECT COUNT(*) FROM {data_base}.proc_3 WHERE end_date = 0);
	IF(check_log=0)THEN
		SET start_click_id = (SELECT id FROM {data_base}.temp_table ORDER BY id ASC LIMIT 1);
		SET last_click_id = (SELECT id FROM {data_base}.temp_table ORDER BY id DESC LIMIT 1);
		IF(last_click_id IS NOT NULL)THEN
			IF((last_click_id-start_click_id)>1200)THEN
				SET last_click_id = start_click_id +1200;
			END IF;
			CALL {data_base}.report_update_temp(start_click_id, last_click_id); 
		END IF;
	END IF;
END;
<next>
CREATE EVENT report_update_temp_event_2 ON SCHEDULE EVERY 4 SECOND DO BEGIN
	DECLARE check_log, start_click_id, last_click_id INT;
	SET check_log = (SELECT COUNT(*) FROM {data_base}.proc_4 WHERE end_date = 0);
	IF(check_log=0)THEN
		SET start_click_id = (SELECT id FROM {data_base}.temp_table_2 ORDER BY id ASC LIMIT 1);
		SET last_click_id = (SELECT id FROM {data_base}.temp_table_2 ORDER BY id DESC LIMIT 1);
		IF(last_click_id IS NOT NULL)THEN
			IF((last_click_id-start_click_id)>30)THEN
				SET last_click_id = start_click_id +30;
			END IF;
			CALL {data_base}.report_update_temp_2(start_click_id, last_click_id); 
		END IF;
	END IF;
END;
<next>
CREATE EVENT save_clicks_event ON SCHEDULE EVERY 2 SECOND DO BEGIN
	DECLARE check_log INT;
	SET check_log = (SELECT COUNT(*) FROM {data_base}.proc_1 WHERE end_date=0);
	IF(check_log=0)THEN
		CALL {data_base}.check_clicks(); 
	END IF;
END;
<next>
CREATE EVENT check_reboot_event ON SCHEDULE EVERY 15 SECOND DO BEGIN
	/*Binom 11000 1.1*/
	DECLARE check_1, check_2, check_3, err_log INT DEFAULT 0;
	SET check_1=(SELECT auto_increment FROM information_schema.tables WHERE table_name = 'temp_clicks' AND table_schema = '{data_base}');
	SET check_2=(SELECT auto_increment FROM information_schema.tables WHERE table_name = 'clicks' AND table_schema = '{data_base}');
	SET check_3=(SELECT COUNT(*) FROM temp_clicks AS tc WHERE (SELECT COUNT(*) FROM clicks AS c WHERE c.id = tc.id)>0);
	IF((check_2-check_1)>200)THEN
		CALL check_reboot();
	ELSE
		IF((SELECT @@global.max_heap_table_size)<1073741824)THEN
			CALL check_reboot();
		END IF;
	END IF;
END
<next>
CREATE EVENT clear_temp_report ON SCHEDULE EVERY 30 MINUTE DO BEGIN
	/*Binom 15000 1.5*/
	DECLARE var_table_name VARCHAR(128);
	DECLARE sql_drop_temp_report TEXT;
	DECLARE flag TINYINT(1) DEFAULT 0;
	DECLARE cursor_1 CURSOR FOR 
		SELECT table_name FROM information_schema.tables WHERE table_schema = '{data_base}' AND table_name LIKE '%temp_report%' AND (UNIX_TIMESTAMP() - UNIX_TIMESTAMP(update_time) > 3600);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_1;
		REPEAT
			FETCH cursor_1 INTO var_table_name;
			IF NOT flag THEN
				SET @sql_drop_temp_report=CONCAT('DROP TABLE IF EXISTS {data_base}.',var_table_name);
				PREPARE sql_drop_temp_report FROM @sql_drop_temp_report;
				EXECUTE sql_drop_temp_report;
				DEALLOCATE PREPARE sql_drop_temp_report;
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_1;
END