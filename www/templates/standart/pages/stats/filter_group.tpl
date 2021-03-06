<div class="block_filter_all">
	<div class="block_filter_1">
	
		<?php 
			function button_link($group, $button, $arr_tpl){
				if(isset($arr_tpl['drilldown']) && (int)$arr_tpl['drilldown']!== 0){
					$result='&drilldown='.$arr_tpl['drilldown'].'&group2='.$group.'&group3=1&';
				}else{
					$result='&group1='.$group.'&group2=1&group3=1&';
				}
				$result='?page=Stats&'.$arr_tpl['l_camp_id'].$result.$arr_tpl['l_date'].'&button='.$button;
				return $result;
			}
		?>
	
		<a id="button_33" href="<?php echo button_link(33,33,$arr_tpl) ?>" class="button_stat">Campaigns</a>
		<a id="button_2" href="<?php echo button_link(3,2,$arr_tpl) ?>" class="button_stat">Offers</a>
		<a id="button_3" href="<?php echo button_link(4,3,$arr_tpl) ?>" class="button_stat">Landers</a>
		<a id="button_32" href="<?php echo button_link(32,32,$arr_tpl) ?>" class="button_stat">Traffic Sources</a>
		<?php echo $arr_tpl['tokens_html'];?>
		<ul class="ul_parent" id="button_6">
			<li	class="li_parent">
				<a>Connection<img src="templates/standart/images/arrow_btn.png"></a>
				<ul class="ul_children">
					<a id="button_61" href="<?php echo button_link(6,61,$arr_tpl) ?>"><li class="li_children">ISP / Carrier</li></a>
					<a id="button_151" href="<?php echo button_link(30,62,$arr_tpl) ?>"><li class="li_children">Connection type</li></a>
				</ul>
			</li>
		</ul>
		<ul class="ul_parent" id="button_7">
			<li	class="li_parent">
				<a>IP<img src="templates/standart/images/arrow_btn.png"></a>
				<ul class="ul_children">
					<a id="button_151" href="<?php echo button_link(8,15,$arr_tpl) ?>"><li class="li_children">IP-range 1.2.3.xxx</li></a>
					<a id="button_16" href="<?php echo button_link(9,16,$arr_tpl) ?>"><li class="li_children">IP-range 1.2.xxx.xxx</li></a>
				</ul>
			</li>
		</ul>
		<ul class="ul_parent" id="button_8">
			<li	class="li_parent">
				<a>Device<img src="templates/standart/images/arrow_btn.png">
				</a>
				<ul class="ul_children">
					<a id="button_17" href="<?php echo button_link(10,17,$arr_tpl) ?>"><li class="li_children">Device type</li></a>
					<a id="button_171" href="<?php echo button_link(29,171,$arr_tpl) ?>"><li class="li_children">Device name</li></a>
					<a id="button_18" href="<?php echo button_link(11,18,$arr_tpl) ?>"><li class="li_children">Device brand</li></a>
					<a id="button_19" href="<?php echo button_link(12,19,$arr_tpl) ?>"><li class="li_children">Device model</li></a>
					<a id="button_20" href="<?php echo button_link(13,20,$arr_tpl) ?>"><li class="li_children">Device resolution</li></a>
				</ul>
			</li>
		</ul>
		<ul class="ul_parent" id="button_9">
			<li	class="li_parent">
				<a>OS<img src="templates/standart/images/arrow_btn.png"></a>
				<ul class="ul_children">
					<a id="button_21" href="<?php echo button_link(17,21,$arr_tpl) ?>"><li class="li_children">OS name</li></a>
					<a id="button_22" href="<?php echo button_link(18,22,$arr_tpl) ?>"><li class="li_children">OS version</li></a>
				</ul>
			</li>
		</ul>	
		<ul class="ul_parent" id="button_10">
			<li	class="li_parent">
				<a>Browser<img src="templates/standart/images/arrow_btn.png"></a>
				<ul class="ul_children">
					<a id="button_23" href="<?php echo button_link(15,23,$arr_tpl) ?>"><li class="li_children">Browser name</li></a>
					<a id="button_24" href="<?php echo button_link(16,24,$arr_tpl) ?>"><li class="li_children">Browser version</li></a>
				</ul>
			</li>
		</ul>

		<ul class="ul_parent" id="button_11">
			<li	class="li_parent">
				<a>Country<img src="templates/standart/images/arrow_btn.png"></a>
				<ul class="ul_children">
					<li class="li_children">
						<a id="button_25" href="<?php echo button_link(19,25,$arr_tpl) ?>">Country</a>
					</li>
					<li class="li_children">
						<a id="button_32" href="<?php echo button_link(20,32,$arr_tpl) ?>">Region / City</a>
					</li>
				</ul>
			</li>
		</ul>
		
		<a id="button_12" href="<?php echo button_link(21,6,$arr_tpl) ?>" href="" class="button_stat">Language</a>
		<!--<a id="button_7" href="" class="button_stat">Aff. Network</a>-->
		<ul class="ul_parent" id="button_13">
			<li	class="li_parent">
				<a>Referer<img src="templates/standart/images/arrow_btn.png"></a>
				<ul class="ul_children">
					<li class="li_children"><a id="button_27" href="<?php echo button_link(24,27,$arr_tpl) ?>">Referer domain</li></a>
					<li class="li_children"><a id="button_26" href="<?php echo button_link(23,26,$arr_tpl) ?>">Referer URL</li></a>
				</ul>
			</li>
		</ul>
		<ul class="ul_parent" id="button_14">
			<li	class="li_parent">
				<a>Part of day<img src="templates/standart/images/arrow_btn.png"></a>
				<ul class="ul_children">
					<a id="button_29" href="<?php echo button_link(25,29,$arr_tpl) ?>"><li class="li_children">Day of week</li></a>
					<a id="button_30" href="<?php echo button_link(26,30,$arr_tpl) ?>"><li class="li_children">Hour of day</li></a>
				</ul>
			</li>
		</ul>
		<a id="button_31"  href="<?php echo button_link(31,31,$arr_tpl) ?>" class="button_stat">Days</a>
		<a id="button_15"  href="?page=Stats&<?php echo $arr_tpl['l_camp_id'];?>&group1=1&group2=1&group3=1&<?php echo $arr_tpl['l_date'];?>&button=15&leads=1&num_page=1" class="button_stat">Leads</a>
	</div>
	<!--
	<div class="block_filter_2">
		<a id="button_9" href="" class="button_stat">List</a>
		<a id="button_10" href="" class="button_stat">Table</a>
		<a id="button_11" href="" class="button_stat">Chart</a>
		
		<a id="button_12" href="?page=Stats&<?php echo $arr_tpl['l_camp_id'];?>&group1=2&group2=4&group3=1&<?php echo $arr_tpl['l_date'];?>&button=12"  class="button_stat">Paths-Landers</a>					
		<a id="button_13" href="?page=Stats&<?php echo $arr_tpl['l_camp_id'];?>&group1=4&group2=3&group3=1&<?php echo $arr_tpl['l_date'];?>&button=13" class="button_stat">Landers-Offers</a>					
		<a id="button_14" href="?page=Stats&<?php echo $arr_tpl['l_camp_id'];?>&group1=6&group2=7&group3=1&<?php echo $arr_tpl['l_date'];?>&button=14" class="button_stat">ISP-IP</a>
	</div>-->
	<div class="block_filter_3 block_filter_3_group <?php echo ($arr_tpl["leads"]==1?"block_filter_3_leads":"") ?>">
		<form method="get" id="act-form">
			<?php //echo $arr_tpl['leads'];?>
			<?php if(isset($arr_tpl['fid']) && !empty($arr_tpl['fid'])){ ?>
				<input type="hidden" name="fid" id="refresh_fid" value="<?php echo $arr_tpl['fid'];?>">
			<?php } ?>
			<input type="hidden" name="order" value=<?php echo $arr_tpl['order'];?>>
				<input type="hidden" name="type" value=<?php echo $arr_tpl['type'];?>>
				<input type="hidden" name="num_page" value=<?php echo $arr_tpl['num_page'];?>>
				<input type="hidden" name="val_page" value=<?php echo $arr_tpl['val_page'];?>>
			<input type="hidden" name="camps" value="<?php echo $arr_tpl['camp_id'];?>">
			<input type="hidden" name="page" value="Stats">
			<input type="hidden" name="leads" value="<?php echo $arr_tpl['leads'] ?>">

			<div class="stats-main-buttons-block">
			
				<?php if (isset($arr_tpl['leads']) && $arr_tpl['leads'] == 1) { ?>
					<select name="group1" id="group1" class="group_select" disabled>
				<?php } else { ?>
				
				
					<?php if (isset($arr_tpl['drilldown']) && (int)$arr_tpl['drilldown']!== 0) { ?>
							<input type="hidden" name="drilldown" value="<?php echo $arr_tpl['drilldown']; ?>">
							<select name="drilldown" id="group1" class="group_select" disabled>
						<?php } else { ?>
							<select name="group1" id="group1" class="group_select">
						<?php } ?>
					
					
				<?php } ?>
					<option value="1">Choose grouping</option>
					<option value="33">Campaigns</option>
					<option value="3">Offers</option>
					<option value="4">Landers</option>
					<option value="32">Traffic Sources</option>
					<option value="6">ISP / Carrier</option>
					<option value="30">Connection type</option>
					<option value="8">IP-range 1.2.3.xxx</option>
					<option value="9">IP-range 1.2.xxx.xxx</option>
					<option value="10">Device type</option>
					<option value="29">Device name</option>
					<option value="11">Device brand</option>
					<option value="12">Device model</option>
					<option value="13">Device resolution</option>
					<option value="14">Data speed</option>
					<option value="15">Browser</option>
					<option value="16">Browser version</option>
					<option value="17">OS name</option>
					<option value="18">OS version</option>
					<option value="19">Country</option>
					<option value="20">City</option>
					<option value="21">Language</option>
					<option value="22">Aff. Network</option>
					<option value="24">Referer domain</option>
					<option value="23">Referer URL</option>
					<option value="25">Day of week</option>
					<option value="26">Hour of day</option>
					<option value="31">Days</option>
					<?php if ($arr_tpl['leads'] == 1) { ?>
						<option selected>Leads</option>
					<?php } ?>
					<?php echo $arr_tpl['token_select'];?>
					<option value="35">CPC</option>
					<option value="34">Conversion Status</option>
					<option value="38">Conversion Status 2</option>
				</select>

				<?php if (isset($arr_tpl['leads']) && $arr_tpl['leads'] == 1) { ?>
				<select name="group2" id="group2" class="group_select" disabled>
				<?php } else { ?>
				<select name="group2" id="group2" class="group_select">
				<?php } ?>
					<option value="1">Choose grouping</option>
					<option value="33">Campaigns</option>
					<option value="3">Offers</option>
					<option value="4">Landers</option>
					<option value="32">Traffic Sources</option>
					<option value="6">ISP / Carrier</option>
					<option value="30">Connection type</option>
					<option value="8">IP-range 1.2.3.xxx</option>
					<option value="9">IP-range 1.2.xxx.xxx</option>
					<option value="10">Device type</option>
					<option value="29">Device name</option>
					<option value="11">Device brand</option>
					<option value="12">Device model</option>
					<option value="13">Device resolution</option>
					<option value="14">Data speed</option>
					<option value="15">Browser</option>
					<option value="16">Browser version</option>
					<option value="17">OS name</option>
					<option value="18">OS version</option>
					<option value="19">Country</option>
					<option value="20">City</option>
					<option value="21">Language</option>
					<option value="22">Aff. Network</option>
					<option value="24">Referer domain</option>
					<option value="23">Referer URL</option>
					<option value="25">Day of week</option>
					<option value="26">Hour of day</option>
					<option value="31">Days</option>
					<?php echo $arr_tpl['token_select'];?>
					<option value="35">CPC</option>
					<option value="34">Conversion Status</option>
					<option value="38">Conversion Status 2</option>
				</select>

				<?php if (isset($arr_tpl['leads']) && $arr_tpl['leads'] == 1) { ?>
				<select name="group3" id="group3" class="group_select" disabled>
				<?php } else { ?>
				<select name="group3" id="group3" class="group_select">
				<?php } ?>
					<option value="1">Choose grouping</option>
					<option value="33">Campaigns</option>
					<option value="3">Offers</option>
					<option value="4">Landers</option>
					<option value="32">Traffic Sources</option>
					<option value="6">ISP / Carrier</option>
					<option value="30">Connection type</option>
					<option value="8">IP-range 1.2.3.xxx</option>
					<option value="9">IP-range 1.2.xxx.xxx</option>
					<option value="10">Device type</option>
					<option value="29">Device name</option>
					<option value="11">Device brand</option>
					<option value="12">Device model</option>
					<option value="13">Device resolution</option>
					<option value="14">Data speed</option>
					<option value="15">Browser</option>
					<option value="16">Browser version</option>
					<option value="17">OS name</option>
					<option value="18">OS version</option>
					<option value="19">Country</option>
					<option value="20">City</option>
					<option value="21">Language</option>
					<option value="22">Aff. Network</option>
					<option value="24">Referer domain</option>
					<option value="23">Referer URL</option>
					<option value="25">Day of week</option>
					<option value="26">Hour of day</option>
					<option value="31">Days</option>
					<?php echo $arr_tpl['token_select'];?>
					<option value="35">CPC</option>
					<option value="34">Conversion Status</option>
					<option value="38">Conversion Status 2</option>
				</select>
				
				<?php if (isset($arr_tpl['leads']) && $arr_tpl['leads'] == 1) { ?>
					<input type="text" class="search_in_report" onclick="this.placeholder='';" onblur="tryToReturnPlaceholderSearch(this);" name="search_name" placeholder="Search" value="<?php echo $arr_tpl['search'];?>"> 
				<?php } else { ?>
					<input type="text" class="search_in_report" onclick="this.placeholder='';" onblur="tryToReturnPlaceholderSearch(this);" name="search_report" placeholder="Search" value="<?php echo $arr_tpl['search'];?>"> 
				<?php } ?>

				<select name="date" style="width: 100px;"  onchange="enter_date_report(this);" id="timedate" class="group_select">
					<?php foreach($arr_tpl['arr_date'] as $key => $value) { ?>
						<?php if ($arr_tpl['date']==$key){ ?>
							<option selected value="<?php echo $key ?>"><?php echo $value ?></option>
						<?php } else { ?>
							<option value="<?php echo $key ?>"><?php echo $value ?></option>
						<?php } ?>
					<?php } ?>
				</select>


				<div id="custom_date" style="display:none;" <?php echo ($arr_tpl['date']==12?"class='narrow_date_input'":"") ?> >
					<input type="text" name="date_s" class="blocked_minutes" value="<?php echo $arr_tpl['date_s'];?>" id="custom_date_pol1">
					<font> - </font>
					<input type="text" name="date_e" class="blocked_minutes" value="<?php echo $arr_tpl['date_e'];?>" id="custom_date_pol2">
					<select name="timezone" class="datetime_timezone">
						<?php for($i=-12;$i<=12;$i++){echo '<option value="'.($i==0?'+0':$i).'">'.($i>0?'+'.$i:$i).'</option>';} ?>
					</select>
				</div>
				<a id="refresh-btn" onclick="validateActForm();" class="blue-button" style="display:inline-block; top:0px"><img src="templates/standart/images/w-refresh.png" class="icon">Refresh</a>
				
				<?php if (isset($arr_tpl['drilldown']) && (int)$arr_tpl['drilldown']!== 0) { ?>
					<a id="drilldown_close" onclick="drilldown_close()" class="blue-button" style="top:1px;"><img src="templates/standart/images/w-report3.png" class="icon">Close</a>
				<?php } else { ?>
					<a id="drilldown" onclick="drilldown()" class="blue-button" style="display: none;top:1px;"><img src="templates/standart/images/w-report3.png" class="icon">Drilldown</a>
				<?php } ?>
				
			<!-- 	<div class="stats_group_gray_buttons"> -->
					<?php if (!isset($arr_tpl['leads']) || ($arr_tpl['leads']!=1)) { ?>
						<a class="gray-button" style="position: relative;display: inline-block;" href="<?php echo $arr_tpl['csv_link'];?>"><img src="templates/standart/images/b-csv2.png" class="icon csv_icon" target="_blank">.csv</a>
						<a class="gray-button" style="position: relative; display: inline-block;" href="<?php echo $arr_tpl['txt_link'];?>"><img src="templates/standart/images/b-csv2.png" class="icon csv_icon" target="_blank">.txt</a>
					<?php } ?>

					<?php if (!isset($arr_tpl['leads']) || ($arr_tpl['leads'] != 1)) { ?>
						<a class="gray-button" style="position: relative;" id="filters"><img src="templates/standart/images/filter.png" class="icon updatecosts_icon">
					

						<?php if(isset($arr_tpl['fid']) && !empty($arr_tpl['fid'])) { ?>Edit filter<?php }else{ ?>Set filter<?php } ?></a>
							<?php if(isset($arr_tpl['fid']) && !empty($arr_tpl['fid'])){ ?>
								<a class="gray-button" style="position: relative;" id="clear_filters"><img src="templates/standart/images/filter.png" class="icon updatecosts_icon">Clear filter</a>
							<?php } ?>
					<?php  } ?>
				<!-- </div> -->


			</div>

			
				
			

		</form>	
	</div>
</div>