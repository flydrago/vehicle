function initForm() {
    $("#old_password").val("");
    $("#new_password").val("");
    $("#confirm_password").val("");
};
var the_user_DataTable;

//jquery 初始化函数
$(function () {
    initForm();
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
    // common_form_ajax_deal();

    the_user_DataTable = $('#users_table').DataTable({
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
        sAjaxSource: $('#users_table').data('source'),
        language: datatable_language,
        "order": [[2, 'desc']],
        "columnDefs": [
            {"orderable": false, "targets": 0},
            {"orderable": false, "targets": 1},
            {"orderable": false, "targets": 3}
        ]
    })

    $("#search-scope #search").click(function(){
        search();
    });

});

//查询用户搜索
function search() {
    var mobile = $("#search-scope #mobile").val();
    var request_url = $('#users_table').data('source')+"?mobile="+mobile;
    the_user_DataTable.ajax.url(request_url).load()
}


//管理员用户>>重置密码
function reset_password(user_id) {
    var current_userid =  $("#current_user_id").val()
    $.get("/admin/users/" + user_id + "/reset_password", function (data, status) {
            if (data.flag == 1) {
                if(current_userid == user_id){
                    alert("当前登录账号,密码重置成功,确认后,请重新登录!")
                    window.location.href="/users/sign_in"
                }else{
                    alert("密码重置成功!")
                }
            } else {
                alert("密码重置失败!")
            }
        }
    );
}

//当前用户修改密码
function checkPwd(){
    var data = {old_password: $("#old_password").val(), new_password: $("#new_password").val()}
    if ($("#old_password").val() == "" || $("#old_password").val().length == 0) {
        alert("旧密码不能为空");
        return false;
    } else if ($("#new_password").val() == "" || $("#new_password").val().length == 0) {
        alert("新密码不能为空")
        return false;
    }else if ($("#confirm_password").val() == "" || $("#confirm_password").val().length == 0){
        alert("确认新密码不能为空")
        return false;
    }else if($("#new_password").val()!=$("#confirm_password").val()){
        alert("新密码和确认新密码,两次输入密码不同")
        return false;
    }else{
        $.post("/admin/users/modify_loginpassword",data,function(data,status){
            if(data.flag==1){
                alert(data.msg)
                window.location.href="/users/sign_in"

            }else{
                alert(data.msg)
                $("#old_password").val("");
                $("#new_password").val("");
                $("#confirm_password").val("");
            }
        });
        return;
    }

}

