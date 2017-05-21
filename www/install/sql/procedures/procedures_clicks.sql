CREATE PROCEDURE check_clicks ()  BEGIN 
	DECLARE count_id, last_click INT;
	DECLARE time_client DATETIME;
	CALL {data_base}.time_convert(NOW(),time_client);
	SET count_id = (SELECT COUNT(id) AS count_id FROM {data_base}.temp_clicks);
	IF count_id > 0 THEN
		IF count_id = 100 OR count_id > 100 THEN
			CALL {data_base}.save_clicks(count_id);
		ELSE
			SET last_click = (SELECT click_time FROM {data_base}.temp_clicks ORDER BY click_time ASC LIMIT 0, 1);
			IF (UNIX_TIMESTAMP(time_client) - last_click)>15 THEN
				CALL {data_base}.save_clicks(count_id);
			END IF;
		END IF;
	END IF;
END 
<next>
CREATE PROCEDURE save_clicks(IN var_count_clicks INT)  BEGIN
	DECLARE last_id, log_id  INT;
	DECLARE time_client DATETIME;
	CALL {data_base}.time_convert(NOW(),time_client);
	INSERT INTO {data_base}.proc_1 (start_date, end_date, dop_info) VALUES (UNIX_TIMESTAMP(time_client),0,var_count_clicks);
	SET log_id=(SELECT LAST_INSERT_ID());
	SET last_id=(SELECT id FROM {data_base}.temp_clicks ORDER BY id DESC LIMIT 1);
	INSERT INTO {data_base}.clicks (id, click_time, camp_id, offer, path_id, landing_page, cvr_id, ts_id, rule_id, offer_click, offer_type, an, pay, cpc, geo, ua, ip, publisher, referer_domain, bidhash, token, is_bot) SELECT id, click_time, camp_id, offer, path_id, landing_page, cvr_id, ts_id, rule_id, offer_click, offer_type, an, pay, cpc, geo, ua, ip, publisher, referer_domain, bidhash, token, is_bot FROM {data_base}.temp_clicks WHERE id <= last_id;
	DELETE FROM {data_base}.temp_clicks WHERE id <= last_id;
	UPDATE {data_base}.proc_1 SET end_date=UNIX_TIMESTAMP(time_client) WHERE id = log_id;
END