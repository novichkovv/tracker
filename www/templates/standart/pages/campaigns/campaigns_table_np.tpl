<div class="stat-container campaigns-stats-table">
	<div class="header-container">
		<table class="stat_header">
			<tr>
				<td class="id_td" id="hrow1">
					<div class="checkbox_group">
						<input type="checkbox" class="check_camp_all" name="check_camp_all" id="check_all"><label for="check_all"></label>
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
				<td class="source_td" id="hrow4">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['5'] ?>">
						<?php echo ($arr_tpl['order']==5?$arr_tpl["str_img"]:'') ?>
					Traffic Source</a>
				</td>
				<td class="start_td table_td_info" id="hrow5">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['16'] ?>">
						<?php echo ($arr_tpl['order']==16?$arr_tpl["str_img"]:'') ?>
						Start Date
					</a>
				</td>
				<td class="url_td table_td_info" id="hrow6">
					<a>
						<b>URL</b>
					</a>
				</td>
				<td class="cpc_td table_td_info" id="hrow7">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['24'] ?>">
						<b><?php echo ($arr_tpl['order']==24?$arr_tpl["str_img"]:'') ?> Current CPC</b>
					</a>
				</td>
				<td class="clh_td table_td_info" id="hrow8">
					<b>CLH</b>
				</td>	
				
				<td class="llh_td" id="hrow9" style="display:none"></td>	
				<td class="plh_td" id="hrow10" style="display:none"></td>	
				<td class="lastlead_td" id="hrow11" style="display:none"></td>
				
				<td class="clicks_td" id="hrow12">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['6'] ?>">
						<?php echo ($arr_tpl['order']==6?$arr_tpl["str_img"]:'') ?>
					Clicks</a>
				</td>

				<td class="lpctr_td table_td_stat" id="hrow13">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['23'] ?>">
						<?php echo ($arr_tpl['order']==23?$arr_tpl["str_img"]:'') ?>
					LP CTR</a>
				</td>

				<td class="leads_td" id="hrow14" style="display:none"></td>	
				<td class="cr_td" id="hrow15" style="display:none"></td>
				<td class="epc_td" id="hrow16" style="display:none"></td>

				<td class="cpc_td table_td_stat" id="hrow17">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['11'] ?>">
						<?php echo ($arr_tpl['order']==11?$arr_tpl["str_img"]:'') ?>
					CPC</a>
				</td>	
				
				<td class="revenue_td" id="hrow18"  style="display:none"></td>
				
				<td class="cost_td table_td_stat" id="hrow19">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['13'] ?>">
						<?php echo ($arr_tpl['order']==13?$arr_tpl["str_img"]:'') ?>
					Cost</a>
				</td>	

				<td class="proft_td" id="hrow20" style="display:none"></td>	
				<td class="roi_td" id="hrow21" style="display:none"></td>
			</tr>
		</table>
	</div>

	<div class="body-container">
        <script>hideTablePreload()</script>
		<table class="table_stat camps_table" cellspacing="0" width="100%">
			<tbody>
				<?php $sum_clicks=0;$sum_leads=0;$sum_rev=0;$sum_spend=0;$sum_offer_cl=0;$row_counter=0;
					foreach($arr_tpl["rows"] as $row) { $sum_clicks+=$row["clicks"];$sum_leads+=$row["leads"];$sum_rev+=$row["rev"];$sum_spend+=$row["spend"];$sum_offer_cl+=$row["off_cl"];?>

					<?php $row_counter++; ?>

					<tr class="table_stat_tr tr_profit_2 visible_row <?php echo ($row_counter % 2 == 1?'gray_row':'')?>" 
					ondblclick="open_stat(<?php echo $row['id']?>,this);" onclick="hide_button(<?php echo $row['id']?>, this, <?php echo $row['status']?>, event.target);"> 

						<td class="id_td">
							<div class="checkbox_group">
								<input type="checkbox" class="check_camp" name="check_camp" id="check<?php echo $row['id']?>"><label for="check<?php echo $row['id'] ?>"><?php echo $row['id'] ?></label>
							</div>
						</td>
						<td class="name_td name_camp"><span><?php echo $row['name'] ?></span><?php echo ($row["note"]?"<img style='margin-left:4px;' width='9px' src='templates/standart/images/green-star.png' />":"") ?>
						</td>
						<td class="group_td">
							<?php echo ($row['group_id']=="0"?"":$row['group_name']) ?>
						</td>
						<td class="source_td">
							<?php echo $row['ts'] ?>
						</td>
						<td class="start_td table_td_info">
							<?php echo date('Y-m-d', $row['date_cr']) ?>
						</td>
						<td class="url_td table_td_info">
							<input tyle="text" class="table_link" readonly value="<?php echo $row['link'] ?>">
						</td>
						<td class="cpc_td table_td_info">
							<?php echo (($row['auto_cpc']==1) ? "auto" : "$".$row['current_cpc'])  ?>
						</td>
						<td class="clh_td table_td_info loading" id="clh_<?php echo $row['id'] ?>">
							<img style="width: 40px;" src="templates/standart/images/loading.GIF">
						</td>
						
						<td class="llh_td loading"  id="llh_<?php echo $row['id'] ?>" style="display:none"></td>
						<td class="plh_td loading"  id="plh_<?php echo $row['id'] ?>" style="display:none"></td>
						<td class="lastlead_td" id="last_lead_<?php echo $row['id'] ?>" style="display:none"></td>
						
						<td class="clicks_td">
							<?php echo $row['clicks'] ?>
						</td>
						<td class="lpctr_td table_td_stat">
							<?php echo $row['LP_CTR'] ?>%
							<div class="offer_clicks_hide" style="display:none;">
								<?php echo $row['off_cl'] ?>
							</div>
							<div class="landing_clicks_hide" style="display:none;">
								<?php echo $row['lp_cl'] ?>
							</div>
						</td>
						
						<td  class="leads_td" style="display:none"></td>
						<td  class="cr_td" style="display:none"></td>
						<td  class="epc_td" style="display:none"></td>

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
					<td id="frow4"></td>
					<td id="frow5" class="table_td_info"></td>
					<td id="frow6" class="table_td_info"></td>
					<td id="frow7" class="table_td_info"></td>
					<td id="frow8" class="table_td_info"></td>
					<td id="frow9" class="" style="display:none"></td>
					<td id="frow10" class="" style="display:none"></td>
					<td id="frow11" class="" style="display:none"></td>
					<td id="frow12" class="clicks_td">
						<?php echo number_format($sum_clicks) ?>
					</td>
					<td id="frow13"  class="lpctr_td table_td_stat">
						<?php echo ($sum_clicks>0?number_format((($sum_offer_cl / $sum_clicks)*100),2):0) ?>%
					</td>
					
					<td id="frow14"  class="leads_td " style="display:none"></td>
					<td id="frow15"  class="cr_td " style="display:none"></td>
					<td id="frow16"  class="epc_td " style="display:none"></td>
					
					<td id="frow17"  class="cpc_td table_td_stat">
						$<?php echo ($sum_clicks>0?number_format(($sum_spend / $sum_clicks),4):0) ?>
					</td>
					
					<td id="frow18"  class="revenue_td " style="display:none"></td>
					
					<td id="frow19"  class="cost_td table_td_stat">
						$<?php echo number_format($sum_spend,2) ?>
					</td>
					
					<td id="frow20" class="profit_td" style="display:none"></td>
					<td id="frow21" class="roi_td" style="display:none"></td>
				</tr>
			</table>
	</div>
</div>