// GLOBAL
var __pageFormat = "statistic",
	__pageType = "offers";

var OffersStatsPage = {

	deleteButtonHandler : function(object){
		deleteButtonHandler(object, "Offer", "Are you sure that you want to delete this offer?");
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
		$("#offer_"+$.getUrlVar("edit")).trigger("click");
		$("#edit-offer-btn").trigger("click");
	}
});

// GLOBAL VARIABLE
var __checkBoxChecked = false;


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
				"type_lh" : "3",
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
	
	var type_stat='<?php echo $arr_tpl['type_stat'] ?>';
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

	$("body").on("click",".block_button #create-offer-btn",function () { 
		$.ajax({
			url: "",
			type: "POST",
			data: {"type" : "load_group_of",
				   "ajax":"1"},
			success:function(data) { 
				$("#add_of [name = of_group]").html("<option selected value='0'></option>"+data+"<option value='add'>Add new</option>");
			}
		});
		
		$("#add_of input").val("");
		$("#add_of select").val("");
		$("#add_of .window_head_name").html("New offer");
		
		addTokensToURL.init($("input[name=\'of_url\']"), "add_of", "of");
		addCheckButtonToURL.init("input[name=of_url]");
		$("#wrap").css("display","block");
		$("#add_of").css("display","block");
	});

		$("body").on("click",".block_button #create-lp-btn",function () { 
		var xhr = $.ajax({
			url: "",
			type: "POST",
			data: {"type" : "load_group_lp",
				   "ajax":"1"},
			success:function(data) { 
				$("#add_lp [name = lp_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
			}
		});
		
		$("#add_lp input").val("");
		$("#add_lp select").val("");
		$("#add_lp .window_head_name").html("New landing");
		addTokensToURL.init($("input[name=\'lp_url\']"), "add_lp", "lp");
		addCheckButtonToURL.init("input[name=of_url]");
		$("#wrap").css("display","block");
		$("#add_lp").css("display","block");
	});


	$("body").on("change",".check_offer",function () {
		
		action_after_check();

	});


	$("body").on("change",".check_offer_all",function () {
		disabledNongroupButtons();

		$(".table_stat_tr").removeClass("tr_active");
		var group_offer="", count_of_rows=0, count_of_deleted_rows=0;
		if($(this).prop("checked")==true){

			$(".check_offer").each(function(i, el){

				if ($(el).parent().parent().parent().css("display") != "none") {
					group_offer=group_offer+$(el).attr("id")+",";
					group_offer=group_offer.replace("check", "");
					$(el).parent().parent().parent().addClass("tr_active");
					$(el).prop("checked","true");
					count_of_rows += 1;
					if ($(el).parent().parent().parent().hasClass("camp_inactive")){
						count_of_deleted_rows += 1;
					}
				}

			});
			
			group_offer=group_offer.substring(0, group_offer.length - 1);
			//????
			if (count_of_rows > count_of_deleted_rows){
				$("#delete-offer-btn").attr("data-href", "?page=del_offer&ids="+group_offer);
				$("#delete-offer-btn").attr("class", "gray-button");
				$("#delete-offer-btn").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
				$("#delete-offer-btn").attr("onclick","OffersStatsPage.deleteButtonHandler(this);");
			} else if (count_of_deleted_rows>0) {
				$("#delete-offer-btn").attr("data-href", "?page=restore&type_el=3&el_id="+group_offer);
				$("#delete-offer-btn").attr("class", "gray-button");
				$("#delete-offer-btn").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
				$("#delete-offer-btn").attr("onclick","OffersStatsPage.restoreButtonHandler(this)");
			}
			hide_nongroup_buttons();
			__checkBoxChecked = true;
		}else{
			__checkBoxChecked = false;
			$(".check_offer").each(function(i, el){
				$(el).parent().parent().parent().removeClass("tr_active");
				$(el).prop("checked","");
			});
		}
	});

});

function open_buttons_for_stat_row(id, status){

	$(".block_button #clone-offer-btn").attr("class", "green-button");
			
	//$(".block_button #clone-offer-btn").attr("onclick", "clone('"+$(el).find("[name = 'name']").val()+"','"+$(el).find("[name = 'url']").val()+"','"+$(el).find("[name = 'network']").val()+"','"+$(el).find("[name = 'payout']").val()+"','"+$(el).find("[name = 'status']").val()+"','"+$(el).find("[name = 'geo']").val()+"','"+$(el).find("[name = 'group_of']").val()+"','"+$(el).find("[name = 'auto_payout']").val()+"','"+$(el).find("[name = 'cap']").val()+"');");
	$(".block_button #clone-offer-btn").attr("onclick", "clone()");

	//$(".block_button #edit-offer-btn").attr("onclick", "edit('"+$(el).find("[name = 'id']").val()+"','"+$(el).find("[name = 'name']").val()+"','"+$(el).find("[name = 'url']").val()+"','"+$(el).find("[name = 'network']").val()+"','"+$(el).find("[name = 'payout']").val()+"','"+$(el).find("[name = 'status']").val()+"','"+$(el).find("[name = 'geo']").val()+"','"+$(el).find("[name = 'group_of']").val()+"','"+$(el).find("[name = 'auto_payout']").val()+"','"+$(el).find("[name = 'cap']").val()+"','"+$(el).find("[name = 'upsell']").val()+"');");
	$(".block_button #edit-offer-btn").attr("onclick", "edit()");

	$(".block_button #edit-offer-btn").attr("class", "green-button");

	$("#note").attr("onclick", "show_window_node()");
	$("#note").attr("class", "green-button");
	
	
	if(status==1){
		$("#delete-offer-btn").attr("data-href", "?page=del_offer&id="+id);
		$("#delete-offer-btn").attr("class", "gray-button");
		$("#delete-offer-btn").html("<img src='templates/standart/images/b-delete.png' class='icon delete_icon'>Delete");
		$("#delete-offer-btn").attr("onclick","OffersStatsPage.deleteButtonHandler(this);");
	}else{
		$("#delete-offer-btn").attr("data-href", "?page=restore&type_el=3&el="+id);
		$("#delete-offer-btn").attr("class", "gray-button");
		$("#delete-offer-btn").html("<img src='templates/standart/images/b-restore.png' class='icon restore_icon'>Restore");
		$("#delete-offer-btn").attr("onclick","OffersStatsPage.restoreButtonHandler(this)");
		
	}

}

function get_options_from_active_row(id){

	var offer_row,
		options = {};

	if (id!==undefined){
		offer_row = $(".table_stat .table_stat_tr#offer_"+id);
	} else {
		offer_row = $(".table_stat .table_stat_tr.tr_active");
		if (offer_row.length>1){
			return false;
		}
	}

	options["id"] = offer_row.find("[name=id]").val();
	options["name"] = offer_row.find("[name=name]").val();
	options["url"] = offer_row.find("[name=url]").val();
	options["network"] = offer_row.find("[name=network]").val();
	options["payout"] = offer_row.find("[name=payout]").val();
	options["status"] = offer_row.find("[name=status]").val();
	options["geo"] = offer_row.find("[name=geo]").val();
	options["group_of"] = offer_row.find("[name=group_of]").val();
	options["auto_payout"] = offer_row.find("[name=auto_payout]").val();
	options["upsell"] = offer_row.find("[name=upsell]").val();
	options["cap"] = offer_row.find("[name=cap]").val();
	return options;
}

function setZclipOnCopyBtn(){
	$("#copy_postback_url").zclip({
	    path:"templates/standart/js/jquery-zclip/ZeroClipboard.swf",
	    copy:$("#postback_url").val(),
	    beforeCopy:function(){
	    },
	    afterCopy:function(){
	        $("#copy_postback_url").addClass("blue-button");
	        $("#copy_postback_url").html("Done");
	        setTimeout(function(){
	        	$("#copy_postback_url").removeClass("blue-button");
	      		$("#copy_postback_url").html("Copy");
	        },2000);
	    }
	});
}

function addCopyFuncTobutton() {

	if (!FlashDetect.installed){
		try {
			new Clipboard("#copy_postback_url");
			$("#copy_postback_url").replaceWith( $("<button class='green-button' id='copy_postback_url' href='javascript:' data-clipboard-target='#postback_url'>Copy</button>") );
		} catch (e){
			$("#url_input").css({'width':'100%'});
		}

	} else {
		setZclipOnCopyBtn();
	}

}

//function edit(id, name, url, network, payout, status, geo, group_of, auto_payout, cap, upsell){
function edit(id){
	var of_options = get_options_from_active_row(id);

	if (of_options==false){
		return;
	}

	$.ajax({
		url: "",
		type: "POST",
		data: {"type" : "load_group_of",
			   "ajax":"1"},
		success:function(data) { 
			$("#add_of [name = of_group]").html("<option selected value=''></option>"+data+"<option value='add'>Add new</option>");
		},
		complete:function(data) { 
			closeAnotherWindows();
			$("[name = 'of_name']").val(of_options["name"]);
			$("[name = 'of_url']").val(of_options["url"]);
			$("[name = 'of_pay']").val(Math.ceil((of_options["payout"])*1000)/1000);
			$("[name = 'geo_of'] [value='"+of_options["geo"]+"']").prop("selected", true);
			$("[name = 'of_group'] [value='"+of_options["group_of"]+"']").prop("selected", true);
			$("[name = 'of_networks'] [value='"+of_options["network"]+"']").prop("selected", true);

			//Выставление значения инпута постбека из хранящегосе в option'e в data-value постбек
			var postback_url = $("[name=of_networks] option:selected").attr("data-postback-url");
			if (postback_url!="" && typeof postback_url != "undefined"){
				$("#add_of .postback_url_offer_field").css("display", "block");
				$("[name=postback_url]").val(postback_url);
			} else {
				$("#add_of .postback_url_offer_field").css("display", "none");
			}
				
			
			$("#add_of .window_head_name").html("Edit: "+of_options["name"]);
			$("#add_of [name = win_of_id]").val(of_options["id"]);
			
			if(of_options["upsell"]=="1"){
				$("[name = upsell]").prop("checked", true);
			}else{
				$("[name = upsell]").prop("checked", false);
			}
			
			if(of_options["auto_payout"]=="1"){
				$("#add_of [name = of_pay]").attr("disabled", true);
				$("#add_of [name = of_pay]").addClass("input_inactive");
				$("[name = auto_pay]").prop("checked", true);
			}else{
				$("#add_of [name = of_pay]").attr("disabled", false);
				$("#add_of [name = of_pay]").removeClass("input_inactive");
				$("[name = auto_pay]").prop("checked", false);
			}
			
			if(of_options["cap"] == "1"){
				$("[name = cap_enabled]").prop("checked", true);
				$("#add_of [name = of_cap]").attr("disabled",false );
				$("#add_of [name = of_cap]").removeClass("input_inactive");
			}else{
				$("[name = cap_enabled]").prop("checked", false);
				$("#add_of [name = of_cap]").attr("disabled",true );
				$("#add_of [name = of_cap]").addClass("input_inactive");
			}
			
			addTokensToURL.init($("input[name=\'of_url\']"), "add_of", "of");
			addCheckButtonToURL.init("input[name=of_url]");
			$("#wrap").css("display","block");
			$("#add_of").css("display","block");

			addCopyFuncTobutton();

		}
	});
}

//function clone(name, url, network, payout, status, geo, group_of, auto_payout, cap){
function clone (){
	var of_options = get_options_from_active_row();

	if (of_options==false){
		return;
	}

	$.ajax({
		url: "",
		type: "POST",
		data: {"type" : "load_group_of",
			   "ajax":"1"},
		success:function(data) { 
			$("#add_of [name = of_group]").html("<option selected value=''></option>"+data+"<option value='add'>Add new</option>");
		},
		complete:function(data) { 
			closeAnotherWindows();
			//Вычисление номера клона
			//Регулярка - есть ли в строке (clone \d)
			var myRe = /.*\(clone\s(\d*)\)/i;
			var myArray = myRe.exec(of_options["name"]);
			
			//Все строки таблицы
			var rows = $(".table_stat tr .name_camp"),
				temp_name;

			//Вычленение строки без клона, по которой будет идти поиск
			if (myArray){
				temp_name = of_options["name"].replace(/\(clone\s(\d*)\)/i, "");
			} else {
				temp_name = of_options["name"] + " ";
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
				of_options["name"] = of_options["name"].replace(/clone\s(\d*)/, "clone "+(parseInt(clones)));
			} else {
				of_options["name"] = of_options["name"] = of_options["name"] +  " (clone " + parseInt(clones)  + ")" ;
			}	
			
			$("[name='win_of_id']").val("");
			$("[name = 'of_name']").val(of_options["name"]);
			$("[name = 'of_url']").val(of_options["url"]);
			$("[name = 'of_pay']").val(Math.ceil((of_options["payout"])*1000)/1000);
			$("[name = 'geo_of'] [value='"+of_options["geo"]+"']").prop("selected", true);
			$("[name = 'of_group'] [value='"+of_options["group_of"]+"']").prop("selected", true);
			$("[name = 'of_networks'] [value='"+of_options["network"]+"']").prop("selected", true);
			//Выставление значения инпута постбека из хранящегосе в option'e в data-value постбек
			var postback_url = $("[name=of_networks] option:selected").attr("data-postback-url");
			if (postback_url!="" && typeof postback_url != "undefined"){
				$("#add_of .postback_url_offer_field").css("display", "block");
				$("[name=postback_url]").val(postback_url);
			} else {
				$("#add_of .postback_url_offer_field").css("display", "none");
			}
			$("#add_of .window_head_name").html("Edit: "+of_options["name"]);
			/*$("#add_of [name = win_of_id]").val(id);*/
				
			
			if(of_options["auto_payout"]=="1"){
				$("#add_of [name = of_pay]").attr("disabled", true);
				$("#add_of [name = of_pay]").addClass("input_inactive");
				$("[name = auto_pay]").prop("checked", true);
			}else{
				$("#add_of [name = of_pay]").attr("disabled", false);
				$("#add_of [name = of_pay]").removeClass("input_inactive");
				$("[name = auto_pay]").prop("checked", false);
			}
			
			if(of_options["cap"] == "1"){
				$("[name = cap_enabled]").prop("checked", true);
				$("#add_of [name = of_cap]").attr("disabled",false );
				$("#add_of [name = of_cap]").removeClass("input_inactive");
			}else{
				$("[name = cap_enabled]").prop("checked", false);
				$("#add_of [name = of_cap]").attr("disabled",true );
				$("#add_of [name = of_cap]").addClass("input_inactive");
			}
			
			addTokensToURL.init($("input[name=\'of_url\']"), "add_of", "of");
			addCheckButtonToURL.init("input[name=of_url]");
			$("#wrap").css("display","block");
			$("#add_of").css("display","block");

			addCopyFuncTobutton();

		}
	});
}

function hide_button(el, status){
	if (__checkBoxChecked==true){
		return;
	} else {
		if($(el).hasClass("tr_active")){
			$(".block_button #edit-offer-btn").attr("onclick", "");
			$(".block_button #edit-offer-btn").attr("class", "button_inactive");
			$(".block_button #clone-offer-btn").attr("onclick", "");
			$(".block_button #clone-offer-btn").attr("class", "button_inactive");		

			$("#note").attr("onclick", "");
			$("#note").attr("class", "button_inactive");

			$("#delete-offer-btn").removeAttr("data-href", "");
			$("#delete-offer-btn").removeAttr("onclick", "");
			$("#delete-offer-btn").attr("class", "gray-button_inactive");						
			$(el).removeClass("tr_active");
		}else{
			var id = $(el).find("[name = 'id']").val();
			$(".tr_active").removeClass("tr_active");

			open_buttons_for_stat_row(id, status);
			
			$(el).addClass("tr_active");

		}
	}
}

function hide_nongroup_buttons(){

	$(".block_button #edit-offer-btn").attr("onclick", "");
	$(".block_button #edit-offer-btn").attr("class", "button_inactive");
	$(".block_button #clone-offer-btn").attr("onclick", "");
	$(".block_button #clone-offer-btn").attr("class", "button_inactive");

}

function show_window_node(){
	var id = $(".tr_active").attr("data-id");
	noteWindow.init(id, 'offer');
	noteWindowTokens.init("#node_text");
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

function action_after_check(){

	$(".table_stat_tr").removeClass("tr_active");
	var group_offer="",
	offer_get_param = "",
	checked_offers = $(".check_offer:checked"),
	i2=checked_offers.size(),
	count_of_rows=0, count_of_deleted_rows=0;

	disabledNongroupButtons();

	checked_offers.each( function(i, el){
		group_offer=group_offer+$(el).attr("id")+",";
		group_offer=group_offer.replace("check", "");
		$(el).parent().parent().parent().addClass("tr_active");
		count_of_rows += 1;
		if ($(el).parent().parent().parent().hasClass("camp_inactive")){
			count_of_deleted_rows += 1;
		}
	});

	group_offer=group_offer.slice(0,-1);

	if (i2>1){
		offer_get_param = "ids="+group_offer;
	} else if (i2==1) {
		offer_get_param = "ids="+group_offer;
	}

	if(i2>0){
		if (count_of_rows > count_of_deleted_rows){
			$("#delete-offer-btn").attr("data-href", "?page=del_offer&"+offer_get_param);
			$("#delete-offer-btn").attr("class", "gray-button");
			$("#delete-offer-btn").html("<img src=\'templates/standart/images/b-delete.png\' class=\'icon delete_icon\'>Delete");
			$("#delete-offer-btn").attr("onclick","OffersStatsPage.deleteButtonHandler(this);");
		} else if (count_of_deleted_rows>0) {
			$("#delete-offer-btn").attr("data-href", "?page=restore&type_el=3&el_id="+group_offer);
			$("#delete-offer-btn").attr("class", "gray-button");
			$("#delete-offer-btn").html("<img src=\'templates/standart/images/b-restore.png\' class=\'icon restore_icon\'>Restore");
			$("#delete-offer-btn").attr("onclick","OffersStatsPage.restoreButtonHandler(this)");
		} 
		hide_nongroup_buttons();
		__checkBoxChecked = true;
	} else {
		__checkBoxChecked = false;
	}

	if (i2==1){
		var offer_single = $(checked_offers[0]).parent().parent().parent(),
			status = (!offer_single.hasClass("camp_inactive")?1:0);
		open_buttons_for_stat_row(offer_single.attr("data-id"), status);
	}

}