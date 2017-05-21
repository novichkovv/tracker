<table class="a_table_3">
	<tr>
		<td style="width: 150px;">
			ID
		</td>
		<td style="width: 150px;">
			User
		</td>
		<td style="width: 150px;">
			Data Base
		</td>
		<td style="width: 50px;">
			Time
		</td>
		<td style="width: 350px;">
			State
		</td>
		<td>
			SQL/Info
		</td>
	</tr>
<?php foreach ($arr_tpl['mysql_processes'] AS $val){ ?>
	<tr <?php if($val['Time']>10 && $val['Time']>60){echo 'style="background:#f5e26f;"';}else{if($val['Time']>60){echo 'style="background:red;"';}} ?>>
		<td>
			<?php echo $val['Id'] ?> (<a style="color:red; cursor:pointer;" onclick="sql_kill('<?php echo $val['Id'] ?>')">Kill</a>)
		</td>
		<td>
			<?php echo $val['User'] ?>
		</td>
		<td>
			<?php echo $val['db'] ?>
		</td>
		<td>
			<?php echo $val['Time'] ?>
		</td>
		<td>
			<?php echo $val['State'] ?>
		</td>
		<td>
			<?php echo $val['Info'] ?>
		</td>
	</tr>
<?php }?>
</table>