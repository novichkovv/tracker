// GLOBAL
var __checkBoxChecked=false,
	__pageFormat = "statistic",
	__pageType = "landing_pages";

var LandingsStatsPage = {

	deleteButtonHandler : function(object){
		deleteButtonHandler(object, "Landing Page", "Are you sure that you want to delete this landing?");
	},
	restoreButtonHandler: function(object){
		window.location = $(object).attr("data-href");
	}
}

$(window).load(function () {
	if($.getUrlVar("edit")){
		$("#land_"+$.getUrlVar("edit")).trigger("click");
		$("#edit-lp-btn").trigger("click");
	}
});

function addZclip(caller, target){
	$(caller).zclip({
		path:"templates/standart/js/jquery-zclip/ZeroClipboard.swf",
		copy:$(target).val(),
		beforeCopy:function(){
		},
		afterCopy:function(){
			$(caller).addClass("blue-button");
			$(caller).html("Done");
			setTimeout(function(){
				$(caller).removeClass("blue-button");
				$(caller).html("Copy");
			},2000);
		}
	});
}


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

$(document).ready(function() {

	//Определение строки по которой будет идти выравнивание верхней и нижней
	var rows = document.querySelectorAll("table.table_stat tr");
	
	for (var i=0; i<rows.length;i++){
		if (rows[i].style.display!="none"){
			window.line=$(rows[i]).find("td");
		}
	}

	if (typeof(window.line) == "undefined"){
		window.line=$("table.table_stat tr:first-child td");
	}

	//header_correlation();


	$.ajax({
		url: "",
		type: "POST",
		data: {	"type" : "load_hour",
				"type_lh" : "2",
				"ajax":"1"
		},
		success:function(data) { 
			var myRe = /\<el\>(.*?)\<\/el\>+/g;
			var myRe2 = /\<el_id\>(.*)\<\/el_id\>/;
			var ReClh = /\<CLH\>(.*)\<\/CLH\>/;
			var Rellh = /\<LLH\>(.*)\<\/LLH\>/;
			var Replh = /\<PLH\>(.*)\<\/PLH\>/;
			var Replh2 = /\<PLH2\>(.*)\<\/PLH2\>/;
			var Rell = /\<LL\>(.*)\<\/LL\>/;
			
			while ((arr_all = myRe.exec(data)) != null) {
				var el_id =  myRe2.exec(arr_all[1]);
				el_id = el_id[1];
				//заменяем данные
				if(<?php echo $arr_tpl['show_profit'] ?> !== 1){
					var ll2 = Rell.exec(arr_all[1]);
					$("#last_lead_"+el_id).html(ll2[1]);
					$("#last_lead_"+el_id).attr("class","table_td_info");
					var clh = ReClh.exec(arr_all[1]);
					$("#clh_"+el_id).html(clh[1]);
					$("#clh_"+el_id).attr("class","table_td_info");
					var llh = Rellh.exec(arr_all[1]);
					$("#llh_"+el_id).html(llh[1]);
					$("#llh_"+el_id).attr("class","table_td_info");
					var plh = Replh.exec(arr_all[1]);
					$("#plh_"+el_id).html(plh[1]);
					$("#plh_"+el_id).attr("class","table_td_info");
					
					var plh2 = Replh2.exec(arr_all[1]);
					if(plh2[1]>0){
						$("#plh_"+el_id).addClass("color_stat_1");
					}else{
						if(plh2[1]=0){
							$("#plh_"+el_id).addClass("color_stat_2");
						}else{
							$("#plh_"+el_id).addClass("color_stat_3");
						}
					}
				}else{
					var clh = ReClh.exec(arr_all[1]);
					$("#clh_"+el_id).html(clh[1]);
					$("#clh_"+el_id).attr("class","table_td_info");
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


	$("body").on("click",".block_button #create-lp-btn",function () { 
		$.ajax({
			url: "",
			type: "POST",
			data: {"type" : "load_group_lp",
				   "ajax":"1"},
			success:function(data) { 
				$("#add_lp [name = lp_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
			}
		});
		
		lp_protect=$("[name=lp_protect]").val();
		
		$("#add_lp input").val("");
		
		$("[name=lp_protect]").val(lp_protect);
		
		$("#add_lp select").val("");
		$("#add_lp .window_head_name").html("New landing");

		$("#wrap").css("display","block");
		$("#add_lp").css("display","block");
		
		//сброс загрузчика
		$("#land_block_2").css("display","none");
		$("#land_block_1").css("display","block");
		$("#lp_protect_span").css("display","block");
		$("#lp_protect_input").css("display","block");
		$("#lp_type").val("1");
		$("#download_land").css("display","block");
		$("input[name=lp_file]").css("display","none");
		
		addTokensToURL.init($("input[name=\'lp_url\']"), "add_lp", "lp");
		addCheckButtonToURL.init("input[name=lp_url]");
		
		addZclip("#copy_btn10", "#copy_value10");
	});


	$("body").on("change",".check_land",function () {
		
		action_after_check();

	});


	$("body").on("change",".check_land_all",function () {

		disabledNongroupButtons();

		$(".table_stat_tr").removeClass("tr_active");
		var group_land="", count_of_rows=0, count_of_deleted_rows=0;

		if($(this).prop("checked")==true){
			hide_nongroup_buttons();
			$(".check_land").each(function(i, el){

				if ($(el).parent().parent().parent().css("display") != "none") {
					group_land=group_land+$(el).attr("id")+",";
					group_land=group_land.replace("check", "");
					$(el).parent().parent().parent().addClass("tr_active");
					$(el).prop("checked","true");
					count_of_rows += 1;
					if ($(el).parent().parent().parent().hasClass("camp_inactive")){
						count_of_deleted_rows += 1;
					}
				}

			});

			group_land=group_land.substring(0, group_land.length - 1);

			if (count_of_rows > count_of_deleted_rows){
				$("#delete-lp-btn").attr("data-href", "?page=del_lp&ids="+group_land);
				$("#delete-lp-btn").attr("class", "gray-button");
				$("#delete-lp-btn").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
				$("#delete-lp-btn").attr("onclick","LandingsStatsPage.deleteButtonHandler(this);");
			} else if (count_of_deleted_rows>0) {
				$("#delete-lp-btn").attr("data-href", "?page=restore&type_el=2&el_id="+group_land);
				$("#delete-lp-btn").attr("class", "gray-button");
				$("#delete-lp-btn").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
				$("#delete-lp-btn").attr("onclick","LandingsStatsPage.restoreButtonHandler(this)");
			}
			__checkBoxChecked = true;
		}else{
			$(".check_land").each(function(i, el){
				$(el).parent().parent().parent().removeClass("tr_active");
				$(el).prop("checked","");
			});
			__checkBoxChecked = false;
		}
	});

});

function clone(){
	var lp_options = get_options_from_active_row();
	if (lp_options==false){
		return;
	}
	$.ajax({
		url: "",
		type: "POST",
		data: {"type" : "load_group_lp",
			   "ajax":"1"},
		success:function(data) { 
			$("#add_lp [name = lp_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
		},
		complete:function(data) { 
			closeAnotherWindows();
			//Вычисление номера клона
			//Регулярка - есть ли в строке (clone \d)
			var myRe = /.*\(clone\s(\d*)\)/i;
			var myArray = myRe.exec(lp_options["name"]);
			
			//Все строки таблицы
			var rows = $(".table_stat tr .name_camp"),
				temp_name;

			//Вычленение строки без клона, по которой будет идти поиск
			if (myArray){
				temp_name = lp_options["name"].replace(/\(clone\s(\d*)\)/i, "");
			} else {
				temp_name = lp_options["name"] + " ";
			}

			//Экранирование строки поиска
			var name_re = temp_name.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
			//Составление регекспа для поиска клонов
			clon_re = new RegExp(name_re + "\\(clone \\d*\\)");

			//Счетчик количества клонов
			var clones = 1;
			//Поиск клонов построчно
			for (var i=0;i<rows.length;i++){
				clone_match = clon_re.exec($(rows[i]).html());
				if (clone_match){
					clones += 1;	
				}
			}

			//Составление конечного имени клона
			if (myArray){
				lp_options["name"] = lp_options["name"].replace(/clone\s(\d*)/, "clone "+(parseInt(clones)));
			} else {
				lp_options["name"] = lp_options["name"] = lp_options["name"] +  " (clone "+(parseInt(clones))  + ")";
			}	
			
			$("#add_lp [name=lp_file]").prop("readonly", true);
            $("#add_lp [name=lp_file]").addClass("readonly_input");
			$("[name=\'win_lp_id\']").val("");
			$("[name = \'lp_name\']").val(lp_options["name"]);
			if (lp_options["lp_type"]!=2){
				$("[name = \'lp_url\']").val(lp_options["url"]);
			} else {
				$("[name = \'lp_file\']").val(lp_options["url"]);
				$("[name = \'lp_file\']").css("display", "block");
			}
			$("[name = \'lp_type\']").val(lp_options["lp_type"]);
			$("[name = \'lang_lp\'] [value=\'"+lp_options["lang"]+"\']").prop("selected", true);
			$("[name = \'lp_group\'] [value=\'"+lp_options["group_lp"]+"\']").prop("selected", true);

			$(".window [name=\'offers\']").val(lp_options["offers"]);

			$("#add_lp .window_head_name").html("Edit: "+lp_options["name"]);


			
			
			if(lp_options["lp_type"]==2){
                $("#lp_protect_span").css("display","none");
                $("#lp_protect_input").css("display","none");
                $("#land_block_1").css("display","none");
                $("#land_block_2").css("display","block");
                $("#lp_file_block").css("display","block");
                $("#download_land").css("display","none");
                $("#lp_type").val("2");
                addCheckButtonToURL.init("input[name=lp_file]", true);
            } else {
                $("#land_block_2").css("display","none");
                $("#lp_file_block").css("display","none");
                $("#lp_protect_span").css("display","block");
                $("#lp_protect_input").css("display","block");
                $("#land_block_1").css("display","block");
                $("#lp_type").val("1");
                addTokensToURL.init( $("#add_lp input[name=\'lp_url\']") , "add_lp", "lp");
                addCheckButtonToURL.init("input[name=lp_url]");
            }
			closeAnotherWindows();
			$("#wrap").css("display","block");
			$("#add_lp").css("display","block");
			addZclip("#copy_btn10", "#copy_value10");
		}
	});
}

function get_options_from_active_row(id){
	var land_row,
		options = {};
	if (id!==undefined){
		land_row = $(".table_stat .table_stat_tr#land_"+id);
	} else {
		land_row = $(".table_stat .table_stat_tr.tr_active");
		if (land_row.length>1){
			return false;
		}
	}

	options["id"] = land_row.find("[name=id]").val();
	options["lp_type"] = land_row.find("[name=tlp_type]").val();
	options["name"] = land_row.find("[name=name]").val();
	options["url"] = land_row.find("[name=url]").val();
	options["status"] = land_row.find("[name=status]").val();
	options["lang"] = land_row.find("[name=lang]").val();
	options["group_lp"] = land_row.find("[name=group_lp]").val();
	options["offers"] = land_row.find("[name=offers_lp]").val();
	return options;
}

//function edit(id, name, url, status, lang, group_lp, offers){
function edit(id){

	var lp_options = get_options_from_active_row(id);
	if (lp_options==false){
		return;
	}
	$.ajax({
		url: "",
		type: "POST",
		data: {"type" : "load_group_lp",
			   "ajax":"1"},
		success:function(data) { 
			$("#add_lp [name = lp_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
		},
		complete:function(data) { 
			closeAnotherWindows();
			$("[name = \'lp_name\']").val(lp_options["name"]);
			$("[name = \'lp_type\']").val(lp_options["lp_type"]);
			$("#lp_type").val(lp_options["lp_type"]);
			if (lp_options["lp_type"]!=2){
				$("[name = \'lp_url\']").val(lp_options["url"]);
			} else {
				$("[name = \'lp_file\']").val(lp_options["url"]);
				$("[name = \'lp_file\']").css("display", "block");
			}
			$("[name = \'offers\']").val(lp_options["offers"]);
			$("[name = \'lang_lp\'] [value=\'"+lp_options["lang"]+"\']").prop("selected", true);
			$("[name = \'lp_group\'] [value=\'"+lp_options["group_lp"]+"\']").prop("selected", true);

			$("#add_lp [name = win_lp_id]").val(lp_options["id"]);

			$("#add_lp .window_head_name").html("Edit: "+lp_options["name"]);
			$("#add_lp [name=lp_file]").prop("readonly", true);
            $("#add_lp [name=lp_file]").addClass("readonly_input");

			if(lp_options["lp_type"]==2){
                $("#lp_protect_span").css("display","none");
                $("#lp_protect_input").css("display","none");
                $("#land_block_1").css("display","none");
                $("#land_block_2").css("display","block");
                $("#lp_file_block").css("display","block");
                $("#download_land").css("display","none");
                $("#lp_type").val("2");
                addCheckButtonToURL.init("input[name=lp_file]", true);
            } else {
                $("#land_block_2").css("display","none");
                $("#lp_file_block").css("display","none");
                $("#lp_protect_span").css("display","block");
                $("#lp_protect_input").css("display","block");
                $("#land_block_1").css("display","block");
                $("#lp_type").val("1");
                addTokensToURL.init( $("#add_lp input[name=\'lp_url\']") , "add_lp", "lp");
                addCheckButtonToURL.init("input[name=lp_url]");
            }
			
			
			$("#wrap").css("display","block");
			$("#add_lp").css("display","block");
			// addCheckButtonToURL.init("input[name=lp_file]", true);
			addZclip("#copy_btn10", "#copy_value10");
		}
	});
}

function open_buttons_for_stat_row(id, status){

	$("#note").attr("onclick", "show_window_node()");
	$("#note").attr("class", "green-button");
	
	$(".block_button #clone-lp-btn").attr("class", "green-button");
	
	$(".block_button #clone-lp-btn").attr("onclick", "clone()");

	$(".block_button #edit-lp-btn").attr("onclick", "edit()");

	$(".block_button #edit-lp-btn").attr("class", "green-button");

	if(status==1){
		$("#delete-lp-btn").attr("data-href", "?page=del_lp&id="+id);
		$("#delete-lp-btn").attr("class", "gray-button");
		$("#delete-lp-btn").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
		$("#delete-lp-btn").attr("onclick","LandingsStatsPage.deleteButtonHandler(this);");
	}else{
		$("#delete-lp-btn").attr("data-href", "?page=restore&type_el=2&el="+id);
		$("#delete-lp-btn").attr("class", "gray-button");
		$("#delete-lp-btn").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
		$("#delete-lp-btn").attr("onclick","LandingsStatsPage.restoreButtonHandler(this)");
	}
}

function hide_button(el, status){
	// __checkBoxChecked is global variable.
	// true if at least one checkbox is checked 
	if (__checkBoxChecked == true ){
	} else {
		var id = $(el).attr("data-id");

		if($(el).hasClass("tr_active")){

			$(".block_button #edit-lp-btn").attr("onclick", "");
			$(".block_button #edit-lp-btn").attr("class", "button_inactive");
			
			$(".block_button #clone-lp-btn").attr("onclick", "");
			$(".block_button #clone-lp-btn").attr("class", "button_inactive");
					
			$("#note").attr("onclick", "");
			$("#note").attr("class", "button_inactive");

			$("#delete-lp-btn").removeAttr("href", "");
			$("#delete-lp-btn").attr("onclick", "");
			$("#delete-lp-btn").attr("class", "gray-button_inactive");
			
			$(el).removeClass("tr_active");
		}else{
			var id = $(el).find("[name = \'id\']").val();
			$(".table_stat_tr").removeClass("tr_active");
			open_buttons_for_stat_row(id, status);
			$(el).addClass("tr_active");
		}
	}
}

function hide_nongroup_buttons(){

	$(".block_button #edit-lp-btn").attr("onclick", "");
	$(".block_button #edit-lp-btn").attr("class", "button_inactive");
	$(".block_button #clone-lp-btn").attr("onclick", "");
	$(".block_button #clone-lp-btn").attr("class", "button_inactive");

}

function infoStatClick(){
	/*toggleTypeStat();
	show_info();*/
}

function toggleTypeStat(){
	if($("#info_button span").html()=="Info"){
		localStorage.typeStatState = 1;
	} else {
		localStorage.typeStatState = 0;
	}
}


function show_window_node(id){
	var id = $(".tr_active").attr("data-id");
	noteWindow.init(id, 'landing');
}

function action_after_check(){
	$(".table_stat_tr").removeClass("tr_active");
	var group_land="",
	land_get_param = "",
	checked_lands = $(".check_land:checked"),
	i2=checked_lands.size(),
	count_of_rows=0, count_of_deleted_rows=0;

	disabledNongroupButtons();

	checked_lands.each( function(i, el){
		group_land=group_land+$(el).attr("id")+",";
		group_land=group_land.replace("check", "");
		$(el).parent().parent().parent().addClass("tr_active");
		count_of_rows += 1;
		if ($(el).parent().parent().parent().hasClass("camp_inactive")){
			count_of_deleted_rows += 1;
		}
	});

	group_land=group_land.slice(0,-1);

	//?????
	if (i2>1){
		land_get_param = "ids="+group_land;
	} else if (i2==1) {
		land_get_param = "id="+group_land;
	}
	//????

	if(i2>0){
		hide_nongroup_buttons();
		if (count_of_rows > count_of_deleted_rows){
			//group_land=group_land.substring(0, group_land.length - 1);
			$("#delete-lp-btn").attr("data-href", "?page=del_lp&"+land_get_param);
			$("#delete-lp-btn").attr("class", "gray-button");
			$("#delete-lp-btn").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
			$("#delete-lp-btn").attr("onclick","LandingsStatsPage.deleteButtonHandler(this);");
		} else if (count_of_deleted_rows > 0) {
			$("#delete-lp-btn").attr("data-href", "?page=restore&type_el=2&el_id="+group_land);
			$("#delete-lp-btn").attr("class", "gray-button");
			$("#delete-lp-btn").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
			$("#delete-lp-btn").attr("onclick","LandingsStatsPage.restoreButtonHandler(this)");
		}
		__checkBoxChecked = true;
	} else {
		__checkBoxChecked = false;
	}
	if (i2==1){
		var land_single = $(checked_lands[0]).parent().parent().parent(),
			status = (!land_single.hasClass("camp_inactive")?1:0);
		open_buttons_for_stat_row(land_single.attr("data-id"), status);
	}
}