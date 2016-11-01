var current_action_name = $("#current_action_name").val();
var current_controller_name = $("#current_controller_name").val();

//jquery 初始化函数
$(function(){

    //datatable初始化
    data_table_init();

});

function data_table_init(){

    //新增和修改时初始化
    if (current_action_name!='index') return;

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


    $('#search-scope #beginTime').datetimepicker({
        sideBySide: true,
        locale: "zh-cn",
        format: "YYYY-MM-DD HH:mm:ss"
    });

    $('#search-scope #endTime').datetimepicker({
        sideBySide: true,
        locale: "zh-cn",
        format: "YYYY-MM-DD HH:mm:ss"
    });

    //表格选中事件监听
    $('#search-scope #search').click(function(){
        do_search();
    });


    $('#'+current_controller_name+"_datatable").DataTable({
        /**
         sScrollY: "200px",//enable vertical scrolling
         sScrollX: "100%",
         sScrollXInner: "120%",//enable horizintal scrolling with its content 120% of its container
         bScrollCollapse: true,
         */
        pageLength: 25,
        bProcessing: true,
        bServerSide: true,
        stateSave: true,
        sAjaxSource: $('#'+current_controller_name+"_datatable").data('source'),
        language: datatable_language,
        "order": [[5,'desc' ]],
        "columnDefs": [
            { "orderable": false, "targets": 0 },
            { "orderable": false, "targets": 7 }
        ]
    });

}

function do_search(){

    var shopname = $("#search-scope #shopname").val();
    var name = $("#search-scope #name").val();
    var mobile = $("#search-scope #mobile").val();
    var status = $("#search-scope #status").val();

    var beginTime = $("#search-scope #beginTime").val();
    var endTime = $("#search-scope #endTime").val();

    var request_url = $('#'+current_controller_name+"_datatable").data('source')+"&shopname="+shopname+"&name="+name+"&mobile="+mobile+"&status="+status+"&beginTime="+beginTime+"&endTime="+endTime;
    $('#'+current_controller_name+"_datatable").DataTable().ajax.url(request_url).load()
}

//启用单位
function jyd_check (userinfo_id){
    $.ajax({
        type: "POST",
        url: "/userinfos/jyd_check/"+userinfo_id,
        dataType: "json",
        success: function (data) {

            if (data['flag'] == 1){
                window.location.href = get_location_href_no_search() + "?f=" + get_rand_num();
            }

        }
    });
}

//停用单位
function jyd_check_out (userinfo_id){
    $.ajax({
        type: "POST",
        url: "/userinfos/jyd_check_out/"+userinfo_id,
        dataType: "json",
        success: function (data) {

            if (data['flag'] == 1){
                window.location.href = get_location_href_no_search() + "?f=" + get_rand_num();
            }

        }
    });
}
