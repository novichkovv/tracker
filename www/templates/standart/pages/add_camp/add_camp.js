/*GLOBAL*/
window.lp_protect_landing =  $("#add_lp [name=lp_protect]").val();

/**
* String "#Choose offer#" in offer.detail.name is reserved name. 
* Users cannot use this string for offer's name;
*/
function getKeyCode(e){
    return (e.keyCode ? e.keyCode : e.which);
}
Array.prototype.findObjectByProp = function(prop, val) {
    var result = new Array();

    for (var i=0;i<this.length;i++){
        if (typeof this[i] == "object" && this[i][prop]==val){
            result.push(this[i]);
        }
    }

    if (result.length==1){
        return result[0];
    } else if (result.length>0) {
        return result;
    } else {
        return false;
    }
}

function makeEmptyPath(paths){
    var number;
    if (typeof paths == "undefined"){
        number = 1;
    } else {
        number = paths.length + 1;
    }
    return {
        "name":"Path " + number, 
        "status":1,
        "split" :100,
        "landings": [],
        "offers" : []
        };
}

function makeEmptyRule(rules){

    var number;
    if (typeof rules == "undefined"){
        number = 1;
    } else {
        number = rules.length + 1;
    }

    return {
            "name":"Rule "+number,  
            "status":1,
            "criteria" : [],
            "paths":new Array(makeEmptyPath()),
            "number" : number
        };
}

var time=new Date();

var jobj_block = $(".camp_edit_right");
var json_routing = $(".json_routing_keeper").text(),
jobj_block = $(".camp_edit_right");

$(".json_routing_keeper").remove();
var ROUTING;

if (typeof json_routing == "undefined" || json_routing == "") {
    ROUTING = {"paths" : [makeEmptyPath()], "rules":[]}
} else {
    ROUTING = JSON.parse(json_routing);    
}

var routingTemplater = (function (){
    this.ROUTING = ROUTING;
    return {
        /* exportFull: function(){
            var i=0,
                export_obj = {};
            export_obj.paths = new Array();
            for (i=0;i<ROUTING.paths[0];i++){
                export_obj.paths.push(cloneObject(ROUTING.paths));
                delete export_obj.paths[i].id;
            }
            return JSON.stringify(export_obj);
        }, */
        /*importFull: function(json_routing){
            var object_to_insert = JSON.parse(json_string);
            console.log(object_to_insert);
        }*/
        exportRules: function(json){
            if (typeof json == "undefined"){
                json = false;
            }

            var i=0, 
                j=0, 
                k=0,
                export_obj = {};
            export_obj.rules = new Array();
            // Clearing export object
            for (i=0;i<ROUTING.rules.length;i++){
                export_obj.rules.push(cloneObject(ROUTING.rules[i]));
                delete export_obj.rules[i].id;
                delete export_obj.rules[i].camp_id;
                delete export_obj.rules[i].minimized;
                for (j=0;j<export_obj.rules[i].criteria.length;j++){
                    delete export_obj.rules[i].criteria[j].id;
                }
                for (j=0;j<export_obj.rules[i].paths.length;j++){
                    delete export_obj.rules[i].paths[j].id;
                    delete export_obj.rules[i].paths[j].camp_id;
                    delete export_obj.rules[i].paths[j].camp_id;
                    delete export_obj.rules[i].paths[j].minimized;
                    for (k=0;k<export_obj.rules[i].paths[j].landings.length;k++){
                        delete export_obj.rules[i].paths[j].landings[k].id;
                        delete export_obj.rules[i].paths[j].landings[k].path_id;
                    }
                    for (k=0;k<export_obj.rules[i].paths[j].offers.length;k++){
                        delete export_obj.rules[i].paths[j].offers[k].path_id;
                        delete export_obj.rules[i].paths[j].offers[k].id;
                    }
                }
            }
            if (json){
                return JSON.stringify(export_obj);
            } else {
                return export_obj;
            }
        },
        // TODO получится хреново, наверное
        importRules: function(import_data){
            if (typeof import_data == "string"){
                rules = JSON.parse(import_data)["rules"];
            } else if (typeof import_data== "object") {
                rules = import_data["rules"];
            }
            ROUTING.rules.splice(0, ROUTING.rules.length);
            for (var i=0;i<rules.length;i++){
                ROUTING.rules.push(rules[i]);
            }
        },
        saveRulesToStorage: function(){
            var rules = this.exportRules(true);
            localStorage.setItem('rules_import', rules);
        },
        importRulesFromStorage: function(){
            var import_data = localStorage.getItem('rules_import');
            this.importRules(import_data);
            //localStorage.removeItem("rules_import");
        },
        clearStorage: function(){
            localStorage.removeItem("rules_import");
            $(".paste_rules_templates").css({"display" : "none"});
            $(".clear_rules_templates").css({"display" : "none"});
        },
        
    }
})(ROUTING);

Array.prototype.remove = function(value) {
    var idx = this.indexOf(value);
    if (idx != -1) {
        //var arr = this.splice(idx, 1);
        this.splice(idx,1);
        // Второй параметр - число элементов, которые необходимо удалить
    }
    return false;
}

// TODO add this to components
$("body").on("click", "._list-collapser", function(){
    var child_block = $(this).parent().next(),
        collapser_button = $(this).find("._collapser-button");

});

var getToggleId = function(){
        var number=0; 
        return function(){return "tgl-id-"+ (++number);} 
}();

function getCampaignData(){
    var campaign_data = {
        id : $("[name=camp_id]").val(),
        name : $("[name=camp_name]").val(),
        domain : $("[name=domain]").val(),
        group_id : $("[name=camp_group]").val(),
        // For creating new camp_group
        group_name : $("#new_group_name_camp").val(),
        
        sources_id : $("[name=camp_traffic_sources]").val(),
        cpc : $("[name=camp_cpc]").val(),
        auto_cpc : $("[name=auto_cpc]").is(':checked'),
        is_cpm : $("[name=is_cpm]").val(),
        // detected_type 3 - all
        //               2 - without ISP/GEO
        //               1 Without Device/OS/Browser
        //               0 - Nothing
        detected_type: $("[name=detected_type]").val(),

        postback_url : $("[name=camp_s2spostback]").val(),
        postback_using : $("[name=s2spostback_using]").is(":checked"),
        // Meta refersh
        red_type : $("[name=blocking]").val(),   
        smart_rotation : $("[name=smart_rotation_type]").val(),
          /*AntiSpy*/
        losses :         $("[name=camp_trafficloss]").val(),
        
        land_tokens :    $("[name=land_tokens]").val(),
        camp_tokens :    $("[name=camp_tokens]").val(),
        var_1: $("#antispy_input").val(),
        var_2: $("[name=antispy_using]").is(":checked"),
        note: $("#camp_note").val()
    }
    return campaign_data;
}

function validateCampaignSettings(camp_data){
    $(".error_field_border").removeClass("error_field_border");
    // Need name
    if (!camp_data.name){
        makeBadAlertModal("OK", "Enter name, please!").show();
        $("#name_input").addClass("error_field_border");
        return false;
    }
    // Need traffic source
    if (!camp_data.sources_id){
        makeBadAlertModal("OK", "Choose or create traffic source, please!").show();
        $("#trafficsource_input").addClass("error_field_border");
        return false;
    }
    // Need cpc or checked auto cpc
    if (!camp_data.cpc){
        if (!camp_data.auto_cpc){
            makeBadAlertModal("OK", "Please enter cpc").show();
            $("#cpc_input").addClass("error_field_border");
            return false;
        }
    }

    return true;
}

/**
* @param block   {object}  path or rule object from ROUTING
* @param message {message} message for alerting
*/
function makeRoutingAlert(block, message){
    makeBadAlertModal("OK", message).show();
}

// Добавить 
function validateRoutingPath(path, index, rule_name){
    var additional_info = "";

    if (typeof rule_name !== "undefined"){
        additional_info = "Rule #" + rule_name;
    } else if (typeof rule_name !== "undefined" && rule_name.trim()===""){
        additional_info = "Rule Unnamed";
    }

    if (path.landings.length==0){
        makeRoutingAlert(path , "Please, add landings or Direct landing to " + additional_info + " path #" + path.name);
        return false;
    }

    if (path.offers.length==0){
        makeRoutingAlert(path , "Please, add offers to " + additional_info + " path #" + path.name);
        return false;
    }

    var active_landings = 0;
    for (var i=0; i<path.landings.length; i++){
        if (path.landings[i].status!=0){
            active_landings++;
        }
    }

    var active_offers = 0;
    for (var i=0; i<path.offers.length; i++){
        if (path.offers[i].detail.name=="#Choose Offer#"){
            makeRoutingAlert(path , "Please, choose offer in " + additional_info + " path #" + path.name);
            return false;
        }
        if (path.offers[i].type==4 && path.offers[i].detail.name==""){
            makeRoutingAlert(path , "Please, enter URL of Direct-offer in " + additional_info + " path #" + path.name);
            return false;
        }
        if (path.offers[i].status!=0){
            active_offers++;
        }
    }

   if (active_landings==0){
        makeRoutingAlert(path , "Please, add or unpause any landing " + additional_info + " path #" + path.name);
        return false;
    }

    if (active_offers==0){
        makeRoutingAlert(path , "Please, add or unpause any offer " + additional_info + " path #" + path.name);
        return false;
    }

    // Check name
    if (!path.name || path.name.trim()==""){
        makeRoutingAlert(path , "Please, enter name in " + additional_info + " path " + (index+1) );
        return false;
    }
    return true;
}

function validateRoutingRule(rule, index){

    // Check name
    if (!rule.name || rule.name.trim()==""){
        makeRoutingAlert(rule , "Please, enter name for rule " + (index+1));
        return false;
    }

    if (rule.criteria.length==0){
        makeRoutingAlert(rule , "Please, add criteria to rule #" + rule.name);
        return false;
    }
    var valid_rule_paths = false,
        paused_paths = 0;
    for (var i=0; i<rule.paths.length;i++){
        valid_rule_paths = validateRoutingPath(rule.paths[i], i, rule.name);
        if (!valid_rule_paths){
            return false;
        }
        if (rule.paths[i].status==0){
            paused_paths += 1;
        }
    }
    if (paused_paths==rule.paths.length && rule.status!=0){
        makeRoutingAlert(rule , "Please, add active path to rule #" + rule.name);
        return false;
    }
    

    return true;
}

function validateCampaignRouting(routing){
    
    if (routing.paths.length==0){
        makeBadAlertModal('OK', "You have no path. Please, add it.").show();
        return;
    }

    var count_of_paths = routing.paths.length,
        count_of_paused_paths=0;

    for (var i=0;i<count_of_paths;i++){
        if (routing.paths[i].status==0){
            count_of_paused_paths++;
        }
    }

    if (count_of_paths == count_of_paused_paths){
        makeBadAlertModal('OK', "You have no active path. Please, add it or run one of these that exist.").show();
        return;
    }

    var valid_paths=false, 
        valid_rules=false;

    // Check Paths
    for (var i=0; i<routing.paths.length;i++){
        valid_paths = validateRoutingPath(routing.paths[i], i);

        if (!valid_paths){
            return false;
        }
    }
    

    // Check Rules
    for (i=0; i<routing.rules.length; i++){
        valid_rules = validateRoutingRule(routing.rules[i], i);

        if (!valid_rules){
            return false;
        }

    }

    return true;

}

function validateCampaign(data){
    var valid_settings=false,
        valid_rules= false;

    valid_settings = validateCampaignSettings(data.campaign);
    
    if (!valid_settings){
        return false;
    }

    valid_routing = validateCampaignRouting(data.routing);

    if (!valid_routing){
        return false;
    }

    return true;
}



// TODO добавить анимацию загрузки

function saveCampaign(save_close){
    if (!save_close){
        save_close = false;
    }

    var campaign_data = getCampaignData();

    var data = {
        "campaign"   : campaign_data,
        "routing"    : ROUTING,
        "save_close" : save_close
    };

    var camp_valid = validateCampaign(data);

    if (!camp_valid){
        return;
    } 

    data = JSON.stringify(data); 

    // Clear unbeforeunload handler
    window.onbeforeunload = function (){};

    var form = $("<form class='temp-routing-form' style='display:none' action='?page=save_camp' method='post'></form>").append( $("<input name='campaign_data' type='hidden'>").val(data) );
    if (save_close){
        form.append("<input type='hidden' name='save_close' value=1>");
        form.append("<input type='hidden' name='save_close_ref' value=" + window.document.referrer + ">");
    }

    $(".temp-routing-form").remove();
    $("body").append(form);
    $(".temp-routing-form").submit();

}

$(document).ready(function(){

    $(".camp_edit_left, .camp_edit_right").css("display", "block");
    $(".camp_edit_loading").css("display", "none");

    $(".main_save_button_add_camp").on("click", function(){
        if (!$(this).hasClass("button_inactive")){
            saveCampaign();
        }
    });

    $(".main_save_close_button_add_camp").on("click", function(){
        if (!$(this).hasClass("button_inactive")){
            saveCampaign(true);
            /* window.location = "?page=campaigns"; */
        }
    });

    if (!FlashDetect.installed){
        try {
            new Clipboard('#copy_btn');
            new Clipboard('#copy_btn_pixel');
            $("#copy_btn").replaceWith($("<a href='javascript:' id='copy_btn' class='button' style='float:right;' data-clipboard-target='#url_input' >Copy</a>"));
            $("#copy_btn_pixel").replaceWith($("<a href='javascript:' id='copy_btn_pixel' class='button' style='float:right;' data-clipboard-target='#lp_pixel_input' >Copy</a>"));
            
        } catch (e){
            $("#url_input").css({'width':'100%'});
            $("#lp_pixel_input").css({'width':'100%'});
        }

    } else {
        addZclip("#copy_btn", "#url_input");
    }

    $(document).on("keydown",  function (e){
                var e = e || event;
                if ((getKeyCode(e)==27 || getKeyCode(e)==13) && $(".routing-system input:focus").length>0){
                    $(".routing-system input:focus").trigger("blur");
                }
                
            });

}); 

// TODO auto payout для офферов

/*
####################
     COMPONENTS
####################
*/
    // Main component
    rivets.components['routing-app'] = {
        template: function(){
            return '<paths-block paths="routing.paths"></paths-block>\
                    <paths-buttons paths="routing.paths"></paths-buttons>\
                    <rules-block rules="routing.rules"></rules-block>\
                    <rules-buttons rules="routing.rules"></rules-buttons>'
        },
        initialize: function(el, data){return data;}
    }

    // Rules components
    rivets.components['rules-block'] = {
        template: function(){
            return '<h2 class="camp_edit_caption rules_header_block">RULES \
                    <div class="template_rules_button_wrapper">\
                        <span class="copy_rules_templates blue-button">Copy</span>\
                        <span class="paste_rules_templates green-button" style="display:none;">Paste</span>\
                        <span class="clear_rules_templates gray-button" style="display:none;">Clear</span>\
                    </div>\
                    </h2>\
                    <div class="_paths _rules">\
                        <div class="_paths_header" rv-class-empty-routing-block-header="isEmpty | call rules">\
                            <div class="_list-collapser"  rv-on-click="minimizeAction" rv-class-_closed-collapser="state.minimized"><div class="_collapser-button"></div></div>\
                            <div class="_caption-block _caption"><span style="color:#E53935;">RULES</span></div>\
                            <div class="_path-weight" ><span>Weight</span></div>\
                            <div class="_path-actions"><span>Actions</span></div>\
                        </div>\
                        <div class="rules_wrapper">\
                            <div><rule-block class="_rule_block" rv-each-rule="rules" rule="rule" rules="rules"></rule-block><div>\
                        </div>\
                    </div>\
                    ';
        },
        initialize: function(el, data){
            return new rulesBlockController(data);
        }
    };
    function rulesBlockController(data){
        this.rules = data.rules;
        this.isEmpty = function(rules){
            if (rules.length==0){
                return true;
            } else {
                return false;
            }
        }
        this.rules.deleteRule = function(rule){
            somethingWasChanged();
            rule.paths = new Array();
            var idx = this.indexOf(rule);
            this.splice(idx, 1);
            
        }
        this.state = {};
        this.state.minimized = false;
        this.minimizeAction = function(event, scope){
            scope.state.minimized = !scope.state.minimized;
            if (scope.state.minimized==true){
                for (var i=0;i<scope.rules.length;i++){
                    scope.rules[i].minimized = true;
                }
            } else {
                for (var i=0;i<scope.rules.length;i++){
                    if (scope.rules[i].status!=0){
                        scope.rules[i].minimized = false;
                    }
                }
            }
            
        };
    };

    rivets.components['rule-block'] = {
        template: function(){
            var tgl_id = getToggleId();
            return '<div class="_rule-entry" rv-class-_minimized="rule.minimized" rv-class-_last-path="isLast | call rule rules" >\
                        <div class="_path _active path-header-block" rv-class-_paused="isPaused | call rule.status">\
                            <div class="_div-color"></div>\
                            <div class="_list-collapser" rv-on-click="minimizeAction" rv-class-_closed-collapser="rule.minimized"><div class="_collapser-button"></div></div>\
                            <div class="_caption-block _caption _renamed_caption" rv-on-click="state.changeEditable">\
                                <span rv-text="rule.name" rv-class-hidden="state.hideSpanState | call state.editable" ></span>\
                                <input class="rule_caption_input" rv-value="rule.name" rv-class-hidden="state.hideInputState | call state.editable" rv-on-blur="state.changeEditable"></input>\
                                </div>\
                            <div class="_weight-wrapper _rule_weight">\
                                <span class="_get_rule_up" rv-on-click="getUp"><img src="templates/standart/images/up_3.png" ></span>\
                                <span class="_get_rule_down" rv-on-click="getDown"><img src="templates/standart/images/down_3.png" ></span>\
                            </div>\
                            <div class="_of-actions" data-object-type="offer">\
                                <input rv-on-click="changeStatus" id="'+tgl_id+'" type="checkbox" rv-checked="rule.active" class="tgl tgl-light">\
                                <label for="'+tgl_id+'" class="tgl-btn"></label>\
                                <edit-action-button obj="rule" state="state"></edit-action-button>\
                                <div rv-on-click="delete" " class="delete_btn"></div>\
                            </div>\
                        </div>\
                        <div class="_block_in_rule-entry" rv-class-_hidden-block="rule.minimized">\
                            <criteria-block criteria="rule.criteria"></criteria-block>\
                            <rule-paths-block paths="rule.paths"></rule-paths-block>\
                            <paths-buttons paths="rule.paths"></paths-buttons>\
                        </div>\
                    </div>';
        },

        initialize: function(el, data){
            return new ruleController(data);
        }
    };
    function ruleController(data){
        this.rule = data.rule;
        this.rules = data.rules;

        this.isLast = function(rule, rules){
            if (rules.indexOf(rule) == (rules.length-1) ){
                return true;
            } else {
                return false;
            }
        };

        this.delete = function(event, scope){
            scope.rules.deleteRule(scope.rule);
        };

        this.rule.number = (data.rules.indexOf(data.rule)+1);

        this.rule.paused = (data.rule.status==0?true:false);
        // 
        this.rule.active = (data.rule.status==0?false:true);

        this.isPaused = function(status){
            return (status==0?true:false);
        };

        this.getUp = function(event, scope){
            somethingWasChanged();
            if (scope.rules.length==1){return;}

            if (scope.rules.indexOf(scope.rule)>0){

                var rule_index = scope.rules.indexOf(scope.rule);
                if (rule_index == 0 || rule_index==-1){
                    return false;
                }
                scope.rule.number = parseInt(scope.rule.number) - 1;
                scope.rules[rule_index-1].number = parseInt(scope.rules[rule_index-1].number) + 1;

                scope.rules.sort(function(x,y){
                    if (x.number > y.number){
                        return 1;
                    } 
                    if ( x.number < y.number){
                        return -1;
                    }
                    return 0;
                });


            } else {
                return;
            }

            for (var j=0, jl=scope.rules.length;j<jl;j++){
                // simulate change object for path.isLast recounting
                for (var i=0, l=scope.rules[j].paths.length;i<l;i++){
                    
                    scope.rules[j].paths[i].minimized = !!scope.rules[j].paths[i].minimized;

                }
            }
            
        };
        this.getDown = function(event, scope){
            somethingWasChanged();
            //if (scope.rules.length==1){return;}

            var rule_index = scope.rules.indexOf(scope.rule);
            if (rule_index == scope.rules.length-1 || rule_index==-1){
                return false;
            }
            scope.rule.number = parseInt(scope.rule.number) + 1;
            scope.rules[rule_index+1].number = parseInt(scope.rules[rule_index+1].number) - 1;

            scope.rules.sort(function(x,y){
                if (x.number > y.number){
                    return 1;
                } 
                if ( x.number< y.number){
                    return -1;
                }
                return 0;
            });

            // simulate change object for path.isLast recounting
            for (var j=0, jl=scope.rules.length;j<jl;j++){
                // simulate change object for path.isLast recounting
                for (var i=0, l=scope.rules[j].paths.length;i<l;i++){
                    scope.rules[j].paths[i].minimized = !!scope.rules[j].paths[i].minimized;
                }
            }

        }

        this.changeStatus = function(event, scope){
           var status;
           if ($(event.target).prop("checked")==true){
               status = 1;
                var collapser = $(event.target).parent().parent().find("._list-collapser");
                if (collapser.hasClass("_closed-collapser")){
                    collapser.trigger("click");
                } 
           } else {
               status = 0;
               var collapser = $(event.target).parent().parent().find("._list-collapser");
                if (!collapser.hasClass("_closed-collapser")){
                    collapser.trigger("click");
                }
               
           }
           scope.rule.status = status;
           scope.rule.paused = (status==0?true:false);
           scope.rule.active = (status==0?false:true);
        }
    
        this.rule.button_state = {};
        this.rule.button_state.not_paused = (function(rule){
            if (rule.status==0){
                return false;
            } else {
                return true;
            }

        })(this.rule);

        this.state = {};
        this.rule.minimized = (this.rule.status==0?true:false);
        this.state.editable == false;
        this.state.hideInputState = function(editable){
            return !editable;
        }
        this.state.hideSpanState = function(editable){
            return editable;
        }
        this.state.inputBlur = function(event, scope){
            if (scope.state.editable==true){
                scope.state.editable = false;
            }
        }
        this.minimizeAction = function(event, scope){
            scope.rule.minimized = !scope.rule.minimized;
        }
        this.rule.edit = function(obj, state){
            state.editable = true;
            $(".rule_caption_input:not(.hidden)")[0].focus();
        }

        this.state.changeEditable = function(event, scope){

            if (event.type=="click" && event.target.tagName.toLowerCase()=="input" && scope.state.editable==true){
                return;
            }

            if (event.type=='blur') {
                scope.state.editable = false;
                return;
            }

            scope.state.editable = !scope.state.editable;
           
            if ( scope.state.editable ){
                if ($(event.target).find("input").length>0){
                    $(event.target).find("input")[0].focus();
                } else if (event.target.tagName.toLowerCase() == "span") {
                    $(event.target).next()[0].focus();
                    event.target.focus();
                }
            }            
            
        }
    };

    rivets.components['rules-buttons'] = {
        template: function(){
            return '<div class="_rule_buttons_wrapper"><a rv-on-click="addRule" class="green-button" id="add-rule-btn"><img src="templates/standart/images/w-add.png" class="icon add_icon">Rule</a></div>';
        },
        initialize: function(el, data){
            return new rulesButtonsController(data);
        }
    };
    function rulesButtonsController(data) {
        this.rules = data.rules;
        this.addRule = function(event, scope){
            // TODO добавить доп коллбек на сохранение
            addCriterion("new_rule", data.rules);
        }
    };

    rivets.components['criteria-block'] = {
        template: function(){
            return '<div class="_criteria _inner-block">\
                        <div class="_criteria_header">\
                            <div class="_criteria_header_caption _caption-block _caption"><span style="color:#11AA22;">CRITERIA</span></div>\
                        </div>\
                        <div class="_criteria_blocks_wrapper">\
                            <div rv-each-criterion="criteria"><criterion-block criterion="criterion" criteria="criteria"></criterion-block></div>\
                            <criteria-buttons  criteria="criteria"><criteria-buttons>\
                        </div>\
                    </div>';
        },
        initialize: function(el, data){return data;}
    };


    rivets.components['criterion-block'] = {
        template: function(){
            return '<div class="_row _active _criterion" rv-class-_paused="criterion.paused" >\
                        <div class="_div-color"></div>\
                        <div class="_criterion_caption _lp-caption _caption" rv-on-click="criterion.rowEdit">\
                            <span>{getCriterionName | call criterion.type criterion.type2}</span>\
                            <span rv-html="getValueString | call criterion.type criterion.type2 criterion.values"></span>\
                        </div>\
                        <actions-block obj="criterion" array_holder="criteria"></actions-block>\
                    </div>';
        },
        initialize: function(el, data){return new criterionController(data);},
    };

    function criterionController(data){
        this.criterion = data.criterion;
        this.criteria = data.criteria;
        this.criterion.paused = (this.criterion.status==0?true:false);

        this.getCriterionName = function(cri_type, cri_type_2){

            var criterion_map = {
                "1":"Brand and Model",
                "2":"Browser and version",
                "3":"Operating system and version",
                "14":"Language",
                "17":"Device type",
                "16":"Device resolution",
                "4":"Country",
                "20":"City",
                "5":"ISP",
                "13":"Connection type",
                "6":"IP",
                "7":"User agent",
                "12":"Day of week",
                "18":"Part of day",
                "11":"Referer",
                "8":"Unique/Non-unique",
                "9":"Proxy-traffic"
            }

            
            if (typeof criterion_map[cri_type] == "undefined" && cri_type!=0){
                if (ROUTING.tokens){
                    var token = ROUTING.tokens.findObjectByProp("id",cri_type-90);
                    if (!token.type && !token.name){
                        return "#Undefined Token#";
                    } else {
                        return "Token " + (token.type) + ": "+ token.name;  
                    }
                } else {
                    return "#Undefined Token#: ";
                }
            } else if (cri_type==8) {
                if (cri_type_2==0){
                    return "Unique";
                } else {
                    return "Not Unique";
                }
            } else {
                return criterion_map[cri_type];
            }
            

        }

        this.getValueString = function(type, type2, values){

            var operator_string = "", values_string = "";
            if (type2 == 1){
                operator_string += " <span class='red_text'>IS NOT</span> ";
            } else {
                operator_string += " <span class='green_text'>IS</span> ";
            }
            if ( (type==11 || type>90 || type==14) && values.length==1 && values[0].toLowerCase()=="unknown"){
                values_string = "Empty/Unknown";
            } else {

                // Splice causes an error Maximum call stack size 
                var temp_values = new Array();
                for (var i=0;i<10;i++){
                    if (typeof values[i] != "undefined"){
                        temp_values[i] = values[i];
                    }
                }

                if (type==8){
                    if (values[0]==1){
                        operator_string =" in ";
                        values_string=" all traffic"
                    } else {
                        operator_string = " in ";
                        values_string = " this campaign";
                    }
                
                }else {
                    //var temp_values = new Array();
                    
                    // make unknown value italic
                    if (type==11 || type>90 || type==14) {
                        var unknown_index = temp_values.indexOf("unknown");
                        if (unknown_index!=-1){ 
                            temp_values[unknown_index] = "<i>unknown</i>";
                        }
                    } 

                    if (type==12) {
                        var days_map = {
                            "1":"Monday",
                            "2":"Tuesday",
                            "3":"Wednesday",
                            "4":"Thursday",
                            "5":"Friday",
                            "6":"Saturday",
                            "7":"Sunday"
                        }
                        for (var i=0; i<temp_values.length;i++){
                            temp_values[i] = days_map[temp_values[i]];
                        }
                    }

                    values_string = temp_values.join(", ")
                    /*if (values.length>5){
                        values_string += "...";
                    }*/
                }

            }
            end_string=operator_string+values_string;
            return end_string;
        };

        this.criterion.rowEdit = function(event, scope){
            editCriterion(scope.criterion);
        },

        this.criterion.edit = function(obj){
            editCriterion(obj);
        };

    };

    rivets.components['criteria-buttons'] = {
        template: function(){
            return '<div class="_criteria_buttons_wrapper"><a rv-on-click="addCriterion" class="green-button" id="add-cri-btn"><img src="templates/standart/images/w-add.png" class="icon add_icon">Criteria</a></div>';
        },
        initialize: function(el, data){
            return new criterionButtonController(data);
        }
    };
    function criterionButtonController(data){
        this.criteria = data.criteria;

        this.addCriterion = function(event,scope){ 
            addCriterion(scope.criteria);
        };
    }

    // Убрать Weight Actions отсюда
    // Path components
    rivets.components['paths-block'] = {
        // Return the template for the component.
        template: function() {
          return '<h2 class="camp_edit_caption">DEFAULT<span class="tooltip" data-hasqtip="143" oldtitle="All visitors will go to these paths unless a visitor matches up with any defined rules." title=""></span></h2>\
          <div class="_paths">\
                      <div class="_paths_header" rv-class-empty-routing-block-header="isEmpty | call paths" >\
                          <div class="_list-collapser" rv-on-click="minimizeAction" rv-class-_closed-collapser="state.minimized"><div class="_collapser-button"></div></div>\
                          <div class="_caption-block"><span>PATHS</span></div>\
                          <div class="_path-weight"><span>Weight</span></div>\
                          <div class="_path-actions"><span>Actions</span></div>\
                      </div>\
                      <div ><path-block class="_path_block" rv-each-path="paths"  path="path" paths="paths"></path-block></div>\
                  <div>';
        },

      initialize: function(el, data) {
        return new pathsBlockContainer(data);
      }
    };
    function pathsBlockContainer(data) {
        this.paths = data.paths;
        this.state = {};
        this.state.minimized = false;

        this.isEmpty = function(paths){
            if (paths.length==0){ return true }
            else {return false;}
        };

        this.minimizeAction = function(event, scope){
            scope.state.minimized = !scope.state.minimized;
            if (scope.state.minimized==true){
                for (var i=0;i<scope.paths.length;i++){
                    scope.paths[i].minimized = true;
                }
            } else {
                for (var i=0;i<scope.paths.length;i++){
                    if (scope.paths[i].status!=0){
                        scope.paths[i].minimized = false;
                    }
                }
            }
            
        };

        this.paths.deletePath = function(path){
            somethingWasChanged();
            path.offers = new Array();
            path.landings = new Array();
            var idx = this.indexOf(path);
            this.splice(idx, 1);
        }
    };

    rivets.components['rule-paths-block'] = {
        // Return the template for the component.
        template: function() {
          //return "<path-block rv-each-path='ROUTING.paths' style='border: 1px solid blue;'> <h3>{path.name}</h3> </path-block>";
          return '<div class="_paths">\
                      <div class="_paths_header" rv-class-empty-routing-block-header="isEmpty | call paths">\
                          <div class="_list-collapser" rv-on-click="minimizeAction" rv-class-_closed-collapser="state.minimized"><div class="_collapser-button"></div></div>\
                          <div class="_caption-block"><span>PATHS</span></div>\
                      </div>\
                      <div ><path-block rv-each-path="paths" class="_path-block" path="path" paths="paths"></path-block><div>\
                  </div>';
        },

      initialize: function(el, data) {
        return new rulePathsController(data);
      }
    };
    function rulePathsController(data){
        this.paths = data.paths;
        this.paths.deletePath = function(path){
            somethingWasChanged();
            path.landings = new Array();
            path.offers = new Array();
            var idx = this.indexOf(path);
            this.splice(idx, 1);
        }
        this.isEmpty = function(paths){
            if (paths.length==0){ return true }
            else {return false;}
        };
        this.state = {};
        this.state.minimized = false;
        this.minimizeAction = function(event, scope){
            scope.state.minimized = !scope.state.minimized;

            if (scope.state.minimized==true){
                for (var i=0;i<scope.paths.length;i++){
                    scope.paths[i].minimized = true;
                }
            } else {
                for (var i=0;i<scope.paths.length;i++){
                    if (scope.paths[i].status!=0){
                        scope.paths[i].minimized = false;
                    }
                }
            }
            
        };
    }

    rivets.components['path-block'] = {
      
      template: function() {
        var tgl_id = getToggleId();
        return '<div class="_path-entry path-block"  rv-class-_minimized="path.minimized" rv-class-_last-path="isLast | call path paths" rv-class-_paused="isPaused | call path.status">\
                    <div class="_path _active path-header-block">\
                        <div class="_div-color"></div>\
                        <div class="_list-collapser" rv-on-dblclick="cancelSelect" rv-on-click="minimizeAction" rv-class-_closed-collapser="path.minimized"><div class="_collapser-button"></div></div>\
                        <div class="_caption-block _path_caption _caption _renamed_caption" rv-on-click="state.changeEditable">\
                            <span rv-class-hidden="state.hideSpanState | call state.editable" rv-text="path.name"></span>\
                            <input class="path_caption_input" rv-value="path.name" rv-on-blur="state.changeEditable" rv-class-hidden="state.hideInputState | call state.editable">\
                        </div>\
                        <weight-block object="path"></weight-block>\
                        <div class="_of-actions" data-object-type="offer">\
                            <input rv-on-click="changeStatus" id="'+tgl_id+'" type="checkbox" rv-checked="path.button_state.not_paused" class="tgl tgl-light">\
                            <label for="'+tgl_id+'" class="tgl-btn"></label>\
                            <edit-action-button obj="path" state="state"></edit-action-button>\
                            <div rv-on-click="delete" " class="delete_btn"></div>\
                        </div>\
                    </div>\
                    <div rv-class-_hidden-block="path.minimized">\
                        <landings-block landings="path.landings" offers="path.offers"></landings-block>\
                        <offers-block offers="path.offers"></offers-block>\
                    </div>\
                </div>';
      },

      initialize: function(el, data) {
        return new pathController(data);
      }
    };
    function pathController(data){
        this.path  = data.path;
        this.paths = data.paths;
        this.path.paused = (data.path.status==0?true:false);
        
        this.isLast = function(path, paths){

            if ( paths.indexOf(path) == (paths.length-1) ){
                return true;
            } else {
                return false;
            }
            
        }

        this.state = {};
        this.path.minimized = (function(){
            if (data.path.minimized){
                return data.path.minimized;
            } else {
                return (data.path.status==0?true:false);
            }
        }());

        this.state.editable == false;

        this.isPaused = function(status){ return (status==0?true:false); }

        this.delete = function(event, scope){
            scope.paths.deletePath(scope.path);
        }

        this.minimizeAction = function(event, scope){
            scope.path.minimized = !scope.path.minimized;
        }

        this.changeStatus = function(event, scope){
           var status;
           if ($(event.target).prop("checked")==true){
               status = 1;
                var collapser = $(event.target).parent().parent().find("._list-collapser");
                if (collapser.hasClass("_closed-collapser")){
                    collapser.trigger("click");
                } 
           } else {
               status = 0;
               var collapser = $(event.target).parent().parent().find("._list-collapser");
                if (!collapser.hasClass("_closed-collapser")){
                    collapser.trigger("click");
                }
               
           }
           scope.path.status = status;
        }
    
        this.path.button_state = {};
        this.path.button_state.not_paused = (function(path){
            if (path.status==0){
                return false;
            } else {
                return true;
            }

        })(this.path);

        this.state.hideInputState = function(editable){
            return !editable;
        }
        this.state.hideSpanState = function(editable){
            return editable;
        }

        this.path.edit = function(obj, state){
            state.editable = true;
            $(".path_caption_input:not(.hidden)")[0].focus();
        }

        // All this move with bluredByKeybeaord
        // exist coz after keyboard event and closing 
        this.state.bluredByKeyboard = false;
        this.state.changeEditable = function(event, scope){

            if (event.type=="click" && event.target.tagName.toLowerCase()=="input" && scope.state.editable==true){
                return;
            }

            if (event.type=='blur' && scope.state.bluredByKeyboard) {
                scope.state.bluredByKeyboard = false;
                return;
            } else if (event.type=='blur') {
                scope.state.editable = false;
                return;
            }

            scope.state.editable = !scope.state.editable;
           
            if ( scope.state.editable ){
                if ($(event.target).find("input").length>0){
                    $(event.target).find("input")[0].focus();
                } else if (event.target.tagName.toLowerCase() == "span") {
                    $(event.target).next()[0].focus();
                    event.target.focus();
                }
            }           
            
        }
    };

    rivets.components['paths-buttons'] = {
        template: function(){
            return '<div class="_path_buttons_wrapper"><a rv-on-click="addPath" class="green-button" id="add-path-btn"><img src="templates/standart/images/w-add.png" class="icon add_icon">Path</a></div>';;
        },
        initialize: function(el, data){
            return new pathsButtonsController(data);
        }
    };
    function pathsButtonsController(data){
        this.paths = data.paths;
        this.addPath = function(event, scope){
            scope.paths.push(makeEmptyPath(scope.paths));
        }
    };

    // Landing components
    rivets.components['landings-block'] = {
        template: function(){
            return '<div class="_landers" >\
                        <div class="lands-block">\
                            <div class="_lp_header">\
                                <div class="_lp-caption"><span>LANDING PAGES</span></div>\
                            </div>\
                            <div rv-each-landing="landings"> <landing-block offers="offers" landings="landings" landing="landing"></landing-block> </div>\
                        </div>\
                         <landing-buttons landings="landings" offers="offers"></landing-buttons>   \
                    <div>';
        },
        initialize: function(el, data) {
          return data;
        }
    };


    rivets.components['landing-block'] = {
        template: function(){
            var tgl_id = getToggleId();
            return '<div class="_lp _row" rv-class-_paused="landing.paused" data-landing-id={landing.id} >\
                            <div class="_div-color"></div>\
                            <div class="_lp-caption _caption" rv-on-click="changeLanding">\
                                <span >{landing.detail.name}</span>\
                                <span rv-if="hasLang | call landing.detail.lang" class="_info" title="Landing\'s lang">{landing.detail.lang | lowerCase}</span>\
                                <span rv-if="landing.multioffer | call landing.detail.offers" title="Count of offers">({landing.detail.offers} offers)</span>\
                            </div>\
                            <weight-block object="landing"></weight-block>\
                            <actions-block obj="landing" array_holder="landings"></actions-block>\
                        </div>';
        },
        initialize: function(el, data) {
            return new landingController(data);
        }
    };
    function landingController(data){
        this.landing = data.landing;

        this.landing.multioffer = function(offers){
            if (offers>1){
                return true;
            } else {
                return false;
            }
        };
        // For class in componen flag only
        this.landing.paused = (data.landing.status==0?true:false);
        
        // For outer calling
        this.landing.edit = function(land){

            if (land.type==1){
    
                $.ajax({
                    type: "post",
                    url: "",
                    data: {
                        "ajax":1,
                        "type":"get_land",
                        "id":land.id_t,
                    }
                }).success(function(data){
                    data = JSON.parse(data);
                    prepareLandingWindow(data, openLandingWindowCallback(land)); 
                    });
                }

        };

        this.changeLanding = function(event, scope){

            chooseLanding(scope.landings, scope.offers, true, scope.landing);
        },
        this.hasLang = function (lang){
            if (typeof lang != "undefined" && lang != ""){
                return true;
            } else {
                return false;
            }
        }

        this.landings = data.landings;
        this.offers = data.offers;
        this.delete = function(event, scope){
          scope.landings = scope.landings.remove(scope.landing);
        };
    };

    rivets.components['landing-buttons'] = {
        template: function(){
            return '<div class="_lp-buttons">\
                        <a class="green-button add-lander-normal-button" rv-on-click="chooseLanding"><img src="./templates/standart/images/w-add.png" class="icon add_icon">Lander</a>\
                        <a rv-on-click="addDirect" class="green-button add-lander-direct-button"><img src="./templates/standart/images/w-add.png" class="icon add_icon">Direct</a>\
                        <a class="blue-button add-lander-new-button" rv-on-click="addNewLanding"><img src="./templates/standart/images/w-star.png" class="icon new_icon">New lander</a>\
                    </div>'
        },
        initialize: function(el, data){
            return new landingButtonsController(data);
        }
    };
    function landingButtonsController(data){
        this.landings  = data.landings;
        this.offers    = data.offers;
        this.addDirect = function(event, scope){
            somethingWasChanged();
            var direct_object = { 
                                 "id_t":0, 
                                 "type" : 2,
                                 "split" : "100",
                                 "status":1,
                                 "detail":{
                                    "name":"Direct",
                                    "offers":"1",
                                 }
                            }
            scope.landings.push(direct_object)
        };
        this.addNewLanding = function(event, scope){
            addNewLanding(scope.landings);
        };
        this.chooseLanding = function(event, scope){
            chooseLanding(scope.landings, scope.offers);
        }
    };

    // Offer components
    rivets.components['offers-block'] = {
        template: function(){
            return '<div class="_offers"  >\
                    <div class="_of-header">\
                        <div class="_of-caption"><span>OFFERS</span></div>\
                    </div>\
                    <div rv-each-offer="offers"><offer-block offers="offers" offer="offer"></offer-block></div>\
                    <offer-buttons offers="offers"></offer-buttons>\
                    \
            <div>';
        },
        initialize: function(el,data){
            return new offersController(data);
        }
    };
    function offersController(data){
        this.offers = data.offers;

        this.offers.deleteOffer = function(offer){
            somethingWasChanged();
            var idx = this.indexOf(offer);
            this.splice(idx, 1);
        }
    }

    rivets.components['offer-block'] = {
        template: function(){
            var tgl_id = getToggleId();
            return '<div class="_of _row _active" rv-class-_paused="isPaused | call offer.status" data-offer-id={offer.id}>\
                        <div class="_div-color"></div>\
                        <div class="_of-caption _caption" rv-on-click="changeOffer">\
                            <span rv-class-hidden="state.editable" >{getOfferName | call offer.detail.name offer.detail.network}</span>\
                            <input class="_offer_direct_url" rv-class-showed="state.editable" type="text" rv-value="offer.detail.name" rv-on-blur="inputLoseFocus">\
                            <span rv-if="offer.is_camp">  (campaign)  </span>\
                            <span class="_info" rv-text="state.payoutFormat  | call offer.detail.payout offer.detail.payout_auto "></span></div>\
                            <weight-block object="offer"></weight-block>\
                            \
                            <input rv-on-click="changeStatus" id="'+tgl_id+'" type="checkbox" rv-checked="offer.button_state.not_paused" class="tgl tgl-light">\
                            <label for="'+tgl_id+'" class="tgl-btn"></label>\
                            <edit-action-button obj="offer" state="state"></edit-action-button>\
                            <div rv-on-click="delete" class="delete_btn"></div>\
                    </div>';
        },
        initialize: function(el,data){
            // TODO добавить листенер на esc и enter для инпута с сылкой оффера
            return new offerController(data);
        }
    };
    function offerController(data){
        this.offer = data.offer;
        this.offer.is_camp = (data.offer.type==5);
        this.offer.paused = (data.offer.status==0?true:false);
        this.offers = data.offers;
  
        this.state = {};

        this.isPaused = function(status){ return (status==0?true:false) }

        this.state.editable = ((this.offer.type==4 && this.offer.detail.name=="")?true:false);
        this.state.bluredByKeybeaord = false;
        this.state.focus_flag = false;

        this.offer.button_state = {};
        // I dont understandt why just rv-checked="obj.paused" does not wokring it seems bug
        this.offer.button_state.not_paused = (function(offer){
            if (offer.status==0){
                return false;
            } else {
                return true;
            }

        })(this.offer);

        this.getOfferName = function(offer_name, network_name){
            if (typeof network_name != "undefined" && network_name != "0" && network_name!=""){
                return network_name + " - " + offer_name;
            } else {
                return offer_name;
            }
        },

        this.state.payoutFormat = function(payout, payout_auto){
            if (payout_auto==1 || typeof payout == "undefined"){
                return "auto";
            } else {
                return parseFloat(payout).toFixed(2) + "$";
            }
        }

        this.delete = function(event, scope){
            scope.offers.deleteOffer(scope.offer);
        }

        this.changeOffer = function(event, scope){
            if (scope.offer.type==3){
                chooseOffer(scope.offers, true, scope.offer);
            } else if (scope.offer.type==5){
                changeCampaign(scope.offers, true, scope.offer);
            } else {

                if (event.type=="click" && event.target.tagName.toLowerCase()=="input" && scope.state.editable==true){
                    return;
                }

                if (event.type=='blur' && scope.state.bluredByKeyboard) {
                    scope.state.bluredByKeyboard = false;
                    return;
                } else if (event.type=='blur') {
                    scope.state.editable = false;
                    return;
                }

                scope.state.editable = !scope.state.editable;
                if (scope.state.editable==true){
                    $("._offer_direct_url.showed")[0].focus();
                }
            }
            
        },
        

        this.inputLoseFocus = function(event, scope){
            scope.state.editable = false;
        },

        this.state.hideName = function(event, scope){
            if (scope.state.editable == false){
                return false;
            } else {
                return true;
            }
        }
        this.state.hideInput = function(event, scope){
            if (scope.state.editable == false){
                return true;
            } else {
                return false;
            }
        }

        this.offer.editUrl = function(event, scope){
            state.editable = !state.editable;
        }

        this.state.makeUneditable = function(event, scope){
            scope.state.editable = false;
            scope.state.focus_flag = true;
            setTimeout(function(){scope.state.focus_flag==false}, 200);
            //if ($(event.currentTarget))
        }

        this.offer.editDirect = function(event, scope){

            if (scope.state.editable == false) {
                scope.state.editable = !scope.state.editable;
                $("._offer_direct_url.showed")[0].focus();
            }

        },

        this.offer.edit = function(offer, state){
            
            if (offer.type==3){
               $.ajax({
                   type: "post",
                   url: "",
                   data: {
                       "ajax":1,
                       "type":"get_offer",
                       "id"  :offer.id_t,
                   }
               }).success(function(data){
                   data = JSON.parse(data);
                   prepareOfferWindow(data); 
                   openOfferWindow(offer)});
            } else if (offer.type==4){
                                
                if (state.editable == false) {
                    // Logic for Direct URL

                    state.editable = !state.editable;
                    $("._offer_direct_url.showed")[0].focus();
                }
                
                
            } else if (offer.type==5){
                window.open("?page=edit_camp&id=" + offer.id_t);
            }

        };

        this.changeStatus = function(event, scope){
            var status;
            if ($(event.target).prop("checked")==true){
                status = 1;
            } else {
                status = 0;
            }
            scope.offer.status = status;
        };
    };

    rivets.components['offer-buttons'] = {
        template: function(){
            return  '<div class="_lp-buttons">\
                        <a class="green-button add-offer-normal-button"    rv-on-click="chooseOffer"    > <img src="./templates/standart/images/w-add.png" class="icon add_icon">Offer</a>\
                        <a class="green-button add-offer-direct-button"    rv-on-click="addDirectOffer" > <img src="./templates/standart/images/w-add.png" class="icon add_icon">Direct URL</a>\
                        <a class="green-button add-offer-campaign-button"  rv-on-click="addCampaign"    > <img src="./templates/standart/images/w-add.png" class="icon add_icon">Campaign</a>\
                        <a class="blue-button  add-offer-new-button"       rv-on-click="addNewOffer"    > <img src="./templates/standart/images/w-star.png" class="icon new_icon">New offer</a>\
                    </div>';
        },
        initialize: function(el,data){
            return new offerButtonController(data);
        }
    };
    function offerButtonController(data) {
        this.offers = data.offers;
        this.addNewOffer = function(event, scope){addNewOffer(scope.offers)},
        this.addDirectOffer = function(event, scope){addDirectOffer(scope.offers);}
        this.addCampaign = function(event, scope){addCampaign(scope.offers);};
        this.chooseOffer = function(event, scope){chooseOffer(scope.offers);};
    }

    rivets.components['actions-block'] = {
        template: function(){
            var tgl_id = getToggleId();
            return '<div class="_of-actions" data-object-type="offer">\
                        <input rv-on-click="changeStatus" id="'+tgl_id+'" type="checkbox" rv-checked="obj.button_state.not_paused" class="tgl tgl-light">\
                        <label for="'+tgl_id+'" class="tgl-btn"></label>\
                        <edit-action-button obj="obj" state="state"></edit-action-button>\
                        <div rv-on-click="delete" " class="delete_btn"></div>\
                    </div>';
        },
        initialize: function(el, data){return new actionsBlockController(data)}
    };
    function actionsBlockController(data) {
        this.obj = data.obj;
        this.array_holder = data.array_holder;

        this.obj.button_state = {};
        // I dont understandt why just rv-checked="obj.paused" does not wokring it seems bug
        this.obj.button_state.not_paused = (function(obj){
            if (obj.status==0){
                return false;
            } else {
                return true;
            }

        })(this.obj);

        

        if (data.state){
            this.state = data.state;
        }

        this.delete = function(event, scope){
            somethingWasChanged();
            var idx = scope.array_holder.indexOf(scope.obj);
            scope.array_holder.splice(idx,1);
        };
        this.changeStatus = function(event, scope){

            var status;
            if ($(event.target).prop("checked")==true){
                status = 1;
                scope.obj.paused = false;
            } else {
                status = 0;
                scope.obj.paused = true;
            }
            scope.obj.status = status;
        };
    };

    rivets.components['weight-block'] = {
        template: function(){

            return  '<div rv-on-click="makeWeightEditable" class="_weight-wrapper">\
                         <span class="_weight-amount" rv-class-visible="state.not_edit_weigth" >{object.split}</span>\
                         <input rv-value="object.split" type="text" rv-on-focusout="makeWeightNonEditable" rv-class-hidden="state.not_edit_weigth" >\
                     </div>';
        },
        initialize: function(el, data){
            return new weightBlockController(data);
        }
    };
    function weightBlockController(data){

        this.object = data.object;

        this.state = {};
        this.state.not_edit_weigth = true;

        this.openInput = function(){
            scope.state.not_edit_weigth = false;
        }

        this.makeWeightNonEditable = function(event, scope){
            scope.state.not_edit_weigth = true;
        };

        this.makeWeightEditable = function(event, scope){
            scope.state.not_edit_weigth = false;
            $(event.currentTarget).find("input")[0].focus();
        }
    };

    


    rivets.components['edit-action-button'] = {
        template: function(){
            return '<div rv-on-click="editAction" class="edit_btn"></div>';
        },
        initialize: function(el, data){
            return new editButtonController(data);
        }
    };
    function editButtonController(data){
        this.obj = data.obj;
        if (data.state){
            this.state = data.state;
        }
        this.editAction = function(event, scope){
            scope.obj.edit(scope.obj, scope.state);
        }
    };

/*
###################
*/




/*
####################
FORMATTERS
####################
*/
    rivets.formatters.getOfferName = function(offer){
        if (offer.detail.url){
            return offer.detail.url;
        } else {
            return offer.detail.name;
        }
    }

    // TODO добавить payout auto
    rivets.formatters.offerPayout = function(offer_detail){
        if (offer_detail.payout_auto && offer_detail.payout_auto==1){
            return "auto";
        } else if (!offer_detail.payout){
            return "0.0$";
        } else {
            return parseFloat(offer_detail.payout).toFixed(2) + "$";
        }

    }

    rivets.formatters.lowerCase = function(str){
        return str.toLowerCase();
    }

    /*rivets.formatters.offerPayout = {
        read: function(offer_detail){
            if (offer_detail.payout_auto && offer_detail.payout_auto==1){
                return "auto";
            } else if (!offer_detail.payout){
                return "0.0$";
            } else {
                return parseFloat(offer_detail.payout).toFixed(2) + "$";
            }
        },
        publish: function(){
            return "huy";
        }
    }*/

    /*rivets.formatters.criterionName = function(cri_type, cri_type_2){
 
    }*/
/*
####################
*/

jobj_block.append("<routing-app routing='routing'></routing-app>");

var rivers_routing = rivets.bind(jobj_block, {routing: ROUTING} );

/*
########################
 ALL ABOUTH THE WINDOWS 
########################
*/
    
    var addNewLanding = function (arr) {
        //something_was_changed+=1; 
        somethingWasChanged();
        $.ajax({
            url: "",
            type: "POST",
            data: {"type" : "load_group_lp",
                   "ajax":"1"},
            success:function(data) { 
                $("#add_lp [name = lp_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
                var lp_protect = window.lp_protect_landing;
                $("#add_lp input").val("");
                $("#add_lp select :nth-child(1)").prop("selected", true);
                addTokensToURL.init( $("#add_lp input[name=\'lp_url\']") , "add_lp", "lp");
                addCheckButtonToURL.init("input[name=lp_url]");
                $("#add_lp group_name").css("display","none");
                $("#add_lp #clear_bl").css("display","none");
                $("#add_lp [name=lp_protect]").val(lp_protect);
                $("#wrap").css("display","block");
                $("#add_lp").css("display","block");
                $("#add_lp .win-save-button").attr("onclick","");
                $("#add_lp").find(".win-save-button").off("click");
                $("#add_lp").find(".win-save-button").on("click", makeSaveNewLandingHandler(arr));
            }
        });

    },

    prepareLandingWindow = function(data, additional_callback){
        var lp_protect = lp_protect_landing;
        function makeSettingWindowCallBack(){
            return function(){
                $("#add_lp [name=lp_protect]").val(lp_protect);
                $("input[type=file]").change(function(){
                    files = this.files;
                });
                
                $("#load_type_2").click(function(){
                    $("#lp_protect_span").css("display","none");
                    $("#lp_protect_input").css("display","none");
                    $("#land_block_1").css("display","none");
                    $("#land_block_2").css("display","block");
                    $("#lp_type").val("2");
                    addCheckButtonToURL.init("input[name=lp_file]", true);
                });
                
                $("#load_type_1").click(function(){
                    $("#land_block_2").css("display","none");
                    $("#lp_protect_span").css("display","block");
                    $("#lp_protect_input").css("display","block");
                    $("#land_block_1").css("display","block");
                    $("#lp_type").val("1");

                    addTokensToURL.init( $("#add_lp input[name=\'lp_url\']") , "add_lp", "lp");
                    addCheckButtonToURL.init("input[name=lp_url]");
                });

                $("#add_lp [name=lp_name]").val(data.name);
                if (data.type==2){
                    $("#add_lp [name=lp_file]").val(data.url);
                } else  {
                    $("#add_lp [name=lp_url]").val(data.url);
                }
                $("#add_lp [name=lp_type]").val(data.type);
                $("#add_lp [name=lang_lp]").val(data.lang);
                $("#add_lp [name=lp_group]").val(data.group_lp);
                $("#add_lp [name=offers]").val(data.offers);

                if(data.type==2){
                    $("#lp_protect_span").css("display","none");
                    $("#lp_protect_input").css("display","none");
                    $("#land_block_1").css("display","none");
                    $("#land_block_2").css("display","block");
                    $("#lp_file_block").css("display","block");
                    $("#download_land").css("display","none");
                    $("#lp_type").val("2");
                    $("#add_lp [name=lp_file]").prop("readonly", true);
                    $("#add_lp [name=lp_file]").addClass("readonly_input");
                    addCheckButtonToURL.init("input[name=lp_file]", true);
                }else{
                    $("#land_block_2").css("display","none");
                    $("#lp_file_block").css("display","none");
                    $("#lp_protect_span").css("display","block");
                    $("#lp_protect_input").css("display","block");
                    $("#land_block_1").css("display","block");
                    $("#lp_type").val("1");
                    addTokensToURL.init( $("#add_lp input[name=\'lp_url\']") , "add_lp", "lp");
                    addCheckButtonToURL.init("input[name=lp_url]");
                    
                }

                
            }
        }
        var callbackLoadGroup = makeSettingWindowCallBack();
        //подгружаем группы через ajax
        $.ajax({
            url: "",
            type: "POST",
            data: {"type" : "load_group_lp",
                   "ajax":"1"},
            success:function(data) { 
                $("#add_lp [name = lp_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
                callbackLoadGroup();
                additional_callback();
                landingPageHelper.addCopyFuncTobutton();
            }
        });
        
    },
    /**
    * obj - landing object
    */
    openLandingWindowCallback = function(obj){
        return function(){
            $("#add_lp .win-save-button").attr("onclick", "");
            $("#add_lp").find(".win-save-button").off("click");

            function save_callback(){
                obj.detail.name = $("#add_lp [name=lp_name]").val();
                obj.detail.offers = $("#add_lp [name=offer]").val();
                obj.detail.lang = $("#add_lp [name=lang_lp]").val();
            }

            $("body").off("click", "#add_lp .win-save-button");

            function makeAjaxCallback(land){
                return function(){
                    obj.detail.name = land.name;
                    obj.detail.offers = land.offers;
                    obj.detail.lang = land.lang;
                    // Close window
                    clear_closing();
                    $(".wrap").css("display", "none");
                    $("#add_lp").css("display", "none");
                    clearWindow("#add_lp");
                }
            }

            function saveEditedLand(){
                var landing = checkLandingWindow();
                if (!landing){
                    return false;
                }
                $.ajax({
                    url: "",
                    type: "POST",
                    data: {"type" : "save_new_lp",
                           "id" : obj.id_t, 
                           "name" : landing.name,
                           "url" : landing.url,
                           "group_id" : landing.group_id,
                           "lang": landing.lang,
                           "group_name": landing.group_name,
                           "offers": landing.offers,
                           "lp_type":landing.lp_type,
                           "file" : landing.file,
                           "ajax":"1"},
                    success: makeAjaxCallback(landing)
                });
            }

            $("#add_lp").find(".win-save-button").on("click", saveEditedLand);
            
            $("#wrap").css("display", "block");
            $("#add_lp").css("display", "block");
        }
    },

    prepareOfferWindow = function(data){

        function makeSettingWindowCallBack(){
            return function(){
                $("#add_of [name=of_name]").val(data.name);
                $("#add_of [name=of_url]").val(data.url);
                $("#add_of [name=geo_of]").val(data.geo);
                $("#add_of [name=of_group]").val(data.group_of);
                $.ajax({
                    url:"",
                    type:"POST",
                    data: {"type":"find_networks", 
                            "ajax":"1"}
                }).success(function(networks){
                    networks = JSON.parse(networks);
                    var networks_len = networks.length;
                    $("#add_of [name=of_networks]").html("");
                    $("#add_of [name=of_networks]").append('<option selected="" value=""></option>');
                    for (var i=0; i<networks_len;i++){
                        
                        $("#add_of [name=of_networks]").append("<option \
                                                                data-postback-url='"+networks[i]["postback_url"]+"'\
                                                                value="+networks[i]["id"]+">\
                                                                "+networks[i]["name"]+"\
                                                                </option>");
                    }
                    $("#add_of [name=of_networks]").append("<option value='add_new_network'>Add new</option>");
                    $("#add_of [name=of_networks]").val(data.network);  
                    $("#add_of [name=of_networks]").trigger("change");
                    // from binomscript
                    offerPageHelper.addCopyFuncTobutton();
                })
                $("#add_of [name=of_pay]").val(Math.ceil((data.payout)*1000)/1000);

                if (data.auto_payout == 1){
                    $("#add_of [name=auto_pay]").prop("checked", true);
                } else {
                    $("#add_of [name=auto_pay]").prop("checked", false);
                }
                $("#add_of [name=auto_pay]").trigger("change");
                if (data.upsell == 1){
                    $("#add_of [name=upsell]").prop("checked", true);
                } else {
                    $("#add_of [name=upsell]").prop("checked", false);
                }
                $("#add_of [name=upsell]").trigger("change");

                addTokensToURL.init( $("#add_of input[name=\'of_url\']") , "add_of", "of");
                addCheckButtonToURL.init("input[name=of_url]");
            }
        }
        var callbackLoadGroup = makeSettingWindowCallBack();
        //подгружаем группы через ajax
        $.ajax({
            url: "",
            type: "POST",
            data: {"type" : "load_group_of",
                   "ajax":"1"},
            success:function(data) { 
                $("#add_of [name = of_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
                callbackLoadGroup();

            }
        });
    },
    /**
    * obj - landing object
    */
    openOfferWindow = function(obj){

        

        $("#add_of .win-save-button").attr("onclick", "");
        $("#add_of").find(".win-save-button").off("click");

        function save_callback(){
            obj.detail.name = $("#add_of [name=lp_name]").val();
            obj.detail.offers = $("#add_of [name=offer]").val();
        }
        $("body").off("click", "#add_of .win-save-button");

        function makeAjaxCallback(offer){
            return function(){
                obj.detail.name = offer.name;
                obj.detail.payout = offer.payout;
                obj.detail.payout_auto = offer.payout_auto;
                obj.detail.network = offer.network_name;
                // Close window
                clear_closing();
                $(".wrap").css("display", "none");
                $("#add_of").css("display", "none");
                clearWindow("#add_of");
            }
        }

        function saveEditedOffer(){
            var offer = checkOfferWindow();
            if (!offer){
                return false;
            }
            $.ajax({
                url: "",
                type: "POST",
                data: {"type" : "save_new_of",
                       "id": obj.id_t,
                       "name" : offer.name,
                       "url" : offer.url,
                       "geo" : offer.geo,
                       "group_id" : offer.group,
                       "network_id": offer.network,
                       "network_name": $("#add_of [name=network_name_of]").val(),
                       "group_name": offer.group_name,
                       "pay" : offer.payout,
                       "upsell" : offer.upsell,
                       "pay_auto" : offer.auto_payout,
                       "ajax":"1"},
                success: makeAjaxCallback(offer)
            });
        }

        $("#add_of").find(".win-save-button").on("click", saveEditedOffer);
        
        $("#wrap").css("display", "block");
        $("#add_of").css("display", "block");
    },

    makeSaveNewLandingHandler = function(arr){
        return function(){
            var landing = checkLandingWindow();
            if (!landing){
                return false;
            } 
            function makeAjaxCallback(landing){
                return function(data){
                    var id = data;
                    landing = editLandingForROUTING(landing, id);
                    // Add to ROUTING
                    arr.push(landing);
                    // Close window
                    clear_closing();
                    $(".wrap").css("display", "none");
                    $("#add_lp").css("display", "none");
                    clearWindow("#add_lp");
                }
            }
            $("#add_lp").find(".win-save-button").off("click");
            $.ajax({
                url: "",
                type: "POST",
                data: {"type" : "save_new_lp",
                       "name" : $("#add_lp  [name = lp_name]").val(),
                       "url" : $("#add_lp  [name = lp_url]").val(),
                       "file" : $("#add_lp  [name = lp_file]").val(),
                       "group_id" : $("#add_lp  [name = lp_group]").val(),
                       "lang": $("#add_lp  [name = lang_lp]").val(),
                       "group_name": $("#add_lp  [name = group_name]").val(),
                       "offers":$("#add_lp  [name = offers]").val(),
                       "lp_type":$("#add_lp  [name = lp_type]").val(),
                       "ajax":"1"},
                success: makeAjaxCallback(landing)
            });
        }
    },

    editLandingForROUTING = function(landing, id){
        var ROUTING_landing = {
            "status" : 1,
            "id_t" : id,
            "type" : 1,
            "split" : 100,
            "detail" : {
                "name": landing.name,
                "offers":landing.offers,
                "lang": landing.lang
            }
        };
        return ROUTING_landing;
    },
    checkLandingWindow = function(){
        var error=0, landing={};
        if($("#add_lp [name = 'lp_name']").val()==""){
            $("#add_lp [name = 'lp_name']").css("border", "1px solid red");
            error = 1;
        }else{
            $("#add_lp [name = 'lp_name']").css("border", "1px solid #ccc");
        }
        
        if($("#add_lp [name = 'lp_group']").val()=="add"){
            if($("#add_lp [name = 'group_name']").val()=="" || $("#add_lp [name = \'group_name\']").val()=="Name of new group"){
                $("#add_lp [name = 'group_name']").css("border", "1px solid red");
                $("#add_lp [name = 'lp_group']").css("border", "1px solid red");
                error = 1;
            }else{
                $("#add_lp [name = 'group_name']").css("border", "1px solid #ccc");
                $("#add_lp [name = 'lp_group']").css("border", "1px solid #ccc");
            }
        }

        if ($("#land_block_1").css("display")!="none"){

            if( $(".win_add_lp_content [name = \'lp_url\']").val()=="" ) {
                $(".win_add_lp_content [name = \'lp_url\']").css("border", "1px solid red");
                error = 1;
            }else{
                $(".win_add_lp_content [name = \'lp_url\']").css("border", "1px solid #ccc");
            }

        } else if ($("#land_block_2").css("display")!="none"){

            if ($(".win_add_lp_content [name = \'lp_file\']").val()==""){
                $(".win_add_lp_content [name = \'import_file\']").css("border", "1px solid red");
                error = 1;
            } else {
                $(".win_add_lp_content [name = \'import_file\']").css("border", "1px solid #ccc");
            }

        }

        landing["name"]       = $("#add_lp [name = 'lp_name']").val();
        landing["url"]        = $("#add_lp [name = 'lp_url']").val();
        landing["group_id"]   = $("#add_lp [name = 'lp_group']").val();
        landing["lang"]       = $("#add_lp [name = 'lang_lp']").val();
        landing["group_id"]   = $("#add_lp [name = 'lp_group']").val();
        landing["group_name"] = $("#add_lp [name = 'group_name']").val();
        landing["offers"]     = $("#add_lp [name = 'offers']").val();
        landing["lp_type"]    = ($("#add_lp [name = 'lp_type']").val()!=""?$("#add_lp [name = 'lp_type']").val():1);
        landing["file"]       = $("#add_lp  [name = lp_file]").val()

        if (error==0){
            return landing;
        } else {
            return false;
        }
    },
    saveNewLanding = function(){},
    closeChooseLandingWindow = function(){

    },
    chooseLanding  = function(arr, offers_arr, swap, landing){

        if (typeof swap == "undefined"){
            swap = false;
        }

        // something_was_changed+=1; 
        somethingWasChanged();
        // подгружаем группы через ajax
        $.ajax({
            url: "",
            type: "POST",
            data: {"type" : "load_group_lp",
                   "ajax":"1"},
            success:function(data) { 
                var old_val = $("#all_lp [name = group_lp]").val();
                $("#all_lp [name = group_lp]").html("<option value=\'\'>All groups</option>"+data);
                $("#all_lp [name = group_lp] [value=\'"+old_val+"\']").prop("selected", true);
            }
        });
            
        $("#wrap").css("display","block");
        $("#all_lp").css("display","block");
        $("body").off("click","#all_lp tr.dop_table_tr");
        $("body").on("click","#all_lp tr.dop_table_tr", makeChooseLandingRowClickHandler(arr,offers_arr, swap, landing));
        $("body").off("click", "#all_lp .win-save-button");
        $("body").on("click", "#all_lp .win-save-button", makeChooseLandingsByCheckboxRowClickHandler(arr,offers_arr, swap, landing));
        /*$("body").off("click", "#all_lp .win-close-button" );

        $("#all_lp .win_footer").css("display", "none");
        $("#all_lp .win_footer").html("");*/

        $("body").on("click", "#all_lp .win-close-button", function(){
            clearWindow("#all_lp");
            $("#all_lp").css("display", "none");
            $(".wrap").css("display", "none");
        });

        /*
            $("#all_lp [name = win_lp_id]").val(lp_id);
            $("#all_lp [name = win_par_type]").val("path");
            $("#all_lp [name = win_lp_par_id]").val(path_id);
        */
        load_lp_list();
    },

    // TODO добавить возможность добавлять пустые офферы
    correlateCountOfOffersInLandings = function(landing, landings_array, offers_array, index_untoucheble){

        if (typeof index_untoucheble == "undefined"){
            index_untoucheble = -1;
        }

        if (landings_array.length==0 && landing.offers==1){
            return true;
        }

        var count_of_offers = landing.offers,
            diff_offers_lands = new Array();
        
        for (var i=0; i<landings_array.length; i++){
            if (landings_array[i].detail.offers != count_of_offers && !(count_of_offers==1 && landings_array[i].detail.offers==0)){
                if (i != index_untoucheble){
                    diff_offers_lands.push(landings_array[i]);
                }
            }
        }

        if (diff_offers_lands.length>0 || landings_array.length==0){
            if (confirm("You are adding lander with different number of offers. Are your sure?")){
                // Проводим действия по выравниванию количества офферов
                // Remove extra landers
                for (var i=0; i<diff_offers_lands.length;i++){
                   landings_array.remove(diff_offers_lands[i]);
                }

            } else {
                return false;
            }
        }
        function removeAddOffersForCorrelate(){
            if (count_of_offers!=1){
                // Remove extra offers
                if (offers_array.length>count_of_offers){
                        var difference = offers_array.length - count_of_offers;
                        for (var i=offers_array.length-1;i>=count_of_offers;i--){
                            offers_array.remove(offers_array[i]);
                        }
                }
                // Add necess offers
                if (offers_array.length<count_of_offers){
                        var difference = count_of_offers - offers_array.length;
                        for (var i=0; i<difference; i++){
                            offers_array.push({
                                "id_t": 0,
                                "type":"3",
                                "split":100,
                                "status":1,
                                "detail" : {
                                    "name":"#Choose Offer#",
                                    "payout" : 0
                                }
                            });
                        }
                }
            }
            return true;
        }
        return removeAddOffersForCorrelate();
    },


    makeChooseLandingRowClickHandler = function(arr, offers_arr, swap, landing_swapped){
        return function(e){
            var e = e || event;

            if ( checkTargetForCheckbox(e.target) ){
                return true;
            }

            var landing = {};
            landing.id= $(this).attr("id");
            landing.offers = $(this).attr("data-offers-count");
            landing.name = $("#all_lp #lp_name_" + landing.id + " .lp_list_lp_name").text().trim();
            landing.lang = $("#all_lp #lp_lang_" + landing.id).html().trim();

            if (swap) {
                landing_edited = editLandingForROUTING(landing, landing.id);
                
                var index_untoucheble = arr.indexOf(landing_swapped);
                if (landing_swapped.detail.offers != landing_edited.detail.offers){
                    if (!correlateCountOfOffersInLandings(landing, arr, offers_arr, index_untoucheble)) {
                        return false;
                    }
                }
                swapLandings(landing_swapped, landing_edited);
            } else {
                if (!correlateCountOfOffersInLandings(landing, arr, offers_arr)) {
                    return false;
                }
                arr.push(editLandingForROUTING(landing, landing.id));
            }
            // Закрываем окно
            $("#all_lp input:checked").trigger("click");
            $(".wrap").css("display", "none");
            $("#all_lp").css("display", "none");
        }
    },


    makeChooseLandingsByCheckboxRowClickHandler = function(arr, offers_arr, swap, landing_swapped){
        
        if (typeof swap == "undefined"){
            swap = false;
        }

        return function(){
            var landings = new Array(), landing={};
            $("#all_lp tr.dop_table_tr .checkbox_group input[type=checkbox]:checked").each( function(index, item) {
                landing = {}
                landing.id = $(item).parent().parent().parent().attr("id");
                landing.offers = $(item).parent().parent().parent().attr("data-offers-count");

                landing.name = $(item).parent().parent().parent().find("#lp_name_"+landing.id + " .lp_list_lp_name").text().trim();
                landing.lang = $(item).parent().parent().parent().find("#lp_lang_"+landing.id).html().trim();
                
                landings.push(landing);
            });


            var swap_index = arr.indexOf(landing_swapped);

            if (!correlateCountOfOffersInLandings(landing, arr, offers_arr, swap_index)){
                return false;
            }
            // Refinding but land might be deleted
            swap_index = arr.indexOf(landing_swapped);

            if (swap){
                if (swap_index != -1){

                    swapLandings(landing_swapped, editLandingForROUTING(landings[0]));
                    for (var i=1; i<landings.length;i++){
        
                        arr.push(editLandingForROUTING(landings[i]));
                        //arr.splice(swap_index, 0, editLandingForROUTING(landings[i]));
                        swap_index += 1;
                    }
                } else {
                    for (var i=0; i<landings.length;i++){
                        arr.splice(i, 0, editLandingForROUTING(landings[i]));
                    }
                }
            } else {
                for (var i =0; i<landings.length;i++){
                    arr.push(editLandingForROUTING(landings[i], landings[i].id));
                }
            }

            $("#all_lp input:checked").trigger("click");
            $("#all_lp input:checked").trigger("click");
            clearWindow("#all_lp");
            $(".wrap").css("display", "none");
            $("#all_lp").css("display", "none");
        } 
    }

    clearWindow = function(window_selector){

        $(window_selector + " select option:selected").prop("selected", false);
        //$(window_selector + " select option:selected").trigger("change");
        $(window_selector + " input[type=text]").val("");
        $(window_selector + " textarea").val("");
        // $(window_selector + " input").trigger("change");
        $(window_selector + " [type=checkbox]").prop("checked", false);
        // $(window_selector + " [type=checkbox]").trigger("change");
        $(window_selector + " [type=checkbox]").off("click");
        $(window_selector + " [type=checkbox]").off("change");

        if (window_selector == "#all_lp" || window_selector == "#all_of"){
            $(window_selector + " .win_content .dop_table").html("");
        }

        if (window_selector == "#add_of"){
            $(window_selector + " [type=checkbox]").trigger("change");
            $(".postback_url_offer_field").css("display", "none");
        }
        if (window_selector == "#add_lp"){
            $("#land_block_1").css("display", "block");
            $("#land_block_2").css("display", "none");
            $(window_selector+" [name=group_name]").css("display", "none");
        }
    },

    // Functions for adding new offer
    addNewOffer = function(arr){
        clearWindow("#add_of");
        addTokensToURL.init( $("#add_of input[name=\'of_url\']") , "add_of", "of");
        addCheckButtonToURL.init("input[name=of_url]");
        $("#wrap").css("display","block");
        $("#add_of").css("display","block");

        //подгружаем группы через AJAX
        $.ajax({
            url: "",
            type: "POST",
            data: {"type" : "load_group_of",
                   "ajax":"1"},
            success:function(data) { 
                $("#add_of [name = of_group]").html("<option selected value=\'\'></option>"+data+"<option value=\'add\'>Add new</option>");
            }
        });
       
        $("#add_of").find(".win-save-button").attr( "onclick", "" );
        $("#add_of").find(".win-save-button").off("click");
        $("#add_of").find(".win-save-button").on("click", makeSaveNewOfferHandler(arr));
    },
    makeSaveNewOfferHandler = function(arr){
        return function(){
            var offer = checkOfferWindow();
            if (!offer){
                return false;
            } 

            function makeAjaxCallback(offer){
                return function(data){
                    var id = data;
                    offer = editOfferForROUTING(offer, id);
                    // Add to ROUTING
                    arr.push(offer);
                    // Close window
                    clear_closing();
                    $(".wrap").css("display", "none");
                    $("#add_of").css("display", "none");
                    clearWindow("#add_of");
                }
            }

            $.ajax({
                url: "",
                type: "POST",
                data: {"type" : "save_new_of",
                       "name" : offer.name,
                       "url" : offer.url,
                       "geo" : offer.geo,
                       "group_id" : offer.group,
                       "network_id": offer.network,
                       "network_name": $("#add_of [name=network_name_of]").val(),
                       "group_name": offer.group_name,
                       "pay" : offer.payout,
                       "upsell" : offer.upsell,
                       "pay_auto" : offer.auto_payout,
                       "ajax":"1"},
                success: makeAjaxCallback(offer)
            });
        }
    },
    editOfferForROUTING = function(offer, id){

        var ROUTING_offer = {
            "id_t" : id,
            "status" : 1,
            "new" : 1,
            "type" : 3,
            "split": 100,
            "detail" : {
                "name" : offer.name,
                "payout" : offer.payout,
                "payout_auto" : (offer.payout_auto?offer.payout_auto:offer.auto_payout),
                "network": (offer.network_name?offer.network_name:offer.network)
            }
        };
        return ROUTING_offer;
    },
    checkOfferWindow = function(){
        var error=0, offer={};
        if($("#add_of [name = 'of_name']").val()==""){
            $("#add_of [name = 'of_name']").css("border", "1px solid red");
            error = 1;
        }else{
            $("#add_of [name = 'of_name']").css("border", "1px solid #ccc");
            offer["name"] = $("#add_of [name = 'of_name']").val();
        }
        
        if($("#add_of [name = 'of_url']").val()==""){
            $("#add_of [name = 'of_url']").css("border", "1px solid red");
            error = 1;
        }else{
            $("#add_of [name = 'of_url']").css("border", "1px solid #ccc");
            offer["url"] = $("#add_of [name = 'of_url']").val();
        }
        
        if($("#add_of [name = \'of_group\']").val()=="add"){
            if($("#add_of [name = \'group_name_of\']").val()=="" || $("#add_of [name = \'group_name_of\']").val()=="Name of new group"){
                $("#add_of [name = \'group_name_of\']").css("border", "1px solid red");
                $("#add_of [name = \'of_group\']").css("border", "1px solid red");
                error = 1;
            }else{
                $("#add_of  [name = \'group_name_of\']").css("border", "1px solid #ccc");
                $("#add_of  [name = \'of_group\']").css("border", "1px solid #ccc");
                
            }
        }
        
        offer["group_name"] = $("#add_of [name = 'group_name_of']").val();
        offer["group"] = $("#add_of [name = 'of_group']").val();

        if($("#add_of [name = upsell]").prop("checked")==true){
            upsell=1;
        }else{
            upsell=0;
        }
        offer["upsell"] = upsell;
        
        if($("#add_of [name = auto_pay]").prop("checked")==true){
            pay=1;
            $("#add_of [name = \'of_pay\']").css("border", "1px solid #ccc");
            offer["auto_payout"] = 1;
        }else{
            var rep = /^[0-9]*$/;
            var rep2 = /^[0-9]*[.][0-9]*$/;
            if($("#add_of [name = 'of_pay']").val()=="" || (!rep.test($("#add_of [name = \'of_pay\']").val()) && !rep2.test($(".win_add_lp_content [name = \'of_pay\']").val()))){
                $("#add_of [name = 'of_pay']").css("border", "1px solid red");
                error = 1;
            }else{
                $("#add_of [name = 'of_pay']").css("border", "1px solid #ccc");
            }
            pay=0;
            offer["auto_payout"] = 0;
        }

        offer["payout"] =  $("#add_of [name = 'of_pay']").val();
        offer["geo"] =  $("#add_of [name = 'geo_of']").val();
        offer["network"] =  $("#add_of [name = 'of_networks']").val();

        if (typeof offer["network"] != "undefined" && offer["network"] != "0"){
            // for path-view
            offer["network_name"] = $("#add_of [name = 'of_networks'] option:selected").html();
            if (offer["network_name"]){
                offer["network_name"] = offer["network_name"].trim();
            }
        }
        if (offer["network_name"]=="Add new"){
            offer["network_name"] = $("#add_of [name=network_name_of]").val();
        }
        //offer["network_name"] = 
        
        if (error==0){
            return offer;
        } else {
            return false;
        }
    },
    swapOffers = function(offer1, offer2){
        offer1.id_t                     =  offer2.id_t;                
        offer1["new"]                   =  offer2["new"];                  
        offer1["split"]                 =  offer2["split"];                
        offer1["status"]                =  offer2["status"];               
        offer1["type"]                  =  offer2["type"];                 
        offer1.detail.name              =  offer2["detail"]["name"];       
        offer1.detail.payout            =  offer2["detail"]["payout"];     
        offer1.detail.payout_auto =  offer2["detail"]["payout_auto"];
    },
    swapLandings = function(landing1, landing2){

        landing1["id_t"]= landing2["id_t"];
        landing1["type"]= landing2["type"];
        landing1["split"]= landing2["split"];
        landing1["status"]= landing2["status"];
        landing1["detail"]["name"]= landing2["detail"]["name"];
        landing1["detail"]["lang"]= landing2["detail"]["lang"];
        landing1["detail"]["offers"]= landing2["detail"]["offers"];
    },
    addDirectOffer = function(arr){
        var directOffer = {"status":1, "type":4, "split":100, "detail":{"name":"", "payout_auto":"1"}};
        arr.push(directOffer);
        setTimeout(function(){
            $("._offer_direct_url.showed")[0].focus();

        }, 100);
    },
    addCampaign = function(arr){
        $("#wrap").css("display","block");
        $("#all_camp").css("display","block");
        $("body").off("click","#all_camp tr.dop_table_tr");
        $("body").on("click","#all_camp tr.dop_table_tr", makeChooseCampaignRowHandler(arr));
        load_camp_list();
    },
    /*makeChooseCampaignRowHandler = function(arr){
        return function(){
            somethingWasChanged();
            var campaign = {};
            campaign.detail = {};
            campaign.id_t = $(this).attr("id");
            campaign.detail.name = $(this).find("#camp_name_"+campaign.id_t).text().trim();

            campaign["status"] = 1;
            campaign["type"] = 5;
            campaign["split"] = 100;
            campaign["status"] = 1;
            arr.push(campaign);
            clearWindow("#all_camp");
            $(".wrap").css("display","none");
            $("#all_camp").css("display","none");
        }
    },*/
    changeCampaign = function(arr, swap, campaign){
        $("#wrap").css("display","block");
        $("#all_camp").css("display","block");
        $("body").off("click","#all_camp tr.dop_table_tr");
        $("body").on("click","#all_camp tr.dop_table_tr", makeChangeCampaignRowHandler(arr, campaign));
        load_camp_list();
    },
    makeChangeCampaignRowHandler = function(arr, to_swap){
        return function(){
            somethingWasChanged();
            var campaign = {};

            /*campaign.detail = {};
            campaign.id_t = $(this).attr("id");
            campaign.detail.name = $(this).find("#camp_name_"+campaign.id_t).html().trim();
            
            campaign["status"] = 1;
            campaign["type"] = 5;
            campaign["split"] = 100;
            campaign["status"] = 1;*/
            var id = $(this).attr("id")
            to_swap.detail.name = $(this).find("#camp_name_"+id).text().trim();
            to_swap.id_t = id;
            to_swap.status = 1;
            to_swap.type = 5;
            to_swap.split = 100;
            to_swap.status = 1;

            //arr.push(campaign);
            clearWindow("#all_camp");
            $(".wrap").css("display","none");
            $("#all_camp").css("display","none");
        }
    }
    makeChooseCampaignRowHandler = function(arr){
        return function(){
            somethingWasChanged();
            var campaign = {};
            campaign.detail = {};
            campaign.id_t = $(this).attr("id");
            campaign.detail.name = $(this).find("#camp_name_"+campaign.id_t).text().trim();
            campaign["status"] = 1;
            campaign["type"] = 5;
            campaign["split"] = 100;
            campaign["status"] = 1;
            arr.push(campaign);
            clearWindow("#all_camp");
            $(".wrap").css("display","none");
            $("#all_camp").css("display","none");
        }
    },
    chooseOffer = function(arr, swap, offer){
        if (typeof swap == "undefined"){
            swap = false;
        }
        $.ajax({
             url: "",
             type: "POST",
             data: {"type" : "load_group_of",
                    "ajax":"1"},
             success:function(data) { 
                 var old_val = $("#all_of [name = group_of]").val();
                 $("#all_of [name = group_of]").html("<option value=\'\'>All groups</option>"+data);
                 $("#all_of [name = group_of] [value=\'"+old_val+"\']").prop("selected", true);
             }
         });
         
         $("#wrap").css("display","block");
         $("#all_of").css("display","block");
         $("body").off("click", "#all_of tr.dop_table_tr");
         $("body").on("click", "#all_of tr.dop_table_tr", makeChooseOfferRowClickHandler(arr, swap, offer));
         $("body").off("click", "#all_of .win-save-button");
         $("body").on("click", "#all_of .win-save-button", makeChooseOffersByCheckboxRowClickHandler(arr, swap, offer))
         load_of_list();
    };

    function makeChooseOfferRowClickHandler(arr,swap, offer_swapped) {

        return function(e){
            somethingWasChanged();
            var e = e || event;

            if ( checkTargetForCheckbox(e.target) ){
                return true;
            }

            var offer= {};
            offer.id= $(this).attr("id");
            offer.name = $("#all_of #of_name_" + $(this).attr("id")).text().trim();
            offer.payout = $("#all_of #of_payout_" + $(this).attr("id")).html().trim();
            offer.network = $(this).find(".of_network").html().trim();

            if (offer.payout != "auto"){
                offer.payout = parseFloat(offer.payout);
            } else {
                offer.payout_auto = 1;
            }
            if (swap){
                swapOffers(offer_swapped, editOfferForROUTING(offer, offer.id));
                
            }  else {
                arr.push(editOfferForROUTING(offer, offer.id));
            }
            
            // Закрываем окно
            $("#all_of input:checked").trigger("click");
            $(".wrap").css("display", "none");
            $("#all_of").css("display", "none");
        }
    }
    function makeChooseOffersByCheckboxRowClickHandler(arr,swap,swap_offer){
        if (typeof swap == "undefined"){
            swap = false;
        }
        return function(){
            somethingWasChanged();
            var offers = new Array(), offer={};
            $("#all_of tr.dop_table_tr .checkbox_group input[type=checkbox]:checked").each( function(index, item) {
                offer = {}
                offer.id_t = $(item).parent().parent().parent().attr("id");
                offer.name = $(item).parent().parent().parent().find("#of_name_"+offer.id_t).text().trim();
                offer.payout = $(item).parent().parent().parent().find("#of_payout_"+offer.id_t).html().trim();
                offer.network = $(item).parent().parent().parent().find(".of_network").html().trim();
                
                if (offer.payout != "auto"){
                    offer.payout = parseFloat(offer.payout);
                } else {
                    offer.payout_auto = 1;
                }
                offers.push(offer);
            });
            
            if (swap){
                var swap_index = arr.indexOf(swap_offer);
                swapOffers(swap_offer, editOfferForROUTING(offers[0], offers[0].id_t));
                for (var i =1; i<offers.length; i++){
                    arr.splice(swap_index+1, 0, editOfferForROUTING(offers[i], offers[i].id_t));
                    swap_index += 1;
                }
            } else {    
                for (var i =0; i<offers.length;i++){
                    arr.push(editOfferForROUTING(offers[i], offers[i].id_t));
                }
            }

            $("#all_of input:checked").trigger("click");
            $("#all_of input:checked").trigger("click");
            $(".wrap").css("display", "none");
            $("#all_of").css("display", "none");
        }
    }

    function editCriterion(criterion){
        //something_was_changed+=1;
        somethingWasChanged() ;
        $("#cri_type").html("");
        var t = Date.now();

        saveButtonHandler = function(){
           var criterion_edited = getDataFromCriterionWindow();
           
           criterion.type = criterion_edited.type;
           // mark
           // if (criterion.type)
           criterion.type2 = criterion_edited.type2;
           criterion.type3 = criterion_edited.type3;
           criterion.values = criterion_edited.values;
           clearCriWindow();
           $(".wrap").css("display", "none");
           $("#add_cri").css("display","none");
        };

        function makeAjaxCallBack(){
            return function(data){
                // $("#cri_type").html(data);
                var data = JSON.parse(data);
                $("#cri_type").html(makeOptionsForCriList(data));
                window.ts_changed=false;
                $("#add_cri #cri_type").val(criterion.type);
                $("#add_cri #cri_type_2").val(criterion.type2);
                $("#add_Cri #cri_type_3").prop("checked", (criterion.type3==1?true:false));
                if (criterion.type2 == 0){
                    $(".is_btn").addClass("is_btn_active");
                } else {
                    $(".isnot_btn").addClass("isnot_btn_active");
                }
                initEditCri();
                text_values = (function(){
                    var text = "";
                    for (var i=0; i<criterion.values.length;i++){
                        text += criterion.values[i] + "\n";
                    }
                    return text;
                })();
                // TODO сделать сохранение окна 
                setOptions(text_values);
                $("body").on("click", "#add_cri .win-save-button", saveButtonHandler);
            }
        }

        $.ajax({
            url: "",
            type: "POST",
            data: {"type" : "load_cri_types",
                   "ts" : $("[name = \'camp_traffic_sources\']").val(),
                   "ajax":"1"},
            success: makeAjaxCallBack()
        });

        $("#add_cri textarea").val("");
        //$("#add_cri select :nth-child(1)").prop("selected", true);

        $("#wrap").css("display","block");
        $("#add_cri").css("display","block");

        $("#add_cri .win-save-button").attr("onclick", "");
        $("body").off("click", "#add_cri .win-save-button");

    }

    function makeOptionsForCriList(data){
        var html = "",
            tokens = new Array();
        for (var i=0, l=data.length;i<l;i++){
            // Is this param token?
            if (data[i]["type"]){
                tokens.push(data[i]);
                html += "<option value="+(parseInt(data[i]["id"]) + 90)+">Token "+data[i]["type"]+":"+data[i]["name"]+"</option>";
            } else {
                html += "<option value="+data[i]["id"]+">"+data[i]["name"]+"</option>";
            }
        }
        addTokensToROUTING(tokens);
        return html;
    }

    function addTokensToROUTING(tokens){
        ROUTING.tokens = [];
        for (var i=0, l=tokens.length;i<l;i++){
            ROUTING.tokens.push(tokens[i]);
        }
    }

    /**
    * arr - criterion array
    * @param arr {Array or string} If passed String, then it must be "new_rule"; 
                                   if passed Array, then it must be array of criteries
    * @param values {Array} If passed "new_rule" as first value then need to pass rules (from riverts scope) array
    */
    function addCriterion(arr, rules){

        //something_was_changed+=1;
        somethingWasChanged() ;
        if (window.ts_changed==true){
            $("#cri_type").html("");
            var t = Date.now();
            $.ajax({
                url: "",
                type: "POST",
                data: {"type" : "load_cri_types",
                       "ts" : $("[name = \'camp_traffic_sources\']").val(),
                       "ajax":"1"},
                success:function(data) { 
                    var data = JSON.parse(data);
                    $("#cri_type").html(makeOptionsForCriList(data));
                    window.ts_changed=false;
                }
            });
        }

        
        $("#add_cri textarea").val("");
        $("#add_cri select :nth-child(1)").prop("selected", true);

        $("#wrap").css("display","block");
        $("#add_cri").css("display","block");

        $("#add_cri .win-save-button").attr("onclick", "");
        $("body").off("click", "#add_cri .win-save-button");

        var saveButtonHandler;

        if (arr=="new_rule") {
            saveButtonHandler = function(){
                var emptyRule = makeEmptyRule(rules);
                emptyRule.criteria.push(getDataFromCriterionWindow());
                rules.push(emptyRule);
                clearCriWindow();
                $(".wrap").css("display", "none");
                $("#add_cri").css("display","none");
            }
        } else {
            saveButtonHandler = function(){
                arr.push(getDataFromCriterionWindow());
                clearCriWindow();
                $(".wrap").css("display", "none");
                $("#add_cri").css("display","none");
            };
        }


        $("body").on("click", "#add_cri .win-save-button", saveButtonHandler)

        // FUNCTION CALLING FROM WINDOWS CORE
        initEditCri();

    };
    function getDataFromCriterionWindow(){
        var criterion = {};
        criterion = getCriterionValuesFromWindow();
        return criterion;
    };
    
    function getCriterionValuesFromWindow(){
        var select_flag = 0,
            //input_type=1 значит из инпута и токенов, =2 значит из списка разбивая переносами строк
            input_type, 
            //Массивв значений с простым текстареа
            text_options = [6, 7,10, 11],
            with_exact_options = [1,2,3,16, /*4,*/ 5],
            include_empty = [14, 11],
            cri_select, cri_choices, 
            //Изменяется в initEditCri, openList
            list_is_open,
            //timeout id
            timeout,
            tokens_disabled, 
            select_flag;

        var arr_options = [];
        var cri_type = parseInt($("#cri_type").val()), cri_type_3;
        var cri_type_2 = $("#cri_type_2").val();

        if (with_exact_options.indexOf(cri_type)!=-1){
            cri_type_3 = ($("#add_cri #cri_type_3").is(":checked")?1:0);
        } else {
            cri_type_3 = 0;
        }

        if (text_options.indexOf(cri_type) != -1 || cri_type>90){
            var text=$("#cri_list").val().split("\n");
            for (var i=0; i<text.length; i++){
                if ((text[i]!==" ") && (text[i]!=="")){
                    arr_options.push(text[i].trim());
                }
            }
        } else if (cri_type == 12){
            var options = $(".day_of_week_option_block input:checked");
            options.each(function(i, item){
                arr_options.push(item.value);
            });
        } else if (cri_type == 18) {
            var start_time = document.getElementsByClassName("part-of-day-start")[0].value,
             end_time = document.getElementsByClassName("part-of-day-end")[0].value,
             reg_time = new RegExp("\d\d:\d\d", "i");

            if (start_time.match(/^\d\d:\d\d$/)!=null && end_time.match(/^\d\d:\d\d$/)!=null){
                start_time_arr = start_time.split(":");
                end_time_arr = end_time.split(":");

                if (parseInt(start_time_arr[0])>=0 && parseInt(start_time_arr[0])<24 && parseInt(start_time_arr[1])<60 && parseInt(start_time_arr[1])>=0 && parseInt(end_time_arr[0])>=0 && parseInt(end_time_arr[0])<24 && parseInt(end_time_arr[1])<60 && parseInt(end_time_arr[1])>=0){
                    arr_options.push(start_time + "-" + end_time);
                } else{
                    // alert("Please enter time in hh:mm format");
                    makeBadAlertModal("OK1", "Please enter time in hh:mm format").show();
                    return;
                }
                
            } else {
                // alert("Please enter time in hh:mm format");
                makeBadAlertModal("OK2", "Please enter time in hh:mm format").show();
                return;
            }
            

        } else if (cri_type == 8) {
           
           var  unique_type = $("input[name=unique_type]:checked").val();

            arr_options.push(unique_type);

        } else if (cri_type == 9) {
            arr_options = [];
        } else {
            var options = $(".Token");
            options.each(function(i, item){
                
                arr_options.push(item.getAttribute("data-value"));
            });
        }

        // Add empty/Unknown
        if ( (include_empty.indexOf(cri_type)!=-1 || cri_type>90) && $(".cri_include_empty input").prop("checked")){
            arr_options.push("unknown");
        }
        
        if (cri_type==20){
            cri_type_3=1;
        }

        criterion_data = {
            "status" : 1,
            "type"   : cri_type,
            "type2"  : cri_type_2,
            "type3" :  cri_type_3,
            "values"  : arr_options
        }
        return criterion_data;
    }

// Add all Close window buttons clearWindow handler
$("body").on("click", ".window .win_closebtn", function(){
    clearWindow("#"+$(this).parent().attr("id"));
});

$("body").on("click", ".window .win-close-button", function(){
    clearWindow("#" + $(this).parent().parent().parent().attr("id"));
});

/*
######################
*/
/*$("body").on("click", "#all_of tr.dop_table_tr",function (e) { 
    var e = e || event;

    if ( checkTargetForCheckbox(e.target) ){
        return true;
    }

    var id= $(this).attr("id"),
    name = $("#all_of #of_name_"+$(this).attr("id")).html().trim(),
    network_name = $(this).find(".of_network").html().trim(),
    full_name = name;
});*/

var templatesWindow = (function(){
    var window_class = "routing_template_window";
    return {
        makeHTML: function(){
            return '<div id="wrap" class="wrap '+window_class+'_wrap" style="display: block;"></div>\
                        <div class="window '+window_class+'" style="display: block; width:600px;height:600px;">\
                            <a onclick="notewindow_hide(this);" class="win_closebtn"></a>\
                            <div class="win_header">\
                                <span class="window_head_name" >Rules </span>\
                            </div>\
                            <div class="win_cap ">\
                            </div>\
                            <div class="win_content" >\
                            </div>\
                            <div class="win_footer ">\
                                <div class="win-buttons-block">\
                                    <a class="button win-save-button note-save-button"><img src="templates/standart/images/w-save.png" class="icon save_icon">Save</a>\
                                    <a class="button win-close-button note-close-button" ><img src="./templates/standart/images/w-close.png" class="icon close_icon">Close</a>\
                                </div>\
                            </div>\
                        </div>';
        },
        showWindow: function(){
            $("body").append(this.makeHTML());
        },  
        clearWindow: function(){
            $(".wrap."+window_class+"_wrap").remove();
            $("."+window_class).remove();
        },
        makeHandlerOpenWindow: function(){
            var that = this;
            return function(){
                that.showWindow();
            }
        }
    }
})();
var is_storage_enable;
if (typeof localStorage === "object"){
    try {
        localStorage.setItem('localStorage', 1);
        localStorage.removeItem('localStorage');
        is_storage_enable = true;
    } catch (e) {
        is_storage_enable = false;
    }
}
if (is_storage_enable){
    if (localStorage.getItem('rules_import')!== null){
        $(".paste_rules_templates").css({"display" : "inline"});
        $(".clear_rules_templates").css({"display" : "inline"});
    }

    $(window).bind('storage', function (e) {
        if (localStorage.getItem('rules_import')!== null){
            $(".paste_rules_templates").css({"display" : "inline"});
            $(".clear_rules_templates").css({"display" : "inline"});
        } else {
            $(".paste_rules_templates").css({"display" : "none"});
            $(".clear_rules_templates").css({"display" : "none"});
        }
    });

    $(".copy_rules_templates").on("click",  function() {
        routingTemplater.saveRulesToStorage();
        $(".paste_rules_templates").css({"display" : "inline"});
        $(".clear_rules_templates").css({"display" : "inline"});}     
    );
    $(".paste_rules_templates").on("click", function() {routingTemplater.importRulesFromStorage();somethingWasChanged();} );
    $(".clear_rules_templates").on("click", function() {routingTemplater.clearStorage();});
}

//console.log("Выполнилось за " + ((new Date()) - time)/1000 + " секунд" );