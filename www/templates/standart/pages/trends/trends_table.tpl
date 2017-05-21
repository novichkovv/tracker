<div class="stat-container campaigns-stats-table trends-stats-table" >
	<div class="header-container">
		<table class="stat_header">
			<tr>
				<td class="name_td" id="hrow1">
					<b>Date</b>
				</td>		
				<td class="clicks_td" id="hrow2">
					<b>Clicks</b>
				</td>
				<td class="lpctr_td table_td_stat" id="hrow3">
					<b>LP CTR</b>
				</td>
				<td class="leads_td table_td_stat" id="hrow4">
					<b>Leads</b>
				</td>	
				<td class="cr_td table_td_stat" id="hrow5">
					<b>CR</b>
				</td>
				<td class="epc_td table_td_stat" id="hrow6">
					<b>EPC</b>
				</td>	
				<td class="cpc_td table_td_stat" id="hrow7">
					<b>CPC</b>
				</td>	
				<td class="revenue_td table_td_stat" id="hrow8" >
					<b>Revenue</b>
				</td>	
				<td class="cost_td table_td_stat" id="hrow9">
					<b>Cost</b>
				</td>	
				<td class="proft_td" id="hrow10">
					<b>Profit</b>
				</td>	

				<td class="roi_td" id="hrow11">
					<b>ROI</b>
				</td>
			</tr>
		</table>
	</div>

	<div class="body-container" style="min-height: 250px;">
		<table class="table_stat camps_table" cellspacing="0" width="100%">
		
			<tbody>
				<?php $sum_clicks=0;$sum_leads=0;$sum_rev=0;$sum_spend=0;$sum_offer_cl=0;
					foreach($arr_tpl["rows"] as $row) { $sum_clicks+=$row['clicks'];$sum_leads+=$row["leads"];$sum_rev+=$row["rev"];$sum_spend+=$row["spend"];$sum_offer_cl+=$row["off_cl"];
				?>
					<tr class="table_stat_tr  <?php if ($row['profit']>0){
								echo 'tr_profit_1';
							}else if($row['profit']==0){
								echo 'tr_profit_2';
							}else{
								echo 'tr_profit_3';
						}?>" 
					> 

						
						<td class="name_td name_camp"><span><?php echo $row['name'] ?></span></td>
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
							<?php 
							echo (strrchr(strval($row['profit']), '-')?str_replace('-','-$',$row['profit']):'$'.$row['profit'])
							?>
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
	</div>	

	<div class="footer-container">
		<table class="stat_footer">
			<tr> 
				<td id="frow1"></td>
				<td id="frow2" class="clicks_td">
					
				</td>
				<td id="frow3"  class="lpctr_td table_td_stat">
					
				</td>
				<td id="frow4"  class="leads_td table_td_stat">
					
				</td>
				<td id="frow5"  class="cr_td table_td_stat">
					
				</td>
				<td id="frow6"  class="epc_td table_td_stat">
					
				</td>
				<td id="frow7"  class="cpc_td table_td_stat">
					
				</td>
				<td id="frow8"  class="revenue_td table_td_stat">
					
				</td>
				<td id="frow9"  class="cost_td table_td_stat">
					
				</td>
				<td id="frow10" class="profit_td <?php if(($sum_rev-$sum_spend)>0){
														echo 'color_stat_1';
														}else if(($sum_rev-$sum_spend)==0){
														echo 'color_stat_2';
														}else{
														echo 'color_stat_3';} ?>">
					
				</td>
				<td id="frow11" class="roi_td <?php if(($sum_rev-$sum_spend)>0){
														echo 'color_stat_1';
														}else if(($sum_rev-$sum_spend)==0){
														echo 'color_stat_2';
														}else{
														echo 'color_stat_3';} ?>">

				</td>
			</tr>
		</table>
	</div>
</div>
 <script src="templates/standart/js/d3.min.js"></script>
<script src="templates/standart/js/c3.min.js"></script>


<!--<script src="templates/standart/js/echarts-all.js"></script>
<script src="templates/standart/js/echarts.js"></script>-->