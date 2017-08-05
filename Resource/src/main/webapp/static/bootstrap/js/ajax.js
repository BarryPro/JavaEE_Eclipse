/**
 * Created by belong on 2017/4/16.
 */
$(function () {
    $("#class_btn").click(function () {
        console.log("开始获取资源");
        $.ajax({
            url: "type",
            type: "post",
            dataType: "text",
            success: function (data) {
                $("#msg").empty();
                console.log("结束获取资源");
            }
        })
    });
    $("#subUrl_btn").click(function () {
        console.log("开始获取urls");
        $.ajax({
            url: "subUrls",
            type: "post",
            dataType: "text",
            success: function (data) {
                $("#msg").empty();
                console.log("结束获取urls");
            }
        })
    });

    // 设置区域
    setting_fun();
    for (var i = 0; i < 100; i++) {
        $("#txt").append("world!hello world!hello world!hello world!hello world!hello world!\n");
    }

    $("#menu-area").on('click', 'span', function () {
        var span_id = $(this).attr('id');
        $.ajax({
            url: '../80sHome/page',
            data: 'id=' + span_id,
            type: 'post',
            dataType: 'json',
            success: function (data) {
                // 电影信息都在data.data中video就是具体的电影信息
                $(".display-setting").empty();
                $(data.data).each(function (i, video) {
                    $(".display-setting").append(
                        '<div class="video-view">' +
                        '            <table>' +
                        '                <tr>' +
                        '                    <td><a href="' + video.videoHref + '"><img class="img-size" src="' + video.videoImg + '"/></a></td>' +
                        '                </tr>' +
                        '                <tr class="span-title"><td><span>'+video.videoTitle+'</span></td></tr>' +
                        '                <tr><td>评分: '+video.videoRating+'</td></tr>'+
                        '            </table>' +
                        '        </div>'
                    );
                })
            }
        })
    })


});

function setting_fun() {
    $("#video-window").hide();
    $("#info-area").hide();
    $("#setting-area").hide();
    $("#setting-btn").click(function () {
        // 显示div
        $("#setting-area").show(1000);
    });
    $("#setting-area").mouseleave(function () {
        $("#setting-area").hide(1000);
    });

    $("#message-area").click(function () {
        $("#video-window").slideDown(400)
    });

    $("#email-area").click(function () {
        $("#info-area").slideDown(600)
    });

    $("#info-area").mouseleave(function () {
        $("#info-area").hide(1000);
    });
    $("#close-video").click(function () {
        $("#video-window").slideUp(400);
        $("#video-player").trigger("pause")
    });

    $("#chart").click(function () {
        $("#display-img").empty();
        $("#display-img").append('<img src="../80sHome/chart" alt="图表" id="chart-0">')
    });

    $("#display-img").mouseleave(function () {
        $("#chart-0").hide(400)
    })
}
