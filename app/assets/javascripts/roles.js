var roles_DataTable;
//jquery 初始化函数
$(function () {
    //键盘enter事件
    document.onkeydown = function (event) {
        var e = event || window.event || arguments.callee.caller.arguments[0];
        if (e && e.keyCode == 27) { // 按 Esc
            //要做的事情
        }
        if (e && e.keyCode == 113) { // 按 F2
            //要做的事情
        }
        if (e && e.keyCode == 13) { // enter 键
            search();
        }
    };

    pagination_ajax();
    common_form_ajax_deal();

    roles_DataTable = $('#roles_table').DataTable({
        /**
         sScrollY: "200px",//enable vertical scrolling
         sScrollX: "100%",
         sScrollXInner: "120%",//enable horizintal scrolling with its content 120% of its container
         bScrollCollapse: true,
         */
        pageLength: 10,
        bProcessing: true,
        bServerSide: true,
        stateSave: true,
        sAjaxSource: $('#roles_table').data('source'),
        language: datatable_language,
        "order": [[4, 'desc']],
        "columnDefs": [
            {"orderable": false, "targets": 0},
            {"orderable": false, "targets": 1},
            {"orderable": false, "targets": 2},
            {"orderable": false, "targets": 5}
        ]
    })

    $("#search-scope #search").click(function(){
        search();
    });

});

// 查询用户搜索
function search() {
    var name_title = $("#search-scope #name_title").val();
    var role_mark = $("#search-scope #role_mark").val();
    var request_url = $('#roles_table').data('source')+"?name_title="+name_title+"&role_mark="+role_mark;
    roles_DataTable.ajax.url(request_url).load()
}

//保存验证
function role_save_check(){
    var role_name = $("#role_name").val();
    var role_name_title = $("#role_name_title").val();
    if (role_name==""){
        alert("请输入角色名称(English)");
        return false;
    }
    if (role_name_title==""){
        alert("请输入角色中文名称");
        return false;
    }

    return true;
}
