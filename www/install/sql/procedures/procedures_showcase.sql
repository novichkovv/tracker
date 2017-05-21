CREATE PROCEDURE showcase_update_m (IN var_click_time INT, IN var_camp_id INT, IN var_path_id INT) BEGIN
	/*Binom 11000 1.1*/
	DECLARE flag,  var_id_t, var_an INT DEFAULT 0;
	DECLARE var_date_name1,var_date_name2,var_date_name3 INT;
	DECLARE cursor_m1 CURSOR FOR 
		SELECT id_t FROM path_com WHERE path_id = var_path_id AND (`type`=3);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1;
	OPEN cursor_m1;
		REPEAT
			FETCH cursor_m1 INTO var_id_t;
			IF NOT flag THEN
				
				SET var_an = (SELECT network FROM offers WHERE id = var_id_t);
				
				SET var_date_name1 = FROM_UNIXTIME(var_click_time, '%d%m%Y'); 
				
				IF((SELECT COUNT(el_id) FROM showcase_networks WHERE el_id = var_an AND date_name = var_date_name1 AND camp_id = var_camp_id)=0)THEN
					INSERT INTO showcase_networks (el_id, date_type, date_name, clicks, clicks_offer, leads, spend, pay, last_click, clicks_landing, bots, camp_id) VALUES (var_an,1,var_date_name1,0,0,0,0,0,var_click_time,0,0,var_camp_id);
				END IF;
				
				IF((SELECT COUNT(el_id) FROM showcase_offers WHERE el_id = var_id_t AND date_name = var_date_name1 AND camp_id = var_camp_id)=0)THEN
					INSERT INTO showcase_offers (el_id, date_type, date_name, clicks, clicks_offer, leads, spend, pay, last_click, clicks_landing, bots, camp_id) VALUES (var_id_t,1,var_date_name1,0,0,0,0,0,var_click_time,0,0,var_camp_id);
				END IF;
				SET var_date_name2 = FROM_UNIXTIME(var_click_time, '%m%Y'); 
				
				IF((SELECT COUNT(el_id) FROM showcase_networks WHERE el_id = var_an AND date_name = var_date_name2 AND camp_id = var_camp_id)=0)THEN
					INSERT INTO showcase_networks (el_id, date_type, date_name, clicks, clicks_offer, leads, spend, pay, last_click, clicks_landing, bots, camp_id) VALUES (var_an,2,var_date_name2,0,0,0,0,0,var_click_time,0,0,var_camp_id);
				END IF;
				
				IF((SELECT COUNT(el_id) FROM showcase_offers WHERE el_id = var_id_t AND date_name = var_date_name2 AND camp_id = var_camp_id)=0)THEN
					INSERT INTO showcase_offers (el_id, date_type, date_name, clicks, clicks_offer, leads, spend, pay, last_click, clicks_landing, bots, camp_id) VALUES (var_id_t,2,var_date_name2,0,0,0,0,0,var_click_time,0,0,var_camp_id);
				END IF;
				SET var_date_name3 = FROM_UNIXTIME(var_click_time, '%Y'); 
				
				IF((SELECT COUNT(el_id) FROM showcase_networks WHERE el_id = var_an AND date_name = var_date_name3 AND camp_id = var_camp_id)=0)THEN
					INSERT INTO showcase_networks (el_id, date_type, date_name, clicks, clicks_offer, leads, spend, pay, last_click, clicks_landing, bots, camp_id) VALUES (var_an,3,var_date_name3,0,0,0,0,0,var_click_time,0,0,var_camp_id);
				END IF;
				
				IF((SELECT COUNT(el_id) FROM showcase_offers WHERE el_id = var_id_t AND date_name = var_date_name3 AND camp_id = var_camp_id)=0)THEN
					INSERT INTO showcase_offers (el_id, date_type, date_name, clicks, clicks_offer, leads, spend, pay, last_click, clicks_landing, bots, camp_id) VALUES (var_id_t,3,var_date_name3,0,0,0,0,0,var_click_time,0,0,var_camp_id);
				END IF;
				
			END IF;
		UNTIL flag END REPEAT;
	CLOSE cursor_m1;
END
<next>
CREATE PROCEDURE showcase_update (IN var_click_time INT, IN var_camp_id INT, IN var_off_id INT, IN var_lp_id INT, IN var_ts_id INT, IN var_netw_id INT, IN var_cvr_id INT, IN var_offer_click TINYINT, IN var_pay DECIMAL(7,3), IN var_cpc DECIMAL(9,5), IN var_offer_type INT, IN var_bot INT) BEGIN
	DECLARE cvr_click, check_showcase, var_date_name, i, var_click_lp, i2, var_el_id, log_id, ok_save INT; 
	DECLARE table_name VARCHAR(64);
	DECLARE time_client INT;
	SET time_client = var_click_time;
	SET ok_save=1;
	IF(var_lp_id!=0) THEN 
		SET var_click_lp=1;
	ELSE 
		SET var_click_lp=0;
		SET var_offer_click=0;
	END IF;
	SET i = 1;
	WHILE i < 4 DO
		CASE i  
			WHEN 1 THEN  
				SET var_date_name = FROM_UNIXTIME(time_client, '%d%m%Y'); 
			WHEN 2 THEN  
				SET var_date_name = FROM_UNIXTIME(time_client, '%m%Y'); 
			ELSE  
				SET var_date_name = FROM_UNIXTIME(time_client, '%Y');  
		END CASE;  
		SET i2=1;
		WHILE i2 < 6 DO  
			CASE i2  
				WHEN 1 THEN  
					SET table_name = 'showcase_campaigns';
					SET var_el_id = var_camp_id;
					SET ok_save=1;
				WHEN 2 THEN  
					SET table_name = 'showcase_landings';
					SET var_el_id = var_lp_id;
					IF(var_lp_id=0)THEN
						SET ok_save=0;
					ELSE
						SET ok_save=1;
					END IF;
				WHEN 3 THEN  
					SET table_name = 'showcase_networks';
					SET var_el_id = var_netw_id;
					SET ok_save=1;
				WHEN 4 THEN  
					SET table_name = 'showcase_offers';
					SET var_el_id = var_off_id;
					IF(var_offer_type!=3)THEN
						SET ok_save=0;
					ELSE
						SET ok_save=1;
					END IF;
				ELSE  
					SET table_name = 'showcase_sources';
					SET var_el_id = var_ts_id; 
					SET ok_save=1;
			END CASE; 
			IF(var_cvr_id!=0)THEN 
				SET cvr_click=1; 
			ELSE 
				SET cvr_click=0;
			END IF;
			IF(ok_save=1)THEN
				SET @showcase_update_sql_2 = CONCAT('SELECT COUNT(el_id) INTO @showcase_update_chshtbl FROM ', table_name, ' WHERE el_id = ', var_el_id, ' AND date_type = ', i, ' AND date_name = ',var_date_name,' AND camp_id = ',var_camp_id);
				PREPARE check_showcase_table FROM @showcase_update_sql_2;
				EXECUTE check_showcase_table;
				DEALLOCATE PREPARE check_showcase_table;
				SET check_showcase = @showcase_update_chshtbl;
				IF(check_showcase != 0) THEN 
					SET @showcase_update_sql_3 = CONCAT('UPDATE ', table_name, ' SET clicks = clicks + 1, clicks_offer = clicks_offer + ', var_offer_click, ', bots = bots + ', var_bot, ', leads = leads + ', cvr_click, ', spend = spend + ', var_cpc, ', pay = pay + ', var_pay, ', last_click = ', var_click_time, ', clicks_landing = clicks_landing + ', var_click_lp, ' WHERE el_id = ', var_el_id, ' AND date_type = ', i, ' AND date_name = ',var_date_name,' AND camp_id = ',var_camp_id);
					PREPARE showcase_update_proc FROM @showcase_update_sql_3;
					EXECUTE showcase_update_proc;
					DEALLOCATE PREPARE showcase_update_proc;
				ELSE
					SET @showcase_update_sql_3 = CONCAT('INSERT INTO ', table_name, ' (el_id, date_type, date_name, clicks, clicks_offer, leads, spend, pay, last_click, clicks_landing, bots, camp_id) VALUES (', var_el_id, ',', i, ',', var_date_name, ',1,', var_offer_click, ',', cvr_click, ',', var_cpc, ',', var_pay, ',', var_click_time, ',', var_click_lp, ',', var_bot, ',', var_camp_id,')');
					PREPARE showcase_insert_proc FROM @showcase_update_sql_3;
					EXECUTE showcase_insert_proc;
					DEALLOCATE PREPARE showcase_insert_proc;
				END IF;
			END IF;
			SET i2 = i2 +1;
		END WHILE; 
		SET i = i +1;
	END WHILE;
END
<next>
CREATE PROCEDURE showcase_upload (IN filter_date INT, IN el_type INT, IN order_sql VARCHAR(128), IN filter_sql VARCHAR(512)) BEGIN
    /*Binom 16000*/
    DECLARE date_select, date_sql, date_sql_trends TEXT;
    DECLARE date_type, dop_int,time_client_2 INT;
    DECLARE time_client DATETIME;
    CALL {data_base}.time_convert(NOW(),time_client);
    SET time_client_2 = UNIX_TIMESTAMP(time_client);
    CASE filter_date
        WHEN 1 THEN  
            SET date_sql = CONCAT(' AND date_name  = DATE_FORMAT("',time_client,'", "%d%m%Y") ');
            SET date_type = 1;
        WHEN 2 THEN  
            SET date_sql = CONCAT(' AND date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 1 DAY), "%d%m%Y") ');
            SET date_type = 1;
        WHEN 3 THEN  
            SET date_sql = CONCAT(' AND (date_name = DATE_FORMAT("',time_client,'", "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 1 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 2 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 3 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 4 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 5 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 6 DAY), "%d%m%Y")) ');
			SET date_sql_trends=date_sql;
            SET date_type = 1;
        WHEN 11 THEN  
            SET dop_int=DATE_FORMAT(time_client, '%w')-1;
            SET date_sql = CONCAT(' AND (date_name = DATE_FORMAT("',time_client,'", "%d%m%Y")');
            WHILE dop_int>0 DO
                SET date_sql=CONCAT(date_sql,' OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL ',dop_int,' DAY), "%d%m%Y") ');
                SET dop_int=dop_int-1;
            END WHILE;
            SET date_sql=CONCAT(date_sql,')');
			SET date_sql_trends=date_sql;
            SET date_type = 1;
        WHEN 4 THEN  
            SET date_sql = CONCAT(' AND (date_name = DATE_FORMAT("',time_client,'", "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 1 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 2 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 3 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 4 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 5 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 6 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 7 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 8 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 9 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 10 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 11 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 12 DAY), "%d%m%Y") OR date_name = DATE_FORMAT(("',time_client,'" - INTERVAL 13 DAY), "%d%m%Y")) ');
			SET date_sql_trends=date_sql;
            SET date_type = 1;
        WHEN 5 THEN  
            SET date_sql = CONCAT(' AND date_name  = DATE_FORMAT("',time_client,'", "%m%Y")  ');
			SET date_sql_trends=CONCAT(' AND date_name LIKE CONCAT("%",DATE_FORMAT("',time_client,'", "%m%Y"),"%")  ');
            SET date_type = 2;
        WHEN 6 THEN  
            SET date_sql = CONCAT(' AND date_name  = DATE_FORMAT(("',time_client,'" - INTERVAL 1 MONTH), "%m%Y") ');
			SET date_sql_trends=CONCAT(' AND date_name LIKE CONCAT("%",DATE_FORMAT(("',time_client,'" - INTERVAL 1 MONTH), "%m%Y"),"%") ');
            SET date_type = 2;
        WHEN 7 THEN  
            SET date_sql = CONCAT(' AND date_name  = DATE_FORMAT("',time_client,'", "%Y") ');
			SET date_sql_trends=CONCAT(' AND date_name  LIKE CONCAT("%",DATE_FORMAT("',time_client,'", "%Y"),"%") ');
            SET date_type = 3;
        WHEN 8 THEN  
            SET date_sql = CONCAT(' AND date_name  = DATE_FORMAT(("',time_client,'" - INTERVAL 1 YEAR), "%Y") ');
			SET date_sql_trends=CONCAT(' AND date_name LIKE CONCAT("%",DATE_FORMAT(("',time_client,'" - INTERVAL 1 YEAR), "%Y"),"%") ');
            SET date_type = 3;
        ELSE
            SET date_sql = ' ';
			SET date_sql_trends=date_sql;
            SET date_type = 3;
    END CASE;
    CASE el_type
        WHEN 1 THEN  
            SET @showcase_upload_sql_1 = CONCAT('
                SELECT 
                    id,
                    status,
                    name,
                    date_cr,
                    keyword,
                    group_id,
                    group_name,
                    ts,
                    ts_id,
                    start_date,
                    IF(clicks IS NULL,0,clicks) AS clicks,
                    IF(bots IS NULL,0,bots) AS bots,
                    IF(rev - spend IS NULL,0,rev - spend) AS profit,
                    IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                    IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                    IF(leads IS NULL,0,leads) AS leads,
                    IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                    IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                    IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                    IF(rev IS NULL,0,rev) AS rev,
                    IF(spend IS NULL,0,spend) AS spend,
                    IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
                    IF(off_cl IS NULL,0,off_cl) AS off_cl,
                    note,
                    IF(current_cpc IS NULL,0,current_cpc) AS current_cpc,
                    auto_cpc
                FROM (
                    SELECT
                        camp.id AS id,
                        camp.name AS name,
                        camp.status AS status,
                        camp.date_cr AS date_cr,
                        camp.start_camp AS start_date,
                        camp.keyword AS keyword,
                        camp.sources_id AS ts_id,
                        camp.group_id AS group_id,
                        camp.cpc AS current_cpc,
                        camp.auto_cpc AS auto_cpc,
                        (SELECT name FROM {data_base}.groups WHERE id = camp.group_id) AS group_name,
                        (SELECT name FROM {data_base}.traffic_sources WHERE id = camp.sources_id) AS ts,
                        (SELECT COUNT(id) FROM {data_base}.camp_note WHERE camp_id = camp.id AND text!="") AS note,
                        SUM(showcase.clicks) AS clicks,
                        SUM(showcase.bots) AS bots,
                        SUM(showcase.clicks_offer) AS off_cl,
                        SUM(showcase.clicks_landing)     AS cnt_lp,
                        SUM(showcase.leads) AS leads,
                        SUM(showcase.pay) AS rev,
                        SUM(showcase.spend) AS spend
                    FROM 
                        {data_base}.campaigns AS camp
                        LEFT JOIN {data_base}.showcase_campaigns AS showcase ON showcase.el_id = camp.id AND showcase.date_type=',date_type,' ',date_sql,'
                    WHERE camp.id!=0
                        GROUP BY camp.id
                ) AS stat ', filter_sql, 'ORDER BY', order_sql);
        WHEN 2 THEN  
            SET @showcase_upload_sql_1 = CONCAT('
                SELECT 
                        id,
                        status,
                        name,
                        geo,
                        group_id,
                        group_name,
                        network,
                        network_id,
                        upsell,
                        cap,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(rev - spend IS NULL,0,rev - spend) AS profit,
                        IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                        IF(leads IS NULL,0,leads) AS leads,
                        IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                        IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(rev IS NULL,0,rev) AS rev,
                        IF(spend IS NULL,0,spend) AS spend,
                        IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl,
                        url,
                        auto_payout,
                        payout,
                        note
                    FROM (
                        SELECT
                            offr.id AS id,
                            offr.url AS url,
                            offr.auto_payout AS auto_payout,
                            offr.payout AS payout,
                            offr.name AS name,
                            offr.status AS status,
                            offr.geo AS geo,
                            offr.cap AS cap,
                            offr.upsell AS upsell,
                            offr.network AS network_id,
                            offr.group_of AS group_id,
                            (SELECT name FROM {data_base}.groups WHERE id = offr.group_of) AS group_name,
                            (SELECT name FROM {data_base}.networks WHERE id = offr.network) AS network,
                            SUM(showcase.clicks) AS clicks,
                            SUM(showcase.bots) AS bots,
                            SUM(showcase.clicks_offer) AS off_cl,
                            SUM(showcase.clicks_landing)     AS cnt_lp,
                            SUM(showcase.leads) AS leads,
                            SUM(showcase.pay) AS rev,
                            SUM(showcase.spend) AS spend,
                            (SELECT COUNT(id) FROM {data_base}.offer_note WHERE offer_id = offr.id AND text!="") AS note
                        FROM 
                            {data_base}.offers AS offr
                            LEFT JOIN {data_base}.showcase_offers AS showcase ON showcase.el_id = offr.id AND showcase.date_type=',date_type,' ',date_sql,'
                        WHERE offr.id!=0
                        GROUP BY offr.id 
                    ) AS stat
             ', filter_sql, 'ORDER BY', order_sql);
        WHEN 3 THEN  
            SET @showcase_upload_sql_1 = CONCAT('
                SELECT 
                    id,
                    status,
                    offers,
                    name,
                    lang,
                    group_id,
					type,
                    group_name,
                    url,
                    IF(clicks IS NULL,0,clicks) AS clicks,
                    IF(bots IS NULL,0,bots) AS bots,
                    IF(rev - spend IS NULL,0,rev - spend) AS profit,
                    IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                    IF(ROUND((off_cl / clicks),9)*100 IS NULL,0,ROUND((off_cl / clicks),9)*100) AS LP_CTR,
                    IF(leads IS NULL,0,leads) AS leads,
                    IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                    IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                    IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                    IF(rev IS NULL,0,rev) AS rev,
                    IF(spend IS NULL,0,spend) AS spend,
                    IF(off_cl IS NULL,0,off_cl) AS off_cl,
                    note
                FROM (
                    SELECT
                        lp.id AS id,
                        lp.url AS url,
                        lp.lang AS lang,
                        lp.name AS name,
                        lp.status AS status,
                        lp.offers AS offers,
                        lp.group_lp AS group_id,
                        lp.type AS type,
                        (SELECT name FROM {data_base}.groups WHERE id = lp.group_lp) AS group_name,
                        SUM(showcase.clicks) AS clicks,
                        SUM(showcase.bots) AS bots,
                        SUM(showcase.clicks_offer) AS off_cl,
                        SUM(showcase.leads) AS leads,
                        SUM(showcase.pay) AS rev,
                        SUM(showcase.spend) AS spend,
                        (SELECT COUNT(id) FROM {data_base}.landing_note WHERE landing_id = lp.id AND text!="") AS note
                    FROM 
                        {data_base}.landing_pages AS lp
                        LEFT JOIN {data_base}.showcase_landings AS showcase ON showcase.el_id = lp.id AND showcase.date_type=',date_type,' ',date_sql,'
                    WHERE lp.id!=0
                    GROUP BY lp.id ORDER BY clicks DESC
                ) AS stat 
             ', filter_sql, 'ORDER BY', order_sql);
        WHEN 4 THEN  
            SET @showcase_upload_sql_1 = CONCAT('
                SELECT 
                    id,
                    status,
                    name,
                    postback_url,
                    IF(offers IS NULL,0,offers) AS offers,
                    IF(clicks IS NULL,0,clicks) AS clicks,
                    IF(bots IS NULL,0,bots) AS bots,
                    IF(summ_cnv - Spend IS NULL,0,summ_cnv - Spend) AS profit,
                    IF(ROUND(((summ_cnv - Spend) / Spend),9) * 100 IS NULL,0,ROUND(((summ_cnv - Spend) / Spend),9) * 100) AS ROI,
                    IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                    IF(cnt_cnv IS NULL,0,cnt_cnv) AS cnt_cnv,
                    IF(ROUND((cnt_cnv / clicks),9)*100 IS NULL,0,ROUND((cnt_cnv / clicks),9)*100) AS CR,
                    IF(ROUND((summ_cnv / clicks),9) IS NULL,0,ROUND((summ_cnv / clicks),9)) AS EPC,
                    IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                    IF(summ_cnv IS NULL,0,summ_cnv) AS summ_cnv,
                    IF(spend IS NULL,0,spend) AS spend,
                    IF(cnt_lp IS NULL,0,cnt_lp) AS cnt_lp,
                    IF(off_cl IS NULL,0,off_cl) AS off_cl
                FROM (
                    SELECT
                        net.id AS id,
                        net.name AS name,
                        net.status AS status,
                        net.postback_url AS postback_url,
                        SUM(showcase.clicks) AS clicks,
                        SUM(showcase.bots) AS bots,
                        (SELECT COUNT(*) FROM {data_base}.offers WHERE status = 1 AND network = net.id) AS offers,
                        SUM(showcase.clicks_offer) AS off_cl,
                        SUM(showcase.clicks_landing)     AS cnt_lp,
                        SUM(showcase.leads) AS cnt_cnv,
                        SUM(showcase.pay) AS summ_cnv,
                        SUM(showcase.spend) AS spend
                    FROM 
                        {data_base}.networks AS net
                        LEFT JOIN {data_base}.showcase_networks AS showcase ON showcase.el_id = net.id  AND showcase.date_type=',date_type,' ',date_sql,'
                    WHERE net.id!=0
                    GROUP BY net.id
                ) AS stat 
             ', filter_sql, 'ORDER BY', order_sql);
        WHEN 5 THEN  
            SET @showcase_upload_sql_1 = CONCAT('
                SELECT 
                    id,
                    status,
                    name,
                    IF(clicks IS NULL,0,clicks) AS clicks,
                    IF(bots IS NULL,0,bots) AS bots,
                    IF(summ_cnv - Spend IS NULL,0,summ_cnv - Spend) AS profit,
                    IF(ROUND(((summ_cnv - Spend) / Spend),9) * 100 IS NULL,0,ROUND(((summ_cnv - Spend) / Spend),9) * 100) AS ROI,
                    IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                    IF(cnt_cnv IS NULL,0,cnt_cnv) AS cnt_cnv,
                    IF(ROUND((cnt_cnv / clicks),9)*100 IS NULL,0,ROUND((cnt_cnv / clicks),9)*100) AS CR,
                    IF(ROUND((summ_cnv / clicks),9) IS NULL,0,ROUND((summ_cnv / clicks),9)) AS EPC,
                    IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                    IF(summ_cnv IS NULL,0,summ_cnv) AS summ_cnv,
                    IF(Spend IS NULL,0,Spend) AS Spend,
                    IF(cnt_lp IS NULL,0,cnt_lp) AS cnt_lp,
                    tokens,
                    IF(camps IS NULL,0,camps) AS camps,
                    IF(off_cl IS NULL,0,off_cl) AS off_cl,
                    e_name,
                    e_value,
                    postback_url
                FROM (
                    SELECT
                        ts.id AS id,
                        ts.postback_url AS postback_url,
                        ts.name AS name,
                        ts.e_name AS e_name,
                        ts.e_value AS e_value,
                        ts.tokens AS tokens,
                        ts.status AS status,
                        (SELECT COUNT(*) FROM {data_base}.campaigns WHERE sources_id = ts.id AND status = 1) AS camps,
                        SUM(showcase.clicks) AS clicks,
                        SUM(showcase.bots) AS bots,
                        SUM(showcase.clicks_offer) AS off_cl,
                        SUM(showcase.clicks_landing) AS cnt_lp,
                        SUM(showcase.leads) AS cnt_cnv,
                        SUM(showcase.pay) AS summ_cnv,
                        SUM(showcase.spend) AS Spend
                    FROM 
                        {data_base}.traffic_sources AS ts
                        LEFT JOIN {data_base}.showcase_sources AS showcase ON showcase.el_id = ts.id AND showcase.date_type=',date_type,' ',date_sql,'
                    WHERE ts.id!=0
                    GROUP BY ts.id
                ) AS stat
             ', filter_sql, 'ORDER BY', order_sql);
		ELSE
			/*условие для трендов*/
			IF el_type>60 THEN
				CASE el_type
					/*по дням*/
					WHEN 61 THEN  
						SET date_select='
							unix_timestamp(CONCAT(
								RIGHT(showcase.date_name,4),"-",
								LEFT(RIGHT(showcase.date_name,6),2),"-",								IF(LENGTH(showcase.date_name)=8,LEFT(showcase.date_name,2),CONCAT("0",LEFT(showcase.date_name,1)))
							))';
					/*по месяцам*/
					WHEN 62 THEN  
						SET date_select='
							unix_timestamp(CONCAT(
								RIGHT(showcase.date_name,4),"-",
								LEFT(RIGHT(showcase.date_name,6),2),"-01"
								))';
					/*по неделям*/
					WHEN 63 THEN  
						SET date_select='
							unix_timestamp(CONCAT(
								RIGHT(showcase.date_name,4),"-",
								LEFT(RIGHT(showcase.date_name,6),2),"-",								IF(LENGTH(showcase.date_name)=8,LEFT(showcase.date_name,2),CONCAT("0",LEFT(showcase.date_name,1)))
							))-(WEEKDAY(CONCAT(
								RIGHT(showcase.date_name,4),"-",
								LEFT(RIGHT(showcase.date_name,6),2),"-",								IF(LENGTH(showcase.date_name)=8,LEFT(showcase.date_name,2),CONCAT("0",LEFT(showcase.date_name,1)))
							))*3600*24)';
				END CASE;  
				SET @showcase_upload_sql_1 = CONCAT('
					SELECT 
						id, 
						date_name AS name,
						status,
						IF(clicks IS NULL,0,clicks) AS clicks,
						IF(bots IS NULL,0,bots) AS bots,
						IF(rev - spend IS NULL,0,rev - spend) AS profit,
						IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
						IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
						IF(leads IS NULL,0,leads) AS leads,
						IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
						IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
						IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
						IF(rev IS NULL,0,rev) AS rev,
						IF(spend IS NULL,0,spend) AS spend,
						IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
						IF(off_cl IS NULL,0,off_cl) AS off_cl
					FROM (
						SELECT
							date_name AS id,
							',date_select,' AS date_name,
							camp.status AS status,
							SUM(showcase.clicks) AS clicks,
							SUM(showcase.bots) AS bots,
							SUM(showcase.clicks_offer) AS off_cl,
							SUM(showcase.clicks_landing) AS cnt_lp,
							SUM(showcase.leads) AS leads,
							SUM(showcase.pay) AS rev,
							SUM(showcase.spend) AS spend
						FROM 
							{data_base}.campaigns AS camp
							LEFT JOIN {data_base}.showcase_campaigns AS showcase ON showcase.el_id = camp.id AND showcase.date_type=1 ',date_sql_trends,'
						',filter_sql,'
							GROUP BY ',date_select,'
					) AS stat ORDER BY ', order_sql);
			END IF;
    END CASE;  
    PREPARE upload_1 FROM @showcase_upload_sql_1;
    EXECUTE upload_1;
    DEALLOCATE PREPARE upload_1;
END
<next>
CREATE PROCEDURE showcase_upload_custom (IN start_date VARCHAR(64), IN end_date VARCHAR(64), IN el_type INT, IN order_sql VARCHAR(128), IN filter_sql VARCHAR(512), IN custom_type INT) BEGIN
    /*Binom 16000*/
    DECLARE date_sql,day_val,date_select LONGTEXT;
    DECLARE dop_int, time_client_2, days_interval, end_date_u, start_date_u, i_day INT;
    DECLARE time_client DATETIME;
    CALL {data_base}.time_convert(NOW(),time_client);
    SET time_client_2 = UNIX_TIMESTAMP(time_client);
    SET start_date_u=UNIX_TIMESTAMP(start_date);
    SET end_date_u=UNIX_TIMESTAMP(end_date);
    IF(custom_type=1)THEN
        SET date_sql=' AND (';
        SET days_interval = CEILING(((end_date_u) - (start_date_u))/(60*60*24));
        SET i_day=0;
        WHILE i_day < (days_interval+1) DO
            SET day_val = DATE_FORMAT((FROM_UNIXTIME(start_date_u, '%Y-%m-%d') + INTERVAL i_day DAY), '%d%m%Y');
            SET date_sql = CONCAT(date_sql,' date_name = ',day_val);
            IF(i_day<days_interval)THEN
                SET date_sql = CONCAT(date_sql,' OR ');
            END IF;
            SET i_day=i_day+1;
        END WHILE;
        SET date_sql=CONCAT(date_sql,') ');
        CASE el_type
            WHEN 1 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
                        status,
                        name,
                        date_cr,
                        keyword,
                        group_id,
                        group_name,
                        ts,
                        ts_id,
                        start_date,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(rev - spend IS NULL,0,rev - spend) AS profit,
                        IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                        IF(leads IS NULL,0,leads) AS leads,
                        IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                        IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(rev IS NULL,0,rev) AS rev,
                        IF(spend IS NULL,0,spend) AS spend,
                        IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl,
                        note,
                        current_cpc,
                        auto_cpc
                    FROM (
                        SELECT
                            camp.id AS id,
                            camp.name AS name,
                            camp.status AS status,
                            camp.date_cr AS date_cr,
                            camp.start_camp AS start_date,
                            camp.keyword AS keyword,
                            camp.sources_id AS ts_id,
                            camp.group_id AS group_id,
                            camp.cpc AS current_cpc,
                            camp.auto_cpc AS auto_cpc,
                            (SELECT name FROM {data_base}.groups WHERE id = camp.group_id) AS group_name,
                            (SELECT name FROM {data_base}.traffic_sources WHERE id = camp.sources_id) AS ts,
                            (SELECT COUNT(id) FROM {data_base}.camp_note WHERE camp_id = camp.id AND text!="") AS note,
                            SUM(showcase.clicks) AS clicks,
                            SUM(showcase.bots) AS bots,
                            SUM(showcase.clicks_offer) AS off_cl,
                            SUM(showcase.clicks_landing)     AS cnt_lp,
                            SUM(showcase.leads) AS leads,
                            SUM(showcase.pay) AS rev,
                            SUM(showcase.spend) AS spend
                        FROM 
                            {data_base}.campaigns AS camp
                            LEFT JOIN {data_base}.showcase_campaigns AS showcase ON showcase.el_id = camp.id AND showcase.date_type = 1 ',date_sql,'
                        WHERE camp.id!=0
                            GROUP BY camp.id
                    ) AS stat ', filter_sql, 'ORDER BY', order_sql);
            WHEN 2 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                            id,
                            status,
                            name,
                            geo,
                            group_id,
                            group_name,
                            network,
                            network_id,
                            upsell,
                            cap,
                            IF(clicks IS NULL,0,clicks) AS clicks,
                            IF(bots IS NULL,0,bots) AS bots,
                            IF(rev - spend IS NULL,0,rev - spend) AS profit,
                            IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                            IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                            IF(leads IS NULL,0,leads) AS leads,
                            IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                            IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                            IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                            IF(rev IS NULL,0,rev) AS rev,
                            IF(spend IS NULL,0,spend) AS spend,
                            IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
                            IF(off_cl IS NULL,0,off_cl) AS off_cl,
                            url,
                            auto_payout,
                            payout,
                            note
                        FROM (
                            SELECT
                                offr.id AS id,
                                offr.url AS url,
                                offr.auto_payout AS auto_payout,
                                offr.payout AS payout,
                                offr.name AS name,
                                offr.status AS status,
                                offr.geo AS geo,
                                offr.cap AS cap,
                                offr.upsell AS upsell,
                                offr.network AS network_id,
                                offr.group_of AS group_id,
                                (SELECT name FROM {data_base}.groups WHERE id = offr.group_of) AS group_name,
                                (SELECT name FROM {data_base}.networks WHERE id = offr.network) AS network,
                                SUM(showcase.clicks) AS clicks,
                                SUM(showcase.bots) AS bots,
                                SUM(showcase.clicks_offer) AS off_cl,
                                SUM(showcase.clicks_landing)     AS cnt_lp,
                                SUM(showcase.leads) AS leads,
                                SUM(showcase.pay) AS rev,
                                SUM(showcase.spend) AS spend,
                                (SELECT COUNT(id) FROM {data_base}.offer_note WHERE offer_id = offr.id AND text!="") AS note
                            FROM 
                                {data_base}.offers AS offr
                                LEFT JOIN {data_base}.showcase_offers AS showcase ON showcase.el_id = offr.id AND showcase.date_type = 1 ',date_sql,'
                            WHERE offr.id!=0
                            GROUP BY offr.id 
                        ) AS stat
                 ', filter_sql, 'ORDER BY', order_sql);
            WHEN 3 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
						type,
                        status,
                        offers,
                        name,
                        lang,
                        group_id,
                        group_name,
                        url,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(rev - spend IS NULL,0,rev - spend) AS profit,
                        IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / clicks),9)*100 IS NULL,0,ROUND((off_cl / clicks),9)*100) AS LP_CTR,
                        IF(leads IS NULL,0,leads) AS leads,
                        IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                        IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(rev IS NULL,0,rev) AS rev,
                        IF(spend IS NULL,0,spend) AS spend,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl,
                        note
                    FROM (
                        SELECT
                            lp.id AS id,
                            lp.type AS type,
                            lp.url AS url,
                            lp.lang AS lang,
                            lp.name AS name,
                            lp.status AS status,
                            lp.offers AS offers,
                            lp.group_lp AS group_id,
                            (SELECT name FROM {data_base}.groups WHERE id = lp.group_lp) AS group_name,
                            SUM(showcase.clicks) AS clicks,
                            SUM(showcase.bots) AS bots,
                            SUM(showcase.clicks_offer) AS off_cl,
                            SUM(showcase.leads) AS leads,
                            SUM(showcase.pay) AS rev,
                            SUM(showcase.spend) AS spend,
                            (SELECT COUNT(id) FROM {data_base}.landing_note WHERE landing_id = lp.id AND text!="") AS note
                        FROM 
                            {data_base}.landing_pages AS lp
                            LEFT JOIN {data_base}.showcase_landings AS showcase ON showcase.el_id = lp.id AND showcase.date_type = 1 ',date_sql,'
                        WHERE lp.id!=0
                        GROUP BY lp.id ORDER BY clicks DESC
                    ) AS stat 
                 ', filter_sql, 'ORDER BY', order_sql);
            WHEN 4 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
                        status,
                        name,
                        postback_url,
                        IF(offers IS NULL,0,offers) AS offers,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(summ_cnv - Spend IS NULL,0,summ_cnv - Spend) AS profit,
                        IF(ROUND(((summ_cnv - Spend) / Spend),9) * 100 IS NULL,0,ROUND(((summ_cnv - Spend) / Spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                        IF(cnt_cnv IS NULL,0,cnt_cnv) AS cnt_cnv,
                        IF(ROUND((cnt_cnv / clicks),9)*100 IS NULL,0,ROUND((cnt_cnv / clicks),9)*100) AS CR,
                        IF(ROUND((summ_cnv / clicks),9) IS NULL,0,ROUND((summ_cnv / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(summ_cnv IS NULL,0,summ_cnv) AS summ_cnv,
                        IF(spend IS NULL,0,spend) AS spend,
                        IF(cnt_lp IS NULL,0,cnt_lp) AS cnt_lp,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl
                    FROM (
                        SELECT
                            net.id AS id,
                            net.name AS name,
                            net.status AS status,
                            net.postback_url AS postback_url,
                            SUM(showcase.clicks) AS clicks,
                            SUM(showcase.bots) AS bots,
                            (SELECT COUNT(*) FROM {data_base}.offers WHERE status = 1 AND network = net.id) AS offers,
                            SUM(showcase.clicks_offer) AS off_cl,
                            SUM(showcase.clicks_landing)     AS cnt_lp,
                            SUM(showcase.leads) AS cnt_cnv,
                            SUM(showcase.pay) AS summ_cnv,
                            SUM(showcase.spend) AS spend
                        FROM 
                            {data_base}.networks AS net
                            LEFT JOIN {data_base}.showcase_networks AS showcase ON showcase.el_id = net.id  AND showcase.date_type = 1 ',date_sql,'
                        WHERE net.id!=0
                        GROUP BY net.id
                    ) AS stat 
                 ', filter_sql, 'ORDER BY', order_sql);
            WHEN 5 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
                        status,
                        name,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(summ_cnv - Spend IS NULL,0,summ_cnv - Spend) AS profit,
                        IF(ROUND(((summ_cnv - Spend) / Spend),9) * 100 IS NULL,0,ROUND(((summ_cnv - Spend) / Spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                        IF(cnt_cnv IS NULL,0,cnt_cnv) AS cnt_cnv,
                        IF(ROUND((cnt_cnv / clicks),9)*100 IS NULL,0,ROUND((cnt_cnv / clicks),9)*100) AS CR,
                        IF(ROUND((summ_cnv / clicks),9) IS NULL,0,ROUND((summ_cnv / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(summ_cnv IS NULL,0,summ_cnv) AS summ_cnv,
                        IF(Spend IS NULL,0,Spend) AS Spend,
                        IF(cnt_lp IS NULL,0,cnt_lp) AS cnt_lp,
                        tokens,
                        IF(camps IS NULL,0,camps) AS camps,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl,
                        e_name,
                        e_value,
                        postback_url
                    FROM (
                        SELECT
                            ts.id AS id,
                            ts.postback_url AS postback_url,
                            ts.name AS name,
                            ts.e_name AS e_name,
                            ts.e_value AS e_value,
                            ts.tokens AS tokens,
                            ts.status AS status,
                            (SELECT COUNT(*) FROM {data_base}.campaigns WHERE sources_id = ts.id AND status = 1) AS camps,
                            SUM(showcase.clicks) AS clicks,
                            SUM(showcase.bots) AS bots,
                            SUM(showcase.clicks_offer) AS off_cl,
                            SUM(showcase.clicks_landing) AS cnt_lp,
                            SUM(showcase.leads) AS cnt_cnv,
                            SUM(showcase.pay) AS summ_cnv,
                            SUM(showcase.spend) AS Spend
                        FROM 
                            {data_base}.traffic_sources AS ts
                            LEFT JOIN {data_base}.showcase_sources AS showcase ON showcase.el_id = ts.id AND showcase.date_type = 1 ',date_sql,'
                        WHERE ts.id!=0
                        GROUP BY ts.id
                    ) AS stat
                 ', filter_sql, 'ORDER BY', order_sql);
			ELSE
			/*условие для трендов*/
				IF el_type>60 THEN
					CASE el_type
						/*по дням*/
						WHEN 61 THEN  
							SET date_select='
								unix_timestamp(CONCAT(
									RIGHT(showcase.date_name,4),"-",
									LEFT(RIGHT(showcase.date_name,6),2),"-",								IF(LENGTH(showcase.date_name)=8,LEFT(showcase.date_name,2),CONCAT("0",LEFT(showcase.date_name,1)))
								))';
						/*по месяцам*/
						WHEN 62 THEN  
							SET date_select='
								unix_timestamp(CONCAT(
									RIGHT(showcase.date_name,4),"-",
									LEFT(RIGHT(showcase.date_name,6),2),"-01"
									))';
						/*по неделям*/
						WHEN 63 THEN  
							SET date_select='
								unix_timestamp(CONCAT(
									RIGHT(showcase.date_name,4),"-",
									LEFT(RIGHT(showcase.date_name,6),2),"-",								IF(LENGTH(showcase.date_name)=8,LEFT(showcase.date_name,2),CONCAT("0",LEFT(showcase.date_name,1)))
								))-(WEEKDAY(CONCAT(
									RIGHT(showcase.date_name,4),"-",
									LEFT(RIGHT(showcase.date_name,6),2),"-",								IF(LENGTH(showcase.date_name)=8,LEFT(showcase.date_name,2),CONCAT("0",LEFT(showcase.date_name,1)))
								))*3600*24)';
					END CASE;  
					SET @showcase_upload_sql_1 = CONCAT('
						SELECT 
							id, 
							date_name AS name,
							status,
							IF(clicks IS NULL,0,clicks) AS clicks,
							IF(bots IS NULL,0,bots) AS bots,
							IF(rev - spend IS NULL,0,rev - spend) AS profit,
							IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
							IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
							IF(leads IS NULL,0,leads) AS leads,
							IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
							IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
							IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
							IF(rev IS NULL,0,rev) AS rev,
							IF(spend IS NULL,0,spend) AS spend,
							IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
							IF(off_cl IS NULL,0,off_cl) AS off_cl
						FROM (
							SELECT
								date_name AS id,
								',date_select,' AS date_name,
								camp.status AS status,
								SUM(showcase.clicks) AS clicks,
								SUM(showcase.bots) AS bots,
								SUM(showcase.clicks_offer) AS off_cl,
								SUM(showcase.clicks_landing) AS cnt_lp,
								SUM(showcase.leads) AS leads,
								SUM(showcase.pay) AS rev,
								SUM(showcase.spend) AS spend
							FROM 
								{data_base}.campaigns AS camp
								LEFT JOIN {data_base}.showcase_campaigns AS showcase ON showcase.el_id = camp.id AND showcase.date_type=1 ',date_sql,'
							',filter_sql,'
								GROUP BY ',date_select,'
						) AS stat ORDER BY ', order_sql);
				END IF;
        END CASE;   
    ELSE
        CASE el_type
            WHEN 1 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
                        status,
                        name,
                        date_cr,
                        keyword,
                        group_id,
                        group_name,
                        ts,
                        ts_id,
                        start_date,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(rev - spend IS NULL,0,rev - spend) AS profit,
                        IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                        IF(leads IS NULL,0,leads) AS leads,
                        IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                        IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(rev IS NULL,0,rev) AS rev,
                        IF(spend IS NULL,0,spend) AS spend,
                        IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl,
                        note,
                        current_cpc,
                        auto_cpc
                    FROM (
                        SELECT
                            camp.id AS id,
                            camp.name AS name,
                            camp.status AS status,
                            camp.date_cr AS date_cr,
                            camp.start_camp AS start_date,
                            camp.keyword AS keyword,
                            camp.sources_id AS ts_id,
                            camp.group_id AS group_id,
                            camp.cpc AS current_cpc,
                            camp.auto_cpc AS auto_cpc,
                            (SELECT name FROM {data_base}.groups WHERE id = camp.group_id) AS group_name,
                            (SELECT name FROM {data_base}.traffic_sources WHERE id = camp.sources_id) AS ts,
                            (SELECT COUNT(id) FROM {data_base}.camp_note WHERE camp_id = camp.id AND text!="") AS note,
                            COUNT(showcase.id) AS clicks,
                            SUM(showcase.is_bot) AS bots,
                            SUM(IF(showcase.landing_page>0,showcase.offer_click,0)) AS off_cl,
                            SUM(IF(showcase.landing_page>0,1,0)) AS cnt_lp,
                            SUM(IF(showcase.cvr_id>1,1,0)) AS leads,
                            SUM(showcase.pay) AS rev,
                            SUM(showcase.cpc) AS spend
                        FROM 
                            {data_base}.campaigns AS camp
                            LEFT JOIN {data_base}.clicks AS showcase ON showcase.camp_id = camp.id AND showcase.click_time > ',start_date_u,' AND showcase.click_time < ',end_date_u,'
                        WHERE camp.id!=0
                            GROUP BY camp.id
                    ) AS stat ', filter_sql, 'ORDER BY', order_sql);
            WHEN 2 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                            id,
                            status,
                            name,
                            geo,
                            group_id,
                            group_name,
                            network,
                            network_id,
                            upsell,
                            cap,
                            IF(clicks IS NULL,0,clicks) AS clicks,
                            IF(bots IS NULL,0,bots) AS bots,
                            IF(rev - spend IS NULL,0,rev - spend) AS profit,
                            IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                            IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                            IF(leads IS NULL,0,leads) AS leads,
                            IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                            IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                            IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                            IF(rev IS NULL,0,rev) AS rev,
                            IF(spend IS NULL,0,spend) AS spend,
                            IF(cnt_lp IS NULL,0,cnt_lp) AS lp_cl,
                            IF(off_cl IS NULL,0,off_cl) AS off_cl,
                            url,
                            auto_payout,
                            payout,
                            note
                        FROM (
                            SELECT
                                offr.id AS id,
                                offr.url AS url,
                                offr.auto_payout AS auto_payout,
                                offr.payout AS payout,
                                offr.name AS name,
                                offr.status AS status,
                                offr.geo AS geo,
                                offr.cap AS cap,
                                offr.upsell AS upsell,
                                offr.network AS network_id,
                                offr.group_of AS group_id,
                                (SELECT name FROM {data_base}.groups WHERE id = offr.group_of) AS group_name,
                                (SELECT name FROM {data_base}.networks WHERE id = offr.network) AS network,
                                COUNT(showcase.id) AS clicks,
                                SUM(showcase.is_bot) AS bots,
                                SUM(IF(showcase.landing_page>0,showcase.offer_click,0)) AS off_cl,
                                SUM(IF(showcase.landing_page>0,1,0)) AS cnt_lp,
                                SUM(IF(showcase.cvr_id>1,1,0)) AS leads,
                                SUM(showcase.pay) AS rev,
                                SUM(showcase.cpc) AS spend,
                                (SELECT COUNT(id) FROM {data_base}.offer_note WHERE offer_id = offr.id AND text!="") AS note
                            FROM 
                                {data_base}.offers AS offr
                                LEFT JOIN {data_base}.clicks AS showcase ON showcase.offer = offr.id AND showcase.click_time > ',start_date_u,' AND showcase.click_time < ',end_date_u,'
                            WHERE offr.id!=0
                            GROUP BY offr.id 
                        ) AS stat
                 ', filter_sql, 'ORDER BY', order_sql);
            WHEN 3 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
						type,
                        status,
                        offers,
                        name,
                        lang,
                        group_id,
                        group_name,
                        url,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(rev - spend IS NULL,0,rev - spend) AS profit,
                        IF(ROUND(((rev - spend) / spend),9) * 100 IS NULL,0,ROUND(((rev - spend) / spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / clicks),9)*100 IS NULL,0,ROUND((off_cl / clicks),9)*100) AS LP_CTR,
                        IF(leads IS NULL,0,leads) AS leads,
                        IF(ROUND((leads  / clicks),9)*100 IS NULL,0,ROUND((leads  / clicks),9)*100) AS CR,
                        IF(ROUND((rev / clicks),9) IS NULL,0,ROUND((rev / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(rev IS NULL,0,rev) AS rev,
                        IF(spend IS NULL,0,spend) AS spend,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl,
                        note
                    FROM (
                        SELECT
                            lp.id AS id,
                            lp.type AS type,
                            lp.url AS url,
                            lp.lang AS lang,
                            lp.name AS name,
                            lp.status AS status,
                            lp.offers AS offers,
                            lp.group_lp AS group_id,
                            (SELECT name FROM {data_base}.groups WHERE id = lp.group_lp) AS group_name,
                            COUNT(showcase.id) AS clicks,
                            SUM(showcase.is_bot) AS bots,
                            SUM(IF(showcase.landing_page>0,showcase.offer_click,0)) AS off_cl,
                            SUM(IF(showcase.cvr_id>1,1,0)) AS leads,
                            SUM(showcase.pay) AS rev,
                            SUM(showcase.cpc) AS spend,
                            (SELECT COUNT(id) FROM {data_base}.landing_note WHERE landing_id = lp.id AND text!="") AS note
                        FROM 
                            {data_base}.landing_pages AS lp
                            LEFT JOIN {data_base}.clicks AS showcase ON showcase.landing_page = lp.id AND showcase.click_time > ',start_date_u,' AND showcase.click_time < ',end_date_u,'
                        WHERE lp.id!=0
                        GROUP BY lp.id ORDER BY clicks DESC
                    ) AS stat 
                 ', filter_sql, 'ORDER BY', order_sql);
            WHEN 4 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
                        status,
                        name,
                        postback_url,
                        IF(offers IS NULL,0,offers) AS offers,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(summ_cnv - Spend IS NULL,0,summ_cnv - Spend) AS profit,
                        IF(ROUND(((summ_cnv - Spend) / Spend),9) * 100 IS NULL,0,ROUND(((summ_cnv - Spend) / Spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                        IF(cnt_cnv IS NULL,0,cnt_cnv) AS cnt_cnv,
                        IF(ROUND((cnt_cnv / clicks),9)*100 IS NULL,0,ROUND((cnt_cnv / clicks),9)*100) AS CR,
                        IF(ROUND((summ_cnv / clicks),9) IS NULL,0,ROUND((summ_cnv / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(summ_cnv IS NULL,0,summ_cnv) AS summ_cnv,
                        IF(spend IS NULL,0,spend) AS spend,
                        IF(cnt_lp IS NULL,0,cnt_lp) AS cnt_lp,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl
                    FROM (
                        SELECT
                            net.id AS id,
                            net.name AS name,
                            net.status AS status,
                            net.postback_url AS postback_url,
                            (SELECT COUNT(*) FROM {data_base}.offers WHERE status = 1 AND network = net.id) AS offers,
                            COUNT(showcase.id) AS clicks,
                            SUM(showcase.is_bot) AS bots,
                            SUM(IF(showcase.landing_page>0,showcase.offer_click,0)) AS off_cl,
                            SUM(IF(showcase.landing_page>0,1,0)) AS cnt_lp,
                            SUM(IF(showcase.cvr_id>1,1,0)) AS cnt_cnv,
                            SUM(showcase.pay) AS summ_cnv,
                            SUM(showcase.cpc) AS spend
                        FROM 
                            {data_base}.networks AS net
                            LEFT JOIN {data_base}.clicks AS showcase ON showcase.an = net.id AND showcase.click_time > ',start_date_u,' AND showcase.click_time < ',end_date_u,'
                        WHERE net.id!=0
                        GROUP BY net.id
                    ) AS stat 
                 ', filter_sql, 'ORDER BY', order_sql);
            WHEN 5 THEN  
                SET @showcase_upload_sql_1 = CONCAT('
                    SELECT 
                        id,
                        status,
                        name,
                        IF(clicks IS NULL,0,clicks) AS clicks,
                        IF(bots IS NULL,0,bots) AS bots,
                        IF(summ_cnv - Spend IS NULL,0,summ_cnv - Spend) AS profit,
                        IF(ROUND(((summ_cnv - Spend) / Spend),9) * 100 IS NULL,0,ROUND(((summ_cnv - Spend) / Spend),9) * 100) AS ROI,
                        IF(ROUND((off_cl / cnt_lp),9)*100 IS NULL,0,ROUND((off_cl / cnt_lp),9)*100) AS LP_CTR,
                        IF(cnt_cnv IS NULL,0,cnt_cnv) AS cnt_cnv,
                        IF(ROUND((cnt_cnv / clicks),9)*100 IS NULL,0,ROUND((cnt_cnv / clicks),9)*100) AS CR,
                        IF(ROUND((summ_cnv / clicks),9) IS NULL,0,ROUND((summ_cnv / clicks),9)) AS EPC,
                        IF(ROUND((spend / clicks),9) IS NULL,0,ROUND((spend / clicks),9)) AS CPC,
                        IF(summ_cnv IS NULL,0,summ_cnv) AS summ_cnv,
                        IF(Spend IS NULL,0,Spend) AS Spend,
                        IF(cnt_lp IS NULL,0,cnt_lp) AS cnt_lp,
                        tokens,
                        IF(camps IS NULL,0,camps) AS camps,
                        IF(off_cl IS NULL,0,off_cl) AS off_cl,
                        e_name,
                        e_value,
                        postback_url
                    FROM (
                        SELECT
                            ts.id AS id,
                            ts.postback_url AS postback_url,
                            ts.name AS name,
                            ts.e_name AS e_name,
                            ts.e_value AS e_value,
                            ts.tokens AS tokens,
                            ts.status AS status,
                            (SELECT COUNT(*) FROM {data_base}.campaigns WHERE sources_id = ts.id AND status = 1) AS camps,
                            COUNT(showcase.id) AS clicks,
                            SUM(showcase.is_bot) AS bots,
                            SUM(IF(showcase.landing_page>0,showcase.offer_click,0)) AS off_cl,
                            SUM(IF(showcase.landing_page>0,1,0)) AS cnt_lp,
                            SUM(IF(showcase.cvr_id>1,1,0)) AS cnt_cnv,
                            SUM(showcase.pay) AS summ_cnv,
                            SUM(showcase.cpc) AS Spend
                        FROM 
                            {data_base}.traffic_sources AS ts
                            LEFT JOIN {data_base}.clicks AS showcase ON showcase.ts_id = ts.id AND showcase.click_time > ',start_date_u,' AND showcase.click_time < ',end_date_u,'
                        WHERE ts.id!=0
                        GROUP BY ts.id
                    ) AS stat
                 ', filter_sql, 'ORDER BY', order_sql);
        END CASE;   
    END IF;
    PREPARE upload_1 FROM @showcase_upload_sql_1;
    EXECUTE upload_1;
    DEALLOCATE PREPARE upload_1;
END
<next>