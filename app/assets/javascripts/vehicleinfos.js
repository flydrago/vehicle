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
        "order": [[6, 'desc']],
        "columnDefs": [
            {"orderable": false, "targets": 0},
            {"orderable": false, "targets": 1},
            {"orderable": false, "targets": 2},
            {"orderable": false, "targets": 3},
            {"orderable": false, "targets": 4},
            {"orderable": false, "targets": 5},
            {"orderable": false, "targets": 7}
        ]
    });
})


function search() {
    var vehicle_brand = $("#search-scope #vehicle_brand").val();
    var vehicle_name = $("#search-scope #vehicle_name").val();
    var vehicle_model = $("#search-scope #vehicle_model").val();
    var vehicle_style = $("#search-scope #vehicle_style").val();
    var request_url = $('#vihicle_infos_table').data('source')+"?vehicle_brand="+vehicle_brand+"&vehicle_name="+vehicle_name+"&vehicle_model="+vehicle_model+"&vehicle_style="+vehicle_style;
    vihicle_infos_DataTable.ajax.url(request_url).load()
}


