<div class="analisys_block">
	<h3>Binom <?php echo $arr_tpl['version_name'];?></h3>
	<table class="a_table_1">
		<tr>
			<td>
				<p>Product Name:</p>
			</td>
			<td>
				<p><?php echo $arr_tpl['name'];?></p>
			</td>
		<tr>
		</tr>
			<td>
				<p>Product Version:</p>
			</td>
			<td>
				<p><?php echo $arr_tpl['version'];?></p>
			</td>
		<tr>
		</tr>
			<td>
				<p>Install update date:</p>
			</td>
			<td>
				<p><?php echo date('d-m-Y G:i:s',(int)$arr_tpl['date_update']);?></p> 
			</td>
		<tr>
		</tr>
			<td>
				<p>License key:</p>
			</td>
			<td>
				<p><?php echo $arr_tpl['lic_key'];?></p>
			</td>
		</tr>
		</tr>
			<td>
				<a  style="margin-top:10px;display: block;"class="green-button" href="?page=full_exit">Full Exit</a>
			</td>
			<td>
			</td>
		</tr>
	</table>
</div>
<div class="analisys_block">	
	<h3>Current Info<input id="astat_2_check" type="checkbox"/></h3>
	<div id="astat_2" style="margin-top:10px;">
	
	</div>
	<div class="clear"></div>
</div>
<div class="analisys_block">	
		<h3>SQL</h3>
		<div class="a_sql">
			<table>
				<tr>
					<td>
						<p>SQL:</p>
					</td>
					<td>
						<textarea id="a_sql_text" style="width:700px;height:50px;"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<p>Type:</p>
					</td>
					<td>
						<select id="a_sql_type">
							<option value="1">select</option>
							<option value="2">select_res</option>
							<option value="3">i_d</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<a style="margin-top: 15px;display: block;" class="green-button" onclick="asql_send()">Send</a>
					</td>
					<td>
						
					</td>
				</tr>
			</table>
			<p>SQL Load:</p>
			<div id="asql_send_load">
				No SQL
			</div>
		</div>
</div>
<div class="analisys_block">	
	<h3>Procedure</h3>
		<div class="a_actions">
			<a class="green-button" onclick="astop(1)">Stop Process #1</a>
			<a class="green-button" onclick="arestart(1)">Restart Process #1</a>
		</div>
		<div class="a_actions">
			<a class="green-button" onclick="astop(2)">Stop Process #2</a>
			<a class="green-button" onclick="arestart(2)">Restart Process #2</a>
		</div>
		<div class="a_actions">
			<a class="green-button" onclick="astop(3)">Stop Process #3</a>
			<a class="green-button" onclick="arestart(3)">Restart Process #3</a>
		</div>
		<div class="a_actions">
			<a class="green-button" onclick="astop(4)">Stop Process #4</a>
			<a class="green-button" onclick="arestart(4)">Restart Process #4</a>
		</div>
		<div class="a_actions">
			<a class="green-button" onclick="astop(5)">Stop Process #5</a>
			<a class="green-button" onclick="arestart(5)">Restart Process #5</a>
		</div>
</div><div class="analisys_block">	
	<h3>Speed Settings</h3>
	<form id="events_form">
	<table class="a_table_1" style="margin-bottom:10px;">
		<tr>
			<td>
				<p>Event Name:</p>
			</td>
			<td>
				<p>Interval</p>
			</td>
			<td>
				<p>Field</p>
			</td>
		<tr>
	<?php 
		while($event=$arr_tpl['events_res']->fetch()){
	?>
		<tr>
			<td>
				<p><?php echo $event['EVENT_NAME']; ?></p>
			</td>
			<td>
				<input type="hidden" name="type" value="aevent"> 
				<input type="hidden" name="ajax" value="1"> 
				<input type="hidden" name="ajax_type" value="write"> 
				<input type="hidden" name="event[]" value="<?php echo $event['EVENT_NAME']; ?>"> 
				<input type="text" name="interval[]" value="<?php echo $event['INTERVAL_VALUE']; ?>"> 
			</td>
			<td>
				<input type="text" name="field[]" value="<?php echo $event['INTERVAL_FIELD']; ?>"> 
			</td>
		<tr>	
	<?php 
		}
	?>
	</table>
	<a class="green-button" onclick="aevent()">Save</a>
</div>
<div class="analisys_block">	
	<h3>Processes List<input id="astat_3_check" type="checkbox" checked></h3>
	<div id="astat_3" style="margin-top:10px;">
	
	</div>
	<div class="clear"></div>
</div>