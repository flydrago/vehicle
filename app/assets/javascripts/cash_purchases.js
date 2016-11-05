//jquery 初始化函数
var cash_purchase_datatable = null;
$(document).ready(function () {
    //设置时间监听机制
    $('#cash_purchase_scheduledmaintenance').datetimepicker({
        sideBySide: true,
        locale: "zh-cn",
        format: "YYYY-MM-DD"
    });
    $('#cash_purchase_buyingtime').datetimepicker({
        sideBySide: true,
        locale: "zh-cn",
        format: "YYYY-MM-DD"
    });

    //初始化表格
    cash_purchase_datatable = $('#cash_purchase_datatable').DataTable({
        pageLength: 25,
        bProcessing: true,
        bServerSide: true,
        stateSave: true,
        searching: false,
        sAjaxSource: $('#cash_purchase_datatable').data('source'),
        language: datatable_language,
        "order": [[0,'desc' ]],
        "columnDefs": [
            {"orderable": false, "targets": 11}
        ], fnInitComplete: function (oSettings, json) {
        }
    });
});