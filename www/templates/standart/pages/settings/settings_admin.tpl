<div class="settings_block">
	<div class="settings_dop_block1">
		<h3>User info</h3>
		<form method="post" action="?page=save_info" id="usr-info-form">
			<input name="id" value="<?php echo $arr_tpl['user']['id']; ?>" type="hidden">
			<div class="field_set">
				<span>Login</span> 
				<input name="login" value="<?php echo $arr_tpl['user']['login']; ?>" type="text">
			</div>
			<div class="field_set">
				<span>Email</span> 
				<input name="email" value="<?php echo $arr_tpl['user']['email']; ?>" type="text">
			</div>
			
			<div class="field_set">
				<span>Timezone</span> 
				<select disabled="disabled" name="user_timezone" id="user_timezone">
					<option value="-12">(GMT -12:00) Eniwetok, Kwajalein</option>
					<option value="-11">(GMT -11:00) Midway Island, Samoa</option>
					<option value="-10">(GMT -10:00) Hawaii</option>
					<option value="-9">(GMT -9:00) Alaska</option>
					<option value="-8">(GMT -8:00) Pacific Time (US &amp; Canada)</option>
					<option value="-7">(GMT -7:00) Mountain Time (US &amp; Canada)</option>
					<option value="-6">(GMT -6:00) Central Time (US &amp; Canada), Mexico City</option>
					<option value="-5">(GMT -5:00) Eastern Time (US &amp; Canada), Bogota, Lima</option>
					<option value="-4">(GMT -4:00) Atlantic Time (Canada), Caracas, La Paz</option>
					<option value="-3">(GMT -3:00) Brazil, Buenos Aires, Georgetown</option>
					<option value="-2">(GMT -2:00) Mid-Atlantic</option>
					<option value="-1">(GMT -1:00 hour) Azores, Cape Verde Islands</option>
					<option value="0">(GMT) Western Europe Time, London, Lisbon, Casablanca</option>
					<option value="1">(GMT +1:00 hour) Brussels, Copenhagen, Madrid, Paris</option>
					<option value="2">(GMT +2:00) Kaliningrad, South Africa</option>
					<option value="3">(GMT +3:00) Baghdad, Riyadh, Moscow, St. Petersburg</option>
					<option value="4">(GMT +4:00) Abu Dhabi, Muscat, Baku, Tbilisi</option>
					<option value="5">(GMT +5:00) Ekaterinburg, Islamabad, Karachi, Tashkent</option>
					<option value="6">(GMT +6:00) Almaty, Dhaka, Colombo</option>
					<option value="7">(GMT +7:00) Bangkok, Hanoi, Jakarta</option>
					<option value="8">(GMT +8:00) Beijing, Perth, Singapore, Hong Kong</option>
					<option value="9">(GMT +9:00) Tokyo, Seoul, Osaka, Sapporo, Yakutsk</option>
					<option value="10">(GMT +10:00) Eastern Australia, Guam, Vladivostok</option>
					<option value="11">(GMT +11:00) Magadan, Solomon Islands, New Caledonia</option>
					<option value="12">(GMT +12:00) Auckland, Wellington, Fiji, Kamchatka</option>
				</select>
			</div>
			
			<!--<input type="submit" style="width: 200px;margin-left: 140px;margin-top: 15px;" class="button" value="Save">-->
			<a onclick="$('#usr-info-form').submit();" class="green-button" style="display: block; width: 178px;margin-left: 140px;margin-top: 15px;">
			<img src="templates/standart/images/w-save.png" class="icon save_icon">Save</a>
		</form>
	</div>
	<div class="settings_dop_block1">
		<h3>Change password</h3>
		<form method="post" action="?page=save_pass" id="pass-form">
			<input name="id" value="<?php echo $arr_tpl['user']['id']; ?>" type="hidden">
			<div class="field_set">
				<span>Old password</span> 
				<input name="old_pass" value="" type="password">
			</div>
			<div class="field_set">
				<span>New password</span> 
				<input name="new_pass"  value="" type="password">
			</div>
			<div class="field_set">
				<span>Re-enter</span> 
				<input name="copy_new_pass"  value="" type="password">
			</div>
			<a onclick="$('#pass-form').submit();" class="green-button" style="display: block; width: 178px;margin-left: 140px;margin-top: 15px;">
			<img src="templates/standart/images/w-save.png" class="icon save_icon">Save</a>
		</form>
	</div>
	<div class="settings_dop_block2" style="margin-bottom: 10px;">
		<h3>Customize settings</h3>
		<form method="post" action="?page=customize_save" id="customize-form">
			<div style="float: left; width: 370px;margin-left: 20px;padding-bottom: 10px;">
				<div class="field_set">
					<span>User session (s)</span>
					<input name="cookies" value="<?php echo $arr_tpl['cookies'];?>" type="number" style="margin-top: 10px;margin-right: 0px;" min="600" max="1200000">
				</div>
				<div class="field_set">
					<span>Unique period (s)</span>
					<input name="cookies_click" value="<?php echo $arr_tpl['cookies_click'];?>" type="number" style="margin-right: 0px;" min="1" max="1200000">
				</div>
				<div class="field_set">
					<span>LP live time (s)</span>
					<input name="landtime" value="<?php echo $arr_tpl['landtime'];?>" type="number" style="margin-right: 0px;" min="2" max="1200000">
				</div>
			</div>
			<div style="float: right; width: 380px;margin-left: 20px;">
				<div class="field_set" style="text-align: right;">
					<span>Table style</span>
					<select id="customtable_input" style="margin-top: 10px;" name="table_colors">
					    <option value="0">White</option>
					    <option value="2">Gray/white</option>
					    <option value="1">Colorize</option>
				    </select>
				</div>
				<div class="field_set" style="text-align: right;">
					<span>Vertical line</span>
					<input <?php echo $arr_tpl['table_vertical_line'];?> style="top: 2px;position: relative;margin-top: 10px;height: 14px;width: 14px;margin-right: 246px;margin-left: 0;" type="checkbox" name="table_vertical_line"> 
				</div>
			</div>
			<div class="clear"></div>
			<div style="width: 680px;margin-left: 50px;margin-top: 0px;">
				<div class="field_set" style="text-align: left;">
					<span>Remember groups in reports</span>
					<input <?php echo $arr_tpl['save_report_groups'];?> style="margin-top: 10px; height: 14px; width: 14px;margin-left:0px;" type="checkbox" name="save_report_groups"> 
				</div>
			</div>
			
			<div class="clear"></div>
			<script>
				        function adv_hideshow()
				        {

				        	if ($("#adv_settings_div").css("display")=="none") 
				     		{ 
				     			$("#adv_settings_div").show();
				     			$(".adv_settings img").attr("src","templates/standart/images/arrow_up.png");
								if (!FlashDetect.installed){
									try {
										new Clipboard('#copy_btn_pixel');
										$("#copy_btn_pixel").replaceWith($("<a href='javascript:' id='copy_btn_pixel' class='button' style='float:right;' data-clipboard-target='#lp_pixel_input' >Copy</a>"));	
									} catch (e){
										$("#lp_pixel_input").css({'width':'100%'});
									}
								} else {
									addZclip("#copy_btn_pixel", "#lp_pixel_input");
								}
				     		}
				     		else
				     		{	
				     			$("#adv_settings_div").hide();
				     			$(".adv_settings img").attr("src","templates/standart/images/arrow_down.png");
				     		}
				        }
				        </script>


			
				        <a href="javascript: adv_hideshow();" class="adv_settings" style="margin-left: 50px;width: 280px;font-size: 14px !important; color: #000;">Digits after the decimal point in stats
				        	<img src="templates/standart/images/arrow_down.png">
				        </a>
				<div id="adv_settings_div" style="display: none;margin-top: 10px;">
					<div style="width: 370px;margin-left: 20px; float: left;padding-bottom: 20px;">
						<div class="field_set" style="text-align: right;">
							<span>LP CTR</span>
							<input name="lp_ctr" style="margin-right:0;" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['lp_ctr']['val'] ?>">
						</div>
						<div class="field_set" style="text-align: right;">
							<span>CR</span>
							<input name="cr" style="margin-right:0;" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['cr']['val'] ?>">
						</div>
						<div class="field_set" style="text-align: right;">
							<span>EPC</span>
							<input name="epc" style="margin-right:0;" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['epc']['val'] ?>">
						</div>
						<div class="field_set" style="text-align: right;">
							<span>CPC</span>
							<input name="cpc" style="margin-right:0;" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['cpc']['val'] ?>">
						</div>
					</div>	
					<div style="width: 380px;margin-left: 20px; float: right;">	
						<div class="field_set" style="text-align: right;">
							<span>Revenue</span>
							<input name="revenue" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['revenue']['val'] ?>">
						</div>
						<div class="field_set" style="text-align: right;">
							<span>Cost</span>
							<input name="cost" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['cost']['val'] ?>">
						</div>
						<div class="field_set" style="text-align: right;">
							<span>Profit</span>
							<input name="profit" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['profit']['val'] ?>">
						</div>
						<div class="field_set" style="text-align: right;">
							<span>ROI</span>
							<input name="roi" type="number" min="1" max="8" value="<?php echo $arr_tpl['settings_round']['roi']['val'] ?>">
						</div>
					</div>
				</div>
			<a onclick="$('#customize-form').submit();" class="green-button" style="clear: both; display: block; width: 178px;margin: 0px auto;margin-top: 15px;">
			<img src="templates/standart/images/w-save.png" class="icon save_icon">Save</a>
		</form>
	</div>
	<div class="clear"></div>
	<div class="settings_dop_block2" style="margin-bottom:10px;">
		<h3>Tracking links</h3>
		<h4>Click URL</h4>
		<p>
			With Binom you don\'t need to place any PHP code on your landing pages. Visitors are redirected based on data stored in a cookie and referrer.
		</p>
		<input readonly value="<?php echo $arr_tpl['domain_url'];?>click.php?lp=1" id="copy_value1" type="text"/>
		<a href="javascript:" id="copy_btn1" class="button">Copy</a>
		<h4>Postback URL</h4>
		<p>
		Server-to-server postback URLs are the most secure and reliable method to count conversions. Use the URLs below to pass conversions from affiliate networks. To get your postback links working you have to:
		<ol>
		<li>Include the {clickId} token in your offer URLs. For example, you can add <b>&clickid={clickid}</b> to the offer URL, to have the click ID passed to the postback via the subid parameter on the affiliate network/advertiser side.</li>
		<li>Copy-paste the postback URL to your affiliate network panel. Make sure to replace the tokens with affiliate network-specific tokens. The following is what your postback URL would look like on a HasOffers based network: <br><a href="<?php echo $arr_tpl['domain_url'];?>click.php?cnv_id={aff_sub}&payout={payout}"><?php echo $arr_tpl['domain_url'];?>click.php?cnv_id={aff_sub}&payout={payout}</a></li>
		</ol>
		</p>
		<p>
		Consult the affiliate network documentation or support to find out which tokens you should use to pass back click ID and payout. The payout parameter is optional, if you do not use it, you can manually specify the payout in the offer configuration. Do not put these URLs or any of the tracking pixels / scripts in your landing pages.
		</p>
		<input readonly value="<?php echo $arr_tpl['domain_url'];?>click.php?cnv_id={network_token}&payout={payout}" id="copy_value2" type="text"/>
		<a href="javascript:" id="copy_btn2" class="button">Copy</a>
		<h4>Tracking pixel URL</h4>
		<p>
		In cases when your affiliate network only supports client-side pixels, you can use a conversion pixel or script. Conversion pixels are cookie-based and so you have to use the same domain for the cookie to work correctly. The clickid is also stored in a cookie, so conversion tracking will still work if the parameter is missing.
		</p>
		<p>
		Consult your affiliate network documentation or support to find out how to specify conversion pixels in their web panel. The payout parameter is optional, if you do not use it, you can manually specify payout in the offer configuration.
		</p>
		<p>
		Do not put these URLs or any of the postback URLs in your landing pages.
		</p>
		<input readonly id="copy_value4" value="<?php echo htmlspecialchars('<img src="'.$arr_tpl['domain_url'].'click.php?cnv_id=OPTIONAL&payout=OPTIONAL" style="display:none"/>') ; ?>" type="text" />
		<a href="javascript:" id="copy_btn4" class="button">Copy</a>
	</div>
	<div class="clear"></div>
	<div class="settings_dop_block2" style="margin-bottom:10px;">
		<h3>LP Protect</h3>
		<p>If you want protect your LPs from direct access just append this code to the start of LP code and add 'LP Key' token to lander URL on LP settings page.</p>
		<input readonly value='<?php echo $arr_tpl['lp_lock'];?>' id="copy_value9" type="text"/>
		<a href="javascript:" id="copy_btn9" class="button">Copy</a>
	</div>
	<div class="clear"></div>
	<div class="settings_dop_block2" style="margin-bottom:10px;">
		<h3>API</h3>
		<p>
			This token identifies the caller and authorizes them to perform operations on the API. Add this parametr in your URL of report’s page then you’ll see save statistic in JSON-format.
		</p>
		<input readonly value="<?php echo $arr_tpl['api_token'];?>" id="copy_value3" type="text"/>
		<a href="javascript:" id="copy_btn3" class="button">Copy</a>
	</div>
	<div class="clear"></div>
	<div class="settings_dop_block2">
		<h3>Export / Import</h3>
		<div>
		<p>You can transfer your campaign (with maintaining URLs), offers, landers, sources, aff. networks, domains, groups, filters, notes from Binom to Binom.</p>
		</div>
		<div style="width: 370px;margin-left: 0px; float: left;padding-bottom: 20px;">
			<p>
				<strong>Export</strong><br><br>
				<a href="?page=export" target="_blank">Download</a>
			</p>
		</div>
		<div style="width: 380px;margin-left: 0px; float: right;">	
			<?php if($arr_tpl['import']==1){?>
			<p>
				<strong>Import</strong><br>
			</p>
			<form id="import_form">
				<input name="import_file" id="import_file" type="file" style="width: 350px;border: none !important;margin-top: 3px;margin-left:13px;">
			</form>
			<a onclick="download_import()" class="green-button" style="display: block; margin-left: 20px;margin-top: 0px;width: 50px; position: relative; top:-8px;">
			<img src="templates/standart/images/w-save.png" class="icon save_icon">Load</a>
			<?php }else{?>
			<p>
				Import is available on a "clean" tracker
			</p>
			<?php }?>
			
		</div>
	</div>
</div>