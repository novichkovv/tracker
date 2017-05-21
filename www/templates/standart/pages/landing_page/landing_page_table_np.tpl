<div class="stat-container landing-stat-container">
	<div class="header-container">
		<table class="stat_header">
			<tr>
				<td class="id_td" id="hrow1">
					<div class="checkbox_group">
						<input type="checkbox" class="check_land_all" name="check_land_all" id="check_all"><label for="check_all"></label>
					</div>
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['1'] ?>">
						<?php echo ($arr_tpl['order']==1?$arr_tpl["str_img"]:'') ?>
					id</a>
				</td>	
				
				<td class="name_td" id="hrow2">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['2'] ?>">
						<?php echo ($arr_tpl['order']==2?$arr_tpl["str_img"]:'') ?>
					Name</a>
				</td>
				
				<td class="group_td" id="hrow3">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['4'] ?>">
						<?php echo ($arr_tpl['order']==4?$arr_tpl["str_img"]:'') ?>
					Group</a>
				</td>
				
				<td class="url_td table_td_info" id="hrow4">
					<b>URL</b>
				</td>
				<td class="clh_td table_td_info" id="hrow5">
					<b>CLH</b>
				</td>	
				
				<td class="llh_td" id="hrow6" style="display:none"></td>	
				<td class="plh_td" id="hrow7" style="display:none"></td>	
				<td class="lastlead_td" id="hrow8" style="display:none"></td>	
				
				<td class="clicks_td" id="hrow9">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['6'] ?>">
						<?php echo ($arr_tpl['order']==6?$arr_tpl["str_img"]:'') ?>
					Clicks</a>
				</td>

				<td class="lpctr_td table_td_stat" id="hrow10">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['23'] ?>">
						<?php echo ($arr_tpl['order']==23?$arr_tpl["str_img"]:'') ?>
					LP CTR</a>
				</td>

				<td class="leads_td" id="hrow11" style="display:none"></td>	
				<td class="cr_td" id="hrow12" style="display:none"></td>
				<td class="epc_td" id="hrow13" style="display:none"></td>	

				<td class="cpc_td table_td_stat" id="hrow14">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['11'] ?>">
						<?php echo ($arr_tpl['order']==11?$arr_tpl["str_img"]:'') ?>
					CPC</a>
				</td>	

				<td class="revenue_td" id="hrow15" style="display:none"></td>	

				<td class="cost_td table_td_stat" id="hrow16">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['13'] ?>">
						<?php echo ($arr_tpl['order']==13?$arr_tpl["str_img"]:'') ?>
					Cost</a>
				</td>	

				<td class="proft_td" style="display:none" id="hrow17"></td>	
				<td class="roi_td" style="display:none" id="hrow18"></td>

			</tr>
		</table>
	</div>

	<div class="body-container">
		<script>hideTablePreload()</script>
		<table class="table_stat camps_table" cellspacing="0" width="100%">
			<tbody>
				<?php $sum_clicks=0;$sum_leads=0;$sum_rev=0;$sum_spend=0;$sum_offer_cl=0;$row_counter=0;
					foreach($arr_tpl["rows"] as $row) {$sum_clicks+=$row["clicks"];$sum_leads+=$row["leads"];$sum_rev+=$row["rev"];$sum_spend+=$row["spend"];$sum_offer_cl+=$row["off_cl"];?>

					<?php $row_counter++;?>

					<tr id="land_<?php echo $row['id'] ?>" class="table_stat_tr tr_profit_2 visible_row <?php echo ($row_counter % 2 == 1?'gray_row':'')?>" 
					ondblclick="edit(<?php echo $row['id'] ?>)"
					onclick="hide_button(this,'<?php echo $row['status'] ?>');" data-id="<?php echo $row['id'] ?>"> 
						<input type="hidden" name="id" value="<?php echo $row['id'] ?>">
						<input type="hidden" name="name" value="<?php echo str_replace("'","\'",$row['name']) ?>">
						<input type="hidden" name="url" value="<?php echo $row['url'] ?>">
						<input type="hidden" name="status" value="<?php echo $row['status'] ?>">
						<input type="hidden" name="lang" value="<?php echo $row['lang'] ?>">
						<input type="hidden" name="group_lp" value="<?php echo $row['group_id'] ?>">
						<input type="hidden" name="offers_lp" value="<?php echo $row['offers'] ?>">
						<input type="hidden" name="tlp_type" value="<?php echo $row['type'] ?>">
						
						<td class="id_td">
							<div class="checkbox_group">
								<input type="checkbox" class="check_land" name="check_land" id="check<?php echo $row['id']?>"><label for="check<?php echo $row['id'] ?>"><?php echo $row['id'] ?></label>
							</div>
						</td>
						
						<td class="name_td name_camp">
							<span><?php echo $row['name'] ?></span>
							<span style="color: #aaa;">
								<?php echo ($row['lang']=='0'?'none':$row['lang']) ?>
							</span>
							<?php echo ($row['note']==0 ? "" : '<img style="margin-left:4px;" width="9px" src="templates/standart/images/green-star.png">') ?>
					
						</td>
						<td class="group_td">
							<?php echo ($row['group_id']=="0"?"":$row['group_name']) ?>
						</td>
						<td class="url_td table_td_info">
							<input tyle="text" class="table_link" readonly value="<?php echo $row['url'] ?>">
						</td>
						<td class="clh_td table_td_info loading" id="clh_<?php echo $row['id'] ?>">
							<img style="width: 40px;" src="templates/standart/images/loading.GIF">
						</td>
						
						<td class="llh_td loading" style="display:none" id="llh_<?php echo $row['id'] ?>"></td>
						<td class="plh_td loading" style="display:none" id="plh_<?php echo $row['id'] ?>"></td>
						<td class="lastlead_td" style="display:none" id="last_lead_'<?php echo $row['id'] ?>"></td>
						
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
						
						<td  class="leads_td " style="display:none"></td>						
						<td  class="cr_td " style="display:none"></td>
						<td  class="epc_td " style="display:none"></td>
						
						<td  class="cpc_td table_td_stat">
							$<?php echo $row['CPC'] ?>
						</td>
						
						<td  class="revenue_td" style="display:none"></td>
						
						<td  class="cost_td table_td_stat">
							$<?php echo $row['spend'] ?>
						</td>
						<td class="profit_td" style="display:none"></td>
						<td class="roi_td" style="display:none"></td>
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
					<td id="frow4" class="table_td_info"></td>
					<td id="frow5" class="table_td_info"></td>
					<td id="frow6" style="display:none"></td>
					<td id="frow7" style="display:none"></td>
					<td id="frow8" style="display:none"></td>
					<td id="frow9" class="clicks_td">
						<?php echo number_format($sum_clicks) ?>
					</td>
					<td id="frow10"  class="lpctr_td table_td_stat">
						<?php echo ($sum_clicks>0?number_format((($sum_offer_cl / $sum_clicks)*100),2):0) ?>%
					</td>
					<td id="frow11" style="display:none" class="leads_td"></td>
					<td id="frow12" style="display:none" class="cr_td"></td>
					<td id="frow13" style="display:none" class="epc_td"></td>
					
					<td id="frow14"  class="cpc_td table_td_stat">
						$<?php echo ($sum_clicks>0?number_format(($sum_spend / $sum_clicks),4):0) ?>
					</td>
					
					<td id="frow15" style="display:none" class="revenue_td"></td>
					
					<td id="frow16"  class="cost_td table_td_stat">
						$<?php echo number_format($sum_spend,2) ?>
					</td>
					<td id="frow17" class="profit_td" style="display:none"></td>
					<td id="frow18" class="roi_td" style="display:none"></td>
				</tr>
			</table>
	</div>
</div>