INSERT INTO `ts_templates` (`id`, `name`, `postback_url`, `tokens`, `e_name`, `e_value`, `c_name`, `c_value`, `tokens_list`, `description`, `int1`, `int2`, `ads_format`, `traffic_type`, `self_serve`, `geo`) VALUES
(2, 'AirPush', 'http://api.airpush.com/track/?guid={externalid}', 1, 'guid', '%guid%', '', '', '[{"name":"App ID","field":"appid","val":"%dapp%"},{"name":"Phone model","field":"device","val":"%device%"},{"name":"Brand","field":"brand","val":"%manufacturer%"},{"name":"Campaign ID","field":"campaignid","val":"%campaignid%"},{"name":"Creative ID","field":"creativeid","val":"%creativeid%"},{"name":"IP","field":"ip","val":"%ip%"},{"name":"Pub ID","field":"pubid","val":"%pubid%"},{"name":"Carrier","field":"carrier","val":"%carrier%"},{"name":"City","field":"city","val":"%city%"},{"name":"State","field":"state","val":"%state%"}]', '', 0, 0, 'Push, dialog ads, appwall, display', 'Mobile', 1, 'Global'),
(3, 'Avazu Mobile DSP', 'http://mdsp.avazutracking.net/tracking/s2s.php?subid={externalid}', 1, 'subid', '{subid}', '', '', '[{"name":"Publisher Name","field":"pub_name","val":"{publisher_name}"},{"name":"Creative ID","field":"creative_id","val":"{creative_id}"},{"name":"Source Name","field":"source","val":"{source_name}"},{"name":"OS Version","field":"os_version","val":"{os_version}"},{"name":"Exchange","field":"exchange","val":"{exchange}"},{"name":"Device Model","field":"device_model","val":"{device_model}"},{"name":"Device Vendor","field":"device_vendor","val":"{device_vendor}"},{"name":"Carrier","field":"carrier","val":"{carrier}"},{"name":"Campaign ID","field":"campaign_id","val":"{campaign_id}"},{"name":"Category","field":"category","val":"{category}"}]', '', 0, 0, 'Display', 'Mobile', 1, 'Global'),
(4, 'Buzzcity', 'http://api.buzzcity.net/vconvert.php?partnerid=REPLACE&clickcode={externalid}', 1, 'cid', '{clickcode}', '', '', '[{"name":"Pub ID","field":"pubid","val":"{pubid}"}]', '', 0, 0, 'Display', 'Mobile', 1, 'Global'),
(5, 'DNTX/Tonic', '', 1, '', '', 'cpc', '[cpc]', '[{"name":"Source ID","field":"sourceid","val":"[sourceid]"},{"name":"Keywords","field":"match","val":"[match]"},{"name":"Carrier","field":"carrier","val":"[carrier]"},{"name":"Mobile Platform","field":"mob_pf","val":"[mob_pf]"},{"name":"Country","field":"country","val":"[country]"}]', '', 0, 0, 'Redirect, pop, display', 'Mobile', 1, 'Global'),
(6, 'EroAdvertising', 'https://tracker.ero-advertising.com/tracking/conv.php?cid={externalid}', 1, 'cid', '[tracking]', '', '', '[{"name":"Domain ID","field":"did","val":"[domainid]"},{"name":"Country","field":"country","val":"[country]"},{"name":"Campaign ID","field":"campid","val":"[campaignid]"},{"name":"Adspace ID","field":"spaceid","val":"[spaceid]"},{"name":"Advertisement ID","field":"adid","val":"[adid]"}]', '', 0, 0, 'Display', 'Mobile, desktop', 1, 'Global'),
(7, 'ExoClick', 'http://main.exoclick.com/tag.php?goal=REPLACE&tag={externalid}', 1, 'tag', '{conversions_tracking}', 'cost', '{cost}', '[{"name":"Domain","field":"source","val":"{src_hostname}"},{"name":"Variation ID","field":"varid","val":"{variation_id}"},{"name":"Campaign ID","field":"campid","val":"{campaign_id}"},{"name":"Site ID","field":"siteid","val":"{site_id}"},{"name":"Zone ID","field":"zoneid","val":"{zone_id}"},{"name":"Category ID","field":"catid","val":"{category_id}"},{"name":"Country","field":"country","val":"{country}"},{"name":"Format","field":"format","val":"{format}"}]', '', 0, 0, 'Display, pop, redirect, notifications', 'Mobile, desktop', 1, 'Global'),
(8, 'Go2mobi', 'http://pb.g2trk.com/pb/?api_key=REPLACE&clickid={externalid}&payout={payout}', 1, 'cid', '{clickid}', '', '', '[{"name":"Exchange placement name","field":"pln","val":"{pln}"},{"name":"Exchange placement ID","field":"plid","val":"{plid}"},{"name":"Creative ID","field":"crid","val":"{crid}"},{"name":"Carrier","field":"isp","val":"{isp}"},{"name":"User indentifier","field":"uid","val":"{uid_deviceid}"},{"name":"Country","field":"country","val":"{country}"},{"name":"Brand","field":"brand","val":"{device_vendor}"},{"name":"Model","field":"model","val":"{device_model}"},{"name":"Operating system","field":"os","val":"{os}"}]', '', 0, 0, 'Display, rich media, in-video', 'Mobile', 1, 'Global'),
(9, 'LeadBolt', 'http://ad.leadbolt.net/conv/?track_id={var1}&clk_id={externalid}', 1, 'CLK_ID', '[CLK_ID]', '', '', '[{"name":"Site ID","field":"SITE_ID","val":"[SITE_ID]"},{"name":"Device ID","field":"DEVICE_AD_ID","val":"{DEVICE_AD_ID}"},{"name":"Category ID","field":"CAT_ID","val":"[CAT_ID]"},{"name":"Track ID","field":"TRACK_ID","val":"[TRACK_ID]"},{"name":"Ad Group ID","field":"AD_GROUP_ID","val":"[AD_GROUP_ID]"},{"name":"Platform","field":"PLATFORM","val":"[PLATFORM]"},{"name":"Ad ID","field":"AD_ID","val":"[AD_ID]"}]', '', 0, 0, 'Display, rich media, in-video', 'Mobile', 1, 'Global'),
(10, 'MobFox', 'http://my.mobfox.com/conversion.track.php?account_id=REPLACE&click_id={externalid}', 1, 'cid', 'MFOXCLICKID', '', '', '[{"name":"Publisher ID","field":"pubid","val":"MFOXPUBID"},{"name":"Device ID","field":"deviceid","val":"MFOXUDID"},{"name":"iOS IDFA","field":"ios","val":"MFOXIFA"},{"name":"Campaign ID","field":"campid","val":"MFOXCAID"},{"name":"Ad Group ID","field":"adgroup","val":"MFOXAGID"},{"name":"Ad ID","field":"adid","val":"MFOXADID"}]', '', 0, 0, 'Display', 'Mobile', 1, 'Global'),
(11, 'PlugRush', '', 1, '', '', 'cpv', '{$cpv}', '[{"name":"Domain","field":"domain","val":"{$domain}"},{"name":"OS","field":"os","val":"{$mobile_os}"},{"name":"Pubid","field":"pubid","val":"{$id}"},{"name":"Category","field":"category","val":"{$category}"},{"name":"Traffic Source","field":"source","val":"{$trafficsource}"},{"name":"Orientation","field":"orientation","val":"{$orientation}"},{"name":"Campaign ID","field":"campaign_id","val":"{$campaign_id}"},{"name":"Banner ID","field":"banner_id","val":"{$banner_id}"},{"name":"Ad ID","field":"ad_id","val":"{$ad_id}"}, {"name":"Browser","field":"browser","val":"{$browser}"}]', '', 0, 0, 'Redirect, pop, display	', 'Mobile	', 1, 'Global'),
(12, 'PopAds', '', 1, '', '', 'bid', '[BID]', '[{"name":"Website ID","field":"websiteid","val":"[WEBSITEID]"},{"name":"Quality score","field":"quality","val":"[QUALITY]"},{"name":"Category ID","field":"categoryid","val":"[CATEGORYID]"},{"name":"Country","field":"country","val":"[COUNTRY]"},{"name":"Form Factor Name","field":"formfactorname","val":"[FORMFACTORNAME]"},{"name":"Campaign ID","field":"campaignid","val":"[CAMPAIGNID]"},{"name":"Campaign name","field":"campaignname","val":"[CAMPAIGNNAME]"},{"name":"Screen Resolution","field":"screenresolution","val":"[SCREENRESOLUTION]"},{"name":"Impression ID","field":"impressionid","val":"[IMPRESSIONID]"}]', '', 0, 0, 'Pop', 'Mobile', 1, 'Global'),
(13, 'PropellerAds', 'http://ad.propellerads.com/conversion.php?aid=REPLACE&pid=REPLACE&tid=REPLACE&visitor_id={externalid}', 1, 'visitor_id', '${SUBID}', '', '', '[{"name":"Zone ID","field":"zoneid","val":"{zoneid}"},{"name":"Campaign ID","field":"campaignid","val":"{campaignid}"}]', '', 0, 0, 'Redirect, pop, display', 'Mobile', 1, 'Global'),
(14, 'SelfAdvertiser', 'http://clkpback3.com/adServe/ssapixel?subid={externalid}&price={payout}', 1, 'subid', '@@CLICK-ID@@', '', '', '[{"name":"Site","field":"site","val":"@@SOURCE@@"},{"name":"Keyword","field":"keyword","val":"@@CAMPAIGN-KEYWORD@@"}]', '', 0, 0, 'Redirect, pop, search', 'Mobile, desktop', 1, 'Global'),
(15, 'SiteScout', 'http://clickserv2.sitescout.com/conv/a227ad4326795?pb={externalid}', 1, 'cid', '{postbackId}', '', '', '[{"name":"Site ID","field":"site_id","val":"{siteId}"},{"name":"Ad ID","field":"ad_id","val":"{adId}"},{"name":"Campaign ID","field":"campaign_id","val":"{campaignId}"},{"name":"Exchange ID","field":"network_id","val":"{networkId}"},{"name":"Domain","field":"domain","val":"{domain}"},{"name":"Page URL","field":"pageurl","val":"{pageURL}"},{"name":"Carrier","field":"carrier","val":"{carrier}"},{"name":"Device","field":"device","val":"{device}"},{"name":"App ID","field":"appid","val":"{appId}"},{"name":"App Type","field":"apptype","val":"{appType}"}]', '', 0, 0, 'Display, in-video, retargeting', 'Mobile, desktop', 1, 'Global'),
(16, 'StartApp', 'http://www.startappinstalls.com/trackinstall/voluum?d={externalid}', 1, 'cid', 'startapp_click_id_placeholder', '', '', '[{"name":"App ID","field":"appid","val":"startapp_app_id"},{"name":"Creative ID","field":"creativeid","val":"creative_id"},{"name":"Campaign ID","field":"campid","val":"campaign_id"},{"name":"ISP/Carrier","field":"isp","val":"startapp_isp_name"},{"name":"Device Model","field":"model","val":"startapp_device_model"},{"name":"Device Brand","field":"brand","val":"startapp_device_brand"},{"name":"OS Version","field":"os","val":"startapp_os_version"},{"name":"Connection Type","field":"connection","val":"startapp_connection_type"},{"name":"Publisher Category","field":"category","val":"startapp_publisher_category"},{"name":"Campaign Payment Model","field":"bid","val":"bid_type"}]', '', 0, 0, 'Display', 'Mobile', 1, 'Global'),
(17, 'TapIt', 'http://a.tapit.com/adconvert.php?xid={externalid}', 1, 'cid', '[transaction_id]', '', '', '[{"name":"Site","field":"site","val":"[site]"},{"name":"Category","field":"channel","val":"[channel]"},{"name":"Carrier","field":"carrier","val":"[carrier]"},{"name":"OS","field":"os","val":"[platform]"},{"name":"OS Version","field":"osv","val":"[version]"},{"name":"Brand","field":"brand","val":"[phone_brand]"},{"name":"Model","field":"model","val":"[phone_model]"},{"name":"Creative Name","field":"creative","val":"[creative]"},{"name":"Ad Size","field":"adsize","val":"[adsize]"},{"name":"Environment","field":"environment","val":"[environment]"}]', '', 0, 0, 'Display, notifications, rich media', 'Mobile', 1, 'Global'),
(18, 'TrafficForce', 'http://delivery.trafficforce.com/conv.php?click_id={externalid}', 1, 'cid', '{CLICK_ID}', '', '', '[{"name":"Site Name","field":"site_name","val":"{site_name}"},{"name":"Channel ID","field":"channel_id","val":"{channel_id}"},{"name":"Campaign ID","field":"campaign_id","val":"{campaign_id}"},{"name":"Group ID","field":"group_id","val":"{group_id}"},{"name":"Ad ID","field":"ad_id","val":"{ad_id}"},{"name":"Keywords","field":"keywords","val":"{keywords}"},{"name":"Country","field":"country","val":"{v_country}"},{"name":"Language","field":"lang","val":"{v_language}"},{"name":"Site ID","field":"site_id","val":"{site_id}"},{"name":"Channel Name","field":"channel_name","val":"{channel_name}"}]', '', 0, 0, 'Display', 'Mobile', 1, 'Global'),
(19, 'TrafficStars', 'http://rotator.trafficstars.com/api/v1/cpa/action/{externalid}', 1, 'click_id', '{click_id}', 'price', '{price}', '[{"name":"Site ID","field":"site_id","val":"{site_id}"},{"name":"Creative ID","field":"cr_id","val":"{creative_id}"},{"name":"Categories","field":"cat","val":"{categories}"},{"name":"Keywords","field":"keyword","val":"{keyword}"},{"name":"Referrer","field":"referrer","val":"{referrer}"},{"name":"Campaign ID","field":"campid","val":"{campaign_id}"},{"name":"Ad Format","field":"format","val":"{format}"},{"name":"ip","field":"ip","val":"{ip}"},{"name":"Geo","field":"geo","val":"{geo}"},{"name":"Pricing Model","field":"price_model","val":"{price_model}"}]', '', 0, 0, 'Display', 'Mobile, desktop', 1, 'Global'),
(20, 'Trafficvance', 'https://tracking.trafficvance.com/?id=REPLACE&amp;value={payout}&token={externalid}', 1, 'cid', '{token}', '', '', '[{"name":"Keyword","field":"keyword","val":"{keyword}"}]', '', 0, 0, 'Display', 'Mobile', 1, 'Global'),
(21, 'AdCash', 'http://www.adcash.com/script/register_event.php?key=UNIQUEID&idform=UNIQUEID&campagne=UNIQUEID&cid={externalid}', 1, '', '', 'cid', '[clickid]', '[{"name":"Site ID","field":"zone","val":"[zone]"},{"name":"Time in seconds","field":"time","val":"[time]"},{"name":"Language","field":"lang","val":"[lang]"},{"name":"Country ID","field":"country","val":"[country]"},{"name":"Unique ID","field":"campaign","val":"[campaign]"}]', '', 0, 0, 'Pop, display, in-app', 'Mobile, desktop', 1, 'Global'),
(22, 'Content.ad', '', 1, '', '', '', '', '[{"name":"Domain ID","field":"did","val":"[did]"},{"name":"Campaign ID","field":"cid","val":"[cid]"},{"name":"ID of the ad creative the visitor clicked on","field":"adid","val":"[adid]"}]', '', 0, 0, 'Native ads', 'Mobile, desktop', 1, 'Global'),
(23, 'Google AdWords ', '', 1, '', '', '', '', '[{"name":"Website placement for display network","field":"placement","val":"{placement}"},{"name":"Ad position","field":"adposition","val":"{adposition}"},{"name":"Campaign ID","field":"campid","val":"{campid}"},{"name":"Device type","field":"device","val":"{device}"},{"name":"Device model (mobile or tablet)","field":"devicemodel","val":"{devicemodel}"},{"name":"Ad creative","field":"creative","val":"{creative}"},{"name":"Unique ID of the ad","field":"adid","val":"{adid}"},{"name":"Category placement for display network","field":"target","val":"{target}"},{"name":"Category placement for display network","field":"keyword","val":"{keyword}"},{"name":"Bidded keyword match type","field":"matchtype","val":"{matchtype}"}]', '', 0, 0, 'Search, display', 'Mobile, desktop	', 1, 'Global'),
(24, 'InMobi', '', 1, '', '', '', '', '[{"name":"Campaign ID","field":"campid","val":"{campid}"},{"name":"Creative ad ID","field":"creaid","val":"{creaid}"}]', '', 0, 0, 'Display', 'Mobile', 1, 'Global'),
(25, 'MobiCow', 'http://cdn.mobicow.com/tracking/postback/UNIQUEID/{externalid}', 1, 'MOBI_TRACKING_ID', '{MOBI_TRACKING_ID}', '', '', '[{"name":"Site ID","field":"MOBI_SITE","val":"{MOBI_SITE}"},{"name":"Device model of visitor","field":"MOBI_DEVICE","val":"{MOBI_DEVICE}"},{"name":"Mobile carrier of visitor","field":"MOBI_CARRIER","val":"{MOBI_CARRIER}"},{"name":"Device Vendor of visitor","field":"MOBI_VENDOR","val":"{MOBI_VENDOR}"}]', '', 0, 0, 'Pop', 'Mobile', 1, 'Global'),
(26, 'MGID', '', 1, '', '', '', '', '[{"name":"Publisher ID","field":"widget_id","val":"{widget_id}"},{"name":"Ad ID of the click","field":"teaser_id","val":"{teaser_id}"}]', '', 0, 0, 'Native ads', 'Mobile, desktop', 1, 'Global'),
(27, 'PopCash', '', 1, '', '', '', '', '[{"name":"Site Id","field":"siteid","val":"%siteid%"},{"name":"OS","field":"operatingsystem","val":"%operatingsystem%"},{"name":"Category","field":"cat","val":"%category%"}]', '', 0, 0, 'Pop', 'Mobile, desktop', 1, 'Global'),
(28, 'RevContent', '', 1, '', '', '', '', '[{"name":"Targets","field":"adv_targets","val":"{adv_targets}"},{"name":"Boost campaign ID","field":"boost_id","val":"{boost_id}"},{"name":"Content ID","field":"content_id","val":"{content_id}"},{"name":"Widget ID","field":"widget_id","val":"{widget_id}"}]', '', 0, 0, 'Native ads', 'Mobile, desktop', 1, 'Global'),
(29, 'Redirect', 'http://tracted.net/cp/?c={externalid}', 1, '', '', '', '', '[{"name":"Partner site ID","field":"SOURCE","val":"#SOURCE#"},{"name":"Partner sub site IDu2019s","field":"SUBSOURCE","val":"#SUBSOURCE#"}]', '', 0, 0, 'Redirect', 'Mobile, desktop', 1, 'Global'),
(30, 'Taboola', '', 1, '', '', '', '', '[{"name":"Website","field":"site","val":"{site}"},{"name":"Campaign ID from advertisers side","field":"campaign","val":"{campaign}"},{"name":"Thumbnail ID of the creative","field":"thumbnail","val":"{thumbnail}"},{"name":"Title of the ad","field":"title","val":"{title}"}]', '', 0, 0, 'Native ads', 'Mobile, desktop', 1, 'Global'),
(31, 'ZeroPark', 'http://postback.zeroredirect1.com/zppostback/XXXXXX-XXXX-XXXX-XXXX-XXXXXX?cid={externalid}&payout={payout}', 1, 'cid', '{cid}', '', '', '[{"name":"Target ID","field":"target","val":"{target}"},{"name":"Campaign ID","field":"campaign_id","val":"{campaign_id}"},{"name":"Country","field":"geo","val":"{geo}"},{"name":"Bidded keyword","field":"keyword","val":"{keyword}"},{"name":"Source","field":"source","val":"{source}"},{"name":"Sends the bidded keyword of the visit (keyword campaigns only)","field":"match","val":"{match}"},{"name":"Campaign name","field":"campaign_name","val":"{campaign_name}"},{"name":"Carrier","field":"carrier","val":"{carrier}"},{"name":"Traffic type (popup or doamin)","field":"traffic_type","val":"{traffic_type}"},{"name":"Visitor type (adult or non-adult)","field":"visitor_type","val":"{visitor_type}"}]', '', 0, 0, 'Redirect, pop	', 'Mobile, desktop', 1, 'Global'),
(32, 'Trafficjunky', '', 1, '', '', '', '', '[{"name":"Ad id","field":"adid","val":"{AdID}"},{"name":"Banner id","field":"banid","val":"{BanID}"},{"name":"Banner name","field":"banname","val":"{BanName}"},{"name":"Bid","field":"bid","val":"{BidValue}"},{"name":"Campaign ID","field":"campid","val":"{CampaignID}"},{"name":"Location","field":"location","val":"{Location}"},{"name":"Site name","field":"site","val":"{SiteName}"},{"name":"Spot name","field":"spot","val":"{SpotName}"}]', '', 0, 0, 'Display', 'Mobile, desktop', 1, 'Global'),(33, 'Clickadu', '', 1, '', '', '', '', '[{"name":"Zone ID", "field":"zoneid", "val":"{zoneid}"}]', '', 0, 0, 'Pop, redirect', 'Mobile', 1, 'Global');
<next>
INSERT INTO `settings` (`name`, `val`, `default_val`, `val_varchar`, `default_val_varchar`,`info`) VALUES 
('table_colors', 1, 0, '', '', '-'),
('save_report_groups', '1', '1', '', '', ''),
('cookies', 86400, 86400, '', '', '-'),
('cookies_click', 86400, 86400, '', '', '-'),
('lp_ctr', '2', '2', 'round', 'round', '-'), 
('cr', '4', '4', 'round', 'round', '-'), 
('epc', '4', '4', 'round', 'round', '-'), 
('cpc', '4', '4', 'round', 'round', '-'), 
('revenue', '2', '2', 'round', 'round', '-'), 
('cost', '2', '2', 'round', 'round', '-'), 
('profit', '2', '2', 'round', 'round', '-'), 
('roi', '2', '2', 'round', 'round', '-'),
('uct_block', '1', '1', '', '', '-'),
('check_private_ip', '1', '1', '', '', '-'),
('save_report_groups', '1', '1', '', '', '-'),
('landtime', '300', '300', '', '', '-'),
('lpkey', '0', '0', md5(CONCAT(NOW(),(SELECT password FROM users WHERE id=1))), md5(CONCAT(NOW(),(SELECT password FROM users WHERE id=1))), '-');
<next>
INSERT INTO `groups`(`id`, `name`, `type`) VALUES (0,0,0);
<next>
UPDATE `groups` SET id=0;
<next>
ALTER TABLE `groups` AUTO_INCREMENT=1;
<next>
INSERT INTO `landing_pages`(`id`, `status`, `name`, `url`, `group_lp`, `lang`) VALUES (0,0,'DIRECT',0,0,0);
<next>
UPDATE `landing_pages` SET id=0;
<next>
ALTER TABLE landing_pages AUTO_INCREMENT=1;
<next>
INSERT INTO `networks`(`id`, `status`, `name`) VALUES (0,0,0);
<next>
UPDATE `networks` SET id=0;
<next>
ALTER TABLE networks AUTO_INCREMENT=1;
<next>
INSERT INTO `offers`(`id`, `name`, `url`, `network`, `payout`, `status`, `geo`, `group_of`, `auto_payout`, `cap`) VALUES (0,0,0,0,0,0,0,0,0,0);
<next>
UPDATE `offers` SET id=0;
<next>
ALTER TABLE offers AUTO_INCREMENT=1;
<next>
INSERT INTO  `clicks_tokens` (`id`,`click_id`,`t1`,`t2`,`t3`,`t4`,`t5`,`t6`,`t7`,`t8`,`t9`,`t10`)VALUES (0,'0','0','0','0','0','0','0','0','0','0','0');
<next>
UPDATE `clicks_tokens` SET id=0;
<next>
ALTER TABLE clicks_tokens AUTO_INCREMENT=1;
<next>
INSERT INTO `traffic_sources`(`id`, `name`, `tokens`, `postback_url`, `status`, `e_name`, `e_value`) VALUES (0,0,0,0,0,0,0);
<next>
UPDATE `traffic_sources` SET id=0;
<next>
ALTER TABLE traffic_sources AUTO_INCREMENT=1;
<next>
INSERT INTO `campaigns`(`id`, `keyword`, `name`, `status`, `red_type`, `group_id`, `sources_id`, `start_camp`, `cpc`, `date_cr`) VALUES (0,0,0,0,0,0,0,0,0,0);
<next>
UPDATE `campaigns` SET id=0;
<next>
ALTER TABLE campaigns AUTO_INCREMENT=1;
<next>
INSERT INTO `paths`(`id`, `status`, `camp_id`, `split`, `is_rule`, `name`) VALUES (0,3,0,0,0,"Rules");
<next>
UPDATE `paths` SET id=0;
<next>
ALTER TABLE paths AUTO_INCREMENT=1;
<next>
INSERT INTO `rule`(`id`, `path_id`, `status`, `camp_id`, `name`) VALUES (0,0,0,0,'Default');
<next>
UPDATE `rule` SET id=0;
<next>
ALTER TABLE rule AUTO_INCREMENT=1;
<next>
INSERT INTO `conversion`(`id`, `camp_id`, `offer`, `offer_type`, `lp`, `pay`, `time`, `ts`, `an`) VALUES (0,0,0,0,0,0,0,0,0);
<next>
UPDATE `conversion` SET id=0;
<next>
ALTER TABLE conversion AUTO_INCREMENT=1;
<next>
INSERT INTO `clicks`(`id`, `click_time`, `camp_id`, `offer`, `path_id`, `landing_page`, `cvr_id`, `ts_id`, `rule_id`, `offer_click`, `offer_type`, `an`, `pay`, `cpc`, `geo`, `ua`, `ip`, `publisher`, `referer_domain`, `bidhash`, `is_bot`, `token`) VALUES (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
<next>
UPDATE `clicks` SET id=0;
<next>
ALTER TABLE clicks AUTO_INCREMENT=1;
<next>
INSERT INTO  user_agents (id,user_agent,device_brand_id,device_model_id,device_lang_id,device_td1_id,device_td2_id,device_td3_id,device_td4_id,os,browser)VALUES (0,0,0,0,0,0,0,0,0,0,0);
<next>
UPDATE user_agents SET id=0;
<next>
ALTER TABLE user_agents AUTO_INCREMENT=1;
<next>
INSERT INTO domains(name,`default`,status)VALUES ('{domain}',  '1',  '1');
<next>
UPDATE domains SET id=0;
<next>
ALTER TABLE domains AUTO_INCREMENT=1;
<next>
INSERT INTO  token_value (id,val)VALUES (0,'-');
<next>
UPDATE token_value SET id=0;
<next>
INSERT INTO `columns_settings` (`id`, `user_id`, `page`, `column`, `status`) VALUES
(1,0, 'Clicklog', 'path', 0),
(2,0, 'Clicklog', 'landing_page', 0),
(3,0, 'Clicklog', 'offer', 0),
(4,0, 'Clicklog', 'traffic_source', 0),
(5,0, 'Clicklog', 'aff__network', 0),
(6,0, 'Clicklog', 'city', 0),
(7,0, 'Clicklog', 'ISP', 0),
(8,0, 'Clicklog', 'connection_type', 0),
(9,0, 'Clicklog', 'user_agent', 0),
(10,0, 'Clicklog', 'device_brand', 0),
(11,0, 'Clicklog', 'device_type', 0),
(12,0, 'Clicklog', 'device_model', 0),
(13,0, 'Clicklog', 'device_resolution', 0),
(14,0, 'Clicklog', 'display_size', 0),
(15,0, 'Clicklog', 'language', 0),
(16,0, 'Clicklog', 'referer_domain', 0),
(17,0, 'Clicklog', 'referer_url', 0),
(18,0, 'Clicklog', 'token_1', 0),
(19,0, 'Clicklog', 'token_2', 0),
(20,0, 'Clicklog', 'token_3', 0),
(21,0, 'Clicklog', 'token_4', 0),
(22,0, 'Clicklog', 'token_5', 0),
(23,0, 'Clicklog', 'token_6', 0),
(24,0, 'Clicklog', 'token_8', 0),
(25,0, 'Clicklog', 'token_7', 0),
(26,0, 'Clicklog', 'token_10', 0),
(27,0, 'Clicklog', 'token_9', 0),
(28,0, 'Clicklog', 'external_ID', 0),
(29,0, 'Clicklog', 'is_bot', 0),
(30,0, 'Clicklog', 'payout', 0),
(31,0, 'Clicklog', 'conversion_status', 0),
(32,0, 'Clicklog', 'LP_click', 0),
(33,0, 'Clicklog', 'CPC', 0),
(34,1, 'Clicklog', 'clickid', 1),
(35,1, 'Clicklog', 'OS', 1),
(36,1, 'Clicklog', 'IP', 1),
(37,1, 'Clicklog', 'country', 1),
(38,1, 'Clicklog', 'campaign', 1),
(39,1, 'Clicklog', 'browser', 1),
(40,1, 'Clicklog', 'conversion', 1),
(41,1, 'Clicklog', 'time_click', 1);
<next>
INSERT INTO `settings` (`id`, `name`, `val`, `default_val`, `val_varchar`, `default_val_varchar`, `info`) VALUES (NULL, 'table_vertical_line', '0', '0', '', '', '');
<next>