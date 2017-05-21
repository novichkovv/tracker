//GLOBAL
__pageFormat = "settings";
__pageType = "settings";

$(window).load(function () {
	$("#user_timezone [value='<?php echo $arr_tpl['timezone']; ?>']").prop("selected", true);
	$("#customtable_input [value='<?php echo $arr_tpl['table_colors']; ?>']").prop("selected", true);
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
	

function download_import(){
	var data = new FormData();
    $.each(files, function( key, value ){
        data.append(key, value);
    });
	
	// Create and make "waiting please" window
	var loading_window = new makeLoadingModal("Uploading", "Upload file");
	loading_window.show();

	var import_load_callback = function(data){
		loading_window.close();
		if(data=='true'){
		   makeGoodAlertModal('OK', "Import Done", {"footer_ok_callback": "close"}).show();
		}else{
			if(data=='false'){
				// alert('Version incorrect');
				makeBadAlertModal('OK', 'Version incorrect', {"footer_ok_callback": "close"}).show();
			}else{
				// alert('Import Error');
				makeBadAlertModal('OK', 'Import Error', {"footer_ok_callback": "close"}).show();
			}
		}
	}

	$.ajax({
		url : "?ajax=1&type=download_import",
		method: "post",
		data: data,
		cache: false,
		processData: false,
		contentType: false,
	}).success(import_load_callback);
}

$(document).ready(function(){
	$('input[type=file]').change(function(){
		files = this.files;
	});

	if (!FlashDetect.installed){
		try {
			new Clipboard("#copy_btn1");
			new Clipboard("#copy_btn2");
			new Clipboard("#copy_btn3");
			new Clipboard("#copy_btn9");
			$("#copy_btn1").attr("data-clipboard-target", "#copy_value1");
			$("#copy_btn2").attr("data-clipboard-target", "#copy_value2");
			$("#copy_btn3").attr("data-clipboard-target", "#copy_value3");
			$("#copy_btn4").attr("data-clipboard-target", "#copy_value4");
			$("#copy_btn9").attr("data-clipboard-target", "#copy_value9");
		} catch (e){
			$("#url_input").css({"width":"100%"});
		}

	} else {
		addZclip("#copy_btn1", "#copy_value1");
		addZclip("#copy_btn2", "#copy_value2");
		addZclip("#copy_btn3", "#copy_value3");
		addZclip("#copy_btn4", "#copy_value4");
		addZclip("#copy_btn9", "#copy_value9");
	}					

});