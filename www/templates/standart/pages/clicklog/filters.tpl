<div class="window" id="win_cl_filter" style="display: none; width: 536px; height: 570px;">
	<a onclick="notewindow_hide(this);" class="win_closebtn"></a>
	<div class="win_header">
		<span class="window_head_name">Filters</span>
	</div>
	<div class="win_cap ">
						
	</div>
	<div class="win_content filter_win_style" style="margin: 10px 12px 15px 15px !important;">
		<form action="" class="filter-form" id="filter_form" method="post">
			<input type="hidden" name="type" value="filters_clicklog_save">
			<input type="hidden" name="ajax" value="1">
			<input type="hidden" name="ajax_type" value="write">
			<div class="filter-rows-container">
				<div id="first_element" class="filter-row row_0">
					<select type="select" class="filter_group_name" style="width:150px;" name="filter_column[]">
						
					</select>
					<select class="filter_compare_type" name="filter_compare[]">
						<option value="1" style="display: block;">=</option>
						<option value="2" style="display: block;">&lt;&gt;</option>
						<option value="3" style="display: block;">&gt;</option>
						<option value="4" style="display: block;">&gt;=</option>
						<option value="5" style="display: block;">&lt;</option>
						<option value="6" style="display: block;">&lt;=</option>
						<option value="7" style="display: block;">IN</option>
						<option value="8" style="display: block;">NOT IN</option>
					</select>
					<input type="text" name="filter_value[]"  class="input filter_value" style="width: 190px!important; font-size: 14px;border-color: #aaa;height:25px;padding-left: 7px;border: 1px solid #aaa;background-color: #fff;border-radius: 5px;">
				</div>
			</div>
			<div class="filter-middle-block" style="margin-bottom: 50px;">
				<a class="button green-button add_condition_button" style="font-size: 14px; top: 5px;position: relative;" id="addlist_btn">
					Add condition
				</a> 
				<span class="filter-condition-descr">
					<i>
						There is operator <b>AND</b> between conditions!
						<i></i>
					</i>
				</span>
			</div>
		</form>
	</div>
	<div class="win_footer ">
		<div class="win-buttons-block">
			<a class="button win-save-button filter-button" id="save_filter">
				<img src="templates/standart/images/w-save.png" class="icon save_icon">
				Apply
			</a>
			<a class="button win-close-button" onclick="notewindow_hide2(this);">
				<img src="./templates/standart/images/w-close.png" class="icon close_icon">
				Close
			</a>
		</div>
	</div>
</div>