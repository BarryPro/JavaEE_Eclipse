/**
 * Created by belong on 2017/4/29.
 */

var top_position = 0;
$(document).ready(function(){

    var clicknum1 = 0;
    $(".fixediv1 a").click(function(){
        if(clicknum1<1){
            clicknum1 = clicknum1 + 1;
            $(this).prev().find("img").trigger("click");

        }else{
            $(this).parent(".fixediv1").fadeOut(0);
        }

    });
    $(".fixediv1").floatadv();

    var clicknum2 = 0;
    $(".fixediv2 a").click(function(){
        if(clicknum2<1){
            clicknum2 = clicknum2 + 1;
            $(this).prev().find("img").trigger("click");

        }else{
            $(this).parent(".fixediv2").fadeOut(0);
        }

    });
    $(".fixediv2").floatadv();

    var clicknum3 = 0;
    $(".fixediv3 a").click(function(){
        if(clicknum3<1){
            clicknum3 = clicknum3 + 1;
            $(this).prev().find("img").trigger("click");

        }else{
            $(this).parent(".fixediv3").fadeOut(0);
        }

    });
    $(".fixediv3").floatadv();


});

$(window).resize(function() {
    $('#pop').css("right","0px");
    $('#pop').css("bottom","0px");

    $('#popl').css("right","0px");
    $('#popl').css("bottom","0px");
});



$('#pop').show();
$('#popl').show();

var clicknum = 0;
$("#popClose").click(function(){
        if(clicknum<1){
            clicknum = clicknum + 1;
            $("#pop #popContent img").trigger("click");

        }else{
            $('#pop').hide();
        }

    }
);


var clicknuml = 0;
$("#poplClose").click(function(){
        if(clicknuml<1){
            clicknuml = clicknuml + 1;
            $("#popl #poplContent img").trigger("click");

        }else{
            $('#popl').hide();
        }

    }
);





jQuery.fn.floatadv = function(loaded) {
    var obj = this;
    body_height = parseInt($(window).height());
    block_height = parseInt(obj.height());

    if(this.hasClass("fixediv1")){
        top_position = parseInt((body_height/2) - (block_height/2) + $(window).scrollTop())-230 ;

    }

    if(this.hasClass("fixediv2")){
        top_position = parseInt((body_height/2) - (block_height/2) + $(window).scrollTop())-10 ;
    }

    if(this.hasClass("fixediv3")){
        top_position = parseInt((body_height/2) - (block_height/2) + $(window).scrollTop())+205 ;
    }

    if (body_height < block_height) {
        top_position = 0 + $(window).scrollTop();
    }
    if(!loaded) {
        obj.css({'position': 'absolute'});
        obj.css({ 'top': top_position });
        $(window).bind('resize', function() {
            obj.floatadv(!loaded);
        });
        $(window).bind('scroll', function() {
            obj.floatadv(!loaded);
        });
    } else {
        obj.stop();
        obj.css({'position': 'absolute'});
        obj.animate({ 'top': top_position }, 0, 'linear');
    }
};



function IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone","SymbianOS", "Windows Phone","iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;

}

if(!IsPC()) {
    // $(".wrap-head-spots").hide();
    $(".leftadv").hide();
    $(".rightadv").hide();
    $("#pop").hide();
    $("#popl").hide();
    //$(".content-inner .main > a").hide();
    //$(".sidebar .spots").hide();


    //$("iframe").hide();

    $(".kt-api-btn-start,.kt-api-btn-nostart").css("top", "150px");
    $(".kt-api-btn-start,.kt-api-btn-nostart").css("height", "20px");
    $(".kt-api-btn-start,.kt-api-btn-nostart").css("line-height", "20px");
    $(".kt-api-btn-start,.kt-api-btn-nostart").css("font-size", "15px");
    $(".kt-api-btn-start,.kt-api-btn-nostart").css("right", "70px");
    $(".kt-api-btn-start,.kt-api-btn-nostart").css("width", "140px");
    $("#_iframe_content");
}
