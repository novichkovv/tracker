$(document).ready(function() {
	$(".chosen-select").chosen();
	$(".chosen-container").css("float", "left");
	$('#get_win_filters').click(function(){
		$('#win_cl_filter').css('display','block');
		$('#wrap').css('display','block');
		$('.filter_group_name').html('');
		$.each( $(".stat_header-new tr td"), function( key, value ) {
			if($(value).attr('class')){
				name = $(value).attr('class');
				name = name.replace('head_column_','filter_');
				name2 = $('.'+$(value).attr('class')+' a').html();
				$('.filter_group_name').append('<option value="'+name+'">'+name2+'</option>');
			}
		});
	});
	$('#addlist_btn').click(function(){
		$('.filter-rows-container').append('<div class="filter-row">'+$('#first_element').html()+'<a class="button gray-button filter-delete-button" onclick="filter_delete(this)" style="position: relative;">Delete</a></div>');
		if($('.filter-row').length>11){
			$('#addlist_btn').css('display','none');
		}
	});
	$('#save_filter').click(function(){
		//$("#filter_form").submit();
		var form_data   = $('#filter_form').serialize();
		$.ajax({
			url : "",
			method: "post",
			data: form_data,
			success: function(data) {
				var url=document.location.href;
				url=set_get(url,'fid_cl',data);
				location.href = url;
			},
		});
	});
	$('#clear_filters').click(function(){
		var url=document.location.href;
		url=set_get(url,'fid_cl',0);
		location.href = url;
	});
});
	
function filter_delete(el){
	$(el).parent().detach(); 
	$('#addlist_btn').css('display','inline');
};