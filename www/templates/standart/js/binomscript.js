// preload images
if (__pageType=="report"){
	var buttonbackgroud = new Image();
	buttonbackgroud.src = "./templates/standart/images/but-bg.png";
}

function cloneObject(obj){
    if (null == obj || "object" != typeof obj) return obj;
    var copy = obj.constructor();
    for (var attr in obj) {
        if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
    }
    return copy;
}

/*
#######################
# STATISTICS FUNCTION #
#######################
*/
/**
 * Handler delete button - writen inline onclick
 * working only with main stats tables and their mechanism 
 * of setting href to deleting button
 * 
 * @param object {object} object of button - click target
 * @param page_type {string} this string that will be after word delete in header of window
 */
function deleteButtonHandler(object, page_type, text){
	
	var ok_callback, modal_window;

	// Callback of delete button
	ok_callback = function(){
		// make Delete (OK) button animating
		makeButtonInProcess(".modal_window--confirm .modal_window__ok-button", "Deleting...");
		// redirect on href which delete campaign
		window.location = object.dataset.href;
	};
	
	modal_window = makeConfirmModal("Delete", "Cancel", ok_callback, "Delete "+page_type, text);
	modal_window.show();
	return false;
}

/*
##############################
# END OF STATISTICS FUNCTION #
##############################
*/


function getURLParameter(name) {
	return decodeURI( (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1] || '');
}

// NEEDED FOR WINDOWS_CORE FOR SAVING SEARCH VALUE 
// AFTER SAVING LAND/OFFER AND RELOAD PAGE
function afterSaveButton(){
	if ( (typeof submitForm != "undefined") && ( $("#act-form .search").val()!="" )  && __searchChanged==1){
		submitForm();
		return;
	} else {
		window.location.reload();
		return;
	}
	window.location.reload();
}

function changeNewLineOnBr(string){
	return string.replace(/(?:\r\n|\r|\n)/g, '<br />');
}

binomMessageWindow = {

	// read/close buttons
	read_button: '<a class="button win-save-button message-read-button"><img src="templates/standart/images/w-save.png" class="icon save_icon">Read</a>',
	close_button: '<a class="button win-close-button message-close-button" ><img src="./templates/standart/images/w-close.png" class="icon close_icon">Close</a>',

	drawWindow: function(){
		$('body').append(this.makeWindow());
		this.setMessageFromServer();
		this.setListeners();
	},

	makeWindow: function(){
		return  '<div id="wrap" class="wrap" style="display: block;"></div>\
				<div class="window window_read_message" id="1" style="display:block;width:400px;">\
					<a class="win_closebtn" onclick="binomMessageWindow.closeWindow()"></a>\
					<div class="win_header">\
						<span class="window_head_name">New message!</span>\
					</div>\
					<div class="win_cap">\
					</div>\
					<div class="win_content win_message_content">\
						<img class="message-text-loading" width="75px" src="templates/standart/images/loading.GIF">\
					</div>\
					<div class="win_footer">\
					' + this.makeFooter() + '\
					</div>\
				</div>';
	},

	closeWindow: function(){
		$(".window_read_message").remove();
		$(".wrap").css("display", "none");
	},

	
	makeMessageRead: function(that){
		return function(){
			$.ajax({
				url: "",
				type:"POST",
				data: {"ajax":1, "type":"make_user_message_read", "id":$.cookie("messages")},
				success: function(data){}
			});


			$.removeCookie("messages", {path: '/'});

			$(".menu_button_new_message").remove();
			setTimeout(that.closeWindow, 500);
		}
	},

	setListeners: function(){
		var that = this;
		$(".message-close-button").on("click", this.closeWindow);
		$(".message-read-button").on("click", this.makeMessageRead(that))
	},

	makeFooter: function(){
		var that = this;
		footer_block = '<div class="win-buttons-block">'+this.read_button + this.close_button+'</div>';
		return footer_block;
	},

	insertMessageInWindow:function(text){
		$(".window_read_message img.message-text-loading").remove();
		$(".window_read_message .win_content").append(text);
	},

	//Success callback  
	setMessageFromServer:function(){
		var that = this;
		$.ajax({
			url: "",
			type: "POST",
			data: {"ajax":1, "type":"get_user_message", "id":$.cookie("messages")},
			success: function(data){that.insertMessageInWindow(data)}
		});
	},
}

formattingSettingsStorage = {

}

// Set text cursor position
// Functions more for noteWindowTokens 
function doGetCaretPosition (oField) {

  // Initialize
  var iCaretPos = 0;

  // IE Support
  if (document.selection) {

    // Set focus on the element
    oField.focus();

    // To get cursor position, get empty selection range
    var oSel = document.selection.createRange();

    // Move selection start to 0 position
    oSel.moveStart('character', -oField.value.length);

    // The caret position is selection length
    iCaretPos = oSel.text.length;
  }

  // Firefox support
  else if (oField.selectionStart || oField.selectionStart == '0')
    iCaretPos = oField.selectionStart;


  // Return results
  return iCaretPos;
}

function insertTextAtCursor(el, text) {
    var val = el.value, endIndex, range, doc = el.ownerDocument;
    if (typeof el.selectionStart == "number"
            && typeof el.selectionEnd == "number") {
        endIndex = el.selectionEnd;
        el.value = val.slice(0, endIndex) + text + val.slice(endIndex);
        el.selectionStart = el.selectionEnd = endIndex + text.length;
    } else if (doc.selection != "undefined" && doc.selection.createRange) {
        el.focus();
        range = doc.selection.createRange();
        range.collapse(false);
        range.text = text;
        range.select();
    }
}

function moveCaret(textNode, charCount) {
    var sel, range;
    if (window.getSelection) {
        // IE9+ and other browsers
        sel = window.getSelection();
        if (sel.rangeCount > 0) {
            var newOffset = sel.focusOffset + charCount;
            sel.collapse(textNode, Math.min(textNode.length, newOffset));
        }
    } else if ( (sel = window.document.selection) ) {
        // IE <= 8
        if (sel.type != "Control") {
            range = sel.createRange();
            range.move("character", charCount);
            range.select();
        }
    }
}

"x".constructor.prototype.addCommaSeparatorFloat = function(){
	return this.replace( /(?=\B(?:\d{3})+\b[\.])/g, ',' );
}

"x".constructor.prototype.addCommaSeparatorInt = function(){
	return this.replace( /(?=\B(?:\d{3})+\b)/g, ',' );
}

String.prototype.capitalizeFirstLetter = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

//#################
//#################
function calcSumSearch(){

	var sum_obj = {

		sum_clicks: 0,
		sum_leads: 0,
		sum_spend: 0,
		sum_rev: 0,
		sum_lpctr: 0,
		sum_of_cl: 0,
		sum_lnd_cl: 0,
		sum_cr: 0,
		sum_epc: 0,
		sum_cpc: 0

		},
		lpctr_used = ($(".table_stat .lpctr_td").length>0),
		sum_of_cl=0,
		sum_lnd_cl=0;

	re_comma = new RegExp("[,]", "g");

	$(".table_stat tr").each(function(i, elem){
		if ($(elem).css("display")!="none"){
			sum_obj["sum_clicks"] += parseFloat($(elem).find(".clicks_td").html().replace(re_comma,""));
			sum_obj["sum_leads"] += parseFloat($(elem).find(".leads_td").html().replace(re_comma,""));
			sum_obj["sum_spend"] += parseFloat($(elem).find(".cost_td").html().replace(re_comma,"").replace("$",""));
			sum_obj["sum_rev"] += parseFloat($(elem).find(".revenue_td").html().replace(re_comma,"").replace("$",""));
			if (lpctr_used){
				sum_of_cl=sum_of_cl+parseInt($(elem).find(".offer_clicks_hide").html().replace(re_comma,""));
				sum_lnd_cl=sum_lnd_cl+parseInt($(elem).find(".landing_clicks_hide").html().replace(re_comma,""));
			}
		}
	});



	if(sum_lnd_cl>0){
		sum_obj["sum_lpctr"]=(sum_of_cl/sum_lnd_cl)*100;
	}else{
		sum_obj["sum_lpctr"]=0;
	}
	if(sum_obj["sum_clicks"]>0){
		sum_obj["sum_cr"]=(sum_obj["sum_leads"]/sum_obj["sum_clicks"])*100;
	}else{
		sum_obj["sum_cr"]=0;
	}
	if(sum_obj["sum_clicks"]>0){
		sum_obj["sum_epc"]=(sum_obj["sum_rev"]/sum_obj["sum_clicks"]);
	}else{
		sum_obj["sum_epc"]=0;
	}
	if(sum_obj["sum_clicks"]>0){
		sum_obj["sum_cpc"]=(sum_obj["sum_spend"]/sum_obj["sum_clicks"]);
	}else{
		sum_obj["sum_cpc"]=0;
	}

	sum_obj["sum_profit"]=sum_obj["sum_rev"]-sum_obj["sum_spend"];

	if(sum_obj["sum_spend"]>0){
		sum_obj["sum_roi"]=(parseFloat(sum_obj["sum_profit"])/parseFloat(sum_obj["sum_spend"]))*100;
	}else{
		sum_obj["sum_roi"]=0;
	}

	return sum_obj;
}

function drawFooterSum(obj){

	obj["sum_clicks"] = obj["sum_clicks"];
	obj["sum_leads"] = obj["sum_leads"];
	obj["sum_rev"] = obj["sum_rev"].toFixed(formattingSettingsStorage['revenue']).toString().addCommaSeparatorFloat();
	obj["sum_spend"] = obj["sum_spend"].toFixed(formattingSettingsStorage['cost']).toString().addCommaSeparatorFloat();


	$(".footer-container table .clicks_td").html(obj["sum_clicks"].toString().addCommaSeparatorInt());

	if (typeof(obj["sum_lpctr"]) != "undefined"){
		$(".footer-container table .lpctr_td").html(obj["sum_lpctr"].toFixed(formattingSettingsStorage['lp_ctr'])+"%");
	}

	$(".footer-container table .leads_td").html(obj["sum_leads"].toString().addCommaSeparatorInt());
	$(".footer-container table .cr_td").html(obj["sum_cr"].toFixed(formattingSettingsStorage['cr']) + "%");
	$(".footer-container table .epc_td").html("$" + obj["sum_epc"].toFixed(formattingSettingsStorage['epc']));
	$(".footer-container table .cpc_td").html("$" + obj["sum_cpc"].toFixed(formattingSettingsStorage['cpc']));
	$(".footer-container table .revenue_td").html("$" + obj["sum_rev"]);
	$(".footer-container table .cost_td").html("$" + obj["sum_spend"]);

	var profit;

	if (obj["sum_profit"]>=0){
		profit = obj["sum_profit"].toFixed(formattingSettingsStorage['profit']).toString().addCommaSeparatorFloat();
		$(".footer-container table .profit_td").html("$" + profit).removeClass("color_stat_3").removeClass("color_stat_2").removeClass("color_stat_1");
		if (obj["sum_profit"]==0){
			$(".footer-container table .profit_td").addClass("color_stat_2");
		} else {
			$(".footer-container table .profit_td").addClass("color_stat_1");
		}
	} else {
		profit = "-"+("$"+(obj["sum_profit"]*(-1)).toFixed(formattingSettingsStorage['profit']));
		profit = profit.toString().addCommaSeparatorFloat();
		$(".footer-container table .profit_td").html(profit).removeClass("color_stat_1").removeClass("color_stat_2").addClass("color_stat_3");;
	}

	var sum_roi;

	if (obj["sum_roi"] != 0 ){
		sum_roi = obj["sum_roi"].toFixed(formattingSettingsStorage['roi']).toString().addCommaSeparatorFloat() + "%";
	} else {
		sum_roi = "0.00" + "%";
	}
	$(".footer-container table .roi_td").html("$" + profit).removeClass("color_stat_3").removeClass("color_stat_2").removeClass("color_stat_1");
	if (obj["sum_roi"] == 0){
		$(".footer-container table .roi_td").html("$" + profit).addClass("color_stat_2");
	} else if (obj["sum_roi"]>0){
		$(".footer-container table .roi_td").html("$" + profit).addClass("color_stat_1");
	} else {
		$(".footer-container table .roi_td").html("$" + profit).addClass("color_stat_3");
	}
	$(".footer-container table .roi_td").html(sum_roi);
}

//Make enable/disable buttons that not needed in group choice
function disabledNongroupButtons(){
	$("#delete, #clone, #report, #edit").removeAttr("href");
	$("#edit, #report, #clone, #note").attr("class", "button_inactive");
	$("#clear, #note").attr("onclick", "");
	$("#clear, #delete").attr("class", "gray-button_inactive");
}

//function that open custom_time inputs
function enter_date_statistics(value){
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

		if ($(value).val()=="12"){
			$("#custom_date").addClass("narrow_date_input");
		} else {
			$("#custom_date").removeClass("narrow_date_input");
		}

		$("[name = \'search_name\']").css("width","140px");
	}else{
		$("#custom_date").css("display","none");
		$("[name = \'search_name\']").css("width","200px");
	}
}


	
function set_get(url,name,val){
	var re=name;
	if(url.search(re)==-1){
		url=url+'&'+name+'='+val;
	}else{
		var old_tag = name+'='+getURLParameter(name);
		url=url.replace(old_tag,name+'='+val);
	}
	return url;
} 

function tryToReturnPlaceholderSearch(that){
	if ($(that).val().length == 0){
		that.placeholder="Search";
	}
}

function addZeroToNumber(number){
	if (number.toString().length == 1){
		return "0" + number.toString();
	}
	return number;
}

/**
 * Download land
*/
function download_land(){
	var lp_name = $("[name = \'lp_name\']").val();
	var data = new FormData();
	$.each(files, function( key, value ){
		data.append(key, value);
	});

	var blocker = new windowBlocker("#add_lp", {blocked_button_text:"Uploading"});
	// Blocking window
	blocker.block();

	var upload_button = $(".upload_land_button");
	makeButtonLoaded(upload_button, "Upload");

	$.ajax({
		url : "?ajax=1&type=download_land&land_name="+lp_name,
		method: "post",
		data: data,
		cache: false,
		processData: false,
		contentType: false,
	}).success(function(data){
		if(data.indexOf("Maximum number") + 1) {
			$("#download_land").parent().append("<p style=\'margin: 0;color: red;\'>Exceeded the limit number of files</p>");
			blocker.unblock();
			$(".upload_land_button .sk-fading-circle").remove();
			$(".upload_land_button").html('<img src="templates/standart/images/w-save.png" class="icon save_icon">Upload lander');
		}else{
			var obj = jQuery.parseJSON(data);
			$("#download_land").css("display","none");
			$("#lp_file_block").css("display","block");
			$("[name = \'lp_file\']").css("display","block");
			$("[name = \'lp_file\']").val(obj.path);
			$("#add_lp [name=lp_file]").prop("readonly", true);
            $("#add_lp [name=lp_file]").addClass("readonly_input");
			if(obj.error){
				$("#download_land").parent().append("<p style=\'margin: 0;color: red;\'>"+obj.error+"</p>");
			}
			// Unblocking window
			blocker.unblock();
			addCheckButtonToURL.init("input[name=lp_file]", true);
		}
	}).error(function(error){
		if (error.status==413){
			makeBadAlertModal("OK", "HTTP 413! Please, change your web-server's configuration \
									 (For Nginx: client_max_body_size, for Apache: LimitRequestBody)\
									 and try again.").show();
			blocker.unblock();
			addCheckButtonToURL.init("input[name=lp_file]", true);
			$(".upload_land_button").html('<img src="templates/standart/images/w-save.png" class="icon save_icon">Upload lander');
		}
	});
}

//#################
//#################

offerPageHelper = {

	clipboard: -1,

	setZclipOnCopyBtn: function(){
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
	},

	addCopyFuncTobutton: function(){

		if (!FlashDetect.installed){
			try {
				if (this.clipboard == -1){
					this.clipboard = new Clipboard("#copy_postback_url");
					$("#copy_postback_url").replaceWith( $("<button class='green-button' id='copy_postback_url' href='javascript:' data-clipboard-target='#postback_url'>Copy</button>") );
				}
			} catch (e){
				$("#url_input").css({'width':'100%'});
			}

		} else {
			this.setZclipOnCopyBtn();
		}

	}
}

landingPageHelper = {
	clipboard: -1,

	setZclipOnCopyBtn: function(){
		$("#copy_btn10").zclip({
		    path:"templates/standart/js/jquery-zclip/ZeroClipboard.swf",
		    copy:$("#copy_value10").val(),
		    beforeCopy:function(){
		    },
		    afterCopy:function(){
		        $("#copy_btn10").addClass("blue-button");
		        $("#copy_btn10").html("Done");
		        setTimeout(function(){
		        	$("#copy_btn10").removeClass("blue-button");
		      		$("#copy_btn10").html("Copy");
		        },2000);
		    }
		});
	},

	addCopyFuncTobutton: function(){

		if (!FlashDetect.installed){

			try {
				if (this.clipboard == -1){
					this.clipboard = new Clipboard("#copy_btn10");
					$("#copy_btn10").replaceWith( $("<button class='green-button' id='copy_btn10' href='javascript:' data-clipboard-target='#copy_value10'>Copy</button>") );
				}
			} catch (e){
				/*	$("#url_input").css({'width':'100%'});*/
			}

		} else {
			this.setZclipOnCopyBtn();
		}

	}
}

addTokensToURL = {

	list_of_tokens: {},

	opened_flag : false,

	
	init: function(jobj, win_id, type){
		if (!this.opened_flag){
			this.opened_flag = true;
			this.url_input = jobj;
			this.window_id = win_id;

			var additional_tokens = new Array();

			if (type=="lp"){
				additional_tokens.push({"param":"{lp_key}", "value": {"param":"lpkey", "view":"LP Key"}});
			} 


			if (type=="of" || type=="lp"){
					this.list_of_tokens = {
								"{clickid}"        : {"param":"clickid", "view":"Click ID"},
								"{campaign}"       : {"param":"campaign","view":"Camp ID"},
								"{trafficsource}"  : {"param":"trafficsource", "view":"Traffic Source"},
								"{lander}"         : {"param":"lander", "view":"Land ID"},
								"{domain}"		   : {"param":"domain", "view":"Domain"},
								"{referer}"		   : {"param":"referer","view":"Referer"},
								/*"{referer}"	   : {"param":"referer", "view":"Referer"},*/
								"{time}"		   : {"param":"time", "view":"Time"},
								"{htime}"		   : {"param":"htime", "view":"Encoded Time"},
								"{device_name}"    : {"param":"device_name", "view":"Device Name"},
								"{device_brand}"   : {"param":"device_brand", "view":"Device Brand"},
								"{device_model}"   : {"param":"device_model", "view":"Device Model"},
								"{browser_name}"   : {"param":"browser_name", "view":"Browser Name"},
								"{browser_version}": {"param":"browser_version", "view":"Browser Version"},
								"{resolution}"	   : {"param":"resolution", "view":"Resolution"},
								"{os_name}"        : {"param":"os_name", "view":"OS Name"},
								"{os_version}"     : {"param":"os_version", "view":"OS Version"},
								"{country}"        : {"param":"country", "view":"Country"},
								"{language}"        : {"param":"language", "view":"Language"},
								"{city}"           : {"param":"city", "view":"City"},
								"{isp}"            : {"param":"isp", "view":"ISP"},
						 		"{ip}"             : {"param":"ip", "view":"IP"},
								"{user_agent}"     : {"param":"user_agent", "view":"User Agent"},
								"{t1}"             : {"param":"t1",  "view":"Token 1"},
								"{t2}"             : {"param":"t2",  "view":"Token 2"},
								"{t3}"             : {"param":"t3",  "view":"Token 3"},
								"{t4}"             : {"param":"t4",  "view":"Token 4"},
								"{t5}"             : {"param":"t5",  "view":"Token 5"},
								"{t6}"             : {"param":"t6",  "view":"Token 6"},
								"{t7}"             : {"param":"t7",  "view":"Token 7"},
								"{t8}"             : {"param":"t8",  "view":"Token 8"},
								"{t9}"             : {"param":"t9",  "view":"Token 9"},
								"{t10}"            : {"param":"t10", "view":"Token 10"},
								"{country_code}"            : {"param":"country_code", "view":"Сountry code"}
							};
			} else if (type=="ts") {
				this.list_of_tokens = {
					"{externalid}" : {"param":"externalid", "view":"External ID"},
					"{payout}" : {"param":"payout", "view":"Payout"}
				}
			}

			for(var i=0;i<additional_tokens.length;i++){
				this.list_of_tokens[additional_tokens[i]["param"]] = additional_tokens[i]["value"]; 
			}
			
			if (type=="ts"){
				this.url_input.after("<div class='url-tokens-block'>\
						<a class='url-tokens-title'>You can use the following tokens:</a>\
								<div class='url-tokens-list url-tokens-list-ts' >\
								</div>\
				</div>");
			} else {
				this.url_input.after("<div class='url-tokens-block'>\
						<a class='url-tokens-title'>You can use the following tokens:</a>\
								<div class='url-tokens-list url-tokens-list-lpof'>\
								</div>\
				</div>");
			}
			this.setHandlers();
			this.setListOfTokens();
		}

	},

	checkInput: function(obj){
		var that = obj;
		return function(){
			if ($(".url-tokens-list").css("display")!="none"){
				that.setListOfTokens();
			}
		}
	},

	setListOfTokens: function(){
		var url_input = this.url_input;

		tokens_keys = Object.keys(this.list_of_tokens),
		html_tokens_list = "";

		var needed_tokens_keys = tokens_keys.filter(function(plc){
			if (url_input.val().indexOf(plc) == -1){
				return true;
			} else {
				return false;
			}
		});

		for (var i=0; i<tokens_keys.length;i++){
			if (url_input.val().indexOf(tokens_keys[i]) == -1){
				html_tokens_list += "<span class='url-tokens-not-used' data-placeholder=" + tokens_keys[i] + "> <span class='url-tokens-name-plus'>+</span>"+this.list_of_tokens[tokens_keys[i]]["view"]+" </span>";
		 	} else {
		 		html_tokens_list += "<span class='url-tokens-used' data-placeholder=" + tokens_keys[i] + "> <span class='url-tokens-name-minus'>-</span>"+this.list_of_tokens[tokens_keys[i]]["view"]+" </span>";
		 	}
		}

		$(".url-tokens-list").html("");
		$(".url-tokens-list").append(html_tokens_list);
	},

		setHandlers: function(){
		if ('ontouchstart' in document.documentElement){
			//$(".url-tokens-block").on("touchend", ".url-tokens-add-button", this.toggleTokensList(this));
			$(".url-tokens-block").on("touchend", ".url-tokens-not-used", this.addToken(this));
			$(".url-tokens-block").on("touchend", ".url-tokens-used", this.removeToken(this));
		} else {
			//$(".url-tokens-block").on("click", ".url-tokens-add-button", this.toggleTokensList(this));
			$(".url-tokens-block").on("click", ".url-tokens-not-used", this.addToken(this));
			$(".url-tokens-block").on("click", ".url-tokens-used", this.removeToken(this));
		}
		this.url_input.on("keyup", this.checkInput(this));
		$("#" + this.window_id + " .win-close-button").on("click", this.closeTokens(this));
		$("#" + this.window_id + " .win_closebtn").on("click", this.closeTokens(this));
	},

	toggleTokensList: function(obj){
		var that = obj;
		return function(){
			if ($(".url-tokens-block .url-tokens-list").css("display")=="none"){
				$(".url-tokens-block .url-tokens-list").css("display", "block");
				//$(".url-tokens-add-button").html("Close tokens");
				that.setListOfTokens();
			} else {

				that.closeTokens();
			}
		}
	},

	//@param token: JQuery Object
	toggleTokenChooser: function(token){
		if (token.hasClass("url-tokens-not-used")){
			token.removeClass("url-tokens-not-used");
			token.addClass("url-tokens-used");
			token.find(".url-tokens-name-plus").html("-").removeClass("url-tokens-name-plus").addClass("url-tokens-name-minus");

		} else if (token.hasClass("url-tokens-used")){
			token.removeClass("url-tokens-used");
			token.addClass("url-tokens-not-used");
			token.find(".url-tokens-name-minus").html("+").removeClass("url-tokens-name-minus").addClass("url-tokens-name-plus");

		}
	},

	addToken: function(){
		var that = this;
		return function(){

			var plc = $(this).attr("data-placeholder"),
			url_input_text = that.url_input.val();

			if (that.url_input.val()[that.url_input.val().length-1]!="="){
				if(url_input_text.indexOf("?")!=-1){
					that.url_input.val(url_input_text + "&" +that.list_of_tokens[plc]["param"] +"="+plc);
				} else {
					that.url_input.val(url_input_text + "?" +that.list_of_tokens[plc]["param"] +"="+plc);
				}
			} else {
				that.url_input.val(url_input_text + plc);
			}
			that.toggleTokenChooser($(this));
			$(this).html($(this).html().replace("+", "-"));
			
			that.url_input.trigger("change");
		}
	},

	removeToken: function(obj){
		var that = obj;
		return function(){
			var url_input_text = that.url_input.val(),
			replace_re = new RegExp("[&?]*[0-9a-zA-Z_-~\.!*'\(\)]*" + "\=?" + this.getAttribute("data-placeholder"),"g" ),
			new_url, old_url;

			new_url = that.url_input.val(url_input_text.replace(replace_re, "") ).val();
			if (new_url != url_input_text){
				that.toggleTokenChooser($(this));

				if (new_url.indexOf("?")==-1){
					that.url_input.val(new_url.replace("&", "?"));
				}
			}

			that.url_input.trigger("change");

		}
	},

	closeTokens: function(obj){
		var that = obj;
		return function(){
			$(".url-tokens-block").css("display","none");
			$(".url-tokens-block").remove();
			that.opened_flag = false;
			return "xxx";
		}
	}
}

noteWindowTokens = {
	
	input_selector: "",
	temp_timeout: "",
	textarea_focused: 0,

	init: function(input_selector){
		this.clearTokens();
		this.input_selector = input_selector;
		$(input_selector).parent().append(this.makeHtmlBlock());
		this.setHandlers();
	},

	clearTokens: function(){
		if ($(this.input_selector).parent().find(".note-tokens").length>0){
			$(this.input_selector).parent().find(".note-tokens-wrapper").remove();
		}
	},

	drawTokens: function(){
	},

	makeFunctionWriter: function(textFunc) {
		var that = this;
		return function(e){
			if ($(this).hasClass("note-tokens-disabled")){
				return;
			}
			var e = e || event,
				button = $(this);
			e.preventDefault();
			var caret_position = doGetCaretPosition( document.getElementById(that.input_selector.replace("#","")) );
			// inserting before focus
			if (caret_position==0 && that.textarea_focused==0){
				if ($(that.input_selector).val().trim().length==0){
					$(that.input_selector).val($(that.input_selector).val() + textFunc());
				} else {
					$(that.input_selector).val($(that.input_selector).val() +"\n"+ textFunc());
				}
			} else {
				insertTextAtCursor(document.getElementById(that.input_selector.replace("#","")), textFunc());
			}
			document.getElementById(that.input_selector.replace("#","")).focus();
			button.addClass("note-tokens-disabled");

			setTimeout(function(){
				button.removeClass("note-tokens-disabled");
			}, 1000);

			if (__pageType=="add_camp"){
				somethingWasChanged();
			}
			//moveCaret(caret_position, document.getElementById(that.input_selector.replace("#",""))) ;
			//$(that.input_selector).val($(that.input_selector).val() + textfunc());
			
		}
	},

	setHandlers: function(){
		for (var i=0;i<this.list_of_tokens.length;i++){
			$(".note_token_" + this.list_of_tokens[i]["class_postfix"]).on("click", this.makeFunctionWriter(noteWindowTokens[this.list_of_tokens[i]["action"]]));
		}	
		var that = this;
		$(this.input_selector).on("click", function(){that.textarea_focused=1});
	},

	list_of_tokens: [
						{"name": "Time" ,   "class_postfix":"time", "action":"getTime"},
						{"name": "Date" ,   "class_postfix":"date", "action":"getDate"},
						{"name":"Datetime", "class_postfix":"Datetime", "action":"getDateTime"}
					],

	getTime: function(){
		x = new Date();
		return addZeroToNumber(x.getHours())+":"+addZeroToNumber(x.getMinutes()) + " ";
	},

	getDate: function(){
		x = new Date();
		return x.getFullYear()+"-"+addZeroToNumber(x.getMonth()+1)+"-"+addZeroToNumber(x.getDate()) + " ";
	},

	getDateTime: function(){
		return noteWindowTokens.getDate() + " " + noteWindowTokens.getTime() + " ";
	},

	makeHtmlBlock: function(){

		return "<div class='note-tokens-wrapper'>"+this.makeListOfTokens()+"</div>";
	},

	makeListOfTokens: function(){
		html = "";
		for (var i=0;i<this.list_of_tokens.length;i++){
			html += " <span class='note-tokens note_token_"+this.list_of_tokens[i]["class_postfix"]+"' >" + this.list_of_tokens[i]["name"] + " </span> ";
		}
		return html;
	}
}

trafficSourceTemplates = {

	xhr_get_template: undefined,

	list_of_templates: undefined,

	init : function(){
		var that = this;
		return function(){
		that.drawWindow();
		}
	},

	makeWindow : function(){

		return '<div class="window window-second-layer window-trafficsource-templates-list" style="width:800px;">\
					<a class="win_closebtn"></a>\
					<div class="win_header">\
						<span class="window_head_name">Predefined Traffic Sources</span>\
					</div>\
					<div class="win_cap ">\
						<div class="win_filter">\
								<select class="trafficsource-templates-adsformat-select" style="width:205px;">\
									<option value="0">Ads format</option>\
									<option value="1">Display</option>\
									<option value="2">Redirect</option>\
									<option value="3">Pop</option>\
									<option value="4">Native ads</option>\
									<option value="5">Search</option>\
									<option value="6">Push</option>\
									<option value="7">Dialog ads</option>\
								</select>\
								\
								<select class="trafficsource-templates-traffictype-select" style="width:205px;">\
									<option value="0">Traffic Type</option>\
									<option value="1">Mobile</option>\
									<option value="2">Desktop</option>\
								</select>\
								<input type="text" onclick="this.placeholder=\'\'" onblur="tryToReturnPlaceholderSearch(this);"  name="search_lp" placeholder="Search" class="search_other trafficsource-templates-name-search">\
						</div>\
					</div>\
					<div class="win_content trafficsource_templates">\
						\
						<table class="dop_table">\
							<tr class="dop_table_header">\
								<td style="padding-left: 20px;width:240px;">\
									Name\
								</td>\
								<td style="text-align:right;width: 210px;">\
									Ads format\
								</td>\
								<td style="text-align:right;width: 110px;">\
									Traffic type\
								</td>\
								<td style="text-align:right;width: 90px;">\
									Self-serve\
								</td>\
								<td style="text-align:right;padding-right:20px;">\
									Geo\
								</td>\
							</tr>\
						</table>\
						\
					</div>\
					<div class="win_footer lp_win_style2">\
					</div>\
				</div>';
	},

	drawWindow: function(){
		$("body").append(this.makeWindow());
		$("#add_ts").css("display", "none");
		//this.getListOfTemplatesFromServer();
		this.makeListOfTemplates();
		this.setHandlers();
	},

	setHandlers: function(){
		$(".trafficsource_templates").on("click", ".dop_table .dop_table_tr", this.templateLineHandler());
		$(".window-trafficsource-templates-list").on("click", ".win_closebtn", this.closeWindowHandler(this));
		$(".trafficsource-templates-adsformat-select").on("change", this.addFilterTemplatesByAdsFormat(this));
		$(".trafficsource-templates-traffictype-select").on("change", this.addFilterTemplatesByTrafficType(this));
		$(".trafficsource-templates-name-search").on("keyup", this.addFilterTemplatesByName(this));
	},

	//Ã‚Ã®Ã§Ã¢Ã°Ã Ã¹Ã Ã¥Ã² Ã´Ã³Ã­ÃªÃ¶Ã¨Ã¾-handler Ã± Ã§Ã Ã¡Ã¨Ã­Ã¦Ã¥Ã­Ã­Ã»Ã¬ this
	templateLineHandler: function(){
		var that=this;
		return function(){
			var template_id = this.getAttribute("data-id");
			that.getTemplateFromServer(template_id);
		}
	},

	//Ã…Ã±Ã«Ã¨ list_of_templates Ã¥Ã±Ã²Ã¼ Ã²Ã® Ã°Ã¨Ã±Ã³Ã¥Ã² Ã¨Ã§ Ã­Ã¥Ã£Ã®
	//Ã…Ã±Ã«Ã¨ Ã­Ã¥Ã² Ã²Ã® Ã§Ã Ã£Ã°Ã³Ã¦Ã Ã²Ã¼ Ã± Ã±Ã¥Ã°Ã¢Ã¥Ã°Ã 
	makeListOfTemplates: function(){
		var t = Date.now();
		if (typeof(this.list_of_templates)!="undefined"){
			this.drawListOfTemaplates(this.list_of_templates);
		} else {
			//Ã‚Ã»Ã§Ã»Ã¢Ã Ã¥Ã² this.drawListOfTemplates Ã¯Ã® ÃªÃ®Ã«Ã«Ã¡Ã¥ÃªÃ³ Ã± ajax'a
			this.getListOfTemplatesFromServer();
		}
	},

	//ÃÃ°Ã¨Ã­Ã¨Ã¬Ã Ã¥Ã² JSON - Ã¢Ã±Ã²Ã Ã¢Ã«Ã¿Ã¥Ã² Ã¢ Ã²Ã Ã¡Ã«Ã¨Ã¶Ã³
	drawListOfTemaplates: function(data){
		html = "";
		var self_serve;

		for (var i=0; i<data.length; i++){
			if (data[i]["self_serve"]==1){
				self_serve="+";
			} else {
				self_serve="-";
			}
			html = html + "<tr class='dop_table_tr' data-id="+data[i]["id"]+"><td align='left' style='padding-left:20px'>"+data[i]["name"]+"</td><td align='right'>"+data[i]["ads_format"]+"</td><td align='right'>"+data[i]["traffic_type"]+"</td><td align='right'>"+self_serve+"</td><td align='right' style='padding-right:20px;'>"+data[i]["geo"]+"</td></tr>";
		}
		$(".window-trafficsource-templates-list .dop_table").append(html);
	},

	//ÃŽÃ²Ã¯Ã°Ã Ã¢Ã«Ã¿Ã¥Ã² Ã§Ã Ã¯Ã°Ã®Ã± Ã­Ã  Ã±Ã¥Ã°Ã¢Ã¥Ã° Ã¨ Ã¯Ã®Ã«Ã³Ã·Ã Ã¥Ã² Ã±Ã¯Ã¨Ã±Ã®Ãª Ã¸Ã Ã¡Ã«Ã®Ã­Ã®Ã¢ Ã¨Ã±Ã²Ã®Ã·Ã­Ã¨ÃªÃ®Ã¢
	getListOfTemplatesFromServer: function(){
		var that=this;
		$.ajax({
			"url":"",
			"type":"post",
			"data":{"ajax":1, "type":"get_ts_templates_list"}
		}).success(function(data){
			var data = JSON.parse(data);
			that.drawListOfTemaplates(data);
		})
	},

	//ÃÃ°Ã¥Ã¤Ã§Ã Ã£Ã°Ã³Ã¦Ã Ã¥Ã² Ã±Ã¯Ã¨Ã±Ã®Ãª Ã¸Ã Ã¡Ã«Ã®Ã­Ã®Ã¢ Ã¨ Ã³Ã±Ã²Ã Ã­Ã®Ã¢Ã«Ã¨Ã¢Ã Ã¥Ã² this.list_of_templates
	getLisOfTemplatesFromServerPreLoad: function(){
		var that = this;
		$.ajax({
			"url":"",
			"type":"post",
			"data":{"ajax":1, "type":"get_ts_templates_list"}
		}).success(function(data){
			var x;

			that.list_of_templates=JSON.parse(data);

		})
	},

	getTemplateFromServer: function(template_id){
		var that=this;

		if (typeof(this.xhr_get_template)!="undefined" && this.xhr_get_template.ready != 4){
			this.xhr_get_template.abort();
		}

		this.xhr_get_template = $.ajax({
			"url":"",
			"type":"post",
			"data":{"ajax":1, "type":"get_template", "id":template_id}
		}).success(function(data){that.drawMainTrafficWindow(data)});
	},

	//Ã?ÃªÃ°Ã»Ã¢Ã Ã¥Ã² Ã®ÃªÃ­Ã® Ã¸Ã Ã¡Ã«Ã®Ã­Ã®Ã¢ - Ã¢Ã±Ã²Ã Ã¢Ã«Ã¿Ã¥Ã² Ã¢Ã±Ã¥ Ã¢ Ã®Ã±Ã­Ã®Ã¢Ã­Ã®Ã¥ Ã®ÃªÃ­Ã®
	drawMainTrafficWindow: function(data){
		var data = JSON.parse(data), tokens_list, tokens_table_rows;
		this.closeWindow();

		if (typeof(data["name"])!="undefined"){
			$("#add_ts .win_content input[name=name]").val(data["name"]);
		}
		if (typeof(data["postback_url"])!="undefined"){
			$("#add_ts .win_content input[name=postback_url]").val(data["postback_url"]);
			addTokensToURL.setListOfTokens();
		}

		if(typeof(data["c_name"])!="undefined"){
			$("#add_ts .win_content input[name=c_name]").val(data["c_name"]);
		}
		if(typeof(data["c_value"])!="undefined"){
			$("#add_ts .win_content input[name=c_value]").val(data["c_value"]);
		}
		if(typeof(data["e_name"])!="undefined"){
			$("#add_ts .win_content input[name=e_name]").val(data["e_name"]);
		}
		if(typeof(data["e_value"])!="undefined"){
			$("#add_ts .win_content input[name=e_value]").val(data["e_value"]);
		}



		if (typeof(data["tokens"])!="undefined" && data["tokens"]==1){
			if ($(".win_tokens_check").prop("checked")==false){
				$(".win_tokens_check").trigger("click");
			}
			tokens_list = JSON.parse(data["tokens_list"]);
			tokens_table_rows = $("#add_ts .win_content .token_tabl .tokens_tr");
			for (var i=0; i<tokens_table_rows.size(); i++){
				$(tokens_table_rows[i]).find("td:nth-child(2) input:first-child").val("");
				$(tokens_table_rows[i]).find("td:nth-child(3) input").val("");
				$(tokens_table_rows[i]).find("td:nth-child(4) input").val("");
			}
			for (var i=0; i<tokens_list.length; i++){
				$(tokens_table_rows[i]).find("td:nth-child(2) input:first-child").val(tokens_list[i]["field"]);
				$(tokens_table_rows[i]).find("td:nth-child(3) input").val(tokens_list[i]["val"]);
				$(tokens_table_rows[i]).find("td:nth-child(4) input").val(tokens_list[i]["name"]);
			}
		}
	},

	//ÃŒÃ Ã±Ã±Ã¨Ã¢ Ã§Ã­Ã Ã·Ã¥Ã­Ã¨Ã© Ã´Ã¨Ã«Ã¼Ã²Ã°Ã®Ã¢
	//1 - adsformat, 2-traffic type, 3-name
	ts_list_filter: ["","",""],

	//ÃŽÃ¡Ã¹Ã¨Ã© Ã´Ã¨Ã«Ã¼Ã²Ã° Ã¯Ã® Ã²Ã°Ã¥Ã¬ ÃªÃ®Ã«Ã®Ã­ÃªÃ Ã¬
	filterTemplatesList: function(){

		var ts_list = $(".dop_table_tr"), ts_ads_format, ts_traffic_type, ts_name;
		ts_list.css("display","table-row");
		if (this.ts_list_filter[0]!=0 || this.ts_list_filter[1] != 0 || this.ts_list_filter[2]!=0){

			for (var i=0; i<ts_list.size();i++){
				ts_ads_format = $(ts_list[i]).find("td:nth-child(2)").html();
				ts_traffic_type = $(ts_list[i]).find("td:nth-child(3)").html();
				ts_name = $(ts_list[i]).find("td:nth-child(1)").html();

				if (this.ts_list_filter[0]!=0){
					if (ts_ads_format.toLowerCase().indexOf(this.ts_list_filter[0].toLowerCase())==-1){
						$(ts_list[i]).css("display","none");
					}
				}
				if (this.ts_list_filter[1]!=0){
					if (ts_traffic_type.toLowerCase().indexOf(this.ts_list_filter[1].toLowerCase())==-1){
						$(ts_list[i]).css("display","none");
					}
				}
				if (this.ts_list_filter[2]!=0){
					if (ts_name.toLowerCase().indexOf(this.ts_list_filter[2].toLowerCase())==-1){
						$(ts_list[i]).css("display","none");
					}
				}
			}
		}
	},

	addFilterTemplatesByAdsFormat: function(obj){
		var that = obj;
		return function(){
			if ($(".trafficsource-templates-adsformat-select option:checked").val()!=0){
				that.ts_list_filter[0] = $(".trafficsource-templates-adsformat-select option:checked").html();
			}else{
				that.ts_list_filter[0]=0;
			}
		that.filterTemplatesList();
		}

	},

	addFilterTemplatesByTrafficType: function(obj){
		var that = obj;
		return function(){
			if ($(".trafficsource-templates-traffictype-select option:checked").val()!=0){
				that.ts_list_filter[1] = $(".trafficsource-templates-traffictype-select option:checked").html();
			}else{
				that.ts_list_filter[1]=0;
			}
		that.filterTemplatesList();
		}

	},

	addFilterTemplatesByName: function(obj){
		var that=obj;
		return function(event){

			if (event.keyCode==13){
				event.preventDefault();
			}
			if ($(".trafficsource-templates-name-search").val()!="Search"){
				that.ts_list_filter[2] = $(".trafficsource-templates-name-search").val();
			}else{
				that.ts_list_filter[2]=0;
			}
			that.filterTemplatesList();

		}
	},

	closeWindow: function(obj){
		$("#add_ts").css("display", "block");
		$(".window-trafficsource-templates-list").remove();
		if (typeof(obj)=="undefined"){
			this.ts_list_filter = ["","",""];
		}else{
			obj.ts_list_filter = ["","",""];
		}
	},

	closeWindowHandler: function(obj){
		var that = obj;
		return function(){
			obj.closeWindow();
		}
	}
}

function replacerMinutes(string, hours, minutes){
	return hours + ':00';
}

function blockMinutesChange(input){
	var datetime, reg1, reg2, match, minutes;
	datetime = $(input).val();
	reg = new RegExp('\\d{1,2}:(\\d*)', 'i');
	match = reg.exec(datetime);
	if (match != null && match[1] != 0){
		reg2 = new RegExp('(\\d{1,2}):(\\d*)', 'i');
		datetime = datetime.replace(reg2, replacerMinutes);
		$(input).val(datetime);
	}
}


function validateActForm(){
	var err = 0;

	if ($("#act-form #timedate").val()==12 || $("#act-form #timedate").val()==10){
		date_s = $("#act-form [name=date_s]").val().split("|");
		date_e = $("#act-form [name=date_e]").val().split("|");
		if (date_s.length>1){
			if ( new Date(date_s[0] + " " +date_s[1]) > new Date(date_e[0] + " " +date_e[1]) ){
				err +=1;
				//alert("Incorrect date/time!");
				var modal_alert = makeBadAlertModal("OK", "Incorrect date/time!");
				modal_alert.show();
			}

		} else {
			if (new Date(date_s[0]) > new Date(date_e[0])){
				err += 1;
				//alert("Incorrect date!");
				var modal_alert = makeBadAlertModal("OK", "Incorrect date!");
				modal_alert.show();
			}
		}
	}

	if (err==0){
		$('#act-form').submit();
		$(this).removeAttr('onclick');
	}
}

function addAllWrapsClickHandler(){
	$("body").on("click", ".wrap", function(){
	var windows = $(".window");
	if ($(this).css("display")!="none" && windows.size()>0){
		
		// handling closing secondlayer window load_from_templates window
		if ( $(".window-second-layer").length>0 ){
			$(".window-second-layer").find(".win_closebtn").trigger("click");
			return;
		}

		for (var i=0; i<windows.size();i++){
			if (windows.eq(i).css("display")!="none"){
				clear_closing();
				windows.eq(i).find(".win_closebtn").trigger("click");
				$("#wrap").css("display", "none");
			}
		}
	}
	});
}

$(document).ready(function(){
	
	$('[name="lp_url"]').keyup(function(eventObject){
		if(__pageType=='landing_pages'){
			if($('[name="lp_url"]').val()==''){
				$('#qrcode').html('');
				$('#qrcode').css('display','none');
			}else{
				$('#qrcode').html('');
				$('#qrcode').css('display','block');
				makeCode($('[name="lp_url"]').val());
			}
			
		}
	});
	
	var cssFix = function(){
	  var u = navigator.userAgent.toLowerCase(),
	  is = function(t){return (u.indexOf(t)!=-1)};
	  $(".body-container").addClass([
		(is('x11')||is('linux'))?' linux_os'
		  :is('mac')?' mac_os'
		  :is('win')?' win_os':' default_os'
	  ].join(''));
	  $("body").addClass([
		(is('x11')||is('linux'))?' linux_os'
		  :is('mac')?' mac_os'
		  :is('win')?' win_os':' default_os'
	  ].join(''));
	}();
	/*$(window).trigger("resize");*/
	$(".blocked_minutes").on("keyup change", function(){
		blockMinutesChange(this);
	});
	//Clear windows on click at black wrapper
	addAllWrapsClickHandler();

	setTimeout(function(){
			$(document).trigger("resize")
		}, 50);

});

function safeStringEscape(name){

	var replacer = function(char){
		return "";
	}

	var unsafe_reg = new RegExp("'", "g");
	name = name.replace(unsafe_reg, replacer);
	return name;
}

// @param string - string 
// @param length - int  max length
function cutTheString(string, length){

	if ( string.length>length ){
		return string.substr(0, length-3) + "...";
	} else {
		return string;
	}
}

noteWindow = {

	/**
	 * @param id - id of land or offers
	 * @param object_type - 'landing' or 'offer'
	 */
	init: function(id, object_type){
		if (this.window_opened==0){
			if (typeof(id) != "undefined"){
				this.window_opened = 1;
				this.id = id;
				this.row_name = $(".tr_active td.name_camp span:first-child").html();
				//set ajax_get_type and ajax_save_type to determine
				//what data['type'] will be send
				this.setAjaxTypesAndClassName(object_type);
				//Get text by ajax with id
				//Draw window as callback
				var text = this.getNote(this.id, this.noteWindow());
			} else {
				console.error('noteWindow Error: ID not found');
			}

		}
	},

	clear_note: function(){
		this.id = 0;
		this.object_type = 0;
		this.window_opened = 0;
	},

	//open window flag
	window_opened: 0,

	//id of object
	id: 0,

	//type of object
	object_type: "",


	row_name: "",

	//ajax data type parameter
	ajax_get_type: "",
	ajax_save_type: "",
	row_class_name: "",


	setAjaxTypesAndClassName: function(object_type){
		if (object_type == "landing"){
			this.ajax_get_type = 'get_landing_note';
			this.ajax_save_type = 'save_landing_note';
			this.row_class_name = "land";
		} else if (object_type == 'offer') {
			this.ajax_get_type = 'get_offer_note';
			this.ajax_save_type = 'save_offer_note';
			this.row_class_name = "offer";
		}
	},

	getNote: function(id, callback){
		$.ajax({
			type: 'post',
			url: '',
			data: {'ajax':1, 'type':this.ajax_get_type, 'id':id},
			success: function(data){
				callback(data);
			}
		});
	},


	noteWindow: function(){
		var that = this;
		return function(text){
            closeAnotherWindows();
			$("body").append(noteWindow.getWindowHTML());
			$("#note_window textarea").val(text);
			that.setListeners();
			noteWindowTokens.init("#node_text");
		}

	},

	setListeners: function(){
		$("#note_window .note-save-button").on("click", this.saveNote());
		$("#note_window .note-close-button").on("click", this.clearWindow());
		$("#note_window .win_closebtn").on("click", this.clearWindow());
	},

	saveNote : function(){
		var that = this;
		return function(){
			var text = $("#note_window textarea").val();
			$.ajax({
				url: "",
				type: "post",
				data: {"ajax":1, "type":that.ajax_save_type, id:that.id, text:text}
			}).success(function(data){

				if (text != ""){
					that.addStarToRow();
				} else {
					that.clearStarFromRow();
				}

				that.clearWindow()();
			});
		}
	},

	clearWindow: function(){
		var that = this;
		return function(){
			that.clear_note();
			$(".wrap.note_window_wrap").remove();
			$("#note_window").remove();
		}
	},

	addStarToRow: function(){
		var name_cell = $("#"+this.row_class_name+"_"+this.id+" .name_camp");
		if (name_cell.find("img").size() == 0) {
			$("#"+this.row_class_name+"_"+this.id+" .name_camp").append('<img style="margin-left:4px;" width="9px" src="templates/standart/images/green-star.png">');
		}
	},

	clearStarFromRow: function(){
		var name_cell = $("#"+this.row_class_name+"_"+this.id+" .name_camp"),
			img = name_cell.find("img");
		if (img.size()>0){
			img.remove();
		}
	},

	getWindowHTML: function(){ return  '<div id="wrap" class="wrap note_window_wrap" style="display: block;"></div>\
		<div class="window" id="note_window" style="display: block; width:600px;height:600px;">\
			<a onclick="notewindow_hide(this);" class="win_closebtn"></a>\
			<div class="win_header">\
				<span class="window_head_name" title="'+this.row_name+'">Note: ' + cutTheString(this.row_name, 50) + ' </span>\
			</div>\
			<div class="win_cap ">\
			</div>\
			<div class="win_content" >\
				<textarea id="node_text" style="width:100%; height:500px;resize:none;border:1px solid #ccc;"></textarea>\
			</div>\
			<div class="win_footer ">\
				<div class="win-buttons-block">\
					<a class="button win-save-button note-save-button"><img src="templates/standart/images/w-save.png" class="icon save_icon">Save</a>\
					<a class="button win-close-button note-close-button" ><img src="./templates/standart/images/w-close.png" class="icon close_icon">Close</a>\
				</div>\
			</div>\
		</div>'
	},
}



function closeAnotherWindows(){
    var windows = $(".window");

    for (var i = 0; i<windows.size(); i++){

        if (windows.eq(i).css("display") == "block"){
            $(".window .win_closebtn").trigger("click");
        }
    }

}

function makeButtonInProcess(button_selector, text){
	loader_animation = '<div class="sk-fading-circle">\
				  <div class="sk-circle1 sk-circle"></div>\
				  <div class="sk-circle2 sk-circle"></div>\
				  <div class="sk-circle3 sk-circle"></div>\
				  <div class="sk-circle4 sk-circle"></div>\
				  <div class="sk-circle5 sk-circle"></div>\
				  <div class="sk-circle6 sk-circle"></div>\
				  <div class="sk-circle7 sk-circle"></div>\
				  <div class="sk-circle8 sk-circle"></div>\
				  <div class="sk-circle9 sk-circle"></div>\
				  <div class="sk-circle10 sk-circle"></div>\
				  <div class="sk-circle11 sk-circle"></div>\
				  <div class="sk-circle12 sk-circle"></div>\
				</div>';
		$(button_selector).html("").append(text).append(loader_animation);
}

//this window opened by click on button "Import"
//landings/offers page
importWindow = {

	//type of import offer/landings
	object_type: "",

	//type of ajax request
	ajax_type: "import_from_textarea",

	//flag of opened window
	window_opened: 0,

	//sending request state
	sending_state: 0,

	init: function(object_type){
		this.window_opened = 1;
		this.setObjectName(object_type);
		this.drawWindow();
		this.setHandlers();
	},

	setObjectName: function(object_type){

		if (object_type=="landing_page"){
			this.object_type = "landing";
		} else if (object_type=="offers"){
			this.object_type = "offer";
		}

	},

	setHandlers: function(){
		$(".import-list-save-button").on("click", this.sendImportList());
		$(".import-list-close-button").on("click", this.closeWindow());
		$("#import_list_window .win_closebtn").on("click", this.closeWindow());
	},

	drawWindow: function(){
        closeAnotherWindows();
		$("body").append(this.getWindowHTML());
	},

	clearProperties: function(){
		importWindow.object_type = "";
		this.window_opened = 0;
	},

	clearWindow: function(){
		$(".wrap.import_list_window_wrap").remove();
		$("#import_list_window").remove();
	},

	disableSaveButton: function(){
		loader_animation = '<div class="sk-fading-circle">\
				  <div class="sk-circle1 sk-circle"></div>\
				  <div class="sk-circle2 sk-circle"></div>\
				  <div class="sk-circle3 sk-circle"></div>\
				  <div class="sk-circle4 sk-circle"></div>\
				  <div class="sk-circle5 sk-circle"></div>\
				  <div class="sk-circle6 sk-circle"></div>\
				  <div class="sk-circle7 sk-circle"></div>\
				  <div class="sk-circle8 sk-circle"></div>\
				  <div class="sk-circle9 sk-circle"></div>\
				  <div class="sk-circle10 sk-circle"></div>\
				  <div class="sk-circle11 sk-circle"></div>\
				  <div class="sk-circle12 sk-circle"></div>\
				</div>';
		$("#import_list_window .win-save-button").html("").append("Sending").append(loader_animation);
	},

	enableSaveButton: function(){
		$("#import_list_window .win-save-button").html("").append('<img src="templates/standart/images/w-save.png" class="icon save_icon">Import');
	},

	sendImportList: function(){
		var that = this;
		return function(){
			// do nothing if request is sending
			if (that.sending_state==1){
				return;
			}
			that.disableSaveButton();
			that.sending_state = 1;
			$.ajax({
				url: "",
				type: "post",
				data: {"ajax":1, "type":that.ajax_type, "text":$("#import_list_text").val(), "object_type":that.object_type}
			}).done(function(data){
				that.sending_state = 0;
				that.enableSaveButton();
				data = JSON.parse(data);
				if (data["status"] != "error"){
					//alert(data["status"]);
					var alert_window = makeGoodAlertModal("OK", data["status"], {'cross_button_hide' : true ,'footer_ok_callback' : function(){makeButtonLoaded($(".modal_window__ok-button"),"Reloading");window.location.reload()}});
					alert_window.show();
					//window.location.reload();
				} else {
					var alert_window = makeBadAlertModal("OK", changeNewLineOnBr(data["error"]));
					alert_window.show();
					//alert(data["error"]);
				}
			});
		}
	},

	closeWindow: function(){
		var that = this;
		return function(){
			that.clearProperties();
			that.clearWindow();
		}
	},

	getInfoMessage: function(){
		if (this.object_type=="landing"){
			return "<p style='margin-top:0px;font-size:11px;'>Name|URL [|Group|Lang|Offers] &nbsp;&nbsp;&nbsp;  [] - optional</p>";
		} else if(this.object_type == "offer") {
			return "<p style='margin-top:0px;' ><span style='margin-top:0px;font-size:11px;margin-bottom:8px;'>Name|URL|Payout/Auto [|Geo(US,UK etc.)|Group|Aff. network|Upsell(\"Upsell\" or nothing)]\
			<span style='padding-left:15px;font-size:11px;'> [] - optional</span></p>";
		}
	},

	getWindowHTML: function(){
		return '<div id="wrap" class="wrap import_list_window_wrap" style="display: block;"></div>\
			<div  class="window" id="import_list_window" style="display: block; width:600px;height:600px;">\
			<a onclick="notewindow_hide(this);" class="win_closebtn"></a>\
			<div class="win_header">\
				<span class="window_head_name">'+this.object_type.capitalizeFirstLetter()+' import </span>\
			</div>\
			<div class="win_cap ">\
			</div>\
			<div class="win_content" >\
				'+this.getInfoMessage()+'\
				<textarea id="import_list_text" style="width:100%; height:500px;resize:none;border:1px solid #ccc;"></textarea>\
			</div>\
			<div class="win_footer ">\
				<div class="win-buttons-block">\
					<a class="button win-save-button import-list-save-button"><img src="templates/standart/images/w-save.png" class="icon save_icon">Import</a>\
					<a class="button win-close-button import-list-close-button" ><img src="./templates/standart/images/w-close.png" class="icon close_icon">Close</a>\
				</div>\
			</div>\
		</div>'
	},

}

/**
 * makes window totally unavailable and wrap onclickable
 * only way to make this available again is refresh the page
 * @param id {string} id of window that needed to be unavailable with "#"
*/

/**
* id - window selector #add_lp for instance
* options - dict of options
*	  {blocked_button_text:"updating"} for instance
*/
function windowBlocker(id, options){
	this.id = id;
	this.button_text = $(id+ " .win-save-button" ).html().trim();
	this.blocked_button_text = options.blocked_button_text; 

	this.block = function(){

		var id = this.id;
		var height_of_content = $(id+" .win_content").height(),
		block = "<div class='loaded_blocker_block'></div>",
		message = "I am updating costs of your clicks now, please, wait",
		loader_animation = '<div class="sk-fading-circle">\
					  <div class="sk-circle1 sk-circle"></div>\
					  <div class="sk-circle2 sk-circle"></div>\
					  <div class="sk-circle3 sk-circle"></div>\
					  <div class="sk-circle4 sk-circle"></div>\
					  <div class="sk-circle5 sk-circle"></div>\
					  <div class="sk-circle6 sk-circle"></div>\
					  <div class="sk-circle7 sk-circle"></div>\
					  <div class="sk-circle8 sk-circle"></div>\
					  <div class="sk-circle9 sk-circle"></div>\
					  <div class="sk-circle10 sk-circle"></div>\
					  <div class="sk-circle11 sk-circle"></div>\
					  <div class="sk-circle12 sk-circle"></div>\
					</div>';

		$(id+" .win-close-button").addClass("button_inactive");

		$("body").off("click", ".wrap");
		$(".wrap").off("click");

		$(id+" .win-save-button").html("").append(this.blocked_button_text).append(loader_animation);

		//$(id).append("<div class='window-wrapper-block'></div>");
		$("body").append("<div class='window-wrapper-block'></div>");
		addAllWrapsClickHandler();
		$(".window-wrapper-block").on("click", function(){

		})
	}
	this.unblock = function(){
		var id = this.id;
		$(".window-wrapper-block").remove();
		$(id+" .win-save-button").html(this.button_text);
		$(id+" .win-close-button").removeClass("button_inactive");
	}

}
// save for old using
function makeWindowLoaded(id){
	var height_of_content = $(id+" .win_content").height(),
	block = "<div class='loaded_blocker_block'></div>",
	message = "I am updating costs of your clicks now, please, wait",
	loader_animation = '<div class="sk-fading-circle">\
				  <div class="sk-circle1 sk-circle"></div>\
				  <div class="sk-circle2 sk-circle"></div>\
				  <div class="sk-circle3 sk-circle"></div>\
				  <div class="sk-circle4 sk-circle"></div>\
				  <div class="sk-circle5 sk-circle"></div>\
				  <div class="sk-circle6 sk-circle"></div>\
				  <div class="sk-circle7 sk-circle"></div>\
				  <div class="sk-circle8 sk-circle"></div>\
				  <div class="sk-circle9 sk-circle"></div>\
				  <div class="sk-circle10 sk-circle"></div>\
				  <div class="sk-circle11 sk-circle"></div>\
				  <div class="sk-circle12 sk-circle"></div>\
				</div>';

	$(id+" .win_closebtn").unbind();
	$(id+" .win_closebtn").attr("onclick", "");

	$(id+" .win-save-button").attr("onclick", "");
	$(id+" .win-save-button").unbind("click");

	$(id+" .win-close-button").attr("onclick", "");
	$(id+" .win-close-button").unbind("click");
	$(id+" .win-close-button").addClass("button_inactive");

	$("body").off("click", ".wrap");


	$(id+" .win-save-button").html("").append("Updating").append(loader_animation);

	$(id+ " .win_content").append("<div class='window-wrapper-block'></div>");

	// Now i do not need any choice for this message but...
	/* $(id+" .win_content").html(
		$(block).append("<h1 style='color:pink;font-style:italic'>"+message+"</h1>").append(loader_animation).css("height", height_of_content)
		); */
}


/**
* Same but for modal windows
* new function coz different css selectors
* for buttons and blocks
* @param id {string} css id selector
* @param text {string} text for button
*/
function makeModalWindowLoaded(id, text){
	var height_of_content = $(id+" .win_content").height(),
	block = "<div class='loaded_blocker_block'></div>",
	message = "I am updating costs of your clicks now, please, wait",
	loader_animation = '<div class="sk-fading-circle">\
				  <div class="sk-circle1 sk-circle"></div>\
				  <div class="sk-circle2 sk-circle"></div>\
				  <div class="sk-circle3 sk-circle"></div>\
				  <div class="sk-circle4 sk-circle"></div>\
				  <div class="sk-circle5 sk-circle"></div>\
				  <div class="sk-circle6 sk-circle"></div>\
				  <div class="sk-circle7 sk-circle"></div>\
				  <div class="sk-circle8 sk-circle"></div>\
				  <div class="sk-circle9 sk-circle"></div>\
				  <div class="sk-circle10 sk-circle"></div>\
				  <div class="sk-circle11 sk-circle"></div>\
				  <div class="sk-circle12 sk-circle"></div>\
				</div>';

	$(id+" .win_closebtn").unbind();
	$(id+" .win_closebtn").attr("onclick", "");
	$("body").off("click", id+" .win_closebtn");


	$(id+" .button").attr("onclick", "");
	$(id+" .button").unbind("click");

	/*$(id+" .win-close-button").attr("onclick", "");
	$(id+" .win-close-button").unbind("click");*/
	$(id+" .win-close-button").addClass("button_inactive");

	$("body").off("click", ".wrap");

	var animated_button;
	if ($(id+" .modal_window__ok-button").length>0){
		animated_button = $(id+" .modal_window__ok-button");
	} else {
		animated_button = $(id+" .modal_window__close-button");
	}

	animated_button.html("").append(text).append(loader_animation);

	//$(id+ " .win_content").append("<div class='window-wrapper-block'></div>");
}

/**
 * "Object" type is was choosed coz need to handle onclick anywhere
 * @param button_obj {jQUery obj} id of window that needed to be unavailable with "#"
*/
function makeButtonLoaded(button_obj, text) {
	var loader_animation = '<div class="sk-fading-circle">\
				  <div class="sk-circle1 sk-circle"></div>\
				  <div class="sk-circle2 sk-circle"></div>\
				  <div class="sk-circle3 sk-circle"></div>\
				  <div class="sk-circle4 sk-circle"></div>\
				  <div class="sk-circle5 sk-circle"></div>\
				  <div class="sk-circle6 sk-circle"></div>\
				  <div class="sk-circle7 sk-circle"></div>\
				  <div class="sk-circle8 sk-circle"></div>\
				  <div class="sk-circle9 sk-circle"></div>\
				  <div class="sk-circle10 sk-circle"></div>\
				  <div class="sk-circle11 sk-circle"></div>\
				  <div class="sk-circle12 sk-circle"></div>\
				</div>';
	$(button_obj).html("").append(text).append(loader_animation);
}

function rightblock() {
	if ($(".filter_block_stats").size() > 0){
	    if ($(".filter_block_stats").offset().top>80) {$(".filter_block").css("float","left").css("marginLeft","-2px").css("marginTop","5px");
	    } else {$(".filter_block").css("float","right").css("marginTop","3px");}
	}
}

/*
####################
#     KEYBOARD     #
####################
*/
// it seems closure
// Function that add keyboards handlers on all pages
function addKeyboardHandlers() {

	
	var ctrl_pressed=false, // flag that true if ctrl was keydowned and false if was keyupped (it seems closure)
		// it seems closure
		ctrlPressHandlerExist=false; // is ctrlHandler added?

	function checkPage(){
		if (typeof __pageFormat != "undefined"){
			return true;
		}
		return false;
	}
	
	if (!checkPage()){
		return false;
	}

	var states = {};

	function setModalBlocker(){
		$(document).keydown(function(e){
			var e = e || event;
			if ($(".modal_window").length>0){
				var key_code = getKeyCode(e);
				if (key_code!=13 && key_code!=27){
					e.stopImmediatePropagation();
				}
			}
		});
	}
	
	setModalBlocker();

	function initStates(){
		// 1 is open 0 is close
		states["stat_tab"] = localStorage.typeStatState;
	}

	function addArrowForTabsHandlers(){
		if ($("#info_button").size()>0 && __pageFormat=="statistic"){
			
			$(document).keydown(function(e){

				if (isAnyInputFocus()){
					return;
				}

				var e = window.event||e;
				
				//right
				if (getKeyCode(e) == 39){
					e.preventDefault();
					openStatTab(states["stat_tab"]);
					states["stat_tab"] = 1;
					localStorage.typeStatState = 1;
				//left
				} else if (getKeyCode(e) == 37) {
					e.preventDefault();
					closeStatTab(states["stat_tab"]);
					states["stat_tab"] = 0;
					localStorage.typeStatState = 0;
				}
			});
		}
	}

	function addEnterHandlers(){
		var edit_action = ['landing_pages', 'offers', "networks", "traffic_sources", "users"],
			apply_action_formats = ['report', 'conversions', "report"];
		
		$(document).on("keydown", function(e){
			var e = e || event;
			if ($(".modal_window").length>0 && getKeyCode(e) == 13){
				$(".modal_window__ok-button")[0].click();
				e.stopImmediatePropagation();
			}

		});

		if (__pageFormat == "statistic" || __pageFormat=="users"){
			if (__pageType == "campaigns"){
				$(document).keydown(function(e){
                    if (isAnyInputFocus()){
                        return;
                    }
					if (getKeyCode(e) == 13){
						var row = $(".tr_active"),
							href;
						if (row.size()>0){
							e.preventDefault();
							$("#report")[0].click();
						}
					}
				});
			} else if (edit_action.indexOf(__pageType) != -1) {
				$(document).keydown(function(e){
                    if (isAnyInputFocus()){
                        return;
                    }
					if (getKeyCode(e) == 13){
						var row = $(".tr_active"),
							href;
						if (row.size()>0){
							e.preventDefault();
							if (typeof(edit)=="function"){
								edit();
							} else {
								$(".edit_button")[0].click();
							}
						}
					}
				});
			}
		} else if (apply_action_formats.indexOf(__pageFormat) != -1){
			
			$(document).on("keydown", function(e) {
                if (isAnyInputFocus()){
                    if ($("input:focus").hasClass("search_in_report") || $("input:focus").hasClass("search")){

                    } else {
                    	return;
                    }
                }
				// Check: is apply button active?
				if (getKeyCode(e) == 13){					
					if ($("#refresh-btn").hasClass("green-button")){
						event.preventDefault();
						$("#refresh-btn").trigger("click");
					}
				}

			});
		}
	}

	function addShiftHandlers(){
		var list_of_type_pages = ['offers', 'landing_pages', 'campaigns']
		if (__pageFormat == "statistic" && list_of_type_pages.indexOf(__pageType) != -1){
			// it seems like closure
			var infinityloop_flag = false;
			$(".table_stat").on("click", "tr", function(e){
				if (e.shiftKey){
					if (!infinityloop_flag){
						if ($(".tr_active").length>0){
							e.preventDefault();
							var index_of_start = $(".table_stat_tr").index($(".tr_active").eq(0)),
								index_of_end = $(".table_stat_tr").index($(this)),
								index_difference = index_of_end - index_of_start, 
								i, action_row;

								infinityloop_flag = true;
								/*$(".checkbox_group input[type=checkbox]:checked").prop("checked", true);
								action_after_check();*/
								infinityloop_flag = false;

								if (index_difference > 0) {
									action_row = $(".table_stat_tr").eq(index_of_start);
									
									infinityloop_flag = true;
									action_row.trigger("click");
									for (i=0; i<index_difference; i++){
										action_row = action_row.next();
										if (!action_row.hasClass(".tr_active") && action_row.css("display")!="none"){
											action_row.find(".id_td input[type=checkbox]").prop("checked", true);
											action_after_check();
										}
									}
									infinityloop_flag = false;
								} else if (index_difference < 0) {
									action_row = $(".table_stat_tr").eq(index_of_start);
									infinityloop_flag = true;
									//action_row.trigger("click");
									action_row.find(".id_td input[type=checkbox]").prop("checked", true);
									action_after_check();
									for (i=index_difference; i<0;++i){
										action_row = action_row.prev();
										if (!action_row.hasClass(".tr_active") && action_row.css("display")!="none"){
											action_row.find(".id_td input[type=checkbox]").prop("checked", true);
											action_after_check();
										}
									}
									infinityloop_flag = false;
								}
								
						}
					}
				}
			});
			$(document).on("keydown", function(e){
				if (getKeyCode(e) == 16){
					$(".table_stat").addClass("block_allocation");
				}
			});
			$(document).on("keyup", function(e){
				if (getKeyCode(e) == 16){
					$(".table_stat").removeClass("block_allocation");
				}
			});

		}
	}

	// @row_active {jQuery object}
	function getNextActionRow(row_active, direction){
		var next_row;
		if (direction=="up"){
			next_row = row_active.prev();
		} else if (direction=="down") {
			next_row = row_active.next();
		}
		if (next_row.length==0){
			return next_row;
		}
		while(next_row.css("display")=="none"){
			if (direction == "up"){
				next_row = next_row.prev();
			} else if (direction == "down") {
				next_row = next_row.next(); 
			}
		}
		return next_row;
	}

	// @direction :string up or down
	function arrowForRowsHandlersAction(direction, event){
		var row = $(".tr_active"),
			row_action;
			row_action = getNextActionRow(row, direction);

		if (row.length>0){

			if (row_action.length>0 && row_action.css("display") != 0){
				row.trigger("click");
				row_action.trigger("click");
			} else if (row_action.length==0){
				row.trigger("click");
				// If derection is "up" take last element
				if (direction == "up"){
					$(".table_stat_tr").eq($(".table_stat_tr").length-1).trigger("click");
					$(".body-container").scrollTop($(".table_stat")[0].offsetHeight);
				} else if (direction == "down") {
					$(".table_stat_tr").eq(0).trigger("click");
					$(".body-container").scrollTop(0);
				}

			}
		} else {
			var new_active = $(".table_stat_tr").eq(0);

			while (new_active.css("display") == "none"){
				new_active == new_active.next();
				if (new_active.length == 0){
					break;
				}
			}
			new_active.trigger("click");
		}

		var row_pos = ($(".tr_active")[0].offsetTop+20),
			table_pos =  ($(".body-container").height()  + $(".body-container").scrollTop());
		if (row_pos>table_pos ){
			// +1 in line below is border height
			var scroll_top = $(".body-container").scrollTop() + $(".tr_active").height() + 1;
			//finish_scroll_top = $(".tr_active")[0].offsetTop + $(".tr_active").height());

			$(".body-container").scrollTop(scroll_top);
		}

		if ($(".tr_active")[0].offsetTop < $(".body-container").scrollTop()){
			// -1 in line below  is border height
			var scroll_top = $(".body-container").scrollTop() - $(".tr_active").height();
			
			$(".body-container").scrollTop(scroll_top -1);
		}	
	}

	function addArrowForRowsHandlers(){

		if (__pageFormat == "statistic" || __pageFormat == "users"){
			$(document).on('keydown', function(e){

				if (isAnyInputFocus()){
					return;
				}

				var e = e || event;
				var row = $(".tr_active");
				//down
				if ( getKeyCode(e) == 40){
					e.preventDefault();
					arrowForRowsHandlersAction("down");
				}
				//up
				if ( getKeyCode(e) == 38){
					e.preventDefault();
					arrowForRowsHandlersAction("up");
				}
				
			});
		}
	}

	function getKeyCode(e){
		return (e.keyCode ? e.keyCode : e.which);
	}

	function addEscapeHandler(){

		$(document).on("keydown", function(e){
			var e = e || event, closed;
			if ($(".modal_window").length>0 && getKeyCode(e) == 27){
				var closed = false;
				// Try to click on cancel button
				if ($(".modal_window__cancel-button").length>0){
					$(".modal_window__cancel-button")[0].click();
					closed=true;
				}


				// Try to click on win_close button
				if ($(".modal_window .win_closebtn").length>0 && !closed){
					$(".modal_window__cancel-button")[0].click();
					closed=true;
				}

				// Try to click on ok button
				if ($(".modal_window__ok-button").length>0 && !closed){
					$(".modal_window__ok-button")[0].click();
					closed=true;
				}

				e.stopImmediatePropagation();
			}

		});

		if ( __pageFormat == "statistic" || __pageType=="add_camp"|| __pageType=="conversions" ||__pageType=="users" || __pageType=="report"){
			//Esc 
			$(document).keydown(function(e){
				if (getKeyCode(e) == 27){
					$(".wrap").each(function(i, elem){
						if ($(elem).css("display")!=="none"){
							$(elem).trigger("click");
						}
					});
				}
			});
		}
	}

	// Change variable ctrlpressed defined above
	function addCtrlPressHandler(){

		$(document).on("keydown", function(e){
			// set ctrl press flag true
			if (getKeyCode(e) == 17){
				ctrl_pressed = true;
				setTimeout(function(){
					ctrl_pressed = false;
				}, 750)
			}
		});

		$(document).on("keyup", function(e){
			// set ctrl press flag false
			if (getKeyCode(e) == 17){
				ctrl_pressed = false;
			}
		});
		ctrlPressHandlerExist = true;
	}

	function addCtrlEHandler(){
		if (__pageType=="campaigns" || __pageType=="report"){
			if (!ctrlPressHandlerExist){
				addCtrlPressHandler();
			}

			$(document).on("keydown", function(e){

				
				if (isAnyInputFocus()){
					return;
				}
				var e = e || event;
					
					if (ctrl_pressed && getKeyCode(e)==69 ){
						if (__pageType=="campaigns" && $(".tr_active").length==1){
							e.preventDefault();
							$("#edit")[0].click();
						} else if (__pageType=="report") {
							e.preventDefault();
							$("#edit")[0].click();
						}
						
					}
				
			});
		}
	}

	function saveWindowAction(e){
		if(ctrl_pressed){
			
			// find opened window
			$(".window").each(function(i, item){

				if ($(item).css("display")!="none"){
					e.preventDefault();
					//trigger click on save button in window block
					$(item).find(".win-save-button").trigger("click");
					return false;
				}

			});
			
		}
	}

	function addCtrlSHandler(){
		var list_of_page_format_save=["offers", "landing_pages", "networks", "traffic_sources", "conversions", "users", "campaigns", "report"];
		if (list_of_page_format_save.indexOf(__pageType) != -1 || __pageFormat == "add_camp"){

			if (!ctrlPressHandlerExist){
				addCtrlPressHandler();
			}

		}

		//For tracker-windows
		if (list_of_page_format_save.indexOf(__pageType) != -1){
				
			$(document).on("keydown", function(e){
				var e = e || event;
				// S handler
				if (getKeyCode(e) == 83){
					saveWindowAction(e);
				}

			});
		}  else if (__pageFormat == "add_camp") {
				
			$(document).on("keydown", function(e){
				var e = e || event;
				// S handler
				if (getKeyCode(e) == 83){
					if (ctrl_pressed){
						e.preventDefault();
						if (findOpenedWindow() != false){
							saveWindowAction(e);
						} else {
							$(".main_save_button_add_camp").trigger("click");
						}
					}
				}

			});
		}
	}

	function addCtrlRHandler(){

		if ( __pageFormat == "add_camp"){

			if (!ctrlPressHandlerExist){
				addCtrlPressHandler();
			}

			$(document).on("keydown", function(e){
				var e = e || event;
				if (getKeyCode(e) == 82 && ctrl_pressed){
					e.preventDefault();
					$(".add_camp_statistic_button")[0].click();
				}

			});

		}

	}

	// Move between tabs - Camps, Lands and etc
	function addNumbersHandlers(){

		$(document).on("keydown", function(e){
			var e = e || event, 
				keyCode = getKeyCode(e);

			if (isAnyInputFocus()){
				return;
			}

			if (keyCode >= 49 && keyCode <= 56){
				switch (keyCode){
					case 49:
						$(".menu_campaigns")[0].click();
					break;
					case 50:
						$(".menu_landing_pages")[0].click();
					break;
					case 51:
						$(".menu_offers")[0].click();
					break;
					case 52:
						$(".menu_networks")[0].click();
					break;
					case 53:
						$(".menu_traffic_sources")[0].click();
					break;
					case 54:
						$(".menu_trends")[0].click();
					break;
					case 55:
						$(".menu_conversions ")[0].click();
					break;
					case 56:
						$(".menu_users")[0].click();
					break;
				}
			}
		});
	}

	function isAnyInputFocus(){
		if ($("input:focus").length>0 || $("textarea:focus").length>0){
			return true;
		} else {
			return false;
		}
	}

	(function(){
		initStates();
		addArrowForTabsHandlers();
		addEnterHandlers();
		addArrowForRowsHandlers();
		addEscapeHandler();
		addShiftHandlers();
		addCtrlSHandler();
		addCtrlRHandler();
		addNumbersHandlers();
		addCtrlEHandler();
	})();



}
/*
####################
####################
*/

function reDrawZebra(){
		var cnt = 0;
		$(".table_stat tr").each(function(i ,elem){
			if ($(elem).css("display")!="none"){
	            if (cnt % 2 == 0){
	                
	                if (!$(elem).hasClass("gray_row")){
	                    $(elem).addClass("gray_row");
	                }

	            } else {
	                 $(elem).removeClass("gray_row");
	            }
	            cnt++;
	        }
		});
	}

/*
####################
#     SORTING      #
####################
*/
// sorting is referenced to first class of table cells 
function addClientSortingToPages() {

	var sorting_column_number = 0,
		sorting_column_name =  "",
		sorting_direction = 1,
		sort_object = {},
		asc_image = new Image(),
		desc_image = new Image(),
		//Jquery array of table rows
		rows,
		list_of_text_columns = new Array("name_td", "group_td", "source_td", "geo_td", "network_td", "source_name_td", "tokens_td"),
        localstorage_is_active = checkLocalStorageActive();
    	//localstorage_is_active = false,
    	list_of_checked_lines = new Array();

	desc_image.src ="templates/standart/images/up_3.png";
	asc_image.src = "templates/standart/images/down_3.png";
	desc_image.className = "direction_sort_icon";
	asc_image.className = "direction_sort_icon";

    // get value from storage
    function getStorageValue(property_name){
        if (localstorage_is_active) {
            return localStorage[property_name];
        } else {
            return $.cookie(property_name);
        }
    }

    function setStorageValue(property_name, value){
        if (localstorage_is_active) {
            return localStorage[property_name] = value;
        } else {
            return $.cookie(property_name, value);
        }
    }

	function removeLinksFromTableHeaders(){
		$(".stat_header td a").removeAttr("href");
		$(".stat_header td a").css("cursor", "pointer");
	}

	function getSortColumn(){
		if (typeof(localStorage.sortType) != "undefined"){
			return localStorage.sortType;
		}
	}

	function getSortDirection(){
		if (typeof(localStorage.sortDirection) != "undefined"){
			return localStorage.sortDirection;
		}
	}

	function setSortColumn(sort_column){
		localStorage.sortColumn = sort_column;
	}

	function setSortDirection(sort_direction){
		localStorage.sortDirection = sort_direction;
	}

	// @item - no Jquery, just DOM element
	function getNumberFromTableCell(item){
		return parseFloat($(item).find("td").eq(sorting_column_number-1).html().trim().replace(new RegExp("[%$,]", "g"), ""));
	}

	function getTextFromTableCell(item){
		return $(item).find("td").eq(sorting_column_number-1).html().trim();
	}

    function getTextFromTableCellFromSpan(item){
        return $(item).find("td").eq(sorting_column_number-1).find("span").eq(0).html().trim();
    }

	function getIDValueFromTableCell(item){
		return parseFloat($(item).find("td").eq(sorting_column_number-1).find("label").html().trim());
	}

	function getDataValueFromTablecell(item){
		return new Date($(item).find("td").eq(sorting_column_number-1).html().trim())
	}

	/* 
	   @arr : specific array of symbolic table-row objects
	   @direction : number. direction of sorting 1/-1. 1 - DESC; -1 - ASC
	*/
	function sortRowArray(arr, direction){
		var swapped = false,
			directFunc = (direction==1?compareForAsc:compareForDesc);
		do {
			swapped = false;
			for (var j=0; j<arr.length-1;j++){
				if (directFunc(arr[j]["value"], arr[j+1]["value"])){
					temp_row = arr[j];
					arr[j] = arr[j+1];
					arr[j+1] = temp_row;
					swapped = true;
				}
			}
		} while (swapped);
		return arr;
	}

	// it takes necessary clss from localStorage.sortColumn
	function addArrowIconToHeaderCell(){
		var header_cell_class = getStorageValue("sortColumnName"),
			direction_image = (getStorageValue("sortDirection")==1?desc_image:asc_image),
			cell_selector = ".stat_header ."+header_cell_class;
		$(".direction_sort_icon").remove();

		if (getStorageValue("sortColumnName") == "id_td"){
			if ($(cell_selector).find(".sort_link").parent().find(".checkbox_group").length>0){
				$(cell_selector).find(".sort_link").parent().find(".checkbox_group").after(direction_image);
			} else {
				$(cell_selector).find(".sort_link").prepend(direction_image);
			}
		} else {
			$(cell_selector).prepend(direction_image);
		}
	}

	/*
	 *  @direction -1/1 depending on this function return true/false
	 */
	function compareForDesc (elem1, elem2){
		if (elem1 < elem2){
			return true;
		} else {
			return false;
		}
	}

	function compareForAsc(elem1, elem2){
		if (elem1 > elem2){
			return true;
		} else {
			return false;
		}
	}

	

	function sortTable(){
		var time  = new Date();
		//function that will parse data from cell (getNumberFromTableCell/getTextFromTableCell/getIDValueFromTableCell)
		var getCellValueFunc;

		if (!(typeof(getStorageValue("sortColumnName")) != "undefined" && getStorageValue("sortColumnName") == sorting_column_name)){
			//localStorage.sortColumnName = sorting_column_name;
			//localStorage.sortDirection = 1;
            setStorageValue("sortColumnName", sorting_column_name);
            setStorageValue("sortDirection", -1);
		}
		
		var rows_length,
			sort_object = new Array(),
			// 1 is DESC, -1 is ASC
			sort_direction = 1,
			temp_row,
			swapped = false;
		// defined in root of this module var
		rows = $(".table_stat tr");
		rows_length = rows.length;

		// check type of column and define proper function for taking data from table cell
		if (list_of_text_columns.indexOf(getStorageValue("sortColumnName")) != -1){
			
            if ($(".table_stat tr").eq(0).find("."+sorting_column_name).find("span").length >0){
                getCellValueFunc = getTextFromTableCellFromSpan;
            } else {
                getCellValueFunc = getTextFromTableCell;
            }

		} else if (getStorageValue("sortColumnName") == "id_td" && $(".table_stat tr").eq(0).find("input[type=checkbox]").length>0) {
			getCellValueFunc = getIDValueFromTableCell;
		} else if (getStorageValue("sortColumnName") == "start_td"){
			getCellValueFunc = getDataValueFromTablecell;
		} else {
			getCellValueFunc = getNumberFromTableCell;
		}

		$(".table_stat tr").has("input[type=checkbox]:checked").each(function (i, item){
			list_of_checked_lines.push($(item).attr("data-id"));
		});

		$(".table_stat tr").each(function(i, item){
			sort_object.push( {
				number: i,
				value: getCellValueFunc(item)
				});
		});

		sort_object = sortRowArray(sort_object, getStorageValue("sortDirection"));

        addArrowIconToHeaderCell();
        
		/*printSortArr(sort_object);*/
		
		
		drawSortedArrayInTable(sort_object);

		setGlobalWindowLine();
        reDrawZebra();
	}

	function drawSortedArrayInTable(sort_arr){
		var html_table = "";
		var time = new Date();
		for (i=0; i<sort_arr.length; i++){
			html_table += rows.eq(sort_arr[i]["number"])[0].outerHTML;
		}	
		$(".table_stat tr").detach();
		$(".table_stat tbody").append(html_table);

		for (var i=0;i<list_of_checked_lines.length;i++){
			$(".table_stat tr[data-id="+list_of_checked_lines[i]+"] .checkbox_group input[type=checkbox]").prop("checked", true);
			action_after_check();
		}

		reDrawZebra();
		
	}

	function sortOnStart(){
		if (typeof(getStorageValue("sortColumnName")) != "undefined"){
            try {
    			sorting_column_name = getStorageValue("sortColumnName");
    			sorting_column_number = $(".stat_header").find("."+sorting_column_name).attr("id").replace("hrow", "");
                 sorting_direction = getStorageValue("sortDirection");
             } catch (err){
                 sorting_column_name = "clicks_td";
                 sorting_column_number = $(".stat_header").find("."+sorting_column_name).attr("id").replace("hrow", "");
                 sorting_direction = 1;    
             }
			
		} else {
			sorting_column_name = "click_td";

		}
		sortTable();
	}

	function sortAction(e){
		var e =  e || event;
		// on start
		if (typeof(e) == "undefined" || typeof(e.target.tagName) == "undefined") {

			if (typeof(getStorageValue("sortColumnName")) != "undefined"){
                try {
    				sorting_column_name = getStorageValue("sortColumnName");
    				sorting_column_number = $(".stat_header").find("."+sorting_column_name).attr("id").replace("hrow", "");
                    sorting_direction = getStorageValue("sortDirection");
                } catch (err){
                    sorting_column_name = "clicks_td";
                    sorting_column_number = $(".stat_header").find("."+sorting_column_name).attr("id").replace("hrow", "");
                    sorting_direction = 1;    
                }
				
			} else {
				sorting_column_name = "click_td";

			}
			sortTable();

		} else if (e.target.tagName == "A"){
			// replace explained specific of stat_header blocks id
			sorting_column_number = $(e.target).parent().attr("id").replace("hrow", "");
			sorting_column_name = $(e.target).parent().attr("class").split(' ')[0];
			sorting_direction = (typeof(getStorageValue("sortDirection"))=="undefined"?getStorageValue("sortDirection") *= -1:1);
			setStorageValue("sortDirection", getStorageValue("sortDirection")*-1);
			sortTable();			

		} else {
			return;
		}
	}

	function printSortArr(print_array){
		var arr = new Array();
		for (var i=0;i<print_array.length;i++){
			arr.push(print_array[i]["value"]);
		}
	}

	function addSortLinkClickHandler() {
		$(".stat_header").on("click", function(e){
			
			sortAction(e);

		});
	}

	// function that redraw zebra color on table
	



	(function(){
		var time = new Date();
		removeLinksFromTableHeaders();
		addSortLinkClickHandler();
		// on ready sorting
		$(document).ready(sortOnStart);
	})();
}
/*
#####################
#####################
*/

function openStatTab(){
	if (checkLocalStorageActive()){
        localStorage.typeStatState =  1;
    }
	$("#info_button").html("<img src=\"templates/standart/images/w-table.png\" class=\"icon stats_icon\"><span>Stat</span>");
	$(".table_td_info").css("display","table-cell");
	$(".table_td_stat").css("display","none");
	header_correlation();
}

function closeStatTab(){
	if (checkLocalStorageActive()){
	   localStorage.typeStatState =  0;
    }
	$("#info_button").html("<img src=\"templates/standart/images/w-note.png\" class=\"icon info_icon\"><span>Info</span>");
	$(".table_td_info").css("display","none");
	$(".table_td_stat").css("display","table-cell");
	header_correlation();
}

function onReadyToggleTabState(tab_state){
	if (tab_state==1){
		openStatTab();
	} else {
		closeStatTab();
	}
	header_correlation();
}

function toggleTabState(){
	if (localStorage.typeStatState==1){
		closeStatTab();
	} else {
		openStatTab();
	}
}

// Check: can i use localstorage?
function checkLocalStorageActive(){
    if (typeof localStorage === 'object') {
        try {
            localStorage.setItem('localStorage', 1);
            localStorage.removeItem('localStorage');
            return  true;
        } catch (e) {
            return false;    
        }
    } else {
        return false;
    }
}

function setGlobalWindowLine(){
	var rows = document.querySelectorAll("table.table_stat tr");
	for (var i=0; i<rows.length;i++){
		if (rows[i].style.display!="none"){
			window.line=$(rows[i]).find("td");
		}
	}

	if (typeof(window.line) == "undefined"){
		window.line=$("table.table_stat tr:first-child td");
	}
}

$(document).ready(rightblock);
$(document).ready(addKeyboardHandlers);

if (__pageFormat == "statistic"){

	$(document).ready(function(){
		setGlobalWindowLine();
		onReadyToggleTabState(localStorage.typeStatState);
		addClientSortingToPages();
		setTimeout(header_correlation, 300);
	});

	$(window).resize(header_correlation);
};

$(document).keydown(function(){
});

$(window).resize(rightblock);

function hideTablePreload(){
	$(".body-container").height(window.innerHeight-$(".body-container").offset().top-45);
	$(".body-container table").css("display", "none");
	//Ð”Ð¾Ð±Ð°Ð²Ð¸Ñ‚ÑŒ Ð¸ÐºÐ¾Ð½ÐºÑƒ 
	/*$(".body-container").append('<div class="table-load"><div class="table_load_icon">\
				<div class="sk-fading-circle">\
				  <div class="sk-circle1 sk-circle"></div>\
				  <div class="sk-circle2 sk-circle"></div>\
				  <div class="sk-circle3 sk-circle"></div>\
				  <div class="sk-circle4 sk-circle"></div>\
				  <div class="sk-circle5 sk-circle"></div>\
				  <div class="sk-circle6 sk-circle"></div>\
				  <div class="sk-circle7 sk-circle"></div>\
				  <div class="sk-circle8 sk-circle"></div>\
				  <div class="sk-circle9 sk-circle"></div>\
				  <div class="sk-circle10 sk-circle"></div>\
				  <div class="sk-circle11 sk-circle"></div>\
				  <div class="sk-circle12 sk-circle"></div>\
				</div>\
		</div></div>')*/
	$(".body-container").append('<div class="table-load">\
		<div class="sk-fading-circle sk-fading-circle-black">\
			  <div class="sk-circle1 sk-circle"></div>\
			  <div class="sk-circle2 sk-circle"></div>\
			  <div class="sk-circle3 sk-circle"></div>\
			  <div class="sk-circle4 sk-circle"></div>\
			  <div class="sk-circle5 sk-circle"></div>\
			  <div class="sk-circle6 sk-circle"></div>\
			  <div class="sk-circle7 sk-circle"></div>\
			  <div class="sk-circle8 sk-circle"></div>\
			  <div class="sk-circle9 sk-circle"></div>\
			  <div class="sk-circle10 sk-circle"></div>\
			  <div class="sk-circle11 sk-circle"></div>\
			  <div class="sk-circle12 sk-circle"></div>\
			</div>\
		</div>');
	
	$(".table-load").css("width", "100%").css("height", "100%");
	$(".table-load .sk-fading-circle").css({
		width: "60px",
    	height: "60px",
    	top: "calc(50% - 30px)",
    	left: "calc(50% - 30px)",
    	position: "absolute"
	});
}
function showTablePostLoad(){
	//Ð£Ð±Ñ€Ð°Ñ‚ÑŒ Ð¸ÐºÐ¾Ð½ÐºÑƒ
	$(".table-load").remove();
	$(".body-container table").css("display", "table");
}

function makeCode (url) {		
	var qrcode = new QRCode(document.getElementById("qrcode"), {width : 100,height : 100});
	qrcode.makeCode(url);
}

/* Find and return opened window
 * return {JQUERY OBJECT}
*/
function findOpenedWindow(){
	var window_blocks = $(".window");
	for (var i=0; i<window_blocks.length;i++){
		if (window_blocks.eq(i).css("display")!="none"){
			return window_blocks.eq(i);
		}
	}
	return false;
}


addCheckButtonToURL = {

	//Jquery obj
	block : $("<div>Test</div>").addClass("check_url_button"),
	url_selector : "", 
	/*
	 * @param {string} selector for input with needed URL
	*/
	init: function(url_selector, relative){
		if (typeof relative=="undefined"){ relative=false; }
		$(".check_url_button").remove();
		$(url_selector).off("keyup", this.checkInputFunction);
		this.url_selector = url_selector;
		this.relative = relative;
		url_input_block = $(url_selector);

		this.relative = relative;

		this.block.removeClass("check_url_button_inactive");		
		this.block.removeClass("check_url_button_active");
		
		
		if ($(url_selector).val().length>0){
			this.block.addClass("check_url_button_active");
		} else {
			this.block.addClass("check_url_button_inactive");
		}

		url_input_block.after(this.block);
		this.setHandlers();
	},

	setHandlers: function(){
		$(".check_url_button").on("click", this.makeCheckFunction(this));
		$(this.url_selector).on("keyup change", this.checkInputFunction);
	},

	makeCheckFunction: function(that){
		var that = that;
		return function (){

			var url = $(that.url_selector).val().trim(),
			edited_url,
			win;
			if (url != ""){
				try{
					edited_url = that.editforCorrectURL(url);
					if(edited_url.indexOf("{lp_key}")>-1){
						$.ajax({
							"url":"",
							"type":"get",
							"async": false,
							"data":{"ajax":1, "type":"lp_key"}
						}).success(function(data){
							edited_url=edited_url.replace('{lp_key}', data);
							if (this.relative){
								win = window.open(edited_url, '_blank');
							} else {
								win = window.open(edited_url, '_blank');
							}
							win.focus();
						});
					}else{
						win = window.open(edited_url, '_blank')
						win.focus();
					}
					
			  	} catch (e) {
			  		//alert("Cant check this URL.");
			  		var alert_window = makeBadAlertModal("Close", "Cant check this URL.");
			  		alert_window.show();
			  	}
	  		}
	  	}
	},

	editforCorrectURL: function(url){
		if (!this.relative && url.indexOf("http://")!=0 && url.indexOf("https://")!=0){ 
			return "http://" + url;
		} else {
			return url;
		}
	},

	checkInputFunction: function(that){
		if ($(this).val().length == 0){
			$(".check_url_button").removeClass("check_url_button_active").addClass("check_url_button_inactive");
		} else {
			$(".check_url_button").removeClass("check_url_button_inactive").addClass("check_url_button_active");
		}
	}

}


editCampHandler = {
	/**
	 * @param jobj_row {jQuery object} - object of row from window
	*/
	addLenderPath : function (jobj_row) {
						//something_was_changed+=1; 
						somethingWasChanged();
						var path_id=parseInt(jobj_row.parent().parent().attr("id").replace("path",""));
						var lps=parseInt($("#path"+path_id+" .path_lp_header").length);
						if(lps==0){lps=1}
						while ($("div").is("#lp_path_"+path_id+"_"+lps)) {
							lps=lps+1;
						}
						var new_lp_id=lps;
						jobj_row.parent().children(".lp_block").append('<div id="lp_path_'+path_id+'_'+new_lp_id+'" class="path_lp_header"><h3><a>Landing page</a> | <a>Direct</a></h3><a class="delete_btn"></a> <a class="pause_btn"></a> <input class="weight" name="path_'+path_id+'_lp_'+new_lp_id+'_split" value="100" type="text"><input type="hidden" value="1" name="path_'+path_id+'_lp_'+new_lp_id+'_type"><input type="hidden" value="1" name="path_'+path_id+'_lp_'+new_lp_id+'_status"><input type="hidden" value="" name="path_'+path_id+'_lp_'+new_lp_id+'_value"></div>');
					}

}


/*
###################
#  MODAL WINDOWS  #
###################
*/

// header, footer, styles is not necesserily arguments
// styles is object with width, height params and other
// footer OK/SAVE button necessarily must have modal_window__ok-button class
// 	for correct listener adding
// footer Cancel/Close button necessarily must have modal_window__cancel-button class
//  for the same reason (btw auto hanging close action)
/**
 * z-index of this window 10000 
 * where can be given html_code can be given jobj same way maybe (! it didnt test)
 * 
 * @param header_text {string} title of window
 * @param content {string} html code of window content
 * @param footer {string} html code
 * @param options {object} 
 *		@param footer_ok_callback {function} callback on click action on save/ok button
 *		@param css_class {string} string of window css class. This option can be given as
 *			   multiple classes separated by whitespaces
 * 		@param styles {object} object with css styles width, height, min-height
 * 		@param wrap {bool} Will draw black wrapp layer under window?
 *		@param cross_button_hide {boolean} Is cross button in top right hidden?
 * 		@param closing_ok_wrap {boolean} Closing window after "ok" action is true
 *		@param overflow_another_modal {boolean} If true then do not show when 
 *				any modal already showed and didnt close
 */
var Modal = function(header_text, content, footer, options){

	this.header_text = header_text;
	this.content = content;
	
	this.footer = footer;
	
	this.css_class = options["css_class"];

	this.css_id = "modal"+($(".modal_window").length+1);

	this.getSelector = function(css_class){
		return "."+css_class.split(" ").join(".");
	};

	this.css_selector = this.getSelector(this.css_class);

	this.styles = options["styles"];
	this.wrap = options["wrap"];
	this.footer_ok_callback = options["footer_ok_callback"];
	this.footer_cancel_callback = options["footer_cancel_callback"];
	this.cross_button_hide = options["cross_button_hide"];
	this.closing_ok_wrap = options["closing_ok_wrap"];
	this.hide_if_overflow = options["hide_if_overflow"];

	this.show = function(){
		if (this.hide_if_overflow && $(".modal_window").length>0){
			return;
		}
		if (this.wrap==true){
			this.showWrapper();
		}
		var window_jobj = this.makeWindow();
		// Check is any handler is string which means one of inner embedded methods
		// for instance "close"
		// If so is, redefined callbacks for neede methods
		// !CAREFULLY THIS FUNCTION CAN REDEFINE
		// SOME object's PARAMETERS (this.footer_cancel_callback,this.cross_button_hide)
		this.checkHandlersInnerMethods();
		this.addHandlers();
		$("body").append(window_jobj);
	};

	

	this.makeWindow = function(){
		// If footer was not taken get default
		var footer = (this.footer==undefined?"":this.getFooterHTML);

		var window_jobj = $("<div></div>").addClass("modal_window")
							.addClass(this.css_class)
							.attr("id", this.css_id)
							.css("z-index", this.getZindex())
							.append(this.getHeaderHTML())
							.append(this.getContentHTML(this.content))
							.append(this.getFooterHTML());

		if (this.styles != undefined) {
			if (this.styles["width"]){
				window_jobj.css("width", this.styles["width"]);
			}
			
			if (this.styles["height"] != undefined){
				window_jobj.css("height", this.styles["height"]);
			}

			if (this.styles["min-height"] != undefined){
				window_jobj.css("min-height", this.styles["min-height"]);
			}

			if (this.styles["overflow"] != undefined){
				window_jobj.css("overflow", this.styles["overflow"]);
			}
		}

		return window_jobj;
	};

	this.showWrapper = function(){
		if ( $(".modal_wrap").length>1){
			$(".modal_wrap").eq(0).css("opacity", 0.4);
		}
		$("body").append(this.getWrapHTML());
	};

	/*this.getWindowHTML= function(){
		return "<div class='modal_window'>\
				<div class='modal_window__content'>Модалка</div>\
				</div>"
	};*/

	this.getWrapHTML = function(){
		return "<div class='modal_wrap "+this.css_class+"_wrap' style='opacity:"+this.getWrapOpacity()+";z-index:"+this.getZindex()+"' ></div>" // TODO: check зачем здесь css_class??????
	};

	this.getContentHTML = function(content){
		return "<div class='modal_window_content'>"+content+"</div>";
	};

	this.getHeaderHTML = function(){
		var additional_class = (this.header_text==""?"modal_window__header--empty_text":""),
		cross_btn = (this.cross_button_hide?"":"<a class='win_closebtn'></a>");
		header_html = "<div class='modal_window__header " + additional_class + "'><h1>"+this.header_text+"</h1>"+cross_btn+"</div>";
		return header_html;
	};

	this.getFooterHTML = function(){
		footer_html = "<div class='modal_window__footer'>"+this.footer+"</div>";
		return footer_html;
	};

	this.getZindex = function(){
		var count_of_windows = $(".modal_window").length;
		return 10000+count_of_windows;
	};

	this.getWrapOpacity = function(){
		var count_of_wraps = $(".modal_wrap").length+1;
		return 0.8/count_of_wraps;
	};

	/**
	* @param css_selector {string} selector to taking window
	*/
	this.removeWindow = function(css_selector){
		if (typeof css_selector == "undefined"){
			css_selector = this.css_selector;
		}
		$(".modal_window"+css_selector).remove();
		$(".modal_wrap"+css_selector+"_wrap").remove();
	};

	this.makeRemoveWindowhandler = function(){
		var that = this;
		return function(){
			that.removeWindow.call(this.removeWindow, that.css_selector);
			$("body").off("click", ".modal_window"+that.css_selector+" .win_closebtn");
		};
	};

	this.checkHandlersInnerMethods = function (){
		
		if (this.footer_ok_callback == "close"){
			this.footer_ok_callback = this.makeRemoveWindowhandler();
		}
	};

	this.makeClosingWrappedCallback = function(func){
		var that = this;
		return function(){
			func();
			that.removeWindow(that.css_selector);
		}
	};

	this.addHandlers = function(){

		var ok_callback;

		$("body").on("click", ".modal_window"+this.css_selector+" .win_closebtn", this.makeRemoveWindowhandler());
		// TODO 
		$("body").on("click", ".modal_window"+this.css_selector+" .modal_window__cancel-button", this.makeRemoveWindowhandler());

		if (this.footer_ok_callback != undefined){ 

			if (this.closing_ok_wrap){
				ok_callback = this.makeClosingWrappedCallback(this.footer_ok_callback);
			} else {
				ok_callback = this.footer_ok_callback;
			}
			$("body").on("click", ".modal_window"+this.css_selector+" .modal_window__ok-button", ok_callback);
		}
		if (this.footer_cancel_callback != undefined){
			$("body").on("click", ".modal_window"+this.css_selector+" .modal_window__cancel-button", this.footer_cancel_callback);
		}
		
	}

};

// Function that make classic confirm modal window 
/**
* @param text_ok {string} text of ok button 
* @param text_cancel {string} text of cancel button
* @param ok_callback {function} callback on OK/SAVE action
* @param header_text {string} text of header of modal window
* @return {Modal Object}
*/
var makeConfirmModal = function(text_ok, text_cancel, ok_callback, header_text, content_text, additional_options){
	//var content = content_text,
	footer = '<div class="modal_window__buttons-block">\
			 <a class="button modal_window__ok-button" ><img src="templates/standart/images/w-ok.png" class="icon save_icon">'+text_ok+'</a>\
			 <a class="button  modal_window__cancel-button" ><img src="templates/standart/images/w-close.png" class="icon close_icon">'+text_cancel+'</a>\
			</div>',
	options = {"css_class":"modal_window--confirm", "styles":{"width":"440px", "height":"auto", "min-height":"50px", "overflow":"hidden"}, "wrap":true, "footer_ok_callback":ok_callback};
	if (typeof additional_options != "undefined"){
		$.extend(options, additional_options);
	}
	var modal_window = new Modal(header_text, content_text, footer, options);

	return modal_window;
}

/**
* Make alert for errors and other bad messages
* @param text_cancel {string} text alert single button
* @param content_text {string} text of alert
* @param additional_options {object} options for modal
* @return {Modal Object}
*/
var makeBadAlertModal = function(text_cancel, content_text, additional_options){
	//var content = content_text,
	footer = '<div class="modal_window__buttons-block">\
			 <a class="button modal_window__cancel-button" ><img src="templates/standart/images/w-close.png" class="icon close_icon">'+text_cancel+'</a>\
			</div>',
	options = {"css_class":"modal_window--alert modal_window--bad-alert", "styles":{"width":"440px", "height":"auto", "min-height":"50px", "overflow":"hidden"}, "wrap":true};
	if (typeof additional_options != "undefined"){
		$.extend(options, additional_options);
	}
	var modal_window = new Modal("", content_text, footer, options);
	return modal_window;
}

/**
* Make alert for success and other good messages
* @param text_cancel {string} text alert single button
* @param content_text {string} text of alert
* @param additional_options {object} options for modal
* @return {Modal Object}
*/
var makeGoodAlertModal = function(text_ok, content_text, additional_options){
	//var content = content_text,
	footer = '<div class="modal_window__buttons-block">\
			 <a class="button modal_window__ok-button" ><img src="templates/standart/images/w-ok.png" class="icon close_icon">'+text_ok+'</a>\
			</div>',
	options = {"css_class":"modal_window--alert modal_window--good-alert", "styles":{"width":"440px", "height":"auto", "min-height":"50px", "overflow":"hidden"}, "wrap":true};

	if (typeof additional_options != "undefined"){
		$.extend(options, additional_options);
	}

	var modal_window = new Modal("", content_text, footer, options);
	return modal_window;
}

/**
* Make alert that cant be closed
* if that modal was showed you can just wait
* this.showLoadingModal - open
* this.closeLoadingModal - close this
*/
var makeLoadingModal = function(text_ok, content_text, additional_options){
	
	//var content = content_text,
	footer = '<div class="modal_window__buttons-block">\
			 <a class="button modal_window__ok-button" ><img src="templates/standart/images/w-ok.png" class="icon close_icon">'+text_ok+'</a>\
			</div>',
	options = { "css_class":"modal_window--alert modal_window--good-alert", 
				"styles":{"width":"440px", "height":"auto", "min-height":"50px", "overflow":"hidden"}, 
				"wrap":true,
				"cross_button_hide": true};


	this.modal_window = new Modal("", content_text, footer, options);

	this.show = function(){
		this.modal_window.show();
		makeModalWindowLoaded("#" + this.modal_window.css_id, text_ok);
	};

	this.close = function(){
		this.modal_window.removeWindow();
	};

	if (typeof additional_options != "undefined"){
		$.extend(options, additional_options);
	}
}

/*
#########################
# END OF MODAL WINDOWS  #
#########################
*/

/**
* Add to network window block settings
* in form of status-payouts double inputs
*/
var NetworkWindowStatusPayoutOptions = {

	// count of options
	number: 0,

	window_obj : new Object(),
	network_id : 0,
	network_options_list: {},
	network_options_using: 0,
	network_options_approve: {},
	/**
	* @param obj {jQuery object} window object
	* @param format {string} For edit or create? [create, edit]
	*/
	init: function(obj, format, network_id){
		
		if (!network_id){
			this.network_id = obj.find("[name=win_net_id]").val();
		} else {
			this.network_id = network_id;
		}

		this.window_obj = obj;
		// saving from double adding
		if (obj.find(".network-status-options").length>0){
			return;
		}

		if (format == "create"){
			this.drawInitOptions();
			this.addHandlers();
		} else if (format == "edit"){
			// Add load animation
			this.addLoadingAnimation();
			// Animation remove in ajax callback
			this.getOptionsAjax(this.network_id);
		}
	},

	hideOptions: function(){
		this.window_obj.find(".network-status-options").css("display", "none");
	},

	addLoadingAnimation: function(){
		loader_animation = '\
				<div class="network-status-options__loading-animation">\
					<div class="sk-fading-circle sk-fading-circle-black">\
					<div class="sk-circle1 sk-circle"></div>\
					<div class="sk-circle2 sk-circle"></div>\
					<div class="sk-circle3 sk-circle"></div>\
					<div class="sk-circle4 sk-circle"></div>\
					<div class="sk-circle5 sk-circle"></div>\
					<div class="sk-circle6 sk-circle"></div>\
					<div class="sk-circle7 sk-circle"></div>\
					<div class="sk-circle8 sk-circle"></div>\
					<div class="sk-circle9 sk-circle"></div>\
					<div class="sk-circle10 sk-circle"></div>\
					<div class="sk-circle11 sk-circle"></div>\
					<div class="sk-circle12 sk-circle"></div>\
				</div>\
			</div>';
		
		makeButtonLoaded( this.window_obj.find(".win-save-button"), "loaded" );
		this.window_obj.find(".win-save-button").attr("onclick", "");

		this.window_obj.find("form").append(loader_animation);
	},

	removeLoadAnimation: function(){
		this.window_obj.find(".network-status-options__loading-animation").remove();

		this.window_obj.find(".win-save-button").html("");
		this.window_obj.find(".win-save-button").html('<img src="templates/standart/images/w-save.png" class="icon save_icon">Save');
		this.window_obj.find(".win-save-button").attr("onclick","check_net_form()");
	},

	drawInitOptions: function(){
		this.number += 1;
		this.window_obj.find(".win_content form")
				.append(this.makeToggler())
				.append($(this.makeBlock()).css("display","none"));

		if (this.window_obj.find(".network-status-options__loading-animation")){
			this.removeLoadAnimation();
		}
		$(".network-status-options__button-delete").on("click", this.makeRemoveLineHandler());
		$(".network-status-options-header").css("margin-bottom", "25px");
		this.setToggleState();

	},

	setOptionsUsing: function(options_using){
		var checkbox = this.window_obj.find(".network-status-options__using-checkbox"),
			options_block = this.window_obj.find(".network-status-options");
		if (options_using==1){
			checkbox.prop("checked", true);
			options_block.css("display", "block");
		}
	},

	drawLoadedOptions: function(data){
		var form = this.window_obj.find(".win_content form"),
			input_line, display_options;
		this.network_options_using = data["options_using"];
		
		this.network_options_list = data["options"]["options_list"];
		this.network_options_approve = data["options"]["approve"];

		if (this.network_options_using==1){
			display_options = "block";
		} else {
			display_options = "none";
		}

		form.append(this.makeToggler()).append($(this.makeWrapper()).css("display", display_options).append(this.makeControlBlock()).append(this.makeLineWrapper()).append(this.makeButtonAdd()) );

		if (this.network_options_using==1){
			$(".network-status-options__using-checkbox").prop("checked", true);
			$(".network-status-options__toggle-description").css("display", "inline");
		}

		for(var i=0;i<this.network_options_list.length;i++){
			// make input line
			input_line = this.addLine();
			input_line.find(".network-status-options__approve-radio").val(this.network_options_list[i][0]);
			if (this.network_options_approve == this.network_options_list[i][0]){
				input_line.find(".network-status-options__approve-radio").prop("checked", true);
			}
			// set values of inputs
			input_line.find(".network-status-options__status-input").val(this.network_options_list[i][0]);
			input_line.find(".network-status-options__payout-input").val(this.network_options_list[i][1]);
			$(".network-status-options__line-wrapper").append(
				input_line
			);
			
		}

		this.removeLoadAnimation();

		this.addHandlers();

		this.setToggleState();
	},

	makeControlBlock: function(){
		return '<div class="network-status-options__control-block">\
					'+this.makeCheckBox()+'\
				</div>';
	},

	makeToggler: function(){
		/*return "<div class='network-status-options-toggler-wrapper'>\
					<p class='network-status-options-toggler'>Settings</p>\
				</div>";*/
		return '<div class="field_span network-status-options-header">\
						<span style="width: 150px;">Status-payout relation</span> \
					</div>\
					<div class="field_input network-status-options-description" style="margin-bottom: 0px;">\
						<input type="checkbox" name="options_using" class="network-status-options-toggler network-status-options__using-checkbox" style="margin-left: -2px;display: inline !important;width: 15px;">\
						<span class="network-status-options__toggle-description" style="display:none; position: relative; top:-5px;">If conversion status = A then Payout = B</span>\
					</div>';
	},

	setToggleState: function(){
		$(".network-status-options-toggler img").remove();
		if ($(".network-status-options").css("display") == "none"){
			$(".network-status-options-toggler").prepend("<img src='templates/standart/images/arrow_down.png' class='icon' >");
		} else {
			$(".network-status-options-toggler").prepend("<img src='templates/standart/images/arrow_up.png' class='icon' >");
		}
	},

	makeCheckBox: function(){
		return "";
		// return "<label class='network-status-options__using-checkbox-label'><input type='checkbox' name='options_using' class='network-status-options__using-checkbox'>Using Options</label>";
	},

	makeBlock: function(){
		var block = $(this.makeWrapper())

					.append(this.makeControlBlock())
					
					.append(
						$(this.makeLineWrapper())
							.append(this.makeLine())
					 ).append(this.makeButtonAdd());
					
		return block;
	},

	makeWrapper: function(){
		return '<div class="network-status-options"></div>'
	},

	makeLineWrapper: function(){
		return '<div class="network-status-options__line-wrapper"></div>';
	},

	makeLine: function(number) {
		if (typeof number == "undefined"){
			number = 1;
		}
		return '<div data-number='+number+' class="network-status-options__line">\
					<input placeholder="Conversion status" onfocus="this.placeholder=\'\'" onblur="this.placeholder=\'Conversion status\'" class="settings_input classic_input_narrow network-status-options__status-input" name="status-option[]">\
					<input placeholder="Payout or token {payout}" onfocus="this.placeholder=\'\'" onblur="this.placeholder=\'Payout or token {payout}\'" class="settings_input classic_input_narrow network-status-options__payout-input" name="payout-option[]">\
					<!-- '+ this.makeLineRadio(this.number) +' -->\
					'+ this.makeButtonDelete() +'\
				</div>';
	},

	makeLineRadio: function(){
		return '<label><input type="radio" class="network-status-options__approve-radio" name="approve-option" value="xx">Is approve</label>';
	},

	makeButtonAdd: function(){
		return ' <a class="button network-status-options__button-add" ><img src="templates/standart/images/w-add.png" class="icon close_icon">Add</a>';
	},

	makeButtonDelete: function(){
		return '<a class="network-status-options__button-delete"></a>';
	},

	makeAddLineButtonHadler: function(){
		var that = this;
		return function(){
			that.addLine();
		};
	},

	makeRemoveLineHandler: function(){
		var that = this;
		return function(){
			$(this).parent().remove();
			that.number = that.number - 1;
		}
	},

	makeTogglerHandler: function(){
		var that = this;
		return function(){
			if ($(".network-status-options").css("display") == "block"){
				$(".network-status-options__toggle-description").css("display", "none");
				$(".network-status-options").css("display", "none");
				$(".network-status-options-header").css("margin-bottom", "25px");
			} else {
				$(".network-status-options").css("display", "block");
				$(".network-status-options__toggle-description").css("display", "inline");
				$(".network-status-options-header").css("margin-bottom", "0px");
			}
			that.setToggleState();
		}
	},

	makeBlockRemoveHandler:function(){
		var that = this;
		return function(){
			that.removeOptions();
		};
	},

	makeRadioButtonValueHandler:function(){
		var that = this;
		return function(){
			// Double parent for getting line wrapper
			$(this).parent().parent().find(".network-status-options__approve-radio").val($(this).val());
		}
	},

	/**
	* @param that {NetworkWindowStatusPayoutOptions Object} link to NetworkWindowStatusPayoutOptions object
	*/
	removeOptions:function(){
		this.number = 0;
		this.window_obj = {};
		$(".network-status-options").remove();
		$(".network-status-options-toggler").remove();
		$(".network-status-options-header").remove();
		$(".network-status-options-description").remove();
	},

	getLineBlockObject: function(number){
		return $(".network-status-options__line-wrapper").find("[data-number="+number+"]");
	},

	/**
	* Add line to options and set handlers
	* @return jobj_line
	*/
	addLine: function(){
		if (this.number>9){
			return;
		}
		var line;
		this.number += 1;
		line = this.makeLine(this.number);
		
		$(".network-status-options__line-wrapper").append(line);

		jobj_line = this.getLineBlockObject(this.number);

		jobj_line.find(".network-status-options__button-delete").on("click", this.makeRemoveLineHandler());
		jobj_line.find(".network-status-options__status-input").on("change keypress", this.makeRadioButtonValueHandler());
		return jobj_line
	},

	addHandlers: function(){
		$(".network-status-options__button-add").on( "click", this.makeAddLineButtonHadler() );
		$(".network-status-options-toggler").on( "click", this.makeTogglerHandler() );
		this.window_obj.find(".win_closebtn").on("click", this.makeBlockRemoveHandler());
		this.window_obj.find(".win-close-button").on("click", this.makeBlockRemoveHandler());
	},

	getOptionsAjax: function(id){
		$.ajax({
			"type":"post",
			"data":{
				"ajax":1,
				"type":"get_network_options",
				"id":id
			},
			"success": function(data){
				data = JSON.parse(data);
				if (data["options"]!=null && data["options"]["options_list"]!=""){
					NetworkWindowStatusPayoutOptions.drawLoadedOptions(data);
					if (data["options_using"]==0){
						NetworkWindowStatusPayoutOptions.hideOptions();
					}

				} else {
					NetworkWindowStatusPayoutOptions.drawInitOptions();
					NetworkWindowStatusPayoutOptions.setOptionsUsing(data["options_using"]);
					NetworkWindowStatusPayoutOptions.addHandlers();
				}
			}
		});
	}

}

// Page_types list
function makeOpacityColorize(){
		var positive_class = "green_row_opacity";
		var negative_class = "red_row_opacity";
		var result_class;
		var positive_ranges = [0, 21, 41, 61, 81, 101, 121, 141, 161, 181, 200];
		var negative_ranges = [0, -21, -41, -61, -81, -100];
		var roi = 0;
		var volume = 0;
		var rows = $(".tr_profit_1, .tr_profit_3");
		var getROIReport = function (row){
			return parseFloat(rows.eq(i).find("td").eq(11).html().replace(/[,%]/g, ""));
		}
		var getROITrends = function (row){
			return parseFloat(rows.eq(i).find("td").eq(10).html().replace(/[,%]/g, ""));
		}
		var getROIStat = function (row){
			return parseFloat(rows.eq(i).find(".roi_td").html().replace(/[,%]/g, ""));
		}
		if (__pageFormat=="statistic" || __pageFormat=="report" || __pageFormat=="trends"){
			var getROI;
			for (var i=0, l=rows.length;i<l;i++){

				volume = 0;
				if (__pageFormat=="statistic"){
					getROI = getROIStat;
					
				} else if (__pageFormat=="report" ){
					getROI = getROIReport;
				} else if ( __pageFormat=="trends"){
					getROI = getROITrends;
				}

				roi = getROI(rows.eq(i));
				console.log(roi);
				if (roi>0){
					for (var j=0, jl=positive_ranges.length;j<jl;j++){
						if (roi>positive_ranges[j]){
							volume = j + 1;
						}
					}
					result_class = positive_class;
				}
				else if (roi<0){
					for (var j=0, jl=negative_ranges.length;j<jl;j++){
						if (roi<negative_ranges[j]){
							volume = j + 1;
						}
					}
					result_class = negative_class;
				}
				rows.eq(i).addClass(result_class+"_"+volume);
			}

		} else if (__pageFormat=="report"){

		}
}

$(document).ready(function(){
	makeOpacityColorize();
});
