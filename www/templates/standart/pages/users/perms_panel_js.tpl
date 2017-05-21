//GLOBAL
__pageFormat = "users";
__pageType = "users";

function hide_button(el){
	if($(el).hasClass("tr_active")){
		$(el).removeClass("tr_active");
        $(".edit_user_button").addClass("button_inactive");
        $(".edit_user_button").removeClass("green-button");
        $(".edit_user_button").prop("disabled", true);
        $(".clone_user_button").addClass("button_inactive");        
        $(".clone_user_button").removeClass("green-button");
        $(".clone_user_button").prop("disabled", true);
        $(".delete_user_button").addClass("button_inactive");        
        $(".delete_user_button").removeClass("gray-button");
        $(".delete_user_button").prop("disabled", true);
	}else{
		$("#clone").attr("class", "green-button");
		$(".tr_active").removeClass("tr_active");
		$(el).addClass("tr_active");
        $(".edit_user_button").removeClass("button_inactive");
		$(".edit_user_button").addClass("green-button");
        $(".edit_user_button").prop("disabled", false);
        $(".clone_user_button").removeClass("button_inactive");
        $(".clone_user_button").addClass("green-button");
        $(".clone_user_button").prop("disabled", false);
        $(".delete_user_button").removeClass("button_inactive");
        $(".delete_user_button").addClass("gray-button");
        $(".delete_user_button").prop("disabled", false);
	}
}

permsWindow = {

    //Если -1, то новый или клон
    user_id: -1,

    //При edit поле пароля должно быть заменено на скрытое поле + кнопку "Change password" его открывающую
    makeHTMLPasswordInput : function(){
        var html = '';
        if (this.user_id==-1){
            return '<span class="left_field">Password</span> \
                    <div class="right_field"><input value="" type="password" name="user_password"></div>';
        } else {
            return '<span class="left_field">Password</span> \
                    <div class="right_field"><div class="perms_change_password">Change password</div><input style="display:none;" value="" type="password" name="user_password"></div>';
        }
    },

    togglePasswordInput : function(){
        if ($("#perms_window input[name=user_password]").css("display")=="none"){
            $("#perms_window input[name=user_password]").css("display", "block");
            $("#perms_window .perms_change_password").css("display", "none");
        }
    },

    makeHTMLPermsForm : function(){
        return '<div class="win_perms_form">\
                <div class="field_span">\
                </div>\
                <div class="field_input">\
                    <form autocomplete="false">\
                        <span class="left_field">Username</span> <div class="right_field"> <input value="" type="text" name="user_login"></div>\
                        \
    					'+this.makeHTMLPasswordInput()+'\
                        \
                        <span class="left_field"><div>Group</div>\
                            <span class="tooltip window_tooltip window-tooltip-relative" style="position:relative;left: 20px;top: -40px;" title="Administrator have access to all users, campaigns, LPs, offers etc and can manage users. User have access to items based of his settings. Auditor can see everything but can\'t make actions." ></span>\
                        </span> \
                        <div class="right_field"> <select name="user_group" class="user_group"><option  value="1">Administrator</option><option value="2" selected>User</option><option value="3">Auditor</option></select></div>\
                        \
                        <style>\
                            #current_list {border: 2px solid #90CAF9; border-radius: 3px; width: auto; height: auto;padding: 7px 5px;}\
                        </style>\
                        <div class="perms_block">\
                            <div class="right_field"><div class="url-tokens-block" style="margin-top: 10px;margin-bottom: 3px;">\
                                <a class="url-tokens-title" style="font-weight: bold;">Permissions </a>\
                                <span class="tooltip window_tooltip window-tooltip-relative" style="position:relative;margin-top:0px;top:5px;" title="All - Means the user have access to all items. Added by himself - The user only have access to items that added by himself. Assigned - The user only have access to items you assigned. Added by himself & Assigned - The user only have access to items you assigned and items that added by himself. Read onle - The user can see but can\'t make actions. No - The user have no access to all items." style="margin-top: 0px;"></span>\
                                </div>\
                            </div>\
                            <span class="left_field">Сampaigns</span> \
                            <div class="right_field">\
    							<input type="hidden" name="el_type" value="11">\
                                <select name="perm_cm" class="perms_select">\
                                <option value="0" selected>All</option>\
                                <option value="1">Created by himself</option>\
                                <option value="2">Assigned groups</option>\
                                <option value="3">Created by himself and assigned groups</option>\
                                <option value="4">Read only</option>\
                                <option value="5">No</option>\
                                <input class="assing_perms_input assing_perms_input_camp" type="text" style="display:none">\
                                </select>\
                            </div>\
                            <span class="left_field">Offers</span> \
                            <div class="right_field">\
    							<input type="hidden" name="el_type" value="13">\
                                <select name="perm_of" class="perms_select">\
                                <option value="0" selected>All</option>\
                                <option value="1">Created by himself</option>\
                                <option value="2">Assigned groups</option>\
                                <option value="3">Created by himself and assigned groups</option>\
                                <option value="4">Read only</option>\
                                <option value="5">No</option></select>\
                                <input class="assing_perms_input assing_perms_input_offer" type="text" style="display:none">\
                            </div>\
                            <span class="left_field">LPs</span> \
                            <div class="right_field">\
    							<input type="hidden" name="el_type" value="12">\
                                <select name="perm_lp" class="perms_select">\
                                <option value="0" selected>All</option>\
                                <option value="1">Created by himself</option>\
                                <option value="2">Assigned groups</option>\
                                <option value="3">Created by himself and assigned groups</option>\
                                <option value="4">Read only</option>\
                                <option value="5">No</option></select>\
                                <input class="assing_perms_input assing_perms_input_land" type="text" style="display:none">\
                            </div>\
                            \
                            <span class="left_field" style="width: 105px; padding-right:0px;text-align: left;">Traffic sources</span> \
                            <div class="right_field">\
    							<input type="hidden" name="el_type" value="5">\
                                <select name="perm_ts" class="perms_select">\
                                <option selected="" value="0">All</option>\
                                <option value="1">Created by himself</option>\
                                <option value="2">Assigned</option>\
                                <option value="3">Created by himself and assigned</option>\
                                <option value="4">Read only</option>\
                                <option value="5">No</option></select>\
                                <input class="assing_perms_input assing_perms_input_ts" type="text" style="display:none">\
                            </div>\
                            \
                            <span class="left_field">Aff. networks</span> \
                            <div class="right_field">\
    							<input type="hidden" name="el_type" value="4">\
                                <select name="perm_an" class="perms_select">\
                                <option selected="" value="0">All</option>\
                                <option value="1">Created by himself</option>\
                                <option value="2">Assigned</option>\
                                <option value="3">Created by himself and assigned</option>\
                                <option value="4">Read only</option>\
                                <option value="5">No</option></select>\
                                <input class="assing_perms_input assing_perms_input_network" type="text" style="display:none">\
                            </div>\
                            <span class="left_field">Show profit</span> \
                            <div class="right_field">\
                                <select name="perm_pr" class="perm_pr">\
                                <option selected="" value="0">Yes</option>\
                                <option value="1">No</option></select>\
                            </div>\
                    </div>\
                </form>\
                </div>\
            </div>';
    },

    makeHTMLPermsWindow : function(){
        return '<div id="wrap" class="wrap" style="display: block"></div>\
            <div class="window" id="perms_window" style="display:block;width:700px;" ">\
                <a onclick="notewindow_hide(this);" class="win_closebtn"></a>\
                <div class="win_header">\
                    <span class="window_head_name">User settings</span>\
                </div>\
                <div class="win_cap">\
                </div>\
                <div class="win_content">\
                    '+ this.makeHTMLPermsForm() +'\
                </div>\
                <div class="win_footer ">\
                    <div class="win-buttons-block">\
                        <a class="button win-save-button"><img src="templates/standart/images/w-save.png" class="icon save_icon"> Save </a>\
                        <div class="button win-close-button"  onclick="notewindow_hide2(this);"><img src="./templates/standart/images/w-close.png" class="icon close_icon">Close</div>\
                    </div>\
                </div>\
            </div>';
    },

    savePerms : function(){
    },

    closeWindow : function(){
        $(".wrap").remove();
        $("#perms_window").remove();
        permsWindow.user_id = -1;
        usersPanel.form_state = 0;
        usersPanel.window_opened = false;
    },

    initWindowHandlers : function(){
        this.setFormFieldHandlers();
    },

    setFormFieldHandlers : function(){
        var that = this;
        $("#perms_window .perms_select").on("change", function(){

            if ($(this).val()==2 || $(this).val()==3){
                //$(this).parent().find("input").css('display', 'none');
                //Инициируется tokenize
                that.addTokenizeToInput($(this));                
            } else {
                //$(this).parent().find("input").css('display', 'none');
                that.removeTokenizeToInput($(this));
            }

        });

        $("#perms_window .perms_change_password").on("click", this.togglePasswordInput);

        $("#perms_window .user_group").on("change", function(){
            if ($(this).val()==1){
                $("#perms_window .perms_select").val(0);
                $("#perms_window .perms_select").prop("disabled", true);
                $("#perms_window .perm_pr").val(0);
                $("#perms_window .perm_pr").prop("disabled", true);
                $("#perms_window .perms_select").prop("disabled", true);
                $("#perms_window .assing_perms_input").css('display', 'none');
                $("#perms_window .assing_perms_input").prop('disabled', true);
            } else if ($(this).val()==2){
                $("#perms_window .perms_select").val(0);
                $("#perms_window .perms_select").prop("disabled", false);
                $("#perms_window .perm_pr").val(0);
                $("#perms_window .perm_pr").prop("disabled", false);
                $("#perms_window .perms_select").prop("disabled", false);
                $("#perms_window .assing_perms_input").css('display', 'none');
                $("#perms_window .assing_perms_input").prop('disabled', true);
            } else if ($(this).val()==3){
                $("#perms_window .perms_select").val(4);
                $("#perms_window .perms_select").prop("disabled", true);
                $("#perms_window .perm_pr").val(0);
                $("#perms_window .perm_pr").prop("disabled", true);
                $("#perms_window .perms_select").prop("disabled", true);
                $("#perms_window .assing_perms_input").css('display', 'none');
                $("#perms_window .assing_perms_input").prop('disabled', true);
            }
        });


    },

    addTokenizeToInput: function(jobj){
        var type = jobj.attr('name');
        //Для кампании
        if (type=='perm_cm'){
            $("#perms_window .assing_perms_input_camp").tokenize({datas:"", textField:"name", htmlField:"name", valueField:"id", nbDropdownElements:"1000"});
            $("#perms_window .assing_perms_input_camp").tokenize().options.ajax_params = {'type':'find_groups', 'ajax':'1', 'group_type':'1'};
            $("#perms_window .assing_perms_input_camp").tokenize().enable();
        } else if (type=='perm_of') {
            $("#perms_window .assing_perms_input_offer").tokenize({datas:"", textField:"name", htmlField:"name", valueField:"id", nbDropdownElements:"1000"});
            $("#perms_window .assing_perms_input_offer").tokenize().options.ajax_params = {'type':'find_groups', 'ajax':'1', 'group_type':'3'};
            $("#perms_window .assing_perms_input_offer").tokenize().enable();
        } else if (type=='perm_lp'){
            $("#perms_window .assing_perms_input_land").tokenize({datas:"", textField:"name", htmlField:"name", valueField:"id", nbDropdownElements:"1000"});
            $("#perms_window .assing_perms_input_land").tokenize().options.ajax_params = {'type':'find_groups', 'ajax':'1', 'group_type':'2'};
            $("#perms_window .assing_perms_input_land").tokenize().enable();
        } else if (type=='perm_ts'){
            $("#perms_window .assing_perms_input_ts").tokenize({datas:"", textField:"name", htmlField:"name", valueField:"id", nbDropdownElements:"1000"});
            $("#perms_window .assing_perms_input_ts").tokenize().options.ajax_params = {'type':'find_ts', 'ajax':'1'};
            $("#perms_window .assing_perms_input_ts").tokenize().enable();
        } else if (type=='perm_an'){
            $("#perms_window .assing_perms_input_network").tokenize({datas:"", textField:"name", htmlField:"name", valueField:"id", nbDropdownElements:"1000"});
            $("#perms_window .assing_perms_input_network").tokenize().options.ajax_params = {'type':'find_networks', 'ajax':'1'};
            $("#perms_window .assing_perms_input_network").tokenize().enable();
        }
        jobj.parent().find('.Tokenize').css('display', 'block');
    },

    removeTokenizeToInput: function(jobj){
        var type = jobj.attr('name');
        if (jobj.parent().find(".Tokenize").size() == 0){
            return false;
        }
        //Для кампании
        if (type=='perm_cm'){
            $("#perms_window .assing_perms_input_camp").tokenize().disable();
        } else if (type=='perm_of') {
            $("#perms_window .assing_perms_input_offer").tokenize().disable();
        } else if (type=='perm_lp') {
            $("#perms_window .assing_perms_input_land").tokenize().disable();
        } else if (type=='perm_ts'){ 
            $("#perms_window .assing_perms_input_ts").tokenize().disable();
        } else if (type=='perm_an'){ 
            $("#perms_window .assing_perms_input_network").tokenize().disable();
        }
        jobj.parent().find('.Tokenize').css('display', 'none');
    },

    setWindowButtonHandlers : function(){
        $("#perms_window .win_footer .win-close-button").on("click", this.closeWindow);
        $("#perms_window .win_closebtn").on("click", this.closeWindow);
        $("#perms_window .win_footer .win-save-button").on("click", this.savePerms(this));
    },

    //Функция сохранения пермишшенов (!)
    savePerms: function(obj){
        var that = obj;
        return function(){
            var form_data = that.validateForm();
            if (form_data){
                that.sendPerms(form_data);
            } else {
                console.log('0');
            }
        }
    }, 

    //Проводит валидацию; возвращает либо false либо объект с данными
    validateForm: function(){
        var select, perms_obj = {} ,selects = $(".perms_select"),  err = 0;
        if (permsWindow.user_id != -1){
            perms_obj["id"] = permsWindow.user_id;
        }
        if ($("#perms_window input[name=user_id]").val()){
            perms_obj["id"] = $("#perms_window input[name=user_id]").val();
        }
		
        perms_obj["user_group"] = $("#perms_window .user_group").val();

        if ($("#perms_window input[name=user_login]").val()==""){
            $("#perms_window input[name=user_login]").css('border', '1px solid red');
            err += 1;
        } else {
            $("#perms_window input[name=user_login]").css('border', '1px solid #ccc');
            perms_obj["login"] = $("#perms_window input[name=user_login]").val();
        }


        if ($("#perms_window input[name=user_password]").css("display") != "none" && $("#perms_window input[name=user_password]").val()==""){
            $("#perms_window input[name=user_password]").css('border', '1px solid red');
            err += 1;
        } else {
            $("#perms_window input[name=user_password]").css('border', '1px solid #ccc');
            if ($("#perms_window input[name=user_password]").css("display") != "none"){
                perms_obj["password"] = $("#perms_window input[name=user_password]").val();
            }
        }

		perms_obj["perms"] = {};
		var el=1;
        selects.each(function(i, item){
            select = $(item);
            perms_obj[select.attr("name")] = select.val();
			if ($(item).val()==2 || $(item).val()==3){
				if (select.parent().find(".TokensContainer .Token").size() == 0){
					err+=1;
                    select.parent().find(".Tokenize").css('border', '1px solid red');
				}else{
					select.parent().find(".Tokenize").css('border', '2px solid #90CAF9');
					select.parent().find(".TokensContainer .Token").each(function(i, item){
						perms_obj["perms"][el]={};
						perms_obj["perms"][el]["el_id"]=$(item).attr('data-value');
						perms_obj["perms"][el]["el_type"]=select.parent().find("[name=el_type]").val();
						if(select.val()==4){
							perms_obj["perms"][el]["el_perm"]=2;
						}else{
							perms_obj["perms"][el]["el_perm"]=1;
						}
						el=el+1;
					});
				}
			}
            /*perms_obj["perms"] = {};
            perms_obj["perms"][select.attr("name")] = {};
            perms_obj["perms"][select.attr("name")]["type"] = select.val();
            if ($(item).val()==2 || $(item).val()==3){
                if (select.parent().find(".TokensContainer .Token").size() == 0){
                    err+=1;
                    select.parent().find(".Tokenize").css('border', '1px solid red');
                } else {
                    select.parent().find(".Tokenize").css('border', '2px solid #90CAF9');
                    perms_obj["perms"][select.attr("name")]["values"] = [];
                    select.parent().find(".TokensContainer .Token").each(function(i, item){
                        perms_obj["perms"][select.attr("name")]["values"].push($(item).attr('data-value'));
                    });
                    
                }
            }*/
        });

        perms_obj["perm_pr"] = $(".perm_pr").val();
        if (err>=1){
            return false;
        } else {
            return perms_obj;
        }
    },

    sendPerms: function(form_data){
        form_data = JSON.stringify(form_data);
        $.ajax({
            url : "",
            method: "post",
            data: {
				"type":"save_user_perms",
				"ajax":"1",
				"data":form_data
			}
        }).success(function(data){
            if (data=="double"){
                $("#perms_window [name=user_login]").css("border","1px solid red");
                alert("User with this name already exists!");
            } else {
                location.reload();
            }
        });

    },

    loadUserPerms: function(json, clone){
        if (clone === undefined){
            clone = false;
        }

        var i, len, group_id, group_name, userperms = JSON.parse(json);
        if (!clone){
            $("#perms_window input[name=user_login]").val(userperms['login']);
        }
        $("#perms_window input[name=user_password]").val(userperms['password']);
        $("#perms_window input[name=user_id]").val(userperms['user_id']);
        $("#perms_window [name=user_group]").val(userperms["user_group"]);
        $("#perms_window [name=perm_cm]").val(userperms.perm_cm["type"]);
        $("#perms_window [name=perm_pr]").val(userperms.perm_pr["type"]);
        $("#perms_window [name=perm_cm]").trigger("change");

        if (userperms["user_group"]==1){

            $("#perms_window .perms_select").val(0);
            $("#perms_window .perms_select").prop("disabled", true);
            $("#perms_window .perm_pr").val(0);
            $("#perms_window .perm_pr").prop("disabled", true);
            $("#perms_window .perms_select").prop("disabled", true);
            $("#perms_window .assing_perms_input").css('display', 'none');
            $("#perms_window .assing_perms_input").prop('disabled', true);

        } else if (userperms["user_group"]==3){

            $("#perms_window .perms_select").val(4);
            $("#perms_window .perms_select").prop("disabled", true);
            $("#perms_window .perm_pr").val(0);
            $("#perms_window .perm_pr").prop("disabled", true);
            $("#perms_window .perms_select").prop("disabled", true);
            $("#perms_window .assing_perms_input").css('display', 'none');
            $("#perms_window .assing_perms_input").prop('disabled', true);
    
        } else {
            if (userperms.perm_cm.type==2 || userperms.perm_cm.type==3){
                //Количество добавленных групп
                len = userperms.perm_cm.values.length;
                for (i=0;i<len;i++){
                    group_id = userperms.perm_cm.values[i].id;
                    group_name = userperms.perm_cm.values[i].name;
                    //Вставляем токен с value = group_id и текстом = group_name в  токенайз инпут
                    $("#perms_window .assing_perms_input_camp").tokenize().tokenAdd(group_id, group_name);
                }
            }

            //Изменение инпута
            $("#perms_window [name=perm_of]").val(userperms.perm_of["type"]);
            //Триггер для того чтобы выскочил tokenize input
            $("#perms_window [name=perm_of]").trigger("change");

            //Если типа пермишна 2 или 3, то должен быть массив values 
            //Добавляем токены в токенайз инпут из массива values
            if (userperms.perm_of.type==2 || userperms.perm_of.type==3){
                //Количество добавленных групп
                len = userperms.perm_of.values.length;
                for (i=0;i<len;i++){
                    group_id = userperms.perm_of.values[i].id;
                    group_name = userperms.perm_of.values[i].name;
                    $("#perms_window .assing_perms_input_offer").tokenize().tokenAdd(group_id, group_name);
                }
            }

            $("#perms_window [name=perm_lp]").val(userperms.perm_lp["type"]);
            $("#perms_window [name=perm_lp]").trigger("change");

            if (userperms.perm_lp.type==2 || userperms.perm_lp.type==3){
                //Количество добавленных групп
                len = userperms.perm_lp.values.length;
                for (i=0;i<len;i++){
                    group_id = userperms.perm_lp.values[i].id;
                    group_name = userperms.perm_lp.values[i].name;
                    $("#perms_window .assing_perms_input_land").tokenize().tokenAdd(group_id, group_name);
                }
            }

            $("#perms_window [name=perm_ts]").val(userperms.perm_ts["type"]);
            $("#perms_window [name=perm_ts]").trigger("change");

            if (userperms.perm_ts.type==2 || userperms.perm_ts.type==3){
                //Количество добавленных групп
                len = userperms.perm_ts.values.length;
                for (i=0;i<len;i++){
                    group_id = userperms.perm_ts.values[i].id;
                    group_name = userperms.perm_ts.values[i].name;
                    $("#perms_window .assing_perms_input_ts").tokenize().tokenAdd(group_id, group_name);
                }
            }

            $("#perms_window [name=perm_an]").val(userperms.perm_an["type"]);
            $("#perms_window [name=perm_an]").trigger("change");

            if (userperms.perm_an.type==2 || userperms.perm_an.type==3){
                //Количество добавленных групп
                len = userperms.perm_an.values.length;
                for (i=0;i<len;i++){
                    group_id = userperms.perm_an.values[i].id;
                    group_name = userperms.perm_an.values[i].name;
                    $("#perms_window .assing_perms_input_network").tokenize().tokenAdd(group_id, group_name);
                }
            }
        }
        moveWindowPerms();

    }
}

usersPanel = {

    //arg jobj: JQuery object that contain all logic of panel
    jobj : new Object,
    //var for handling state of form 0 - close, 1 - open
    form_state: 0,

    //Показывает, что одно окно уже открывается
    window_opened: false,

    //arg jobj: JQuery object that contain all logic of panel
    //Создается кнопка добавить пользователя
    //На эту кнопку вешается хендлер клика
    init : function(jobj){
        this.jobj = jobj;
        /*jobj.append(this.makeHTMLButtonAddUser());*/
       /* jobj.append(this.makeHTMLButtonEditUser());*/
        this.setButtonsHandlers();
    },

    //Отдает html кнопки
   /* makeHTMLButtonAddUser : function(){
        return "<button class='green-button add_user_button'>Add User</button>";
    },

    makeHTMLButtonEditUser : function(){
        return "<button class='green-button edit_user_button'>Edit User</button>";
    },*/

    editUser: function(id){
        var that = this;
        //Выставляем состояние - окно открыто
        that.form_state = 1;
        
        //Вызываем функцию создания окна редактирования сохраненных perms
        //Отправляем запрос на получение пермишнов для пользователя
        //Вызываемая функция сама находит id выделенного юзера
        //И по success колбеку вызывает создание окна и загрузку пермишшнов в окно из полученного json
        if (!that.window_opened){
            if (id==undefined){
                that.initEditUserWindow(that);
            } else {
                that.initEditUserWindow(that, id);
            }
            that.window_opened = true;
        }
        // не Делаем окно
        //that.makeWindow("edit"); 

    },

    //Добавляет хендлер по клику на кнопку AddUser
    setButtonsHandlers : function (){
        var that = this;

        $(".add_user_button").on("click", function(){
                //Выставляем состояние - окно открыто
                that.form_state = 1;
                
                //Делаем окно
                if (!that.window_opened){
                    that.makeWindow();
                    that.window_opened = true; 
                }               
        });
        $(".edit_user_button").on("click", function(){
                //Выставляем состояние - окно открыто
                that.form_state = 1;
                
                //Вызываем функцию создания окна редактирования сохраненных perms
                //Отправляем запрос на получение пермишнов для пользователя
                //Вызываемая функция сама находит id выделенного юзера
                //И по success колбеку вызывает создание окна и загрузку пермишшнов в окно из полученного json
                if (!that.window_opened){
                    that.initEditUserWindow(that);
                    that.window_opened = true;
                }
                // не Делаем окно
                //that.makeWindow("edit");   
                             
        });
        $(".clone_user_button").on("click", function(){
            that.form_state = 1;
            if (!that.window_opened){
                that.cloneUserWindow(that);
                that.window_opened = true;
            }
        });
         $(".delete_user_button").on("click", function(){
             that.deleteUser(that);
        });
    },

    makeWindow : function(){
        //permsWindow.user_id = -1;
        var html = permsWindow.makeHTMLPermsWindow();
        this.jobj.append(html);
        //Расставляем хендлеры
        this.setInitHandlers();
        $("span.tooltip").qtip({
            show: "click",
            hide: "unfocus",
            style: {
                   classes: "qtip-dark"
               },
           position: {
               my: "left center"
           }
        });
    },

    initEditUserWindow : function(that, id){

        //!!!!!Подгтовка данных для отправки по AJAX

        //Взять строку юзера и получить из нее id
        //В качестве рекоммендации записывать id в аттрибут tr user_id="id"
        //Тогда
        if (id===undefined){
            id  = $(".users_table .tr_active").attr('data-user-id');
        }
        
		//var id = 52;
        $.ajax({
            url : "",
            method: "post",
            data: {"type":"get_user_perms", "ajax":"1", "user_id":id}
        }).success(function(data){
                //Указываем id
                permsWindow.user_id = id;
                that.makeWindow(); 
                permsWindow.loadUserPerms(data);
                
            });
    },

    cloneUserWindow: function(that){

        var id = $(".users_table .tr_active").attr('data-user-id');
        $.ajax({
            url : "",
            method: "post",
            data: {"type":"get_user_perms", "ajax":"1", "user_id":id}
        }).success(function(data){
                that.makeWindow(); 
                permsWindow.loadUserPerms(data, clone=true);
                //Указываем id
                permsWindow.user_id = -1;
            });
    },

    deleteUser: function(){
        var user_tr = $(".users_table .tr_active"),
            userrole = user_tr.find(".role_td").html(),
            username = user_tr.find(".name_camp span").html(),
            id = user_tr.attr("data-user-id");
        if (confirm("Deleting "+ userrole +" " + username + "? Are you sure?")){
            $.ajax({
                url : "",
                method: "post",
                data : {
                    "type"   : "delete_user",
                    "ajax"   : "1",
                    "user_id": id
                }
            }).success(function(data){location.reload();});
        }
    },

    setInitHandlers : function(){
        var that = this;
        permsWindow.setWindowButtonHandlers();
        permsWindow.initWindowHandlers();
    },

    clearForm : function(){

    }
}


//TODO add object ADDUSERFIELD

var globalWindowResizeTimeoutID = 0;

function initUsersPanel(){
    var panel = $(".perms_panel");
    usersPanel.init(panel);
}

function moveWindowPerms(){
    clearTimeout(globalWindowResizeTimeoutID);
    globalWindowResizeTimeoutID = setTimeout(moveWindowPermsAfterTimeOut, 25);
}

function moveWindowPermsAfterTimeOut(){
    var perm_window = $(document.getElementById("perms_window")), jump_size, timeid=0;
    //for (var i=0;i<windows.length;i++){
        //Разворачиваем - берем высоту и снова сворачиваем
        perm_window.find(".win_content").css({"height":"auto", "overflow-y":"auto"});
        jump_size=perm_window.height()+50;
        perm_window.find(".win_content").css({"height":(window.innerHeight-100) , "overflow-y":"scroll"});

        if (perm_window.css("display") == "block"){

            if ((window.innerHeight<jump_size)  ){

                perm_window.css("marginTop","0");

                if (window.innerHeight<=perm_window.height()){
                    perm_window.find(".win_content").css({"height":(window.innerHeight-100) , "overflow-y":"scroll"});
                } else {
                    if (perm_window.find("#perms_window").size()>0){
                            perm_window.find(".win_content").css({"height":"auto", "overflow-y":"auto"});
                    }
                }
            } else {
                perm_window.find(".win_content").css({"height":"auto", "overflow-y":"auto"});
                perm_window.css("marginTop","60");
            }
            if ( (window.innerHeight>jump_size)  ){
                
            }

        }
    //}
    globalWindowResizeTimeoutID = 0;
}

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

//Инициация скрипта панели
$(document).ready(function(){
	
    openCustomDate();

    initUsersPanel();

    //Настройки корреляции 
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

    $("#custom_date_pol1").on("click",function () {
        $("#refresh-btn").removeClass("blue-button").addClass("green-button");
        $("#refresh-btn").html("&nbsp;&nbsp;<img src=\'templates/standart/images/w-ok.png\' class=\'icon\' style=\'position: relative; top: 1px;\'>Apply&nbsp;&nbsp;")
    });
    $("#custom_date_pol2").on("click",function () {
        $("#refresh-btn").removeClass("blue-button").addClass("green-button");
        $("#refresh-btn").html("&nbsp;&nbsp;<img src=\'templates/standart/images/w-ok.png\' class=\'icon\' style=\'position: relative; top: 1px;\'>Apply&nbsp;&nbsp;")
    });
    
    var date_obj = $("#date_filter [value="+<?php echo $arr_tpl['date']; ?>+"]");
    enter_date_statistics(date_obj);

    $(".filter_block").on("change","select",function () {
        if($("#date_filter").val()=="10" || $("#date_filter").val()=="12"){
            openCustomDate();
        }else{
            $("#refresh-btn").removeClass("green-button").addClass("blue-button");
            $("#refresh-btn").html("<img src=\'templates/standart/images/w-refresh.png\' class=\'icon\'>Refresh");
            //$(".filter_block [type=\'submit\']").click();
            $("#act-form").submit();
        }
    });
});

$(window).resize(function(){
    moveWindowPerms();
    header_correlation();
});




function submitForm(){
    var err = 0;
    if ($("[name=date]").val()=="10" || $("[name=date]").val()=="12"){
        date_s = $("#act-form [name=date_s]").val().split("|");
        date_e = $("#act-form [name=date_e]").val().split("|");
        if (date_s.length>1){
            if ( new Date(date_s[0] + " " +date_s[1]) > new Date(date_e[0] + " " +date_e[1]) ){
                err += 1;
                alert("Incorrect date/time!");
            } else {
                $("#act-form").submit();
            }
        } else {
            if (new Date(date_s[0]) > new Date(date_e[0])){
                err += 1;
                alert("Incorrect date!");
            } else {
                $("#act-form").submit();
            }

        }
    }
    if (err==0){
        $("#act-form").submit();
    }
}

function openCustomDate(){
    if($("#date_filter").val()=="12"){
        $("#custom_date_pol1").datetimepicker({format:"Y-m-d", timepicker: false});
        $("#custom_date_pol2").datetimepicker({format:"Y-m-d", timepicker: false});
        if($("#custom_date_pol1").val()=="all" || $("#custom_date_pol2").val()=="all" || $("#custom_date_pol2").val()=="" || $("#custom_date_pol1").val()==""){
            $("#custom_date_pol1").val("<?php echo date('Y-m-d'); ?>");
            $("#custom_date_pol2").val("<?php echo date('Y-m-d'); ?>");
        }
        $("#refresh-btn").removeClass("blue-button").addClass("green-button");
        $("#refresh-btn").html("&nbsp;&nbsp;<img src=\'templates/standart/images/w-ok.png\' class=\'icon\' style=\'position: relative; top: 1px;\'>Apply&nbsp;&nbsp;");
    }
}