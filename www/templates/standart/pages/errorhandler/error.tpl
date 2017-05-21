<div class="main" style="margin:0;">
	<div class="install_block">
		<h3 style="color:red">
			Fatal Error!
		</h3>
		<p style="text-align:center;font-size: 17px;">
			Something went wrong :(
			<br>
			Do not stop your traffic, just write on skype - <b>binom.support</b>
		</p>
		<p style="text-align: center;margin: 0;">
			<a href="javascript: error_show();" class="error_log_a">Error log
				<img src="templates/standart/images/arrow_down.png">
			</a>
		 </p>
		<textarea id="text_error" disabled style="background: white;margin: 0px;height: 328px;width: 750px;margin: 10 25 10 25;height: 350px; display:none;">
			<?php print_r($arr_tpl) ?>
		</textarea>
		<center><img style="margin: 20px 20px 60px 20px;" src="templates/standart/images/fatal_error.gif"></center>
	</div>
	<div class="clear"></div>
</div>