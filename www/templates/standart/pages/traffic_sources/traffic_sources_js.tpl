//GLOBAL
var __pageFormat = "statistic",
	__pageType="traffic_sources";

var SourcesStatsPage = {

	deleteButtonHandler : function(object){
		deleteButtonHandler(object, "Traffic Source", "Are you sure that you want to delete this source?");
	},

	restoreButtonHandler: function(object){
		window.location = $(object).attr("data-href");
	}
}

$(window).load(function () {
	if($.getUrlVar("edit")){
		$("#ts_"+$.getUrlVar("edit")).trigger("click");
		$("#edit-src-btn").trigger("click");
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

		if (moveWindow){
			moveWindow();
		}
});


$(document).ready(function() {

	//Определение строки по которой будет идти выравнивание верхней и нижней
	var rows = document.querySelectorAll("table.table_stat tr");

	//ВЫЗЫВАЕТ ИЗ ФАЙЛА BINOMSCRIPT - ПРЕДЗАГРУЖАЕТ ШАБЛОНЫ ИСТОЧНИКОВ
	trafficSourceTemplates.getLisOfTemplatesFromServerPreLoad();

	if ('ontouchstart' in document.documentElement){
		$("#add_ts").on("touchend", ".load-templates-ts-button", trafficSourceTemplates.init());
	} else {
		$("#add_ts").on("click", ".load-templates-ts-button", trafficSourceTemplates.init());
	}

	for (var i=0; i<rows.length;i++){
		if (rows[i].style.display!="none"){
			window.line=$(rows[i]).find("td");
		}
	}

	if (typeof(window.line) == "undefined"){
		window.line=$("table.table_stat tr:first-child td");
	}

	header_correlation();

	$.ajax({
		url: "",
		type: "POST",
		data: {	"type" : "load_hour",
				"type_lh" : "5",
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
	var type_stat='<?php echo $arr_tpl['type_stat']; ?>';
	if(type_stat == '1'){
		$("#info_button").html("<img src='templates/standart/images/w-table.png' class='icon stats_icon'><span>Stat</span>");
		$(".table_td_info").css("display","table-cell");
		$(".table_td_stat").css("display","none");
		/*str=$(".sort_link").attr("href");
		str = str.replace(/\&type\_stat\=info/g, "");
		$(".sort_link").attr("href", str+"&type_stat=1");*/
		for (var i=0; i<$(".sort_link").size(); i++){
			str = $(".sort_link").eq(i).attr("href");
			str = str.replace(/\&type\_stat\=info/g, "");
			$(".sort_link").eq(i).attr("href", str+"&type_stat=1");
		}
		header_correlation();
	}
	
	$("body").on("click",".block_button #create-src-btn",function () { 
		$("#add_ts .window_head_name").html("New Traffic Source");
		$("#info_pub_t").css("display","none");
		$(".tokens_tr").css("display","none");
		//$(".win_tokens").css("height","250px");
		//$("#add_ts").css("height","300px");
		$("#ts_form input").val("");
		$(".win_tokens_check").removeAttr("checked");
		$(".win_tokens_check").removeAttr("value");

		addTokensToURL.init($(".window input[name=\'postback_url\']"), "add_ts", "ts");
		$(".token_tabl").css("height","");
		$(".token_tabl").css("overflow-y","hidden");
		$("#wrap").css("display","block");
		$("#add_ts").css("display","block");
	});

});

function edit(target){

	var id = ($(".tr_active").length==1?$(".tr_active").attr("data-id"):$(target).attr("data-id")), 
	name = $("#ts_"+id).find(".name_camp span").html();

	$.ajax({
		url: "",
		type: "POST",
		data: {"type" : "load_win_ts",
			   "id":id,
			   "ajax":"1"},
		success:function(data) { 
			$("#ts_form").html(data);
		},
		complete:function(data) {
			closeAnotherWindows();
			if($(".win_tokens_check").prop("checked")){
				$(".tokens_tr").css("display","table-row");
				//$(".win_tokens").css("height","550px");
				//$("#add_ts").css("height","590px");
			}else{
				$(".tokens_tr").css("display","none");
				//$(".win_tokens").css("height","250px");
				//$("#add_ts").css("height","300px");
			}
			
			$("#add_ts .window_head_name").html("Edit: "+name);

			addTokensToURL.init($(".window input[name=\'postback_url\']"), "add_ts", "ts");
			$("#wrap").css("display","block");
			$("#add_ts").css("display","block");
			moveWindow();
		}
	});
}

function clone(id){

	var name = $("#ts_"+id).find(".name_camp span").html();

	$.ajax({
		url: "",
		type: "POST",
		data: {"type" : "clone_load_win_ts",
			   "id":id,
			   "ajax":"1"},
		success:function(data) { 
			$("#ts_form").html(data); 
		},
		complete:function(data) {
			closeAnotherWindows();
			if($(".win_tokens_check").prop("checked")){
				$(".tokens_tr").css("display","table-row");
				//$(".win_tokens").css("height","490px");
				//$("#add_ts").css("height","590px");
			}else{
				$(".tokens_tr").css("display","none");
				//$(".win_tokens").css("height","250px");
				//$("#add_ts").css("height","300px");
			}
		
			//Вычисление номера клона
			//Регулярка - есть ли в строке (clone \d)
			var myRe = /.*\(clone\s(\d*)\)/i;
			var myArray = myRe.exec(name);
			
			//Все строки таблицы
			var rows = $(".table_stat tr .name_camp"),
				temp_name;

			//Вычленение строки без клона, по которой будет идти поиск
			if (myArray){
				temp_name = name.replace(/\(clone\s(\d*)\)/i, "");
			} else {
				temp_name = name + " ";
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
				name = name.replace(/clone\s(\d*)/, "clone "+(parseInt(clones)));
			} else {
				name = name = name +  " (clone "+(parseInt(clones))  + ")";
			}					


			$("#add_ts [name = 'name']").val(name);
			$("#add_ts .window_head_name").html("Clone: "+name);

			addTokensToURL.init($(".window input[name=\'postback_url\']"), "add_ts", "ts");
			$("#wrap").css("display","block");
			$("#add_ts").css("display","block");
			moveWindow();
		}
	});
}

function hide_button(el,status,cnt_camps){


	name = $(el).find(".name_camp span").html();


	var timedate=$("#date_filter option:selected").val();
	var date_s=$("#custom_date_pol1").val();
	var date_e=$("#custom_date_pol2").val();
	if($(el).hasClass("tr_active")){
		$(".block_button #edit-src-btn").attr("onclick", "");
		$(".block_button #edit-src-btn").attr("class", "button_inactive");
		$(".block_button #clone-src-btn").attr("onclick", "");
		$(".block_button #clone-src-btn").attr("class", "button_inactive");	
		
		$("#delete-src-btn").attr("href", "");
		$("#delete-src-btn").attr("class", "gray-button_inactive");
		$("#report").attr("href", "");
		$("#report").attr("class", "button_inactive");
		
		$(el).removeClass("tr_active");
	}else{
		var id = $(el).find("[name = 'id']").val();
		$(".tr_active").removeClass("tr_active");
		$(".block_button #edit-src-btn").attr("onclick", "edit('"+$(el).find("[name = 'id']").val()+"');");
		$(".block_button #edit-src-btn").attr("class", "green-button");

		$(".block_button #clone-src-btn").attr("onclick", "clone('"+$(el).find("[name = 'id']").val()+"');");
		$(".block_button #clone-src-btn").attr("class", "green-button");
		
		$(el).addClass("tr_active");
		
		if(cnt_camps>0){
			$("#report").attr("href", "?page=Stats&ts_id="+id+"&date="+timedate+"&date_s="+date_s+"&date_e="+date_e);
			$("#report").attr("class", "green-button");
		}else{
			$("#report").attr("href", "");
			$("#report").attr("class", "button_inactive");
		}
		
		if(status==1){
			$("#delete-src-btn").attr("data-href", "?page=del_traffic_sources&id="+id);
			$("#delete-src-btn").attr("class", "gray-button");
			$("#delete-src-btn").html("<img src='templates/standart/images/b-delete.png' class='icon delete_icon'>Delete");
			$("#delete-src-btn").attr("onclick","SourcesStatsPage.deleteButtonHandler(this);");
		}else{
			$("#delete-src-btn").attr("data-href", "?page=restore&type_el=5&el="+id);
			$("#delete-src-btn").attr("class", "gray-button");
			$("#delete-src-btn").html("<img src='templates/standart/images/b-restore.png' class='icon restore_icon'>Restore");
			$("#delete-src-btn").attr("onclick","SourcesStatsPage.restoreButtonHandler(this)");
		}
	}
}

function infoStatClick(){
	toggleTypeStat();
	show_info();
	

}

function toggleTypeStat(){
	if($("#info_button span").html()=="Info"){
		$("#act-form input[name=type_stat]").val(1);
	} else {
		$("#act-form input[name=type_stat]").val(0);
	}
}

function show_info(){
	if($("#info_button span").html()=="Info"){
		$("#info_button").html("<img src=\"templates/standart/images/w-table.png\" class=\"icon stats_icon\"><span>Stat</span>");
		$(".table_td_info").css("display","table-cell");
		$(".table_td_stat").css("display","none");
		$(".sort_link").each(function(i,elem) {
			$(elem).attr("href", $(elem).attr("href")+"&type_stat=1");
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
	header_correlation();
}