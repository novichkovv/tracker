var filterWindow = {

	//Инициализация окна фильтров
	init : function(block){
		this.window_block = block;
		this.window_content = $(this.window_block).find(".win_content");
		this.window_footer = $(this.window_block).find(".win_footer");

		this.setGroupsName();

		this.window_content.append("<form action='"+ window.location.href +"' class='filter-form' method='post'><div class='filter-rows-container' ></div></form>");
		this.window_content = $(".filter-form");
		this.rows_container = $(".filter-rows-container");

		this.window_content.append("<div class='filter-middle-block'></div>");
		this.middle_block = $(".filter-middle-block");

		this.window_content.append("<div class='filter-saveload-block'></div>");
		this.windows_saveload = $(".filter-saveload-block");

		// this.window_content.append("<input type='hidden' name='fid' >");

		this.initDraw();

	},	

	//Флаг активности окна
	active: false,

	//Номер последней добавленной строки ~ идентификатор
	row_number: 0,
	//Количество строк
	row_count: 0,

	//Имена группировок
	group_1_name: '',
	group_2_name: '',
	group_3_name: '',

	//Блок окна
	window_block: Object,
	//Блок контента окна
	window_content: Object,
	//Блок со строками
	rows_container: Object, 
	//Блок под строками (кнопка add и строка текста)
	middle_block:  Object,
	//Блок загрузки и сохзранения фильтров
	windows_saveload: Object,

	//Блок инпута со значением отправляемого фильтра. 0 если не из сохраненных
	window_fid_input: "<input type='hidden' name='window-fid'>",

	filters_arr : {},

	//Выставляет имена группировок
	setGroupsName : function(){

		this.group_1_name = $("#group1 option:selected").html();
		this.group_2_name = $("#group2 option:selected").html();
		this.group_3_name = $("#group3 option:selected").html();
		if (this.group_1_name == "Choose grouping"){
			this.group_1_name = "Group 1";
		}
		if (this.group_2_name == "Choose grouping"){
			this.group_2_name = "Group 2";
		}
		if (this.group_3_name == "Choose grouping"){
			this.group_3_name = "Group 3";
		}

	},

	//Создает селект выбора группы
	getGroupSelectHtml : function(g1,g2,g3, val){ var jobj=$('<select type="select" class="filter_group_name" name="filter_group_name[]"><option value="1">'+ g1 +'</option><option value="2">'+ g2 +'</option><option value="3">'+ g3 +'</option></select>');
													if (val){
														jobj.val(val);
													} else  {
														jobj.val(1);
													}
													return jobj;
												},
	//Создает селект выбора критерия
	getColumnSelect : function(val){ 
						var jobj = $('<select class="filter_column" name="filter_column[]">\
							<option selected value="1">Clicks</option>\
							<option value="2">LP Clicks</option>\
							<option value="3">LP CTR</option>\
							<option value="4">Leads</option>\
							<option value="5">CR</option>\
							<option value="6">CPC</option>\
							<option value="7">EPC</option>\
							<option value="8">Revenue</option>\
							<option value="9">Cost</option>\
							<option value="10">Profit</option>\
							<option value="11">ROI</option>\
							<option selected value="12">Name</option>\
						</select>');
						if (val){
							jobj.val(val);
						} else {
							jobj.val(1);
						}
						return jobj;
					},
	//Создает селект выбора сраненивя 
	getCompareSelect : function(val, column){
							var jobj
							if (column != undefined && column == 12){
								jobj = $('<select class="filter_compare_type" name="filter_compare[]">\
										<option value=1>=</option>\
										<option value=2><></option>\
										<option style="display:none" value=3>></option>\
										<option style="display:none" value=4>>=</option>\
										<option style="display:none" value=5><</option>\
										<option style="display:none" value=6><=</option>\
										<option value=7>IN</option>\
										<option value=8>NOT IN</option>\
									</select>');
							} else {
								jobj = $('<select class="filter_compare_type" name="filter_compare[]">\
										<option value=1>=</option>\
										<option value=2><></option>\
										<option value=3>></option>\
										<option selected value=4>>=</option>\
										<option value=5><</option>\
										<option value=6><=</option>\
										<option value=7 style="display:none">IN</option>\
										<option value=8 style="display:none">NOT IN</option>\
									</select>');
							}
							if (val){
								jobj.val(val);
							} else {
								jobj.val(1);
							}
							return jobj;
						},
	//
	getFilterValueInput : function(val){ var jobj = $('<input type="text" name="filter_value[]" class="input filter_value" data-number='+this.row_number+ 
													' style="width: 135px; font-size: 14px;border-color: #aaa;height:25px;\
													padding-left: 7px;border: 1px solid #aaa;background-color: #fff;border-radius: 5px;">');
									if (val || val === 0){
										jobj.val(val);
									} else {
										jobj.val(100);
									}
									return jobj;
								},

	getDeleteButton : function(){var jobj = $( '<a class="button gray-button filter-delete-button" data-number='+this.row_number+' style="position: relative;" id="addlist_btn">Delete</a>'); return jobj;},

	add_button : '<a class="button green-button add_condition_button" style="font-size: 14px; top: 5px;position: relative;" id="addlist_btn">Add condition</a> <span class="filter-condition-descr"><i>There is operator <b>AND</b> between conditions!<i></span>', 

	save_button: '<a class="button win-save-button filter-button"><img src="templates/standart/images/w-save.png" class="icon save_icon">Apply</a>',
	close_button: '<a class="button win-close-button" onclick="notewindow_hide2(this);"><img src="./templates/standart/images/w-close.png" class="icon close_icon">Close</a>',

	submitForm : function (){
		var inputs = $(".filter_value");
		var error = 0;
		$.each(inputs, function(i, el){

			if (!$.isNumeric($(el).val()) && $(".filter_column").val()!="12") {
				alert("Please enter numeric value!");
				error += 1;
				return;
			}

		});
		if (error == 0){
			$(".filter-form").submit();
		}
	},


	//Выставляет количество строк в окне. Если передается только объект окна - то только считает, если и количество, то тупо присваивает (нужно для удаления)
	setRowCount: function(obj, number){
		if (arguments.length == 1){
			obj.row_count = obj.window_content.find(".filter-row").size();
		} else {
			obj.row_count = number;
		}	
		return obj.row_count;
	},

	deleteRow : function (obj){ 
					var that=obj;
					return function () { 
							var number=$(this).attr("data-number"); 
							$(".row_"+number).remove();
							that.setRowCount(that);
							if (obj.row_count == 0){
								that.drawRow();
							}
							if ($("input[name=window-fid]").val()!=0){
								that.resetChoosenFilter();
							}
						}
				},

	clearRows : function (){
		$(".filter-rows-container").html("");
		this.setRowCount(this);
	},

	max_count: 8,

	drawRow : function (load_obj){

				var row;
				if (this.row_count<this.max_count){
					if (load_obj){
						filter_value = 0;
						//Если идет фильтр по нейм то значение сранвенивая
						//сохраняется в другой столбец - val_string
						if (load_obj['type_1']==12){

							filter_value = load_obj["val_string"];

						} else if (load_obj["val"] % 1 != 0){

							filter_value = load_obj["val"];

						} else {
							filter_value = parseInt(load_obj["val"]);
						}
						row = $('<div class="filter-row row_'+this.row_number+'"></div>').append(this.getGroupSelectHtml(this.group_1_name, this.group_2_name, this.group_3_name, load_obj["group_num"])).append(this.getColumnSelect(load_obj["type_1"])).append(this.getCompareSelect(load_obj["type_2"], load_obj["type_1"])).append(this.getFilterValueInput(filter_value)).append(this.getDeleteButton());
					} else {
						row = $('<div class="filter-row row_'+this.row_number+'"></div>').append(this.getGroupSelectHtml(this.group_1_name, this.group_2_name, this.group_3_name)).append(this.getColumnSelect()).append(this.getCompareSelect()).append(this.getFilterValueInput()).append(this.getDeleteButton());
					}	
					this.row_number++;
					this.row_count++;
				} else if (this.row_count >= this.max_count){

				} 					



				this.window_content.on("click", ".filter-delete-button", this.deleteRow(this));

				this.window_content.on("change", ".filter_column", function(){
					console.log("change");
					var select_filter_compare = $($(this).siblings()[1]),
							options = select_filter_compare.find("option"),
							value_input = $($(this).siblings()[2]);
					if ($(this).val()==12){
						
						for (var i = 0; i<options.length; i++){

							$(options[i]).css("display", "none");

							if ($(options[i]).val()=="1" || $(options[i]).val()=="2" || $(options[i]).val()=="7" || $(options[i]).val()=="8"){
								$(options[i]).css("display", "block");
							}

						}
					} else {
						if (select_filter_compare.val()=="7" || select_filter_compare.val()=="8"){
							select_filter_compare.val("1");
						}
						for (var i = 0; i<options.length; i++){
							if ($(options[i]).val()=="7" || $(options[i]).val()=="8"){
								$(options[i]).css("display", "none");
							} else {
								$(options[i]).css("display", "block");
							}
						}
					}
				});
				$(this.rows_container).append(row);
				this.changeHandlerOnRow();
			}, 

	load_filter_block : '<select class="filter-select-filters" style="width: 250px; font-size: 14px;border-color: #aaa">\
							<option value=0>Load filters</option>\
						 </select>\
						<a class="button gray-button filters-load-filter-button" style="top: 0px;position: relative;">Load</a>\
						<a class="button gray-button delete-filter-button" >Delete filter</a>',

	save_filter_block : '<input name="filter_new_name" placeholder="Name of new filter" type="text" class="input filter-enter-filter-name" onclick="this.placeholder=\'\';"><a class="button gray-button filters-save-filter-button" style="top: 0px;position: relative;" id="getlist_btn">Save</a>',

	getSavedFilters : function(that){$.ajax({
								url: "",
								type: "POST",
								data: {"type" : "get_filters_name",
									   "ajax":"1"},
								success:function(data) { 
									var options = JSON.parse(data), options_id=[], options_names=[], html='<option value=0>Choose filter</option>';

									for (var i=0;i<options.length;i++){
										options_id.push(options[i]["id"]);
										options_names.push(options[i]["name"]);
										that.filters_arr[options[i]["id"]]=options[i]["name"];
									}

									for (var i=0;i<options.length;i++){
										if ($("input[name=window-fid]").val()!=options[i]["id"]){
											html+='<option value='+options[i]["id"]+'>'+options[i]["name"]+'  '+options[i]["id"]+'</option>';
										}
									}

									var index = Object.keys(that.filters_arr).indexOf($("input[name=fid]").val());

									$(".filter-select-filters").html("");
									$(".filter-select-filters").append(html);

									options_names = [];
									options_id = [];

								}
							});
						},
	
	loadFilterMain : function(that, fid, loaded){

		loaded = "undefined" != typeof(loaded) ? loaded : false;  

		var time = Date.now();

		if (fid!=0){
			that.window_content.find("input, select").prop("disabled", true);
			$.ajax({
					url: "",
					type: "POST",
					data: {"type" : "get_filter",
							"id" : fid,
						   "ajax":"1"},
					success:function(data) { 
						//$(".window_head_name").append(" "+data["name"]);

						that.clearRows();
						data = JSON.parse(data);
						for (var i=0; i<data.length; i++){
							that.drawRow(data[i]);
						}

						if (Object.keys(that.filters_arr).indexOf(fid) != -1){
							$("input[name=window-fid]").val(fid);
							console.log("that.setNameHeader fid " + fid);
							that.setNameHeader(that, that.filters_arr[$("input[name=window-fid]").val()], fid);
						} else {
							that.window_content.find("input[name=window-fid]").val(0);
						}

						that.window_content.find("input, select").prop("disabled", false);
						that.getSavedFilters(that);
						that.setRowCount(that);
					}
				});
		} 
	},

	loadFilterFromSelect : function(obj, filter_id){
					var that=obj;
						return function (){
									var fid = $(".filter-select-filters").val();
									that.loadFilterMain(that, fid, true);
									
								}
				},
	
	//Сохраняет фильтр
	saveFilter : function(obj){
		var that=obj;
		return function(){
			var name = $(".filter-enter-filter-name").val();
			if (name!=""){
				that.window_content.find("input, select").prop("readonly", true);
				$(".filter-form").serialize();
				$.ajax({
						url: "",
						type: "POST",
						data: {"type" : "save_filter",
							   "ajax":"1",
								"form":$(".filter-form").serialize()},
						success:function(data) { 
							that.getSavedFilters(that);
							that.window_content.find("input, select").prop("readonly", false);
						}
					});
				} 
		};
	},

	deleteFilter : function(that){
		var that=that;
		
		return function(){


			if (confirm("Are you sure?")){
			//$(".delete-filter-button").css("display", "none");
			$.ajax({
					url: "",
					type: "POST",
					data: {"type" : "delete_filter",
						   "ajax":"1",
							"fid": $(".filter-select-filters option:selected").val()},
					success:function(data) { 

						//that.clearRows();
						//that.drawRow();
						//that.window_content.find("input[name=window-fid]").val(0);
						that.getSavedFilters(that);

					}
				});
			} 
		}
	},

	resetChoosenFilter : function(){
		$(".filter-select-filters").val(0);
		//$(".delete-filter-button").css("display","none");
		$("input[name='window-fid']").val(0);
		this.getSavedFilters(this);
		this.clearNameHeader();
	},

	changeHandlerOnRow : function(){
		var that = this;
		this.rows_container.find("select").on("change", function(){that.resetChoosenFilter()});
		this.rows_container.find("input").on("input", function(){that.resetChoosenFilter()});
	},

	setNameHeader : function(that, name, fid){
		
		if ($(".filter-select-filters").val() != "0"){
			fid = $(".filter-select-filters").val();
		}

		$(".filter-name-header").remove();
		that.window_content.before( "<div class='filter-name-header'><b>" + name + " (" + fid + ")"+ "<b></div>");
		
	},

	clearNameHeader : function(){
		$(".filter-name-header").remove();
	},

	clearWindow : function(){
 		this.window_content.remove();
 		this.window_footer.html("");
 		this.active = false;
 		this.setRowCount(this, 0);
 		this.clearNameHeader();
 		this.window_block.off("click", ".delete-filter-button");
	},

	initDraw: function() {
		
				var page_fid = $("input[name=fid]").val();				

				this.window_footer.append("<div class='win-buttons-block'>"+this.save_button+this.close_button+"</div>");
				this.window_footer.on("click",".win-save-button.filter-button", this.submitForm);

				this.middle_block.append(this.add_button);
				this.middle_block.on("click",".add_condition_button", $.proxy(this.drawRow, this));

				this.windows_saveload.append(this, this.load_filter_block);
				this.windows_saveload.on("click", ".filters-load-filter-button", this.loadFilterFromSelect(this));

				this.windows_saveload.append(this, this.save_filter_block);
				this.windows_saveload.on("click", ".filters-save-filter-button", this.saveFilter(this));

				this.window_block.on("click", ".delete-filter-button", this.deleteFilter(this));

				this.window_content.append(this.window_fid_input);

				this.getSavedFilters(this);

				if ( page_fid ){					
					
					this.loadFilterMain(this, page_fid);
					
				} else {
					this.drawRow();
				}

				this.active = true;

			},



}

