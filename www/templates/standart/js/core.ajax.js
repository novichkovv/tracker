function load_ajax(url, block){
	$.ajax({  
		url: url,  
		cache: false,  
		success: function(html){  
			$(block).html(html);  
		}  
	}); 
}