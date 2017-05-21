/**
* Classes are being used in this module
* divide on two types:
*   with _ prefix - design/css    
*   without this - hierarchical/structure
* but exceptions may apply.
*
* Id in data attribute almost always means id in database,
* path, path_com, rule and others.
* ROUTING is main object that handles all 
* settings of routing.
* When adding new stuff to path or rule, 
* it is important to add "new":"true" in lander_object,
* this is for easy saving.
*
* target_object is object where will be added object
* {"target" : "path", "target_number": 1} or {"target":"rule", "target_id":"", "target_path":"1"} or
* {"target" : "path", "target_number": 1, "object_type":"landing", "object_type":2}
*
* Target-number in data-attr count from 1
* so it is often found expression like ROUTING.paths[target_number-1]
*
* TODO написать подробные комменты
*
*/
var routingObject = new function(){
    var json_routing = $(".json_routing_keeper").html(),
    jobj_block = $(".camp_edit_right");

    $(".json_routing_keeper").remove();
    this.routing_data = JSON.parse(json_routing);

    criteries_map = {
        "1" : "Brand and Model"
    };

    return {
        ROUTING: this.routing_data,
        
        // jbobj paths
        jobj_paths: {},

        //jobj rules
        jobj_rules: {},

        general_counter: {
            "paths"  : 0,
            "rules"  : 0,
            "lands"  : 0,
            "offers" : 0,
            "criterion": 0
        },  

        // TODO добавить количество путей
        // количество рулсов 
        // TODO добавить анимацию на загрузку путей
        // TODO скорее всего нужно будет переписать туггл буттон,
        // так как он работает на css который может смотреть только логику одного
        // тугглера на странице

        // START  Init Drawing 
        drawWrapper: function(){
        },
        initDrawing(){
            this.drawPathsFromObject();
            this.drawRulesFromObject();
            this.setHandlersFordivs();
        },
        // Вызывается при изначальной отрисовке путей
        /**
        * @param inner {boolean} Is it rule-inner block?
        */
        drawPathsFromObject: function(){
            var path_jobj = {};
            jobj_block.append(this.makePathsWrapper());
            this.jobj_paths = jobj_block.find("._paths");
            for (var i=0;i<this.ROUTING.paths.length;i++){
                path_jobj = {};
                path_jobj = this.makePathFromObject(this.ROUTING.paths[i], i);
                this.jobj_paths.append(path_jobj);
            }
        },
        /**
        * @param inner {boolean} Is include header weight/actions?
        */
        makePathsWrapper: function(inner){
            var action='<div class="_path-weight"><span>Weight</span></div>\
                        <div class="_path-actions"><span>Actions</span></div>';
            if (typeof inner == "undefined"){
                inner = false;
            }

            return '<div class="_paths">\
                        <div class="_paths_header">\
                            <div class="_list-collapser"><div class="_collapser-div"></div></div>\
                            <div class="_path-caption"><span>PATHS</span></div>\
                            '+(inner?"":action)+'\
                        </div>\
                    <div>'
        },
        /**
        * @param args {Object} object with args: {number, name, split, is_rule_path}
        */
        makePathHeader: function(args){
            this.general_counter.paths += 1;
            var toogle_id = this.general_counter.paths;
            path_type = (args.is_rule_path?"rule-path":"path");
            return '<div class="_path-entry path-block" data-path-type="'+path_type+'" data-path-number="'+args.number+'">\
                        <div class="_path _active path-header-block">\
                            <div class="_div-color"></div>\
                            <div class="_list-collapser"><div class="_collapser-div"></div></div>\
                            <div class="_path-caption"><span>'+args.name+'</span></div>\
                            <div class="_path-weight"><span>'+args.split+'</span></div>\
                            <div class="_path-actions">\
                                <input id="cb1" type="checkbox" class="tgl tgl-light" checked="checked">\
                                <label for="cb1" class="tgl-btn"></label>\
                                <div class="edit_btn"></div>  \
                                <div class="delete_btn"></div>                                        \
                            </div>\
                        </div>\
                    </div>';
        },
        /**
        * @param path {Object} path object
        * @param number {string/integer} number of path
        * @param is_rule_path {boolean} Is this path rule-inner? #optional
        * @param rule_number #optional
        */
        makePathFromObject: function(path, number, is_rule_path, rule_number){
            if (typeof is_rule_path == "undefined"){
                is_rule_path = false;
            }
            var jobj_path = $(this.makePathHeader({
                                                    "number": number, 
                                                    "name":path.name, 
                                                    "split": path.split, 
                                                    "is_rule_path":is_rule_path
                                                })),
                path_type = (is_rule_path?"rule-path":"path");

            jobj_path.append(this.makeLands(path.landings, path_type, number, rule_number));
            jobj_path.append(this.makeOffers(path.offers,  path_type, number, rule_number));
            return jobj_path;
        },

        // TODO проверка на порядок
        drawRulesFromObject: function(){
            var rule_jobj = {},
                i = 0;
            jobj_block.append(this.makeRulesWrapper());
            this.jobj_rules = jobj_block.find("._rules");


            for (i=0; i<this.ROUTING.rules.length;i++){
                rule_jobj = {};
                // i+1 (!) be care
                rule_jobj = this.makeRuleFromObject(this.ROUTING.rules[i], i);
                this.jobj_rules.append(rule_jobj);
            }
        },
        makeRuleFromObject: function(rule, rule_number){
            // Make Rule Header
            var jobj_rule = $(this.makeRuleHeader(rule.id, rule_number, rule.name)),
                jobj_criteria = {},
                jobj_block_in_rule = $(this.makeInRuleBlock());

            //TODO Make criteria
            // Make criteria

            // Make criteria wrapper
            jobj_criteria = $(this.makeCriteriaWrapper());
            for (i=0; i<rule.criteria.length; i++){
                // Add to wrapper cri blocks
                jobj_criteria.append(this.makeCriterion(rule.criteria[i], rule_number) );
            }

            jobj_block_in_rule.append( jobj_criteria );

            // make path block in rules
            // Make wrapper of path
            var jobj_rule_path = $(this.makePathsWrapper(true));
            // Make paths
            for (i=0;i<rule.paths.length;i++){
                // Draw path of rule and append it to paths wrapper
                
                jobj_rule_path.append(this.makePathFromObject(rule.paths[i], i, true, rule_number));
            }
            // Add paths within wrapper to _BLOCK_IN_RULE
            jobj_block_in_rule.append(jobj_rule_path);

            jobj_rule.append(jobj_block_in_rule);
            return jobj_rule;
        },
        makeRulesWrapper: function(){
            return '<div class="_paths _rules">\
                        <div class="_paths_header">\
                            <div class="_list-collapser"><div class="_collapser-div"></div></div>\
                            <div class="_path-caption"><span style="color:#E53935;">RULES</span></div>\
                            <div class="_path-weight"><span>Weight</span></div>\
                            <div class="_path-actions"><span>Actions</span></div>\
                        </div>\
                    </div>';
        },

        makeRuleHeader: function(id, number, name, split){
            var toogle_id = this.general_counter.paths;
            return '<div class="_path-entry path-block" data-rule-number="'+number+'" data-rule-id="'+id+'">\
                        <div class="_path _active path-header-block">\
                            <div class="_div-color"></div>\
                            <div class="_list-collapser"><div class="_collapser-div"></div></div>\
                            <div class="_path-caption"><span>'+name+'</span></div>\
                            <div class="_path-weight"><span></span></div>\
                            <div class="_path-actions">\
                                <input id="cb1" type="checkbox" class="tgl tgl-light" checked="checked">\
                                <label for="cb1" class="tgl-btn"></label>\
                                <div class="edit_btn"></div>\
                                <div class="delete_btn"></div>\
                            </div>\
                        </div>\
                    </div>';
        },
        makeInRuleBlock: function(){
            return '<div class="_block_in_rule-entry"></div>';
        },
        makeCriteriaWrapper: function(){
            return '<div class="_criteria _inner-block">\
                        <div class="_criteria_header">\
                            <div class="_list-collapser"><div class="_collapser-div"></div></div>\
                            <div class="_criteria_header_caption _path-caption"><span style="color:#11AA22;">CRITERIA</span></div>\
                        </div>\
                    </div>';
        },
        makeCriterion: function(criterion, rule_number){
            var criterion_name = criteries_map[criterion.type];
            // TODO Make name of criterion
            return '<div class="_row _active _criterion" data-rule-number="'+rule_number+'">\
                        <div class="_div-color"></div>\
                        <div class="_criterion_caption _lp-caption"><span>'+criterion_name+'</span></div>\
                        <div class="_lp-actions">\
                            <input id="cb1" type="checkbox" class="tgl tgl-light" checked="checked">\
                            <label for="cb1" class="tgl-btn"></label>\
                            <div class="edit_btn"></div>\
                            <div class="delete_btn"></div>\
                        </div>\
                    </div>'
        },


        setHandlersFordivs: function(){
            var that = this;
            /*
             example 
             $('.selector').click(function(event) {
               that.handlerFunction(event);
            });
            */
            // For lander divs
            jobj_block.on("click", ".add-lander-normal-div", function(){   console.log("normal lander div click")});
            jobj_block.on("click", ".add-lander-new-div",    function(){   console.log("new lander div click")});
            jobj_block.on("click", ".add-lander-direct-div", function(){   that.addDirectLanderHadler(this) });
            // For offer divs
            jobj_block.on("click", ".add-offer-normal-div",   function(){  console.log("normal offer div click")   });
            jobj_block.on("click", ".add-offer-new-div",      function(){  console.log("new offer div click")      });
            jobj_block.on("click", ".add-offer-direct-div",   function(){  console.log("direct offer div click")   });
            jobj_block.on("click", ".add-offer-campaign-div", function(){  console.log("campaign offer div click") });
            //For delete Actions
            jobj_block.on("click", ".delete_btn", function() { that.removeObjectHandler(this)   });
            jobj_block.on("click", ".edit_btn",   function() {   console.log("edit div");    });
            jobj_block.on("change", ".tgl",       function() {    that.changeStatusHandler(this) });         
        },


        /**
        * @param landingns {array} array of landing objects
        * @param parent_type {string} offer/rule/rule-path
        * @param path_id {string/number} id of rule/path and etc
        */
        makeLands: function(landings, parent_type, path_number, rule_number){
            var i, 
                html_lands="",
                divs=this.makeLanddivs(path_number),
                data_attrs= "";

            for (i=0;i<landings.length;i++){
                // ERROR path_number может в мейк ленд делаться таргет намбером при руле-пас
                html_lands += this.makeLand(landings[i], {"landing_number":i, "path_number":path_number, "parent_type":parent_type, "rule_number":rule_number});
            }
            data_attrs = 'data-parent-type=' +parent_type+ ' data-parent-number=' + path_number;
            return '<div class="_landers" '+ data_attrs +' >\
                        <div class="lands-block" data-parent-type=' +parent_type+ ' data-parent-number=' +path_number+ '>\
                            <div class="_lp_header">\
                                <div class="_lp-caption"><span>LANDING PAGES</span></div>\
                            </div>\
                            '+html_lands+'\
                        </div>\
                            '+divs+'\
                    <div>';
        },
        // TODO makeLands и makeOffers не предусмотрены для 
        //      мультиоферности
        // TODO Добавить условие для директа
        /**
         * @param landing {Object} in form of campaign API
         * @param opts {Object} options
         *  landing_number {integer}
         *  path_number
         *  parent_type
         *  rule_number
         *  new_landing {boolean} is adding new or init drawing
         */
        //makeLand: function(landing, landing_number, path_number, new_landing){
        makeLand: function(landing, opts){    
            var data_target = "";
            // Setting correct target-link object
            if (opts.parent_type=="rule-path"){
                data_target = this.makeTargetJSONLink({
                "target" : opts.parent_type,
                "target_number": opts.rule_number,
                "target_path_rule" : opts.path_number,
                "object_type" : "landing",
                "object_number" : opts.landing_number,
            });
            } else {
                data_target = this.makeTargetJSONLink({
                    "target" : opts.parent_type,
                    "target_number": opts.path_number,
                    "object_type" : "landing",
                    "object_number" : opts.landing_number,
                });
            }

            if (typeof new_landing == "undefined"){
                opts.new_landing = false;
            }
            var landing_self_id = (landing.type==2?landing.id_t:0),
                pathcom_id_data="",
                new_landing_data =""; 

            if (opts.new_landing){
                new_landing_data = 'data-new-lander=1';
                new_landing_data = "";
            } else {
                pathcom_id_data = "";
            }

            var tgl_id = this.general_counter.paths + "1" + this.general_counter.lands;

            // Adding to general Counter
            this.general_counter.lands += 1;
            // landing id means id of path_com row
            // landing_self_id means id of landing row in landing_pages row
            return '<div class="_lp _active" data-target='+data_target+'  '+new_landing_data+'  data-landing-id='+landing_self_id+' data-parent-number='+opts.path_number+' data-object-type="landing" data-object-number='+opts.landing_number+'>\
                        <div class="_div-color"></div>\
                        <div class="_lp-caption"><span>'+landing.detail.name+'</span><span class="_info">en</span></div>\
                        <div class="_lp-weight"><span>'+landing.split+'</span></div>\
                        <div data-target='+data_target+' class="_lp-actions" data-object-type="landing" data-object-number='+opts.landing_number+'>\
                            <input id="'+tgl_id+'" type="checkbox" class="tgl tgl-light" checked="checked">\
                            <label for="'+tgl_id+'" class="tgl-btn"></label>\
                            <div data-object-type="landing" class="edit_btn edit_lander_btn"></div>\
                            <div data-object-type="landing" class="delete_btn delete_lander_btn"></div>\
                        </div>\
                    </div>';
        },

        makeLanddivs: function(path_number){
            return ' <div class="_lp-divs" data-parent-type="path" data-parent-number='+path_number+'>\
                                <a class="green-div add-lander-normal-div"><img src="./templates/standart/images/w-add.png" class="icon add_icon">Lander</a>\
                                <a class="green-div add-lander-direct-div"><img src="./templates/standart/images/w-add.png" class="icon add_icon">Direct</a>\
                                <a class="blue-div add-lander-new-div"><img src="./templates/standart/images/w-star.png" class="icon new_icon">New lander</a>\
                            </div>\
            ';
        },

        makeOffers: function(offers, parent_type, path_number, rule_number){
            var i, 
                html_offers="",
                divs = this.makeOffersdiv();
            for (i=0;i<offers.length;i++){
                html_offers += this.makeOffer(offers[i], {"offer_number":i, "path_number": path_number, "parent_type":parent_type, "rule_number":rule_number});
                
            }
            return '<div class="_offers" data-parent-type=' +parent_type+ ' data-parent-number=' +path_number+ ' >\
                            <div class="_of-header">\
                                <div class="_of-caption"><span>OFFERS</span></div>\
                            </div>\
                            '+html_offers+'\
                            '+divs+'\
                    <div>';
        },

        // TODO добавить условия на Direct URL и Кампании
        // TODO сделать возможность для изменения URL если Direct URL
        // TODO обработка количества знаков после запятой и знак $ в payout'е
        /**
         * @param offer {Object} in form of campaign API
         * @param opts {Object} options
         *  offer_number {integer}
         *  path_number
         *  parent_type
         *  rule_number
         *  new_offer {boolean} is adding new or init drawing
         */
        //makeOffer: function(offer, offer_number, path_number, new_offer){
        makeOffer: function(offer, opts){
            var data_target = "";
            if (opts.parent_type=="rule-path"){
                console.log("Создаем для оффера rule_path target-link");
                data_target = this.makeTargetJSONLink({
                    "target" : opts.parent_type,
                    "target_number": opts.rule_number,
                    "target_path_rule" : opts.path_number,
                    "object_type" : "landing",
                    "object_number" : opts.offer_number,
                });
            } else {
                data_target = this.makeTargetJSONLink({
                    "target" : opts.parent_type,
                    "target_number": opts.path_number,
                    "object_type" : "offer",
                    "object_number" : opts.offer_number,
                });
            }
            if (typeof opts.new_offer == "undefined"){
                opts.new_offer = false;
            }

            var offer_type="", 
                offer_pathcom_data, 
                offer_id_data,
                offer_name;

            // Offer is classic offer, or direct, or campaing?
            if (offer.type==3){
                offer_type = "offer";
                offer_name = offer.detail.name;
                offer_payout = offer.detail.payout;
            } else if (offer.type==4) {
                offer_type = "direct-url";
                offer_name = offer.detail.url;
                offer_payout = "auto";
            } else if (offer.type=5)  {
                offer_type = "campaign";
                offer_name = offer.detail.name;
                offer_payout = offer.detail.payout;
            }

            // In case offer is direct, offer.id_t or offer-id does not exist
            // just url. So for make attr readable add param
            if (offer.type==4){
                offer_id_data = "data-offer-direct-url="+offer.id_t;
            } else {
                offer_id_data = "data-offer-id="+offer.id_t;
            }

            if (opts.new_offer){
                new_offer_data = 'data-new-lander=1';
            } else {
                new_offer_data = '';
            }

            

            var tgl_id = this.general_counter.paths+"2"+this.general_counter.offers;

            // Adding to general_counter
            this.general_counter.offers += 1;
            return '<div class="_of _active"  data-target='+data_target+' data-type="'+offer_type+'" '+new_offer_data+' '+offer_id_data+'>\
                                <div class="_div-color"></div>\
                                <div class="_of-caption"><span>'+offer_name+'</span><span class="_info">'+offer_payout+'</span></div>\
                                <div class="_of-weight"><span>100</span></div>\
                                <div data-target="'+data_target+'" class="_of-actions" data-object-type="offer" data-object-number='+opts.offer_number+'>\
                                    <input id="'+tgl_id+'" type="checkbox" class="tgl tgl-light" checked="checked">\
                                    <label for="'+tgl_id+'" class="tgl-btn"></label>\
                                    <div class="edit_btn"></div>\
                                    <div class="delete_btn"></div>\
                                </div>\
                            </div>'
        },

        // TODO добавить какие-то зацепки для пути 
        makeOffersdiv: function(path_id){
            return '<div class="_lp-divs" data-path-id='+path_id+'>\
                        <a class="green-div add-offer-normal-div"><img src="./templates/standart/images/w-add.png" class="icon add_icon">Offer</a>\
                        <a class="green-div add-offer-direct-div"><img src="./templates/standart/images/w-add.png" class="icon add_icon">Direct URL</a>\
                        <a class="green-div add-offer-campaign-div"><img src="./templates/standart/images/w-add.png" class="icon add_icon">Campaign</a>\
                        <a class="blue-div add-offer-new-div"><img src="./templates/standart/images/w-star.png" class="icon new_icon">New offer</a>\
                    </div>';
        },

        // END  Init Drawing 
        addPath: function(){
        },

        // TODO сделать обработку для путей в рулсах
        /**
        * @param id {number/string} id of path (data-path-id)
        * @return {jQuery Object} object of path div
        */
        getPathBlock: function(target_obj){
            if (target_obj.target=="path"){
                return $(".path-block[data-path-number="+target_obj.target_number+"]");
            }
        },

        // this is handlers
        // so in 'on' (setHandlersFordivs) we pass click context in this function
        addLander: function(context){
        },

        // this is handlers
        // so in 'on' (setHandlersFordivs) we pass click-event context in this function
        // TODO заменить context на path_id как-то
        /**
        * @param context {string} click-event 'this' object
        */
        addDirectLanderHadler: function(context){
            var target_number = $(context).parent().attr("data-parent-number"),
                target = $(context).parent().attr("data-parent-type");;
            this.addDirectLander({"target":target, "target_number":target_number});
        },

        /**
        * @param target_obj {Object} Where add object, for instance {"target" : "path", "target_number": 1}
        */
        addDirectLander: function(target_obj){

            var path_block = this.getPathBlock(target_obj),
                land_object = {},
                land_block = "",
                adding_to_object_status;
            land_object = {
                //path_id : path_block, 
                status : "1",
                id_t : "0",
                type: "1",
                split: "100",
                // "new" indicate that landing is added by interface
                new: "true",
                detail: {
                    name:"Direct"
                }
            };
            landing_number = this.getCountOfObjects(target_obj.target, target_obj.target_number, "landing") + 1;
            // We count all objects from 1
            land_block = this.makeLand(land_object, landing_number, target_obj.target_number, true);
            path_block.find(".lands-block").append(land_block);
            // TODO сделать возможность добавлять прямо отсюда для rules
            adding_to_object_status = this.addLandingToROUTING(target_obj.target, target_obj.target_number, land_object);
            if (!adding_to_object_status){
                console.error("Cant adding direct land to ROUTING");
            }
        },

        // TODO переделать размещение data-parent-type/number на размещение в блоке кнопки
        removeObjectHandler: function(context){
            var target_obj= {
                "target"        : $(context).parent().parent().parent().attr("data-parent-type"),
                "target_number" : $(context).parent().parent().parent().attr("data-parent-number"),
                "object_number" : $(context).parent().attr("data-object-number"),
                "object_type"   : $(context).parent().attr("data-object-type")
            };

            if (target_obj.target=="rule-path"){

            } else if (target_ob.target=="path"){
            }

            this.removeObject(target_obj);
        },

        // Сделать обработку для путей в руслах
        /**
        * Deleting from HTML and Deleting from ROUTING
        * @param target_obp {Object} 
        *                    "target"         path/rule
        *                    "target_number"  number
        *                    "object_number"  number
        *                    "object_type"    land/offer and etc
        * also we can delete path as target:path, object_type:path
        */
        removeObject: function(target_obj){
            var path_block = this.getPathBlock(target_obj);
            // Deleting from ROUTING
            if (target_obj.target=="path"){
                if (target_obj.object_type=="landing"){
                    this.ROUTING.paths[target_obj.target_number-1].landings.splice(target_obj.object_number-1,1);
                } else if (target_obj.object_type=="offer"){
                    this.ROUTING.paths[target_obj.target_number-1].offers.splice(target_obj.object_number-1,1);
                } else if (target_obj.object_type=="path"){

                }
            }  

            // Delete from html
            var object_block = path_block.find("[data-object-type="+target_obj.object_type+"][data-object-number="+target_obj.object_number+"]");
            object_block.remove();
        },

        changeStatusHandler: function(context){
            
            /*var target_obj = {
                "target": $(context).parent().parent().parent().attr("data-parent-type"),
                "target_number": $(context).parent().parent().parent().attr("data-parent-number"),
                "object_type": $(context).parent().attr("data-object-type"),
                "object_number":$(context).parent().attr("data-object-number")
            };

            if ($(context).prop("checked")==true){
                this.changeObject(target_obj, {status:1});
            } else {
                this.changeObject(target_obj, {status:0});
            }*/
            var target_obj = $(context).parent().attr("data-target"),
                sub_routing = this.getSubROUTING(target_obj);

            if ($(context).prop("checked")==true){
                sub_routing.status = 1;
            } else {
                sub_routing.status = 0;
            }
            console.log(sub_routing);
            console.log(this.getSubROUTING(target_obj));
        },

        /**
        * @param target_obj {Object} same as removeObject above
        * @param change {Object} Changes, like {"status":"0"}
        */
        changeObject: function(target_obj, change){
            
            var finish_obj = {};
            if (target_obj.target == "path"){
                // finding object for changing
                if (target_obj.object_type=="landing"){
                    finish_obj = this.ROUTING.paths[target_obj.target_number-1].landings[target_obj.object_number-1];
                } else if (target_obj.object_type=="offer") {
                    finish_obj = this.ROUTING.paths[target_obj.target_number-1].offers[target_obj.object_number-1];
                }
                    // Change all parameter in change on ROUTING subobject
                    for (var prop in change){

                        if (change.hasOwnProperty(prop)){
                            finish_obj[prop] = change[prop];
                        }
                    }
                
                this.ROUTING.paths[target_obj.target_number-1].offers[target_obj.object_number-1];
                
            } else if (target_obj.target == "rule"){

            }

        },

        /**
        * Func return count of objects in target. 
        * For example, offers in path, landing in rule, paths in rule
        * 
        * @param target {string} Where to look? (path, rule)
        * @param target_id {string/number} Where concrete to count? (path-id)
        * @param object_type {string} What to count? (offer, landing)
        */
        getCountOfObjects: function(target, target_number, object_type){
            // TODO сделать если не указаны второй и третий агумент 
            // то выдавать количество путей или правил
            if (target=="path"){
                for (var i=0;i<this.ROUTING.paths.length;i++){
                   if (object_type=="landing"){
                       return this.ROUTING.paths[target_number-1].landings.length;
                   } else if (object_type == "offer"){
                       return this.ROUTING.paths[target_number-1].offers.length;
                   }
                }
            } else if(target=="rule"){
            }
        },


        addNewLander: function(){
        },

        /**
        * @param args {Object} Object with params
        *       target path/rule/rule-path reuqired
        *       target_number number of path or rule (if path-rule then number of rule all the same) required 
        *       target_path_rule number path in rule optional
        *       object_type
        *       object_number
        */
        makeTargetJSONLink: function(args){
            var target_object, t,tn, tpr, ot, on;
            // set landing
            var target_map = {
                "path":"p",
                "rule":"r",
                "rule-path":"pr"},
                object_type_map = {
                    "landing":"l",
                    "offer":"o",
                    "path":"p",
                    "rule" : "r",
                    "criterion" : "c"
                };

            var target_obj = {
                "t" : target_map[args.target],
                "tn" : args.target_number,
                "tpr" : args.target_path_rule,
                "ot" : object_type_map[args.object_type],
                "on" : args.object_number
            }
            return JSON.stringify(target_obj);
        },
        /**
        * When you click for any action u need to know,
        *   how u can get the current part of ROUTING object.
        *   This function make it real.
        * @param args {Object} Object with arguments
        *       aim {string} div/weight/actions/
        *       context {DOMElement} This stuff that is "this" passed in handler
        * @return {Object} target_obj
        */
        getTargetObject: function(args){
            
        },

        /**
        * @param target_link {string} link from data-target, but can be object
        */
        getSubROUTING: function(target_link){
            var temp;
            // getHighSubRouting
            if (target_link.t=="p"){
                temp = this.ROUTING.paths;
            } else if (target_link.t=="r"){
                temp = this.ROUTING.rules;
            } else if (target_link.t=="pr"){
                temp = this.ROUTING.rules[target_link.tpr];
            }

            if (target_link.ot != undefined){
                return temp;
            }
            // НЕ РАБОТАЕТ
            if (target_link.ot=="l"){
                temp = temp.landings;
            } else if (target_link.ot=="o"){
                temp = temp.offers;
            }
            if (target_link.on != undefined){
                return temp[target_link.on]
            } else {
                return temp;
            }
            // getLowSubRouting
        },

        addOffer: function(){},
        addDirectOffer: function(){},
        addCampaign: function(){},
        addNewOffer: function(){},


        addPathToROUTING: function(){},
        addRuleToROUTING: function(){},
        /**
        * adding Lander to ROUTING object
        * @param target {string} may be "path" or "rule"
        * @param targer_id {number} id of path or rule
        * @param landing_object 
        */
        addLandingToROUTING: function(target, target_number, landing_object){
            if (target=="path"){
                this.ROUTING.paths[target_number-1].landings.push(landing_object);
                return true;
            } else {
                // TODO Добавление лендинга для путей
            }
        },
        addOfferToROUTING: function(){},

        removePathFromROUTUNG: function(){},
        removeRuleFromROUTING: function(){},
        removeLandingFromRouting: function(){},
        removeOfferFromRouting: function(){},


    }
}();

/*Init Drawing*/
routingObject.initDrawing();
