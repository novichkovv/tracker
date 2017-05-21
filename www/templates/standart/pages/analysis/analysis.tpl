<div class="analisys_block" style="width: 700px;font-size: 13px !important">
<h1 style="font-size: 17px;margin-top: 0px;">System Monitor</h1>
	<h4 style="margin-bottom: 0px;">
		Product:
	</h4>
	<p style="margin: 2px 0px;">Product version: <?php echo $arr_tpl['name'].' ('.$arr_tpl['version'][0].')';?> <br>
	<a style="margin-right: 15px;" target="_blank" href="http://binom.org/changelog">Change log</a>
	<a style="margin-right: 15px;" href="?page=analysis_system&type=check_update">Check update</a>
	<a href="?page=analysis_system&type=check_update">Check payments</a>
	<p style="margin: 2px 0px;">Last update date: <?php echo date('d-m-Y G:i:s',(int)$arr_tpl['date_update']);?></p>
	
	<p style="margin: 2px 0px;">User group: <?php echo $arr_tpl['user'];?></p>
	
	<?php if($arr_tpl['lic_check']>3){ ?>
		<p style="margin: 2px 0px;">Paid subscription days left: <?php echo $arr_tpl['lic_check'];?></p>
	<?php }else{ ?>
		<p style="margin: 2px 0px;color: #C62828;">Paid subscription days left: <b><?php echo $arr_tpl['lic_check'];?></b></p>
	<?php } ?>
	<h4 style="margin-bottom: 0px;">
		Server use:
	</h4>
	<p style="margin: 2px 0px;">Database volume: <?php echo round(($arr_tpl['server_info']['size_db']/1024),2).' Gb ('.round($arr_tpl['server_info']['size_db'],0) ?> Mb)</p>
	<p style="margin: 2px 0px;">Memory tables: <?php echo round(($arr_tpl['server_info']['size_db_ram']/1024),2).' Gb ('.round($arr_tpl['server_info']['size_db_ram'],0) ?> Mb)</p>		
	<!--<h4 style="margin-bottom: 0px;">
		Loads:
	</h4>
	<p style="margin: 2px 0px;">In the last 24 hours:</p>
	<?php $i=0; foreach($arr_tpl['Loads'] AS $load){ $i++;?>
		<p style="margin: 6px 0px;"><span style="font-weight: 600;"><?php echo $load['cl_sec'];?></span> <span style="color:gray;"> c/m (<?php echo $load['load_time'];?>)</span></p>
	<?php } ?>
	<?php
		if($i==0){
			?>
			<p style="margin: 6px 0px;"><span style="font-weight: 600;">No load</span></p>
			<?php
		}
	?>-->
	<h4 style="margin-bottom: 0px;">
		Errors:
	</h4>
	<div>
		<?php echo $arr_tpl['err_text'] ?>
	</div>
</div>