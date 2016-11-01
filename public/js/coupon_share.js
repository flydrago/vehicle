function register_user() {

    var mobile = document.getElementById("mobile").value;
    var userinfo_id = document.getElementById("userinfo_id").value;
    var order_id = document.getElementById("order_id").value;

    var pattern = /^1[34578]\d{9}$/;
    if (!pattern.test(mobile)) {
        alert("请输入正确的手机号码！")
        return false;
    }
    ;
    $.ajax({
        type: "POST",
        url: "/jyd_coupons/coupon_register_user/register_user",
        data: {mobile: mobile, userinfo_id: userinfo_id, order_id: order_id},
        dataType: "json",
        success: function (data) {
            if (data.flag == 0) {
                window.location.href = "/jyd_coupons/order_share_coupon/share_index2"
                // $.ajax({
                //     type: "GET",
                //     url: "/jyd_coupons/order_share_coupon/share_index2",
                //     data: {},
                //     success: function (htmldata) {
                //         $(".posTop").empty();
                //         $(".bomTxt").empty();
                //         document.getElementById("posTop").innerHTML=htmldata;
                //     }
                // });
            } else if (data.flag == 2) {
                window.location.href = "/jyd_coupons/order_share_coupon/share_index3"
            } else {
                window.location.href = "/jyd_coupons/order_share_coupon/share_page?order_id=" + data.order_id + "&mobile=" + data.mobile
            }
        }
    });


}

// //定向优惠券跳转至填写电话号码
// function to_input_mobile(){
//     var jyd_coupon_activity_id = document.getElementById("jyd_coupon_activity_id").value;
//     window.location.href="/jyd_coupon_activities/"+jyd_coupon_activity_id+"/activity_jyd_coupon_index2"
// }

//定向优惠券,输入手机号领取优惠券
function input_mobile() {
    var mobile = document.getElementById("user_mobile").value;
    var jyd_coupon_activity_id = document.getElementById("jyd_coupon_activity_id").value;
    var pattern = /^1[34578]\d{9}$/;
    if (!pattern.test(mobile)) {
        alert("请输入正确的手机号码！")
        return false;
    }
    ;

    $.ajax({
        type: "POST",
        url: "/jyd_coupon_activities/input_mobile_get_coupons",
        data: {mobile: mobile, jyd_coupon_activity_id: jyd_coupon_activity_id},
        dataType: "json",
        success: function (data) {
            if (data.flag == 0) {//你已经领取过了
                window.location.href = "/jyd_coupon_activities/" + data.jyd_coupon_activity_id + "/activity_jyd_coupon_index3"

            } else if (data.flag == 2) {//来晚了,活动结束了
                window.location.href = "/jyd_coupon_activities/" + data.jyd_coupon_activity_id + "/activity_jyd_coupon_index4"
            } else {//正常领取
                window.location.href = "/jyd_coupon_activities/" + data.jyd_coupon_activity_id + "/activity_jyd_coupon_index2?mobile=" + data.mobile
            }
        }
    });

}

// //点击跳转到输入手机号码的页面
// function click_to_get_coupons(){
//     var jyd_coupon_activity_id = document.getElementById("jyd_coupon_activity_id").value;
//     window.location.href = "/jyd_coupon_activities/" + jyd_coupon_activity_id + "/activity_jyd_coupon_index2"
//
// }


function click_to_use() {
    var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1;
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    if (isAndroid) {
        window.location.href = 'jiuyunda://scan/';
    }
    if (isiOS) {
        window.location.href = 'com.jiuyunda.NewWineClient://';
    }
    window.setTimeout(function () {
        window.location.href = 'http://a.app.qq.com/o/simple.jsp?pkgname=com.h2y.android.shop.activity'
    }, 500);
}

// // 先去尝试打开APP,如果失败就去市场下载app
// function open_app(){
//     window.location.href = 'jiuyunda://scan/';
//     window.setTimeout(function () {
//         window.location.href = 'http://a.app.qq.com/o/simple.jsp?pkgname=com.h2y.android.shop.activity'
//     }, 500);
// }
