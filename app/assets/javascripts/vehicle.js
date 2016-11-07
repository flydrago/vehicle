//获取location的href 包括hash 并且去除?后面的条件
function get_location_href_no_search() {
    var l_hash = location.hash;
    if (l_hash.indexOf("?") != -1) {
        l_hash = l_hash.substring(0, l_hash.indexOf("?"));
    }
    return "http://" + location.host + "/" + l_hash;
}


//获取随机数
function get_rand_num() {
    return Math.floor(Math.random() * 1000);
}

//分页添加ajax
function pagination_ajax() {

    $(".pagination a").each(function () {

        var href = $(this).attr('href');
        if (undefined != href && null != href) {
            $(this).attr('data-href', href);
            $(this).attr('data-url', href);
            $(this).attr('href', "#" + href);
        }
    });
}


//是否存在指定函数
function isExitsFunction(funcName) {
    try {
        if (typeof(eval(funcName)) == "function") {
            return true;
        }
    } catch (e) {
    }
    return false;
}
//是否存在指定变量
function isExitsVariable(variableName) {
    try {
        if (typeof(variableName) == "undefined") {
            //alert("value is undefined");
            return false;
        } else {
            //alert("value is true");
            return true;
        }
    } catch (e) {
    }
    return false;
}

//表单ajax提交处理，处理错误信息提示以及成功后页面跳转 适用于（data-remote=true）
function common_form_ajax_deal(success_call_back) {

    $("form[data-remote='true']").on('ajax:success', function (event, xhr, status, error) {

        console.log("返回信息为：" + JSON.stringify(xhr));
        var model = xhr.model

        //重置样式和提示信息
        $("#error_explanation ul").html("");
        $(".field_with_errors").each(function () {
            var model_name = $(this).attr('_model')
            console.log(model_name)
            $("#" + model_name).unwrap();
        });

        //{flag:标识（1成功、0失败），model:模型，msg:信息提示，error_attrs:对象错误的属性值，path：要跳转的路径}
        if (xhr.flag == 1) {

            if (typeof(success_call_back) == "function") {
                success_call_back(xhr);
            } else {
                $("#error_explanation").hide();
                eval(xhr.path);
            }
            //$("#error_explanation").hide();
            //eval(xhr.path);
        } else {

            //错误信息
            $(xhr.msg).each(function (m, v) {
                $("#error_explanation ul").append("<li>" + v + "</li>");
            });
            $("#error_explanation").show();

            //样式添加
            $(xhr.error_attrs).each(function (m, v) {
                $("#" + model + "_" + v).wrap("<div class='field_with_errors' _model='" + model + "_" + v + "'></div>");
            });
        }
    });
}

function jyd_form_validate(response_data) {

    var error_msgs = response_data.error_msgs;
    var error_attrs = response_data.error_attrs;
    var redirect_path = response_data.redirect_path;
    var model = response_data.model;

    //重置样式和提示信息
    $("#error_explanation ul").html("");
    $(".field_with_errors").each(function () {
        var model_name = $(this).attr('_model')
        console.log(model_name)
        $("#" + model_name).unwrap();
    });


    //错误时，进行提示
    if (error_msgs.length > 0) {
        console.log("执行信息为：" + JSON.stringify(error_msgs));
        //错误信息
        $(error_msgs).each(function (m, v) {
            console.log("v:" + v);
            $("#error_explanation ul").append("<li>" + v + "</li>");
        });
        $("#error_explanation").show();

        //样式添加
        $(error_attrs).each(function (m, v) {
            console.log("model:" + model + ",v:" + v);
            $("#" + model + "_" + v).wrap("<div class='field_with_errors' _model='" + model + "_" + v + "'></div>");
        });
    } else {//无错误时，进行跳转
        eval(redirect_path);
    }
}


//异步加载百度地图
function loadBaiduJScript() {

    console.log("异步加载地图js");
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src = "http://api.map.baidu.com/api?v=2.0&ak=DhPM8pha2qqNaHNZRZGpNaNf&callback=baiduMapInit";
    document.body.appendChild(script);
}


var datatable_language = {
    "sProcessing": "处理中...",
    "sLengthMenu": "显示 _MENU_ 项结果",
    "sZeroRecords": "没有匹配结果",
    "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
    "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
    "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
    "sInfoPostFix": "",
    "sSearch": "搜索:",
    "sUrl": "",
    "sEmptyTable": "表中数据为空",
    "sLoadingRecords": "载入中...",
    "sInfoThousands": ",",
    "oPaginate": {
        "sFirst": "首页",
        "sPrevious": "上页",
        "sNext": "下页",
        "sLast": "末页"
    },
    "oAria": {
        "sSortAscending": ": 以升序排列此列",
        "sSortDescending": ": 以降序排列此列"
    }
}


//客户信息选择模态框初始化
function consumer_info_select_modal_init(modal_but_id, callback) {

    var table_id = "consumer_info_select_table";

    console.log("初始化1");
    $("#" + table_id).DataTable({
        /**
         sScrollY: "200px",//enable vertical scrolling
         sScrollX: "100%",
         sScrollXInner: "120%",//enable horizintal scrolling with its content 120% of its container
         bScrollCollapse: true,
         */
        pageLength: 5,
        bProcessing: true,
        bServerSide: true,
        stateSave: true,
        sAjaxSource: $("#" + table_id).data('source'),
        language: datatable_language,
        "order": [[3, 'asc']],
        "columns": [
            {"data": "name"},
            {"data": "mobile"},
            {"data": "identity_card"},
            {"data": "birthday"}
        ],
        "columnDefs": [
            {"orderable": false, "targets": 0},
            {"orderable": false, "targets": 1},
            {"orderable": false, "targets": 2}
        ]
    });

    $("#" + table_id + " tbody").on('click', 'tr', function () {
        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
        }
        else {
            $("#" + table_id).DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    //初始化
    $("#" + table_id + "_modal").modal({show: false});

    //表格选中事件监听
    $('#' + modal_but_id).click(function () {
        $("#" + table_id + "_modal").modal('show');
    });

    $("#" + table_id + "_callback").click(function () {
        data = $("#" + table_id).DataTable().row('.selected').data();
        if (typeof(callback) == "function" && typeof(data)=="object") {
            callback(data);
            $("#" + table_id + "_modal").modal('hide');
        }else{
            lark_alert("请选择客户信息！");
        }
    });
}



//车辆信息选择模态框初始化
function vehicleinfo_select_modal_init(modal_but_id, callback) {

    var table_id = "vehicleinfo_select_table";

    console.log("初始化1");
    $("#" + table_id).DataTable({
        /**
         sScrollY: "200px",//enable vertical scrolling
         sScrollX: "100%",
         sScrollXInner: "120%",//enable horizintal scrolling with its content 120% of its container
         bScrollCollapse: true,
         */
        pageLength: 5,
        bProcessing: true,
        bServerSide: true,
        stateSave: true,
        sAjaxSource: $("#" + table_id).data('source'),
        language: datatable_language,
        "order": [[3, 'asc']],
        "columns": [
            {"data": "vehicle_brand"},
            {"data": "vehicle_name"},
            {"data": "vehicle_model"},
            {"data": "vehicle_engine_number"},
            {"data": "vehicle_color"},
            {"data": "vehicle_style"}
        ],
        "columnDefs": [
            {"orderable": false, "targets": 1},
            {"orderable": false, "targets": 2},
            {"orderable": false, "targets": 3},
            {"orderable": false, "targets": 4},
            {"orderable": false, "targets": 5}
        ]
    });

    $("#" + table_id + " tbody").on('click', 'tr', function () {
        if ($(this).hasClass('selected')) {
            $(this).removeClass('selected');
        }
        else {
            $("#" + table_id).DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    //初始化
    $("#" + table_id + "_modal").modal({show: false});

    //表格选中事件监听
    $('#' + modal_but_id).click(function () {
        $("#" + table_id + "_modal").modal('show');
    });

    $("#" + table_id + "_callback").click(function () {
        data = $("#" + table_id).DataTable().row('.selected').data();
        if (typeof(callback) == "function" && typeof(data)=="object") {
            callback(data);
            $("#" + table_id + "_modal").modal('hide');
        }else{
            lark_alert("请选择车辆信息！");
        }
    });
}



//是否为正整数
function isPositiveNum(s) {
    var re = /^[0-9]*[1-9][0-9]*$/;
    return re.test(s)
}


//公用confirm
var lark_confirm = function (msg, func) {
    bootbox.confirm({
        message: "<span class='bigger-110 text-center'>" + msg + "</span>", buttons: {
            confirm: {
                label: '确认',
                className: 'btn btn-sm btn-success'
            },
            cancel: {
                label: '取消',
                className: 'btn btn-sm btn-default'
            }
        }, title: '温馨提示 <i class="ace-icon fa fa-lightbulb-o"></i>', callback: function (result) {
            if (result) {
                func();
            }
        }
    });
}

//公用alert
var lark_alert = function (message) {
    bootbox.dialog({
        message: "<span class='bigger-110 text-center'>" + message + "</span>",
        title: '温馨提示 <i class="ace-icon fa fa-lightbulb-o"></i>',
        buttons: {
            "success": {
                "label": "<i class='ace-icon fa fa-check'></i> 确定 ",
                "className": "btn-sm btn-success",
                "callback": function () {
                    //Example.show("great success");
                }
            }
        }
    });
}
