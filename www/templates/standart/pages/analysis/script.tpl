<script>
	var timerId1 = setInterval(function() {
	  astat_2();
	}, 1000);
	
	$(document).ready(function(){
		var interval=1000;
		var timerId2 = setInterval(function() {
		  astat_processlist();
		}, interval);
	});
	
	function astat_2(){
		if($("#astat_2_check").prop("checked")){
			$.ajax({
				url: "",
				type: "POST",
				data: {	"type" : "astat_2",
						"ajax":"1"
				},
				success: function(data) { 
					$("#astat_2").html(data);
				}
			});
		}
	}
	
	function aevent(){
		var form_data;
		form_data=$('#events_form').serialize();
		$.ajax({
			url: "",
			type: "POST",
			data: form_data,
			success: function(data) { 
				console.log(data);
			}
		});
	}
	
	function astat_processlist(){
		if($("#astat_3_check").prop("checked")){
			$.ajax({
				url: "",
				type: "POST",
				data: {	"type" : "astat_processlist",
						"ajax":"1"
				},
				success: function(data) { 
					$("#astat_3").html(data);
				}
			});
		}
	}
	
	
	function astop(id){
		$.ajax({
			url: "",
			type: "POST",
			data: {	"type" : "astop",
					"id" : id,
					"ajax":"1"
			}
		});
	}
	
	function arestart(id){
		$.ajax({
			url: "",
			type: "POST",
			data: {	"type" : "arestart",
					"id" : id,
					"ajax":"1"
			}
		});
	}
	
	function sql_kill(id){
		$.ajax({
			url: "",
			type: "POST",
			data: {	"type" : "asql_send",
					"sql_text" : "kill "+id,
					"sql_type" : 3,
					"ajax":"1"
			},
			success: function(data) { 
				alert(data);
			}
		});
	}
	
	function asql_send(){
		$.ajax({
			url: "",
			type: "POST",
			data: {	"type" : "asql_send",
					"sql_text" : $("#a_sql_text").val(),
					"sql_type" : $("#a_sql_type").val(),
					"ajax":"1"
			},
			success: function(data) { 
				$("#asql_send_load").html(data);
			}
		});
	}
</script>