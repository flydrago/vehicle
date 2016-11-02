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
        do_search();
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
        //上传图片预览

    $("#consumer_info_picture").change(function(){
        var objUrl = getObjectURL(this.files[0]) ;
        if (objUrl) {
            $("#picture").attr("src", objUrl) ;
        }
    }) ;
    //建立一個可存取到該file的url
    function getObjectURL(file) {
        var url = null ;
        if (window.createObjectURL!=undefined) { // basic
            url = window.createObjectURL(file) ;
        } else if (window.URL!=undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file) ;
        } else if (window.webkitURL!=undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file) ;
        }
        return url ;
    }


//function do_search(){
//
//    var shopname = $("#search-scope #shopname").val();
//    var name = $("#search-scope #name").val();
//    var mobile = $("#search-scope #mobile").val();
//    var status = $("#search-scope #status").val();
//
//    var beginTime = $("#search-scope #beginTime").val();
//    var endTime = $("#search-scope #endTime").val();
//
//    var request_url = $('#'+current_controller_name+"_datatable").data('source')+"&shopname="+shopname+"&name="+name+"&mobile="+mobile+"&status="+status+"&beginTime="+beginTime+"&endTime="+endTime;
//    $('#'+current_controller_name+"_datatable").DataTable().ajax.url(request_url).load()
//}
//
