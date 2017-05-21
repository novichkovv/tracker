<div class="stat-container offers-stats-table">
	<div class="header-container">
		<table class="stat_header">
			<tr>
				<td class="id_td" id="hrow1">
					<div class="checkbox_group">
							<input type="checkbox" class="check_offer_all" name="check_offer_all" id="check_all"><label for="check_all"></label>
						</div>
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['1'] ?>">
						<?php echo ($arr_tpl['order']==1?$arr_tpl["str_img"]:'') ?> 
					id</a>
				</td>	
				
				<td class="geo_td" id="hrow2">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['16'] ?>">
						<?php echo ($arr_tpl['order']==16?$arr_tpl["str_img"]:'') ?>
					Geo</a>
				</td>
				
				<td class="name_td" id="hrow3">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['2'] ?>">
						<?php echo ($arr_tpl['order']==2?$arr_tpl["str_img"]:'') ?>
					Name</a>
				</td>
				<td class="group_td" id="hrow4">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['4'] ?>">
						<?php echo ($arr_tpl['order']==4?$arr_tpl["str_img"]:'') ?>
					Group</a>
				</td>
				<td class="network_td" id="hrow5">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['5'] ?>">
						<?php echo ($arr_tpl['order']==5?$arr_tpl["str_img"]:'') ?>
					Network</a>
				</td>

				<td class="url_td table_td_info" id="hrow6">
					<b>URL</b>
				</td>
				<td class="clh_td table_td_info" id="hrow7">
					<b>CLH</b>
				</td>	
				<td class="llh_td table_td_info" id="hrow8">
					<b>LLH</b>
				</td>	
				<td class="plh_td table_td_info" id="hrow9">
					<b>PLH</b>
				</td>	
				<td class="lastlead_td table_td_info" id="hrow10">
					<b>Last lead</b>
				</td>	

				<td class="clicks_td" id="hrow11">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['6'] ?>">
						<?php echo ($arr_tpl['order']==6?$arr_tpl["str_img"]:'') ?>
					Clicks</a>
				</td>

				<td class="lpctr_td table_td_stat" id="hrow12">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['23'] ?>">
						<?php echo ($arr_tpl['order']==23?$arr_tpl["str_img"]:'') ?>
					LP CTR</a>
				</td>
															
				<td class="leads_td table_td_stat" id="hrow13">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['8'] ?>">
						<?php echo ($arr_tpl['order']==8?$arr_tpl["str_img"]:'') ?>
					Leads</a>
				</td>							
				<td class="cr_td table_td_stat" id="hrow14">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['9'] ?>">
						<?php echo ($arr_tpl['order']==9?$arr_tpl["str_img"]:'') ?>
					CR</a>
				</td>							
				<td class="epc_td table_td_stat" id="hrow15">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['10'] ?>">
						<?php echo ($arr_tpl['order']==10?$arr_tpl["str_img"]:'') ?>
					EPC</a>
				</td>							
				<td class="cpc_td table_td_stat" id="hrow16">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['11'] ?>">
						<?php echo ($arr_tpl['order']==11?$arr_tpl["str_img"]:'') ?>
					CPC</a>
				</td>							
				<td class="revenue_td table_td_stat" id="hrow17" >
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['12'] ?>">
						<?php echo ($arr_tpl['order']==12?$arr_tpl["str_img"]:'') ?>
					Revenue</a>
				</td>							
				<td class="cost_td table_td_stat" id="hrow18">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['13'] ?>">
						<?php echo ($arr_tpl['order']==13?$arr_tpl["str_img"]:'') ?>
					Cost</a>
				</td>							
				<td class="proft_td" 
					id="hrow19">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['14'] ?>">
						<?php echo ($arr_tpl['order']==14?$arr_tpl["str_img"]:'') ?>
					Profit</a>
				</td>							
				<td class="roi_td" 
					id="hrow20">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['15'] ?>">
						<?php echo ($arr_tpl['order']==15?$arr_tpl["str_img"]:'') ?>
					ROI</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="body-container">
		<script>hideTablePreload()</script>
		<table class="table_stat camps_table" cellspacing="0" width="100%">
	
			<tbody>
				<?php $sum_clicks=0;$sum_leads=0;$sum_rev=0;$sum_spend=0;$sum_land_cl=0;$sum_offer_cl=0;$row_counter=0;
					foreach($arr_tpl["rows"] as $row) { $sum_clicks+=$row["clicks"];
														$sum_leads+=$row["leads"];
														$sum_rev+=$row["rev"];
														$sum_spend+=$row["spend"];
														$sum_land_cl+=$row["lp_cl"];
														$sum_offer_cl+=$row["off_cl"]; ?>

					<?php $row_counter++; ?>

					<tr id="offer_<?php echo $row['id']?>" class="table_stat_tr <?php echo ($row['status']!=='1'?' camp_inactive':'') ?> <?php if ($row['profit']>0){
										echo 'tr_profit_1';
									}else if($row['profit']==0){
										 echo 'tr_profit_2';
									}else{
										echo 'tr_profit_3';
									}?> visible_row <?php echo ($row_counter % 2 == 1?'gray_row':'') ?>" 
					onclick="hide_button(this, '<?php echo $row['status'] ?>')" ondblclick="edit('<?php echo $row['id'] ?>');"
					data-id="<?php echo $row['id'] ?>" data-status="<?php echo $row['status'] ?>" >
						<input type="hidden" name="id" value="<?php echo $row['id'] ?>">
						<input type="hidden" name="name" value="<?php echo str_replace("'","\'",$row['name']) ?>">
						<input type="hidden" name="url" value="<?php echo $row['url'] ?>">
						<input type="hidden" name="network" value="<?php echo $row['network_id'] ?>">
						<input type="hidden" name="payout" value="<?php echo $row['payout'] ?>">
						<input type="hidden" name="status" value="<?php echo $row['status'] ?>">
						<input type="hidden" name="geo" value="<?php echo $row['geo'] ?>">
						<input type="hidden" name="group_of" value="<?php echo $row['group_id'] ?>">
						<input type="hidden" name="auto_payout" value="<?php echo $row['auto_payout'] ?>">
						<input type="hidden" name="cap" value="<?php echo $row['cap'] ?>">
						<input type="hidden" name="upsell" value="<?php echo $row['upsell'] ?>">
						<td class="id_td">
							<div class="checkbox_group">
								<input type="checkbox" class="check_offer" name="check_offer" id="check<?php echo $row['id']?>"><label for="check<?php echo $row['id'] ?>"><?php echo $row['id'] ?></label>
							</div>

							<!-- <?php echo $row['id'] ?> -->
						</td>
						<td class="geo_td">
							<?php echo ($row['geo']=='1'?'Global':($row['geo']=='0'?'none':$row['geo'])) ?>
						</td>
						<td class="offer_name_td name_camp">
							<span><?php echo $row['name'] ?></span> <span style="color:#aaa;"> <?php echo ($row['auto_payout']==1?'auto':round($row['payout'],3).'$') ?></span>
							<?php echo ($row['note']==0 ? "" : '<img style="margin-left:4px;" width="9px" src="templates/standart/images/green-star.png">') ?>
						</td>
						<td class="group_td">
							<?php echo ($row['group_id']=="0"?"":$row['group_name']) ?>
						</td>
						<td class="network_td">
							<?php echo $row['network'] ?>
						</td>
						<td class="url_td table_td_info">
								<input tyle="text" class="table_link" readonly value="<?php echo $row['url']; ?>">
							</td>
						<td class="clh_td table_td_info loading" id="clh_<?php echo $row['id'] ?>">
							<img style="width: 40px;" src="templates/standart/images/loading.GIF">
						</td>
						<td class="llh_td table_td_info loading"  id="llh_<?php echo $row['id'] ?>">
							<img style="width: 40px;" src="templates/standart/images/loading.GIF">
						</td>
						<td class="plh_td table_td_info loading"  id="plh_<?php echo $row['id'] ?>">
							<img style="width: 40px;" src="templates/standart/images/loading.GIF">
						</td>
						<td class="lastlead_td table_td_info" id="last_lead_<?php echo $row['id'] ?>">
							-
						</td>
						
						<td class="clicks_td">
							<?php echo $row['clicks'] ?>
						</td>
						<td class="lpctr_td table_td_stat">
							<?php echo $row['LP_CTR'] ?>%
								<div class="offer_clicks_hide" style="display:none;">
									<?php echo $row['off_cl'] ?>
								</div>
								<div class="landing_clicks_hide" style="display:none;">
									<?php echo $row['clicks'] ?>
								</div>
						</td>
						<td  class="leads_td table_td_stat">
							<?php echo $row['leads'] ?>
						</td>
						<td  class="cr_td table_td_stat">
							<?php echo $row['CR'] ?>%
						</td>
						<td  class="epc_td table_td_stat">
							$<?php echo $row['EPC'] ?>
						</td>
						<td  class="cpc_td table_td_stat">
							$<?php echo $row['CPC'] ?>
						</td>
						<td  class="revenue_td table_td_stat">
							$<?php echo $row['rev'] ?>
						</td>
						<td  class="cost_td table_td_stat">
							$<?php echo $row['spend'] ?>
						</td>
						<td class="profit_td <?php if ($row['profit']>0){
										echo 'color_stat_1';
									}else if($row['profit']==0){
										 echo 'color_stat_2';
									}else{
										echo 'color_stat_3';
									}?> ">
							<?php echo (strrchr(strval($row['profit']), '-')?str_replace('-','-$',$row['profit']):'$'.$row['profit']) ?>
						</td>
						<td class="roi_td <?php if ($row['profit']>0){
										echo 'color_stat_1';
									}else if($row['profit']==0){
										 echo 'color_stat_2';
									}else{
										echo 'color_stat_3';
									}?> ">
							<?php echo $row['ROI'] ?>%
						</td>
					</tr>
				<?php } ?>
			</tbody>
		</table>
		<script>showTablePostLoad()</script>
	</div>	

	<div class="footer-container">
			<table class="stat_footer">
				<tr> 
					<td id="frow1"></td>
					<td id="frow2"></td>
					<td id="frow3"></td>
					<td id="frow4"></td>
					<td id="frow5" class="table_td_stat"></td>
					<td id="frow6" class="table_td_info"></td>
					<td id="frow7" class="table_td_info"></td>
					<td id="frow8" class="table_td_info"></td>
					<td id="frow9" class="table_td_info"></td>
					<td id="frow10" class="table_td_info"></td>

					<td id="frow11" class="clicks_td">
						<?php echo number_format($sum_clicks) ?>
					</td>
					
					<td id="frow12"  class="lpctr_td table_td_stat">
						<?php echo ($sum_land_cl>0?number_format((($sum_offer_cl / $sum_land_cl)*100),2):0) ?>%
					</td>
					<td id="frow13"  class="leads_td table_td_stat">
						<?php echo number_format($sum_leads) ?>
					</td>
					<td id="frow14"  class="cr_td table_td_stat">
						<?php echo ($sum_clicks>0?number_format((($sum_leads  / $sum_clicks)*100),2):0) ?>%
					</td>
					<td id="frow15"  class="epc_td table_td_stat">
						<?php echo ($sum_clicks>0?number_format(($sum_rev / $sum_clicks),4):0) ?>
					</td>
					<td id="frow16"  class="cpc_td table_td_stat">
						$<?php echo ($sum_clicks>0?number_format(($sum_spend / $sum_clicks),4):0) ?>
					</td>
					<td id="frow17"  class="revenue_td table_td_stat">
						$<?php echo number_format($sum_rev,2) ?>
					</td>
					<td id="frow18"  class="cost_td table_td_stat">
						$<?php echo number_format($sum_spend,2) ?>
					</td>
					<td id="frow19" class="profit_td <?php if(($sum_rev-$sum_spend)>0){
															echo 'color_stat_1';
														}else if (($sum_rev-$sum_spend)==0){
																echo 'color_stat_2';
														}else{
															echo 'color_stat_3';
														} ?>">
						<?php echo (strrchr(strval($sum_rev-$sum_spend), '-')?str_replace('-','-$',number_format(($sum_rev-$sum_spend),2)):'$'.number_format(($sum_rev-$sum_spend),2)) ?>
					</td>
					<td id="frow20" class="roi_td <?php if(($sum_rev-$sum_spend)>0){
															echo 'color_stat_1';
														}else if (($sum_rev-$sum_spend)==0){
																echo 'color_stat_2';
														}else{
															echo 'color_stat_3';
														} ?>">
						<?php echo ($sum_spend>0?number_format(((($sum_rev - $sum_spend) / $sum_spend) * 100),2):0) ?>%
					</td>
				</tr>
			</table>
	</div>


	
</div>