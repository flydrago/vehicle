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

//节日活动优惠券,输入手机号领取优惠券
function holiday_input_mobile() {
    var mobile = document.getElementById("user_mobile").value;
    var jyd_holiday_coupon_id = document.getElementById("jyd_holiday_coupon_id").value;
    var pattern = /^1[34578]\d{9}$/;
    if (!pattern.test(mobile)) {
        alert("请输入正确的手机号码！")
        return false;
    };

    $.ajax({
        type: "POST",
        url: "/jyd_holiday_coupons/input_mobile_get_holiday_coupons",
        data: {mobile: mobile, jyd_holiday_coupon_id: jyd_holiday_coupon_id},
        dataType: "json",
        success: function (data) {
            if (data.flag == 0) {//你已经领取过了
                alert("您已经领取过优惠券!");
                window.location.href = "/jyd_holiday_coupons/" + data.jyd_holiday_coupon_id + "/jyd_holiday_coupon_index6?mobile=" + data.mobile

            } else if (data.flag == 2) {//来晚了,活动结束了
                alert("很遗憾,您来晚了,活动已结束!");
                // window.location.href = "/jyd_holiday_coupons/" + data.jyd_holiday_coupon_id + "/jyd_holiday_coupon_index7"

            } else {//正常领取
                window.location.href = "/jyd_holiday_coupons/" + data.jyd_holiday_coupon_id + "/jyd_holiday_coupon_index2?mobile=" + data.mobile
            }
        }
    });

}

//上传个人靓照校验
function check_upload_photo(){
    var self_photo  =  $("#previewImage").attr('src');
    if("/images/jyd_holiday_coupon_index3/tianjia.jpg" == self_photo){
        alert("亲,忘记上传靓照了,赶快上传靓照吧~");
        return false;
    }
}

//开始制作
function start_making(){
    var mobile = document.getElementById("mobile").value;
    var jyd_holiday_coupon_id = document.getElementById("jyd_holiday_coupon_id").value;
    window.location.href = "/jyd_holiday_coupons/" + jyd_holiday_coupon_id + "/jyd_holiday_coupon_index3?mobile=" + mobile

}

//点击使用优惠券
function click_use_holiday_coupon(){
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

//一键生成
// function start_key_generate(){
//     var mobile = document.getElementById("mobile").value;
//     var jyd_holiday_coupon_id = document.getElementById("jyd_holiday_coupon_id").value;
//     var self_photo = document.getElementById("file").value;
//
//     $.ajax({
//         type: "POST",
//         url: "/jyd_holiday_coupons/save_self_photo",
//         data: {mobile: mobile, jyd_holiday_coupon_id: jyd_holiday_coupon_id,self_photo: self_photo},
//         dataType: "json",
//         success: function (data) {
//             if (data.flag == 0) {//你已经领取过了
//                 alert("很遗憾,您已经领取过优惠券!");
//                 // window.location.href = "/jyd_holiday_coupons/" + data.jyd_holiday_coupon_id + "/jyd_holiday_coupon_index6"
//
//             } else if (data.flag == 2) {//来晚了,活动结束了
//                 window.location.href = "/jyd_holiday_coupons/" + data.jyd_holiday_coupon_id + "/jyd_holiday_coupon_index7"
//             } else {//正常领取
//                 window.location.href = "/jyd_holiday_coupons/" + data.jyd_holiday_coupon_id + "/jyd_holiday_coupon_index2?mobile=" + data.mobile
//             }
//         }
//     });
//
// }
