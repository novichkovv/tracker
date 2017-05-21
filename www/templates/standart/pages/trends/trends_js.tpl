//Установка значений массива настроек количества знаков после запятой
window.trends_show_profit = !Boolean(parseInt(<?php echo $arr_tpl['show_profit'] ?>));

//GLOBAL
var __pageFormat = "trends",
    __pageType   = "trends";

function getURLParameter(name) {
	return decodeURI(
		(RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1] || ''
	);
}

$(document).ready(function() {
	
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

    formattingSettingsStorage["lp_ctr"]=' <?php echo $arr_tpl["round_settings"]->result['lp_ctr']['val'] ?>';
    formattingSettingsStorage["cr"]=' <?php echo $arr_tpl["round_settings"]->result['cr']['val'] ?>';
    formattingSettingsStorage["epc"]=' <?php echo $arr_tpl["round_settings"]->result['epc']['val'] ?>';
    formattingSettingsStorage["cpc"]=' <?php echo $arr_tpl["round_settings"]->result['cpc']['val'] ?>';
    formattingSettingsStorage["revenue"]=' <?php echo $arr_tpl["round_settings"]->result['revenue']['val'] ?>';
    formattingSettingsStorage["cost"]=' <?php echo $arr_tpl["round_settings"]->result['cost']['val'] ?>';
    formattingSettingsStorage["profit"]=' <?php echo $arr_tpl["round_settings"]->result['profit']['val'] ?>';
    formattingSettingsStorage["roi"]=' <?php echo $arr_tpl["round_settings"]->result['roi']['val'] ?>';
    drawFooterSum(calcSumSearch());

    if(getURLParameter("chart")=='true'){
        trendsGraph.open();
    }

});
window.trendsChart = new Object;


$(window).resize(function(){ 
    header_correlation();
});
//УБРАТЬ
$(window).ready(function(){
    
    /*trendsGraph.parseTableToGetData();*/
    /*trendsGraph.init();*/
    
});


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

//Trends graph
trendsGraph = {
    //Dumb for c3-chart object
    chart : new Object, 

    //Data of table
    data: new Array,

    graph_open: null,

    open: function(){
        if (this.graph_open === null){
            this.init();
            this.graph_open = true;
			$("#chart_show").detach();
			$("#act-form").append('<input type="hidden" name="chart" value="true" id="chart_show">');
        } else if (this.graph_open === true) {
            $(".graph-wrapper").css("display", "none");
			
			$("#chart_show").detach();
			$("#act-form").append('<input type="hidden" name="chart" value="false" id="chart_show">');
			
            //For table height auto sizing
            $(window).trigger("resize");
            this.graph_open = false;
        } else if (this.graph_open === false){
            $(".graph-wrapper").css("display", "block");
			
			$("#chart_show").detach();
			$("#act-form").append('<input type="hidden" name="chart" value="true" id="chart_show">');

            //For table height auto sizing
            $(window).trigger("resize");
            this.graph_open = true;
        }
    },

    init: function(){
        
        var graphic_block = "<div class='graph-wrapper stat-container' style='margin-top:0px;margin-bottom: 10px'>\
                                <div id='graph-block' style='height:450px;'></div>\
                            </div>";
        $(".stat-container").toggleClass("constriction-transition");
        //$(".trends-stats-table").addClass("narrow_table");
        //$(".trends-stats-table .body-container").addClass("narrow_table_body_container");
        $(".top_block").after(graphic_block);
        //$(".top_block").append("<div style='height:300px'></div>");
        trendsGraph.parseTableToGetData();
        this.bindGraph();
        $(window).trigger("resize");
        

    },

    getDataColumnsConfig: function(){

        var columns = [
                        ['x'].concat(this.data['x'].reverse()),
                        ['Clicks'].concat(this.data['1'].reverse()),
                        ['Cost'].concat(this.data['2'].reverse())
                      ];
        if (window.trends_show_profit){
            columns.push(
                ['Profit'].concat(this.data['4'].reverse()),
                ['Revenue'].concat(this.data['3'].reverse()),
                ['Leads'].concat(this.data['5'].reverse())
                );
        }

        


        return columns;

    },

    bindGraph : function() {
        this.chart = c3.generate({
            bindto: '#graph-block',
            data: {
              x : 'x',
              columns: this.getDataColumnsConfig(),
              type: 'spline',
              //reference between chart and y (left or right)
              axes: {
                x: 'y',
                Clicks: 'y2',
                Revenue: 'y',
                Cost: 'y',
                Profit: 'y',
                Leads: 'y2'
              },
              //Hide charts by deault
              hide: ['Revenue', 'Cost', 'Leads'],
              types:{
                Profit: 'bar'
              },
              colors: {
                'Clicks' : "#039BE5",
                'Profit': "#66BB6A",
                'Revenue': "#689F38",
                'Cost':"#D32F2F",
                'Leads':'#7B1FA2'
              }
            },
            axis: {
              x: {
                type: 'category', // ADD
                tick: {
                    culling:{
                        max: 20
                    },
                    rotate: 0,
                    multiline: false
                },
              },
              y:{
                label: {
                    text:'$$$',
                    position: 'middle'
                },
                tick: {
                    format: d3.format("$,")
                }
              },
              y2: {
                show: true,
                label: {
                    text:'Volume',
                    position: 'middle'
                },
                tick: {
                    format: function (d) { if (d>10000) { return d/1000+"K"} else {return d;} }
                }
              },

            },
            grid:{

                y:{
                    show: true,
                    lines: [
                         {value: 0, text: '0 volume', axis: 'y2', position: 'start'},
                         {value: 0, text: '0$', axis: 'y', position: 'start'},
                    ],
                   
                },
                 y2: {
                        show:true
                    }


            }
        });

        //Make circles invisible where amount of line is more than number
        if (this.data['1'].length>50) {
            //$("circle.c3-circle:not(_expanded_)").css("r","0");

            var stylesheet = document.styleSheets[0],
            selector1 = "circle.c3-circle:not(_expanded_)", rule1 = "{r:0}",
            selector2 = "circle.c3-circle._expanded_", rule2 = "{r:3.5}";

            if (stylesheet.insertRule) {
                stylesheet.insertRule(selector1 + rule1, stylesheet.cssRules.length);
                stylesheet.insertRule(selector2 + rule2, stylesheet.cssRules.length);
            } else if (stylesheet.addRule){
                stylesheet.addRule(selector1, rule1, -1);
                stylesheet.addRule(selector2, rule2, -1);
            }
        }

    },

    randomValue: function(min, max){

        return Math.floor(Math.random() * (max - min)) + min;

        },
    parseTableToGetData: function(){
        var rows = $(".stat-container .body-container tr"),
        rows_objects=[],
        row_object,
        timer = new Date();
        /*
            x - date
            1 - Clicks
            2 - Cost
            3 - Revenue
            4 - Profit
            5 - Leads

        */

        var week_reg=/\d{4}-(\d{2}-\d{2}) - \d{4}-(\d{2}-\d{2})/g,
            week_str, result, is_week; 

        if (rows.size()>0){
            week_str = week_reg.exec(rows.eq(0).find(".name_camp span").html());
            if (week_str !== null && week_str.length==3){
                is_week = true;
            } else {
                is_week = false;
            }
        }

        for (var i=0; i<rows.size(); i++){
            row_object = {};
            if (is_week){
                row_object['x'] = rows.eq(i).find(".name_camp span").html().replace(week_reg, "$1 - $2");
            } else {
                row_object['x'] = rows.eq(i).find(".name_camp span").html();
            }
            row_object['1'] = parseInt(rows.eq(i).find(".clicks_td").html().replace(/,/g, "").trim());
            row_object['2'] = parseInt(rows.eq(i).find(".cost_td").html().replace(/[,$]/g, "").trim());
            if (window.trends_show_profit){
                row_object['3'] = parseInt(rows.eq(i).find(".revenue_td").html().replace(/[,$]/g, "").trim());
                row_object['4'] = parseInt(rows.eq(i).find(".profit_td").html().replace(/[,$]/g, "").trim());
                row_object['5'] = parseInt(rows.eq(i).find(".leads_td").html().replace(/[,]/g, "").trim());
            }
             rows_objects.push(row_object);
        }
       
        //Sorting by date
       /* rows_objects.sort(function(a,b){
            x1 = new Date(a["x"]);
            x2 = new Date (b["x"]);
            return x1 - x2;
        });*/

        this.data['x'] = [];
        this.data['1'] = [];
        this.data['2'] = [];

        if (window.trends_show_profit){
            this.data['3'] = [];
            this.data['4'] = [];
            this.data['5'] = [];
        }

        for (var i=0; i<rows_objects.length; i++){
            this.data['x'].push(rows_objects[i]["x"]);
            this.data['1'].push(rows_objects[i]["1"]);
            this.data['2'].push(rows_objects[i]["2"]);

            if (window.trends_show_profit){
                this.data['3'].push(rows_objects[i]["3"]);
                this.data['4'].push(rows_objects[i]["4"]);
                this.data['5'].push(rows_objects[i]["5"]);
            }
            
        }
    }

}
