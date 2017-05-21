
function clear_camp(id){
					if (confirm('You sure that you want to clear clicks in this campaign?')) {
						$.ajax({
							url: "",
							type: "POST",
							data: {	"type" : "clear_camp",
									"camp_id" : id,
									"ajax":"1"
							}
						});
					}
}

$(window).resize(function(){ 
						$("table.table_stat tr:first-child td").each(function(i,elem) { 
							w=$(elem).width();
							minw=$(elem).css("min-width");
							pleft=$(elem).css("padding-left");
							pright=$(elem).css("padding-right");
							$("#hrow"+(i+1)).width(w);
							$("#hrow"+(i+1)).css("min-width",minw);
							$("#hrow"+(i+1)).css("padding-left",pleft);
							$("#hrow"+(i+1)).css("padding-right",pright);
							$("#frow"+(i+1)).width(w);	
							$("#frow"+(i+1)).css("min-width",minw);
							$("#frow"+(i+1)).css("padding-left",pleft);
							$("#frow"+(i+1)).css("padding-right",pright);
						});
						$(".body-container").height(window.innerHeight-$(".body-container").offset().top-45);
});

$(document).ready(function() {
					
	var i_c=0;
	var group_camp="";
	$(".check_camp").each(function(i, el){
		if($(el).prop("checked")==true){
			group_camp=group_camp+$(el).attr("id")+",";
			group_camp=group_camp.replace("check", "");
			$(el).parent().parent().parent().addClass("tr_active");
			i_c=i_c+1;
		}
	});
	
	if(i_c>0){
		group_camp=group_camp.substring(0, group_camp.length - 1);
		$("#report").attr("href", "?page=Stats&camps="+group_camp+"&date='<?php echo $arr_tpl['date'] ?>'&date_s='<?php echo $arr_tpl['date_s'] ?>'&date_e='<?php echo $arr_tpl['date_e'] ?>'");
		$("#report").attr("class", "green-button");
	}
	
	$("body").on("change",".check_camp_all",function () {
		$("#edit").attr("href", "");
		$("#edit").attr("class", "button_inactive");
		$("#report").attr("href", "");
		$("#report").attr("class", "button_inactive");
		$("#clone").attr("href", "");
		$("#clone").attr("class", "button_inactive");
		$("#note").attr("onclick", "");
		$("#note").attr("class", "button_inactive");
		$("#clear").attr("onclick", "");
		$("#clear").attr("class", "gray-button_inactive");
		$("#delete").attr("href", "");
		$("#delete").attr("class", "gray-button_inactive");
		$(".table_stat_tr").removeClass("tr_active");
		var group_camp="";
		if($(this).prop("checked")==true){
			$(".check_camp").each(function(i, el){
				group_camp=group_camp+$(el).attr("id")+",";
				group_camp=group_camp.replace("check", "");
				$(el).parent().parent().parent().addClass("tr_active");
				$(el).prop("checked","true");
			});
			group_camp=group_camp.substring(0, group_camp.length - 1);
			$("#report").attr("href", "?page=Stats&camps="+group_camp+"&date='<?php echo $arr_tpl['date'] ?>'&date_s='<?php echo $arr_tpl['date_s'] ?>'&date_e='<?php echo $arr_tpl['date_e'] ?>'");
			$("#report").attr("class", "green-button");
		}else{
			$(".check_camp").each(function(i, el){
				$(el).parent().parent().parent().removeClass("tr_active");
				$(el).prop("checked","");
			});
		}
	});
	
	$("body").on("change",".check_camp",function () {
		$("#edit").attr("href", "");
		$("#edit").attr("class", "button_inactive");
		$("#report").attr("href", "");
		$("#report").attr("class", "button_inactive");
		$("#clone").attr("href", "");
		$("#clone").attr("class", "button_inactive");
		$("#note").attr("onclick", "");
		$("#note").attr("class", "button_inactive");
		$("#clear").attr("onclick", "");
		$("#clear").attr("class", "gray-button_inactive");
		$("#delete").attr("href", "");
		$("#delete").attr("class", "gray-button_inactive");
		$(".table_stat_tr").removeClass("tr_active");
		var group_camp="";
		var i2=0;
		$(".check_camp").each(function(i, el){
			if($(el).prop("checked")==true){
				group_camp=group_camp+$(el).attr("id")+",";
				group_camp=group_camp.replace("check", "");
				$(el).parent().parent().parent().addClass("tr_active");
				i2=i2+1;
			}
		});
		if(i2>0){
			group_camp=group_camp.substring(0, group_camp.length - 1);
			$("#report").attr("href", "?page=Stats&camps="+group_camp+"&date='<?php echo $arr_tpl['date'] ?>'&date_s='<?php echo $arr_tpl['date_s'] ?>'&date_e='<?php echo $arr_tpl['date_e'] ?>'");
			$("#report").attr("class", "green-button");
		}
	});

	$("table.table_stat tr:first-child td").each(function(i,elem) { 
			w=$(elem).width();
			minw=$(elem).css("min-width");
			pleft=$(elem).css("padding-left");
			pright=$(elem).css("padding-right");
			$("#hrow"+(i+1)).width(w);
			$("#hrow"+(i+1)).css("min-width",minw);
			$("#hrow"+(i+1)).css("padding-left",pleft);
			$("#hrow"+(i+1)).css("padding-right",pright);
			$("#frow"+(i+1)).width(w);	
			$("#frow"+(i+1)).css("min-width",minw);
			$("#frow"+(i+1)).css("padding-left",pleft);
			$("#frow"+(i+1)).css("padding-right",pright);
		});	
	$(".body-container").height(window.innerHeight-$(".body-container").offset().top-45);


	$.ajax({
		url: "",
		type: "POST",
		data: {	"type" : "load_hour",
				"type_lh" : "1",
				"ajax":"1"
		},
		success:function(data) { 
			var myRe = /\<el\>(.*?)\<\/el\>+/g;
			var myRe2 = /\<el_id\>(.*)\<\/el_id\>/;
			var ReClh = /\<CLH\>(.*)\<\/CLH\>/;
			var Rellh = /\<LLH\>(.*)\<\/LLH\>/;
			var Rephl = /\<PHL\>(.*)\<\/PHL\>/;
			var Rephl2 = /\<PHL2\>(.*)\<\/PHL2\>/;
			var Rell = /\<LL\>(.*)\<\/LL\>/;
			
			while ((arr_all = myRe.exec(data)) != null) {
				var el_id =  myRe2.exec(arr_all[1]);
				el_id = el_id[1];
				//заменяем данные
				var ll2 = Rell.exec(arr_all[1]);
				$("#last_lead_"+el_id).html(ll2[1]);
				$("#last_lead_"+el_id).attr("class","table_td_info");
				var clh = ReClh.exec(arr_all[1]);
				$("#clh_"+el_id).html(clh[1]);
				$("#clh_"+el_id).attr("class","table_td_info");
				var llh = Rellh.exec(arr_all[1]);
				$("#llh_"+el_id).html(llh[1]);
				$("#llh_"+el_id).attr("class","table_td_info");
				var phl = Rephl.exec(arr_all[1]);
				$("#phl_"+el_id).html(phl[1]);
				$("#phl_"+el_id).attr("class","table_td_info");
				
				var phl2 = Rephl2.exec(arr_all[1]);

				phl2[1] = parseFloat(phl2[1]);

				if(phl2[1]>0){
					$("#phl_"+el_id).addClass("color_stat_1");
				}else{
					if(phl2[1]==0){
						$("#phl_"+el_id).addClass("color_stat_2");
					}else{
						$("#phl_"+el_id).addClass("color_stat_3");
					}
				}
			}
			//заменяем на прочерки пустые данные
			$(".table_stat td").each(function() {
				if($(this).hasClass("loading")){
					$(this).html("-");
				}
			});
		}
	});
});


function enter_date(value){
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
}

function open_stat(id, el){
	var timedate=$("#date_filter option:selected").val();
	var date_s=$("#custom_date_pol1").val();
	var date_e=$("#custom_date_pol2").val();
	var link = "?page=Stats&camp_id="+id+"&date="+timedate+"&date_s="+date_s+"&date_e="+date_e;
	location.href = link;
}

function hide_button(id, el, status){
	var i2 = 0;
	$(".check_camp").each(function(i, el){
		if($(el).prop("checked")==true){
			i2=i2+1;
		}
	});
	if(i2==0){
		var timedate=$("#date_filter option:selected").val();
		var date_s=$("#custom_date_pol1").val();
		var date_e=$("#custom_date_pol2").val();
		$("#edit").attr("href", "");
		$("#edit").attr("class", "button_inactive");
		$("#report").attr("href", "");
		$("#report").attr("class", "button_inactive");
		$("#clone").attr("href", "");
		$("#clone").attr("class", "button_inactive");
		$("#note").attr("onclick", "");
		$("#note").attr("class", "button_inactive");
		$("#clear").attr("onclick", "");
		$("#clear").attr("class", "gray-button_inactive");
		$("#delete").attr("href", "");
		$("#delete").attr("class", "gray-button_inactive");
		if($(el).hasClass("tr_active")){
			$("#edit").attr("href", "");
			$("#edit").attr("class", "button_inactive");
			$("#report").attr("href", "");
			$("#report").attr("class", "button_inactive");
			$("#clone").attr("href", "");
			$("#clone").attr("class", "button_inactive");
			$("#note").attr("onclick", "");
			$("#note").attr("class", "button_inactive");
			$("#clear").attr("onclick", "");
			$("#clear").attr("class", "gray-button_inactive");
			$("#delete").attr("href", "");
			$("#delete").attr("class", "gray-button_inactive");
			$(el).removeClass("tr_active");
		}else{
			$("#report").attr("href", "?page=Stats&camp_id="+id+"&date="+timedate+"&date_s="+date_s+"&date_e="+date_e);
			$("#report").attr("class", "green-button");
			$("#clone").attr("href", "?page=clone_camp&camp_id="+id);
			$("#clone").attr("class", "green-button");
			$("#note").attr("onclick", "show_window_node(\'"+id+"\', \'"+$(el).children(".name_camp").html()+"\')");
			$("#note").attr("class", "green-button");
			$("#clear").attr("onclick", "clear_camp("+id+")");
			$("#clear").attr("class", "gray-button");
			$(".tr_active").removeClass("tr_active");
			$(el).addClass("tr_active");
			if(status==1){
				$("#edit").attr("href", "?page=edit_camp&id="+id);
				$("#edit").attr("class", "green-button");
				$("#delete").attr("href", "?page=delete_camp&camp_id="+id);
				$("#delete").attr("class", "gray-button");
				$("#delete").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
				$("#delete").attr("onclick","return confirm(\'You sure that want to delete this item?\');");
			}else{
				$("#delete").attr("href", "?page=restore&type_el=1&el_id="+id);
				$("#delete").attr("class", "gray-button");
				$("#delete").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
				$("#delete").attr("onclick","");
			}
		}
	}
}

$(window).load(function () {
	if($.getUrlVar("date")=="10" || $.cookie("date") == "10" || $.getUrlVar("date")=="12" || $.cookie("date") == "12"){
		$("#custom_date").css("display","block");
		$("[name = \'search_name\']").css("width","140px");
	}else{
		$("#custom_date").css("display","none");
		$("[name = \'search_name\']").css("width","200px");
	}
	if($.getUrlVar("date")=="10" || $.cookie("date") == "10"){
		$("#custom_date_pol1").datetimepicker({format:"Y-m-d | H:i", defaultTime: "00:00", timepicker: true});
		$("#custom_date_pol2").datetimepicker({format:"Y-m-d | H:i", defaultTime: "23:59", timepicker: true});
	}
	if($.getUrlVar("date")=="12" || $.cookie("date") == "12"){
		$("#custom_date_pol1").datetimepicker({format:"Y-m-d", timepicker: false});
		$("#custom_date_pol2").datetimepicker({format:"Y-m-d", timepicker: false});
	}
	
	var type_stat=<?php arr_tpl['type_stat']?>;

	if(type_stat){
		$("#info_button").html("Stat");
		$(".table_td_info").css("display","block");
		$(".table_td_stat").css("display","none");
		str = str.replace(/\&type\_stat\=info/g, "");
		$(".sort_link").attr("href", str+"&type_stat=info");
	}

});

function show_info(){
	if($("#info_button span").html()=="Info"){
		$("#info_button").html("<img src=\"templates/standart/images/w-table.png\" class=\"icon stats_icon\"><span>Stat</span>");
		$(".table_td_info").css("display","table-cell");
		$(".table_td_stat").css("display","none");
		$(".sort_link").each(function(i,elem) {
			$(elem).attr("href", $(elem).attr("href")+"&type_stat=info");
		});
	}else{
		$("#info_button").html("<img src=\"templates/standart/images/w-note.png\" class=\"icon info_icon\"><span>Info</span>");
		$(".table_td_info").css("display","none");
		$(".table_td_stat").css("display","table-cell");
		$(".sort_link").each(function(i,elem) {
			var str = $(elem).attr("href");
			str = str.replace(/\&type\_stat\=info/g, "");
			$(elem).attr("href", str);
		});
	}

	$("table.table_stat tr:first-child td").each(function(i,elem) { 
			w=$(elem).width();
			minw=$(elem).css("min-width");
			pleft=$(elem).css("padding-left");
			pright=$(elem).css("padding-right");
			$("#hrow"+(i+1)).width(w);
			$("#hrow"+(i+1)).css("min-width",minw);
			$("#hrow"+(i+1)).css("padding-left",pleft);
			$("#hrow"+(i+1)).css("padding-right",pright);
			$("#frow"+(i+1)).width(w);	
			$("#frow"+(i+1)).css("min-width",minw);
			$("#frow"+(i+1)).css("padding-left",pleft);
			$("#frow"+(i+1)).css("padding-right",pright);
		});
		$(".body-container").height(window.innerHeight-$(".body-container").offset().top-45);


}