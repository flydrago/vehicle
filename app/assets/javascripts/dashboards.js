/**
 * Created by jyd-pc005 on 16/1/5.
 */
//jquery 初始化函数
$(function(){

    consumer_info_select_modal_init("consumer_infos_select_btn",function(data){
        console.log("回调信息为："+JSON.stringify(data));
        $("#consumer_infos_select_callback").html(JSON.stringify(data));
    });


    vehicleinfo_select_modal_init("vehicleinfo_select_btn",function(data){
        console.log("回调信息为："+JSON.stringify(data));
        $("#vehicleinfo_select_callback").html(JSON.stringify(data));
    });

});