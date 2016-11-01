$(function () {

    $.ajax({
        type: "POST",
        url: "/jyd_holiday_coupons/get_weixin_signa",
        data: {url: location.href.split('#')[0]},
        dataType: "json",
        success: function (data) {
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: 'wx5950970145118999', // 必填，公众号的唯一标识
                timestamp: data.timestamp, // 必填，生成签名的时间戳
                nonceStr: data.timestamp, // 必填，生成签名的随机串
                signature: data.signa,// 必填，签名，见附录1
                jsApiList: ['onMenuShareAppMessage', 'onMenuShareTimeline', 'onMenuShareQQ', 'onMenuShareQZone'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            wx.ready(function () {
                //获取“分享给朋友”按钮点击状态及自定义分享内容接口
                wx.onMenuShareAppMessage({
                    title: "我有6.3个亿，送你中秋红包又咋滴，谁让我心里只有你!", // 分享标题
                    desc: "中秋佳节，挠破脑袋也想不出送啥礼。既要高大上，又要创新，还要价格满意，呃，酒运达6亿红包解决问题。神马神马？这种天上掉馅饼的事情可是得碰的呦！团圆美酒即刻送达！", // 分享描述
                    link: location.href.split('#')[0], // 分享链接
                    imgUrl: "http://" + location.host + "/images/jyd_holiday_coupon_index/huodong.jpg", // 分享图标
                    type: "link",// 分享类型,music、video或link，不填默认为link
                    success: function () {
                        // 用户确认分享后执行的回调函数
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                    }
                });

                //获取“分享到朋友圈”按钮点击状态及自定义分享内容接口
                wx.onMenuShareTimeline({
                    title: "我有6.3个亿，送你中秋红包又咋滴，谁让我心里只有你!", // 分享标题
                    link: location.href.split('#')[0], // 分享链接
                    imgUrl: "http://" + location.host + "/images/jyd_holiday_coupon_index/huodong.jpg", // 分享图标
                    success: function () {
                        // 用户确认分享后执行的回调函数
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                    }
                });

                //获取“分享到QQ”按钮点击状态及自定义分享内容接口
                wx.onMenuShareQQ({
                    title: "我有6.3个亿，送你中秋红包又咋滴，谁让我心里只有你!", // 分享标题
                    desc: "中秋佳节，挠破脑袋也想不出送啥礼。既要高大上，又要创新，还要价格满意，呃，酒运达6亿红包解决问题。神马神马？这种天上掉馅饼的事情可是得碰的呦！团圆美酒即刻送达！", // 分享描述
                    link: location.href.split('#')[0], // 分享链接
                    imgUrl: "http://" + location.host + "/images/jyd_holiday_coupon_index/huodong.jpg", // 分享图标
                    success: function () {
                        // 用户确认分享后执行的回调函数
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                    }
                });

                //获取“分享到QQ空间”按钮点击状态及自定义分享内容接口
                wx.onMenuShareQZone({
                    title: "我有6.3个亿，送你中秋红包又咋滴，谁让我心里只有你!", // 分享标题
                    desc: "中秋佳节，挠破脑袋也想不出送啥礼。既要高大上，又要创新，还要价格满意，呃，酒运达6亿红包解决问题。神马神马？这种天上掉馅饼的事情可是得碰的呦！团圆美酒即刻送达！", // 分享描述
                    link: location.href.split('#')[0], // 分享链接
                    imgUrl: "http://" + location.host + "/images/jyd_holiday_coupon_index/huodong.jpg", // 分享图标
                    success: function () {
                        // 用户确认分享后执行的回调函数
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                    }
                });

            });
        }
    });
});








