var vihicle_infos_DataTable ;
//jquery 初始化函数
$(function () {
    $("#search-scope #search").click(function(){
        search();
    });

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

    vihicle_infos_DataTable = $('#vihicle_infos_table').DataTable({
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
        sAjaxSource: $('#vihicle_infos_table').data('source'),
        language: datatable_language,
        "order": [[4, 'desc']],
        "columnDefs": [
            {"orderable": false, "targets": 0},
            {"orderable": false, "targets": 1},
            {"orderable": false, "targets": 2},
            {"orderable": false, "targets": 3},
            {"orderable": false, "targets": 5}
        ]
    });
})



function search() {
    // var userinfo_shop_name = $("#search-scope #userinfo_shop_name").val();
    // var release_state = $("#search-scope #release_state").val();
    // var request_url = $('#single_map_applies_table').data('source')+"?userinfo_shop_name="+userinfo_shop_name+"&release_state="+release_state;
    // vihicle_infos_DataTable.ajax.url(request_url).load()
}


