<p><b>Server Time</b></p>
<p>MYSQL: <?php echo date('d-m-Y G:i:s',$arr_tpl['mysql_time']) ?></p>
<p>PHP: <?php echo date('d-m-Y G:i:s'); ?></p>
<p><b>Binom Processes</b></p>
<table class="a_table_2">
	<tr>
		<td style="width:150px;">
			Temp clicks:
		</td>
		<td style="width:200px;">
			<?php echo $arr_tpl['temp_clicks'] ?>
		</td>
		<td style="width:400px;">
			
		</td>
	</tr>
	<tr>
		<td>
			Temp table:
		</td>
		<td>
			<?php echo $arr_tpl['temp_table'] ?>
		</td>
		<td>
			
		</td>
	</tr>
	<tr>
		<td>
			Temp table 2:
		</td>
		<td>
			<?php echo $arr_tpl['temp_table_2'] ?>
		</td>
		<td>
			
		</td>
	</tr>
	<tr>
		<td>
			Process #1 status:
		</td>
		<td>
			<?php echo  ($arr_tpl['proc_1']==NULL?'Not in action':($arr_tpl['proc_1']==0?'Stop':'Load ('.date('d-m-Y G:i:s',(int)$arr_tpl['proc_1']).')')) ?>
		</td>
		<td>
			<?php echo 'AVG Time: '.$arr_tpl['avg_proc_1'].' s, MAX Time: '.$arr_tpl['max_proc_1'].' s' ?>
		</td>
	</tr>
	<tr>
		<td>
			Process #2 status:
		</td>
		<td>
			<?php echo  ($arr_tpl['proc_2']==NULL?'Not in action':($arr_tpl['proc_2']==0?'Stop':'Load ('.date('d-m-Y G:i:s',(int)$arr_tpl['proc_2']).')')) ?>
		</td>
		<td>
			<?php echo 'AVG Time: '.$arr_tpl['avg_proc_2'].' s, MAX Time: '.$arr_tpl['max_proc_2'].' s' ?>
		</td>
	</tr>
	<tr>
		<td>
			Process #3 status:
		</td>
		<td>
			<?php echo  ($arr_tpl['proc_3']==NULL?'Not in action':($arr_tpl['proc_3']==0?'Stop':'Load ('.date('d-m-Y G:i:s',(int)$arr_tpl['proc_3']).')')) ?>
		</td>
		<td>
			<?php echo 'AVG Time: '.$arr_tpl['avg_proc_3'].' s, MAX Time: '.$arr_tpl['max_proc_3'].' s' ?>
		</td>
	</tr>
	<tr>
		<td>
			Process #4 status:
		</td>
		<td>
			<?php echo  ($arr_tpl['proc_4']==NULL?'Not in action':($arr_tpl['proc_4']==0?'Stop':'Load ('.date('d-m-Y G:i:s',(int)$arr_tpl['proc_4']).')')) ?>
		</td>
		<td>
			<?php echo 'AVG Time: '.$arr_tpl['avg_proc_4'].' s, MAX Time: '.$arr_tpl['max_proc_4'].' s' ?>
		</td>
	</tr>
</table>
<p><b>MYSQL Stats</b></p>
<table class="a_table_2">
	<tr>
		<td>
			DB Size:
		</td>
		<td>
			<?php echo round(($arr_tpl['size_db']/1024),2).' Gb ('.round($arr_tpl['size_db'],0) ?> Mb)
		</td>
	</tr>
	<tr>
		<td>
			Report Tables:
		</td>
		<td>
			<?php echo $arr_tpl['sum_report'] ?>
		</td>
	</tr>
	<tr>
		<td>
			Report Tables Size:
		</td>
		<td>
			<?php echo round(($arr_tpl['size_db_report']/1024),2).' Gb ('.round($arr_tpl['size_db_report'],0) ?> Mb)
		</td>
	</tr>
	<tr>
		<td>
			Use RAM:
		</td>
		<td>
			<?php echo round(($arr_tpl['size_db_ram']/1024),2).' Gb ('.round($arr_tpl['size_db_ram'],0) ?> Mb)
		</td>
	</tr>
	<tr>
		<td>
			Filling showcases/reports:
		</td>
		<td>
			<?php echo round((($arr_tpl['last_id_click_p2']/$arr_tpl['last_id_click'])*100),3) ?>%
		</td>
	</tr>
	<tr>
		<td>
			Max Heap Table Size:
		</td>
		<td>
			<?php echo round(($arr_tpl['var_memory_table_size']/1024/1024/1024),2).' Gb ('.round($arr_tpl['var_memory_table_size']/1024/1024,0) ?> Mb)
		</td>
	</tr>
	<tr>
		<td>
			EVENT Status:
		</td>
		<td>
			<?php echo $arr_tpl['var_event_status'] ?>
		</td>
	</tr>
</table>
