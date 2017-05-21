<script>

//GLOBAL
var __pageFormat = "report",
	__pageType = "report";

$(window).load(function () {
	$("#group1 [value = '<?php echo $arr_tpl['group1'] ?>']").prop("selected", true);
	$("#group2 [value = '<?php echo $arr_tpl['group2'] ?>']").prop("selected", true);
	$("#group3 [value = '<?php echo $arr_tpl['group3'] ?>']").prop("selected", true);
	$(".datetime_timezone [value = '<?php if($arr_tpl['timezone']==0){echo '+0';}else{echo $arr_tpl['timezone'];} ?>']").prop("selected", true);
});

function drilldown_close(){
	if(getURLParameter("camp_id")){
		window.location.href = "?page=Stats&date_e="+
			getURLParameter("date_e")+
			"&date_s="+getURLParameter("date_s")+
			"&date="+getURLParameter("date")+
			"&camp_id="+getURLParameter("camp_id")+
			"&group1="+$("#group1").val()+
			"&group2="+$("#group2").val()+
			"&group3="+$("#group3").val();
	}else{
		if(getURLParameter("camps")){
			window.location.href = "?page=Stats&date_e="+
				getURLParameter("date_e")+
				"&date_s="+getURLParameter("date_s")+
				"&date="+getURLParameter("date")+
				"&camps="+getURLParameter("camps")+
				"&group1="+$("#group1").val()+
				"&group2="+$("#group2").val()+
				"&group3="+$("#group3").val();
		}else{
			window.location.href = "?page=Stats&date_e="+
				getURLParameter("date_e")+"&date_s="+
				getURLParameter("date_s")+"&date="+
				getURLParameter("date")+"&ts_id="+
				"&group1="+$("#group1").val()+
				"&group2="+$("#group2").val()+
				"&group3="+$("#group3").val();
		}
	}
}

function drilldown(){
	var arr=[];
	var arr1 = [];
	var arr2 = [];
	var arr3 = [];
	var group_number;
	$(".tr_active .start_name").each(function() {
		if($(this).parent().hasClass("table_stat_name_1")){
			arr1.push($(this).html());
		}
		if($(this).parent().hasClass("table_stat_name_2")){
			arr2.push($(this).html());
		}
		if($(this).parent().hasClass("table_stat_name_3")){
			arr3.push($(this).html());
		}
	});
	if(arr1.length>0){
		arr = arr1;
		group_number=1;
	}else{
		if(arr2.length>0){
			arr = arr2;
			group_number=2;
		}else{
			if(arr3.length>0){
				arr = arr3;
				group_number=3;
			}else{
			
			}
		}
	}
	var group2=3;
	if($("#group"+group_number).val()==3){
		group2=4;
	}
	var arr_json=JSON.stringify(arr);
	$.ajax({
		url : "",
		method: "post",
		data: {
			"ajax_type":"write",
			"type":"drilldown",
			"data":arr_json,
			"group":$("#group"+group_number).val(),
			"ajax":"1"
		}
	}).success(function(data){
		if(getURLParameter("camp_id")){
			window.location.href = "?page=Stats&date_e="+getURLParameter("date_e")+"&date_s="+getURLParameter("date_s")+"&date="+getURLParameter("date")+"&camp_id="+getURLParameter("camp_id")+"&drilldown="+$("#group"+group_number).val()+"&group2="+group2+"&group3=1";
		}else{
			if(getURLParameter("camps")){
				window.location.href = "?page=Stats&date_e="+getURLParameter("date_e")+"&date_s="+getURLParameter("date_s")+"&date="+getURLParameter("date")+"&camps="+getURLParameter("camps")+"&drilldown="+$("#group"+group_number).val()+"&group2="+group2+"&group3=1";
			}else{
				window.location.href = "?page=Stats&date_e="+getURLParameter("date_e")+"&date_s="+getURLParameter("date_s")+"&date="+getURLParameter("date")+"&ts_id="+getURLParameter("ts_id")+"&drilldown="+$("#group"+group_number).val()+"&group2="+group2+"&group3=1";
			}
		}
	});
}


formattingSettings = {};
formattingSettings["lp_ctr"]=' <?php echo $arr_tpl["round_settings"]['lp_ctr']['val'] ?>';
formattingSettings["cr"]=' <?php echo $arr_tpl["round_settings"]['cr']['val'] ?>';
formattingSettings["epc"]=' <?php echo $arr_tpl["round_settings"]['epc']['val'] ?>';
formattingSettings["cpc"]=' <?php echo $arr_tpl["round_settings"]['cpc']['val'] ?>';
formattingSettings["revenue"]=' <?php echo $arr_tpl["round_settings"]['revenue']['val'] ?>';
formattingSettings["cost"]=' <?php echo $arr_tpl["round_settings"]['cost']['val'] ?>';
formattingSettings["profit"]=' <?php echo $arr_tpl["round_settings"]['profit']['val'] ?>';
formattingSettings["roi"]=' <?php echo $arr_tpl["round_settings"]['roi']['val'] ?>';

var __sumValuesOfChosenLines = {
	clicks: 0,
	lp_clicks: 0,
	leads: 0,
	revenue: 0,
	clicks_to_lp: 0,
	cost: 0,
	profit: 0,
},

 __chosenTakenTromSumRows = []

__sumFooter = {},
__countOfGroups = 1;


// Add to prototype object method for deleting element of self
// by value of element
Array.prototype.remove = function(value) {
    var idx = this.indexOf(value);
    if (idx != -1) {
        // Второй параметр - число элементов, которые необходимо удалить
        return this.splice(idx, 1);
    }
    return false;
}

function getURLParameter(name) {
	return decodeURI(
	(RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1] || ''	
	);
}

function getCountOfGroups(){
	var group1 = getURLParameter("group1"),
		group2 = getURLParameter("group2"),
		group3 = getURLParameter("group3"),
		count_of_groups = 0;

	//If condition is true its mean default grouping is choosen
	if ( (group1 == ""|| group1=="1") && (group2 == ""|| group2=="1") && (group3 == ""|| group3=="1") ){
		var group1_cookie = $.cookie("group1"),
			group2_cookie = $.cookie("group2"),
			group3_cookie = $.cookie("group3"), cookie_groups=false;
		if (group1_cookie != "" && group1_cookie!="1"){
			cookie_groups = true;
			count_of_groups +=1;
		}
		if (group2_cookie != "" && group2_cookie!="1"){
			cookie_groups = true;
			count_of_groups +=1;
		}
		if (group3_cookie != "" && group3_cookie!="1"){
			cookie_groups = true;
			count_of_groups +=1;
		}
		if (cookie_groups){
			return count_of_groups
		} else {
			return 3;
		}
		
	} 

	if (group1 != "" && group1!="1"){
		count_of_groups +=1;
	}
	if (group2 != "" && group2!="1"){
		count_of_groups +=1;
	}
	if (group3 != "" && group3!="1"){
		count_of_groups +=1;
	}
	return count_of_groups;

}

/*function getCountOfGroups(){
	var count = 0;
	if ($("#group1")!="1"){
 		count += 1;
	}
	if ($("#group2")!="1"){
 		count += 1;
	}
	if ($("#group3")!="1"){
 		count += 1;
	}
	return count;
}*/

function enter_date_report(value){
	if($(value).val()=="10" || $(value).val()=="12"){
		if($(value).val()=="12"){
			$("#custom_date_pol1").datetimepicker({format:"Y-m-d", timepicker: false});
			$("#custom_date_pol2").datetimepicker({format:"Y-m-d", timepicker: false});
			var custom_val_1=$("#custom_date_pol1").val().replace(/\s\|.*/,"");
			var custom_val_2=$("#custom_date_pol2").val().replace(/\s\|.*/,"");
		}else{
			$("#custom_date_pol1").datetimepicker({format:"Y-m-d | H:i", defaultTime: "00:00", timepicker: true});
			$("#custom_date_pol2").datetimepicker({format:"Y-m-d | H:i", defaultTime: "23:59", timepicker: true});
			if($("#custom_date_pol1").val().indexOf("|")<0){
				var custom_val_1=$("#custom_date_pol1").val()+" | 00:00";
				var custom_val_2=$("#custom_date_pol2").val()+" | 00:00";
			}else{
				var custom_val_1=$("#custom_date_pol1").val();
				var custom_val_2=$("#custom_date_pol2").val();
			}
		}
		$("#custom_date_pol1").val(custom_val_1);
		$("#custom_date_pol2").val(custom_val_2);
		$("#custom_date").css("display","block");
		$("[name = 'search_name']").css("width","140px");
	}else{
		$("#custom_date").css("display","none");
		$("[name = 'search_name']").css("width","200px");
	}

	if ($(value).val()=="12"){
		$("#custom_date").addClass("narrow_date_input");
	} else {
		$("#custom_date").removeClass("narrow_date_input");
	}
}


function header_correlation(){

	$("table.table_stat tr:first-child td").each(function(i,elem) { 
		w=$(elem).width();
		minw=$(elem).css("min-width");
		pleft=$(elem).css("padding-left");
		pright=$(elem).css("padding-right");
		//$("#hrow"+(i+1)).width(w);
		$("#hrow"+(i+1)).css("min-width",w);
		$("#hrow"+(i+1)).css("max-width",w);
		$("#hrow"+(i+1)).css("padding-left",pleft);
		$("#hrow"+(i+1)).css("padding-right",pright);
		//$("#frow"+(i+1)).width(w);	
		$("#frow"+(i+1)).css("min-width",w);
		$("#frow"+(i+1)).css("max-width",w);
		$("#frow"+(i+1)).css("padding-left",pleft);
		$("#frow"+(i+1)).css("padding-right",pright);
	});
	$(".body-container").height(window.innerHeight-$(".body-container").offset().top-45);
}

$(window).resize(function(){ 

	header_correlation();

});

function clearFromCommas(number_string){
	if (number_string!==undefined){
		return number_string.replace(/,/g, "");
	}
}

function addCommas(number_string){
	if (number_string!==undefined){
		return number_string.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
}

//row - jqobject of table row
function getValuesFromRow(row){
	var values = {};
	values["clicks"] = parseInt(clearFromCommas(row.find("td:nth-child(2)").html()));
	values["lp_clicks"] = parseInt(clearFromCommas(row.find("td:nth-child(3)").html()));
	values["leads"] = parseInt(clearFromCommas(row.find("td:nth-child(5)").html()));

	var rev = row.find("td:nth-child(9)").html();
	if (rev === undefined){

		rev = '0';
	}
	values["revenue"] = parseFloat(clearFromCommas(rev.replace("$","")));
	values["cost"] = parseFloat(clearFromCommas(row.find("td:nth-child(10)").html().replace("$","")));
	var profit  = row.find("td:nth-child(11)").html();
	if (profit===undefined){
		profit = '0';
	}
	values["profit"]    = parseFloat(clearFromCommas(profit.replace("$","")));
	values["lp_ctr"]    = parseFloat(clearFromCommas(row.find("td:nth-child(4)").html().replace("%","")));
	if (values["lp_clicks"]==0){
		values["clicks_to_lp"] = 0;
	} else {
		values["clicks_to_lp"] = Math.round(100*values["lp_clicks"]/values["lp_ctr"]);
	}
	return values;
}

//return string
function addDollarSignToNumber(number){
	if (number<0) {
		return "-"+"$"+number.replace("-", "");
	} else {
		number = number.replace("-", "");
		return "$" + number;
	}
}



//values - obj with values that was returned by getValuesFromRow
function addToSumOfChosenRows(object, values){
	object["clicks"] += values["clicks"];
	object["lp_clicks"] += values["lp_clicks"];
	object["leads"] += values["leads"];
	object["revenue"] += values["revenue"];
	object["cost"] += values["cost"];
	object["profit"] += values["profit"];
	object["clicks_to_lp"] += values["clicks_to_lp"];
	return object;
}

//values - obj with values that was returned by getValuesFromRow
function removeFromSumOfChosenRows(object, values){
	object["clicks"] -= values["clicks"];
	object["lp_clicks"] -= values["lp_clicks"];
	object["leads"] -= values["leads"];
	object["revenue"] -= values["revenue"];
	object["cost"] -= values["cost"];
	object["profit"] -= values["profit"];
	object["clicks_to_lp"] -= values["clicks_to_lp"];
	return object;
}

function calcRemovedValuesFromFooter(values_obj){
	var footer_obj= {};
	footer_obj['clicks'] = __sumFooter["clicks"] - values_obj["clicks"];
	footer_obj['lp_clicks'] = __sumFooter["lp_clicks"] - values_obj["lp_clicks"];
	footer_obj['leads'] = __sumFooter["leads"] - values_obj["leads"];
	footer_obj['rev'] = (__sumFooter["revenue"] - values_obj["revenue"]).toFixed(formattingSettings["revenue"]);
	footer_obj['spend'] = (__sumFooter["cost"] - values_obj["cost"]).toFixed(formattingSettings["cost"]);
	footer_obj['profit'] = (__sumFooter["profit"] - values_obj["profit"]).toFixed(formattingSettings["profit"]);
	footer_obj['clicks_to_lp'] = (__sumFooter["clicks_to_lp"] - values_obj["clicks_to_lp"]);
	return footer_obj;
}

function calcAddValuesToFooter(values_obj){
	var footer_obj= {};
	footer_obj['clicks'] = __sumFooter["clicks"] + values_obj["clicks"];
	footer_obj['lp_clicks'] = __sumFooter["lp_clicks"] + values_obj["lp_clicks"];
	footer_obj['leads'] = __sumFooter["leads"] + values_obj["leads"];
	footer_obj['rev'] = (__sumFooter["revenue"] + values_obj["revenue"]).toFixed(formattingSettings["revenue"]);
	footer_obj['spend'] = (__sumFooter["cost"] + values_obj["cost"]).toFixed(formattingSettings["cost"]);
	footer_obj['profit'] = (__sumFooter["profit"] + values_obj["profit"]).toFixed(formattingSettings["profit"]);
	footer_obj['clicks_to_lp'] = (__sumFooter["clicks_to_lp"] + values_obj["clicks_to_lp"]);
	return footer_obj;
}

function setDrawValuesToFooter(footer_values_obj){
	var cr, cpc, epc;

	if (footer_values_obj == 0){
		footer_values_obj = {};
		footer_values_obj['clicks'] 		= 0;
		footer_values_obj['lp_clicks'] 		= 0;
		footer_values_obj['leads'] 			= 0;
		footer_values_obj['rev'] 			= 0;
		footer_values_obj['spend'] 			= 0;
		footer_values_obj['profit'] 		= 0;
		footer_values_obj['clicks_to_lp'] 	= 0;
	}

	if (footer_values_obj['clicks'] > 0){
		cr  = (footer_values_obj['leads']/footer_values_obj['clicks']*100).toFixed(formattingSettings["cr"]) + "%";
		cpc = "$"+(footer_values_obj['spend']/footer_values_obj['clicks']).toFixed(formattingSettings["cpc"]);
		epc = "$"+(footer_values_obj['rev']/footer_values_obj['clicks']).toFixed(formattingSettings["epc"]);
	} else if (footer_values_obj['clicks'] == 0){
		cpc ="$"+(0).toFixed(formattingSettings["cpc"]);
		epc = "$"+(0).toFixed(formattingSettings["epc"]);
		cr  = (0).toFixed(formattingSettings["cr"]) + "%";
	}
	if (footer_values_obj['spend']==0){
		roi = (0).toFixed(formattingSettings["roi"])+"%";
	} else {
		roi = ((parseFloat(footer_values_obj['profit'])/parseFloat(footer_values_obj['spend']))*100).toFixed(formattingSettings["roi"]) + "%";
	}

	if (footer_values_obj['clicks_to_lp']>0){
		lp_ctr = (footer_values_obj['lp_clicks']/footer_values_obj['clicks_to_lp']*100).toFixed(formattingSettings["lp_ctr"]) + "%";
	} else {
		var temp = 0;
		lp_ctr = temp.toFixed(formattingSettings["lp_ctr"]) + "%";
	}

	//Подкрашивание профита
	$(".sum_footer_profit").removeClass("color_stat_1").removeClass("color_stat_2").removeClass("color_stat_3");

	if (footer_values_obj['profit']>0){
		$(".sum_footer_profit").addClass("color_stat_1");
	} else if(footer_values_obj['profit']==0){
		$(".sum_footer_profit").addClass("color_stat_2");
	} else {
		$(".sum_footer_profit").addClass("color_stat_3");
	}

	$(".sum_footer_roi").removeClass("color_stat_1").removeClass("color_stat_2").removeClass("color_stat_3");

	if (footer_values_obj['profit']>0){
		$(".sum_footer_roi").addClass("color_stat_1");
	} else if(footer_values_obj['profit']==0){
		$(".sum_footer_roi").addClass("color_stat_2");
	} else {
		$(".sum_footer_roi").addClass("color_stat_3");
	}

	$(".sum_footer_clicks").html(addCommas(footer_values_obj['clicks']));
	$(".sum_footer_lp_clicks").html(addCommas(footer_values_obj['lp_clicks']));

	$(".sum_footer_lp_ctr").html(lp_ctr);
	$(".sum_footer_leads").html(addCommas(footer_values_obj['leads']));

	$(".sum_footer_cr").html(cr);
	$(".sum_footer_epc").html(epc);
	$(".sum_footer_cpc").html(cpc);
	$(".sum_footer_roi").html(roi);

	if (footer_values_obj['rev']<0){
		footer_values_obj['rev'] = 0;
	}

	if (footer_values_obj['spend']<0){
		footer_values_obj['spend'] = 0;
	}

	$(".sum_footer_revenue").html(addDollarSignToNumber( footer_values_obj['rev'].toString().addCommaSeparatorFloat() ));
	$(".sum_footer_spend").html(addDollarSignToNumber( footer_values_obj['spend'].toString().addCommaSeparatorFloat() ));
	$(".sum_footer_profit").html(addDollarSignToNumber( footer_values_obj['profit'].toString()).addCommaSeparatorFloat());

}

function removeValuesFromFooter(values_obj){
	calcSumFooter();
	var values_to_footer = calcRemovedValuesFromFooter(values_obj);
	setDrawValuesToFooter(values_to_footer);
}

function addValuesToFooter(values_obj){
	calcSumFooter();
	var values_to_footer = calcAddValuesToFooter(values_obj);
	setDrawValuesToFooter(values_to_footer);
}


function getRowLevel(id){
	return id.toString().split("_").length - 1;
}



/**
	@id string id
 	@return boolean false/true
 */
function haveParent(id){
	var level = getRowLevel(id);
	if (level != 1){
		return true;
	} else {
		return false;
	}
}

/**
	@id string id
 	@return boolean false/true
 */
function haveChildren(id){
	var level = getRowLevel(id);
	if (level == __countOfGroups){
		return false;
	} 
	return true;
}

function isChild(idp, idc){

	if (idc.indexOf(idp) != -1){
		return true;
	} else {
		return false;
	}
}

/**
  @row: jqobject of row
  @return array of rows - jqobjects
 */
 //Тоже работает только для третьей группировки
function getChildrenRows(row){
	var is_children = true, 
		children = new Array(), 
		next_row, 
		row_id = row.attr("id"),
		next_row_id = "",
		counter = 0;
	next_row = row;
	while (is_children){
		next_row = next_row.next();
		if (next_row.size() == 0){
			break;
		}
		next_row_id = next_row.attr("id");

		if (isChild(row_id, next_row_id)){
			children.push(next_row);
		} else {
			break;
		} 
	}
	return children;
}

// @row: jqobject of row
function getParentsRows(row){

	var row_id = row.attr("id"), 
		row_id_splitted = row_id.split("_"),   
		parent1_id, 
		parent2_id;

	if (getRowLevel(row_id) == 3){
		parent1_id = row_id_splitted[0]+"_"+row_id_splitted[1];
		parent2_id = row_id_splitted[0]+"_"+row_id_splitted[1]+"_"+row_id_splitted[2];
		return [$("#"+parent1_id), $("#"+parent2_id)];
	} else if (getRowLevel(row_id) == 2) {
		parent1_id = row_id_splitted[0]+"_"+row_id_splitted[1];
		return [$("#"+parent1_id)];
	}

}

function getNearestParent(row){
	var row_id = row.attr("id"), 
	row_id_splitted = row_id.split("_"),   
	parent1_id, 
	parent2_id;

	if (getRowLevel(row_id) == 3){
		parent1_id = row_id_splitted[0]+"_"+row_id_splitted[1]+"_"+row_id_splitted[2];
		return $("#"+parent1_id);
	} else if (getRowLevel(row_id) == 2) {
		parent1_id = row_id_splitted[0]+"_"+row_id_splitted[1];
		return $("#"+parent1_id);
	} else {
		return false;
	}
}

function getSiblings(row){
	var row_id = row.attr("id"), 
	counter = 1, 
	row_level = getRowLevel(row_id),
	id_temp,
	splitted = row_id.split("_"),
	siblings = new Array(),
	sibling_obj,
	prev_sibl,
	prev_sibl_id,
	next_sibl,
	next_sibl_id;

	// Работает только на строках третьего уровня
	// TODO добавить для второго, хз пока как
	if (row_level == __countOfGroups){
		prev_sibl = row;
		while (true){
			
			prev_sibl = prev_sibl.prev();
			prev_sibl_id = prev_sibl.attr("id");
			if (prev_sibl.size()==0){
				break;
			}
			if (isSiblings(prev_sibl_id, row_id)){
				siblings.push(prev_sibl);
			} else {
				break;
			}
			counter ++;
		}
		next_sibl = row;
		while (true){
			
			next_sibl = next_sibl.next();
			next_sibl_id = next_sibl.attr("id");
			if (next_sibl.size()==0){
				break;
			}
			if (isSiblings(next_sibl_id, row_id)){
				siblings.push(next_sibl);
			} else {
				break;
			}
			counter ++;
		}
		return siblings;
	}
	return false;
}

function getAllSiblingsForSecondLevelOnThreeGroups(row){
	var row_id = row.attr("id"),
		parent = getNearestParent(row),
		parent_id = parent.attr("id"),
		next_row = parent,
		next_row_id,
		siblings = new Array(),
		counter = 0;


	while(true && counter<50){
		counter ++;
		next_row = next_row.next();
		next_row_id = next_row.attr("id");
		if (next_row.size()==0){
			break;
		}
		if (getRowLevel(next_row_id)==2 && isChild(parent_id, next_row_id)){
			siblings.push(next_row);
		}
		if (isSiblings(next_row_id, parent_id)){
			break;
		}
	}
	return siblings;

}	

/**
	@row1 - string row id
	@row2 - string row id
*/
function isSiblings(row1, row2){
	var level_row1 = getRowLevel(row1),
		level_row2 = getRowLevel(row2);

	if (level_row1 != level_row2){
		return false;
	} else {
		row1_sp = row1.split("_");
		row2_sp = row2.split("_");
		if (level_row1 =1 ){
			return true;
		}
		if (level_row1 == 2){
			if (row1_sp[0]+"_"+row1_sp[1] == row2_sp[0]+"_"+row2_sp[1]){
				return true;
			} 
		}
		if (level_row1 == 3){
			if (row1_sp[0]+"_"+row1_sp[1]+"_"+row1_sp[2] == row2_sp[0]+"_"+row2_sp[1]+"_"+row2_sp[2]){
				return true;
			} 
		}
	}

}



function getFarestCheckedChildren(row){

	var row_id = row.attr("id"),
		row_level = getRowLevel(row_id),
		next_row,
		children = new Array(),
		counter = 0;;

	next_row = row;
	while (true){
		next_row = next_row.next();
		next_row_id = next_row.attr("id");
		if (next_row.size()==0){
			break;
		}
		if (isSiblings(row_id, next_row_id) || (row_level > getRowLevel(next_row_id)) ){
			break;
		} else if (isChild(row_id, next_row_id) && getRowLevel(next_row_id) == __countOfGroups) {
			if (next_row.hasClass("tr_active")){
				children.push(next_row);
			}
		} 
	}
	return children;


}

function getAllFarestChildren(row){
	var row_id = row.attr("id"),
		row_level = getRowLevel(row_id),
		next_row,
		children = new Array(),
		counter = 0;;

	next_row = row;
	while (true){
		next_row = next_row.next();
		next_row_id = next_row.attr("id");
		if (next_row.size()==0){
			break;
		}
		if (isSiblings(row_id, next_row_id) || (row_level > getRowLevel(next_row_id)) ){
			break;
		} else if (isChild(row_id, next_row_id) && getRowLevel(next_row_id) == __countOfGroups) {
			children.push(next_row);
		} 
	}
	return children;
}

// @row: jqobject of row
function markParent(row){

}

function checkSiblingChecked(row){
}

function markAllChildrenRows(row){
	children = getChildrenRows(row);
	for (i = 0; i<children.length; i++){
		if (!children[i].hasClass("tr_active")){
			children[i].addClass("tr_active");
		}
	}
}


function unmarkAllChildrenRows(row){
	children = getChildrenRows(row);
	for (i = 0; i<children.length; i++){
		if (children[i].hasClass("tr_active")){
			children[i].removeClass("tr_active");
		}
	}
}

function unMarkAllParents(row){
	parents = getParentsRows(row);
	for (i = 0; i<parents.length; i++){
		if (parents[i].hasClass("tr_active")){
			parents[i].removeClass("tr_active");
		}
	}
}

function checkAllSiblingsMarked(siblings){
	var siblings_len = siblings.length,
		counter = 0;

	for (var i=0;i<siblings_len;i++){
		if (siblings[i].hasClass("tr_active")){
			counter += 1;
		}
	}

	if (counter == siblings_len){
		return true;
	} else {
		return false;
	}

}
// ##########################################
/**
	@row jq-object of clickd row
	@toggle string ["on", "off"] determine action - add row to choose or vice versa
*/
function makeChooseRowAction(row, toggle){
	var row_values = getValuesFromRow(row), 
	row_id= row.attr("id"), 
	children,
	j,
	siblings,
	nearest_parent,
	addRemoveObject = {

		"clicks":0,
		"lp_clicks":0,
		"leads":0,
		"revenue":0,
		"cost":0,
		"profit":0,
		"clicks_to_lp" : 0

	};

	if (__countOfGroups!=1){
		
		if (toggle == "on"){
			if (haveChildren(row_id)){

				var marked_children = getFarestCheckedChildren(row), values;

				for (var i = 0; i<marked_children.length;i++){
					values = {};
					values = getValuesFromRow(marked_children[i]);
					addRemoveObject = addToSumOfChosenRows(addRemoveObject, values);
					
				}

				addValuesToFooter(addRemoveObject);

				addRemoveObject = {

					"clicks":0,
					"lp_clicks":0,
					"leads":0,
					"revenue":0,
					"cost":0,
					"profit":0,
					"clicks_to_lp" : 0

				}

				var farest_children = getAllFarestChildren(row);
				for (var i = 0; i<farest_children.length;i++){
					values = {};
					values = getValuesFromRow(farest_children[i]);
					addRemoveObject = removeFromSumOfChosenRows(addRemoveObject, values);
				}
				addValuesToFooter(addRemoveObject);
				markAllChildrenRows(row);

			}

			if (haveParent(row_id)){
				siblings = getSiblings(row);

				if (checkAllSiblingsMarked(siblings)){
					nearest_parent = getNearestParent(row);
					if (nearest_parent){
						nearest_parent.addClass("tr_active");

						if (getRowLevel(nearest_parent.attr("id"))==2 && __countOfGroups==3){
							siblings = getAllSiblingsForSecondLevelOnThreeGroups(nearest_parent);
							if (checkAllSiblingsMarked(siblings)){
								last_parent = getNearestParent(nearest_parent);
								if (last_parent){
									last_parent.addClass("tr_active");
								}
							}
						}

					}
				}

				if (getRowLevel(row_id)==2 && __countOfGroups==3){
					siblings = getAllSiblingsForSecondLevelOnThreeGroups(row);
					if (checkAllSiblingsMarked(siblings)){
						last_parent = getNearestParent(row);
						if (last_parent){
							last_parent.addClass("tr_active");
						}
					}
				}

			}
			if (getRowLevel(row_id) == __countOfGroups){
				removeValuesFromFooter(row_values);
			}
		} else {
			if (haveParent(row_id)){
				unMarkAllParents(row);
			}
			if (haveChildren(row_id)){
				var farest_children = getAllFarestChildren(row),
				addRemoveObject = {
					"clicks":0,
					"lp_clicks":0,
					"leads":0,
					"revenue":0,
					"cost":0,
					"profit":0,
					"clicks_to_lp" : 0
				};
				for (var i = 0; i<farest_children.length;i++){
					values = {};
					values = getValuesFromRow(farest_children[i]);
					
					addRemoveObject = addToSumOfChosenRows(addRemoveObject, values);
	
				}
				addValuesToFooter(addRemoveObject);
				unmarkAllChildrenRows(row);
			}
			if (getRowLevel(row_id) == __countOfGroups){
				addValuesToFooter(row_values);
			}
			
		}

	} else {
		if (toggle == "on"){
			removeValuesFromFooter(row_values)
		} else {
			addValuesToFooter(row_values);
		}
	}
	if ($(".table_stat tr").size() == $(".table_stat tr.tr_active").size()){
		// 0 means clear footer
		setDrawValuesToFooter(0);
	}
}

//row - is jquery obj of reports row
function makeCalcChosenRows(row){

	var values = getValuesFromRow(row);
	if (row.hasClass("tr_active")){
		row.removeClass("tr_active");
		//removeFromSumOfChosenRows(values);
		makeChooseRowAction(row, "off");
		//__chosen_taken_from_sum_rows.remove(row.attr("id"));
	} else {
		row.addClass("tr_active");
		//addToSumOfChosenRows(values);
		makeChooseRowAction(row, "on");
		//__chosenTakenTromSumRows.push(row.attr("id"));
	}
	
	//removeValuesFromFooter();
}

function calcSumFooter(){
	__sumFooter["clicks"] = parseInt(clearFromCommas($(".sum_footer_clicks").html()));
	__sumFooter["lp_clicks"] = parseInt(clearFromCommas($(".sum_footer_lp_clicks").html()));
	__sumFooter["leads"] = parseInt(clearFromCommas($(".sum_footer_leads").html()));
	var rev_sumfooter = $(".sum_footer_revenue").html();
	if (rev_sumfooter === undefined){
		rev_sumfooter = '0' ;
	}
	__sumFooter["revenue"] = parseFloat(clearFromCommas(rev_sumfooter.replace("$", "")));

	__sumFooter["cost"] = parseFloat(clearFromCommas($(".sum_footer_spend").html().replace("$", "")));
	var profit = $(".sum_footer_profit").html();
	if (profit===undefined){
		profit = '0';
	} 
	__sumFooter["profit"] = parseFloat(clearFromCommas(profit.replace("$", "")));
	__sumFooter["lp_ctr"] = parseFloat(clearFromCommas($(".sum_footer_lp_ctr").html().replace("%", "")));

	if (!__sumFooter["clicks_to_lp"]){
		if (__sumFooter["lp_ctr"] != 0 ){
			__sumFooter["clicks_to_lp"] = Math.floor(100*__sumFooter["lp_clicks"]/__sumFooter["lp_ctr"]);
		} else {
			__sumFooter["clicks_to_lp"] = 0;
		}
	}
}

$(document).ready(function() {

	//global var
	__countOfGroups = getCountOfGroups();
	
	calcSumFooter();

	$("#act-form").on("change","select",function () { 
						if($("#group1").val()==23 || $("#group2").val()==23 || $("#group3").val()==23){
							if((parseInt($("#group1").val())+parseInt($("#group2").val())+parseInt($("#group3").val()))>25){
								makeBadAlertModal("OK", "Building a report on these groups can take a long time!").show();
								//alert("Building a report on these groups can take a long time!");
							}
						}
					});
	



	function make_selected_numpage(){
		var options = $("select.page_select option");
		options.each(function(i,item){
			if ($(item).val()==$.cookie("val_page")){
				$(item).prop("selected", true);
			}
		});
	}
	
	make_selected_numpage();

	//row - jquery object of clicked row

	function getURLParameter(name) {
		return decodeURI(
			(RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1] || ''
		);
	}
	
	//Выделение строки
	$("body").on("click", ".table_stat tr", function(e){
		if (! ($(e.target).hasClass("str_hide") || $(e.target).hasClass("str_show")) ){
			//markChosenOfInnerOuterRow($(this));
			
			makeCalcChosenRows($(this));
		}
		//открываем drilldown
		if($("tr").is(".tr_active")){
			$("#drilldown").css("display","inline-block");
		}else{
			$("#drilldown").css("display","none");
		}
	});
	
	function save_tag(arr_tags){
		var arr_tags_json=JSON.stringify(arr_tags);
		//пример сохранения
		$.ajax({
            url : "",
            method: "post",
            data: {
				"type":"save_token_tag",
				"arr_tags":arr_tags_json,
				"ajax":"1"
			}
        }).success(function(data){
           //console.log(data);
        });
	}
	
	//сохранение тега
	$("body").on("click", ".token_tags a", function(){
		var arr_tags={};
		var tag_type=$(this).attr("id");
		var i=0;
		$(".table_stat .tr_active .save_tag").each(function() {
			i=i+1;
			var arr_tag={};
			arr_tag['token_number'] = $(this).find(".token_number").html();
			arr_tag['tag_old_type'] = $(this).find(".tag_type").html();
			arr_tag['token_name'] = $(this).parent().find(".td_report_name").html();
			arr_tag['camp_id']=getURLParameter('camp_id');
			arr_tag['tag_type']=tag_type;
			arr_tag['tag_name']='tag';
			//формируем массив сохранения
			arr_tags[i]=arr_tag;
			//дописываем к строке тег
			if(tag_type!=='tag_clear'){
				$(this).parent().find(".tag_ico").html("<img src='templates/standart/images/tags/"+tag_type+".png' style='width: 11px;position: relative; top: 2px;left: -1px;'>");
			}else{
				$(this).parent().find(".tag_ico").html("");
			}
		});
		if(i>0){
			save_tag(arr_tags);
			//сброс выделения
			rows_offclicks();
			$("#check_all").removeAttr('checked');
		}else{
			tag_type=tag_type.replace('tag_','%23');
			var url=location.href;
			if(tag_type=='%23clear'){
				var old_tag = getURLParameter('search_report');
				url=url.replace('&search_report='+old_tag,'');
				url=url.replace('?search_report='+old_tag+'&','?');
			}else{
				var re='search_report';
				if(url.search(re)==-1){
					url=url+'&search_report='+tag_type;
				}else{
					var old_tag = getURLParameter('search_report');
					url=url.replace(old_tag,tag_type);
				}
			}
			window.location.href = url;
		}
	});
	
	//сброс выделения
	function rows_onclicks(){
		$(".table_stat tr").each(function() {
			if(!$(this).hasClass("tr_active")){
				makeCalcChosenRows($(this));
			}
		});
	}
	
	function rows_offclicks(){
		$(".table_stat .tr_active").each(function() {
			if($(this).hasClass("tr_active")){
				makeCalcChosenRows($(this));
			}
		});
	}
	
	//выделение всех токенов
	$("body").on("change", "#check_all", function(){
		if($("#check_all").prop("checked")==true){
			rows_onclicks();
		}else{
			rows_offclicks();
		}
	});
	
	$("body").on("touchstart click","#filters",function () { 
		$("#wrap").css("display","block");
		$("#win_filter").css("display","block");
		//Подключает объект работы с фильтрами
		filterWindow.init($("#win_filter"));
	}); 

	$("body").on("touchstart click","#clear_filters",function () { 
		$("#refresh_fid").remove();
		/*$("#filters").html("Set filter");*/
		$("#refresh-btn").trigger('click');
	});
	
	$("body").on("touchstart click","#update_costs",function () { 
		$("#wrap").css("display","block");
		$("#upd_costs").css("display","block");
		var selected_tm=$("#timedate").val();
		$("#date_filter_cpc option").removeAttr("selected");
		$("#date_filter_cpc [value='"+selected_tm+"']").prop("selected", true);
		if(selected_tm==12){
			$("#custom_date_pol1_1").datetimepicker({format:"Y-m-d", timepicker: false});
			$("#custom_date_pol2_1").datetimepicker({format:"Y-m-d", timepicker: false});
			var custom_val_1=$("#custom_date_pol1").val();
			var custom_val_2=$("#custom_date_pol2").val();	
			$("#custom_date_pol1_1").val(custom_val_1);
			$("#custom_date_pol2_1").val(custom_val_2);
			$("#upd_cpc_custom").css("display","block");
		}else{
			if(selected_tm==10){
				$("#custom_date_pol1_1").datetimepicker({format:"Y-m-d | H:i", defaultTime: "00:00", timepicker: true});
				$("#custom_date_pol2_1").datetimepicker({format:"Y-m-d | H:i", defaultTime: "23:59", timepicker: true});
				var custom_val_1=$("#custom_date_pol1").val();
				var custom_val_2=$("#custom_date_pol2").val();	
				$("#custom_date_pol1_1").val(custom_val_1);
				$("#custom_date_pol2_1").val(custom_val_2);
				$("#upd_cpc_custom").css("display","block");
			}
		}
		//windows_core function
		enter_date2($("#timedate"));	
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
	
	$("#nav_str [value=<?php echo $arr_tpl['num_page'];?>]").prop("selected", true);
	

	
	$(".block_filter_3 .search_in_report").on("input", function(){
		if ($(".block_filter_3 .search_in_report").val().length!=0){
			$("#refresh-btn").removeClass("blue-button").addClass("green-button");
			$("#refresh-btn").html("&nbsp;&nbsp;<img src='templates/standart/images/w-ok.png' class='icon' style='position: relative; top: 1px;'>Apply&nbsp;&nbsp;");
		} else {
			$("#refresh-btn").removeClass("green-button").addClass("blue-button");
			$("#refresh-btn").html("&nbsp;&nbsp;<img src='templates/standart/images/w-refresh.png' class='icon'>Refresh&nbsp;&nbsp;");
		}
	});

	$("[name=date_s], [name=date_e]").on("change", function(){
		$("#refresh-btn").removeClass("blue-button").addClass("green-button");
		$("#refresh-btn").html("&nbsp;&nbsp;<img src='templates/standart/images/w-ok.png' class='icon' style='position: relative; top: 1px;'>Apply&nbsp;&nbsp;");
	});

	$(".block_filter_3 select").change(function() {

		$("#refresh-btn").removeClass("blue-button").addClass("green-button");
		$("#refresh-btn").html("&nbsp;&nbsp;<img src='templates/standart/images/w-ok.png' class='icon' style='position: relative; top: 1px;'>Apply&nbsp;&nbsp;");
	});

	$("#nav_str").change(function() {
		var myRe = /num\_page\=<?php echo $arr_tpl['num_page'];?>/i;
		var myArray = myRe.exec(location.href);
		if(myArray){
			var new_link = location.href.replace(/num\_page\=<?php echo $arr_tpl['num_page'];?>/, "num_page="+$("#nav_str :selected").val());
		}else{
			var new_link = location.href + "&num_page="+$("#nav_str :selected").val();
		}
		var myRe = /fid\=[0-9]*/i;
		var myArray = myRe.exec(new_link);
		if(myArray){
			var new_link = new_link.replace(/fid\=[0-9]*/, "fid=<?php echo $arr_tpl['fid'];?>");
		}else{
			var new_link = new_link + "&fid=<?php echo $arr_tpl['fid'];?>";
		}
		var myRe = /type_load\=[0-5]*/i;
		var myArray = myRe.exec(new_link);
		if(myArray){
			var new_link = new_link.replace(/type_load\=[0-9]*/, "type_load=3");
		}else{
			var new_link = new_link + "&type_load=3";
		}
		document.location.href = new_link;
	});
	
	$("#nav_str_val [value=<?php echo $arr_tpl['val_page'];?>]").prop("selected", true);
	
	$("#nav_str_val").change(function() {
		var myRe = /val\_page\=<?php echo $arr_tpl['val_page'];?>/i;
		var myArray3 = myRe.exec(location.href);
		if(myArray3){
			var new_link = location.href.replace(/val\_page\=<?php echo $arr_tpl['val_page'];?>/, "val_page="+$("#nav_str_val :selected").val());
		}else{
			var new_link = location.href + "&val_page="+$("#nav_str_val :selected").val();
		}
		var myRe = /num\_page\=<?php echo $arr_tpl['num_page'];?>/i;
		var myArray = myRe.exec(new_link);
		if(myArray){
			var new_link = new_link.replace(/num\_page\=<?php echo $arr_tpl['num_page'];?>/, "num_page=1");
		}else{
			var new_link = new_link + "&num_page="+$("#nav_str :selected").val();
		}
		var myRe = /type_load\=[0-5]*/i;
		var myArray = myRe.exec(new_link);
		if(myArray){
			var new_link = new_link.replace(/type_load\=[0-9]*/, "type_load=3");
		}else{
			var new_link = new_link + "&type_load=3";
		}
		document.location.href = new_link;
	});

	header_correlation();

	$("#timedate [value=<?php echo $arr_tpl['date'];?>]").prop("selected", true);
	
	function str_hide_click(){
		$(this).attr("class","str_show");

		var cell_width = $(this).parent().width()-2;
		$(this).parent().css("width", cell_width);

		var check_num=$(this).parent().parent().attr("id");
		var myRe = new RegExp("^" + check_num + "_");
		$(".table_stat tr").each(function() {
			if($(this).attr("id")){
				var temp=$(this).attr("id");
				if(temp.search(myRe) == 0){
					$(this).css("display","none");
				}
			}
		});
		header_correlation();
	}

	if ('ontouchstart' in document.documentElement){
		$("body").on("touchstart",".str_hide", str_hide_click);
	} else {
		$("body").on("click",".str_hide", str_hide_click);
	}
	
	function str_show_click(){
		$(this).attr("class","str_hide");
		var check_num=$(this).parent().parent().attr("id");
		var myRe = new RegExp("^" + check_num + ".*_");
		$(".table_stat tr").each(function() {
			if($(this).attr("id")){
				var temp=$(this).attr("id");
				if(temp.search(myRe) == 0){
					$(this).css("display","table-row");
					$(this).children("td").children(".str_show").attr("class","str_hide");
				}
			}
		});
	}
	
	if ('ontouchstart' in document.documentElement){
		$("body").on("touchstart",".str_show",str_show_click);
	} else {
		$("body").on("click",".str_show",str_show_click);
	}

	$(".block_filter_1 .ul_parent").on("click", function(){
					
		var lists, children = $(this).find(".ul_children");

		if (children.css("display")=="none"){
			
			lists = $(".block_filter_1 .ul_children");
			lists.each(function(i, el){
				if ($(el).css("display") == "block" && el!==children.get(0)){
					$(el).css("display", "none");
				}
			});
			children.css("display", "block");
		} else {
			children.css("display", "none");
		}
	});

	$(document).mouseup(function (e){ 
		var div = $(".block_filter_1 .ul_parent"); 
		if (!div.is(e.target) && div.has(e.target).length === 0) { 
			lists = $(".block_filter_1 .ul_children");
			lists.each(function(i, el){
				$(el).css("display", "none");
			}); 
		}
	});


});
</script>