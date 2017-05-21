function submitForm(){
	var err = 0;
	if ($("[name=date]").val()=="10" || $("[name=date]").val()=="12"){
		date_s = $("#act-form [name=date_s]").val().split("|");
		date_e = $("#act-form [name=date_e]").val().split("|");
		if (date_s.length>1){
			if ( new Date(date_s[0] + " " +date_s[1]) > new Date(date_e[0] + " " +date_e[1]) ){
				err += 1;
				alert("Incorrect date/time!");
			} else {
				$("#act-form").submit();
			}
		} else {
			if (new Date(date_s[0]) > new Date(date_e[0])){
				err += 1;
				alert("Incorrect date!");
			} else {
				$("#act-form").submit();
			}

		}
	}
	if (err==0){
		$("#act-form").submit();
	}
}

function setDateTimePickerOnInput(){

	if($("#date_filter").val()=="10" || $("#date_filter").val()=="12"){
		if($("#date_filter").val()=="10"){
			$("#custom_date_pol1").datetimepicker({format:"Y-m-d | H:i", defaultTime: "00:00", timepicker: true});
			$("#custom_date_pol2").datetimepicker({format:"Y-m-d | H:i", defaultTime: "23:59", timepicker: true});
			if($("#custom_date_pol1").val()=="all" || $("#custom_date_pol2").val()=="all" || $("#custom_date_pol2").val()=="" || $("#custom_date_pol1").val()==""){
				$("#custom_date_pol1").val("<?php echo date('Y-m-d').' | 00:00'; ?>");
				$("#custom_date_pol2").val("<?php echo date('Y-m-d | G:i'); ?>");
			}
			$("#refresh-btn").removeClass("blue-button").addClass("green-button");
			$("#refresh-btn").html("&nbsp;&nbsp;<img src=\'templates/standart/images/w-ok.png\' class=\'icon\' style=\'position: relative; top: 1px;\'>Apply&nbsp;&nbsp;");
		}
		if($("#date_filter").val()=="12"){
			$("#custom_date_pol1").datetimepicker({format:"Y-m-d", timepicker: false});
			$("#custom_date_pol2").datetimepicker({format:"Y-m-d", timepicker: false});
			if($("#custom_date_pol1").val()=="all" || $("#custom_date_pol2").val()=="all" || $("#custom_date_pol2").val()=="" || $("#custom_date_pol1").val()==""){
				$("#custom_date_pol1").val("<?php echo date('Y-m-d'); ?>");
				$("#custom_date_pol2").val("<?php echo date('Y-m-d'); ?>");
			}
			$("#refresh-btn").removeClass("blue-button").addClass("green-button");
			$("#refresh-btn").html("&nbsp;&nbsp;<img src=\'templates/standart/images/w-ok.png\' class=\'icon\' style=\'position: relative; top: 1px;\'>Apply&nbsp;&nbsp;");
		}
	}else{
		$("#refresh-btn").removeClass("green-button").addClass("blue-button");
			$("#refresh-btn").html("<img src=\'templates/standart/images/w-refresh.png\' class=\'icon\'>Refresh");
			//$(".filter_block [type=\'submit\']").click();
			
	}

}

$(document).ready(function(){
	setDateTimePickerOnInput();
	$(".filter_block").on("change","select", function(){setDateTimePickerOnInput(), $("#act-form").submit();});
});

function filters_enter_date(value){
	if($(value).val()=="10" || $(value).val()=="12"){
		if($(value).val()=="12"){
			var custom_val_1=$("#custom_date_pol1").val().replace(/\s\|.*/,"");
			var custom_val_2=$("#custom_date_pol2").val().replace(/\s\|.*/,"");
		}else{
			if($("#custom_date_pol1").val().search(/|/)=="-1"){
				var custom_val_1=$("#custom_date_pol1").val()+" | 00:00";
				var custom_val_2=$("#custom_date_pol2").val()+" | 00:00";
			}
		}
		$("#custom_date_pol1").val(custom_val_1);
		$("#custom_date_pol2").val(custom_val_2);
		$("#custom_date").css("display","block");
		$("[name = \'search_name\']").css("width","140px");
	}else{
		$("#custom_date").css("display","none");
		$("[name = \'search_name\']").css("width","200px");
	}

	if ($(value).val()=="12"){
		$("#custom_date").addClass("narrow_date_input");
	} else {
		$("#custom_date").removeClass("narrow_date_input");
	}

}