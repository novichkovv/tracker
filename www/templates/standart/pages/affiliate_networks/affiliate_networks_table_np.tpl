<div class="stat-container">
	<div class="header-container">
		<table class="stat_header">
			<tr>
				<td class="id_td" id="hrow1">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['1'] ?>">
						<?php echo ($arr_tpl['order']==1?$arr_tpl["str_img"]:'') ?>
					id</a>
				</td>	
				
				<td class="name_td" id="hrow2">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['2'] ?>">
						<?php echo ($arr_tpl['order']==2?$arr_tpl["str_img"]:'') ?>
					Name</a>
				</td>
				
				<td class="offers_td" id="hrow3">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['3'] ?>">
						<?php echo ($arr_tpl['order']==3?$arr_tpl["str_img"]:'') ?>
					Offers</a>
				</td>
				
				<td class="clh_td table_td_info" id="hrow4">
					<b>CLH</b>
				</td>	
				
				<td class="llh_td " style="display:none" id="hrow5"></td>	
				<td class="plh_td " style="display:none" id="hrow6"></td>	
				<td class="lastlead_td " style="display:none" id="hrow7"></td>	
				
				<td class="clicks_td" id="hrow8">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['6'] ?>">
						<?php echo ($arr_tpl['order']==6?$arr_tpl["str_img"]:'') ?>
					Clicks</a>
				</td>								
				<td class="leads_td " style="display:none" id="hrow9"></td>							
				<td class="cr_td " style="display:none" id="hrow10"></td>							
				<td class="epc_td " style="display:none" id="hrow11"></td>			
				
				<td class="cpc_td table_td_stat" id="hrow12">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['11'] ?>">
						<?php echo ($arr_tpl['order']==11?$arr_tpl["str_img"]:'') ?>
					CPC</a>
				</td>	
				
				<td class="revenue_td " style="display:none" id="hrow13" ></td>	
				
				<td class="cost_td table_td_stat" id="hrow14">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['13'] ?>">
						<?php echo ($arr_tpl['order']==13?$arr_tpl["str_img"]:'') ?>
					Cost</a>
				</td>
				
				<td class="proft_td" style="display:none" id="hrow15"></td>							
				<td class="roi_td" style="display:none" id="hrow16"></td>
			</tr>
		</table>
	</div>

	<div class="body-container">
		<script>hideTablePreload()</script>
		<table class="table_stat camps_table noncheckbox_table" cellspacing="0" width="100%">
	
			<tbody>
				<?php $sum_clicks=0;$sum_leads=0;$sum_rev=0;$sum_spend=0;$row_counter=0;
					foreach($arr_tpl["rows"] as $row) { $sum_clicks+=$row["clicks"];$sum_leads+=$row["cnt_cnv"];$sum_rev+=$row["summ_cnv"];$sum_spend+=$row["spend"]?>

					<?php $row_counter++;?>

					<tr id="network_<?php echo $row['id'] ?>" class="table_stat_tr 
					<?php echo ($row['status']!=='1'?' camp_inactive':'') ?>
					<?php if ($row['profit']>0){
								echo 'tr_profit_1';
							}else if($row['profit']==0){
								 echo 'tr_profit_2';
							}else{
								echo 'tr_profit_3';
						}?> visible_row <?php echo ($row_counter % 2 == 1?'gray_row':'')?>
					" ondblclick="edit(<?php echo $row['id'] ?>);" onclick="hide_button(this,'<?php echo $row['status'] ?>');"> 
						<input type="hidden" name="id" value="<?php echo $row['id']?>">
						<input type="hidden" name="name" value="<?php echo $row['name']?>"> 
						<input type="hidden" name="status" value="<?php echo $row['status']?>">
						<td class="id_td">
							<?php echo $row['id'] ?>
						</td>
						<td class="name_td name_camp">
							<span><?php echo $row['name'] ?></span>
						</td>
						<td class="offers_td">
							<?php echo $row['offers'] ?>
						</td>
						<td class="clh_td table_td_info loading" id="clh_<?php echo $row['id'] ?>">
							<img style="width: 40px;" src="templates/standart/images/loading.GIF">
						</td>
						
						<td class="llh_td  loading" style="display:none"  id="llh_<?php echo $row['id'] ?>"></td>
						<td class="plh_td  loading" style="display:none"  id="plh_<?php echo $row['id'] ?>"></td>
						<td class="lastlead_td " style="display:none" id="last_lead_'<?php echo $row['id'] ?>"></td>
						
						<td class="clicks_td">
							<?php echo $row['clicks'] ?>
						</td>
						
						<td  class="leads_td " style="display:none"></td>
						<td  class="cr_td " style="display:none"></td>
						<td  class="epc_td " style="display:none"></td>
						
						<td  class="cpc_td table_td_stat">
							$<?php echo $row['CPC'] ?>
						</td>
						
						<td  class="revenue_td " style="display:none"></td>
						
						<td  class="cost_td table_td_stat">
							$<?php echo $row['spend'] ?>
						</td>
						
						<td class="profit_td color_stat_2"  style="display:none"></td>
						<td class="roi_td color_stat_2" style="display:none"></td>
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
					<td id="frow5" style="display:none" class=""></td>
					<td id="frow6" style="display:none" class=""></td>
					<td id="frow7" style="display:none" class=""></td>
					<td id="frow8" class="clicks_td">
						<?php echo number_format($sum_clicks) ?>
					</td>
					<td id="frow9"  class="leads_td " style="display:none"></td>
					<td id="frow10"  class="cr_td " style="display:none"></td>
					<td id="frow11"  class="epc_td " style="display:none"></td>
					<td id="frow12"  class="cpc_td table_td_stat">
						$<?php echo ($sum_clicks>0?number_format(($sum_spend / $sum_clicks),4):0) ?>
					</td>
					<td id="frow13"  class="revenue_td " style="display:none"></td>
					<td id="frow14"  class="cost_td table_td_stat">
						$<?php echo number_format($sum_spend,2) ?>
					</td>
					<td id="frow15" class="profit_td color_stat_2" style="display:none"></td>
					<td id="frow16" class="roi_td color_stat_2" style="display:none"></td>
				</tr>
			</table>
	</div>

	<script>
	
	</script>
	
</div>