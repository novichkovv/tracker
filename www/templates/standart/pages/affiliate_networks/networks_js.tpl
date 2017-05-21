//GLOBAL
var __pageFormat = "statistic",
	__pageType = "networks";

var NetworksStatsPage = {
	
	deleteButtonHandler : function(object){
		deleteButtonHandler(object, "Affiliate Network", "Are you sure that you want to delete this network?");
	},
	restoreButtonHandler: function(object){
		window.location = $(object).attr("data-href");
	}
	
}

//preload checkbox image for using it later
var saveCheckboxImage = new Image();
saveCheckboxImage.src = "./templates/standart/images/check_in_box.png";

$(window).load(function () {
	if($.getUrlVar("edit")){
		$("#network_"+$.getUrlVar("edit")).trigger("click");
		$("#edit-aff-btn").trigger("click");
	}
});

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


$(window).resize(function(){ 

	header_correlation();
		
});


$(document).ready(function() {

	//Определение строки по которой будет идти выравнивание верхней и нижней
	var rows = document.querySelectorAll("table.table_stat tr");


	setGlobalWindowLine();
	header_correlation();

	$.ajax({
		url: "",
		type: "POST",
		data: {	"type" : "load_hour",
				"type_lh" : "4",
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
		$("[name = 'search_name']").css("width","140px");
	}else{
		$("#custom_date").css("display","none");
		$("[name = 'search_name']").css("width","200px");
	}
	if($.getUrlVar("date")=="10" || $.cookie("date") == "10"){
		$("#custom_date_pol1").datetimepicker({format:"Y-m-d | H:i", defaultTime: "00:00", timepicker: true});
		$("#custom_date_pol2").datetimepicker({format:"Y-m-d | H:i", defaultTime: "23:59", timepicker: true});
	}
	if($.getUrlVar("date")=="12" || $.cookie("date") == "12"){
		$("#custom_date_pol1").datetimepicker({format:"Y-m-d", timepicker: false});
		$("#custom_date_pol2").datetimepicker({format:"Y-m-d", timepicker: false});
	}
	/*var type_stat='<?php echo $arr_tpl['type_stat']; ?>';
	if(type_stat == '1'){
		$("#info_button").html("<img src='templates/standart/images/w-table.png' class='icon stats_icon'><span>Stat</span>");
		$(".table_td_info").css("display","table-cell");
		$(".table_td_stat").css("display","none");
		/*str=$(".sort_link").attr("href");
		str = str.replace(/\&type\_stat\=info/g, "");
		$(".sort_link").attr("href", str+"&type_stat=1");*/

		/*for (var i=0; i<$(".sort_link").size(); i++){
			str = $(".sort_link").eq(i).attr("href");
			str = str.replace(/\&type\_stat\=info/g, "");
			$(".sort_link").eq(i).attr("href", str+"&type_stat=1");
		}

		header_correlation();
	}*/
	
	$("body").on("click",".block_button #create-aff-btn", function () { 
		$("#add_net input").val("");
		$("#add_net .window_head_name").html("New Affiliate Network");
		$("#wrap").css("display","block");
		$("#add_net").css("display","block");
		NetworkWindowStatusPayoutOptions.init($("#add_net"), "create");
	});
});

function get_options_from_active_row(id){
	var camp_row,
		options = {};

	if (id!==undefined){
		camp_row = $(".table_stat .table_stat_tr#network_"+id);
	} else {
		camp_row = $(".table_stat .table_stat_tr.tr_active");
	}
	options["id"] = camp_row.find("[name=id]").val();
	options["name"] = camp_row.find("[name=name]").val();

	options["postback_url"] = camp_row.find("[name=postback_url]").val();
	if (options["postback_url"]==0){
		options["postback_url"] = "";
	}
	return options;
}

//function edit(id, name){
function edit(id){
	closeAnotherWindows();
	var an_options = get_options_from_active_row(id);

	$("#add_net [name = 'name']").val(an_options["name"]);
	$("#add_net [name = 'postback_url']").val(an_options["postback_url"]);
	$("#add_net [name = 'win_net_id']").val(an_options["id"]);
	$("#add_net .window_head_name").html("Edit: "+an_options["name"]);
	$("#wrap").css("display","block");
	$("#add_net").css("display","block");
	NetworkWindowStatusPayoutOptions.init($("#add_net"), "edit");
}

//function clone(name){
function clone(){
	closeAnotherWindows();
		//Вычисление номера клона
		//Регулярка - есть ли в строке (clone \d)
		var an_options = get_options_from_active_row(),
			myRe = /.*\(clone\s(\d*)\)/i,
			myArray = myRe.exec(an_options["name"]),
		
		//Все строки таблицы
			rows = $(".table_stat tr .name_camp"),
			temp_name;
			

		//Вычленение строки без клона, по которой будет идти поиск
		if (myArray){
			temp_name = an_options["name"].replace(/\(clone\s(\d*)\)/i, "");
		} else {
			temp_name = an_options["name"] + " ";
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
			an_options["name"] = an_options["name"].replace(/clone\s(\d*)/, "clone "+(parseInt(clones)));
		} else {
			an_options["name"] = an_options["name"] = an_options["name"] +  " (clone "+(parseInt(clones))  + ")";
		}	
	$("#add_net [name = 'name']").val(an_options["name"]);
	$("#add_net [name = 'postback_url']").val(an_options["postback_url"]);
	$("#add_net .window_head_name").html("Edit: "+an_options["name"]);
	$("#wrap").css("display","block");
	$("#add_net").css("display","block");
	console.log("an_options " );
	console.log(an_options );
	NetworkWindowStatusPayoutOptions.init($("#add_net"), "edit", an_options["id"]);
}



function hide_button(el,status){
	if($(el).hasClass("tr_active")){
		$(".block_button #edit-aff-btn").attr("onclick", "");
		$(".block_button #edit-aff-btn").attr("class", "button_inactive");
		$(".block_button #clone-aff-btn").attr("onclick", "");
		$(".block_button #clone-aff-btn").attr("class", "button_inactive");	
		$("#delete").attr("href", "");
		$("#delete").attr("class", "gray-button_inactive");
		
		$(el).removeClass("tr_active");
	}else{
		var id = $(el).find("[name = 'id']").val();
		$(".tr_active").removeClass("tr_active");
		//$(".block_button #edit-aff-btn").attr("onclick", "edit('"+$(el).find("[name = 'id']").val()+"', '"+$(el).find("[name = 'name']").val()+"');");

		$(".block_button #edit-aff-btn").attr("onclick", "edit()");
		$(".block_button #edit-aff-btn").attr("class", "green-button");
		$(".block_button #clone-aff-btn").attr("class", "green-button");

		//$(".block_button #clone-aff-btn").attr("onclick", "clone('"+$(el).find("[name = 'name']").val()+"');");
		$(".block_button #clone-aff-btn").attr("onclick", "clone()");
		
		
		$(el).addClass("tr_active");
		
		if(status==1){
			$("#delete-aff-btn").attr("data-href", "?page=del_networks&id="+id);
			$("#delete-aff-btn").attr("class", "gray-button");
			$("#delete-aff-btn").html("<img src='templates/standart/images/b-delete.png' class='icon delete_icon'>Delete");
			$("#delete-aff-btn").attr("onclick","NetworksStatsPage.deleteButtonHandler(this);");
		}else{
			$("#delete-aff-btn").attr("data-href", "?page=restore&type_el=4&el="+id);
			$("#delete-aff-btn").attr("class", "gray-button");
			$("#delete-aff-btn").html("<img src='templates/standart/images/b-restore.png' class='icon restore_icon'>Restore");
			$("#delete-aff-btn").attr("onclick","NetworksStatsPage.restoreButtonHandler(this)");
		}
	}
}

function infoStatClick(){
	toggleTypeStat();
	show_info();
	

}

function toggleTypeStat(){
	if($("#info_button span").html()=="Info"){
		localStorage.typeStatState = 1;
	} else {
		localStorage.typeStatState = 0;
	}
}

function show_info(){
	if (localStorage.typeStatState==1){
		$("#info_button").html("<img src=\"templates/standart/images/w-table.png\" class=\"icon stats_icon\"><span>Stat</span>");
		$(".table_td_info").css("display","table-cell");
		$(".table_td_stat").css("display","none");
		/*$(".sort_link").each(function(i,elem) {
			$(elem).attr("href", $(elem).attr("href")+"&type_stat=1");
		});*/
	}else{
		$("#info_button").html("<img src=\"templates/standart/images/w-note.png\" class=\"icon info_icon\"><span>Info</span>");
		$(".table_td_info").css("display","none");
		$(".table_td_stat").css("display","table-cell");
		/*$(".sort_link").each(function(i,elem) {
			var str = $(elem).attr("href");
			str = str.replace(/\&type\_stat\=info/g, "");
			$(elem).attr("href", str);
		});*/
	}
	header_correlation();
}