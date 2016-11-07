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
    //////
    consumer_info_select_modal_init("bag_product_select_btn",function(data){
        console.log("回调信息为："+JSON.stringify(data));
        $("#consumer_infos_select_callback").html(JSON.stringify(data));
    });
});


function add_select_product(id,data) {
    if ($("#"+id).val()!=""){
        lark_alert("请清除商品后再添加商品")
        return
    }
    add_shangpin_tr(data);
}
function add_shangpin_tr(data) {
    var trmodel = $("#bag_user_tr").clone();
    trmodel.find(".name").html(data.name);
    trmodel.find(".mobile").html(data.mobile);
    trmodel.find(".identity_card").html(data.identity_card);
    trmodel.find(".birthday").html(data.birthday);
    trmodel.find(".address").html(data.address);
    trmodel.find(".addtime").html(data.created_at);
    trmodel.find("a").click(function () {
        $(this).parent().parent().remove();
    });
    trmodel.removeAttr("id");
    trmodel.show();
    $("#bag_user_table tbody").append(trmodel);
    $("#consumer_id").val(data._id);
}
