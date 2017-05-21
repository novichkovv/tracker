// GLOBAL
__pageType="Clicklog";
__pageFormat="Clicklog";

$(document).ready(function() {
	//вывод постраничной навигации, если она присутствует
	<?php if($arr_tpl['table_options']['pages']>0){ ?>
		$("#nav_str").change(function() {
			$(this).prop("disabled", true);
			var myRe = /num_page=<?php echo $arr_tpl['options']['num_page'];?>/i;
			var myArray = myRe.exec(location.href);
			if(myArray){
				var new_link = location.href.replace(/num\_page\=<?php echo $arr_tpl['options']['num_page'];?>/, "num_page="+$("#nav_str :selected").val());
			}else{
				var new_link = location.href + "&num_page="+$("#nav_str :selected").val();
			}
			document.location.href = new_link;
		});
		$("#nav_str_val [value='<?php echo $arr_tpl['options']['val_page'];?>']").prop("selected", true);
		$("#nav_str_val").change(function() {
			var myRe = /val\_page\=<?php echo $arr_tpl['options']['val_page'];?>/i;
			var myArray3 = myRe.exec(location.href);

			if(myArray3){
				var new_link = location.href.replace(/val\_page\=<?php echo $arr_tpl['options']['val_page'];?>/, "val_page="+$("#nav_str_val :selected").val());
			}else{
				var new_link = location.href + "&val_page="+$("#nav_str_val :selected").val();
			}
			
			document.location.href = new_link;
		});
	<?php } ?>
	//смещение шапки вместе с телом по оси x
	$(".body-container-new").scroll(function(){
		$(".header-container-new").scrollLeft($(".body-container-new").scrollLeft());
	});
	//запускаем корректировки размеров таблицы при изменении размеров окна
	$(window).resize(function(){
		table_correct(); 
	});
	//отключение столбцов
	$('#win_button_save').click(function(){
		$.each( $("#edit_table_column input"), function( key, value ) {
			if($(this).prop('checked')==true){
				$('.head_column_'+$(this).attr('name')).css("display","table-cell");
			}else{
				$('.head_column_'+$(this).attr('name')).css("display","none");
			}
		});
		var form_data   = $('#parameters_form').serialize();
		$.ajax({
			url : "",
			method: "post",
			data: form_data,
			success: function(data) {
				console.log(data);
			},
		});
		//корректируем размеры таблицы
		table_correct(); 
		notewindow_hide2(this);
	});
	//функции для окна выбора колонок
	//поиск
	jQuery.expr[":"].Contains = jQuery.expr.createPseudo(function(arg) {
		return function( elem ) {
			return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
		};
	});
	$('#prm_column_serach').keyup(function(){
		//console.log($(this).val());
		$('#edit_table_column label').parent().parent().parent().css('display','table-row');
		$.each( $('#edit_table_column label:not(:Contains("'+$(this).val()+'"))'), function( key, value ) {
			$(this).parent().parent().parent().css('display','none');
		});
	});
	//выбор
	$('#edit_table_column input').click(function(){
		$('#win_button_close').css("display","none");
		$('#win_button_save').css("display","table-row");
		if($(this).prop('checked')==true){
			$(this).parent().parent().parent().css("background-color","#f5e26f");
		}else{
			$(this).parent().parent().parent().css("background-color","");
		}
	});
	//открытие окна
	$('#get_win_parameters').click(function(){
		//расставляем статусы
		$.each( $(".stat_header-new tr td"), function( key, value ) {
			if($(value).css("display")=='none'){
				name = $(value).attr('class');
				name = name.replace('head_column_','check_');
				$('#'+name).removeAttr('checked');
				$('#'+name).parent().parent().parent().css("background-color","");
			}else{
				name = $(value).attr('class');
				name = name.replace('head_column_','check_');
				$('#'+name).prop('checked','true');
				$('#'+name).parent().parent().parent().css("background-color","#f5e26f");
			}
		});
		$('#win_button_close').css("display","table-row");
		$('#win_button_save').css("display","none");
		$('#win_edit_parameters').css('display','block');
		$('#wrap').css('display','block');
	});
	//запускаем корректировки размеров таблицы
	table_correct();
});		

function table_correct(){
	//добовляем элемент для выравнивания ширины
	if(!$(".stat_header-new tr td:last").is("#width_td_header")){
		$(".stat_header-new tr:first").append( "<td style='width:0;padding:0;' id='width_td_header'></td>" );
		$(".stat_footer table tr:first").append( "<td style='width:0;padding:0;' id='width_td_footer'></td>" );
		$(".table_stat-new table tr").append( "<td style='width:0padding:0;'></td>" );
	}
	//прячем колонки, если они отключены в шапке
	$.each( $(".stat_header-new tr td"), function( key, value ) {
		if($(value).css("display")=='none'){
			$(".table_stat-new tr td:nth-child("+(key+1)+")").css("display","none");
			$(".stat_footer-new tr td:nth-child("+(key+1)+")").css("display","none");
		}else{
			$(".table_stat-new tr td:nth-child("+(key+1)+")").css("display","table-cell");
			$(".stat_footer-new tr td:nth-child("+(key+1)+")").css("display","table-cell");
		}
	});
	//ширина
	$.each($(".table_stat-new tr:first td"), function( key, value ) {
		if($(value).css("display")!=='none'){
			$(".stat_header-new td:eq("+key+")").css("min-width",$(value).width());
			$(".stat_header-new td:eq("+key+")").css("max-width",$(value).width());
			$(".stat_footer td:eq("+key+")").width($(value).width());
		}
	});
	//чекаем скролл
	if($(".stat_header-new").width()>$(".table_stat-new").width()){
		var scroll_with=$(".stat_header-new").width()-$(".table_stat-new").width();
		$(".stat_header-new tr td:last").css("padding-right",scroll_with);
		$(".stat_footer table tr td:last").css("padding-right",scroll_with);
	}else{
		$(".stat_header-new tr td:last").css("padding-right","0px");
		$(".stat_footer table tr td:last").css("padding-right","0px");
	}
	//убираем анимацию
	$(".table-load").css('display','none');
	$(".stat_header-new").css('height','30px');
	$(".stat_header-new").css('overflow','visible');
	$(".stat_header-new").css('display','table');
	
	$(".table_stat-new").css('height','100%');
	$(".table_stat-new").css('overflow','visible');
	$(".table_stat-new").css('display','table');
	
	$(".stat_footer-new").css('height','38px');
	$(".stat_footer-new").css('overflow','visible');
	$(".stat_footer-new").css('display','table');
	//корректируем высоту блока
	$(".body-container-new").height(window.innerHeight-$(".body-container-new").offset().top-45);
}