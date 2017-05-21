// GLOBAL
var __checkBoxChecked = false,
	__pageFormat = "statistic",
	__pageType = "campaigns";

var CampaignsStatsPage = {

	deleteButtonHandler : function(object){
		deleteButtonHandler(object, "Campaigns", "Are you sure that you want to delete this campaign?");
	},

	clearCampHandler : function(id, type){
		var	ok_callback = function(){

			makeButtonInProcess(".modal_window--confirm .modal_window__ok-button" ,"Clearing...");

			$.ajax({
				url: "",
				type: "POST",
				data: {	"type" : "clear_camp",
						"camp_id" : id,
						"ajax":"1",
						"type2":type
				},
				success:function(data) { 
				}

			});
			setTimeout(function(){location.reload()}, 1500);
		};
		
		var modal_window = makeConfirmModal("OK", "Cancel", ok_callback, "Clearing campaign", "You sure that you want to clear clicks in this campaign?");
		modal_window.show();
	}

}

//preload checkbox image for using it later
var saveCheckboxImage = new Image();
saveCheckboxImage.src = "./templates/standart/images/check_in_box.png"
// Preload save_active.png image for using it later
var saveActiveImage = new Image();
saveActiveImage.src = "./templates/standart/images/save_active.png";

//function clear_camp(id, type){
	/*if (confirm('You sure that you want to clear clicks in this campaign?')) {
		$.ajax({
			url: "",
			type: "POST",
			data: {	"type" : "clear_camp",
					"camp_id" : id,
					"ajax":"1",
					"type2":type
			},
			success:function(data) { 

			}
		});
		setTimeout(function(){location.reload()}, 1500);
	}*/

	/* var content = "You sure that you want to clear clicks in this campaign?",
		footer = '<div class="modal_window__buttons-block">\
				 <a class="button win-save-button modal_window__ok-button" ><img src="templates/standart/images/w-save.png" class="icon save_icon">OK</a>\
				 <a class="button win-close-button modal_window__cancel-button" ><img src="templates/standart/images/w-close.png" class="icon close_icon">Cancel</a>\
				</div>',*/
	//CampaignsStatsPage.clearCampHandler(id, type);

//}


function header_correlation(){

	window.line.each(function(i,elem) { 

		w=$(elem).width();
		minw=$(elem).css("min-width");
		pleft=$(elem).css("padding-left");
		pright=$(elem).css("padding-right");

		//$("#hrow"+(i+1)).width(w);
		if (w!=0){
			$("#hrow"+(i+1)).css("min-width",w);
			$("#frow"+(i+1)).css("min-width",w);
			$("#hrow"+(i+1)).css("max-width",w);
			$("#frow"+(i+1)).css("max-width",w);
		}
		if (pleft!=0){
			$("#hrow"+(i+1)).css("padding-left",pleft);
		}
		if (pright!=0){
			$("#hrow"+(i+1)).css("padding-right",pright);
		}
		//$("#frow"+(i+1)).width(w);	
		
		
		$("#frow"+(i+1)).css("padding-left",pleft);
		$("#frow"+(i+1)).css("padding-right",pright);
	});
	$(".body-container").height(window.innerHeight-$(".body-container").offset().top-45);
}




/*$(window).resize(function(){ 
	header_correlation();
});*/

/*function disabledNongroupButtons(){
	$("#delete, #clone, #report, #edit").removeAttr("href");
	$("#edit, #report, #clone, #note").attr("class", "button_inactive");
	$("#clear, #note").attr("onclick", "");
	$("#clear, #delete").attr("class", "gray-button_inactive");
}*/

$(document).ready(function() {

	//подгрузка группового выбора при back		
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
		$("#report").attr("href", "?page=Stats&camps="+group_camp+"&date=<?php echo $arr_tpl['date'] ?>&date_s=<?php echo $arr_tpl['date_s'] ?>&date_e=<?php echo $arr_tpl['date_e'] ?>");
		$("#report").attr("class", "green-button");
		$("#delete").attr("data-href", "?page=delete_camp&camps="+group_camp);
		$("#delete").attr("class", "gray-button");
		$("#delete").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
		$("#delete").attr("onclick","CampaignsStatsPage.deleteButtonHandler(this)");
		$("#clear").attr("onclick", "CampaignsStatsPage.clearCampHandler('"+group_camp+"',2)");
		$("#clear").attr("class", "gray-button");
	}
	
	//выбор всех элементов
	$("body").on("change",".check_camp_all",function () {
		
		disabledNongroupButtons();

		$(".table_stat_tr").removeClass("tr_active");
		var group_camp="", count_of_rows=0, count_of_deleted_rows=0;
		if($(this).prop("checked")==true){

			$(".check_camp").each(function(i, el){

				if ($(el).parent().parent().parent().css("display") != "none") {
					group_camp=group_camp+$(el).attr("id")+",";
					group_camp=group_camp.replace("check", "");
					$(el).parent().parent().parent().addClass("tr_active");
					$(el).prop("checked","true");
					count_of_rows += 1;
					if ($(el).parent().parent().parent().hasClass("camp_inactive")){
						count_of_deleted_rows += 1;
					}
				}

			});
			
			group_camp=group_camp.substring(0, group_camp.length - 1);
			$("#report").attr("href", "?page=Stats&camps="+group_camp+"&date=<?php echo $arr_tpl['date'] ?>&date_s=<?php echo $arr_tpl['date_s'] ?>&date_e=<?php echo $arr_tpl['date_e'] ?>");
			$("#report").attr("class", "green-button");
			
			if (count_of_rows > count_of_deleted_rows){
				$("#delete").attr("data-href", "?page=delete_camp&camps="+group_camp);
				$("#delete").attr("class", "gray-button");
				$("#delete").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
				$("#delete").attr("onclick","CampaignsStatsPage.deleteButtonHandler(this)");
			} else if (count_of_deleted_rows>0) {
				$("#delete").attr("href", "?page=restore&type_el=1&el_id="+group_camp);
				$("#delete").attr("class", "gray-button");
				$("#delete").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
				$("#delete").attr("onclick","");
			}
			

			$("#clear").attr("onclick", "CampaignsStatsPage.clearCampHandler('"+group_camp+"',2)");
			$("#clear").attr("class", "gray-button");
			__checkBoxChecked = true; 
		}else{
			$(".check_camp").each(function(i, el){
				$(el).parent().parent().parent().removeClass("tr_active");
				$(el).prop("checked","");
			});
			__checkBoxChecked = false;
		}
	});
	
	//выбор элемента
	$("body").on("change",".check_camp",action_after_check);

	//Определение строки по которой идет корреляция
	//window.line=$("table.table_stat tr:first-child td");


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
			var Replh = /\<PLH\>(.*)\<\/PLH\>/;
			var Replh2 = /\<PLH2\>(.*)\<\/PLH2\>/;
			var Rell = /\<LL\>(.*)\<\/LL\>/,
				no_profit;
			
			if ($(".stat_header td.proft_td").css("display")=="none"){
				no_profit = true;
			} else {
				no_profit = false;

			}

			while ((arr_all = myRe.exec(data)) != null) {
				var el_id =  myRe2.exec(arr_all[1]);
				el_id = el_id[1];
				//заменяем данные
				if(<?php echo $arr_tpl['show_profit'] ?> !== 1){
					var ll2 = Rell.exec(arr_all[1]);
					$("#last_lead_"+el_id).html(ll2[1]);
					$("#last_lead_"+el_id).attr("class","table_td_info");
					var llh = Rellh.exec(arr_all[1]);
					$("#llh_"+el_id).html(llh[1]);
					$("#llh_"+el_id).attr("class","table_td_info");

					var plh = Replh.exec(arr_all[1]);
					$("#plh_"+el_id).html(plh[1]);
					$("#plh_"+el_id).attr("class","table_td_info");
					
					var plh2 = Replh2.exec(arr_all[1]);

					plh2[1] = parseFloat(plh2[1]);
					if(plh2[1]>0){
						$("#plh_"+el_id).addClass("color_stat_1");
					}else{
						if(plh2[1]==0){
							$("#plh_"+el_id).addClass("color_stat_2");
						}else{
							$("#plh_"+el_id).addClass("color_stat_3");
						}
					}
				}
				
				var clh = ReClh.exec(arr_all[1]);
				$("#clh_"+el_id).html(clh[1]);
				$("#clh_"+el_id).attr("class","table_td_info");

			}
			//заменяем на прочерки пустые данные
			$(".table_stat td").each(function() {
				if($(this).hasClass("loading")){
					$(this).html("-");
				}
			});
		}
	});

	//Preload save_active.png image for using it later
	var saveActiveImage = new Image();
	saveActiveImage.src = "./templates/standart/images/save_active.png";
	//0 is leave, 1 is out
	var animateSaveLincIconAnimationTimeout = 0;

	function animateSaveLincIcon(){

		var that = this;
		
		$(that).removeClass("save_camp_link_icon_hover")
		$(that).attr("src", "./templates/standart/images/save_active.png");
		$(that).css("opacity", 1);

		setTimeout(function(){
			$(that).attr("src", "./templates/standart/images/copy.png");
			$(that).removeClass("save_camp_link_icon_hover");
		}, 500);

	}
	

	if (document.queryCommandSupported && document.queryCommandSupported('copy')){
		//Add icon to camp_name for saving campaign link
		$(".table_stat").on("mouseenter", "tr", function(e){

			$(".save_camp_link_icon").remove();

			var camp_url = $(this).find(".table_link").val();
			if ($(e.target).hasClass("save_camp_link_icon")){
				return;
			}
			if ($(this).find(".name_td .save_camp_link_icon").size() == 0){
				$(this).find(".name_td").append("<img class='save_camp_link_icon' src='./templates/standart/images/copy.png'>");
			}

			try {
				new Clipboard(".name_td .save_camp_link_icon");
				$(".name_td .save_camp_link_icon").replaceWith( $("<img title='Copy URL' class='save_camp_link_icon' src='./templates/standart/images/copy.png' href='javascript:' data-clipboard-text='"+camp_url+"'>") );
				$(".save_camp_link_icon").on("mouseenter", function(){$(this).addClass("save_camp_link_icon_hover");})
				$(".save_camp_link_icon").on("mouseleave", function(){$(this).removeClass("save_camp_link_icon_hover");})
				$(".save_camp_link_icon").on("click", animateSaveLincIcon);
				
				
			} catch (e){

				$(this).find(".name_td .save_camp_link_icon").remove();
			}
		}); 
	}
	
	//handle deleting icon
	$(".table_stat").on("mouseleave", ".table_stat_tr", function(e){
		
		if ($(this).find(".name_td .save_camp_link_icon").length != 0){
			$(this).find(".name_td .save_camp_link_icon").remove();
		}
		
	});

	//show_info();

});





function open_stat(id, el){
	var timedate=$("#date_filter option:selected").val();
	var date_s=$("#custom_date_pol1").val();
	var date_e=$("#custom_date_pol2").val();
	var link = "?page=Stats&camp_id="+id+"&date="+timedate+"&date_s="+date_s+"&date_e="+date_e;
	location.href = link;
}

function open_buttons_for_stat_row(id, status){
	var timedate=$("#date_filter option:selected").val();
	var date_s=$("#custom_date_pol1").val();
	var date_e=$("#custom_date_pol2").val();
	disabledNongroupButtons();

	$("#report").attr("href", "?page=Stats&camp_id="+id+"&date="+timedate+"&date_s="+date_s+"&date_e="+date_e);
	$("#report").attr("class", "green-button");
	$("#clone").attr("href", "?page=clone_camp&id="+id);
	$("#clone").attr("class", "green-button");
	$("#note").attr("onclick", "show_window_node(\'"+id+"\')");
	$("#note").attr("class", "green-button");
	$("#clear").attr("onclick", "CampaignsStatsPage.clearCampHandler("+id+",1)");
	$("#clear").attr("class", "gray-button");
	
	if(status==1){
		$("#edit").attr("href", "?page=edit_camp&id="+id);
		$("#edit").attr("class", "green-button");
		$("#delete").attr("data-href", "?page=delete_camp&camp_id="+id);
		$("#delete").attr("class", "gray-button");
		$("#delete").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
		$("#delete").attr("onclick","CampaignsStatsPage.deleteButtonHandler(this)");
	}else{
		$("#edit").attr("href", "?page=edit_camp&id="+id);
		$("#edit").attr("class", "green-button");
		$("#delete").attr("href", "?page=restore&type_el=1&el_id="+id);
		$("#delete").attr("class", "gray-button");
		$("#delete").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
		$("#delete").attr("onclick","");
	}

}

//Last attribute is event initiator
function hide_button(id, el, status, event_target){

	// Drop function if click was done on save icon
	if ($(event_target).hasClass("save_camp_link_icon")){
		return;
	}

	// Drop function if any checkbox is checked
	if (__checkBoxChecked==true){
		return;
	}

	var i2 = 0;
	$(".check_camp").each(function(i, el){
		if($(el).prop("checked")==true){
			i2=i2+1;
		}
	});

	if(i2<=1){
		var timedate=$("#date_filter option:selected").val();
		var date_s=$("#custom_date_pol1").val();
		var date_e=$("#custom_date_pol2").val();
		disabledNongroupButtons();
		if($(el).hasClass("tr_active")){
			$(el).removeClass("tr_active");
		}else{
			$("#report").attr("href", "?page=Stats&camp_id="+id+"&date="+timedate+"&date_s="+date_s+"&date_e="+date_e);
			$("#report").attr("class", "green-button");
			$("#clone").attr("href", "?page=clone_camp&id="+id);
			$("#clone").attr("class", "green-button");
			//$("#note").attr("onclick", "show_window_node(\'"+id+"\', \'"+$(el).children(".name_camp").html()+"\')");
			$("#note").attr("onclick", "show_window_node(\'"+id+"\')");
			$("#note").attr("class", "green-button");
			$("#clear").attr("onclick", "CampaignsStatsPage.clearCampHandler("+id+",1)");
			$("#clear").attr("class", "gray-button");
			$(".tr_active").removeClass("tr_active");
			$(el).addClass("tr_active");
			if(status==1){
				$("#edit").attr("href", "?page=edit_camp&id="+id);
				$("#edit").attr("class", "green-button");
				$("#delete").attr("data-href", "?page=delete_camp&camp_id="+id);
				$("#delete").attr("class", "gray-button");
				$("#delete").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
				$("#delete").attr("onclick","CampaignsStatsPage.deleteButtonHandler(this)");
			}else{
				$("#edit").attr("href", "?page=edit_camp&id="+id);
				$("#edit").attr("class", "green-button");
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
	
	//header_correlation();

});

function infoStatClick(){	
	toggleTabState(localStorage.typeStatState);
	/*toggleTypeStat();
	show_info();*/
}

/*function toggleTypeStat(){
	if($("#info_button span").html()=="Info"){
		localStorage.typeStatState = 1;
	} else {
		localStorage.typeStatState = 0;
	}
}

function show_info(){
	if(localStorage.typeStatState == 1){

		$("#info_button").html("<img src=\"templates/standart/images/w-table.png\" class=\"icon stats_icon\"><span>Stat</span>");
		$(".table_td_info").css("display","table-cell");
		$(".table_td_stat").css("display","none");
		/*$(".sort_link").each(function(i,elem) {
			$(elem).attr("href", $(elem).attr("href")+"&type_stat=1");
		});*/
	
	/*}else{
		$("#info_button").html("<img src=\"templates/standart/images/w-note.png\" class=\"icon info_icon\"><span>Info</span>");
		$(".table_td_info").css("display","none");
		$(".table_td_stat").css("display","table-cell");*/

		/*$(".sort_link").each(function(i,elem) {
			var str = $(elem).attr("href");
			str = str.replace(/\&type\_stat\=info/g, "");
			$(elem).attr("href", str);
		});*/
	/*
	}
	header_correlation();
}*/

/*
###################################
# LITTLE START OF BIG REFACTORING #
###################################
*/

function action_after_check(){

	$(".table_stat_tr").removeClass("tr_active");
		var group_camp="",
		camp_get_param = "",
		checked_camps = $(".check_camp:checked"),
		i2=checked_camps.size(),
		count_of_rows=0, count_of_deleted_rows=0;

		disabledNongroupButtons();

		checked_camps.each( function(i, el){
			group_camp=group_camp+$(el).attr("id")+",";
			group_camp=group_camp.replace("check", "");
			$(el).parent().parent().parent().addClass("tr_active");
			count_of_rows += 1;
			if ($(el).parent().parent().parent().hasClass("camp_inactive")){
				count_of_deleted_rows += 1;
			}
		});

		group_camp=group_camp.slice(0,-1);

		if (i2>1){
			camp_get_param = "camps="+group_camp;
		} else if (i2==1) {
			camp_get_param = "camp_id="+group_camp;
		}

		if(i2>0) {
			//group_camp=group_camp.substring(0, group_camp.length - 1);
			$("#report").attr("href", "?page=Stats&"+camp_get_param+"&date=<?php echo $arr_tpl['date'] ?>&date_s=<?php echo $arr_tpl['date_s'] ?>&date_e=<?php echo $arr_tpl['date_e'] ?>");
			$("#report").attr("class", "green-button");

			if (count_of_rows > count_of_deleted_rows){
				$("#delete").attr("data-href", "?page=delete_camp&"+camp_get_param);
				$("#delete").attr("class", "gray-button");
				$("#delete").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
				$("#delete").attr("onclick","CampaignsStatsPage.deleteButtonHandler(this)");
			} else if (count_of_deleted_rows>0){
				$("#delete").attr("href", "?page=restore&type_el=1&el_id="+group_camp);
				$("#delete").attr("class", "gray-button");
				$("#delete").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
				$("#delete").attr("onclick","");
			}

			$("#clear").attr("onclick", "CampaignsStatsPage.clearCampHandler('"+group_camp+"',2)");
			$("#clear").attr("class", "gray-button");

			__checkBoxChecked = true;

		} else {
			__checkBoxChecked = false;
		}
		
		if (i2 == $(".table_stat_tr").length){
			$(".check_camp_all").prop("checked", true);
		}

		if (i2==1){
			var camp_single = $(checked_camps[0]).parent().parent().parent(),
				status = (!camp_single.hasClass("camp_inactive")?1:0);
			open_buttons_for_stat_row(camp_single.attr("data-id"), status);
		}

}