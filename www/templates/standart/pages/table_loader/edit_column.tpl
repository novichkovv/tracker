<div class="window" id="win_edit_parameters" style="display: none; width: 510px; height: 655px; margin-top: 50px;">
	<a onclick="notewindow_hide(this);" class="win_closebtn"></a>
	<div class="win_header">
		<span class="window_head_name">Choose Parameters</span>
	</div>
	<div class="win_cap ">
		<div class="win_filter">
			<form autocomplete="off">
				<input type="text" onclick="this.placeholder=''" placeholder="Search" class="search_other" onblur="tryToReturnPlaceholderSearch(this);" id="prm_column_serach" style="margin-top:10px;width: 500px">
			</form>
		</div>
	</div>
	<form id="parameters_form">
	<input type="hidden" name="type" value="column_settings">
	<input type="hidden" name="ajax" value="1">
	<input type="hidden" name="ajax_type" value="write">
	<input type="hidden" name="page" value="<?php echo $_GET['page']; ?>">
	<div class="win_content lp_win_style list_window_style">
		<table id="edit_table_column" class="dop_table">
				<tr>
					<td>
						<span style="font-weight:600;margin-left: 25px;">Parameter</span>
					</td>
				</tr>
			<?php
				foreach($arr_tpl AS $key=>$column){
			?>
				<tr class="tr_edit_column" >
					<td>
						<div class="checkbox_group_edit_column">
							<input style="display:none;"  type="checkbox" name="<?php echo $key; ?>" id="check_<?php echo $key; ?>">
							<label style="width: 470px;display: block;margin-left: 25px;" for="check_<?php echo $key; ?>"><?php echo $column['name']; ?></label>
						</div>
					</td>
				</tr>
			<?php
				}
			?>
		</table>
	</div>
	</form>
	<div class="win_footer">			
		<div class="win-buttons-block" style="width: 130px;">
			<a id="win_button_save" class="button win-save-button" style="display:none;margin:0;" onclick=""><img src="templates/standart/images/w-save.png" class="icon save_icon">Save</a>
			<a id="win_button_close" style="margin:0;" class="button win-close-button" onclick="notewindow_hide2(this);"><img src="templates/standart/images/w-close.png" class="icon close_icon">Close</a>
		</div>
	</div>
</div>