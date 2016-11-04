var current_action_name = $("#current_action_name").val();
var current_controller_name = $("#current_controller_name").val();

//jquery 初始化函数
$(function(){

    //datatable初始化
    data_table_init();

});

function data_table_init(){

    //键盘enter事件
    document.onkeydown=function(event){
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==27){ // 按 Esc
            //要做的事情
        }
        if(e && e.keyCode==113){ // 按 F2
            //要做的事情
        }
        if(e && e.keyCode==13){ // enter 键
            do_search();
        }
    };

    //表格选中事件监听
    $('#search-scope #search').click(function(){
        search();
    });

    $('#birthday').datetimepicker({
        sideBySide: true,
        locale: "zh-cn",
        format: "YYYY-MM-DD"
    });


    $('#'+current_controller_name+"_datatable").DataTable({
        pageLength: 25,
        bProcessing: true,
        bServerSide: true,
        stateSave: true,
        sAjaxSource: $('#'+current_controller_name+"_datatable").data('source'),
        language: datatable_language,
    });

}

function search(){
    var mobile = $("#search-scope #mobile").val();
    var request_url = $('#'+current_controller_name+"_datatable").data('source')+"?mobile="+mobile;
    $('#'+current_controller_name+"_datatable").DataTable().ajax.url(request_url).load()
}

