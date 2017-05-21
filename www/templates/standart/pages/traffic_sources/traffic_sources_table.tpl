<div class="stat-container">
	<div class="header-container">
		<table class="stat_header">
			<tr>
				<td class="id_td" id="hrow1">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['1'] ?>">
						<?php echo ($arr_tpl['order']==1?$arr_tpl["str_img"]:'') ?>
					id</a>
				</td>	
				
				<td class="name_td source_name_td" id="hrow2">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['2'] ?>">
						<?php echo ($arr_tpl['order']==2?$arr_tpl["str_img"]:'') ?>
					Name</a>
				</td>
				
				<td class="tokens_td" id="hrow3">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['16'] ?>">
						<?php echo ($arr_tpl['order']==16?$arr_tpl["str_img"]:'') ?>
					Tokens</a>
				</td>

				<td class="camps_td" id="hrow4">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['3'] ?>">
						<?php echo ($arr_tpl['order']==3?$arr_tpl["str_img"]:'') ?>
					Campaigns</a>
				</td>
				
				<td class="clh_td table_td_info" id="hrow5">
					<b>CLH</b>
				</td>	
				<td class="llh_td table_td_info" id="hrow6">
					<b>LLH</b>
				</td>	
				<td class="plh_td table_td_info" id="hrow7">
					<b>PLH</b>
				</td>	
				<td class="lastlead_td table_td_info" id="hrow8">
					<b>Last lead</b>
				</td>	
				
				<td class="clicks_td" id="hrow9">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['6'] ?>">
						<?php echo ($arr_tpl['order']==6?$arr_tpl["str_img"]:'') ?>
					Clicks</a>
				</td>								
				<td class="leads_td table_td_stat" id="hrow10">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['8'] ?>">
						<?php echo ($arr_tpl['order']==8?$arr_tpl["str_img"]:'') ?>
					Leads</a>
				</td>							
				<td class="cr_td table_td_stat" id="hrow11">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['9'] ?>">
						<?php echo ($arr_tpl['order']==9?$arr_tpl["str_img"]:'') ?>
					CR</a>
				</td>							
				<td class="epc_td table_td_stat" id="hrow12">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['10'] ?>">
						<?php echo ($arr_tpl['order']==10?$arr_tpl["str_img"]:'') ?>
					EPC</a>
				</td>							
				<td class="cpc_td table_td_stat" id="hrow13">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['11'] ?>">
						<?php echo ($arr_tpl['order']==11?$arr_tpl["str_img"]:'') ?>
					CPC</a>
				</td>							
				<td class="revenue_td table_td_stat" id="hrow14" >
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['12'] ?>">
						<?php echo ($arr_tpl['order']==12?$arr_tpl["str_img"]:'') ?>
					Revenue</a>
				</td>							
				<td class="cost_td table_td_stat" id="hrow15">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['13'] ?>">
						<?php echo ($arr_tpl['order']==13?$arr_tpl["str_img"]:'') ?>
					Cost</a>
				</td>							
				<td class="proft_td" id="hrow16">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['14'] ?>">
						<?php echo ($arr_tpl['order']==14?$arr_tpl["str_img"]:'') ?>
					Profit</a>
				</td>							
				<td class="roi_td" id="hrow17">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['15'] ?>">
						<?php echo ($arr_tpl['order']==15?$arr_tpl["str_img"]:'') ?>
					ROI</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="body-container">
		<script>hideTablePreload()</script>
		<table class="table_stat camps_table noncheckbox_table" cellspacing="0" width="100%">
	
			<tbody>
				<?php $sum_clicks=0;$sum_leads=0;$sum_rev=0;$sum_spend=0;$row_counter=0;
					foreach($arr_tpl["rows"] as $row) { $sum_clicks+=$row["clicks"];$sum_leads+=$row["cnt_cnv"];$sum_rev+=$row["summ_cnv"];$sum_spend+=$row["Spend"]?>

					<?php $row_counter++;?>

					<tr id="ts_<?php echo $row['id'] ?>" class="table_stat_tr 
						<?php echo ($row['status']!=='1'?' camp_inactive':'') ?>
						<?php if ($row['profit']>0){
							echo 'tr_profit_1';
							}else if($row['profit']==0){
							 echo 'tr_profit_2';
							}else{
							echo 'tr_profit_3';
							}?> visible_row <?php echo ($row_counter % 2 == 1?'gray_row':'')?>"

						ondblclick="edit(this);" onclick="hide_button(this,'<?php echo $row['status'] ?>', '<?php echo $row['camps'] ?>') ;"
						data-id="<?php echo $row['id'] ?>"> 
						<input type="hidden" name="id" value="<?php echo $row['id'] ?>">
							<input type="hidden" name="name" value="<?php echo str_replace("'","\'",$row['name']) ?>"> 
							<input type="hidden" name="status" value="<?php echo $row['status'] ?>">
							<input type="hidden" name="tokens" value="<?php echo $row['tokens'] ?>">
							<input type="hidden" name="postback_url" value="<?php echo $row['postback_url'] ?>">
							<input type="hidden" name="e_name" value="<?php echo $row['e_name'] ?>">
							<input type="hidden" name="e_value" value="<?php echo $row['e_value'] ?>">
						<td class="id_td">
							<?php echo $row['id'] ?>
						</td>
						<td class="name_td source_name_td name_camp">
							<span><?php echo $row['name'] ?></span>
						</td>
						<td class="tokens_td">
							<?php echo ($row['tokens']=='1'?"Yes":"No") ?>
						</td>
						<td class="camps_td">
							<?php echo $row['camps'] ?>
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
						<td  class="leads_td table_td_stat">
							<?php echo $row['cnt_cnv'] ?>
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
							$<?php echo $row['summ_cnv'] ?>
						</td>
						<td  class="cost_td table_td_stat">
							$<?php echo $row['Spend'] ?>
						</td>
						<td class="profit_td <?php 
												if($row['profit']>0){
													echo 'color_stat_1';
												}else if ($row['profit']==0){
													echo 'color_stat_2';
												}else{
													echo 'color_stat_3';
												}
												 ?>
						">
							<?php echo (strrchr(strval($row['profit']), '-')?str_replace('-','-$',$row['profit']):'$'.$row['profit']) ?>
						</td>
						<td class="roi_td <?php 
											if($row['profit']>0){
												echo 'color_stat_1';
											}else if ($row['profit']==0){
												echo 'color_stat_2';
											}else{
												echo 'color_stat_3';
											}
											?> 
						">
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
					<td id="frow2" ></td>
					<td id="frow3" ></td>
					<td id="frow4" ></td>
					<td id="frow5" class="table_td_info"></td>
					<td id="frow6" class="table_td_info"></td>
					<td id="frow7" class="table_td_info"></td>
					<td id="frow8" class="table_td_info"></td>
					<td id="frow9" class="clicks_td">
						<?php echo number_format($sum_clicks) ?>
					</td>
					<td id="frow10"  class="leads_td table_td_stat">
						<?php echo number_format($sum_leads) ?>
					</td>
					<td id="frow11"  class="cr_td table_td_stat">
						<?php echo ($sum_clicks>0?number_format((($sum_leads  / $sum_clicks)*100),2):0)?>%
					</td>
					<td id="frow12"  class="epc_td table_td_stat">
						$<?php echo ($sum_clicks>0?number_format(($sum_rev / $sum_clicks),4):0) ?>
					</td>
					<td id="frow13"  class="cpc_td table_td_stat">
						$<?php echo ($sum_clicks>0?number_format(($sum_spend / $sum_clicks),4):0) ?>
					</td>
					<td id="frow14"  class="revenue_td table_td_stat">
						$<?php echo number_format($sum_rev,2) ?>
					</td>
					<td id="frow15"  class="cost_td table_td_stat">
						$<?php echo number_format($sum_spend,2) ?>
					</td>
					<td id="frow16" class="profit_td <?php if(($sum_rev-$sum_spend)>0){
															echo 'color_stat_1';
															}else if(($sum_rev-$sum_spend)==0){
															echo 'color_stat_2';
															}else{
															echo 'color_stat_3';} ?>">
						<?php echo (strrchr(strval($sum_rev-$sum_spend), '-')?str_replace('-','-$',number_format(($sum_rev-$sum_spend),4)):'$'.number_format(($sum_rev-$sum_spend),4)) ?>
					</td>
					<td id="frow17" class="roi_td <?php if(($sum_rev-$sum_spend)>0){
															echo 'color_stat_1';
															}else if(($sum_rev-$sum_spend)==0){
															echo 'color_stat_2';
															}else{
															echo 'color_stat_3';} ?>">
						<?php echo ($sum_spend>0?number_format(((($sum_rev - $sum_spend) / $sum_spend) * 100),2):0) ?>%
					</td>
				</tr>
			</table>
	</div>

	<script>
	
	</script>
	
</div>