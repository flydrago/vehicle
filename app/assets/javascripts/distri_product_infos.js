var distri_product_info_DataTable ;
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

    distri_product_info_DataTable = $('#distri_product_info_table').DataTable({
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
        sAjaxSource: $('#distri_product_info_table').data('source'),
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
    // var distributor_name = $("#search-scope #distributor_name").val();
    // var contact_name = $("#search-scope #contact_name").val();
    // var phone_number = $("#search-scope #phone_number").val();
    // var distributor_address = $("#search-scope #distributor_address").val();
    // var request_url = $('#distributor_table').data('source')+"?distributor_name="+distributor_name+"&contact_name="+contact_name+"&phone_number="+phone_number+"&distributor_address="+distributor_address;
    // distri_product_info_DataTable.ajax.url(request_url).load()
}


