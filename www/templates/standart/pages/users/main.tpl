<div class="perms_panel">
   
</div>

<div class="top_block">
	<div class="block_button" style="margin-bottom:7px">
		<button class='green-button add_user_button'><img src="templates/standart/images/w-add.png" class="icon add_icon">Add User</button>
		<button class='button_inactive edit_button edit_user_button' disabled><img src="templates/standart/images/w-edit3.png" class="icon edit_icon">Edit</button>
		<button class='button_inactive clone_user_button' disabled><img src="templates/standart/images/w-copy.png" class="icon copy_icon">Clone</button>
		<button class='button_inactive delete_user_button' disabled><img src="templates/standart/images/b-delete.png" class="icon delete_icon">Delete</button>
	</div>

	<div class="filter_block">
		<form id="act-form" method="get" action>
			<input type="hidden" name="page" value="Users">
			<select name="date" id="date_filter" onchange="enter_date_statistics(this);" style="width:200px;">
				'<?php echo $arr_tpl['date_html'] ?>'
			</select>						
			<div id="custom_date" style="display: none;">
				<input type="text" name="date_s" class="blocked_minutes" value="<?php echo $arr_tpl['date_s'] ?>" id="custom_date_pol1">
				<font> - </font>
				<input type="text" name="date_e" class="blocked_minutes" value="<?php echo $arr_tpl['date_e'] ?>" id="custom_date_pol2">
			</div>
			<a onclick="submitForm();" class="blue-button" id="refresh-btn"><img src="templates/standart/images/w-refresh.png" class="icon">Refresh</a>
		</form>
	</div>
</div>

<script src='templates/standart/js/tokenize-perms.js'></script>
<!--<div class="stat-container campaigns-stats-table">-->
<div class="stat-container users-stats-table">
	<div class="header-container">
		<table class="stat_header">
			<tr>

				<td class="id_td" id="hrow1">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['1'] ?>">
						<?php echo ($arr_tpl['order']==1?$arr_tpl["str_img"]:'') ?>
					id</a>
				</td>
					
				<td class="name_td" id="hrow2">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['3'] ?>">
						<?php echo ($arr_tpl['order']==3?$arr_tpl["str_img"]:'') ?>
					Login</a>
				</td>
				<td class="id_td" id="hrow3">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['2'] ?>">
						<?php echo ($arr_tpl['order']==2?$arr_tpl["str_img"]:'') ?>
					Role</a>
				</td>
				<td class="clicks_td" id="hrow4">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['4'] ?>">
						<?php echo ($arr_tpl['order']==4?$arr_tpl["str_img"]:'') ?>
					Clicks</a>
				</td>
				<td class="lpctr_td table_td_stat" id="hrow5">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['5'] ?>">
						<?php echo ($arr_tpl['order']==5?$arr_tpl["str_img"]:'') ?>
					LP CTR</a>
				</td>
				<td class="leads_td table_td_stat" id="hrow6">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['6'] ?>">
						<?php echo ($arr_tpl['order']==6?$arr_tpl["str_img"]:'') ?>
					Leads</a>
				</td>	
				<td class="cr_td table_td_stat" id="hrow7">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['7'] ?>">
						<?php echo ($arr_tpl['order']==7?$arr_tpl["str_img"]:'') ?>
					CR</a>
				</td>
				<td class="epc_td table_td_stat" id="hrow8">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['8'] ?>">
						<?php echo ($arr_tpl['order']==8?$arr_tpl["str_img"]:'') ?>
					EPC</a>
				</td>	
				<td class="cpc_td table_td_stat" id="hrow9">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['9'] ?>">
						<?php echo ($arr_tpl['order']==9?$arr_tpl["str_img"]:'') ?>
					CPC</a>
				</td>	
				<td class="revenue_td table_td_stat" id="hrow10" >
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['10'] ?>">
						<?php echo ($arr_tpl['order']==10?$arr_tpl["str_img"]:'') ?>
					Revenue</a>
				</td>	
				<td class="cost_td table_td_stat" id="hrow11">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['11'] ?>">
						<?php echo ($arr_tpl['order']==11?$arr_tpl["str_img"]:'') ?>
					Cost</a>
				</td>	
				<td class="proft_td" id="hrow12">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['12'] ?>">
						<?php echo ($arr_tpl['order']==12?$arr_tpl["str_img"]:'') ?>
					Profit</a>
				</td>	
				<td class="roi_td" id="hrow13">
					<a class="sort_link" href="<?php echo $arr_tpl["order_arr"]['13'] ?>">
						<?php echo ($arr_tpl['order']==13?$arr_tpl["str_img"]:'') ?>
					ROI</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="body-container" style="height:auto;">
		<!--<table class="table_stat camps_table" cellspacing="0" width="100%">-->
		<table class="table_stat users_table noncheckbox_table" cellspacing="0" width="100%">
		<?php 
		if(!empty($arr_tpl['users'])){
		foreach($arr_tpl['users'] as $key=>$user){ ?>
			
			<tr onclick="hide_button(this);" ondblclick="usersPanel.editUser(<?php echo $user['id']; ?>)" data-user-id="<?php echo $user['id']; ?>" class="table_stat_tr 
				<?php
					if ($user['profit']>0){
						echo 'tr_profit_1';
					}else if($user['profit']==0){
						echo 'tr_profit_2';
					}else{
						echo 'tr_profit_3';
					}
				?>"> 
				
				<td class="id_td">
					<div class="checkbox_group">
						<?php echo $user['id'] ?>
					</div>
				</td>
				
				<td class="name_td name_camp"><span><?php echo $user['login'] ?></span>
				</td>
				<td class="role_td"><?php if ($user['user_group']==1){
						echo 'Administrator';
					} else if ($user['user_group']==2){
						echo 'User';
					} else {
						echo 'Auditor';
					} ?></td>
				<td class="clicks_td">
					<?php echo $user['clicks'] ?>
				</td>
				<td class="lpctr_td table_td_stat">
					<?php echo $user['LP_CTR'] ?>%
					<div class="offer_clicks_hide" style="display:none;">
						<?php echo $user['off_cl'] ?>
					</div>
					<div class="landing_clicks_hide" style="display:none;">
						<?php echo $user['lp_cl'] ?>
					</div>
				</td>
				<td  class="leads_td table_td_stat">
					<?php echo $user['leads'] ?>
				</td>
				<td  class="cr_td table_td_stat">
					<?php echo $user['CR'] ?>%
				</td>

				<td  class="epc_td table_td_stat">
					$<?php echo $user['EPC'] ?>
				</td>

				<td  class="cpc_td table_td_stat">
					$<?php echo $user['CPC'] ?>
				</td>
				<td  class="revenue_td table_td_stat">
					$<?php echo $user['rev'] ?>
				</td>
				<td  class="cost_td table_td_stat">
					$<?php echo $user['spend'] ?>
				</td>
				<td class="profit_td <?php 
										if($user['profit']>0){
											echo 'color_stat_1';
										}else if ($user['profit']==0){
											echo 'color_stat_2';
										}else{
											echo 'color_stat_3';
										}
										 ?>
				">
					<?php echo (strrchr(strval($user['profit']), '-')?str_replace('-','-$',$user['profit']):'$'.$user['profit']) ?>
				</td>
				<td class="roi_td <?php 
									if($user['profit']>0){
										echo 'color_stat_1';
									}else if ($user['profit']==0){
										echo 'color_stat_2';
									}else{
										echo 'color_stat_3';
									}
									?> 
				">
					<?php echo $user['ROI'] ?>%
				</td>
			</tr>
		<?php } }?>
		</table>
	</div>
</div>